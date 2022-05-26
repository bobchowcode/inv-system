<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<title> Add Product</title>
</head>

<script src="/js/jquery-3.3.1.min.js"></script>
<script>
function submit(elem) {
	$(elem).parents('form:first').submit();
}
</script>
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
	border: none;
    color: white;
    padding: 15px 32px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    margin: 2px 2px;
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
<body>

	<h1>Add Product</h1>
		<c:if test="${type eq 'Toy'}">
			<form action="/addNewToy" method="GET" id="css_table" >
				<div class="css_tr">
					<div class="css_td big">Name: </div>
                    <div class="css_td"><input type="text" name="name"></div>
				</div>
				<div class="css_tr">
					<div class="css_td big">Quantity: </div>
                    <div class="css_td"><input type="text" name="quantity"></div>
				</div>
				<div class="css_tr">
					<div class="css_td big">Price: </div>
                    <div class="css_td"><input type="text" name="price"> </div>
				</div>
				<div class="css_tr">
					<div class="css_td big">Descrption: </div>
                    <div class="css_td"><input type="text" name="desc"></div>
				</div>
				<div class="css_tr">
					<div class="css_td big">Weight: </div>
                    <div class="css_td"><input type="text" name="weight"></div>
				</div>
				<div class="css_tr">
					<div class="css_td big">Standard: </div>
                    <div class="css_td"><input type="text" name="standard"></div>
				</div>
				<div class="css_tr">
                	<div class="css_td big"></div>
					<div class="css_td"><input class="submit_button button1" type="button" value="Submit" onClick="submit(this);"></div>
				</div>
			</form>
		</c:if>
		<c:if test="${type eq 'Clothes'}">
			<form action="/addNewClothes" method="GET" id="css_table">
				<div class="css_tr">
					<div class="css_td big">Name: </div>
                    <div class="css_td"><input type="text" name="name"></div>
				</div>
				<div class="css_tr">
					<div class="css_td big">Quantity: </div>
                    <div class="css_td"><input type="text" name="quantity"></div>
				</div>
				<div class="css_tr">
					<div class="css_td big">Price: </div>
                    <div class="css_td"><input type="text" name="price"> </div>
				</div>
				<div class="css_tr">
					<div class="css_td big">Descrption: </div>
                    <div class="css_td"><input type="text" name="desc"></div>
				</div>
				<div class="css_tr">
					<div class="css_td big">Color: </div>
                    <div class="css_td"><input type="text" name="color"></div>
				</div>
				<div class="css_tr">
					<div class="css_td big">Size: </div>
                    <div class="css_td"><input type="text" name="size"></div>
				</div>
				<div class="css_tr">
					<div class="css_td big"></div>
                    <div class="css_td"><input class="submit_button button2" type="button" value="submit" onClick="submit(this);"></div>
				</div>
			</form>
		</c:if>
		<c:if test="${type eq 'Food'}">
			<form action="/addNewFood" method="GET" id="css_table">
				<div class="css_tr">
					<div class="css_td big">Name: </div>
                    <div class="css_td"><input type="text" name="name"></div>
				</div>
				<div class="css_tr">
					<div class="css_td big">Quantity: </div>
                    <div class="css_td"><input type="text" name="quantity"></div>
				</div>
				<div class="css_tr">
					<div class="css_td big">Price: </div>
                    <div class="css_td"><input type="text" name="price"> </div>
				</div>
				<div class="css_tr">
					<div class="css_td big">Descrption: </div>
                    <div class="css_td"><input type="text" name="desc"></div>
				</div>
				<div class="css_tr">
					<div class="css_td big">Brand: </div>
                    <input type="text" name="brand"></div>
				</div>
				<div class="css_tr">
					<div class="css_td big">Origin: </div>
                    <input type="text" name="origin"></div>
				</div>
				<div class="css_tr">
                	<div class="css_td big"></div>
					<div class="css_td"><input class="submit_button button3 btn btn-success" type="button" value="submit" onClick="submit(this);"></div>
				</div>
			</form>
		</c:if>

</body>
</html>
