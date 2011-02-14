{Author: Alexander Turenko} {#5.28}
program n528;
const n = 70;
var s:integer;
    x:real;
begin
   s:=0; x:=-1;
   while (s<n) and (x<0) do
   begin
      write('Insert next element (#',s,'): '); readln(x);
      s:=succ(s);
   end;
   s:=pred(s);
   writeln('s: ',s);
end.
