<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8" />
<title>Monginis</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport"
	content="width=device-width; initial-scale=1.0; maximum-scale=1.0" />
<meta name="keywords" content="Monginis" />
<meta name="description" content="Monginis" />
<meta name="author" content="Monginis">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/newpos/css/monginis.css"
	type="text/css" />
<link rel="icon"
	href="${pageContext.request.contextPath}/resources/newpos/images/feviconicon.png"
	type="images/png" sizes="32x32">

<link
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700&display=swap"
	rel="stylesheet">

<!--commanJS-->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/newpos/js/jquery-1.10.2.min.js"></script>
<style type="text/css">
.login_bg {
	background-image:
		url("${pageContext.request.contextPath}/resources/images/lgn_bg.jpg");
	background-repeat: no-repeat;
	background-size: cover;
	position: relative;
	height: 100vh;
}
</style>
</head>

<body class="login_page">
<div class="login_bg">
	<form action="${pageContext.request.contextPath}/loginProcess"
		method="post">
		<!--wrapper-start-->
		<div class="wrapper">
			<div class="login_bx">
				<h2 class="lgn_head">
					<img
						src="${pageContext.request.contextPath}/resources/images/monginislogo.png"
						alt="lgn_logo">
				</h2>
				<div class="lgn_container">

					<%-- <c:choose>
						<c:when test="${not empty sessionScope.loginError}">
							<p class="lgn_account"><h4><c:out value="${sessionScope.loginError}" /></h4></p>
						</c:when>
						<c:otherwise>
							<p class="lgn_account">Please login to your account.</p>
						</c:otherwise>
					</c:choose> --%>

					<c:if test="${not empty sessionScope.loginError}">
						<p class="lgn_account" style="color: #ec268f !important; font-size: medium; font-weight: bold;"><c:out value="${sessionScope.loginError}" /></p>
					</c:if>

					<p class="lgn_account">Please login to your account.</p>
					<div class="lgn_row">
						<input name="username" type="text" class="lgn_input"
							placeholder="Username" /> <img
							src="${pageContext.request.contextPath}/resources/newpos/images/user_icn1.png"
							alt="user_icn">
					</div>
					<div class="lgn_row">
						<input name="password" type="password" class="lgn_input"
							placeholder="Password" /> <img
							src="${pageContext.request.contextPath}/resources/newpos/images/pass_icn.png"
							alt="pass_icn">
					</div>
					<!-- <div class="a">
						<label class="container">Remember me <input
							type="checkbox"> <span class="checkmark"></span>
						</label>
					</div> --> 
					<div class="lgn_btn">
						<button type="submit" class="signin_btn">
							<i class="fa fa-sign-in" aria-hidden="true"></i> &nbsp;Sign in
						</button>
					</div>
					<!-- <p class="lgn_frgt">
						<a href="#">Forgot your password?</a> <br> Don't worry! <a
							href="#">click here</a> To Reset
					</p> -->
				</div>
			</div>
		</div>
		<!--wrapper-end-->
	</form>
</div>
</body>
</html>