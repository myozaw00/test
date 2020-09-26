package com.myozawoo.data.model.response

data class MovieDetailsResponse(
    val status_code: Int?,
    val status_message: String?,
    val adult: Boolean?,
    val backdrop_path: String?,
    val budget: Int?,
    val genres: List<Genres>?,
    val homePage: String?,
    val id: Int?,
    val original_language: String?,
    val original_title: String?,
    val overview: String?,
    val poster_path: String?,
    val release_date: String?,
    val runtime: Int?,
    val title:String?

    ) {

    data class Genres(
        val id: Int?,
        val name: String?
    )
}