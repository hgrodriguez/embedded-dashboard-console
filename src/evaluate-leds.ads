--===========================================================================
--
--  This package checks and evaluates the input received from the serial
--  line for commanding the LEDs
--
--===========================================================================
--
--  Copyright 2021 (C) Holger Rodriguez
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with Execute;

package Evaluate.LEDs is

   --------------------------------------------------------------------------
   --  LED section
   --  The complete instruction is built as (all elements are Character):
   --  <LED_Prefix><Block Code><Color of LED><State of LED>
   --  LED_Prefix := L
   --  Block Code := (0) --  only one block available at the moment
   --  Color of LED := (R, A, G, W, B)
   --  State of LED := (0, 1, 2)
   subtype LED_Instruction is String (1 .. 3);

   --------------------------------------------------------------------------
   --  Blocks of LEDs defined. At the moment there is only one block
   --------------------------------------------------------------------------
   type Blocks is (Zero);

   --------------------------------------------------------------------------
   --  Colors of the LEDs available
   --------------------------------------------------------------------------
   type Colors is (Red, Amber, Green, White, Blue);

   --------------------------------------------------------------------------
   --  Operations possible for the LEDs
   --------------------------------------------------------------------------
   type Operations is (Off, On, Toggle);

   --------------------------------------------------------------------------
   --  Checks the input received against the rules defined above
   --------------------------------------------------------------------------
   function Check_Input (Instruction : LED_Instruction)
                         return Execute.LED_Errors;

   --------------------------------------------------------------------------
   --  Evaluates the input received and returns the equivalent LED Command
   --------------------------------------------------------------------------
   function Evaluate (Instruction : LED_Instruction)
                      return Execute.LED_Commands;

end Evaluate.LEDs;
