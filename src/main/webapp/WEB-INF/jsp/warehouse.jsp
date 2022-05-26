<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<title>Warehouse</title>
</head>

<script src="/js/jquery-3.3.1.min.js"></script>
<script src="/js/warehouse.js"></script>
<style>
#css_table {
    display:table;
    border: 1px solid black;
    font-family: arial, sans-serif;
	  border-collapse: collapse;
	  width: 100%;
    background-color: white;
  }
.css_tr {
      display: table-row;
      border: 1px solid #dddddd;
	   text-align: left;
	   padding: 8px;
     background-color: white;

  }
.css_td {
    display: table-cell;
    border: 1px solid #dddddd;
	  text-align: left;
	  padding: 8px;
    background-color: white;
/*       min-width: 250px;
 */}
.big{
	font-size:20px;
}

.submit_button{
	border: none;
    color: black;
	/* padding: 15px 20px;  */
 	text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    margin: 2px 2px;
    cursor: pointer;
}
.button1 {
	border: 1px solid black;
    background-color: #ffe6ff;
}
.button2 {
	border: 1px solid black;
    background-color: #cceeff;
}
.button3 {
	border: 1px solid black;
    background-color: #ffeecc;
}
body {
    background-image:url("/images/baby2.jpg");
    background-repeat:no-repeat;
    background-size: cover;
}

</style>
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

	<h1 style="padding:20px">Warehouse Management</h1>

	<%--<input type="button" onclick="location.href='/outgoing';" value="All" />
	<input type="button" onclick="location.href='/outgoing?q=toy';"
		value="Toy" />
	<input type="button" onclick="location.href='/outgoing?q=clothes';"
		value="Clothes" />
	<input type="button" onclick="location.href='/outgoing?q=food';"
		value="Food" /> --%>
<div style="padding:20px">
	<input type="button"  class="btn btn-primary" onclick="location.href='/addProduct?q=toy';" value="Add Toy" />
	<input type="button"  class="btn btn-primary" onclick="location.href='/addProduct?q=clothes';" value="Add Clothes" />
	<input type="button"  class="btn btn-primary" onclick="location.href='/addProduct?q=food';" value="Add Food" />
</div>
<br>
	<div class="container">
		<div id="css_table">
	      	<div class="css_tr">
	         	<div class="css_td big">Product ID</div>
	         	<div class="css_td big">Product Name</div>
	          	<div class="css_td big">Quantity</div>
	          	<div class="css_td big">Price</div>
	         	<div class="css_td big">Description</div>
	          	<div class="css_td big">Weight / Color / Brand</div>
	          	<div class="css_td big">Standard / Size / Origin</div>
	          	<div class="css_td big">Operations</div>
	      	</div>
		<c:forEach items="${productList}" var="item">
			<c:if test="${item['class'].simpleName eq 'Toy'}">
					<form class="css_tr">
						<div class="css_td"><span>${item.id}</span></div>
						<div class="css_td"><span>${item.name}</span></div>
						<div class="css_td"><span>${item.quantity}</span></div>
						<div class="css_td"><span>${item.price}</span></div>
						<div class="css_td"><span>${item.desc}</span></div>
						<div class="css_td"><span>Weight: ${item.weight}</span></div>
						<div class="css_td"><span>Standard: ${item.standard}</span></div>
						<div class="css_td">
						<input type="hidden" name="productId" value="${item.id}">
						<input class="submit_button button1" type="button" value="Edit" onClick="editItem(this);">
						<input class="submit_button button1" type="button" value="+" onClick="addQuantity(this);">
						<input type="text" name="quantity" style="width:23px;" >
						<input class="submit_button button1" type="button" value="-" onClick="deleteQuantity(this);">
						</div>
					</form>
			</c:if>

			<c:if test="${item['class'].simpleName eq 'Clothes'}">
					<form class="css_tr">
						 <div class="css_td"><span>${item.id}</span></div>
						 <div class="css_td"><span>${item.name}</span></div>
						 <div class="css_td"><span>${item.quantity}</span></div>
						 <div class="css_td"><span>${item.price}</span></div>
						 <div class="css_td"><span>${item.desc}</span></div>
						 <div class="css_td"><span>Color: ${item.color}</span></div>
						 <div class="css_td"><span>Size: ${item.size}</span></div>
                         <div class="css_td">
							<input type="hidden" name="productId" value="${item.id}">
							<input class="submit_button button2" type="button" value="Edit" onClick="editItem(this);">
							<input class="submit_button button2" type="button" value="+" onClick="addQuantity(this);">
							<input type="text" name="quantity" style="width:23px;" >
							<input class="submit_button button2" type="button" value="-" onClick="deleteQuantity(this);">
						</div>
					</form>
			</c:if>

			<c:if test="${item['class'].simpleName eq 'Food'}">
					<form class="css_tr">
							<div class="css_td"><span>${item.id}</span></div>
							<div class="css_td"><span>${item.name}</span></div>
							<div class="css_td"><span>${item.quantity}</span></div>
							<div class="css_td"><span>${item.price}</span></div>
							<div class="css_td"><span>${item.desc}</span></div>
							<div class="css_td"><span>Brand: ${item.brand}</span></div>
							<div class="css_td"><span>Origin: ${item.origin}</span></div>
							<div class="css_td">
							<input type="hidden" name="productId" value="${item.id}">
							<input class="submit_button button3" type="button" value="Edit" onClick="editItem(this);">
							<input class="submit_button button3" type="button" value="+" onClick="addQuantity(this);">
							<input type="text" name="quantity" style="width:23px;" >
							<input class="submit_button button3" type="button" value="-" onClick="deleteQuantity(this);">
							</div>
					</form>
			</c:if>
		</c:forEach>
	</div>
	</div>

	<div class="container">
		<c:forEach items="${orderList}" var="order">
			<form action="/deleteItemById" method="GET">
				<div class="row">
					<span>productId: ${order.productId}</span><span>quantity:
						${order.quantity}</span> <input type="hidden" name="productId"
						value="${order.productId}"> <input type="button" value="-"
						onClick="deleteItemFromOrderList(this);">
				</div>
			</form>
		</c:forEach>
	</div>





</body>
</html>
