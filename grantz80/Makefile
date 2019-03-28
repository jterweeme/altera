all: spectrum.sof

spectrum.sof:
	quartus_sh --flow compile microcomputer -c de2_115

download:
	quartus_pgm de2_115.cdf

clean:
	rm -Rvf db incremental_db simulation greybox_tmp
	rm -Rvf *.sof *.pof *.bak *.rpt *.jdi *.summary *.pin *.done *.qws *.smsg
	rm -Rvf PLLJ_PLLSPE_INFO.txt


