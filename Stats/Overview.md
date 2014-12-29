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
 

## Data Analysis - What to Measure


### Variables
Data is made up of variables.  Variables can have any value (like a category or number).  `y = 10` says that the variable '_y_' has the value of '_10_'.  There are two types of variables:

* __N__ - _N_ is the size of the sample and _n_ represents a subsample (e.g. number of cases within a particular group)
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


### Reliability
* __Measurement Error__ - the discrepancy between the numbers we use to represent the thing we're measuring and the actual value of measuring it directly (e.g. I measure my height with a ruler, but might be off a bit)
* __Reliability__ - whether an instrument can be interpreted consistently across different situations.  The easiest method is through _test-retest reliability_, which tests the same group of people twice (e.g. if I weighed myself within minutes of each other, would I get the same result?)
* __Counterbalancing__ - order in which a person participates in an experiment may affect their behavior.  Counterbalancing fixes this; say there are two possible conditions (A and B), subjects are divided into two groups with Group 1 (A then B), Group 2 (B then A)
* __Randomization__ - randomly allocates experimental units across groups; reduces confounding by dispersing at chance levels (hopefully roughly evenly)


### Validity
Validity is whether an instrument actually measures what it sets out to measure (e.g. does a scale actually measure my weight?).  Validity is usually divided into three forms including _Criterion_, _Content_, and _Construct_.

* __Criterion Validity__ - looks at the correlation between one set of variable(s) predicts an outcome based on information from another set of criterion variable(s).  e.g. IQ tests are often validated against measures of academic performance (the criterion).  Criterion Validity can be either _concurrent_ or _predictive_:
    - __Concurrent Validity__ - assess the ability to distinguish between groups (e.g. check if an AP exam can substitute taking a college course; all students take AP exam and college course, check if there is a strong correlation between exam scores and college course grade)
    - __Predictive Validity__ - assess the ability to predict observations at a later point in time (e.g. how well does SAT test predict academic success?  Determine usefulness by correlating SAT scores to first-year student's GPA)
    - _Note_: Difficult because objective criteria that can be measured easily may not exist
* __Content Validity (aka Logical Validity)__ - a non-statistical type of validity that assesses the degree to which individual items represent the construct being measured (e.g. test of the ability to add two numbers should include adding a combination of digits including odd, even and not multiplying)
    - __Face Validity__ - an estimate of whether a test appears to measure a certain criterion
    - __Representation Validity (aka Translation Validity)__ - the extent to which an abstract theoretical construct can be turned into a specific practical test
* __Construct Validity__ - a construct is an abstraction (attribute, ability or skill) created to conceptualize a latent variable.  (e.g. someone's English proficency is a construct).  Construct Validity is whether your test measures the construct adequately  (e.g. how well does your test measure someone's English proficiency).  In order to have _construct validity_, you need both _convergent_ and _discriminant_ validity.
    -  __Convergent Validity__ - the degree to which two measures of constructs that should be related, are in fact related (e.g. if a construct of general happiness had convergent validity, then it should correlate to a similar construct, say of marital satisfaction)
    -  __Discriminant Validity__ - the degree to which two measures of constructs that should be unrelated, are in fact unrelated (e.g. if a construct of general happiness had discriminant validity, then it should correlate to an unrelated construct, say of depression)

## Data Analysis - How data is collected

### Types of Research Methods
We're interested in _correlation_ as well as _causality_ (cause and effect).
To test a hypothesis, we can do the following

* __Observational/Correlational Research__ - observe what naturally goes on without directly interfering.  Correlation suggests a relationship between two variables, but cannot prove that one caused another.  Correlation does not equal causation.
    - __Cross-sectional Study__ - a snapshot of many different variables at a single point in time (e.g. measure cholesterol levels of daily walkers across two age groups, but can't consider past or future cholestral levels of snapshot)
    - __Longitudinal Study__ - measure variables repeatedly at different time points (e.g. we might measure workers' job satisfaction under different managers)
    - __Limitations of Correlational Research__
        - __Continuity__ - we view the co-occurrence of variables so we have no timeline (e.g. we have people with low self-esteem and dating anxiety, can't tell which came first)
        - __Confounding Variables (aka Teritum Quid)__ - extraneous factors (e.g. a correlation between breast implants and suicide; breast implants don't cause suicide, but a third factor like low self-esteem might cause both)
* __Experimental Research__ - manipulate one variable to see its effect on another.  We do a comparison of situations (usually called _treatments_ or _conditions_) in which cause is present or absent (e.g. we split students into two groups: one with motivation and the other as control, no motivation)
    - __Between-Subjects Design (aka independent measures, between-groups)__ - Participants can be part of the treatment group or the control group, but not both.  Every participant is only subjected to a single treatment (e.g. motivational group gets motivation, control gets no motivation through entire experiment)
    - __Within-Subjects Design (aka repeated measures)__ - Participants are subjected to every single treatment, including the control (e.g. give positive motivation for a few weeks, then no motivation)


## Data Analysis - How data is analyzed (Basics)

### Frequency Distribution (aka Histogram)
A count of how many times different values occur.  The two main ways a distribution can deviate from normal is by _skew_ and _kurtosis_

* __skew__ - the symmetry (tall bars are clustered at one end of the scale); _positively skewed_ means clustered at the lower end / left side) while _negatively skewed_ means clustered at the higher end / right side)
* __kurtosis__ - the pointyness (degree that scores cluster at the end of the distributions/ the _tails_); _positive kurtosis_ has many scores in the tails (aka _leptokurtic distribution_, _has heavy-tailed distribution_) while _negative_kurtosis_ is relatively thin (aka _platykurtic distribution_, _has light tails_)
* __Normal Distribution__ - a bell-shaped curve (majority of bars lie around the center of the distribution); has values of `skew=0` and `kurtosis=0`

### Mode, Median, Mean
Used in frequency distribution to describe central tendancy

* __Mode__ - the value that occurs most frequently.  Modes can have many 'highest points'
    - __bimodal__ - two bars that are the highest
    - __multimodal__ - more than two bars that are the highest
* __Median__ - the middle value when ranked in order of magnitude
* __Mean__ - the average, represented as:


### Quantiles, Quartiles, Percentages
* __Range__ - largest value minus the smallest value
* __Quantiles__ - quantiles split data into equal portions.  Quantiles include _quartiles_ (split into four equal parts), _percentages_ (split into 100 equal parts), _noniles_ (points that split the data into nine equal parts)
* __Quartiles__ - the three values that split sorted data into four equal parts.  _Quartiles_ are special cases of _quantiles_
    - __Lower Quartile (aka First Quartile, Q1)__ - the median of the lower half of the data
    - __Second Quartile (aka Q2)__ - the median, which splits our data into two equal parts
    - __Upper Quartile (aka Third Quartile, Q3)__ - the median of the upper half of the data
    - _Note_: For discrete distributions, there is no universal agreement on selecting quartile values
    * __Interquartile Range (aka IQR)__ - exclude values at the extremes of the distribution (e.g. cut off the top and bottom 25%) and calculate the range of the middle 50% of scores.  `IQR = Q3 - Q1`


### Dispersion in Data

* __Variation (aka spread, dispersion)__ - a change or difference in condition, amount, level
* __Variance__ - a particular measure of _variation_; how far a set of numbers are spread out around the mean or expected value; low variance means values are clumped together (zero means all values are identical), high variance means values are spread out from the mean and each other
    - __Unsystematic Variation (aka random variance)__ - random variability within individuals and/or groups (e.g. I feel better today than yesterday)  `Unsystematic Variance = Measurement Error + Individual Differences`
    - __Systematic Variation (aka between-groups variance)__ - variance between-groups created by a specific experimental manipulation (e.g. give bananas to reward monkeys for successfully completing tasks); doing something in one condition but not in the other condition
* __Deviance__ - quality of fit for a model, the difference between each score and the fit.  Used in the _sum of squares of residuals in ordinary least squares_ where model-fitting is achieved by maximum likelihood.  Can be calculated as: `deviance = <insert deviance equation>`
* __Sum of Squared Errors (aka SS, sum of squares)__ - we can't just add up all the deviance (or else the total spread is just zero, which is meaningless) so we square all the values in order to get the total dispersion / total deviance of scores (i.e. gets rid of negatives)
* __Variance__ - _SS_ works nicely until the number of observations (_n_) changes, then we'll need to recalculate.  Instead of using total dispersion, we use the average dispersion, which is the _variance_
* __Standard Deviation__ - Since the _variance_ is still squared, we need to do the square root of the variance, as calculated here: `standard deviation = <insert standard deviation formula>`


### From Frequency to Probability
So what does the frequency tell us?  Instead of thinking of it as as the frequency of values occuring, think of it as how likely a value is to occur (i.e. probability).  For any distribution of scores, we can calculate the probability of obtaining a given value.

* __Probability Density Functions (aka probability distribution function, probability function)__ -  just like a histogram, except that lumps are smoothed out so that we have a smooth curve.  The area under curve tells us the probability of a value occurring.
    -  Common distributions include _z-distribution_, _t-distribution_, _chi-square distribution_, _F-distribution_
    -  We use a normal distribution with a mean of 0 and a standard deviation of 1 (this lets us use tabulated probabilities instead of calculating ourselves)
    -  To ensure a standard deviation of 1, we calculate the _z-scores_ using: `z = <insert z-score equation>`
    -  Check tabulated values and you'll get the probability _P_ of a value occurring


