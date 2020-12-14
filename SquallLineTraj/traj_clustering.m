% make sure we're working with a blank canvas
clear all
close all

%---------------- initial loading and plots --------------%
% load parcel data
pn='parcels.nc';
xp=ncread(pn,'xp')*0.001;
zp=ncread(pn,'zp')*0.001;

% fig1: plot full trajectories
newfig(1);
hxy1a=plot(xp,zp);
print('-dpng','fig1_full_trajectories.png');

% fig2: plot origins of trajectories
newfig(1);
hxy2=scatter(xp(1,:),zp(1,:),'k');
print('-dpng','fig2_origins.png');

%---------------- hierarchical clustering -----------------%
X=[xp(1,:) zp(1,:)];
X=reshape(X,[485 2]);
Y=pdist(X);
Z=linkage(Y);

% fig3: dendrogram of hierarchies
newfig(1);
dendrogram(Z);
print('-dpng','fig3_dendrogram.png');

% do the clustering
T=cluster(Z,'maxclust',4);

% fig4: plot the hierarchical clusters
newfig(1);
hxy4a=scatter(xp(1,T==1),zp(1,T==1),'k');
hold on
hxy4b=scatter(xp(1,T==2),zp(1,T==2),'b');
hxy4c=scatter(xp(1,T==3),zp(1,T==3),'g');
hxy4d=scatter(xp(1,T==4),zp(1,T==4),'r');
print('-dpng','fig4_hierarchical.png');

%---------------- K-means clustering ----------------------%
idx4=kmeans(X,4);
idx5=kmeans(X,5);
idx6=kmeans(X,6);
idx7=kmeans(X,7);

% fig5: silhouette plot 4
newfig(1);
[silh4,h5]=silhouette(X,idx4);
mean(silh4)
print('-dpng','fig5_silh4.png');

% fig6: silhouette plot 5
newfig(1);
[silh5,h6]=silhouette(X,idx5);
mean(silh5)
print('-dpng','fig6_silh5.png');

%fig7: silhouette plot 6
newfig(1);
[silh6,h7]=silhouette(X,idx6);
mean(silh6)
print('-dpng','fig7_silh6.png');

%fig8: silhouette plot 7
newfig(1);
[silh7,h8]=silhouette(X,idx7);
mean(silh7)
print('-dpng','fig8_silh7.png');

% fig 9: k-means clusters
h9a=scatter(xp(1,idx6==1),zp(1,idx6==1),'k');
hold on
h9b=scatter(xp(1,idx6==2),zp(1,idx6==2),'g');
h9c=scatter(xp(1,idx6==3),zp(1,idx6==3),'b');
h9d=scatter(xp(1,idx6==4),zp(1,idx6==4),'r');
h9e=scatter(xp(1,idx6==5),zp(1,idx6==5),'m');
h9f=scatter(xp(1,idx6==6),zp(1,idx6==6),'c');
print('-dpng','fig9_kmeans.png');
