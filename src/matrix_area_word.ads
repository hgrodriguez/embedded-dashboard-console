--===========================================================================
--
--  This package defines the two 5x7 matrix elements used for the WORD
--  sized display capability
--
--===========================================================================
--  Copyright 2021 (C) Holger Rodriguez
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with HAL; use HAL;
with HAL.I2C;

with ItsyBitsy;

with Hex_2Digits_Display;

package Matrix_Area_Word is

   --------------------------------------------------------------------------
   --  Byte 0: this display is in the right side of the two displays
   --          represents the lower byte of the word
   --------------------------------------------------------------------------
   Byte_0_I2C     : HAL.I2C.Any_I2C_Port := ItsyBitsy.I2C'Access;
   Byte_0_Address : HAL.I2C.I2C_Address := 16#61# * 2;
   package Byte_0 is new
     Hex_2Digits_Display (Byte_0_I2C, Byte_0_Address);

   --------------------------------------------------------------------------
   --  Byte 1: this display is in the left side of the two displays
   --          represents the higher byte of the word
   --------------------------------------------------------------------------
   Byte_1_I2C     : HAL.I2C.Any_I2C_Port := ItsyBitsy.I2C'Access;
   Byte_1_Address : HAL.I2C.I2C_Address := 16#62# * 2;
   package Byte_1 is new
     Hex_2Digits_Display (Byte_1_I2C, Byte_1_Address);

end Matrix_Area_Word;
