<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>



<jsp:include page="/WEB-INF/views/include/header.jsp" />

<html>
<head>
<style>
table, th, td {
	border: 1px solid #9da88d;
}

.select2-selection--multiple .select2-selection__rendered {
	border-bottom: 1px solid #ddd;
}
</style>


<!-- -----------------------------------------CODE FOR MULTIPLE DROPDOWN (CSS)------------------------------------------------------------ -->

<!-- chosen CSS ============================================ -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/dropdownmultiple/bootstrap-chosen.css">

<!-- ----------------------------------------------------END------------------------------------------------------------ -->



<!--datepicker-->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery-ui.js"></script>
<script>
	$(function() {
		$("#todatepicker").datepicker({
			dateFormat : 'dd-mm-yy'
		});
	});
	$(function() {
		$("#fromdatepicker").datepicker({
			dateFormat : 'dd-mm-yy'
		});
	});
</script>
</head>
<body>



	<c:url var="getOrderListByStatus" value="/getOrderListByStatusAjax"></c:url>
	<c:url var="getStatusList" value="/getStatusList"></c:url>
	<c:url var="getOrderDashDetailByFrId" value="/getOrderDashDetailByFrId"></c:url>


	<!--topLeft-nav-->
	<div class="sidebarOuter"></div>
	<!--topLeft-nav-->

	<!--wrapper-start-->
	<div class="wrapper">


		<jsp:include page="/WEB-INF/views/include/logo.jsp"></jsp:include>


		<!--topHeader-->

		<!--rightContainer-->
		<div class="fullGrid center">
			<!--fullGrid-->
			<div class="wrapperIn2">

				<jsp:include page="/WEB-INF/views/include/left.jsp">
					<jsp:param name="myMenu" value="${menuList}" />
				</jsp:include>


				<!--rightSidebar-->
				<br>
				<div class="sidebarright">
					<div class="row">
						<br>
						<div class="col-md-12">
							<h2 class="pageTitle">Order List</h2>
						</div>
						<br>
					</div>
					<br>

					<div class="row">

						<div class="col-md-2" style="float: none;">
							<h4 class="pull-left">From Date:-</h4>
						</div>
						<div class="col-md-4">
							<input id="fromdatepicker" class="texboxitemcode texboxcal"
								autocomplete="off" placeholder="DD-MM-YYYY" name="fromDate"
								type="text" value="${todaysDate}">
						</div>
						<div class="col-md-2">
							<h4 class="pull-left">To Date:-</h4>
						</div>
						<div class="col-md-4">
							<input id="todatepicker" class="texboxitemcode texboxcal"
								autocomplete="off" placeholder="DD-MM-YYYY" name="toDate"
								type="text" value="${todaysDate}">
						</div>


					</div>

					<div class="row">
						<div class="col-md-2" style="float: none;">
							<h4 class="pull-left">Order Status:-</h4>
						</div>
						<div class="col-md-8">
							<select class="chosen-select" name="status" id="statusId"
								multiple="multiple" onchange="selectOpt(this.value)">
								<option value="-1" style="text-align: left;">All</option>
								<c:forEach items="${statusList}" var="status" varStatus="count">
									<option value="${status.statusId}" style="text-align: left;">${status.statusValue}</option>
								</c:forEach>
							</select>
						</div>
						<div class="col-md-2">
							<button class="buttonsaveorder" onclick="getOrderDetailData()"
								style="margin-left: 75px;">Search</button>
						</div>
					</div>
				</div>
				<!--tabNavigation-->
				<div class="row">
					<div class="col-md-12">
						<div class="clearfix"></div>

						<div id="table-scroll" class="table-scroll">
							<div class="table-wrap"
								style="max-height: none; min-height: none; z-index: 0;">
								<table id="order_table" class="main-table">
									<thead>
										<tr class="bgpink">
											<th class="col-md-1" style="text-align: center;">Sr No</th>
											<th class="col-md-2" style="text-align: center;">Order
												No.</th>
											<th class="col-md-2" style="text-align: center;">Delivery
												Date</th>
											<th class="col-md-2" style="text-align: center;">Customer</th>
											<th class="col-md-2" style="text-align: center;">Time
												Slot</th>
											<th class="col-md-1" style="text-align: center;">Order
												Status</th>
											<th class="col-sm-1" style="text-align: center;">Payment
												Mode</th>
											<th class="col-md-2" style="text-align: center;">Total</th>
											<th class="col-md-1" style="text-align: center;">Action</th>

										</tr>
									</thead>
									<tbody>
									</tbody>

								</table>
							</div>
						</div>

						<br /> 
					</div>


				</div>

				<br> <br>



			</div>
			<!--tabNavigation-->


			<!--fullGrid-->
		</div>
		<!--rightContainer-->

<!-- Bill PopUp -->
		<div id="billPopup" class="add_customer" style="width: 60%;">
		<button class="addcust_close close_popup" onclick="closeBillPopup()">
			<i class="fa fa-times" aria-hidden="true"></i>
		</button>
		<h3 class="pop_head">
			<div class="row" style="margin-right: 25px;">

				<div class="col-lg-3" style="margin-top: 5px;">Order Detail</div>
				<div class="col-lg-9" id="statusDiv"></div>

			</div>
		</h3>

		<div class="col-lg-12">

			<div class="row" style="margin-left: 15px; margin-right: 15px;">

				<div class="col-lg-2" style="padding-left: 15px;">
					<div class="add_frm" style="padding: 0px; border-bottom: 0px">
						<div class="add_frm_one" style="margin: 0;">
							<div class="add_customer_one"
								style="font-size: 14px; width: 100%">Order No :</div>
						</div>

					</div>
				</div>
				<div class="col-lg-4">
					<div class="add_frm"
						style="padding: 0px 0px 0px 15px; border-bottom: 0px">
						<div class="add_frm_one" style="margin: 0">
							<div class="add_customer_one"
								style="font-size: 14px; width: 100%;" id="orderNo"></div>
						</div>

					</div>
				</div>

				<div class="col-lg-3" style="padding-left: 15px;">
					<div class="add_frm"
						style="padding: 0px 0px 0px 15px; border-bottom: 0px">
						<div class="add_frm_one" style="margin: 0;">
							<div class="add_customer_one"
								style="font-size: 14px; width: 100%">Delivery Date :</div>
						</div>

					</div>
				</div>

				<div class="col-lg-3" style="padding-left: 15px;">
					<div class="add_frm" style="padding: 0px; border-bottom: 0px">
						<div class="add_frm_one" style="margin: 0;">
							<div class="add_customer_one"
								style="font-size: 14px; width: 100%;" id="dateTime"></div>
						</div>

					</div>
				</div>

			</div>

			<div class="row" style="margin-left: 15px; margin-right: 15px;">

				<div class="col-lg-2" style="padding-left: 15px;">
					<div class="add_frm" style="padding: 0px; border-bottom: 0px">
						<div class="add_frm_one" style="margin: 0;">
							<div class="add_customer_one"
								style="font-size: 14px; width: 100%">Customer :</div>
						</div>

					</div>
				</div>
				<div class="col-lg-4">
					<div class="add_frm"
						style="padding: 0px 0px 0px 15px; border-bottom: 0px">
						<div class="add_frm_one" style="margin: 0">
							<div class="add_customer_one"
								style="font-size: 14px; width: 100%;" id="custName"></div>
						</div>

					</div>
				</div>

				<div class="col-lg-3" style="padding-left: 15px;">
					<div class="add_frm"
						style="padding: 0px 0px 0px 15px; border-bottom: 0px">
						<div class="add_frm_one" style="margin: 0;">
							<div class="add_customer_one"
								style="font-size: 14px; width: 100%">Mobile Number :</div>
						</div>

					</div>
				</div>

				<div class="col-lg-3" style="padding-left: 15px;">
					<div class="add_frm" style="padding: 0px; border-bottom: 0px">
						<div class="add_frm_one" style="margin: 0;">
							<div class="add_customer_one"
								style="font-size: 14px; width: 100%;" id="mobileDiv"></div>
						</div>

					</div>
				</div>

			</div>


			<div class="row" style="margin-left: 15px; margin-right: 15px;">
			
				<div class="col-lg-2" style="padding-left: 15px;">
					<div class="add_frm" style="padding: 0px; border-bottom: 0px">
						<div class="add_frm_one" style="margin: 0;">
							<div class="add_customer_one"
								style="font-size: 14px; width: 100%">Order Type :</div>
						</div>

					</div>
				</div>
				<div class="col-lg-4">
					<div class="add_frm"
						style="padding: 0px 0px 0px 15px; border-bottom: 0px">
						<div class="add_frm_one" style="margin: 0">
							<div class="add_customer_one"
								style="font-size: 14px; width: 100%;" id="orderType"></div>
						</div>

					</div>
				</div>
				
				<div class="col-lg-3" style="padding-left: 15px;">
					<div class="add_frm"
						style="padding: 0px 0px 0px 15px; border-bottom: 0px">
						<div class="add_frm_one" style="margin: 0;">
							<div class="add_customer_one"
								style="font-size: 14px; width: 100%">Order Status :</div>
						</div>

					</div>
				</div>

				<div class="col-lg-3" style="padding-left: 15px;">
					<div class="add_frm" style="padding: 0px; border-bottom: 0px">
						<div class="add_frm_one" style="margin: 0;">
							<div class="add_customer_one"
								style="font-size: 14px; width: 100%;" id="orderStatus"></div>
						</div>

					</div>
				</div>
			</div>


			<div class="row" style="margin-left: 15px; margin-right: 15px;">
			<div class="col-lg-2" style="padding-left: 15px;">
					<div class="add_frm" style="padding: 0px; border-bottom: 0px">
						<div class="add_frm_one" style="margin: 0;">
							<div class="add_customer_one"
								style="font-size: 14px; width: 100%">Payment Mode :</div>
						</div>

					</div>
				</div>
				<div class="col-lg-4">
					<div class="add_frm"
						style="padding: 0px 0px 0px 15px; border-bottom: 0px">
						<div class="add_frm_one" style="margin: 0">
							<div class="add_customer_one"
								style="font-size: 14px; width: 100%;" id="payMode"></div>
						</div>

					</div>
				</div>
				
				<div class="col-lg-3" style="padding-left: 15px;">
					<div class="add_frm"
						style="padding: 0px 0px 0px 15px; border-bottom: 0px">
						<div class="add_frm_one" style="margin: 0;">
							<div class="add_customer_one"
								style="font-size: 14px; width: 100%">Payment Status :</div>
						</div>

					</div>
				</div>

				<div class="col-lg-3" style="padding-left: 15px;">
					<div class="add_frm" style="padding: 0px; border-bottom: 0px">
						<div class="add_frm_one" style="margin: 0;">
							<div class="add_customer_one"
								style="font-size: 14px; width: 100%;" id="pamentStat"></div>
						</div>

					</div>
				</div>
			</div>
			
			<div class="row" style="margin-left: 15px; margin-right: 15px;">
				<div class="col-lg-6">					
				</div>
				
				
				<div class="col-lg-3" style="padding-left: 15px;">
					<div class="add_frm"
						style="padding: 0px 0px 0px 15px; border-bottom: 0px">
						<div class="add_frm_one" style="margin: 0;">
							<div class="add_customer_one"
								style="font-size: 14px; width: 100%">Total :</div>
						</div>

					</div>
				</div>

				<div class="col-lg-3" style="padding-left: 15px;">
					<div class="add_frm" style="padding: 0px; border-bottom: 0px">
						<div class="add_frm_one" style="margin: 0;">
							<div class="add_customer_one"
								style="font-size: 14px; width: 100%;" id="ttlAmt"></div>
						</div>

					</div>
				</div>
			</div>
			<br>

			<div class="row">
				<div id="table-scroll" class="table-scroll" style="width: 100%">
					<div class="table-responsive"
						style="max-height: none; min-height: none;">
						<table id="order_dtl_table" class="main-table">
							<thead>
								<tr class="bgpink">
									<th class="col-md-1"
										style="text-align: center; padding: 0 !important; font-size: 14px;">SR</th>
									<th class="col-md-2"
										style="text-align: center; padding: 0 !important; font-size: 14px;">Items Name</th>
									<th class="col-md-1"
										style="text-align: center; padding: 0 !important; font-size: 14px;">Product Image</th>
									<th class="col-sm-1"
										style="text-align: center; padding: 0 !important; font-size: 14px;">Rate</th>
									<th class="col-md-1"
										style="text-align: center; padding: 0 !important; font-size: 14px;">Quantity</th>
									<th class="col-md-1"
										style="text-align: center; padding: 0 !important; font-size: 14px;">Total</th>

								</tr>
							</thead>
							<tbody>

							</tbody>
						</table>
					</div>
				</div>
			</div>
			
			<div class="col-lg-12">

			<div class="row" style="margin-left: 15px; margin-right: 15px;">

				
				<div class="col-lg-6"> </div>

				<div class="col-lg-3" style="padding-left: 15px;">
					<div class="add_frm"
						style="padding: 0px 0px 0px 15px; border-bottom: 0px">
						<div class="add_frm_one" style="margin: 0;">
							<div class="add_customer_one"
								style="font-size: 14px; width: 100%">Product Total :</div>
						</div>

					</div>
				</div>

				<div class="col-lg-3" style="padding-left: 15px;">
					<div class="add_frm" style="padding: 0px; border-bottom: 0px">
						<div class="add_frm_one" style="margin: 0;">
							<div class="add_customer_one"
								style="font-size: 16px; width: 100%; margin-left: 109px;" id="taxableAmt"></div>
						</div>
					</div>
				</div>
				
				<div class="col-lg-6"> </div>

				<div class="col-lg-3" style="padding-left: 15px;">
					<div class="add_frm"
						style="padding: 0px 0px 0px 15px; border-bottom: 0px">
						<div class="add_frm_one" style="margin: 0;">
							<div class="add_customer_one"
								style="font-size: 14px; width: 100%">Tax :</div>
						</div>

					</div>
				</div>

				<div class="col-lg-3" style="padding-left: 15px;">
					<div class="add_frm" style="padding: 0px; border-bottom: 0px">
						<div class="add_frm_one" style="margin: 0;">
							<div class="add_customer_one"
								style="font-size: 16px; width: 100%; margin-left: 109px;" id="taxAmt"></div>
						</div>
					</div>
				</div>
				
				<div class="col-lg-6"> </div>

				<div class="col-lg-3" style="padding-left: 15px;">
					<div class="add_frm"
						style="padding: 0px 0px 0px 15px; border-bottom: 0px">
						<div class="add_frm_one" style="margin: 0;">
							<div class="add_customer_one"
								style="font-size: 14px; width: 100%">Offer Discount :</div>
						</div>

					</div>
				</div>

				<div class="col-lg-3" style="padding-left: 15px;">
					<div class="add_frm" style="padding: 0px; border-bottom: 0px">
						<div class="add_frm_one" style="margin: 0;">
							<div class="add_customer_one"
								style="font-size: 16px; width: 100%; margin-left: 109px;" id="discAmt"></div>
						</div>
					</div>
				</div>
				
				<div class="col-lg-6"> </div>

				<div class="col-lg-3" style="padding-left: 15px;">
					<div class="add_frm"
						style="padding: 0px 0px 0px 15px; border-bottom: 0px">
						<div class="add_frm_one" style="margin: 0;">
							<div class="add_customer_one"
								style="font-size: 14px; width: 100%">Delivery Charges :</div>
						</div>

					</div>
				</div>

				<div class="col-lg-3" style="padding-left: 15px;">
					<div class="add_frm" style="padding: 0px; border-bottom: 0px">
						<div class="add_frm_one" style="margin: 0;">
							<div class="add_customer_one"
								style="font-size: 16px; width: 65%; margin-left: 109px;
								 border-bottom: solid;  border-width: thin" id="deliveryCharges"></div>
						</div>
					</div>
				</div>
				
				
				<div class="col-lg-6"> </div>

				<div class="col-lg-3" style="padding-left: 15px;">
					<div class="add_frm"
						style="padding: 0px 0px 0px 15px; border-bottom: 0px">
						<div class="add_frm_one" style="margin: 0;">
							<div class="add_customer_one"
								style="font-size: 14px; width: 100%">Total :</div>
						</div>

					</div>
				</div>

				<div class="col-lg-3" style="padding-left: 15px;">
					<div class="add_frm" style="padding: 0px; border-bottom: 0px">
						<div class="add_frm_one" style="margin: 0;">
							<div class="add_customer_one"
								style="font-size: 16px; width: 100%; margin-left: 109px;  border-bottom: none;" id="totalOrderAmt"></div>
						</div>
					</div>
				</div>

			</div>
			</div>
			
			<div class="row">
				<div id="table-scroll" class="table-scroll" style="width: 100%">
					<div class="table-responsive"
						style="max-height: none; min-height: none;">
						<table id="order_trail_table" class="main-table">
							<thead>
								<tr class="bgpink">
									<th class="col-md-1"
										style="text-align: center; padding: 0 !important; font-size: 14px;">SR</th>
									<th class="col-md-2"
										style="text-align: center; padding: 0 !important; font-size: 14px;">Status</th>
									<th class="col-md-1"
										style="text-align: center; padding: 0 !important; font-size: 14px;">Action By</th>
									<th class="col-sm-1"
										style="text-align: center; padding: 0 !important; font-size: 14px;">Date Time</th>

								</tr>
							</thead>
							<tbody>

							</tbody>
						</table>
					</div>
				</div>
			</div>

			<br>
		</div>
	</div>
		
		<input type="hidden" value="${imagePath}" id="imgPath"> <input
			type="hidden" value="${fromDate}" name="fromDate" id="fromDate">
		<input type="hidden" value="${toDate}" name="toDate" id="toDate">


	</div>
	<!--wrapper-end-->

	<script type="text/javascript">
		$(document).ready(function() {
			$('#billPopup').popup({
				focusdelay : 400,
				outline : true,
				vertical : 'top'
			});
		});
	</script>

	<script type="text/javascript">
	function openBillPopup(orderId) {
		//alert(orderId)
		$('#order_dtl_table td').remove();	
		var imgPath = $("#imgPath").val();
		if (orderId > 0) {

			$
					.getJSON(
							'${getOrderDashDetailByFrId}',
							{

								ajax : 'true'

							},
							function(data) {
							//	alert("Hi----------"+JSON.stringify(data[0].deliveryDateDisplay))
								$('#billPopup').popup('show');
								for (var i = 0; i < data.length; i++) {

									if (data[i].orderId == orderId) {
										
										var orderStatus = null;
										var paymentMode = null;
										var pamentStatus = null;
										var orderType = null;
										var trailStatus = null;

										if (data[i].orderStatus == 0) {
											orderStatus = "Park Order";
										} else if (data[i].orderStatus == 1) {
											orderStatus = "Shop Confirmation Pending";
										} else if (data[i].orderStatus == 2) {
											orderStatus = "Accept";
										} else if (data[i].orderStatus == 3) {
											orderStatus = "Processing";
										} else if (data[i].orderStatus == 4) {
											orderStatus = "Delivery Pending";
										} else if (data[i].orderStatus == 5) {
											orderStatus = "Delivered";
										} else if (data[i].orderStatus == 6) {
											status = "Rejected by Shop";
										} else if (data[i].orderStatus == 7) {
											orderStatus = "Return Order";
										} else if (data[i].orderStatus == 8) {
											orderStatus = "Cancelled Order";
										}

										if (data[i].paymentMethod == 1) {
											paymentMode = "Cash";
										} else if (data[i].paymentMethod == 2) {
											paymentMode = "Card";
										} else if (data[i].paymentMethod == 3) {
											paymentMode = "E-Pay";
										} else {
											paymentMode = "";
										}

										if (data[i].orderPlatform == 1) {
											orderType = "Executive";
										} else if (data[i].orderPlatform == 2) {
											orderType = "Mobile App";
										} else {
											orderType = "Web Site";
										}

										if (data[i].paidStatus == 0) {
											pamentStatus = "Pending";
										} else {
											pamentStatus = "Paid";
										}
										
										document.getElementById("orderNo").innerHTML = data[i].orderNo;
										document.getElementById("custName").innerHTML = data[i].custName;
										document.getElementById("mobileDiv").innerHTML = data[i].custMobile;
										document
												.getElementById("orderStatus").innerHTML = orderStatus;
										document
												.getElementById("pamentStat").innerHTML = pamentStatus;
										document.getElementById("dateTime").innerHTML = data[i].deliveryDateDisplay
												+ " "
												+ data[i].deliveryTimeDisplay;
										document
												.getElementById("orderType").innerHTML = orderType;
										document.getElementById("payMode").innerHTML = paymentMode;
										document.getElementById("ttlAmt").innerHTML = data[i].totalAmt;
										
										document
										.getElementById("taxableAmt").innerHTML = data[i].taxableAmt;
										
										document.getElementById("taxAmt").innerHTML = data[i].igstAmt;
										document.getElementById("discAmt").innerHTML = data[i].discAmt;
										document
												.getElementById("deliveryCharges").innerHTML = data[i].deliveryCharges;
										document
												.getElementById("totalOrderAmt").innerHTML = data[i].totalAmt;

										
										$
												.each(
														data[i].orderDetailList,
														function(key, itm) {			
															
															var itemPic = '<img src="'+imgPath+itm.itemPic+'"  width="50" height="50" alt="Product Image">';
																	
																	
															var tr = $('<tr style="background:##03a9f4;"></tr>');
															tr
															.append($(
																	'<td style="padding: 2 !important; font-size: 14px;"></td>')
																	.html(key + 1));


															tr
																	.append($(
																			'<td  style="padding: 12px; line-height:0; border-top: 1px solid #ddd;"></td>')
																			.html(
																					itm.itemName));
															tr
																	.append($(
																			'<td style="padding: 12px; line-height:0; border-top: 1px solid #ddd;""></td>')
																			.html(itemPic));

															tr
																	.append($(
																			'<td style="padding: 12px; line-height:0; border-top: 1px solid #ddd;""></td>')
																			.html(
																					itm.mrp));

															tr
																	.append($(
																			'<td style="padding: 12px; line-height:0; border-top: 1px solid #ddd;""></td>')
																			.html(
																					itm.qty));

															tr
																	.append($(
																			'<td style="padding: 12px; line-height:0; border-top: 1px solid #ddd;""></td>')
																			.html(
																					itm.mrp
																							* itm.qty));

															$(
																	'#order_dtl_table tbody')
																	.append(
																			tr);

														});

										//***************************************Trail Table*****************************************//

										$('#order_trail_table td').remove();

										$
												.each(
														data[i].orderTrailList,
														function(key, trail) {

															if (trail.status == 0) {
																trailStatus = "Park Orde";
															} else if (trail.status == 1) {
																trailStatus = "Shop Confirmation Pending";
															} else if (trail.status == 2) {
																trailStatus = "Accept";
															} else if (trail.status == 3) {
																trailStatus = "Processing";
															} else if (trail.status == 4) {
																trailStatus = "Delivery Pending";
															} else if (trail.status == 5) {
																trailStatus = "Delivered";
															} else if (trail.status == 6) {
																trailStatus = "Rejected by Shop";
															} else if (trail.status == 7) {
																trailStatus = "Return Order";
															} else if (trail.status == 8) {
																trailStatus = "Cancelled Order";
															}

															var tr = $('<tr style="background:##03a9f4;"></tr>');
															tr
															.append($(
																	'<td style="padding: 2 !important; font-size: 14px;"></td>')
																	.html(key + 1));


															tr
																	.append($(
																			'<td  style="padding: 12px; line-height:0; border-top: 1px solid #ddd;"></td>')
																			.html(
																					trailStatus));
															tr
																	.append($(
																			'<td style="padding: 12px; line-height:0; border-top: 1px solid #ddd;""></td>')
																			.html(
																					trail.userName));

															tr
																	.append($(
																			'<td style="padding: 12px; line-height:0; border-top: 1px solid #ddd;""></td>')
																			.html(
																					trail.trailDate));

															$(
																	'#order_trail_table tbody')
																	.append(
																			tr);

														});

										break;

									}
								}

							});
		}
	}
		function closeBillPopup() {

			$('#billPopup').popup('hide');

		}
	</script>


	<!-- chosen JS
		============================================ -->
	<script
		src="${pageContext.request.contextPath}/resources/dropdownmultiple/chosen.jquery.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/dropdownmultiple/chosen-active.js"></script>

	<!-- ======================================================================== -->
	<script type="text/javascript">
		function selectOpt(statusId) {
			//	alert(statusId)
			if (statusId == -1) {

				$
						.getJSON(
								'${getStatusList}',
								{
									ajax : 'true'
								},
								function(data) {
									//alert("OK"+JSON.stringify(data))
									var len = data.length;

									$('#statusId').find('option').remove()
											.end()
									for (var i = 0; i < len; i++) {
										$('#statusId')
												.append(
														$(
																'<option selected style="text-align: left;"></option>')
																.attr(
																		'value',
																		data[i].statusId)
																.text(
																		data[i].statusValue));
									}
									$('.chosen-select').trigger(
											"chosen:updated");
								});
			}
		}
	</script>
	<script type="text/javascript">
		function getOrderDetailData() {
			$('#order_table td').remove();
			//$('#loader').show();
			var statusId = $("#statusId").val();
			var fromDate = $("#fromdatepicker").val();
			var toDate = $("#todatepicker").val();
			//alert(statusId + " " + fromDate + " " + toDate);

			$
					.getJSON(
							'${getOrderListByStatus}',
							{
								fromDate : fromDate,
								toDate : toDate,
								statusId : JSON.stringify(statusId),
								ajax : 'true'
							},
							function(data) {
								//	$('#loader').hide();
								if (data == null) {
									alert("No Data Found!");
								}

								var orderTtlAmt = 0;
								$
										.each(
												data,
												function(key, order) {

													var orderStatus = null;
													var paymentMode = null;

													var acStr = '<a href="javascript:void(0)" class="list-icons-item text-primary-600" data-popup="tooltip" title="" data-original-title="Order Detail" onclick="openBillPopup('
															+ order.orderId
															+ ')"><i class="fa fa-list"></i></a>'

													if (order.paymentMethod == 1) {
														paymentMode = "Cash";
													} else if (order.paymentMethod == 2) {
														paymentMode = "Card";
													} else {
														paymentMode = "E-Pay";
													}

													if (order.orderStatus == 0) {
														orderStatus = "Park Order";
													} else if (order.orderStatus == 1) {
														orderStatus = "Shop Confirmation Pending";
													} else if (order.orderStatus == 2) {
														orderStatus = "Accept";
													} else if (order.orderStatus == 3) {
														orderStatus = "Processing";
													} else if (order.orderStatus == 4) {
														orderStatus = "Delivery Pending";
													} else if (order.orderStatus == 5) {
														orderStatus = "Delivered";
													} else if (order.orderStatus == 6) {
														orderStatus = "Rejected by Shop";
													} else if (order.orderStatus == 7) {
														orderStatus = "Return Order";
													} else if (order.orderStatus == 8) {
														orderStatus = "Cancelled Order";
													}

													var tr = $('<tr style="background:##03a9f4;"></tr>');

													tr
															.append($(
																	'<td  style=""></td>')
																	.html(
																			key + 1));

													tr
															.append($(
																	'<td style=""></td>')
																	.html(
																			order.orderNo));

													tr
															.append($(
																	'<td style=""></td>')
																	.html(
																			order.deliveryDateDisplay));

													tr
															.append($(
																	'<td style=""></td>')
																	.html(
																			order.custName
																					+ " - "
																					+ order.custMobile));

													tr
															.append($(
																	'<td style=""></td>')
																	.html(
																			order.deliveryTimeDisplay));

													tr
															.append($(
																	'<td style=""></td>')
																	.html(
																			orderStatus));

													tr
															.append($(
																	'<td style=""></td>')
																	.html(
																			paymentMode));

													orderTtlAmt = orderTtlAmt
															+ order.totalAmt;
													tr
															.append($(
																	'<td style=""></td>')
																	.html(
																			order.totalAmt));

													tr
															.append($(
																	'<td style=""></td>')
																	.html(acStr));

													$('#order_table tbody')
															.append(tr);

												});

								var tr = "<tr>";
								var td1 = "<td colspan='7'>&nbsp;&nbsp;&nbsp;<b> Total</b></td>";
								var td2 = "<td><b><b>"
										+ addCommas((orderTtlAmt).toFixed(2));
								+"</b></td>";
								var trclosed = "</tr>";

								$('#order_table tbody').append(tr);
								$('#order_table tbody').append(td1);
								$('#order_table tbody').append(td2);
								$('#order_table tbody').append(trclosed);

							});
		}
	</script>

	<script type="text/javascript">
		function getOrderDetail(orderId) {
			$('#order_dtl_table td').remove();
			alert(orderId)
			var imgPath = $("#imgPath").val();
			if (orderId > 0) {

				$
						.getJSON(
								'${getOrderDashDetailByFrId}',
								{

									ajax : 'true'

								},
								function(data) {

									$('#modal_large').modal('toggle');
									for (var i = 0; i < data.length; i++) {

										if (data[i].orderId == orderId) {
											var status = null;
											var paymentMode = null;
											var pamentStatus = null;
											var orderType = null;
											var trailStatus = null;

											if (data[i].orderStatus == 0) {
												status = "Park Order";
											} else if (data[i].orderStatus == 1) {
												status = "Shop Confirmation Pending";
											} else if (data[i].orderStatus == 2) {
												status = "Accept";
											} else if (data[i].orderStatus == 3) {
												status = "Processing";
											} else if (data[i].orderStatus == 4) {
												status = "Delivery Pending";
											} else if (data[i].orderStatus == 5) {
												status = "Delivered";
											} else if (data[i].orderStatus == 6) {
												status = "Rejected by Shop";
											} else if (data[i].orderStatus == 7) {
												status = "Return Order";
											} else if (data[i].orderStatus == 8) {
												status = "Cancelled Order";
											}

											if (data[i].paymentMethod == 1) {
												paymentMode = "Cash";
											} else if (data[i].paymentMethod == 2) {
												paymentMode = "Card";
											} else if (data[i].paymentMethod == 3) {
												paymentMode = "E-Pay";
											} else {
												paymentMode = "";
											}

											if (data[i].orderPlatform == 1) {
												orderType = "Executive";
											} else if (data[i].orderPlatform == 2) {
												orderType = "Mobile App";
											} else {
												orderType = "Web Site";
											}

											if (data[i].paidStatus == 0) {
												pamentStatus = "Pending";
											} else {
												pamentStatus = "Paid";
											}

											document.getElementById("orderNo").value = data[i].orderNo;
											document.getElementById("custName").value = data[i].custName
													+ "-" + data[i].custMobile;
											document.getElementById("frName").value = data[i].frName;
											document
													.getElementById("orderStatus").value = status;
											document
													.getElementById("pamentStat").value = pamentStatus;
											document.getElementById("dateTime").value = data[i].deliveryDateDisplay
													+ " "
													+ data[i].deliveryTimeDisplay;
											document
													.getElementById("orderType").value = orderType;
											document.getElementById("payMode").value = paymentMode;
											document.getElementById("ttlAmt").value = data[i].totalAmt;

											document
													.getElementById("taxableAmt").value = data[i].taxableAmt;
											document.getElementById("taxAmt").value = data[i].igstAmt;
											document.getElementById("discAmt").value = data[i].discAmt;
											document
													.getElementById("deliveryCharges").value = data[i].deliveryCharges;
											document
													.getElementById("totalOrderAmt").value = data[i].totalAmt;

											$
													.each(
															data[i].orderDetailList,
															function(key, itm) {

																var itemPic = '<img src="'+imgPath+itm.itemPic+'"  width="50" height="50" alt="Product Image">';

																var tr = $('<tr style="background:##03a9f4;"></tr>');

																tr
																		.append($(
																				'<td  style="padding: 12px; line-height:0; border-top: 1px solid #ddd;"></td>')
																				.html(
																						itm.itemName));
																tr
																		.append($(
																				'<td style="padding: 12px; line-height:0; border-top: 1px solid #ddd;""></td>')
																				.html(
																						itemPic));

																tr
																		.append($(
																				'<td style="padding: 12px; line-height:0; border-top: 1px solid #ddd;""></td>')
																				.html(
																						itm.mrp));

																tr
																		.append($(
																				'<td style="padding: 12px; line-height:0; border-top: 1px solid #ddd;""></td>')
																				.html(
																						itm.qty));

																tr
																		.append($(
																				'<td style="padding: 12px; line-height:0; border-top: 1px solid #ddd;""></td>')
																				.html(
																						itm.mrp
																								* itm.qty));

																$(
																		'#order_dtl_table tbody')
																		.append(
																				tr);

															});

											//***************************************Trail Table*****************************************//

											$('#order_trail_table td').remove();

											$
													.each(
															data[i].orderTrailList,
															function(key, trail) {

																if (trail.status == 0) {
																	trailStatus = "Park Orde";
																} else if (trail.status == 1) {
																	trailStatus = "Shop Confirmation Pending";
																} else if (trail.status == 2) {
																	trailStatus = "Accept";
																} else if (trail.status == 3) {
																	trailStatus = "Processing";
																} else if (trail.status == 4) {
																	trailStatus = "Delivery Pending";
																} else if (trail.status == 5) {
																	trailStatus = "Delivered";
																} else if (trail.status == 6) {
																	trailStatus = "Rejected by Shop";
																} else if (trail.status == 7) {
																	trailStatus = "Return Order";
																} else if (trail.status == 8) {
																	trailStatus = "Cancelled Order";
																}

																var tr = $('<tr style="background:##03a9f4;"></tr>');

																tr
																		.append($(
																				'<td  style="padding: 12px; line-height:0; border-top: 1px solid #ddd;"></td>')
																				.html(
																						trailStatus));
																tr
																		.append($(
																				'<td style="padding: 12px; line-height:0; border-top: 1px solid #ddd;""></td>')
																				.html(
																						trail.userName));

																tr
																		.append($(
																				'<td style="padding: 12px; line-height:0; border-top: 1px solid #ddd;""></td>')
																				.html(
																						trail.trailDate));

																$(
																		'#order_trail_table tbody')
																		.append(
																				tr);

															});

											break;

										}
									}

								});
			}
		}
	</script>


	<script type="text/javascript">
		$(document).ready(function() {

			getOrders();
			//getLiveList();
		});

		function getOrderDetails(data) {

			//alert(JSON.stringify(data));

			$('#table_grid td').remove();

			var uomIdArray = [];
			var uomDisplayArray = [];

			$
					.each(
							data,
							function(key, item) {

								var tr = $('<tr></tr>');

								tr
										.append($(
												'<td style="padding: 2 !important; font-size: 14px;"></td>')
												.html(key + 1));

								tr
										.append($(
												'<td style="padding: 2 !important; font-size: 14px;"></td>')
												.html(item.itemName));

								tr
										.append($(
												'<td style="padding: 2 !important; font-size: 14px;"></td>')
												.html(item.qty));

								tr
										.append($(
												'<td style="padding: 2 !important; font-size: 14px;"></td>')
												.html(item.itemUom));

								tr
										.append($(
												'<td style="padding: 2 !important; font-size: 14px;"></td>')
												.html(item.mrp));

								tr
										.append($(
												'<td style="padding: 2 !important; font-size: 14px;"></td>')
												.html(item.discAmt));

								tr
										.append($(
												'<td style="padding: 2 !important; font-size: 14px;"></td>')
												.html(item.totalAmt));

								$('#table_grid tbody').append(tr);

								if (!uomIdArray.includes(item.uomId)) {
									uomIdArray.push(item.uomId);
								}

							});

			for (var i = 0; i < uomIdArray.length; i++) {

				var uomDisplay = "";
				var qty = 0;
				var uomName = "";

				var totalQty = 0;

				for (var j = 0; j < data.length; j++) {

					if (uomIdArray[i] == data[j].uomId) {
						qty = qty + data[j].qty;
						uomName = data[j].itemUom;
						totalQty = totalQty + data[j].qty;
					}

				}

				uomDisplay = uomName + " = " + qty;
				uomDisplayArray.push(uomDisplay);
			}

			//alert(uomDisplayArray);

			var displayUom = "";
			for (var i = 0; i < uomDisplayArray.length; i++) {
				displayUom = displayUom + "&nbsp;&nbsp;&nbsp;"
						+ uomDisplayArray[i] + "&nbsp;&nbsp;&nbsp;";
			}
			displayUom = displayUom + "&nbsp;&nbsp;&nbsp;  TOTAL = " + totalQty;

			document.getElementById("uomDiv").innerHTML = displayUom;

			document.getElementById("totalItemsDiv").innerHTML = data.length;

		}
	</script>


</body>
</html>
