package com.example.plugins

import io.ktor.routing.*
import io.ktor.http.*
import io.ktor.application.*
import io.ktor.response.*
import io.ktor.request.*
import io.ktor.client.*
import io.ktor.client.engine.cio.*
import io.ktor.client.features.*
import io.ktor.client.request.*
import io.ktor.client.response.*
import io.ktor.client.statement.*
import io.ktor.html.*
import io.ktor.routing.head
import kotlinx.html.*

fun Application.configureRouting() {

    // Starting point for a Ktor app:
    routing {
        get("/") {


            //val client = HttpClient(CIO)
            //val httpResponse: HttpStatement = client.request("https://api.thecatapi.com/v1/images/search")
            //val byteArrayBody: ByteArray = httpResponse.receive()

            //data class Cat(val url: String)

            //val response = client.get("https://api.thecatapi.com/v1/images/search")

            val client = HttpClient()
            val url = "https://api.thecatapi.com/v1/images/search"
            val response: HttpStatement = client.get(url)
            val text: String = response.execute().readText().split('"')[9]


            call.respondHtml(HttpStatusCode.OK){
                head {
                    title { +"CEGLÉD BOI$$$$" }
                }
                body {

                    img(src = text) {
                    }

            }

        }
    }
    routing {
    }
}



}
