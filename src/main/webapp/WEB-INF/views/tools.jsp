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
  <!-- Set incative interval based on Role -->
  <c:choose>
    <c:when test="${loggedInRole eq 'ADMIN'}">
      <meta http-equiv="refresh" CONTENT="<%= 180 %>; URL='${contextPath}/expired'" />
    </c:when>
    <c:when test="${loggedInRole eq 'USER'}">
      <meta http-equiv="refresh" CONTENT="<%= session.getMaxInactiveInterval() %>; URL='${contextPath}/expired'" />
    </c:when>
    <c:otherwise></c:otherwise>
  </c:choose>
  <!-- End set incative interval based on Role -->

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

<body class="tools-page sidebar-collapse font-weight-normal">
  <!-- Navbar -->
  <jsp:include page="header.jsp" />
  <!-- End Navbar -->


  <div class="page-header page-header-small" data-parallax="true"
    style="background-image: url('assets/img/sockets.jpg');">
    <h3 class="presentation-subtitle ">${msg}</h3>
    <div class="filter"></div>
  </div>

  <div class="section about-content paddingTB60 gray-bg">
    <div class="container">
      <div class="row">
        <div class="col-md-10 col-lg-12">
          <div class="about-title clearfix">
            <h1>Our <span>Tools</span></h1>
            <!-- Tab Links -->
            <div class="nav-tabs-navigation">
              <div class="nav-tabs-wrapper">
                <ul class="nav nav-tabs" role="tablist">
                  <li class="nav-item">
                    <a class="nav-link  ${active=='tab1'? 'active' : ''}" data-toggle="tab" href="#toolRequests"
                      role="tab">Tool Requests</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link  ${active=='tab2'? 'active' : ''}" data-toggle="tab" href="#toolSearch"
                      role="tab">Search for Tools</a>
                  </li>
                  <c:if test="${not empty loggedInID}">
                    <li class="nav-item">
                      <a class="nav-link  ${active=='tab3'? 'active' : ''}" data-toggle="tab" href="#requestTool"
                        role="tab">Request a Tool</a>
                    </li>
                  </c:if>
                </ul>
              </div>
            </div>
            <!-- End Tab Links-->

            <!-- Tab Panes -->
            <div class="tab-content info">
              <!-- Tool Requests Tab -->
              <div class="tab-pane ${active=='tab1'? 'active' : ''}" id="toolRequests" role="tabpanel">
                <div class="section allusers-content font-weight-normal">

                  <div class="container">
                    <table class="table ">
                      <tr class="text-danger">
                        <th>#</th>
                        <th>Tool Requested</th>
                        <th>City</th>
                        <th>Date Needed</th>
                        <th>Date Will Return</th>
                        <th>Email</th>
                      </tr>

                      <tbody>
                        <c:set var="count" value="0" />
                        <c:forEach var="item" items="${requestList}">
                          <c:set var="count" value="${count+1}" />
                          <tr>
                            <td> ${count}.</td>
                            <td>${item.toolRequested}</td>
                            <td>${item.user.address.city}</td>
                            <fmt:parseDate value= "${item.pickUp}" pattern="yyyy-MM-dd" var="parsedPickUp" />
                            <fmt:formatDate value= "${parsedPickUp}" pattern="MM/dd/yyy" var="formattedPickUp" />
                            <td>${formattedPickUp}</td>
                            <fmt:parseDate value= "${item.returnDate}" pattern="yyyy-MM-dd" var="parsedReturnDate" />
                            <fmt:formatDate value= "${parsedReturnDate}" pattern="MM/dd/yyy" var="formattedReturnDate" />
                            <td>${formattedReturnDate}</td>

                            <td> <a class="text-danger" href="#" data-toggle="modal" data-target="#email${item.user.id}"
                                title="Email person requesting ${item.toolRequested}">Email</a>

                              <div class="modal fade" id="email${item.user.id}">
                                <div class="modal-dialog modal-md">
                                  <div class="modal-content">
                                    <!-- Modal body -->
                                    <!-- Contact Form -->
                                    <div class="contact-form col-md-10 ">
                                      <form action="sendemail" method="post" id="contact-form" role="form">
                                        <div class="form-group">
                                          <input type="text" placeholder="Your Name" class="form-control" name="name"
                                            id="name" required>
                                        </div>
                                        <div class="form-group">
                                          <input type="hidden" name="to" id="to" value="${item.user.email}">
                                          <input type="hidden" name="page" id="page" value="${page}">
                                          <input type="email" placeholder="Your Email" class="form-control" name="from"
                                            id="from" required>
                                        </div>
                                        <div class="form-group">
                                          <input type="text" placeholder="Subject" class="form-control" name="subject"
                                            id="subject" required>
                                        </div>
                                        <div class="form-group">
                                          <textarea rows="6" placeholder="Message" class="form-control" name="message"
                                            id="message"></textarea>
                                        </div>
                                        <div id="cf-submit">
                                          <input type="submit" id="contact-submit" class="btn btn-transparent"
                                            value="Submit">
                                        </div>
                                      </form>
                                    </div>
                                    <!-- End Contact Form -->
                                  </div>
                                </div>
                              </div>
                            </td>
                          </tr>
                        </c:forEach>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
              <!-- End Tool Requests Tab -->

              <!-- Tool Search Tab -->
              <div class="tab-pane text-center ${active=='tab2'? 'active' : ''}" id="toolSearch" role="tabpanel">
                <div class="col-md-10 col-lg-12">
                  <div class="section font-weight-normal">

                    <form action="tools" method="GET">
                      <input type="search" name="tool" class="input-lg" placeholder="Enter Tool Name...">
                      <button type="submit" class="btn btn-main btn-small btn-round">Search</button>
                    </form>


                    <table class="table">
                      <tr class="text-danger">

                        <th>Tool</th>
                        <th>Type</th>
                        <th>City</th>
                        <th>Email</th>
                      </tr>

                      <tbody>
                        <c:if test="${not empty results}">
                          <c:forEach var="item" items="${results}">
                            <c:if test="${item.status eq 'Available'}">
                              <tr>
                                <td>${item.tool}</td>
                                <td>${item.type}</td>
                                <td>${item.user.address.city}</td>

                                <td> <a class="text-danger" href="#" data-toggle="modal"
                                    data-target="#email${item.user.id}" title="Email ${item.tool}'s owner">Email</a>
                                  <!-- Send Email to Tool Owner Model -->
                                  <div class="modal fade" id="email${item.user.id}">
                                    <div class="modal-dialog modal-md">
                                      <div class="modal-content">
                                        <!-- Contact Form -->
                                        <div class="contact-form col-md-10 ">
                                          <form action="sendemail" method="post" id="contact-form" role="form">
                                            <div class="form-group">
                                              <input type="text" placeholder="Your Name" class="form-control"
                                                name="name" id="name" required>
                                            </div>
                                            <div class="form-group">
                                              <input type="hidden" name="to" id="to" value="${item.user.email}">
                                              <input type="hidden" name="page" id="page" value="${page}">
                                              <input type="email" placeholder="Your Email" class="form-control"
                                                name="from" id="from" required>
                                            </div>
                                            <div class="form-group">
                                              <input type="text" placeholder="Subject" class="form-control"
                                                name="subject" id="subject" required>
                                            </div>
                                            <div class="form-group">
                                              <textarea rows="6" placeholder="Message" class="form-control"
                                                name="message" id="message"></textarea>
                                            </div>
                                            <div id="cf-submit">
                                              <input type="submit" id="contact-submit" class="btn btn-transparent"
                                                value="Submit">
                                            </div>
                                          </form>
                                        </div>
                                        <!-- End Contact Form -->
                                      </div>
                                    </div>
                                  </div>
                                  <!-- End Send Email to Tool Owner Model -->
                                </td>
                              </tr>
                            </c:if>
                          </c:forEach>
                        </c:if>
                      </tbody>
                    </table>
                    <br>
                  </div>
                </div>
              </div>
              <!-- End Tool Requests Tab -->

              <!-- Request Tool Tab -->
              <div class="tab-pane text-center ${active=='tab3'? 'active' : ''}" id="requestTool" role="tabpanel">
                <div class="col-md-10 col-lg-12">
                  <p class="text-left">
                    <a href="#" data-toggle="modal" data-target="#addToolRequest" class="btn btn-round">Request a
                      Tool</a>
                  </p>
                  <c:if test="${not empty user_account.getToolRequests()}">
                    <table class="table ">
                      <tr class="text-danger">
                        <th>#</th>
                        <th>Tool</th>
                        <th>Where</th>
                        <th>Pickup Date</th>
                        <th>Return Date</th>
                        <th>Delete</th>
                      </tr>
                      <tbody>
                        <c:set var="count" value="0" />
                        <c:forEach var="req" items="${user_account.getToolRequests()}">
                          <c:set var="count" value="${count+1}" />

                          <tr>
                            <td> ${count}.</td>
                            <td> ${req.toolRequested}</td>
                            <td> ${req.user.address.city}</td>
                            <fmt:parseDate value= "${req.pickUp}" pattern="yyyy-MM-dd" var="parsedPickUp" />
                            <fmt:formatDate value= "${parsedPickUp}" pattern="MM/dd/yyy" var="formattedPickUp" />
                            <td>${formattedPickUp}</td>
                            <fmt:parseDate value= "${req.returnDate}" pattern="yyyy-MM-dd" var="parsedReturnDate" />
                            <fmt:formatDate value= "${parsedReturnDate}" pattern="MM/dd/yyy" var="formattedReturnDate" />
                            <td>${formattedReturnDate}</td>
                            
                            <td>
                              <a href="deleteToolRequest?id=${req.id}" onclick="confirmed(); return false;"
                                title="Delete ${req.toolRequested}" class="btn btn-sm btn-round">x<i
                                  class="tf-ion-close"></i></a>
                            </td>
                          </tr>
                        </c:forEach>
                      </tbody>
                    </table>
                  </c:if>
                </div>
                <!-- Tool Request Form Model -->
                <div class="modal fade" id="addToolRequest">
                  <div class="modal-dialog modal-md">
                    <div class="modal-content"> -->
                      <!-- Modal body -->
                      <div class="modal-body">
                        <h4>Add New Tool Request</h4>
                        <form action="addToolRequest" method="post" role="form" class="contactForm">
                          <div class="form-group">
                            <input type="hidden" name="id" value="${loggedInID}" />
                          </div>
                          <div class="form-group">
                            <input type="string" class="form-control" name="toolRequested" placeholder="Tool Name" />
                          </div>

                          <div class="form-group">
                            <label for="pickUp">When do you need it?</label>
                            <input type="date" class="form-control" name="pickUp" id="pickUp" />
                          </div>

                          <div class="form-group">
                            <label for="returnDate">When will you return it?</label>
                            <input type="date" class="form-control" name="returnDate" id="returnDate" />
                          </div>

                          <button class="btn btn-main btn-small btn-round" type="submit">Add </button>
                          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </form>

                      </div>
                    </div>
                  </div>
                </div>
                <!--End Tool Request Form Model -->
              </div>
              <!-- End Request Tool Tab -->
            </div>
            <!-- End Tab Panes -->
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
  <!--   End Core JS Files   -->
</body>

</html>