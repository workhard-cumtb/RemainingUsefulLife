
%% test for princomp(Principal Component Analysis)
% http://www.matlabsky.com/thread-11751-1-1.html
% ����matlab��princomp��ʹ��˵������С���� by faruto
% �ܿ������������ע�ͽ����ǰ��������PCA��һ�����˽�~O(��_��)O
% 2009.10.27
clear;
clc
%% load cities data
load cities
% whos
%   Name             Size         Bytes  Class
%   categories       9x14           252  char array
%   names          329x43         28294  char array
%   ratings        329x9          23688  double array
%% box plot for ratings data
% To get a quick impression of the ratings data, make a box plot
figure;
boxplot(ratings,'orientation','horizontal','labels',categories);
grid on;
%% pre-process
stdr = std(ratings);
sr = ratings./repmat(stdr,329,1);
%% use princomp 
[coef,score,latent,t2] = princomp(sr);
%% �����������

% coef:9*9
% ���ɷ�ϵ��:��ԭʼ������������������ɷ�������ÿһά����ǰ���ϵ��.
% coef��ÿһ�д���һ�������ɵ����ɷֵ�ϵ��.
% ��������ȡ��ǰ�������ɷֵ�ϵ��,�����¿�ʵ��:pca3 = coef(:,1:3);

% score:329*9
% ��������:���ɷֵ÷�
% ��ԭʼ�����������ɵ����ɷֿռ��������ֵ.

% latent:9*1
% һ��������,��sr��Э������������ֵ���.
% �� latent = sort(eig(cov(sr)),'descend');
% ��������:
% sort(eig(cov(sr)),'descend') =
%     3.4083
%     1.2140
%     1.1415
%     0.9209
%     0.7533
%     0.6306
%     0.4930
%     0.3180
%     0.1204
% latent =
%     3.4083
%     1.2140
%     1.1415
%     0.9209
%     0.7533
%     0.6306
%     0.4930
%     0.3180
%     0.1204

% t2:329*1
% һ�ж�Ԫͳ�ƾ���,��¼����ÿһ���۲��������ĵľ���
%% �����ȡ���ɷ�,�ﵽ��Ϊ��Ŀ��
% ͨ��latent,����֪����ȡǰ�������ɷ־Ϳ�����.
figure;
percent_explained = 100*latent/sum(latent);
pareto(percent_explained);
xlabel('Principal Component');
ylabel('Variance Explained (%)');
% ͼ�е��߱�ʾ���ۻ��������ͳ̶�.
% ͨ����ͼ���Կ���ǰ�߸����ɷֿ��Ա�ʾ��ԭʼ���ݵ�90%.
% ������90%��������ֻ����ȡǰ�߸����ɷּ���,�����ﵽ���ɷ���ȡ��Ŀ��.
%% Visualizing the Results

% ����Ŀ��ӻ�
figure;
biplot(coef(:,1:2), 'scores',score(:,1:2),... 
'varlabels',categories);
axis([-.26 1 -.51 .51]);
% �������������ֱ��ʾ��һ���ɷֺ͵ڶ����ɷ�
% ��ɫ�ĵ����329���۲���,����������Ǹ�score
% ��ɫ�������ķ���ͳ��ȱ�ʾ��ÿ��ԭʼ�������µ����ɷֵĹ���,����������Ǹ�coef.
