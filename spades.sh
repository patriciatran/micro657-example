#!/bin/bash

# The number $1, $2, corresponds to the positional arguments in the submit file
SAMPLE="$1"
CPU="$2"

# Example Spades command that I would run (if not doing this demo in class)
#spades.py -1 ${SAMPLE}_R1.fastq.gz \
#	-2 ${SAMPLE}_R2.fastq.gz \
#	-o ${SAMPLE}_spades_output \
#	--meta \
#	-t ${CPU} \
#	-m 600

# Zip the output folder:
# tar cvzf ${SAMPLE}_spades_output.tar.gz ${SAMPLE}_spades_output

echo "Pretending to run Spades on ${SAMPLE}"

echo "Done."
