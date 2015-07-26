# Geting-And-Cleainging-Data-PROJECT
Files for Coursera MOC on Getting and Cleaning Data Using R

This repo contains the following files necessary for the Getting and Cleaning Data Coursera/John Hopkins final project:

Readme.md (this file)
Codebook.md (a codebook describing the final output dataset)
run_analysis.R  (an R script that creates the final output dataset from raw data files)

Before you execute run_analysis you will need to download the zipped data and extract the raw data files. The raw data files can be found here:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Having downloaded and extracted the data files, all data will reside in a folder titled “UCI HAR Dataset”. This folder can be located anywhere on your local hard drive. By default the script run_analysis will assume that this folder and all of the raw data within that folder reside in the current R working director. If the “UCI HAR Dataset” folder exists in some other directory, for purposes of this script the working directory may be changed by using the setwd() command on line 9 (about) in the run_analysis script. Since the script assumes that the data folder resides in the working directory, the setwd() function call is currently commented out with a hash (#).
