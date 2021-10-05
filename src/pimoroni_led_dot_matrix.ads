--
--  Copyright 2021 (C) Jeremy Grosser
--
--  SPDX-License-Identifier: BSD-3-Clause
--
--  This is a driver for the Pimoroni PIM526 LED Dot Matrix Breakout using an
--  IS31FL3730 I2C LED matrix driver to control two LTP-305 5x7 matrices.
--  https://shop.pimoroni.com/products/led-dot-matrix-breakout
--
--  The breakout board includes pullups on the SDA and SCL pins, internal
--  pullups are unnecessary.
--
with Ada.Unchecked_Conversion;
with Interfaces;
with HAL.I2C;

generic
   Matrix_I2CPort : HAL.I2C.Any_I2C_Port;
   Matrix_Address : HAL.I2C.I2C_Address;

package Pimoroni_LED_Dot_Matrix is

   Default_Address : constant HAL.I2C.I2C_Address := 16#61#;

   subtype Display_Column is Integer range 0 .. 4;
   subtype Display_Row is Integer range 0 .. 6;
   type Display_Matrix is array (Display_Column, Display_Row) of Boolean;

   type Matrix_Bits is new Interfaces.Unsigned_64;
   subtype Matrix_Array is HAL.UInt8_Array (1 .. 8);

   type Command is (Mode,
                    Matrix_R,
                    Update,
                    Options,
                    Matrix_L,
                    Brightness,
                    Reset)
      with Size => 8;

   for Command use (
       Mode       => 16#00#,
       Matrix_R   => 16#01#,
       Update     => 16#0C#,
       Options    => 16#0D#,
       Matrix_L   => 16#0E#,
       Brightness => 16#19#,
       Reset      => 16#FF#
    );

   type Outputs is (Matrix_1, Matrix_2, Both)
      with Size => 2;

   for Outputs use
      (Matrix_1 => 2#00#,
       Matrix_2 => 2#01#,
       Both     => 2#11#);

   type Matrix_Modes is (Matrix_8x8, Matrix_7x9, Matrix_6x10, Matrix_5x11)
      with Size => 2;

   for Matrix_Modes use
      (Matrix_8x8  => 2#00#,
       Matrix_7x9  => 2#01#,
       Matrix_6x10 => 2#10#,
       Matrix_5x11 => 2#11#);

   type Config_Register is record
      Shutdown    : Boolean := False;
      Reserved    : Boolean := False;
      Output      : Outputs := Both;
      Audio_In    : Boolean := False;
      Matrix_Mode : Matrix_Modes := Matrix_8x8;
   end record
      with Size => 8;

   for Config_Register use record
      Shutdown    at 0 range 7 .. 7;
      Reserved    at 0 range 5 .. 6;
      Output      at 0 range 3 .. 4;
      Audio_In    at 0 range 2 .. 2;
      Matrix_Mode at 0 range 0 .. 1;
   end record;

   procedure Initialize;

   function Convert is new Ada.Unchecked_Conversion
      (Source => Matrix_Bits,
       Target => Matrix_Array);

   function Convert is new Ada.Unchecked_Conversion
      (Source => Config_Register,
       Target => HAL.UInt8);

   procedure Write_Byte_Data
      (Cmd     : Command;
       B       : HAL.UInt8);

   procedure Write_Block_Data
      (Cmd     : Command;
       Data    : HAL.UInt8_Array);

   function To_Left_Matrix
      (DM : Display_Matrix;
       DP : Boolean := False)
      return Matrix_Array;

   function To_Right_Matrix
      (DM : Display_Matrix;
       DP : Boolean := False)
      return Matrix_Array;

end Pimoroni_LED_Dot_Matrix;
