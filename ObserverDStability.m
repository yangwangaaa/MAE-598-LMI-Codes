%MATLAB-YALMIP example implementation of the continuous-time D-stability observer.

A = [-1.3410 0.9933 0 -0.1689 -0.2518
    43.2230 -0.8693 0 -17.2510 -1.5766
    1.3410 0.0067 0 0.1689 0.2518
    0 0 0 -20.0000 0
    0 0 0 0 -20.0000];
B = [0 0
    0 0
    0 0
    20 0
    0 20];%parameters used for this example
[~,n]=size(A);
[c1,c2]=size(B);
P4=sdpvar(n,n);Z2=sdpvar(c1,c2);
options = sdpsettings('solver','sedumi');
F2=[P4>=1e-5*eye(n)];
F2=[F2,[(-r*P4),(P4*A+Z2*C)';(P4*A+Z2*C),(-r*P4)]<=1e-5*eye(2*n)];
F2=[F2,(P4*A+Z2*C)'+P4*A+Z2*C+2*alpha*P4<=1e-5*eye(n)];
F2=[F2,[((P4*A+Z2*C)'+P4*A+Z2*C),c*((P4*A+Z2*C)'-(P4*A+Z2*C));c*((P4*A+Z2*C)-(P4*A+Z2*C)'),((P4*A+Z2*C)'+P4*A+Z2*C)]<=1e-5*eye(2*n)];
optimize(F2,[],options);%execute the given problem
Z2=value(Z2);P4=value(P4);
L=inv(P4)*Z2%display the resulting L matrix
ApLC_eig=eig(A+L*C)%display the resulting eigenvalues of A+LC
%Note that all the real part of eigenvalues of A+LC are negative, hence
%stable.
