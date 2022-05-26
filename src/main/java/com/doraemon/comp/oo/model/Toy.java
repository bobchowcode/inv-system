package com.doraemon.comp.oo.model;

import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;

@Entity
@DiscriminatorValue("T")
public class Toy extends Product {
	
	@Column(name="weight")
	protected String weight;
	@Column(name="standard")
	protected String standard;
	
	public Toy() {}
	
	public Toy(String name, Integer quantity, Double price, String desc, Integer lowStockQty, String weight, String standard) {
		super(name, quantity, price, desc, lowStockQty);
		this.weight = weight;
		this.standard = standard;
	}

	public String getWeight() {
		return weight;
	}
	public void setWeight(String weight) {
		this.weight = weight;
	}
	public String getStandard() {
		return standard;
	}
	public void setStandard(String standard) {
		this.standard = standard;
	}	
	

}