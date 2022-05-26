package com.doraemon.comp.oo.model;

import javax.persistence.Column;
import javax.persistence.DiscriminatorColumn;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.Table;
import javax.persistence.InheritanceType;
import javax.persistence.DiscriminatorType;

@Entity
@Table(name = "product")
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name = "types", discriminatorType = DiscriminatorType.STRING, length = 1)
public class Product {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "id")
	protected Integer id;

	@Column(name = "name")
	protected String name;
	@Column(name = "quantity")
	protected Integer quantity;
	@Column(name = "price")
	protected Double price;
	@Column(name = "desc")
	protected String desc;
	@Column(name = "low_stock_qty")
	protected Integer lowStockQty;
	
	public Product() {}

	public Product(String name, Integer quantity, Double price, String desc, Integer lowStockQty) {
		this.name = name;
		this.quantity = quantity;
		this.price = price;
		this.desc = desc;
		this.lowStockQty = lowStockQty;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getQuantity() {
		return quantity;
	}

	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}

	public Integer getLowStockQty() {
		return lowStockQty;
	}

	public void setLowStockQty(Integer lowStockQty) {
		this.lowStockQty = lowStockQty;
	}
	
	public void discount() {
		this.price = this.price * 0.9;		
	}

}
