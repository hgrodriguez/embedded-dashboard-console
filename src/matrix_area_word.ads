with ItsyBitsy;

with Hex_2Digits_Display;

package Matrix_Area_Word is

   package Byte_0 is new
     Hex_2Digits_Display (ItsyBitsy.I2C'Access, 16#61# * 2);
   package Byte_1 is new
     Hex_2Digits_Display (ItsyBitsy.I2C'Access, 16#62# * 2);

end Matrix_Area_Word;
