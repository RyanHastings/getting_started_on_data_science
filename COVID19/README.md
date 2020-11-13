# COVID19 Model

This is a simplifed version of a model I wrote for the Indiana State
Department of Health in 2020 to model the outbreak of coronavirus.  It
is a modified SEIR model, including categories for critically hospitalized
and deceased.  The model itself is quite simple, a system of six linear
differential equations that are solved simultaneously using a forward-Euler
integration method.

* [BaseModel](BaseModel) has the basic model itself.
* [StateSpace](StateSpace) contains an iterable version of the model for
constructing a state space of possible model solutions.  This was done
to try and figure out what the proper parameters were for running the model:
A set of possibilities were generated, and then fit to observations.
* [ModelFitting](ModelFitting) has the algorithm used to fit the state space
of possible models to observations.
