package com.github.jewertow

import io.ktor.application.call
import io.ktor.http.HttpStatusCode
import io.ktor.request.receive
import io.ktor.response.respond
import io.ktor.response.respondRedirect
import io.ktor.routing.post
import io.ktor.routing.routing
import io.ktor.server.engine.embeddedServer
import io.ktor.server.netty.Netty
import org.slf4j.LoggerFactory
import java.util.concurrent.atomic.AtomicLong

class App {
    val logger = LoggerFactory.getLogger(this.javaClass.simpleName)!!
}

fun main(args: Array<String>) {
    val logger = App().logger
    val counter = AtomicLong()
    embeddedServer(Netty, 8099) {
        logger.info("Server is running...")
        routing {
            post("/200") {
                val requestBody = call.receive<String>()
                logger.info("Received {}. request at /200. Message: {}", counter.incrementAndGet(), requestBody)
                call.respond(HttpStatusCode.OK, "")
            }
            post("/300") {
                val requestBody = call.receive<String>()
                logger.info("Received {}. request at /300. Message: {}", counter.incrementAndGet(), requestBody)
                call.respondRedirect("http://subscriber:8099/new-location", permanent = true)
            }
            post("/400") {
                val requestBody = call.receive<String>()
                logger.info("Received {}. request at /400. Message: {}", counter.incrementAndGet(), requestBody)
                call.respond(HttpStatusCode.BadRequest, "")
            }
            post("/500") {
                val requestBody = call.receive<String>()
                logger.info("Received {}. request at /500. Message: {}", counter.incrementAndGet(), requestBody)
                call.respond(HttpStatusCode.InternalServerError, "")
            }
            post("/new-location") {
                val requestBody = call.receive<String>()
                logger.info("Received {}. request at /new-location. Message: {}", counter.incrementAndGet(), requestBody)
                call.respond(HttpStatusCode.OK, "")
            }
        }
    }.start(wait = true)
}
