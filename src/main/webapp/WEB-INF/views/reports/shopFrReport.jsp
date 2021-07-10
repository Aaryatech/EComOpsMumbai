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
</style>

 <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

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

<link rel="stylesheet" type="text/css" href="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/css/jquery.dataTables.css">
</head>
<body>

<c:url var="getOrderBetDateAndStatus" value="/getOrderBetDateAndStatus"></c:url>
<c:url var="getOrderStatusListRep" value="/getOrderStatusListRep"></c:url>
<c:url var="getShopFranchiseReport" value="/getShopFranchiseReport"></c:url>
<c:url value="/getStatusListAjax" var="getStatusListAjax" />

<c:url value="/getSubCatWiseTtlSaleChartDataByFr" var="getSubCatWiseTtlSaleChartDataByFr" />	

	<c:url value="/getCatWiseQtyChartDataByFr" var="getCatWiseQtyChartDataByFr" />	
 	<c:url value="/getCatWiseTtlSaleChartDataByFr" var="getCatWiseTtlSaleChartDataByFr" />	
 	<c:url value="/getSubCatWiseQtyChartDataByFr" var="getSubCatWiseQtyChartDataByFr" />
	<c:url value="/getSubCatWiseItemChartDataByFr" var="getSubCatWiseItemChartDataByFr" />	

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
							<h2 class="pageTitle">Franchise Shop Report</h2>
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
						<div class="col-md-7">
							<select class="chosen-select" name="statusId" id="statusId"
								multiple="multiple" onchange="selectOpt(this.value)">
								<option value="-1" style="text-align: left;">All</option>
								<c:forEach items="${statusList}" var="status" varStatus="count">
									<option value="${status.statusId}" style="text-align: left;">${status.statusValue}</option>
								</c:forEach>
							</select>
						</div>
						
					</div>
					
					<div class="row">

			
									<div class="col-md-2" style="float: none;">
							<h4 class="pull-left">Payment Mode:-</h4>
						</div>
									<div class="col-lg-4">
										<select class="form-control select-search" data-fouc
											data-placeholder="Select" name="paymentMethod" id="paymentMethod">
											<option value="1">Cash</option>
											<option value="2">Card</option>
											<option value="3">E-Pay</option>
										</select> <span class="validation-invalid-label text-danger"
											id="error_payment_mode" style="display: none;">This
											field is required.</span>
									</div>	
									
									<div class="col-md-3">
						<button type="button" class="btn btn-primary" id="submtbtn" >
										Search <i class="icon-paperplane ml-2"></i>
									</button>
									
									<a href="#down"><button type="submit" class="btn btn-primary" id="graphbtn" disabled="disabled">
										Graph <i class="icon-paperplane ml-2"></i>
									</button></a>
						</div>
					
					</div>
				<!-- </div> --><!--  -->
				<div class="clearfix"></div>
				<!--tabNavigation-->
				<div class="row">
					<div class="col-md-12">
						<div class="clearfix"></div>

						<div class="table-responsive marg_bx">
								<div id="table-scroll" class="table-scroll responsive-table-one">							
									<table id="order_table" class="responsive-table">
									<thead>
										<tr class="bgpink">
											<th style="text-align: center;">Sr No</th>
											<th style="text-align: center;">Order No.</th>
											<th style="text-align: center;">Order Date</th>
											<th style="text-align: center;">Delivery Date</th>
											<th style="text-align: center;">Category/Subcategory</th>
											<th style="text-align: center;">Product Name</th>
<!-- 											<th style="text-align: center;">Product Short Name</th>											 -->
											<th style="text-align: center;">Qty</th>											
											<th style="text-align: center;">Customer Name</th>
											<th style="text-align: center;">Time Slot</th>
											<th style="text-align: center;">Order Status</th>
											<th style="text-align: center;">Payment Mode</th>
											<th style="text-align: center;">Payment Ref No</th>
											<th style="text-align: center;">Cuopun Code</th>
											<th style="text-align: center;">Discount Amount</th>
											<th style="text-align: center;">Total Bill Amount</th>
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
				<div class="text-center">
								<!-- <button class="btn btn-primary" value="PDF" id="PDFButton"
									onclick="genPdf()" disabled="disabled">PDF</button>

								<input type="button" id="expExcel" class="btn btn-primary"
									value="EXPORT TO Excel" onclick="exportToExcel();"
									disabled="disabled"> -->
									
									<button type="button" class="btn btn-primary" id="pdf_btn" disabled="disabled"
							data-toggle="modal" data-target="#modal_theme_primary" onclick="getHeaders()">
								Pdf/Excel <i class="fas fa-file-pdf"></i>
							</button>
							</div>
				<div class="row" style="text-align: left; margin: 15px 0;">
						<div class="form-group" style="display: none;" id="range">
								<div class="controls">
									<input type="button" id="expExcel" class="buttonsaveorder"
										value="EXPORT TO Excel" onclick="exportToExcel();"
										disabled="disabled">
							</div>
						</div>	
				</div>
				
								<div class="row">
				
					<div class="col-lg-12"><div id="down">
						<div class="row">
							<div class="col-md-6" id="catQty" style="display: none;">
								<div class="card">
									<div id="cat_pie_3d" style="width: 600px; height: 350px;"></div>
								</div>
							</div>
							<div class="col-md-6" id="catSale" style="display: none;">
								<div class="card">
									<div id="ttlSale_pie_3d" style="width: 600px; height: 350px;"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
               </div>

				<div class="row">
					<div class="col-lg-12">
						<div class="row">
							<div class="col-md-6" id="subCatQty" style="display: none;">
								<div class="card">
									<div id="sub_cat_pie_3d" style="width: 600px; height: 350px;"></div>
								</div>
							</div>
						
							<div class="col-md-6" id="subCatSale" style="display: none;">
								<div class="card">
									<div id="subCat_ttlsl_pie_3d" style="width: 600px; height: 350px;"></div>
								</div>
							</div>	
						</div>					
					</div>
				</div>

				<div class="row">
					<div class="col-lg-12">
						<div class="row">
							<div class="col-md-6" id="qtyItems" style="display: none;">
								<div class="card">
									<div class="card-header bg-transparent">
										<h6 class="card-title">
											<i class="icon-cog3 mr-2"></i> Top 10 quantity wise products
										</h6>
									</div>
									<div class="card-body">
										<table
											class="table datatable-fixed-left_custom table-bordered table-hover table-striped"
											id="item_table">
											<thead>
												<tr>
													<th width="5%">SR. No.</th>
													<th>Product</th>
													<th>Qty.</th>
												</tr>
											</thead>
											<tbody>
											</tbody>
										</table>
									</div>
								</div>
							</div>

							<div class="col-md-6" id="salesItems" style="display: none;">
								<div class="card">
									<div class="card-header bg-transparent">
										<h6 class="card-title">
											<i class="icon-cog3 mr-2"></i> Top 10 total sales wise products
										</h6>
									</div>
									<div class="card-body">
										<table
											class="table datatable-fixed-left_custom table-bordered table-hover table-striped"
											id="item_sales_table">
											<thead>
												<tr>
													<th width="5%">SR. No.</th>
													<th>Product</th>
													<th>Total Sale</th>
												</tr>
											</thead>
											<tbody>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<input type="hidden" value="${imagePath}" id="imgPath">
				<input type="hidden" name="catId" id="catId" value="0">
				<input type="hidden" name="subCatId" id="subCatId" value="0">
				<input type="hidden" name="catId_sub" id="catId_sub" value="0">
				<input type="hidden" name="subCatId_ttlSale" id="subCatId_ttlSale" value="0">
				<input type="hidden" value="${compId}" id="companyId">
				<input type="hidden" value="1" id="datetype">
				<input type="hidden" value="${frId}" id="frId">
				
				</div>
				<!--rightSidebar-->
			</div>
			<!--tabNavigation-->


			<!--fullGrid-->
		</div>
		<!--rightContainer-->
		


	<!--wrapper-end-->

<script type="text/javascript">
  document.addEventListener("DOMContentLoaded", function(event) {
      // - Code to execute when all DOM content is loaded. 
  });
</script>

	<script type="text/javascript">
		$(document).ready(function() {
			$('#billPopup').popup({
				focusdelay : 400,
				outline : true,
				vertical : 'top'
			});
		});
	</script>
	
  <script type="text/javascript" charset="utf8" src="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/jquery.dataTables.min.js"></script>	
	
<script type="text/javascript">

$('.datatable-fixed-left_custom').DataTable({

	columnDefs : [ {
		orderable : false,
		targets : [ 0 ]
	} ],
	//scrollX : true,
	scrollX : true,
	scrollY : '65vh',
	scrollCollapse : true,
	order:[],
	paging : false,
	fixedColumns : {
		leftColumns : 1,
		rightColumns : 0
	}

});

$("#submtbtn")
.click(
		function() {
			
			
			$("#submtbtn").attr("disabled", true);							
			
			var fromDate = $("#fromdatepicker").val();
			
			var toDate = $("#todatepicker").val();
			var status = $("#statusId").val();
			var datetype = $("#datetype").val();
			var companyId = $("#companyId").val();
			var payment = $("#paymentMethod").val();
			var frId = $("#frId").val();
			
			var flag = true;
		
				if (statusId=="") {									
					$("#error_status").show()
					flag = false;
				}else{
					$("#error_status").hide()
					flag = true;
				}
				if(companyId==""){
					$("#error_comp").show();
					flag = false;
				}else{
					$("#error_comp").hide()
					flag = true;
				}
				
			if(flag) {
				
			$('#loader').show();
			$('#order_table td').remove();
			
			var dataTable = $('#order_table').DataTable();
// 			dataTable.clear().draw();

			$
					.getJSON(
							'${getShopFranchiseReport}',
							{
								
								fromDate : fromDate,
								toDate : toDate,
								datetype : datetype,
								status : JSON.stringify(status),
								compId : companyId,
								payment : payment,
								frId : frId,
								ajax : 'true'
							},
							function(data) {
								
									alert(JSON.stringify(data));
								$("#submtbtn").attr("disabled", false);
																				
								$('#loader').hide();
								if (data == "") {
									alert("No records found !!");													
								}else{	
									$("#graphbtn").attr("disabled", false);
									$("#pdf_btn").attr("disabled", false);
								}	
								
								$
										.each(
												data,
												function(key,
														order) {

													var acStr = '<a href="javascript:void(0)" class="list-icons-item text-primary-600" data-popup="tooltip" title="" data-original-title="Order Detail" onclick="getOrderDetail(\''
															+ order.orderId
															+ '\')"><i class="fa fa-list"></i></a>'

													var orderStatus = null;
													var paymentMode = null;

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

													if (order.paymentMethod == 1) {
														paymentMode = "Cash";
													} else if ((order.paymentMethod == 2)) {
														paymentMode = "Card";
													} else {
														paymentMode = "E-Pay";
													}
																	
													var tr = $('<tr></tr>');	
													var key=0;
													tr
													.append($(
																'<td></td>')
																.html(
																		key + 1));
													
													tr
													.append($(
																'<td></td>')
																.html(
																		order.orderNo));
													
													tr
													.append($(
																'<td></td>')
																.html(
																		order.orderDate));
													
													tr
													.append($(
																'<td></td>')
																.html(
																		order.deliveryDate));
													
													tr
													.append($(
																'<td></td>')
																.html(
																		order.catName + "" +order.subCatName));
													
													tr
													.append($(
																'<td></td>')
																.html(
																		order.productName));
													
													tr
													.append($(
																'<td></td>')
																.html(
																		order.qty));
													
													tr
													.append($(
																'<td></td>')
																.html(
																		order.custName));
													
													tr
													.append($(
																'<td></td>')
																.html(
																		order.timeSlot));
											
													tr
													.append($(
																'<td></td>')
																.html(
																		orderStatus));
													
													tr
													.append($(
																'<td></td>')
																.html(
																		paymentMethod));
													
													tr
													.append($(
																'<td></td>')
																.html(
																		order.payRefNo));
													
													tr
													.append($(
																'<td></td>')
																.html(
																		order.couponCode));
													
													tr
													.append($(
																'<td></td>')
																.html(
																		order.discAmt.toFixed(2)));
													
													tr
													.append($(
																'<td></td>')
																.html(
																		order.totalAmt.toFixed(2)));
														

													$('#order_table tbody').append(tr);

												});
							});
		}
		});
</script>

	<script type="text/javascript">
	
	
	

	
	
		

		function selectOpt(opt) {

			if (opt == -1) {
				$.getJSON('${getStatusListAjax}', {

					ajax : 'true',
				}, function(data) {

					if(data!=null){
						$("#error_status").hide();
					}
					$('#statusId').find('option').remove().end()
					$("#statusId")				

					for (var i = 0; i < data.length; i++) {
						$("#statusId").append(
								$("<option selected></option>").attr("value",
										data[i].statusId).text(
										data[i].statusValue));
					}
					$("#statusId").trigger("chosen:updated");
				});

			}
		}
			
		
		  $('#modal_large2').on('hidden.bs.modal', function () {
			
			  $("#imgDiv").empty();	
		}) 
		
	</script>
	
	
	
	 <script type="text/javascript">
    $("#graphbtn")
	.click(
		function() {

		google.charts.load("current", {
			packages : [ "corechart" ]
		});
		google.charts.setOnLoadCallback(drawCatQtyChart);
		
		google.charts.setOnLoadCallback(drawCatTtlSaleChart);
		
	});
    
   
		function drawCatQtyChart() {
				//var dates = $("#dates").val();
				var fromDate = $("#fromdatepicker").val();
				var toDate = $("#todatepicker").val();
				var status = $("#statusId").val();
				var datetype = $("#datetype").val();
				var companyId = $("#companyId").val();
				var payment = $("#paymentMethod").val();				
				var frId = $("#frId").val();
				
				var chart;
				var datag = '';
				var a = "";
				var dataSale = [];
				var Header = [ 'Category', 'Qty.', 'ID' ];
				dataSale.push(Header);
				$
						.getJSON(
								'${getCatWiseQtyChartDataByFr}',
								{
									fromDate : fromDate,
									toDate : toDate,
									datetype : datetype,
									status : JSON.stringify(status),
									compId : JSON.stringify(companyId),
									payment : payment,
									frId : frId,
									ajax : 'true'
								},
								function(chartsdata) {									
									if(chartsdata!=''){
										$("#catQty").css("display", "block");
									}
									var len = chartsdata.length;
									datag = datag + '[';
									$.each(chartsdata, function(key, chartsdata) {
										var temp = [];
										temp.push(chartsdata.catName + " ("
												+ (parseFloat(chartsdata.qty).toFixed(2))
												+ ")", (parseFloat(chartsdata.qty)),
												parseInt(chartsdata.catId));
										dataSale.push(temp);

									});

									//console.log(dataSale);									
									var data1 = google.visualization.arrayToDataTable(dataSale);

									var options = {
										title : 'Qty. Categories Pie Chart',
										legend: 'left',
										pieHole : 0.4,
										backgroundColor : 'transparent',
										pieSliceText : 'none',
										sliceVisibilityThreshold : 0,
										legend : {
											position : 'labeled',
											labeledValueText : 'both',
											textStyle : {
												color : 'red',
												fontSize : 8
											}
										},
										is3D : true,
									};
									
									chart = new google.visualization.PieChart(document
											.getElementById('cat_pie_3d'));
									

									function selectQtyHandler() {										
										var selectedItem = chart.getSelection()[0];
										if (selectedItem) {											
											i = selectedItem.row, 0;											
											getSubCatChart(chartsdata[i].catId, chartsdata[i].catName);
										}
									}
									google.visualization.events.addListener(chart, 'select',
											selectQtyHandler);
									
									chart.draw(data1, options);
								});
				
			}
		
		function drawCatTtlSaleChart() {
			
			var fromDate = $("#fromdatepicker").val();
			var toDate = $("#todatepicker").val();
			var status = $("#statusId").val();
			var datetype = $("#datetype").val();
			var companyId = $("#companyId").val();
			var payment = $("#paymentMethod").val();				
			var frId = $("#frId").val();
			
			var chart;
			var datag = '';
			var a = "";
			var dataSale = [];
			var Header = [ 'Category', 'Total Sale.', 'ID' ];
			dataSale.push(Header);
			$
					.getJSON(
							'${getCatWiseTtlSaleChartDataByFr}',
							{
								fromDate : fromDate,
								toDate : toDate,
								datetype : datetype,
								status : JSON.stringify(status),
								compId : JSON.stringify(companyId),
								payment : payment,
								frId : frId,
								ajax : 'true'
							},
							function(chartsdata) {									
								if(chartsdata!=''){
									$("#catSale").css("display", "block");
								}
								var len = chartsdata.length;
								datag = datag + '[';
								$.each(chartsdata, function(key, chartsdata) {
									var temp = [];
									temp.push(chartsdata.catName + " ("
											+ (parseFloat(chartsdata.qty).toFixed(2))
											+ ")", (parseFloat(chartsdata.qty)),
											parseInt(chartsdata.catId));
									dataSale.push(temp);

								});

								//console.log(dataSale);									
								var data1 = google.visualization.arrayToDataTable(dataSale);

								var options = {
									title : 'Total Sale Categories Pie Chart',
									legend: 'center',
									pieHole : 0.4,
									backgroundColor : 'transparent',
									pieSliceText : 'none',
									sliceVisibilityThreshold : 0,
									legend : {
										position : 'labeled',
										labeledValueText : 'both',
										textStyle : {
											color : 'red',
											fontSize : 8
										}
									},
									is3D : true,
								};
								
								chart = new google.visualization.PieChart(document
										.getElementById('ttlSale_pie_3d'));
								

								function selectQtyHandler() {										
									var selectedItem = chart.getSelection()[0];
									if (selectedItem) {											
										i = selectedItem.row, 0;											
										getSubCatTtlSaleChart(chartsdata[i].catId, chartsdata[i].catName);
									}
								}
								google.visualization.events.addListener(chart, 'select',
										selectQtyHandler);
								
								chart.draw(data1, options);
							});
			
		}
    </script>
    <script type="text/javascript">
		function getSubCatChart(id, catName) {
			
				var catId = id;
				var fromDate = $("#fromdatepicker").val();
				var toDate = $("#todatepicker").val();
				var status = $("#statusId").val();
				var datetype = $("#datetype").val();
				var companyId = $("#companyId").val();
				var payment = $("#paymentMethod").val();				
				var frId = $("#frId").val();
				
				var chart;
				var datag = '';
				var a = "";
				var dataSale = [];
				var Header = [ 'Sub Category', 'Qty.', 'ID' ];
				dataSale.push(Header);
				$
						.getJSON(
								'${getSubCatWiseQtyChartDataByFr}',
								{
									catId : catId,
									fromDate : fromDate,
									toDate : toDate,
									datetype : datetype,
									status : JSON.stringify(status),
									compId : JSON.stringify(companyId),
									payment : payment,
									frId : frId,
									ajax : 'true'
								},
								function(chartsdata) {									
									if(chartsdata!=''){
										$("#subCatQty").css("display", "block");
									}
								
									var len = chartsdata.length;
									datag = datag + '[';
									$.each(chartsdata, function(key, chartsdata) {
										var temp = [];
										temp.push(chartsdata.subCatName + " ("
												+ (parseFloat(chartsdata.qty).toFixed(2))
												+ ")", (parseFloat(chartsdata.qty)),
												parseInt(chartsdata.subCatId));
										dataSale.push(temp);

									});

									//console.log(dataSale);									
									var data1 = google.visualization.arrayToDataTable(dataSale);

									var options = {
										title : 'Qty. Sub Category : '+catName,
										pieHole : 0.4,
										legend: 'center',
										backgroundColor : 'transparent',
										pieSliceText : 'none',
										sliceVisibilityThreshold : 0,
										legend : {
											position : 'labeled',
											labeledValueText : 'both',
											textStyle : {
												color : 'red',
												fontSize : 8
											}
										},
										is3D : true,
									};
									
									chart = new google.visualization.PieChart(document
											.getElementById('sub_cat_pie_3d'));
									

									function selectQtyHandler() {										
										var selectedItem = chart.getSelection()[0];
										if (selectedItem) {											
											i = selectedItem.row, 0;											
											getSubCatItems(chartsdata[i].subCatId);
										}
									}
									google.visualization.events.addListener(chart, 'select',
											selectQtyHandler);
									
									chart.draw(data1, options);
								});
				
			
			document.getElementById("catId").value = id;
		}
		
		
		
		function getSubCatTtlSaleChart(id, catName){
		
		var catId = id;
		var fromDate = $("#fromdatepicker").val();
		var toDate = $("#todatepicker").val();
		var status = $("#statusId").val();
		var datetype = $("#datetype").val();
		var companyId = $("#companyId").val();
		var payment = $("#paymentMethod").val();				
		var frId = $("#frId").val();
		
		var chart;
		var datag = '';
		var a = "";
		var dataSale = [];
		var Header = [ 'Sub Category', 'Total Sale', 'ID' ];
		dataSale.push(Header);
		$
				.getJSON(
						'${getSubCatWiseTtlSaleChartDataByFr}',
						{
							catId : catId,
							fromDate : fromDate,
							toDate : toDate,
							datetype : datetype,
							status : JSON.stringify(status),
							compId : JSON.stringify(companyId),
							payment : payment,
							frId : frId,
							ajax : 'true'
						},
						function(chartsdata) {									
							if(chartsdata!=''){
								$("#subCatSale").css("display", "block");
							}
							
							var len = chartsdata.length;
							datag = datag + '[';
							$.each(chartsdata, function(key, chartsdata) {
								var temp = [];
								temp.push(chartsdata.subCatName + " ("
										+ (parseFloat(chartsdata.qty).toFixed(2))
										+ ")", (parseFloat(chartsdata.qty)),
										parseInt(chartsdata.subCatId));
								dataSale.push(temp);

							});

							//console.log(dataSale);									
							var data1 = google.visualization.arrayToDataTable(dataSale);

							var options = {
								title : 'Total Sale Sub Category : '+catName,
								pieHole : 0.4,
								legend: 'center',
								backgroundColor : 'transparent',
								pieSliceText : 'none',
								sliceVisibilityThreshold : 0,
								legend : {
									position : 'labeled',
									labeledValueText : 'both',
									textStyle : {
										color : 'red',
										fontSize : 8
									}
								},
								is3D : true,
							};
							
							chart = new google.visualization.PieChart(document
									.getElementById('subCat_ttlsl_pie_3d'));
							

							function selectQtyHandler() {										
								var selectedItem = chart.getSelection()[0];
								if (selectedItem) {											
									i = selectedItem.row, 0;											
									getSubCatTtlSaleItems(chartsdata[i].subCatId);
								}
							}
							google.visualization.events.addListener(chart, 'select',
									selectQtyHandler);
							
							chart.draw(data1, options);
						});
		
	
	document.getElementById("catId_sub").value = id;
}
	</script>
	<script type="text/javascript">
	function getSubCatItems(subCatId){
				
		var subCatId = subCatId;
		var fromDate = $("#fromdatepicker").val();
		var toDate = $("#todatepicker").val();
		var status = $("#statusId").val();
		var datetype = $("#datetype").val();
		var companyId = $("#companyId").val();
		var payment = $("#paymentMethod").val();				
		var frId = $("#frId").val();
		
		$('#item_table td').remove();
		var dataTable = $('#item_table').DataTable();
// 		dataTable.clear().draw();
       
		$
				.getJSON(
						'${getSubCatWiseItemChartDataByFr}',
						{
							subCatId : subCatId,
							fromDate : fromDate,
							toDate : toDate,
							datetype : datetype,
							status : JSON.stringify(status),
							compId : JSON.stringify(companyId),
							payment : payment,
							frId : frId,
							ajax : 'true'
						},
						function(data) {
							alert("table"+JSON.stringify(data))
							if(data!=''){
								$("#qtyItems").css("display", "block");
							}
							
							var total = 0;
							$
							.each(
									data,
									function(key,
											order) {
										total = total+order.qty;
							dataTable.row.add(	alert("table"+JSON.stringify(data))
									[key + 1,
										+order.productName,
										order.qty]).draw();
									});
							
							dataTable.row.add(['','Total Qty',total]).draw();
						});
		
	
		document.getElementById("subCatId").value = subCatId;
	}
	
	
	
	function getSubCatTtlSaleItems(subCatId){
		
		var subCatId = subCatId;
		var fromDate = $("#fromdatepicker").val();
		var toDate = $("#todatepicker").val();
		var status = $("#statusId").val();
		var datetype = $("#datetype").val();
		var companyId = $("#companyId").val();
		var payment = $("#paymentMethod").val();
		var frId = $("#frId").val();
			
		$('#item_sales_table td').remove();
		var dataTable = $('#item_sales_table').DataTable();
//         dataTable.clear().draw();
		$
				.getJSON(
						'${getSubCatItemSalesChartData}',
						{
							subCatId : subCatId,
							fromDate : fromDate,
							toDate : toDate,
							datetype : datetype,
							status : JSON.stringify(status),
							compId : JSON.stringify(companyId),
							payment : payment,
							frId : frId,
							ajax : 'true'
						},
						function(data) {
							if(data!=''){
								$("#salesItems").css("display", "block");
							}
							var total = 0
							$
							.each(
									data,
									function(key,
											order) {
										total = total+order.totalSale;
							dataTable.row.add(
									[key + 1,
										+order.productName,
										order.totalSale]).draw();
									});
							
							dataTable.row.add(['','Total Sale',total]).draw();
							
						});
		
	
		document.getElementById("subCatId_ttlSale").value = subCatId;
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
			var statusId = $("#statusId").val();
			var frId = $("#frId").val();
			var compId = $("#compId").val(); 
			
			 window
				.open('${pageContext.request.contextPath}/pdfReport?url=pdf/getOrderReportPdf/'
						+fromDate
						+ '/'
						+ toDate
						+ '/'
						+ statusId
						+'/'
						+frId+'/'+compId);
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
	
	<table
		class="table datatable-fixed-left_custom  table-bordered table-hover table-striped"
		width="100%" id="printtable2" style="display: none;">
		<thead>
			<tr>
				<th>Order No.</th>
				<th>Product</th>
				<th>Category/Sub Category</th>
				<th>Order Date</th>
				<th>Delivery Date</th>
				<th>HSN Code</th>
				<th>Price</th>
				<th>GST(CGST,SGST,IGST)</th>
				<th>Delivery Ch.</th>
				<th>Qty.</th>
				<th>Customer</th>
				<th>Company</th>
				<th>Shop</th>
				<th>Address</th>
				<th>Pincode</th>
				<th>Time Slot</th>
				<th>Order Status</th>
				<th>Payment Mode</th>
				<th>Payment Ref. No.</th>
				<th>Coupon Code</th>
				<th>Discount</th>
				<th>Total</th>
			</tr>
		</thead>
	</table>
	<!-- Primary modal -->
				<div id="modal_theme_primary" class="modal fade" tabindex="-1">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header bg-primary">
								<h6 class="modal-title">Product List</h6>
								<button type="button" class="close" data-dismiss="modal">&times;</button>
							</div>
				
							<div class="modal-body">
								<table class="table table-bordered table-hover table-striped"
										width="100%" id="modelTable">
									<thead>
										<tr>
											<th width="15">Sr.No.
											<input type="checkbox" name="selAll" id="selAll"/>
											</th>
											<th>Headers</th>
										</tr>
									</thead>
									<tbody></tbody>
								</table>
								<span class="validation-invalid-label" id="error_chks"
										style="display: none;">Select Check Box.</span>
							</div>
							<div class="text-center">
							<div class="form-check form-check-switchery form-check-inline">

								<label class="form-check-label"> <input type="checkbox" id="chkPdf"
									class="form-check-input-switchery" checked data-fouc>
									Click For show or hide header on pdf.
								</label>
							</div>
						</div>
							<div class="modal-footer">
								<button type="button" class="btn bg-primary" id="expExcel" onclick="getIdsReport(1)">Excel</button>
								<button type="button" class="btn bg-primary" onclick="getIdsReport(2)">Pdf</button>
							</div>
						</div>
					</div>
				</div>
<script>
				function getHeaders(){
					alert("getHeaders");
					$('#modelTable td').remove();
				var thArray = [];
	
				$('#printtable2 > thead > tr > th').each(function(){
				    thArray.push($(this).text())
				})
				//console.log(thArray[0]);
					
				var seq = 0;
					for (var i = 0; i < thArray.length; i++) {
						seq=i+1;					
						var tr1 = $('<tr></tr>');
						tr1.append($('<td style="padding: 7px; line-height:0; border-top:0px;"></td>').html('<input type="checkbox" class="chkcls" name="chkcls'
								+ seq
								+ '" id="catCheck'
								+ seq
								+ '" value="'
								+ seq
								+ '">') );
						tr1.append($('<td style="padding: 7px; line-height:0; border-top:0px;"></td>').html(innerHTML=thArray[i]));
						$('#modelTable tbody').append(tr1);
					}
				}
				
				$(document).ready(

						function() {

							$("#selAll").click(
									function() {
										$('#modelTable tbody input[type="checkbox"]')
												.prop('checked', this.checked);

									});
						});
				
				  function getIdsReport(val) {
					  var elemntIds = [];										
								
								$(".chkcls:checkbox:checked").each(function() {
									elemntIds.push($(this).val());
								}); 
									
											 $
											.getJSON(
													'${getfrUnitManufctExlReport}',
													{
														elemntIds : JSON.stringify(elemntIds),
														fromDate : $("#fromDate").val(),
														toDate : $("#toDate").val(),
														ajax : 'true'
													},
													function(data) {														
														
														if(data!=null){
															$("#modal_theme_primary").modal('hide');
															if(val==1){															
																window.open("${pageContext.request.contextPath}/exportToExcelNew");
															}else{
																var fromDate = $("#fromDate").val();
																var toDate = $("#toDate").val();
																var status = $("#status").val();
																var datetype = $("#datetype").val();
																var companyId = $("#companyId").val();
																var payment = $("#paymentMethod").val();
																var frId = $("#frId").val();
																
																var showHead = 0;
																if($("#chkPdf").is(":checked")){
																	showHead = 1;
																}else{
																	showHead = 0;
																}
																
																window.open("${pageContext.request.contextPath}/pdfReport?url=pdf/getFrUnitManurctrListPdf/"+companyId+"/"+status+"/"+fromDate+"/"+toDate+"/"+datetype+"/"+payment+"/"+elemntIds.join()+'/'+showHead);		
															
																$('#selAll').prop('checked', false);
															}
														}
													}); 
									
					}		
				</script>

	
</body>
</html>