program n634(INPUT, OUTPUT);
var current, sum:integer;
	is_plus:boolean;
    c:char;
begin
  writeln('Please, insert "d1+d2+...+dn.", where di - nubmer, n>1. For example "1+2+5+7+9+6."');
  write('>'); read(c);

  current := 0;
  sum := 0;
  is_plus := True;

  while(c <> '.') do begin
    if((ord(c)>=ord('0')) AND (ord(c)<=ord('9'))) then begin
	       if (NOT is_plus) then begin
			    write('Error ++!!!');
				exit();
           end;
	       is_plus := False;
           current := ord(c) - ord('0');
           sum := sum + current;
        end else begin
           if (c <> '+') OR is_plus then begin
				    write('Error ++!!!');
					exit();
           end else
					is_plus := True;
		end;
    read(c);
  end;
  writeln('Summa: ', sum);
end.
