program Proud;

function Spocti(i0, u, ut, rs, i : real) : real; //Protože hledáme kde I_0(exp((U-Rs I)/Ut)-1)-I = 0, bude tato funkce počítat levou stranu této rovnice
begin
    result := i0*exp((u - rs*i)/ut) - i0 - i;
    Spocti := result;
end;

function sgnum(x : real) : real; //Pro určení znamének
begin
     if x < 0 then sgnum := -1;
     if x = 0 then sgnum := 0;
     if x > 0 then sgnum := 1;
end;

function najdiKoren(i0, u, ut, rs, epsilon : real) : real; //Metoda půlení intervalů - hledáme v jakém intervalu se mění znaménko - tam je hodnota = 0
     var min, max, stred, hodnota : real;
begin
     if u < 0 then
     begin //Pokud je U záporné, bude největší proud minimum, nejmenší proud bude odpovídat I=0;
       min := u/rs;
       max := i0*exp(u/ut) - i0;
       end else begin //Pokud U kladné, je pak I v intervalu  od nuly do U/Rs.
         max := u/rs;
         min := i0*exp(u/ut) - i0;
         end;
     stred := (max+min)/2.0;

     hodnota := spocti(i0, u, ut, rs, stred);

     while abs(hodnota) < epsilon do //Půlení intevalů až do požadované přesnosti
           begin
                if sgnum(spocti(i0, u, ut, rs, min)) <> sgnum(hodnota) then //Zjisti kde se mění znaménko (někde se musí měnit) a ten interval vyber pro další půlení.
                   max := stred
                else
                   min := stred;
                stred := (max+min)/2.0;
                hodnota := spocti(i0, u, ut, rs, stred);
           end;
     najdiKoren := stred; //Vypíše pro které I je funkce spocti 0.
end;

begin
  //Program psát nebudu #lenoch
end. 
