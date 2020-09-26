package com.myozawoo.viewstate

import com.myozawoo.model.movie.MovieDetails

sealed class MovieDetailViewState {

    class Error(val t: Throwable): MovieDetailViewState()

    object Progress: MovieDetailViewState()

    class MovieInfo(val details: MovieDetails): MovieDetailViewState()
}