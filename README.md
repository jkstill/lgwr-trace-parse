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


Here's an example where the data is sent to <a href="https://github.com/jkstill/Histogram">data-histogram.pl</a>

<pre>


grep 'Warning: log write elapsed time' msgprod1_lgwr_*.trc | awk '{ print $6 }'| sed -e 's/ms,$//'| data-histogram.pl --bucket-count 30 --line-length 50 --lower-limit-op '>=' --lower-limit-val 500 --upper-limit-op '<=' --upper-limit-val 25000
       816:  11.8%  *******************
      1632:  29.6%  **************************************************
      2448:  11.9%  ********************
      3264:  12.1%  ********************
      4080:   4.0%  ******
      4896:   3.9%  ******
      5712:   3.5%  *****
      6528:   2.6%  ****
      7344:   1.2%  **
      8160:   1.2%  **
      8976:   0.9%  *
      9792:   1.0%  *
     10608:   1.1%  *
     11424:   0.8%  *
     12240:   1.1%  *
     13056:   0.7%  *
     13872:   0.7%  *
     14688:   0.8%  *
     15504:   0.9%  *
     16320:   0.8%  *
     17136:   0.8%  *
     17952:   0.6%  *
     18768:   0.8%  *
     19584:   0.9%  *
     20400:   1.1%  *
     21216:   1.8%  ***
     22032:   0.8%  *
     22848:   0.6%
     23664:   0.9%  *
     24480:   0.7%  *
     25296:   0.6%  *


</pre>
