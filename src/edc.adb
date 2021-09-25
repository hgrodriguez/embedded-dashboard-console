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
begin
   RP.Clock.Initialize (ItsyBitsy.XOSC_Frequency);
   ItsyBitsy.LED.Configure (RP.GPIO.Output);
   RP.Device.Timer.Enable;

   ItsyBitsy.GP1.Configure (RP.GPIO.Output);

   loop
      ItsyBitsy.LED.Toggle;
      LEDs.LED_0_Red.Toggle;
      RP.Device.Timer.Delay_Milliseconds (100);
   end loop;
end Edc;
