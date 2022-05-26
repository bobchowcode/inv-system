package com.doraemon.comp.oo.model;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "trans_tbl")
public class Transaction {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "transaction_id")
	private Integer transactionId;
	@Column(name = "total")
	private Double total;
	@Column(name = "staff")
	private String staff;
	@Column(name = "transaction_date")
	private String transactionDate;
		
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, targetEntity = TransactionDetail.class)
	@JoinColumn(name = "transaction_id", referencedColumnName = "transaction_id", nullable = false, updatable = false, insertable = false)
	private List<TransactionDetail> detailList = new ArrayList<TransactionDetail>();
	
	
	public Integer getTransactionId() {
		return transactionId;
	}
	public void setTransactionId(Integer transactionId) {
		this.transactionId = transactionId;
	}
	public Double getTotal() {
		return total;
	}
	public void setTotal(Double total) {
		this.total = total;
	}
	public String getStaff() {
		return staff;
	}
	public void setStaff(String staff) {
		this.staff = staff;
	}
	public String getTransactionDate() {
		return transactionDate;
	}
	public void setTransactionDate(String transactionDate) {
		this.transactionDate = transactionDate;
	}
	public List<TransactionDetail> getDetailList() {
		return detailList;
	}
	public void setDetailList(List<TransactionDetail> detailList) {
		this.detailList = detailList;
	}
	
	
	
}
