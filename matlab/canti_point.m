clear


syms x a b c d e L Es I kappa P
w(x) = a*x^4+b*x^3+c*x^2+d*x+e;

w1(x)= diff(w,x);

w2(x) = diff(w1,x);

w3(x) = diff(w2,x);

k(x) = -w2(x);

M(x) = Es*I*k(x);

V(x) =  -Es*I*w3(x);

%boundary conditions
w0 = w(0);
eq1 = w0 == 0;

M0 = M(0);
Mc = kappa*w1(0);
eq2 = M0 == -Mc;

ML = M(L);
eq3 = eval(ML) == 0;

VL = V(L);
eq4 = VL == P;


[A,B] = equationsToMatrix([eq1, eq2, eq3, eq4], [b, c, d, e]);


X = linsolve(A,B);


b = X(1)
c = X(2)
d = X(3)
e = X(4)

rot(x) = diff(w,x);
rot0 = rot(0);

U(a)=(1/2)*int(M*k,[0,L])+(1/2)*kappa*rot0^2
U(a) = subs(U)
Omega(a)= -P*w(L);
Omega(a) = subs(Omega)

V(a)=U(a)+Omega(a)

dV(a) = subs(diff(V,a))

eq5 = dV == 0;

[A,B] = equationsToMatrix([eq5], [a]);
X = linsolve(A,B);
a = X(1);
wL = subs(w(L));
delta = subs(wL);
delta = simplify(delta)

% Stiffness = simplify(eval(P/delta))
% [N,D] = numden(Stiffness)
% syms d;
% eq6 = P*D == Stiffness * d*D
% [A,B] = equationsToMatrix([eq6], [kappa]);
% X = linsolve(A,B);
% kappa = X(1);
% kappa = simplify(kappa)


Es = 210e6;
L = 9.0;
I = 0.00043218;
P = 2.0;
d = 0.0113988;

tmp = delta-d;

zer = subs(tmp);

[N,D] = numden(zer);

zer = simplify(zer*D)

f = @(kappa)[eval(zer)];

sol = fzero(f,100.0)


