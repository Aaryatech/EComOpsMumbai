<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8" />
<title>Madhvi</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport" content="width=device-width; initial-scale=1.0; maximum-scale=1.0" />
<meta name="keywords" content="Madhvi"/>
<meta name="description" content="Madhvi"/>
<meta name="author" content="Madhvi">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/newpos/css/monginis.css" type="text/css"/>
<link rel="icon" href="${pageContext.request.contextPath}/resources/newpos/images/favicon.png" type="images/png" sizes="32x32">

<link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700&display=swap" rel="stylesheet">

<!--commanJS-->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/newpos/js/jquery-1.10.2.min.js"></script>
<style type="text/css">
.fr_head{
	text-align: center;
	padding-bottom: 1%;
	color: red;
}
.fr_head_lgn{text-align: center; color:#333; background:#fff200; margin: 0 0 15px 0; font-weight: 600; text-transform: uppercase; padding: 10px;
font-size: 16px;}
</style>
</head>

<body class="login_page">
<form action="${pageContext.request.contextPath}/frLoginProcess"  method="post">
<!--wrapper-start-->
<div class="wrapper">
	<div class="login_bx">
		<h2 class="lgn_head"><img src="${pageContext.request.contextPath}/resources/newpos/images/lgn_logo.jpg" alt="lgn_logo"></h2>
		<div class="lgn_container">
			<!-- <p class="lgn_account">Please login to your account.</p> -->
			<p class="fr_head_lgn">${frName}</p>
			<div class="lgn_row"><input name="username" type="text" class="lgn_input" placeholder="Username" maxlength="10" />
				<img src="${pageContext.request.contextPath}/resources/newpos/images/user_icn1.png" alt="user_icn">
			</div>
			<div class="lgn_row"><input name="password"  type="password" class="lgn_input" placeholder="Password" />
				<img src="${pageContext.request.contextPath}/resources/newpos/images/pass_icn.png" alt="pass_icn">
			</div>
			<div class="a">
				<label class="container">Remember me
				  <input type="checkbox" >
				  <span class="checkmark"></span>
				</label>
			</div>
			<div class="lgn_btn"><button type="submit" class="signin_btn" ><i class="fa fa-sign-in" aria-hidden="true"></i> &nbsp;Sign in</button></div>
			<p class="lgn_frgt">
				<a href="#">Forgot your password?</a> <br>
				Don't worry! <a href="#">click here</a> To Reset
			</p>
		</div>
	</div>
</div>
<!--wrapper-end-->
</form>

</body>
</html>