%% PSO %%
clear all
close all
clc

D = 3;
DVar = [1 D];
Pop = 20;
MaxIter = 200;

%% Loop for days of a month
BestFitday = zeros( 30 );
BestXday = zeros( 30 , 3 );
for day=1 : 30
%% Set the initial value for the parameters %%
load('PL_min.mat')
load('PL_max.mat')
for i=1 : Pop
	X(i,:) = unifrnd(min(PL_min+1) , max(PL_max) , DVar);
	P(i,:) = X(i,:);
	Fit(i) = F(X(i,:) , 1 , MaxIter , day);
	PFit(i) = Fit(i);
end
V = zeros(Pop , D);
w = 0.01;
n1 = 2;
n2 = 2;
Gbest = zeros(MaxIter);
Bworst = zeros(MaxIter);
BestX = zeros(MaxIter  , D);
GbestX = zeros(MaxIter , D);
%%  Main loop %%
tic
for iter=1 : MaxIter
    % Calculate Worst & Best for this iter
	Best(iter) = min( Fit(:) );
	Worst(iter) = max( Fit(:) );
	[~,BestXiter ]=min( Fit(:) );
	BestX(iter , :) = X(BestXiter ,:);
    % Calculate GoodBest & BadWorst
    if iter==1
        Gbest = Best;
        Bworst = Worst;
        GbestX(1 ,:) = BestX(1 ,:);
    else
        if Gbest(iter-1)>Best(iter)
            Gbest(iter) = Best(iter);
            GbestX(iter, :) = BestX(iter , :);
            
        else
            Gbest(iter) = Gbest(iter-1);
            GbestX(iter ,:) = GbestX(iter-1 ,:);
        end
    end
    % Calculation & Update V
	for i=1:Pop
		for d=1:D
			V(i ,d) = w*V(i , d) + n1*rand*(P(i ,d)-X(i ,d)) + n2*rand*(GbestX(iter ,d)-X(i ,d));
		end
	end
    % Update X
	for i=1:Pop
		X(i, :) = X(i , :) + V(i , :);
	end
    
    % Update position & best position
    for i=1:Pop
        Fit(i) = F(X(i ,:) , iter , MaxIter , day);
        if (Fit(i) < PFit(i))
            P(i,:) = X(i,:);
            PFit(i) = Fit(i);
        end
    end
%     Print best solution
    disp(['iteration = ' num2str(iter) '    Best = ' ...
        num2str(Gbest(iter))]);
end
BestFitday(day) = Gbest(MaxIter);
BestXday(day , :) = GbestX(MaxIter , :);
end
ti = toc;
disp(['CPU Time = ' num2str(ti)]);
%% 