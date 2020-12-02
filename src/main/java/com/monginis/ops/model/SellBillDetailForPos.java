package com.monginis.ops.model;
 
public class SellBillDetailForPos {
	 
	private int sellBillDetailNo; 
	private int sellBillNo; 
	private int catId; 
	private int itemId; 
	private float mrpBaseRate; 
	private float mrp; 
	private float qty; 
	private int billStockType;  
	private float cgstPer; 
	private float cgstRs; 
	private float igstPer; 
	private float igstRs; 
	private float sgstPer; 
	private float sgstRs; 
	private float discPer;  
	private float discAmt;  
	private float taxableAmt; 
	private float totalTax; 
	private float grandTotal; 
	private String remark; 
	private int delStatus; 
	private int extInt1; 
	private int extInt2; 
	private int extInt3; 
	private int extInt4; 
	private float extFloat1; 
	private float extFloat2; 
	private float extFloat3; 
	private float extFloat4; 
	private String extVar1; 
	private String extVar2; 
	private String extVar3; 
	private String extVar4; 
	private String itemName; 
	private String itemUom; 
	private String itemHsncd; 
	private String catName;
	private int isDecimal;

	
	public int getIsDecimal() {
		return isDecimal;
	}
	public void setIsDecimal(int isDecimal) {
		this.isDecimal = isDecimal;
	}
	public int getSellBillDetailNo() {
		return sellBillDetailNo;
	}
	public void setSellBillDetailNo(int sellBillDetailNo) {
		this.sellBillDetailNo = sellBillDetailNo;
	}
	public int getSellBillNo() {
		return sellBillNo;
	}
	public void setSellBillNo(int sellBillNo) {
		this.sellBillNo = sellBillNo;
	}
	public int getCatId() {
		return catId;
	}
	public void setCatId(int catId) {
		this.catId = catId;
	}
	public int getItemId() {
		return itemId;
	}
	public void setItemId(int itemId) {
		this.itemId = itemId;
	}
	public float getMrpBaseRate() {
		return mrpBaseRate;
	}
	public void setMrpBaseRate(float mrpBaseRate) {
		this.mrpBaseRate = mrpBaseRate;
	}
	public float getMrp() {
		return mrp;
	}
	public void setMrp(float mrp) {
		this.mrp = mrp;
	}
	public float getQty() {
		return qty;
	}
	public void setQty(float qty) {
		this.qty = qty;
	}
	public int getBillStockType() {
		return billStockType;
	}
	public void setBillStockType(int billStockType) {
		this.billStockType = billStockType;
	}
	public float getCgstPer() {
		return cgstPer;
	}
	public void setCgstPer(float cgstPer) {
		this.cgstPer = cgstPer;
	}
	public float getCgstRs() {
		return cgstRs;
	}
	public void setCgstRs(float cgstRs) {
		this.cgstRs = cgstRs;
	}
	public float getIgstPer() {
		return igstPer;
	}
	public void setIgstPer(float igstPer) {
		this.igstPer = igstPer;
	}
	public float getIgstRs() {
		return igstRs;
	}
	public void setIgstRs(float igstRs) {
		this.igstRs = igstRs;
	}
	public float getSgstPer() {
		return sgstPer;
	}
	public void setSgstPer(float sgstPer) {
		this.sgstPer = sgstPer;
	}
	public float getSgstRs() {
		return sgstRs;
	}
	public void setSgstRs(float sgstRs) {
		this.sgstRs = sgstRs;
	}
	public float getDiscPer() {
		return discPer;
	}
	public void setDiscPer(float discPer) {
		this.discPer = discPer;
	}
	public float getDiscAmt() {
		return discAmt;
	}
	public void setDiscAmt(float discAmt) {
		this.discAmt = discAmt;
	}
	public float getTaxableAmt() {
		return taxableAmt;
	}
	public void setTaxableAmt(float taxableAmt) {
		this.taxableAmt = taxableAmt;
	}
	public float getTotalTax() {
		return totalTax;
	}
	public void setTotalTax(float totalTax) {
		this.totalTax = totalTax;
	}
	public float getGrandTotal() {
		return grandTotal;
	}
	public void setGrandTotal(float grandTotal) {
		this.grandTotal = grandTotal;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public int getDelStatus() {
		return delStatus;
	}
	public void setDelStatus(int delStatus) {
		this.delStatus = delStatus;
	}
	public int getExtInt1() {
		return extInt1;
	}
	public void setExtInt1(int extInt1) {
		this.extInt1 = extInt1;
	}
	public int getExtInt2() {
		return extInt2;
	}
	public void setExtInt2(int extInt2) {
		this.extInt2 = extInt2;
	}
	public int getExtInt3() {
		return extInt3;
	}
	public void setExtInt3(int extInt3) {
		this.extInt3 = extInt3;
	}
	public int getExtInt4() {
		return extInt4;
	}
	public void setExtInt4(int extInt4) {
		this.extInt4 = extInt4;
	}
	public float getExtFloat1() {
		return extFloat1;
	}
	public void setExtFloat1(float extFloat1) {
		this.extFloat1 = extFloat1;
	}
	public float getExtFloat2() {
		return extFloat2;
	}
	public void setExtFloat2(float extFloat2) {
		this.extFloat2 = extFloat2;
	}
	public float getExtFloat3() {
		return extFloat3;
	}
	public void setExtFloat3(float extFloat3) {
		this.extFloat3 = extFloat3;
	}
	public float getExtFloat4() {
		return extFloat4;
	}
	public void setExtFloat4(float extFloat4) {
		this.extFloat4 = extFloat4;
	}
	public String getExtVar1() {
		return extVar1;
	}
	public void setExtVar1(String extVar1) {
		this.extVar1 = extVar1;
	}
	public String getExtVar2() {
		return extVar2;
	}
	public void setExtVar2(String extVar2) {
		this.extVar2 = extVar2;
	}
	public String getExtVar3() {
		return extVar3;
	}
	public void setExtVar3(String extVar3) {
		this.extVar3 = extVar3;
	}
	public String getExtVar4() {
		return extVar4;
	}
	public void setExtVar4(String extVar4) {
		this.extVar4 = extVar4;
	}
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	public String getItemUom() {
		return itemUom;
	}
	public void setItemUom(String itemUom) {
		this.itemUom = itemUom;
	}
	public String getItemHsncd() {
		return itemHsncd;
	}
	public void setItemHsncd(String itemHsncd) {
		this.itemHsncd = itemHsncd;
	}
	public String getCatName() {
		return catName;
	}
	public void setCatName(String catName) {
		this.catName = catName;
	}
	@Override
	public String toString() {
		return "SellBillDetailForPos [sellBillDetailNo=" + sellBillDetailNo + ", sellBillNo=" + sellBillNo + ", catId="
				+ catId + ", itemId=" + itemId + ", mrpBaseRate=" + mrpBaseRate + ", mrp=" + mrp + ", qty=" + qty
				+ ", billStockType=" + billStockType + ", cgstPer=" + cgstPer + ", cgstRs=" + cgstRs + ", igstPer="
				+ igstPer + ", igstRs=" + igstRs + ", sgstPer=" + sgstPer + ", sgstRs=" + sgstRs + ", discPer="
				+ discPer + ", discAmt=" + discAmt + ", taxableAmt=" + taxableAmt + ", totalTax=" + totalTax
				+ ", grandTotal=" + grandTotal + ", remark=" + remark + ", delStatus=" + delStatus + ", extInt1="
				+ extInt1 + ", extInt2=" + extInt2 + ", extInt3=" + extInt3 + ", extInt4=" + extInt4 + ", extFloat1="
				+ extFloat1 + ", extFloat2=" + extFloat2 + ", extFloat3=" + extFloat3 + ", extFloat4=" + extFloat4
				+ ", extVar1=" + extVar1 + ", extVar2=" + extVar2 + ", extVar3=" + extVar3 + ", extVar4=" + extVar4
				+ ", itemName=" + itemName + ", itemUom=" + itemUom + ", itemHsncd=" + itemHsncd + ", catName="
				+ catName + ", isDecimal=" + isDecimal + "]";
	}
	
}
