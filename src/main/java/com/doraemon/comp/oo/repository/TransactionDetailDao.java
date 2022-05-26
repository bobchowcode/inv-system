package com.doraemon.comp.oo.repository;

import org.springframework.data.repository.CrudRepository;

import com.doraemon.comp.oo.model.TransactionDetail;

public interface TransactionDetailDao extends CrudRepository<TransactionDetail, Long> {
	
	
	
}