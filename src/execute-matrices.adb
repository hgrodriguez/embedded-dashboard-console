--
--  Copyright 2021 (C) Holger Rodriguez
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with Interfaces;

with HAL;

with Matrix_Area_Word;
with Matrix_Area_Double_Word;

package body Execute.Matrices is

   --------------------------------------------------------------------------
   --  Conversion functions from Character/String to UInt?
   --------------------------------------------------------------------------
   function Convert_To_UInt4 (Value : Character) return HAL.UInt4;

   subtype Byte_Input_String is String (1 .. 2);
   function Convert_To_UInt8 (Value : Byte_Input_String) return HAL.UInt8;

   function Convert_To_UInt16 (Value : Standard.Execute.Matrix_Value_Type)
                               return HAL.UInt16;

   --------------------------------------------------------------------------
   --  see .ads
   --------------------------------------------------------------------------
   procedure Execute (Cmd : Matrix_Command) is
      Value    : constant Standard.Execute.Matrix_Value_Type := Cmd.Value;
      Byte_Num :  HAL.UInt8;
   begin
      if Cmd.Block = Block_0 then
         case Cmd.Command is
            when Byte_0 =>
               Byte_Num := Convert_To_UInt8 (Value (1 .. 2));
               Matrix_Area_Word.Byte_0.Show (Number => Byte_Num);
            when Byte_1 =>
               Byte_Num := Convert_To_UInt8 (Value (1 .. 2));
               Matrix_Area_Word.Byte_1.Show (Number => Byte_Num);
            when Word_0 =>
               Byte_Num := Convert_To_UInt8 (Value (1 .. 2));
               Matrix_Area_Word.Byte_1.Show (Number => Byte_Num);

               Byte_Num := Convert_To_UInt8 (Value (3 .. 4));
               Matrix_Area_Word.Byte_0.Show (Number => Byte_Num);
            when others =>
               null;
         end case;
      else
         case Cmd.Command is
            when Byte_0 =>
               Byte_Num := Convert_To_UInt8 (Value (1 .. 2));
               Matrix_Area_Double_Word.Byte_0.Show (Number => Byte_Num);
            when Byte_1 =>
               Byte_Num := Convert_To_UInt8 (Value (1 .. 2));
               Matrix_Area_Double_Word.Byte_1.Show (Number => Byte_Num);
            when Byte_2 =>
               Byte_Num := Convert_To_UInt8 (Value (1 .. 2));
               Matrix_Area_Double_Word.Byte_2.Show (Number => Byte_Num);
            when Byte_3 =>
               Byte_Num := Convert_To_UInt8 (Value (1 .. 2));
               Matrix_Area_Double_Word.Byte_3.Show (Number => Byte_Num);

            when Word_0 =>
               Byte_Num := Convert_To_UInt8 (Value (1 .. 2));
               Matrix_Area_Double_Word.Byte_1.Show (Number => Byte_Num);

               Byte_Num := Convert_To_UInt8 (Value (3 .. 4));
               Matrix_Area_Double_Word.Byte_0.Show (Number => Byte_Num);

            when Word_1 =>
               Byte_Num := Convert_To_UInt8 (Value (1 .. 2));
               Matrix_Area_Double_Word.Byte_3.Show (Number => Byte_Num);

               Byte_Num := Convert_To_UInt8 (Value (3 .. 4));
               Matrix_Area_Double_Word.Byte_2.Show (Number => Byte_Num);

            when Double_Word_0 =>
               Byte_Num := Convert_To_UInt8 (Value (1 .. 2));
               Matrix_Area_Double_Word.Byte_3.Show (Number => Byte_Num);

               Byte_Num := Convert_To_UInt8 (Value (3 .. 4));
               Matrix_Area_Double_Word.Byte_2.Show (Number => Byte_Num);

               Byte_Num := Convert_To_UInt8 (Value (5 .. 6));
               Matrix_Area_Double_Word.Byte_1.Show (Number => Byte_Num);

               Byte_Num := Convert_To_UInt8 (Value (7 .. 8));
               Matrix_Area_Double_Word.Byte_0.Show (Number => Byte_Num);
         end case;
      end if;
   end Execute;

   --------------------------------------------------------------------------
   --  Convert one character representing
   --  a hex digit into an UInt4 value (Nibble)
   --------------------------------------------------------------------------
   function Convert_To_UInt4 (Value : Character) return HAL.UInt4 is
      RetVal : HAL.UInt4;
   begin
      if Value = '0' then
         RetVal := 0;
      elsif Value = '1' then
         RetVal := 1;
      elsif Value = '2' then
         RetVal := 2;
      elsif Value = '3' then
         RetVal := 3;
      elsif Value = '4' then
         RetVal := 4;
      elsif Value = '5' then
         RetVal := 5;
      elsif Value = '6' then
         RetVal := 6;
      elsif Value = '7' then
         RetVal := 7;
      elsif Value = '8' then
         RetVal := 8;
      elsif Value = '9' then
         RetVal := 9;
      elsif Value = 'A' then
         RetVal := 10;
      elsif Value = 'B' then
         RetVal := 11;
      elsif Value = 'C' then
         RetVal := 12;
      elsif Value = 'D' then
         RetVal := 13;
      elsif Value = 'E' then
         RetVal := 14;
      elsif Value = 'F' then
         RetVal := 15;
      end if;
      return RetVal;
   end Convert_To_UInt4;

   --------------------------------------------------------------------------
   --  Convert two characters representing
   --  a two hex digit number into an UInt8 value (Byte)
   --------------------------------------------------------------------------
   function Convert_To_UInt8 (Value : Byte_Input_String) return HAL.UInt8 is
      LSB_U  : constant Interfaces.Unsigned_8
        := Interfaces.Unsigned_8 (Convert_To_UInt4 (Value (2)));
      MSB_U  : constant Interfaces.Unsigned_8
        := Interfaces.Unsigned_8 (Convert_To_UInt4 (Value (1)));
      RetVal : HAL.UInt8;

      use Interfaces;
   begin
      RetVal := HAL.UInt8 (Interfaces.Shift_Left (MSB_U, 4) + LSB_U);
      return RetVal;
   end Convert_To_UInt8;

   --------------------------------------------------------------------------
   --  Convert four characters representing
   --  a four hex digit number into an UInt16 value (Word)
   --------------------------------------------------------------------------
   function Convert_To_UInt16 (Value : Standard.Execute.Matrix_Value_Type)
                            return HAL.UInt16 is
      use Interfaces;

      MSB_S  : constant Byte_Input_String := Value (1 .. 2);
      MSB_U  : constant Unsigned_8 := Unsigned_8 (Convert_To_UInt8 (MSB_S));
      LSB_S  : constant Byte_Input_String := Value (3 .. 4);
      LSB_U  : constant Unsigned_8 := Unsigned_8 (Convert_To_UInt8 (LSB_S));
      RetVal : HAL.UInt16;
   begin
      RetVal := HAL.UInt16 (Interfaces.Shift_Left (MSB_U, 8) + LSB_U);
      return RetVal;
   end Convert_To_UInt16;

end Execute.Matrices;
