package com.doraemon.comp.oo.service;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.stereotype.Service;

import com.doraemon.comp.oo.repository.ProductDao;
import com.doraemon.comp.oo.repository.RoleDao;
import com.doraemon.comp.oo.repository.StockHistoryDao;
import com.doraemon.comp.oo.repository.TransactionDao;
import com.doraemon.comp.oo.repository.TransactionDetailDao;
import com.doraemon.comp.oo.utils.TransactionObj;
import com.doraemon.comp.oo.model.Product;
import com.doraemon.comp.oo.model.StockHistory;
import com.doraemon.comp.oo.model.Transaction;
import com.doraemon.comp.oo.model.TransactionDetail;
import com.doraemon.comp.oo.model.User;

@Service
public class InventoryServiceImp implements InventoryService {
	
	@Autowired
    private DataSource dataSource;
    private JdbcTemplate jdbcTemplate;
    
    @Autowired
	private RoleDao roleDao;
    @Autowired
	private ProductDao productDao;
    @Autowired
	private TransactionDao transactionDao;
	@Autowired
	private TransactionDetailDao transactionDetailDao;
	@Autowired
	private StockHistoryDao stockHistoryDao;
    
    @Autowired
    public void setDataSource(DataSource dataSource) {
        this.dataSource = dataSource;
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }
    
    @Override
	public User login(String username, String password) {
    
    	User user=roleDao.findRoleByUsernameAndPassword(username, password);    	
    	return user;
    	
    }
	
	@Override
	public List<Product> getFullProductList() {		
		List<Product> tmp = (List<Product>) productDao.findAll();		
		return tmp;
	}
	
	@Override
	public void addNewProduct(Product product) {
		productDao.save(product);		
	}

	@Override
	public Map<String, Object> queryFromSql(String sql) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			List<Map<String, String>> queryResult = jdbcTemplate.query(sql, new ResultSetExtractor<List<Map<String, String>>>() {
				public List<Map<String, String>> extractData(ResultSet rs) throws SQLException, DataAccessException {
					StringBuilder builder = new StringBuilder();
					ResultSetMetaData rsmd = rs.getMetaData();
				    int columnCount = rsmd.getColumnCount();
				    
				    ArrayList<String> columns = new ArrayList<String>();
				    
				    for(int i = 1 ; i <= columnCount ; i++){
				    	columns.add(rsmd.getColumnName(i));				    	
				    }
				    
				    List<Map<String, String>> resultMap = new ArrayList<Map<String, String>>();
				    while (rs.next()) {
				    	Map<String, String> map = new HashMap<String, String>();
				        for (String columnName : columns) {
				          String value = rs.getString(columnName);
				          map.put(columnName, value);
				        }
				        resultMap.add(map);
				    }
				    
				    return resultMap;
				}
			});
			result.put("result", "success");
			result.put("detail", queryResult);
		} catch(Exception e) {
			result.put("result", "error");
			result.put("detail", "There are SQL error, please check the SQL.");
		}
		
		return result;
	}

	@Override
	public void addQuantity(Integer productId, Integer quantity, User user) {
		
		Product product = productDao.findProductById(productId);
		product.setQuantity(product.getQuantity() + quantity);
		productDao.save(product);
		
		//set 1 for InOut column for adding
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		StockHistory sh = new StockHistory(productId, 1, quantity, user.getUsername(), sdf.format(new Date()));
		stockHistoryDao.save(sh);		
	}

	@Override
	public void deleteQuantity(Integer productId, Integer quantity, User user) {
		
		Product product = productDao.findProductById(productId);
		product.setQuantity(product.getQuantity() - quantity);
		productDao.save(product);
		
		//set 0 for InOut column for deleting
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		StockHistory sh = new StockHistory(productId, 0, quantity, user.getUsername(), sdf.format(new Date()));
		stockHistoryDao.save(sh);		
	}	
	
	@Override
	public List<TransactionObj> submitTransaction(List<TransactionObj> orderList, User user) {
				
		Double total = new Double(0);
		for (int i = 0; i < orderList.size(); i++) {
			if (orderList.get(i).getQuantity() >= 3) {
				orderList.get(i).getProduct().discount();
			}
			total += orderList.get(i).getProduct().getPrice() * orderList.get(i).getQuantity();
		}
		 
		Transaction transaction = new Transaction();
		transaction.setStaff(user.getUsername());
		transaction.setTotal(total);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		transaction.setTransactionDate(sdf.format(new Date()));
		transactionDao.save(transaction);
		
		Integer transId = transactionDao.getMaxId();
		
		List<TransactionDetail> detailList = new ArrayList<TransactionDetail>();
		for (int i = 0; i < orderList.size(); i++) {
			TransactionDetail detail = new TransactionDetail();
			detail.setTransactionId(transId);
			detail.setProductId(orderList.get(i).getProduct().getId());
			detail.setProductPrice(orderList.get(i).getProduct().getPrice());
			detail.setQuantity(orderList.get(i).getQuantity());
			detailList.add(detail);
			
			Product product = productDao.findProductById(orderList.get(i).getProduct().getId());
			product.setQuantity(product.getQuantity() - orderList.get(i).getQuantity());
			productDao.save(product);
		}
		transactionDetailDao.saveAll(detailList);
		
		return orderList;				
	}
	
//	public List<Transaction> test() {
////		User user = new User();
////		
////		user.setUsername("username");
////		user.setPassword("password");
////		user.setRole("role");
////		
////		roleDao.save(user);
//		
//		return (List<Transaction>) transactionDao.findAll();
//		
//		
//	}

	@Override
	public Product getProductById(Integer id) {
		return productDao.findProductById(id);
	}

	@Override
	public void editProduct(Product product) {
		productDao.save(product);		
	}

	@Override
	public List<Transaction> getFullTransactionHistory() {
		return (List<Transaction>) transactionDao.findAll();
	}

	@Override
	public List<StockHistory> getFullStockHistory() {
		return (List<StockHistory>) stockHistoryDao.findAll();
	}

}
