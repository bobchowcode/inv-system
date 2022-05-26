<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="en">
<head>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>

<style>
#login-bg {
    min-height: 500px;
    background-color: #f5f5f5;
}

body {
    background-image: url("/images/background.jpg");
    /* background-size: cover; */
    background-repeat: repeat;
    /* background-position: 50% 50%;
    height: 130px; */
    display: block;
    text-align: center;
}

#login-bg-top h2 {
    color: #101010;
}

.logo-circle {
    background-image: url("/images/logo.jpg");
    background-repeat: no-repeat;
    background-size: cover;
    border-radius: 50px;
    width: 350px;
    height: 300px;
    margin-top: 50px;
    display: inline-block;
    border: 5px solid rgba(211,211,211,0.9);
}

.bg-content {
    text-align: center;
    padding-top: 50px;
    padding-left: 110px;
    padding-right: 110px;
    margin-top: 40px;
    margin-bottom: 90px;
    min-height: 300px;
}

.input-group {
    width: 100%;
}


</style>
<title>Login Page</title>
</head>
<body>

<section>
    <div id="login-bg-top">
        <div class="logo-circle"></div>
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <h2>No-Error Company Inventory and POS System</h2>
                </div><!-- /.col-md-12 -->
            </div><!-- /.row -->
        </div><!-- /.container -->
    </div>
    
    <form action="/login" method="POST">
    <div class="container">
        <div class="col-md-12">
            <div class="bg-content">
                <div class="input-group">
                  <input type="text" class="form-control" placeholder="Username" aria-describedby="basic-addon1" name="username">
                </div>
                
                <div class="input-group" style="margin-top: 10px">
                  <input type="password" class="form-control" placeholder="Password" aria-describedby="basic-addon1" name="password">
                </div>
                
                <div class="input-group" style="margin-top: 50px;">
                  <input type="submit" value="LOGIN" class="btn btn-success btn-lg">
                </div>
            </div>
        </div>
    </div>
    </form>
<h4>  Developed by Doraemon</h4>
</section>

<!-- 	<div class="container">

		
		<h2>Developed By: Doraemon Company</h2>

		<form action="/login" method="POST">
			username:<br> <input type="text" name="username"> <br>
			password:<br> <input type="password" name="password"> <br>
			<br> <input type="submit" value="Submit">
		</form>

	</div> -->
	
</body>

</html>
