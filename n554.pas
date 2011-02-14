{Author: Alexander Turenko} {#5.54}
program n554(INPUT, OUTPUT);
var    i,j,n:integer;
    isSimple:boolean;
begin
   write('Enter n: '); readln(n);
   if(n>2) then
   begin
      for i:=2 to n do
         begin
         isSimple:=true;
         for j:=2 to (i div 2) do
            isSimple:=isSimple AND ((i mod j) <> 0);
         if(isSimple) then
           write(' ', i);
         end;
   end
   else writeln('Not performed n>2. Quitting.');
end.
