# output format
set terminal canvas

set output "out.html"

# graph title
set title "ab -n 8000 -c 100"

# nicer aspect ratio for image size
set size 1,0.7

# y-axis grid
set grid y

set xlabel "request"

set ylabel "response time (ms)"

plot "jetty.dat" using 9 smooth sbezier with lines title "unfiltered jetty", "netty.dat" using 9 smooth sbezier with lines title "unfiltered netty"