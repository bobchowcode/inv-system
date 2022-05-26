<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"
	integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4"
	crossorigin="anonymous">
<title>Report</title>
<style>
	table {
	    font-family: arial, sans-serif;
	    border-collapse: collapse;
	    width: 100%;
	}

	td, th {
	    border: 1px solid #dddddd;
	    text-align: left;
	    padding: 8px;
	}

	</style>
	
<style type="text/css" media="print">
input { 
	display: none !important;
}
</style>
<script src="/js/jquery-3.3.1.min.js"></script>
</head>

<body>

	<nav class="navbar navbar-light navbar-expand-lg sticky-top"
		style="background-color: #e3f2fd;">
		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav">
				<c:if test="${user.role eq 'outgoing' || user.role eq 'admin'}">
					<li class="nav-item"><a class="nav-link" href="/outgoing">Outgoing</a>
					</li>
				</c:if>
				<c:if test="${user.role eq 'warehouse' || user.role eq 'admin'}">
					<li class="nav-item"><a class="nav-link" href="/warehouse">Warehouse</a>
					</li>
				</c:if>
				<c:if test="${user.role eq 'admin'}">
					<li class="nav-item"><a class="nav-link" href="/sqlPage">SQL-Page</a>
					</li>
				</c:if>
				<c:if test="${user.role eq 'admin'}">
					<li class="nav-item"><a class="nav-link" href="/report">Report</a>
					</li>
				</c:if>
			</ul>
			<ul class="navbar-nav ml-auto">
				<li class="nav-right"><a class="nav-link" href="/logout">Logout</a>
				</li>
			</ul>
		</div>
	</nav>

	<h1>Print</h1>

	<input type="button" onclick="location.href='/report?q=stock';"
		value="Stock History" />
	<input type="button" onclick="location.href='/report?q=trans';"
		value="Transaction History" />

	<c:if test="${not empty stockHistory}">

		<div class="container" style="width: 1200px">
			<table>
				<tr>
					<th>Stock ID</th>
					<th>Product ID</th>
					<th>ADD / DEL</th>
					<th>Quantity</th>
					<th>Staff</th>
					<th>Date</th>
				</tr>
				<c:forEach items="${stockHistory}" var="stock">
					<tr>
						<td>${stock.stockId}</td>
						<td>${stock.productId}</td>
						<td><c:if test="${stock.inOut eq 1}">ADD</c:if> <c:if
								test="${stock.inOut eq 0}">DELETE</c:if></td>
						<td>${stock.quantity}</td>
						<td>${stock.staff}</td>
						<td>${stock.stockDate}</td>
					</tr>
				</c:forEach>
			</table>
		</div>

		<%--<c:forEach items="${stockHistory}" var="stock">
			<div class="row">
				<span>${stock.stockId}</span><br> <span>${stock.productId}</span><br>
				<span> <c:if test="${stock.inOut eq 1}">ADD</c:if> <c:if
						test="${stock.inOut eq 0}">DELETE</c:if>
				</span><br> <span>${stock.quantity}</span><br> <span>${stock.staff}</span><br>
				<span>${stock.stockDate}</span><br>
			</div>
		</c:forEach> --%>
	</c:if>

	<c:if test="${not empty transHistory}">
	
		<div class="container">
			<table>
				<tr>
					<th>Transaction ID</th>
					<th>Total</th>
					<th>Staff</th>
					<th>Date</th>
					<th>Detail</th>
				</tr>
				<c:forEach items="${transHistory}" var="trans">
					<tr>
						<td>${trans.transactionId}</td>
						<td>${trans.total}</td>
						<td>${trans.staff}</td>
						<td>${trans.transactionDate}</td>
						<td>
							<table>
								<tr>
									<th>Product ID</th>
									<th>Price</th>
									<th>Quantity</th>
								</tr>
								<c:forEach items="${trans.detailList}" var="detail">
									<tr>
										<td>${detail.productId}</td>
										<td>${detail.productPrice}</td>
										<td>${detail.quantity}</td>
									</tr>
								</c:forEach>
							</table>						
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		
		<%--<c:forEach items="${transHistory}" var="trans">
			<div class="row">
				<span>${trans.transactionId}</span><br> <span>${trans.total}</span><br>
				<span>${trans.staff}</span><br> <span>${trans.transactionDate}</span><br>
				<c:forEach items="${trans.detailList}" var="detail">
					<span>${detail.productId}</span>
					<br>
					<span>${detail.productPrice}</span>
					<br>
					<span>${detail.quantity}</span>
					<br>
				</c:forEach>
			</div>
		</c:forEach>--%>
	</c:if>

	<input type="button" onclick="javascript:window.print();" value="Print">


</body>
</html>
