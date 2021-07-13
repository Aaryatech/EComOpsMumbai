package com.monginis.ops.controller;

import java.awt.Dimension;
import java.awt.Insets;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Scope;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;
import org.zefer.pd4ml.PD4Constants;
import org.zefer.pd4ml.PD4ML;
import org.zefer.pd4ml.PD4PageMark;


import com.monginis.ops.constant.Constant;
import com.monginis.ops.common.DateConvertor;
import com.monginis.ops.constant.Constant;
import com.monginis.ops.model.ExportToExcel;
import com.monginis.ops.model.Franchisee;
import com.monginis.ops.model.GetOrderHeaderDisplay;
import com.monginis.ops.model.Status;
import com.monginis.ops.report.model.GetCustomerWisReport;
import com.monginis.ops.report.model.GetDateWiseBillReport;
import com.monginis.ops.report.model.GetSellBillHeader;

@Controller
@Scope("session")
public class ReportsController {

	String todaysDate;

	public static float roundUp(float d) {
		return BigDecimal.valueOf(d).setScale(2, BigDecimal.ROUND_HALF_UP).floatValue();
	}

	List<Status> statusList = new ArrayList<Status>();

	@RequestMapping(value = "/showOrderWiseReportBetDate", method = RequestMethod.GET)
	public ModelAndView showHSNwiseReportBetDate(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = null;
		HttpSession session = request.getSession();
		Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");
		
		model = new ModelAndView("reports/orderWiseReport");

		try {
			ZoneId z = ZoneId.of("Asia/Calcutta");

			LocalDate date = LocalDate.now(z);
			DateTimeFormatter formatters = DateTimeFormatter.ofPattern("d-MM-uuuu");
			todaysDate = date.format(formatters);
			model.addObject("todaysDate", todaysDate);
			
			model.addObject("imagePath", Constant.PROD_IMG_VIEW_URL);
			Status[] statusArr = Constant.getRestTemplate().getForObject(Constant.URL + "getAllStatus", Status[].class);

			statusList = new ArrayList<Status>(Arrays.asList(statusArr));
			model.addObject("statusList", statusList);
			
			model.addObject("frId", frDetails.getFrId());
			model.addObject("compId", frDetails.getCompanyId());

		} catch (Exception e) {

			System.out.println("Exc in show   report hsn wise  " + e.getMessage());
			e.printStackTrace();
		}

		return model;
	}

	@RequestMapping(value = "/getOrderStatusListRep", method = RequestMethod.GET)
	@ResponseBody
	public List<Status> getStatusList(HttpServletRequest request, HttpServletResponse response) {
	
		return statusList;
	}

	List<GetOrderHeaderDisplay> orderList = null;

	@RequestMapping(value = "/getOrderBetDateAndStatus", method = RequestMethod.GET)
	public @ResponseBody List<GetOrderHeaderDisplay> getReportHSNwise(HttpServletRequest request,
			HttpServletResponse response) {
		String fromDate = "";
		String toDate = "";
		HttpSession ses = request.getSession();
		Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");

		try {
			System.err.println("In Here");
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();

			String statusId = request.getParameter("statusId");
			
			String statusStr = "";

			if (statusId != null) {
				try {
					statusStr = statusId.toString().substring(1, statusId.toString().length() - 1);
					statusStr = statusStr.replaceAll("\"", "");
					statusStr = statusStr.replaceAll(" ", "");
				} catch (Exception e) {
					statusStr = statusId;
				}
			}

			int frId = frDetails.getFrId();
			int compId = frDetails.getCompanyId();

			fromDate = request.getParameter("fromDate");
			toDate = request.getParameter("toDate");

			System.out.println(statusStr + " " + fromDate);
			map.add("fromDate", DateConvertor.convertToYMD(fromDate));
			map.add("toDate", DateConvertor.convertToYMD(toDate));
			map.add("status", statusStr);
			map.add("compId", compId);
			map.add("frId", frId);

			GetOrderHeaderDisplay[] orderRepArr = Constant.getRestTemplate()
					.postForObject(Constant.URL + "/getOrderHeaderListByFrId", map, GetOrderHeaderDisplay[].class);

			orderList = new ArrayList<GetOrderHeaderDisplay>(Arrays.asList(orderRepArr));
			System.out.println("orderList in get sale Report hsn Wise " + orderList);
		} catch (

		Exception e) {
			System.out.println("get sale Report hsn Wise " + e.getMessage());
			e.printStackTrace();

		}

		// exportToExcel

		List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

		ExportToExcel expoExcel = new ExportToExcel();
		List<String> rowData = new ArrayList<String>();

		rowData.add("Sr No");
		rowData.add("Order No.");
		rowData.add("Delivery Date");
		rowData.add("Customer");
		rowData.add("Order Status");
		rowData.add("Total");
		float grandTotal = 0.0f;

		expoExcel.setRowData(rowData);
		int srno = 1;
		exportToExcelList.add(expoExcel);
		for (int i = 0; i < orderList.size(); i++) {
			expoExcel = new ExportToExcel();
			rowData = new ArrayList<String>();

			rowData.add(" " + srno);
			rowData.add(orderList.get(i).getOrderNo());
			rowData.add(" " + orderList.get(i).getDeliveryDateDisplay());
			rowData.add(" " + orderList.get(i).getCustName());
			rowData.add(" " + orderList.get(i).getOrderStatus());
//			String status = orderList.get(i).getOrderStatus() == 0 ? "Park Order"
//					: orderList.get(i).getOrderStatus() == 1 ? "Shop Confirmation Pending"
//							: orderList.get(i).getOrderStatus() == 2 ? "Accept"
//									: orderList.get(i).getOrderStatus() == 3 ? "Processing"
//											: orderList.get(i).getOrderStatus() == 4 ? "Delivery Pending"
//													: orderList.get(i).getOrderStatus() == 5 ? "Delivered"
//															: orderList.get(i).getOrderStatus() == 6
//																	? "Rejected by Shop"
//																	: orderList.get(i).getOrderStatus() == 7
//																			? "Return Order"
//																			: "Cancelled Order";
//			rowData.add(" " + status);
			rowData.add(" " + roundUp(orderList.get(i).getTotalAmt()));

			grandTotal = grandTotal + roundUp(orderList.get(i).getTotalAmt());

			srno = srno + 1;

			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);

		}

		expoExcel = new ExportToExcel();
		rowData = new ArrayList<String>();

		rowData.add("");
		rowData.add("");
		rowData.add("");
		rowData.add("Total");
		rowData.add("");
		rowData.add("" + Long.toString((long) (grandTotal)));
		expoExcel.setRowData(rowData);
		exportToExcelList.add(expoExcel);

		HttpSession session = request.getSession();
		session.setAttribute("exportExcelListNew", exportToExcelList);
		session.setAttribute("excelNameNew", "OrderWiseReport");
		session.setAttribute("reportNameNew", "Order Wise Report");
		session.setAttribute("searchByNew", "From Date: " + fromDate + "  To Date: " + toDate + " ");
		session.setAttribute("mergeUpto1", "$A$1:$L$1");
		session.setAttribute("mergeUpto2", "$A$2:$L$2");

		session.setAttribute("exportExcelList", exportToExcelList);
		session.setAttribute("excelName", "OrderWiseReport");

		return orderList;
	}

	@RequestMapping(value = "/getShowOrderDetail", method = RequestMethod.GET)
	@ResponseBody
	public List<GetOrderHeaderDisplay> getOrderDetailByBillId(HttpServletRequest request,
			HttpServletResponse response) {
		
		return orderList;

	}

	@RequestMapping(value = "pdf/getOrderReportPdf/{fromDate}/{toDate}/{statusId}/{frId}/{compId}", method = RequestMethod.GET)
	public ModelAndView getOrdrListPdf(HttpServletRequest request, HttpServletResponse response,
			@PathVariable String fromDate, @PathVariable String toDate, @PathVariable String statusId,
			@PathVariable int frId, @PathVariable int compId) throws FileNotFoundException {
		ModelAndView model = null;
		try {
			model = new ModelAndView("reports/reportPdf/orderWisePdf");

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			System.out.println(statusId + " " + fromDate);
			
			map.add("fromDate", DateConvertor.convertToYMD(fromDate));
			map.add("toDate", DateConvertor.convertToYMD(toDate));
			map.add("status", statusId);
			map.add("compId", compId);
			map.add("frId", frId);

			GetOrderHeaderDisplay[] orderRepArr = Constant.getRestTemplate()
					.postForObject(Constant.URL + "/getOrderHeaderListByFrId", map, GetOrderHeaderDisplay[].class);

			List<GetOrderHeaderDisplay> orderList = new ArrayList<GetOrderHeaderDisplay>(Arrays.asList(orderRepArr));

			model.addObject("orderList", orderList);
			model.addObject("fromDate", fromDate);
			model.addObject("toDate", toDate);
		} catch (Exception e) {
			System.out.println("Excep in /getOrderReportPdf " + e.getMessage());
		}

		return model;

	}

	@RequestMapping(value = "/showCustWiseReportBetDate", method = RequestMethod.GET)
	public ModelAndView showCustWiseReportBetDate(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = null;
		HttpSession session = request.getSession();

		model = new ModelAndView("reports/custWiseReport");

		try {
			ZoneId z = ZoneId.of("Asia/Calcutta");

			LocalDate date = LocalDate.now(z);
			DateTimeFormatter formatters = DateTimeFormatter.ofPattern("d-MM-uuuu");
			todaysDate = date.format(formatters);
			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
			model.addObject("frId", frDetails.getFrId());
			model.addObject("todaysDate", todaysDate);

		} catch (Exception e) {

			System.out.println("Exc in /showCustWiseReportBetDate  " + e.getMessage());
			e.printStackTrace();
		}

		return model;
	}

	List<GetCustomerWisReport> custRepList = new ArrayList<GetCustomerWisReport>();
	@RequestMapping(value = "/getCustPrchsRepBetDate", method = RequestMethod.GET)
	public @ResponseBody List<GetCustomerWisReport> getCustPrchsRepBetDate(HttpServletRequest request,
			HttpServletResponse response) {
		String fromDate = "";
		String toDate = "";
		HttpSession ses = request.getSession();
		Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");

		try {
			System.err.println("In Here");
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();

			int frId = frDetails.getFrId();
			int compId = frDetails.getCompanyId();

			fromDate = request.getParameter("fromDate");
			toDate = request.getParameter("toDate");

			map.add("fromDate", DateConvertor.convertToYMD(fromDate));
			map.add("toDate", DateConvertor.convertToYMD(toDate));
			// map.add("compId", compId);
			map.add("frId", frId);

			GetCustomerWisReport[] orderRepArr = Constant.getRestTemplate()
					.postForObject(Constant.URL + "/getCustPurchaseRepByFrId", map, GetCustomerWisReport[].class);

			custRepList = new ArrayList<GetCustomerWisReport>(Arrays.asList(orderRepArr));
			
		} catch (

		Exception e) {
			System.out.println("get sale Report hsn Wise " + e.getMessage());
			e.printStackTrace();

		}

		// exportToExcel

		List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

		ExportToExcel expoExcel = new ExportToExcel();
		List<String> rowData = new ArrayList<String>();

		rowData.add("Sr No");
		rowData.add("Customer Name");
		rowData.add("Mobile No.");
		rowData.add("Date Of Birth");
		rowData.add("Total Purchase");
		float grandTotal = 0.0f;

		expoExcel.setRowData(rowData);
		int srno = 1;
		exportToExcelList.add(expoExcel);
		for (int i = 0; i < custRepList.size(); i++) {
			expoExcel = new ExportToExcel();
			rowData = new ArrayList<String>();

			rowData.add(" " + srno);
			rowData.add(custRepList.get(i).getCustName());
			rowData.add(" " + custRepList.get(i).getCustMobileNo());
			rowData.add(" " + custRepList.get(i).getDateOfBirth());
			rowData.add(" " + roundUp(custRepList.get(i).getGrandTotal()));

			grandTotal = grandTotal + roundUp(custRepList.get(i).getGrandTotal());

			srno = srno + 1;

			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);

		}

		expoExcel = new ExportToExcel();
		rowData = new ArrayList<String>();

		rowData.add("");
		rowData.add("");
		rowData.add("Total");
		rowData.add("");
		rowData.add("" + Long.toString((long) (grandTotal)));
		expoExcel.setRowData(rowData);
		exportToExcelList.add(expoExcel);

		HttpSession session = request.getSession();
		session.setAttribute("exportExcelListNew", exportToExcelList);
		session.setAttribute("excelNameNew", "OrderWiseReport");
		session.setAttribute("reportNameNew", "Order Wise Report");
		session.setAttribute("searchByNew", "From Date: " + fromDate + "  To Date: " + toDate + " ");
		session.setAttribute("mergeUpto1", "$A$1:$L$1");
		session.setAttribute("mergeUpto2", "$A$2:$L$2");

		session.setAttribute("exportExcelList", exportToExcelList);
		session.setAttribute("excelName", "OrderWiseReport");

		return custRepList;
	}

	@RequestMapping(value = "pdf/getCustPrchsOrderDrlPdf/{fromDate}/{toDate}/{frId}", method = RequestMethod.GET)
	public ModelAndView getCustPrchsOrderDrlPdf(@PathVariable("fromDate") String fromDate,
			@PathVariable("toDate") String toDate, @PathVariable("frId") int frId, HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView model = null;
		
		try {
			model = new ModelAndView("/reports/reportPdf/custOrderDtlPdf");

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();

			map.add("fromDate", DateConvertor.convertToYMD(fromDate));
			map.add("toDate", DateConvertor.convertToYMD(toDate));
			// map.add("compId", compId);
			map.add("frId", frId);

			GetCustomerWisReport[] orderRepArr = Constant.getRestTemplate()
					.postForObject(Constant.URL + "/getCustPurchaseRepByFrId", map, GetCustomerWisReport[].class);

			custRepList = new ArrayList<GetCustomerWisReport>(Arrays.asList(orderRepArr));

			model.addObject("custRepList", custRepList);
		} catch (

		Exception e) {
			System.out.println("get sale Report hsn Wise " + e.getMessage());
			e.printStackTrace();

		}
		return model;
	}


	List<GetSellBillHeader> custPrchDtlList = new ArrayList<GetSellBillHeader>();
	@RequestMapping(value = "/getCustPrchsReportDetail", method = RequestMethod.GET)
	public @ResponseBody List<GetSellBillHeader> getCustPrchsReportDetail(HttpServletRequest request,
			HttpServletResponse response) {
		String fromDate = "";
		String toDate = "";
		HttpSession ses = request.getSession();
		Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");

		try {
			System.err.println("In Here");
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();

			int frId = frDetails.getFrId();
			int compId = frDetails.getCompanyId();

			fromDate = request.getParameter("fromDate");
			toDate = request.getParameter("toDate");

			map.add("fromDate", DateConvertor.convertToYMD(fromDate));
			map.add("toDate", DateConvertor.convertToYMD(toDate));
			map.add("custId", Integer.parseInt(request.getParameter("custId")));
			map.add("compId", compId);
			map.add("frId", frId);

			GetSellBillHeader[] orderRepArr = Constant.getRestTemplate()
					.postForObject(Constant.URL + "/getCustPurchaseDetailReport", map, GetSellBillHeader[].class);

			custPrchDtlList = new ArrayList<GetSellBillHeader>(Arrays.asList(orderRepArr));
			
		} catch (

		Exception e) {
			System.out.println("get sale Report hsn Wise " + e.getMessage());
			e.printStackTrace();

		}

		// exportToExcel

		List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

		ExportToExcel expoExcel = new ExportToExcel();
		List<String> rowData = new ArrayList<String>();

		rowData.add("Sr No");
		rowData.add("Bill No.");
		rowData.add("Bill Date");
		rowData.add("Bill Amt.");
		rowData.add("Payment Mode");
		rowData.add("Delivery Boy");
		float grandTotal = 0.0f;

		expoExcel.setRowData(rowData);
		int srno = 1;
		exportToExcelList.add(expoExcel);
		for (int i = 0; i < custPrchDtlList.size(); i++) {
			expoExcel = new ExportToExcel();
			rowData = new ArrayList<String>();

			rowData.add(" " + srno);
			rowData.add(custPrchDtlList.get(i).getInvoiceNo());
			rowData.add(" " + custPrchDtlList.get(i).getBillDate());
			rowData.add(" " + roundUp(custPrchDtlList.get(i).getGrandTotal()));
			rowData.add(custPrchDtlList.get(i).getPaymentMode() == 1 ? "Cash"
					: custPrchDtlList.get(i).getPaymentMode() == 2 ? "Card" : "E-Pay");
			rowData.add(" " + custPrchDtlList.get(i).getDelvrBoyName());
			grandTotal = grandTotal + roundUp(custPrchDtlList.get(i).getGrandTotal());

			srno = srno + 1;

			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);

		}

//		expoExcel = new ExportToExcel();
//		rowData = new ArrayList<String>();
//
//		rowData.add("");		
//		rowData.add("Total");
//		rowData.add("");
//		rowData.add("" + Long.toString((long) (grandTotal)));
//		expoExcel.setRowData(rowData);
//		exportToExcelList.add(expoExcel);

		HttpSession session = request.getSession();
		session.setAttribute("exportExcelListDummy", exportToExcelList);
		session.setAttribute("excelNameNew", "CustPurchaseOrderDtlReport");
		session.setAttribute("reportNameNew", "Customer Purchase Order Detail Report");
		session.setAttribute("searchByNew", "From Date: " + fromDate + "  To Date: " + toDate + " ");
		session.setAttribute("mergeUpto1", "$A$1:$L$1");
		session.setAttribute("mergeUpto2", "$A$2:$L$2");

		session.setAttribute("exportExcelList", exportToExcelList);
		session.setAttribute("excelName", "CustPurchaseOrderDtlReport");
		System.out.println("custPrchDtlList>>>>"+custPrchDtlList);
		return custPrchDtlList;
	}

	private Dimension format = PD4Constants.A4;
	private boolean landscapeValue = false;
	private int topValue = 8;
	private int leftValue = 0;
	private int rightValue = 0;
	private int bottomValue = 8;
	private String unitsValue = "m";
	private String proxyHost = "";
	private int proxyPort = 0;

	private int userSpaceWidth = 750;
	private static int BUFFER_SIZE = 1024;

	@RequestMapping(value = "/pdfReport", method = RequestMethod.GET)
	public void showPDF(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("Inside PDf For Report URL ");
		String url = request.getParameter("url");
		System.out.println("URL " + url);

		File f = new File(Constant.REPORT_PATH);

		try {
			runConverter(Constant.ReportURL + url, f, request, response);
			// runConverter("www.google.com", f,request,response);

		} catch (IOException e) {
			System.out.println("Pdf conversion exception " + e.getMessage());
			e.printStackTrace();
		}

		// get absolute path of the application
		ServletContext context = request.getSession().getServletContext();
		String appPath = context.getRealPath("");
		String filePath = Constant.REPORT_PATH;

		// construct the complete absolute path of the file
		String fullPath = appPath + filePath;
		File downloadFile = new File(filePath);
		FileInputStream inputStream = null;
		try {
			inputStream = new FileInputStream(downloadFile);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		try {
			// get MIME type of the file
			String mimeType = context.getMimeType(fullPath);
			if (mimeType == null) {
				// set to binary type if MIME mapping not found
				mimeType = "application/pdf";
			}
			System.out.println("MIME type: " + mimeType);

			String headerKey = "Content-Disposition";

			// response.addHeader("Content-Disposition", "attachment;filename=report.pdf");
			response.setContentType("application/pdf");

			OutputStream outStream;

			outStream = response.getOutputStream();

			byte[] buffer = new byte[BUFFER_SIZE];
			int bytesRead = -1;

			while ((bytesRead = inputStream.read(buffer)) != -1) {
				outStream.write(buffer, 0, bytesRead);
			}

			inputStream.close();
			outStream.close();

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private void runConverter(String urlstring, File output, HttpServletRequest request, HttpServletResponse response)
			throws IOException {

		if (urlstring.length() > 0) {
			if (!urlstring.startsWith("http://") && !urlstring.startsWith("file:")) {
				urlstring = "http://" + urlstring;
			}
			System.out.println("PDF URL " + urlstring);
			java.io.FileOutputStream fos = new java.io.FileOutputStream(output);

			PD4ML pd4ml = new PD4ML();

			try {

				Dimension landscapeA4 = pd4ml.changePageOrientation(PD4Constants.A4);
				pd4ml.setPageSize(landscapeA4);
				pd4ml.enableSmartTableBreaks(true);

				PD4PageMark footer = new PD4PageMark();

				footer.setPageNumberTemplate("Page $[page] of $[total]");
				footer.setPageNumberAlignment(PD4PageMark.RIGHT_ALIGN);
				footer.setFontSize(10);
				footer.setAreaHeight(20);

				pd4ml.setPageFooter(footer);

			} catch (Exception e) {
				System.out.println("Pdf conversion method excep " + e.getMessage());
			}

			if (unitsValue.equals("mm")) {
				pd4ml.setPageInsetsMM(new Insets(topValue, leftValue, bottomValue, rightValue));
			} else {
				pd4ml.setPageInsets(new Insets(topValue, leftValue, bottomValue, rightValue));
			}

			pd4ml.setHtmlWidth(userSpaceWidth);

			pd4ml.render(urlstring, fos);
		}
	}
	
	/*-----------------------------------------------------------------------------------*/
	 @RequestMapping(value = "/showDateWiseBillReport", method = RequestMethod.GET)
	public ModelAndView showDateWiseBillReport(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = null;
		HttpSession session = request.getSession();

		model = new ModelAndView("reports/dateWiseReport");

		try {
			ZoneId z = ZoneId.of("Asia/Calcutta");

			LocalDate date = LocalDate.now(z);
			DateTimeFormatter formatters = DateTimeFormatter.ofPattern("d-MM-uuuu");
			todaysDate = date.format(formatters);
			model.addObject("todaysDate", todaysDate);
			
			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
			model.addObject("frId", frDetails.getFrId());
		} catch (Exception e) {

			System.out.println("Excep in /showDateWiseBillReport  " + e.getMessage());
			e.printStackTrace();
		}

		return model;
	}
	 
	 List<GetDateWiseBillReport> dateBillRep = new ArrayList<GetDateWiseBillReport>();
		@RequestMapping(value = "/getDateWiseillsReport", method = RequestMethod.GET)
		public @ResponseBody List<GetDateWiseBillReport> getDateWiseillsReport(HttpServletRequest request,
				HttpServletResponse response) {
			String fromDate = "";
			String toDate = "";
			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");

			try {
				
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();

				int frId = frDetails.getFrId();
				int compId = frDetails.getCompanyId();

				fromDate = request.getParameter("fromDate");
				toDate = request.getParameter("toDate");

				map.add("fromDate", DateConvertor.convertToYMD(fromDate));
				map.add("toDate", DateConvertor.convertToYMD(toDate));				
				map.add("frId", frId);

				GetDateWiseBillReport[] orderRepArr = Constant.getRestTemplate()
						.postForObject(Constant.URL + "/getDateWiseBillsReport", map, GetDateWiseBillReport[].class);

				dateBillRep = new ArrayList<GetDateWiseBillReport>(Arrays.asList(orderRepArr));
				
			} catch (

			Exception e) {
				System.out.println("Excep in /getDateWiseillsReport " + e.getMessage());
				e.printStackTrace();

			}

			// exportToExcel

			List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

			ExportToExcel expoExcel = new ExportToExcel();
			List<String> rowData = new ArrayList<String>();

			rowData.add("Sr No");
			rowData.add("Bill Date");
			rowData.add("No. Of Bills");
			rowData.add("Total Amt.");
			rowData.add("COD");
			rowData.add("Cash");
			rowData.add("Card");
			float grandTotal = 0.0f;

			expoExcel.setRowData(rowData);
			int srno = 1;
			exportToExcelList.add(expoExcel);
			for (int i = 0; i < dateBillRep.size(); i++) {
				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();

				rowData.add(" " + srno);
				rowData.add(dateBillRep.get(i).getBillDate());
				rowData.add(" " + dateBillRep.get(i).getTotalBills());
				rowData.add(" " + roundUp(dateBillRep.get(i).getTotalAmt()));	
				rowData.add(" " + dateBillRep.get(i).getCod());	
				rowData.add(" " + dateBillRep.get(i).getCard());	
				rowData.add(" " + dateBillRep.get(i).getEpay());	
				grandTotal = grandTotal + roundUp(dateBillRep.get(i).getTotalAmt());

				srno = srno + 1;

				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);

			}

			expoExcel = new ExportToExcel();
			rowData = new ArrayList<String>();
	
			rowData.add("");		
			rowData.add("Total");
			rowData.add("");
			rowData.add("" + Long.toString((long) (grandTotal)));
			rowData.add("");
			rowData.add("");
			rowData.add("");
			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);

			HttpSession session = request.getSession();
			session.setAttribute("exportExcelListNew", exportToExcelList);
			session.setAttribute("excelNameNew", "DateWiseBillReport");
			session.setAttribute("reportNameNew", "Customer Purchase Order Detail Report");
			session.setAttribute("searchByNew", "From Date: " + fromDate + "  To Date: " + toDate + " ");
			session.setAttribute("mergeUpto1", "$A$1:$L$1");
			session.setAttribute("mergeUpto2", "$A$2:$L$2");

			session.setAttribute("exportExcelList", exportToExcelList);
			session.setAttribute("excelName", "DateWiseBillReport");

			return dateBillRep;
		}
		
		@RequestMapping(value = "pdf/getDateWiseBillPdf/{fromDate}/{toDate}/{frId}", method = RequestMethod.GET)
		public ModelAndView getDateWiseBillPdf(@PathVariable("fromDate") String fromDate,
				@PathVariable("toDate") String toDate, @PathVariable("frId") int frId, HttpServletRequest request,
				HttpServletResponse response) {
			ModelAndView model = null;
			
			try {
				model = new ModelAndView("/reports/reportPdf/dateBillPdf");

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();

				map.add("fromDate", DateConvertor.convertToYMD(fromDate));
				map.add("toDate", DateConvertor.convertToYMD(toDate));
				map.add("frId", frId);

				GetDateWiseBillReport[] orderRepArr = Constant.getRestTemplate()
						.postForObject(Constant.URL + "/getDateWiseBillsReport", map, GetDateWiseBillReport[].class);

				dateBillRep = new ArrayList<GetDateWiseBillReport>(Arrays.asList(orderRepArr));

				model.addObject("dateBillRep", dateBillRep);
			} catch (

			Exception e) {
				System.out.println("Excep in /getDateWiseBillPdf " + e.getMessage());
				e.printStackTrace();
			}
			return model;
		}
		
		List<GetSellBillHeader> orderDateCustDtl = new ArrayList<GetSellBillHeader>();
		@RequestMapping(value = "/getDateWiseCustDtlReport", method = RequestMethod.GET)
		public @ResponseBody List<GetSellBillHeader> getDateWiseCustDtlReport(HttpServletRequest request,
				HttpServletResponse response) {
			String fromDate = "";
			String toDate = "";
			HttpSession ses = request.getSession();
			Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");
			
			try {
				System.err.println("In Here");
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();

				int frId = frDetails.getFrId();
				int compId = frDetails.getCompanyId();

				fromDate = request.getParameter("fromDate");
				toDate = request.getParameter("toDate");

				map.add("fromDate", DateConvertor.convertToYMD(fromDate));
				map.add("toDate", DateConvertor.convertToYMD(toDate));				
				map.add("compId", compId);
				map.add("frId", frId);

				GetSellBillHeader[] orderRepArr = Constant.getRestTemplate()
						.postForObject(Constant.URL + "/getOrderDateWiseCustReport", map, GetSellBillHeader[].class);

				orderDateCustDtl = new ArrayList<GetSellBillHeader>(Arrays.asList(orderRepArr));
				
			} catch (

			Exception e) {
				System.out.println("Excep in /getDateWiseCustDtlReport " + e.getMessage());
				e.printStackTrace();

			}

			// exportToExcel

			List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

			ExportToExcel expoExcel = new ExportToExcel();
			List<String> rowData = new ArrayList<String>();

			rowData.add("Sr No");
			rowData.add("Bill No.");
			rowData.add("Bill Date");
			rowData.add("Bill Amt.");
			rowData.add("Payment Mode");
			rowData.add("Delivery Boy");
			float grandTotal = 0.0f;

			expoExcel.setRowData(rowData);
			int srno = 1;
			exportToExcelList.add(expoExcel);
			for (int i = 0; i < orderDateCustDtl.size(); i++) {
				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();

				rowData.add(" " + srno);
				rowData.add(orderDateCustDtl.get(i).getInvoiceNo());
				rowData.add(" " + orderDateCustDtl.get(i).getBillDate());
				rowData.add(" " + roundUp(orderDateCustDtl.get(i).getGrandTotal()));
				rowData.add(orderDateCustDtl.get(i).getPaymentMode() == 1 ? "Cash"
						: orderDateCustDtl.get(i).getPaymentMode() == 2 ? "Card" : "E-Pay");
				rowData.add(" " + orderDateCustDtl.get(i).getDelvrBoyName());
				grandTotal = grandTotal + roundUp(orderDateCustDtl.get(i).getGrandTotal());

				srno = srno + 1;

				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);

			}

			expoExcel = new ExportToExcel();
			rowData = new ArrayList<String>();
	
			rowData.add("");		
			rowData.add("Total");
			rowData.add("");
			rowData.add("" + Long.toString((long) (grandTotal)));
			rowData.add("");
			rowData.add("");
			rowData.add("");
			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);

			HttpSession session = request.getSession();
			session.setAttribute("exportExcelListDummy", exportToExcelList);
			session.setAttribute("excelNameNew", "OrderDateWiseCustBillReport");
			session.setAttribute("reportNameNew", "Order Date Customer Bill Detail Report");
			session.setAttribute("searchByNew", "From Date: " + fromDate + "  To Date: " + toDate + " ");
			session.setAttribute("mergeUpto1", "$A$1:$L$1");
			session.setAttribute("mergeUpto2", "$A$2:$L$2");

			session.setAttribute("exportExcelList", exportToExcelList);
			session.setAttribute("excelName", "OrderDateWiseCustBillReport");

			return orderDateCustDtl;
		}
		
		
//		@RequestMapping(value = "pdf/getDateWiseDtlPdf", method = RequestMethod.GET)
//		public ModelAndView getDateWiseDtlPdf(HttpServletRequest request,
//				HttpServletResponse response) {
//			ModelAndView model = null;
//			
//			try {
//				model = new ModelAndView("/reports/reportPdf/orderDateCustDtlPdf");
//				model.addObject("order", orderDateCustDtl);
//				
//				System.out.println("orderDateCustDtl>>>>"+orderDateCustDtl);
//			}catch (Exception e) {
//				// TODO: handle exception
//			}
//			return model;
//		}
	/*---------------------------------------------------------------------------------------------*/
	
		@RequestMapping(value = "/monthWiseOrderReport", method = RequestMethod.GET)
		public ModelAndView monthWiseOrderReport(HttpServletRequest request, HttpServletResponse response) {

			ModelAndView model = null;
			HttpSession session = request.getSession();

			model = new ModelAndView("reports/monthWiseOrderReport");

			try {
				SimpleDateFormat sdf = new SimpleDateFormat("MM-yyyy");

				Calendar cal = Calendar.getInstance();
				String toDate = sdf.format(cal.getTimeInMillis());

				cal.set(Calendar.DAY_OF_MONTH, 1);
				String fromDate = sdf.format(cal.getTimeInMillis());

				model.addObject("frommonth",fromDate);
				model.addObject("tomonth", toDate);
				
				Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");
				model.addObject("frId", frDetails.getFrId());				

			} catch (Exception e) {

				System.out.println("Exc in /showCustWiseReportBetDate  " + e.getMessage());
				e.printStackTrace();
			}

			return model;
		}
		
		 List<GetDateWiseBillReport> monthlyBillRep = new ArrayList<GetDateWiseBillReport>();
			@RequestMapping(value = "/getMonthlyBillsReport", method = RequestMethod.GET)
			public @ResponseBody List<GetDateWiseBillReport> getMonthlyBillsReport(HttpServletRequest request,
					HttpServletResponse response) {
				String fromDate = "";
				String toDate = "";
				HttpSession ses = request.getSession();
				Franchisee frDetails = (Franchisee) ses.getAttribute("frDetails");

				try {
					System.err.println("In Here");
					MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();

					int frId = frDetails.getFrId();
					int compId = frDetails.getCompanyId();

					fromDate = request.getParameter("fromDate");
					toDate = request.getParameter("toDate");
					
					String[] dateStr = toDate.split("-");
					String endDate = DateConvertor.getLastDayOfMonth(Integer.parseInt(dateStr[1]),
							Integer.parseInt(dateStr[0]));					

					map.add("fromDate", DateConvertor.convertToYMD("01-"+fromDate));
					map.add("toDate", endDate);				
					map.add("frId", frId);

					GetDateWiseBillReport[] orderRepArr = Constant.getRestTemplate()
							.postForObject(Constant.URL + "/getDateWiseBillsReport", map, GetDateWiseBillReport[].class);

					monthlyBillRep = new ArrayList<GetDateWiseBillReport>(Arrays.asList(orderRepArr));
					
				} catch (

				Exception e) {
					System.out.println("Excep in /getDateWiseillsReport " + e.getMessage());
					e.printStackTrace();

				}

				// exportToExcel

				List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

				ExportToExcel expoExcel = new ExportToExcel();
				List<String> rowData = new ArrayList<String>();

				rowData.add("Sr No");
				rowData.add("Month");
				rowData.add("Year");
				rowData.add("No. Of Bills");
				rowData.add("Total Amt.");
				rowData.add("COD");
				rowData.add("Cash");
				rowData.add("Card");
				float grandTotal = 0.0f;

				expoExcel.setRowData(rowData);
				int srno = 1;
				exportToExcelList.add(expoExcel);
				for (int i = 0; i < monthlyBillRep.size(); i++) {
					expoExcel = new ExportToExcel();
					rowData = new ArrayList<String>();

					rowData.add(" " + srno);
					rowData.add(monthlyBillRep.get(i).getMonthName());
					rowData.add(monthlyBillRep.get(i).getOrderYear());
					rowData.add(" " + monthlyBillRep.get(i).getTotalBills());
					rowData.add(" " + roundUp(monthlyBillRep.get(i).getTotalAmt()));	
					rowData.add(" " + monthlyBillRep.get(i).getCod());	
					rowData.add(" " + monthlyBillRep.get(i).getCard());	
					rowData.add(" " + monthlyBillRep.get(i).getEpay());	
					grandTotal = grandTotal + roundUp(monthlyBillRep.get(i).getTotalAmt());

					srno = srno + 1;

					expoExcel.setRowData(rowData);
					exportToExcelList.add(expoExcel);

				}

				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();
		
				rowData.add("");		
				rowData.add("Total");
				rowData.add("");
				rowData.add("" + Long.toString((long) (grandTotal)));
				rowData.add("");
				rowData.add("");
				rowData.add("");
				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);

				HttpSession session = request.getSession();
				session.setAttribute("exportExcelListNew", exportToExcelList);
				session.setAttribute("excelNameNew", "MonthWiseBillReport");
				session.setAttribute("reportNameNew", "Month Wiser Bill Report");
				session.setAttribute("searchByNew", "From Date: " + fromDate + "  To Date: " + toDate + " ");
				session.setAttribute("mergeUpto1", "$A$1:$L$1");
				session.setAttribute("mergeUpto2", "$A$2:$L$2");

				session.setAttribute("exportExcelList", exportToExcelList);
				session.setAttribute("excelName", "MonthWiseBillReport");

				return monthlyBillRep;
			}
			
			@RequestMapping(value = "pdf/getMonthWiseBillPdf/{fromDate}/{toDate}/{frId}", method = RequestMethod.GET)
			public ModelAndView getMonthWiseBillPdf(@PathVariable("fromDate") String fromDate,
					@PathVariable("toDate") String toDate, @PathVariable("frId") int frId, HttpServletRequest request,
					HttpServletResponse response) {
				ModelAndView model = null;
				
				try {
					model = new ModelAndView("/reports/reportPdf/monthlyBillPdf");

					MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();

					String[] dateStr = toDate.split("-");
					String endDate = DateConvertor.getLastDayOfMonth(Integer.parseInt(dateStr[1]),
							Integer.parseInt(dateStr[0]));	
					
					map.add("fromDate", DateConvertor.convertToYMD("01-"+fromDate));
					map.add("toDate", endDate);
					map.add("frId", frId);

					GetDateWiseBillReport[] orderRepArr = Constant.getRestTemplate()
							.postForObject(Constant.URL + "/getDateWiseBillsReport", map, GetDateWiseBillReport[].class);

					List<GetDateWiseBillReport> monthBillRep = new ArrayList<GetDateWiseBillReport>(Arrays.asList(orderRepArr));

					model.addObject("dateBillRep", monthBillRep);
				} catch (

				Exception e) {
					System.out.println("Excep in /getDateWiseBillPdf " + e.getMessage());
					e.printStackTrace();
				}
				return model;
			}
			

}
