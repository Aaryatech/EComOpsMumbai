package com.monginis.ops.report.model;

public class ShowPieChartData {
	
	private String id;
	private int catId;
	private String catName;
	private String catPrefix;
	private float qty;	
	private int subCatId;
	private String subCatName;
	private String subCatCode;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getCatId() {
		return catId;
	}

	public void setCatId(int catId) {
		this.catId = catId;
	}

	public String getCatName() {
		return catName;
	}

	public void setCatName(String catName) {
		this.catName = catName;
	}

	public String getCatPrefix() {
		return catPrefix;
	}

	public void setCatPrefix(String catPrefix) {
		this.catPrefix = catPrefix;
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

	public String getSubCatCode() {
		return subCatCode;
	}

	public void setSubCatCode(String subCatCode) {
		this.subCatCode = subCatCode;
	}

	@Override
	public String toString() {
		return "ShowPieChartData [id=" + id + ", catId=" + catId + ", catName=" + catName + ", catPrefix=" + catPrefix
				+ ", qty=" + qty + ", subCatId=" + subCatId + ", subCatName=" + subCatName + ", subCatCode="
				+ subCatCode + "]";
	}

}
