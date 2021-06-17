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
		<div class="row">
			<div class="col-md-6">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h4>
							<span class="glyphicon glyphicon-shopping-cart"></span>
							<spring:message code="newOrder.selected.items" />
							<a href="/orders/users/orders/newOrder/clearItems"
								class="btn btn-default btn-sm"> <span
								class="glyphicon glyphicon-remove"></span> <spring:message
									code="newOrder.clear" />
							</a>
						</h4>
					</div>
					<div class="panel-body">
						<c:forEach items="${sessionScope.order.items}" var="item">
						<c:set var="itemKey" value="${item.key}"/>
						<c:set var="itemVal" value="${item.value}"/>
							<div class="media">
								<div class="media-left media-top">
									<img src="<spring:url value="/images/${itemKey.image}"/>"
										class="media-object" style="width: 60px">
								</div>
								<div class="media-body">
									<h4 class="media-heading">
										${itemKey.name} <small> x ${itemVal} = 
										<fmt:formatNumber value="${itemKey.price * itemVal}" type="currency"
														currencySymbol="${currencySymbol}" pattern="#,###,##0.00 ¤"/>
										</small>
									</h4>
									<p>${itemKey.description}</p>
								</div>
								<div class="media-right media-top">
									<spring:url var="increaseItemURL"
										value="/users/orders/newOrder/increaseItem">
										<spring:param name="reference" value="${itemKey.reference}" />
									</spring:url>
									<a href="${increaseItemURL}"> <span
										class="glyphicon glyphicon-plus-sign"></span>
									</a>
								</div>
								<div class="media-right media-top">
									<spring:url var="decreaseItemURL"
										value="/users/orders/newOrder/decreaseItem">
										<spring:param name="reference" value="${itemKey.reference}" />
									</spring:url>
									<a href="${decreaseItemURL}"> <span
										class="glyphicon glyphicon-minus-sign"></span>
									</a>
								</div>
							</div>
						</c:forEach>
					</div>
					<div class="panel-footer">
						<c:if test="${!empty sessionScope.order.items}">
							<spring:url var="finishOrderUrl"
								value='/users/orders/newOrder/finishOrder' />
								<a class="btn btn-primary center-block" href="${finishOrderUrl}"> <span
									class="glyphicon glyphicon-shopping-cart"></span> <spring:message
										code="header.navbar.finish.order" />
							</a>
						</c:if>
					</div>
				</div>
			</div>
			<div class="col-md-6">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h4>
							<span class="glyphicon glyphicon-list"></span>
							<spring:message code="newOrder.items" />
						</h4>
					</div>
					<div class="panel-body">
						<c:forEach items="${items}" var="item">
							<div class="media">
								<div class="media-left media-top">
									<img src="<spring:url value="/images/${item.image}"/>"
										class="media-object" style="width: 60px">
								</div>
								<div class="media-body">
									<h4 class="media-heading">
										${item.name} <small> <fmt:formatNumber value="${item.price}" type="currency"
														currencySymbol="${currencySymbol}" pattern="#,###,##0.00 ¤"/>
													</small>
									</h4>
									<p>${item.description}</p>
								</div>
								<div class="media-right media-top">

									<spring:url var="increaseItemURL"
										value="/users/orders/newOrder/increaseItem">
										<spring:param name="reference" value="${item.reference}" />
									</spring:url>
									<a href="${increaseItemURL}"> <span
										class="glyphicon glyphicon-plus-sign"></span>
									</a>
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