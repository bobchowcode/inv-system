<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<title>Outgoing</title>
<style>
	body {
			background-image:url("/images/baby.jpg");
			background-repeat:no-repeat;
			background-size: cover;
	}
	table {
	    font-family: arial, sans-serif;
	    border-collapse: collapse;
	    width: 100%;
			background-color: white;
	}

	td, th {
	    border: 1px solid #dddddd;
	    text-align: left;
	    padding: 8px;
			background-color: white;
	}

	tr:nth-child(even) {
	    background-color: #dddddd;
	}
	</style>


</head>

<script src="/js/jquery-3.3.1.min.js"></script>
<script src="/js/outgoing.js"></script>


<body>
	<nav class="navbar navbar-light navbar-expand-lg sticky-top" style="background-color: #e3f2fd;">
	    <div class="collapse navbar-collapse" id="navbarNav">
	        <ul class="navbar-nav">
	        <c:if test="${user.role eq 'outgoing' || user.role eq 'admin'}">
	        	<li class="nav-item">
	                <a class="nav-link" href="/outgoing">Outgoing</a>
	            </li>
	        </c:if>
	        <c:if test="${user.role eq 'warehouse' || user.role eq 'admin'}">
	        	<li class="nav-item">
	                <a class="nav-link" href="/warehouse">Warehouse</a>
	            </li>
	        </c:if>
	        <c:if test="${user.role eq 'admin'}">
	        	<li class="nav-item">
	                <a class="nav-link" href="/sqlPage">SQL-Page</a>
	            </li>
	        </c:if>
	        <c:if test="${user.role eq 'admin'}">
	        	<li class="nav-item">
	                <a class="nav-link" href="/report">Report</a>
	            </li>
	        </c:if>
	        </ul>
	        <ul class="navbar-nav ml-auto">
	            <li class="nav-right">
	                <a class="nav-link" href="/logout">Logout</a>
	            </li>
	        </ul>
	    </div>
	</nav>
	<div style="padding:20px">
	<h1 style="font-family:arial;">Sell item</h1>
	<input type="button" class="btn btn-primary" onclick="location.href='/outgoing';" value="All" />
	<input type="button" class="btn btn-primary" onclick="location.href='/outgoing?q=toy';" value="Toy" />
	<input type="button" class="btn btn-primary" onclick="location.href='/outgoing?q=clothes';"value="Clothes" />
	<input type="button" class="btn btn-primary" onclick="location.href='/outgoing?q=food';" value="Food" />
</div>
	<div style="width: 1200px;padding:20px;">

		<c:forEach items="${productList}" var="item">
			<c:if test="${item['class'].simpleName eq 'Toy'}">
				<form action="/addItemById" method="GET" style="display: inline;">
					<button style="width: 100px; background-color: #ffe6ff"
						onClick="submit(this);">
						<input type="hidden" name="productId" value="${item.id}">
							<%-- ${item.id}<br>  --%>
							${item.name}<br>
							(${item.quantity})<br>
							$${item.price}
						<%-- <span>${item.desc}</span><br> <span>${item.weight}</span><br>
						<span>${item.standard}</span><br> --%>
					</button>
				</form>
			</c:if>



			<c:if test="${item['class'].simpleName eq 'Clothes'}">
				<form action="/addItemById" method="GET" style="display: inline;">
					<button style="width: 100px; background-color: #cceeff"
						onClick="submit(this);">
						<input type="hidden" name="productId" value="${item.id}">
						<%-- <span>${item.id}</span><br>  --%>
						<span>${item.name}</span><br>
						<span>(${item.quantity})</span><br>
						 <span>$${item.price}</span><br>
						<%-- <span>${item.desc}</span><br> <span>${item.color}</span><br>
						<span>${item.size}</span><br> --%>
					</button>
				</form>
			</c:if>
			<c:if test="${item['class'].simpleName eq 'Food'}">
				<form action="/addItemById" method="GET" style="display: inline;">
					<button style="width: 100px; background-color: #ffeecc"
						onClick="submit(this);">
						<input type="hidden" name="productId" value="${item.id}">
						<%-- <span>${item.id}</span><br>  --%>
						<span>${item.name}</span><br>
						<span>(${item.quantity})</span><br>
						<span>$${item.price}</span><br>
						<%-- <span>${item.desc}</span><br> <span>${item.brand}</span><br>
						<span>${item.origin}</span><br> --%>
					</button>
				</form>
			</c:if>
		</c:forEach>
	</div>

	<br><br>
	<div class="container">
	<h3 style="font-family:arial">Transaction Details:</h3>
	<br>
		<table>
			<tr>

				<th>Product Name</th>
				<th>Quantity</th>
				<th>Price</th>
				<th>Subtotal</th>
			</tr>
		<c:forEach items="${orderList}" var="order">
			<form action="/deleteItemById" method="GET">
				<%-- <div class="row"> --%>
				<tr>
					<td>${order.product.name}</td>
					<td>${order.quantity}</td>
					<td>${order.product.price}</td>
					<td>${order.quantity*order.product.price}</td>
					<input type="hidden" name="productId" value="${order.product.id}">
					<td><input type="button" value="-"	style="width:10px" onClick="submit(this);"></td>
				</tr>
				<%-- </div> --%>

			</form>
		</c:forEach>
		</table>
	</div>
<br>
<br>
	<form action="/submitOrder" method="GET" class="container">
		<input type="button" class="btn btn-success" value="Check Out" onClick="submit(this);">
	</form>





</body>
</html>
