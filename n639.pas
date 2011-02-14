{Author: Alexander Turenko} {#6.39}
program n639(OUTPUT);
const startx = -1;
      endx = 2;
      step = 0.25;
      space = 10;
var i,y,ox,max_y_ox:integer;
         x:real;
begin
  x:=startx;
  while(x<=endx) do begin
    y:=round((x*x-1)/step)+space;
    ox:=space;
    write('x: ',x:5:2,' y: ',((y-space)*step):5:2);
    if(y > ox) then max_y_ox:=y
               else max_y_ox:=ox;
    for i:=1 to max_y_ox do
      if(i=y)  then write('*') else
      if(i=ox) then write('|') else
                    write(' ');
    x:=x+step; writeln;
    end;
end.
