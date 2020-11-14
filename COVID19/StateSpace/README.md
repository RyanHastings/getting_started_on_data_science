# StateSpace

This code is very similar to that in [BaseModel](../BaseModel), in that it has a master,
initialization, dynamic core, and script for organizing the output.  This iterates over
the basic model to produce a set of solutions to the SEIR equations based on varying the
parameters slightly.  It results in an .RData file for output containing all the
epidemiological trajectories.  This particular version simply simulates possibilities for
Phase One of Indiana's NPI plan.

* [DetermineStateSpace.R](DetermineStateSpace.R) is the master code.
* [DetermineStateSpace_initialization.R](DetermineStateSpace_initialization.R) initializes
the model.
* [DetermineStateSpace_dynamics.R](DetermineStateSpace_dynamics.R) contains the dynamic
core for the model.
* [DetermineStateSpace_out.R](DetermineStateSpace_out.R) organizes the output for the
state space file.
