{Turenko Alexander, Project 1, 7.4.3 and 7.1.3}
program task1(INPUT, OUTPUT);
const eps = 0.001;
      p = 1/15;
type RF = function (x:real):real;
var eps1,eps2,x1,x2,x3,a,b,I1,I2,I3:real;
    test,debug:boolean;
    root_method:integer;
    checked:packed array [1..10] of char;

function f1(x:real):real; begin f1:=ln(x) end;
function f2(x:real):real; begin f2:=-2*x+14 end;
function f3(x:real):real; begin f3:=1/(2-x)+6 end;

function f1p(x:real):real; begin f1p:=1/x end;
function f2p(x:real):real; begin f2p:=-2 end;
function f3p(x:real):real; begin f3p:=1/((2-x)*(2-x)) end;

function f_test(x:real):real; begin f_test:=-12*x+12 end;
function f_test1(x:real):real; begin f_test1:=1/x+1 end;
function f_test2(x:real):real; begin f_test2:=-1/x+1 end;
function f_test3(x:real):real; begin f_test3:=1/x-1 end;
function f_test4(x:real):real; begin f_test4:=-1/x-1 end;

function fp_test(x:real):real; begin fp_test:=-12 end;
function fp_test1(x:real):real; begin fp_test1:=-1/(x*x) end;
function fp_test2(x:real):real; begin fp_test2:=1/(x*x) end;
function fp_test3(x:real):real; begin fp_test3:=-1/(x*x) end;
function fp_test4(x:real):real; begin fp_test4:=1/(x*x) end;

function f_test5(x:real):real; begin f_test5:=7*exp(6*ln(x))+14 end;
function f_test6(x:real):real; begin f_test6:=5*exp(4*ln(x))-3*x*x end;

{Difficult between function f1 and f2 at some dot a}
function Fd(f1,f2:RF; a:real):real;
begin
  if (debug) then writeln('DEBUG: Called Fd(',a:2:5,'); f1(a): ',f1(a):2:5,' f2(a): ',f2(a):2:5,'. Return ',(f1(a)-f2(a)):2:5);
  Fd:=f1(a)-f2(a);
end;

procedure root4(f,g,f1,g1:RF; a,b,eps:real; var x:real);
var c1,c2,tmp1,tmp2,eps_current:real;
begin
  if (debug) then writeln('DEBUG: Called root4(',a:2:5,'; ',b:2:5,');');
  {Найдём точку пересечения с осью абсцисс прямой, проходящей через точки (a,Fd(a) и (b, Fd(b).}
  tmp1 := (a*Fd(f,g,b)-b*Fd(f,g,a))/(Fd(f,g,b) - Fd(f,g,a));
  if (debug) then writeln('DEBUG: tmp1: ',tmp1:2:5);
  if ((Fd(f,g,(a+b)/2)>(Fd(f,g,a)+Fd(f,g,b))/2)=(Fd(f,g,a)<0)) then begin
    {Первая и вторая производные имеют разные знаки.}
    if (debug) then writeln('DEBUG: #2');
    c2:=tmp1;
    tmp2:=a;
    {Найдём точку пересечения касательной с осью абсцисс.}
    c1:=tmp2-Fd(f,g,tmp2)/Fd(f1,g1,tmp2);
  end else begin
    {Первая и вторая производные имеют одинаковые знаки.}
    if (debug) then writeln('DEBUG: #1');
    c1:=tmp1;
    tmp2:=b;
    {Найдём точку пересечения касательной с осью абсцисс.}
    c2:=tmp2-Fd(f,g,tmp2)/Fd(f1,g1,tmp2);
  end;

  eps_current:=c2-c1;
  if (eps_current<=eps) then
    x:=c1
  else root4(f,g,f1,g1,c1,c2,eps,x);
end;

procedure root1(f,g,f1,g1:RF; a,b,eps:real; var x:real);
var fa,fb,middle,f_middle,eps_current:real;
    fa_z,fb_z,fm_z:boolean;
begin
  if (debug) then writeln('DEBUG: Called root1(',a:2:5,'; ',b:2:5,');');

  fa := Fd(f,g,a);
  fb := Fd(f,g,b);

  if (fa = 0) then begin
    x := a;
    exit;
  end else if (fb = 0) then begin
    x := b;
    exit;
  end;

  fa_z := (fa > 0);
  fb_z := (fb > 0);

  repeat
    middle := (a + b) / 2;
    f_middle := Fd(f,g,middle);

    if (f_middle = 0) then begin
      x := middle;
      exit;
    end;

    fm_z := (f_middle > 0);
   
    if (fa_z <> fm_z) then begin
      if (debug) then writeln('DEBUG: middle<--b');
      b := middle;
      fb := f_middle;
      fb_z := fm_z;
    end else if (fm_z <> fb_z) then begin
      if (debug) then writeln('DEBUG: a-->middle');
      a := middle;
      fa := f_middle;
      fa_z := fm_z;
    end else begin
      writeln('root1: solve not found.');
      exit;
    end;

    eps_current := b - a;
  until (eps_current <= eps);

  x := a;
end;

procedure root(f,g,f1,g1:RF; a,b,eps:real; var x:real);
begin
  if (root_method = 1) then
    root1(f,g,f1,g1,a,b,eps,x)
  else if (root_method = 4) then
    root4(f,g,f1,g1,a,b,eps,x)
  else
    writeln('Cannot find root method',root_method);
end;

function integral(f:RF; a,b,eps:real):real;
var h,sum0,sum1,sum2,Iln,Il2n,x1,x2,tmp:real;
    n:integer;
begin
  if (debug) then writeln('DEBUG: Called integral(',a:2:5,'; ',b:2:5,');');
  if(b<a) then begin
    tmp:=a;
    a:=b;
    b:=tmp;
  end;

  sum0:=f(a)+f(b);
  sum1:=0;
  sum2:=0;
  h:=(b-a);
  n:=0;
  Iln:=0;
  repeat
    Il2n:=Iln;
    h:=h/3;

    x1:=a+h; x2:=a+2*h;
    while x1<(b-h/2) do begin
      if ((n mod 2)=1) then begin
        tmp:=x1;
        x1:=x2;
        x2:=tmp;
      end;
      sum1:=sum1+2*f(x1);
      sum2:=sum2+2*f(x2);
      x1:=x1+3*h; x2:=x2+3*h;
    end;

    Iln := (h/3)*(sum0+(sum1*(((n+1) mod 2)+1))+(sum2*((n mod 2)+1)));
    if (debug) then writeln('DEBUG: Iln: ',Iln:2:5);

    n:=n+1;
  until (abs(Il2n-Iln)<p*eps);
  writeln('Integral end before ',n,' iteration of devide.');
  integral:=Il2n;
end;

function init:boolean;
var tmp:integer;
begin
  writeln('This is program for calculating area via integrals.');
  writeln('Run in test mode? Enter 0 to answer "NO" or 1 to "YES".');
  write('> '); read(tmp);

  if (tmp < 0) then begin
    tmp := 0;
    writeln('Mode value out of range! Changed to ',tmp,'.');
  end else if (tmp > 1) then begin
    tmp := 1;
    writeln('Mode value out of range! Changed to ',tmp,'.');
  end;

  test := (tmp = 1);

  writeln('Write debug information? Enter 0 to answer "NO" or 1 to "YES".');
  write('> '); read(tmp);

  if (tmp < 0) then begin
    tmp := 0;
    writeln('Debug value out of range! Changed to ',tmp,'.');
  end else if (tmp > 1) then begin
    tmp := 1;
    writeln('Debug value out of range! Changed to ',tmp,'.');
  end;

  debug := (tmp = 1);

  writeln('Please, select method for find point of cross of functions:');
  writeln('1. Bisection method.');
  writeln('4. Secant and tangent method.');
  write('> '); read(tmp);

  if ((tmp = 1) OR (tmp = 4)) then begin
    root_method := tmp;
  end else begin
    writeln('Sorry, this method is not implemented.');
    writeln('Exiting...');
    init := False; { Not initialized }
    exit;
  end;

  eps1 := eps;
  eps2 := eps;

  if (debug) then writeln('DEBUG: eps1 = eps2 = eps.');

  { Succeful initialized }
  init := True;
end;

begin
  if (NOT init) then
    exit;
  writeln;

  if (NOT test) then begin
    a:=2.1; b:=7;
    root(@f1,@f2,@f1p,@f2p,a,b,eps1,x1);
    root(@f2,@f3,@f2p,@f3p,a,b,eps1,x2);
    root(@f1,@f3,@f1p,@f3p,a,b,eps1,x3);
    writeln('x_12: ',x1:2:5);
    writeln('x_23: ',x2:2:5);
    writeln('x_13: ',x3:2:5);

    I1:=integral(@f1,x1,x3,eps2);
    I2:=integral(@f2,x1,x2,eps2);
    I3:=integral(@f3,x2,x3,eps2);
    writeln('Integral f1 (',x1:2:5,'; ',x3:2:5,') : ', I1:2:5);
    writeln('Integral f2 (',x1:2:5,'; ',x2:2:5,') : ', I2:2:5);
    writeln('Integral f3 (',x2:2:5,'; ',x3:2:5,') : ', I3:2:5);

    writeln('Area: ', (I2+I3-I1):2:5);
  end else begin
    a:=0.5; b:=10;
    writeln('Testing find point of cross of functions 1/x+1 and -12x+12 on [',a:2:5,'; ',b:2:5,']');
    root(@f_test,@f_test1,@fp_test,@fp_test1,a,b,eps1,x1);
    writeln('Got:                       ',x1:2:5);
    writeln('Expected:                  0.814333');
    if(abs(0.814333-x1)<eps1) then
      checked:='[OK]'
    else checked:='[FAILED]';
    writeln('Checking with eps ',eps1:2:5,': ',checked);
    writeln;

    writeln('Testing find point of cross of functions -1/x+1 and -12x+12 on [',a:2:5,'; ',b:2:5,']');
    root(@f_test,@f_test2,@fp_test,@fp_test2,a,b,eps1,x1);
    writeln('Got:                       ',x1:2:5);
    writeln('Expected:                  1');
    if(abs(1-x1)<eps1) then
      checked:='[OK]'
    else checked:='[FAILED]';
    writeln('Checking with eps ',eps1:2:5,': ',checked);
    writeln;

    writeln('Testing find point of cross of functions 1/x-1 and -12x+12 on [',a:2:5,'; ',b:2:5,']');
    root(@f_test,@f_test3,@fp_test,@fp_test3,a,b,eps1,x1);
    writeln('Got:                       ',x1:2:5);
    writeln('Expected:                  1');
    if(abs(1-x1)<eps1) then
      checked:='[OK]'
    else checked:='[FAILED]';
    writeln('Checking with eps ',eps1:2:5,': ',checked);
    writeln;

    writeln('Testing find point of cross of functions -1/x-1 and -12x+12 on [',a:2:5,'; ',b:2:5,']');
    root(@f_test,@f_test4,@fp_test,@fp_test4,a,b,eps1,x1);
    writeln('Got:                       ',x1:2:5);
    writeln('Expected:                  1.15545');
    if(abs(1.15545-x1)<eps1) then
      checked:='[OK]'
    else checked:='[FAILED]';
    writeln('Checking with eps ',eps1:2:5,': ',checked);
    writeln;

    a:=1; b:=2;
    writeln('Testing calculate integral functions 7*x^6+14 on [',a:2:5,'; ',b:2:5,']');
    I1:=integral(@f_test5,a,b,eps2);
    writeln('Got:                       ',I1:2:5);
    writeln('Expected:                  141');
    if(abs(141-I1)<eps2) then
      checked:='[OK]'
    else checked:='[FAILED]';
    writeln('Checking with eps ',eps1:2:5,': ',checked);
    writeln;

    writeln('Testing calculate integral functions 5*x^4-3*x^2 on [',a:2:5,'; ',b:2:5,']');
    I1:=integral(@f_test6,a,b,eps2);
    writeln('Got:                       ',I1:2:5);
    writeln('Expected:                  24');
    if(abs(24-I1)<eps2) then
      checked:='[OK]'
    else checked:='[FAILED]';
    writeln('Checking with eps ',eps1:2:5,': ',checked);
  end;
end.
