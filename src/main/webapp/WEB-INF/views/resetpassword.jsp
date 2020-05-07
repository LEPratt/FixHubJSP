<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
    
<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> 
<html class="no-js"> <!--<![endif]-->
<head>

	<title>${page}</title>

	<meta charset="ISO-8859-1">
	<meta charset="utf-8">
	<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport" />

	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

	<!--     Fonts and icons     -->

	<link href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">


	<!-- CSS Files -->
	<link rel="stylesheet" type="text/css" href="static/css/bootstrap.css">
	<link href="assets/css/bootstrap.min.css" rel="stylesheet" />
	<link href="assets/css/paper-kit.css" rel="stylesheet" />


</head>

<body id="body">

<section class="passwordReset account">
  <div class="container">
    <div class="row">
      <div class="col-md-6 col-md-offset-3">
        <div class="block text-center">          
          <h2 class="text-center"> ${msg} ${success} <br>
			 Please enter your token
		   </h2>
          <form class="text-left clearfix" action="passwordReset" method="post" >
            <div class="form-group">
              <input type="hidden" name="email" class="form-control" value="${email}" placeholder="Email">
            </div>
            <div class="form-group">
              <input type="password" name="token" class="form-control" placeholder="Enter Token" required>
            </div>
            <div class="form-group">
              <input type="password" name="password" class="form-control" placeholder="Create New Password" required>
              <small class="text-danger">${error} ${expired}</small>
            </div>
            
            <div class="text-center">
              <button type="submit" class="btn btn-main text-center" >Reset</button>
            </div>
          </form>
          <p>
          <a  href="#" data-toggle="modal" data-target="#forgot" 
            class="btn btn-link">Request New Token?</a> |
            <a  href="login"  
            class="btn btn-link">Login</a>
          </p>
          
        </div>
      </div>
    </div>
  </div>
</section>
<!--   Footer   -->

<jsp:include page="footer.jsp" />

<!--   End Footer   -->

 
    <!--    Essential Scripts    =====================================-->
    
    <!--   Core JS Files   -->
	<script src="assets/js/core/jquery.min.js" type="text/javascript"></script>
	<script src="assets/js/core/popper.min.js" type="text/javascript"></script>
	<script src="assets/js/core/bootstrap.min.js" type="text/javascript"></script>
	<!--  Plugin for Switches, full documentation here: http://www.jque.re/plugins/version3/bootstrap.switch/ -->
	<script src="assets/js/plugins/bootstrap-switch.js"></script>
	<!--  Plugin for the Sliders, full documentation here: http://refreshless.com/nouislider/ -->
	<script src="assets/js/plugins/nouislider.min.js" type="text/javascript"></script>
	<!--  Plugin for the DatePicker, full documentation here: https://github.com/uxsolutions/bootstrap-datepicker -->
	<script src="assets/js/plugins/moment.min.js"></script>
	<script src="assets/js/plugins/bootstrap-datepicker.js" type="text/javascript"></script>
	<!-- Control Center for Paper Kit: parallax effects, scripts for the example pages etc -->
	<script src="assets/js/paper-kit.js?v=2.2.0" type="text/javascript"></script>
	<!--  Google Maps Plugin    -->
	<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=YOUR_KEY_HERE"></script>

  </body>
  </html>