program proba;
var i, max : integer;
    s, tmp : real; 
begin
max := (abs(-83)-1) div 2;
s := 0.0;
for i:=0 to max do
  begin
   tmp := 1/(1+i*2);
   if ((i mod 2) = 1) then
      tmp := 0-tmp;
   s := s+tmp;
  end;
writeln('s = ', s);
{ writeln(3*arctan(sqrt(3))); }
end.
