<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<div class="navbar navbar-expand-md navbar-dark bg-dark mb-4" role="navigation">
    <a class="navbar-brand" href="home">CODE FOR LIFE</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarCollapse">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="home">Home <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">About us</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#" target="_blank">Github</a>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" id="dropdown1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Categories</a>
                <ul class="dropdown-menu" aria-labelledby="dropdown1">
                    <c:forEach items="${listC}" var="o">
                        <li class="dropdown-item"><a href="category?cid=${o.cid}">${o.cname}</a></li>
                        </c:forEach>
                </ul>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#" target="_blank">Contact</a>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" id="dropdown2-1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Language</a>
                <ul class="dropdown-menu" aria-labelledby="dropdown2-1">
                    <li class="dropdown-item"><a href="#" id="englishLink">English</a></li>
                    <li class="dropdown-item"><a href="#" id="vietnameseLink">Vietnamese</a></li>
                </ul>
            </li>
        </ul>
        <form class="form-inline mt-2 mt-md-0" action="search" method="post">
            <input class="form-control mr-sm-2" type="text" name="txt" value="${txtS}" placeholder="Search" aria-label="Search">
            <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
            <a class="btn btn-success btn-sm ml-3" href="cart">
                <i class="fa fa-shopping-cart"></i> Cart
                <span class="badge badge-light">${cookie.sizeC.value}</span>
            </a>
            <ul class="navbar-nav mr-auto">
                <c:if test="${sessionScope.acc == null}">
                    <li class="nav-item">
                        <a class="nav-link" href="login.jsp">Login</a>
                    </li>
                </c:if>
                <c:if test="${sessionScope.acc != null}">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" id="dropdown2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Account</a>
                        <ul class="dropdown-menu" aria-labelledby="dropdown1"> 
                            <c:if test="${sessionScope.acc.isAdmin == 1}">
                                <li class="dropdown-item"><a href="managerProduct.jsp">Manage Product</a></li>
                                </c:if>
                            <li class="dropdown-item" href="#"><a href="profile">Profile</a></li>
                            <li class="dropdown-item" href="#"><a href="orders">Orders</a></li>
                            <li class="dropdown-item" href="#"><a href="logout">Logout</a></li>
                        </ul>
                    </li>
                </c:if>
            </ul>
        </form>
    </div>
</div>
<script>
    document.getElementById('englishLink').addEventListener('click', function (event) {
        updateLanguageUrl('en');
    });

    document.getElementById('vietnameseLink').addEventListener('click', function (event) {
        updateLanguageUrl('vi');
    });

    function updateLanguageUrl(language) {
        var currentUrl = window.location.href;
        var newUrl;
        var separator = currentUrl.indexOf('?') !== -1 ? '&' : '?';

        if (currentUrl.indexOf('lang=') !== -1) {
            newUrl = currentUrl.replace(/lang=[^\&]+/, 'lang=' + language);
        } else {
            newUrl = currentUrl + separator + 'lang=' + language;
        }

        window.location.href = newUrl;
    }
</script>
