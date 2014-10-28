with Ada.Text_Io, Ada.Integer_Text_IO; use Ada.Text_Io, Ada.Integer_Text_IO;
with Ada.Numerics.Discrete_Random;
with Generic_Perm;

procedure Main is
   type Node;
   type Node_Access is access Node; -- pointer
   type Node is record -- definicja wezla
      Left : Node_Access := null;
      Right : Node_Access := null;
      Value : Integer;
   end record;
   Root : Node_Access := null; -- korzen
   Nodes_Counter : Integer := 1; -- liczba node'ow
   Null_Counter : Integer := 1 ; -- liczba nulli w drzewie
   Iterations : Integer;

   procedure Swap (A, B : in out Integer) is
      C : Integer := A;
   begin
      A := B;
      B := C;
   end Swap;

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
            return (Left + 1);
         else
            return (Right + 1) ;
         end if;
      end if;
   end Tree_Height;

   function Tree_Elements( N : Node_Access ) return Integer is
      Left : Integer := 0;
      Right : Integer := 0;
   begin
      if N = null then
         return 0;
      else
         return Tree_Elements(N.Left) + Tree_Elements(N.Right) + 1;
      end if;
   end Tree_Elements;

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
         Iter := Iter + 1;
         LoopFinished := False;
         Current_Node := Root;
         while LoopFinished = False loop
            Num := Rand_Int.Random(seed);
            if Num = 0 then
               if Current_Node.Left = null then
                  Current_Node.Left := new Node;
                  LoopFinished := True;
               else
                  Current_Node := Current_Node.Left;
               end if;
            else
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
   procedure Third_Method( Iteration_number : Integer ) is
      Done : Boolean := False;
      Current_Node : Node_Access := Root;
      LoopFinished : Boolean := False ;
   begin
      declare
         subtype Rand_Range is Positive range 1..Iteration_number;
         package Rand_Int is new Ada.Numerics.Discrete_Random(Rand_Range);
         seed : Rand_Int.Generator;
         Num : Rand_Range;
         subtype Element is Positive range 1 .. Iteration_number;
         P : array (Element) of Element;

      begin
         Rand_Int.Reset(seed);
         Num := Rand_Int.Random(seed);
         for I in Rand_Range range 1..Iteration_number loop
            P( I ) := I;
         end loop;
         for I in Rand_Range range 1..Iteration_number loop
            Swap( P( Rand_Int.Random(seed) ), P( Rand_Int.Random(seed) ) );
         end loop;
         Root := new Node;
         Root.Value := P(1);
         New_Line;
         Current_Node := Root;

         for I in Integer range 2..Iteration_number loop
            LoopFinished := False;
            Current_Node := Root;
            while LoopFinished = False loop
               if P(I) <= Current_Node.Value then
                  if Current_Node.Left = null then
                     Current_Node.Left := new Node;
                     Current_Node.Left.Value := P(I);
                     LoopFinished := True;
                  else
                     Current_Node := Current_Node.Left;
                  end if;
               else
                  if Current_Node.Right = null then
                     Current_Node.Right := new Node;
                     Current_Node.Right.Value := P(I);
                     LoopFinished := True;
                  else
                     Current_Node := Current_Node.Right;
                  end if;
               end if;
            end loop;
         end loop;
      end;
   end Third_Method;


begin
   --Get (Iterations);
   Iterations := 1000;
   Second_Method( Iterations );
   --Third_Method (Iterations);

   Put("Wysokosc drzewa:");
   Put( Tree_Height(Root) );
   New_Line;
   Put("Elements");
   Put( Tree_Elements(Root));
end Main;
