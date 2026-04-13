#!/bin/bash

spades.py -1 ERR2653804_R1.fastq.gz \
	-2 ERR2653804_R2.fastq.gz \
	-o ERR2653804_spades_output \
	--meta \
	-t $1 \
	-m 600

# Zip the output folder:
tar -cvzf ERR2653804_spades_output.tar.gz ERR2653804_spades_output

echo "Done."
