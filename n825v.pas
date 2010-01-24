{Turenko Alexander. #8.25v}
program n825v(INPUT, OUTPUT);
var       c:char;
          x:array [0..9] of integer;
    i,n,max:integer;
        nan:boolean;
begin
  writeln('Please enter digits and dot at end text.'); write('> ');
  for i:=0 to 9 do x[i]:=0;

  nan:=false; read(c);
  while((c<>'.') AND (not nan)) do begin
    i:=ord(c)-ord('0');
    nan:=(i<0) or (i>9);
    if(not nan) then begin
      x[i]:=x[i]+1; read(c);
    end else writeln('NaN');
  end;

  n:=0; max := x[n];
  for i:=1 to 9 do
    if(x[i]>max) then begin
      max:=x[i];
      n:=i;
    end;

  if(not nan) then writeln('Most found digit: ', n);
end.
