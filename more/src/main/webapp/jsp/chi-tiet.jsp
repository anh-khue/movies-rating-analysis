<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/xml" prefix="x" %>

<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>Chi tiết</title>
        <link rel="icon" href="/img/Logo_K.svg">
        <!-- Bootstrap core CSS -->
        <link href="/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <!-- Custom fonts for this template -->
        <link href="/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link href="/vendor/simple-line-icons/css/simple-line-icons.css" rel="stylesheet" type="text/css">
        <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic"
              rel="stylesheet" type="text/css">
        <!-- Custom styles for this template -->
        <link href="/css/master.css" rel="stylesheet">
        <link href="/css/phim-moi.css" rel="stylesheet">
        <link href="/css/chi-tiet.css" rel="stylesheet">
    </head>
    <body>
        <!-- Header -->
        <jsp:include page="fragments/header.jsp"/>

        <c:set var="movie" value="${requestScope.MOVIE}"/>

        <%-- If movie not null --%>
        <c:if test="${not empty movie}">
            <div class="container">
                <div class="row wrapper">
                    <c:import charEncoding="UTF-8" url="/xsl/movie-detail.xsl" var="xslDoc"/>
                    <x:transform doc="${movie}" xslt="${xslDoc}"/>
                </div>
                <!-- Recommend -->
                <section class="testimonials text-center">
                    <div class="container">
                        <h2 class="mb-5">Có thể bạn sẽ thích</h2>
                        <div class="row">
                            <div class="col-lg-3">
                                <div class="testimonial-item mx-auto mb-5 mb-lg-0">
                                    <img class="img-thumbnail mb-3" src="img/justice_league.jpeg" alt="">
                                    <h5>Liên minh công lý</h5>
                                </div>
                            </div>
                            <div class="col-lg-3">
                                <div class="testimonial-item mx-auto mb-5 mb-lg-0">
                                    <img class="img-thumbnail mb-3" src="img/infinity_war.jpg" alt="">
                                    <h5>Biệt đội siêu anh hùng: Cuộc chiến vô cực</h5>
                                </div>
                            </div>
                            <div class="col-lg-3">
                                <div class="testimonial-item mx-auto mb-5 mb-lg-0">
                                    <img class="img-thumbnail mb-3" src="img/black_panther.jpeg" alt="">
                                    <h5>Chiến binh Báo đen</h5>
                                </div>
                            </div>
                            <div class="col-lg-3">
                                <div class="testimonial-item mx-auto mb-5 mb-lg-0">
                                    <img class="img-thumbnail mb-3" src="img/spider_man.jpeg" alt="">
                                    <h5>Người Nhện: Về nhà</h5>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
        </c:if>
        <%-- End if movie not null --%>

        <%-- If movie null --%>
        <c:if test="${empty movie}">
            <div class="container text-center sorry-message">
                <h1 class="message">Xin lỗi!</h1>
                <br>
                <h2 class="message">Chúng tôi không thể tìm thấy trang bạn yêu cầu</h2>
                <br>
                <img src="/img/panda-404.png" alt="">
                <br>
                <a href="/">
                    <button class="btn btn-success">Quay lại</button>
                </a>
            </div>
        </c:if>
        <%-- End if movie null --%>

        <!-- Footer -->
        <jsp:include page="fragments/footer.jsp"/>

        <script type="text/javascript">
            function rate(star) {
                var stars = document.getElementsByClassName('star');

                for (var i = 0; i < stars.length; i++) {
                    stars[i].classList.remove('checked');
                }

                for (i = 1; i <= star; i++) {
                    stars[i - 1].classList.add('checked');
                }

                var movieId = document.getElementById('movie-id').value;

                var request = new XMLHttpRequest();
                var url = '/movies/' + movieId + '/rate';
                var params = 'rating=' + star;
                request.open('POST', url, true);

                // Send the proper header information along with the request
                request.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');

                request.onreadystatechange = function () {
                    if (request.readyState === 4 && request.status === 200) {
                        var movieRating = document.getElementById('movie-rating');
                        movieRating.innerHTML = request.responseText + ' <span class="fa fa-star"/>';

                        var message = document.getElementById('message');
                        message.innerHTML = "Cảm ơn phản hồi của bạn!";
                    } else if (request.status === 401) {
                        message = document.getElementById('message');

                        message.innerHTML = "";
                        var errorMessage = document.createElement('div');
                        errorMessage.classList.add('alert', 'alert-danger');

                        errorMessage.innerHTML = request.responseText;
                        message.appendChild(errorMessage);
                    }
                };

                request.send(params);
            }
        </script>
    </body>
</html>