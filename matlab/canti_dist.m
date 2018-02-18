clear


syms x a b c d e L Es I kappa P g
w(x) =  g*x^5 +a*x^4+b*x^3+c*x^2+d*x+e;

w1(x)= diff(w,x);

w2(x) = diff(w1,x);

w3(x) = diff(w2,x);

k(x) = -w2(x);

M(x) = Es*I*k(x);

V(x) =  -Es*I*w3(x);

p_dist(x) = P*x/L

%boundary conditions
w0 = w(0);
eq1 = w0 == 0;

M0 = M(0);
Mc = kappa*w1(0);
eq2 = M0 == -Mc;

ML = M(L);
eq3 = eval(ML) == 0;

VL = V(L);
eq4 = VL == 0;


[A,B] = equationsToMatrix([eq1, eq2, eq3, eq4], [b, c, d, e]);


X = linsolve(A,B);


b = X(1)
c = X(2)
d = X(3)
e = X(4)

rot(x) = diff(w,x);
rot0 = rot(0);

U(a,g)=(1/2)*int(M*k,[0,L])+(1/2)*kappa*rot0^2
U(a,g) = subs(U)
Omega(a,g)= -int(p_dist*w,[0,L]);
Omega(a,g) = subs(Omega)

V(a,g)=U(a,g)+Omega(a,g)

dVa(a,g) = subs(diff(V,a))
dVg(a,g) = subs(diff(V,g))

eq5 = dVa == 0
eq6 = dVg == 0

[A,B] = equationsToMatrix([eq5, eq6], [a,g]);
X = linsolve(A,B);
a = X(1);
g = X(2);
wL = subs(w(L));
delta = subs(wL);
delta = simplify(delta)


Es = 210e6;
L = 9.0;
I = 0.000432;
P = 15.0;
d = 1.2724;

% d_calc = eval(subs(delta,3000e30))
% delta(kappa) = eval(subs(vpa(delta)));
% 
% [N,D] = numden(delta);
tmp = delta-d;

zer = subs(tmp);

[N,D] = numden(zer);

zer = simplify(zer*D)

f = @(kappa)[eval(zer)];

sol = fzero(f,100.0)

%kappa = vpa(subs(kappa));

%kappa = eval(kappa)

