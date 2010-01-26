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

     list = ^item;
     item = record
              elem:stud;
              next:list;
            end;
var group118:group;
    f:fstud;
    sort_by:integer;

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

function compare(a, b:stud):integer;
begin
write('Called compare [',a.fn.fam,'] vs [',b.fn.fam,']: ');
{   if(a=nil && b=nil) then
     compare:=0
   else if (a=nil) then
           compare:=1
        else if (b=nil) then
                compare:=-1
             else }if (sort_by = 0) then
                     if (a.fn.fam=b.fn.fam) then
                        compare:=0
                     else if (a.fn.fam < b.fn.fam) then
                          compare:= -1
                          else compare:=1;
writeln(compare);
end;

procedure put_to_list(var l:list; cur_item:stud);
var tmp, tmp_pred,new_item:list;
    comp:integer;
begin
   writeln('Called put_to_list');
   if (l=nil) then begin
      writeln('Branch one begin');
      new(l);
      l^.elem:=cur_item;
      writeln('Branch one end');
   end else begin
      writeln('Branch two begin');
      tmp:=l;
      comp:=1;
      while ((tmp<>nil) AND (comp>0)) do
      begin
        tmp_pred:=tmp;
        tmp:=tmp^.next;
        comp:=compare(tmp_pred^.elem, cur_item);
      end;
      writeln('Branch two middle');
      new(new_item);
      new_item^.elem:=cur_item;
      new_item^.next:=tmp;
      tmp_pred^.next:=new_item;
      writeln('Branch two end');
      end;
end;

procedure read_to_list(var f:fstud; var l:list);
var cur_item:stud;
begin
   writeln('Called read_to_list');
   assign(f, 'group118.records');
   reset(f);
   while not eof(f) do begin
      read(f, cur_item);
      put_to_list(l, cur_item);
   end;
end;

procedure read_to_screen;
var l:list;
    f:fstud;
    el:stud;
    i:integer;
begin
   writeln('Called read_to_screen');
   new(l);
   {new(f);}
   read_to_list(f, l);
   while (l<>nil) do
   begin
      el:=l^.elem;
      write(el.fn.fam,' ');
      write(el.fn.name,' ');
      if (el.sex=M) then
         write('M ')
      else write('W ');
      for i:= 1 to 5 do
         write(el.marks[i]);
      writeln;
      l:=l^.next;
   end
end;

begin
   new_group(group118);
   write_to_file(f, group118);
   writeln('Data writing to file "group118.records".');

   sort_by := 0;
   read_to_screen;
end.