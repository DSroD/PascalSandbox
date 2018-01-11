program Strela;

Uses math;

type tVektor = record
     x, y, z : real;
     end;

type tSouradnice = record
     sSirka, vDelka : real;
     end;

operator + (a, b : tVektor) c : tVektor;
     begin
         c.x := a.x + b.x;
         c.y := a.y + b.y;
         c.z := a.z + b.z;
     end;

function Delka(a : tVektor) : real;
     begin
          delka := sqrt(a.x * a.x + a.y * a.y + a.z * a.z);
     end;

function SouradniceToVektor(a : tSouradnice; R : real) : tVektor;
     var theta, fi : real;
         k : real = pi/180;
     begin
         theta := k*(90-a.sSirka);
         fi := k*a.vDelka;

         result.x := R*sin(theta)*cos(fi);
         result.y := R*sin(theta)*sin(fi);
         result.z := R*cos(theta);

         SouradniceToVektor := result;
     end;

function VektorToSouradnice(a : tVektor) : tSouradnice;
     var theta, fi, R : real;
         k : real = 180/pi;
     begin
         R := Delka(a);
         theta := arccos(a.z/R);
         fi := arctan2(a.y, a.x);

         result.sSirka := 90-theta*k;
         result.vDelka := fi*k;

         VektorToSouradnice := result;
     end;

const R = 6378;

function VrcholDrahy(a, b : tSouradnice) : tSouradnice;
     var va, vb, s : tVektor;
     begin
         va := SouradniceToVektor(a, R);
         vb := SouradniceToVektor(b, R);

         s := va + vb;

         result := VektorToSouradnice(s);

         VrcholDrahy := result;
     end;

var a, b, v : tSouradnice;
begin
  a.sSirka := 55;
  a.vDelka := 15;
  b.sSirka := 73;
  b.vDelka := 22;

  v := VrcholDrahy(a, b);

  Writeln(v.sSirka:2:5,' s.s., ', v.vDelka:2:5, ' v.d.');
  Readln;
end.
