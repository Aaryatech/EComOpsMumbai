<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.monginis.ops.constant.Constant"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Customer Bill</title>
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
		style="font-family: verdana; font-size: 11px; border: 1px solid #E7E7E7;">
		<tbody>

			<tr>
				<td colspan="2" align="center"
					style="padding: 2px; border-bottom: 1px solid #E7E7E7;"><img
					src="${pageContext.request.contextPath}/resources/images/monginis1.png"
					alt="madhvi_logo"></td>
			</tr>
			<tr>
				<td colspan="2" align="center"
					style="padding: 2px; border-bottom: 1px solid #E7E7E7; font-size: 12px;"><b>TAX
						INVOICE</b></td>
			</tr>
			<tr>
				<td colspan="2" align="center"
					style="padding: 2px; border-bottom: 1px solid #E7E7E7;"><b>${frDetails.frName}
						<br>
				</b></td>
			</tr>
			<tr>
				<td colspan="2" align="center"
					style="padding: 2px; font-family: verdana; border-bottom: 1px solid #E7E7E7; font-size: 11px;">${frDetails.frAddress}
					<br />Outlet Ph:<strong>&nbsp;${frDetails.frContactNo}</strong><br /> <span
					style="font-size: 11px; font-family: verdana;">GSTIN:&nbsp;<b>
							${frDetails.gstNumber}</b> State:&nbsp; <%-- ${frSup.frState} --%> <br>FSSAI:&nbsp;&nbsp;${frDetails.fdaNumber}
				</span>
				</td>
			</tr>
			<c:set var="calTotalAmt" value="0"></c:set>
			<c:set var="totalAmt" value="0"></c:set>
			<c:set var="taxAmount" value="${0}" />
			<c:set var="totaltax" value="${0 }" />
			<c:set var="cgst" value="${0 }" />
			<c:set var="sgst" value="${0 }" />

			<c:if test="${sellBillHeaderAndDetail.remainingAmt>0}">
				<tr>
					<td colspan="2" align="center"
						style="padding: 2px; font-family: verdana; border-bottom: 1px solid #E7E7E7; font-size: 11px;">
						<b>Credit Bill</b>
					</td>
				</tr>
			</c:if>


			<tr>
				<td colspan="2">
					<table width="100%" border="0" cellspacing="0" cellpadding="2">
						<tbody>
							<tr>
								<td align="left">Inv No:</td>
								<td align="left" colspan="3">${sellBillHeaderAndDetail.invoiceNo}</td>
							</tr>
							<tr>
								<td align="left">Date:</td>
								<td align="left" colspan="3">${sellBillHeaderAndDetail.timestamp}</td>

							</tr>
							<tr>
								<td align="left">Place of Supply:</td>
								<td align="left" colspan="3">Gujarat</td>

							</tr>
							<tr>
								<td align="left">Customer :</td>
								<td align="left" colspan="3">${sellBillHeaderAndDetail.custName}</td>

							</tr>
							<%-- <c:if test="${sellBillHeaderAndDetail.gstNo!=''}">
								<tr>
									<td align="left">GST No:</td>
									<td align="left" colspan="3">${sellBillHeaderAndDetail.gstNo}</td>
								</tr>
							</c:if> --%>

							<c:if test="${sellBillHeaderAndDetail.userGstNo != ''}">
								<c:if test="${sellBillHeaderAndDetail.userGstNo != null}">
									<tr>
										<td align="left">Customer GST :</td>
										<td align="left" colspan="3">${sellBillHeaderAndDetail.userGstNo}</td>

									</tr>
								</c:if>
							</c:if>

							<c:choose>
								<c:when test="${sellBillHeaderAndDetail.extInt2 > 0}">
									<c:if test="${sellBillHeaderAndDetail.custAddress!=''}">
										<td align="left">Address :</td>
										<td align="left" colspan="5">${sellBillHeaderAndDetail.custAddress}</td>
									</c:if>
								</c:when>
								<c:otherwise>
									<c:if test="${sellBillHeaderAndDetail.extVar2!=''}">
										<td align="left">Address :</td>
										<td align="left" colspan="5">${sellBillHeaderAndDetail.extVar2}</td>
									</c:if>
								</c:otherwise>
							</c:choose>

							<%-- <tr>
								<td align="left">Address :</td>
								<c:choose>
									<c:when test="${sellBillHeaderAndDetail.extInt2 > 0}">
										<td align="left" colspan="5">${sellBillHeaderAndDetail.custAddress}</td>
									</c:when>
									<c:otherwise>
										<td align="left" colspan="5">${sellBillHeaderAndDetail.extVar2}</td>
									</c:otherwise>
								</c:choose>
							</tr> --%>

							<tr>
								<td align="left">Sales Person:</td>
								<td align="left" colspan="3">${frEmpMaster.frEmpName}</td>
							</tr>

							<tr>
								<td align="left">Payment Mode :</td>
								<td align="left" colspan="3">${paymentMode}</td>
							</tr>

							<tr>
								<td colspan="4"><table width="100%" border="0"
										cellspacing="0" cellpadding="4" class="tbl-inner">
										<tbody>
											<tr>
												<th width="43%" align="left" bgcolor="#ECECEC">Item <span
													style="font-size: 8"> (HSN)</span></th>
												<th width="8%" bgcolor="#ECECEC">GST</th>
												<th width="8%" bgcolor="#ECECEC">Qty</th>
												<th width="8%" bgcolor="#ECECEC" align="right">UOM</th>
												<th width="13%" bgcolor="#ECECEC">Rate</th>
												<th width="29%" align="center" bgcolor="#ECECEC">Amt</th>
											</tr>
											<c:forEach items="${sellBillHeaderAndDetail.list}"
												var="itemBillList" varStatus="count">
												<tr>
													<td><span style="font-size: 11px">${itemBillList.itemName}<br />
															<span style="font-size: 8px">HSN-
																${itemBillList.itemHsncd}</span></span></td>
													<td align="right">${itemBillList.igstPer}%</td>
													<td align="right"><span style="font-size: 11px"><c:choose>
																<c:when test="${itemBillList.isDecimal==1}">
																	<fmt:formatNumber type="number" groupingUsed="false"
																		value="${itemBillList.qty}" maxFractionDigits="3"
																		minFractionDigits="2" />
																</c:when>
																<c:otherwise>
																	<fmt:formatNumber type="number" groupingUsed="false"
																		value="${itemBillList.qty}" maxFractionDigits="0"
																		minFractionDigits="0" />
																</c:otherwise>
															</c:choose> </span></td>
													<td align="right"><span style="font-size: 11px">
															${itemBillList.itemUom} </span></td>
													<td align="right"><span style="font-size: 11px"><fmt:formatNumber
																type="number" groupingUsed="false"
																value="${itemBillList.mrp}" maxFractionDigits="0"
																minFractionDigits="0" /> </span></td>
													<td align="right"><span style="font-size: 11px">
															<fmt:formatNumber type="number" groupingUsed="false"
																value="${itemBillList.discAmt+itemBillList.grandTotal}"
																maxFractionDigits="2" minFractionDigits="2" var="total" />
															${total} <c:set var="calTotalAmt"
																value="${total+calTotalAmt}"></c:set>
													</span></td>
													<c:set var="totalAmt"
														value="${totalAmt+itemBillList.grandTotal}"></c:set>
													<c:set var="taxAmount"
														value="${taxAmount + itemBillList.taxableAmt}" />
													<c:set var="cgst" value="${cgst+itemBillList.cgstRs }" />
													<c:set var="sgst" value="${sgst+custBilltax.sgstRs }" />
													<c:set var="totaltax" value="${cgst+sgst}" />
												</tr>
											</c:forEach>
											<c:if test="${sellBillHeaderAndDetail.discountAmt>0}">
												<tr>
													<td colspan="4" align="right"><span class="style7">SubTotal:</span></td>
													<td align="right"><span class="style7"><fmt:formatNumber
																type="number" maxFractionDigits="2"
																minFractionDigits="2" value="${calTotalAmt}"
																groupingUsed="false" /></span></td>
												</tr>
												<tr>
													<td colspan="4" align="right"><span class="style7">Disc
															Amt:</span></td>
													<td align="right"><span class="style7"><fmt:formatNumber
																type="number" maxFractionDigits="2"
																minFractionDigits="2"
																value="${sellBillHeaderAndDetail.discountAmt}"
																groupingUsed="false" /></span></td>
												</tr>
											</c:if>
											<fmt:formatNumber type="number" maxFractionDigits="2"
												minFractionDigits="2"
												value="${calTotalAmt-sellBillHeaderAndDetail.discountAmt}"
												groupingUsed="false" var="billTotal" />


											<%-- <fmt:formatNumber
															type="number" maxFractionDigits="0" minFractionDigits="0"
															value="${calTotalAmt-sellBillHeaderAndDetail.discountAmt}"
															groupingUsed="false" var="total"/> --%>

											<fmt:formatNumber type="number" maxFractionDigits="0"
												minFractionDigits="0"
												value="${billTotal+ (billTotal % 1 == 0 ? 0 : 0.5)}"
												groupingUsed="false" var="total" />



											<tr>
												<td colspan="4" align="right"><span class="style7">Bill
														Total:</span></td>
												<td align="right"><span class="style7">${billTotal}</span></td>
											</tr>
											<c:if test="${(total-billTotal) != 0}">
												<tr>
													<td colspan="4" align="right"><span class="style7">R.Off:</span></td>
													<td align="right"><span class="style7"><fmt:formatNumber
																type="number" maxFractionDigits="2"
																minFractionDigits="2" value="${total-billTotal}"
																groupingUsed="false" /></span></td>
												</tr>
											</c:if>

											<c:if test="${sellBillHeaderAndDetail.extInt2 > 0}">

												<c:if test="${sellBillHeaderAndDetail.extFloat3 > 0}">
													<tr>
														<td colspan="4" align="right"><span class="style7">Total
																Amount:</span></td>
														<td align="right"><span class="style7">${sellBillHeaderAndDetail.extFloat3}</span></td>
													</tr>
												</c:if>
												<tr>
													<td colspan="4" align="right"><span class="style7">Delivery
															Charges:</span></td>
													<td align="right"><span class="style7">${sellBillHeaderAndDetail.extFloat2}</span></td>
												</tr>


											</c:if>

											<tr>
												<td colspan="4" align="right"><span class="style7">Total:</span></td>

												<c:set value="${total}" var="tot"></c:set>
												<c:if test="${sellBillHeaderAndDetail.extInt2 > 0}">
													<c:set value="${total + sellBillHeaderAndDetail.extFloat2}"
														var="tot"></c:set>
												</c:if>

												<td align="right"><span class="style7">${tot}</span></td>


											</tr>
										</tbody>
									</table></td>
							</tr>
						</tbody>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="2"><table width="100%" border="0" cellspacing="0"
						cellpadding="7">
						<tr>
							<th width="17%" align="left" bgcolor="#ECECEC" rowspan="2">Taxable<br />
								Value
							</th>
							<th bgcolor="#ECECEC" colspan="2">CGST</th>
							<th bgcolor="#ECECEC" colspan="2">SGST</th>
							<th width="25%" align="center" bgcolor="#ECECEC">Total</th>
						</tr>

						<tr>
							<th width="14%" bgcolor="#ECECEC">%</th>
							<th width="15%" bgcolor="#ECECEC">Amt</th>
							<th width="16%" bgcolor="#ECECEC">%</th>
							<th width="13%" bgcolor="#ECECEC">Amt</th>
							<th width="25%" align="center" bgcolor="#ECECEC">GST</th>
						</tr>
						<c:forEach items="${sellBillHeaderAndDetail.taxlabList}"
							var="taxlabList">
							<tr>
								<td bgcolor="#ECECEC"><b><fmt:formatNumber
											type="number" minFractionDigits="2" maxFractionDigits="2"
											value="${taxlabList.taxableAmt}" /></b></td>

								<td bgcolor="#ECECEC">${taxlabList.cgstPer}%</td>
								<td bgcolor="#ECECEC"><fmt:formatNumber type="number"
										minFractionDigits="2" maxFractionDigits="2"
										value="${taxlabList.cgstRs}" /></td>
								<td bgcolor="#ECECEC">${taxlabList.sgstPer}%</td>
								<td bgcolor="#ECECEC"><fmt:formatNumber type="number"
										minFractionDigits="2" maxFractionDigits="2"
										value="${taxlabList.sgstRs}" /></td>
								<td align="center" bgcolor="#ECECEC"><fmt:formatNumber
										type="number" minFractionDigits="2" maxFractionDigits="2"
										value="${taxlabList.cgstRs+taxlabList.sgstRs}" /></td>
							</tr>
						</c:forEach>

						<c:if test="${sellBillHeaderAndDetail.extInt2 > 0}">
							<tr>
								<td align="center"
									style="border-top: 1px solid #E7E7E7; padding: 3px;"
									colspan="6"><span> Delivery Boy :
										${sellBillHeaderAndDetail.delBoyName} -
										${sellBillHeaderAndDetail.delBoyMobile}</span></td>
							</tr>
						</c:if>

						<tr>
							<td align="center"
								style="border-top: 1px solid #E7E7E7; padding: 3px;" colspan="6"><span>
									Customer Care: 0000000088 </span></td>
						</tr>

						<tr>
							<td align="left"
								style="border-top: 1px solid #E7E7E7; padding: 3px;" colspan="6"><span>
									For any enquiry contact  us<br> Ph: 82600
									60048/49<br> Visit us on www.monginis.in<br> Please
									Email us your feedback/suggestions on<br>
									monginis@gmail.com<br> This is a computer generated
									invoice <br> Subject to ${frDetails.frCity} Jurisdiction
							</span></td>
						</tr>
						<tr>
							<td align="center"
								style="border-top: 1px solid #E7E7E7; padding: 3px;" colspan="6"><span
								style="font-weight: bold;">With You @ Your Great Moments!
							</span></td>
						</tr>
						<!-- <tr>
							<td style="border-top: 1px solid #E7E7E7; padding: 2px;"
								colspan="6">-For wholesale inquiry contact DairyMart Team
								<br>-visit us on www.madhvi.in<br>-Email
								feedback/suggestions on monginis@gmail.com<br>-This is a
								computer generated invoice
							</td>
						</tr> -->
					</table></td>
			</tr>
			<%-- <tr>
				<td width="200" align="center"
					style="border-top: 1px solid #E7E7E7; padding: 5px 7px;"><strong>For
						${billList[0].frName}</strong></td>
			</tr> --%>
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