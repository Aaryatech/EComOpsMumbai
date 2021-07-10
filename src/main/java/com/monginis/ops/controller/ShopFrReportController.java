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
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


import com.monginis.ops.report.model.ShowPieChartData;

import com.monginis.ops.report.model.GetItemSubCatWise;
import com.monginis.ops.common.DateConvertor;
import com.monginis.ops.constant.Constant;
import com.monginis.ops.model.CompMaster;
import com.monginis.ops.model.Company;
import com.monginis.ops.model.Franchisee;
import com.monginis.ops.model.Info;
import com.monginis.ops.model.Status;
import com.monginis.ops.report.model.HeadOfficeReport;

@Controller
@Scope("session")
public class ShopFrReportController {
	
	List<CompMaster> compList = new ArrayList<CompMaster>();
	List<Status> statusList = new ArrayList<Status>();
	
	
	
	List<HeadOfficeReport> hoReport = new ArrayList<HeadOfficeReport>();
	@RequestMapping(value = "/getShopFranchiseReport", method = RequestMethod.GET)
	public @ResponseBody List<HeadOfficeReport> getheadOfficeReportt(HttpServletRequest request,
			HttpServletResponse response) {
		System.out.println("inside getShopFranchiseReport ");

		String fromDate = "";
		String toDate = "";
		HttpSession ses = request.getSession();		
		try {				
			
			//int compId = (int) ses.getAttribute("companyId");
			
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			
			int dateType = Integer.parseInt(request.getParameter("datetype"));
			int paymentMethod = Integer.parseInt(request.getParameter("payment"));	
			int frId = Integer.parseInt(request.getParameter("frId"));
			int compIds = Integer.parseInt(request.getParameter("compId"));


			System.out.println("frId " + frId);
			System.out.println("dateType " + dateType);

			System.out.println("compIds " + compIds);
			System.out.println("paymentMethod " + paymentMethod);
			
//			String compIdStr = request.getParameter("compId");
//			String compIds = "";
//			if (compIdStr != null) {
//
//				compIds = compIdStr.toString().substring(1, compIdStr.toString().length() - 1);
//				compIds = compIds.replaceAll("\"", "");
//				compIds = compIds.replaceAll(" ", "");
//			}				
			
			String statusStr = request.getParameter("status");
			String orderStatus = "";
			if (statusStr != null) {

				orderStatus = statusStr.toString().substring(1, statusStr.toString().length() - 1);
				orderStatus = orderStatus.replaceAll("\"", "");
				orderStatus = orderStatus.replaceAll(" ", "");
			}	System.out.println("orderStatus " + orderStatus);			
			
			fromDate = request.getParameter("fromDate");
			toDate = request.getParameter("toDate");
			System.out.println("fromDate " + fromDate);
			System.out.println("toDate " + toDate);
			
			map.add("dateType", dateType);
			map.add("fromDate", DateConvertor.convertToYMD(fromDate));
			map.add("toDate", DateConvertor.convertToYMD(toDate));				
			map.add("compId", compIds);
			map.add("orderStatus", orderStatus);
			map.add("paymentMethod", paymentMethod);
			map.add("frId", frId);

		
			

			HeadOfficeReport[] orderRepArr = Constant.getRestTemplate()
					.postForObject(Constant.URL + "/getFrItemReport", map, HeadOfficeReport[].class);

			hoReport = new ArrayList<HeadOfficeReport>(Arrays.asList(orderRepArr));
			
		} catch (

		Exception e) {
			System.out.println("Excep in /getShopFranchiseReport " + e.getMessage());
			e.printStackTrace();
		}

		System.out.println("getShopFranchiseReport " + hoReport);
		return hoReport;
	}
	
	
	@RequestMapping(value = "/getShopFrReport", method = RequestMethod.GET)
	public ModelAndView getShopFrReports(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView mav = null;

		mav = new ModelAndView("reports/shopFrReport");

		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
		mav.addObject("todaysDate", sdf.format(cal.getTime()));

	
		try {
			HttpSession session = request.getSession();
			Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");
			Company cmDetails = (Company) session.getAttribute("cmDetails");
			
			int frId = frDetails.getFrId();
			int compId = frDetails.getCompanyId();
			
			Status[] statusArr = Constant.getRestTemplate().getForObject(Constant.URL + "getAllStatus",
					Status[].class);
			
			statusList = new ArrayList<Status>(Arrays.asList(statusArr));
			mav.addObject("compId", compId);
			mav.addObject("frId", frId);
			mav.addObject("statusList", statusList);
			
			mav.addObject("imagePath", Constant.PROD_IMG_VIEW_URL);

			System.out.println("comp id"+compId);
			System.out.println("fr id"+frId);
			System.out.println("statusList"+statusList);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;

	}
	
	@RequestMapping(value = "/getStatusListAjax", method = RequestMethod.GET)
	@ResponseBody
	public List<Status> getStatusListAjax(HttpServletRequest request, HttpServletResponse response) {

		return statusList;
	}
	
	
	List<ShowPieChartData> chartData = new ArrayList<ShowPieChartData>();
	@RequestMapping(value = "/getCatWiseQtyChartDataByFr", method = RequestMethod.GET)
	public @ResponseBody List<ShowPieChartData> getCatWiseQtyChartData(HttpServletRequest request,
			HttpServletResponse response) {

		String fromDate = "";
		String toDate = "";
		HttpSession ses = request.getSession();		
		try {				
							
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			
			int paymentMethod = Integer.parseInt(request.getParameter("payment"));
			int frId = Integer.parseInt(request.getParameter("frId"));
//			int compId = Integer.parseInt(request.getParameter("compId"));
			System.out.println("Payment - "+paymentMethod);
			
			String compIdStr = request.getParameter("compId");
			String compIds = "";
			if (compIdStr != null) {

				compIds = compIdStr.toString().substring(1, compIdStr.toString().length() - 1);
				compIds = compIds.replaceAll("\"", "");
				compIds = compIds.replaceAll(" ", "");
			}
			System.out.println("compIds - "+compIds); 
			
			String statusStr = request.getParameter("status");
			String orderStatus = "";
			if (statusStr != null) {

				orderStatus = statusStr.toString().substring(1, statusStr.toString().length() - 1);
				orderStatus = orderStatus.replaceAll("\"", "");
				orderStatus = orderStatus.replaceAll(" ", "");
			}
			System.out.println("orderStatus - "+orderStatus); 
			
			fromDate = request.getParameter("fromDate");
			toDate = request.getParameter("toDate");

			System.out.println("Dates  - "+fromDate+" - "+toDate); 

			map.add("fromDate", DateConvertor.convertToYMD(fromDate));
			map.add("toDate", DateConvertor.convertToYMD(toDate));				
			map.add("compIds", compIds);
			map.add("orderStatus", orderStatus);
			map.add("paymentMethod", paymentMethod);
			map.add("frId", frId);

			ShowPieChartData[] orderRepArr = Constant.getRestTemplate()
					.postForObject(Constant.URL + "/getCatQtyChartDataByFr", map, ShowPieChartData[].class);

			chartData = new ArrayList<ShowPieChartData>(Arrays.asList(orderRepArr));
			
		} catch (Exception e) {
			System.out.println("Excep in /getCatWiseQtyChartData " + e.getMessage());
			e.printStackTrace();
		}
		
		return chartData;
	}
	
	@RequestMapping(value = "/getCatWiseTtlSaleChartDataByFr", method = RequestMethod.GET)
	public @ResponseBody List<ShowPieChartData> getCatWiseTtlSaleChartData(HttpServletRequest request,
			HttpServletResponse response) {

		String fromDate = "";
		String toDate = "";
		HttpSession ses = request.getSession();		
		try {				
							
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			
			int paymentMethod = Integer.parseInt(request.getParameter("payment"));
			int frId = Integer.parseInt(request.getParameter("frId"));
//			int compId = Integer.parseInt(request.getParameter("compId"));
			System.out.println("Payment - "+paymentMethod);
			
			String compIdStr = request.getParameter("compId");
			String compIds = "";
			if (compIdStr != null) {

				compIds = compIdStr.toString().substring(1, compIdStr.toString().length() - 1);
				compIds = compIds.replaceAll("\"", "");
				compIds = compIds.replaceAll(" ", "");
			}
			System.out.println("compIds - "+compIds); 
			
			String statusStr = request.getParameter("status");
			String orderStatus = "";
			if (statusStr != null) {

				orderStatus = statusStr.toString().substring(1, statusStr.toString().length() - 1);
				orderStatus = orderStatus.replaceAll("\"", "");
				orderStatus = orderStatus.replaceAll(" ", "");
			}
			System.out.println("orderStatus - "+orderStatus); 
			
			fromDate = request.getParameter("fromDate");
			toDate = request.getParameter("toDate");

			System.out.println("Dates  - "+fromDate+" - "+toDate); 

			map.add("fromDate", DateConvertor.convertToYMD(fromDate));
			map.add("toDate", DateConvertor.convertToYMD(toDate));				
			map.add("compIds", compIds);
			map.add("orderStatus", orderStatus);
			map.add("paymentMethod", paymentMethod);
			map.add("frId", frId);

			ShowPieChartData[] orderRepArr = Constant.getRestTemplate()
					.postForObject(Constant.URL + "/getTotalSaleQtyChartDataByFr", map, ShowPieChartData[].class);

			chartData = new ArrayList<ShowPieChartData>(Arrays.asList(orderRepArr));
			
		} catch (Exception e) {
			System.out.println("Excep in /getCatWiseTtlSaleChartData " + e.getMessage());
			e.printStackTrace();
		}
		
		return chartData;
	}
	
	
	@RequestMapping(value = "/getSubCatWiseQtyChartDataByFr", method = RequestMethod.GET)
	public @ResponseBody List<ShowPieChartData> getSubCatWiseQtyChartData(HttpServletRequest request,
			HttpServletResponse response) {
		 chartData = new ArrayList<ShowPieChartData>();
		String fromDate = "";
		String toDate = "";
		HttpSession ses = request.getSession();		
		try {				
							
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			
			int catId = Integer.parseInt(request.getParameter("frId"));
			
			int paymentMethod = Integer.parseInt(request.getParameter("payment"));
			int frId = Integer.parseInt(request.getParameter("frId"));
//			int compId = Integer.parseInt(request.getParameter("compId"));
			System.out.println("Payment - "+paymentMethod);
			
			String compIdStr = request.getParameter("compId");
			String compIds = "";
			if (compIdStr != null) {

				compIds = compIdStr.toString().substring(1, compIdStr.toString().length() - 1);
				compIds = compIds.replaceAll("\"", "");
				compIds = compIds.replaceAll(" ", "");
			}
			System.out.println("compIds - "+compIds); 
			
			String statusStr = request.getParameter("status");
			String orderStatus = "";
			if (statusStr != null) {

				orderStatus = statusStr.toString().substring(1, statusStr.toString().length() - 1);
				orderStatus = orderStatus.replaceAll("\"", "");
				orderStatus = orderStatus.replaceAll(" ", "");
			}
			System.out.println("orderStatus - "+orderStatus); 
			
			fromDate = request.getParameter("fromDate");
			toDate = request.getParameter("toDate");

			System.out.println("Dates  - "+fromDate+" - "+toDate); 

			map.add("catId", catId);
			map.add("fromDate", DateConvertor.convertToYMD(fromDate));
			map.add("toDate", DateConvertor.convertToYMD(toDate));				
			map.add("compIds", compIds);
			map.add("orderStatus", orderStatus);
			map.add("paymentMethod", paymentMethod);
			map.add("frId", frId);

			ShowPieChartData[] orderRepArr = Constant.getRestTemplate()
					.postForObject(Constant.URL + "/getSubCatQtyChartDataByFr", map, ShowPieChartData[].class);

			chartData = new ArrayList<ShowPieChartData>(Arrays.asList(orderRepArr));
			
		} catch (Exception e) {
			System.out.println("Excep in /getSubCatQtyChartDataFr " + e.getMessage());
			e.printStackTrace();
		}
		
		return chartData;
	}
	
	
	@RequestMapping(value = "/getSubCatWiseItemChartDataByFr", method = RequestMethod.GET)
	public @ResponseBody List<GetItemSubCatWise> getSubCatWiseItemChartData(HttpServletRequest request,
			HttpServletResponse response) {
		List<GetItemSubCatWise> chartData = new ArrayList<GetItemSubCatWise>();
		String fromDate = "";
		String toDate = "";
		HttpSession ses = request.getSession();		
		try {				
							
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			
			int subCatId = Integer.parseInt(request.getParameter("subCatId"));
			
			int paymentMethod = Integer.parseInt(request.getParameter("payment"));
			System.out.println("Payment - "+paymentMethod);
			
			int frId = Integer.parseInt(request.getParameter("frId"));
			
			String compIdStr = request.getParameter("compId");
			String compIds = "";
			if (compIdStr != null) {

				compIds = compIdStr.toString().substring(1, compIdStr.toString().length() - 1);
				compIds = compIds.replaceAll("\"", "");
				compIds = compIds.replaceAll(" ", "");
			}
			System.out.println("compIds - "+compIds); 
			
			String statusStr = request.getParameter("status");
			String orderStatus = "";
			if (statusStr != null) {

				orderStatus = statusStr.toString().substring(1, statusStr.toString().length() - 1);
				orderStatus = orderStatus.replaceAll("\"", "");
				orderStatus = orderStatus.replaceAll(" ", "");
			}
			System.out.println("orderStatus - "+orderStatus); 
			
			fromDate = request.getParameter("fromDate");
			toDate = request.getParameter("toDate");

			System.out.println("Dates  - "+fromDate+" - "+toDate); 

			map.add("subCatId", subCatId);
			map.add("fromDate", DateConvertor.convertToYMD(fromDate));
			map.add("toDate", DateConvertor.convertToYMD(toDate));				
			map.add("compIds", compIds);
			map.add("orderStatus", orderStatus);
			map.add("paymentMethod", paymentMethod);
			map.add("frId", frId);
			GetItemSubCatWise[] orderRepArr = Constant.getRestTemplate()
					.postForObject(Constant.URL + "/getSubCatWiseItemChartDataByFr", map, GetItemSubCatWise[].class);

			chartData = new ArrayList<GetItemSubCatWise>(Arrays.asList(orderRepArr));
			
		} catch (Exception e) {
			System.out.println("Excep in /getSubCatWiseItemChartDataByFr " + e.getMessage());
			e.printStackTrace();
		}
		
		return chartData;
	}
}
