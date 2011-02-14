{Author: Alexander Turenko} {#10.21}
program n1021(INPUT, OUTPUT);
var  board:packed array [0..7,0..7] of char;
       x,y:integer;
       i,j:integer;
input_char:char;
begin
  {Ввод}
  writeln('Enter horse position (for example e4):'); write('> ');
  read(input_char); x:=ord(input_char) - ord('a');
  read(input_char); y:=ord(input_char) - ord('1');

  {Проверка}
  if (((x<0) OR (x>7)) OR ((y<0) OR (y>7)))
    then writeln('Error: out of range. Quitting.')
    else begin
      {Обработка}
      for i:=0 to 7 do
        for j:=0 to 7 do
          if (((abs(x-i)=1)AND(abs(y-j)=2)) OR ((abs(x-i)=2)AND(abs(y-j)=1)))
            then board[i][j]:='X'
            else board[i][j]:='0';
      board[x][y]:='*'; {Конь}

      {Вывод с сеткой}
      for i:=0 to 7 do begin
        writeln('_______________');
        for j:=0 to 7 do begin
          write('|'); write(board[i][j]);
          end; writeln('|');
        end; writeln('_______________');

      {Вывод без сетки}
      writeln;
      for i:=0 to 7 do writeln(board[i]);
    end;
end.
