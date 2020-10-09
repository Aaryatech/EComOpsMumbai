package com.monginis.ops.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.monginis.ops.common.DateConvertor;
import com.monginis.ops.constant.Constant;
import com.monginis.ops.model.Franchisee;
import com.monginis.ops.model.GetOrderHeaderDisplay;
import com.monginis.ops.model.Status;

@Controller
@Scope("session")
public class OrderController {
	
	List<Status> statusList = new ArrayList<Status>();
	
	@RequestMapping(value = "/showOrderList", method = RequestMethod.GET)
	public ModelAndView showOrderList(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView mav = null;

		mav = new ModelAndView("orders/orderList");

		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
		mav.addObject("todaysDate", sdf.format(cal.getTime()));

	
		try {
			HttpSession session = request.getSession();
			Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");
			int frId = frDetails.getFrId();
			
			Status[] statusArr = Constant.getRestTemplate().getForObject(Constant.URL + "getAllStatus",
					Status[].class);
			
			statusList = new ArrayList<Status>(Arrays.asList(statusArr));
			mav.addObject("statusList", statusList);
			
			mav.addObject("imagePath", Constant.FR_IMAGE_URL);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;

	}
	
	@RequestMapping(value = "/getStatusList", method = RequestMethod.GET)
	@ResponseBody
	public List<Status> getStatusList(HttpServletRequest request, HttpServletResponse response) {
		System.err.println("Status List----------"+statusList);
		return statusList;
	}
	
	List<GetOrderHeaderDisplay> orderList = new ArrayList<>();	
	@RequestMapping(value = "/getOrderListByStatusAjax", method = RequestMethod.GET)
	public @ResponseBody List<GetOrderHeaderDisplay> getOrderListByStatus(HttpServletRequest request,
			HttpServletResponse response) {		
				
		try {			
			System.err.println("In Here");
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			
			String statusId = request.getParameter("statusId");	

			String statusStr = "";

			if (statusId != null) {

				statusStr = statusId.toString().substring(1, statusId.toString().length() - 1);
				statusStr = statusStr.replaceAll("\"", "");
				statusStr = statusStr.replaceAll(" ", "");
			}
			
			HttpSession session = request.getSession();
			Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");
			int frId = frDetails.getFrId();
			int compId = frDetails.getCompanyId();
			
			String fromDate = request.getParameter("fromDate");
			String toDate = request.getParameter("toDate");
			
			System.out.println(statusStr+" "+fromDate);
			map.add("fromDate", DateConvertor.convertToYMD(fromDate));
			map.add("toDate", DateConvertor.convertToYMD(toDate));
			map.add("status", statusStr);
			map.add("compId", compId);
			map.add("frId", frId);

			GetOrderHeaderDisplay[] orderRepArr = Constant.getRestTemplate()
					.postForObject(Constant.URL + "/getOrderHeaderListByFrId", map, GetOrderHeaderDisplay[].class);

			orderList = new ArrayList<GetOrderHeaderDisplay>(Arrays.asList(orderRepArr));			
			System.out.println("Order List--->"+orderList);
		}catch (Exception e) {
			System.out.println("Exc in /getOrdersByStatus : "+e.getMessage());
			e.printStackTrace();
		}
				return orderList;
		
	}
	
	@RequestMapping(value = "/getOrderDashDetailByFrId", method = RequestMethod.GET)
	@ResponseBody
	public List<GetOrderHeaderDisplay> getOrderDetailByBillId(HttpServletRequest request,
			HttpServletResponse response) {
		System.out.println("Order List Details--->"+orderList);
		return orderList;

	}
}
