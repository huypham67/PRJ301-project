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
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/checkout.css">
</head>
<body>
    <jsp:include page="includes/formInfo.jsp"/>
    <div class="container mt-4">
        <div class="row">
            <div class="col-lg-8">
                <div class="table-responsive">
                    <table class="table table-light">
                        <thead>
                            <tr>
                                <th scope="col"></th>
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
                                    <td><img src="${course.image}" alt="Course Image" width="100" height="50"></td>
                                    <td>${course.id}</td>
                                    <td>${course.name}</td>
                                    <td>
                                        <c:forEach items="${listC}" var="category">
                                            <c:if test="${category.cid eq course.cid}">
                                                ${category.cname}
                                            </c:if>
                                        </c:forEach>
                                    </td>
                                    <td>
                                        <select name="quantity" id="quantity${loop.index}" onchange="clearAndUpdateOrderSummary()">
                                            <c:forEach begin="0" end="1" var="i">
                                                <option value="${i}">${i}</option>
                                            </c:forEach>
                                        </select>
                                    </td>
                                    <td><fmt:formatNumber value="${course.discount*100}" pattern="#" />%</td>
                                    <td>${course.price*(1-course.discount)}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title">Order Summary</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Quantity</th>
                                        <th>Discount</th>
                                        <th>Subtotal</th>
                                    </tr>
                                </thead>
                                <tbody id="orderSummaryBody">
                                    <!-- Order summary content will be inserted here -->
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td colspan="3"><strong>Total:</strong></td>
                                        <td id="totalPriceCell">0.00</td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                        <button class="btn btn-primary" onclick="purchase()">Purchase</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="script/checkout.js"></script>
</body>
</html>
