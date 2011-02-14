{Author: Alexander Turenko} {#6.34}
program n634(INPUT, OUTPUT);
var n,z,znak:integer;
           c:char;
begin
  writeln('Please, insert "d1(+/-)d2(+/-)...dn.", where di - nubmer, n>1. For example "1+2-5+7-9+6."');
  write('>'); read(c);
  znak:=1; z:=0; n:=0;
  while(c<>'.') do begin
    if((ord(c)>=ord('0')) AND (ord(c)<=ord('9'))) then begin
           n:=ord(c)-ord('0');
           n:=znak*n;
           z:=z+n;
         end
    else begin
           if(c='-') then znak:=-1;
           if(c='+') then znak:=1;
         end;
    read(c);
  end;
  writeln('Summa: ',z);
end.
