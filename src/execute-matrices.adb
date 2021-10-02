with Interfaces;

with HAL;
with ItsyBitsy;

with Matrix_Area_Word;

package body Execute.Matrices is

   MyNumber_0 : HAL.UInt8 := HAL.UInt8'First;
   MyNumber_1 : HAL.UInt8 := HAL.UInt8'Last;

   subtype Input_String is String (1 .. 2);
   function Convert_To_UInt8 (Value : Input_String) return HAL.UInt8;

   function Convert_To_UInt16 (Value : Standard.Execute.Value_String_Type)
                               return HAL.UInt16;

   procedure Execute (Cmd : Matrix_Command) is
      Byte_Val : constant Standard.Execute.Value_String_Type := Cmd.Value;
      Byte_Num : constant HAL.UInt8 := Convert_To_UInt8 (Byte_Val (1 .. 2));

      Word_Val : constant Standard.Execute.Value_String_Type := Cmd.Value;
      MSB      : constant HAL.UInt8 := Convert_To_UInt8 (Word_Val (1 .. 2));
      LSB      : constant HAL.UInt8 := Convert_To_UInt8 (Word_Val (3 .. 4));

      use HAL;
   begin
      ItsyBitsy.LED.Toggle;
      case Cmd.Command is
         when Byte_0 =>
            Matrix_Area_Word.Byte_0.Show (Number => Byte_Num);
         when Byte_1 =>
            Matrix_Area_Word.Byte_1.Show (Number => Byte_Num);
         when Word_0 =>
            Matrix_Area_Word.Byte_0.Show (Number => LSB);
            Matrix_Area_Word.Byte_1.Show (Number => MSB);
      end case;
   end Execute;

   function Convert_To_UInt8 (Value : Input_String) return HAL.UInt8 is
      LSB_C  : constant Character := Value (2);
      LSB_U  : Interfaces.Unsigned_8;
      MSB_C  : constant Character := Value (1);
      MSB_U  : Interfaces.Unsigned_8;
      RetVal : HAL.UInt8;

      use Interfaces;
   begin
      if LSB_C = '0' then
         LSB_U := 0;
      elsif LSB_C = '1' then
         LSB_U := 1;
      elsif LSB_C = '2' then
         LSB_U := 2;
      elsif LSB_C = '3' then
         LSB_U := 3;
      elsif LSB_C = '4' then
         LSB_U := 4;
      elsif LSB_C = '5' then
         LSB_U := 5;
      elsif LSB_C = '6' then
         LSB_U := 6;
      elsif LSB_C = '7' then
         LSB_U := 7;
      elsif LSB_C = '8' then
         LSB_U := 8;
      elsif LSB_C = '9' then
         LSB_U := 9;
      elsif LSB_C = 'A' then
         LSB_U := 10;
      elsif LSB_C = 'B' then
         LSB_U := 11;
      elsif LSB_C = 'C' then
         LSB_U := 12;
      elsif LSB_C = 'D' then
         LSB_U := 13;
      elsif LSB_C = 'E' then
         LSB_U := 14;
      elsif LSB_C = 'F' then
         LSB_U := 15;
      end if;

      if MSB_C = '0' then
         MSB_U := 0;
      elsif MSB_C = '1' then
         MSB_U := 1;
      elsif MSB_C = '2' then
         MSB_U := 2;
      elsif MSB_C = '3' then
         MSB_U := 3;
      elsif MSB_C = '4' then
         MSB_U := 4;
      elsif MSB_C = '5' then
         MSB_U := 5;
      elsif MSB_C = '6' then
         MSB_U := 6;
      elsif MSB_C = '7' then
         MSB_U := 7;
      elsif MSB_C = '8' then
         MSB_U := 8;
      elsif MSB_C = '9' then
         MSB_U := 9;
      elsif MSB_C = 'A' then
         MSB_U := 10;
      elsif MSB_C = 'B' then
         MSB_U := 11;
      elsif MSB_C = 'C' then
         MSB_U := 12;
      elsif MSB_C = 'D' then
         MSB_U := 13;
      elsif MSB_C = 'E' then
         MSB_U := 14;
      elsif MSB_C = 'F' then
         MSB_U := 15;
      end if;

      RetVal := HAL.UInt8 (Interfaces.Shift_Left (MSB_U, 4) + LSB_U);
      return RetVal;
   end Convert_To_UInt8;

   function Convert_To_UInt16 (Value : Standard.Execute.Value_String_Type)
                               return HAL.UInt16 is
      use Interfaces;

      MSB_S  : constant Input_String := Value (1 .. 2);
      MSB_U  : constant Unsigned_8 := Unsigned_8 (Convert_To_UInt8 (MSB_S));
      LSB_S  : constant Input_String := Value (3 .. 4);
      LSB_U  : constant Unsigned_8 := Unsigned_8 (Convert_To_UInt8 (LSB_S));
      RetVal : HAL.UInt16;
   begin
      RetVal := HAL.UInt16 (Interfaces.Shift_Left (MSB_U, 8) + LSB_U);
      return RetVal;
   end Convert_To_UInt16;

end Execute.Matrices;
