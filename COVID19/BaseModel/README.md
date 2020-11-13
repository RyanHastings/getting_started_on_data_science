# BaseModel COVID-19 ISDH SEIR model Lite

This is a simplified version of the full model that was deployed in 2020
at the Indiana State Department of Health for modeling COVID-19.

* model_master.R: master script for running all other model scripts,
also contains configuration variables
* model_initialization.R: initializes model arrays
* model_dynamic_core.R: contains the dynamic core of the model
* model_out.R: creates model output 

It should be possible to run this model with little modification.  A
census file is included with the data so it can be run for any state.
Note that this is the bare-bones, missing a lot of the bells and 
whistles in the operational model, which I was not allowed to share.
