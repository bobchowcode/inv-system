<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<title>SQL Page</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<style>
	body {
			background-image:url("/images/baby3.jpeg");
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

<script>
$(document).ready(function(){
$.makeTable = function (mydata) {
    var table = $('<table border=1>');
    var tblHeader = "<tr>";
    for (var k in mydata[0]) tblHeader += "<th>" + k + "</th>";
    tblHeader += "</tr>";
    $(tblHeader).appendTo(table);
    $.each(mydata, function (index, value) {
        var TableRow = "<tr>";
        $.each(value, function (key, val) {
            TableRow += "<td>" + val + "</td>";
        });
        TableRow += "</tr>";
        $(table).append(TableRow);
    });
    return ($(table));
};

    $('#query-button').click(function(){
    	$('#result-table').html("");
    	$.ajax({
    	    url: '/sql',
    	    contentType: 'application/json; charset=utf-8',
    	    type: 'POST',
    	    data: JSON.stringify({
        	    sqlStr:$('#query-str').val().trim()
       	    }),
    	    dataType: 'json',
    	    error: function(xhr) {
    	      	alert('Ajax request error');
    	    },
    	    success: function(res) {
    	    	//$('#result-table').html(JSON.stringify(res.detail));
				var mydata = eval(JSON.stringify(res.detail));
				var table = $.makeTable(mydata);
				$(table).appendTo("#result-table");
    	    }
   	    });

    });
});
</script>

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

<h1 style="padding:20px">SQL Page</h1>

<textarea id="query-str" rows="4" cols="150" style="padding:20px">
select * from user_tbl
</textarea>

<input type="button" value="Query" id="query-button" class="btn btn-success" style="padding:20px">

<div id="result-table" class="container"></div>
<!--<table id="result-table"></table>-->

</body>
</html>
