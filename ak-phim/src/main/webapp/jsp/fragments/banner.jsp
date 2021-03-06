<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="en">
    <body>
        <%--<header class="masthead text-white text-center">
            <div class="overlay"></div>
            <div class="container">
                <div class="row">
                    <div class="col-xl-9 mx-auto">
                        <h1 class="mb-5">
                            <c:out value="${param.adQuote}"/>
                        </h1>
                    </div>
                    <div class="col-md-10 col-lg-8 col-xl-7 mx-auto">
                        <form action="/tim-kiem" method="get">
                            <div class="form-row">
                                <div class="col-12 col-md-9 mb-2 mb-md-0">
                                    <input type="text"
                                           class="form-control form-control-lg"
                                           placeholder="Tên phim..."
                                           value="${requestScope.SEARCH_VALUE}"
                                           name="searchValue">
                                </div>
                                <div class="col-12 col-md-3">
                                    <button type="submit" class="btn btn-block btn-lg btn-success">Tìm kiếm</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </header>--%>

        <div id="banner">
            <img src="${param.bannerImg}"/>
            <div class="banner-overlay"></div>
            <div class="banner-content">
                <div class="banner-title">
                    <c:out value="${param.adQuote}"/>
                </div>
                <div class="banner-search">
                    <form action="/tim-kiem">
                        <input type="text" placeholder=" Tên phim..."
                               value="${requestScope.SEARCH_VALUE}"
                               name="searchValue"/>
                        <button type="submit">Tìm kiếm</button>
                    </form>
                </div>
            </div>
        </div>

    </body>
</html>