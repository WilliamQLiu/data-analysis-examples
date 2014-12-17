************************************************************.
*   Author: Andy Field, University of Sussex, UK    .
************************************************************.

MATRIX.
GET n /VARIABLES = n
   /MISSING=OMIT.
GET r /VARIABLES = r
   /MISSING=OMIT.
COMPUTE z = 0.5*(ln((1+r)/(1-r))).
COMPUTE SEz = 1/sqrt(n-3).
COMPUTE zscore = z/SEz.
COMPUTE sigz = 2*(1-cdfnorm(abs(zscore))).
COMPUTE zrupper = z + (1.96*SEz).
COMPUTE zrlower = z - (1.96*SEz).
COMPUTE rlower =(exp(zrlower/0.5)-1)/(1+exp(zrlower/0.5)).
COMPUTE rupper =(exp(zrupper/0.5)-1)/(1+exp(zrupper/0.5)).
COMPUTE zCI = {r, rlower, rupper, zscore, sigz}.
print "*** 95% Confidence interval for r ***".
print zCI /TITLE = "         r         95% Lower     95% Upper         z           Sig".
END MATRIX.




