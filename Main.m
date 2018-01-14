%semi-supervised spectral clustering for image set classification

clear all;

% Load DataSet:
% set1 = load_image('C:\Users\Masoud\Desktop\Pattern_Project\hand_pictures\Set1');
% set2 = load_image('C:\Users\Masoud\Desktop\Pattern_Project\hand_pictures\Set2');
% set3 = load_image('C:\Users\Masoud\Desktop\Pattern_Project\hand_pictures\Set3');
% set4 = load_image('C:\Users\Masoud\Desktop\Pattern_Project\hand_pictures\Set4');
% set5 = load_image('C:\Users\Masoud\Desktop\Pattern_Project\hand_pictures\Set5');

load('all_dataset');

% DataSet in PCA map:
[eigvector1, eigvalue1] = PCAmodified(set1',100);
set1_pca = set1'*eigvector1;
set1_pca = set1_pca';

[eigvector2, eigvalue2] = PCAmodified(set2',100);
set2_pca = set2'*eigvector2;
set2_pca = set2_pca';

[eigvector3, eigvalue3] = PCAmodified(set3',100);
set3_pca = set3'*eigvector3;
set3_pca = set3_pca';

[eigvector4, eigvalue4] = PCAmodified(set4',100);
set4_pca = set4'*eigvector4;
set4_pca = set4_pca';

[eigvector5, eigvalue5] = PCAmodified(set5',100);
set5_pca = set5'*eigvector5;
set5_pca = set5_pca';