COMPUTE df = n1+n2-2.
COMPUTE Diff = x1-x2.
COMPUTE poolvar = (((n1-1)*(sd1 ** 2))+((n2-1)*(sd2 ** 2)))/df.
COMPUTE poolsd = sqrt((((n1-1)*(sd1 ** 2))+((n2-1)*(sd2 ** 2)))/(n1+n2)).
Compute SE = sqrt(poolvar*((1/n1)+(1/n2))).
COMPUTE CI_Upper = Diff+(idf.t(0.975, df)*SE).
Compute CI_Lower = Diff-(idf.t(0.975, df)*SE).
COMPUTE d = Diff/poolsd.
COMPUTE t_test = Diff/SE.
COMPUTE t_sig = 2*(1-(CDF.T(abs(t_test),df))).
Variable labels Diff 'Difference between Means (X1-X2)'.
Variable labels SE 'Standard Error of Difference between means'.
Variable labels poolsd 'Pooled SD'.
Variable labels d 'Effect Size (d)'.
Variable labels t_test 't statistic'.
Variable labels t_sig 'Significance (2-tailed)'.
Variable labels CI_Upper '95% Confidence Interval (Upper)'.
Variable labels CI_Lower '95% Confidence Interval (Lower)'.
Formats t_sig(F8.5).
EXECUTE .

SUMMARIZE
  /TABLES=  x1 x2 Diff CI_Lower  CI_Upper df t_test t_sig d
  /FORMAT=VALIDLIST NOCASENUM TOTAL LIMIT=100
  /TITLE='T-test'
  /MISSING=VARIABLE
  /CELLS=NONE.
