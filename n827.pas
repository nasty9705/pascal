program n827(INPUT, OUTPUT);
const n=80;
var i,j:integer;
      x:array [1..n] of char;
begin
  {На всякий случай}
  for j:=1 to n do x[j]:='*';
  {Ввод}
  writeln('Please enter text with number and other symbols (80 character):'); write('> ');
  for j:=1 to n do read(x[j]);
  {Вывод}
  writeln; writeln('*Sorted*');
  for i:=0 to 1 do
    for j:=1 to n do
      if((x[j]>='0') AND (x[j]<='9'))
        then if(i=0) then write(x[j]) else {ничего не делаем}
        else if(i=1) then write(x[j]);
  writeln; {Для красоты}
end.