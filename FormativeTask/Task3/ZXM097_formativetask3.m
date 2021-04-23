%% Question 1
clear; close all; clc;
data_origin = readcell("data.csv");
data = normalize(cell2mat(data_origin(2:142,3:13)));
[coeff,score,latent,tsquared,explained,mu] = pca(data);
figure;
% subplot(2,2,1);
biplot(coeff(:,1:2),'varlabels',data_origin(1,3:13));
title("Loading plot");
% hold on;
%% Question 2
figure;
% subplot(2,2,2);
X = categorical(data_origin(1,3:13));
X = reordercats(X,data_origin(1,3:13));
vals = transpose(coeff(:,1:2));
bar(X,vals);
legend('PC 1','PC 2', 'FontSize',8,'FontName','Times New Roman', 'Location', 'northeast');
title("Principal components");
% hold on;

%% Question 3
figure;
explainedSize = [9,1];
% subplot(2,2,3);
yyaxis left
bar(explained(1:9));
ylabel('Varience Explained(%)');
xlabel('Principal Component');
ylim([0 100]);

tmpExplained = 0;
ratioData = zeros(explainedSize(1),1);
for i=1:explainedSize(1)
    tmpExplained = tmpExplained+explained(i);
    ratioData(i,1) = tmpExplained;
end

yyaxis right
plot(ratioData,'b-');
ylim([0 100]);


title("Explained varience ratio");
% hold on;


%% Question 4

data_PCA = data*coeff(:,1:2);

% subplot(2,2,4);

figure;

typeString = [];

for i = 2:size(data_origin,1)
    if isempty(typeString)
        typeString = [typeString string(data_origin(i,2))];
    end
    
    if find(typeString==string(data_origin(i,2)))
    else
        typeString = [typeString string(data_origin(i,2))];
    end
end

typeString = typeString.sort;

scoreData = struct;

for i = typeString
    tmpTypeDate = [];
    for j = 1:size(data,1)
        if data_origin(j+1,2)==i
            tmpTypeDate = [tmpTypeDate [data_PCA(j,1);data_PCA(j,2)]];
        end
    end
    scoreData.(i) = transpose(tmpTypeDate);
end
    

scatter(scoreData.Assassins(:,1),scoreData.Assassins(:,2),'fill');
hold on
scatter(scoreData.Fighters(:,1),scoreData.Fighters(:,2),'fill');
hold on
scatter(scoreData.Mages(:,1),scoreData.Mages(:,2),'fill');
hold on
scatter(scoreData.Marksmen(:,1),scoreData.Marksmen(:,2),'fill');
hold on
scatter(scoreData.Support(:,1),scoreData.Support(:,2),'fill');
hold on
scatter(scoreData.Tanks(:,1),scoreData.Tanks(:,2),'fill');
hold on

xlabel('Principal Component 1');
ylabel('Principal Component 2');

legend(typeString(:));

title("Score plot");
% hold on;
