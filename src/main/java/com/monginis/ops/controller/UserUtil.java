package com.monginis.ops.controller;

import java.time.Instant;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.monginis.ops.constant.Constant;
import com.monginis.ops.model.FrEmpMaster;
import com.monginis.ops.model.Franchisee;
import com.monginis.ops.model.Info;

@Controller
@Scope("session")
public class UserUtil {

	Instant start = null;
	
	@RequestMapping(value = "/getEmpDetails", method = RequestMethod.GET)
	public @ResponseBody FrEmpMaster getUserInfo(HttpServletRequest request, HttpServletResponse response) {
		Info info = new Info();
		ModelAndView model = null;
		FrEmpMaster frEmp = new FrEmpMaster();	
	try{
		
		RestTemplate rest = new RestTemplate();
		
		String mob = request.getParameter("mob");
		int empId = Integer.parseInt(request.getParameter("frEmpId"));
		
		System.out.println("mob--------------------------"+mob+" : "+empId);
		
		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
		map.add("mob", mob);
		map.add("empId", empId);
		
		frEmp = rest.postForObject(Constant.URL + "getFranchiseeByMob", map, FrEmpMaster.class);
		System.err.println("frEmp-----------"+frEmp);
		if(frEmp!=null) {
			model = new ModelAndView("verifyOTP");
			model.addObject("mob", mob);
			info.setError(false);
			info.setMessage("User Found");
			System.err.println(info);
			
			start = Instant.now();
			;
		}else {
			info.setError(true);			
			info.setMessage("User Not Found");
			System.err.println(info);
			model = new ModelAndView("forgotpassword");
		}
	}catch (Exception e) {
		model = new ModelAndView("forgotpassword");
		e.printStackTrace();		
	}
		
		return frEmp;
		
	}
	
	@RequestMapping(value = "/checkOtp", method = RequestMethod.GET)
	public @ResponseBody Info OTPVerificationByContact(HttpServletRequest request, HttpServletResponse response) {

		System.err.println("Hiii  OTPVerification  ");
		Info info = new Info();
		

		try {
			RestTemplate rest = new RestTemplate();
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			String otp = request.getParameter("otp");
			System.out.println("OTP Found--------"+otp);
			map.add("otp", otp);

			FrEmpMaster user = rest.postForObject(Constant.URL + "validateOTP", map, FrEmpMaster.class);	
		//	System.err.println("OTP User--------------"+user);

			if (user.getFrEmpId() == 0) {
				info.setError(true);
				info.setMessage("Invalid OTP");

			} else {				
				System.err.println("User" + user);
				info.setError(false);
				info.setMessage("Correct OTP");
				
			}

		} catch (Exception e) {
			System.err.println("Exce in checkOtp  " + e.getMessage());
			e.printStackTrace();
		}

		return info;

	}
	
	@RequestMapping(value = "/changeToNewPassword", method = RequestMethod.GET)
	public @ResponseBody Info changeToNewPassword(HttpServletRequest request, HttpServletResponse response) {
		Info info = new Info();
		ModelAndView model = null;
		HttpSession session = request.getSession();
		try {

			RestTemplate rest = new RestTemplate();
			int employeeId = Integer.parseInt(request.getParameter("employeeId"));
			String newPass = request.getParameter("newPass");
			//System.out.println("Passs--------------------------" + userId + " " + newPass);
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("empId", employeeId);
			map.add("pass", newPass);

			Info inf = rest.postForObject(Constant.URL + "updateEmpNewPassword", map, Info.class);

			if (inf.isError()) {
				model = new ModelAndView("login");
				session.setAttribute("changePasswordFail", "Password Not Change");
				info.setError(true);
				info.setMessage("Password Not Change");
				System.err.println(info);
			} else {
				model = new ModelAndView("login");			
				session.setAttribute("changePassword", "Password Change Sucessfully");
				info.setError(false);
				info.setMessage("Password Change Sucessfully");
				System.err.println(info);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return info;

	}
}
