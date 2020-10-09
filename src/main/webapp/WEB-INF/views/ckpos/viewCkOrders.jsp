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
		$("#datepicker").datepicker({
			dateFormat : 'dd-mm-yy'
		});
	});
	$(function() {
		$("#datepicker2").datepicker({
			dateFormat : 'dd-mm-yy'
		});
	});
	$(function() {
		$("#datepicker3").datepicker({
			dateFormat : 'dd-mm-yy'
		});
	});
	$(function() {
		$("#datepicker4").datepicker({
			dateFormat : 'dd-mm-yy'
		});
	});
	$(function() {
		$("#datepicker5").datepicker({
			dateFormat : 'dd-mm-yy'
		});
	});
</script>
</head>
<body>



	<c:url var="getOrderDetailListByOrderId"
		value="/getOrderDetailListByOrderId"></c:url>

	<c:url var="getOrdersByFrAndDelDateAjax"
		value="/getOrdersByFrAndDelDateAjax"></c:url>



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
					<div class="order-left" style="width: 100%">
						<br>

						<div class="row">

							<div class="col-md-2">
								<h2 class="pageTitle">Orders</h2>
							</div>
							<div class="col-md-6"></div>

							<div class="col-md-4" style="text-align: right;">

								<input id="datepicker" class="texboxitemcode texboxcal"
									autocomplete="off" placeholder="Delivery Date"
									style="width: 50%" name="datepicker" type="text"
									value="${todaysDate}" onchange="getOrders()"> <input
									name="" class="buttonsaveorder" value="Search" type="button">

							</div>


						</div>

					</div>


					<!--tabNavigation-->
					<div class="cd-tabs">
						<!--tabMenu-->

						<!--tabMenu-->



						<div class="clearfix"></div>

						<div id="table-scroll" class="table-scroll">
							<div id="faux-table" class="faux-table" aria="hidden"></div>
							<div class="table-wrap"
								style="max-height: none; min-height: none;">
								<table id="order_table" class="main-table">
									<thead>
										<tr class="bgpink">
											<th class="col-md-1" style="text-align: center;">Sr No</th>
											<th class="col-md-2" style="text-align: center;">Order
												ID</th>
											<th class="col-md-2" style="text-align: center;">Customer</th>
											<th class="col-md-2" style="text-align: center;">Mobile
												Number</th>
											<th class="col-md-1" style="text-align: center;">Order
												From</th>
											<th class="col-sm-1" style="text-align: center;">Total</th>
											<th class="col-md-2" style="text-align: center;">Status</th>
											<th class="col-md-2" style="text-align: center;">Delivery
												Date</th>
											<th class="col-md-2" style="text-align: center;">Delivery
												Time</th>
											<th class="col-md-2" style="text-align: center;">Kilometer</th>
											<th class="col-md-1" style="text-align: center;">Action</th>

										</tr>
									</thead>
									<tbody>



										<%-- <c:forEach var="i" begin="1" end="5">

											<tr>
												<td class="col-md-1">${i}</td>
												<td class="col-md-1" style="text-align: center;">#2315</td>
												<td class="col-md-1">Test Customer</td>
												<td class="col-md-1" style="text-align: center;">9090909090</td>
												<td class="col-md-1">Mobile App</td>
												<td class="col-md-1" style="text-align: right;">450/-</td>


												<c:choose>

													<c:when test="${i==2}">
														<td class="col-md-1" style="text-align: center;"><input
															type="text" readonly="readonly"
															style="text-align: center; border-radius: 50px 50px 50px 50px; background: #b4ffaf; padding: 5px; width: 100px; border: 1px solid #b4ffaf;"
															value="Completed"></td>
													</c:when>


													<c:when test="${i==4}">
														<td class="col-md-1" style="text-align: center;"><input
															type="text" readonly="readonly"
															style="text-align: center; border-radius: 50px 50px 50px 50px; background: #ffd2d2; padding: 5px; width: 100px; border: 1px solid #ffd2d2;"
															value="Delivered"></td>
													</c:when>

													<c:otherwise>
														<td class="col-md-1" style="text-align: center;"><input
															type="text" readonly="readonly"
															style="text-align: center; border-radius: 50px 50px 50px 50px; background: #fffed2; padding: 5px; width: 100px; border: 1px solid #fffed2;"
															value="Process"></td>
													</c:otherwise>

												</c:choose>



												<td class="col-md-1" style="text-align: center;">13/07/2020</td>
												<td class="col-md-1" style="text-align: center;">11:30am</td>
												<td class="col-md-1" style="text-align: right;">7</td>
												<td class="col-md-1" style="text-align: center;"><a
													onclick="openBillPopup()" title="view/generate bill"><i
														class="fa fa-shopping-cart" aria-hidden="true"></i></a> &nbsp;

													<a href="#" title="KOT">KOT</a> &nbsp; <a href="#"
													title="GST Bill"><i class="fa fa-file-pdf-o"
														aria-hidden="true"></i></a></td>

												</td>

											</tr>

										</c:forEach> --%>


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


		<div id="billPopup" class="add_customer" style="width: 60%;">
			<button class="addcust_close close_popup" onclick="closeBillPopup()">
				<i class="fa fa-times" aria-hidden="true"></i>
			</button>
			<h3 class="pop_head">
				<div class="row" style="margin-right: 25px;">

					<div class="col-lg-3" style="margin-top: 5px;">Generate Bill</div>
					<div class="col-lg-9" id="statusDiv"></div>

				</div>
			</h3>

			<div class="col-lg-12">

				<div class="row" style="margin-left: 15px; margin-right: 15px;">

					<div class="col-lg-2" style="padding-left: 15px;">
						<div class="add_frm" style="padding: 0px; border-bottom: 0px">
							<div class="add_frm_one" style="margin: 0;">
								<div class="add_customer_one"
									style="font-size: 14px; width: 100%">Order ID :</div>
							</div>

						</div>
					</div>
					<div class="col-lg-4">
						<div class="add_frm"
							style="padding: 0px 0px 0px 15px; border-bottom: 0px">
							<div class="add_frm_one" style="margin: 0">
								<div class="add_customer_one"
									style="font-size: 14px; width: 100%;" id="orderNoDiv"></div>
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
									style="font-size: 14px; width: 100%;" id="delDateDiv"></div>
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
									style="font-size: 14px; width: 100%;" id="custNameDiv"></div>
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
									style="font-size: 14px; width: 100%">Address :</div>
							</div>

						</div>
					</div>

					<div class="col-lg-10">
						<div class="add_frm"
							style="padding: 0px 0px 0px 15px; border-bottom: 0px">
							<div class="add_frm_one" style="margin: 0">
								<div class="add_customer_one"
									style="font-size: 14px; width: 100%;" id="addressDiv"></div>
							</div>

						</div>
					</div>


				</div>


				<div class="row" style="margin-left: 15px; margin-right: 15px;">

					<div class="col-lg-2" style="padding-left: 15px;">
						<div class="add_frm" style="padding: 0px; border-bottom: 0px">
							<div class="add_frm_one" style="margin: 0;">
								<div class="add_customer_one"
									style="font-size: 14px; width: 100%">Pincode :</div>
							</div>

						</div>
					</div>
					<div class="col-lg-4">
						<div class="add_frm"
							style="padding: 0px 0px 0px 15px; border-bottom: 0px">
							<div class="add_frm_one" style="margin: 0">
								<div class="add_customer_one"
									style="font-size: 14px; width: 100%;" id="pincodeDiv"></div>
							</div>

						</div>
					</div>

					<div class="col-lg-3" style="padding-left: 15px;">
						<div class="add_frm"
							style="padding: 0px 0px 0px 15px; border-bottom: 0px">
							<div class="add_frm_one" style="margin: 0;">
								<div class="add_customer_one"
									style="font-size: 14px; width: 100%">Kilometer :</div>
							</div>

						</div>
					</div>

					<div class="col-lg-3" style="padding-left: 15px;">
						<div class="add_frm" style="padding: 0px; border-bottom: 0px">
							<div class="add_frm_one" style="margin: 0;">
								<div class="add_customer_one"
									style="font-size: 14px; width: 100%;" id="kmDiv"></div>
							</div>

						</div>
					</div>

				</div>
				<br>

				<div class="row">

					<div id="table-scroll" class="table-scroll" style="width: 90%">
						<div class="table-responsive"
							style="max-height: none; min-height: none;">
							<table id="table_grid" class="main-table">
								<thead>
									<tr class="bgpink">
										<th class="col-md-1"
											style="text-align: center; padding: 0 !important; font-size: 14px;">SR</th>
										<th class="col-md-2"
											style="text-align: center; padding: 0 !important; font-size: 14px;">PRODUCT</th>
										<th class="col-md-1"
											style="text-align: center; padding: 0 !important; font-size: 14px;">QTY</th>
										<th class="col-sm-1"
											style="text-align: center; padding: 0 !important; font-size: 14px;">UOM</th>
										<th class="col-md-1"
											style="text-align: center; padding: 0 !important; font-size: 14px;">PRICE</th>
										<th class="col-md-1"
											style="text-align: center; padding: 0 !important; font-size: 14px;">DISCOUNT</th>
										<th class="col-md-1"
											style="text-align: center; padding: 0 !important; font-size: 14px;">TOTAL</th>

									</tr>
								</thead>
								<tbody>

									<%-- <c:forEach var="i" begin="1" end="3">

										<tr>
											<td class="col-md-1"
												style="padding: 2 !important; font-size: 14px;">${i}</td>
											<td class="col-md-1"
												style="padding: 2 !important; font-size: 14px;">Madhvi
												Penda</td>
											<td class="col-md-1"
												style="text-align: right; padding: 2 !important; font-size: 14px;">5.00</td>
											<td class="col-md-1"
												style="padding: 2 !important; font-size: 14px;">Kgs</td>
											<td class="col-md-1"
												style="text-align: right; padding: 2 !important; font-size: 14px;">480</td>
											<td class="col-md-1"
												style="text-align: right; padding: 2 !important; font-size: 14px;">0</td>
											<td class="col-md-1"
												style="text-align: right; padding: 2 !important; font-size: 14px;">2400.00</td>

										</tr>

									</c:forEach> --%>


								</tbody>

							</table>
						</div>
					</div>

				</div>

				<div class="row" style="margin-left: 15px; margin-right: 15px;">

					<div class="col-lg-6" style="padding-left: 15px;">
						<div class="add_frm" style="padding: 0px; border-bottom: 0px">
							<div class="add_frm_one" style="margin: 0">
								<div class="add_customer_one" style="font-size: 14px;">Total
									UOM :</div>
							</div>

						</div>
					</div>
					<div class="col-lg-6">
						<div class="add_frm" style="padding: 0px; border-bottom: 0px">
							<div class="add_frm_one" style="margin: 0">
								<div class="add_customer_one"
									style="font-size: 14px; width: 100%; text-align: right;"
									id="uomDiv"></div>
							</div>

						</div>
					</div>

				</div>


				<div class="row"
					style="margin-left: 15px; margin-right: 15px; background: #ffe5e6">

					<div class="col-lg-3" style="padding-left: 15px;">
						<div class="add_frm" style="padding: 0px; border-bottom: 0px">
							<div class="add_frm_one" style="margin: 0;">
								<div class="add_customer_one"
									style="font-size: 14px; width: 100%">Total Items :</div>
							</div>

						</div>
					</div>
					<div class="col-lg-2">
						<div class="add_frm"
							style="padding: 0px 0px 0px 15px; border-bottom: 0px">
							<div class="add_frm_one" style="margin: 0">
								<div class="add_customer_one" style="font-size: 14px;"
									id="totalItemsDiv"></div>
							</div>

						</div>
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

					<div class="col-lg-4" style="padding-left: 15px;">
						<div class="add_frm" style="padding: 0px; border-bottom: 0px">
							<div class="add_frm_one" style="margin: 0;">
								<div class="add_customer_one"
									style="font-size: 14px; width: 100%; text-align: right;"
									id="totalDiv">0</div>
							</div>

						</div>
					</div>

				</div>


				<div class="row" style="margin-left: 15px; margin-right: 15px;">

					<div class="col-lg-3" style="padding-left: 15px;"></div>

					<div class="col-lg-2"></div>

					<div class="col-lg-3" style="padding-left: 15px;">
						<div class="add_frm"
							style="padding: 0px 0px 0px 15px; border-bottom: 0px">
							<div class="add_frm_one" style="margin: 0;">
								<div class="add_customer_one"
									style="font-size: 14px; width: 100%">Order Tax :</div>
							</div>

						</div>
					</div>

					<div class="col-lg-4" style="padding-left: 15px;">
						<div class="add_frm" style="padding: 0px; border-bottom: 0px">
							<div class="add_frm_one" style="margin: 0;">
								<div class="add_customer_one"
									style="font-size: 14px; width: 100%; text-align: right;"
									id="orderTaxDiv">0</div>
							</div>

						</div>
					</div>

				</div>


				<div class="row"
					style="margin-left: 15px; margin-right: 15px; background: #e5ffeb">

					<div class="col-lg-3" style="padding-left: 15px;">
						<div class="add_frm" style="padding: 0px; border-bottom: 0px">
							<div class="add_frm_one" style="margin: 0;">
								<div class="add_customer_one"
									style="font-size: 14px; width: 100%">Item Discount :</div>
							</div>

						</div>
					</div>
					<div class="col-lg-2">
						<div class="add_frm"
							style="padding: 0px 0px 0px 15px; border-bottom: 0px">
							<div class="add_frm_one" style="margin: 0">
								<div class="add_customer_one" style="font-size: 14px;"
									id="itemDiscDiv">0</div>
							</div>

						</div>
					</div>

					<div class="col-lg-3" style="padding-left: 15px;">
						<div class="add_frm"
							style="padding: 0px 0px 0px 15px; border-bottom: 0px">
							<div class="add_frm_one" style="margin: 0;">
								<div class="add_customer_one"
									style="font-size: 14px; width: 100%">Bill Discount :</div>
							</div>

						</div>
					</div>

					<div class="col-lg-4" style="padding-left: 15px;">
						<div class="add_frm" style="padding: 0px; border-bottom: 0px">
							<div class="add_frm_one" style="margin: 0;">
								<div class="add_customer_one"
									style="font-size: 14px; width: 100%; text-align: right;"
									id="billDiscDiv">0</div>
							</div>

						</div>
					</div>

				</div>


				<div class="row"
					style="margin-left: 15px; margin-right: 15px; background: #fefcd5">

					<div class="col-lg-3" style="padding-left: 15px;">
						<div class="add_frm" style="padding: 0px; border-bottom: 0px">
							<div class="add_frm_one" style="margin: 0;">
								<div class="add_customer_one"
									style="font-size: 14px; width: 100%">Total Payable :</div>
							</div>

						</div>
					</div>
					<div class="col-lg-2"></div>

					<div class="col-lg-3" style="padding-left: 15px;">
						<div class="add_frm"
							style="padding: 0px 0px 0px 15px; border-bottom: 0px">
							<div class="add_frm_one" style="margin: 0;">
								<div class="add_customer_one"
									style="font-size: 14px; width: 100%"></div>
							</div>

						</div>
					</div>

					<div class="col-lg-4" style="padding-left: 15px;">
						<div class="add_frm" style="padding: 0px; border-bottom: 0px">
							<div class="add_frm_one" style="margin: 0;">
								<div class="add_customer_one"
									style="font-size: 14px; width: 100%; text-align: right;"
									id="totalPayableDiv">0</div>
							</div>

						</div>
					</div>

				</div>

				<!-- <div class="row" style="margin-left: 15px; margin-right: 15px;">

					<div class="col-lg-3" style="padding-left: 15px;">
						<div class="add_frm" style="padding: 0px; border-bottom: 0px">
							<div class="add_frm_one" style="margin: 0;">
								<div class="add_customer_one"
									style="font-size: 14px; width: 100%">Payment Mode :</div>
							</div>

						</div>
					</div>


					<div class="col-lg-9" style="padding-left: 15px;">
						<div class="add_frm"
							style="padding: 0px 0px 0px 15px; border-bottom: 0px">
							<div class="add_frm_one" style="margin: 0;">
								<div class="add_customer_one"
									style="font-size: 14px; width: 100%">COD</div>
							</div>

						</div>
					</div>

				</div> -->

				<div class="row"
					style="margin-left: 15px; margin-right: 15px; background: #e5ffeb">

					<div class="col-lg-3" style="padding-left: 15px;">
						<div class="add_frm" style="padding: 0px; border-bottom: 0px">
							<div class="add_frm_one" style="margin: 0;">
								<div class="add_customer_one"
									style="font-size: 14px; width: 100%">Payment Mode :</div>
							</div>

						</div>
					</div>
					<div class="col-lg-2">
						<div class="add_frm"
							style="padding: 0px 0px 0px 15px; border-bottom: 0px">
							<div class="add_frm_one" style="margin: 0">
								<div class="add_customer_one" style="font-size: 14px;"
									id="payModeDiv"></div>
							</div>

						</div>
					</div>

					<div class="col-lg-3" style="padding-left: 15px;">
						<div class="add_frm"
							style="padding: 0px 0px 0px 15px; border-bottom: 0px">
							<div class="add_frm_one" style="margin: 0;">
								<div class="add_customer_one"
									style="font-size: 14px; width: 100%">Grievance :</div>
							</div>

						</div>
					</div>

					<div class="col-lg-4" style="padding-left: 15px;">
						<div class="add_frm" style="padding: 0px; border-bottom: 0px">
							<div class="add_frm_one" style="margin: 0;">
								<div class="add_customer_one"
									style="font-size: 14px; width: 100%; text-align: right;"
									id="grievanceDiv"></div>
							</div>

						</div>
					</div>

				</div>

				<div class="row"
					style="margin-left: 15px; margin-right: 15px; background: #fff">

					<div class="col-lg-3" style="padding-left: 15px;">
						<div class="add_frm" style="padding: 0px; border-bottom: 0px">
							<div class="add_frm_one" style="margin: 0;">
								<div class="add_customer_one"
									style="font-size: 14px; width: 100%">Remark :</div>
							</div>

						</div>
					</div>
					<div class="col-lg-2">
						<div class="add_frm"
							style="padding: 0px 0px 0px 15px; border-bottom: 0px">
							<div class="add_frm_one" style="margin: 0">
								<div class="add_customer_one" style="font-size: 14px;"
									id="remarkDiv"></div>
							</div>

						</div>
					</div>
				</div>

				<div class="row"
					style="margin-left: 15px; margin-right: 15px; background: #fff">

					<div class="col-lg-3" style="padding-left: 15px;">
						<div class="add_frm" style="padding: 0px; border-bottom: 0px">
							<div class="add_frm_one" style="margin: 0;">
								<div class="add_customer_one"
									style="font-size: 14px; width: 100%">Delivery Boy :</div>
							</div>

						</div>
					</div>
					<div class="col-lg-9">
						<div class="add_frm"
							style="padding: 0px 0px 0px 15px; border-bottom: 0px">
							<div class="add_frm_one" style="margin: 0">
								<Select id="deliveryBoy" name="deliveryBoy" style="width: 100%">
									<c:forEach items="${deliveryBoyList}" var="delBoy">
										<option value="${delBoy.frEmpId}">${delBoy.frEmpName}
											- ${delBoy.frEmpContact}</option>
									</c:forEach>
								</Select>
							</div>

						</div>
					</div>





				</div>

				<br>
				<div class="row" style="margin-left: 15px; margin-right: 15px;">

					<div class="col-lg-4">
						<button class="hold can_btn" onclick="closeBillPopup()">REJECT</button>
					</div>
					<div class="col-lg-4">
						<button class="hold hold_btn" onclick="closeBillPopup()">KOT</button>
					</div>
					<div class="col-lg-4">
						<button class="hold pay_btn" onclick="closeBillPopup()">GST
							BILL</button>
					</div>


				</div>
				<br>


			</div>



		</div>



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

			//getOrderDetails(orderId)
			$('#billPopup').popup('show');

			var orderList = sessionStorage.getItem("orderList");
			var table = $.parseJSON(orderList);

			//console.log(table);
			for (var i = 0; i < table.length; i++) {

				if (orderId == table[i].orderId) {

					console.log(table[i].orderDetailList);

					document.getElementById("orderNoDiv").innerHTML = "#"
							+ table[i].orderNo;
					document.getElementById("delDateDiv").innerHTML = table[i].deliveryDate
							+ " " + table[i].deliveryTime;
					document.getElementById("custNameDiv").innerHTML = table[i].custName;
					document.getElementById("mobileDiv").innerHTML = table[i].whatsappNo;
					document.getElementById("addressDiv").innerHTML = table[i].address;
					document.getElementById("pincodeDiv").innerHTML = table[i].pincode;
					document.getElementById("kmDiv").innerHTML = table[i].deliveryKm;

					document.getElementById("totalDiv").innerHTML = table[i].totalAmt;

					document.getElementById("orderTaxDiv").innerHTML = table[i].taxAmt;

					document.getElementById("itemDiscDiv").innerHTML = table[i].itemDiscAmt;
					document.getElementById("billDiscDiv").innerHTML = table[i].discAmt;
					document.getElementById("totalPayableDiv").innerHTML = table[i].totalAmt;
					document.getElementById("payModeDiv").innerHTML = table[i].paymentMethod;
					document.getElementById("grievanceDiv").innerHTML = "";
					document.getElementById("remarkDiv").innerHTML = table[i].remark;

					var process = "<input type=text readonly=readonly style='text-align: center; border-radius: 50px 50px 50px 50px; background: #fffed2; padding: 5px; width: 100px; border: 1px solid #fffed2;' value=Process>";
					var pending = "<input type=text readonly=readonly style='text-align: center; border-radius: 50px 50px 50px 50px; background: #fffed2; padding: 5px; width: 100px; border: 1px solid #fffed2;' value=Pending>";
					var complete = "<input type=text readonly=readonly style='text-align: center; border-radius: 50px 50px 50px 50px; background: #b4ffaf; padding: 5px; width: 100px; border: 1px solid #fffed2;' value=complete>";

					if (table[i].orderStatus == 0) {
						document.getElementById("statusDiv").innerHTML = process;
					} else {
						document.getElementById("statusDiv").innerHTML = complete;
					}

					getOrderDetails(table[i].orderDetailList);

					break;

				}
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
		function getOrders() {

			var delDate = $("#datepicker").val();

			//alert(delDate);

			$
					.getJSON(
							'${getOrdersByFrAndDelDateAjax}',
							{
								delDate : delDate,
								ajax : 'true'

							},
							function(data) {

								//alert(JSON.stringify(data));

								sessionStorage.setItem("orderList", JSON
										.stringify(data));

								$('#order_table td').remove();

								$
										.each(
												data,
												function(key, order) {

													var tr = $('<tr></tr>');

													tr.append($('<td></td>')
															.html(key + 1));

													tr
															.append($(
																	'<td style="text-align: center;"></td>')
																	.html(
																			order.orderNo));

													tr
															.append($(
																	'<td></td>')
																	.html(
																			order.custName));

													tr
															.append($(
																	'<td style="text-align: center;"></td>')
																	.html(
																			order.whatsappNo));

													var platform = "";

													if (order.orderPlatform == 1) {
														platform = "Executive"
													} else if (order.orderPlatform == 2) {
														platform = "Mobile App"
													}

													tr.append($('<td></td>')
															.html(platform));

													tr
															.append($(
																	'<td style="text-align: right;"></td>')
																	.html(
																			order.totalAmt));

													var status = "";

													if (order.orderStatus == 0) {
														status = "<input type=text readonly style='text-align: center; border-radius: 50px 50px 50px 50px; background: #fffed2; padding: 5px; width: 100px; border: 1px solid #fffed2;' value=Process>";
													} else if (order.orderStatus == 1) {
														status = "<input type=text readonly style='text-align: center; border-radius: 50px 50px 50px 50px; background: #b4ffaf; padding: 5px; width: 100px; border: 1px solid #b4ffaf;' value=Completed>";
													} else {
														status = "<input type=text readonly style='text-align: center; border-radius: 50px 50px 50px 50px; background: #b4ffaf; padding: 5px; width: 100px; border: 1px solid #b4ffaf;' value=Completed>";
													}

													tr
															.append($(
																	'<td style="text-align: center;"></td>')
																	.html(
																			status));

													tr
															.append($(
																	'<td style="text-align: center;"></td>')
																	.html(
																			order.deliveryDate));

													tr
															.append($(
																	'<td style="text-align: center;"></td>')
																	.html(
																			order.deliveryTime));

													tr.append($('<td style="text-align: right;"></td>')
															.html(order.deliveryKm));

													var view = "<a onclick='openBillPopup("
															+ order.orderId
															+ ")' title='view/generate bill'><i class='fa fa-shopping-cart' aria-hidden='true'></i></a> &nbsp;";

													var kotUrl = "${pageContext.request.contextPath}/printOrderKot/"
															+ order.orderId;
													//alert(JSON.parse(order));

													//var kot = "<a href="+kotUrl+" title='KOT'>KOT</a> &nbsp;";
													var kot = "<a href=# title=KOT onclick='printKOT("+key+")'>KOT</a> &nbsp;";

													
													
													var gst = "<a href=# title='GST Bill'><i class='fa fa-file-pdf-o' aria-hidden='true'></i></a> &nbsp;";

													tr
															.append($(
																	'<td style="text-align: center;"></td>')
																	.html(
																			view
																					+ " "
																					+ kot
																					+ " "
																					+ gst));

													$('#order_table tbody')
															.append(tr);

												});

							});

		}
	</script>

	<script type="text/javascript">
		function printKOT(index) {

			var url = "${pageContext.request.contextPath}/printOrderKot/"
					+ index;

			$("<iframe>").hide().attr("src", url).appendTo("body");

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
