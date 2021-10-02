--
--  Copyright 2021 (C) Holger Rodriguez
--
--  SPDX-License-Identifier: BSD-3-Clause
--
package body Evaluate.Matrices is

   --------------------------------------------------------------------------
   --  Check functions for the input received
   --  Those functions set the global variables to the received value
   --------------------------------------------------------------------------
   function Check_Block (Block_Char : Character) return Boolean;
   function Check_Size (Size_Char : Character) return Boolean;
   function Check_Position (Position_Char : Character) return Boolean;
   function Check_Value (Value_String : Execute.Value_String_Type)
                         return Boolean;

   --------------------------------------------------------------------------
   --  Those variables hold the input received and are set by the
   --  different Check_ functions
   --------------------------------------------------------------------------
   Block    : Blocks; pragma Warnings (Off, Block);
   Size     : Sizes;
   Position : Positions;
   Value    : Execute.Value_String_Type;

   function Check_Input (Instruction : Matrix_Instruction)
                         return Execute.Matrix_Errors is
   begin
      if not Check_Block (Instruction (1)) then
         return Execute.M_Wrong_Block;
      end if;

      if not Check_Size (Instruction (2)) then
         return Execute.M_Wrong_Size;
      end if;

      if not Check_Position (Instruction (3)) then
         return Execute.M_Wrong_Position;
      end if;

      if not Check_Value (Instruction (4 .. Matrix_Instruction'Last)) then
         return Execute.M_Wrong_Value;
      end if;

      return Execute.M_OK;
   end Check_Input;


   function Evaluate (Instruction : Matrix_Instruction)
                      return Execute.Matrix_Command is
      RetVal : Execute.Matrix_Command;
   begin
      RetVal.Value := Value;
      if Size = Byte then
         if Position = Zero then
            RetVal.Command := Execute.Byte_0;
         elsif Position = One then
            RetVal.Command := Execute.Byte_1;
         end if;
      elsif Size = Word then
         RetVal.Command := Execute.Word_0;
      end if;
      return RetVal;
   end Evaluate;

   function Check_Block (Block_Char : Character) return Boolean is
      type B_2_C_Map is array (Blocks) of Character;
      B_2_C : constant B_2_C_Map := (Zero => '0');
   begin
      for B in B_2_C_Map'First .. B_2_C_Map'Last loop
         if Block_Char = B_2_C (B) then
            Block := B;
            return True;
         end if;
      end loop;
      return False;
   end Check_Block;

   function Check_Size (Size_Char : Character) return Boolean is
      type S_2_C_Map is array (Sizes) of Character;
      S_2_C : constant S_2_C_Map := (Byte => 'B',
                                     Word => 'W'
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

   function Check_Position (Position_Char : Character) return Boolean is
      type P_2_C_Map is array (Positions) of Character;
      P_2_C : constant P_2_C_Map
        := (Zero => '0',
            One => '1');
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

   function Check_Value (Value_String : Execute.Value_String_Type)
                         return Boolean is
      MSB             : constant String (1 .. 2) := Value_String (1 .. 2);
      MSB_Nibble_High : constant Character := MSB (1);
      MSB_Nibble_Low  : constant Character := MSB (2);
      LSB             : constant String (1 .. 2) := Value_String (3 .. 4);
      LSB_Nibble_High : constant Character := LSB (1);
      LSB_Nibble_Low  : constant Character := LSB (2);
   begin
      case MSB_Nibble_High is
         when '0' .. 'F' => Value (1) := MSB_Nibble_High;
         when others => return False;
      end case;

      case MSB_Nibble_Low is
         when '0' .. 'F' => Value (2) := MSB_Nibble_Low;
         when  others => return False;
      end case;

      if Size = Word then
         case LSB_Nibble_High is
            when '0' .. 'F' => Value (3) := LSB_Nibble_High;
            when  others => return False;
         end case;

         case LSB_Nibble_Low is
            when '0' .. 'F' => Value (4) := LSB_Nibble_Low;
            when  others => return False;
         end case;
      end if;

      return True;
   end Check_Value;

end Evaluate.Matrices;
