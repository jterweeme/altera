all: spectrum.sof

spectrum.sof:
	quartus_sh --flow compile seg1 -c ask2ca

clean:
	rm -Rvf db incremental_db simulation greybox_tmp output_files
	rm -Rvf *.sof *.pof *.bak *.rpt *.jdi *.summary *.pin *.done *.qws *.smsg
	rm -Rvf PLLJ_PLLSPE_INFO.txt


