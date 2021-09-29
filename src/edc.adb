--
--  Copyright 2021 (C) Holger Rodriguez
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with RP.Device;
with RP.Clock;
with RP.GPIO;

with ItsyBitsy;
with LED_Control;

with Transport.Serial;
with Evaluate;
with Evaluate.LEDs;

with Execute;
with Execute.LEDs;

procedure Edc is
   WAIT_FOR_NEXT_LED : constant Integer := 25;

   Area_Selector     : Transport.Area_Selector;

   procedure Process_LED;
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

   use Transport;

begin
   RP.Clock.Initialize (ItsyBitsy.XOSC_Frequency);
   RP.Clock.Enable (RP.Clock.PERI);
   RP.Device.Timer.Enable;
   ItsyBitsy.LED.Configure (RP.GPIO.Output);

   Transport.Serial.Initialize;

   loop
      --  Check for Serial Channel input
      Area_Selector := Transport.Serial.Get_Area_Selector;
      if Area_Selector /= Transport.None then

         --  something arrived on the UART, process it
         case Area_Selector is
            when Evaluate.LED_Prefix =>
               Process_LED;
            when others =>
               LED_Control.Toggle_All_LEDs (WAIT_FOR_NEXT_LED);
         end case;
      end if;
   end loop;
end Edc;
