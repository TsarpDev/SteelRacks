clear

% shape function and forces
syms x a b c d e L Es I kappa P g m
w(x) = m*x^6+ g*x^5 +a*x^4+b*x^3+c*x^2+d*x+e;

w1(x)= diff(w,x);

w2(x) = diff(w1,x);

w3(x) = diff(w2,x);

k(x) = -w2(x);

M(x) = Es*I*k(x);

V(x) =  -Es*I*w3(x);


% initialize
syms N;
N=9;
dx = L/N;

p_pt=[];
w_pt=[];
for i=0:dx:L
  p_pt =[ p_pt, [P*i/L]];
  eval(subs(w,i));
  w_pt =[ w_pt, [ans]];
end



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

U(a,g,m)=(1/2)*int(M*k,[0,L])+(1/2)*kappa*rot0^2
U(a,g,m) = subs(U)

Omega(a,g,m)=0*a*g;
for i=1:(N+1)
Omega(a,g,m)= Omega(a,g,m)-p_pt(i)*w_pt(i);
end

Omega(a,g,m) = subs(Omega)

V(a,g,m)=U(a,g,m)+Omega(a,g,m)

dVa(a,g,m) = subs(diff(V,a))
dVg(a,g,m) = subs(diff(V,g))
dVm(a,g,m) = subs(diff(V,m))

eq5 = dVa == 0
eq6 = dVg == 0
eq7 = dVm == 0

[A,B] = equationsToMatrix([eq5, eq6, eq7], [a,g,m]);
X = linsolve(A,B);
a = X(1);
g = X(2);
m = X(3);
wL = subs(w(L));
delta = subs(wL);
delta = simplify(delta)



syms d_;
eqK = delta == d_;
kappa_ = solve(eqK,kappa)


Es = 210e6;
L = 9.0;
I = 0.000432;
P = 2.0;
d = 0.0172911;

 d_calc = eval(subs(delta,459680))
% delta(kappa) = eval(subs(vpa(delta)));
% 
% [N,D] = numden(delta);
tmp = delta-d;

zer = subs(tmp);

[N,D] = numden(zer);

zer = simplify(zer*D)

f = @(kappa)[eval(zer)];

sol = fzero(f,1000000.0)

%kappa = vpa(subs(kappa));

%kappa = eval(kappa)

