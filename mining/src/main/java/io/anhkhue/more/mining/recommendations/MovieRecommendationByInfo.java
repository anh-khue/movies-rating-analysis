package io.anhkhue.more.mining.recommendations;

import io.anhkhue.more.mining.function.similarity.Similarity;
import io.anhkhue.more.mining.model.ActorInMovie;
import io.anhkhue.more.mining.model.Movie;
import io.anhkhue.more.mining.model.MovieHasCategory;
import io.anhkhue.more.mining.repository.ActorInMovieRepository;
import io.anhkhue.more.mining.repository.MovieHasCategoryRepository;
import io.anhkhue.more.mining.repository.MovieRepository;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class MovieRecommendationByInfo implements MovieRecommendation<Movie, Similarity<Movie>> {

    private final MovieHasCategoryRepository movieHasCategoryRepository;
    private final MovieRepository movieRepository;
    private final ActorInMovieRepository actorInMovieRepository;

    MovieRecommendationByInfo(MovieHasCategoryRepository movieHasCategoryRepository, MovieRepository movieRepository, ActorInMovieRepository actorInMovieRepository) {
        this.movieHasCategoryRepository = movieHasCategoryRepository;
        this.movieRepository = movieRepository;
        this.actorInMovieRepository = actorInMovieRepository;
    }

    @Override
    public Map<Integer, Double> recommend(Movie movie, Similarity<Movie> similarity) {
        Map<Integer, Double> rankings = new HashMap<>();

        // Optimize set of mining
        String specificCategories = movieHasCategoryRepository.findByMovieId(movie.getId()).stream()
                                                              .map(MovieHasCategory::getCategoryName)
                                                              .collect(Collectors.toList())
                                                              .get(0);

        List<MovieHasCategory> otherMovies = movieHasCategoryRepository
                .findByCategoryNameAndMovieIdNot(specificCategories, movie.getId());

        for (MovieHasCategory movieHasCategory: otherMovies) {
            movieRepository.findById(movieHasCategory.getMovieId()).ifPresent(other -> {
                double simScore = similarity.score(movie, other);
                rankings.put(other.getId(), simScore);
            });
        }

        return rankings.entrySet().stream()
                       .sorted(Map.Entry.<Integer, Double>comparingByValue().reversed())
                       .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue,
                                                 (oldValue, newValue) -> oldValue, LinkedHashMap::new));
    }
}
