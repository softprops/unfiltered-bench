# unfiltered bench

some scripts and sample servers for benchmarking unfiltered servers

# setup

update deps

    sbt update

install tooling

via [homebrew](https://github.com/mxcl/homebrew)

    sudo brew install -v gnuplot

# usage

run netty server on port 8080

    sbt "run netty"

run ab test on netty

    ab -n 8000 -c 100 -g netty.dat http://127.0.0.1:8080/

shutdown netty

run jetty server on port 8080

    sbt "run jetty"

run ab test on jetty

    ab -n 8000 -c 100 -g jetty.dat http://127.0.0.1:8080/

generate the ab graph `out.png`

    gnuplot ./scripts/ab_plot.p

2010 Doug Tangren (softprops)