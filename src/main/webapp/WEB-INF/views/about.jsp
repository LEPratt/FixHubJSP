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

<body class="about-page sidebar-collapse font-weight-normal">
    <!-- Navbar -->
    <jsp:include page="header.jsp" />
    <!-- End Navbar -->


    <div class="page-header page-header-small" data-parallax="true"
        style="background-image: url('assets/img/lifts.jpg');">

        
        <div class="filter"></div>
    </div>

    <div class="section about-content paddingTB60 gray-bg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 col-md-10 col-sm-8">
                    <div class="about-title clearfix">
                        <h1>About <span>FixHub</span></h1>
                        <h3>Fixing Cars and Connecting People</h3>
                        <p class="about-padding">FixHub is a web application to help people keep their cars on the road
                            a little longer. FixHub allows users to create a community where they can find nearby users
                            to help them with auto repairs.</p>
                        <p>Users can post requests for assistance with things like oil changes or brake pad replacement.
                        </p>
                        <p> A tool section allows users to post requests to borrow or rent specialty tools like bearing
                            pullers or torque wrenches. </p>

                        <div class="about-icons">
                            <ul>

                                <li><a href="https://github.com/LEPratt"><i id="social-tw"
                                            class="fa fa-github-square fa-3x social"></i></a> </li>
                                <li> <a href="https://www.linkedin.com/in/lepratt"><i id="social-gp"
                                            class="fa fa-linkedin-square fa-3x social"></i></a> </li>
                                <li> <a href="mailto:lsmlpratt@gmail.com"><i id="social-em"
                                            class="fa fa-envelope-square fa-3x social"></i></a> </li>
                            </ul>





                        </div>
                    </div>
                </div>
                <div class="col-md-5 col-sm-6">
                    <div class="about-img">
                        <img src="https://devitems.com/preview/appmom/img/mobile/2.png" alt="">
                    </div>
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