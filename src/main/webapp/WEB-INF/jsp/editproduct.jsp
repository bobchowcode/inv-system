<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<title> Edit Product</title>
</head>

<script src="/js/jquery-3.3.1.min.js"></script>
<style>
#css_table {
      display:table;
      border: 1px solid black;
  }
.css_tr {
      display: table-row;
      border: 1px solid black;
  }
.css_td {
      display: table-cell;
      border: 0px solid black;
      min-width: 100px;
}
.big{
	font-size:20px;
}
.submit_button{
	float:right;
}

.submit_button{
	float:right;
	border: none;
    color: white;
    padding: 15px 32px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    margin: 4px 2px;
    cursor: pointer;
}
.button1 {
    background-color: red;
}
.button2 {
    background-color: blue;
}
.button3 {
    background-color: green;
}
</style>
<script>
function submit(elem) {
	$(elem).parents('form:first').submit();
}
</script>

<body>

	<h1>Edit Product</h1>
	<form action="/submitEdit" method="GET" id="css_table">
		<input type="hidden" name="productId" value="${product.id}">
		<div class="css_tr">
			<div class="css_td big">Name:</div>
			<div class="css_td"><input type="text" name="name" value="${product.name}"> </div>
		</div>
		<div class="css_tr">
			<div class="css_td big">Quantity: </div>
			<div class="css_td">${product.quantity} </div>
		</div>
		<div class="css_tr">
			<div class="css_td big">Price: </div>
			<div class="css_td"><input type="text" name="price" value="${product.price}"> </div>
		</div>
		<div class="css_tr">
			<div class="css_td big">Descrption: </div>
			<div class="css_td"><input type="text" name="desc" value="${product.desc}"> </div>
		</div>
		<c:if test="${product['class'].simpleName eq 'Toy'}">
			<div class="css_tr">
				<div class="css_td big">Weight: </div>
				<div class="css_td"><input type="text" name="weight" value="${product.weight}"></div>
			</div>
			<div class="css_tr">
				<div class="css_td big">Standard: </div>
				<div class="css_td"><input type="text" name="standard" value="${product.standard}"></div>
			</div>
		</c:if>
		<c:if test="${product['class'].simpleName eq 'Clothes'}">
			<div class="css_tr">
				<div class="css_td big">Color: </div>
				<div class="css_td"><input type="text" name="color" value="${product.color}"></div>
			</div>
			<div class="css_tr">
				<div class="css_td big">Size: </div>
				<div class="css_td"><input type="text" name="size" value="${product.size}"></div>
			</div>
		</c:if>
		<c:if test="${product['class'].simpleName eq 'Food'}">
			<div class="css_tr">
				<div class="css_td big">Brand: </div>
				<div class="css_td"><input type="text" name="brand" value="${product.brand}"></div>
			</div>
			<div class="css_tr">
				<div class="css_td big">Origin: </div>
				<div class="css_td"><input type="text" name="origin" value="${product.origin}"></div>
			</div>
		</c:if>
			<div class="css_tr">
            	<div class="css_td"></div>
				<div class="css_td"><input class="submit_button button2 btn btn-success" type="button" value="Submit" onClick="submit(this);"></div>
			</div>
	</form>

</body>
</html>
