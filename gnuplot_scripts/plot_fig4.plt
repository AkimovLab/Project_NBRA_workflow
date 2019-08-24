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
set linetype 15 dashtype (7,7,4,4,6,6) lc rgb '#800080'
set linetype 16 dashtype (7,7,4,4,6,6) lc rgb '#008080'
set linetype 17 dashtype (7,7,4,4,6,6) lc rgb '#FF4500'
set linetype 17 dashtype (7,7,4,4,6,6) lc rgb '#2F4F4F'

set style line 21 lc rgb '#000000' pt 5 
set style line 22 lc rgb '#000E8B' pt 5
set style line 23 lc rgb '#8b1a0e' pt 5
set style line 24 lc rgb '#006400' pt 5
set style line 25 lc rgb '#800080' pt 5
set style line 26 lc rgb '#008080' pt 5
set style line 27 lc rgb '#FF4500' pt 5
set style line 28 lc rgb '#2F4F4F' pt 5

set style line 31 lc rgb '#000000' pt 7 
set style line 32 lc rgb '#000E8B' pt 7
set style line 33 lc rgb '#8b1a0e' pt 7
set style line 34 lc rgb '#006400' pt 7
set style line 35 lc rgb '#800080' pt 7
set style line 36 lc rgb '#008080' pt 7
set style line 37 lc rgb '#FF4500' pt 7
set style line 38 lc rgb '#2F4F4F' pt 7

set style line 41 lc rgb '#000000' pt 9 
set style line 42 lc rgb '#000E8B' pt 9
set style line 43 lc rgb '#8b1a0e' pt 9
set style line 44 lc rgb '#006400' pt 9
set style line 45 lc rgb '#800080' pt 9
set style line 46 lc rgb '#008080' pt 9
set style line 47 lc rgb '#FF4500' pt 9
set style line 48 lc rgb '#2F4F4F' pt 9

set border 31 lw 8
set key font ",27"
set key opaque

set lmargin at screen 0.12
set rmargin at screen 0.94
set bmargin at screen 0.19
set tmargin at screen 0.96

unset xrange
unset yrange
set yrange [0:1.5]
set ytics 1
set xrange [0:500]
set xtics 250

set output "_fig4a.png"
set xlabel "Time (fs)" offset 0.0,  0.6
set ylabel "State 1 Population"     offset 1.4,  0.0
unset label
set label "{/:Bold {/:Italic mSDM} }" front offset 7, 9
plot "model_1/de_0.01/msdm_dish/25fs/V01_0.003/_tmp_21_300.0_25.0.txt" using ($1/41.34137):7 w l lt 2 lw 8 t "25 fs",\
     "model_1/de_0.01/msdm_dish/10fs/V01_0.003/_tmp_21_300.0_10.0.txt" using ($1/41.34137):7 w l lt 3 lw 8 t "10 fs",\
     "model_1/de_0.01/msdm_dish/1fs/V01_0.003/_tmp_21_300.0_1.0.txt"   using ($1/41.34137):7 w l lt 4 lw 8 t "1 fs",\
     "model_1/de_0.01/none_ida/V01_0.003/_out_0_1_300.0_0.0.txt"       using ($1/41.34137):($5) w l lt 15 lw 8 t "",\

set output "_fig4b.png"
set xlabel "Time (fs)" offset 0.0,  0.6
set ylabel "State 1 Population"     offset 1.4,  0.0
unset label
set label "{/:Bold {/:Italic DISH} }" front offset 20, 9
plot "model_1/de_0.01/msdm_dish/25fs/V01_0.003/_tmp_31_300.0_25.0.txt" using ($1/41.34137):7 w l lt 2 lw 8 t "",\
     "model_1/de_0.01/msdm_dish/10fs/V01_0.003/_tmp_31_300.0_10.0.txt" using ($1/41.34137):7 w l lt 3 lw 8 t "",\
     "model_1/de_0.01/msdm_dish/1fs/V01_0.003/_tmp_31_300.0_1.0.txt"   using ($1/41.34137):7 w l lt 4 lw 8 t "",\
     "model_1/de_0.01/none_ida/V01_0.003/_out_0_1_300.0_0.0.txt"       using ($1/41.34137):($5) w l lt 15 lw 8 t "",\
