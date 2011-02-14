{Author: Alexander Turenko} {#18.12}
program n1812(INPUT,OUTPUT);
var cur,i,n,sum:integer;
              c:char;
           plus:boolean;
       num:array [0..100] of integer;
begin
  writeln('Enter number in Rymlian system and space at end.'); write('> ');
  read(c);
  n:=-1;
  while(c<>' ') do begin
    case c of
     'M','m': cur:=1000;
     'D','d': cur:=500;
     'C','c': cur:=100;
     'L','l': cur:=50;
     'X','x': cur:=10;
     'V','v': cur:=5;
     'I','i': cur:=1;
         else begin {Not standarted Pascal}
           cur:=0;
           writeln('Warning: symbol ''',c,''' in position ',(n+2),' is ignored.');
         end;
    end;
    n:=n+1;
    num[n]:=cur;
    read(c);
  end;

  { DCCXLVI } { CMXCIX }
  { +++-+++ } { -+-+-+ }

  sum:=num[n]; plus:=true;
  for i:=(n-1) downto 0 do begin
  if(num[i]<>0) then
   if(num[i]=num[i+1]) then
     if(plus) then
       sum:=sum+num[i]
     else sum:=sum-num[i]
   else if(num[i]<num[i+1]) then
          begin sum:=sum-num[i]; plus:=false end
        else begin sum:=sum+num[i]; plus:=true end;
  end;
  writeln(sum);
end.
