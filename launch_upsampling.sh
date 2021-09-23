#! /bin/sh

### ASDP PIPELINE ###
## Licence: AGPLV3
## Author: Anne-Sophie Denommé-Pichon
## Description: script to launch the wrapper to upsample data

READ_ID="@V1:1:HKFJ7DSXX:1:2165:25825:9236/2"
#READ_ID="@HISEQ2:C88CYACXX:7:1213:21186:56408"
INPUTFILE="/work/gad/shared/analyse/STR/Data/upsampling/dijen402.R2.newread.fastq"
SAMPLE="$(basename -s .fastq "$INPUTFILE")"
OUTPUTDIR="/work/gad/shared/analyse/STR/Data/upsampling"
COMPUTE_QUEUE="batch"
LOGDIR="$OUTPUTDIR"

for rate in 10 20 30 40 50 100 200 300 400 500 1000
do
    qsub -pe smp 1 -o "$LOGDIR" -e "$LOGDIR" -q "$COMPUTE_QUEUE" \
	-v INPUTFILE="$INPUTFILE",OUTPUTFILE="$OUTPUTDIR/$SAMPLE.upsampling_$rate.fastq",UPSAMPLING_RATE="$rate",READ_ID="$READ_ID",LOGFILE="$LOGDIR/upsampling_$SAMPLE_$rate.$(date +"%F_%H-%M-%S").log" "$(dirname "$0")/wrapper_upsampling.sh"
done
