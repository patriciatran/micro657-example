# Example scripts

These scripts demonstrates some of the concepts during the guest lecture on high throughput computing for microbiologists, as part of micro657 at UW-Madison, presented by Dr. Patricia Tran.

A link to the slides is available here: https://go.wisc.edu/43mku5 [netID login required]

# Repository contents:

There are 3 pairs (`.sh` and `.sub`) of scripts in this repository:

1 - **simple_batch** : 
- Demonstrates how HTCondor can submit multiple (hundreds!) of jobs at the same time. 
- Learning how to use the queue statement and the `condor_watch_q` commands to keep track of job. 
- Starting to recognize some of the variables (such as `$(Process)` or `$(Cluster)` to better understand jobs)

Moving on, the next two examples build upon the concept of submitting multiple jobs, this time, using a more appropriate bioinformatics analysis scenario. In this case, a user wants to assembly paired-end Illumina reads obtained from four distinct E. coli samples. 


2 - **spades_one_sample** : 
- example of how to run a bioinformatics analysis on the cluster. 
- Introduces the concept of container images (`container_image`) and pulling from container repository. 
- Also introduces more complex executable scripts (`.sh`) file that includes pre-job completion steps (e.g. `tar` on the output folder for correctly exporting files)

3 - **spades** : 
- an extension of the spades_one_sample example, but now on multiple samples. 
- Students can compare the 2 scripts to identify differences. 
- Introduces the concept of using variables and using them in the `arguments` line of the submit file.

# Set up

While I will not demonstrate these scripts live in class, if you'd like to do this after, you will need to create a CHTC account and log into the server.

- Request an account: https://chtc.cs.wisc.edu/uw-research-computing/form.html
- How to login: https://chtc.cs.wisc.edu/uw-research-computing/connecting

To reproduce the analysis in the video first, log into your account:
Your login information will be sent by email upon account creation.

```
ssh netid@address
#enter your password
pwd
# you will now be in /home/netid
```

Obtain a copy of the scripts from this github repository
```
git clone https://github.com/patriciatran/micro657-example.git
cd micro657-example
pwd
ls
```

# Simple batch jobs

(This is the code used in video from the slides)

The first script `simple_batch.sub` does not need any input data. You can submit it and track its status by typing:

```
condor_submit simple_batch.sub
condor_watch_q
```

> [!NOTE]
> the `$(Cluster)` and `$(Process)` variables are automatically generated when you submit your job. When you type condor_q, the numbers in the `JOBS_IDS` column refer to the Cluster.Process number.
> Using Variables in your .log, .err and .out file names ensure that output files are unique.
> Note that paths are relative to the location of your submit file. 

# Biological tasks

# Submit one job

## Getting the test datasets

For this example, you will need input data. 

The input reads are Escherichia coli ATCC 25922 strain and the example datasets is here:
https://www.ncbi.nlm.nih.gov/taxonomy/1322345

Go to Related Information > SRA > Filter for FASTQ, Paired-End.
Copy and paste the run number (e.g. ERR2653804) to this website: https://www.ncbi.nlm.nih.gov/Traces/index.html?view=run_browser
Go to Data Access, Scroll down to Original Format, and get the URLS.

Instead of downloading the files directly to your computer laptop, you can download them directly to your server /home/netid folder:

```
cd ~/micro657
mkdir reads
cd reads
wget http://ftp.sra.ebi.ac.uk/vol1/run/ERR265/ERR2653804/6763_Ch2_D20_CL_1.fastq.gz
wget http://ftp.sra.ebi.ac.uk/vol1/run/ERR265/ERR2653804/6763_Ch2_D20_CL_2.fastq.gz
mv 6763_Ch2_D20_CL_1.fastq.gz ERR2653804_R1.fastq.gz
mv 6763_Ch2_D20_CL_2.fastq.gz ERR2653804_R2.fastq.gz
cd ..
# you should now be back in the folder that contains the .sh and .sub files
```

## Submit the job

```
condor_submit spades_one_sample.sh
```
> [!NOTE]
> Take a look at the contents of spades_one_sample.sub. A new addition to the submit file is the line `container_image=`. 
> This links to a path: docker://staphb/spades:4.2.0, which corresponds to a publicly available, trusted, container image published on DockerHub. the format is docker://username/package:version 
> You can search for packages online and call them directly in your submit file.
> Another new line is the transfer_input_files line. This is necessary, on this system, because the worker node does not have access to the files in your /home/ folder, unless you specifically "import" them into the job.


Check the status of the job using:
```
condor_q
condor_watch_q
```

Check for issues using : `condor_q -hold`

# Submitting multiple jobs

## Get more data

We will now download more reads data for the next example, which consists of running the assembly multiple times by submitting a batch of jobs.

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

cd ..
```

# Run on multiple jobs

Once again, you can submit by typing:
```
condor_submit spades.sub
```

> [!NOTE]
> To generalize a script and scale up your work, you can modify the line that begins with "queue". The format is `queue variable from list`. Each item in the list will be a distinct job. As such, you can use the variable anywhere in the submit file. In this example, the variable is `$(sample)`, and it is used in the `transfer_input_files=` line.



