<%-- 
    Document   : index
    Created on : Feb 23, 2024, 10:26:29 PM
    Author     : huypd
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="dao.DAO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Orders Page</title>
        <jsp:include page="/includes/header.jsp" />
    </head>
    <body>
        <jsp:include page="/includes/navbar.jsp" />
        <div class="container">
            <div class="card-header my-3">All Orders</div>
            <table class="table table-light">
                <thead>
                    <tr>
                        <th scope="col">Date</th>
                        <th scope="col">Name</th>
                        <th scope="col">Category</th>
                        <th scope="col">Quantity</th>
                        <th scope="col">Price</th>
                        <th scope="col">Cancel</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach begin="1" end="5" var="o">
                    <tr>
                        <td>1</td>
                        <td>1</td>
                        <td>1</td>
                        <td>1</td>
                        <td>25</td>
                        <td><a class="btn btn-sm btn-danger" href="cancel-order?id=1">Cancel Order</a></td>
                    </tr>
                    </c:forEach>

                </tbody>
            </table>
        </div>
    </body>
</html>