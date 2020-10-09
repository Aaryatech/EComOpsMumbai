<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Order KOT</title>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title></title>
</head>
<style type="text/css">
.style2 {
	font-size: 14px
}

.style5 {
	font-size: 10px
}

.style6 {
	font-size: 9px
}

.style7 {
	font-size: 12px;
	font-weight: bold;
}

.style8 {
	font-size: 11px;
	font-weight: bold;
}
</style>
</head>

</head>
<body>

	<table width="250" border="0" cellspacing="0" cellpadding="0"
		style="padding: 2px; font-family: verdana; font-size: 12px; border: 1px solid #E7E7E7;">
		<tbody>

			<tr>
				<td colspan="2" align="center" style="padding: 2px;"><span><b>${frName}</b><br />
				</span></td>
			</tr>
			<tr>
				<td colspan="2" align="center"
					style="padding: 2px; border-top: 1px solid #E7E7E7; font-size: 12px;"><span><b>Sales
							Person:&nbsp;${frEmpMaster.frEmpName} </b><br /> </span></td>
			</tr>
			<tr>
				<td colspan="2" align="center"
					style="padding: 2px; border-top: 1px solid #E7E7E7; font-size: 9px;"><span><b>Date
							& Time:&nbsp;</b></span><br /></td>
			</tr>
			<tr>
				<td colspan="2">
					<table width="100%" border="0" cellspacing="0" cellpadding="2">
						<tbody>
							<c:set var="totalAmt" value="0"></c:set>
							<c:set var="calTotalAmt" value="0"></c:set>
							<tr>
								<td colspan="4"><table width="100%" border="0"
										cellspacing="0" cellpadding="3" class="tbl-inner">
										<tbody>

											<tr>
												<td align="left">Inv No:</td>
												<td align="left" colspan="3"></td>
											</tr>

											<tr>
												<th width="43%" align="left" bgcolor="#ECECEC">Item</th>
												<th width="8%" bgcolor="#ECECEC" align="right">QTY</th>
												<th width="8%" bgcolor="#ECECEC" align="right">UOM</th>
												<th width="13%" bgcolor="#ECECEC" align="right">Rate</th>
												<th width="29%" align="right" bgcolor="#ECECEC">AMT</th>
											</tr>

											<c:forEach items="${order.orderDetailList}" var="item"
												varStatus="count">
												<tr>

													<td><span style="font-size: 11px">${item.itemName}</span>
													</td>

													<td align="right"><span style="font-size: 11px"><c:choose>
																<c:when test="${itemBillList.isDecimal==1}">
																	<fmt:formatNumber type="number" groupingUsed="false"
																		value="${item.qty}" maxFractionDigits="3"
																		minFractionDigits="3" />
																</c:when>
																<c:otherwise>
																	<fmt:formatNumber type="number" groupingUsed="false"
																		value="${item.qty}" maxFractionDigits="0"
																		minFractionDigits="0" />
																</c:otherwise>
															</c:choose> </span></td>

													<td align="right"><span style="font-size: 11px">
															${item.itemUom} </span></td>

													<td align="right"><span style="font-size: 11px"><fmt:formatNumber
																type="number" groupingUsed="false" value="${item.mrp}"
																maxFractionDigits="0" minFractionDigits="0" /> </span></td>

													<td align="right"><span style="font-size: 11px">

															<fmt:formatNumber type="number" groupingUsed="false"
																value="${item.discAmt+item.totalAmt}"
																maxFractionDigits="2" minFractionDigits="2" var="total" />
															${total} <c:set var="calTotalAmt"
																value="${calTotalAmt+total}"></c:set>

													</span></td>
													<c:set var="totalAmt" value="${totalAmt+item.totalAmt}"></c:set>
												</tr>
											</c:forEach>

											<tr>

												<td colspan="3" align="right"><span class="style7">Sub
														Total:</span></td>
												<td align="right"><span class="style7"> <fmt:formatNumber
															type="number" maxFractionDigits="2" minFractionDigits="2"
															value="${order.totalAmt}" groupingUsed="false" /></span></td>
											</tr>


											<c:if test="${order.discAmt > 0}">

												<tr>

													<td colspan="3" align="right"><span class="style7">Disc
															Amt:</span></td>
													<td align="right"><span class="style7"> <fmt:formatNumber
																type="number" maxFractionDigits="2"
																minFractionDigits="2" value="${order.discAmt}"
																groupingUsed="false" /></span></td>
												</tr>

											</c:if>



											<tr>

												<td colspan="3" align="right"><span class="style7">Bill
														Total:</span></td>
												<td align="right"><span class="style7"> <fmt:formatNumber
															type="number" maxFractionDigits="2" minFractionDigits="2"
															value="${order.totalAmt}" groupingUsed="false" /></span></td>
											</tr>


											<tr>
												<td align="left" colspan="5" style="border-top: 1px solid;">
													Please ask Cashier for Tax Invoice.</td>
											</tr>

										</tbody>
									</table></td>
							</tr>
						</tbody>
					</table>
				</td>
			</tr>

		</tbody>
	</table>
</body>
<body onload="directPrint()">
	<script>
		function directPrint() {
			window.print();

		}
	</script>
</body>
</html>