package com.doraemon.comp.oo.repository;

import org.springframework.data.repository.CrudRepository;

import com.doraemon.comp.oo.model.StockHistory;

public interface StockHistoryDao extends CrudRepository<StockHistory, Long> {

	
}