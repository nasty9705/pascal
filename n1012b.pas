{Turenko Alexander, #10.12b}
program n1012b(INPUT, OUTPUT);
var letters:packed array [1..33] of char;
      c1,c2:char;
    c1i,c2i:integer;
          b:boolean;
begin
  letters:='abcdefghijklmnopqrstuvwxyz';
  writeln('Enter text with english small letters and dot at end:'); write('> ');
  read(c1,c2); b:=true;
  while(c2<>'.') do begin
    c1i:=1; c2i:=1;
    while(c1 <> letters[c1i]) do c1i:=c1i+1;
    while(c2 <> letters[c2i]) do c2i:=c2i+1;
    b:=b AND (c1i<c2i);
    c1:=c2;
    read(c2);
    end;
  if(b) then writeln('Sorted.')
        else writeln('Unsorted.');
end.
