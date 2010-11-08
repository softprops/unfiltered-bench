import sbt._
class Project(info: ProjectInfo) extends DefaultProject(info) {
  val uf_version = "0.2.2"
  // jetty
  val uff = "net.databinder" %% "unfiltered-filter" % uf_version
  val ufj = "net.databinder" %% "unfiltered-jetty" % uf_version
  
  // netty
  val ufn = "net.databinder" %% "unfiltered-netty" % uf_version
  
  // netty dependencies
  lazy val jboss = "JBoss repository" at 
     "http://repository.jboss.org/maven2"
}