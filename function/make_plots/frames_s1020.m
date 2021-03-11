function [frames, deriv, titles] = frames_s1020(nd)
frames=zeros(3,nd);
frames(2,:)=ones(1,size(frames,2))*5;
frames(1,:)=ones(1,nd)*5;  %las 19 derivaciones

deriv=zeros(1,nd);
titles=zeros(nd,3);
nwx=frames(2,1);
n=1;  frames(3,n)=2;       titles(n,:)='Fp1';  deriv(n)=1;
n=2;  frames(3,n)=4;       titles(n,:)='Fp2';  deriv(n)=2;
n=3;  frames(3,n)=nwx+1;   titles(n,:)='F7 ';  deriv(n)=11;
n=4;  frames(3,n)=nwx+2;   titles(n,:)='F3 ';  deriv(n)=3;
n=5;  frames(3,n)=nwx+4;   titles(n,:)='F4 ';  deriv(n)=4;
n=6;  frames(3,n)=nwx+5;   titles(n,:)='F8 ';  deriv(n)=12;
n=7;  frames(3,n)=2*nwx+1; titles(n,:)='T3 ';  deriv(n)=13;
n=8;  frames(3,n)=2*nwx+2; titles(n,:)='C3 ';  deriv(n)=5;
n=9;  frames(3,n)=2*nwx+4; titles(n,:)='C4 ';  deriv(n)=6;
n=10; frames(3,n)=2*nwx+5; titles(n,:)='T4 ';  deriv(n)=14;
n=11; frames(3,n)=3*nwx+1; titles(n,:)='T5 ';  deriv(n)=15;
n=12; frames(3,n)=3*nwx+2; titles(n,:)='P3 ';  deriv(n)=7;
n=13; frames(3,n)=3*nwx+4; titles(n,:)='P4 ';  deriv(n)=8;
n=14; frames(3,n)=3*nwx+5; titles(n,:)='T6 ';  deriv(n)=16;
n=15; frames(3,n)=4*nwx+2; titles(n,:)='O1 ';  deriv(n)=9;
n=16; frames(3,n)=4*nwx+4; titles(n,:)='O2 ';  deriv(n)=10;
n=17; frames(3,n)=nwx+3;   titles(n,:)='Fz ';  deriv(n)=17;
n=18; frames(3,n)=2*nwx+3; titles(n,:)='Cz ';  deriv(n)=18;
n=19; frames(3,n)=3*nwx+3; titles(n,:)='Pz ';  deriv(n)=19;
titles=setstr(titles);
