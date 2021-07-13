<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.time.LocalTime"%>
<%@ page import="java.time.ZoneId"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<style type="text/css">
.topSlide2 {
	padding: 20px 60px 20px 20px;
}

#preloader {
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background-color: #fff;
	z-index: 99;
	height: 100%;
}

#status {
	width: 200px;
	height: 200px;
	position: absolute;
	left: 50%;
	top: 50%;
	background-image:
		url(${pageContext.request.contextPath}/resources/newpos/images/loader.gif);
	background-repeat: no-repeat;
	background-position: center;
	margin: -100px 0 0 -100px;
}
</style>
<div id="preloader">
	<div id="status"></div>
</div>
<%-- <c:if test="${sessionScope.eyeVal==1}"> --%>
<div id="demo">



	<section id="examples" class="snap-scrolling-example">
		<a href="#" id="button"></a>
		<div id="content-1" class="content horizontal-images">
			<div class="top_menu">
				<ul>
					<c:set var="flag" value="${0}"></c:set>
					<c:forEach items="${setList}" var="setting" varStatus="count">
						<c:choose>

							<c:when test="${setting.settingKey eq 'Order Booking'}">
								<c:set var="flag" value="${1}"></c:set>
							</c:when>


						</c:choose>
					</c:forEach>
				<c:if
						test="${(sessionScope.frEmpDetails.designation==1 or sessionScope.frEmpDetails.designation==2 or sessionScope.frEmpDetails.designation==3) && flag==1 }">
						<li style="border: 1px;"><a href="#" onClick="openNav()"><div
									class="img">
									<!-- <i class="fa fa-file-pdf-o" aria-hidden="true"></i> -->
									<i class="fa fa-sticky-note-o" aria-hidden="true"></i>
								</div>
								<div class="title">
									Order <span>Booking</span>
								</div></a></li>

					</c:if>


					<%-- <c:if
						test="${(sessionScope.frEmpDetails.designation==1 or sessionScope.frEmpDetails.designation==2 or sessionScope.frEmpDetails.designation==3) && sessionScope.isEmpPresent==1}">
						<li><a
							href="${pageContext.request.contextPath}/newcustomerbill/0"><div
									class="img">
									<!-- <i class="fa fa-file-pdf-o icon"></i> -->
									<i class="fa fa-desktop" aria-hidden="true"></i>
								</div>
								<div class="title">
									POINT OF SALE(POS)<span></span>
								</div></a></li>
					</c:if> --%>

					<c:set var="flag" value="${0}"></c:set>
					<c:forEach items="${setList}" var="setting" varStatus="count">
						<c:choose>

							<c:when test="${setting.settingKey eq 'Express Bill'}">
								<c:set var="flag" value="${1}"></c:set>
							</c:when>


						</c:choose>
					</c:forEach>

					<c:if test="${flag==1}">
						<li><a
							href="${pageContext.request.contextPath}/showExpressBill">
								<div class="img">
									<i class="fa fa-file-pdf-o icon"></i>
								</div>
								<div class="title">
									Express Bill <span></span>
								</div>
						</a></li>
					</c:if>

						<c:set var="flag" value="${0}"></c:set>
			<c:forEach items="${setList}" var="setting" varStatus="count">
				<c:choose>

					<c:when test="${setting.settingKey eq 'Customer Bill'}">
						<c:set var="flag" value="${1}"></c:set>
					</c:when>


				</c:choose>
			</c:forEach>
			<c:set var="flagForPhyStk" value="${0}"></c:set>
			<c:forEach items="${setList}" var="setting" varStatus="count">
				<c:choose>

					<c:when test="${setting.settingKey eq 'Bill As Per Physical Stock'}">
						<c:set var="flagForPhyStk" value="${1}"></c:set>
					</c:when>


				</c:choose>
			</c:forEach>

					<c:if test="${  flag==1 }">
						<li><a
					href="${pageContext.request.contextPath}/showCustomerBill"><div
							class="img">
							<i class="fa fa-file-pdf-o icon"
								style="font-size: 22px !important;"></i>
						</div>
						<div class="title">
							Customer Bill <span></span>
						</div></a></li>
						<c:if
							test="${(sessionScope.frEmpDetails.designation==1 or sessionScope.frEmpDetails.designation==2) && flagForPhyStk==1}">
							<li><a
								href="${pageContext.request.contextPath}/showStockMatchUtility"><div
										class="img">
										<i class="fa fa-file-pdf-o" aria-hidden="true"></i>
									</div>
									<div class="title">
										Bill As Per <span>Physical Stock </span>
									</div></a></li>
						</c:if>

					</c:if>


					<%-- <c:if
						test="${sessionScope.frEmpDetails.designation==1 or sessionScope.frEmpDetails.designation==2 or sessionScope.frEmpDetails.designation==3}">

						<li><a href="${pageContext.request.contextPath}/viewBill"><div
									class="img">
									<!-- <i class="fa fa-file-pdf-o icon"></i> -->
									<i class="fa fa-eye" aria-hidden="true"></i>
								</div>
								<div class="title">
									View Sell Bills <span></span>
								</div></a></li>
					</c:if> --%>



					<c:set var="flag" value="${0}"></c:set>
					<c:forEach items="${setList}" var="setting" varStatus="count">
						<c:choose>

							<c:when test="${setting.settingKey eq 'Goods Return'}">
								<c:set var="flag" value="${1}"></c:set>
							</c:when>


						</c:choose>
					</c:forEach>


					<c:if
						test="${(sessionScope.frEmpDetails.designation==1 or sessionScope.frEmpDetails.designation==2) && flag==1}">
						<li><a href="#" onClick="openNav1()"><div class="img">
									<!-- <i class="fa fa-file-pdf-o" aria-hidden="true"></i> -->
									<i class="fa fa-repeat" aria-hidden="true"></i>
								</div>
								<div class="title">
									Goods <span>Return</span>
								</div></a></li>
					</c:if>


					<c:set var="flag" value="${0}"></c:set>
					<c:forEach items="${setList}" var="setting" varStatus="count">
						<c:choose>

							<c:when test="${setting.settingKey eq 'Order History'}">
								<c:set var="flag" value="${1}"></c:set>
							</c:when>


						</c:choose>
					</c:forEach>



					<c:if
						test="${(sessionScope.frEmpDetails.designation==1 or sessionScope.frEmpDetails.designation==2 or sessionScope.frEmpDetails.designation==3) && flag==1}">

						<li><a href="${pageContext.request.contextPath}/orderHistory"><div
									class="img">
									<i class="fa fa-file-text-o" aria-hidden="true"></i>
								</div>
								<div class="title">
									Order <span>History</span>
								</div></a></li>





						<li style="display: none;"><a
							href="${pageContext.request.contextPath}/showAdvanceOrderList"><div
									class="img">
									<!-- <i class="fa fa-file-pdf-o" aria-hidden="true"></i> -->
									<i class="fa fa-list" aria-hidden="true"></i>
								</div>
								<div class="title">Advance Order List</div></a></li>


					</c:if>

					<c:set var="flag" value="${0}"></c:set>
					<c:forEach items="${setList}" var="setting" varStatus="count">
						<c:choose>

							<c:when test="${setting.settingKey eq 'View Purchase Bills'}">
								<c:set var="flag" value="${1}"></c:set>
							</c:when>


						</c:choose>
					</c:forEach>


				<%-- 	<c:if
						test="${(sessionScope.frEmpDetails.designation==1 or sessionScope.frEmpDetails.designation==2 or sessionScope.frEmpDetails.designation==3) && flag==1}">
						<li><a href="${pageContext.request.contextPath}/showBill">

								<div class="img">
									<i class="fa fa-money"></i>
								</div> <c:choose>
									<c:when test="${sessionScope.frDetails.frKg1==1}">
										<div class="title">Delivery Challan</div>
									</c:when>
									<c:otherwise>
										<div class="title">Purchase Bills</div>
									</c:otherwise>
								</c:choose>

						</a></li>

					</c:if> --%>

					<c:if
						test="${(sessionScope.frEmpDetails.designation==1 or sessionScope.frEmpDetails.designation==2 or sessionScope.frEmpDetails.designation==3) && flag==1}">
						<li><a
							href="${pageContext.request.contextPath}/insertCreditNote">

								<div class="img">
									<i class="fa fa-users" aria-hidden="true"></i>
									<!-- <i class="fa fa-file-pdf-o"></i> -->
								</div>
								<div class="title">Credit Note</div>
						</a></li>
					</c:if>


					<c:set var="flag" value="${0}"></c:set>
			<c:forEach items="${setList}" var="setting" varStatus="count">
				<c:choose>

					<c:when test="${setting.settingKey eq 'Other Purchase Bill'}">
						<c:set var="flag" value="${1}"></c:set>
					</c:when>


				</c:choose>
			</c:forEach>
					<c:if test="${ flag==1}">
						<li><a
							href="${pageContext.request.contextPath}/showOtherBill"><div
									class="img">
									<i class="fa fa-file-pdf-o"></i>
								</div>
								<div class="title">Other Purchase Bill</div></a></li>
					</c:if>
					<c:set var="flag" value="${0}"></c:set>
					<c:forEach items="${setList}" var="setting" varStatus="count">
						<c:choose>

							<c:when test="${setting.settingKey eq 'Other Item Stock'}">
								<c:set var="flag" value="${1}"></c:set>
							</c:when>


						</c:choose>
					</c:forEach>
					<c:if test="${flag==1}">
						<li><a
							href="${pageContext.request.contextPath}/showOthItemStock"><div
									class="img">
									<i class="fa fa-file-pdf-o"></i>
								</div>
								<div class="title">Other Item Stock</div></a></li>
					</c:if>


					<c:set var="flag" value="${0}"></c:set>
					<c:forEach items="${setList}" var="setting" varStatus="count">
						<c:choose>

							<c:when test="${setting.settingKey eq 'Reports'}">
								<c:set var="flag" value="${1}"></c:set>
							</c:when>


						</c:choose>
					</c:forEach>



					<c:if
						test="${sessionScope.frEmpDetails.designation==1 or sessionScope.frEmpDetails.designation==2   && flag==1}">

						<li><a href="#" onClick="openNav4()"><div class="img">
									<!-- <i class="fa fa-file-o icon"></i> -->
									<i class="fa fa-file-word-o" aria-hidden="true"></i>
								</div>
								<div class="title">
									<span>Reports</span>
								</div></a></li>
					</c:if>

					<c:set var="flag" value="${0}"></c:set>
					<c:forEach items="${setList}" var="setting" varStatus="count">
						<c:choose>

							<c:when test="${setting.settingKey eq 'Rule And Regulation'}">
								<c:set var="flag" value="${1}"></c:set>
							</c:when>


						</c:choose>
					</c:forEach>



					<c:if test="${ flag==1}">
						<li><a
							href="${pageContext.request.contextPath}/showRuleFilePdf"><div
									class="img">
									<i class="fa fa-file-pdf-o icon"></i>
								</div>
								<div class="title">
									Rule And Regulation <span></span>
								</div></a></li>
					</c:if>




					<c:set var="flag" value="${0}"></c:set>
					<c:forEach items="${setList}" var="setting" varStatus="count">
						<c:choose>

							<c:when test="${setting.settingKey eq 'Stock Details'}">
								<c:set var="flag" value="${1}"></c:set>
							</c:when>


						</c:choose>
					</c:forEach>


					<c:if
						test="${(sessionScope.frEmpDetails.designation==1 or sessionScope.frEmpDetails.designation==2) && flag==1}">
						<li><a
							href="${pageContext.request.contextPath}/showstockdetail"><div
									class="img">
									<!-- <i class="fa fa-file-pdf-o" aria-hidden="true"></i> -->
									<i class="fa fa-pie-chart" aria-hidden="true"></i>
								</div>
								<div class="title">
									Stock <span>Details</span>
								</div></a></li>


					</c:if>


					<%-- <c:if
						test="${sessionScope.frEmpDetails.designation==1 or sessionScope.frEmpDetails.designation==2 or sessionScope.frEmpDetails.designation==3}">

						<li><a
							href="${pageContext.request.contextPath}/showPattyCashMgmnt">
								<div class="img">
									<!-- <i class="fa fa-file-pdf-o" aria-hidden="true"></i> -->
									<i class="fa fa-archive" aria-hidden="true"></i>
								</div>
								<div class="title">
									Petty <span>Cash</span>
								</div>
						</a></li>
						<li><a
							href="${pageContext.request.contextPath}/showExpenseList"><div
									class="img">
									<!-- <i class="fa fa-file-pdf-o" aria-hidden="true"></i> -->
									<i class="fa fa-list-alt" aria-hidden="true"></i>
								</div>
								<div class="title">
									Expense <span>List</span>
								</div></a></li>
					</c:if> --%>


					<c:set var="flag" value="${0}"></c:set>
					<c:forEach items="${setList}" var="setting" varStatus="count">
						<c:choose>

							<c:when test="${setting.settingKey eq 'Edit Profile'}">
								<c:set var="flag" value="${1}"></c:set>
							</c:when>


						</c:choose>
					</c:forEach>


					<c:if test="${sessionScope.frEmpDetails.designation==1 && flag==1}">

						<li><a
							href="${pageContext.request.contextPath}/showCkOrders"><div
									class="img">

									<!-- <i class="fa fa-file-pdf-o" aria-hidden="true"></i> -->
									<i class="fa fa-list  " aria-hidden="true"></i>
								</div>
								<div class="title">
									Orders 
								</div></a></li>

						<li><a
							href="${pageContext.request.contextPath}/showItemConfig"><div
									class="img">

									<!-- <i class="fa fa-file-pdf-o" aria-hidden="true"></i> -->
									<i class="fa fa-cog " aria-hidden="true"></i>
								</div>
								<div class="title">
									Item <span>Configuration</span>
								</div></a></li>


						
					</c:if> 
					
					<li><a
							href="${pageContext.request.contextPath}/showOrderList"><div
									class="img">
									<!-- <i class="fa fa-file-pdf-o" aria-hidden="true"></i> -->
									<i class="fa fa-list-alt" aria-hidden="true"></i>
								</div>
								<div class="title">
									Order <span>List</span>
								</div></a></li>
					<li><a
							href="${pageContext.request.contextPath}/showeditprofile"><div
									class="img">

									<!-- <i class="fa fa-file-pdf-o" aria-hidden="true"></i> -->
									<i class="fa fa-pencil" aria-hidden="true"></i>
								</div>
								<div class="title">
									Edit <span>Profile</span>
								</div></a></li>

					<c:if test="${flag==1}">

						<li><a href="${pageContext.request.contextPath}/changePass"><div
									class="img">
									<!-- <i class="fa fa-file-pdf-o" aria-hidden="true"></i> -->
									<i class="fa fa-lock" aria-hidden="true"></i>
								</div>
								<div class="title">
									Change <span>Password</span>
								</div></a></li>
					</c:if>
				</ul>
			</div>
		</div>
		<!--leftNav-->

		<!--navInner-->

		<!--1nav-->
		<div id="mySidenav" class="sidenav">
			<div class="topSlide">
				<div class="topSlide2">
					<a href="javascript:void(0)" class="closebtn" onClick="closeNav()"><img
						src="${pageContext.request.contextPath}/resources/images/closebtn.png"
						alt="madhvi"></a>
					<div class="listarea">
						<ul>

							<c:forEach var="menu" items="${menuList}" varStatus="loop">
								<c:set var="menuToTime" value="${menu.toTime}" />
								<c:set var="menuFromTime" value="${menu.fromTime}" />
								<c:set var="menuDesc" value="${menu.menuDesc}" />

								<c:set var="menuDay" value="${menu.day}" />
								<c:set var="menuDate" value="${menu.date}" />

								<c:set var="frId" value="${menu.frId}" />
								<c:set var="isSameDayApplicable"
									value="${menu.isSameDayApplicable}" />
								<c:set var="settingType" value="${menu.settingType}" />

								<c:set var="catId" value="${menu.catId}" />

								<%
									ZoneId z = ZoneId.of("Asia/Calcutta");
										LocalTime now = LocalTime.now(z); // Explicitly specify the desired/expected time zone.

										//String settType=(String) pageContext.getAttribute("setting");

										String menuToTiming = (String) pageContext.getAttribute("menuToTime");
										String menuFromTiming = (String) pageContext.getAttribute("menuFromTime");

										String menuDay = (String) pageContext.getAttribute("menuDay");
										String menuDate = (String) pageContext.getAttribute("menuDate");

										String menuDesc = (String) pageContext.getAttribute("menuDesc");

										SimpleDateFormat _24HourSDF = new SimpleDateFormat("HH:mm");
										SimpleDateFormat _12HourSDF = new SimpleDateFormat("hh:mm a");
										Date fromTime12Hrs = _24HourSDF.parse(menuFromTiming);
										Date toTime12Hrs = _24HourSDF.parse(menuToTiming);

										// System.out.println(_24HourDt);
										//  System.out.println(_12HourSDF.format(_24HourDt));

										pageContext.setAttribute("fromTime", _12HourSDF.format(fromTime12Hrs));
										pageContext.setAttribute("toTime", _12HourSDF.format(toTime12Hrs));

										int isSameDayApplicable = (int) pageContext.getAttribute("isSameDayApplicable");
										int catId = (Integer) pageContext.getAttribute("catId");
										int settingType = (int) pageContext.getAttribute("settingType");

										System.out.println("\n\n\nMenu To Timing" + menuToTiming);
										System.out.println("Menu From Timing" + menuFromTiming);

										LocalTime toTime = LocalTime.parse(menuToTiming);
										LocalTime fromTime = LocalTime.parse(menuFromTiming);

										Boolean isLate = now.isAfter(toTime);
										Boolean isEarly = now.isBefore(fromTime);

										System.out.println("\nLocal time" + now + "Is Early :" + isLate);
										System.out.println("Local time" + now + "Is Late :" + isLate);

										/* 	try {
											    final SimpleDateFormat sdf = new SimpleDateFormat("H:mm");
											    final Date dateObj = sdf.parse(time);
											    System.out.println(dateObj);
											    System.out.println(new SimpleDateFormat("K:mm").format(dateObj));
											} catch (final ParseException e) {
											    e.printStackTrace();
											} */
										Boolean isSameDay = fromTime.isBefore(toTime);
										Boolean isValid = false;

										if (isSameDay) {
											System.out.println("in isSameDay if loop");

											if (!isLate && !isEarly) {

												isValid = true;
											}
										} else {
											System.out.println("in isSameDay else loop");

											if (now.isAfter(fromTime)) {
												isValid = true;
											} else if (toTime.isAfter(now)) {
												isValid = true;
											}
										}

										if (isValid) {
								%>

								<li>
									<%
										if (catId != 5) {

													if (isSameDayApplicable == 3) {
														// if
														if (settingType != 1) {
									%> <abbr title='${menu.menuDesc}'>
										<div class="listareaBoxBlue">
								</abbr> <a class="listareaBoximg"
									href="${pageContext.request.contextPath}/showsPlaceOrder/${loop.index}">



										<%
											//else
															} else {
										%> <abbr title='${menu.menuDesc}'><a
											class="listareaBox"
											href="${pageContext.request.contextPath}/showsPlaceOrder/${loop.index}"><div
													class="listareaBoximg"></abbr> <%
 	}
 				} else {
 					if (settingType != 1) {
 						//if
 %> <abbr title='${menu.menuDesc}'><a class="listareaBoxBlue"
											href="${pageContext.request.contextPath}/showSavouries/${loop.index}">
												<div class="listareaBoximg"></abbr> <%
 	} else {
 %> <abbr title='${menu.menuDesc}'> <a class="listareaBox"
											href="${pageContext.request.contextPath}/showSavouries/${loop.index}">
												<div class="listareaBoximg"></abbr> <%
 	}
 				}
 			} else if (catId == 5) {

 				// if
 				if (settingType != 1) {
 %> <abbr title='${menu.menuDesc}'><a class="listareaBoxBlue"
											href="${pageContext.request.contextPath}/showSpCakeOrder/${loop.index}">
												<div class="listareaBoximg"></abbr> <%
 	//else
 				} else {
 %> <abbr title='${menu.menuDesc}'><a class="listareaBox"
											href="${pageContext.request.contextPath}/showSpCakeOrder/${loop.index}">
												<div class="listareaBoximg"></abbr> <%
 	}

 			}
 %> <img
										src="${pageContext.request.contextPath}/resources/newpos/images/${menu.menuImage}"
										alt="madhvi"> <img
										src="${pageContext.request.contextPath}/resources/newpos/images/${menu.selectedMenuImage}"
										alt="madhvi">
					</div>
					<h2>
						<c:out value='${menu.menuTitle}' />
					</h2>
					<h3 style="margin-bottom: 0; padding-bottom: 0;">
						Booking -
						<c:out value='${fromTime}' />
						To
						<c:out value='${toTime}' />
					</h3>

					<%
						if (settingType == 1) {
					%>
					<h3 style="margin-bottom: 0; padding-bottom: 0;">Daily</h3>
					<%
						} else if (settingType == 2) {
					%>
					<h3 style="margin-bottom: 0; padding-bottom: 0;">Date :
						${menuDate}</h3>
					<%
						} else if (settingType == 3) {
					%>
					<h3 style="margin-bottom: 0; padding-bottom: 0;">
						Day :

						<c:forTokens items="${menuDay}" delims="," var="name">

							<c:if test="${name eq '1'}">
							Sunday,&nbsp; 
							</c:if>

							<c:if test="${name eq '2'}">
							Monday,&nbsp; 
							</c:if>

							<c:if test="${name eq '3'}">
							Tuesday,&nbsp;
							</c:if>

							<c:if test="${name eq '4'}">
							Wednesday,&nbsp;
							</c:if>

							<c:if test="${name eq '5'}">
							Thursday,&nbsp;
							</c:if>

							<c:if test="${name eq '6'}">
							Friday,&nbsp;
							</c:if>

							<c:if test="${name eq '7'}">
							Saturday
							</c:if>

						</c:forTokens>

					</h3>

					<%
						}
					%>

					</a>
					</li>


					<%
						} else {
					%>


					<li>

						<div class="listareaBox" style="background-color: #eedfdf;">

							<a class="listareaBoximg"> <img
								src="${pageContext.request.contextPath}/resources/newpos/images/${menu.menuImage}"
								alt="madhvi"> <img
								src="${pageContext.request.contextPath}/resources/newpos/images/${menu.selectedMenuImage}"
								alt="madhvi">
							</a>


							<h2 style="color: grey;">
								<c:out value='${menu.menuTitle}' />
							</h2>
							<h3 style="color: grey;">
								Booking -
								<c:out value='${fromTime}' />
								To
								<c:out value='${toTime}' />
							</h3>



							</a>
						</div>

					</li>
					<%
						}
					%>
					</c:forEach>




					</ul>
				</div>

			</div>
		</div>
</div>
<!--1nav-->



<!--2nav-->
<div id="mySidenav1" class="sidenav">
	<div class="topSlide">
		<div class="topSlide2">
			<a href="javascript:void(0)" class="closebtn" onClick="closeNav1()"><img
				src="${pageContext.request.contextPath}/resources//images/closebtn.png"
				alt="madhvi"></a>
			<div class="listarea">


				<ul>
					<%-- <li class="small-box">

						<div class="ibox">
							<div class="ibox-head">
								<div class="ibox-title">GRN</div>
							</div>


							<a href="${pageContext.request.contextPath}/getGrnBillDetail"><i
								class="fa fa-plus-circle icon"></i> Grn Based on Expiry of
								product </a>
							<div class="clearfix"></div>
							<a href="${pageContext.request.contextPath}/showGrn"><i
								class="fa fa-plus-circle icon"></i> Grn Based on stock FIFO
								method </a>
							<div class="clearfix"></div>
							<a href="${pageContext.request.contextPath}/displayGrn"><i
								class="fa fa-search-plus icon"></i> View GRN </a>
							<div class="clearfix"></div>

							<a href="${pageContext.request.contextPath}/getGrnBillDetail"><i class="fa fa-search-plus icon"></i> Manual GRN </a>

						</div>
					</li>
 --%>
					<li class="small-box">
						<div class="ibox">
							<div class="ibox-head">
								<div class="ibox-title">GRN & GVN</div>
							</div>

							<a href="${pageContext.request.contextPath}/displayGrn"><i
								class="fa fa-search-plus icon"></i> View GRN </a>
							<div class="clearfix"></div>

							<a href="${pageContext.request.contextPath}/showGvn"><i
								class="fa fa-plus-circle icon"></i> Request GVN </a> <a
								href="${pageContext.request.contextPath}/displayGvn"><i
								class="fa fa-search-plus icon"></i> View GVN </a>

						</div>
					</li>


				</ul>
			</div>

		</div>
	</div>
</div>
<!--2nav-->

<!--4nav-->
<div id="mySidenav4" class="sidenav">
	<div class="topSlide">
		<div class="topSlide2">
			<a href="javascript:void(0)" class="closebtn" onClick="closeNav4()"><img
				src="${pageContext.request.contextPath}/resources//images/closebtn.png"
				alt="madhvi"></a>
			<div class="listarea">
				<ul>
					<div class="row">


						<c:if
							test="${sessionScope.frEmpDetails.designation==1 or sessionScope.frEmpDetails.designation==2}">
							<li class="small-box">

								<div class="ibox">
									<div class="ibox-head">
										<div class="ibox-title">Reports</div>
									</div>

									<a
										href="${pageContext.request.contextPath}/showOrderWiseReportBetDate"><i
										class="fa fa-files-o icon"></i>Order Wise Report</a>
<!-- 										 <a -->
<%-- 										href="${pageContext.request.contextPath}/showDateWiseBillReport"><i --%>
<!-- 										class="fa fa-files-o icon"></i>Order Date Wise Report</a> -->
										 <a
										href="${pageContext.request.contextPath}/getShopFrReport"><i
										class="fa fa-files-o icon"></i>Shop Report</a>
										
<!-- 										<a -->
<%-- 										href="${pageContext.request.contextPath}/monthWiseOrderReport"><i --%>
<!-- 										class="fa fa-files-o icon"></i>Month Wise Bill Report</a> -->
										
										<a
										href="${pageContext.request.contextPath}/showCustWiseReportBetDate"><i
										class="fa fa-files-o icon"></i>Customer Wise Report
										Purchase Report</a>
										<%--  <a
										href="${pageContext.request.contextPath}/showSaleReportBySubCategory"><i
										class="fa fa-files-o icon"></i> Sub Category Summary Report</a> <a
										href="${pageContext.request.contextPath}/showFranchiseeWiseBillReport"><i
										class="fa fa-files-o icon"></i> Bill Credit Note Summary
										Report</a> <a
										href="${pageContext.request.contextPath}/viewItemWiseReport"><i
										class="fa fa-files-o icon"></i>Itemwise Purchase Report</a> <a
										href="${pageContext.request.contextPath}/showYearlyFrSubCatSaleReport"><i
										class="fa fa-files-o icon"></i>Month Wise Sub Category
										Purchase Report Or Month Wise Item Purchase Report</a>
 --%>

								</div>
							</li>
						</c:if>


					<%-- 	<c:if
							test="${sessionScope.frEmpDetails.designation==1 or sessionScope.frEmpDetails.designation==2}">
							<li class="small-box">

								<div class="ibox">
									<div class="ibox-head">
										<div class="ibox-title">Other Reports</div>
									</div>
									<a
										href="${pageContext.request.contextPath}/showCutomerPendingList"><i
										class="fa fa-files-o icon"></i>Customer Pending Details</a>
									
								 <a href="${pageContext.request.contextPath}/showSpAdvanceReport"><i
									class="fa fa-files-o icon"></i>SP Advance Report</a>
								 
								 // <a
								href="${pageContext.request.contextPath}/showSpAdvTaxReport"><i
								class="fa fa-files-o icon"></i>Sp Advance Tax Report</a> //
								
								<a
									href="${pageContext.request.contextPath}/showInsertCreditNote"><i
									class="fa fa-files-o icon"></i>Credit Note Report</a> <a
									href="${pageContext.request.contextPath}/showCumulativeCrnNotes"><i
									class="fa fa-files-o icon"></i>Cumulative Credit Note</a> <a
									href="${pageContext.request.contextPath}/grnReport"><i
									class="fa fa-files-o icon"></i> GRN Report (Sale)</a> <a
									href="${pageContext.request.contextPath}/gvnReport"><i
									class="fa fa-files-o icon"></i> GVN Report (Sale)</a> 

									<a href="${pageContext.request.contextPath}/showCutomerList"><i
										class="fa fa-files-o icon"></i>Customer List(Sale)</a>
										
									<a href="${pageContext.request.contextPath}/showOnlineOrderHistory"><i
										class="fa fa-files-o icon"></i>Online Order History</a>
										
									<a href="${pageContext.request.contextPath}/showDeliveryBoyWiseReport"><i
										class="fa fa-files-o icon"></i>Delivery Boy Wise Report</a>
								</div>
							</li>
						</c:if> --%>

						<%-- <c:if
							test="${sessionScope.frEmpDetails.designation==1 or sessionScope.frEmpDetails.designation==2}">
							<li class="small-box">

								<div class="ibox">
									<div class="ibox-head">
										<div class="ibox-title">Punching Based Reports</div>
									</div>
									<a href="${pageContext.request.contextPath}/viewBillwiseSell"><i
										class="fa fa-files-o icon"></i>Billwise Sale Report</a> <a
										href="${pageContext.request.contextPath}/viewDatewiseSellBill"><i
										class="fa fa-calendar-o icon"></i>Datewise Sale Report</a> <a
										href="${pageContext.request.contextPath}/viewMonthwiseSellBill"><i
										class="fa fa-calendar-o  icon"></i>Monthwise Sale Report</a> <a
										href="${pageContext.request.contextPath}/viewItemwiseSellBill"><i
										class="fa fa-chevron-circle-down icon"></i>Categorywise-
										Itemwise Sale Report</a> <a
										href="${pageContext.request.contextPath}/viewDateItemwiseSellBill">
										<i class="fa fa-chevron-circle-down icon"></i>Datewise-Itemwise
										Sale Report
									</a> <a
										href="${pageContext.request.contextPath}/showYearlySellReport"><i
										class="fa fa-files-o icon"></i>Month Wise Sub Category Sell
										Report Or Month Wise Item Sell Report</a> <a
										href="${pageContext.request.contextPath}/showSubCatDateWiseSellReport"><i
										class="fa fa-files-o icon"></i>Datewise Sub Category Sale
										Report</a> <a style="display: none;"
										href="${pageContext.request.contextPath}/showHsnDateWiseSellReport"><i
										class="fa fa-files-o icon"></i>Bill wise HSN wise Report</a> <a
										href="${pageContext.request.contextPath}/viewCustBillwiseSell"><i
										class="fa fa-files-o icon"></i>Customer wise Sell Report</a>


								</div>

							</li>
						</c:if> --%>
					</div>
					<%-- <div class="row">
						<li class="small-box">

							<div class="ibox">
								<div class="ibox-head">
									<div class="ibox-title">
										<!-- Purchase Sale Reports -->
										Purchase/CRN Tax Report
									</div>
								</div>

								<a href="${pageContext.request.contextPath}/showTaxReport"><i
									class="fa fa-files-o icon"></i>Billwise Tax Report </a> <a
									href="${pageContext.request.contextPath}/showTax2Report"><i
									class="fa fa-files-o icon"></i>Billwise Tax Percentage Report</a> <a
									href="${pageContext.request.contextPath}/showCRNoteRegister"><i
									class="fa fa-files-o icon"></i>Credit Note Tax Percentage
									Report</a> <a
									href="${pageContext.request.contextPath}/showCRNoteRegisterDone"><i
									class="fa fa-files-o icon"></i>Credit Note HSNwise Report</a> <a
									href="${pageContext.request.contextPath}/showHSNwiseReportBetDate"><i
									class="fa fa-files-o icon"></i>HSN wise Summary Report</a>
								<a
									href="${pageContext.request.contextPath}/showGstRegister"><i
									class="fa fa-files-o icon"></i>Billwise HSN Register Report</a>
								<a
								href="${pageContext.request.contextPath}/viewItemWiseReport"><i
								class="fa fa-files-o icon"></i>Itemwise Purchase Report</a>
								<a
									href="${pageContext.request.contextPath}/viewBillTaxPurchaseReport"><i
									class="fa fa-files-o icon"></i>Purchase Billwise Tax (Input)
									Report</a>



							</div>
						</li>
						<li class="small-box">


							<div class="ibox">
								<div class="ibox-head">
									<div class="ibox-title">Sale Tax Report</div>
								</div>
								<a href="${pageContext.request.contextPath}/viewFrTaxSellBill"><i
									class="fa fa-file-text-o icon"></i> Tax Report Summary (Sale) </a>
								<a
									href="${pageContext.request.contextPath}/viewFrDatewiseTaxSellBill"><i
									class="fa fa-calendar icon"></i> Date Report (Sale) </a> <a
									href="${pageContext.request.contextPath}/viewFrBillwiseTaxSellBill"><i
									class="fa fa-files-o icon"></i> Bill Report (Sale)</a> <a
									href="${pageContext.request.contextPath}/hsnWiseReport"><i
									class="fa fa-files-o icon"></i> HSN Code wise Report (Sale)</a> <a
									href="${pageContext.request.contextPath}/itemWiseHsnReport"><i
									class="fa fa-files-o icon"></i> Item wise HSN Report (Sale)</a> <a
									href="${pageContext.request.contextPath}/viewDailySalesReport"><i
									class="fa fa-files-o icon"></i> Daily Sales Report</a> <a
									href="${pageContext.request.contextPath}/viewCrnTaxSellBill"><i
									class="fa fa-file-text-o icon"></i> Tax Report Summary (Credit
									Note) </a> <a
									href="${pageContext.request.contextPath}/viewFrCRNTaxSellBill"><i
									class="fa fa-file-text-o icon"></i> Bill Report (Credit Note) </a>
							</div>

						</li>


								<li class="small-box">

							<div class="ibox">
								<div class="ibox-head">
									<div class="ibox-title">Customer Reports</div>
								</div>
								<a
									href="${pageContext.request.contextPath}/showCutomerPendingList"><i
									class="fa fa-files-o icon"></i>Customer Pending Report</a>
							</div>
						</li>

					</div> --%>
				</ul>
			</div>
		</div>

		</section>

	</div>
</div>
<%-- </c:if> --%>
<script type="text/javascript">
	var btn = $('#button');

	$(window).scroll(function() {
		if ($(window).scrollTop() > 300) {
			btn.addClass('show');
		} else {
			btn.removeClass('show');
		}
	});

	btn.on('click', function(e) {
		e.preventDefault();
		$('html, body').animate({
			scrollTop : 0
		}, '300');
	});
	/* 	$('html, body').animate({scrollTop:170}, '300'); */
</script>
<script type="text/javascript">
	var requestFullscreen = function(ele) {
		if (ele.requestFullscreen) {
			ele.requestFullscreen();
		} else if (ele.webkitRequestFullscreen) {
			ele.webkitRequestFullscreen();
		} else if (ele.mozRequestFullScreen) {
			ele.mozRequestFullScreen();
		} else if (ele.msRequestFullscreen) {
			ele.msRequestFullscreen();
		} else {
			console.log('Fullscreen API is not supported.');
		}
	};

	var exitFullscreen = function() {
		if (document.exitFullscreen) {
			document.exitFullscreen();
		} else if (document.webkitExitFullscreen) {
			document.webkitExitFullscreen();
		} else if (document.mozCancelFullScreen) {
			document.mozCancelFullScreen();
		} else if (document.msExitFullscreen) {
			document.msExitFullscreen();
		} else {
			console.log('Fullscreen API is not supported.');
		}
	};

	var fsDocButton = document.getElementById('fs-doc-button');
	var fsExitDocButton = document.getElementById('fs-exit-doc-button');

	fsDocButton.addEventListener('click', function(e) {
		e.preventDefault();
		requestFullscreen(document.documentElement);
	});

	fsExitDocButton.addEventListener('click', function(e) {
		e.preventDefault();
		exitFullscreen();
	});
</script>
<script>
	function openNav() {
		document.getElementById("mySidenav").style.width = "100%";
	}

	function closeNav() {
		document.getElementById("mySidenav").style.width = "0";
	}
	function openNav1() {
		document.getElementById("mySidenav1").style.width = "100%";
	}

	function closeNav1() {
		document.getElementById("mySidenav1").style.width = "0";
	}
	function openNav3() {
		document.getElementById("mySidenav3").style.width = "100%";
	}

	function closeNav3() {
		document.getElementById("mySidenav3").style.width = "0";
	}
	function openNav4() {
		document.getElementById("mySidenav4").style.width = "100%";

	}

	function closeNav4() {
		document.getElementById("mySidenav4").style.width = "0";
	}
</script>

<script
	src="${pageContext.request.contextPath}/resources/js/owl.carousel.min.js"></script>
<script>
	$(document).ready(function() {
		$('.imgpath').click(function() {
			$(this).hide();
			$('.videoWrapper').show();
			$(".sproutvideo-player")[0].src += "?autoplay=1";
		});
		var owl = $("#owl-example");
		owl.owlCarousel({
			items : 2,
			loop : false,
			autoplay : false,
		});

	});
</script>

<script type="text/javascript">
	function showWindow(fromTime, toTime) {
		confirm("Timeout:\n You can place order from " + fromTime + " To "
				+ toTime);
	}
</script>


<!-- custom scrollbar plugin added by kalpesh -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery.mCustomScrollbar.concat.min.js"></script>


<script type="text/javascript">
	/*Dropdown Menu*/
	$('.dropdown').click(function() {
		$(this).attr('tabindex', 1).focus();
		$(this).toggleClass('active');
		$(this).find('.dropdown-menu').slideToggle(300);
	});
	$('.dropdown').focusout(function() {
		$(this).removeClass('active');
		$(this).find('.dropdown-menu').slideUp(300);
	});
	$('.dropdown .dropdown-menu li').click(
			function() {
				$(this).parents('.dropdown').find('span').text($(this).text());
				$(this).parents('.dropdown').find('input').attr('value',
						$(this).attr('id'));
			});
	/*End Dropdown Menu*/
</script>

<!-- custom scrollbar plugin -->
<script
	src="${pageContext.request.contextPath}/resources/newpos/js/jquery.mCustomScrollbar.concat.min.js"></script>

<script>
	(function($) {
		$(window).on(
				"load",
				function() {

					/*
					get snap amount programmatically or just set it directly (e.g. "273")
					in this example, the snap amount is list item's (li) outer-width (width+margins)
					 */
					var amount = Math.max.apply(Math, $("#content-1 li").map(
							function() {
								return $(this).outerWidth(true);
							}).get());

					$("#content-1").mCustomScrollbar({
						axis : "x",
						theme : "inset",
						advanced : {
							autoExpandHorizontalScroll : true
						},
						scrollButtons : {
							enable : true,
							scrollType : "stepped"
						},
						keyboard : {
							scrollType : "stepped"
						},
						snapAmount : amount,
						mouseWheel : {
							scrollAmount : amount
						}
					});

				});
	})(jQuery);
</script>
<script>
	//makes sure the whole site is loaded
	jQuery(window).load(function() {
		// will first fade out the loading animation
		jQuery("#status").fadeOut();
		// will fade out the whole DIV that covers the website.
		jQuery("#preloader").delay(1000).fadeOut("fast");
	})
</script>