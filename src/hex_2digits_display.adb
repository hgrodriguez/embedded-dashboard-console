--
--  Copyright 2021 (C) Holger Rodriguez
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with Font;
with Pimoroni_LED_Dot_Matrix;

package body Hex_2Digits_Display is

   -----------------------------------------------------------------------
   --  represents the hardware piece to use for display
   -----------------------------------------------------------------------
   package PLDM is new Pimoroni_LED_Dot_Matrix (I2C, Address);

   -----------------------------------------------------------------------
   --  references the font defintions, so we have easier indexing
   All_Letters : constant array (HAL.UInt4 range <>) of Font.Matrix_Array
     := ((Font.Characters (17).Bytes), --  0
         (Font.Characters (18).Bytes), --  1
         (Font.Characters (19).Bytes), --  2
         (Font.Characters (20).Bytes), --  3
         (Font.Characters (21).Bytes), --  4
         (Font.Characters (22).Bytes), --  5
         (Font.Characters (23).Bytes), --  6
         (Font.Characters (24).Bytes), --  7
         (Font.Characters (25).Bytes), --  8
         (Font.Characters (26).Bytes), --  9
         (Font.Characters (34).Bytes), --  A
         (Font.Characters (35).Bytes), --  B
         (Font.Characters (36).Bytes), --  C
         (Font.Characters (37).Bytes), --  D
         (Font.Characters (38).Bytes), --  E
         (Font.Characters (39).Bytes)  --  F
        );

   -----------------------------------------------------------------------
   --  shows the value on the left display
   -----------------------------------------------------------------------
   procedure Show_Left (Number  : HAL.UInt4);

   -----------------------------------------------------------------------
   --  shows the value on the right display
   -----------------------------------------------------------------------
   procedure Show_Right (Number  : HAL.UInt4);

   -----------------------------------------------------------------------
   --  see .ads
   -----------------------------------------------------------------------
   procedure Show (Number  : HAL.UInt8) is
      use HAL;

      Right_Block_Value : HAL.UInt4;
      Left_Block_Value  : HAL.UInt4;

   begin
      Left_Block_Value  := HAL.UInt4 (Shift_Right (Number, 4));
      Show_Left (Number => Left_Block_Value);

      Right_Block_Value := HAL.UInt4 (Number and 16#0F#);
      Show_Right (Number => Right_Block_Value);
      PLDM.
        Write_Byte_Data (
                         PLDM.Update, 1);
   end Show;

   -----------------------------------------------------------------------
   --  converts the
   --    Font.Matrix_Array into the required PLDM.Display_Matrix format
   -----------------------------------------------------------------------
   function Convert (FMA : Font.Matrix_Array)
                     return PLDM.Display_Matrix;

   -----------------------------------------------------------------------
   --  shows the value on the left display
   -----------------------------------------------------------------------
   procedure Show_Left (Number : HAL.UInt4) is
      Letter_Array : Font.Matrix_Array;
      DM           : PLDM.Display_Matrix;
   begin
      --  left letter
      Letter_Array := All_Letters (Number);
      DM := Convert (Letter_Array);
      PLDM.Write_Block_Data (PLDM.Matrix_L, PLDM.To_Left_Matrix (DM));
   end Show_Left;

   -----------------------------------------------------------------------
   --  shows the value on the right display
   -----------------------------------------------------------------------
   procedure Show_Right (Number : HAL.UInt4) is
      Letter_Array : Font.Matrix_Array;
      DM           : PLDM.Display_Matrix;
   begin
      --  right letter
      Letter_Array := All_Letters (Number);
      DM := Convert (Letter_Array);
      PLDM.Write_Block_Data (PLDM.Matrix_R, PLDM.To_Right_Matrix (DM));
   end Show_Right;

   -----------------------------------------------------------------------
   --  converts the
   --    Font.Matrix_Array into the required PLDM.Display_Matrix format
   -----------------------------------------------------------------------
   function Convert (FMA : Font.Matrix_Array) return PLDM.Display_Matrix is
      Mask   : HAL.UInt8;
      Column : Integer;
      Result : PLDM.Display_Matrix := (others => (others => False));
      use HAL;
   begin
      Mask := 1;
      for Row in PLDM.Display_Matrix'First (2)
        ..
          PLDM.Display_Matrix'Last (2) loop
         Column := PLDM.Display_Matrix'First (1);
         for FMA_Column in FMA'First .. FMA'Last loop
            Result (Column, Row) := (FMA (FMA_Column) and Mask) /= 0;
            Column := Column + 1;
         end loop;
         Mask := Shift_Left (Mask, 1);
      end loop;
      return Result;
   end Convert;

end Hex_2Digits_Display;
