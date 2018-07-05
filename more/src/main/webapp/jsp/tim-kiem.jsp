<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>AK Phim</title>
        <link rel="icon" href="/img/Logo_K.svg">
        <!-- Bootstrap core CSS -->
        <link href="/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <!-- Custom fonts for this template -->
        <link href="/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link href="/vendor/simple-line-icons/css/simple-line-icons.css" rel="stylesheet" type="text/css">
        <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic"
              rel="stylesheet"
              type="text/css">
        <!-- Custom styles for this template -->
        <link href="/css/master.css" rel="stylesheet">
        <link href="/css/phim-moi.css" rel="stylesheet">
    </head>
    <body>
        <script>
            var searchValue = '${requestScope.SEARCH_VALUE}';
            var totalPages = parseInt('${requestScope.TOTAL_PAGES}');
            var currentPage = 1;
            var moviePerPage = 12;
        </script>

        <!-- Header -->
        <jsp:include page="fragments/header.jsp"/>

        <!-- Masthead -->
        <jsp:include page="fragments/masthead.jsp">
            <jsp:param name="adQuote" value="Luôn cập nhật các tác phẩm điện ảnh mới nhất"/>
        </jsp:include>

        <!-- Movies -->
        <section class="movies text-center bg-light">
            <div class="container">
                <h2 id="new-movies" class="mb-5">Kêt quả tìm kiếm</h2>
                <%-- Movie List --%>
                <div id="movies">

                </div>
            </div>
            <br>
            <%-- Pagination --%>
            <nav>
                <ul id="pagination" class="pagination justify-content-center">

                </ul>
            </nav>
        </section>

        <!-- Footer -->
        <jsp:include page="fragments/footer.jsp"/>

        <script src="/js/client-cache.js" type="text/javascript"></script>
        <script src="/js/more/MovieAccessor.js" type="text/javascript"></script>
        <script src="/js/more/MoviePresenter.js" type="text/javascript"></script>
        <script src="/js/more/Pagination.js" type="text/javascript"></script>

        <script type="text/javascript">
            // self executing function
            (function () {
                if (totalPages !== 0) {
                    var pagination = new Pagination(currentPage, 'search', searchValue);

                    pagination.createPagination('pagination');
                    var movieAccessor = new MovieAccessor('search', currentPage, moviePerPage);

                    var moviePresenter = new MoviePresenter('movies', movieAccessor, searchValue);
                    topSearchMovies(moviePerPage * 10, moviePresenter, searchValue);
                } else {
                    var showSection = document.getElementById('movies');
                    var inform = document.createElement('h4');
                    inform.innerHTML = 'Không tìm thấy kết quả nào';
                    showSection.appendChild(inform);
                }
            })();
        </script>
    </body>
</html>