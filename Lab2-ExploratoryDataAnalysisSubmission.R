# *****************************************************************************
# Lab 2: Exploratory Data Analysis ----
#
# Course Code: BBT4206
# Course Name: Business Intelligence II
# Semester Duration: 21st August 2023 to 28th November 2023
#
# Lecturer: Allan Omondi
# Contact: aomondi [at] strathmore.edu
#
# Note: The lecture contains both theory and practice. This file forms part of
#       the practice. It has required lab work submissions that are graded for
#       coursework marks.
#
# License: GNU GPL-3.0-or-later
# See LICENSE file for licensing information.
# *****************************************************************************

# STEP 1. Install and use renv ----
# **Initialization: Install and use renv ----
# The renv package helps you create reproducible environments for your R
# projects. This is helpful when working in teams because it makes your R
# projects more isolated, portable and reproducible.

# Further reading:
#   Summary: https://rstudio.github.io/renv/
#   More detailed article: https://rstudio.github.io/renv/articles/renv.html

# Install renv:
if (!is.element("renv", installed.packages()[, 1])) {
  install.packages("renv", dependencies = TRUE)
}
require("renv")

# Use renv::init() to initialize renv in a new or existing project.

# The prompt received after executing renv::init() is as shown below:
# This project already has a lockfile. What would you like to do?

# 1: Restore the project from the lockfile.
# 2: Discard the lockfile and re-initialize the project.
# 3: Activate the project without snapshotting or installing any packages.
# 4: Abort project initialization.

# Select option 1 to restore the project from the lockfile
renv::init()

# This will set up a project library, containing all the packages you are
# currently using. The packages (and all the metadata needed to reinstall
# them) are recorded into a lockfile, renv.lock, and a .Rprofile ensures that
# the library is used every time you open that project.

# This can also be configured using the RStudio GUI when you click the project
# file, e.g., "BBT4206-R.Rproj" in the case of this project. Then
# navigate to the "Environments" tab and select "Use renv with this project".

# As you continue to work on your project, you can install and upgrade
# packages, using either:
# install.packages() and update.packages or
# renv::install() and renv::update()

# You can also clean up a project by removing unused packages using the
# following command: renv::clean()

# After you have confirmed that your code works as expected, use
# renv::snapshot() to record the packages and their
# sources in the lockfile.

# Later, if you need to share your code with someone else or run your code on
# a new machine, your collaborator (or you) can call renv::restore() to
# reinstall the specific package versions recorded in the lockfile.

# Execute the following code to reinstall the specific package versions
# recorded in the lockfile:
renv::restore()

# One of the packages required to use R in VS Code is the "languageserver"
# package. It can be installed manually as follows if you are not using the
# renv::restore() command.
if (!is.element("languageserver", installed.packages()[, 1])) {
  install.packages("languageserver", dependencies = TRUE)
}
require("languageserver")

# Loading Datasets ----
## STEP 2: Download sample datasets ----
# Create a folder called "data" and store the following 2 files inside the
# "data" folder:
## Link 1 (save the file as "iris.data"):
# https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data
## Link 2 ("crop.data.csv"):
# https://cdn.scribbr.com/wp-content/uploads/2020/03/crop.data_.anova_.zip
# Extract the "crop.data.csv" file into the data folder

## STEP 3. Load the downloaded sample datasets ----
# Load the datasets


if (!is.element("readr", installed.packages()[, 1])) {
  install.packages("readr", dependencies = TRUE)
}
require("readr")

Student_dataset <- read_csv(
  "data/20230412-20230719-BI1-BBIT4-1-StudentPerformanceDataset - dataset.csv",
  col_types = cols(
    read_content_before_lecture = col_factor(levels = c("1", "2")),
    anticipate_test_questions = col_factor(levels = c("1", "2", "3", "4")),
    answer_rhetorical_questions = col_factor(levels = c("1", "2", "3")),
    find_terms_I_do_not_know = col_double()
  )
)
View(Student_dataset)

## STEP 4. Load sample datasets that are provided as part of a package ----
if (!is.element("mlbench", installed.packages()[, 1])) {
  install.packages("mlbench", dependencies = TRUE)
}
require("mlbench")



# Dimensions ----
## STEP 5. Preview the Loaded Datasets ----
# Dimensions refer to the number of observations (rows) and the number of
# attributes/variables/features (columns). Execute the following commands to
# display the dimensions of your datasets:


dim(Student_dataset)

# Data Types ----
## STEP 6. Identify the Data Types ----
# Knowing the data types will help you to identify the most appropriate
# visualization types and algorithms that can be applied. It can also help you
# to identify the need to convert from categorical data (factors) to integers
# or vice versa where necessary. Execute the following command to identify the
# data types:

sapply(Student_dataset, class)


# Descriptive Statistics ----

# You must first understand your data before you can use it to design
# prediction models and to make generalizable inferences. It is not until you
# take the time to truly understand your dataset that you can fully comprehend
# the context of the results you achieve. This understanding can be done using
# descriptive statistics such as:

# 1. Measures of frequency
# (e.g., count, percent)

# 2. Measures of central tendency
# (e.g., mean, median, mode)
# Further reading: https://www.scribbr.com/statistics/central-tendency/

# 3. Measures of distribution/dispersion/spread/scatter/variability
# (e.g., range, quartiles, interquartile range, standard deviation, variance,
# kurtosis, skewness)
# Further reading: https://www.scribbr.com/statistics/variability/
# Further reading:
#   https://digitaschools.com/descriptive-statistics-skewness-and-kurtosis/
# Further reading: https://www.scribbr.com/statistics/skewness/

# 4. Measures of relationship
# (e.g., covariance, correlation, ANOVA)

# Further reading: https://www.k2analytics.co.in/covariance-and-correlation/
# Further reading: https://www.scribbr.com/statistics/one-way-anova/
# Further reading: https://www.scribbr.com/statistics/two-way-anova/

# Understanding your data can lead to:
# (i)	  Data cleaning: Removing bad data or imputing missing data.
# (ii)	Data transformation: Reduce the skewness by applying the same function
#       to all the observations.
# (iii)	Data modelling: You may notice properties of the data such as
#       distributions or data types that suggest the use (or not) of
#       specific algorithms.

## Measures of Frequency ----

### STEP 7. Identify the number of instances that belong to each class. ----
# It is more sensible to count categorical variables (factors or dimensions)
# than numeric variables, e.g., counting the number of male and female
# participants instead of counting the frequency of each participant’s height.


Student_dataset_write_down_important_points_freq <- Student_dataset$write_down_important_points
cbind(frequency = table(Student_dataset_write_down_important_points_freq),
      percentage = prop.table(table(Student_dataset_write_down_important_points_freq)) * 100)

Student_dataset_take_quizzes_and_use_results_freq <- Student_dataset$take_quizzes_and_use_results
cbind(frequency = table(Student_dataset_take_quizzes_and_use_results_freq),
      percentage = prop.table(table(Student_dataset_take_quizzes_and_use_results_freq)) * 100)



## Measures of Central Tendency ----
### STEP 8. Calculate the mode ----
# Unfortunately, R does not have an in-built function for calculating the mode.
# We, therefore, must manually create a function that can calculate the mode.

## Measures of Distribution/Dispersion/Spread/Scatter/Variability ----



### STEP 10. Measure the standard deviation of each variable ----
# Measuring the variability in the dataset is important because the amount of
# variability determines how well you can generalize results from the sample
# dataset to a new observation in the population.

# Low variability is ideal because it means that you can better predict
# information about the population based on sample data. High variability means
# that the values are less consistent, thus making it harder to make
# predictions.

# The format “dataset[rows, columns]” can be used to specify the exact rows and
# columns to be considered. “dataset[, columns]” implies all rows will be
# considered. Specifying “BostonHousing[, -4]” implies all the columns except
# column number 4. This can also be stated as
# “BostonHousing[, c(1,2,3,5,6,7,8,9,10,11,12,13,14)]”. This allows us to
# calculate the standard deviation of only columns that are numeric, thus
# leaving out the columns termed as “factors” (categorical) or those that have
# a string data type.



sapply(Student_dataset[,12:14], sd)



### STEP 11. Measure the variance of each variable ----


### STEP 12. Measure the kurtosis of each variable ----
# The Kurtosis informs you of how often outliers occur in the results.

# There are different formulas for calculating kurtosis.
# Specifying “type = 2” allows us to use the 2nd formula which is the same
# kurtosis formula used in SPSS and SAS. More details about any function can be
# obtained by searching the R help knowledge base. The knowledge base says:

# In “type = 2” (used in SPSS and SAS):
# 1.	Kurtosis < 3 implies a low number of outliers
# 2.	Kurtosis = 3 implies a medium number of outliers
# 3.	Kurtosis > 3 implies a high number of outliers

if (!is.element("e1071", installed.packages()[, 1])) {
  install.packages("e1071", dependencies = TRUE)
}
require("e1071")



### STEP 13. Measure the skewness of each variable ----

# The skewness informs you of the asymmetry of the distribution of results.
# Similar to kurtosis, there are several ways of computing the skewness.
# Using “type = 2” can be interpreted as:

# 1.	Skewness between -0.4 and 0.4 (inclusive) implies that there is no skew
# in the distribution of results; the distribution of results is symmetrical;
# it is a normal distribution.
# 2.	Skewness above 0.4 implies a positive skew; a right-skewed distribution.
# 3.	Skewness below -0.4 implies a negative skew; a left-skewed distribution.


sapply(Student_dataset[, 12:14],  skewness, type = 2)

