with Ada.Text_Io, Ada.Integer_Text_IO; use Ada.Text_Io, Ada.Integer_Text_IO;
with Ada.Numerics.Discrete_Random;

procedure Main is
   type Node;
   type Node_Access is access Node; -- pointer
   type Node is record -- definicja wezla
      Left : Node_Access := null;
      Right : Node_Access := null;
   end record;
   Root : Node_Access := null; -- korzen
   Nodes_Counter : Integer := 1; -- liczba node'ow
   Null_Counter : Integer := 1 ; -- liczba nulli w drzewie
   Iterations : Integer;

   function Tree_Height( N : Node_Access ) return Integer is
      Left : Integer := 0;
      Right : Integer := 0;
   begin
      if N = null then
         return 0;
      else
         Left := Tree_Height( N.Left );
         Right := Tree_Height( N.Right );
         if Left > Right then
            return Left + 1;
         else
            return Right +1 ;
         end if;
      end if;
   end Tree_Height;

   procedure Second_Method( Iteration_number : Integer ) is
      Current_Node : Node_Access := Root;
      LoopFinished : Boolean := False ;
      Iter : Integer := 0;
      type Rand_Range is range 0..1;
      package Rand_Int is new Ada.Numerics.Discrete_Random(Rand_Range);
      seed : Rand_Int.Generator;
      Num : Rand_Range;
   begin

      Root := new Node;
      Root.Left := null;
      Root.Right := null;

      Rand_Int.Reset(seed);
      while Iter < Iteration_number - 1 loop
         New_Line;
         Iter := Iter + 1;
         LoopFinished := False;
         Current_Node := Root;
         while LoopFinished = False loop
            Num := Rand_Int.Random(seed);
            if Num = 0 then
               Put("left");
               New_Line;
               if Current_Node.Left = null then
                  Current_Node.Left := new Node;
                  LoopFinished := True;
               else
                  Current_Node := Current_Node.Left;
               end if;
            else
               Put("right");
               New_Line;
               if Current_Node.Right = null then
                  Current_Node.Right := new Node;
                  LoopFinished := True;
               else
                  Current_Node := Current_Node.Right;
               end if;
            end if;
         end loop;
      end loop;
   end Second_Method;
begin
   Get (Iterations);
   Second_Method (Iterations);

   Put("Wysokosc drzewa:");
   Put( Tree_Height(Root) );
end Main;
