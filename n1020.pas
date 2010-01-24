{Turenko Alexander, #10.20}
program n1020(INPUT, OUTPUT);
var  board:packed array [0..7,0..7] of char;
       x,y:integer;
       i,j:integer;
input_char:char;
begin
  {Ввод}
  writeln('Enter ferze position (for example e4):'); write('> ');
  read(input_char); x:=ord(input_char) - ord('a');
  read(input_char); y:=ord(input_char) - ord('1');

  {Проверка}
  if (((x<0) OR (x>7)) OR ((y<0) OR (y>7)))
    then writeln('Error: out of range. Quitting.')
    else begin
      {Обработка}
      for i:=0 to 7 do
        for j:=0 to 7 do
          if ((i=x) OR (j=y) OR (abs(x-i)=abs(y-j)))
            then board[i][j]:='X'
            else board[i][j]:='0';
      board[x][y]:='*'; {Ферзь}

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
