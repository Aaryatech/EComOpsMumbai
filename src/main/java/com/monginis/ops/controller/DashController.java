package com.monginis.ops.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.monginis.ops.constant.Constant;
import com.monginis.ops.model.Franchisee;

public class DashController {
	
	
	@RequestMapping(value = "/getCounts", method = RequestMethod.POST)
	public ModelAndView  submitBill(HttpServletRequest request, HttpServletResponse responsel) {
	 
		
		ModelAndView model = new ModelAndView("home");
		
		RestTemplate restTemplate = new RestTemplate();
		HttpSession session = request.getSession();
		Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");
		 
//		try {
//			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
//			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
//			Date date = new Date();
//
//			map = new LinkedMultiValueMap<String, Object>();
// 
//			map.add("frId", frDetails.getFrId());
//			map.add("frRateCat", frDetails.getFrRateCat());
//			map.add("fromDate", sf.format(date));
//			map.add("toDate", sf.format(date));
//			PosDashCounts countDet = restTemplate.postForObject(Constant.URL + "/getPosDashCounts",map,
//					PosDashCounts.class);
//			 
//			model.addObject("countDetails", countDet);
//			
//			
//			
//		}catch (Exception e) {
//			e.printStackTrace();
//		}
		return model;
	}
	
	
}
