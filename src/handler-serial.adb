--
--  Copyright 2021 (C) Holger Rodriguez
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with Evaluate;
with Evaluate.LEDs;

with Execute.LEDs;

with LED_Control;

with Transport.Serial;

package body Handler.Serial is

   --------------------------------------------------------------------------
   --  Processes a request for the LED area
   --------------------------------------------------------------------------
   procedure Process_LED;

   procedure Handle_Request (Area_Selector : Transport.Area_Selector) is
   begin
      case Area_Selector is
         when Evaluate.LED_Prefix =>
            Process_LED;
         when others =>
            null;
      end case;
   end Handle_Request;

   procedure Process_LED is
      LED_Instruction : Evaluate.LEDs.LED_Instruction;
      LED_Error       : Execute.LED_Errors;
      LED_Action      : Execute.LED_Actions;
      use Execute;
   begin
      LED_Instruction := Transport.Serial.Get_LED_Instruction;
      LED_Error := Evaluate.LEDs.Check_Input (LED_Instruction);
      if LED_Error = Execute.OK then
         LED_Action := Evaluate.LEDs.Evaluate (LED_Instruction);
         Execute.LEDs.Execute (LED_Action);
      end if;
   end Process_LED;

end Handler.Serial;
