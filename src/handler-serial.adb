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
   --  Processes a request for the Matrix area
   --------------------------------------------------------------------------
   procedure Process_Matrix (Instruction
                              : Evaluate.Matrices.Matrix_Instruction);

   --------------------------------------------------------------------------
   --  see .ads
   --------------------------------------------------------------------------
   procedure Handle_Request (Area_Selector : Transport.Area_Selector) is
      Matrix_Instruction : Evaluate.Matrices.Matrix_Instruction;
   begin
      case Area_Selector is
         when Evaluate.LED_Prefix =>
            null;
         when Evaluate.Matrix_Prefix =>
            Matrix_Instruction := Transport.Serial.Get_Matrix_Instruction;
            Process_Matrix (Matrix_Instruction);
         when others =>
            null;
      end case;
   end Handle_Request;

   --------------------------------------------------------------------------
   --  Processes a request for the Matrix area
   --  * gets the serial command request
   --  * checks the input for correctness
   --  * if OK, then executes the command given
   --------------------------------------------------------------------------
   procedure Process_Matrix (Instruction
                              : Evaluate.Matrices.Matrix_Instruction) is
      Error       : Execute.Matrix_Errors;
      Action      : Execute.Matrix_Command;
      use Execute;
   begin
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
