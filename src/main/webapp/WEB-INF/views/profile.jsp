<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>

<%-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
<title>Madhvi</title>
<link
	href="${pageContext.request.contextPath}/resources/css/monginis.css"
	rel="stylesheet" type="text/css" />
<link rel="icon"
	href="${pageContext.request.contextPath}/resources/images/feviconicon.png"
	type="image/x-icon" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery-1.10.2.min.js"></script>

<!--rightNav-->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/menuzord.js"></script>
<script type="text/javascript">
	jQuery(document).ready(function() {
		jQuery("#menuzord").menuzord({
			align : "left"
		});
	});
	$(".toggle").on("click", function() {
		$(".marquee").toggleClass("microsoft");
	});
</script> --%>

<!--datepicker-->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery-ui.js"></script>
<script>
	$(function() {
		$(".datepicker_dmy").datepicker({
			dateFormat : 'dd-mm-yy'
		});
	});
	/* $(function() {
		$("#to_date").datepicker({
			dateFormat : 'dd-mm-yy'
		});
	});
	$(function() {
		$("#join_date").datepicker({
			dateFormat : 'dd-mm-yy'
		});
	}); */
</script>
<!--datepicker-->




<style>
.fileUpload1 input.upload1 {
	position: absolute;
	top: 0;
	right: 0;
	margin: 0;
	padding: 0;
	cursor: pointer;
	opacity: 0;
	filter: alpha(opacity = 0);
	width: 100%;
	height: 33px;
}
/* div.topSlide {
    width: auto;
    height: 600px;
    overflow: scroll;
} */
</style>
<!--rightNav-->
<link href="${pageContext.request.contextPath}/resources/css/style.css"
	rel="stylesheet" type="text/css" />

</head>
<body onload="getCurrentEmpCode()">
	<c:url var="checkUserAuthority" value="/checkUserAuthority" />
	<c:url var="updateUserPasswords" value="/updateUserPasswords" />
	<c:url var="updateAdminPassword" value="/updateAdminPassword" />
	<c:url var="getAllFrEmp" value="/getAllFrEmp" />
	<c:url var="getFrEmpById" value="/getFrEmpById" />
	<c:url var="delFrEmpById" value="/delFrEmpById" />
	<c:url var="verifyUniqueContactNo" value="/verifyUniqueContactNo" />
	<c:url var="getCurrentEmpCodeValue" value="/getCurrentEmpCodeValue" />
	<c:url var="getFrEditEmpById" value="/getFrEditEmpById" />




	<!--topLeft-nav-->
	<div class="sidebarOuter"></div>
	<!--topLeft-nav-->

	<!--wrapper-start-->
	<div class="wrapper">

		<!--topHeader-->
		<%--  <jsp:include page="/WEB-INF/views/include/header.jsp">
		
			<jsp:param name="fr" value="${frDetails}"/>
		</jsp:include>  --%>

		<jsp:include page="/WEB-INF/views/include/logo.jsp"></jsp:include>



		<!--topHeader-->

		<!--rightContainer-->
		<div class="fullGrid center">
			<!--fullGrid-->
			<div class="wrapperIn2">

				<jsp:include page="/WEB-INF/views/include/left.jsp"></jsp:include>

				<!--rightSidebar-->
				<div class="sidebarright">



					<!--slider-->
					<!--slider thum size : width:850px height:350px-->
					<div id="owl-example" class="owl-carousel">




						<%-- <c:forEach items="${msgList}" var="msgList">

							<div class="item">
								<div class="screen4plan">
									<div class="homesliderImg">
									 <img src="${url}${msgList.msgImage}" height="300" width="300" />
									

									</div>
									<h3 class="homesliderTitle" ><center>${msgList.msgHeader}</center></h3>


								</div>
							</div>
						</c:forEach> --%>


					</div>
					<!--slider-->



					<div class="topSlide">


						<div class="topSlide2 textcen">

							<div class="order-right"
								style="padding-top: 10px; padding-bottom: 5px; float: right;">
								<a href="#" class="pending_btn initialism addcust_open">Add
									Employee</a> <a href="#" class="pending_btn initialism slide_open"
									onclick="getData()">Employee List</a>
							</div>



							<div class="profileinsite">


								<form name="updateprofile" id="updateprofile" method="post"
									action="${pageContext.request.contextPath}/updateprofile"
									enctype="multipart/form-data">
									<div class="profileinsiteLeft">

										<div class="profile">
											<div class="profilefildset">Franchisee Name</div>
											<div class="profileinput">
												<input class="texboxitemcode" placeholder="franchisee Name"
													name="fr_name" type="text" value="${frDetails.frName}"
													readonly="readonly">
											</div>
										</div>

										<div class="profile">
											<div class="profilefildset">Franchisee Profile Pic</div>
											<div class="profileinput">
												<div class="editimg">
													<div class="editpics">
														<div class="fileUpload1">
															<span><i class="fa fa-pencil"></i></span> <input
																type="file" class="upload1" name="fr_image" id="fr_image" />
														</div>
													</div>
													<div style="max-width: 110px; height: 110px; width: 110px;">
														<img src="${imgUrl}${frDetails.frImage}" alt="img" id="img">
													</div>
												</div>
											</div>
										</div>
										<input type="hidden" name="prevImage" value="${frImageName}">

										<div class="profile">
											<div class="profilefildset">City</div>
											<div class="profileinput">
												<select class="texboxitemcode" name="fr_city" id="fr_city">
													<c:forEach items="${cityList}" var="city" varStatus="count">
														<c:choose>
															<c:when test="${city.cityId==frDetails.frCity}">
																<option selected value="${city.cityId}">${city.cityName}</option>
															</c:when>
															<c:otherwise>
																<option value="${city.cityId}">${city.cityName}</option>
															</c:otherwise>
														</c:choose>
													</c:forEach>
												</select>
											</div>
										</div>

										<div class="profile">
											<div class="profilefildset">Pin Code</div>
											<div class="profileinput">
												<input class="texboxitemcode" placeholder="Pincode"
													name="fr_pincode" type="text" value="${frDetails.pincode}">
											</div>
										</div>

										<div class="profile">
											<div class="profilefildset">Owner's Birthdate</div>
											<div class="profileinput mardis">${frDetails.ownersBirthDay}</div>

										</div>
									</div>


									<div class="profileinsiteRight">
										<div class="profile">
											<div class="profilefildset">Email Id</div>
											<div class="profileinput">
												<input class="texboxitemcode" name="fr_email"
													placeholder="example@gmail.com" type="text"
													value="${frDetails.frEmailId}">
											</div>
										</div>
										&nbsp;

										<div class="profile">
											<div class="profilefildset">Mobile No.</div>
											<div class="profileinput">
												<input class="texboxitemcode" placeholder="Mobile No."
													name="fr_mobile" type="text" maxlength="10"
													oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');"
													value="${frDetails.frContactNo}">
											</div>
										</div>

										<div class="profile" style="display: none;">
											<div class="profilefildset">Distance (Km.)</div>
											<div class="profileinput mardis">${frDetails.noOfKmAreaCover}</div>

										</div>

										<div class="profile">
											<div class="profilefildset">Shop Opening Date</div>
											<div class="profileinput mardis">${frDetails.openingDate}</div>
										</div>

										<div class="profile">
											<div class="profilefildset">Address</div>
											<div class="profileinput mardis">

												<input class="texboxitemcode" placeholder="Address"
													name="fr_address" type="text" value="${frDetails.frAddress}">
											</div>


											<div class="profile">
												<div class="profilefildset">FDA License Date</div>
												<div class="profileinput mardis">
													<input class="texboxitemcode datepicker_dmy"
														placeholder="FDA License Date" name="fda_lics_date"
														type="text" value="${frDetails.fdaLicenseDateExp}">
												</div>
											</div>

											<div class="profile">
												<div class="profilefildset">FDA License No.</div>
												<div class="profileinput mardis">${frDetails.fdaNumber}</div>
											</div>
										</div>
									</div>


									<div class="frm_row_one"
										style="margin-top: 20px; display: none;">

										<div class="four_one three" style="width: 50%;">
											<input name="" class="" value="Change Admin Password"
												type="button" id="changePwd1" onclick="showDiv()"
												style="font-size: 8pt; height: 33px; width: 150px;">

											<input name="" class="" value="Change Cashier Password"
												type="button" id="changePwd2" onclick="showDiv1()"
												style="font-size: 8pt; height: 33px; width: 150px;">

											<input name="" class="" value="Change Manager Password"
												type="button" id="changePwd3" onclick="showDiv2()"
												style="font-size: 8pt; height: 33px; width: 150px;">
										</div>

										<div class="four_one three" style="width: 50%;">

											<div style="display: none;" id="adminDiv">
												<label>Admin Password</label>&nbsp;&nbsp; <input
													class="texboxitemcode" placeholder="Enter Admin Password"
													name="admin_password" type="password" value=""
													id="admin_password"
													style="font-size: 8pt; height: 33px; width: 150px;">

												<input name="" class="btn btn-info" value="Submit"
													type="button" id="btnupdate_profile"
													onclick="return checkAuthority()">

											</div>


											<div style="display: none;" id="adminDiv1">
												<label>Admin Password</label> &nbsp;&nbsp;<input
													class="texboxitemcode" placeholder="Enter Admin Password"
													name="admin_password1" type="password" value=""
													id="admin_password1"
													style="font-size: 8pt; height: 33px; width: 130px;">

												<input name="" class="btn btn-info" value="Submit"
													type="button" id="btnupdate_profile"
													onclick="return checkAuthForPassChange()">

											</div>

											<div style="display: none;" id="adminDiv2">
												<label>Admin Password</label> &nbsp;&nbsp;<input
													class="texboxitemcode" placeholder="Enter Admin Password"
													name="admin_password2" type="password" value=""
													id="admin_password2"
													style="font-size: 8pt; height: 33px; width: 130px;">

												<input name="" class="btn btn-info" value="Submit"
													type="button" id="btnupdate_profile"
													onclick="return checkAuthForManagerPassChange()">

											</div>


										</div>



									</div>

									<div class="frm_row_one" id="adminNewPassDiv"
										style="display: none;">
										<div class="four_one three" style="width: 35%;">

											<lable> <b>Edit Admin Password</b></lable>
											&nbsp;&nbsp; <input class="texboxitemcode"
												placeholder="Enter new Password" name="fr_password"
												type="password" onChange="checkPasswordMatch();"
												value="${frDetails.frPassword}" id="txtNewPassword"
												style="font-size: 16px; height: 33px; width: 130px;">



										</div>
										<div class="four_one three" style="width: 35%;">

											<lable> <b>Confirm Admin Password</b></lable>
											&nbsp;&nbsp; <input class="texboxitemcode"
												placeholder="Confirm new Password" name="fr_password"
												type="password" value="${frDetails.frPassword}"
												id="txtConfirmPassword" onChange="checkPasswordMatch();"
												style="font-size: 16px; height: 33px; width: 130px;">

											<div class="update FormAlert" id="divCheckPasswordMatch">
											</div>
										</div>
										<div class="four_one three" style="width: 15%;">

											<div id="updateDiv" style="display: none;">

												<input name="updateAdminPwd" class="btn btn-primary"
													value="Update Password" onclick="updateAdminPassword()"
													type="button" id="btnupdate_profile">

											</div>


										</div>

										<div class="four_one three" style="width: 15%;">
											<input class="btn btn-primary" value="Cancel"
												onclick="cancelDiv()" type="button">
										</div>

									</div>
									<div class="profile">
										<div class="profileinput">
											<input name="" class="btn additem_btn" value="SUBMIT"
												type="submit" id="btnupdate_profile">
										</div>
									</div>

								</form>

							</div>
						</div>
					</div>




					<!--latestNews-->

				</div>
				<!--rightSidebar-->

			</div>
			<!--fullGrid-->
		</div>
		<!--rightContainer-->

	</div>
	<!--wrapper-end-->
	<!--pending amount popup-->
	<div id="addcust" class="add_customer" style="width: 60%;">
		<button class="addcust_close close_popup" onclick="clearForm()">
			<i class="fa fa-times" aria-hidden="true"></i>
		</button>
		<h3 class="pop_head">Add Employee</h3>
		<div class="col-lg-12">
			<div class="row">
				<form action="saveFranchiseeEmp" id="fr_emp_form" method="post">
					<div class="col-lg-6">
						<input type="hidden" value="${emp.frEmpId}" name="fr_emp_id"
							id="fr_emp_id">

						<div class="add_frm">
							<div class="add_frm_one">
								<div class="add_customer_one">Employee Name</div>
								<div class="add_input">
									<input name="emp_name" type="text" class="input_add"
										id="emp_name" value="${emp.frEmpName}" required />
								</div>
								<div class="clr"></div>
							</div>
							<div class="add_frm_one">
								<div class="add_customer_one">Joining Date</div>
								<div class="add_input">
									<input name="join_date" type="date" class="input_add"
										id="join_date" value="${emp.frEmpJoiningDate}" required />
								</div>
								<div class="clr"></div>
							</div>
							<input name="ttl_limit" type="hidden" class="input_add"
								id="ttl_limit" value="1"
								oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
								required />
							<%-- 	<div class="add_frm_one">
								<div class="add_customer_one">Total Limit</div>
								<div class="add_input">
									<input name="ttl_limit" type="text" class="input_add"
										id="ttl_limit" value="${emp.totalLimit}"
										oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
										required />
								</div>
								<div class="clr"></div>
							</div> --%>
							<div class="add_frm_one" style="z-index: 9999; display: none;">
								<div class="add_customer_one">From Date</div>
								<div class="add_input">
									<input name="from_date" type="date" class="input_add"
										id="from_date" value="${emp.fromDate}" required
										autocomplete="off" />

								</div>
								<div class="clr"></div>
							</div>
							<div class="add_frm_one">
								<div class="add_customer_one">Password</div>
								<div class="add_input">
									<input name="pass" type="password" class="input_add" id="pass"
										value="${emp.password}" required />
								</div>
								<div class="clr"></div>
							</div>
							<div class="add_frm_one">
								<div class="add_customer_one">Designation</div>
								<select name="designation" id="designation"
									data-placeholder="Designation" class="add_input"
									class="input_add " style="text-align: left;">
									<option value="1" style="text-align: left;" selected>Admin</option>
									<option value="2" style="text-align: left;">Manager</option>
									<option value="3" style="text-align: left;">Cashier</option>
									<option value="4" style="text-align: left;">Delivery
										Boy</option>
								</select>
								<div class="clr"></div>
							</div>
							<div class="add_frm_one" id="vehicle_div" style="display: none;">
								<div class="add_customer_one">Vehicle No.</div>
								<div class="add_input">
									<input name="vehicle_no" type="text" class="input_add"
										id="vehicle_no" value="${emp.exVar1}" required
										style="text-transform: uppercase;" />
								</div>
								<div class="clr"></div>
							</div>
						</div>
					</div>

					<div class="col-lg-6">

						<div class="add_frm">
							<div class="add_frm_one">
								<div class="add_customer_one">Mobile Number</div>
								<div class="add_input">
									<input name="emp_contact" type="text" class="input_add"
										id="emp_contact" onchange="checkContactNo()"
										value="${emp.frEmpContact}" maxlength="10"
										oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');"
										required />
								</div>
								<div class="clr"></div>
							</div>

							<div class="add_frm_one">
								<div class="add_customer_one">Address</div>
								<div class="add_input">
									<input name="emp_address" type="text" class="input_add"
										id="emp_address" value="${emp.frEmpAddress}" required />
								</div>
								<div class="clr"></div>
							</div>

							<input name="curr_bill_amt" type="hidden" class="input_add"
								id="curr_bill_amt" value="1"
								oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
								required />
							<%-- <div class="add_frm_one">
								<div class="add_customer_one">Current Bill Amt</div>
								<div class="add_input">
									<input name="curr_bill_amt" type="text" class="input_add"
										id="curr_bill_amt" value="${emp.currentBillAmt}"
										oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
										required />
								</div>
								<div class="clr"></div>
							</div> --%>
							<div class="add_frm_one" style="display: none;">
								<div class="add_customer_one">To Date</div>
								<div class="add_input">
									<input name="to_date" type="date" class="input_add"
										id="to_date" value="${emp.toDate}" />
								</div>
								<div class="clr"></div>
							</div>

							<div class="add_frm_one">
								<div class="add_customer_one">Employee Code</div>
								<div class="add_input">

									<c:choose>
										<c:when test="${emp.empCode>0}">
											<input name="emp_code" type="text" class="input_add"
												readonly="readonly" id="emp_code" value="${emp.empCode}"
												required="required" />
										</c:when>
										<c:otherwise>
											<input name="emp_code" type="text" class="input_add"
												readonly="readonly" id="emp_code" value="${empCode}"
												required="required" />
										</c:otherwise>
									</c:choose>


								</div>
								<div class="clr"></div>
							</div>
							<div class="add_frm_one">
								<div class="add_customer_one">Is Active</div>
								<div class="add_input">

									<input type="radio" id="emp_status_yes"
										${emp.delStatus==1 ? 'checked' : ''} name="emp_status"
										value="1" checked> Yes <input type="radio"
										id="emp_status_no" ${emp.delStatus==0 ? 'checked' : ''}
										name="emp_status" value="0"> NO

								</div>
								<div class="clr"></div>
							</div>
							<div class="add_frm_one" id="license_div" style="display: none;">
								<div class="add_customer_one">License Expiry Date</div>
								<div class="add_input">
									<input name="lic_exp_date" type="date" class="input_add"
										id="lic_exp_date" value="${emp.exVar2}" required />
								</div>
								<div class="clr"></div>
							</div>
						</div>

					</div>
				</form>
			</div>
		</div>

		<div class="pop_btns">
			<div class="close_l">
				<button class="addcust_close close_btn" onclick="clearForm()">Close</button>
			</div>
			<div class="close_r">
				<input type="submit" class="pending_btn" id="sbtbtn4" value="Save">
			</div>
			<div class="clr"></div>
		</div>

		<!--<button class="slide_close"><i class="fa fa-times" aria-hidden="true"></i></button>-->
	</div>
	<script type="text/javascript">
		$(document).ready(function() {
			$('#addcust').popup({
				focusdelay : 400,
				outline : true,
				vertical : 'top'
			});
		});
	</script>


	<!--pending amount popup-->
	<div id="slide" class="pending_pop">
		<h3 class="pop_head">Employee List</h3>
		<button class="slide_close">
			<i class="fa fa-times" aria-hidden="true"></i>
		</button>
		
		<div class="tableFixHead">
			<table id="table_grid">
				<thead>
					<tr>
						<th style="text-align: center;">Sr.No.</th>
						<th style="text-align: center;">Employee Name</th>
						<th style="text-align: center;">Designation</th>
						<th style="text-align: center;">Contact No</th>
						<th style="text-align: center;">Address</th>
						<th style="text-align: center;">Joining Date</th>
						<th style="text-align: center;">Status</th>
						<th style="text-align: center;">Action</th>
					</tr>
				</thead>
				<tbody>

				</tbody>
			</table>
		</div>
		
		
		<!-- <div style="overflow-x: auto; height: 90%;">
			<table class="pending_tab1" id="table_grid">
				<thead>
					<tr>
						<th style="text-align: center;">Sr.No.</th>
						<th style="text-align: center;">Employee Name</th>
						<th style="text-align: center;">Designation</th>
						<th style="text-align: center;">Contact No</th>
						<th style="text-align: center;">Address</th>
						<th style="text-align: center;">Joining Date</th>
						<th style="text-align: center;">Status</th>
						<th style="text-align: center;">Action</th>
					</tr>
				</thead>
				<tbody>

				</tbody>
			</table>
		</div> -->
	</div>
	
	<!-- <script type="text/javascript">
		var loadFile = function(event) {
			try {
				var image = document.getElementById('img');
				image.src = URL.createObjectURL(event.target.files[0]);
			} catch (err) {
				console.log(err);
			}
		};
	</script> -->
	
	<script type="text/javascript">
		$(document).ready(function() {
			$('#slide').popup({
				focusdelay : 400,
				outline : true,
				vertical : 'top'
			});
		});
	</script>

	<script type="text/javascript">
		function checkContactNo() {

			var empId = $('#fr_emp_id').val();

			var mobNo = $('#emp_contact').val();
			if (mobNo != "" || mobNo != null) {

				$.getJSON('${verifyUniqueContactNo}', {
					mobNo : mobNo,
					ajax : 'true'
				}, function(data) {

					//alert("Info : "+JSON.stringify(data)); 
					if (data.error == false) {

						if (data.message != empId) {

							document.getElementById("emp_contact").value = "";
							alert("Contact No. Already Exist.");
							$('#emp_contact').focus();
							return true;
						}
					}

				});

			}
		}
	</script>

	<script type="text/javascript">
		function clearForm() {
			$("#fr_emp_form").trigger("reset");
		}

		$('#sbtbtn4').click(function() {
			var mobNo = $('#emp_contact').val();
			var empId = $('#fr_emp_id').val();
			var desig = $('#designation').val();

			var valid = 0;
			if ($('#emp_name').val() == "") {
				valid = 1;
				alert("Enter Employee Name");
			} else if ($('#emp_contact').val() == "") {
				valid = 1;
				alert("Enter Contact No.");
			} else if ($('#join_date').val() == "") {
				valid = 1;
				alert("Enter Joining Date");
			} else if ($('#emp_address').val() == "") {
				valid = 1;
				alert("Enter Employee Address");
			}

			else if ($('#pass').val() == "") {
				valid = 1;
				alert("Enter Password");
			}
			/* else if ($('#pass').val().length != 4) {
				valid = 1;
				alert("Enter 4 digit Password");
			} */
			else if ($('#emp_code').val() == "") {
				valid = 1;
				alert("Enter Employee Code");
			}
			if (desig == 4) {
				if ($('#vehicle_no').val() == "") {
					valid = 1;
					alert("Enter Vehicle No");
				} else if ($('#lic_exp_date').val() == "") {
					valid = 1;
					alert("Enter License Expiry Date");
				}
			}
			if (valid == 0) {
				save();
			}

		});
		function save() {

			document.getElementById('sbtbtn4').disabled = true;

			$.ajax({
				type : "POST",
				url : "${pageContext.request.contextPath}/saveFranchiseeEmp",
				data : $("#fr_emp_form").serialize(),
				dataType : 'json',
				success : function(data) {
					if (data.frEmpName != null) {

						document.getElementById('sbtbtn4').disabled = false;

						$("#fr_emp_form").trigger("reset");
						$('#addcust').popup('hide');
						alert("Employee Saved Successfylly");

						getCurrentEmpCode();
					}
				}
			}).done(function() {
				setTimeout(function() {
				}, 500);
			});
		}

		function getData() {
			$
					.getJSON(
							'${getAllFrEmp}',

							{
								ajax : 'true'
							},
							function(data) {
								$('#table_grid td').remove();
								$
										.each(
												data,
												function(key, emp) {
													//alert(JSON.stringify(cashHndOvr));
													$('#loader').hide();

													/* document.getElementById("expExcel").disabled = false;
													document.getElementById("PDFButton").disabled = false;

													if (data == "") {
														alert("No records found !!");
														document.getElementById("expExcel").disabled = true;
														document.getElementById("PDFButton").disabled = true;
													
													} */

													var tr = $('<tr></tr>');
													tr.append($('<td style="text-align:center;"></td>')
															.html(key + 1));
													tr
															.append($(
																	'<td style="text-align:left;"></td>')
																	.html(
																			emp.frEmpName));
													var desig = '';
													if (emp.designation == 1) {
														desig = 'Admin'
													} else if (emp.designation == 2) {
														desig = 'Manager'
													} else if (emp.designation == 3) {
														desig = 'Cashier'
													} else if (emp.designation == 4) {
														desig = 'Delivery Boy'
													}

													tr.append($('<td style="text-align:center;" ></td>')
															.html(desig));
													tr
															.append($(
																	'<td style="text-align:center;"></td>')
																	.html(
																			emp.frEmpContact));
													tr
															.append($(
																	'<td style="text-align:left;"></td>')
																	.html(
																			emp.frEmpAddress));
													tr
															.append($(
																	'<td style="text-align:center;"></td>')
																	.html(
																			emp.frEmpJoiningDate));
													var stat = '';
													if (emp.delStatus == 1) {
														stat = 'Active'
													} else {
														stat = 'In-Active'
													}
													tr.append($('<td style="text-align:center;"></td>')
															.html(stat));
													tr
															.append($(
																	'<td style="text-align:center;"></td>')
																	.html(
																			"<a href='#' onclick=editFrEmp("
																					+ emp.frEmpId
																					+ ") title='Edit' class='addcust_open'><i class='fa fa-edit'></i></a>"));
													$('#table_grid tbody')
															.append(tr);

												})

							});
		}/* "<a href='#' onclick=deletFrEmp("+ emp.frEmpId+") title='Delete'><i class='fa fa-trash'></i></a>" */

		function deletFrEmp(empId) {
			//alert("Id----------"+empId)

			if (empId != null) {

				$
						.getJSON(
								'${delFrEmpById}',

								{
									empId : empId,
									ajax : 'true'
								},
								function(data) {
									$('#table_grid td').remove();
									$
											.each(
													data,
													function(key, emp) {
														//alert(JSON.stringify(cashHndOvr));
														$('#loader').hide();

														var tr = $('<tr  ></tr>');
														tr
																.append($(
																		'<td></td>')
																		.html(
																				key + 1));
														tr
																.append($(
																		'<td></td>')
																		.html(
																				emp.frEmpName));
														tr
																.append($(
																		'<td></td>')
																		.html(
																				emp.frEmpContact));
														tr
																.append($(
																		'<td></td>')
																		.html(
																				emp.frEmpAddress));
														tr
																.append($(
																		'<td></td>')
																		.html(
																				emp.frEmpJoiningDate));
														tr
																.append($(
																		'<td  ></td>')
																		.html(
																				emp.empCode));
														tr
																.append($(
																		'<td></td>')
																		.html(
																				"<a href='#' onclick=editFrEmp("
																						+ emp.frEmpId
																						+ ") title='Edit' class='addcust_open'><i class='fa fa-edit'></i></a>&nbsp&nbsp<a href='#' onclick=deletFrEmp("
																						+ emp.frEmpId
																						+ ") title='Delete'><i class='fa fa-trash'></i></a>"));
														$('#table_grid tbody')
																.append(tr);

													})
								});
			}
		}

		function editFrEmp(empId) {

			//$("#slide").hide()

			if (empId != null) {

				$
						.getJSON(
								'${getFrEditEmpById}',

								{
									empId : empId,
									ajax : 'true'
								},
								function(data) {

									//alert(JSON.stringify(data.delStatus)); 

									//$('#addcust').show();
									$('#fr_emp_id').val(data.frEmpId);
									$('#emp_name').val(data.frEmpName);
									$('#curr_bill_amt')
											.val(data.currentBillAmt);
									$('#emp_code').val(data.empCode);
									$('#emp_address').val(data.frEmpAddress);
									$('#emp_contact').val(data.frEmpContact);
									$('#join_date').val(data.frEmpJoiningDate);
									$('#from_date').val(data.exVar2);
									$('#to_date').val(data.exVar3);
									$('#pass').val(data.password);
									$('#ttl_limit').val(data.totalLimit);
									$('#vehicle_no').val(data.exVar1);
									$('#lic_exp_date').val(data.exVar2);
									if (data.designation == 1) {
										document.getElementById("designation").value = data.designation;
									} else if (data.designation == 2) {
										document.getElementById("designation").value = data.designation;
									} else if (data.designation == 3) {
										document.getElementById("designation").value = data.designation;
									} else if (data.designation == 4) {
										document.getElementById("designation").value = data.designation;
									}
									if (data.designation == 4) {
										document.getElementById('vehicle_div').style.display = "block";
										document.getElementById('license_div').style.display = "block";
									} else {
										document.getElementById('vehicle_div').style.display = "none";
										document.getElementById('license_div').style.display = "none";
									}
									if (data.delStatus == 0) {
										document
												.getElementById("emp_status_yes").checked = true;

									} else {
										document
												.getElementById("emp_status_no").checked = true;
									}

									$('#slide').popup('hide');
								});
			}
		}

		/* 
		 $('#sbtbtn4').click(function() {
			 var mobNo = $('#emp_contact').val(); 
			 
				 if (mobNo!=null) {
					
					$
					.getJSON(
							'${verifyUniqueContactNo}',
							{				 
								mobNo : mobNo,
								ajax : 'true'
							},
							function(data) {
								
							//alert("Info : "+JSON.stringify(data)); 
							if(data.error==false){			
								document.getElementById("emp_contact").value = "";
								alert("Contact No. Already Exist.");
								$('#emp_contact').focus();
								return false;
								
							}else{
								return true;
							}
							
							});
						}
		 }); */
	</script>

	<script type="text/javascript">
		function getCurrentEmpCode() {
		
			$.getJSON('${getCurrentEmpCodeValue}', {
				ajax : 'true'
			}, function(data) {

				//alert(JSON.stringify(data)); 
				document.getElementById("emp_code").value = data;

			});

		}
	</script>

</body>




<script type="text/javascript">
	function checkPasswordMatch() {
		var password = $("#txtNewPassword").val();
		var confirmPassword = $("#txtConfirmPassword").val();

		if (password != confirmPassword) {
			document.getElementById("divCheckPasswordMatch").style.color = "#ff0000";
			$("#divCheckPasswordMatch").html("Password not match!");
			document.getElementById("btnupdate_profile").disabled = true;
		} else {
			document.getElementById("divCheckPasswordMatch").style.color = "green";
			$("#divCheckPasswordMatch").html("Password match");
			document.getElementById("btnupdate_profile").disabled = false;
		}
	}

	$(document).ready(function() {
		$("#txtConfirmPassword").keyup(checkPasswordMatch);
	});
</script>


<script type="text/javascript">
	function checkCSPPasswordMatch() {
		var password = $("#csp_password").val();
		var confirmPassword = $("#confirm_csp_password").val();

		if (password != confirmPassword) {
			document.getElementById("divCSPCheckPasswordMatch").style.color = "#ff0000";
			$("#divCSPCheckPasswordMatch").html("Password not match!");
			document.getElementById("btnupdate_profile_csp").disabled = true;
		} else {
			document.getElementById("divCSPCheckPasswordMatch").style.color = "green";
			$("#divCSPCheckPasswordMatch").html("Password match");
			document.getElementById("btnupdate_profile_csp").disabled = false;
		}
	}

	$(document).ready(function() {
		$("#confirm_csp_password").keyup(checkCSPPasswordMatch);
	});
</script>

<script type="text/javascript">
	function checkCaptainPasswordMatch() {
		var password = $("#captain_password").val();
		var confirmPassword = $("#confirm_captain_password").val();

		if (password != confirmPassword) {
			document.getElementById("divCaptainCheckPasswordMatch").style.color = "#ff0000";
			$("#divCaptainCheckPasswordMatch").html("Password not match!");
			document.getElementById("btnupdate_profile_captain").disabled = true;
		} else {
			document.getElementById("divCaptainCheckPasswordMatch").style.color = "green";
			$("#divCaptainCheckPasswordMatch").html("Password match");
			document.getElementById("btnupdate_profile_captain").disabled = false;
		}
	}

	$(document).ready(function() {
		$("#confirm_captain_password").keyup(checkCaptainPasswordMatch);
	});
</script>


<script type="text/javascript">
	function showDiv() {
		document.getElementById('adminDiv').style.display = "block";
		document.getElementById('adminDiv1').style.display = "none";
		document.getElementById('adminDiv2').style.display = "none";

		document.getElementById('adminNewPassDiv').style.display = "none";
		document.getElementById('cspNewPassDiv').style.display = "none";
		document.getElementById('captainNewPassDiv').style.display = "none";

		//alert(${frDetails.frPassword});
		//document.getElementById('txtNewPassword').value = "";

		var pass = $
		{
			frDetails.frPassword
		}
		;
		var csp_pass = $
		{
			frSup.pass3
		}
		;
		var captain_pass = $
		{
			frSup.pass2
		}
		;

		document.getElementById('txtNewPassword').value = pass;

		document.getElementById('txtConfirmPassword').value = pass;

		document.getElementById('csp_password').value = csp_pass;
		document.getElementById('confirm_csp_password').value = csp_pass;

		document.getElementById('captain_password').value = captain_pass;
		document.getElementById('confirm_captain_password').value = captain_pass;

		document.getElementById('admin_password').value = "";
	}
	function showDiv1() {
		document.getElementById('adminDiv1').style.display = "block";
		document.getElementById('adminDiv').style.display = "none";
		document.getElementById('adminDiv2').style.display = "none";

		document.getElementById('adminNewPassDiv').style.display = "none";
		document.getElementById('cspNewPassDiv').style.display = "none";
		document.getElementById('captainNewPassDiv').style.display = "none";

		var pass = $
		{
			frDetails.frPassword
		}
		;
		var csp_pass = $
		{
			frSup.pass3
		}
		;
		var captain_pass = $
		{
			frSup.pass2
		}
		;

		document.getElementById('txtNewPassword').value = pass;

		document.getElementById('txtConfirmPassword').value = pass;

		document.getElementById('csp_password').value = csp_pass;
		document.getElementById('confirm_csp_password').value = csp_pass;

		document.getElementById('captain_password').value = captain_pass;
		document.getElementById('confirm_captain_password').value = captain_pass;

		document.getElementById('admin_password1').value = "";

	}

	function showDiv2() {
		document.getElementById('adminDiv1').style.display = "none";
		document.getElementById('adminDiv').style.display = "none";
		document.getElementById('adminDiv2').style.display = "block";

		document.getElementById('adminNewPassDiv').style.display = "none";
		document.getElementById('cspNewPassDiv').style.display = "none";
		document.getElementById('captainNewPassDiv').style.display = "none";

		var pass = $
		{
			frDetails.frPassword
		}
		;
		var csp_pass = $
		{
			frSup.pass3
		}
		;
		var captain_pass = $
		{
			frSup.pass2
		}
		;

		document.getElementById('txtNewPassword').value = pass;

		document.getElementById('txtConfirmPassword').value = pass;

		document.getElementById('csp_password').value = csp_pass;
		document.getElementById('confirm_csp_password').value = csp_pass;

		document.getElementById('captain_password').value = captain_pass;
		document.getElementById('confirm_captain_password').value = captain_pass;

		document.getElementById('admin_password2').value = "";

	}

	function cancelDiv() {

		document.getElementById('adminDiv1').style.display = "none";
		document.getElementById('adminDiv').style.display = "none";
		document.getElementById('adminDiv2').style.display = "none";

		document.getElementById('adminNewPassDiv').style.display = "none";
		document.getElementById('cspNewPassDiv').style.display = "none";
		document.getElementById('captainNewPassDiv').style.display = "none";

		document.getElementById('txtNewPassword').value = $
		{
			frDetails.frPassword
		}
		;
		document.getElementById('txtConfirmPassword').value = $
		{
			frDetails.frPassword
		}
		;

		document.getElementById('csp_password').value = $
		{
			frSup.pass3
		}
		;
		document.getElementById('confirm_csp_password').value = $
		{
			frSup.pass3
		}
		;

		document.getElementById('captain_password').value = $
		{
			frSup.pass2
		}
		;
		document.getElementById('confirm_captain_password').value = $
		{
			frSup.pass2
		}
		;

	}
</script>
<script type="text/javascript">
	function checkAuthority() {

		var adminPwd = document.getElementById("admin_password").value;

		$
				.getJSON(
						'${checkUserAuthority}',
						{

							adminPwd : adminPwd,
							ajax : 'true'
						},
						function(data) {

							if (data.accessRight == 1) {
								//document.getElementById("changePwd1").disabled = true;
								document.getElementById('txtNewPassword')
										.removeAttribute('disabled');
								document.getElementById('txtConfirmPassword')
										.removeAttribute('disabled');

								$('#txtNewPassword').css('background-color',
										'white'); // change the background color
								$('#txtConfirmPassword').css(
										'background-color', 'white'); // change the background color
								document.getElementById('adminDiv').style.display = "none";
								document.getElementById('updateDiv').style.display = "block";
								document.getElementById('adminNewPassDiv').style.display = "block";

							} else {
								alert("Invalid Credentials");

							}
						}

				);
	}
	function checkAuthForPassChange() {

		var adminPwd = document.getElementById("admin_password1").value;
		$
				.getJSON(
						'${checkUserAuthority}',
						{

							adminPwd : adminPwd,
							ajax : 'true'
						},
						function(data) {

							if (data.accessRight == 1) {
								//document.getElementById("changePwd2").disabled = true;
								//	document.getElementById('user1_password').removeAttribute('disabled');
								//document.getElementById('user2_password').removeAttribute('disabled');
								//document.getElementById('user3_password').removeAttribute('disabled');

								//  $('#user1_password').css('background-color' , 'white'); // change the background color
								//$('#user2_password').css('background-color', 'white'); // change the background color
								//$('#user3_password').css('background-color', 'white'); // change the background color

								document.getElementById('adminDiv1').style.display = "none";
								document.getElementById('updateDiv1').style.display = "block";
								document.getElementById('cspNewPassDiv').style.display = "block";

							} else {
								alert("Invalid Credentials");

							}
						}

				);
	}

	function checkAuthForManagerPassChange() {

		var adminPwd = document.getElementById("admin_password2").value;
		$
				.getJSON(
						'${checkUserAuthority}',
						{

							adminPwd : adminPwd,
							ajax : 'true'
						},
						function(data) {

							//alert("" + data);

							if (data.accessRight == 1) {
								//document.getElementById("changePwd2").disabled = true;
								//	document.getElementById('user1_password').removeAttribute('disabled');
								//document.getElementById('user2_password').removeAttribute('disabled');
								//document.getElementById('user3_password').removeAttribute('disabled');

								//  $('#user1_password').css('background-color' , 'white'); // change the background color
								//$('#user2_password').css('background-color', 'white'); // change the background color
								//$('#user3_password').css('background-color', 'white'); // change the background color

								document.getElementById('adminDiv2').style.display = "none";
								//document.getElementById('adminDiv').style.display = "none";
								document.getElementById('updateDiv2').style.display = "block";
								document.getElementById('captainNewPassDiv').style.display = "block";

							} else {
								alert("Invalid Credentials");

							}
						}

				);
	}

	function updateUserPasswords() {

		//var pass1=document.getElementById('user1_password').value;

		var pass2 = document.getElementById('captain_password').value;

		var pass3 = document.getElementById('csp_password').value;

		//alert("manager - "+pass2+"                 csp - "+pass3);
		$
				.getJSON(
						'${updateUserPasswords}',
						{

							//pass1:pass1,
							pass2 : pass2,
							pass3 : pass3,

							ajax : 'true'
						},
						function(data) {
							if (data.error == false) {

								//document.getElementById("changePwd2").removeAttribute('disabled');
								//	document.getElementById('user1_password').disabled = true;
								//document.getElementById('user2_password').disabled = true;
								//document.getElementById('user3_password').disabled = true;

								//  $('#user1_password').css('background-color' , 'LightGrey'); // change the background color
								//$('#user2_password').css('background-color', 'LightGrey'); // change the background color
								//$('#user3_password').css('background-color', 'LightGrey');
								document.getElementById('updateDiv1').style.display = "none";
								document.getElementById('cspNewPassDiv').style.display = "none";
								document
										.getElementById('divCSPCheckPasswordMatch').style.display = "none";

								document.getElementById('updateDiv2').style.display = "none";
								document.getElementById('captainNewPassDiv').style.display = "none";
								document
										.getElementById('divCaptainCheckPasswordMatch').style.display = "none";

								alert("User Passwords Updated Successfully");

								window.location.reload();

							}

						});
	}

	function updateAdminPassword() {

		var adminPwd = document.getElementById('txtNewPassword').value;
		$
				.getJSON(
						'${updateAdminPassword}',
						{

							adminPwd : adminPwd,

							ajax : 'true'
						},
						function(data) {

							if (data.error == false) {
								//document.getElementById('changePwd1').removeAttribute('disabled');
								//document.getElementById('txtNewPassword').disabled = true;
								//document.getElementById('txtConfirmPassword').disabled = true;

								//$('#txtNewPassword').css('background-color', 'LightGrey'); // change the background color
								//$('#txtConfirmPassword').css('background-color', 'LightGrey'); // 
								document.getElementById('updateDiv').style.display = "none";
								document.getElementById('adminNewPassDiv').style.display = "none";

								alert("Admin Password Updated Successfully");

								$("#divCheckPasswordMatch").html("");

								window.location.reload();

							}

						});
	}
</script>
<script>
	document.getElementById("fr_image").onchange = function() {
		var reader = new FileReader();

		reader.onload = function(e) {
			// get loaded data and render thumbnail.
			document.getElementById("img").src = e.target.result;
		};

		// read the image file as a data URL.
		reader.readAsDataURL(this.files[0]);
	};

	$("#designation").change(function() { // 1st
		var desig = $('#designation').val();

		if (desig == 4) {
			document.getElementById('vehicle_div').style.display = "block";
			document.getElementById('license_div').style.display = "block";
		} else {
			document.getElementById('vehicle_div').style.display = "none";
			document.getElementById('license_div').style.display = "none";
		}
	});
</script>




</html>