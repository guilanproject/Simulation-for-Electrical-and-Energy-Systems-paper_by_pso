function Z = f2( P_on , P_mid , P_off , day )

%	X(i) { P_on , P_mid , P_off } ? how?!
%	i =  1 ,2 ,3 ,4 . . . , N_h    --> number of hours in one day
%	j =  1 ,2 ,3 ,4 . . . , N_d    --> number of days in an entire year
	N_h = 24;
	N_d = 30;
	load('PL.mat')
	sum = 0;
	X = [P_on , P_mid , P_off];
	for i=1 : N_h
		temp = min( min( ( (PL(i,day)-X(1))^2 ) , ( (PL(i,day)-X(2))^2 ) )  , ( (PL(i,day)-X(3))^2 ) );
		sum = sum + temp;
	end
	Z = sqrt( (1/N_h) * sum );
end

