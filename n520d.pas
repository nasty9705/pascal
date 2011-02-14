{Author: Alexander Turenko} {#5.20d}
program n520d(INPUT, OUTPUT);
var         n:integer;
    x,eps,k,z:real;
begin
   writeln('This program calculate arctg(x) with accuracy eps.');
   write('Enter x: '); readln(x);
   if(abs(x)<1) then
      begin
         write('Enter eps: '); readln(eps);
         if(eps>0) then
           begin
              n:=1;
              k:=x;
              z:=0;
              repeat
                 z:=z+(k/n);
                 n:=n+2;
                 k:=k*(-1)*x*x;
              until abs(k)<eps;
              z:=z+(k/n);
              writeln('arctg(x) with accuracy eps (',eps,'): ',z);
              writeln('arctg(x) as function of Pascal returned ',arctan(x));
              writeln('Difficult: ', abs(arctan(x)-z));
              if(x<>0) then
                writeln('Error: ', abs((arctan(x)-z)/arctan(x)));
           end
         else writeln('Not performed eps>0. Quitting.');
      end
   else writeln('Not performed |x|<1. Quitting.');
end.
