function Z = J( P_on , P_mid , P_off , iter , MaxIter , day)
	m = 3;
	load('PL_min.mat')
	load('PL_max.mat')
	PLmin = PL_min(day);
	PLmax = PL_max(day);
	h(1 , :) = ( PLmax - P_on ).*( P_on - PLmin);
	h(2 , :) = ( PLmax - P_mid ).*( P_mid - PLmin );
	h(3 , :) = ( PLmax - P_off ).*( P_off - PLmin );
	
	for i=1 : m
		q( i ) = q_calculater( h(i , :) );
		Landa( i ) = Landa_calculater( q(i) );
		Teta( i ) = Teta_calculater( q(i) );
	end
	
	Z = Fi_calculater(iter , MaxIter) * sum( Teta .* q.^Landa );
end

