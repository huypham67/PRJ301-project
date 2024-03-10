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
                            <div class="card" onmouseover="showPopup(this)">
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

    <div id="coursePopup" class="popup"></div>

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
            
        function showPopup(element) {
            var popup = document.getElementById('coursePopup');
            var listP = JSON.parse(popup.getAttribute('data-listp'));
            
            if (element) {
                var courseId = element.querySelector('.card-title a').getAttribute('href').split('=')[1];              
                var courseFound = null;
                
                listP.forEach(function(item) {
                    if (item.id === courseId) { 
                        alert("Cặc");
                        courseFound = item;
                    }
                });

                if (courseFound) {
                    // Hiển thị dữ liệu trong popup
                    var content = `
                        <h4>${courseFound.name}</h4>
                        <p>${courseFound.price}</p>
                        <p>${courseFound.cname}</p>
                    `;

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
    
</body>
</html>