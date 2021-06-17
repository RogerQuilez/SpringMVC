<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib
	prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
			<div class="row">
				<form:form modelAttribute="order" class="form-horizontal"
					action="/orders/users/orders/newOrder/finishOrder" method="post">
					<spring:hasBindErrors name="order">
						<div class="alert alert-danger alert-dismissible">
							<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
							<form:errors path="*" htmlEscape="false"/>
						</div>
					</spring:hasBindErrors>
					<div class="col-md-12">

						<div class="panel panel-default">
							<div class="panel-heading">
								<h4>
									<span class="glyphicon glyphicon-th-large"></span>
									<spring:message code="finishOrder.order" />
								</h4>
							</div>
							<div class="panel-body">
								<div class="row">
									<div class="col-md-5">
										<h5>
											<span class="glyphicon glyphicon-user"></span>
											<spring:message code="finishOrder.client.data" />
										</h5>
										<div class="form-group">
											<label class="col-sm-3 control-label" for="firstName">
												<spring:message code="finishOrder.first.name" />
											</label>
											<div class="col-sm-8">
												<p class="form-control-static">${order.client.firstName}</p>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 control-label" for="firstName">
												<spring:message code="finishOrder.last.name" />
											</label>
											<div class="col-sm-8">
												<p class="form-control-static">${order.client.lastName}</p>
											</div>
										</div>
										<h5>
											<span class="glyphicon glyphicon-envelope"></span>
											<spring:message code="finishOrder.shipment.data" />
										</h5>
										<div class="form-group">
											<div class="form-group">
												<label for="deliveryAddress.recipientName"
													class="col-sm-3 control-label"><spring:message
														code="finishOrder.recipient" /></label>
												<div class="col-sm-8">
													<spring:message code="finishOrder.recipient.placeholder" var="recipientPlaceholder"/>
													<form:input type="text" id="recipientName" path="deliveryAddress.recipientName" placeholder="${recipientPlaceholder}"
														class="form-control"/>
												</div>
											</div>
											<div class="form-group">
												<form:label path="deliveryAddress.address"
													cssClass="col-sm-3 control-label"
													cssErrorClass="col-sm-3 control-label control-label-error">
													<spring:message code="finishOrder.address" />
												</form:label>
												<div class="col-sm-8">
													<spring:message code="finishOrder.address.placeholder" var="addressPlaceholder"/>
													<form:input type="text" id="address" 
													path="deliveryAddress.address" 
													placeholder="${addressPlaceholder}"
													cssClass="form-control"
													cssErrorClass="form-control form-control-error"/>
												</div>
											</div>
											<div class="form-group">
												
												<form:label path="deliveryAddress.zipCode"
													cssClass="col-sm-3 control-label"
													cssErrorClass="col-sm-3 control-label control-label-error"> 
													<spring:message code="finishOrder.zip.code" />
												</form:label>
												<div class="col-sm-8">
													<spring:message code="finishOrder.zip.code.placeholder" var="codePlaceholder"/>
													<form:input type="text" id="zipCode" path="deliveryAddress.zipCode" placeholder="${codePlaceholder}" htmlEscape="false"
													cssClass="form-control"
													cssErrorClass="form-control form-control-error"/>
												</div>
											</div>
											<div class="form-group">
												<form:label path="deliveryAddress.city"
													cssClass="col-sm-3 control-label"
													cssErrorClass="col-sm-3 control-label control-label-error">
													<spring:message code="finishOrder.city" />
												</form:label>
												<div class="col-sm-8">
													<spring:message code="finishOrder.city.placeholder" var="cityPlaceholder"/>
													<form:input type="text" id="city" path="deliveryAddress.city" placeholder="${cityPlaceholder}"
													cssClass="form-control"
													cssErrorClass="form-control form-control-error"/>
												</div>
											</div>
											<div class="form-group">

												<form:label path="deliveryAddress.state"
													cssClass="col-sm-3 control-label"
													cssErrorClass="col-sm-3 control-label control-label-error">
													<spring:message code="finishOrder.state.province" /> 
												</form:label>
												<div class="col-sm-8">
													<spring:message code="finishOrder.state.province.placeholder" var="statePlaceholder"/>
													<form:input type="text" id="state" path="deliveryAddress.state" placeholder="${statePlaceholder}"
													cssClass="form-control"
													cssErrorClass="form-control form-control-error"/>
												</div>
											</div>
											<div class="form-group">
												<form:label path="deliveryAddress.country"
													cssClass="col-sm-3 control-label"
													cssErrorClass="col-sm-3 control-label control-label-error"> 
													<spring:message code="finishOrder.country" />
												</form:label>
												<div class="col-sm-8">
													<spring:message code="finishOrder.country.placeholder" var="countryPlaceholder"/>
													<form:input type="text" id="country" path="deliveryAddress.country" placeholder="${countryPlaceholder}" htmlEscape="false"
													cssClass="form-control"
													cssErrorClass="form-control form-control-error"/>
												</div>
											</div>
										</div>
									</div>
									<div class="col-md-7">
										<h5>
											<span class="glyphicon glyphicon-list"></span>
											<spring:message code="finishOrder.items" />
										</h5>
										<div class="table-responsive">
											<table
												class="table table-striped table-bordered table-condensed">
												<thead>
													<tr>
														<th><spring:message code="finishOrder.reference" /></th>
														<th><spring:message code="finishOrder.items" /></th>
														<th><spring:message code="finishOrder.price" /></th>
														<th><form:label path="totalQuantity" cssErrorClass="control-label control-label-error">
														<spring:message code="finishOrder.quantity" /></form:label></th>
														<th><spring:message code="finishOrder.amount" /></th>
													</tr>
												</thead>
												<tbody>

														<c:forEach items="${sessionScope.order.items}" var="item">
														<c:set var="itemKey" value="${item.key}"/>
														<c:set var="itemVal" value="${item.value}"/>
															<tr>
																<td>${itemKey.reference}</td>
																<td>${itemKey.name}</td>
																<td><fmt:formatNumber value="${itemKey.price}" type="currency"
																	currencySymbol="${currencySymbol}" pattern="#,###,##0.00 ¤"/></td>
																<td>${itemVal}</td>
																<td><fmt:formatNumber value="${itemKey.price * itemVal}" type="currency"
																	currencySymbol="${currencySymbol}" pattern="#,###,##0.00 ¤"/> </td>
															</tr>
														</c:forEach>
														<tr>
																<td colspan="3" style="text-align: center;"><spring:message code="finishOrder.total" /></td>
																<td>
																	<form:label path="totalQuantity" cssErrorClass="control-label control-label-error">
																		${order.totalQuantity}
																	</form:label>
																</td>
																<td>
																	<fmt:formatNumber value="${order.totalAmount}" type="currency"
																	currencySymbol="${currencySymbol}" pattern="#,###,##0.00 ¤"/>
																</td>
															</tr>
												</tbody>
											</table>
										</div>
									</div>
								</div>
							</div>
							<div class="panel-footer">
								<button type="submit" id="btnAdd"
									class="btn btn-default btn-block">
									<span class="glyphicon glyphicon-credit-card"></span>
									<spring:message code="finishOrder.purchase" />
								</button>
							</div>
						</div>
					</div>
				</form:form>
			</div>
	</div>
</body>
</html>
