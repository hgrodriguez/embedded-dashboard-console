--===========================================================================
--
--  This package defines the four 5x7 matrix elements used for the
--   DOUBLE WORD sized display capability
--
--===========================================================================
--  Copyright 2021 (C) Holger Rodriguez
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with HAL; use HAL;
with HAL.I2C;

with RP.I2C_Master;
with RP.Device;

with ItsyBitsy;

with Hex_2Digits_Display;

package Matrix_Area_Double_Word is

   I2C_1 : RP.I2C_Master.I2C_Master_Port renames ItsyBitsy.I2C;

   --------------------------------------------------------------------------
   --  Byte 1: this display is in the right side of the two displays
   --          represents the higher byte of the lower word
   --------------------------------------------------------------------------
   Byte_0_I2C     : HAL.I2C.Any_I2C_Port := I2C_1'Access;
   Byte_0_Address : HAL.I2C.I2C_Address := 16#63# * 2;
   package Byte_0 is new
     Hex_2Digits_Display (Byte_0_I2C, Byte_0_Address);

   I2C_0 : RP.I2C_Master.I2C_Master_Port renames RP.Device.I2C_0;

   --------------------------------------------------------------------------
   --  Byte 1: this display is in the right side of the two displays
   --          represents the higher byte of the lower word
   --------------------------------------------------------------------------
   Byte_1_I2C     : HAL.I2C.Any_I2C_Port := I2C_0'Access;
   Byte_1_Address : HAL.I2C.I2C_Address := 16#61# * 2;
   package Byte_1 is new
     Hex_2Digits_Display (Byte_1_I2C, Byte_1_Address);

   --------------------------------------------------------------------------
   --  Byte 2: this display is in the right side of the two displays
   --          represents the lower byte of the higher word
   --------------------------------------------------------------------------
   Byte_2_I2C     : HAL.I2C.Any_I2C_Port := I2C_0'Access;
   Byte_2_Address : HAL.I2C.I2C_Address := 16#62# * 2;
   package Byte_2 is new
     Hex_2Digits_Display (Byte_2_I2C, Byte_2_Address);

   --------------------------------------------------------------------------
   --  Byte 3: this display is in the left side of the two displays
   --          represents the higher byte of the higher word
   --------------------------------------------------------------------------
   Byte_3_I2C     : HAL.I2C.Any_I2C_Port := I2C_0'Access;
   Byte_3_Address : HAL.I2C.I2C_Address := 16#63# * 2;
   package Byte_3 is new
     Hex_2Digits_Display (Byte_3_I2C, Byte_3_Address);

   --------------------------------------------------------------------------
   --  Initializes the Double Word Matrix Block
   --     Must be called before anything else regarding the matrix.
   --------------------------------------------------------------------------
   procedure Initialize;

end Matrix_Area_Double_Word;
