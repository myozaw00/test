package com.myozawoo.data.mapper

import com.myozawoo.data.database.entity.MovieTrailerEntity
import com.myozawoo.data.model.response.MovieDetailsResponse
import com.myozawoo.data.model.response.MovieInfoResponse
import com.myozawoo.data.model.response.MovieTrailerResponse
import com.myozawoo.data.utils.DateUtils
import com.myozawoo.model.movie.MovieDetails
import com.myozawoo.model.movie.MovieInfo
import com.myozawoo.model.movie.MovieTrailer

class MovieMapper(private val dateUtils: DateUtils){

    fun mapMovieInfoList(list: List<MovieInfoResponse>): List<MovieInfo>{
        val movies = arrayListOf<MovieInfo>()
        list.forEach {
            val movieInfo = MovieInfo(it.vote_count,
                it.id,
                it.video,
                it.vote_average,
                it.title,
                it.popularity,
                "https://image.tmdb.org/t/p/w500${it.poster_path}",
                it.original_language,
                it.original_title,
                it.genre_ids,
                "https://image.tmdb.org/t/p/w500${it.backdrop_path}",
                it.adult,
                it.overview,
                dateUtils.convertDate(it.release_date))
            movies.add(movieInfo)
        }
        return movies
    }


    fun mapMovieTrailerList(entities: List<MovieTrailerEntity>): List<MovieTrailer>{
        val list = arrayListOf<MovieTrailer>()
        entities.forEach {
            list.add(MovieTrailer(it.movieId,it.title, it.overview, it.youtubeId, dateUtils.convertDate(it.releaseDate), "https://image.tmdb.org/t/p/w500${it.poster}", "https://image.tmdb.org/t/p/original${it.poster}"))
        }
        return list
    }

    fun mapMovieDetails(trailer: MovieTrailerResponse, detail: MovieDetailsResponse): MovieDetails {
        var key = ""
        for (result in trailer.results) {
            if (result.site == "YouTube" && result.type == "Trailer") {
                key = result.key
            }
        }
        return MovieDetails(
            title = detail.original_title ?: "Unknown Title",
            movieId = detail.id ?: 0,
            coverPhoto = "https://image.tmdb.org/t/p/w500${detail.backdrop_path}",
            language = detail.original_language ?: "Unknown Language",
            overview = detail.overview ?: "Error at loading overview.",
            releaseYear = dateUtils.convertYear(detail.release_date ?: ""),
            youtubeId = key,
            hasAdultWarning = detail.adult ?: false,
            duration = "${detail.runtime} minutes"
        )
    }
}