with Ada.Unchecked_Deallocation;
with Ada.Text_Io, Ada.Integer_Text_IO; use Ada.Text_Io, Ada.Integer_Text_IO;
with Ada.Numerics.Discrete_Random;


package Binary_Tree is
   type Node;
   type Node_Access is access Node; -- typ wskazujacy na wezel
   type Node is record -- typ wezla wraz z jego polami
      Left : Node_Access := null;
      Right : Node_Access := null;
      Value : Integer;
   end record;
   Root : Node_Access := null; -- korzen drzewa
   Nodes_Counter : Integer := 1; -- liczba node'ow

   Current_Null_Number : Integer; -- liczba nulli w drzewie w trakcie wypelniania
   Total_Null_Number : Integer; -- calkowita liczba nulli


   procedure Swap (A, B : in out Integer);
   function Tree_Height return Integer;
   function Subtree_Height( N : Node_Access ) return Integer;
   function Tree_Elements( N : Node_Access ) return Integer;
   procedure Clear_Subtree( N : in out Node_Access );
   procedure Clear_Tree;
   procedure Set_Nth_Null( Current_Node : in out Node_Access; N : Integer );
   procedure First_Method( Iteration_number : Integer );
   procedure Second_Method( Iteration_number : Integer );
   procedure Third_Method( Iteration_number : Integer );
   procedure Show_Stats;

end Binary_Tree;
