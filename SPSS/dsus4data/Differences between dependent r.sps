************************************************************.
*   Author: Andy Field, University of Sussex, UK    .
************************************************************.

MATRIX.
GET rxy /VARIABLES = rxy.
GET rzy /VARIABLES = rzy.
GET rxz /VARIABLES = rxz.
GET n /VARIABLES = n.
COMPUTE diff = rxy-rzy.
COMPUTE ttest = diff*(sqrt(((n-3)*(1+rxz))&/(2*(1 - rxy**2 - rxz**2 - rzy**2 + (2*rxy)*rxz*rzy)))).
COMPUTE sigt = tcdf(ttest,(n-3)).
COMPUTE output = {diff, ttest, sigt}.

print "*** Tests of Differences between Dependent Correlation Coefficiants ***".
print output /TITLE = "    Difference        t           Sig".
END MATRIX.

