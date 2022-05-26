package com.doraemon.comp.oo.repository;

import org.springframework.data.repository.CrudRepository;

import com.doraemon.comp.oo.model.Product;
import com.doraemon.comp.oo.model.User;

public interface ProductDao extends CrudRepository<Product, Long> {
	
	Product findProductById(Integer id);

}
