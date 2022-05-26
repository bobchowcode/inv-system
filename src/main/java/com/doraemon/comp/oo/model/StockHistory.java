package com.doraemon.comp.oo.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "stock_history")
public class StockHistory {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "stock_id")
	private Integer stockId;
	@Column(name = "product_id")
	private Integer productId;
	@Column(name = "in_out")
	private Integer inOut;
	@Column(name = "quantity")
	private Integer quantity;
	@Column(name = "staff")
	private String staff;
	@Column(name = "stock_date")
	private String stockDate;
	
	
	public StockHistory() {
		
	}
	
	public StockHistory(Integer productId, Integer inOut, Integer quantity, String staff, String stockDate) {
		this.productId = productId;
		this.inOut = inOut;
		this.quantity = quantity;
		this.staff = staff;
		this.stockDate = stockDate;
		
	}

	public Integer getStockId() {
		return stockId;
	}

	public void setStockId(Integer stockId) {
		this.stockId = stockId;
	}

	public Integer getProductId() {
		return productId;
	}

	public void setProductId(Integer productId) {
		this.productId = productId;
	}

	public Integer getInOut() {
		return inOut;
	}

	public void setInOut(Integer inOut) {
		this.inOut = inOut;
	}

	public Integer getQuantity() {
		return quantity;
	}

	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}

	public String getStaff() {
		return staff;
	}

	public void setStaff(String staff) {
		this.staff = staff;
	}

	public String getStockDate() {
		return stockDate;
	}

	public void setStockDate(String stockDate) {
		this.stockDate = stockDate;
	}

}
