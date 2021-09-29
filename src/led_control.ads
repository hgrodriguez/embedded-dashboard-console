--  Copyright 2021 (C) Holger Rodriguez
--
--  SPDX-License-Identifier: BSD-3-Clause
--
package LED_Control is

   procedure LED_0_Red_Off;
   procedure LED_0_Red_On;
   procedure LED_0_Red_Toggle;

   procedure LED_0_Amber_Off;
   procedure LED_0_Amber_On;
   procedure LED_0_Amber_Toggle;

   procedure LED_0_Green_Off;
   procedure LED_0_Green_On;
   procedure LED_0_Green_Toggle;

   procedure LED_0_White_Off;
   procedure LED_0_White_On;
   procedure LED_0_White_Toggle;

   procedure LED_0_Blue_Off;
   procedure LED_0_Blue_On;
   procedure LED_0_Blue_Toggle;

   procedure Toggle_All_LEDs (Delay_Between_In_Milliseconds : Integer);

end LED_Control;
