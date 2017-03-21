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

 grep 'Warning: log write elapsed time' msgprod1_lgwr_*.trc | awk '{ print $6 }'| sed -e 's/ms,$//'| data-histogram.pl --bucket-count 30 --line-length 50 --lower-limit-op '>=' --lower-limit-val 1000 --upper-limit-op '<=' --upper-limit-val 25000
      1598:  26.5%  **************************************************
      2397:  15.6%  *****************************
      3196:  14.5%  ***************************
      3995:   5.4%  **********
      4794:   4.7%  ********
      5593:   4.1%  *******
      6392:   3.5%  ******
      7191:   1.6%  **
      7990:   1.4%  **
      8789:   1.3%  **
      9588:   1.2%  **
     10387:   1.1%  **
     11186:   1.2%  **
     11985:   1.3%  **
     12784:   0.9%  *
     13583:   0.8%  *
     14382:   0.9%  *
     15181:   0.9%  *
     15980:   1.0%  *
     16779:   1.0%  *
     17578:   0.7%  *
     18377:   1.0%  *
     19176:   0.9%  *
     19975:   1.3%  **
     20774:   2.3%  ****
     21573:   1.1%  **
     22372:   0.7%  *
     23171:   0.9%  *
     23970:   1.1%  **
     24769:   0.6%  *
     25568:   0.5%


</pre>
