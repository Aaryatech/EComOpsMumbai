package com.monginis.ops.model;
 

public class TaxLabListForPos {
	 
	private int sellBillDetailNo; 
	private float taxableAmt; 
	private float cgstPer; 
	private float igstPer; 
	private float sgstPer; 
	private float igstRs;  
	private float cgstRs;
	private float sgstRs;
	public int getSellBillDetailNo() {
		return sellBillDetailNo;
	}
	public void setSellBillDetailNo(int sellBillDetailNo) {
		this.sellBillDetailNo = sellBillDetailNo;
	}
	public float getTaxableAmt() {
		return taxableAmt;
	}
	public void setTaxableAmt(float taxableAmt) {
		this.taxableAmt = taxableAmt;
	}
	public float getCgstPer() {
		return cgstPer;
	}
	public void setCgstPer(float cgstPer) {
		this.cgstPer = cgstPer;
	}
	public float getIgstPer() {
		return igstPer;
	}
	public void setIgstPer(float igstPer) {
		this.igstPer = igstPer;
	}
	public float getSgstPer() {
		return sgstPer;
	}
	public void setSgstPer(float sgstPer) {
		this.sgstPer = sgstPer;
	}
	public float getIgstRs() {
		return igstRs;
	}
	public void setIgstRs(float igstRs) {
		this.igstRs = igstRs;
	}
	public float getCgstRs() {
		return cgstRs;
	}
	public void setCgstRs(float cgstRs) {
		this.cgstRs = cgstRs;
	}
	public float getSgstRs() {
		return sgstRs;
	}
	public void setSgstRs(float sgstRs) {
		this.sgstRs = sgstRs;
	}
	@Override
	public String toString() {
		return "TaxLabListForPos [sellBillDetailNo=" + sellBillDetailNo + ", taxableAmt=" + taxableAmt + ", cgstPer="
				+ cgstPer + ", igstPer=" + igstPer + ", sgstPer=" + sgstPer + ", igstRs=" + igstRs + ", cgstRs="
				+ cgstRs + ", sgstRs=" + sgstRs + "]";
	}
	
	

}
