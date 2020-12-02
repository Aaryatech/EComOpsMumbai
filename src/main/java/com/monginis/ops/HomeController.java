package com.monginis.ops;

import java.io.FileOutputStream;

import java.io.Serializable;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Locale;
import java.util.TimeZone;
import java.util.stream.Collectors;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import org.json.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.monginis.ops.common.Common;
import com.monginis.ops.common.DateConvertor;
import com.monginis.ops.constant.Constant;
import com.monginis.ops.model.City;
import com.monginis.ops.model.FrEmpLoginResp;
import com.monginis.ops.model.FrEmpMaster;
import com.monginis.ops.model.FrLoginResponse;
import com.monginis.ops.model.Franchisee;
import com.monginis.ops.model.GetDashPieStatusCnt;
import com.monginis.ops.model.Info;
import com.monginis.ops.model.Setting;
import com.monginis.ops.model.dash.CategorywiseSell;

import java.io.BufferedOutputStream;
import java.io.File;
import java.time.DayOfWeek;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	private static final String UPLOAD_DIRECTORY = "/icons";

	/**
	 * Simply selects the home view to render by returning its name.
	 */

	@RequestMapping(value = "/time", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);

		String StartTimes = "10:00";
		String EndTimes = "12:00";

		String startTimeParse[] = StartTimes.split(":");
		String endTimeParse[] = EndTimes.split(":");

		int firstHour = Integer.parseInt(startTimeParse[0]);
		int firstMinute = Integer.parseInt(startTimeParse[1]);
		int secondHour = Integer.parseInt(endTimeParse[0]);
		int secondMinute = Integer.parseInt(endTimeParse[1]);
		int durattionHour = secondHour - firstHour;
		int durattionMinutes = secondMinute - firstMinute;

		System.out.println("Duration : " + durattionHour + ":" + durattionMinutes);

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);

		String formattedDate = dateFormat.format(date);

		model.addAttribute("serverTime", formattedDate);

		return "homeold";
	}

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView displayLogin(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("login");
		// ModelAndView model = new ModelAndView("customerBill/newcustomerbill");

		logger.info("/login request mapping.");

		return model;

	}
	List<GetDashPieStatusCnt> dashDataList = new ArrayList<GetDashPieStatusCnt>();
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public ModelAndView displayHome(HttpServletRequest request, HttpServletResponse response, Locale locale)
			throws ParseException {

		ModelAndView model = new ModelAndView("home");
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		HttpSession session = request.getSession();
		Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");
		RestTemplate restTemplate = new RestTemplate();
		try {

			int frId = (Integer) session.getAttribute("frId");

			System.out.println("***************frId*****************" + frId);

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			map.add("frId", frId);
			

			model.addObject("url", Constant.MESSAGE_IMAGE_URL);

			logger.info("/login request mapping.");

			int type = 0;
			String fromDate = null;
			String toDate = null;
			String typeTitle = null;
			try {
				type = Integer.parseInt(request.getParameter("type"));
			} catch (Exception e) {
				type = 1;
			}
			System.err.println("type" + type);
			model.addObject("type", type);
			if (type == 4) {
				fromDate = DateConvertor.convertToYMD(request.getParameter("fromDate"));
				toDate = DateConvertor.convertToYMD(request.getParameter("toDate"));

				String fDate = request.getParameter("fromDate");
				String tDate = request.getParameter("toDate");

				model.addObject("fromDate", fDate);
				model.addObject("toDate", tDate);
				model.addObject("typeTitle", "");
				model.addObject("custmDates", "1");

			} else if (type == 1) {
				fromDate = sf.format(date);
				toDate = sf.format(date);
				model.addObject("typeTitle", "Today's");
				model.addObject("custmDates", "0");
			} else if (type == 2) {
				Calendar calendar = Calendar.getInstance();
				while (calendar.get(Calendar.DAY_OF_WEEK) != Calendar.MONDAY) {
					calendar.add(Calendar.DATE, -1);
				}
				Date d = calendar.getTime();
				fromDate = sf.format(d);

				System.err.println("d**" + fromDate);
				Calendar calendar2 = Calendar.getInstance();
				while (calendar2.get(Calendar.DAY_OF_WEEK) != Calendar.SUNDAY) {
					calendar2.add(Calendar.DATE, 1);
				}
				Date d2 = calendar2.getTime();
				toDate = sf.format(d2);				
				System.err.println("d1**" + toDate);
				model.addObject("typeTitle", "This Week");
				model.addObject("custmDates", "0");
			} else {

				Date begining, end;

				Calendar calendar = getCalendarForNow();
				calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMinimum(Calendar.DAY_OF_MONTH));
				setTimeToBeginningOfDay(calendar);
				begining = calendar.getTime();
				fromDate = sf.format(begining);
				System.err.println("begining" + fromDate);

				Calendar calendar1 = getCalendarForNow();
				calendar1.set(Calendar.DAY_OF_MONTH, calendar1.getActualMaximum(Calendar.DAY_OF_MONTH));
				setTimeToEndofDay(calendar1);
				end = calendar1.getTime();
				toDate = sf.format(end);
				System.err.println("end" + toDate);
				model.addObject("typeTitle", "This Month");
				model.addObject("custmDates", "0");
			}
			System.err.println(" Dates---------"+fromDate+" to "+toDate);
			
			map.add("frId", frDetails.getFrId());
			map.add("fromDate", fromDate);
			map.add("toDate", toDate);
			map.add("compId", frDetails.getCompanyId());
			
			GetDashPieStatusCnt[] dashDataArr = Constant.getRestTemplate()
					.postForObject(Constant.URL + "getAllStatusCountByFrId", map, GetDashPieStatusCnt[].class);
			dashDataList = new ArrayList<GetDashPieStatusCnt>(Arrays.asList(dashDataArr));
			System.out.println("Order Details------------>"+dashDataList);
			model.addObject("countDetails", dashDataList);
			
			model.addObject("divType", type);
			model.addObject("imagePath", Constant.FR_IMAGE_URL);
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;

	}

	@RequestMapping(value = "/homeMessages", method = RequestMethod.GET)
	public ModelAndView displayHomeMessages(HttpServletRequest request, HttpServletResponse response, Locale locale)
			throws ParseException {

		ModelAndView model = new ModelAndView("homeMessages");
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		HttpSession session = request.getSession();
		Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");
		RestTemplate restTemplate = new RestTemplate();
		
		return model;

	}

	
	@RequestMapping(value = "/setGetLeftView", method = RequestMethod.GET)
	@ResponseBody
	public String setGetLeftView(HttpServletRequest request, HttpServletResponse responsel) {

		String leftView = "block";
		HttpSession session = request.getSession();

		try {

			leftView = (String) session.getAttribute("eyeVal");
			// System.err.println("leftView"+leftView);
			if (leftView == "block") {
				session.setAttribute("eyeVal", "none");
				leftView = "none";
			} else {
				session.setAttribute("eyeVal", "block");
				leftView = "block";
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return leftView;
	}

	

	private static Calendar getCalendarForNow() {
		Calendar calendar = GregorianCalendar.getInstance();
		calendar.setTime(new Date());
		return calendar;
	}

	private static void setTimeToBeginningOfDay(Calendar calendar) {
		calendar.set(Calendar.HOUR_OF_DAY, 0);
		calendar.set(Calendar.MINUTE, 0);
		calendar.set(Calendar.SECOND, 0);
		calendar.set(Calendar.MILLISECOND, 0);
	}

	private static void setTimeToEndofDay(Calendar calendar) {
		calendar.set(Calendar.HOUR_OF_DAY, 23);
		calendar.set(Calendar.MINUTE, 59);
		calendar.set(Calendar.SECOND, 59);
		calendar.set(Calendar.MILLISECOND, 999);
	}

	private boolean checkBetween(Date dateToCheck, Date startDate, Date endDate) {
		return dateToCheck.compareTo(startDate) >= 0 && dateToCheck.compareTo(endDate) <= 0;

	}

	@RequestMapping(value = "/showforgotpassword", method = RequestMethod.GET)
	public ModelAndView displayForgotPassword(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("forgotpassword");

		logger.info("/forgot Password request mapping.");

		return model;

	}

	@RequestMapping(value = "savefile", method = RequestMethod.POST)
	public ModelAndView saveimage(@RequestParam CommonsMultipartFile file, HttpSession session) throws Exception {
		try {
			ServletContext context = session.getServletContext();
			String path = context.getRealPath(UPLOAD_DIRECTORY);
			String filename = file.getOriginalFilename();

			System.out.println(path + " " + filename);

			byte[] bytes = file.getBytes();
			BufferedOutputStream stream = new BufferedOutputStream(
					new FileOutputStream(new File(path + File.separator + filename)));
			stream.write(bytes);
			stream.flush();
			stream.close();

		} catch (Exception e) {
			System.out.println("File uplaod exception " + e.getMessage());
		}

		return new ModelAndView("uploadform", "filesuccess", "File successfully saved!");
	}

	@RequestMapping(value = "/loginProcess", method = RequestMethod.POST)
	public String displayHomePage(HttpSession ses, HttpServletRequest request, HttpServletResponse response)
			throws ParseException {

		logger.info("/loginProcess request mapping.");

		ModelAndView model = new ModelAndView("login");

		HttpSession session = request.getSession();

		String frCode = request.getParameter("username");
		String frPassword = request.getParameter("password");
		System.out.println("Credentials-------->" + frCode + " " + frPassword);
		// fr login
		
		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
		map.add("frCode", frCode);
		map.add("frPasswordKey", frPassword);
		FrLoginResponse loginResponse = Constant.getRestTemplate().postForObject(Constant.URL + "/loginFr", map,
				FrLoginResponse.class);
		System.out.println("Login Response " + loginResponse.toString());

		if (loginResponse.getLoginInfo().isError()) {

			session.setAttribute("loginError", "Invalid Login Credentials");

			model.addObject("message", loginResponse.getLoginInfo().getMessage());
			return "redirect:/";

		} else {

			session.removeAttribute("loginError");

			System.out.println("Login Sucess");

			session.setAttribute("frId", loginResponse.getFranchisee().getFrId());
			session.setAttribute("frName", loginResponse.getFranchisee().getFrName());

			session.setAttribute("frDetails", loginResponse.getFranchisee());
			// getting fr menus


			System.out.println("Fr is: " + loginResponse.getFranchisee().toString());

			session.setAttribute("frDetails", loginResponse.getFranchisee());
			session.setAttribute("frDetails", loginResponse.getFranchisee());
			session.setAttribute("frName", loginResponse.getFranchisee().getFrName());

			session.setAttribute("loginInfo", loginResponse.getLoginInfo());
			session.setAttribute("frId", loginResponse.getFranchisee().getFrId());
			session.setAttribute("info", loginResponse.getLoginInfo());
			session.setAttribute("frImage", loginResponse.getFranchisee().getFrImage());
			loginResponse.getFranchisee()
					.setFrImage(Constant.FR_IMAGE_URL + loginResponse.getFranchisee().getFrImage());

			model.addObject("frDetails", loginResponse.getFranchisee());
			model.addObject("url", Constant.MESSAGE_IMAGE_URL);
			model.addObject("info", loginResponse.getLoginInfo());
			
			map = new LinkedMultiValueMap<String, Object>();
			map.add("frId", loginResponse.getFranchisee().getFrId());
			
			FrEmpMaster[] empArr = Constant.getRestTemplate().postForObject(Constant.URL + "/getAllFrEmpByFrid", map,
					FrEmpMaster[].class);			
			List<FrEmpMaster> empList = new ArrayList<FrEmpMaster>(Arrays.asList(empArr));
			if (empList.isEmpty()) {
				logger.info("List is empty");

				session.setAttribute("isEmpPresent", 0);

				return "redirect:/home";
			} else {
				logger.info("List is not empty");
				session.setAttribute("isEmpPresent", 1);
				model = new ModelAndView("frlogin");
				return "redirect:/frEmpLogin";
			}

		}

	}

	List<FrEmpMaster> empList = null;
	FrEmpLoginResp loginResponse = null;
	int empId = 0;

	@RequestMapping(value = "/frEmpLogin", method = RequestMethod.GET)
	public ModelAndView frEmpLogin(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = null;
		try {
			HttpSession session = request.getSession();
			RestTemplate restTemplate = new RestTemplate();
			model = new ModelAndView("saleslogin");
			model.addObject("frncihsesID", session.getAttribute("frId"));
			model.addObject("frName", session.getAttribute("frName"));

			Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("frId", frDetails.getFrId());
			FrEmpMaster[] empArr = Constant.getRestTemplate().postForObject(Constant.URL + "/getAllFrEmpByFrid", map,
					FrEmpMaster[].class);
			empList = new ArrayList<FrEmpMaster>(Arrays.asList(empArr));
			model.addObject("empList", empList);
			logger.info("/FrEmp login request mapping.");
		} catch (Exception e) {
			System.out.println("Exception in /frEmpLogin : " + e.getMessage());
			e.printStackTrace();
		}
		return model;

	}

	@RequestMapping(value = "/checkValidEmployee", method = RequestMethod.POST)
	public @ResponseBody String checkValidEmployee(HttpServletRequest request, HttpServletResponse response) {
		String resp = "";

		try {
			System.err.println("Anmol");
			empId = Integer.parseInt(request.getParameter("empId"));
			if (empList.size() > 0) {
				for (int i = 0; i < empList.size(); i++) {
					if (empList.get(i).getFrEmpId() == empId) {
						resp = empList.get(i).getPassword();
						break;
					}
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return resp;
	}

	/*************************************************************************************************/
	@RequestMapping(value = "/frLoginProcess", method = RequestMethod.GET)
	public String frLoginProcess(HttpSession ses, HttpServletRequest request, HttpServletResponse response)
			throws ParseException {

		System.err.println("Fr Emp Login ");

		logger.info("/frLoginProcess request mapping.");

		ModelAndView model = new ModelAndView("frlogin");
		RestTemplate restTemplate = new RestTemplate();

		HttpSession session = request.getSession();
		Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");
		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
		map.add("empId", empId);
		map.add("frId", frDetails.getFrId());
		loginResponse = Constant.getRestTemplate().postForObject(Constant.URL + "/frEmpById", map, FrEmpLoginResp.class);
	
		session.setAttribute("eyeVal", "block");
		session.setAttribute("frEmpName", loginResponse.getFrEmp().getFrEmpName());
		session.setAttribute("img", Constant.FR_IMAGE_URL + loginResponse.getFranchisee().getFrImage());
		session.setAttribute("frEmpDetails", loginResponse.getFrEmp());
		session.setAttribute("frDetails", loginResponse.getFranchisee());
		session.setAttribute("loginInfo", loginResponse.getLoginInfo());
		session.setAttribute("frId", loginResponse.getFranchisee().getFrId());
		session.setAttribute("info", loginResponse.getLoginInfo());
		session.setAttribute("frImage", loginResponse.getFranchisee().getFrImage());
		loginResponse.getFranchisee().setFrImage(Constant.FR_IMAGE_URL + loginResponse.getFranchisee().getFrImage());
		
		model = new ModelAndView("home");
		System.out.println("fr Image URL " + loginResponse.getFranchisee().getFrImage());
		model.addObject("frEmpDetails", loginResponse.getFrEmp());
		model.addObject("frDetails", loginResponse.getFranchisee());
		model.addObject("url", Constant.MESSAGE_IMAGE_URL);
		model.addObject("info", loginResponse.getLoginInfo());
		
		return "redirect:/home";		

	}

	@RequestMapping(value = "/logout")
	public String logout(HttpSession session, HttpServletRequest req, HttpServletResponse res) {
		System.out.println("Logout Controller User Logout");
		ModelAndView model = new ModelAndView("login");
		HttpServletResponse response = (HttpServletResponse) res;

		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", -1);

		session.removeAttribute("frId");

		session.removeAttribute("frDetails");
		session.invalidate();
		session.setMaxInactiveInterval(0);

		System.out.println("session ID  after expire " + session.getId());

		// session.invalidate();

		return "redirect:/";
		// return "redirect:/";
	}

	@RequestMapping(value = "/sessionTimeOut", method = RequestMethod.GET)
	public ModelAndView displayLoginAgain(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("login");

		logger.info("/login request mapping.");

		model.addObject("message", "Session timeout ! Please login again . . .");

		return model;

	}

	@RequestMapping(value = "/changePass", method = RequestMethod.GET)
	public ModelAndView changePass(HttpServletRequest request, HttpServletResponse response, Locale locale)
			throws ParseException {

		ModelAndView model = new ModelAndView("changePass");

		return model;

	}

	@RequestMapping(value = "/updatePassword")
	public String updatePassword(HttpSession session, HttpServletRequest req, HttpServletResponse res) {
		System.out.println("Logout Controller User Logout");
		HttpServletResponse response = (HttpServletResponse) res;

		String result = "";

		String pass = req.getParameter("newPass");
		String oldPass = req.getParameter("oldPass");

		FrEmpMaster frEmpDetails = (FrEmpMaster) session.getAttribute("frEmpDetails");
		int empId = frEmpDetails.getFrEmpId();

		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
		map.add("empId", empId);
		map.add("pass", pass);

		System.err.println("OLD PASS ---- " + frEmpDetails.getPassword());

		if (!oldPass.equals(frEmpDetails.getPassword())) {
			session.setAttribute("passMsg", "Old Password not Matched!");
			result = "redirect:/changePass";

		} else {
			
			Info info = Constant.getRestTemplate().postForObject(Constant.URL + "updateFrEmpPassword", map, Info.class);

			if (info.isError()) {

				session.setAttribute("passMsg", "Failed to Update!");

				result = "redirect:/changePass";
			} else {

				session.removeAttribute("passMsg");

				result = "redirect:/frEmpLogin";
			}

		}

		return result;
	}

	@RequestMapping(value = "/logoutEmp")
	public String logoutEmp(HttpSession session, HttpServletRequest req, HttpServletResponse res) {
		System.out.println("Logout Controller User Logout");
		ModelAndView model = new ModelAndView("login");

		session.removeAttribute("frEmpDetails");

		// session.invalidate();

		return "redirect:/frEmpLogin";
		// return "redirect:/";
	}
	
	@RequestMapping(value = "/getCatSellList", method = RequestMethod.POST)
	@ResponseBody
	public List<CategorywiseSell> getCatSellList(HttpServletRequest request, HttpServletResponse responsel) {
		System.err.println("************");
		HttpSession session = request.getSession();
		Franchisee frDetails = (Franchisee) session.getAttribute("frDetails");
		
		List<CategorywiseSell> sectionList = new ArrayList<>();
		try {
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			
			map.add("frId", frDetails.getFrId());
			map.add("fromDate", DateConvertor.convertToYMD(request.getParameter("frmd")));
			map.add("toDate", DateConvertor.convertToYMD(request.getParameter("tod")));
			CategorywiseSell[] catSell = Constant.getRestTemplate().postForObject(Constant.URL + "/getCatwiseSell", map,
					CategorywiseSell[].class);
			sectionList = new ArrayList<CategorywiseSell>(Arrays.asList(catSell));

		} catch (Exception e) {
			e.printStackTrace();
		}
		return sectionList;
	}

	

}
