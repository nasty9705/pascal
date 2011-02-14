{Author: Alexander Turenko} {#6.17}
program n617(INPUT, OUTPUT);
var n:integer;
    c:char;
begin
  n:=0;
  writeln('Please, insert text with parentheses and dot as end symbol.'); write('>'); read(c);
  while((c<>'.') AND (n>=0)) do begin
    if(c='(') then n:=n+1;
    if(c=')') then n:=n-1;
    read(c);
  end;
  if(n=0) then writeln('All right! Parentheses in balance.')
  else writeln('Parentheses not balanced.');
end.
