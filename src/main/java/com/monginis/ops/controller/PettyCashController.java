package com.monginis.ops.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLConnection;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Font.FontFamily;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.monginis.ops.HomeController;
import com.monginis.ops.billing.SellBillHeader;
import com.monginis.ops.common.DateConvertor;
import com.monginis.ops.constant.Constant;
import com.monginis.ops.model.FrEmpLoginResp;
import com.monginis.ops.model.FrEmpMaster;
import com.monginis.ops.model.Info;

@Controller
public class PettyCashController {

	@RequestMapping(value = "/saveFranchiseeEmp", method = RequestMethod.POST)
	public @ResponseBody FrEmpMaster saveFranchiseeEmp(HttpServletRequest req, HttpServletResponse resp,
			HttpSession session) {
		FrEmpMaster saveEmp = new FrEmpMaster();
		try {
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date date = new Date();

			session = req.getSession();
			int frid = (int) session.getAttribute("frId");

			FrEmpMaster emp = new FrEmpMaster();
			int frEmpId = Integer.parseInt(req.getParameter("fr_emp_id"));
			System.out.println("EmpId=" + frEmpId);

			emp.setFrEmpId(frEmpId);
			emp.setCurrentBillAmt(Float.parseFloat(req.getParameter("curr_bill_amt")));
			emp.setDelStatus(Integer.parseInt(req.getParameter("emp_status")));
			emp.setDesignation(Integer.parseInt(req.getParameter("designation")));
			emp.setEmpCode(req.getParameter("emp_code"));
			emp.setExInt1(0);
			emp.setExInt2(0);
			emp.setExInt3(0);
			emp.setExVar1(req.getParameter("vehicle_no"));
			emp.setExVar2(req.getParameter("lic_exp_date"));
			emp.setExVar3("NA");
			emp.setFrEmpAddress(req.getParameter("emp_address"));
			emp.setFrEmpContact(req.getParameter("emp_contact"));
			System.out.println("Join Date----"+req.getParameter("join_date"));
			emp.setFrEmpJoiningDate(req.getParameter("join_date"));
			emp.setFrEmpName(req.getParameter("emp_name"));
			emp.setFrId(frid);

			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
			
			String frDate = req.getParameter("from_date");
			String tDate = req.getParameter("to_date");
			
			System.err.println("FDATE ------------------------------ "+frDate);
			System.err.println("TDATE ------------------------------ "+tDate);
			
			if (frDate == null || frDate.isEmpty()) {
					frDate=sdf.format(Calendar.getInstance().getTimeInMillis());
			}

			if (tDate == null || tDate.isEmpty()) {
				tDate=sdf.format(Calendar.getInstance().getTimeInMillis());
			}
			
			System.err.println("FDATE ------------------------------ "+frDate);
			System.err.println("TDATE ------------------------------ "+tDate);

			emp.setFromDate(frDate);
			emp.setToDate(tDate);
			emp.setIsActive(0);
			emp.setPassword(req.getParameter("pass"));
			emp.setTotalLimit(Float.parseFloat(req.getParameter("ttl_limit")));
			emp.setUpdateDatetime(dateFormat.format(date));

			saveEmp = Constant.getRestTemplate().postForObject(Constant.URL + "/saveFrEmpDetails", emp, FrEmpMaster.class);
			System.out.println("Result-----------" + saveEmp);

			if (saveEmp != null) {

			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return saveEmp;

	}

	@RequestMapping(value = "/getAllFrEmp", method = RequestMethod.GET)
	public @ResponseBody List<FrEmpMaster> getAllFrEmp(HttpServletRequest req, HttpServletResponse resp,
			HttpSession session) {
		List<FrEmpMaster> empList = null;
		try {
			session = req.getSession();
			int frid = (int) session.getAttribute("frId");

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			map.add("frId", frid);
			FrEmpMaster[] empArr = Constant.getRestTemplate().postForObject(Constant.URL + "/getAllFrEmp", map, FrEmpMaster[].class);
			empList = new ArrayList<FrEmpMaster>(Arrays.asList(empArr));

			System.out.println("Emp List----------" + empList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return empList;

	}

	@RequestMapping(value = "/getFrEmpById", method = RequestMethod.GET)
	public @ResponseBody FrEmpMaster getFrEmpById(HttpServletRequest req, HttpServletResponse resp,
			HttpSession session) {
		FrEmpMaster emp = new FrEmpMaster();
		try {

			int empId = Integer.parseInt(req.getParameter("empId"));
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("empId", empId);

			emp = Constant.getRestTemplate().postForObject(Constant.URL + "/getFrEmpByEmpId", map, FrEmpMaster.class);
			emp.setExVar1(DateConvertor.convertToYMD(emp.getFrEmpJoiningDate()));
			emp.setExVar2(DateConvertor.convertToYMD(emp.getFromDate()));
			emp.setExVar3(DateConvertor.convertToYMD(emp.getToDate()));

		} catch (Exception e) {
			e.printStackTrace();
		}
		return emp;
	}
	
	@RequestMapping(value = "/getFrEditEmpById", method = RequestMethod.GET)
	public @ResponseBody FrEmpMaster getFrEditEmpById(HttpServletRequest req, HttpServletResponse resp,
			HttpSession session) {
		FrEmpMaster emp = new FrEmpMaster();
		try {
			
				SimpleDateFormat DateFor = new SimpleDateFormat("dd/MM/yyyy");
				String stringDate = null;
				
				int empId = Integer.parseInt(req.getParameter("empId"));
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("empId", empId);
	
				emp = Constant.getRestTemplate().postForObject(Constant.URL + "/getFrEmpByEmpId", map, FrEmpMaster.class);
				emp.setFrEmpJoiningDate(DateConvertor.convertToYMD(emp.getFrEmpJoiningDate()));
				try {
					stringDate= DateFor.format(emp.getExVar2());
				}catch (Exception e) {
					e.printStackTrace();
					stringDate= DateFor.format(emp.getExVar2());
				}
				 
				emp.setExVar2(stringDate);	
		} catch (Exception e) {
			e.printStackTrace();
		}
		return emp;
	}

	@RequestMapping(value = "/delFrEmpById", method = RequestMethod.GET)
	public @ResponseBody List<FrEmpMaster> delFrEmpById(HttpServletRequest req, HttpServletResponse resp,
			HttpSession session) {
		List<FrEmpMaster> empList = null;
		MultiValueMap<String, Object> map = null;
		try {
			session = req.getSession();
			int frid = (int) session.getAttribute("frId");

			int empId = Integer.parseInt(req.getParameter("empId"));
			map = new LinkedMultiValueMap<String, Object>();
			map.add("empId", empId);

			Info info = Constant.getRestTemplate().postForObject(Constant.URL + "/delFrEmp", map, Info.class);
			if (info.isError()) {
				map = new LinkedMultiValueMap<String, Object>();
				map.add("frId", frid);
				FrEmpMaster[] empArr = Constant.getRestTemplate().postForObject(Constant.URL + "/getAllFrEmpByFrid", map,
						FrEmpMaster[].class);
				empList = new ArrayList<FrEmpMaster>(Arrays.asList(empArr));

				System.out.println("Emp ListResFail----------" + empList);

			} else {
				map = new LinkedMultiValueMap<String, Object>();
				map.add("frId", frid);
				FrEmpMaster[] empArr = Constant.getRestTemplate().postForObject(Constant.URL + "/getAllFrEmpByFrid", map,
						FrEmpMaster[].class);
				empList = new ArrayList<FrEmpMaster>(Arrays.asList(empArr));

				System.out.println("Emp ListRes Sucess----------" + empList);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return empList;
	}

	@RequestMapping(value = "/verifyUniqueContactNo", method = RequestMethod.GET)
	public @ResponseBody Info verifyUniqueContactNo(HttpServletRequest request, HttpServletResponse response) {
		Info info = new Info();
		try {
			HttpSession session = request.getSession();
			int frid = (int) session.getAttribute("frId"); 
			String mobNo = request.getParameter("mobNo");

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("mobNo", mobNo);
			map.add("frId", frid);

			info = Constant.getRestTemplate().postForObject(Constant.URL + "/checkUniqueContactNo", map, Info.class);
			System.out.println("Info Res----------------" + info);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return info;

	}
	
}
