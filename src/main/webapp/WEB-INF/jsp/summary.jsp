<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<title>Transaction Summary</title>
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
</head>

<script src="/js/jquery-3.3.1.min.js"></script>
<script src="/js/warehouse.js"></script>

<body>

	<h1 style="padding:20px">Transaction Successful</h1>

	<input type="button" class="btn btn-primary" onclick="location.href='/outgoing';" value="Return To Outgoing Page" style="padding:20px"/>
	
	<input type="button" class="btn btn-primary" onclick="javascript:window.print();" value="Print">
	<br>
	<br>
	<div class="container" style="width: 1200px">
		<table>
		<tr>
			<th>Product Name</th>
			<th>Price</th>
			<th>Quantity</th>
			<th>Subtotal</th>
		</tr>
		<c:forEach items="${orderList}" var="order">
		<%-- <div class="row"> --%>
		<tr>
			<td>${order.product.name} </td>
			<td>${order.product.price}</td>
			<td>${order.quantity}</td>
			<td>${order.quantity*order.product.price}</td>
		</tr>
		<%-- </div> --%>
		</c:forEach>
	</table>
	</div>


</body>
</html>
