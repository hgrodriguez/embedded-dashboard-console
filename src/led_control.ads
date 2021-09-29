--===========================================================================
--
--  This package offers the control for the LEDs
--
--===========================================================================
--  Copyright 2021 (C) Holger Rodriguez
--
--  SPDX-License-Identifier: BSD-3-Clause
--
package LED_Control is

   --------------------------------------------------------------------------
   --  All Red LED related controls
   --------------------------------------------------------------------------
   procedure LED_0_Red_Off;
   procedure LED_0_Red_On;
   procedure LED_0_Red_Toggle;

   --------------------------------------------------------------------------
   --  All Amber LED related controls
   --------------------------------------------------------------------------
   procedure LED_0_Amber_Off;
   procedure LED_0_Amber_On;
   procedure LED_0_Amber_Toggle;

   --------------------------------------------------------------------------
   --  All Green LED related controls
   --------------------------------------------------------------------------
   procedure LED_0_Green_Off;
   procedure LED_0_Green_On;
   procedure LED_0_Green_Toggle;

   --------------------------------------------------------------------------
   --  All White LED related controls
   --------------------------------------------------------------------------
   procedure LED_0_White_Off;
   procedure LED_0_White_On;
   procedure LED_0_White_Toggle;

   --------------------------------------------------------------------------
   --  All Blue LED related controls
   --------------------------------------------------------------------------
   procedure LED_0_Blue_Off;
   procedure LED_0_Blue_On;
   procedure LED_0_Blue_Toggle;

   --------------------------------------------------------------------------
   --  This is just here for the sole reason, that all LEDs can be toggled
   --  for a quick visual check
   --------------------------------------------------------------------------
   procedure Toggle_All_LEDs (Delay_Between_In_Milliseconds : Integer);

end LED_Control;
