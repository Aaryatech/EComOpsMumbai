package com.monginis.ops.model;


public class GetDeliveryBoyOrAgentData {

	private String uId;
	private int delBoyId;
	private String name;
	private String mobileNo;
	private int frId;
	private String cityIds;
	private int isAgent;
	public String getuId() {
		return uId;
	}
	public void setuId(String uId) {
		this.uId = uId;
	}
	public int getDelBoyId() {
		return delBoyId;
	}
	public void setDelBoyId(int delBoyId) {
		this.delBoyId = delBoyId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getMobileNo() {
		return mobileNo;
	}
	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}
	public int getFrId() {
		return frId;
	}
	public void setFrId(int frId) {
		this.frId = frId;
	}
	public String getCityIds() {
		return cityIds;
	}
	public void setCityIds(String cityIds) {
		this.cityIds = cityIds;
	}
	public int getIsAgent() {
		return isAgent;
	}
	public void setIsAgent(int isAgent) {
		this.isAgent = isAgent;
	}
	@Override
	public String toString() {
		return "GetDeliveryBoyOrAgentData [uId=" + uId + ", delBoyId=" + delBoyId + ", name=" + name + ", mobileNo="
				+ mobileNo + ", frId=" + frId + ", cityIds=" + cityIds + ", isAgent=" + isAgent + "]";
	}

}
