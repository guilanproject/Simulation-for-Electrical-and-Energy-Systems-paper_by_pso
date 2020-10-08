function Z = F( X , iter , MaxIter , day)
%	P_on & P_mid & P_off are vectors of D dimention
	
% 	day = 1;
	
	P_on   = X(1 , 1);
	P_mid = X(1 , 2);
	P_off   = X(1 , 3);
	
	Z = f2( P_on , P_mid , P_off , day ) + J( P_on , P_mid , P_off , iter , MaxIter , day);
end

