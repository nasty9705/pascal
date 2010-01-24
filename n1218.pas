{Turenko Alexander, #12.18}
program n1218(INPUT, OUTPUT);
var a, b:integer;

function NOD(a,b:integer):integer;
var tmp:integer;
begin
  if(a=b)
    then NOD:=a
    else if(a>b)
           then NOD:=NOD(a-b,b)
           else NOD:=NOD(a,b-a);
end;

begin
  writeln('Enter two number: '); write('> ');
  read(a); read(b);
  writeln('NOD: ',NOD(a,b));
end.