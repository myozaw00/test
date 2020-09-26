package com.myozawoo.moviedb.feature.movie.details

import com.hannesdorfmann.mosby3.mvi.MviBasePresenter
import com.myozawoo.interactor.MovieDetailInteractor
import com.myozawoo.viewstate.MovieDetailViewState

class MovieDetailPresenter (private val interactor: MovieDetailInteractor)
    :MviBasePresenter<MovieDetailView, MovieDetailViewState>() {

    override fun bindIntents() {
        val detailIntent = intent(MovieDetailView::movieDetailIntent)
            .flatMap { interactor.executeMovieDetail(it) }

        subscribeViewState(detailIntent, MovieDetailView::render)
    }
}