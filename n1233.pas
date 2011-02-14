{Author: Alexander Turenko} {#12.33}
program n1233(INPUT, OUTPUT);
const n=10;
type stack = array [0..n] of integer;
var A,B,C:stack;
    i,debug_level:integer;

function put(var X:stack; element:integer):boolean;
var i:integer;
begin
  i:=n;
  while((X[i]<=0)AND(i>=1)) do
    i:=i-1;
  if(i>n)
    then put:=false
    else begin
      X[i+1]:=element;
      put:=true;
    end;
end;

function getStackName(var X:stack):char;
begin
  case X[0] of
    0: getStackName:='A';
    1: getStackName:='B';
    2: getStackName:='C';
  end;
end;

function get(var X:stack):integer;
var i:integer;
begin
i:=n;
while((X[i]<=0)AND(i>=1)) do
  i:=i-1;
if(i=0) then
  get:=0
  else begin
    get:=X[i];
    X[i]:=0;
  end;
end;

function move(var X,Y:stack):boolean;
var element:integer;
      moved:boolean;
begin
  if (debug_level>=1) then writeln('Transfering element: ',getStackName(X),' --> ',getStackName(Y));
  element:=get(X);
  if(element=0) then begin
    move:=false;
    writeln('Failed move: unable to *get* element.');
  end else begin
    moved:=put(Y,element);
    move:=moved;
    if(moved) then writeln('Element ', element,' moved: ',getStackName(X),' --> ',getStackName(Y))
    else writeln('Failed move : unable to *put* element: ', element);
  end;
end;

procedure show(var X,Y,Z:stack);
var i,j:integer;
begin;
  writeln('Show state...');
  write('    *',getStackName(X),'*    ');
  write('    *',getStackName(Y),'*    ');
  write('    *',getStackName(Z),'*    ');
  writeln;
  for i:=n downto 1 do begin
     for j:=1 to X[i] do write('#');
     for j:=X[i]+1 to n do write('-');
     write(' ');
     for j:=1 to Y[i] do write('#');
     for j:=Y[i]+1 to n do write('-');
     write(' ');
     for j:=1 to Z[i] do write('#');
     for j:=Z[i]+1 to n do write('-');
     writeln;
  end;
end;

{ От куда, свободный стек, куда }
procedure moveN(var X,Y,Z:stack; k:integer);
begin
  if(debug_level>=1) then writeln('called moveN(',getStackName(X),',',getStackName(Y),',',getStackName(Z),',',k);
  if(debug_level>=2) then show(X,Y,Z);
  if (k>1) then begin
    moveN(X, Z, Y, k-1);
    move(X, Z);
    moveN(Y, X, Z, k-1);
  end else begin
    move(X, Z);
  end;
end;

begin
  { ID стека. }
  A[0]:=0;
  B[0]:=1;
  C[0]:=2;
  { Начальное состояние. }
  for i:=1 to n do begin
    A[i]:=n-i+1;
    B[i]:=0;
    C[i]:=0;
  end;
  { Смотрим. }
  show(A, B, C);

  writeln('This program transfer all elements *A* to *B*.');
  writeln('Choose debug level to "normal", "verbose" or "DEBUG" (0-2):');
  write('> '); read(debug_level);
  if (debug_level<0) then begin
    debug_level:=0;
    writeln('Debug level out of range! Changed to ',debug_level,'.');
  end else if (debug_level>2) then begin
    debug_level:=2;
    writeln('Debug level out of range! Changed to ',debug_level,'.');
  end;
  writeln('Ok, continue...');
  { Поехали! }
  moveN(A, B, C, n);

  writeln('GET! Looking and take pleasure :-)');
  { Проверяем. }
  show(A, B, C);
end.
