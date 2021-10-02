--
--  Copyright 2021 (C) Holger Rodriguez
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with HAL;
with HAL.I2C;
with RP.I2C_Master;

with RP.Device;
with RP.Clock;
with RP.GPIO;

with ItsyBitsy;

with Pimoroni_LED_Dot_Matrix;

with Handler.Serial;
with Transport.Serial;

with LED_Dot_Matrix;

with Matrix_Area_Word;

procedure Edc is
   use HAL;
   SDA     : RP.GPIO.GPIO_Point renames ItsyBitsy.SDA;
   SCL     : RP.GPIO.GPIO_Point renames ItsyBitsy.SCL;
   I2C     : RP.I2C_Master.I2C_Master_Port renames ItsyBitsy.I2C;

   Address_0 : constant HAL.I2C.I2C_Address  := 16#61# * 2;
   package PLDM_0 is new Pimoroni_LED_Dot_Matrix (I2C'Access, Address_0);

   Address_1 : constant HAL.I2C.I2C_Address  := 16#62# * 2;
   package PLDM_1 is new Pimoroni_LED_Dot_Matrix (I2C'Access, Address_1);

   WAIT_FOR_NEXT_LED : constant Integer := 25;

   Area_Selector     : Transport.Area_Selector;

   Options            : constant HAL.UInt8 := 2#00001110#;
   --  1110 = 35 mA; 0000 = 40 mA
   Mode               : constant HAL.UInt8 := 2#00011000#;

   use Transport;

begin
   RP.Clock.Initialize (ItsyBitsy.XOSC_Frequency);
   RP.Clock.Enable (RP.Clock.PERI);
   RP.Device.Timer.Enable;
   ItsyBitsy.LED.Configure (RP.GPIO.Output);

   Transport.Serial.Initialize;

   SDA.Configure (RP.GPIO.Output, RP.GPIO.Pull_Up, RP.GPIO.I2C);
   SCL.Configure (RP.GPIO.Output, RP.GPIO.Pull_Up, RP.GPIO.I2C);
   I2C.Enable (100_000);

   PLDM_0.Write_Byte_Data (
                         PLDM_0.Reset,
                         16#FF#);
   PLDM_0.
     Write_Byte_Data (
                      PLDM_0.Mode, Mode);
   PLDM_0.
     Write_Byte_Data (
                      PLDM_0.Options, Options);
   PLDM_0.
     Write_Byte_Data (
                      PLDM_0.Brightness, 255);

   PLDM_1.Write_Byte_Data (
                           PLDM_1.Reset,
                           16#FF#);
   PLDM_1.
     Write_Byte_Data (
                      PLDM_1.Mode, Mode);
   PLDM_1.
     Write_Byte_Data (
                      PLDM_1.Options, Options);
   PLDM_1.
     Write_Byte_Data (
                      PLDM_1.Brightness, 255);

   loop
      --  Check for Serial Channel input
      Area_Selector := Transport.Serial.Get_Area_Selector;
      if Area_Selector /= Transport.None then
         --  something arrived on serial, handle it
         Handler.Serial.Handle_Request (Area_Selector);
      end if;
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
-------------------- -
