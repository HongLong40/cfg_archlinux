#!/bin/zsh

sensors | awk '
BEGIN {
    i = 0;
    tavg = 0;
    tmax = 0;
}   
/Core/ {
    ti = $3;
    gsub(/\+|°C/,"",ti);
    tavg += ti;
    if ( ti >= tmax ) { tmax = ti };
    i++;
}
END {
    tavg = tavg / i;
    printf("Avg: %.1f°C Max: %.1f°C\n" , tavg, tmax);
}
'

