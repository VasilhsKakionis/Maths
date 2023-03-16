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

a1 = zeros(n);
b1 = zeros(n,1);
b1(1,1) = 8;
b1(2,1) = -1;
b1(3,1) = -1;
b1(n,1) = 8;
b1(n-1,1) = -1;
b1(n-2,1) = -1;
for i = 1:n
	a1(i,i) = 16;
	if ( i > 1 )
		a1(i,i-1) = -9;
	end
	if ( i < n )
		a1(i,i+1) = -9;
	end
	if ( i > 3 )
		a1(i,i-3) = 1;
	end
	if ( i < n-2 )
		a1(i,i+3) = 1;
	end
	if( i > 3 && i < n-2 )
		b1(i,1) = 0;
	end
end

r11 = zeros(n,1);    
r12 = zeros(n,1);    
r1k = zeros(n,1);     
x11 = zeros(n,1);     
x12 = zeros(n,1);    
p11 = zeros(n,1);    
p12 = zeros(n,1);    

ep = 0.00005;
r12 = b1;     
p11 = r12;   
ak = 0;
bk = 0;
x = 0;
y = 0;
ap = zeros(n,1);
ap = f2(a1,p11,n);
x = f1(r12,r12,n);
y = f1(ap,p11,n);
ak = ( x/y );          
x12 = x11 + f3(ak,p11,n);  
r11 = b1 - f2(a1,x12,n);   
x11 = x12;
k = 1;
while ((norm(r12,n) > ep) && (k<n))
	k = k+1;
	x = f1(r11,r11,n);
	y = f1(r12,r12,n);
	bk = ( x/y );
	p12 = r11 + f3(bk,p11,n);
	ap = f2(a1,p12,n);
	y = f1(ap,p12,n);
	ak = ( x/y );
	x12 = x11 + f3(ak,p12,n);
	r1k = b1 - f2(a1,x12,n);
	x11 = x12;
	r12 = r11;
	r11 = r1k;
	p11 = p12;
end

disp("\n")
disp("Result from equation 1")
printresults(x12,n);
