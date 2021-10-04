%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  BACKWARDS KINEMATICS  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Erick Osvaldo Castelazo Guerra - A01273870

fprintf("Insert end-effector position(x,y,z)\n");
prompt = 'X: ';Xt = input(prompt);
prompt = 'Y: ';Yt = input(prompt);
prompt = 'Z: ';Zt = input(prompt);
fprintf("Insert end-effector orientation(rx,ry,rz)\n");
prompt = 'rx: ';rx = input(prompt);
prompt = 'ry: ';ry = input(prompt);
prompt = 'rz: ';rz = input(prompt);
R06 = rotx(rx,'deg')*roty(ry,'deg')*rotz(rz,'deg');


% %End effector coordinates(Xt,Yt,Zt)
% Xt=640;
% Yt=-316;
% Zt=724;
% %End effector orientation(R06)
% R06=[0 0 1;0 1 0;-1 0 0];%rx=0  ry=90  rz=0

%Wrist point coordinates(X,Y,Z)
pw = [Xt; Yt; Zt] + R06*[0;0;-65];
X=pw(1);
Y=pw(2);
Z=pw(3);

%Link Dimensions
a1=352; a2=70; %link 1
a3=360;        %link 2
a4=380;        %link 3

%%Backwards Kinematics Position(q1,q2,3)%%
r1 = sqrt(X^2+Y^2) -a2;
r2 = Z - a1;
r3 = sqrt(r1^2+r2^2);
%elbow up
phi1 = acosd((a4^2-a3^2-r3^2)/(-2*a3*r3));
phi2 = atan2d(r2,r1);
phi3 = acosd((r3^2-a4^2-a3^2)/(-2*a4*a3));

q_1 = atan2d(Y,X); 
q_2 = 90 - phi2 - phi1;
q_3 = 90 - phi3;

%%Backwards kinematics Orientation(q4,q5,q6)%%
%Rotation R03
R_A1= rotz(q_1,'deg')    *rotx(-90,'deg');
R_A2= rotz(q_2-90,'deg') *rotx(0,'deg');
R_A3= rotz(q_3+180,'deg')*rotx(90,'deg');
R03 = R_A1*R_A2*R_A3;

R36 = inv(R03)*R06;

q_5 = acosd(R36(3,3));
q_4 = atand(R36(2,3)/R36(1,3));
q_6 = atand(-R36(3,2)/R36(3,1));

q_4(isnan(q_4)) = 0;
q_6(isnan(q_6)) = 0;

fprintf("Joint values\n");
%position joints
fprintf('q1: %.2f\n',q_1);
fprintf('q2: %.2f\n',q_2);
fprintf('q3: %.2f\n',q_3);
%orientation joints
fprintf('q4: %.2f\n',q_4);
fprintf('q5: %.2f\n',q_5);
fprintf('q6: %.2f\n',q_6);

