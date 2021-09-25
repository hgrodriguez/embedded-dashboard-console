--
--  Copyright 2021 (C) Holger Rodriguez
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with RP.Device;
with RP.Clock;
with RP.GPIO;

with ItsyBitsy;
with LEDs;

procedure Edc is
   WAIT_FOR_NEXT_LED : constant Integer := 25;
begin
   RP.Clock.Initialize (ItsyBitsy.XOSC_Frequency);
   ItsyBitsy.LED.Configure (RP.GPIO.Output);
   RP.Device.Timer.Enable;

   loop
      ItsyBitsy.LED.Toggle;
      RP.Device.Timer.Delay_Milliseconds (WAIT_FOR_NEXT_LED);
      LEDs.Toggle_All_LEDs (WAIT_FOR_NEXT_LED);
   end loop;
end Edc;
