package com.doraemon.comp.oo.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.WebUtils;

import com.doraemon.comp.oo.model.Clothes;
import com.doraemon.comp.oo.model.Food;
import com.doraemon.comp.oo.model.Product;
import com.doraemon.comp.oo.model.StockHistory;
import com.doraemon.comp.oo.model.Toy;
import com.doraemon.comp.oo.model.Transaction;
import com.doraemon.comp.oo.model.User;
import com.doraemon.comp.oo.service.InventoryService;
import com.doraemon.comp.oo.utils.TransactionObj;

@Controller
public class InventoryController {

	@Autowired
	private InventoryService inventoryService;

	@RequestMapping(value = "/")
	public ModelAndView index(HttpServletRequest request) {
		ModelAndView model = new ModelAndView();
		model.setViewName("home");
		return model;
	}

	@RequestMapping(value = "/home")
	public ModelAndView home(HttpServletRequest request) {
		ModelAndView model = new ModelAndView();
		model.setViewName("home");
		return model;
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView login(HttpServletRequest request, @RequestParam(value = "username") String username,
			@RequestParam(value = "password") String password) {
		User user = inventoryService.login(username, password);

		ModelAndView model = new ModelAndView();
		if (user != null) {
			WebUtils.setSessionAttribute(request, "user", user);
			switch(user.getRole()) {
			case "admin":
				model = new ModelAndView("redirect:/sqlPage");
				break;
			case "warehouse":
				model = new ModelAndView("redirect:/warehouse");
				break;
			default:
				model = new ModelAndView("redirect:/outgoing");
				break;
				
			}
		} else {
			model = new ModelAndView("redirect:/home");
		}

		return model;
	}

	@RequestMapping(value = "/sqlPage")
	public ModelAndView sqlPage(HttpServletRequest request) {
		if (StringUtils.equalsIgnoreCase(((User)WebUtils.getSessionAttribute(request, "user")).getRole(), "admin")) {
			request.setAttribute("user", (User)WebUtils.getSessionAttribute(request, "user"));
			
			ModelAndView model = new ModelAndView();
			model.setViewName("sql");
			return model;
		} else {
			return new ModelAndView("redirect:/home");
		}
	}
	
	@RequestMapping(value = "/report")
	public ModelAndView reportPage(HttpServletRequest request, @RequestParam(value = "q", required = false) String q) {
		if (StringUtils.equalsIgnoreCase(((User)WebUtils.getSessionAttribute(request, "user")).getRole(), "admin")) {
			request.setAttribute("user", (User)WebUtils.getSessionAttribute(request, "user"));
			
			if (StringUtils.equalsIgnoreCase(q, "stock")) {
				List<StockHistory> stockList = inventoryService.getFullStockHistory();
				request.setAttribute("stockHistory", stockList);
				
			} else if (StringUtils.equalsIgnoreCase(q, "trans")) {
				List<Transaction> transList = inventoryService.getFullTransactionHistory();
				request.setAttribute("transHistory", transList);
			}			
			
			ModelAndView model = new ModelAndView();
			model.setViewName("report");
			return model;
		} else {
			return new ModelAndView("redirect:/home");
		}
	}

	@RequestMapping(value = "/addItemById", method = RequestMethod.GET)
	public ModelAndView addItemById(HttpServletRequest request) {

		Integer id = Integer.parseInt(request.getParameter("productId"));

		List<TransactionObj> orders = new ArrayList<TransactionObj>();
		if (WebUtils.getSessionAttribute(request, "orderList") == null) {
			orders = new ArrayList<TransactionObj>();
		} else {
			orders = (List<TransactionObj>) WebUtils.getSessionAttribute(request, "orderList");
		}

		TransactionObj tmp = null;
		for (int i = 0; i < orders.size(); i++) {
			if (orders.get(i).getProduct().getId() == id) {
				tmp = orders.get(i);
				tmp.setQuantity(tmp.getQuantity() + 1);
				orders.set(i, tmp);
				break;
			}
		}
		if (tmp == null) {
			tmp = new TransactionObj();
			tmp.setProduct(inventoryService.getProductById(id));
			tmp.setQuantity(1);
			orders.add(tmp);
		}
		WebUtils.setSessionAttribute(request, "orderList", orders);

		return new ModelAndView("redirect:/outgoing");
	}

	@RequestMapping(value = "/deleteItemById", method = RequestMethod.GET)
	public ModelAndView deleteItemById(HttpServletRequest request) {

		Integer id = Integer.parseInt(request.getParameter("productId"));

		List<TransactionObj> orders = new ArrayList<TransactionObj>();
		if (WebUtils.getSessionAttribute(request, "orderList") == null) {
			orders = new ArrayList<TransactionObj>();
		} else {
			orders = (List<TransactionObj>) WebUtils.getSessionAttribute(request, "orderList");
		}

		TransactionObj tmp = null;
		for (int i = 0; i < orders.size(); i++) {
			if (orders.get(i).getProduct().getId() == id) {
				tmp = orders.get(i);
				Integer newQuantity = tmp.getQuantity() - 1;
				if (newQuantity < 1) {
					orders.remove(i);
				} else {
					tmp.setQuantity(newQuantity);
					orders.set(i, tmp);
				}
				break;
			}
		}

		WebUtils.setSessionAttribute(request, "orderList", orders);

		return new ModelAndView("redirect:/outgoing");
	}

	@RequestMapping(value = "/outgoing", method = RequestMethod.GET)
	public ModelAndView outgoing(HttpServletRequest request, @RequestParam(value = "q", required = false) String q) {
		
		if (StringUtils.equalsIgnoreCase(((User)WebUtils.getSessionAttribute(request, "user")).getRole(), "admin") ||
				StringUtils.equalsIgnoreCase(((User)WebUtils.getSessionAttribute(request, "user")).getRole(), "outgoing")) {
			
			request.setAttribute("user", (User)WebUtils.getSessionAttribute(request, "user"));
			
			request.setAttribute("orderList", WebUtils.getSessionAttribute(request, "orderList"));

			List<Product> productFullList = inventoryService.getFullProductList();

			if (StringUtils.equalsIgnoreCase(q, "toy")) {
				ArrayList<Toy> toyList = new ArrayList<Toy>();
				for (int i = 0; i < productFullList.size(); i++) {
					Object obj = productFullList.get(i);
					if (obj instanceof Toy) {
						toyList.add((Toy) obj);
					}
				}
				request.setAttribute("productList", toyList);
			} else if (StringUtils.equalsIgnoreCase(q, "clothes")) {
				ArrayList<Clothes> clothesList = new ArrayList<Clothes>();
				for (int i = 0; i < productFullList.size(); i++) {
					Object obj = productFullList.get(i);
					if (obj instanceof Clothes) {
						clothesList.add((Clothes) obj);
					}
				}
				request.setAttribute("productList", clothesList);
			} else if (StringUtils.equalsIgnoreCase(q, "food")) {
				ArrayList<Food> foodList = new ArrayList<Food>();
				for (int i = 0; i < productFullList.size(); i++) {
					Object obj = productFullList.get(i);
					if (obj instanceof Food) {
						foodList.add((Food) obj);
					}
				}
				request.setAttribute("productList", foodList);
			} else {
				request.setAttribute("productList", productFullList);
			}

			ModelAndView model = new ModelAndView();
			model.setViewName("outgoing");
			return model;
		} else {
			return new ModelAndView("redirect:/home");
		}

	}

	@RequestMapping(value = "/submitOrder", method = RequestMethod.GET)
	public ModelAndView submitOrder(HttpServletRequest request) {

		List<TransactionObj> orderList = (List<TransactionObj>) WebUtils.getSessionAttribute(request, "orderList");
		List<TransactionObj> processedOrderList = new ArrayList<TransactionObj>();
		if (orderList.size() > 0) {
			User user = (User)WebUtils.getSessionAttribute(request, "user");
			processedOrderList = inventoryService.submitTransaction(orderList, user);
		}

		WebUtils.setSessionAttribute(request, "orderList", null);
		request.setAttribute("orderList", processedOrderList);

		ModelAndView model = new ModelAndView();
		model.setViewName("summary");
		return model;
	}

	@RequestMapping(value = "/warehouse", method = RequestMethod.GET)
	public ModelAndView warehouse(HttpServletRequest request, @RequestParam(value = "q", required = false) String q) {
		
		if (StringUtils.equalsIgnoreCase(((User)WebUtils.getSessionAttribute(request, "user")).getRole(), "admin") ||
				StringUtils.equalsIgnoreCase(((User)WebUtils.getSessionAttribute(request, "user")).getRole(), "warehouse")) {
			
			request.setAttribute("user", (User)WebUtils.getSessionAttribute(request, "user"));
			
			List<Product> productFullList = inventoryService.getFullProductList();

			if (StringUtils.equalsIgnoreCase(q, "toy")) {
				ArrayList<Toy> toyList = new ArrayList<Toy>();
				for (int i = 0; i < productFullList.size(); i++) {
					Object obj = productFullList.get(i);
					if (obj instanceof Toy) {
						toyList.add((Toy) obj);
					}
				}
				request.setAttribute("productList", toyList);
			} else if (StringUtils.equalsIgnoreCase(q, "clothes")) {
				ArrayList<Clothes> clothesList = new ArrayList<Clothes>();
				for (int i = 0; i < productFullList.size(); i++) {
					Object obj = productFullList.get(i);
					if (obj instanceof Clothes) {
						clothesList.add((Clothes) obj);
					}
				}
				request.setAttribute("productList", clothesList);
			} else if (StringUtils.equalsIgnoreCase(q, "food")) {
				ArrayList<Food> foodList = new ArrayList<Food>();
				for (int i = 0; i < productFullList.size(); i++) {
					Object obj = productFullList.get(i);
					if (obj instanceof Food) {
						foodList.add((Food) obj);
					}
				}
				request.setAttribute("productList", foodList);
			} else {
				request.setAttribute("productList", productFullList);
			}

			ModelAndView model = new ModelAndView();
			model.setViewName("warehouse");
			return model;
		} else {
			return new ModelAndView("redirect:/home");
		}

	}

	@RequestMapping(value = "/addQuantity", method = RequestMethod.GET)
	public ModelAndView addQuantity(HttpServletRequest request) {

		String id = request.getParameter("productId");
		String q = request.getParameter("quantity");
		
		User user = (User)WebUtils.getSessionAttribute(request, "user");

		inventoryService.addQuantity(new Integer(Integer.parseInt(id)), new Integer(Integer.parseInt(q)), user);

		return new ModelAndView("redirect:/warehouse");
	}

	@RequestMapping(value = "/deleteQuantity", method = RequestMethod.GET)
	public ModelAndView deleteQuantity(HttpServletRequest request) {

		String id = request.getParameter("productId");
		String q = request.getParameter("quantity");
		
		User user = (User)WebUtils.getSessionAttribute(request, "user");

		inventoryService.deleteQuantity(new Integer(Integer.parseInt(id)), new Integer(Integer.parseInt(q)), user);

		return new ModelAndView("redirect:/warehouse");
	}

	@RequestMapping(value = "/addProduct", method = RequestMethod.GET)
	public ModelAndView addProduct(HttpServletRequest request, @RequestParam(value = "q", required = false) String q) {

		if (StringUtils.equalsIgnoreCase(q, "toy")) {
			request.setAttribute("type", "Toy");
		} else if (StringUtils.equalsIgnoreCase(q, "clothes")) {
			request.setAttribute("type", "Clothes");
		} else if (StringUtils.equalsIgnoreCase(q, "food")) {
			request.setAttribute("type", "Food");
		}

		ModelAndView model = new ModelAndView();
		model.setViewName("addproduct");
		return model;
	}

	@RequestMapping(value = "/addNewToy", method = RequestMethod.GET)
	public ModelAndView addNewToy(HttpServletRequest request) {

		Product product = null;

		product = new Toy(request.getParameter("name"), new Integer(request.getParameter("quantity")),
				new Double(request.getParameter("price")), request.getParameter("desc"), new Integer(0),
				request.getParameter("weight"), request.getParameter("standard"));

		inventoryService.addNewProduct(product);

		return new ModelAndView("redirect:/warehouse");
	}

	@RequestMapping(value = "/addNewClothes", method = RequestMethod.GET)
	public ModelAndView addNewClothes(HttpServletRequest request) {

		Product product = null;

		product = new Clothes(request.getParameter("name"), new Integer(request.getParameter("quantity")),
				new Double(request.getParameter("price")), request.getParameter("desc"), new Integer(0),
				request.getParameter("color"), request.getParameter("size"));

		inventoryService.addNewProduct(product);

		return new ModelAndView("redirect:/warehouse");
	}

	@RequestMapping(value = "/addNewFood", method = RequestMethod.GET)
	public ModelAndView addNewFood(HttpServletRequest request) {

		Product product = null;

		product = new Food(request.getParameter("name"), new Integer(request.getParameter("quantity")),
				new Double(request.getParameter("price")), request.getParameter("desc"), new Integer(0),
				request.getParameter("brand"), request.getParameter("origin"));

		inventoryService.addNewProduct(product);

		return new ModelAndView("redirect:/warehouse");
	}

	@RequestMapping(value = "/editItem", method = RequestMethod.GET)
	public ModelAndView editItem(HttpServletRequest request) {

		String id = request.getParameter("productId");

		request.setAttribute("product", inventoryService.getProductById(new Integer(id)));

		ModelAndView model = new ModelAndView();
		model.setViewName("editproduct");
		return model;
	}

	@RequestMapping(value = "/submitEdit", method = RequestMethod.GET)
	public ModelAndView submitEdit(HttpServletRequest request) {

		String id = request.getParameter("productId");
		Product oProduct = inventoryService.getProductById(new Integer(id));

		Product nProduct = null;
		if (oProduct instanceof Toy) {
			Toy tmp = new Toy();
			tmp.setId(new Integer(id));
			tmp.setName(request.getParameter("name"));
			tmp.setQuantity(oProduct.getQuantity());
			tmp.setPrice(new Double(request.getParameter("price")));
			tmp.setDesc(request.getParameter("desc"));
			tmp.setLowStockQty(new Integer(0));
			tmp.setWeight(request.getParameter("weight"));
			tmp.setStandard(request.getParameter("standard"));
			nProduct = tmp;

		} else if (oProduct instanceof Clothes) {
			Clothes tmp = new Clothes();
			tmp.setId(new Integer(id));
			tmp.setName(request.getParameter("name"));
			tmp.setQuantity(oProduct.getQuantity());
			tmp.setPrice(new Double(request.getParameter("price")));
			tmp.setDesc(request.getParameter("desc"));
			tmp.setLowStockQty(new Integer(0));
			tmp.setColor(request.getParameter("color"));
			tmp.setSize(request.getParameter("size"));
			nProduct = tmp;

		} else if (oProduct instanceof Food) {
			Food tmp = new Food();
			tmp.setId(new Integer(id));
			tmp.setName(request.getParameter("name"));
			tmp.setQuantity(oProduct.getQuantity());
			tmp.setPrice(new Double(request.getParameter("price")));
			tmp.setDesc(request.getParameter("desc"));
			tmp.setLowStockQty(new Integer(0));
			tmp.setBrand(request.getParameter("brand"));
			tmp.setOrigin(request.getParameter("origin"));
			nProduct = tmp;
		}

		inventoryService.editProduct(nProduct);

		return new ModelAndView("redirect:/warehouse");
	}

	@RequestMapping(value = "/sql", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> sql(@RequestBody Map<String, Object> sqlObj) {
		Map<String, Object> result = new HashMap<String, Object>();

		if (sqlObj != null && StringUtils.startsWith(((String) sqlObj.get("sqlStr")).toLowerCase(), "select")) {
			Map<String, Object> resultMap = inventoryService.queryFromSql((String) sqlObj.get("sqlStr"));
			result = resultMap;
		} else {
			result.put("result", "error");
			result.put("detail", "Your input is incorrect.");
		}

		return result;
	}

	@ResponseStatus(HttpStatus.NOT_FOUND)
	public String notFound() {
		return "/error/404";
	}	

	@RequestMapping("/logout")
	public ModelAndView logout(HttpServletRequest request) {

		WebUtils.setSessionAttribute(request, "user", null);
		ModelAndView model = new ModelAndView();
		model.setViewName("home");
		return model;
	}

}