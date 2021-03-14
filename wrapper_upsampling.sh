#! /bin/sh

### ASDP PIPELINE ###
## Licence: AGPLv3
## Author: Anne-Sophie Denommé-Pichon
## Description: a wrapper for FASTQ upsampling
## Usage: qsub -pe smp 1 -v INPUTFILE=<path to the FASTQ file>,OUTPUTFILE=<output file>,UPSAMPLING_RATE=<percentage of reads to add to theFASTQ file>,READ_ID=<header of the read to add>,[LOGFILE=<path to the log file>] wrapper_upsampling.sh

# Log file path option
if [ -z "$LOGFILE" ]
then
    LOGFILE=downsampling.$(date +"%F_%H-%M-%S").log
fi

# Logging
exec 1>> "$LOGFILE" 2>&1
echo "$(date +"%F_%H-%M-%S"): START"

# Check if input file exists
if [ ! -f "$INPUTFILE" ]
then
    echo "Input file '$INPUTFILE' does not exist"
    echo "$(date +"%F_%H-%M-%S"): END"
    exit 1
fi

# Check if output prefix is specified
if [ -z "$OUTPUTFILE" ]
then
    echo "Outputfile is not specified"
    echo "$(date +"%F_%H-%M-%S"): END"
    exit 1
fi

# Check if upsampling rate is specified
if [ -z "$UPSAMPLING_RATE" ]
then
    echo "Upsampling rate is not specified"
    echo "$(date +"%F_%H-%M-%S"): END"
    exit 1
fi

# Check if read ID is specified
if [ -z "$READ_ID" ]
then
    echo "Read ID is not specified"
    echo "$(date +"%F_%H-%M-%S"): END"
    exit 1
fi

# Launch script command and check exit code
/user1/gad/an1770de/Scripts/upsampling/fastq_upsampling.py "$UPSAMPLING_RATE" "$READ_ID" < "$INPUTFILE" > "$OUTPUTFILE"

upsampling_exitcode=$?

echo "upsampling exit code : $upsampling_exitcode"
if [ $upsampling_exitcode != 0 ]
then
    echo "$(date +"%F_%H-%M-%S"): END"
    exit 1
fi

echo "$(date +"%F_%H-%M-%S"): END"
