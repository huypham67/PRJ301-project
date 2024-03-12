<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@include file="includes/language.jsp" %>
<jsp:useBean id="course" class="model.Course" scope="session"/>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Check out page</title>
    <jsp:include page="includes/header.jsp"/>
    <jsp:include page="includes/navbar.jsp"/>
</head>
<body>
    
    <jsp:include page="includes/formInfo.jsp"/>
    
    <div style="padding-top: 80px" class="container">
        <div class="row">
            <div class="col-xl-8">
                <c:out value="${selectedCourses}" />
                <c:forEach items="${selectedCourses}" var="course">
                    <div class="card border shadow-none">
                        <div class="card-body">
                            <div class="d-flex align-items-start border-bottom pb-3">
                                <div class="me-4">
                                    <img src="${course.image}" alt="" class="avatar-lg rounded">
                                </div>
                                <div class="flex-grow-1 align-self-center overflow-hidden">
                                    <div>
                                        <h5 class="text-truncate font-size-18">${course.name}</h5>
                                        <p class="text-muted mb-0">Category : <span class="fw-medium">${course.getCname()}</span></p>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="mt-3">
                                        <p class="text-muted mb-2">Price</p>
                                        <h5 class="mb-0 mt-2"><span class="text-muted me-2"><del class="font-size-16 fw-normal">${course.price}</del></span>${course.getPrice()}</h5>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                <!-- End loop -->
            </div>

            <!-- Order Summary Section -->
            <div class="col-xl-4">
                <div class="mt-5 mt-lg-0">
                    <!-- Order Summary Card -->
                    <div class="card border shadow-none">
                        <div class="card-header bg-transparent border-bottom py-3 px-4">
                            <h5 class="font-size-16 mb-0">Order Summary <span class="float-end">#MN0124</span></h5>
                        </div>
                        <div class="card-body p-4 pt-2">
                            <div class="table-responsive">
                                <table class="table mb-0">
                                    <tbody>
                                        <!-- Order Summary Details -->
                                        <tr>
                                            <td>Sub Total :</td>
                                            <td class="text-end">$ 780</td>
                                        </tr>
                                        <tr>
                                            <td>Discount : </td>
                                            <td class="text-end">- $ 78</td>
                                        </tr>
                                        <tr>
                                            <td>Shipping Charge :</td>
                                            <td class="text-end">$ 25</td>
                                        </tr>
                                        <tr>
                                            <td>Estimated Tax : </td>
                                        <td class="text-end">$ 18.20</td>
                                        </tr>
                                        <tr class="bg-light">
                                            <th>Total :</th>
                                            <td class="text-end">
                                                <span class="fw-bold">$ 745.2</span>
                                            </td>
                                        </tr>
                                        <!-- End Order Summary Details -->
                                    </tbody>
                                </table>
                            </div>
                            
                        </div>
                    </div>
                    
                </div>
            </div>
            
        </div>
        <!-- end row -->
    </div>
</body>
</html>
