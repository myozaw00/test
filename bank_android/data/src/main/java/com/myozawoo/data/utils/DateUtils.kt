package com.myozawoo.data.utils

import java.text.SimpleDateFormat
import java.util.*

class DateUtils{

    fun convertDate(value: String): String{
        if (value == "") return ""
        val sdf = SimpleDateFormat("yyyy-MM-dd", Locale.getDefault())
        val date = sdf.parse(value)
        return SimpleDateFormat("dd MMM yyyy", Locale.getDefault()).format(date).toString()
    }

    fun convertYear(value: String): String{
        if (value == "") return ""
        val sdf = SimpleDateFormat("yyyy-MM-dd", Locale.getDefault())
        val date = sdf.parse(value)
        return SimpleDateFormat("yyyy", Locale.getDefault()).format(date).toString()
    }

}