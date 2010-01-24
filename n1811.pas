{Turenko Alexander. #18.11}
program n1811(INPUT, OUTPUT);
var st,delta,n,deltaf:integer;
                    c:char;
begin
   st:=1;
   {delta:=1024-st;}
   delta:=999-st;
   n:=1;
   writeln('Use character "y" for reply YES or any except y (for example "n") for reply NOT.');
   while(delta>1) do
   begin
     deltaf := ord(delta mod 2 = 0);
     delta:=(delta div 2);
     write(n:2,'. In [', st:3, ', ', (st+delta):3, ']? : '); readln(c);
     n:=n+1;
     if(c <> 'y') then begin
       st:= st + delta + 1;
       delta:=delta-deltaf;
     end;
   end;
   if(delta=1) then begin
     write(n,'. It ', st,'? : '); readln(c);
     if (c <> 'y') then st:= st + delta;
     end;
writeln('Result: ',st);
end.