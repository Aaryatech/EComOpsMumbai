package com.monginis.ops.controller;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.time.Year;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.monginis.ops.billing.SellBillDetail;
import com.monginis.ops.billing.SellBillHeader;
import com.monginis.ops.common.DateConvertor;
import com.monginis.ops.constant.Constant;
import com.monginis.ops.model.FrEmpMaster;
import com.monginis.ops.model.FrSetting;
import com.monginis.ops.model.Franchisee;
import com.monginis.ops.model.GetDeliveryBoyOrAgentData;
import com.monginis.ops.model.GetOrderDetailDisplay;
import com.monginis.ops.model.GetOrderHeaderDisplay;
import com.monginis.ops.model.Info;
import com.monginis.ops.model.SellBillDataForPrint;
import com.monginis.ops.model.Status;
import com.monginis.ops.model.TransactionDetail;

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
			
			mav.addObject("imagePath", Constant.PROD_IMG_VIEW_URL);

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
			System.out.println("ID ------"+statusId);
			String statusStr = "";

			
			if (statusId != null) {
				try {
				statusStr = statusId.toString().substring(1, statusId.toString().length() - 1);
				statusStr = statusStr.replaceAll("\"", "");
				statusStr = statusStr.replaceAll(" ", "");
				}catch (Exception e) {
					statusStr = statusId;
				}
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
	
	// -------------ACCEPT AND PROCESS ORDER------------------------
		@RequestMapping(value = "/acceptAndProcessOrder", method = RequestMethod.POST)
		@ResponseBody
		public Info acceptAndProcessOrder(HttpServletRequest request, HttpServletResponse responsel) {

			Info info = new Info();
			HttpSession session = request.getSession();
			FrEmpMaster frEmpDetails = (FrEmpMaster) session.getAttribute("frEmpDetails");
			try {

				int orderId = Integer.parseInt(request.getParameter("orderId"));
				int status = Integer.parseInt(request.getParameter("status"));
				String remark = request.getParameter("remark");

				if (orderId > 0) {
					ObjectMapper mapper = new ObjectMapper();
					
					System.err.println("ORDER = " + orderId);

					MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
					map.add("orderId", orderId);
					map.add("status", status);
					map.add("userId", frEmpDetails.getFrEmpId());
					map.add("type", 2);
					map.add("remark", remark);

					info = Constant.getRestTemplate().postForObject(Constant.URL + "/acceptAndProcessOrderOPS", map,
							Info.class);
					System.err.println("INFO = " + info);
				}

			} catch (Exception e) {
				e.printStackTrace();
				info.setError(true);
				info.setMessage("failed");
			}
			return info;
		}
		// -------------ACCEPT ORDER------------------------
		@RequestMapping(value = "/changeOrderStatus", method = RequestMethod.POST)
		@ResponseBody
		public Info changeOrderStatus(HttpServletRequest request, HttpServletResponse responsel) {

			Info info = new Info();
			HttpSession session = request.getSession();
			FrEmpMaster frEmpDetails = (FrEmpMaster) session.getAttribute("frEmpDetails");
			try {

				int orderId = Integer.parseInt(request.getParameter("orderId"));
				int status = Integer.parseInt(request.getParameter("status"));
				String remark = request.getParameter("remark");

				if (orderId > 0) {					
					System.err.println("ORDER = " + orderId);

					MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
					map.add("orderId", orderId);
					map.add("status", status);
					map.add("userId", frEmpDetails.getFrEmpId());
					map.add("type", 2);
					map.add("remark", remark);

					// info = restTemplate.postForObject(Constant.URL + "/updateOrderHeaderStatus",
					// map, Info.class);
					info = Constant.getRestTemplate().postForObject(Constant.URL + "/changeStatusByOrderId", map,
							Info.class);

					System.err.println("INFO = " + info);
				}

			} catch (Exception e) {
				e.printStackTrace();
				info.setError(true);
				info.setMessage("failed");
			}
			return info;
		}
		@RequestMapping(value = "/getDeliveryBoyList", method = RequestMethod.GET)
		public @ResponseBody List<GetDeliveryBoyOrAgentData> getDeliveryBoyOrAgentData(HttpServletRequest request,
				HttpServletResponse response) {

			List<GetDeliveryBoyOrAgentData> deliveryBoyAndAgentList = new ArrayList<>();

			int frId = Integer.parseInt(request.getParameter("frId"));
			

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("frId", frId);

			deliveryBoyAndAgentList = new ArrayList<>();

			GetDeliveryBoyOrAgentData[] empArr = Constant.getRestTemplate().postForObject(
					Constant.URL + "/getDelBoyAndAgentListByFrAndCity", map, GetDeliveryBoyOrAgentData[].class);
			deliveryBoyAndAgentList = new ArrayList<GetDeliveryBoyOrAgentData>(Arrays.asList(empArr));

			return deliveryBoyAndAgentList;
		}
		
		// -------------PROCESS ORDER------------------------
		@RequestMapping(value = "/generateBillForOrder", method = RequestMethod.POST)
		@ResponseBody
		public Info generateBillForOrder(HttpServletRequest request, HttpServletResponse responsel) {

			Info info = new Info();
			HttpSession session = request.getSession();
			FrEmpMaster frEmpDetails = (FrEmpMaster) session.getAttribute("frEmpDetails");
			Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");

			try {
				System.out.println("Order List generateBillForOrder--->"+orderList);				
				int deliveryBoyId = Integer.parseInt(request.getParameter("delBoyId"));

				if (orderList != null) {
					int orderId = Integer.parseInt(request.getParameter("orderId"));
					ObjectMapper mapper = new ObjectMapper();
					GetOrderHeaderDisplay order = new GetOrderHeaderDisplay();
					for (int i = 0; i < orderList.size(); i++) {
						
						if(orderList.get(i).getOrderId()==orderId) {
							order = orderList.get(i);
						}
					}
					System.err.println("ORDER Found= " + order);

					List<SellBillDetail> sellbilldetaillist = new ArrayList<>();

					if (order.getOrderDetailList() != null) {

						for (GetOrderDetailDisplay detail : order.getOrderDetailList()) {

							SellBillDetail sellBillDetail = new SellBillDetail();

							sellBillDetail.setCatId(detail.getCatId());
							sellBillDetail.setSgstPer(detail.getSgstPer());
							sellBillDetail.setCgstPer(detail.getCgstPer());
							sellBillDetail.setIgstPer(detail.getIgstPer());
							sellBillDetail.setDelStatus(1);
							sellBillDetail.setItemId(detail.getItemId());
							sellBillDetail.setMrp(detail.getMrp());

							float mrpBaseRate = (detail.getMrp() * 100)
									/ (100 + (detail.getSgstPer() + detail.getCgstPer()));
							sellBillDetail.setMrpBaseRate(mrpBaseRate);

							// -----------------------------------------

							float detailDiscPer = 0;
							float detailDiscAmt = 0;

							if (detail.getDiscAmt() > 0) {
								detailDiscPer = ((detail.getTotalAmt() * 100) / order.getTotalAmt());
								detailDiscAmt = ((detailDiscPer * detail.getDiscAmt()) / 100);
							}

							float detailGrandTotal = roundUp(detail.getTotalAmt() - detailDiscAmt);

							float baseRate = ((detailGrandTotal * 100)
									/ (100 + (detail.getSgstPer() + detail.getCgstPer())));
							float totalTaxedAmt = roundUp(baseRate * ((detail.getSgstPer() + detail.getCgstPer()) / 100));

							float detailSgstRs = totalTaxedAmt / 2;
							float detailCgstRs = totalTaxedAmt / 2;
							float detailIgstRs = totalTaxedAmt;

							detailSgstRs = roundUp(detailSgstRs);
							detailCgstRs = roundUp(detailCgstRs);
							detailIgstRs = roundUp(detailIgstRs);

							float detailTotalTax = detailSgstRs + detailCgstRs;
							detailTotalTax = roundUp(detailTotalTax);

							float detailTaxableAmt = detailGrandTotal - detailTotalTax;
							detailTaxableAmt = roundUp(detailTaxableAmt);

							System.err.println("TAXABLE AMT = " + detailTaxableAmt);
							System.err.println("-------------------------------------------------------- - ");

							sellBillDetail.setSgstRs(detail.getSgstAmt());
							sellBillDetail.setCgstRs(detail.getCgstAmt());
							sellBillDetail.setIgstRs(detail.getIgstAmt());

							//sellBillDetail.setQty(detail.getQty());
							sellBillDetail.setQty(detail.getExFloat3());
							sellBillDetail.setSellBillDetailNo(0);
							sellBillDetail.setSellBillNo(0);
							sellBillDetail.setBillStockType(1);
							sellBillDetail.setTaxableAmt(detailTaxableAmt);// itemBillList.get(i).getTaxableAmt());
							sellBillDetail.setTotalTax(detailTotalTax);// itemBillList.get(i).getTaxAmt());
							sellBillDetail.setGrandTotal(detailGrandTotal);// 'itemBillList.get(i).getTotal());
							sellBillDetail.setItemName(detail.getItemName());
							sellBillDetail.setDiscAmt(detailDiscAmt);
							sellBillDetail.setDiscPer(detailDiscPer);
							sellBillDetail.setExtFloat1(detail.getTotalAmt());

							sellBillDetail.setExtVar1(detail.getHsnCode());

							sellbilldetaillist.add(sellBillDetail);

						}

					}

					// --------------HEADER-----------------

					SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
					SimpleDateFormat sf1 = new SimpleDateFormat("dd-MM-yyyy");
					Date date = new Date();

					SellBillHeader sellBillHeader = new SellBillHeader();

					sellBillHeader.setExtInt2(order.getOrderId());
					sellBillHeader.setIsDairyMartBill(order.getExInt1()); //Company Id
					sellBillHeader.setFrId(frDetails.getFrId());
					sellBillHeader.setFrCode(frDetails.getFrCode());
					sellBillHeader.setDelStatus(1);
					sellBillHeader.setUserName(order.getCustName());

					MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
					map = new LinkedMultiValueMap<String, Object>();
					map.add("frId", frDetails.getFrId());
//					PettyCashManagmt petty = restTemplate.postForObject(Constant.URL + "/getPettyCashDetails", map,
//							PettyCashManagmt.class);
//
//					String billDate = sf.format(date);
//					if (petty != null) {
//
//						SimpleDateFormat ymdSDF = new SimpleDateFormat("yyyy-MM-dd");
//
//						Calendar cal = Calendar.getInstance();
//						cal.setTimeInMillis(Long.parseLong(petty.getDate()));
//						cal.add(Calendar.DAY_OF_MONTH, 1);
//
//						billDate = ymdSDF.format(cal.getTime());
//					}
					String billDate = sf.format(date);
					sellBillHeader.setBillDate(billDate);

					sellBillHeader.setCustId(order.getCustId());

					String invoiceNo = getInvoiceNo(request, responsel);
					sellBillHeader.setInvoiceNo(invoiceNo);

					sellBillHeader.setSellBillNo(0);
					sellBillHeader.setUserGstNo(order.getCustomerGstnNo());
					sellBillHeader.setUserPhone(order.getWhatsappNo());
					sellBillHeader.setBillType('R');
					sellBillHeader.setTaxableAmt(order.getTaxableAmt());
					sellBillHeader.setPayableAmt(Math.round(order.getTotalAmt()));
					sellBillHeader.setTotalTax(order.getTaxAmt());
					sellBillHeader.setGrandTotal(Math.round(order.getTotalAmt()-order.getDeliveryCharges()));

					// billType=1 => CASH
					// billType=2 => CARD
					// billType=3 => EPAY
					sellBillHeader.setPaymentMode(order.getPaymentMethod());

//					if (discPer != 0) {
//						sellBillHeader.setDiscountPer(discPer);//
//					} else {
//						sellBillHeader.setDiscountPer(discAmt / (billAmtWtDisc / 100));//
//					}

					sellBillHeader.setDiscountAmt(order.getDiscAmt());//

					sellBillHeader.setStatus(2);
					sellBillHeader.setRemainingAmt(0);
					// sellBillHeader.setPaymentMode(paymentMode);
					sellBillHeader.setPaidAmt(Math.round(order.getTotalAmt()));

					sellBillHeader.setExtInt1(frEmpDetails.getFrEmpId());

					float roundOff = 0;
					roundOff = order.getTaxableAmt() + order.getTaxAmt() - Math.round(order.getTotalAmt()-order.getDeliveryCharges());
					sellBillHeader.setExtFloat1(roundOff);
					sellBillHeader.setExtFloat2(order.getDeliveryCharges());
					sellBillHeader.setExtFloat3(order.getExFloat1());

					System.err.println("ROUND OFF = " + roundOff);

					sellBillHeader.setSellBillDetailsList(sellbilldetaillist);

					SellBillHeader sellBillHeaderRes1 = Constant.getRestTemplate().postForObject(Constant.URL + "insertSellBillData",
							sellBillHeader, SellBillHeader.class);

					// -----------SAVE TRANSACTION---------------

					if (sellBillHeaderRes1 != null) {

						info.setError(false);
						info.setMessage("" + sellBillHeaderRes1.getSellBillNo());

						List<TransactionDetail> dList = new ArrayList<>();

						TransactionDetail transactionDetail = new TransactionDetail();
						transactionDetail.setSellBillNo(sellBillHeaderRes1.getSellBillNo());
						// transactionDetail.setTransactionDate(sf1.format(date));

						Date dt = sf.parse(billDate);

						transactionDetail.setTransactionDate(sf1.format(dt));
						transactionDetail.setExInt1(frEmpDetails.getFrEmpId());
						transactionDetail.setePayType(0);
						transactionDetail.setDelStatus(1);

						transactionDetail.setPayMode(1);// 1=single,2=split

						int payType = order.getPaymentMethod();

						if (order.getPaymentMethod() == 1) {
							transactionDetail.setCashAmt(Math.round(order.getTotalAmt()));
							transactionDetail.setExVar1("0," + payType);
						} else if (order.getPaymentMethod() == 2) {
							transactionDetail.setCardAmt(Math.round(order.getTotalAmt()));
							transactionDetail.setExVar1("0," + payType);
						} else if (order.getPaymentMethod() == 3) {
							transactionDetail.setePayAmt(Math.round(order.getTotalAmt()));
							transactionDetail.setExVar1("0," + payType);
						}

						transactionDetail.setRemark("");

						dList.add(transactionDetail);

						TransactionDetail[] transactionDetailRes = Constant.getRestTemplate()
								.postForObject(Constant.URL + "saveTransactionDetail", dList, TransactionDetail[].class);

						map = new LinkedMultiValueMap<>();
						map.add("orderId", order.getOrderId());
						map.add("status", 4);
						map.add("userId", frEmpDetails.getFrEmpId());
						map.add("type", 4);
						map.add("remark", "");

						Info info1 = Constant.getRestTemplate().postForObject(Constant.URL + "/changeStatusByOrderId",
								map, Info.class);
						System.err.println("INFO updateOrderHeaderStatus = " + info1);

						map = new LinkedMultiValueMap<>();
						map.add("orderId", order.getOrderId());
						map.add("delBoyId", deliveryBoyId);

						Info info2 = Constant.getRestTemplate().postForObject(Constant.URL + "/updateDeliveryBoy", map,
								Info.class);
						System.err.println("INFO updateDeliveryBoy = " + info2);

					}

				}

			} catch (Exception e) {
				e.printStackTrace();
				info.setError(true);
				info.setMessage("failed");
			}
			return info;
		}
		
		@RequestMapping(value = "/printGSTBill/{orderId}", method = RequestMethod.GET)
		public String printGSTBill(@PathVariable int orderId, HttpServletRequest request, HttpServletResponse response,
				Model model) {

			String mav = "billPdf/printBillOfInvoice_Order";

			try {

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				map.add("orderId", orderId);

				System.err.println("Order Id - " + orderId);

				SellBillDataForPrint res = Constant.getRestTemplate().postForObject(Constant.URL + "getSellBillForPrintByOrderId", map,
						SellBillDataForPrint.class);
				System.err.println("ORDER ------- "+res);

				HttpSession session = request.getSession();
				Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");
				model.addAttribute("frName", frDetails.getFrName());

				model.addAttribute("sellBillHeaderAndDetail", res);
				model.addAttribute("frDetails", frDetails);
				// model.addAttribute("frEmpMaster", frEmpMaster);
				try {
					map = new LinkedMultiValueMap<String, Object>();
					map.add("empId", res.getExtInt1());

					FrEmpMaster frEmpMaster = Constant.getRestTemplate().postForObject(Constant.URL + "/getFrEmpByEmpId", map,
							FrEmpMaster.class);
					model.addAttribute("frEmpMaster", frEmpMaster);
				} catch (Exception e) {
					FrEmpMaster frEmpMaster = new FrEmpMaster();
					frEmpMaster.setFrEmpName("-");
					model.addAttribute("frEmpMaster", frEmpMaster);
				}
				map = new LinkedMultiValueMap<String, Object>();
				map.add("frId", frDetails.getFrId());

//				try {
//					FranchiseSup frSup = restTemplate.postForObject(Constant.URL + "/getFrSupByFrId", map,
//							FranchiseSup.class);
//					model.addAttribute("frSup", frSup);
//				} catch (Exception e) {
//
//				}

				StringBuilder payMode = new StringBuilder();

				try {
					map = new LinkedMultiValueMap<String, Object>();
					map.add("sellBillNo", res.getSellBillNo());
					TransactionDetail trDetail = Constant.getRestTemplate().postForObject(Constant.URL + "/getTransactionByBillId", map,
							TransactionDetail.class);
					System.err.println("TR DETAIL - " + trDetail);

					if (trDetail != null) {
						List<Integer> mode = Stream.of(trDetail.getExVar1().split(",")).map(Integer::parseInt)
								.collect(Collectors.toList());

						System.err.println("ARRAY - " + mode);

						if (mode.contains(1)) {
							payMode.append("Cash");
							payMode.append(",");
						}
						if (mode.contains(2)) {
							payMode.append("Card");
							payMode.append(",");
						}
						if (mode.contains(3)) {
							payMode.append("E-Pay");
							payMode.append(",");
						}
						if (mode.contains(4)) {
							payMode.append("Debit Card");
							payMode.append(",");
						}
						if (mode.contains(5)) {
							payMode.append("Credit Card");
							payMode.append(",");
						}
						if (mode.contains(6)) {
							payMode.append("Bank Transcation");
							payMode.append(",");
						}
						if (mode.contains(7)) {
							payMode.append("Paytm");
							payMode.append(",");
						}
						if (mode.contains(8)) {
							payMode.append("Google Pay");
							payMode.append(",");
						}
						if (mode.contains(9)) {
							payMode.append("Amazon Pay");
							payMode.append(",");
						}

						System.err.println("MODE - " + payMode);

					}

				} catch (Exception e) {
					e.printStackTrace();
				}

				if (payMode.length() > 0) {
					model.addAttribute("paymentMode", payMode.substring(0, payMode.length() - 1));
				} else {
					model.addAttribute("paymentMode", payMode);
				}

			} catch (Exception e) {
				e.printStackTrace();
			}
			return mav;
		}
		
		
		public static float roundUp(float d) {
			return BigDecimal.valueOf(d).setScale(2, BigDecimal.ROUND_HALF_UP).floatValue();
		}
		
		public static String getInvoiceNo(HttpServletRequest request, HttpServletResponse response) {

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			
			HttpSession session = request.getSession();

			Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");

			int frId = frDetails.getFrId();

			// String frCode = frDetails.getFrCode();

			map.add("frId", frId);
			FrSetting frSetting = Constant.getRestTemplate().postForObject(Constant.URL + "getFrSettingValue", map, FrSetting.class);

			int billNo = frSetting.getSellBillNo();

			int settingValue = billNo;

			System.out.println("Setting Value Received " + settingValue);
			int year = Year.now().getValue();
			String curStrYear = String.valueOf(year);
			curStrYear = curStrYear.substring(2);

			int preMarchYear = Year.now().getValue() - 1;
			String preMarchStrYear = String.valueOf(preMarchYear);
			preMarchStrYear = preMarchStrYear.substring(2);

			System.out.println("Pre MArch year ===" + preMarchStrYear);

			int nextYear = Year.now().getValue() + 1;
			String nextStrYear = String.valueOf(nextYear);
			nextStrYear = nextStrYear.substring(2);

			System.out.println("Next  year ===" + nextStrYear);

			int postAprilYear = nextYear + 1;
			String postAprilStrYear = String.valueOf(postAprilYear);
			postAprilStrYear = postAprilStrYear.substring(2);

			System.out.println("Post April   year ===" + postAprilStrYear);

			java.util.Date date = new Date();
			Calendar cale = Calendar.getInstance();
			cale.setTime(date);
			int month = cale.get(Calendar.MONTH);

			month = month + 1;

			if (month <= 3) {

				curStrYear = preMarchStrYear + curStrYear;
				System.out.println("Month <= 3::Cur Str Year " + curStrYear);
			} else if (month >= 4) {

				curStrYear = curStrYear + nextStrYear;
				System.out.println("Month >=4::Cur Str Year " + curStrYear);
			}

			////

			// int length = String.valueOf(settingValue).length();

			String invoiceNo = frDetails.getFrCode() + curStrYear + "-" + String.format("%05d", settingValue);

			// String invoiceNo = null;
			/*
			 * if (length == 1)
			 * 
			 * invoiceNo = curStrYear + "-" + "0000" + settingValue; if (length == 2)
			 * 
			 * invoiceNo = curStrYear + "-" + "000" + settingValue;
			 * 
			 * if (length == 3)
			 * 
			 * invoiceNo = curStrYear + "-" + "00" + settingValue;
			 * 
			 * if (length == 4)
			 * 
			 * invoiceNo = curStrYear + "-" + "0" + settingValue;
			 */

			// invoiceNo = frDetails.getFrCode() + invoiceNo;
			System.out.println("*** settingValue= " + settingValue);
			return invoiceNo;

		}
}
