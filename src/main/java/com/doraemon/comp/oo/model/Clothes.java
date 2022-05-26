package com.doraemon.comp.oo.model;

import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;

@Entity
@DiscriminatorValue("C")
public class Clothes extends Product {
	
	@Column(name="color")
	protected String color;
	@Column(name="size")
	protected String size;
	
	public Clothes() {}	
	
	public Clothes(String name, Integer quantity, Double price, String desc, Integer lowStockQty, String color, String size) {
		super(name, quantity, price, desc, lowStockQty);
		this.color = color;
		this.size = size;
	}

	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public String getSize() {
		return size;
	}
	public void setSize(String size) {
		this.size = size;
	}
	
	

}