object Main {
  def main(args: Array[String]) {
    (args match {
      case Array("netty") => netty.App.server
      case Array("jetty") => jetty.App.server
    }).run
  }
}