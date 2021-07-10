package com.monginis.ops.report.model;

public class GetItemSubCatWise {
	
	private String id;
	private float qty;
	private int subCatId;
	private String subCatName;
	private int productId;
	private String productCode;
	private String productName;
	private float totalSale;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public float getQty() {
		return qty;
	}
	public void setQty(float qty) {
		this.qty = qty;
	}
	public int getSubCatId() {
		return subCatId;
	}
	public void setSubCatId(int subCatId) {
		this.subCatId = subCatId;
	}
	public String getSubCatName() {
		return subCatName;
	}
	public void setSubCatName(String subCatName) {
		this.subCatName = subCatName;
	}
	public int getProductId() {
		return productId;
	}
	public void setProductId(int productId) {
		this.productId = productId;
	}
	public String getProductCode() {
		return productCode;
	}
	public void setProductCode(String productCode) {
		this.productCode = productCode;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public float getTotalSale() {
		return totalSale;
	}
	public void setTotalSale(float totalSale) {
		this.totalSale = totalSale;
	}
	@Override
	public String toString() {
		return "GetItemSubCatWise [id=" + id + ", qty=" + qty + ", subCatId=" + subCatId + ", subCatName=" + subCatName
				+ ", productId=" + productId + ", productCode=" + productCode + ", productName=" + productName
				+ ", totalSale=" + totalSale + "]";
	}
}
