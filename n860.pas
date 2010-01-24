{Turenko Alexander. #8.60}
program n860(OUTPUT);
var i,s,sn,n:longint;
begin
  s:=0;
  for n:=0 to 27 do begin
    sn:=0;
    for i:=0 to 999 do
      sn:=sn+ord(((i div 100)+((i div 10) mod 10)+(i mod 10))=n);
    s:=s+sn*sn;
    {DEBUG} write(sn:4);
  end;
  {DEBUG} writeln;
  writeln('Happy bus bilets: ',s);
end.