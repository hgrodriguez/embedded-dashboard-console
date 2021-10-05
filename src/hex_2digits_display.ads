--===========================================================================
--
--  Represents an 5x7 Matrix Pimoroni display.
--    This package can only display a hex number on such a 5x7 matrix.
--
--===========================================================================
--
--  Copyright 2021 (C) Holger Rodriguez
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with HAL.I2C;

generic
   ------------------------------------------------------
   --  Define the port, where the display is connected to
   ------------------------------------------------------
   I2C : HAL.I2C.Any_I2C_Port;
   ----------------------------------------------------
   --  Define the address of the display on the I2C bus
   ----------------------------------------------------
   Address : HAL.I2C.I2C_Address;

package Hex_2Digits_Display is

   -----------------------------------------------------------------------
   --  Shows the
   --  Number
   --  on the display having the
   --  Address
   --  on the
   --  I2C
   --  bus
   --  as defined above
   procedure Show (Number : HAL.UInt8);

end Hex_2Digits_Display;
