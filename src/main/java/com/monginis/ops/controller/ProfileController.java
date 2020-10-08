package com.monginis.ops.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.monginis.ops.common.DateConvertor;
import com.monginis.ops.common.Firebase;
import com.monginis.ops.constant.Constant;
import com.monginis.ops.constant.VpsImageUpload;
import com.monginis.ops.model.City;
import com.monginis.ops.model.ErrorMessage;
import com.monginis.ops.model.FrEmpMaster;
import com.monginis.ops.model.FrLoginResponse;
//import com.monginis.ops.model.FrMenu;
//import com.monginis.ops.model.FranchiseSup;
import com.monginis.ops.model.Franchisee;
import com.monginis.ops.model.Info;
import com.monginis.ops.model.LoginInfo;
//import com.monginis.ops.model.Route;
import com.monginis.ops.model.Setting;
 

@Controller
@Scope("session")
public class ProfileController {
	

	@RequestMapping(value = "/showeditprofile")
	public ModelAndView displaySavouries(HttpServletRequest request,HttpServletResponse response) {
		ModelAndView model = new ModelAndView("profile");

	try {
	System.out.println("I am here");
	RestTemplate rest = new RestTemplate();
	
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
	String date=sdf.format(Calendar.getInstance().getTimeInMillis());
	model.addObject("date", date);
	
	
	HttpSession ses = request.getSession();
	Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
	String frImageName = (String)ses.getAttribute("frImage");
	System.out.println("Franchisee Rsponse"+frDetails);
	
	model.addObject("frDetails", frDetails);
	model.addObject("imgUrl", Constant.FR_IMAGE_URL);
	model.addObject("frImageName", frImageName);
	
	MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
	map.add("compId", frDetails.getCompanyId());
	City[] cityArr = Constant.getRestTemplate().postForObject(Constant.URL + "getAllCitiesByCompId", map,
			City[].class);
	List<City> cityList = new ArrayList<City>(Arrays.asList(cityArr));
	model.addObject("cityList", cityList);
	
	FrEmpMaster emp = new FrEmpMaster();
	model.addObject("emp", emp);
	}
	catch (Exception e) {
		e.printStackTrace();
	}
	return model;
	
	
}
	
	
	@RequestMapping(value = "/getCurrentEmpCodeValue", method = RequestMethod.GET)
	public @ResponseBody int getCurrentEmpCodeValue(HttpServletRequest request,HttpServletResponse response) {
		
		int value=0;
		
		RestTemplate rest = new RestTemplate();
			
		try {
			Setting setting= rest.getForObject(Constant.URL + "/getSettingDataById?settingId={settingId}",
					Setting.class,57);
			value=setting.getSettingValue();
			
		}catch(Exception e) {e.printStackTrace();}

		return value;
	}
	
	
	@RequestMapping(value = "/updateprofile", method = RequestMethod.POST)
	public String editProfile(HttpServletRequest request,
		HttpServletResponse response,@RequestParam("fr_image") List<MultipartFile> file) {
		//,@RequestParam("fr_image") MultipartFile file
		//ModelAndView model = new ModelAndView("profile");
		System.out.println("I am here");
		
		HttpSession ses = request.getSession();
		Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
		
		
		try {
			
			Date date = new Date();
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			SimpleDateFormat sfd = new SimpleDateFormat("yyyy-MM-dd ");			
			int frId = frDetails.getFrId();
			String profileImage = null;

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("frId", frId);
			Franchisee getFr = Constant.getRestTemplate().postForObject(Constant.URL + "getFranchiseById", map,
					Franchisee.class);

			Franchisee franchise = new Franchisee();

			franchise.setFrId(frId);
			String frImage = request.getParameter("prevImage");
			
			System.out.println("------------->"+file+"*****"+frImage);
//			if (!file.get(0).getOriginalFilename().equalsIgnoreCase("")) {
//
//				VpsImageUpload upload = new VpsImageUpload();
//				try {
//					frImage=file.get(0).getOriginalFilename();
//					upload.saveUploadedFiles(file, Constant.FR_IMAGE_TYPE,file.get(0).getOriginalFilename());
//					System.out.println("upload method called " + file.toString());
//					frDetails.setFrImage(frImage);
//					ses.setAttribute("frDetails",frDetails);
//					ses.setAttribute("frImage",frImage);
//
//				} catch (IOException e) {
//					
//					System.out.println("Exce in File Upload In Fr Update Process " + e.getMessage());
//					e.printStackTrace();
//				}
//			}else {
//				System.out.println("No Img Found");
//			}
			
			if (!file.get(0).getOriginalFilename().equalsIgnoreCase("")) {

				System.err.println("In If ");

				profileImage = sf.format(date) + "_" + file.get(0).getOriginalFilename();

				try {
					new VpsImageUpload().saveUploadedFiles(file, Constant.FR_IMAGE_TYPE, profileImage);
				} catch (Exception e) {
				}

			} else {
				System.err.println("In else ");
				profileImage = request.getParameter("prevImage");
			}

			
			if (frId > 0) {
				franchise.setEditDateTime(sf.format(date));
			} else {
				franchise.setAddDateTime(sf.format(date));
			}

			franchise.setFrAddress(request.getParameter("fr_address"));
			franchise.setFrCity(Integer.parseInt(request.getParameter("fr_city")));
			franchise.setState(getFr.getState());
			franchise.setFrCode(getFr.getFrCode());
			franchise.setFrContactNo(request.getParameter("fr_mobile"));
			franchise.setFrEmailId(request.getParameter("fr_email"));
			franchise.setFrName(getFr.getFrName());
			franchise.setFrImage(profileImage);
			franchise.setFrPassword(getFr.getFrPassword());
			franchise.setOpeningDate(getFr.getOpeningDate());
			franchise.setOwnersBirthDay(getFr.getOwnersBirthDay());
			franchise.setPincode(request.getParameter("fr_pincode"));

			franchise.setIsActive(1);
			franchise.setDelStatus(1);
			franchise.setCompanyId(frDetails.getCompanyId());
			franchise.setCity("NA");

			if (frId > 0) {
				// FDA& GST Detail
				franchise.setFdaLicenseDateExp(request.getParameter("fda_lics_date"));
				franchise.setFdaNumber(getFr.getFdaNumber());
				franchise.setGstNumber(getFr.getGstNumber());
				franchise.setGstType(getFr.getGstType());
				franchise.setPincodeWeServed(getFr.getPincodeWeServed());

				try {
					franchise.setNoOfKmAreaCover(getFr.getNoOfKmAreaCover());
					franchise.setShopsLatitude(getFr.getShopsLatitude());
					franchise.setShopsLogitude(getFr.getShopsLogitude());

				} catch (Exception e) {
					franchise.setNoOfKmAreaCover(0);
					franchise.setShopsLatitude(0);
					franchise.setShopsLogitude(0);
					e.printStackTrace();
				}

				// Bank Details
				franchise.setPanNo(getFr.getPanNo());
				franchise.setCoBankAccNo(getFr.getCoBankAccNo());
				franchise.setCoBankBranchName(getFr.getCoBankBranchName());
				franchise.setCoBankIfscCode(getFr.getCoBankIfscCode());
				franchise.setCoBankName(getFr.getCoBankName());
				franchise.setPaymentGetwayLink(getFr.getPaymentGetwayLink());
				franchise.setPaymentGetwayLinkSameAsParent(getFr.getPaymentGetwayLinkSameAsParent());
			}

			franchise.setExDate1(sfd.format(date));
			franchise.setExDate2(sfd.format(date));
			franchise.setExFloat1(0);
			franchise.setExFloat2(0);
			franchise.setExFloat3(0);
			franchise.setExFloat4(0);
			franchise.setExFloat5(0);
			franchise.setExInt1(0);
			franchise.setExInt2(0);
			franchise.setExInt3(0);
			franchise.setExVar1("NA");
			franchise.setExVar2("NA");
			franchise.setExVar3("NA");
			franchise.setExVar4("NA");
			franchise.setExVar5("NA");
			franchise.setExVar6("NA");
			franchise.setExVar7("NA");

			franchise.setUserId(getFr.getUserId());
			franchise.setFrRating(getFr.getFrRating());

			Franchisee res = Constant.getRestTemplate().postForObject(Constant.URL + "saveFranchise", franchise,
					Franchisee.class);		
			if(res.getFrId()>0) {
				System.out.println("Update Successfull");
			}
			}catch(Exception e)
			{				
				System.out.println(e.getMessage());
			}
			 return "redirect:/showeditprofile";
	}
	
	
	@RequestMapping(value = "/checkUserAuthority", method = RequestMethod.GET)
	public @ResponseBody LoginInfo checkUserAuthority(HttpServletRequest request,HttpServletResponse response) {
		
		FrLoginResponse loginResponse=new FrLoginResponse();
		try
		{
		String adminPwd=request.getParameter("adminPwd");

		HttpSession session = request.getSession();

		Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");
			
		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
		map.add("frCode", frDetails.getFrCode());
		map.add("frPasswordKey",adminPwd);

		RestTemplate restTemplate = new RestTemplate();

		 loginResponse = restTemplate.postForObject(Constant.URL + "/loginFr", map,
				FrLoginResponse.class);

		System.out.println("Login Response " + loginResponse.toString());

		
		}
		catch(Exception e)
		{
			System.out.println("Exception In /checkAutority Method /ProfileController");
		}
		return loginResponse.getLoginInfo();

	}
	
	
	@RequestMapping(value = "/updateUserPasswords", method = RequestMethod.GET)
	public @ResponseBody Info updateUserPasswords(HttpServletRequest request,HttpServletResponse response) {
		
		//String pass1=request.getParameter("pass1");
		String pass2=request.getParameter("pass2");
		String pass3=request.getParameter("pass3");

		HttpSession session = request.getSession();

		Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");
			
		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
		map.add("frId", frDetails.getFrId());
		//map.add("pass1", pass1);
		map.add("pass2",pass2);
		map.add("pass3",pass3);

		RestTemplate restTemplate = new RestTemplate();

		 Info info = restTemplate.postForObject(Constant.URL + "/updateFranchiseSupUsrPwd", map,
				 Info.class);

		 System.out.println(info.toString());
		return info;
	}
	
	
	
	@RequestMapping(value = "/updateAdminPassword", method = RequestMethod.GET)
	public @ResponseBody Info updateAdminPassword(HttpServletRequest request,HttpServletResponse response) {
		
		String adminPwd=request.getParameter("adminPwd");
	

		HttpSession session = request.getSession();

		Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");
			
		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
		map.add("frId", frDetails.getFrId());
		map.add("adminPwd", adminPwd);
	    
		RestTemplate restTemplate = new RestTemplate();

		 Info info = restTemplate.postForObject(Constant.URL + "/updateAdminPwd", map,
				 Info.class);
		 
		 
		 if(!info.isError()) {
			 
			map = new LinkedMultiValueMap<String, Object>();
				map.add("frCode", frDetails.getFrCode());
				map.add("frPasswordKey", adminPwd);

				FrLoginResponse loginResponse = restTemplate.postForObject(Constant.URL + "/loginFr", map,
						FrLoginResponse.class);

				System.out.println("Login Response " + loginResponse.toString());

				if (!loginResponse.getLoginInfo().isError()) {
					session.setAttribute("frId", loginResponse.getFranchisee().getFrId());
					session.setAttribute("frName", loginResponse.getFranchisee().getFrName());

					session.setAttribute("frDetails", loginResponse.getFranchisee());
				}
			 
		 }
		 
		 

		 System.out.println(info.toString());
		return info;
	}
}
