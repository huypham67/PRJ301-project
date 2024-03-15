<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.Course" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="includes/language.jsp" %>
<fmt:setBundle basename="i18n.language" var="langSet"/>
<!DOCTYPE html>
<html>
<head>
    <title><fmt:message key = "home.title" bundle = "${langSet}"/></title>
    <jsp:include page="/includes/header.jsp" />   
    <link rel="stylesheet" href="css/home.css"/>
</head>
<body>
    <jsp:include page="/includes/navbar.jsp" />
    <div id="bannerHome"><jsp:include page="/includes/banner.jsp"/></div>
    <div class="container">
        <div class="row">
            <div class="col">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="home"><fmt:message key="home.breadcrumb.home" bundle="${langSet}"/></a></li>
                        <li class="breadcrumb-item"><a href="#"><fmt:message key="home.breadcrumb.category" bundle="${langSet}"/></a></li>
                        <li class="breadcrumb-item active" aria-current="true">${cname}</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="row">
            <jsp:include page="/includes/left.jsp"/>
            <div class="col-sm-9">
                <div id="content" class="row">
                    <c:forEach items="${listP}" var="o">
                        <div class="col-12 col-md-6 col-lg-4" style="position: relative;">
                            <div class="card" onmouseover="showPopup(this)" onmouseout="closePopup(this)">
                                <img class="card-img-top" src="${o.image}" alt="Card image cap">
                                <div class="card-body">
                                    <h4 class="card-title show_txt"><a href="detail?id=${o.id}" title="View Product">${o.name}</a></h4>
                                    <h5 class="price"><fmt:message key="home.card.price" bundle="${langSet}"/> $${o.price}</h5>
                                    <jsp:useBean id="course" class="model.Course"/>
                                    <jsp:setProperty name="course" property="cid" value="${o.cid}"/>
                                    <h5 class="category"><fmt:message key="home.card.category" bundle="${langSet}"/> <jsp:getProperty name="course" property="cname"/></h5>
                                    <c:if test="${tagCourseId == o.id}">
                                        <h6 style='color: crimson; text-align: center'>${mes}</h6>
                                    </c:if>
                                    <div class="mt-3 d-flex justify-content-between">
                                        <a class="btn btn-dark" href="add-to-cart?id=${o.id}&quantity=1"><fmt:message key="home.card.add_to_cart" bundle="${langSet}"/></a> 
                                        <a class="btn btn-danger" href="order-now?id=${o.id}&quantity=1"><fmt:message key="home.card.buy_now" bundle="${langSet}"/></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/includes/footer.jsp"/>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            var categoryBlock = document.querySelector('.category_block');
            categoryBlock.style.display = 'none';
            // Hiển thị danh sách danh mục khi trỏ chuột vào
            categoryBlock.parentNode.addEventListener('mouseover', function() {
                categoryBlock.style.display = 'block';
            });

            // Ẩn danh sách danh mục khi trỏ chuột ra ngoài
            categoryBlock.parentNode.addEventListener('mouseout', function() {
                categoryBlock.style.display = 'none';
            });
        }); 
        
        function closePopup(element){
            var popup = document.getElementById('coursePopup');
            popup.style.display = 'none';
        }
        
        function showPopup(element) {
            var popup = document.getElementById('coursePopup');
            var listP = [
                <c:forEach items="${listP}" var="course" varStatus="loop">
                    {
                        id: "${course.id}",
                        name: "${course.name}",
                        price: ${course.price},
                        cname: "${course.cname}",
                        image: "${course.image}",
                        description: "${course.description}",
                        duration_month: ${course.duration_month},
                        publicDate: "${course.publicDate}",
                        discount: ${course.discount}
                    }<c:if test="${not loop.last}">,</c:if>
                </c:forEach>
            ];

            if (element) {
                var courseId = element.querySelector('.card-title a').getAttribute('href').split('=')[1]; 
                var courseFound = listP.find(function(item) {
                    return item.id === courseId;
                });

                if (courseFound) {
                    var content = "<div class='course-info'>" +
                        "<img src='" + courseFound.image + "' alt='" + courseFound.name + "'>" +
                        "<div class='details'>" +
                        "<h4>" + courseFound.name + "</h4>" +
                        "<p><strong>Price:</strong> $" + courseFound.price + "</p>" +
                        "<p><strong>Discount:</strong> $" + courseFound.discount + "</p>" +
                        "<p><strong>Category:</strong> " + courseFound.cname + "</p>" +
                        "<p><strong>Description:</strong> " + courseFound.description + "</p>" +
                        "<p><strong>Duration:</strong> " + courseFound.duration_month + " months</p>" +
                        "<p><strong>Public Date:</strong> " + courseFound.publicDate + "</p>" +
                        "</div>" +
                        "</div>";

                    popup.innerHTML = content;
                    popup.style.display = 'block';

                    // Xác định vị trí của popup
                    var rect = element.getBoundingClientRect();
                    var scrollTop = window.pageYOffset || document.documentElement.scrollTop;
                    var scrollLeft = window.pageXOffset || document.documentElement.scrollLeft;
                    var topPos = rect.top + scrollTop;
                    var leftPos = rect.left + scrollLeft + rect.width;

                    // Đặt vị trí của popup bên cạnh khóa học
                    popup.style.top = topPos + 'px';
                    popup.style.left = leftPos + 'px';
                } else {
                    console.error('Không tìm thấy khóa học với ID: ' + courseId);
                }
            } else {
                console.error('Không thể tìm thấy dữ liệu');
            }
        }

    </script>
    <div style="width: 300px; height: 600px" id="coursePopup" class="popup"></div> 
    <style>
        .popup {
            position: absolute;
            background-color: white;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 10px;
            z-index: 999;
        }

        .course-info {
            display: inline-block;
        }

        .course-info img {
            border: 10px;
            border-color: black;
            width: 280px;
            height: auto;
            margin-right: 10px;
        }

        .course-info .details {
            flex: 1;
        }

        .course-info h4 {
            margin-top: 0;
            margin-bottom: 10px;
        }

        .course-info p {
            margin-top: 0;
            margin-bottom: 5px;
        }
    </style>
    
</body>
</html>