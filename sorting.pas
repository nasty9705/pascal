{Turenko Alexander, Project 3, 5.7}
program sorting;
uses crt;
const start_year=1930; {1930-2029}
      max_index_of_sequence=99;
type date = record d,m,y:integer end;
     sequence = array [0..max_index_of_sequence] of date;
     dstring = array [0..7] of char; { 'xx.xx.xx' }
     arint5 = array [0..4] of integer;
     arint4 = array [0..3] of integer;
     arstr10 = array [0..9] of string;
var compares, moves:integer;
    seq:sequence;
    sorting_names:arstr10;

{ Вернуть среднее значение целочисленного массива
  по первым size элементам }
function average(var ar:arint5; size:integer):integer;
var i,sum:integer;
begin
  sum:=0;
  for i:=0 to (size-1) do
    sum:=sum+ar[i];
  average:=trunc((sum/size)+0.5);
end;

procedure date2str(var str:dstring; date1:date);
begin
  with date1 do begin
    str[0]:=chr(ord('0')+(d div 10));
    str[1]:=chr(ord('0')+(d mod 10));
    str[2]:='.';
    str[3]:=chr(ord('0')+(m div 10));
    str[4]:=chr(ord('0')+(m mod 10));
    str[5]:='.';
    str[6]:=chr(ord('0')+(y div 10));
    str[7]:=chr(ord('0')+(y mod 10));
  end;
end;

function date2int(var date1:date):integer;
var year, month, day:integer;
begin
  with date1 do begin
{ Преобразуем год в величину от -50 до 49 так,
  чтобы большему году соответствовала большая
  величина }
  year:=y-(start_year mod 100);
  if (year<0) then
     year:=year+100;
  year:=year-50;

{ Месяц: от -6 до 5 }
  month:=m-7;

{ День: от -15 до 15 }
  day:=d-16;

  date2int:=(year*372)+(month*31)+day; {31*12=372}
{ TODO: подумать, не надо ли умножить month*32, а year*373}
end;
end;

{ Возвращает:
    отрицательное число, если date1<date2
    нуль, если date1=date2
    положительное число, если date1>date2 }
function compare(var date1,date2:date):longint;
begin
  compare:=(date2int(date1)-date2int(date2));
end;

{ Возвращает:
    True, если date1<=date2
    False, если date1>date2 }
function bcompare(var date1,date2:date):boolean;
begin
  compares:=compares+1;
  bcompare:=(compare(date1,date2)<=0);
end;

procedure warning;
begin
  writeln('Галактеко опасносте!!! Пыщь-пыщь!');
end;

{ Отсортировать последовательность seq размера size
  по неубыванию
  с помощью сортировки простым выбором }
procedure psort(var seq:sequence; size:integer);
var sorted,index_min,i:integer;
    tmp:date;
begin
{ Проверка на вшивость}
if ((size-1)>max_index_of_sequence) then
  warning
else begin
{ Обнуляем счётчики сравнений и перестановок }
  compares:=0; moves:=0;
{ sorted - счётчик количества упорядоченных 
  (в начале массива) элементов }
  for sorted:=0 to (size-1) do begin
  { Находим минимальный среди неупорядоченных элементов }
    index_min:=sorted;
    for i:=(sorted+1) to (size-1) do
      if (not bcompare(seq[index_min], seq[i])) then
        index_min:=i;
  { Меняем минимальный с первым неотсортированным }
    tmp:=seq[sorted];
    seq[sorted]:=seq[index_min];
    seq[index_min]:=tmp;
    moves:=moves+1;
  end;
end;
end;

{ Отсортировать последовательность seq размера size
  по неубыванию
  рекурсивным методом быстрой сортировки }
procedure qsort(var seq:sequence; size:integer);

procedure sort(var seq:sequence; start_index,end_index:integer);
var l,r,size:integer;
    x,tmp:date;
begin
  size:=end_index-start_index;
  if size<4 then begin { Сортировать пузырьком }
    repeat
      r:=moves;
      for l:=0 to (size-2) do
        if (not bcompare(seq[l],seq[l+1])) then begin
          tmp:=seq[l];
          seq[l]:=seq[l+1];
          seq[l+1]:=tmp;
          moves:=moves+1;
        end; {for}
    until (r=moves);
  end else begin
    l:=start_index;
    r:=end_index;
    x:=seq[start_index+trunc(random(size+1))];
    repeat
      while not bcompare(x, seq[l]) do
        l:=l+1;
      while not bcompare(seq[r], x) do
        r:=r-1;
      if l<=r then begin
        tmp:=seq[l];
        seq[l]:=seq[r];
        seq[r]:=tmp;
        moves:=moves+1;
        l:=l+1;
        r:=r-1;
      end;
    until l>r;
    if start_index<r then
      sort(seq, start_index, r);
    if l<end_index then
      sort(seq, l, end_index);
  end;
end;

begin
{ Обнуляем счётчики сравнений и перестановок }
  compares:=0; moves:=0;
  sort(seq,0,size-1);
end;

{ Високосен ли год?
True - високосный
False - невисокосный }
function is_leap_year(year:integer):boolean;
begin
  if (year mod 4)=0 then
    if (year mod 100)=0 then
      if (year mod 400)=0 then
        is_leap_year:=true
      else is_leap_year:=false
    else is_leap_year:=true
  else is_leap_year:=false
end;

{ Возвращает количество дней в данном месяце данного года }
function days_in_month(year, month:integer):integer;
var m:integer;
begin
  if month=2 then
    if is_leap_year(year) then
      days_in_month:=29
    else days_in_month:=28
  else begin
         m:=month;
         if m>7 then
           m:=m-1;
         days_in_month:=30+(m mod 2)
       end;
end;

procedure new_date(var date1:date; year, month, day:integer);
begin
  with date1 do begin
    y:=year;
    m:=month;
    d:=day;
  end;
end;

{ Сгенерировать последовательность дат из n элементов в
  зависимости от значения f такую, что:
0 - элементы упорядочены по неубыванию;
1 - элементы упорядочены по невозрастанию;
2 - элементы с нечетными индексами упорядочены по неубыванию, а с
    четными индексами - по невозрастанию;
3,4 - случайная расстановка элементов; }
procedure genseq(var seq:sequence; n,f:integer);
var i,year,month,day:integer;
begin
  if (f>4) OR (f<0) then
    warning
  else for i:=0 to (n-1) do begin
         case f of
           0: year:=trunc((random(100)/n)+(100/n)*i)+(start_year mod 100);
           1: year:=trunc((random(100)/n)+(100/n)*(n-1-i))+(start_year mod 100);
           2: year:=trunc((random(100)/n)+(100/n)*(i*(i mod 2)+(n-1-i)*((i+1) mod 2)))+(start_year mod 100);
         3,4: year:=trunc(random(100));
         end;

         if year>99 then
           year:=year-100;
         month:=1+trunc(random(12));
         day:=1+trunc(random(days_in_month(year, month)));

         new_date(seq[i],year,month,day);
       end;
end;

{ Вывести на экран последовательность seq из n элементов }
procedure showseq(var seq:sequence; n:integer);
var i:integer;
    str:dstring;
begin
  writeln('------------');
  for i:=0 to (n-1) do begin
    if ((n-1)>9) AND (i<10) then
      write(' ');
    write(i,': ');

    date2str(str, seq[i]);
    writeln(str);
  end;
end;

{ Обёртка для вызова одной из сортировок }
procedure sort_by(var seq:sequence; size,f:integer);
begin
  if (f>9) OR (f<0) then
    warning
  else case f of
         4: psort(seq, size);
         6: qsort(seq, size);
       end;
end;

procedure show_statistic(sorting_number:integer);
var sizes:arint4;
    armoves,arcompares:arint5;
    i,j:integer;
begin
  sizes[0]:=10;
  sizes[1]:=20;
  sizes[2]:=50;
  sizes[3]:=100;
  writeln('		',sorting_names[sorting_number]);
  writeln('-----------------------------------------------------------');
  writeln('|   n | параметр    | номер последовательности | среднее  |');
  writeln('|     |             |   1    2    3    4    5  | значение |');

  for i:=0 to 3 do begin
    writeln('-----------------------------------------------------------');
    write('| ',sizes[i]:3,' | сравнения   |');
    for j:=0 to 4 do begin
      genseq(seq, sizes[i], j);
      sort_by(seq, sizes[i], sorting_number);
      arcompares[j]:=compares;
      armoves[j]:=moves;
      write(' ',compares:4);
    end;
    writeln(' | ',average(arcompares, 5):4,'     |');
    write('| ',sizes[i]:3,' | перемещения |');
    for j:=0 to 4 do
      write(' ',armoves[j]:4);
    writeln(' | ',average(armoves, 5):4,'     |');
  end;
  writeln('-----------------------------------------------------------');
end;

procedure init;
begin
  randomize;

  sorting_names[0]:='Сортировка простыми вставками';
  sorting_names[1]:='Сортировка бинарными вставками';
  sorting_names[2]:='Метод пузырька';
  sorting_names[3]:='Челночная сортировка';
  sorting_names[4]:='Сортировка простым выбором';
  sorting_names[5]:='Метод Шелла';
  sorting_names[6]:='Быстрая сортировка, рекурсивный вариант';
  sorting_names[7]:='Быстрая сортировка, нерекурсивный вариант';
  sorting_names[8]:='Сортировка простым слиянием';
  sorting_names[9]:='Сортировка естественным слиянием';
  sorting_names[0]:='Сортировка простыми вставками';
  textmode(3);
  clrscr;
end;

{ Нарисовать кнопку:
x,y - координаты левого верхнего угла
value - надпись }
procedure draw_button(x,y:integer; value:string);
var i,l:integer;
begin
  l:=length(value);

  gotoxy(x,y);
  write('┌');
  for i:=0 to (l-1) do
    write('─');
  write('┐');
  gotoxy(x,y+1);
  write('│'); write(value); write('│');
  gotoxy(x,y+2);
  write('└');
  for i:=0 to (l-1) do
    write('─');
  writeln('┘');
end;

{ Нарисовать список:
x,y - координаты левого верхнего угла
size - кол-во строк
value - массив надписей 
focus - индекс подсвеченного элемента }
procedure draw_list(x,y,size,focus:integer; value:arstr10);
var i,maxlength:integer;
begin
  maxlength:=(length(value[0]) div 2);
  for i:=1 to (size-1) do
    if (length(value[i]) div 2)>maxlength then
      maxlength:=(length(value[i]) div 2);
  

  gotoxy(x,y);
  write('┌');
  for i:=0 to (maxlength-1) do
    write('+');
  write('┐');


  for i:=0 to (size-1) do begin
    gotoxy(x,y+i+1);
    write('│'); write(value[i]);
    gotoxy(x+maxlength,y+i+1);
    write('│');
  end;

  gotoxy(x,y+size+1);
  write('└');
  for i:=0 to (maxlength-1) do
    write('=');
  writeln('┘');
end;

begin
  init;

  {draw_button(10, 12, 'Ok');}

  
{  draw_list(2, 2, 10, 0, sorting_names);}

  {gotoxy(5,5);
  writeln(' ─ │ ┌ ┐ └ ┘ ├ ┤ ┬ ┴ ┼ ═ ║ ╔ ╗ ╚ ╝ ╦ ╩ ╬ ╠ ╣ ╒ ╓  ╕ ╖ ╘ ╙ ╛ ╜ ╞ ╟ ╡ ╢ ╤ ╥ ╧ ╨ ╪ ╫ ');
}
{ Смотрим статистику}
  show_statistic(4); writeln;
  show_statistic(6);


{ Проверочки
  genseq(seq,70,0);
  showseq(seq,70);
  seq1:=seq;

  psort(seq,70);
  writeln('psort: compares: ',compares:5,'; moves: ',moves,';');

  qsort(seq1,70);
  writeln('qsort: compares: ',compares:5,'; moves: ',moves,';');
  readln;
  showseq(seq,70);
}
end.
{ ─ │ ┌ ┐ └ ┘ ├ ┤ ┬ ┴ ┼ ═ ║ ╔ ╗ ╚ ╝ ╦ ╩ ╬ ╠ ╣ ╒ ╓  ╕ ╖ ╘ ╙ ╛ ╜ ╞ ╟ ╡ ╢ ╤ ╥ ╧ ╨ ╪ ╫ }
