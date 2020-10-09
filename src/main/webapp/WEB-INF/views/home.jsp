<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>Madhvi</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport"
	content="width=device-width; initial-scale=1.0; maximum-scale=1.0" />
<meta name="keywords" content="Madhvi" />
<meta name="description" content="Madhvi" />
<meta name="author" content="Madhvi">
<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
<!--Here Previous Block of Code, Commented at End -->
</head>
<c:url var="getCatSellList" value="/getCatSellList" />
<c:url var="getItemSellBill" value="/getItemSellBill" />
<c:url var="getDatewiseSellList" value="/getDatewiseSellList" />

<c:url var="getPendingOrdersByFrAjax" value="/getPendingOrdersByFrAjax" />

<body onload="getPendingOrders() ">
	<form action="" method="get">
		<!--wrapper-start-->
		<div class="wrapper">
			<jsp:include page="/WEB-INF/views/include/logo.jsp">
				<jsp:param name="fr" value="${frDetails}" />
			</jsp:include>
			<jsp:include page="/WEB-INF/views/include/left.jsp">
				<jsp:param name="fr" value="${frDetails}" />
			</jsp:include>
			<section class="main_container">
				<!--page title-start-->
				<div class="page_head">

					<%-- <div class="morquee_bx">
						<div class="morquee_bx_l">Latest News</div>
						<div class="morquee_bx_r marquee">

							<c:set var="news" value=""></c:set>

							<c:forEach items="${schedulerLists}" var="schedulerLists"
								varStatus="count">

								<c:set var="news"
									value="${news}&nbsp;|&nbsp;${schedulerLists.schMessage}"></c:set>
								<span style="color:${colors}">
									${schedulerLists.schMessage} </span>


							</c:forEach>

							<span style="color:${colors}"> ${news} </span>
						</div>
					</div> --%>

					<%-- <div class="row"
						style="display: inline-block; height: 44px; background: #ed1c24; width: 100%; line-height: 44px; margin: 0 0 20px 0;">

						<div class="col-md-2"
							style="float: left; width: 11%; height: 44px; line-height: 44px; background: #fcf300; color: #111111; text-align: center; font-size: 20px;">Latest
							News</div>
						<div class="col-md-10" style="height: 44px; width: 89%;">

							<c:set var="news" value=""></c:set>


							<c:forEach items="${schedulerLists}" var="schedulerLists"
								varStatus="count">

								<c:set var="news"
									value="${news}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${schedulerLists.schMessage}"></c:set>


							</c:forEach>
							<marquee behavior="scroll" direction="left"
								style="font-size: 16px; color: white; margin-left: -15px; margin-right: -15px;"
								scrollamount="4" onmouseover="this.stop()"
								onmouseout="this.start()">${news} </marquee>



						</div>
					</div> --%>


					<div class="row">

						<div class="col-sm-12" style="margin: 0 0 20px 0;">

							<div class="col-sm-2"
								style="background: #fcf300; color: #111111; text-align: center; font-size: 20px; padding-top: 10px; padding-bottom: 10px;">Latest
								News</div>
							<div class="col-sm-10"
								style="background: #ed1c24; padding-top: 10px; padding-bottom: 5px;">

								<c:set var="news" value=""></c:set>


								<c:forEach items="${schedulerLists}" var="schedulerLists"
									varStatus="count">

									<c:set var="news"
										value="${news}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${schedulerLists.schMessage}"></c:set>


								</c:forEach>
								<marquee behavior="scroll" direction="left"
									style="font-size: 16px; color: white; margin-left: -15px; margin-right: -15px; margin-top: 5px;"
									scrollamount="4" onmouseover="this.stop()"
									onmouseout="this.start()">${news} </marquee>



							</div>

						</div>


					</div>


					<%-- <div class="latestNews" style="background: #ed1c24;">
					
						<h3 class="latestNewsTitle" style="background: #fcf300; color: #111111; width: 200px;">Latest News </h3>
							<div class="microsoft marquee" style="margin-left:37px;">
						<c:forEach items="${schedulerLists}" var="schedulerLists"  varStatus="count">
						
					            <c:set var="colors" value="white"/>
					            <c:choose>
					            <c:when test="${count.index%2==0}">
					            <c:set var="colors" value="white"/>
					           </c:when>
					           <c:otherwise>
					            <c:set var="colors" value="lightblue"/>
					          </c:otherwise>
					          </c:choose>
								<span style="color:${colors}"> ${schedulerLists.schMessage} </span>
							
						
						</c:forEach>
						</div>
					</div> --%>

					<div class="page_title">Dashboard</div>

					<%-- <h3>${type}</h3> --%>

					<!-- <div class="page_bread">
						<ul>
							<li><a href="#"><i class="fa fa-home" aria-hidden="true"></i>
									Home</a></li>
							<li class="active">Dashboard</li>
						</ul>
					</div> -->

					<div class="custom_right">
						<form action="${pageContext.request.contextPath}/home"
							method="get">

							<input type="hidden" name="tod" id="tod" value="${tod}">
							<input type="hidden" name="frmd" id="frmd" value="${frmd}">
							<input type="hidden" name="catId" id="catId" value="${tod}">
							<div class="colOuter">


								<c:choose>
									<c:when test="${type==1}">
										<div class="col-md-1 radio_align_1">
											<input type="radio" name="type" value="1" class="radio-align"
												checked onclick="showDiv(this.value)"> Today
										</div>
										<div class="col-md-1 radio_align_1">
											<input type="radio" name="type" value="2" class="radio-align"
												onclick="showDiv(this.value)"> Week
										</div>
										<div class="col-md-1 radio_align_1">
											<input type="radio" name="type" value="3" class="radio-align"
												onclick="showDiv(this.value)"> Month
										</div>
										<div class="col-md-1 radio_align_1">
											<input type="radio" name="type" value="4" class="radio-align"
												onclick="showDiv(this.value)"> Custom
										</div>
									</c:when>
									<c:when test="${type==2}">
										<div class="col-md-1 radio_align_1">
											<input type="radio" name="type" value="1" class="radio-align"
												onclick="showDiv(this.value)"> Today
										</div>
										<div class="col-md-1 radio_align_1">
											<input type="radio" name="type" value="2" class="radio-align"
												checked onclick="showDiv(this.value)"> Week
										</div>
										<div class="col-md-1 radio_align_1">
											<input type="radio" name="type" value="3" class="radio-align"
												onclick="showDiv(this.value)"> Month
										</div>
										<div class="col-md-1 radio_align_1">
											<input type="radio" name="type" value="4" class="radio-align"
												onclick="showDiv(this.value)"> Custom
										</div>
									</c:when>

									<c:when test="${type==3}">
										<div class="col-md-1 radio_align_1">
											<input type="radio" name="type" value="1" class="radio-align"
												onclick="showDiv(this.value)"> Today
										</div>
										<div class="col-md-1 radio_align_1">
											<input type="radio" name="type" value="2" class="radio-align"
												onclick="showDiv(this.value)"> Week
										</div>
										<div class="col-md-1 radio_align_1">
											<input type="radio" name="type" value="3" class="radio-align"
												checked onclick="showDiv(this.value)"> Month
										</div>
										<div class="col-md-1 radio_align_1">
											<input type="radio" name="type" value="4" class="radio-align"
												onclick="showDiv(this.value)"> Custom
										</div>
									</c:when>

									<c:when test="${type==4}">
										<div class="col-md-1 radio_align_1">
											<input type="radio" name="type" value="1" class="radio-align"
												onclick="showDiv(this.value)">Today
										</div>
										<div class="col-md-1 radio_align_1">
											<input type="radio" name="type" value="2" class="radio-align"
												onclick="showDiv(this.value)"> Week
										</div>
										<div class="col-md-1 radio_align_1">
											<input type="radio" name="type" value="3" class="radio-align"
												onclick="showDiv(this.value)"> Month
										</div>
										<div class="col-md-1 radio_align_1">
											<input type="radio" name="type" value="4" class="radio-align"
												checked onclick="showDiv(this.value)"> Custom
										</div>
									</c:when>
								</c:choose>



								<div id="ihide" style="display: none;">
									<div class="col-md-1">
										<div class="col1title">From Date</div>
									</div>
									<div class="col-md-2">
										<input id="fromdatepicker" class="texboxitemcode texboxcal"
											required="required" placeholder="From Date" name="fromDate"
											value="${fromDate}" autocomplete="off" type="text">

									</div>
									<div class="col-md-1">
										<div class="col1title">To Date</div>
									</div>
									<div class="col-md-2">
										<input id="todatepicker" class="texboxitemcode texboxcal"
											required="required" placeholder="To Date" name="toDate"
											value="${toDate}" autocomplete="off" type="text">

									</div>

								</div>




								<div class="sub_right">
									<input name="submit" class="buttonsaveorder" value="Submit"
										type="submit" id="submtbtn">
								</div>
								<div class="sub_right">
									<c:if test="${msgListCount>0}">
										<a href="${pageContext.request.contextPath}/homeMessages"><button
												type="button" class="buttonsaveorder">
												<i class="fa fa-stack-exchange" aria-hidden="true"></i>
												Messages <span> ${msgListCount}</span>
											</button></a>
									</c:if>

								</div>


							</div>
						</form>
					</div>
					<div class="clr"></div>
				</div>

				<%-- 
				<div class="quick_links">
					<h3 class="bx_title">Quick Links</h3>
					<ul>
						<li><a href="#"><i class="fa fa-list-ul"
								aria-hidden="true"></i> Sell:${countDetails.saleAmt} </a></li>
						<li><a href="#"><i class="fa fa-file-pdf-o"
								aria-hidden="true"></i> Discount:${countDetails.discountAmt}</a></li>
						<li><a href="#"><i class="fa fa-file-pdf-o"
								aria-hidden="true"></i> Purchase:${countDetails.purchaseAmt}</a></li>
						<li><a href="#"><i class="fa fa-file-pdf-o"
								aria-hidden="true"></i> No. of
								Bill:${countDetails.noOfBillGenerated}</a></li>
						<li><a href="#"><i class="fa fa-line-chart"
								aria-hidden="true"></i> Profit:${countDetails.profitAmt} </a></li>
						<li><a href="#"><i class="fa fa-file-pdf-o"
								aria-hidden="true"></i> Advance Amt:${countDetails.advanceAmt}</a></li>
						<li><a href="#"><i class="fa fa-refresh"
								aria-hidden="true"></i> Credit Bill
								Amt:${countDetails.creditAmt}</a></li>
						<li><a href="#"><i class="fa fa-file-word-o"
								aria-hidden="true"></i> Cash Amt:${countDetails.cashAmt}</a></li>
						<li><a href="#"><i class="fa fa-money" aria-hidden="true"></i>
								Card Amount:${countDetails.cardAmt}</a></li>
						<li><a href="#"><i class="fa fa-file-o"
								aria-hidden="true"></i> e-pay Amt:${countDetails.epayAmt}</a></li>
						<li><a href="#"><i class="fa fa-file-o"
								aria-hidden="true"></i> Expense:${countDetails.expenseAmt}</a></li>
					</ul>
				</div> --%>

				<div class="sales_list">
					<ul>
						<!-- first li box -->
						<li>
							<div class="sale_one bg_one">
								<div class="sale_l">
									<i class="fa fa-inr" aria-hidden="true"></i>

								</div>
								<div class="sale_r">
									<h3 class="sale_head">${typeTitle}&nbsp;Sales</h3>

									<h1 class="price_sale">
										Rs.
										<fmt:formatNumber type="number" pattern="#"
											value="${countDetails.saleAmt}" />
									</h1>
								</div>
								<div class="clr"></div>
							</div>
						</li>

						<!-- second li box -->
						<li>
							<div class="sale_one bg_two">
								<div class="sale_l">
									<i class="fa fa-inr" aria-hidden="true"></i>

								</div>
								<div class="sale_r">
									<h3 class="sale_head">${typeTitle}&nbsp;Discount</h3>

									<h5 class="price_sale">
										Rs.
										<fmt:formatNumber type="number" pattern="#"
											value="${countDetails.discountAmt}" />
									</h5>
								</div>
								<div class="clr"></div>
							</div>
						</li>

						<!-- third li box -->
						<li>
							<div class="sale_one bg_three">
								<div class="sale_l">
									<i class="fa fa-inr" aria-hidden="true"></i>

								</div>
								<div class="sale_r">
									<h3 class="sale_head">${typeTitle}&nbsp;
										<%-- <c:choose>
											<c:when test="${sessionScope.frDetails.frKg1==1}">
											Goods Received 
										</c:when>
											<c:otherwise>
											Purchase
										</c:otherwise>
										</c:choose> --%>

									</h3>
									<!-- <div class="range">
										<span class="percen_three"></span>
									</div> -->
									<h5 class="price_sale">
										Rs.
										<fmt:formatNumber type="number" pattern="#"
											value="${countDetails.purchaseAmt}" />
									</h5>


								</div>
								<div class="clr"></div>
							</div>
						</li>

						<!-- fourth li box -->
						<li>
							<div class="sale_one bg_fourth">
								<div class="sale_l">
									<i class="fa fa-inr" aria-hidden="true"></i>

								</div>
								<div class="sale_r">
									<h3 class="sale_head">${typeTitle}&nbsp;No.ofBill</h3>
									<h5 class="price_sale">${countDetails.noOfBillGenerated}</h5>
								</div>
								<div class="clr"></div>
							</div>
						</li>

						<!-- fifth li box -->
						<%-- <li>
							<div class="sale_one bg_fifth">
								<div class="sale_l">
									<i class="fa fa-line-chart" aria-hidden="true"></i>

								</div>
								<div class="sale_r">
									<h3 class="sale_head">${typeTitle}&nbsp;Profit</h3>
									<h5 class="price_sale">
										Rs.
										<fmt:formatNumber type="number" maxFractionDigits="3"
											value="${countDetails.profitAmt}" />
									</h5>
								</div>
								<div class="clr"></div>
							</div>
						</li> --%>

						<!-- six li box -->
						<li>
							<div class="sale_one bg_sixth">
								<div class="sale_l">
									<i class="fa fa-inr" aria-hidden="true"></i>

								</div>
								<div class="sale_r">
									<h3 class="sale_head">${typeTitle}&nbsp;AdvanceAmt</h3>
									<h5 class="price_sale">
										Rs.
										<fmt:formatNumber type="number" pattern="#"
											value="${countDetails.advanceAmt}" />
									</h5>
								</div>
								<div class="clr"></div>
							</div>
						</li>

						<!-- seventh li box -->


						<li>
							<div class="sale_one bg_two">
								<div class="sale_l">
									<i class="fa fa-inr" aria-hidden="true"></i>

								</div>
								<div class="sale_r">
									<h3 class="sale_head">${typeTitle}&nbsp;CreditBillAmt</h3>
									<h5 class="price_sale">
										Rs.
										<fmt:formatNumber type="number" pattern="#"
											value="${countDetails.creditAmt}" />
									</h5>
									<%-- ${countDetails.creditAmt-creditAdvAmt} --%>
								</div>
								<div class="clr"></div>
							</div>
						</li>

						<li>
							<div class="sale_one bg_one">
								<div class="sale_l">
									<i class="fa fa-inr" aria-hidden="true"></i>

								</div>
								<div class="sale_r">
									<h3 class="sale_head">${typeTitle}&nbsp;Expenses</h3>
									<h5 class="price_sale">
										Rs.
										<fmt:formatNumber type="number" pattern="#"
											value="${countDetails.expenseAmt}" />
									</h5>
								</div>
								<div class="clr"></div>
							</div>
						</li>

						<!-- eighth li box -->
						<li>
							<div class="sale_one bg_three">
								<div class="sale-list">
									<div class="sale_epay">
										EPAY <span>Rs.<fmt:formatNumber type="number"
												pattern="#" value="${countDetails.epayAmt}" />
										</span>
									</div>
									<div class="sale_epay">
										Cash <span>Rs.<fmt:formatNumber type="number"
												pattern="#" value="${countDetails.cashAmt}" />
										</span>
									</div>
									<div class="sale_epay">
										Card <span>Rs.<fmt:formatNumber type="number"
												pattern="#" value="${countDetails.cardAmt}" />
										</span>
									</div>
									<div class="clr"></div>
								</div>
							</div>
						</li>

						<li>
							<div class="sale_one bg_two">
								<div class="sale-list">
									<div class="sale_epay" style="text-align: center;">Dairy
										Mart Order</div>
									<c:forEach items="${dailyList}" var="dailyList"
										varStatus="count">
										<div class="sale_epay">
											${dailyList.orderDate} <span>Rs.<fmt:formatNumber
													type="number" pattern="#" value="${dailyList.total}" />
											</span>
										</div>

										<div class="clr"></div>
									</c:forEach>
								</div>
							</div>
						</li>

						<li>
							<div class="sale_one bg_three">
								<div class="sale-list">
									<div class="sale_epay" style="text-align: center;">
										Advance Order</div>
									<c:forEach items="${advOrderList}" var="advOrderList"
										varStatus="count">
										<div class="sale_epay">
											${advOrderList.orderDate} <span>Rs.<fmt:formatNumber
													type="number" pattern="#" value="${advOrderList.total}" />
											</span>
										</div>

										<div class="clr"></div>
									</c:forEach>
								</div>
							</div>
						</li>

						<!-- nine li box -->

					</ul>
					<div class="clr"></div>
				</div>

				<div class="sales_list">


					<h3 class="bx_title">Pending Orders</h3>

					<div class="scrollbars" id="scrollbarsmodaldiv"
						style="height: auto;">
						<table id="order_table">

							<thead>
								<tr>

									<th class=col-md-1 style="text-align: center;">Sr No</th>
									<th class=col-md-1 style="text-align: center;">Order ID</th>
									<th class=col-md-1 style="text-align: center;">Delivery
										Date</th>
									<th class=col-md-1 style="text-align: center;">Customer</th>
									<th class=col-md-1 style="text-align: center;">Order From</th>
									<th class=col-md-1 style="text-align: center;">Total</th>

									<!-- 										<th style="text-align: center;">Action</th> -->
								</tr>
							</thead>
							<tbody>

							</tbody>
						</table>
					</div>

				</div>
		</div>

		<div class="charts_bx">
			<div class="chart_l">

				<!-- <div class="a">Map Put Here</div>
 -->
				<div id="donutchart"></div>
				<!-- style="width: 900px; height: 500px;" -->
			</div>
			<div class="chart_r">
				<h3 class="bx_title">Top Products</h3>
				<div class="right_btns">
					<input name="submit" class="sub_btn" value="All" type="submit"
						onclick="itemSellBillCal2(0)" id="submtbtn">
					<button type="reset" class="sub_btn" value="Reset"
						onclick="itemSellBillCal2(2)">
						<i class="fa fa-arrow-down" aria-hidden="true"></i>
					</button>
					<button type="reset" class="sub_btn" value="Reset"
						onclick="itemSellBillCal2(1)">
						<i class="fa fa-arrow-up" aria-hidden="true"></i>
					</button>



				</div>



				<div class="scrollbars" id="scrollbarsmodaldiv">
					<table id="custCreditTable">

						<thead>
							<tr>
								<th style="text-align: center;">Sr</th>
								<th style="text-align: center;">Item Name</th>
								<th style="text-align: center;">Amount</th>
							</tr>
						</thead>
						<tbody>

						</tbody>
					</table>
				</div>


			</div>
			<div class="clr"></div>


		</div>

		<div class="charts_bx">
			<div class="chart_l">

				<!-- <div class="a">Map Put Here</div>
 -->
				<div id="chart_div"></div>
				<!-- style="width: 900px; height: 500px;" -->


			</div>

			<div class="clr"></div>


		</div>
		</section>
		</div>
		<!--wrapper-end-->
	</form>





	<!--  trial -->
	<script type="text/javascript"
		src="https://www.gstatic.com/charts/loader.js"></script>

	<script type="text/javascript">
		function drawDonutChart() {
			//alert("hii donut ch");
			//to draw donut chart
			var chart;
			var datag = '';
			var frmd = document.getElementById("frmd").value;
			var tod = document.getElementById("tod").value;
			var a = "";
			var dataSale = [];
			var Header = [ 'Category', 'Amount', 'ID' ];
			dataSale.push(Header);
			$.post('${getCatSellList}', {
				frmd : frmd,
				tod : tod,
				ajax : 'true'
			}, function(chartsdata) {
				//alert(JSON.stringify(data));
				//	console.log('data ' + JSON.stringify(chartsdata));
				var len = chartsdata.length;
				datag = datag + '[';
				$.each(chartsdata, function(key, chartsdata) {
					var temp = [];
					temp.push(chartsdata.catName + " ("
							+ (parseFloat(chartsdata.catTotal).toFixed(2))
							+ ")", (parseFloat(chartsdata.catTotal)),
							parseInt(chartsdata.catId));
					dataSale.push(temp);

				});

				//console.log(dataSale);
				var data1 = google.visualization.arrayToDataTable(dataSale);

				var options = {
					title : 'Categorywise Sell(%)',
					pieHole : 0.4,
					backgroundColor : 'transparent',
					pieSliceText : 'none',
					sliceVisibilityThreshold : 0,
					legend : {
						position : 'labeled',
						labeledValueText : 'both',
						textStyle : {
							color : 'red',
							fontSize : 10
						}
					},
					is3D : true,
				};
				//  alert(222);
				chart = new google.visualization.PieChart(document
						.getElementById('donutchart'));

				function selectQtyHandler() {
					// alert("hii");
					var selectedItem = chart.getSelection()[0];
					if (selectedItem) {
						// alert("hii selectedItem");
						i = selectedItem.row, 0;

						//alert("hii selectedItem" + chartsdata[i].catId);
						itemSellBillCal(chartsdata[i].catId);

					}
				}

				google.visualization.events.addListener(chart, 'select',
						selectQtyHandler);
				chart.draw(data1, options);

			});

		}
	</script>
	<script type="text/javascript">
		function drawAllCharts() {

			google.charts.load("current", {
				packages : [ "corechart" ]
			});
			google.charts.setOnLoadCallback(drawDonutChart);

			google.charts.load('current', {
				'packages' : [ 'corechart', 'bar' ]
			});
			google.charts.setOnLoadCallback(drawStuff);

			var type = $
			{
				type
			}
			;

			if (type == 4) {
				document.getElementById("ihide").style = "visible"
				document.getElementById("fromdatepicker").required = true;
				document.getElementById("todatepicker").required = true;
			} else {
				document.getElementById("ihide").style = "display:none"
				document.getElementById("fromdatepicker").required = false;
				document.getElementById("todatepicker").required = false;
			}

		}
	</script>
	<script type="text/javascript">
		function drawStuff() {
			//alert("hii bar ch");
			var frmd = document.getElementById("frmd").value;
			var tod = document.getElementById("tod").value;
			var chartDiv = document.getElementById('chart_div');
			document.getElementById("chart_div").style.border = "thin dotted red";
			var dataTable = new google.visualization.DataTable();

			dataTable.addColumn('string', 'Date'); // Implicit domain column.
			dataTable.addColumn('number', 'Amount'); // Implicit data column.

			$.post('${getDatewiseSellList}', {
				frmd : frmd,
				tod : tod,
				ajax : 'true'
			}, function(chartsBardata) {

				//alert(JSON.stringify(chartsBardata));
				$.each(chartsBardata, function(key, chartsBardata) {

					dataTable.addRows([ [ chartsBardata.sellDate,
							parseInt(chartsBardata.sellAmount) ] ]);

				});

				//alert(11);

				var materialOptions = {
					width : 600,
					height : 450,
					chart : {
						title : 'Sell Amount per Day',
						subtitle : ' '
					},
					series : {
						0 : {
							axis : 'distance'
						}, // Bind series 0 to an axis named 'distance'.
						1 : {
							axis : 'brightness'
						}
					// Bind series 1 to an axis named 'brightness'.
					},
					axes : {
						y : {
							distance : {
								label : 'Sell Amount'
							}, // Left y-axis.
							brightness : {
								side : 'right',
								label : 'Total Tax'
							}
						// Right y-axis.
						}
					}
				};

				var materialChart = new google.charts.Bar(chartDiv);

				function drawMaterialChart() {
					// var materialChart = new google.charts.Bar(chartDiv);
					// google.visualization.events.addListener(materialChart, 'select', selectHandler);    
					materialChart.draw(dataTable, google.charts.Bar
							.convertOptions(materialOptions));
					// button.innerText = 'Change to Classic';
					// button.onclick = drawClassicChart;
				}

				drawMaterialChart();

			});

		}
	</script>

	<script type="text/javascript">
		function itemSellBillCal(id) {

			var frmd = document.getElementById("frmd").value;
			var tod = document.getElementById("tod").value;
			var flag = 1;
			$.post('${getItemSellBill}', {
				id : id,
				frmd : frmd,
				tod : tod,
				flag : flag,
				ajax : 'true'
			}, function(data) {

				//alert(JSON.stringify(data));
				$('#custCreditTable td').remove();

				$.each(data, function(key, data) {

					var tr = $('<tr></tr>');

					tr.append($('<td ></td>').html(key + 1));
					tr.append($('<td ></td>').html(data.itemName));
					tr.append($('<td ></td>').html(
							parseFloat(data.itemTotal).toFixed(2)));

					$('#custCreditTable tbody').append(tr);
				});

			});
			document.getElementById("catId").value = id;
		}
	</script>

	<script type="text/javascript">
		function itemSellBillCal2(flag) {

			//var flag = document.getElementById("typeSort").value;
			var tod = document.getElementById("tod").value;
			var frmd = document.getElementById("frmd").value;
			var id = document.getElementById("catId").value;
			$.post('${getItemSellBill}', {
				id : id,
				frmd : frmd,
				tod : tod,
				flag : flag,
				ajax : 'true'
			}, function(data) {

				//	alert(JSON.stringify(data));
				$('#custCreditTable td').remove();

				$.each(data, function(key, data) {

					var tr = $('<tr></tr>');

					tr.append($('<td ></td>').html(key + 1));
					tr.append($('<td ></td>').html(data.itemName));
					tr.append($('<td ></td>').html(
							parseFloat(data.itemTotal).toFixed(2)));

					$('#custCreditTable tbody').append(tr);
				});

			});

		}
	</script>

	<!-- <script type="text/javascript">
		google.charts.load("current", {
			packages : [ "corechart" ]
		});
		google.charts.setOnLoadCallback(drawChart);
		function drawDonutChart1()  {
		 
			var data = google.visualization.arrayToDataTable([
					[ 'Task', 'Hours per Day' ], [ 'Work', 11 ], [ 'Eat', 2 ],
					[ 'Commute', 2 ], [ 'Watch TV', 2 ], [ 'Sleep', 7 ] ]);

			var options = {
				title : 'My Daily Activities',
				pieHole : 0.4,
			};

			var chart = new google.visualization.PieChart(document
					.getElementById('donutchart'));
			chart.draw(data, options);
		}
	</script> -->


	<script type="text/javascript">
		function showDiv(typdId) {
			//alert("Id="+typdId);
			if (typdId == 4) {
				document.getElementById("ihide").style = "visible"
				document.getElementById("fromdatepicker").required = true;
				document.getElementById("todatepicker").required = true;
			} else {
				document.getElementById("ihide").style = "display:none"
				document.getElementById("fromdatepicker").required = false;
				document.getElementById("todatepicker").required = false;
			}

		}
	</script>
	<script>
		$(function() {
			$("#fromdatepicker").datepicker({
				dateFormat : 'dd-mm-yy'
			});
		});
		$(function() {
			$("#todatepicker").datepicker({
				dateFormat : 'dd-mm-yy'
			});
		});

		$(function() {
			$("#popdatepicker").datepicker({
				dateFormat : 'dd-mm-yy'
			});
		});
	</script>
	<!-- *********************************************************************** -->
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

			<br>


		</div>



	</div>

	<!-- **************************************************************** -->
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

					/* if (table[i].orderStatus == 0) {
						document.getElementById("statusDiv").innerHTML = process;
					} else {
						document.getElementById("statusDiv").innerHTML = complete;
					} */

					getOrderDetails(table[i].orderDetailList);

					break;

				}
			}

		}

		function closeBillPopup() {

			$('#billPopup').popup('hide');

		}
	</script>


	<script type="text/javascript">
		function getPendingOrders() {

			$
					.getJSON(
							'${getPendingOrdersByFrAjax}',
							{
								ajax : 'true'
							},
							function(data) {

								//alert(JSON.stringify(data));

								sessionStorage.setItem("pendingOrderList", JSON
										.stringify(data));

								$('#order_table td').remove();

								$
										.each(
												data,
												function(key, order) {

													var tr = $('<tr onclick=openBillPopup('
															+ order.orderId
															+ ')></tr>');

													tr
															.append($(
																	'<td class=col-md-1 style="padding: 2 !important; font-size: 14px;"></td>')
																	.html(
																			key + 1));

													tr
															.append($(
																	'<td  class=col-md-1 style="text-align: center; padding: 2 !important; font-size: 14px;"></td>')
																	.html(
																			order.orderNo));

													tr
															.append($(
																	'<td  class=col-md-1 style="text-align: center; padding: 2 !important; font-size: 14px;"></td>')
																	.html(
																			order.deliveryDate
																					+ " "
																					+ order.deliveryTime));

													tr
															.append($(
																	'<td class=col-md-1 style="padding: 2 !important; font-size: 14px;"></td>')
																	.html(
																			order.custName
																					+ " - "
																					+ order.whatsappNo));

													var platform = "";

													if (order.orderPlatform == 1) {
														platform = "Executive"
													} else if (order.orderPlatform == 2) {
														platform = "Mobile App"
													}

													tr
															.append($(
																	'<td class=col-md-1 style="padding: 2 !important; font-size: 14px;"></td>')
																	.html(
																			platform));

													tr
															.append($(
																	'<td  class=col-md-1 style="text-align: right; padding: 2 !important; font-size: 14px;"></td>')
																	.html(
																			order.totalAmt));

													$('#order_table tbody')
															.append(tr);

												});

							});
		}
	</script>


	<script type="text/javascript">
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



	<!-- **************************************************************** -->
</body>
</html>
<%--	<!--topLeft-nav-->
	<div class="sidebarOuter"></div>
	<!--wrapper-start-->
	<div class="wrapper">
		<!--topHeader-->
		<jsp:include page="/WEB-INF/views/include/logo.jsp">
					<jsp:param name="fr" value="${frDetails}"/>
		</jsp:include>
		<!--topHeader-->
		<!--rightContainer-->
		<div class="fullGrid center">
			<!--fullGrid-->
			<div class="wrapperIn2">
				<!--rightSidebar-->
				<div class="sidebarright">
										<h2 class="pageTitle">Hi <span>${frDetails.frOwner},</span> Welcome Back</h2>
					<!--slider-->
					<!--slider thum size : width:850px height:350px-->
						<div class="latestNews">
					
						<h3 class="latestNewsTitle">Latest News</h3>
							<div class="microsoft marquee">
						<c:forEach items="${schedulerLists}" var="schedulerLists"  varStatus="count">
						
					            <c:set var="colors" value=""/>
					            <c:choose>
					            <c:when test="${count.index%2==0}">
					            <c:set var="colors" value="white"/>
					           </c:when>
					           <c:otherwise>
					            <c:set var="colors" value="lightblue"/>
					          </c:otherwise>
					          </c:choose>
								<span style="color:${colors}"> ${schedulerLists.schMessage} </span>
						</c:forEach>
						</div>
					</div>
					<div id="owl-example" class="owl-carousel">
						<c:forEach items="${msgList}" var="msgList">
							<div class="item">
								<div class="screen4plan">
									<div class="homesliderImg">
									 <img src="${url}${msgList.msgImage}"  />
									</div>
									<h3 class="homesliderTitle" style="font-size:15px "><center>${msgList.msgHeader}</center></h3>
	                                <h3 class="homesliderTitle"  >${msgList.msgDetails}</h3>

								</div>
							</div>
						</c:forEach>

					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
 --%>