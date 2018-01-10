program Placacka;

type tVektor = record
     x, y : real;
     end;

var r, v : array of tVektor; //polohové a rychlostní vekoty jednolivých much
    d, t : real; //průměr smrtící plochy, reakční čas


procedure Bouchni(p : tVektor);
begin
    //BOUCHÁM!
end;

operator + (a, b : tVektor) v : tVektor;
  begin
    v.x := a.x + b.x;
    v.y := a.y + b.y;
  end;

operator - (a, b : tVektor) v : tVektor;
  begin
    v.x := a.x - b.x;
    v.y := a.y - b.y;
  end;

operator * (r : real; a : tVektor) v : tVektor;
  begin
    v.x := r*a.x;
    v.y := r*a.y;
  end;

function vzdalenostPoCase(r1, v1, r2, v2 : tVektor; t : real) : real;
var vt1, vt2 : tVektor;
  begin
    vt1 := r1 + t*v1;
    vt2 := r2 + t*v2;
    vzdalenostPoCase := sqrt((vt1.x-vt2.x)*(vt2.x-vt2.x)+(vt1.y-vt2.y)*(vt1.y-vt2.y));
  end;

procedure ZjistiSouradniceABouchni(const r, v : array of tVektor; d, t : real);
var vmuch : real;
    pos : tVektor;
    i, j : integer;
  begin
    assert((Low(r)<>Low(v)) or (High(r)<>High(v)));

    for i := Low(r) to High(r)-1 do
        for j := i+1 to High(r) do
            begin
              vmuch := vzdalenostPoCase(r[i], v[i], r[j], v[j], t);
              if vmuch < d then
                 begin
                      pos := (0.5*((r[i] + t*v[i])-(r[j] + t*v[j]))) + (r[i] + t*v[i]);
                      Bouchni(pos);
                 end;
            end;
  end;

begin
  //NIC NEPOBĚŽÍ! :)))
end.    
