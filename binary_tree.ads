with Ada.Unchecked_Deallocation;
with Ada.Text_Io, Ada.Integer_Text_IO; use Ada.Text_Io, Ada.Integer_Text_IO;
with Ada.Numerics.Discrete_Random;


package Binary_Tree is
   type Node;

   -- typ wskazujacy na wezel
   type Node_Access is access Node;

   -- typ wezla wraz z jego polami
   type Node is record
      Left : Node_Access := null;
      Right : Node_Access := null;
      Value : Integer;
   end record;

   -- korzen drzewa
   Root : Node_Access := null;
   -- liczba wezlow
   Nodes_Counter : Integer := 1;

   -- liczba nulli w drzewie w trakcie wypelniania
   Current_Null_Number : Integer;

   -- calkowita liczba nulli
   Total_Null_Number : Integer;

   -- zamiana miejscami dwoch zmiennych
   procedure Swap (A, B : in out Integer);

   -- zwraca wysokosc drzewa od korzenia
   function Tree_Height return Integer;

   -- Zwraca wysokosc drzewa od danego wezla
   function Subtree_Height( N : Node_Access ) return Integer;

   -- Zwraca liczbe elementow poddrzewa
   function Tree_Elements( N : Node_Access ) return Integer;

   --Czysci poddrzewo
   procedure Clear_Subtree( N : in out Node_Access );

   --Czysci drzewo od korzenia
   procedure Clear_Tree;

   -- Znajduje n-tego nulla i na jego miejsce wklada nowy wezel
   procedure Set_Nth_Null( Current_Node : in out Node_Access; N : Integer );

   -- Pierwsza metoda wypelniania drzewa - kazdy Null w drzewie jest losowany z identycznym prawdopodobienstwem
   procedure First_Method( Iteration_number : Integer );

   -- Druga metoda - losowe bladzenie
   procedure Second_Method( Iteration_number : Integer );

   -- Trzecia metoda - drzewo binarne na podstawie wygenerowanej permutacji
   procedure Third_Method( Iteration_number : Integer );

   -- Pokazuje statystyki drzewa
   procedure Show_Stats;

end Binary_Tree;
