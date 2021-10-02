with HAL.I2C;

generic
   I2C : HAL.I2C.Any_I2C_Port;
   Address : HAL.I2C.I2C_Address;

package Hex_2Digits_Display is

   -----------------------------------------------------------------------
   --  Shows the
   --  Number
   --  on the display having the
   --  Address
   --  on the
   --  I2C
   --  device
   procedure Show (Number : HAL.UInt8);

end Hex_2Digits_Display;
