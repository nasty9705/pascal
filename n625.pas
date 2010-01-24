{Turenko Alexander. #6.25}
program n625(INPUT, OUTPUT);
var c:char;
begin
  writeln('Please, insert text with "," as symbol newline and "." as end symbol.'); write('>'); read(c);
  while(c<>'.') do begin
    if(c=',') then writeln(',')
    else write(c);
    read(c);
  end;
end.