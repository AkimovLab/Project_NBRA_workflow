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

set lmargin at screen 0.12
set rmargin at screen 0.9
set bmargin at screen 0.19
set tmargin at screen 0.96

unset xrange
unset yrange
set yrange [0:1.5]
set ytics 1
set xrange [0:200]
set xtics 100

set output "_fig9a.png"
set xlabel "Time (fs)"         offset 0.0,  0.4
set ylabel "State Populations" offset 1.5,  0.0
set label "{/:Bold {/:Italic FSSH} }" at 15, 1.25
plot "model_3/none_ida/_tmp01_0.0.txt"         using ($1/41.34137):($10) w l lt 2 lw 8 t "State 2",\
     "model_3/none_ida/_tmp01_0.0.txt"         using ($1/41.34137):($7)  w l lt 3 lw 8 t "State 1",\
     "model_3/none_ida/_tmp01_0.0.txt"         using ($1/41.34137):($4)  w l lt 4 lw 8 t "State 0",\
     "model_3/none_ida/_out_0_1_300.0_0.0.txt" using ($1/41.34137):($8)  w l lt 12 lw 8 t "",\
     "model_3/none_ida/_out_0_1_300.0_0.0.txt" using ($1/41.34137):($7)  w l lt 13 lw 8 t "",\
     "model_3/none_ida/_out_0_1_300.0_0.0.txt" using ($1/41.34137):($6)  w l lt 14 lw 8 t "",\

set output "_fig9b.png"
set xlabel "Time (fs)"         offset 0.0,  0.4
set ylabel "State Populations" offset 1.5,  0.0
set label "{/:Bold {/:Italic ID-A} }" at 45, 0.83
plot "model_3/none_ida/_tmp11_0.0.txt"         using ($1/41.34137):($10) w l lt 2 lw 8 t "",\
     "model_3/none_ida/_tmp11_0.0.txt"         using ($1/41.34137):($7)  w l lt 3 lw 8 t "",\
     "model_3/none_ida/_tmp11_0.0.txt"         using ($1/41.34137):($4)  w l lt 4 lw 8 t "",\
     "model_3/none_ida/_out_1_1_300.0_0.0.txt" using ($1/41.34137):($8)  w l lt 12 lw 8 t "",\
     "model_3/none_ida/_out_1_1_300.0_0.0.txt" using ($1/41.34137):($7)  w l lt 13 lw 8 t "",\
     "model_3/none_ida/_out_1_1_300.0_0.0.txt" using ($1/41.34137):($6)  w l lt 14 lw 8 t "",\

unset xrange
unset yrange
set yrange [0:1]
set ytics 1
set xrange [0:200]
set xtics 100

set output "_fig9c.png"
set xlabel "Time (fs)"         offset 0.0,  0.4
set ylabel "State Populations" offset 1.7,  0.0
set label "{/:Bold {/:Italic Boltz-corrected Ehrenfest} }" at 35, 0.83
plot "model_3/bastida/none/_tmp00_0.0.txt"         using ($1/41.34137):9 w l lt 2 lw 8 t "",\
     "model_3/bastida/none/_tmp00_0.0.txt"         using ($1/41.34137):6 w l lt 3 lw 8 t "",\
     "model_3/bastida/none/_tmp00_0.0.txt"         using ($1/41.34137):3 w l lt 4 lw 8 t "",\
     "model_3/bastida/none/_out_0_0_300.0_0.0.txt" using ($1/41.34137):8 w l lt 12 lw 8 t "",\
     "model_3/bastida/none/_out_0_0_300.0_0.0.txt" using ($1/41.34137):7 w l lt 13 lw 8 t "",\
     "model_3/bastida/none/_out_0_0_300.0_0.0.txt" using ($1/41.34137):6 w l lt 14 lw 8 t "",\

