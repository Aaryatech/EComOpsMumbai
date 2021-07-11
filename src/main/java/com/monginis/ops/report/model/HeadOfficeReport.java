package com.monginis.ops.report.model;

import java.util.List;

import com.monginis.ops.model.Grievances;

public class HeadOfficeReport {

	private String id;
	private int orderId;
	private String deliveryDate;
	private String orderDate;
	private String orderNo;
	private String companyName;
	private int paymentMethod;
	private int orderStatus;
	private String timeSlot;
	private float qty;
	private float totalAmt;
	private float discAmt;
	private int productId;
	private String productCode;
	private String productName;
	private String catName;
	private String catPrefix;
	private String subCatCode;
	private String subCatName;
	private String subCatPrefix;
	private String custName;
	private String frCode;
	private String frName;
	private String frAddress;
	private String pincode;
	private String couponCode;
	private String payRefNo;
	
	private float deliveryCharges; 
	private String hsnCode; 
	private float mrp; 
	private float sgstAmt; 
	private float cgstAmt; 
	private float igstAmt; 
	
	List<Grievances> grievances;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	public String getDeliveryDate() {
		return deliveryDate;
	}
	public void setDeliveryDate(String deliveryDate) {
		this.deliveryDate = deliveryDate;
	}
	public String getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public int getPaymentMethod() {
		return paymentMethod;
	}
	public void setPaymentMethod(int paymentMethod) {
		this.paymentMethod = paymentMethod;
	}
	public int getOrderStatus() {
		return orderStatus;
	}
	public void setOrderStatus(int orderStatus) {
		this.orderStatus = orderStatus;
	}
	public String getTimeSlot() {
		return timeSlot;
	}
	public void setTimeSlot(String timeSlot) {
		this.timeSlot = timeSlot;
	}
	public float getQty() {
		return qty;
	}
	public void setQty(float qty) {
		this.qty = qty;
	}
	public float getTotalAmt() {
		return totalAmt;
	}
	public void setTotalAmt(float totalAmt) {
		this.totalAmt = totalAmt;
	}
	public float getDiscAmt() {
		return discAmt;
	}
	public void setDiscAmt(float discAmt) {
		this.discAmt = discAmt;
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
	public String getSubCatCode() {
		return subCatCode;
	}
	public void setSubCatCode(String subCatCode) {
		this.subCatCode = subCatCode;
	}
	public String getSubCatName() {
		return subCatName;
	}
	public void setSubCatName(String subCatName) {
		this.subCatName = subCatName;
	}
	public String getSubCatPrefix() {
		return subCatPrefix;
	}
	public void setSubCatPrefix(String subCatPrefix) {
		this.subCatPrefix = subCatPrefix;
	}
	public String getCustName() {
		return custName;
	}
	public void setCustName(String custName) {
		this.custName = custName;
	}
	public String getFrCode() {
		return frCode;
	}
	public void setFrCode(String frCode) {
		this.frCode = frCode;
	}
	public String getFrName() {
		return frName;
	}
	public void setFrName(String frName) {
		this.frName = frName;
	}
	public String getFrAddress() {
		return frAddress;
	}
	public void setFrAddress(String frAddress) {
		this.frAddress = frAddress;
	}
	public String getPincode() {
		return pincode;
	}
	public void setPincode(String pincode) {
		this.pincode = pincode;
	}
	public String getCouponCode() {
		return couponCode;
	}
	public void setCouponCode(String couponCode) {
		this.couponCode = couponCode;
	}
	public String getPayRefNo() {
		return payRefNo;
	}
	public void setPayRefNo(String payRefNo) {
		this.payRefNo = payRefNo;
	}
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	public float getDeliveryCharges() {
		return deliveryCharges;
	}
	public void setDeliveryCharges(float deliveryCharges) {
		this.deliveryCharges = deliveryCharges;
	}
	public String getHsnCode() {
		return hsnCode;
	}
	public void setHsnCode(String hsnCode) {
		this.hsnCode = hsnCode;
	}
	public float getMrp() {
		return mrp;
	}
	public void setMrp(float mrp) {
		this.mrp = mrp;
	}
	public float getSgstAmt() {
		return sgstAmt;
	}
	public void setSgstAmt(float sgstAmt) {
		this.sgstAmt = sgstAmt;
	}
	public float getCgstAmt() {
		return cgstAmt;
	}
	public void setCgstAmt(float cgstAmt) {
		this.cgstAmt = cgstAmt;
	}
	public float getIgstAmt() {
		return igstAmt;
	}
	public void setIgstAmt(float igstAmt) {
		this.igstAmt = igstAmt;
	}
	public List<Grievances> getGrievances() {
		return grievances;
	}
	public void setGrievances(List<Grievances> grievances) {
		this.grievances = grievances;
	}
	@Override
	public String toString() {
		return "HeadOfficeReport [id=" + id + ", orderId=" + orderId + ", deliveryDate=" + deliveryDate + ", orderDate="
				+ orderDate + ", orderNo=" + orderNo + ", companyName=" + companyName + ", paymentMethod="
				+ paymentMethod + ", orderStatus=" + orderStatus + ", timeSlot=" + timeSlot + ", qty=" + qty
				+ ", totalAmt=" + totalAmt + ", discAmt=" + discAmt + ", productId=" + productId + ", productCode="
				+ productCode + ", productName=" + productName + ", catName=" + catName + ", catPrefix=" + catPrefix
				+ ", subCatCode=" + subCatCode + ", subCatName=" + subCatName + ", subCatPrefix=" + subCatPrefix
				+ ", custName=" + custName + ", frCode=" + frCode + ", frName=" + frName + ", frAddress=" + frAddress
				+ ", pincode=" + pincode + ", couponCode=" + couponCode + ", payRefNo=" + payRefNo
				+ ", deliveryCharges=" + deliveryCharges + ", hsnCode=" + hsnCode + ", mrp=" + mrp + ", sgstAmt="
				+ sgstAmt + ", cgstAmt=" + cgstAmt + ", igstAmt=" + igstAmt + ", grievances=" + grievances + "]";
	}
		
}
