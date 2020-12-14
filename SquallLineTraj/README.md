# Squall Line Trajectories

This is based off of some work I was doing with Patrick Skinner at the
National Severe Storms Laboratory.  He read a paper with the idea of
applying clustering methods to objectiely analyzing trajectories through
meteorological systems.  A common problem in studying systems is learning
how the air flows through them.  In severe storms, this often translates
to discovering where the outflow originates.

For the purpose of this project, I simulated a simple squall line
using CM1 (for those interested in the technical details, it's a
Weisman-Klemp sounding with an RKW wind profile and Morrison microphysics).
To compute the trajectories, I used my [cm1_pp_v1.0](http://www.github.com/RyanHastings/cm1_pp).

![fig1_full_trajectories.png](images/fig1_full_trajectories.png)

I then identified the origins.

![fig2_origins](images/fig1_origins.png)

This becomes a problem of identifying clusters in Euclidean space.  I
first followed the literature and tried hierarchical clustering.  The
dendrogram is below.

![fig3_dendrogram](images/fig3_dendrogram.png)

Eyeballing it, the level at which four clusters seems to be the
best for consistency vs similarity.  That gives us four clusters as
seen below.

![fig4_hierarchical](images/fig4_hierarchical.png)

I then decided to try *k*-means clustering.  I arbitrarily chose
to run with clusters 4-7, based on four seeming to be an optimum
number in the hierarchical clustering.  Silhouette plots below.

![fig5_silh4](images/fig5_silh4.png)
with a mean of 0.7837
![fig6_silh5](images/fig6_silh5.png)
with a mean of 0.6487
![fig7_silh6](images/fig7_silh6.png)
with a mean of 0.7890 and
![fig8_silh7](images/fig8_silh7.png)
with a mean of 0.6609.

With the highest mean, I selected six vectors for the *k*-means
clustering, which yielded the following:

![fig9_kmeans](images/fig9_kmeans.png)

Code in Matlab available at [traj_clustering.m](traj_clustering.m) using
data from [parcels.nc](parcels.nc) which is in netCDF format.  If you're
downloading this, be sure to grab [newfig.m](newfig.m) as well to run it
on your own.
