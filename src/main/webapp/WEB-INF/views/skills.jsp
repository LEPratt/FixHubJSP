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

<body class="services-page sidebar-collapse font-weight-normal">
    <!-- Navbar -->
    <jsp:include page="header.jsp" />
    <!-- End Navbar -->


    <div class="page-header page-header-xs" data-parallax="true"
        style="background-image: url('assets/img/oil.jpg');">
        <h3 class="presentation-subtitle ">${msg}</h3>
        <div class="filter"></div>
      </div>
    
      <div class="section about-content paddingTB60 gray-bg">
        <div class="container">
          <div class="row">
            <div class="col-md-10 col-lg-12">
              <div class="about-title clearfix">
                <h1>Our <span>Skills</span></h1>
                <!-- Tab Links -->
                <div class="nav-tabs-navigation">
                  <div class="nav-tabs-wrapper">
                    <ul class="nav nav-tabs" role="tablist">
                      <li class="nav-item">
                        <a class="nav-link  ${active=='tab1'? 'active' : ''}" data-toggle="tab" href="#skillRequests"
                          role="tab">Requests for Help</a>
                      </li>
                      <li class="nav-item">
                        <a class="nav-link  ${active=='tab2'? 'active' : ''}" data-toggle="tab" href="#skillSearch"
                          role="tab">Search for Skills</a>
                      </li>
                      <c:if test="${not empty loggedInID}">
                        <li class="nav-item">
                          <a class="nav-link  ${active=='tab3'? 'active' : ''}" data-toggle="tab" href="#requestSkill"
                            role="tab">Request Help</a>
                        </li>
                      </c:if>
                    </ul>
                  </div>
                </div>
                <!-- End Tab Links-->
    
                <!-- Tab Panes -->
                <div class="tab-content info">
                  <!-- Skill Requests Tab -->
                  <div class="tab-pane ${active=='tab1'? 'active' : ''}" id="skillRequests" role="tabpanel">
                    <div class="section allusers-content font-weight-normal">
    
                      <div class="container">
                        <table class="table ">
                          <tr class="text-danger">
                            <th>#</th>
                            <th>Help Requested</th>
                            <th>Type of Help</th>
                            <th>City</th>
                            <th>Date Needed</th>                            
                            <th>Email</th>
                          </tr>
    
                          <tbody>
                            <c:set var="count" value="0" />
                            <c:forEach var="item" items="${requestList}">
                              <c:set var="count" value="${count+1}" />
                              <tr>
                                <td> ${count}.</td>
                                <td>${item.skillRequested}</td>
                                <td>${item.typeOfHelp}</td>
                                <td>${item.user.address.city}</td>
                                <fmt:parseDate value= "${item.dateRequested}" pattern="yyyy-MM-dd" var="parsedDateRequested" />
                                <fmt:formatDate value= "${parsedDateRequested}" pattern="MM/dd/yyy" var="formattedDateRequested" />
                                <td>${formattedDateRequested}</td>
                                
    
                                <td> <a class="text-danger" href="#" data-toggle="modal" data-target="#email${item.user.id}"
                                    title="Email person requesting ${item.skillRequested}">Email</a>
    
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
                  <!-- End Skill Requests Tab -->
    
                  <!-- Skill Search Tab -->
                  <div class="tab-pane text-center ${active=='tab2'? 'active' : ''}" id="skillSearch" role="tabpanel">
                    <div class="col-md-10 col-lg-12">
                      <div class="section font-weight-normal">
    
                        <form action="searchSkills" method="GET">
                          <input type="search" name="skill" class="input-lg" placeholder="Enter Skill Name...">
                          <button type="submit" class="btn btn-main btn-small btn-round">Search</button>
                        </form>
    
    
                        <table class="table">
                          <tr class="text-danger">
    
                            <th>Skill</th>
                            <th>Type</th>
                            <th>City</th>
                            <th>Email</th>
                          </tr>
    
                          <tbody>
                            <c:if test="${not empty results}">
                              <c:forEach var="item" items="${results}">
                                
                                  <tr>
                                    <td>${item.skill}</td>
                                    <td>${item.type}</td>
                                    <td>${item.user.address.city}</td>
    
                                    <td> <a class="text-danger" href="#" data-toggle="modal"
                                        data-target="#email${item.user.id}" title="Email ${item.skill}'s user">Email</a>
                                      <!-- Send Email User with Skill Model -->
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
                                      <!-- End Send Email User with Skill Model -->
                                    </td>
                                  </tr>
                                
                              </c:forEach>
                            </c:if>
                          </tbody>
                        </table>
                        <br>
                      </div>
                    </div>
                  </div>
                  <!-- End Skill Requests Tab -->
    
                  <!-- Request Help Tab -->
                  <div class="tab-pane text-center ${active=='tab3'? 'active' : ''}" id="requestSkill" role="tabpanel">
                    <div class="col-md-10 col-lg-12">
                      <p class="text-left">
                        <a href="#" data-toggle="modal" data-target="#addSkillRequest" class="btn btn-round">Request Help</a>
                      </p>
                      <c:if test="${not empty user_account.getSkillRequests()}">
                        <table class="table ">
                          <tr class="text-danger">
                            <th>#</th>
                            <th>Help Requested</th>
                            <th>Type of Help</th>
                            <th>City</th>
                            <th>Date Needed</th>
                            <th>Delete</th>
                          </tr>
                          <tbody>
                            <c:set var="count" value="0" />
                            <c:forEach var="req" items="${user_account.getSkillRequests()}">
                              <c:set var="count" value="${count+1}" />
    
                              <tr>
                                <td> ${count}.</td>
                                <td>${req.skillRequested}</td>
                                <td>${req.typeOfHelp}</td>
                                <td>${req.user.address.city}</td>
                                <fmt:parseDate value= "${req.dateRequested}" pattern="yyyy-MM-dd" var="parsedDateRequested" />
                                <fmt:formatDate value= "${parsedDateRequested}" pattern="MM/dd/yyy" var="formattedDateRequested" />
                                <td>${formattedDateRequested}</td>
                                
                                <td>
                                  <a href="deleteSkillRequest?id=${req.id}" onclick="confirmed(); return false;"
                                    title="Delete ${req.skillRequested}" class="btn btn-sm btn-round">x<i
                                      class="tf-ion-close"></i></a>
                                </td>
                              </tr>
                            </c:forEach>
                          </tbody>
                        </table>
                      </c:if>
                    </div>
                    <!-- Skill Request Form Model -->
                    <div class="modal fade" id="addSkillRequest">
                      <div class="modal-dialog modal-md">
                        <div class="modal-content"> -->
                          <!-- Modal body -->
                          <div class="modal-body">
                            <h4>Add New Request for Help</h4>
                            <form action="addSkillRequest" method="post" role="form" class="contactForm">
                              <div class="form-group">
                                <input type="hidden" name="id" value="${loggedInID}" />
                              </div>
                              <div class="form-group">
                                <input type="string" class="form-control" name="skillRequested" placeholder="Help Needed" />
                              </div>

                              <div class="form-group">
                                <select name="typeOfHelp" class="form-control">
                                  <option value="">What type of help do you need?</option>
                                  <option value="I need someone to help me fix it">I need someone to help me fix it</option>
                                  <option value="I need someone to fix it for me">I need someone to fix it for me</option>
                                  <option value="I need advice on how how to fix it">I need advice on how how to fix it</option>
                                </select>
                              </div>
    
                              <div class="form-group">
                                <label for="dateRequested">When do you need it?</label>
                                <input type="date" class="form-control" name="dateRequested" id="dateRequested" />
                              </div>
    
                              <button class="btn btn-main btn-small btn-round" type="submit">Add </button>
                              <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            </form>
    
                          </div>
                        </div>
                      </div>
                    </div>
                    <!--End Skill Request Form Model -->
                  </div>
                  <!-- End Request Skill Tab -->
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