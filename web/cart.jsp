<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="model.Course" %>
<%@include file="includes/language.jsp" %>
<%@include file="includes/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Your cart Page</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="css/cart.css" type="text/css"/>
</head>
<body>
    <%@include file="includes/navbar.jsp" %>
    <div style="padding-top: 100px" class="container my-3">
        <div class="HLRhQB"><img width="44" height="40" src="https://static.vecteezy.com/system/resources/thumbnails/015/452/522/small/discount-icon-in-trendy-flat-style-isolated-on-background-discount-icon-page-symbol-for-your-web-site-design-discount-icon-logo-app-ui-discount-icon-eps-vector.jpg" alt="fs-icon">
            <span class="UqssKR">Following Fanpage to join event and get discount!</span>
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
                        <td><input type="checkbox" value="${o.key.id}" onchange="updateSelectedCount()"/></td>
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

    <div class="fixed-bottom">
        <div class="container">
            <div class="d-flex justify-content-end">
                <h3 class="mr-3">Total Price: $<fmt:formatNumber pattern="#.##" value="${total}"></fmt:formatNumber></h3>
                <div class="text-right mb-3">
                    <button onclick="removeSelected()" id="deleteSelectedBtn" class="btn btn-danger">Delete Selected (0)</button>
                    <button onclick="buySelected()" id="buySelectedBtn" class="btn btn-primary mr-2">Buy Selected (0)</button>                 
                </div>  
            </div>
        </div>
    </div>
                
    <!-- Confirmation Popup -->
    <div id="confirmationPopup" class="popup">
        <div class="popup-content">
            <h2 id="popupMessage"></h2>
            <button id="confirmBtn">Confirm</button>
            <button id="cancelBtn">Cancel</button>
        </div>
    </div>

    <script>
        function updateSelectedCount() {
            var checkboxes = document.querySelectorAll('input[type="checkbox"]:checked');
            var selectedCount = checkboxes.length;
            document.getElementById("deleteSelectedBtn").innerText = "Delete Selected (" + selectedCount + ")";
            document.getElementById("buySelectedBtn").innerText = "Buy Selected (" + selectedCount + ")";
        }
        
    function buySelected() {
        var checkboxes = document.querySelectorAll('input[type="checkbox"]:checked');
        var selectedIds = [];

        checkboxes.forEach(function(checkbox) {
            selectedIds.push(checkbox.value);
        });

        if (selectedIds.length === 0) {
            alert("Please select at least one item to buy.");
            return;
        }

        showConfirmationPopup("Are you sure you want to buy the selected items?", function() {
            var selectedIdsString = selectedIds.join(",");

            var xhttp = new XMLHttpRequest();
            xhttp.open("POST", "buyCheckbox", true);
            xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            var params = "selectedIds=" + encodeURIComponent(selectedIdsString);

            xhttp.onreadystatechange = function() {
                if (this.readyState == 4 && this.status == 200) {
                    alert("Thank you! Here we go to checkout!");
                    window.location.href = "checkout"; 
                }
            };
         
            xhttp.send(params);
        });
    }


        function removeSelected() {
            var checkboxes = document.querySelectorAll('input[type="checkbox"]:checked');
            var selectedCount = checkboxes.length;

            if (selectedCount === 0) {
                alert("Please select at least one item to delete.");
                return;
            }

            showConfirmationPopup("Are you sure you want to delete the selected items?", function() {
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
                        location.reload()
                    }
                };
                xhttp.send(params); 
            });
        }

        function showConfirmationPopup(message, confirmCallback) {
            document.getElementById('popupMessage').innerText = message;
            document.getElementById('confirmationPopup').style.display = 'block';

            document.getElementById('confirmBtn').onclick = function() {
                hideConfirmationPopup();
                confirmCallback();
            };

            document.getElementById('cancelBtn').onclick = function() {
                hideConfirmationPopup();
            };
        }

        function hideConfirmationPopup() {
            document.getElementById('confirmationPopup').style.display = 'none';
        }
    </script>
</body>
</html>
