package body Binary_Tree is

   -- procedura zammieniajaca dwie wartosci miejscami
   procedure Swap (A, B : in out Integer) is
      C : Integer := A;
   begin
      A := B;
      B := C;
   end Swap;

   -- zwraca wysokosc drzewa
   function Subtree_Height( N : Node_Access ) return Integer is
      Left : Integer := 0;
      Right : Integer := 0;
   begin
      if N = null then
         return 0;
      else
         Left := Subtree_Height( N.Left );
         Right := Subtree_Height( N.Right );
         if Left > Right then
            return (Left + 1);
         else
            return (Right + 1) ;
         end if;
      end if;
   end Subtree_Height;

   -- zwraca liczbe wezlow drzewa
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

   -- czysci drzewo
   procedure Clear_Subtree( N : in out Node_Access ) is
   begin
      declare
         procedure Free is new Ada.Unchecked_Deallocation (Node, Node_Access);
      begin
         if N /= null then
            Clear_Subtree( N.Left );
            Clear_Subtree( N.Right );
            Free(N);
         end if;
      end;
   end Clear_Subtree;

   -- inicjalizuje Node na n-tej pozycji w drzewie
   procedure Set_Nth_Null( Current_Node : in out Node_Access; N : Integer ) is
   begin
      if Current_Node.Left = null then
         if Current_Null_Number = N then
            --Put("lewy");
            Current_Null_Number := Current_Null_Number +1;
            Current_Node.Left := new Node;
            return;
         else
            --Put("nierowny lewy");
            Current_Null_Number := Current_Null_Number +1;
         end if;
      else
         Set_Nth_Null(Current_Node.Left, N);
      end if;

      if Current_Node.Right = null then
         if Current_Null_Number = N then
            --Put("prawy");
            Current_Null_Number := Current_Null_Number +1;
            Current_Node.Right := new Node;
            return;
         else
            --Put("nierowny prawy");
            Current_Null_Number := Current_Null_Number +1;
         end if;
      else
         Set_Nth_Null(Current_Node.Right, N);
      end if;
   end Set_Nth_Null;

   -- pierwsza metoda generowania drzewa
   -- dla drzewa z n nullami kazdy null ma szanse 1/n
   -- ze zostanie stworzony nowy node na jego miejsce
   procedure First_Method( Iteration_number : Integer ) is
      N : Integer;
      Current_Node : Node_Access := Root;
   begin
      declare
         subtype Rand_Range is Positive range 1..Iteration_number;
         package Rand_Int is new Ada.Numerics.Discrete_Random(Rand_Range);
         seed : Rand_Int.Generator;
      begin
         Rand_Int.Reset(seed);
         Root := new Node;
         Total_Null_Number := 2;

         for I in Integer range 2..Iteration_number loop
            Rand_Int.Reset(seed);
            Current_Null_Number := 1;
            N := Rand_Int.Random(seed) mod Total_Null_Number;
            N := N + 1;
            --Put("Szukam");
            --Put(Current_Null_Number);
            --New_Line;
            Set_Nth_Null( Root, N );
            Total_Null_Number := Total_Null_Number + 1;

         end loop;
      end;
   end First_Method;

   -- druga metoda polegajaca na losowym bladzeniu w drzewie
   -- idac w dol z prawdopodobienstwem 1/2 idziemy w prawo
   -- z prawdopodobienstwem 1/2 w lewo
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

   -- trzecia metoda, dla ktorej generujemy losowa permutacje
   -- i na jej podstawie tworzymy drzewo przeszukiwan binarnych
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

   -- pokazuje statystyki dla drzewa
   procedure Show_Stats is
   begin
      Put( Tree_Height );
      Put(" , ");
      Put( Tree_Elements(Root));
      New_Line;
   end Show_Stats;

   function Tree_Height return Integer is
   begin
      return Subtree_Height(Root);
   end Tree_Height;

   procedure Clear_Tree is
   begin
      Clear_Subtree(Root);
   end Clear_Tree;
end Binary_Tree;
