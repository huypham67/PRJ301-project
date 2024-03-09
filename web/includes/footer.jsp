<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- Footer -->
<%@include file="../includes/language.jsp" %>
<link rel="stylesheet" href="/css/footer.css"/>
<footer class="text-light">
    <div class="container">
        <div class="row">
            <div class="col-md-3 col-lg-4 col-xl-3">
                <h5><fmt:message key="footer.about_us" bundle="${langSet}" /></h5>
                <hr class="bg-white mb-2 mt-0 d-inline-block mx-auto w-25">
                <p class="mb-0">
                    <fmt:message key="footer.introduction" bundle="${langSet}" />
                </p>
            </div>

            <div class="col-md-2 col-lg-2 col-xl-2 mx-auto">
                <h5><fmt:message key="footer.information" bundle="${langSet}" /></h5>
                <hr class="bg-white mb-2 mt-0 d-inline-block mx-auto w-25">
                <ul class="list-unstyled">
                    <li><a href="">Link 1</a></li>
                    <li><a href="">Link 2</a></li>
                    <li><a href="">Link 3</a></li>
                    <li><a href="">Link 4</a></li>
                </ul>
            </div>

            <div class="col-md-3 col-lg-2 col-xl-2 mx-auto">
                <h5><fmt:message key="footer.others_links" bundle="${langSet}" /></h5>
                <hr class="bg-white mb-2 mt-0 d-inline-block mx-auto w-25">
                <ul class="list-unstyled">
                    <li><a href="">Link 1</a></li>
                    <li><a href="">Link 2</a></li>
                    <li><a href="">Link 3</a></li>
                    <li><a href="">Link 4</a></li>
                </ul>
            </div>

            <div class="col-md-4 col-lg-3 col-xl-3">
                <h5><fmt:message key="footer.contact" bundle="${langSet}" /></h5>
                <hr class="bg-white mb-2 mt-0 d-inline-block mx-auto w-25">
                <ul class="list-unstyled">
                    <li><i class="fa fa-home mr-2"></i> Group 5</li>
                    <li><i class="fa fa-envelope mr-2"></i> huypdnde170173@fpt.edu.vn</li>
                    <li><i class="fa fa-phone mr-2"></i> + 84941121748</li>
                    <li><i class="fa fa-print mr-2"></i> + 33 12 14 15 16</li>
                </ul>
            </div>
            <div class="col-12 copyright mt-3">
                <p class="float-left">
                    <a href="#"><fmt:message key="footer.back_to_top" bundle="${langSet}" /></a>
                </p>
                <p class="text-right text-muted"><fmt:message key="footer.created_by" bundle="${langSet}" /> <a href="#"><i>group5</i></a> | <span><fmt:message key="footer.version" bundle="${langSet}" /></span></p>
            </div>
        </div>
    </div>
</footer>
