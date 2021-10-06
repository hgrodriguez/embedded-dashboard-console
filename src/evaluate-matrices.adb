--
--  Copyright 2021 (C) Holger Rodriguez
--
--  SPDX-License-Identifier: BSD-3-Clause
--
package body Evaluate.Matrices is

   --------------------------------------------------------------------------
   --  Check functions for the input received
   --  Those functions set the global variables to the received value
   --     as a side effect
   --------------------------------------------------------------------------
   function Check_Block (Block_Char : Character) return Boolean;
   function Check_Size (Size_Char : Character) return Boolean;
   function Check_Position (Position_Char : Character) return Boolean;
   function Check_Value (Value_String : Execute.Matrix_Value_Type)
                         return Boolean;

   --------------------------------------------------------------------------
   --  Those variables hold the input received and are set by the
   --  different Check_ functions
   --------------------------------------------------------------------------
   Block    : Blocks;
   Size     : Sizes;
   Position : Positions;
   Value    : Execute.Matrix_Value_Type;

   --------------------------------------------------------------------------
   --  see .ads
   --------------------------------------------------------------------------
   function Check_Input (Instruction : Matrix_Instruction)
                         return Execute.Matrix_Errors is
   begin
      if not Check_Block (Instruction (1)) then
         return Execute.M_Wrong_Block;
      end if;

      if not Check_Size (Instruction (2)) then
         return Execute.M_Wrong_Size;
      end if;
      if Block = Zero then
         --  only supports Byte/Word_0
         if Size /= Byte and Size /= Word then
            return Execute.M_Wrong_Size;
         end if;
      end if;

      if not Check_Position (Instruction (3)) then
         return Execute.M_Wrong_Position;
      end if;
      if Block = Zero then
         --  We only allow:
         --     Byte: 0/1
         --     Word: 0
         if Size = Byte then
            --  only supports Zero, One
            if Position /= Zero and Position /= One then
               return Execute.M_Wrong_Position;
            end if;
         else
            --  if Word, then only Zero
            if Position /= Zero then
               return Execute.M_Wrong_Position;
            end if;
         end if;
      else
         --  Block 1: Double Word we only support Zero
         if Size = Double_Word then
            if Position /= Zero then
               return Execute.M_Wrong_Position;
            end if;
         end if;
      end if;

      if not Check_Value (Instruction (4 .. Matrix_Instruction'Last)) then
         return Execute.M_Wrong_Value;
      end if;

      return Execute.M_OK;
   end Check_Input;

   --------------------------------------------------------------------------
   --  see .ads
   --------------------------------------------------------------------------
   function Evaluate (Instruction : Matrix_Instruction)
                      return Execute.Matrix_Command is
      RetVal : Execute.Matrix_Command;
   begin
      RetVal.Value := Value;
      if Block = Zero then
         RetVal.Block := Execute.Block_0;
      else
         RetVal.Block := Execute.Block_1;
      end if;
      case Size is
         when Byte =>
            if Position = Zero then
               RetVal.Command := Execute.Byte_0;
            elsif Position = One then
               RetVal.Command := Execute.Byte_1;
            elsif Position = Two then
               RetVal.Command := Execute.Byte_2;
            elsif Position = Three then
               RetVal.Command := Execute.Byte_3;
            end if;
         when Word =>
            if Position = Zero then
               RetVal.Command := Execute.Word_0;
            elsif Position = One then
               RetVal.Command := Execute.Word_1;
            end if;
         when Double_Word =>
            RetVal.Command := Execute.Double_Word_0;
      end case;
      return RetVal;
   end Evaluate;

   --------------------------------------------------------------------------
   --  Checks the character for the correct block request
   --------------------------------------------------------------------------
   function Check_Block (Block_Char : Character) return Boolean is
      type B_2_C_Map is array (Blocks) of Character;
      B_2_C : constant B_2_C_Map := (Zero => '0',
                                     One => '1');
   begin
      for B in B_2_C_Map'First .. B_2_C_Map'Last loop
         if Block_Char = B_2_C (B) then
            Block := B;
            return True;
         end if;
      end loop;
      return False;
   end Check_Block;

   --------------------------------------------------------------------------
   --  Checks the character for the correct size request
   --------------------------------------------------------------------------
   function Check_Size (Size_Char : Character) return Boolean is
      type S_2_C_Map is array (Sizes) of Character;
      S_2_C : constant S_2_C_Map := (Byte => 'B',
                                     Word => 'W',
                                     Double_Word => 'D'
                                    );
   begin
      for S in S_2_C_Map'First .. S_2_C_Map'Last loop
         if Size_Char = S_2_C (S) then
            Size := S;
            return True;
         end if;
      end loop;
      return False;
   end Check_Size;

   --------------------------------------------------------------------------
   --  Checks the character for the correct position request
   --------------------------------------------------------------------------
   function Check_Position (Position_Char : Character) return Boolean is
      type P_2_C_Map is array (Positions) of Character;
      P_2_C : constant P_2_C_Map
        := (Zero => '0',
            One => '1',
            Two => '2',
            Three => '3');
   begin
      for P in
        P_2_C_Map'First .. P_2_C_Map'Last loop
         if Position_Char = P_2_C (P) then
            Position := P;
            return True;
         end if;
      end loop;
      return False;
   end Check_Position;

   --------------------------------------------------------------------------
   --  Checks the characters for the correct value request
   --------------------------------------------------------------------------
   function Check_Value (Value_String : Execute.Matrix_Value_Type)
                         return Boolean is
      Last : Integer;
   begin
      case Size is
         when Byte => Last := 2;
         when Word => Last := 4;
         when Double_Word => Last := 8;
      end case;
      for I in 1 .. Last loop
         case Value_String (I) is
            when '0' .. 'F' => Value (I) := Value_String (I);
            when others => return False;
         end case;
      end loop;

      return True;
   end Check_Value;

end Evaluate.Matrices;
