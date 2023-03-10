
C1tsne(i,:) = tsne(features_obj(:,i)', 'NumDimensions', 3,'Standardize',1);

rng('default') % for reproducibility
Y = tsne(C1tsne,'Algorithm','exact','Distance','mahalanobis');
subplot(2,2,1)
gscatter(Y(:,1),Y(:,2),species)
title('Mahalanobis')

rng('default') % for fair comparison
Y = tsne(C1tsne,'Algorithm','exact','Distance','cosine');
subplot(2,2,2)
gscatter(Y(:,1),Y(:,2),species)
title('Cosine')

rng('default') % for fair comparison
Y = tsne(C1tsne,'Algorithm','exact','Distance','chebychev');
subplot(2,2,3)
gscatter(Y(:,1),Y(:,2),species)
title('Chebychev')

rng('default') % for fair comparison
Y = tsne(C1tsne,'Algorithm','exact','Distance','euclidean');
subplot(2,2,4)
gscatter(Y(:,1),Y(:,2),species)
title('Euclidean')