{Turenko Alexander. #5.21v}
program n521v;
var n1,n2,s:integer;
begin
   n1:=1; n2:=1; s:=n1;
   while(n2<=1000) do
   begin
      s:=s+n2;
      n2:=n2+n1;
      n1:=n2-n1;
   end;
   writeln('s: ',s);
end.
