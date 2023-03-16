%Μεθοδος συζυγων κλισεων

function fun1 = f1(A,b,n)
	s = 0;
	for i = 1:n
		s = s + (A(i,1)*b(i,1));
	end
	fun1 = s;
end

function fun2 = f2(A,x,n)

	y = zeros(n,1);
	for i = 1:n
		for j = (i-3):(i+3)
			if ( j > 0 && j <= n)
				y(i,1) = y(i,1) + A(i,j)*x(j,1);
			end
		end
	end
	fun2 = y;

end

function fun3 = f3(A,r,n)

	s = zeros(n,1);
	for i = 1:n
		s(i,1) = A*r(i,1);
	end
	fun3 = s;

end

function r = printresults(x,n)
	disp("\n")
	for i = 1:5
		disp(x(i,1))
	end
	disp("\n")
	for i = (n/2) - 2 : (n/2) + 2
		disp(x(i,1))
	end
	disp("\n")
	for i = (n-4):n
		disp(x(i,1))
	end
	disp("\n")
end

format long

prompt = 'Give number of equations: ';
n = input(prompt);

a2 = zeros(n);
b2 = zeros(n,1);
b2(1,1) = 9;
b2(2,1) = 0;
b2(3,1) = 0;
b2(n,1) = 9;
b2(n-1,1) = 0;
b2(n-2,1) = 0;
for i = 1:n
	a2(i,i) = 17;
	if ( i > 1 )
		a2(i,i-1) = -9;
	end
	if ( i < n )
		a2(i,i+1) = -9;
	end
	if ( i > 3 )
		a2(i,i-3) = 1;
	end
	if ( i < n-2 )
		a2(i,i+3) = 1;
	end
	if( i > 3 && i < n-2 )
		b2(i,1) = 1;
	end
end

r21 = zeros(n,1);
r22 = zeros(n,1);
r2k = zeros(n,1);
x21 = zeros(n,1);
x22 = zeros(n,1);
p21 = zeros(n,1);
p22 = zeros(n,1);

ep = 0.00005;
r22 = b2;
p21 = r22;     
ak = 0;
bk = 0;
x = 0;
y = 0;
ap = zeros(n,1);
ap = f2(a2,p21,n);
x = f1(r22,r22,n);
y = f1(ap,p21,n);
ak = ( x/y );          
x22 = x21 + f3(ak,p21,n);   
r21 = b2 - f2(a2,x22,n);   
x21 = x22;
k = 1;
while ((norm(r22,n) > ep) && (k<n))
	k = k+1;
	x = f1(r21,r21,n);
	y = f1(r22,r22,n);
	bk = ( x/y );
	p22 = r21 + f3(bk,p21,n);
	ap = f2(a2,p22,n);
	y = f1(ap,p22,n);
	ak = ( x/y );
	x22 = x21 + f3(ak,p22,n);
	r2k = b2 - f2(a2,x22,n);
	x21 = x22;
	r22 = r21;
	r21 = r2k;
	p21 = p22;
end

disp("\n")
disp("Result from equation 2")
printresults(x22,n);
