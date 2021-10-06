--
--  Copyright 2021 (C) Holger Rodriguez
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with ItsyBitsy;

with Evaluate;
with Evaluate.LEDs;
with Evaluate.Matrices;

with Execute.LEDs;
with Execute.Matrices;

with LED_Control;

with Transport.Serial;

package body Handler.Serial is

   --------------------------------------------------------------------------
   --  Processes a request for the LED area
   --------------------------------------------------------------------------
   procedure Process_LED;

   --------------------------------------------------------------------------
   --  Processes a request for the Matrix area
   --------------------------------------------------------------------------
   procedure Process_Matrix;

   --------------------------------------------------------------------------
   --  see .ads
   --------------------------------------------------------------------------
   procedure Handle_Request (Area_Selector : Transport.Area_Selector) is
   begin
      case Area_Selector is
         when Evaluate.LED_Prefix =>
            Process_LED;
         when Evaluate.Matrix_Prefix =>
            Process_Matrix;
         when others =>
            null;
      end case;
   end Handle_Request;

   --------------------------------------------------------------------------
   --  Processes a request for the LED area
   --  * gets the serial command request
   --  * checks the input for correctness
   --  * if OK, then executes the command given
   --------------------------------------------------------------------------
   procedure Process_LED is
      LED_Instruction : Evaluate.LEDs.LED_Instruction;
      LED_Error       : Execute.LED_Errors;
      LED_Action      : Execute.LED_Actions;
      use Execute;
   begin
      LED_Instruction := Transport.Serial.Get_LED_Instruction;
      LED_Error := Evaluate.LEDs.Check_Input (LED_Instruction);
      if LED_Error = Execute.OK then
         ItsyBitsy.LED.Clear;
         LED_Action := Evaluate.LEDs.Evaluate (LED_Instruction);
         Execute.LEDs.Execute (LED_Action);
      else
         ItsyBitsy.LED.Set;
      end if;
   end Process_LED;

   --------------------------------------------------------------------------
   --  Processes a request for the Matrix area
   --  * gets the serial command request
   --  * checks the input for correctness
   --  * if OK, then executes the command given
   --------------------------------------------------------------------------
   procedure Process_Matrix is
      Instruction : Evaluate.Matrices.Matrix_Instruction;
      Error       : Execute.Matrix_Errors;
      Action      : Execute.Matrix_Command;
      use Execute;
   begin
      Instruction := Transport.Serial.Get_Matrix_Instruction;
      Error := Evaluate.Matrices.Check_Input (Instruction);
      if Error = Execute.M_OK then
         ItsyBitsy.LED.Clear;
         Action := Evaluate.Matrices.Evaluate (Instruction => Instruction);
         Execute.Matrices.Execute (Action);
      else
         ItsyBitsy.LED.Set;
      end if;
   end Process_Matrix;

end Handler.Serial;
