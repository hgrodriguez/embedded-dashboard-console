--  Copyright 2021 (C) Holger Rodriguez
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with RP.Device;
with RP.GPIO;
with ItsyBitsy;

package body LED_Control is
   subtype LED_Type is RP.GPIO.GPIO_Point;

   -----------------------------------------------------------------------
   --  All Red LED related definitions
   -----------------------------------------------------------------------
   LED_0_Red : LED_Type renames ItsyBitsy.GP26;
   procedure LED_0_Red_Off is
   begin
      LED_0_Red.Clear;
   end LED_0_Red_Off;

   procedure LED_0_Red_On is
   begin
      LED_0_Red.Set;
   end LED_0_Red_On;

   procedure LED_0_Red_Toggle is
   begin
      LED_0_Red.Toggle;
   end LED_0_Red_Toggle;

   -----------------------------------------------------------------------
   --  All Amber LED related definitions
   -----------------------------------------------------------------------
   LED_0_Amber : LED_Type renames ItsyBitsy.GP27;
   procedure LED_0_Amber_Off is
   begin
      LED_0_Amber.Clear;
   end LED_0_Amber_Off;

   procedure LED_0_Amber_On is
   begin
      LED_0_Amber.Set;
   end LED_0_Amber_On;

   procedure LED_0_Amber_Toggle is
   begin
      LED_0_Amber.Toggle;
   end LED_0_Amber_Toggle;

   -----------------------------------------------------------------------
   --  All Green LED related definitions
   -----------------------------------------------------------------------
   LED_0_Green : LED_Type renames ItsyBitsy.GP28;
   procedure LED_0_Green_Off is
   begin
      LED_0_Green.Clear;
   end LED_0_Green_Off;

   procedure LED_0_Green_On is
   begin
      LED_0_Green.Set;
   end LED_0_Green_On;

   procedure LED_0_Green_Toggle is
   begin
      LED_0_Green.Toggle;
   end LED_0_Green_Toggle;

   -----------------------------------------------------------------------
   --  All White LED related definitions
   -----------------------------------------------------------------------
   LED_0_White : LED_Type renames ItsyBitsy.GP29;
   procedure LED_0_White_Off is
   begin
      LED_0_White.Clear;
   end LED_0_White_Off;

   procedure LED_0_White_On is
   begin
      LED_0_White.Set;
   end LED_0_White_On;

   procedure LED_0_White_Toggle is
   begin
      LED_0_White.Toggle;
   end LED_0_White_Toggle;

   -----------------------------------------------------------------------
   --  All Blue LED related definitions
   -----------------------------------------------------------------------
   LED_0_Blue  : LED_Type renames ItsyBitsy.GP24;
   procedure LED_0_Blue_Off is
   begin
      LED_0_Blue.Clear;
   end LED_0_Blue_Off;

   procedure LED_0_Blue_On is
   begin
      LED_0_Blue.Set;
   end LED_0_Blue_On;

   procedure LED_0_Blue_Toggle is
   begin
      LED_0_Blue.Toggle;
   end LED_0_Blue_Toggle;

   -----------------------------------------------------------------------
   --  see .ads
   -----------------------------------------------------------------------
   procedure Toggle_All_LEDs (Delay_Between_In_Milliseconds : Integer
                              := WAIT_FOR_NEXT_LED) is
   begin
      LED_0_Red_Toggle;
      RP.Device.Timer.Delay_Milliseconds (Delay_Between_In_Milliseconds);
      LED_0_Amber_Toggle;
      RP.Device.Timer.Delay_Milliseconds (Delay_Between_In_Milliseconds);
      LED_0_Green_Toggle;
      RP.Device.Timer.Delay_Milliseconds (Delay_Between_In_Milliseconds);
      LED_0_White_Toggle;
      RP.Device.Timer.Delay_Milliseconds (Delay_Between_In_Milliseconds);
      LED_0_Blue_Toggle;
      RP.Device.Timer.Delay_Milliseconds (Delay_Between_In_Milliseconds);
   end Toggle_All_LEDs;

begin
   LED_0_Red.Configure (RP.GPIO.Output);
   LED_0_Amber.Configure (RP.GPIO.Output);
   LED_0_Green.Configure (RP.GPIO.Output);
   LED_0_White.Configure (RP.GPIO.Output);
   LED_0_Blue.Configure (RP.GPIO.Output);
end LED_Control;
