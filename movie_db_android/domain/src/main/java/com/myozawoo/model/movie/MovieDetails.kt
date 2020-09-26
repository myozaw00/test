package com.myozawoo.model.movie

data class MovieDetails(
    val title: String,
    val coverPhoto: String,
    val movieId: Int,
    val language: String,
    val overview: String,
    val releaseYear: String,
    val youtubeId: String,
    val hasAdultWarning: Boolean,
    val duration: String
    )