with Ada.Text_Io; use Ada.Text_Io;
with Ada.Unchecked_Deallocation;
with Ada.Containers.Doubly_Linked_Lists;

procedure Main is
   type Node;
   type Node_Access is access Node;
   type Node is record
      Left : Node_Access := null;
      Right : Node_Access := null;
      Data : Integer;
   end record;
begin
   Put("hello");
end Main;
