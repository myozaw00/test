package com.myozawoo.moviedb.feature.movie.details

import android.app.Dialog
import android.content.ActivityNotFoundException
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.view.View
import android.widget.Toast
import androidx.coordinatorlayout.widget.CoordinatorLayout
import com.bumptech.glide.Glide
import com.google.android.material.bottomsheet.BottomSheetBehavior
import com.google.android.material.bottomsheet.BottomSheetDialogFragment
import com.hannesdorfmann.mosby3.FragmentMviDelegate
import com.hannesdorfmann.mosby3.MviDelegateCallback
import com.myozawoo.exception.ApiException
import com.myozawoo.exception.NetworkException
import com.myozawoo.interactor.MovieDetailInteractor
import com.myozawoo.moviedb.R
import com.myozawoo.moviedb.feature.base.mvi.FragmentXMviDelegateImpl
import com.myozawoo.viewstate.MovieDetailViewState
import io.reactivex.Observable
import io.reactivex.subjects.PublishSubject
import kotlinx.android.synthetic.main.dialog_fragment_movie_details.*
import kotlinx.android.synthetic.main.item_movie_trailer.view.*
import org.koin.android.ext.android.inject

class MovieDetailDialogFragment(private val movieId: Int) : BottomSheetDialogFragment(),
    MviDelegateCallback<MovieDetailView, MovieDetailPresenter>,
    MovieDetailView {

    private val delegate: FragmentMviDelegate<MovieDetailView, MovieDetailPresenter> =
        FragmentXMviDelegateImpl<MovieDetailView, MovieDetailPresenter>(this, this)
    private val mPresenter: MovieDetailPresenter by inject()
    private val movieDetailRelay = PublishSubject.create<MovieDetailInteractor.MovieDetailIntent>()
    private var mYoutubeId: String? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        delegate.onCreate(savedInstanceState)
    }

    override fun setupDialog(dialog: Dialog, style: Int) {
        super.setupDialog(dialog, style)
        val view = View.inflate(context, R.layout.dialog_fragment_movie_details, null)
        dialog.setContentView(view)
        val params = (view.parent as View).layoutParams as CoordinatorLayout.LayoutParams
        val behavior = params.behavior
        if (behavior != null && behavior is BottomSheetBehavior) {
            behavior.setBottomSheetCallback(mBottomSheetBehaviorCallback)
        }

    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        delegate.onViewCreated(view, savedInstanceState)
    }

    private fun setup() {
        dialog?.ivPlay?.setOnClickListener {
            mYoutubeId?.let {
                watchYoutubeVideo(requireContext(), it)
            }
        }

        dialog?.ivClose?.setOnClickListener {
            dialog?.dismiss()
        }
    }

    override fun onStart() {
        super.onStart()
        delegate.onStart()
        movieDetailRelay.onNext(MovieDetailInteractor.MovieDetailIntent(movieId))
        setup()
    }

    override fun onAttach(context: Context) {
        super.onAttach(context)
        delegate.onAttach(context)
    }

    override fun onStop() {
        super.onStop()
        delegate.onStop()
    }

    override fun onResume() {
        super.onResume()
        delegate.onResume()
    }

    override fun onPause() {
        super.onPause()
        delegate.onPause()
    }

    override fun onDestroy() {
        super.onDestroy()
        delegate.onDestroy()
    }

    override fun setRestoringViewState(restoringViewState: Boolean) {

    }

    override fun createPresenter(): MovieDetailPresenter {
        return mPresenter
    }

    override fun getMvpView(): MovieDetailView {
        return this
    }

    override fun render(viewState: MovieDetailViewState) {
        when(viewState) {
            is MovieDetailViewState.Error -> renderError(viewState)
            is MovieDetailViewState.Progress -> renderProgress()
            is MovieDetailViewState.MovieInfo -> renderMovieInfo(viewState)
        }
    }

    private fun renderMovieInfo(viewState: MovieDetailViewState.MovieInfo) {
        dismissProgress()
        dialog?.tvTitle?.text = viewState.details.title

        if (viewState.details.hasAdultWarning) {
            dialog?.tvAdultWarning?.visibility = View.VISIBLE
        }

        dialog?.tvYear?.text = viewState.details.releaseYear

        dialog?.tvOverview?.text = viewState.details.overview

        Glide.with(requireContext())
            .load(viewState.details.coverPhoto)
            .into(dialog?.ivPoster!!)

        dialog?.tvDuration?.text = viewState.details.duration
        mYoutubeId = viewState.details.youtubeId

    }

    private fun renderProgress() {
        dialog?.ivPlay?.visibility = View.GONE
        dialog?.progress?.visibility = View.VISIBLE
    }

    private fun dismissProgress() {
        dialog?.ivPlay?.visibility = View.VISIBLE
        dialog?.progress?.visibility = View.GONE
    }


    private fun renderError(viewState: MovieDetailViewState.Error) {
        dismissProgress()
        when(viewState.t) {
            is NetworkException -> showToast("Network Error!")
            is ApiException -> showToast((viewState.t as ApiException).errorMessage)
            else -> viewState.t.printStackTrace()
        }
    }

    override fun movieDetailIntent(): Observable<MovieDetailInteractor.MovieDetailIntent> {
        return movieDetailRelay
    }



    private val mBottomSheetBehaviorCallback = object : BottomSheetBehavior.BottomSheetCallback() {
        override fun onSlide(bottomSheet: View, slideOffset: Float) {

        }

        override fun onStateChanged(bottomSheet: View, newState: Int) {
            if (newState == BottomSheetBehavior.STATE_HIDDEN) {
                dismiss()
            }
        }
    }

    private fun watchYoutubeVideo(context: Context, id: String) {
        val appIntent = Intent(Intent.ACTION_VIEW, Uri.parse("vnd.youtube:$id"))
        val webIntent = Intent(
            Intent.ACTION_VIEW,
            Uri.parse("http://www.youtube.com/watch?v=$id")
        )
        try {
            context.startActivity(appIntent)
        } catch (ex: ActivityNotFoundException) {
            context.startActivity(webIntent)
        }

    }

    private fun showToast(message: String) {
        if (message != "") Toast.makeText(activity, message, Toast.LENGTH_SHORT).show()
    }
}