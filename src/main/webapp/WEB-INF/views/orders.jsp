<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="sections/head.jsp" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<div class="container">
		<jsp:include page="sections/header.jsp" />
			<table
				class="table table-striped table-bordered table-condensed table-responsive small">
				<thead>
					<tr>

						<th style="text-align: center;"><spring:message code="orders.client" /></th>
						<th style="text-align: center;"><spring:message code="orders.reference" /></th>
						<th style="text-align: center;"><spring:message code="orders.deliveryAddress" /></th>
						<th style="text-align: center;"><spring:message code="orders.startDate" /></th>
						<th style="text-align: center;"><spring:message code="orders.state" /></th>
						<th style="text-align: center;"><spring:message code="orders.deliveryDate" /></th>
						<th style="text-align: center;"><spring:message code="orders.details" /></th>

					</tr>
				</thead>
				<tbody>
					
						<c:forEach items="${orders}" var="order">
						
							<tr>
								<td>${order.client.firstName}</td>
								
								<td><spring:message code="orders.prefix.reference"/>${order.reference}</td>
								
								<td>${order.deliveryAddress.address}</td>
								
								<td>
									<fmt:formatDate value="${order.startDate}"
										pattern="MMM dd, yyyy" />
								</td>
								
								<sec:authorize access="hasRole('ROLE_USER')">
								
									<td><spring:message code="${states[order.state]}" /></td>
									
								</sec:authorize>
								
								<sec:authorize access="hasRole('ROLE_ADMIN')">
								
									<td>
									
										<form action="<spring:url value="/admin/orders/setState"/>"
											method="POST">
											<div class="form-group">
												<select name="state" class="form-control input-sm"
													onchange="$(this).closest('form').submit();">
													<c:forEach var="state" items="${states}" varStatus="count">
														<option value="${count.index}"
															${order.state==count.index?'selected="selected"':''}>
															<spring:message code="${states[count.index]}" />
														</option>
													</c:forEach>
												</select>
											</div>
											<input type="hidden" name="reference"
												value="${order.reference}" />
										</form>
										
									</td>
									
								</sec:authorize>
								
								<sec:authorize access="hasRole('ROLE_USER')">
								
									<td>
										<fmt:formatDate value="${order.deliveryDate}"
										pattern="MMM dd, yyyy" /></td>											
								</sec:authorize>
								
								<sec:authorize access="hasRole('ROLE_ADMIN')">
								
									<td>
									
										<form
											action="<spring:url value="/admin/orders/setDeliveryDate"/>"
											method="POST">
											<div class="form-group">
												<fmt:formatDate var="fmtDate" pattern="yyyy-MM-dd"
													value="${order.deliveryDate}" />
												<input id="inputDate" type="date" min="${order.startDate}" class="form-control input-sm"
													name="deliveryDate" value="${fmtDate}"
													onchange="$(this).closest('form').submit();">
											</div>
											<input type="hidden" name="reference"
												value="${order.reference}" />
										</form>
										
									</td>
									
								</sec:authorize>
								
								<td>
								
									<table class="table table-bordered">
									
										<thead>
											<tr>
												<th><spring:message code="finishOrder.reference" /></th>
												<th><spring:message code="finishOrder.items" /></th>
												<th><spring:message code="finishOrder.price" /></th>
												<th><label for="totalQuantity"><spring:message
															code="finishOrder.quantity" /></label></th>
												<th><spring:message code="finishOrder.amount" /></th>
											</tr>
										</thead>
										<c:forEach items="${order.items}" var="item">
										<c:set var="itemKey" value="${item.key}"/>
										<c:set var="itemVal" value="${item.value}"/>
											<tbody>
												<tr>
													<td>${itemKey.reference}</td>
													<td>${itemKey.name}</td>
													<td><fmt:formatNumber value="${itemKey.price}" type="currency"
														currencySymbol="${currencySymbol}" pattern="#,###,##0.00 ¤"/>
													</td>
													<td>${itemVal}</td>
													<td><fmt:formatNumber value="${itemKey.price * itemVal}" type="currency"
														currencySymbol="${currencySymbol}" pattern="#,###,##0.00 ¤"/>
													</td>
												</tr>
										</c:forEach>
												<tr>
													<td colspan="3" style="text-align: center;">
														<spring:message code="finishOrder.total" /></td>
													<td>
														${order.totalQuantity}
													</td>
													<td><fmt:formatNumber value="${order.totalAmount}" type="currency"
															currencySymbol="${currencySymbol}" pattern="#,###,##0.00 ¤"/>
													</td>
												</tr>
											</tbody>
										
									</table>
									
								</td>
								
							</tr>
							
						</c:forEach>

					<c:if test="${empty orders}">
						<sec:authorize access="hasRole('ROLE_USER')">
							<tr>
								<td colspan="7"><spring:message code="orders.user.no.orders" /></td>
							</tr>
						</sec:authorize>
						<sec:authorize access="hasRole('ROLE_ADMIN')">
							<tr>
								<td colspan="7"><spring:message code="orders.admin.no.orders" /></td>
							</tr>
						</sec:authorize>
					</c:if>

				</tbody>
			</table>
	</div>
</body>
</html>
