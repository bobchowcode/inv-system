package com.doraemon.comp.oo.model;

import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;

@Entity
@DiscriminatorValue("F")
public class Food extends Product {

	@Column(name = "brand")
	protected String brand;
	@Column(name = "origin")
	protected String origin;
	
	public Food() {}	

	public Food(String name, Integer quantity, Double price, String desc, Integer lowStockQty,
			String brand, String origin) {
		super(name, quantity, price, desc, lowStockQty);
		this.brand = brand;
		this.origin = origin;
	}

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public String getOrigin() {
		return origin;
	}

	public void setOrigin(String origin) {
		this.origin = origin;
	}

	@Override
	public void discount() {
		this.price = this.price * 0.8;
	}

}
