--
--  Copyright 2021 (C) Holger Rodriguez
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with LED_Control;

package body Execute.LEDs is

   --------------------------------------------------------------------------
   --  definition of the look up table for the procedures to execute
   --  based on the command given
   --------------------------------------------------------------------------
   type LED_Execute is access procedure;
   type LED_Execute_Map is array (LED_Commands) of LED_Execute;

   LED_Execute_Mapper : constant LED_Execute_Map
     := (
         ------------------------------
         --  Red LED operation mappings
         ------------------------------
         Red_Off => LED_Control.LED_0_Red_Off'Access,
         Red_On => LED_Control.LED_0_Red_On'Access,
         Red_Toggle => LED_Control.LED_0_Red_Toggle'Access,

         --------------------------------
         --  Amber LED operation mappings
         --------------------------------
         Amber_Off => LED_Control.LED_0_Amber_Off'Access,
         Amber_On => LED_Control.LED_0_Amber_On'Access,
         Amber_Toggle => LED_Control.LED_0_Amber_Toggle'Access,

         --------------------------------
         --  Green LED operation mappings
         --------------------------------
         Green_Off => LED_Control.LED_0_Green_Off'Access,
         Green_On => LED_Control.LED_0_Green_On'Access,
         Green_Toggle => LED_Control.LED_0_Green_Toggle'Access,

         --------------------------------
         --  White LED operation mappings
         --------------------------------
         White_Off => LED_Control.LED_0_White_Off'Access,
         White_On => LED_Control.LED_0_White_On'Access,
         White_Toggle => LED_Control.LED_0_White_Toggle'Access,

         --------------------------------
         --  Blue LED operation mappings
         --------------------------------
         Blue_Off => LED_Control.LED_0_Blue_Off'Access,
         Blue_On => LED_Control.LED_0_Blue_On'Access,
         Blue_Toggle => LED_Control.LED_0_Blue_Toggle'Access
        );

   --------------------------------------------------------------------------
   --  see .ads
   --------------------------------------------------------------------------
   procedure Execute (Cmd : LED_Commands) is
   begin
      LED_Execute_Mapper (Cmd).all;
   end Execute;

end Execute.LEDs;
