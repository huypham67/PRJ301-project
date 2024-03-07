<%-- 
    Document   : cart
    Created on : Mar 6, 2024, 4:46:33 PM
    Author     : huypd
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Course" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Your cart Page</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <jsp:include page="/includes/navbar.jsp"/>
        <div class="container my-3">
            <div class="d-flex py-3">
                <h3>Total Price: $
                    <fmt:formatNumber pattern="#.##" value="${total}"></fmt:formatNumber>
                </h3> 
                <a class="mx-3 btn btn-primary" href="cart-check-out">Check Out</a>
                <h5 style='color: crimson; text-align: center'>...</h5>
            </div>
            <table class="table table-light">
                <thead>
                    <tr>
                        <th scope="col">Name</th>
                        <th scope="col">Category</th>
                        <th scope="col">Price</th>
                        <th scope="col">Buy Now</th>
                        <th scope="col">Cancel</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${cart}" var="o">
                        <tr>
                            <td>${o.key.name}</td>
                            <jsp:useBean id="course" class="model.Course"/>
                            <jsp:setProperty name="course" property="cid" value="${o.key.cid}"/>
                            <td><jsp:getProperty name="course" property="cname"/></td>
                            <td><fmt:formatNumber pattern="#.##" value="${o.key.price*o.value}">
                                </fmt:formatNumber></td>
                            <td>
                                <form action="order-now" method="post" class="form-inline">
                                    <input type="hidden" name="id" value="1" class="form-input">
                                    <div class="form-group d-flex justify-content-between">
                                        <a class="btn bnt-sm btn-incre" href="quantity-inc-dec?action=inc&id=${o.key.id}"><i class="fas fa-plus-square"></i></a> 
                                        <input type="text" name="quantity" class="form-control"  value="${o.value}" readonly> 
                                        <a class="btn btn-sm btn-decre" href="quantity-inc-dec?action=dec&id=${o.key.id}"><i class="fas fa-minus-square"></i></a>
                                    </div>
                                    <button type="submit" class="btn btn-primary btn-sm">Buy</button>
                                </form>
                            </td>
                            <td><a href="remove-from-cart?id=${o.key.id}" class="btn btn-sm btn-danger">Remove</a></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </body>
</html>