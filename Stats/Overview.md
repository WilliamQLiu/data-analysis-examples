# Overview

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
    - _Programming_ - In R, this is 'factor()' and Python's Pandas, this is 'categorical' with an optional order
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
        + __Continuity__ - we view the co-occurrence of variables so we have no timeline (e.g. we have people with low self-esteem and dating anxiety, can't tell which came first)
        + __Confounding Variables (aka Teritum Quid)__ - extraneous factors (e.g. a correlation between breast implants and suicide; breast implants don't cause suicide, but a third factor like low self-esteem might cause both)
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
* __Test Statistic__ - the ratio of systematic to unsystematic variance or effect to error (i.e. the signal-to-noise)


### From Frequency to Probability
So what does the frequency tell us?  Instead of thinking of it as as the frequency of values occuring, think of it as how likely a value is to occur (i.e. probability).  For any distribution of scores, we can calculate the probability of obtaining a given value.

* __Probability Density Functions (aka probability distribution function, probability function)__ -  just like a histogram, except that lumps are smoothed out so that we have a smooth curve.  The area under curve tells us the probability of a value occurring.
    -  Common distributions include _z-distribution_, _t-distribution_, _chi-square distribution_, _F-distribution_
    -  We use a normal distribution with a mean of 0 and a standard deviation of 1 (this lets us use tabulated probabilities instead of calculating ourselves)
    -  To ensure a standard deviation of 1, we calculate the _z-scores_ using: `z = <insert z-score equation>`
    -  Check tabulated values and you'll get the probability _P_ of a value occurring


### Populations and Samples
We want to find results that apply to an entire population

* __Population__ - summation of the same group or species; can be very general or very specific (e.g. humans, cats named Will)
* __Sample__ - small subset of the population
* __Degrees of Freedom__ - number of values in the final calculation that are free to vary (e.g. mean is 5 for the values 4, 6, and <blank>.  <blank> must then be 5)
* __Sampling Variation__ - samples will vary because they contain different members of the population (e.g. grab random samples of people off the street, some samples you'll get a sample/group of people that is smarter, some samples not so much) 
* __Sampling Distribution (aka finite-sample distribution)__ - the distribution of a sample statistic (based on a random sample); this tells us about the behavior of samples from the population
* __Standard Error (aka SE)__ - a measure of how representative a sample is likely to be of the population.  A large standard error means there is a lot of variability so samples might not be representative of the population.  A small standard error means that most samples are likely to be an accurate reflection of the population
* __Central Limit Theorem__ - as samples get large (greater than 30), the sampling distribution has a normal distribution and a standard deviation of: `insert standard deviation formula`
* __Confidence Intervals (for large samples)__ - along with standard error, we can calculate boundaries that we believe the population will fall.  In general, we could calculate confidence intervals using the _central limit theorem_:
    - `lower boundary of confidence interval = formula`
    - `upper boundary of confidence interval = formula`
    - Note: Different for 95% confidence interval (most common) or 99% or 90%
* __Confidence Intervals (for small samples)__ - for smaller samples, we can't calculate boundaries using the _central limit theorem_ because the _sampling distribution_ isn't a _normal distribution_.  Instead, smaller samples have a _t-distribution_ and would be calculated with:
    - `lower boundary of confidence interval = formula`
    - `upper boundary of confidence interval = formula`
* __p-value__ - the probability of obtaining the observed sample results when the null hypothesis is true.  If the _p-value_ is very small (threshold based on the previously chosen _significance level_, traditionally 5% or 1%) then the hypothesis must be rejected.
    - p <= 0.01 means very strong presumption against null hypothesis
    - 0.01 < p <= 0.05 means strong presumption against null hypothesis
    - 0.05 < p <= 0.1 means low presumption against null hypothesis
    - p > 0.1 means no presumption against the null hypothesis
    - _Note_: _NHST_ only works if you generate your hypothesis and decide on threshold before collecting the data (otherwise chances of publishing a bad result will increase; as is with 95% confidence level you'll only report 1 bad in 20)


### Statistical Models
We can predict values of an outcome variable based on some kind of model.

* __Model__ - Models are made up of _variables_ and _parameters_
    - __Variables__ - are measured constructs that vary across entities in the sample
    - __Parameters__ - are estimated from the data (rather than being measured) and are (usually) constants.  E.g. the mean and median (which estimate the center of the distribution) and the correlation and regression coefficients (which estimate the relationship between two variables).  We say 'estimate the parameter' or 'parameter estimates' because we're working with a sample, not the entire population.
* __Outcome__ - `outcome = model + error`
* __Error (aka deviance)__ - Error for an entity is the score predicted by the model subtracted from the observed score for that entity.  `error = outcome - model`
* __Null Hypothesis Significance Testing (aka NHST)__ - a method of statistical inference used for testing a hypothesis.  A test result is _statistically significant_ if it has been predicted as unlikely to have occurred by chance alone, according to a threshold probability (the significance level)
    - __Alternative Hypothesis (aka H1, Ha, experimental hypothesis)__ - the hypothesis or prediction that sample observations are influenced by some non-random cause
    - __Null Hypothesis (H0)__ - Opposite of the _alternative hypothesis_, refers to the default position that there is no relationship between two measured phenomena
    - __Directional and Nondirectional Hypothesis__ - hypothesis can be either _directional_ if it predicts whether an effect is larger or smaller (e.g. if I buy cookies, I'll eat more) or _non-directional_ if it does not predict whether effect is larger or smaller (e.g. if I buy cookies, I'll eat more or less).
        + __One-tailed test__ -  a statistical model that tests a directional hypothesis
        + __Two-tailed test__ -  a statistical model that tests a non-directional hypothesis
        + _Note_: Basically, don't ever do one-tailed tests
* __Type I and Type II errors__ - two types of errors that we can make when testing hypothesis.  If we correct for one, the other is affected.
    - __Type I error__ - occurs when we believe there is an effect in our population, when in fact there isn't.  Using conventional 95% confidence level, the probability is 5% of seeing this error (aka _//-level_).  This means if we repeated our experiment, we would get this error 5 out of 100 times.
        + __Familywise (FWER) or Experimentwise Error Rate (EER)__ - the error rate across statistical tests conducted on the same data for _Type I errors_.  This can be calculated using the following equation (assuming .05 level of significance): `familywise error=1=(0.95)^n` where _n_ is the number of tests carried out
        + __Bonferroni correction__ - the easiest and most popular way to correct _FWER_, which fixes familywise error rate, but at the loss of _statistic power_.  Calculated with `insert formula`
    - __Type II error__ - opposite of _Type I error_, occurs when we believe there is no effect in the population when in fact there is an effect.  The maximum acceptable probability of a _Type_II error_ is 20%_(aka //-level)_.  This means we miss 1 in 5 genuine effects.
        + __Statistical Power__ - statistical power is the ability of a test to find an effect; the power of the test is the probability that a given test will find an affect assuming that one exists in the population.  Can be expressed as: `1 - // insert formula`.  Basically, _statistical power_ is linked with the _sample size_.  We aim to achieve a power of 80% chance of determining an effect if one exists.  
        + _Note_: For _R_, use the package 'pwr' to use power to calculate the necessary sample size.  You can also calculate the power of a test after the experiment, but if you find a non-significant effect, it might be that you didn't have enough power.  If you find a significant effect, then you had enough power.
* __Sample Size and Statistical Significance__ - there is a close relationship between _sample size_ and _p-value_.  The same effect will have different _p-values_ in different sized samples (i.e. small differences can be 'significant' in large samples and large effects might be deemed 'non-significant' in small samples)
* __Effect Size and Cohen's d__ - significance does not tell us about the importance of an effect.  The solution is to measure the size of the effect, which is a quantitative measure of the strength of a phenomenon.  In order to compare the mean of one sample to another, we calculate _Cohen's d_ as described here: `insert formula`
* __Pearson's correlation coefficient (aka r)__ - measure of strength of relationship between two variables (thus it's an _effect size_)
    - r ranges between 0 (no effect) and 1 (a perfect effect)
    - r=.10 means a small effect
    - r=.30 means a medium effect
    - r=.50 means a large effect
    - _Note_: r=.6 does not mean it has twice the effect of r=.3
* __Meta-analysis__ - statistical methods for contrasting and combining results from different studies in the hope of identifying patterns among study results (i.e. conducting research about previous research).  Meta-analysis allows to achieve a higher _statistical power_.  `insert formula`


