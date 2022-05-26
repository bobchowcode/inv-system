package com.doraemon.comp.oo.repository;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.doraemon.comp.oo.model.Transaction;

public interface TransactionDao extends CrudRepository<Transaction, Long> {

	@Query(value = "select max(transaction_id) from trans_tbl;", nativeQuery=true)
	Integer getMaxId();
	
}