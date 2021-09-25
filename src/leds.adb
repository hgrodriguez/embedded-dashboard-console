--  Copyright 2021 (C) Holger Rodriguez
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with RP.GPIO;
with ItsyBitsy;

package body LEDs is
   subtype LED_Type is RP.GPIO.GPIO_Point;

   LED_0_Red : LED_Type renames ItsyBitsy.GP26;

   LED_0_Amber : LED_Type renames ItsyBitsy.GP27;

   LED_0_Green : LED_Type renames ItsyBitsy.GP28;

   LED_0_White : LED_Type renames ItsyBitsy.GP29;

   LED_0_Blue  : LED_Type renames ItsyBitsy.GP24;

   procedure LED_0_Red_Toggle is
   begin
      LED_0_Red.Toggle;
   end LED_0_Red_Toggle;

   procedure LED_0_Amber_Toggle is
   begin
      LED_0_Amber.Toggle;
   end LED_0_Amber_Toggle;

   procedure LED_0_Green_Toggle is
   begin
      LED_0_Green.Toggle;
   end LED_0_Green_Toggle;

   procedure LED_0_White_Toggle is
   begin
      LED_0_White.Toggle;
   end LED_0_White_Toggle;

   procedure LED_0_Blue_Toggle is
   begin
      LED_0_Blue.Toggle;
   end LED_0_Blue_Toggle;

begin
   LED_0_Red.Configure (RP.GPIO.Output);
   LED_0_Amber.Configure (RP.GPIO.Output);
   LED_0_Green.Configure (RP.GPIO.Output);
   LED_0_White.Configure (RP.GPIO.Output);
   LED_0_Blue.Configure (RP.GPIO.Output);
end LEDs;
