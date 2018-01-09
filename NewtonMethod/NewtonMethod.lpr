program NewtonMethod;

const rank = 10;

type polynom = array [0 .. rank] of real;
type realfunkce = function(const x : real) : real;

function Vycislip(const p : polynom; const x : real) : real;
  var rs, helper : real;
      i, j : integer;
  begin
    rs := 0;
    for i := 0 to rank do begin
      helper := p[i];
      if helper <> 0 then begin
        for j := 1 to i do begin
          helper := helper * x;
        end;
      end;
      rs := rs + helper;
    end;
    Vycislip := rs;
  end;

function Derivate(const p : polynom) : polynom;
  var rs : polynom;
      i : integer;
  begin
     for i:= 0 to rank-1 do begin
        rs[i] := p[i+1] * i+1;
     end;
     Derivate[rank] := 0;
     Derivate := rs;
  end;

function NumDeriv(const f : realfunkce; x, dx : real) : real;
  var h : real;
  begin
     h := dx/2;
    numDeriv := (f(x+h)-f(x-h))/dx
  end;

function Integrate(const f : realfunkce; a, b, dx : real) : real;
  var l, h, rslt, coef : real;
  begin
    rslt := 0;
    if a = b then begin
      Integrate := rslt;
      end
    else
        if a > b then begin
          coef := -1;
          l := b;
          h := a;
        end
        else begin
          coef := 1;
          l := a;
          h := b;
        end;
    while l < h do begin
      rslt := rslt + f(l)*dx;
      l := l + dx;
    end;
    Integrate := rslt * coef;
  end;

function PrusecikTecny(const p : polynom; const x : real) : real;
  var der : polynom;
      h, dh : real;
  begin
    der := Derivate(p);
    h := Vycislip(p, x);
    dh := Vycislip(der, x);
    PrusecikTecny := x - (h/dh);
  end;

function PrusecikTecny(const f, df : realfunkce; x : real) : real;
  var h, dh : real;
  begin
    h := f(x);
    dh := df(x);
    PrusecikTecny := x - (h/dh);
  end;

function PrusecikTecny(const f : realfunkce; x, err : real) : real;
  var h, dh : real;
  begin
    h := f(x);
    dh := NumDeriv(f, x, err);
    PrusecikTecny := x - (h/dh);
  end;

function fce(const x : real) : real;
  begin
    fce := exp(x)-exp(-2*x)+x*x*x+8;
  end;

function dfce(const x : real) : real;
  begin
    dfce := exp(x)+2*exp(-2*x)+3*x*x;
  end;

function nfce(const x : real) : real;
  begin
    nfce := sin(x);
  end;

function ifce(const x: real) : real;
    var fc : realfunkce;
  begin
    fc := @nfce;
    ifce := Integrate(fc, fc(x), fc(6*x), 10e-3)
  end;

const {p : polynom = (-1,-5,0,3,0,2,0,0,0,0,0);} {1+x+x^2+x^3+...+x^10}
      err : real = 10e-10;
      x0 : real = 6;
      {
      f  : realfunkce = @fce;
      df : realfunkce = @dfce;
      }
      nf : realfunkce = @ifce;
var intr : real;

begin
  intr := x0;
  {
  repeat
    intr := PrusecikTecny(p, intr);
    Writeln(intr, ' => ' ,Vycislip(p, intr));
  until abs(Vycislip(p, intr)) < err;
  }
  repeat
    intr := PrusecikTecny(nf, intr, err);
    Writeln(intr, ' => ' ,nf(intr));
  until abs(nf(intr)) < err;

  Writeln('Done! Root is at ', intr:2:10, ' with error of ', err:2:14);
  Readln;
end.
                                                        
