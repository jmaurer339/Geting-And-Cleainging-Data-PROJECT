The data output from the run_analysis script are derivative of the raw data obtained though motion experiments from the following source.


Human Activity Recognition Using Smartphones Data Set
Source:Jorge L. Reyes-Ortiz(1,2), Davide Anguita(1), Alessandro Ghio(1), Luca Oneto(1) and Xavier Parra(2)
1 - Smartlab - Non-Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova, Genoa (I-16145), Italy. 
2 - CETpD - Technical Research Centre for Dependency Care and Autonomous Living
Universitat Politècnica de Catalunya (BarcelonaTech). Vilanova i la Geltrú (08800), Spain
activityrecognition '@' smartlab.ws 
Detailed description of the data collection experiments can be found at: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

From the data source web site:  “The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. “


Run_analysis reads data on the collection of 10,299 instances of collecting motion data from 30 subjects. In each instance raw 561 measurements were collected derived. Complete data on 9 of the subjects were stored in test data sets. Complete data on the other 21 subjects were stored in the training data. 

*The R script does the following:
*Combines data from both training and test data
*Adds meta data information on activities and metrics
*Selects a subset of 82 metrics from the raw data (means and standard deviations)
*Calculates means, by subject and activity for each of these 82 metrics 
* outputs those data in a text files titled FDtidydata.txt

The 82 summary metrics in FDtidydata are sorted by subject and activity

