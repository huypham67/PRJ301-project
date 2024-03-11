<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="model.Course" %>
<%@include file="includes/language.jsp" %>
<%@include file="includes/navbar.jsp" %>
<%@include file="includes/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Your cart Page</title>
    <link rel="stylesheet" href="css/cart.css" type="text/css"/>
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
            var xhttp = new XMLHttpRequest();
            xhttp.open("POST", "deleteSelected", true);
            xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            var params = "selectedIds=" + encodeURIComponent(ids.join(","));
            xhttp.onreadystatechange = function() {
                if (this.readyState == 4 && this.status == 200) {
                    alert("Deleted Successfully!");
                    location.reload();
                }
            };
            xhttp.send(params); 
        }
    </script>
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
                        <td><a href="remove-from-cart?id=${o.key.id}" class="btn btn-sm btn-danger">Remove</a></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>
