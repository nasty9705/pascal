{Turenko Alexander, #13.32a}
program n1332a(INPUT, OUTPUT);
type complex = record r,z:real end;
var k,mn,res1,res2:complex;
               eps:real;
               i:integer;
               n:longint;

procedure complexMultiplication(a,b:complex; var c:complex);
begin
{ (ar+ai)*(br+bi)=ar*br+ai*br+ar*bi+ai*bi=(ar*br)+(ai*br+ar*bi)i+(ai*bi)*(i^2) }
c.r := a.r*b.r+a.z*b.z;
c.z := a.z*b.r+a.r*b.z;
end;

begin
  writeln('Insert real and hide part of k and eps:');
  write('> '); read(k.r, k.z, eps);
  i:=1; n:=1; res2.r:=0; res2.z:=0; mn.r:=1; mn.z:=0;
  repeat
writeln('i: ',i,' n: ',n,' res1.r: ',res1.r,' res2.r: ',res2.r);
    res1:=res2;
    res2.r:=res2.r+mn.r/n;
    res2.z:=res2.z+mn.z/n;
    complexMultiplication(mn,k,mn);
    n:=n+1;
writeln('### i: ',i,' n: ',n,' res1.r: ',res1.r,' res2.r: ',res2.r);
  until(abs(res1.r-res2.r)<eps);
  writeln('e^z (with accuracy ',eps,') = (',res2.r,'; ',res2.z);
end.