#export PLAYDATE_SDK_PATH=/media/jm/external/software/games/playdate/PlaydateSDK-2.0.0
#export PATH=$PATH:/media/jm/external/software/games/playdate/PlaydateSDK-2.0.0/bin(base)
outputdir=whiskers.pdx
projectname=whiskers

.PHONY: all clean simulate

clean:
	if [ -d $(outputdir) ]; then \
		rm -rf $(outputdir); \
	fi \


all:
	pdc -k . $(outputdir)

simulate:
	PlaydateSimulator $(outputdir)