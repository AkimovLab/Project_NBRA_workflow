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
set linetype 16 dashtype (7,7,4,4,6,6) lc rgb '#800080'
set linetype 17 dashtype (7,7,4,4,6,6) lc rgb '#FF00FF'

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

set lmargin at screen 0.13
set rmargin at screen 0.94
set bmargin at screen 0.19
set tmargin at screen 0.96

unset xrange
unset yrange
set yrange [0:3.7]
set ytics 1
set xrange [80:1020]
set xtics 200

set output "_fig3a.png"
set xlabel "Temperature (K)" offset -0.5, 0.3
set ylabel "P_{1}/P_{0} Eq." offset  1.0, 0.0
set label "{/:Bold {/:Italic FSSH} }" front offset 5, 9
plot "model_1/dt_0.1fs/de_0.003/none_ida/_res_01_0.0.txt"         using ($1):3 w l lt 11 lw 10 t "Expected",\
     "model_1/dt_0.1fs/de_0.003/none_ida/_res_00_0.0.txt"         using ($1):2 w p ls 32 lw 20 t "All hops accepted",\
     "model_1/dt_0.1fs/de_0.003/none_ida/_res_01_0.0.txt"         using ($1):2 w p ls 33 lw 20 t "Boltzmann",\
     "model_1/dt_0.1fs/de_0.003/none_ida/_res_02_0.0.txt"         using ($1):2 w p ls 34 lw 20 t "Maxwell-Boltzmann",\
     "model_1/dt_0.1fs/de_0.003/none_ida/bastida/_res_00_0.0.txt" using ($1):3 w p ls 35 lw 20 t "Boltz-Corr Ehrenfest",\

set yrange [0:1.1]
set ytics 1
set output "_fig3b.png"
set xlabel "Temperature (K)" offset -0.5, 0.3
set ylabel "P_{1}/P_{0} Eq." offset  1.0, 0.0
unset label
set label "{/:Bold {/:Italic ID-A} }" front offset 5, 7
plot "model_1/dt_0.1fs/de_0.003/none_ida/_res_11_0.0.txt"         using ($1):3 w l lt 11 lw 10 t "",\
     "model_1/dt_0.1fs/de_0.003/none_ida/_res_10_0.0.txt"         using ($1):2 w p ls 32 lw 20 t "",\
     "model_1/dt_0.1fs/de_0.003/none_ida/_res_11_0.0.txt"         using ($1):2 w p ls 33 lw 20 t "",\
     "model_1/dt_0.1fs/de_0.003/none_ida/_res_12_0.0.txt"         using ($1):2 w p ls 34 lw 20 t "",\

set output "_fig3c.png"
set xlabel "Temperature (K)" offset -0.5, 0.3
set ylabel "P_{1}/P_{0} Eq." offset  1.0, 0.0
unset label
set label "{/:Bold {/:Italic mSDM 1 fs} }" front offset 5, 7
plot "model_1/dt_0.1fs/de_0.003/msdm_dish/1fs/_res_21_1.0.txt"    using ($1):3 w l lt 11 lw 10 t "",\
     "model_1/dt_0.1fs/de_0.003/msdm_dish/1fs/_res_20_1.0.txt"    using ($1):2 w p ls 32 lw 20 t "",\
     "model_1/dt_0.1fs/de_0.003/msdm_dish/1fs/_res_21_1.0.txt"    using ($1):2 w p ls 33 lw 20 t "",\
     "model_1/dt_0.1fs/de_0.003/msdm_dish/1fs/_res_22_1.0.txt"    using ($1):2 w p ls 34 lw 20 t "",\

set output "_fig3d.png"
set xlabel "Temperature (K)" offset -0.5, 0.3
set ylabel "P_{1}/P_{0} Eq." offset  1.0, 0.0
unset label
set label "{/:Bold {/:Italic mSDM 10 fs} }" front offset 5, 7
plot "model_1/dt_0.1fs/de_0.003/msdm_dish/10fs/_res_21_10.0.txt"  using ($1):3 w l lt 11 lw 10 t "",\
     "model_1/dt_0.1fs/de_0.003/msdm_dish/10fs/_res_20_10.0.txt"  using ($1):2 w p ls 32 lw 20 t "",\
     "model_1/dt_0.1fs/de_0.003/msdm_dish/10fs/_res_21_10.0.txt"  using ($1):2 w p ls 33 lw 20 t "",\
     "model_1/dt_0.1fs/de_0.003/msdm_dish/10fs/_res_22_10.0.txt"  using ($1):2 w p ls 34 lw 20 t "",\

set output "_fig3e.png"
set xlabel "Temperature (K)" offset -0.5, 0.3
set ylabel "P_{1}/P_{0} Eq." offset  1.0, 0.0
unset label
set label "{/:Bold {/:Italic mSDM 25 fs} }" front offset 5, 7
plot "model_1/dt_0.1fs/de_0.003/msdm_dish/25fs/_res_21_25.0.txt"  using ($1):3 w l lt 11 lw 10 t "",\
     "model_1/dt_0.1fs/de_0.003/msdm_dish/25fs/_res_20_25.0.txt"  using ($1):2 w p ls 32 lw 20 t "",\
     "model_1/dt_0.1fs/de_0.003/msdm_dish/25fs/_res_21_25.0.txt"  using ($1):2 w p ls 33 lw 20 t "",\
     "model_1/dt_0.1fs/de_0.003/msdm_dish/25fs/_res_22_25.0.txt"  using ($1):2 w p ls 34 lw 20 t "",\

set output "_fig3f.png"
set xlabel "Temperature (K)" offset -0.5, 0.3
set ylabel "P_{1}/P_{0} Eq." offset  1.0, 0.0
unset label
set label "{/:Bold {/:Italic DISH 1 fs} }" front offset 5, 7
plot "model_1/dt_0.1fs/de_0.003/msdm_dish/1fs/_res_31_1.0.txt"    using ($1):3 w l lt 11 lw 10 t "",\
     "model_1/dt_0.1fs/de_0.003/msdm_dish/1fs/_res_30_1.0.txt"    using ($1):2 w p ls 32 lw 20 t "",\
     "model_1/dt_0.1fs/de_0.003/msdm_dish/1fs/_res_31_1.0.txt"    using ($1):2 w p ls 33 lw 20 t "",\
     "model_1/dt_0.1fs/de_0.003/msdm_dish/1fs/_res_32_1.0.txt"    using ($1):2 w p ls 34 lw 20 t "",\

set output "_fig3g.png"                                                                             
set xlabel "Temperature (K)" offset -0.5, 0.3                                                       
set ylabel "P_{1}/P_{0} Eq." offset  1.0, 0.0                                                       
unset label                                                                                         
set label "{/:Bold {/:Italic DISH 10 fs} }" front offset 5, 7                                       
plot "model_1/dt_0.1fs/de_0.003/msdm_dish/10fs/_res_31_10.0.txt"  using ($1):3 w l lt 11 lw 10 t "",\
     "model_1/dt_0.1fs/de_0.003/msdm_dish/10fs/_res_30_10.0.txt"  using ($1):2 w p ls 32 lw 20 t "",\
     "model_1/dt_0.1fs/de_0.003/msdm_dish/10fs/_res_31_10.0.txt"  using ($1):2 w p ls 33 lw 20 t "",\
     "model_1/dt_0.1fs/de_0.003/msdm_dish/10fs/_res_32_10.0.txt"  using ($1):2 w p ls 34 lw 20 t "",\
                                                                                                    
set output "_fig3h.png"                                                                             
set xlabel "Temperature (K)" offset -0.5, 0.3                                                       
set ylabel "P_{1}/P_{0} Eq." offset  1.0, 0.0                                                       
unset label                                                                                         
set label "{/:Bold {/:Italic DISH 25 fs} }" front offset 5, 7                                       
plot  "model_1/dt_0.1fs/de_0.003/msdm_dish/25fs/_res_31_25.0.txt" using ($1):3 w l lt 11 lw 10 t "",\
      "model_1/dt_0.1fs/de_0.003/msdm_dish/25fs/_res_30_25.0.txt" using ($1):2 w p ls 32 lw 20 t "",\
      "model_1/dt_0.1fs/de_0.003/msdm_dish/25fs/_res_31_25.0.txt" using ($1):2 w p ls 33 lw 20 t "",\
      "model_1/dt_0.1fs/de_0.003/msdm_dish/25fs/_res_32_25.0.txt" using ($1):2 w p ls 34 lw 20 t "",\
