{Author: Turenko Alexander}
program trees(INPUT, OUTPUT);
type tree_type = integer;
     tree = ^item;
     item = record
              elem:tree_type;
              left:tree;
              right:tree;
            end;

     list = ^list_item;
     list_item = record
              elem:tree;
              next:list;
            end;
var t1,empty:tree;
    l1:list;

procedure init(t1:tree);
begin
  new(empty);
  t1:=empty;
end;

function isEmpty(t:tree):boolean;
begin
  if (t<>nil) then
    isEmpty:=(t=empty)
  else isEmpty:=true;
end;

procedure add(var t:tree; e:tree_type);
var toLeft:boolean;
    newItem,next_tree:tree;
begin
  if (not isEmpty(t)) then begin
    if (e<t^.elem) then begin
      toLeft:=true;
      next_tree:=t^.left
    end else begin
      toLeft:=false;
      next_tree:=t^.right;
    end;
  if (not isEmpty(next_tree)) then
    add(next_tree, e)
  else begin
         new(newItem);
         newItem^.elem:=e;
         if (toLeft) then
           t^.left:=newItem
         else t^.right:=newItem;
  end end else begin
             new(newItem);
             newItem^.elem:=e;
             t:=newItem;
           end;
end;

procedure show(t:tree);
var l,r:tree;
    b:boolean;
    p,tmp:list;
begin
  if (not isEmpty(t)) then
     new(l1);
     l1^.elem:=t;
     b:=true;
     while b do begin
        b:=false;
        l:=l1^.elem^.left;
        r:=l1^.elem^.right;
        { left }
        if (not isEmpty(l)) then begin
           write(l^.elem);
           tmp:=l1;
           l1:=l1^.next;
           tmp:=l1;
           while(tmp^.next<>nil) do
              tmp:=tmp^.next;
           new(p);
           p^.elem:=l;
           p^.next:=nil;
           tmp^.next:=p;
           dispose(tmp);
           b:=true;
          end;
        { right }
        if (not isEmpty(r)) then begin
           write(r^.elem);
           tmp:=l1;
           l1:=l1^.next;
           tmp:=l1;
           while(tmp^.next<>nil) do
              tmp:=tmp^.next;
           new(p);
           p^.elem:=r;
           p^.next:=nil;
           tmp^.next:=p;
           dispose(t);
           b:=true;
          end;
     end;



{
  writeln('[',level,']',':',t^.elem);
  if (not isEmpty(t^.left)) then begin
    write('[L]:');
    level := level+1;
    show(t^.left);
    level := level-1;
  end;
  if (not isEmpty(t^.right)) then begin
    write('[R]:');
    level := level+1;
    show(t^.right);
    level := level-1;
  end;}
end;

begin
add(t1,1);
add(t1,2);
add(t1,7);
add(t1,11);
add(t1,13);
add(t1,14);
add(t1,56);
add(t1,12);
add(t1,34);
add(t1,3);
show(t1);
end.