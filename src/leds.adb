--  Copyright 2021 (C) Holger Rodriguez
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with RP.Device;
with RP.GPIO;
with ItsyBitsy;

package body LEDs is
   subtype LED_Type is RP.GPIO.GPIO_Point;

   -----------------------------------------------------------------------
   --  All Red LED related definitions
   LED_0_Red : LED_Type renames ItsyBitsy.GP26;
   procedure LED_0_Red_Clear is
   begin
      LED_0_Red.Clear;
   end LED_0_Red_Clear;

   procedure LED_0_Red_Set is
   begin
      LED_0_Red.Set;
   end LED_0_Red_Set;

   procedure LED_0_Red_Toggle is
   begin
      LED_0_Red.Toggle;
   end LED_0_Red_Toggle;

   -----------------------------------------------------------------------
   --  All Amber LED related definitions
   LED_0_Amber : LED_Type renames ItsyBitsy.GP27;
   procedure LED_0_Amber_Clear is
   begin
      LED_0_Amber.Clear;
   end LED_0_Amber_Clear;

   procedure LED_0_Amber_Set is
   begin
      LED_0_Amber.Set;
   end LED_0_Amber_Set;

   procedure LED_0_Amber_Toggle is
   begin
      LED_0_Amber.Toggle;
   end LED_0_Amber_Toggle;

   -----------------------------------------------------------------------
   --  All Green LED related definitions
   LED_0_Green : LED_Type renames ItsyBitsy.GP28;
   procedure LED_0_Green_Clear is
   begin
      LED_0_Green.Clear;
   end LED_0_Green_Clear;

   procedure LED_0_Green_Set is
   begin
      LED_0_Green.Set;
   end LED_0_Green_Set;

   procedure LED_0_Green_Toggle is
   begin
      LED_0_Green.Toggle;
   end LED_0_Green_Toggle;

   -----------------------------------------------------------------------
   --  All White LED related definitions
   LED_0_White : LED_Type renames ItsyBitsy.GP29;
   procedure LED_0_White_Clear is
   begin
      LED_0_White.Clear;
   end LED_0_White_Clear;

   procedure LED_0_White_Set is
   begin
      LED_0_White.Set;
   end LED_0_White_Set;

   procedure LED_0_White_Toggle is
   begin
      LED_0_White.Toggle;
   end LED_0_White_Toggle;

   -----------------------------------------------------------------------
   --  All Blue LED related definitions
   LED_0_Blue  : LED_Type renames ItsyBitsy.GP24;
   procedure LED_0_Blue_Clear is
   begin
      LED_0_Blue.Clear;
   end LED_0_Blue_Clear;

   procedure LED_0_Blue_Set is
   begin
      LED_0_Blue.Set;
   end LED_0_Blue_Set;

   procedure LED_0_Blue_Toggle is
   begin
      LED_0_Blue.Toggle;
   end LED_0_Blue_Toggle;

   -----------------------------------------------------------------------
   --  All Blue LED related definitions
   procedure Toggle_All_LEDs (Delay_Between_In_Milliseconds : Integer) is
   begin
      LEDs.LED_0_Red_Toggle;
      RP.Device.Timer.Delay_Milliseconds (Delay_Between_In_Milliseconds);
      LEDs.LED_0_Amber_Toggle;
      RP.Device.Timer.Delay_Milliseconds (Delay_Between_In_Milliseconds);
      LEDs.LED_0_Green_Toggle;
      RP.Device.Timer.Delay_Milliseconds (Delay_Between_In_Milliseconds);
      LEDs.LED_0_White_Toggle;
      RP.Device.Timer.Delay_Milliseconds (Delay_Between_In_Milliseconds);
      LEDs.LED_0_Blue_Toggle;
      RP.Device.Timer.Delay_Milliseconds (Delay_Between_In_Milliseconds);
   end Toggle_All_LEDs;

begin
   LED_0_Red.Configure (RP.GPIO.Output);
   LED_0_Amber.Configure (RP.GPIO.Output);
   LED_0_Green.Configure (RP.GPIO.Output);
   LED_0_White.Configure (RP.GPIO.Output);
   LED_0_Blue.Configure (RP.GPIO.Output);
end LEDs;
