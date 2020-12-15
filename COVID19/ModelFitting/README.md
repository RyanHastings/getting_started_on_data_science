# COVID-19 Model Fitting

This code uses the output from [StateSpace](../StateSpace).  That code
generated an .RData file with tens of thousands of possible solutions
to the SEIR model.  This code reads in observations and finds the nearest
fit in the state space.  Unfortunately, I can't provide the data it
reads, so interested parties will simply have to review the code.  It's
fairly straightforward code, though:  [Fit3curves.R](Fit3curves.R)
