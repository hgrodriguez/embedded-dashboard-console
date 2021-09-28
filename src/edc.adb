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

   Area_Selector     : Character;
   LED_Instruction   : Evaluate.LED_Instruction;
   LED_Command       : Execute.LED_Commands;

begin
   RP.Clock.Initialize (ItsyBitsy.XOSC_Frequency);
   RP.Clock.Enable (RP.Clock.PERI);
   RP.Device.Timer.Enable;
   ItsyBitsy.LED.Configure (RP.GPIO.Output);

   Transport.Serial.Initialize;

   loop
      if False then
         LED_Control.Toggle_All_LEDs (WAIT_FOR_NEXT_LED);
      else
         Area_Selector := Transport.Serial.Get;
         case Area_Selector is
            when Evaluate.LED_Prefix =>
               LED_Instruction := Transport.Serial.Get_LED_Instruction;
               LED_Command := Evaluate.LEDs.Evaluate (LED_Instruction);
               Execute.LEDs.Execute (LED_Command);
            when others =>
               LED_Control.Toggle_All_LEDs (WAIT_FOR_NEXT_LED);
         end case;
      end if;
   end loop;
end Edc;
