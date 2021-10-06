--===========================================================================
--
--  This application provides an embedded dashboard controller offering:
--    - UART Interface
--    -  LED Area
--    -  5x7 Matrix Display with two displays as one logical unit
--
--===========================================================================
--
--  Copyright 2021 (C) Holger Rodriguez
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with ItsyBitsy;

with Initializer;

with Transport.Serial;

with Evaluate.LEDs;
with Evaluate.Matrices;

with Execute;
with Execute.LEDs;
with Execute.Matrices;

procedure Edc is

   --------------------------------------------------------------------------
   --  Processes a request for the LED area
   --  * gets the serial command request
   --  * checks the input for correctness
   --  * if OK, then executes the command given
   --------------------------------------------------------------------------
   procedure Process_LED (Instruction : Evaluate.LEDs.LED_Instruction);
   procedure Process_LED (Instruction : Evaluate.LEDs.LED_Instruction) is
      Error  : Execute.LED_Errors;
      Action : Execute.LED_Actions;
   begin
      Error := Evaluate.LEDs.Check_Input (Instruction);
      case Error is
         when Execute.OK =>
            ItsyBitsy.LED.Clear;
            Action := Evaluate.LEDs.Evaluate (Instruction);
            Execute.LEDs.Execute (Action);
         when others =>
            ItsyBitsy.LED.Set;
      end case;
   end Process_LED;

   --------------------------------------------------------------------------
   --  Processes a request for the Matrix area
   --  * gets the serial command request
   --  * checks the input for correctness
   --  * if OK, then executes the command given
   --------------------------------------------------------------------------
   procedure Process_Matrix (Instruction
                             : Evaluate.Matrices.Matrix_Instruction);
   procedure Process_Matrix (Instruction
                             : Evaluate.Matrices.Matrix_Instruction) is
      Error  : Execute.Matrix_Errors;
      Action : Execute.Matrix_Command;
      use Execute;
   begin
      Error := Evaluate.Matrices.Check_Input (Instruction);
      case Error is
         when Execute.M_OK =>
            ItsyBitsy.LED.Clear;
            Action := Evaluate.Matrices.Evaluate (Instruction => Instruction);
            Execute.Matrices.Execute (Action);
         when others =>
            ItsyBitsy.LED.Set;
      end case;
   end Process_Matrix;

   Area_Selector      : Transport.Area_Selector;
   LED_Instruction    : Evaluate.LEDs.LED_Instruction;
   Matrix_Instruction : Evaluate.Matrices.Matrix_Instruction;

begin
   Initializer.Initialize_All;

   loop
      --  Check for Serial Channel input
      Area_Selector := Transport.Serial.Get_Area_Selector;
      case Area_Selector is
         when Transport.Led =>
            --  something arrived on serial, handle it
            LED_Instruction := Transport.Serial.Get_LED_Instruction;
            Process_LED (LED_Instruction);
         when Transport.Matrix =>
            --  something arrived on serial, handle it
            Matrix_Instruction := Transport.Serial.Get_Matrix_Instruction;
            Process_Matrix (Matrix_Instruction);
         when Transport.None =>
            null;
      end case;
   end loop;

end Edc;

--===========================================================================
--
--               MAJOR TITLE HERE
--
--===========================================================================

--------------------------------------------------------------------------
--               Minor Title Here
--------------------------------------------------------------------------

---------------------
--  Subsection Header
---------------------
