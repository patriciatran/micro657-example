#!/bin/bash

# Example Spades command that I would run (if not doing this demo in class)
spades.py -1 SampleA_R1.fastq.gz \
	-2 SampleA_R2.fastq.gz \
	-o SampleA_spades_output \
	--meta \
	-t 16 \
	-m 600

# Zip the output folder:
tar cvzf SampleA_spades_output.tar.gz SampleA_spades_output

echo "Pretending to run Spades on SampleA"

echo "Done."
