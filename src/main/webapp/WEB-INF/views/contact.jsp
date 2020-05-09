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

<body class="contact-page sidebar-collapse font-weight-normal">
    <!-- Navbar -->
    <jsp:include page="header.jsp" />
    <!-- End Navbar -->

    <div class="page-header page-header-xs" data-parallax="true"
        style="background-image: url('assets/img/wrench.jpg');">
        <h3 class="text-center text-success">${msg}</h3>
    </div>
    <div class="section about-content paddingTB60 gray-bg">
        <div class="container">
            <div class="row">
                <div class="col-md-10 col-lg-12">
                    <div class="about-title clearfix">
                        <h1>Contact <span>Us</span></h1>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="contact-section">
        <div class="container">
            <div class="row">

                <!-- Contact Form -->
                <div class="contact-form col-md-6 ">
                    <form action="sendemail" method="post" id="contact-form" role="form">
                        <div class="form-group">
                            <input type="text" placeholder="Your Name" class="form-control" name="name" id="name"
                                required>
                        </div>
                        <div class="form-group">
                            <input type="hidden" name="to" id="to" value="fixhub1313@gmail.com">
                            <input type="hidden" name="page" id="page" value="${page}">
                            <input type="email" placeholder="Your Email" class="form-control" name="from" id="from"
                                required>
                        </div>
                        <div class="form-group">
                            <input type="text" placeholder="Subject" class="form-control" name="subject" id="subject"
                                required>
                        </div>
                        <div class="form-group">
                            <textarea rows="6" placeholder="Message" class="form-control" name="message"
                                id="message"></textarea>
                        </div>
                        <div id="cf-submit">
                            <input type="submit" id="contact-submit" class="btn btn-transparent" value="Submit">
                        </div>

                    </form>
                </div>
                <!-- End Contact Form -->

                <!-- Contact Details -->
                <div class="contact-details col-md-6 ">
                    <div class="google-map">
                        <!-- <div id="map"></div> -->
                        <iframe
                            src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d20966.874070057867!2d-90.20704616946311!3d38.63175897805127!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x87d8b31ef3cb49df%3A0x7fa2c9991ac6421e!2sClaim%20Academy!5e0!3m2!1sen!2sus!4v1587146771051!5m2!1sen!2sus"
                            width="600" height="450" frameborder="0" style="border:0;" allowfullscreen=""
                            aria-hidden="false" tabindex="0"></iframe>
                    </div>
                    <ul class="contact-short-info">
                        <li>
                            <i class="tf-ion-ios-home"></i>
                            <span>Claim Academy 1520 Washington Ave, St. Louis, MO 63103</span>
                        </li>
                        <li>
                            <i class="tf-ion-android-phone-portrait"></i>
                            <span>Phone: (314) 499-5888</span>
                        </li>
                        <li>
                            <i class="tf-ion-android-mail"></i>
                            <span>Email: info@claimacademystl.com</span>
                        </li>
                    </ul>
                </div>
                <!-- / End Contact Details -->

            </div> <!-- end row -->
        </div> <!-- end container -->
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
    </div>
</body>

</html>