<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="model.Course" %>
<%@include file="includes/language.jsp" %>
<%@include file="includes/navbar.jsp" %>
<%@include file="includes/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Your cart Page</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"/>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"
          integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN"
          crossorigin="anonymous">
    <link rel="stylesheet" href="css/cart.css" type="text/css"/>
</head>
<body>
    <div class="container my-3">
        <div class="d-flex py-3">
            <h3>Total Price: $
                <fmt:formatNumber pattern="#.##" value="${total}"></fmt:formatNumber>
            </h3>
            <button onclick="displayPopup()" class="mx-3 btn btn-primary">Checkout</button>
            <h5 style='color: crimson; text-align: center'>${mes}</h5>
        </div>

        <div class="text-right mb-3">
            <button onclick="buySelected()" class="btn btn-primary">Buy Selected</button>
            <button onclick="removeSelected()" class="btn btn-danger">Delete Selected</button>
        </div>     

        <table class="table table-light">
            <thead>
                <tr>
                    <th scope="col"></th>
                    <th scope="col">Name</th>
                    <th scope="col">Category</th>
                    <th scope="col">Discount</th>
                    <th scope="col">Price</th>
                    <th scope="col">Cancel</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${cart}" var="o">
                    <tr>
                        <td><input type="checkbox" value="${o.key.id}"/></td>
                        <td>${o.key.name}</td>
                        <jsp:useBean id="course" class="model.Course"/>
                        <jsp:setProperty name="course" property="cid" value="${o.key.cid}"/>
                        <td><jsp:getProperty name="course" property="cname"/></td>
                        <td>${o.key.discount}</td>
                        <td><fmt:formatNumber pattern="#.##" value="${o.key.price*o.value}"></fmt:formatNumber></td>
                        <td><a href="#" onclick="removeById('${o.key.id}')" class="btn btn-sm btn-danger">Remove</a></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    <script>
        function displayPopup() {
            var popup = document.getElementById("popup");
            popup.style.display = "block"; // Display the popup
        }

        function closePopup() {
            var popup = document.getElementById("popup");
            popup.style.display = "none"; // Hide the popup
        }

        function removeSelected() {
            var checkboxes = document.querySelectorAll('input[type="checkbox"]:checked');
            var ids = [];
            checkboxes.forEach(function (checkbox) {
                ids.push(checkbox.value);
            });
            removeById(ids);
        }

        function removeById(ids) {
            // Gửi yêu cầu xóa các id đến máy chủ, ví dụ sử dụng Ajax
            // Đoạn mã Ajax để gửi yêu cầu xóa các id cụ thể
        }
    </script>
</body>
</html>
