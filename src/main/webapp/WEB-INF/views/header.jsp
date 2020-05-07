<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>


<nav class="navbar navbar-expand-lg fixed-top navbar-transparent" color-on-scroll="100">
    <div class="container">
        <div class="navbar-translate">
            <a class="navbar-brand" href="index">HOME</a>

            <button class="navbar-toggler navbar-toggler" type="button" data-toggle="collapse" data-target="#navigation"
                aria-controls="navigation-index" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-bar bar1"></span>
                <span class="navbar-toggler-bar bar2"></span>
                <span class="navbar-toggler-bar bar3"></span>
            </button>
        </div>

        <div class="collapse navbar-collapse justify-content-end" id="navigation">
            <ul class="navbar-nav">

                <c:if test="${not empty loggedInID}">
                    <li class="nav-item">
                        <a class="nav-link" href="profile">Profile</a>
                    </li>
                </c:if>
                <c:if test="${empty loggedInID}">
                    <li class="nav-item">
                        <a class="nav-link" href="register">Register</a>
                    </li>
                </c:if>
                
                <li class="nav-item">
                    <a class="nav-link" href="tools">Tools</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="skills">Skills</a>
                </li>
               
                <c:if test="${loggedInRole eq 'ADMIN'}">
                    <li class="nav-item">
                        <a class="nav-link" href="allusers">Show All Users</a>
                    </li>
                </c:if>
                
                <c:choose>
                    <c:when test="${not empty loggedInID}">
                        <li class="nav-item">
                            <a class="btn btn-drk btn-round" href="logout">Logout</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item">

                            <div class="login-container">
                                <form action="login" method="post">
                                    <input type="email" name="email" placeholder="Email">
                                    <input type="password" name="password" placeholder="Password">
                                    <button class="btn btn-drk btn-round" id="submit" type="submit">Login</button>
                                </form>
                            </div>
                        </li>

                    </c:otherwise>
                </c:choose>
            </ul>            
        </div>
    </div>
</nav>
