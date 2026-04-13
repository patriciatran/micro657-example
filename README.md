# Example scripts

Example datasets:
https://www.ncbi.nlm.nih.gov/taxonomy/1322345

Go to Related Information > SRA > Filter for FASTQ, Paired-End.
Copy and paste the run number (e.g. ERR2653804) to this website: https://www.ncbi.nlm.nih.gov/Traces/index.html?view=run_browser
Go to Data Access, Scroll down to Original Format, and get the URLS.

# Submit one job

## Getting the test datasets

```
git clone [this link]
cd micr657-example
mkdir reads
wget http://ftp.sra.ebi.ac.uk/vol1/run/ERR265/ERR2653804/6763_Ch2_D20_CL_1.fastq.gz
wget http://ftp.sra.ebi.ac.uk/vol1/run/ERR265/ERR2653804/6763_Ch2_D20_CL_2.fastq.gz
mv 6763_Ch2_D20_CL_1.fastq.gz ERR2653804_R1.fastq.gz
mv 6763_Ch2_D20_CL_2.fastq.gz ERR2653804_R2.fastq.gz

cd ..
```

## Submit the job
```
condor_submit spades_one_sample.sh
```

Check the status of the job using:
```
condor_q
condor_watch_q
```

Check for issues using : `condor_q -hold`

# Submitting multiple jobs

## Get more data

```
cd reads
# Data 2
wget http://ftp.sra.ebi.ac.uk/vol1/run/ERR265/ERR2653803/6762_Ch1_D20_CL_1.fastq.gz
wget http://ftp.sra.ebi.ac.uk/vol1/run/ERR265/ERR2653803/6762_Ch1_D20_CL_2.fastq.gz
mv 6762_Ch1_D20_CL_1.fastq.gz ERR2653803_R1.fastq.gz
mv 6762_Ch1_D20_CL_2.fastq.gz ERR2653803_R2.fastq.gz

# Data 3
wget http://ftp.sra.ebi.ac.uk/vol1/run/ERR265/ERR2653802/6761_Ch3_D14_CL_1.fastq.gz
wget  http://ftp.sra.ebi.ac.uk/vol1/run/ERR265/ERR2653802/6761_Ch3_D14_CL_2.fastq.gz
mv 6761_Ch3_D14_CL_1.fastq.gz ERR2653802_R1.fastq.gz
mv 6761_Ch3_D14_CL_2.fastq.gz ERR2653802_R2.fastq.gz

#Data 4
wget http://ftp.sra.ebi.ac.uk/vol1/run/ERR265/ERR2653801/6760_Ch2_D14_4C_1.fastq.gz
wget http://ftp.sra.ebi.ac.uk/vol1/run/ERR265/ERR2653801/6760_Ch2_D14_4C_2.fastq.gz
mv 6760_Ch2_D14_4C_1.fastq.gz ERR2653801_R1.fastq.gz
mv 6760_Ch2_D14_4C_2.fastq.gz ERR2653801_R2.fastq.gz
```

# Run on multiple jobs
To convert a single script into something that can be reused multiple times, we need to:
1 - not hardcode the samples within the .sh script
Ideally, we do not need to modify anything in the .sh script for future runs
2 - Define variables in the .submit file for 



