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
                                <thead>
                                    <tr>
                                        <th scope="col">ID</th>
                                        <th scope="col">Quantity</th>
                                        <th scope="col">Discount</th>
                                        <th scope="col">Subtotal</th>
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
                        <button onclick="purchase()">Purchase</button>
                    </div>
                </div>                    
            </div>
        </div>   
    </div>

    <!-- Script section -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        function updateOrderSummary() {
            var total = 0;
            var rows = document.querySelectorAll("tbody tr");

            var orderSummaryBody = document.getElementById("orderSummaryBody");
            orderSummaryBody.innerHTML = '';

            rows.forEach(function(row, index) {
                var id = row.querySelector("td:first-child").innerText; 
                var quantity = parseInt(row.querySelector("select").value);
                var price = parseFloat(row.querySelector("td:nth-child(6)").innerText);
                var discount = parseFloat(row.querySelector("td:nth-child(5)").innerText);
                var subtotal = (quantity * price) - discount;
                total += subtotal;

                // Add the data to the order summary table
                var newRow = document.createElement('tr');
                newRow.innerHTML = '<td>' + id + '</td>' +
                                   '<td>' + quantity + '</td>' +
                                   '<td>' + discount.toFixed(2) + '</td>' +
                                   '<td>' + subtotal.toFixed(2) + '</td>';
                orderSummaryBody.appendChild(newRow);
            });
            
            document.getElementById("totalPriceCell").innerText = total.toFixed(2);
        }

        function clearOrderSummary() {
            var summaryRows = document.querySelectorAll("#orderSummaryBody tr");
            summaryRows.forEach(function(row) {
                row.remove();
            });
            document.getElementById("totalPriceCell").innerText = "0.00";
        }

        function clearAndUpdateOrderSummary() {
            clearOrderSummary();
            updateOrderSummary();
        }
        
        function purchase() {
            var rows = document.querySelectorAll("#orderSummaryBody tr");
            var selectedIds = [];

            rows.forEach(function(row) {
                var cells = row.querySelectorAll("td");
                var id = cells[0].innerText;
                var quantity = parseInt(cells[1].innerText);

                if (quantity > 0) {
                    selectedIds.push(id);
                }
            });

            var params = "selectedIds=" + selectedIds.join(",");

            var xhttp = new XMLHttpRequest();
            xhttp.open("POST", "PurchaseServlet", true);
            xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

            xhttp.onreadystatechange = function() {
                if (this.readyState == 4) {
                    if (this.status == 200) {
                        // Xử lý phản hồi từ server (nếu cần)
                        alert("Purchase successful!");
                        // Chuyển hướng đến trang /order
                        window.location.href = "order";
                    } else {
                        // Xử lý lỗi (nếu có)
                        alert("An error occurred while processing the purchase.");
                    }
                }
            };

            xhttp.send(params);
        }

    </script>
</body>
</html>
