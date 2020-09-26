package com.myozawoo.interactor

import com.myozawoo.domain.MovieRepository
import com.myozawoo.executor.BackgroundThread
import com.myozawoo.executor.PostExecutionThread
import com.myozawoo.viewstate.MovieDetailViewState
import io.reactivex.Observable

class MovieDetailInteractor(private val movieRepository: MovieRepository,
                            private val mainThread: PostExecutionThread,
                            private val backgroundThread: BackgroundThread){

    fun executeMovieDetail(intent: MovieDetailIntent): Observable<MovieDetailViewState>{
        return movieRepository.getMovieDetails(intent.movieId)
            .map { MovieDetailViewState.MovieInfo(it) }
            .cast(MovieDetailViewState::class.java)
            .onErrorReturn { MovieDetailViewState.Error(it) }
            .startWith(MovieDetailViewState.Progress)
            .subscribeOn(backgroundThread.getScheduler())
            .observeOn(mainThread.getScheduler())
    }


    data class MovieDetailIntent(val movieId: Int)

}