--
--  Copyright 2021 (C) Holger Rodriguez
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with RP.Device;
with RP.Clock;
with RP.GPIO;

with ItsyBitsy;

with Handler.Serial;
with Transport.Serial;

procedure Edc is
   WAIT_FOR_NEXT_LED : constant Integer := 25;

   Area_Selector     : Transport.Area_Selector;

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
         --  something arrived on serial, handle it
         Handler.Serial.Handle_Request (Area_Selector);
      end if;
   end loop;
end Edc;
