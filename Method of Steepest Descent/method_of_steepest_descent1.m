%Μεθοδος αποτομης καθοδου

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

ep = 0.00005;
x1 = zeros(n,n);
r1 = zeros(n,n);
r1(:,1) = b1;
k = 1;
ak = 0;
ar = zeros(n,1);
arithmitis = 0;
paranomastis = 0;
while norm(r1(:,k))> ep
	k = k+1;
	ar = f2(a1,r1(:,k-1),n);
	arithmitis = f1(r1(:,k-1),r1(:,k-1),n);
	paranomastis = f1(ar,r1(:,k-1),n);
	ak = ( arithmitis/paranomastis );
	x1(:,k) = x1(:,k-1) + f3(ak,r1(:,k-1),n);
	r1(:,k) = r1(:,k-1) -  f3(ak,ar,n);
end

disp("\n")
disp("Result from equation 1")
printresults(x1(:,k),n);
