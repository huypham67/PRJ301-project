<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="includes/language.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Check out page</title>
    <jsp:include page="includes/header.jsp"/>
    <jsp:include page="includes/navbar.jsp"/>
    <style>
        <!-- Your CSS styles here -->
    </style>
</head>
<body>
    <jsp:include page="includes/formInfo.jsp"/>
    <div style="display: flex;">
        <div style="padding: 20px 70px;" class="container">
            <table class="table table-light">
                <thead>
                    <tr>
                        <th scope="col">ID</th>
                        <th scope="col">Name</th>
                        <th scope="col">Category</th>
                        <th scope="col">Quantity</th>
                        <th scope="col">Discount</th>
                        <th scope="col">Price</th> 
                    </tr>
                </thead>
                <tbody>              
                    <c:forEach items="${coursesToCheckout}" var="course" varStatus="loop">
                        <tr>
                            <td>${loop.index + 1}</td>
                            <td>${course.name}</td>
                            <td>
                                <c:forEach items="${listC}" var="category">
                                    <c:if test="${category.cid eq course.cid}">
                                        ${category.cname}
                                    </c:if>
                                </c:forEach>
                            </td>
                            <td>
                                <select name="quantity" id="quantity${loop.index}">
                                    <c:forEach begin="1" end="10" var="i">
                                        <option value="${i}">${i}</option>
                                    </c:forEach>
                                </select>
                            </td>
                            <td>${course.discount}</td>
                            <td>${course.price}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <div style="padding: 20px 50px" class="col-xl-4">
            <div class="mt-5 mt-lg-0">
                <div class="card border shadow-none">
                    <div class="card-header bg-transparent border-bottom py-3 px-4">
                        <h5 class="font-size-16 mb-0">Order Summary <span class="float-end">#MN0124</span></h5>
                    </div>
                    <div class="card-body p-4 pt-2">
                        <div class="table-responsive">
                            <table class="table mb-0">
                                <tbody>
                                    <tr>
                                        <td>Sub Total :</td>
                                        <td class="text-end"></td>
                                    </tr>
                                    <!-- Add more rows for other details such as discount, shipping charge, estimated tax, and total -->
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>                    
            </div>
        </div>   
    </div>
    
    <script>
        // JavaScript code here
    </script>
</body>
</html>
