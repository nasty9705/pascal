{Author: Alexander Turenko}
program task2(INPUT, OUTPUT);
type relation_t = (norel, plus, minus, mult);

     tree_t = ^tree_item;
     tree_item = record
       is_variable:boolean;
       is_number:boolean;
       number:integer;

       left:tree_t;
       relation:relation_t;
       right:tree_t;
     end;
var t:tree_t;

function newItem():tree_t;
var t:tree_t;
begin
  new(t);
  t^.is_variable := False;
  t^.is_number := False;
  t^.number := 0;
  t^.relation := norel;
  t^.left := nil;
  t^.right := nil;
  newItem := t;
end;

procedure show(t:tree_t); forward;
procedure showElem(t:tree_t);
begin
  if (t <> nil) then begin
    if (t^.is_variable) then
      write('X')
    else if (t^.is_number) then
      write(t^.number)
    else begin
      write('(');
      show(t);
      write(')');
    end;
  end;
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

procedure show(t:tree_t);
begin
  if (t <> nil) then begin
    if (t^.left <> nil) then
      showElem(t^.left);
    if (t^.relation <> norel) then begin
      showRelation(t^.relation);
      if (t^.right <> nil) then
        showElem(t^.right);
    end;
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

procedure parseRelation(var r:relation_t);
var c:char;
begin
  read(c);

  if (c = '+') then
    r := plus
  else if (c = '-') then
    r := minus
  else if (c = '*') then
    r := mult
  else
    r := norel;
end;

procedure parse(var t:tree_t); forward;
procedure parseElem(var t:tree_t);
var c:char;
begin
  read(c);
  t := newItem();

  if (isVariable(c)) then
    t^.is_variable := True
  else if (isDigit(c)) then begin
    t^.is_number := True;
    t^.number := (ord(c) - ord('0'));
  end else if (c = '(') then begin
    t^.is_number := False;
    parse(t);
    if (t^.relation = norel) then begin
      write('Parse error 1 at symbol ''',c,'''.');
      exit;
    end;
    read(c);
    if (c <> ')') then begin
      write('Parse error 2 at symbol ''',c,'''.');
      exit;
    end;
  end else begin
    write('Parse error 3 at symbol ''',c,'''.');
    exit;
  end;
end;

procedure parse(var t:tree_t);
begin
  t := newItem();
  parseElem(t^.left);

  parseRelation(t^.relation);

  if (t^.relation <> norel) then
    parseElem(t^.right);
end;

begin
  t := nil;
  write('> ');
  parse(t);
  show(t);
end.
