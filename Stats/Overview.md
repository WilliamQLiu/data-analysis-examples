#Overview

## Background
Welcome!  This is a short onboarding course for new data analysts.  I'll cover the basics of data preparation, data analysis, data visualization, and machine learning.  No other knowledge is necessary other than a very minimum familiarity with Excel.

* __Data Preparation__
    - Extraction
    - Transformation
    - Loading
* __Data Analysis__
    - Descriptive Statistics
    - Inferential Statistics
* __Data Visualization__
    - Types of Charts
    - R's ggplot
    - Python's matplotlib
    - D3.js
* __Machine Learning__
    - Numpy
    - Scipy
    - Scikit-Learn
 
## Data Analysis

### Variables
Data is made up of variables.  Variables can have any value (like a category or number).  `y = 10` says that the variable '_y_' has the value of '_10_'.  There are two types of variables:

* __Independent Variable__ - the outcome; the variable's value does not depend on any other variable (e.g. _Has Lung Cancer_, _Test Score_)
* __Dependent Variable__ - the predictor(s); the variable(s) that we think are an effect because the value depends on the independent variables (e.g. _Cigarettes Per Day_, _Time Spent Studying_)
* __Example__: '_Time Spent Studying_' causes a change in '_Test Score_'.  '_Test Score_' can't cause a change in '_Time Spent Studying_'.  '_Test Score_' (independent variable) depends on '_Time Spent Studying_' (dependent variable)

### Levels of Measurement
Different levels of measurement are used to categorize and quantify variables.  Variables can be categorized '_categorical_' or '_continuous_' as well as quantified at different levels, each with more useful/detailed measurements.

* __Categorical (aka Qualitative)__ - Deals with unmeasurables/can't do arithmetic with it (e.g. '_species_' could have values of '_human_', '_cat_', or '_dog_').  Your choices are discrete (as in you can be a human or a cat, but not both).  Categoricals are further categorized as:
    - __Dichotomous (aka Binary)__ - Two distinct possibilities (e.g. pregnant or not pregnant)
    - __Nominal__ - Two or more possibilities (e.g. human, cat, dog) 
    - __Ordinal__ - Two or more possibilities and there is a logical order (e.g. first, second).  You know which is bigger or smaller, but not by how much (e.g. you know who won race, but not how close race was)
* __Continuous (aka Quantitative)__ - Deals with numbers (e.g. '_length_', '_age_').  Continuous are further categorized as:
    - __Interval__ - Two or more possibilities, there is a logical order that you can measure (i.e. numbers that you can do arithmetic with), and there are equal intervals (e.g. Fahrenheit measurement of 40 to 50 degrees is the same difference as 50 to 60 degrees)
    - __Ratio__ - Two or more possibilites, there is a logical order that you can measure, there are equal intervals, and there is a true zero point (e.g. the weight of an object cannot weigh less than 0) 

### Validity and Reliability
* __Measurement Error__ - the discrepancy between the numbers we use to represent the thing we're measuring and the actual value of measuring it directly (e.g. I measure my height with a ruler, but might be off a bit)
* __Validity__ - whether an instrument actually measures what it sets out to measure (e.g. does a scale actually measure my weight?)
* __Reliability__ - whether an instrument can be interpreted consistently across different situations.  The easiest method is through _test-retest reliability_, which tests the same group of people twice (e.g. if I weighed myself within minutes of each other, would I get the same result?)
* __Criterion Validity__ - measure of how well one variable or set of variables predicts an outcome based on information from other variables
* __Concurrent Validity__ - 
* __Predictive Validity__ - 
* __Content Validity__ - 