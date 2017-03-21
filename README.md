<h3>lgwr-trace-parse</h3>

This script creates A simple histogram of Oracle lgwr write times as found in lgwr trace files.

Anytime a lgwr takes > 500ms an entry is made to the lgwr tracefile.

<pre>
~/oracle/lgwr-trace-parse $ ./lgwr_histogram.pl msgprod*_lgwr*.trc
     500         3
    1000       852
    2000      1383
    3000       663
    4000       378
    5000       229
    6000       204
    7000        91
    8000        71
    9000        60
   10000        57
   11000        63
   12000        54
   13000        42
   14000        40
   15000        50
   16000        45
   20000       192
   30000       971
   40000        41
   50000        20
  100000        21
  150000         1
  160000         0
  170000         0
  180000         0
  190000         1
</pre>


