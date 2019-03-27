all: spectrum.sof

spectrum.sof:
	quartus_sh --flow compile DE2_115_Synthesizer -c DE2_115_Synthesizer

clean:
	rm -Rvf db incremental_db simulation greybox_tmp
	rm -Rvf *.sof *.pof *.bak *.rpt *.jdi *.summary *.pin *.done *.qws *.smsg
	rm -Rvf PLLJ_PLLSPE_INFO.txt


