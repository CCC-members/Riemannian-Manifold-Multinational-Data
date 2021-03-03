# Riemannian-Manifold-Multinational-Data
Contains code to map Cross-Spectra EEG data to an Euclidean space following this steps:          
1-Apply average reference to the Cross-Spectra data (eliminate one row and one column to each matrix)          
2-Apply Hilbert-Smith regularization method described in Schneider-Luftman & Walden, 2015          
3-Group data by Manifolds of single frequencies for all subjects          
4-Find mean of the Manifolds          
5-Map from Manifold space to Eucliden space using the methods described in Pennec et al., 2006

