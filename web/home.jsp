<%-- 
    Document   : home
    Created on : Mar 6, 2024, 3:00:40 PM
    Author     : huypd
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.Course" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Home page</title>
        <jsp:include page="/includes/header.jsp" />   
    </head>
    <body>
        <jsp:include page="/includes/navbar.jsp" />
        <jsp:include page="/includes/banner.jsp"/>
        <div class="container">
            <div class="row">
                <div class="col">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="home">Home</a></li>
                            <li class="breadcrumb-item"><a href="#">Category</a></li>
                            <li class="breadcrumb-item active" aria-current="#">${cname}</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="row">
                <jsp:include page="/includes/left.jsp"/>

                <div class="col-sm-9">
                    <div id="content" class="row">
                        <c:forEach items="${listP}" var="o">
                            <div class="col-12 col-md-6 col-lg-4">
                                <div class="card">
                                    <img class="card-img-top" src="${o.image}" alt="Card image cap">
                                    <div class="card-body">
                                        <h4 class="card-title show_txt"><a href="detail?id=${o.id}" title="View Product">${o.name}</a></h4>
                                        <h5 class="price">Price: $${o.price}</h5>
                                        <jsp:useBean id="course" class="model.Course"/>
                                        <jsp:setProperty name="course" property="cid" value="${o.cid}"/>
                                        <h5 class="category">Category: <jsp:getProperty name="course" property="cname"/></h5>
                                        <c:if test="${tagCourseId == o.id}">
                                            <h6 style='color: crimson; text-align: center'>${mes}</h6>
                                        </c:if>
                                        <div class="mt-3 d-flex justify-content-between">
                                            <a class="btn btn-dark" href="add-to-cart?id=${o.id}&quantity=1">Add to Cart</a> 
                                            <a class="btn btn-danger" href="#">Buy Now</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>

            </div>
        </div>
        <jsp:include page="/includes/footer.jsp"/>
    </body>
</html>
