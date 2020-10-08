package com.monginis.ops.model;


public class FrEmpLoginResp {
	
	 	private LoginInfo loginInfo;
	    private Franchisee franchisee;
	    private FrEmpMaster frEmp;
	    
		public LoginInfo getLoginInfo() {
			return loginInfo;
		}
		public void setLoginInfo(LoginInfo loginInfo) {
			this.loginInfo = loginInfo;
		}
		public Franchisee getFranchisee() {
			return franchisee;
		}
		public void setFranchisee(Franchisee franchisee) {
			this.franchisee = franchisee;
		}
		public FrEmpMaster getFrEmp() {
			return frEmp;
		}
		public void setFrEmp(FrEmpMaster frEmp) {
			this.frEmp = frEmp;
		}
		@Override
		public String toString() {
			return "FrEmpLoginResp [loginInfo=" + loginInfo + ", franchisee=" + franchisee + ", frEmp=" + frEmp + "]";
		}
	    
	    
}
