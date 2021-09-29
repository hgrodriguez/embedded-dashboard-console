--
--  Copyright 2021 (C) Holger Rodriguez
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with Evaluate.LEDs;

package Transport.Serial is

   --------------------------------------------------------------------------
   --  Initalize the UART for operation
   procedure Initialize;

   --------------------------------------------------------------------------
   --  Get the first character in the communication to determine the area
   --  It will return ASCII.NUL, in case there was a timeout with any
   --  character received.
   function Get_Area_Selector return Area_Selector;

   --------------------------------------------------------------------------
   --  Case Get_Area_Selector:
   --     when 'L' == LED => Reads the full instruction for LED control
   function Get_LED_Instruction return Evaluate.LEDs.LED_Instruction;

end Transport.Serial;
