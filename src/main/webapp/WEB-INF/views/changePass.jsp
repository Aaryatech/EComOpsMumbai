
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<link rel="icon"
	href="${pageContext.request.contextPath}/resources/newpos/images/favicon.png"
	type="images/png" sizes="32x32">
<style>
.form-control {
	text-align: left !important;
}
</style>
</head>
<body>

	<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>



	<!--topLeft-nav-->
	<div class="sidebarOuter"></div>
	<!--topLeft-nav-->

	<!--wrapper-start-->
	<div class="wrapper">

		<jsp:include page="/WEB-INF/views/include/logo.jsp"></jsp:include>

		<!--rightContainer-->
		<div class="fullGrid center">
			<!--fullGrid-->
			<div class="wrapperIn2">

				<!--leftNav-->

				<jsp:include page="/WEB-INF/views/include/left.jsp">
					<jsp:param name="myMenu" value="${menuList}" />
				</jsp:include>

				<br>
				<div class="sidebarright">
					<br> <br>
					<div class="order-left" style="text-align: center; width: 100%;">
						<h2 class="pageTitle" style="text-align: center; float: none;">Change
							Password</h2>
						<br> <br>

						<c:if test="${not empty sessionScope.passMsg}">

							<h4 class="pageTitle"
								style="text-align: center; float: none; border: 1px solid #ed1c24; color: #ed1c24;">${sessionScope.passMsg}</h4>
							<br>
							<br>
						</c:if>
					 <% session.removeAttribute("passMsg"); %> 
					</div>


					<br> <br>

					<form name="frm_search" id="frm_search" method="get"
						action="${pageContext.request.contextPath}/updatePassword">



						<div class="profile">
							<div class="profilefildset"
								style="width: 50%; text-align: right;">Previous Password *</div>
							<div class="profileinput" style="width: 50%">
								<input id="oldPass" required name="oldPass" autocomplete="off"
									class="form-control" type="password" style="width: 200px">
							</div>
						</div>

						<div class="profile">
							<div class="profilefildset"
								style="width: 50%; text-align: right;">New Password *</div>
							<div class="profileinput" style="width: 50%">
								<input id="newPass" required name="newPass" autocomplete="off"
									class="form-control" type="password" style="width: 200px">
							</div>
						</div>

						<div class="profile">
							<div class="profilefildset"
								style="width: 50%; text-align: right;">Confirm Password *</div>
							<div class="profileinput" style="width: 50%">
								<input id="confPass" required name="confPass" autocomplete="off"
									class="form-control" type="password" style="width: 200px"
									onblur="checkNewAndConfirmPass()">
							</div>

						</div>

						<br>



						<div class="row">
							<br> <input name="submit" class="buttonsaveorder"
								value="Update" type="submit" align="center" id="submtbtn">
						</div>


					</form>


				</div>
				<!--tabNavigation-->


			</div>
			<!--rightSidebar-->

		</div>
		<!--fullGrid-->
	</div>
	<!--rightContainer-->

	</div>
	<!--wrapper-end-->
	<!--easyTabs-->
	<!--easyTabs-->
	<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
	<!--easyTabs-->


	<script type="text/javascript">
		function checkOldPass() {

			var oldPass = document.getElementById("oldPass").value;

			var savedPass = $
			{
				sessionScope.frEmpDetails.password
			}
			;
			//var savedPass="abc";
			alert(oldPass + " ------------ " + savedPass);

			if (oldPass == savedPass) {
				alert("Match");
				document.getElementById("newPass").disabled = false;
				document.getElementById("confPass").disabled = false;

			} else {
				alert("Incorrect Previous Password !");
				document.getElementById("newPass").value = "";
				document.getElementById("confPass").value = "";
				document.getElementById("newPass").disabled = true;
				document.getElementById("confPass").disabled = true;

				//document.getElementById("submtbtn").disabled = true;
				$('#submtbtn').hide();
			}

		}

		function checkNewAndConfirmPass() {
			var newPass = document.getElementById("newPass").value;
			var confPass = document.getElementById("confPass").value;

			if (newPass == confPass) {
				//alert("Match");
				//document.getElementById("submtbtn").disabled = false;

				$('#submtbtn').show();

			} else {
				alert("Confirm Password Not Matched !");
				//alert("Not Match");
				//document.getElementById("newPass").value="";
				document.getElementById("confPass").value = "";
			}

		}
	</script>

</body>
</html>
