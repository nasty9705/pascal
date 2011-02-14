{Author: Alexander Turenko}
program trees(INPUT, OUTPUT);
type tree_type = integer;
     tree = ^item;
     item = record
              elem:tree_type;
              left:tree;
              right:tree;
            end;
var t1:tree;

procedure init(var t1:tree);
begin
  t1 := nil;
end;

function isEmpty(t:tree):boolean;
begin
  isEmpty := (t = nil);
end;

function newItem(e:tree_type):tree;
var
  newItem_var:tree;
begin
  new(newItem_var);
  newItem_var^.elem := e;
  newItem_var^.left := nil;
  newItem_var^.right := nil;
  newItem := newItem_var;
end;

procedure add(var t:tree; e:tree_type);
begin
  if (not isEmpty(t)) then begin
    if (e < t^.elem) then
      add(t^.left, e)
    else
      add(t^.right, e);
  end else begin
    t := newItem(e);
  end;
end;

procedure show(t:tree);
begin
  writeln('(',t^.elem,')');
  if (not isEmpty(t^.left)) then begin
    write('[L]:');
    show(t^.left);
  end;
  if (not isEmpty(t^.right)) then begin
    write('[R]:');
    show(t^.right);
  end;
  writeln('[UP]');
end;

begin
init(t1);
add(t1, 1);
add(t1, 2);
add(t1, 7);
add(t1, 11);
add(t1, 13);
add(t1, 14);
add(t1, 56);
add(t1, 12);
add(t1, 34);
add(t1, 3);
show(t1);
end.
