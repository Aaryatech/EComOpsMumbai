package com.monginis.ops;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.monginis.ops.model.FrEmpLoginResp;
import com.monginis.ops.model.FrEmpMaster;
import com.monginis.ops.model.Franchisee;

public class CheckUserInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws IOException {

		// System.out.println("Intercept handler..");

		HttpSession session = request.getSession();

		String path = request.getRequestURI().substring(request.getContextPath().length());
		//System.out.println("path is: " + path);

		if (path.startsWith("/pdf")) {
			return true;
		}
		try {
			String resourcesPath = path.substring(1, 4);
			// System.out.println("substring is: "+resourcesPath);

			if (resourcesPath.equalsIgnoreCase("res")) {
				// System.out.println("resource req : "+path);

				return true;
			}
		} catch (Exception e) {
			// TODO: handle exception
		}

		if (!path.equalsIgnoreCase("/sessionTimeOut") || path.startsWith("/resources")) {

			Franchisee userObj = null;
			FrEmpMaster empObj = null;
			try {

				userObj = (Franchisee) session.getAttribute("frDetails");
				empObj = (FrEmpMaster) session.getAttribute("frEmpDetails");

			} catch (Exception e) {
				// TODO: handle exception

				// System.out.println("Fr Details: "+userObj);

			}

			try {
				if (request.getServletPath().equals("/") || request.getServletPath().equals("/loginProcess")
						|| request.getServletPath().equals("/logout") || request.getServletPath().equals("/login")) { // ||request.getServletPath().equals("/logout")
					// System.out.println("Login request");
					return true;
				} else if (userObj == null) {
					// System.out.println("Session Expired");

					// request.setAttribute("emassage", "login failed");
					response.sendRedirect(request.getContextPath() + "/sessionTimeOut");

					return false;
				} else {
					if (request.getServletPath().equals("/frEmpLogin")
							|| request.getServletPath().equals("/frLoginProcess")
							|| request.getServletPath().equals("/checkValidEmployee")
							|| request.getServletPath().equals("/getEmpDetails")
							|| request.getServletPath().equals("/checkOtp")
							|| request.getServletPath().equals("/changeToNewPassword")) { // ||request.getServletPath().equals("/logout")
						// System.out.println("Login request");
						return true;
					} else if (empObj == null) {
						response.sendRedirect(request.getContextPath() + "/sessionTimeOut");
						return false;
					} else {
						return true;
					}
					// return true;
				}
			} catch (Exception e) {
				// e.printStackTrace();
				response.sendRedirect(request.getContextPath() + "/sessionTimeOut");

				return false;
			}

		}
		return true;

	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub

		// System.out.println("post intercept hanlder");
		super.postHandle(request, response, handler, modelAndView);
	}

	/*
	 * if( userObj == null ) { // System.out.println("Session Expired");
	 * 
	 * // request.setAttribute("emassage", "login failed");
	 * response.sendRedirect(request.getContextPath()+"/sessionTimeOut");
	 * 
	 * return false; }else{ if(userObj != null && empObj ==null) {
	 * if(request.getServletPath().equals("/frEmpLogin") ||
	 * request.getServletPath().equals("/frLoginProcess")){
	 * //||request.getServletPath().equals("/logout") System.out.println("IN IF");
	 * return true; }else { System.out.println("IN ELSE");
	 * response.sendRedirect(request.getContextPath()+"/sessionTimeOut"); return
	 * false; } }
	 * 
	 * }
	 */

}
