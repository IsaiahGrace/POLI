************************************************************************
* auCdl Netlist:
* 
* Library Name:  Poly
* Top Cell Name: dig_poly_XOR_BUF2_x1
* View Name:     schematic
* Netlisted on:  Oct 14 15:22:38 2019
************************************************************************

.PARAM
*.SCALE METER

*.GLOBAL vss!:G
+        vdd!:P
+        wafer!:P

*.PIN vss!
*+    vdd!
*+    wafer!

************************************************************************
* Library Name: Poly
* Cell Name:    polymorphic_XOR_BUFF_v2_2
* View Name:    schematic
************************************************************************

.SUBCKT polymorphic_XOR_BUFF_v2_2 A B Vx Vy X inh_wafer
*.PININFO A:I B:I Vx:I Vy:I X:O inh_wafer:B
MM45 Vy A net016 inh_wafer psoi1 m=1 l=90n w=200n nf=1
MM41 net042 net016 X inh_wafer psoi1 m=1 l=90n w=200n nf=1
MM40 Vy Vx net042 inh_wafer psoi1 m=1 l=90n w=200n nf=1
MM46 Vx Vy net010 inh_wafer psoi1 m=1 l=90n w=200n nf=1
MM29 net06 net031 X inh_wafer psoi1 m=1 l=90n w=200n nf=1
MM33 Vx Vy net044 inh_wafer psoi1 m=1 l=90n w=200n nf=1
MM7 net31 B net031 inh_wafer psoi1 m=1 l=90n w=200n nf=1
MM6 net044 A net31 inh_wafer psoi1 m=1 l=90n w=200n nf=1
MM1 net010 B net06 inh_wafer psoi1 m=1 l=90n w=200n nf=1
MM0 net010 A net06 inh_wafer psoi1 m=1 l=90n w=200n nf=1
MM44 Vx A net016 inh_wafer nsoi1 m=1 l=90n w=200n nf=1
MM43 Vx Vy net040 inh_wafer nsoi1 m=1 l=90n w=200n nf=1
MM42 net040 net016 X inh_wafer nsoi1 m=1 l=90n w=200n nf=1
MM27 net032 B net047 inh_wafer nsoi1 m=1 l=90n w=200n nf=1
MM28 net047 A X inh_wafer nsoi1 m=1 l=90n w=200n nf=1
MM32 net032 net031 X inh_wafer nsoi1 m=1 l=90n w=200n nf=1
MM30 net02 A net031 inh_wafer nsoi1 m=1 l=90n w=200n nf=1
MM34 Vy Vx net02 inh_wafer nsoi1 m=1 l=90n w=200n nf=1
MM31 net02 B net031 inh_wafer nsoi1 m=1 l=90n w=200n nf=1
MM35 Vy Vx net032 inh_wafer nsoi1 m=1 l=90n w=200n nf=1
.ENDS

************************************************************************
* Library Name: MITLL90_STDLIB_8T
* Cell Name:    inv_4x
* View Name:    schematic
************************************************************************

.SUBCKT inv_4x A X inh_vdd inh_vss inh_wafer
*.PININFO A:I X:O inh_vdd:B inh_vss:B inh_wafer:B
MM2 inh_vdd A X inh_wafer psoi1 m=1 l=90n w=3.8u nf=4
MM0 inh_vss A X inh_wafer nsoi1 m=1 l=90n w=2.36u nf=4
.ENDS

************************************************************************
* Library Name: Poly
* Cell Name:    dig_poly_XOR_BUF2_x1
* View Name:    schematic
************************************************************************

.SUBCKT dig_poly_XOR_BUF2_x1 A B X orient
*.PININFO A:I B:I orient:I X:O
XI0 A B net11 net9 X wafer! / polymorphic_XOR_BUFF_v2_2
XI2 net9 net11 vdd! vss! wafer! / inv_4x
XI1 orient net9 vdd! vss! wafer! / inv_4x
.ENDS

