## GETTING AND CLEANING DATA COURSE PROJECT

### ASSIGNMENT SUBMITTED BY LEONARDO MACHADO FOR COURSERA



### Description of the files in this repository:

This repository contains the following files:

1. **run_analysis.R** - R script file containing the script developed to process the dataset into a tidy dataset. Script steps are shown below

2. **completeDataset.txt** - text file containing the final result of the project

3. **summarizedDataset.txt** - text file containing the summarized result of the project. The mean of each variable is calculated by *SubjectId* and *ActivityDescription*

4. **codeBook.txt** - text file containing the info about the varliables include in the files above

5. **README.md** - R Markdown file - this file



### Description of the steps executed by the script

The following steps are executed in the script:

1. Loads measurements - FEATURES

2. Chooses measurements related to MEAN and STANDARD DEVIATION

3. Turns measurements labels into DESCRIPTIVE ones

4. Loads ACTIVITIES labels

5. Loads and merges TRAIN and TEST datasets - measurements, activities and subjects

6. Creates complete dataset

7. Creates summarized dataset using reshape2

