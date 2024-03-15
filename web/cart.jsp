<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
        <div class="HLRhQB">
            <img width="44" height="40" src="https://static.vecteezy.com/system/resources/thumbnails/015/452/522/small/discount-icon-in-trendy-flat-style-isolated-on-background-discount-icon-page-symbol-for-your-web-site-design-discount-icon-logo-app-ui-discount-icon-eps-vector.jpg" alt="fs-icon">
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
                        <td>
                            <c:forEach items="${listC}" var="category">
                                <c:if test="${category.cid eq o.key.cid}">
                                    ${category.cname}
                                </c:if>
                            </c:forEach>
                        </td>
                        <td>${o.key.discount}</td>
                        <td><fmt:formatNumber pattern="#.##" value="${o.key.price * o.value}"/></td>
                        <td><a href="remove-from-cart?id=${o.key.id}" class="btn btn-sm btn-danger">Remove</a></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="fixed-bottom">
        <div class="container">
            <div class="d-flex justify-content-end">
                <h3 class="mr-3">Total Price: $<fmt:formatNumber pattern="#.##" value="${total}"/></h3>
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

    <script src="script/cart.js"></script>
</body>
</html>
