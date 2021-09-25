--  Copyright 2021 (C) Holger Rodriguez
--
--  SPDX-License-Identifier: BSD-3-Clause
--
package LEDs is

   procedure LED_0_Red_Clear;
   procedure LED_0_Red_Set;
   procedure LED_0_Red_Toggle;

   procedure LED_0_Amber_Clear;
   procedure LED_0_Amber_Set;
   procedure LED_0_Amber_Toggle;

   procedure LED_0_Green_Clear;
   procedure LED_0_Green_Set;
   procedure LED_0_Green_Toggle;

   procedure LED_0_White_Clear;
   procedure LED_0_White_Set;
   procedure LED_0_White_Toggle;

   procedure LED_0_Blue_Clear;
   procedure LED_0_Blue_Set;
   procedure LED_0_Blue_Toggle;

   procedure Toggle_All_LEDs (Delay_Between_In_Milliseconds : Integer);

end LEDs;
