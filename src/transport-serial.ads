--===========================================================================
--
--  This package provides the serial specific procedures for input requests
--
--===========================================================================
--
--  Copyright 2021 (C) Holger Rodriguez
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with Evaluate.LEDs;
with Evaluate.Matrices;

package Transport.Serial is

   --------------------------------------------------------------------------
   --  Initalize the UART for operation
   --------------------------------------------------------------------------
   procedure Initialize;

   --------------------------------------------------------------------------
   --  Get the first character in the communication to determine the area
   --  It will return Area_Selector'(None), in case there was a timeout
   --  without receiving any input
   --------------------------------------------------------------------------
   function Get_Area_Selector return Area_Selector;

   --------------------------------------------------------------------------
   --  Case Get_Area_Selector:
   --     when 'L' == LED => Reads the full instruction for LED control
   --------------------------------------------------------------------------
   function Get_LED_Instruction return Evaluate.LEDs.LED_Instruction;

   --------------------------------------------------------------------------
   --  Case Get_Area_Selector:
   --     when 'M' == LED => Reads the full instruction for Matrix control
   --------------------------------------------------------------------------
   function Get_Matrix_Instruction return Evaluate.Matrices.Matrix_Instruction;

end Transport.Serial;
