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
    <meta http-equiv="refresh" CONTENT="<%= 180 %>;URL='${contextPath}/expired'" />
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

<body class="allusers-page sidebar-collapse font-weight-normal">

    <!-- Navbar -->
    <jsp:include page="header.jsp" />
    <!-- End Navbar -->

    <div class="page-header page-header-xs" data-parallax="true"
        style="background-image: url('assets/img/redcar.jpg');">
        <h3 class="presentation-subtitle ">${msg} ${success}</h3>
    </div>

    <div class="section about-content paddingTB60 gray-bg">
        <div class="container">
            <div class="row">
                <div class="col-md-10 col-lg-12">
                    <div class="about-title clearfix">
                        <h1>Our <span>Users</span></h1>
                        <div class="container">
                            <form action="searchUser" method="POST">
                                <input type="search" name="keyword" class="input-lg"
                                    placeholder="Enter First or Last Name...">
                                <button type="submit" class="btn btn-main btn-small btn-round">Search</button>
                            </form>
                        </div>

                        <div class="container">
                            <table class="table ">
                                <tr class="text-danger">
                                    <th>#</th>
                                    <th>Name</th>
                                    <th>Email</th>
                                    <th>Password</th>
                                    <th>Role</th>
                                    <th>Delete</th>
                                    <th>Update</th>
                                </tr>

                                <tbody>
                                    <c:forEach var="item" items="${list}">
                                        <tr>
                                            <td>${item.id}</td>
                                            <td>${item.fName} ${item.lName}</td>
                                            <td>${item.email}</td>
                                            <td>${item.password}</td>
                                            <td>
                                                <form method="POST" action="editrole">
                                                    <input type="hidden" name="id" value="${item.id}" />
                                                    <select onchange="this.form.submit()" name="role"
                                                        class="form-control">
                                                        <option value="${item.role}">${item.role}</option>
                                                        <option value="USER">USER</option>
                                                        <option value="ADMIN">ADMIN</option>
                                                    </select>
                                                </form>
                                            </td>
                                            <td><a class="text-danger" href="delete?id=${item.id}" onclick="confirmed(); return false;"
                                                title="Delete ${item.fName} ${item.lName}" >Delete</a>

                                            <td> <a class="text-danger" href="#" data-toggle="modal"
                                                    data-target="#update${item.id}"
                                                    title="Update ${item.fName}'s Details">Update</a>

                                                <div class="modal fade" id="update${item.id}">
                                                    <div class="modal-dialog modal-md">
                                                        <div class="modal-content">
                                                            <!-- Modal body -->
                                                            <div class="modal-body">

                                                                <form:form action="updateuser" modelAttribute="user"
                                                                    method="post" class="text-left clearfix">
                                                                    <h2>Edit User Details</h2>
                                                                    <form:input class="form-control" type="hidden"
                                                                        path="id" value="${item.id}" />
                                                                    <div class="form-group">
                                                                        <form:input class="form-control"
                                                                            title="Edit First Name" path="fName"
                                                                            value="${item.fName}"
                                                                            placeholder="Enter First Name" />
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <form:input class="form-control"
                                                                            title="Edit Last Name" path="lName"
                                                                            value="${item.lName}"
                                                                            placeholder="Enter Last Name" />
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <form:input class="form-control"
                                                                            title="Edit Email" path="email"
                                                                            value="${item.email}"
                                                                            placeholder="Enter email" />
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <form:input class="form-control"
                                                                            title="Edit Password" path="password"
                                                                            value="${item.password}"
                                                                            placeholder="Enter Password" />
                                                                    </div>

                                                                    <div class="text-left">
                                                                        <button type="submit"
                                                                            class="btn btn-main btn-small btn-round">Submit</button>
                                                                    </div>
                                                                </form:form>

                                                            </div>
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