function Z = Teta_calculater( q )
	if q<0.01
		Z = 10;
	elseif q<0.1
		Z = 20;
	elseif q<1
		Z = 100;
	else
		Z = 300;
	end
end

