{Author: Alexander Turenko}
program task2(INPUT, OUTPUT);
type formula_form_t = (normal, prefix, postfix);
     relation_t = (norel, plus, minus, mult);

     tree_t = ^tree_item;
     tree_item = record
       is_variable:boolean;
       is_number:boolean;
       number:integer;

       left:tree_t;
       relation:relation_t;
       right:tree_t;
     end;
var t,d:tree_t;
    succesful:boolean;
    x, res:integer;

function newItem():tree_t;
var t:tree_t;
begin
  new(t);
  t^.is_variable := False;
  t^.is_number := False;
  t^.number := 0;

  t^.left := nil;
  t^.relation := norel;
  t^.right := nil;
  newItem := t;
end;

procedure showRelation(r:relation_t);
begin
  if (r = plus) then
    write('+')
  else if (r = minus) then
    write('-')
  else if (r = mult) then
    write('*')
  else
    write('?')
end;

procedure show(t:tree_t; formula_form:formula_form_t); forward;

procedure showFormula(t:tree_t; formula_form:formula_form_t);
begin
  if (t <> nil) then begin
    write('(');

    if (formula_form = normal) then begin
      show(t^.left, formula_form);
      showRelation(t^.relation);
      show(t^.right, formula_form);
    end else if (formula_form = prefix) then begin
      showRelation(t^.relation);
      show(t^.left, formula_form);
      show(t^.right, formula_form);
    end else if (formula_form = postfix) then begin
      show(t^.left, formula_form);
      show(t^.right, formula_form);
      showRelation(t^.relation);
    end;

    write(')');
  end;
end;

procedure show(t:tree_t; formula_form:formula_form_t);
begin
  if (t <> nil) then begin
    if (t^.is_variable) then
      write('X')
    else if (t^.is_number) then
      write(t^.number)
    else
      showFormula(t, formula_form);
  end;
end;

function isVariable(c:char):boolean;
begin
  isVariable := ((c = 'x') OR (c = 'X'));
end;

function isDigit(c:char):boolean;
begin
  isDigit := ((c >= '0') AND (c <= '9'));
end;

procedure parseRelation(var r:relation_t; var succesful:boolean);
var c:char;
    my_succesful:boolean;
begin
  my_succesful := True;

  read(c);

  if (c = '+') then
    r := plus
  else if (c = '-') then
    r := minus
  else if (c = '*') then
    r := mult
  else begin
    r := norel;
    my_succesful := False;
  end;

  succesful := my_succesful;
end;

procedure parse(var t:tree_t; var succesful:boolean); forward;

procedure parseFormula(var t:tree_t; var succesful:boolean);
var my_succesful:boolean;
    c:char;
begin
  my_succesful := True;

  t := newItem();
  parse(t^.left, my_succesful);

  if (my_succesful) then
    parseRelation(t^.relation, my_succesful);

  if (my_succesful AND (t^.relation <> norel)) then
    parse(t^.right, my_succesful);

  if (my_succesful) then begin
    read(c);
    my_succesful := (c = ')');
  end;

  succesful := my_succesful;
end;

procedure parse(var t:tree_t; var succesful:boolean);
var c:char;
    my_succesful:boolean;
begin
  my_succesful := True;

  read(c);
  t := newItem();

  if (isVariable(c)) then
    t^.is_variable := True
  else if (isDigit(c)) then begin
    t^.is_number := True;
    t^.number := (ord(c) - ord('0'));
  end else if (c = '(') then
    parseFormula(t, my_succesful)
  else
    my_succesful := False;

  succesful := my_succesful;
end;

procedure destroy(var t:tree_t);
begin
  if (t <> nil) then begin
    destroy(t^.left);
    destroy(t^.right);
    dispose(t);
    t := nil;
  end;
end;

procedure calc(t:tree_t; x:integer; var res:integer);
var res1, res2:integer;
begin
  if (t <> nil) then begin
    if (t^.is_variable) then
      res := x
    else if (t^.is_number) then
      res := t^.number
    else {if (t^.relation = norel) then begin
      calc(t^.left, x, res);
    end else} if (t^.relation = plus) then begin
      calc(t^.left, x, res1);
      calc(t^.right, x, res2);
      res := (res1 + res2);
    end else if (t^.relation = minus) then begin
      calc(t^.left, x, res1);
      calc(t^.right, x, res2);
      res := (res1 - res2);
    end else if (t^.relation = mult) then begin
      calc(t^.left, x, res1);
      calc(t^.right, x, res2);
      res := (res1 * res2);
    end;
  end;
end;

function copyTree(t:tree_t):tree_t;
var res:tree_t;
begin
  if (t <> nil) then begin
    res := newItem();
    res^.is_variable := t^.is_variable;
    res^.is_number := t^.is_number;
    res^.number := t^.number;

    res^.left := copyTree(t^.left);
    res^.relation := t^.relation;
    res^.right := copyTree(t^.right);
  end else
    res := nil;

  copyTree := res;
end;


function makeItem(t1,t2:tree_t; r:relation_t):tree_t;
var res:tree_t;
begin
  res := newItem();
  res^.left := copyTree(t1);
  res^.relation := r;
  res^.right := copyTree(t2);
  makeItem := res;
end;

procedure differentiate(t:tree_t; var res:tree_t);
var res1, res2:tree_t;
begin
  if (t <> nil) then begin
    res := newItem();

    if (t^.is_variable) then begin
      res^.is_number := True;
      res^.number := 1;
    end else if (t^.is_number) then begin
      res^.is_number := True;
      res^.number := 0;
    end else {if (t^.relation = norel) then begin
      calc(t^.left, x, res);
    end else} if ((t^.relation = plus) OR (t^.relation = minus)) then begin
      differentiate(t^.left, res1);
      differentiate(t^.right, res2);
      res := makeItem(res1, res2, t^.relation);
    end else if (t^.relation = mult) then begin
      differentiate(t^.left, res1);
      differentiate(t^.right, res2);
      res1 := makeItem(res1, t^.right, mult);
      res2 := makeItem(t^.left, res2, mult);
      res := makeItem(res1, res2, plus);
    end;
  end;
end;

begin
  t := nil;

  writeln('Enter formula:');
  write('> ');

  parse(t, succesful);
  writeln;

  if (NOT succesful) then
    writeln('Parse error. Exiting...')
  else begin
    writeln('Enter value of ''X'' variable:');
    write('> ');
    read(x);
    writeln;

    writeln('Normal form and calculation result:');
    calc(t, x, res);
    show(t, normal);
    writeln(' = ', res);
    writeln;

    writeln('Prefix form:');
    show(t, prefix);
    writeln;
    writeln;

    writeln('Postfix form:');
    show(t, postfix);
    writeln;
    writeln;

    writeln('Differential:');
    differentiate(t, d);
    calc(d, x, res);
    show(d, normal);
    writeln(' = ', res);

    destroy(d);
  end;

  destroy(t);
end.
