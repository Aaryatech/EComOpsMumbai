package com.monginis.ops.model;

public class CustomerBillItem {
	
private int id;
private String itemId;
private String itemName;
private String hsnCode;//new on 22 aug
private int catId;
private float mrp;
private float rate;
private float qty;
private float itemTax1;
private float itemTax2;
private float itemTax3;
private int billStockType;

private float totalSpStock;
private float totalRegStock;

private boolean isSpStockGretor;
private boolean isSpStockLessthanQty;
private boolean isRegOpStockLess;
private boolean isRegOpStockGretor;
private boolean isCurrentStockOver;
public int getId() {
	return id;
}
public void setId(int id) {
	this.id = id;
}
public String getItemId() {
	return itemId;
}
public void setItemId(String itemId) {
	this.itemId = itemId;
}
public String getItemName() {
	return itemName;
}
public void setItemName(String itemName) {
	this.itemName = itemName;
}
public String getHsnCode() {
	return hsnCode;
}
public void setHsnCode(String hsnCode) {
	this.hsnCode = hsnCode;
}
public int getCatId() {
	return catId;
}
public void setCatId(int catId) {
	this.catId = catId;
}
public float getMrp() {
	return mrp;
}
public void setMrp(float mrp) {
	this.mrp = mrp;
}
public float getRate() {
	return rate;
}
public void setRate(float rate) {
	this.rate = rate;
}
public float getQty() {
	return qty;
}
public void setQty(float qty) {
	this.qty = qty;
}
public float getItemTax1() {
	return itemTax1;
}
public void setItemTax1(float itemTax1) {
	this.itemTax1 = itemTax1;
}
public float getItemTax2() {
	return itemTax2;
}
public void setItemTax2(float itemTax2) {
	this.itemTax2 = itemTax2;
}
public float getItemTax3() {
	return itemTax3;
}
public void setItemTax3(float itemTax3) {
	this.itemTax3 = itemTax3;
}
public int getBillStockType() {
	return billStockType;
}
public void setBillStockType(int billStockType) {
	this.billStockType = billStockType;
}
public float getTotalSpStock() {
	return totalSpStock;
}
public void setTotalSpStock(float totalSpStock) {
	this.totalSpStock = totalSpStock;
}
public float getTotalRegStock() {
	return totalRegStock;
}
public void setTotalRegStock(float totalRegStock) {
	this.totalRegStock = totalRegStock;
}
public boolean isSpStockGretor() {
	return isSpStockGretor;
}
public void setSpStockGretor(boolean isSpStockGretor) {
	this.isSpStockGretor = isSpStockGretor;
}
public boolean isSpStockLessthanQty() {
	return isSpStockLessthanQty;
}
public void setSpStockLessthanQty(boolean isSpStockLessthanQty) {
	this.isSpStockLessthanQty = isSpStockLessthanQty;
}
public boolean isRegOpStockLess() {
	return isRegOpStockLess;
}
public void setRegOpStockLess(boolean isRegOpStockLess) {
	this.isRegOpStockLess = isRegOpStockLess;
}
public boolean isRegOpStockGretor() {
	return isRegOpStockGretor;
}
public void setRegOpStockGretor(boolean isRegOpStockGretor) {
	this.isRegOpStockGretor = isRegOpStockGretor;
}
public boolean isCurrentStockOver() {
	return isCurrentStockOver;
}
public void setCurrentStockOver(boolean isCurrentStockOver) {
	this.isCurrentStockOver = isCurrentStockOver;
}
@Override
public String toString() {
	return "CustomerBillItem [id=" + id + ", itemId=" + itemId + ", itemName=" + itemName + ", hsnCode=" + hsnCode
			+ ", catId=" + catId + ", mrp=" + mrp + ", rate=" + rate + ", qty=" + qty + ", itemTax1=" + itemTax1
			+ ", itemTax2=" + itemTax2 + ", itemTax3=" + itemTax3 + ", billStockType=" + billStockType
			+ ", totalSpStock=" + totalSpStock + ", totalRegStock=" + totalRegStock + ", isSpStockGretor="
			+ isSpStockGretor + ", isSpStockLessthanQty=" + isSpStockLessthanQty + ", isRegOpStockLess="
			+ isRegOpStockLess + ", isRegOpStockGretor=" + isRegOpStockGretor + ", isCurrentStockOver="
			+ isCurrentStockOver + "]";
}
}
