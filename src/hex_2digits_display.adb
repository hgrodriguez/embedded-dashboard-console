with Font;
with Pimoroni_LED_Dot_Matrix;

package body Hex_2Digits_Display is

   package PLDM is new Pimoroni_LED_Dot_Matrix (I2C, Address);

   -----------------------------------------------------------------------
   --  references the font defintions, so we have easier indexing
   All_Letters : constant array (HAL.UInt4 range <>) of Font.Matrix_Array
     := ((Font.Characters (17).Bytes),
         (Font.Characters (18).Bytes),
         (Font.Characters (19).Bytes),
         (Font.Characters (20).Bytes),
         (Font.Characters (21).Bytes),
         (Font.Characters (22).Bytes),
         (Font.Characters (23).Bytes),
         (Font.Characters (24).Bytes),
         (Font.Characters (25).Bytes),
         (Font.Characters (26).Bytes),

         (Font.Characters (34).Bytes),
         (Font.Characters (35).Bytes),
         (Font.Characters (36).Bytes),
         (Font.Characters (37).Bytes),
         (Font.Characters (38).Bytes),
         (Font.Characters (39).Bytes)
        );

   -----------------------------------------------------------------------
   --  converts the font UInt8 defintions to the display matrix Boolean version
   function Convert (FMA : Font.Matrix_Array)
                        return PLDM.Display_Matrix;

   -----------------------------------------------------------------------
   --  shows the value on the left display
   procedure Show_Left (I2C     : HAL.I2C.Any_I2C_Port;
                        Address : HAL.I2C.I2C_Address;
                        Number  : HAL.UInt4);

   -----------------------------------------------------------------------
   --  shows the value on the right display
   procedure Show_Right (I2C     : HAL.I2C.Any_I2C_Port;
                         Address : HAL.I2C.I2C_Address;
                         Number  : HAL.UInt4);

   -----------------------------------------------------------------------
   procedure Show (
                   Number  : HAL.UInt8) is
      use HAL;

      Right_Block_Value : HAL.UInt4;
      Left_Block_Value  : HAL.UInt4;

   begin
      Left_Block_Value  := HAL.UInt4 (Shift_Right (Number, 4));
      Show_Left (I2C     => I2C,
                 Address => Address,
                 Number  => Left_Block_Value);

      Right_Block_Value := HAL.UInt4 (Number and 16#0F#);
      Show_Right (I2C     => I2C,
                 Address => Address,
                 Number  => Right_Block_Value);
      PLDM.
        Write_Byte_Data (
                         PLDM.Update, 1);
   end Show;

   -----------------------------------------------------------------------
   procedure Show_Left (I2C     : HAL.I2C.Any_I2C_Port;
                        Address : HAL.I2C.I2C_Address;
                        Number  : HAL.UInt4) is
      Letter_Array : Font.Matrix_Array;
      DM           : PLDM.Display_Matrix;
   begin
      --  left letter
      Letter_Array := All_Letters (Number);
      DM := Convert (Letter_Array);
      PLDM.
        Write_Block_Data (
                          PLDM.Matrix_L,
                          PLDM.To_Left_Matrix (DM));
   end Show_Left;

   -----------------------------------------------------------------------
   procedure Show_Right (I2C     : HAL.I2C.Any_I2C_Port;
                         Address : HAL.I2C.I2C_Address;
                         Number  : HAL.UInt4) is
      Letter_Array : Font.Matrix_Array;
      DM           : PLDM.Display_Matrix;
   begin
      --  left letter
      Letter_Array := All_Letters (Number);
      DM := Convert (Letter_Array);
      PLDM.
        Write_Block_Data (
                          PLDM.Matrix_R,
                          PLDM.To_Right_Matrix (DM));
   end Show_Right;

   -----------------------------------------------------------------------
   function Convert (FMA : Font.Matrix_Array)
                     return PLDM.Display_Matrix is
      Mask : HAL.UInt8;
      DM_Column : Integer;
      Result : PLDM.Display_Matrix
        := (others => (others => False));
      use HAL;
   begin
      Mask := 1;
      for Row in PLDM.Display_Matrix'First (2)
        ..
          PLDM.Display_Matrix'Last (2) loop
         DM_Column := PLDM.Display_Matrix'First (1);
         for FMA_Column in FMA'First .. FMA'Last loop
            Result (DM_Column, Row) := (FMA (FMA_Column) and Mask) /= 0;
            DM_Column := DM_Column + 1;
         end loop;
         Mask := Shift_Left (Mask, 1);
      end loop;
      return Result;
   end Convert;
end Hex_2Digits_Display;
