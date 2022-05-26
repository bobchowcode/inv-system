package com.doraemon.comp.oo.service;

import java.util.List;
import java.util.Map;

import com.doraemon.comp.oo.model.Product;
import com.doraemon.comp.oo.model.StockHistory;
import com.doraemon.comp.oo.model.Transaction;
import com.doraemon.comp.oo.model.TransactionDetail;
import com.doraemon.comp.oo.model.User;
import com.doraemon.comp.oo.utils.TransactionObj;

public interface InventoryService {
	
	User login(String username, String password);
	
	List<Product> getFullProductList();
	
	Map<String, Object> queryFromSql(String sql);
	
	void addNewProduct(Product product);
	
	void addQuantity(Integer productId, Integer quantity, User user);
	
	void deleteQuantity(Integer productId, Integer quantity, User user);
	
	List<TransactionObj> submitTransaction(List<TransactionObj> orderList, User user);
	
	void editProduct(Product product);
	
	Product getProductById(Integer id);
	
	List<Transaction> getFullTransactionHistory();
	
	List<StockHistory> getFullStockHistory();
        
}
