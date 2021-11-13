#!/bin/awk -f

# Calculate average and max core temperature. Input for the script comes from the sensors program
# Sample row:
#       Core 0:        +42.0°C  (high = +100.0°C, crit = +100.0°C)


BEGIN { i = 0; tavg = 0; tmax = 0 }   
/Core/ {
    ti = $3;
    gsub(/\+|°C/,"",ti);
    tavg += ti;
    i++;
    if ( ti >= tmax ) { tmax = ti };
}
END {
    tavg = tavg / i;
    printf("Avg: %.1f°C Max: %.1f°C\n" , tavg, tmax);
}

