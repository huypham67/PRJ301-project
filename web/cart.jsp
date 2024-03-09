<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Your cart Page</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="css/cart.css" type="text/css"/>
    </head>
    <body>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <%@page contentType="text/html" pageEncoding="UTF-8"%>
        <%@ page import="model.Course" %>

        <jsp:include page="/includes/navbar.jsp"/>

        <!-- Checkout Popup -->
        <div id="popup" class="popup">
            <div>
                <div class="popup-content">
                    <!-- Form for input fields -->
                    <form id="checkoutForm" action="cart-check-out" method="post"> 
                        <div>						
                            <h4>Checkout</h4>
                            <button type="button" onclick="closePopup()" class="close-btn" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div>
                            <div class="form-group">
                                <label for="name">Full Name:</label><br>
                                <input type="text" id="name" name="name">
                            </div>
                            <div class="form-group">
                                <label for="phone">Phone Number:</label><br>
                                <input type="text" id="phone" name="phone">
                            </div>
                            <div class="form-group">
                                <label for="address">Address:</label><br>
                                <input type="text" id="address" name="address">
                            </div>
                            <div class="form-group">
                                <label for="email">Email:</label><br>
                                <input type="email" id="email" name="email">
                            </div>
                            <div>
                                <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                                <input type="submit" class="btn btn-success" value="SEND/CHECKOUT">
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Main Content -->
        <div class="container my-3">
            <div class="d-flex py-3">
                <h3>Total Price: $
                    <fmt:formatNumber pattern="#.##" value="${total}"></fmt:formatNumber>
                    </h3> 
                    <button onclick="displayPopup()" class="mx-3 btn btn-primary">Checkout</button>
                    <h5 style='color: crimson; text-align: center'>${mes}</h5>
            </div>
            <table class="table table-light">
                <thead>
                    <tr>
                        <th scope="col"></th>
                        <th scope="col">Name</th>
                        <th scope="col">Category</th>
                        <th scope="col">Discount</th>
                        <th scope="col">Buy Now</th>
                        <th scope="col">Price</th>
                        <th scope="col">Cancel</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${cart}" var="o">
                        <tr>
                            <td><input type="checkbox"/></td>
                            <td>${o.key.name}</td>
                            <jsp:useBean id="course" class="model.Course"/>
                            <jsp:setProperty name="course" property="cid" value="${o.key.cid}"/>
                            <td><jsp:getProperty name="course" property="cname"/></td>
                            <td>${o.key.discount}</td>
                            <td>
                                <form action="order-now" method="post" class="form-inline">
                                    <input type="hidden" name="id" value="${o.key.id}" class="form-input">
                                    <div class="form-group d-flex justify-content-between">
                                        <a class="btn bnt-sm btn-incre" href="quantity-inc-dec?action=inc&id=${o.key.id}"><i class="fas fa-plus-square"></i></a> 
                                        <input style="width: 60px" type="text" name="quantity" class="form-control"  value="${o.value}" readonly> 
                                        <a class="btn btn-sm btn-decre" href="quantity-inc-dec?action=dec&id=${o.key.id}"><i class="fas fa-minus-square"></i></a>
                                    </div>
                                    <button type="submit" class="btn btn-primary btn-sm">Buy</button>
                                </form>
                            </td>
                            <td><fmt:formatNumber pattern="#.##" value="${o.key.price*o.value}"></fmt:formatNumber></td>
                            <td><a href="remove-from-cart?id=${o.key.id}" class="btn btn-sm btn-danger">Remove</a></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- Script to control popup display -->
        <script>
            function displayPopup() {
                var popup = document.getElementById("popup");
                popup.style.display = "block"; // Display the popup
            }

            function closePopup() {
                var popup = document.getElementById("popup");
                popup.style.display = "none"; // Hide the popup
            }
        </script>
    </body>
</html>