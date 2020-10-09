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


<body>
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

					<div class="latestNews" style="background: #ed1c24;">

						<h3 class="latestNewsTitle"
							style="background: #fcf300; color: #111111;">Latest News</h3>
						<div class="microsoft marquee" style="margin-left: 70px;">
							<c:forEach items="${schedulerLists}" var="schedulerLists"
								varStatus="count">

								<c:set var="colors" value="" />
								<c:choose>
									<c:when test="${count.index%2==0}">
										<c:set var="colors" value="white" />
									</c:when>
									<c:otherwise>
										<c:set var="colors" value="lightblue" />
									</c:otherwise>
								</c:choose>
								<span style="color:${colors}">
									${schedulerLists.schMessage} </span>


							</c:forEach>
						</div>
					</div>


					<div id="owl-example" class="owl-carousel">


						<c:forEach items="${msgList}" var="msgList">

							<div class="item">
								<div class="screen4plan">
									<div class="homesliderImg">
										<img src="${url}${msgList.msgImage}" />


									</div>
									<h3 class="homesliderTitle" style="font-size: 15px">
										<center>${msgList.msgHeader}</center>
									</h3>
									<h3 class="homesliderTitle">
										<center>${msgList.msgDetails}</center>
									</h3>

								</div>
							</div>
						</c:forEach>

 
					</div>






					<div class="clr"></div>
				</div>








			</section>
		</div>
		<!--wrapper-end-->
	</form>













</body>
</html>
