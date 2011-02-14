{Author: Alexander Turenko} {#8.41g}
program n841g(INPUT, OUTPUT);
const
  n=10{100};
var
        x:array [1..n] of real;
      k,i:integer;
    a,b,c:integer;
  current:real;
begin
  {Ввод массива}
  for i:=1 to n do begin
    write('Enter x[',i:3,']: '); readln(x[i]);
  end;
  {Сортировка}
  for k:=1 to n-1 do begin
    current:=x[k+1];
     a:=0; b:=k+1;
    while((b-a)>1) do begin
      c:=(a+b) div 2;
      if(x[c]=current) then begin b:=c+1; a:=b; end
        else if(x[c]<current) then a:=c else b:=c;
    end;
      for i:=k downto b do
        x[i+1]:=x[i];
      x[b]:=current;
  end;
  {Вывод}
  writeln;writeln('*Sorted*');
  for i:=1 to n do
    writeln('x[',i:3,'] = ',x[i]:5:2,';');
end.
