package io.anhkhue.more.controllers.apis;

import io.anhkhue.more.models.dto.Account;
import io.anhkhue.more.models.dto.Movie;
import io.anhkhue.more.models.dto.Movies;
import io.anhkhue.more.services.MovieService;
import org.springframework.data.domain.Page;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import static org.springframework.http.HttpStatus.OK;
import static org.springframework.http.HttpStatus.UNAUTHORIZED;

@Controller
public class MovieController {

    private final MovieService movieService;

    public MovieController(MovieService movieService) {
        this.movieService = movieService;
    }

    @GetMapping(value = "/movies", produces = "application/xml")
    public ResponseEntity getAll() {
        Movies movies = new Movies();
        movies.setMovie(movieService.findAll());
        return ResponseEntity.status(OK).body(movies);
    }

    @GetMapping(value = "/movies/top/page={page}&no={number}", produces = MediaType.APPLICATION_XML_VALUE)
    public ResponseEntity getTopNewMoviesByPage(@PathVariable String page,
                                                @PathVariable String number) {
        Page<Movie> moviePage = movieService.findTopNewMovies(Integer.parseInt(page),
                                                              Integer.parseInt(number));
        Movies movies = new Movies();
        movies.setMovie(moviePage.getContent());
        return ResponseEntity.status(OK).body(movies);
    }

    @GetMapping(value = "/movies/coming/page={page}&no={number}", produces = MediaType.APPLICATION_XML_VALUE)
    public ResponseEntity getComingMoviesByPage(@PathVariable String page,
                                                @PathVariable String number) {
        Page<Movie> moviePage = movieService.findIsComingMovies(Integer.parseInt(page),
                                                                Integer.parseInt(number));
        Movies movies = new Movies();
        movies.setMovie(moviePage.getContent());
        return ResponseEntity.status(OK).body(movies);
    }

    @PostMapping(value = "/movies/{movieId}/rate")
    public ResponseEntity rateMovie(HttpServletRequest request,
                                    @PathVariable String movieId,
                                    @RequestParam String rating) {
        HttpSession session = request.getSession();
        Account currentUser = (Account) session.getAttribute("USER");

        if (currentUser == null) {
            return ResponseEntity.status(UNAUTHORIZED).body("Vui lòng đăng nhập để đánh giá phim.");
        }

        double newRating = movieService.rate(Integer.parseInt(rating),
                                             Integer.parseInt(movieId),
                                             currentUser.getUsername());

        return ResponseEntity.status(OK).body(newRating);
    }
}
