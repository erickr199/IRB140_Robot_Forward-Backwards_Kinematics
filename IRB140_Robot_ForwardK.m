%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  FORWARDS KINEMATICS   %%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Erick Osvaldo Castelazo Guerra - A01273870

prompt = 'Insert value of q1: ';q1 = input(prompt);
prompt = 'Insert value of q2: ';q2 = input(prompt);
prompt = 'Insert value of q3: ';q3 = input(prompt);
prompt = 'Insert value of q4: ';q4 = input(prompt);
prompt = 'Insert value of q5: ';q5 = input(prompt);
prompt = 'Insert value of q6: ';q6 = input(prompt);


%       rotz                       tx   tz        rotx
%       theta                      aj   dj        alpha    
A1= r2t(rotz(q1,'deg'))    *transl(70,0,352) *r2t(rotx(-90,'deg'));
A2= r2t(rotz(q2-90,'deg')) *transl(360,0,0)  *r2t(rotx(0,'deg'));
A3= r2t(rotz(q3+180,'deg'))    *transl(0,0,0)    *r2t(rotx(90,'deg'));
A4= r2t(rotz(q4,'deg'))    *transl(0,0,380)  *r2t(rotx(-90,'deg'));
A5= r2t(rotz(q5,'deg'))    *transl(0,0,0)    *r2t(rotx(90,'deg'));
A6= r2t(rotz(q6,'deg'))    *transl(0,0,65)   *r2t(rotx(0,'deg'));

T06 = A1*A2*A3*A4*A5*A6;

fprintf("Homogeneus transform matrix: \n");
disp(T06);
fprintf("position vector(x,y,z): \n");
fprintf("%.2f  %.2f  %.2f\n",T06(1,4),T06(2,4),T06(3,4));
fprintf("Orientation(rx,ry,rz): \n");

rx= atan2d(T06(3,2),T06(3,3));
ry= atan2d(-T06(3,1),sqrt(T06(3,2)^2 + T06(3,3)^2));
rz= atan2d(T06(2,1),T06(1,1));
fprintf("rx: %.2f\nry: %.2f\nrz: %.2f\n",rx,ry,rz);











