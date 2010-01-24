{Author: Turenko Alexander}
program n1639(INPUT, OUTPUT);
type str  = packed array [1..10] of char;
     sex_type = (M,W);
     marks_type = 2..5;
     stud = record {Информация об одном студенте}
              fn:record
                   fam, name: str; {фамилия, имя}
                 end;
              sex:sex_type; {пол}
              marks:array [1..5] of marks_type; {пять оценок}
            end;
     group = array [1..10] of stud;
     fstud = file of stud;

var group118:group;
    f:fstud;

procedure new_stud(var s:stud; fam, name:str; sex:sex_type; m1,m2,m3,m4,m5:marks_type);
begin
   s.fn.fam:=fam;
   s.fn.name:=name;
   s.sex:=sex;
   s.marks[1]:=m1;
   s.marks[2]:=m2;
   s.marks[3]:=m3;
   s.marks[4]:=m4;
   s.marks[5]:=m5;
end;

procedure new_group(var g:group);
var cur_stud:stud;
begin
  new_stud(cur_stud, 'Озмитель  ', 'Андрей    ', M, 5,5,5,4,5);
  g[1]:=cur_stud;
  new_stud(cur_stud, 'Маресов   ', 'Роман     ', M, 5,5,5,4,3);
  g[2]:=cur_stud;
  new_stud(cur_stud, 'Вершинина ', 'Елизавета ', M, 4,3,5,4,4);
  g[3]:=cur_stud;
  new_stud(cur_stud, 'Хамелеон  ', 'Обыкновен.', M, 5,5,5,5,5);
  g[4]:=cur_stud;
  new_stud(cur_stud, 'Козлов    ', 'Имярек    ', M, 4,2,5,3,3);
  g[5]:=cur_stud;
  new_stud(cur_stud, 'Иванов    ', 'Сергей    ', M, 4,5,4,4,5);
  g[6]:=cur_stud;
  new_stud(cur_stud, 'Фурсенок  ', 'Андрей    ', M, 2,2,2,2,2);
  g[7]:=cur_stud;
  new_stud(cur_stud, 'Корень    ', 'Знаний    ', M, 5,5,5,5,5);
  g[8]:=cur_stud;
  new_stud(cur_stud, 'Вычетов   ', 'Группа    ', M, 4,5,3,4,3);
  g[9]:=cur_stud;
  new_stud(cur_stud, 'Науки     ', 'Гранит    ', M, 5,5,5,5,5);
  g[10]:=cur_stud;
end;

procedure write_to_file(var f:fstud; var g:group);
var i:integer;
begin
   assign(f, 'group118.records');
   rewrite(f);
   for i:=1 to 10 do begin
      write(f, g[i]);
   end;
end;

begin
   new_group(group118);
   write_to_file(f, group118);
   writeln('Data writing to file "group118.records".');
end.