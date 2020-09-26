package com.myozawoo.moviedb.feature.movie.details

import com.hannesdorfmann.mosby3.mvp.MvpView
import com.myozawoo.interactor.MovieDetailInteractor
import com.myozawoo.viewstate.MovieDetailViewState
import io.reactivex.Observable

interface MovieDetailView : MvpView {

    fun render(viewState: MovieDetailViewState)

    fun movieDetailIntent(): Observable<MovieDetailInteractor.MovieDetailIntent>
}