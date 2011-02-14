{Author: Alexander Turenko}
program proba;

procedure write_spaces(k,n:integer);
var i,len:integer;
begin
  if k>0 then
    len:=trunc(ln(k)/ln(10))+1
  else len:=1;
  for i:=(len+1) to n do
    write('#');
end;

var i: integer;
    {s, tmp : real;} 
    str:utf8string;
begin
{
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
}
{
for i:=0 to 12 do begin
  write(i);
  write_spaces(i,3);
  writeln;
end;

for i:=97 to 112 do begin
  write(i);
  write_spaces(i,3);
  writeln;
end;

for i:=999 to 1000 do begin
  write(i);
  write_spaces(i,3);
  writeln;
end;
}
{
writeln('─');
str:='─';
writeln(str);
}

for i:=0 to 255 do
  write(chr(i));
end.
