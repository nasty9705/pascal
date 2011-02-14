{Author: Alexander Turenko} {#11.41}
program n1141(OUTPUT);
var it:integer;
    bt:boolean;
function y:integer;
begin
  y:=it;
  it:=it+1;
end;

function b:boolean;
begin
  b:=bt;
  bt:=(not bt);
end;

begin
  it := 0;
  bt := false;
  write('write(y=y); '); write(y=y); writeln;
  write('write(y+y=2*y); '); write(y+y=2*y); writeln;
  write('write(b and b = b); '); write(b and b = b); writeln;
end.
