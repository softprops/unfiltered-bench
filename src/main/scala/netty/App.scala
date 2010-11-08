package netty

import unfiltered.request._
import unfiltered.response._

import unfiltered.filter._

object App {
  // unfiltered.netty.cycle.Plan
  var server = unfiltered.netty.Http(8080).handler(unfiltered.netty.cycle.Planify { 
    case _ => ResponseString("Hello Netty")
  })
}