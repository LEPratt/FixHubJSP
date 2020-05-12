<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />


<!DOCTYPE html>
<html>

<head>

	<title>${page}</title>
	<c:choose>
		<c:when test="${loggedInRole eq 'ADMIN'}">
			<meta http-equiv="refresh" CONTENT="<%= 180 %>; URL='${contextPath}/expired'" />
		</c:when>
		<c:when test="${loggedInRole eq 'USER'}">
			<meta http-equiv="refresh"
				CONTENT="<%= session.getMaxInactiveInterval() %>; URL='${contextPath}/expired'" />
		</c:when>
		<c:otherwise></c:otherwise>
	</c:choose>
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

<body class="register-page sidebar-collapse font-weight-normal">
	<!-- Navbar -->
	<jsp:include page="header.jsp" />
	<!-- End Navbar -->


	<div class="page-header page-header-xs" data-parallax="true"
		style="background-image: url('assets/img/darkdiamondplate.jpg');">
		<div class="filter"></div>



		<div class="motto text-center">
			<h2 class="text-centered">${msg} ${error} ${expired}</h2>
		</div>

	</div>
	<div class="section about-content paddingTB60 gray-bg">
		<div class="container">
			<div class="row">
				<div class="col-md-10 col-lg-12">
					<div class="about-title clearfix">
						<h1>Fix<span>Hub</span> Registration</h1>
						<h3>Sign up and create your own requests for tools or help!</h3>
					</div>

					<div class="col-md-8">
						<div class="row">
							<div class="col-lg-12">
								<div class="card">
									<div class="card-body">
										<h3 class="card-title text-center">Please sign up for FixHub <br><small>It's
												free!</small>
										</h3>
										<div class="row centered-form"></div>
										<form:form class="text-left" action="register" method="post"
											modelAttribute="user">
											<div class="row">
												<div class="col-md-4 col-lg-6">
													<div class="form-group">
														<form:input type="text" path="fName"
															placeholder="Enter First Name" />
														<br>
														<form:errors path="fName" class="text-danger text-center" />
													</div>
												</div>
												<div class="col-md-4 col-lg-6">
													<div class="form-group ">
														<form:input type="text" path="tel"
															placeholder="Enter Phone Number" />
														<br>
														<form:errors path="tel" class="text-danger text-center" />
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-md-4 col-lg-6">
													<div class="form-group">
														<form:input type="text" path="lName"
															placeholder="Enter Last Name" />
														<br>
														<form:errors path="lName" class="text-danger text-center" />
													</div>

												</div>
												<div class="col-md-4 col-lg-6">
													<div class="form-group">
														<select name="type">
															<option value="Select">Select Type</option>
															<option value="Mobile">Mobile </option>
															<option value="Home">Home</option>
															<option value="Work">Work</option>
														</select>
													</div>
												</div>

											</div>
											<div class="row">
												<div class="col-md-4 col-lg-6">
													<div class="form-group ">
														<form:input type="email" path="email"
															placeholder="Enter Email" />
														<br>
														<form:errors path="email" class="text-danger text-center" />
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-md-4 col-lg-6">
													<div class="form-group">
														<form:input type="password" path="password"
															placeholder="Enter Password" />
														<br>
														<form:errors path="password" class="text-danger text-center" />
													</div>
												</div>
												<div class="col-md-4 col-lg-6">
													<div class="form-group">
														<form:input type="password" path="password2"
															placeholder="Confirm Password" />
														<br>
														<form:errors path="password2" class="text-danger text-center" />
													</div>
												</div>
											</div>

											<input type="submit" value="Register" class="btn btn-drk btn-default">
										</form:form>
									</div>
								</div>
							</div>
						</div>
					</div>
					<p class="about-padding">Don't forget to add an address on your profile page! <br /></p>
				</div>
			</div>
		</div>
	</div>
	


	<!--   Footer   -->

	<jsp:include page="footer.jsp" />

	<!--   End Footer   -->

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