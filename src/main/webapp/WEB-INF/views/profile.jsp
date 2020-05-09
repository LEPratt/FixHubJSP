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
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no'
    name='viewport' />

  <!--     Fonts and icons     -->
  <link href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">

  <!-- CSS Files -->
  <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.css">
  <link href="assets/css/bootstrap.min.css" rel="stylesheet" />
  <link href="assets/css/paper-kit.css" rel="stylesheet" />
  
  <script>
    $(document).ready(function(){
        $('a[data-toggle="tab"]').on('show.bs.tab', function(e) {
            localStorage.setItem('activeTab', $(e.target).attr('href'));
        });
        var activeTab = localStorage.getItem('activeTab');
        if(activeTab){
            $('#myTab a[href="' + activeTab + '"]').tab('show');
        }
    });
    </script>

</head>

<body class="profile-page sidebar-collapse font-weight-normal">

  <!-- Navbar -->
  <jsp:include page="header.jsp" />
  <!-- End Navbar -->

  <div class="page-header page-header-xs " data-parallax="true" style="background-image: url('assets/img/wrench.jpg');">
    <h3 class="presentation-subtitle ">${msg}</h3>
    <div class="filter"></div>
  </div>
  <div class="section profile-content">
    <div class="container">
      <div class="owner">
        <div class="avatar">
          <c:if test="${not empty user_account.image}">
            <img src="assets/img/users/${user_account.id}/profile/${user_account.image}" alt="Circle Image"
              class="img-circle img-no-padding img-responsive">
          </c:if>
          <a href="#" data-toggle="modal" data-target="#add-images" class="btn btn-neutral mt-20">
            <c:choose>
              <c:when test="${not empty user_account.image}">
                Change Image
              </c:when>
              <c:otherwise>
                Add Photo
              </c:otherwise>
            </c:choose>
          </a>
        </div>
        <div class="name about-title clearfix">
          <h1>${user_account.fName} <span>${user_account.lName}</span></h1>           
            <br />Member Since: ${createdOn}
          </h4>
        </div>
      </div>

      <div class="nav-tabs-navigation">
        <div class="nav-tabs-wrapper">
          <ul class="nav nav-tabs" role="tablist">
            <li class="nav-item">
              <a class="nav-link ${active=='tab1'? 'active' : ''}" data-toggle="tab" href="#info" role="tab">Profile Info</a>
            </li>
            <li class="nav-item">
              <a class="nav-link ${active=='tab2'? 'active' : ''}" data-toggle="tab" href="#edit" role="tab">Edit Address</a>
            </li>
            <li class="nav-item">
              <a class="nav-link ${active=='tab3'? 'active' : ''}" data-toggle="tab" href="#tools" role="tab">My Tools</a>
            </li>
            <li class="nav-item">
              <a class="nav-link ${active=='tab4'? 'active' : ''}" data-toggle="tab" href="#skills" role="tab">My Skills</a>
            </li>
          </ul>
        </div>
      </div>

      <!-- Tab panes -->
      <div class="tab-content info">
        <div class="tab-pane text-center ${active=='tab1'? 'active' : ''}" id="info" role="tabpanel">
          <div class="col-md-8 ml-auto mr-auto font-weight-normal">
            <div class="row">
              <div class="col-md-6">
                <label>Status</label>
              </div>
              <div class="col-md-6">
                <p>${user_account.role}</p>
              </div>
            </div>
            <div class="row">
              <div class="col-md-6">
                <label>Email</label>
              </div>
              <div class="col-md-6">
                <p>${user_account.email}</p>
              </div>
            </div>
            <div class="row">
              <div class="col-md-6">
                <label>Address</label>
              </div>
              <div class="col-md-6">
                <p>${user_account.address.street}</p>
              </div>
            </div>
            <div class="row">
              <div class="col-md-6">
                <label>City</label>
              </div>
              <div class="col-md-6">
                <p>${user_account.address.city} ${user_account.address.state} ${user_account.address.zip}</p>
              </div>
            </div>
            <div class="row">
              <div class="col-md-6">
                <label>Phone Numbers<a href="#" data-toggle="modal" data-target="#addtel" class="btn btn-link"
                    title="Add new phone numbers"><i class="nc-icon nc-simple-add"></i></a></label>
              </div>
              <div class="col-md-6">
                <p>
                  <c:forEach var="fone" items="${user_account.getPhoneBook()}">
                    <b>${fone.type}:</b> ${fone.tel}
                    <a href="deletephone?id=${fone.id}" onclick="confirmed(); return false;"
                      title="Delete ${fone.tel}"><i class="nc-icon nc-simple-remove"></i></a><br>
                  </c:forEach>
                </p>
              </div>
            </div>
          </div>
        </div>

        <div class="tab-pane text-center ${active=='tab2'? 'active' : ''}" id="edit" role="tabpanel">
          <div class="col-xs-6 col-sm-8 col-md-10 col-lg-12">
            <div class="form-group centered-form">
              <form:form action="updateContact" modelAttribute="address" method="post" class="text-left clearfix">
                <h2>Edit your Address</h2>
                <form:input class="form-control" type="hidden" path="id" value="${user_account.id}" />
                <div class="row">
                  <div class="col-xs-6 col-sm-6 col-md-6">
                    <div class="form-group">
                      <form:label path="street">Street</form:label>
                      <form:input class="form-control" path="street" value="${user_account.address.street}"
                        placeholder="Enter Address" />
                    </div>
                  </div>
                  <div class="col-xs-6 col-sm-6 col-md-6">
                    <div class="form-group">
                      <form:label path="city">City</form:label>
                      <form:input class="form-control" path="city" value="${user_account.address.city}"
                        placeholder="Enter City" />
                    </div>
                  </div>
                </div>
                <div class="row">
                  <div class="col-xs-6 col-sm-6 col-md-6">
                    <div class="form-group">
                      <form:label path="zip">Zip Code</form:label>
                      <form:input class="form-control" path="zip" value="${user_account.address.zip}"
                        placeholder="Enter ZIP" />
                    </div>
                  </div>
                  <div class="col-xs-6 col-sm-6 col-md-6">
                    <div class="form-group">
                      <form:label path="state">State</form:label>
                      <form:select class="form-control" path="state" id="state" required="true">
                        <c:choose>
                          <c:when test="${empty user_account.getAddress().state}">
                            <option value="">Select State</option>
                          </c:when>
                          <c:otherwise>
                            <option value="${user_account.getAddress().state}">
                              ${user_account.getAddress().state}
                            </option>
                          </c:otherwise>
                        </c:choose>
                        <c:forEach items="${states}" var="state">
                          <option value="${state}">${state.id}</option>
                        </c:forEach>
                      </form:select>
                    </div>
                  </div>
                </div>
                <div class="text-left">
                  <button type="submit" class="btn btn-main btn-small btn-round">Submit</button>
                </div>
              </form:form>
            </div>
          </div>
        </div>

        <div class="tab-pane text-center ${active=='tab3'? 'active' : ''}" id="tools" role="tabpanel">
          <div class="col-md-10 col-lg-12">
            <p class="text-left">
              <a href="#" data-toggle="modal" data-target="#addTool" class="btn btn-round">Add New Tool</a>
            </p>
            <c:if test="${not empty user_account.getTools()}">
              <table class="table ">
                <tr class="text-danger">
                  <th>#</th>
                  <th>Tool</th>
                  <th>Type</th>
                  <th>Status</th>
                  <th>Delete</th>
                </tr>
                <tbody>
                  <c:set var="count" value="0" />
                  <c:forEach var="tools" items="${user_account.getTools()}">
                    <c:set var="count" value="${count+1}" />
                    <tr>
                      <td> ${count}.</td>
                      <td> ${tools.tool}</td>
                      <td>
                        <form method="POST" action="editToolType">
                          <input type="hidden" name="id" value="${tools.id}" />
                          <select onchange="this.form.submit()" name="type" class="form-control">
                            <option value="${tools.type}">${tools.type}</option>
                            <option value="Borrow">Borrow</option>
                            <option value="Rent">Rent</option>
                          </select>
                        </form>
                      </td>
                      <td>
                        <form method="POST" action="editToolStatus">
                          <input type="hidden" name="id" value="${tools.id}" />
                          <select onchange="this.form.submit()" name="status" class="form-control">
                            <option value="${tools.status}">${tools.status}</option>
                            <option value="Available">Available</option>
                            <option value="Unavailable">Unavailable</option>
                          </select>
                      </td>
                      <td>
                        <a href="deleteTool?id=${tools.id}" onclick="confirmed(); return true;"
                          title="Delete ${tools.tool}" class="btn btn-sm btn-round">x<i class="tf-ion-close"></i></a>
                      </td>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
            </c:if>
          </div>
        </div>

        <div class="tab-pane text-center ${active=='tab4'? 'active' : ''}" id="skills" role="tabpanel">
          <div class="col-md-10 col-lg-12">
            <p class="text-left">
              <a href="#" data-toggle="modal" data-target="#addSkill" class="btn btn-round">Add New Skill</a>
            </p>
            <c:if test="${not empty user_account.getSkills()}">
              <table class="table ">
                <tr class="text-danger">
                  <th>#</th>
                  <th>Skill</th>
                  <th>Type</th>
                  <th>Delete</th>
                </tr>
                <tbody>
                  <c:set var="count" value="0" />
                  <c:forEach var="skills" items="${user_account.getSkills()}">
                    <c:set var="count" value="${count+1}" />
                    <tr>
                      <td> ${count}.</td>
                      <td> ${skills.skill}</td>
                      <td> ${skills.type}</td>
                      <td>
                        <a href="deleteSkill?id=${skills.id}" onclick="confirmed(); return false;"
                          title="Delete ${skills.skill}" class="btn btn-sm btn-round">x<i class="tf-ion-close"></i></a>
                      </td>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
            </c:if>
          </div>
        </div>
      </div>


      <div class="modal fade" id="add-images">
        <div class="modal-dialog modal-sm">
          <div class="modal-content">
            <!-- Modal body -->
            <div class="modal-body">
              <form method="POST" action="addimages" enctype="multipart/form-data">
                <h4>Add Image</h4>
                <img id="output_image" class="col-sm-12" />
                <div class="control-group">
                  <div class="controls">
                    <input type="file" name="file" class="form-control" onchange="preview_image(event)">
                    <input type="hidden" name="id" value="${user_account.id}">
                  </div>
                </div>
                <div class="control-group"><br>
                  <div class="controls">
                    <button type="submit" class="btn btn-default">Upload</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                  </div>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>

      <div class="modal fade" id="addtel">
        <div class="modal-dialog modal-sm">
          <div class="modal-content"> -->
            <!-- Modal body -->
            <div class="modal-body">

              <form action="addphone" method="post" role="form" class="contactForm">
                <h4>Add Telephone Number</h4>
                <input type="hidden" name="id" value="${user_account.id}">
                <div class="form-group">
                  <input type="text" name="tel" class="form-control" placeholder="Phone Number">
                </div>
                <div class="form-group">
                  <select name="type" class="form-control">
                    <option value="">Select Type</option>
                    <option value="Mobile">Mobile</option>
                    <option value="Home">Home</option>
                    <option value="Work">Work</option>
                  </select>
                </div>
                <div class="text-left">
                  <button class="btn btn-main btn-small btn-round" type="submit">Add </button>
                  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <div class="modal fade" id="addTool">
    <div class="modal-dialog modal-sm">
      <div class="modal-content"> -->
        <!-- Modal body -->
        <div class="modal-body">
          <h4>Add New Tool</h4>
          <form action="addTool" method="post" role="form" class="contactForm">
            <div class="form-group">
              <input type="hidden" name="id" value="${user_account.id}" />
            </div>
            <div class="form-group">
              <input type="string" class="form-control" name="tool" placeholder="Tool Name" />
            </div>
            <div class="form-group">
              <select name="type" class="form-control">
                <option value="">Select Rent or Borrow</option>
                <option value="Borrow">Borrow</option>
                <option value="Rent">Rent</option>
              </select>
            </div>
            <div class="form-group">
              <select name="status" class="form-control">
                <option value="">Current Status</option>
                <option value="Available">Available</option>
                <option value="Unavailable">Unavailable</option>
              </select>
            </div>
            <button class="btn btn-main btn-small btn-round" type="submit">Add </button>
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          </form>
        </div>
      </div>
    </div>
  </div>

  <div class="modal fade" id="addSkill">
    <div class="modal-dialog modal-sm">
      <div class="modal-content"> -->
        <!-- Modal body -->
        <div class="modal-body">
          <h4>Add New Skill</h4>
          <form action="addSkill" method="post" role="form" class="contactForm">
            <div class="form-group">
              <input type="hidden" name="id" value="${user_account.id}" />
            </div>
            <div class="form-group">
              <input type="string" class="form-control" name="skill" placeholder="How Can You Help Others?" />
            </div>
            <div class="form-group">
              <select name="type" class="form-control">
                <option value="">How Can You Help?</option>
                <option value="I can help you fix it">I can help you fix it</option>
                <option value="I can fix it for you">I can fix it for you</option>
                <option value="I can give you advice on how to fix it">I can give you advice on how to fix it</option>
              </select>
            </div>
            <button class="btn btn-main btn-small btn-round" type="submit">Add </button>
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          </form>
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
  <!--  Preview Image Plugin    -->
  
    
</body>

</html>