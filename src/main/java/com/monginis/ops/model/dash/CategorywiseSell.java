package com.monginis.ops.model.dash;

 
public class CategorywiseSell {
	
	 
	private int catId;
	
	private String catName;
	
	private String catTotal;

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

	public String getCatTotal() {
		return catTotal;
	}

	public void setCatTotal(String catTotal) {
		this.catTotal = catTotal;
	}

	@Override
	public String toString() {
		return "CategorywiseSell [catId=" + catId + ", catName=" + catName + ", catTotal=" + catTotal + "]";
	}
	
	
	
	

}
