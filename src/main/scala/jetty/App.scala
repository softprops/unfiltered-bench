package jetty

import unfiltered.request._
import unfiltered.response._

import unfiltered.filter._

object App {
  lazy val server = unfiltered.jetty.Http(8080).filter(unfiltered.filter.Planify{
    case _ => ResponseString("Hello Netty")
  })
}