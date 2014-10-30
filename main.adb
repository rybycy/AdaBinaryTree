with Ada.Text_Io, Ada.Integer_Text_IO; use Ada.Text_Io, Ada.Integer_Text_IO;
with Binary_Tree;

procedure Main is

   Tries_counter : Integer;
   Proba : Integer;
   Res : Integer;
   Iterations : Integer; -- liczba iteracji

begin
   --Get (Iterations);
   Iterations := 10;
   Tries_counter := 1;

   while Iterations <= 1000 loop
      Proba := Tries_counter;
      Res := 0;
      while Proba > 0 loop
         --First_Method( Iterations );
         --Show_Stats;
         --Clear_Tree( Root );
         --Second_Method( Iterations );
         --Show_Stats;
         --Clear_Tree( Root );
         Binary_Tree.Third_Method (Iterations);
         --Show_Stats;
         Res := Res + Binary_Tree.Tree_Height;
         Proba := Proba - 1;
         Binary_Tree.Clear_Tree;
      end loop;
      Res := Res / Tries_counter;
      Put( Iterations );
      Put(" , ");
      Put( Res );
      New_Line;

      Iterations := Iterations + 10;
   end loop;
end Main;
