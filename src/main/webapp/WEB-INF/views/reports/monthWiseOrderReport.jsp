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

chosen-container {
	width: 82%;
}
.select2-selection--multiple .select2-selection__rendered {
	border-bottom: 1px solid #ddd;
}

.hide-calendar .ui-datepicker-calendar {
	display: none;
}
</style>


<!-- -----------------------------------------CODE FOR MULTIPLE DROPDOWN (CSS)------------------------------------------------------------ -->

<!-- chosen CSS ============================================ -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/dropdownmultiple/bootstrap-chosen.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/loader.css">
<!-- ----------------------------------------------------END------------------------------------------------------------ -->



<!--datepicker-->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery-ui.js"></script>
<!-- <script>
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
</script> -->
</head>
<body>

<c:url var="getMonthlyBillsReport" value="/getMonthlyBillsReport"></c:url>
<c:url var="getDateWiseCustDtlReport" value="/getDateWiseCustDtlReport"></c:url>


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
							<h2 class="pageTitle">Month Wise Bill Report</h2>
						</div>
						<br>
					</div>
					<br>

					<div class="row">

						<div class="col-md-2" style="float: none;">
							<h4 class="pull-left">From Date:-</h4>
						</div>
						<div class="col-md-3">
							<input id="fromdatepicker" class="texboxitemcode texboxcal float_l"
								autocomplete="off" placeholder="From Month" name="fromDate"
								type="text" value="${frommonth}">
						</div>
						<div class="col-md-1">
							<h4 class="pull-left">To Date:-</h4>
						</div>
						<div class="col-md-3">
							<input id="todatepicker" class="texboxitemcode texboxcal float_l"
								autocomplete="off" placeholder="To Month" name="toDate"
								type="text" value="${tomonth}">
						</div>
						<div class="col-md-3">
							<button class="buttonsaveorder" onclick="getMonthlyRep()" >Search</button>							
							
							<button class="buttonsaveorder" value="PDF" id="PDFButton"
								onclick="genPdf()" >PDF</button>
						</div>

					</div>

				<div class="clearfix"></div>
				<!--tabNavigation-->
				<div class="row">
					<div class="col-md-12">
						<div class="clearfix"></div>

						<div class="table-responsive marg_bx" >
								<div id="table-scroll" class="table-scroll responsive-table-one">							
									<table id="order_table" class="responsive-table">
									<thead>
										<tr class="bgpink">
											<th style="text-align: center;">Sr No</th>											
											<th style="text-align: center;">Month</th>
											<th style="text-align: center;">Year</th>
											<th style="text-align: center;">No. Of Bills</th>											
											<th style="text-align: center;">Total Amt</th>											
											<th style="text-align: center;">COD</th>
											<th style="text-align: center;">Card</th>
											<th style="text-align: center;">E-Pay</th>
											<th style="text-align: center;">Detail</th>
										</tr>
									</thead>
									<tbody>
									</tbody>

								</table>
							</div>
						</div>
					</div>
				</div>
				<div class="clearfix"></div>
				<div class="row" style="text-align: left; margin: 15px 0;">
						<div class="form-group" style="display: none;" id="range">
								<div class="controls">
									<input type="button" id="expExcel" class="buttonsaveorder"
										value="EXPORT TO Excel" onclick="exportToExcel();"
										disabled="disabled">
							</div>
						</div>	
				</div>
				</div>
				<!--rightSidebar-->
			</div>
			<!--tabNavigation-->


			<!--fullGrid-->
		</div>
		<!--rightContainer-->
		
		<script type="text/javascript">
		function getMonthlyRep() {
			$('#order_table td').remove();
			//$('#loader').show();			
			var fromDate = $("#fromdatepicker").val();
			var toDate = $("#todatepicker").val();
		//	alert(fromDate + " " + toDate);

			$
					.getJSON(
							'${getMonthlyBillsReport}',
							{
								fromDate : fromDate,
								toDate : toDate,
								ajax : 'true'
							},
							function(data) {
								//	$('#loader').hide();
								if (data == null) {
									alert("No Data Found!");
								}
								//document.getElementById("PDFButton").style.display = "block";
								document.getElementById("range").style.display = "block";
								document.getElementById("expExcel").disabled = false;
								var orderTtlAmt = 0;
								$
										.each(
												data,
												function(key, order) {
													var acStr = '<a href="javascript:void(0)" class="list-icons-item text-primary-600" data-popup="tooltip" title="" data-original-title="Order Detail" onclick="openBillPopup(\''
															+ order.billDate
															+ '\')"><i class="fa fa-list"></i></a>'


													

													var tr = $('<tr style="background:##03a9f4;"></tr>');

													tr
															.append($(
																	'<td  style="text-align: center;"></td>')
																	.html(
																			key + 1));

													tr
															.append($(
																	'<td style="text-align: center;"></td>')
																	.html(
																			order.monthName));
													tr
													.append($(
															'<td style="text-align: center;"></td>')
															.html(
																	order.orderYear));
													
													tr
													.append($(
															'<td style="text-align: center;"></td>')
															.html(
																	order.totalBills));

													orderTtlAmt = orderTtlAmt
													+ order.totalAmt;
													tr
															.append($(
																	'<td style="text-align: center;"></td>')
																	.html(
																			order.totalAmt));

													
													tr
													.append($(
															'<td style="text-align: center;"></td>')
															.html(
																	order.cod));
													
													tr
													.append($(
															'<td style="text-align: center;"></td>')
															.html(
																	order.card));
													
													tr
													.append($(
															'<td style="text-align: center;"></td>')
															.html(
																	order.epay));

													

													tr
															.append($(
																	'<td style="text-align: center;"></td>')
																	.html(acStr));

													$('#order_table tbody')
															.append(tr);

												});

								var tr = "<tr>";
								var td1 = "<td colspan='5'>&nbsp;&nbsp;&nbsp;<b> Total</b></td>";
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

<!-- Bill PopUp -->
		<div id="billPopup" class="add_customer" style="width: 60%;">
		<button class="addcust_close close_popup" onclick="closeBillPopup()">
			<i class="fa fa-times" aria-hidden="true"></i>
		</button>
		<h3 class="pop_head">
			<div class="row" style="margin-right: 25px;">

				<div class="col-lg-10" style="margin-top: 5px;">Order Date Wise Customer Purchase Detail</div>
				<div class="col-lg-2" id="statusDiv"></div>

			</div>
		</h3>

		<div class="col-lg-12">	

			<div><!-- class="row" -->
				<div id="table-scroll" class="table-scroll" style="width: 100%">
					<div class="table-responsive"
						style="max-height: none; min-height: none;">
						<table id="order_dtl_table" class="main-table">
							<thead>
								<tr class="bgpink">
									<th style="text-align: center; padding: 0 !important; font-size: 14px;">SR</th>
									<th style="text-align: center; padding: 0 !important; font-size: 14px;">Bill No.</th>
									<th style="text-align: center; padding: 0 !important; font-size: 14px;">Bill Date</th>
									<th style="text-align: center; padding: 0 !important; font-size: 14px;">Bill Amt.</th>
									<th style="text-align: center; padding: 0 !important; font-size: 14px;">Payment Mode</th>
									<th style="text-align: center; padding: 0 !important; font-size: 14px;">Delivery Boy</th>

								</tr>
							</thead>
							<tbody>

							</tbody>
						</table>
					</div>
				</div>
			</div>		
				
			<br>
			 <div class="row"
				style="margin-left: 15px; margin-right: 15px; display: flex; text-align: center;">
				<input type="button" id="dtlExpExcel" class="buttonsaveorder"
										value="EXPORT TO Excel" onclick="exportToExcelDtl();"
						disabled="disabled">
			</div> 
			<br>
		</div>
	</div>		
	</div>
	<input type="hidden" value="${frId}" id="frId">
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
	function openBillPopup(orderDate) {
		//alert(orderDate)
		
		$('#order_dtl_table td').remove();	
		
		if (orderDate != null) {

			$
					.getJSON(
							'${getDateWiseCustDtlReport}',
							{
								fromDate : orderDate,
								toDate : orderDate,
								ajax : 'true'
							},
							function(data) {
								document.getElementById("dtlExpExcel").disabled = false;
								$('#billPopup').popup('show');	
								var ttlBillAmt = 0;
								
								$
								.each(
										data,
										function(key, itm) {		
											
													
											var tr = $('<tr style="background:##03a9f4;"></tr>');
											tr
											.append($(
													'<td style="padding: 2 !important; font-size: 14px; text-align: center;"></td>')
													.html(key + 1));
	

											tr
													.append($(
															'<td  style="padding: 12px; line-height:0; border-top: 1px solid #ddd; text-align: center; "></td>')
															.html(
																	itm.invoiceNo));
											tr
											.append($(
													'<td  style="padding: 12px; line-height:0; border-top: 1px solid #ddd; text-align: center; "></td>')
													.html(
															itm.billDate));
											
											ttlBillAmt = ttlBillAmt+itm.grandTotal;
											
											tr
											.append($(
													'<td  style="padding: 12px; line-height:0; border-top: 1px solid #ddd; text-align: center; "></td>')
													.html(
															itm.grandTotal));
											
											tr
													.append($(
															'<td style="padding: 12px; line-height:0; border-top: 1px solid #ddd; text-align: center; "></td>')
															.html(itm.paymentMode == 1 ? 'Cash' : itm.paymentMode == 2 ? 'Card' : 'E-Pay' ));

											tr
													.append($(
															'<td style="padding: 12px; line-height:0; border-top: 1px solid #ddd; text-align: center; "></td>')
															.html(
																	itm.delvrBoyName));
											
											
											$(
													'#order_dtl_table tbody')
													.append(
															tr);

										});
								/* alert(ttlBillAmt)
								var tr1 = "<tr>";
								var td1 = "<td colspan='2'>&nbsp;&nbsp;&nbsp;<b> Total</b></td>";
								var td2 = "<td><b>"
										+ addCommas((ttlBillAmt).toFixed(2));
								+"</b></td>";
								var trclosed = "</tr>";
								$('#order_dtl_table tbody').append(tr1);
								$('#order_dtl_table tbody').append(td1);
								$('#order_dtl_table tbody').append(td2);
								$('#order_dtl_table tbody').append(trclosed); */

							});
		}
	}
	
	function closeBillPopup() {
		$('#billPopup').popup('hide');
		document.getElementById("deliveryDiv").style.display = "none";
		document.getElementById("enterRemarkDiv").style.display = "none";
		document.getElementById("remarkLbl").innerHTML = "";
		document.getElementById("enterRemark").value = "";
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
		function genPdf() {
			var fromDate = document.getElementById("fromdatepicker").value;
			var toDate = document.getElementById("todatepicker").value;
			var frId = $("#frId").val(); 
			 window
				.open('${pageContext.request.contextPath}/pdfReport?url=pdf/getMonthWiseBillPdf/'
						+fromDate
						+ '/'
						+ toDate
						+ '/'
						+ frId);
			/* var isValid = validate();
			if (isValid == true) {
				var fromDate = document.getElementById("fromdatepicker").value;
				var toDate = document.getElementById("todatepicker").value;
				var frId = document.getElementById("frId").value;
				var cust = $("#selCust").val();
				
				var configType = document.getElementById("selConfigType").value;

				 window
						.open('${pageContext.request.contextPath}/pdfReport?reportURL=pdf/getOrderReportPdf/'
								+ fromDate
								+ '/'
								+ toDate
								+ '/'
								+ frId
								+ '/'
								+ cust + '/' + configType); 
				
			} */

		}
		
		function exportToExcel() {

			window.open("${pageContext.request.contextPath}/exportToExcel");
			document.getElementById("expExcel").disabled = true;
		}
		
		function exportToExcelDtl() {
			window.open("${pageContext.request.contextPath}/exportToExcelDummy");
			document.getElementById("expExcel").disabled = true;
		}
		function validate() {

			var fromDate = $("#fromdatepicker").val();
			var toDate = $("#todatepicker").val();

			var isValid = true;

			if (fromDate == "" || fromDate == null) {

				isValid = false;
				alert("Please select From Date");
			} else if (toDate == "" || toDate == null) {

				isValid = false;
				alert("Please select To Date");
			}
			return isValid;

		}
	</script>
	<script>
	$(document)
	.ready(
			function() {
				$('#fromdatepicker')
						.datepicker(
								{
									changeMonth : true,
									changeYear : true,
									dateFormat : 'mm-yy',

									onClose : function() {
										var iMonth = $(
												"#ui-datepicker-div .ui-datepicker-month :selected")
												.val();
										var iYear = $(
												"#ui-datepicker-div .ui-datepicker-year :selected")
												.val();
										$(this).datepicker(
												'setDate',
												new Date(iYear,
														iMonth, 1));
									},

									beforeShow : function() {
										$('#ui-datepicker-div')
												.addClass(
														'hide-calendar');

										/*  if ((selDate = $(this).val()).length > 0) 
										 {
										    iYear = selDate.substring(selDate.length - 4, selDate.length);
										    iMonth = jQuery.inArray(selDate.substring(0, selDate.length - 5), $(this).datepicker('option', 'monthNames'));
										    $(this).datepicker('option', 'defaultDate', new Date(iYear, iMonth, 1));
										     $(this).datepicker('setDate', new Date(iYear, iMonth, 1));
										 } */
									}
								});
			});
	
		$(document)
				.ready(
						function() {
							$('#todatepicker')
									.datepicker(
											{
												changeMonth : true,
												changeYear : true,
												dateFormat : 'mm-yy',

												onClose : function() {
													var iMonth = $(
															"#ui-datepicker-div .ui-datepicker-month :selected")
															.val();
													var iYear = $(
															"#ui-datepicker-div .ui-datepicker-year :selected")
															.val();
													$(this).datepicker(
															'setDate',
															new Date(iYear,
																	iMonth, 1));
												},

												beforeShow : function() {
													$('#ui-datepicker-div')
															.addClass(
																	'hide-calendar');

													/*   if ((selDate = $(this).val()).length > 0) 
													  {
													     iYear = selDate.substring(selDate.length - 4, selDate.length);
													     iMonth = jQuery.inArray(selDate.substring(0, selDate.length - 5), $(this).datepicker('option', 'monthNames'));
													     $(this).datepicker('option', 'defaultDate', new Date(iYear, iMonth, 1));
													     $(this).datepicker('setDate', new Date(iYear, iMonth, 1));
													  } */
												}
											});
						});
	</script>
	
</body>
</html>