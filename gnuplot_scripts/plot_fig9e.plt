#
set terminal pngcairo font "arial,28" size 800, 600 enhanced rounded truecolor

# color definitions
set style line 11 lc rgb '#8b1a0e' pt 1 ps 1 lt 1 lw 5 # --- red
set style line 12 lc rgb '#FF0000' pt 1 ps 1 lt 1 lw 5 # --- bright red
set style line 13 lc rgb '#FF4500' pt 6 ps 1 lt 1 lw 5 # --- orangered
set style line 14 lc rgb '#B22222' pt 6 ps 1 lt 1 lw 5 # --- firebrick
set style line 15 lc rgb '#DC143C' pt 6 ps 1 lt 1 lw 5 # --- crimson
set style line 16 lc rgb '#FF7000' pt 6 ps 1 lt 1 lw 5 # --- dark orange

set style line 21 lc rgb '#5e9c36' pt 6 ps 1 lt 1 lw 5 # --- green
set style line 22 lc rgb '#006400' pt 6 ps 1 lt 1 lw 5 # --- darkgreen
set style line 23 lc rgb '#228B22' pt 6 ps 1 lt 1 lw 5 # --- forestgreen
set style line 24 lc rgb '#808000' pt 6 ps 1 lt 1 lw 5 # --- olive
set style line 25 lc rgb '#00FF10' pt 6 ps 1 lt 1 lw 5 # --- lime
set style line 26 lc rgb '#20B2AA' pt 6 ps 1 lt 1 lw 5 # --- light sea green

set style line 31 lc rgb '#8A2BE2' pt 6 ps 1 lt 1 lw 5 # --- blueviolet
set style line 32 lc rgb '#000E8B' pt 6 ps 1 lt 1 lw 5 # --- royalblue
set style line 33 lc rgb '#00008B' pt 6 ps 1 lt 1 lw 5 # --- darkblue
set style line 34 lc rgb '#800080' pt 6 ps 1 lt 1 lw 5 # --- purple

set style line 41 lc rgb '#2F4F4F' pt 6 ps 1 lt 1 lw 5 # --- darkslategray
set style line 42 lc rgb '#C0C0C0' pt 6 ps 1 lt 1 lw 5 # --- silver
set style line 43 lc rgb '#D2691E' pt 6 ps 1 lt 1 lw 5 # --- chocolate
set style line 44 lc rgb '#DCDCDC' pt 6 ps 1 lt 1 lw 5 # --- gainsboro

set linetype 1 lc rgb '#000000' 
set linetype 2 lc rgb '#000E8B'
set linetype 3 lc rgb '#8b1a0e'
set linetype 4 lc rgb '#006400'
set linetype 5 lc rgb '#800080' 
set linetype 6 lc rgb '#008080'
set linetype 7 lc rgb '#FF4500'
set linetype 8 lc rgb '#2F4F4F'

set linetype 11 dashtype (7,7,4,4,6,6) lc rgb '#000000' 
set linetype 12 dashtype (7,7,4,4,6,6) lc rgb '#000E8B'
set linetype 13 dashtype (7,7,4,4,6,6) lc rgb '#8b1a0e'
set linetype 14 dashtype (7,7,4,4,6,6) lc rgb '#006400'
set linetype 15 dashtype (7,7,4,4,6,6) lc rgb '#FF7000'
set linetype 16 dashtype (7,7,4,4,6,6) lc rgb '#00FF10'
set linetype 17 dashtype (7,7,4,4,6,6) lc rgb '#F055F0'

set style line 21 lc rgb '#000000' pt 5 
set style line 22 lc rgb '#000E8B' pt 5
set style line 23 lc rgb '#8b1a0e' pt 5
set style line 24 lc rgb '#006400' pt 5
set style line 25 lc rgb '#FF7000' pt 5

set style line 31 lc rgb '#000000' pt 7 
set style line 32 lc rgb '#000E8B' pt 7
set style line 33 lc rgb '#8b1a0e' pt 7
set style line 34 lc rgb '#006400' pt 7
set style line 35 lc rgb '#FF7000' pt 7

set style line 41 lc rgb '#000000' pt 9 
set style line 42 lc rgb '#000E8B' pt 9
set style line 43 lc rgb '#8b1a0e' pt 9
set style line 44 lc rgb '#006400' pt 9
set style line 45 lc rgb '#FF7000' pt 9

set border 31 lw 8
set key font ",28"
set key opaque


set lmargin at screen 0.15
set rmargin at screen 0.94
set bmargin at screen 0.19
set tmargin at screen 0.96


set output "_fig9e.png"
set multiplot
# remove border and ytics from right hand side
set border 7
set ytics nomirror
# set top and bottom margins for both halves of the plot
set tmargin at screen 0.96
set bmargin at screen 0.19
# set left and right margins for left half of the plot
set lmargin at screen 0.12
set rmargin at screen 0.45
# set xrange for left half of the plot
set xrange[0:400]
set yrange[0:1]
set xtics 300
set ytics 1
set label "{/:Bold {/:Italic mSDM 25 fs}}" at 250, 0.825
# set some lines to delimit transition from one half of the plot to next: These are based on t,b,l,r margins.
set arrow from screen 0.45,0.17 to screen 0.46,0.21 nohead lw 8
set arrow from screen 0.48,0.17 to screen 0.49,0.21 nohead lw 8
set arrow from screen 0.45,0.94 to screen 0.46,0.98 nohead lw 8
set arrow from screen 0.48,0.94 to screen 0.49,0.98 nohead lw 8
# plot left half
set ylabel "State Populations" offset 1.3, 0.0
plot "model_3/msdm_dish/25_50/_tmp21_25.0.txt" using ($1/41.34137):($10) w l lt 2 lw 8 t "",\
     "model_3/msdm_dish/25_50/_tmp21_25.0.txt" using ($1/41.34137):($7)  w l lt 3 lw 8 t "",\
     "model_3/msdm_dish/25_50/_tmp21_25.0.txt" using ($1/41.34137):($4)  w l lt 4 lw 8 t "",\
     "model_3/msdm_dish/25_50/_out_2_1_300.0_25.0.txt" using ($1/41.34137):8  w l lt 12 lw 8 t "",\
     "model_3/msdm_dish/25_50/_out_2_1_300.0_25.0.txt" using ($1/41.34137):7  w l lt 13 lw 8 t "",\
     "model_3/msdm_dish/25_50/_out_2_1_300.0_25.0.txt" using ($1/41.34137):6  w l lt 14 lw 8 t "",\
# remove border from left hand side and set ytics on the right
set border 13
unset label
unset ytics
unset ylabel
# set xrange for right half of the plot
set xrange[1500:2500]
set xtics 500
# set left and right margins for right half of the 
set lmargin at screen 0.49
set rmargin at screen 0.90
# set xlabel
set xlabel "Time (fs)" offset -7.5, 0.3
plot "model_3/msdm_dish/25_50/_tmp21_25.0.txt" using ($1/41.34137):($10) w l lt 2 lw 8 t "",\
     "model_3/msdm_dish/25_50/_tmp21_25.0.txt" using ($1/41.34137):($7)  w l lt 3 lw 8 t "",\
     "model_3/msdm_dish/25_50/_tmp21_25.0.txt" using ($1/41.34137):($4)  w l lt 4 lw 8 t "",\
     "model_3/msdm_dish/25_50/_out_2_1_300.0_25.0.txt" using ($1/41.34137):8  w l lt 12 lw 8 t "",\
     "model_3/msdm_dish/25_50/_out_2_1_300.0_25.0.txt" using ($1/41.34137):7  w l lt 13 lw 8 t "",\
     "model_3/msdm_dish/25_50/_out_2_1_300.0_25.0.txt" using ($1/41.34137):6  w l lt 14 lw 8 t "",\
