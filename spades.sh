#!/bin/bash

CPUS="$1"
SAMPLE="$2"

spades.py -1 ${SAMPLE}_R1.fastq.gz \
	-2 ${SAMPLE}_R2.fastq.gz \
	-o ${SAMPLE}_spades_output \
	--meta \
	-t ${CPUS} \
	-m 600

# Zip the output folder:
tar -cvzf ${SAMPLE}_spades_output.tar.gz ${SAMPLE}_spades_output

echo "Done."
