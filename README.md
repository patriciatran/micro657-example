# Example scripts

These scripts demonstrates some of the concepts during the guest lecture on high throughput computing for microbiologists, as part of micro657 at UW-Madison, presented by Dr. Patricia Tran.

A link to the slides is available here: [link TBD]

There are 3 pairs of scripts in this repository:
1 - simple_batch : demonstrates how HTCondor can submit multiple (hundreds!) of jobs at the same time. Learning how to use the queue statement and the `condor_watch_q` commands to keep track of job. Starting to recognize some of the variables (such as $(process) or $(cluster) to better understand jobs)

2 - spades_one_sample : example of how to run a bioinformatics analysis on the cluster. Introduces the concept of container images (`container_image`) and pulling from container repository. Also introduces more complex executable scripts (`.sh`) file that includes pre-job completion steps (e.g. `tar` on the output folder for correctly exporting files)

3 - spades : an extension of the spades_one_sample example, but now on multiple samples. Students can compare the 2 scripts to identify differences. Introduces the concept of using variables and using them in the `arguments` line of the submit file.

# Set up
While I will not demonstrate these scripts live in class, if you'd like to do this after, you will need to create a CHTC account and log into the server.

Then, get a copy of the scripts:
```
cd /home/yournetID
git clone https://github.com/patriciatran/micro657-example.git
cd micro657-example
```

# Simple batch jobs

```
condor_submit simple_batch.sub
condor_watch_q
```

Explaination: tbd

# Biological tasks

# Submit one job

## Getting the test datasets

For this example, I selected some reads associated with the Escherichia coli ATCC 25922 strain.

Example datasets:
https://www.ncbi.nlm.nih.gov/taxonomy/1322345

Go to Related Information > SRA > Filter for FASTQ, Paired-End.
Copy and paste the run number (e.g. ERR2653804) to this website: https://www.ncbi.nlm.nih.gov/Traces/index.html?view=run_browser
Go to Data Access, Scroll down to Original Format, and get the URLS.

If you'd like to use these scripts as is, the examples I used are:

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



