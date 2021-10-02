--
--  Copyright 2021 (C) Jeremy Grosser
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with Pimoroni_LED_Dot_Matrix;
with HAL.I2C;
with RP.I2C_Master;
with RP.Device;
with RP.Clock;
with RP.GPIO;
with ItsyBitsy;

with Font;

with Hex_2Digits_Display;

procedure Main is
   use HAL;
   SDA     : RP.GPIO.GPIO_Point renames ItsyBitsy.SDA;
   SCL     : RP.GPIO.GPIO_Point renames ItsyBitsy.SCL;
   I2C     : RP.I2C_Master.I2C_Master_Port renames ItsyBitsy.I2C;

   Address : constant HAL.I2C.I2C_Address  := 16#61# * 2;

   package PLDM is new Pimoroni_LED_Dot_Matrix (I2C'Access, Address);

   package H2D is new Hex_2Digits_Display (I2C'Access, Address);

   DP                 : Boolean := False;
   L, R               : PLDM.Display_Matrix
     := (others => (others => False));
   X                  : PLDM.Display_Column
     := PLDM.Display_Column'First;
   Y                  : PLDM.Display_Row
     := PLDM.Display_Row'First;
   Letter_Array       : Font.Matrix_Array;
   Letter_Array_Index : Positive;

   Options            : constant HAL.UInt8 := 2#00001110#;
                        --  1110 = 35 mA; 0000 = 40 mA
   Mode               : constant HAL.UInt8 := 2#00011000#;

   Runner : HAL.UInt8;

   use HAL;
begin
   RP.Clock.Initialize (ItsyBitsy.XOSC_Frequency);
   RP.Clock.Enable (RP.Clock.PERI);
   RP.Device.Timer.Enable;

   ItsyBitsy.LED.Configure (RP.GPIO.Output);

   SDA.Configure (RP.GPIO.Output, RP.GPIO.Pull_Up, RP.GPIO.I2C);
   SCL.Configure (RP.GPIO.Output, RP.GPIO.Pull_Up, RP.GPIO.I2C);
   I2C.Enable (100_000);
   PLDM.Write_Byte_Data (
                                            PLDM.Reset,
                                            16#FF#);
   PLDM.
     Write_Byte_Data (
                      PLDM.Mode, Mode);
   PLDM.
     Write_Byte_Data (
                      PLDM.Options, Options);
   PLDM.
     Write_Byte_Data (
                      PLDM.Brightness, 255);

   if False then
      Letter_Array_Index := Font.Characters'First;
      loop
         if X = PLDM.Display_Column'Last then
            X := 0;
            if Y = PLDM.Display_Row'Last then
               Y := 0;
            else
               Y := Y + 1;
            end if;
         else
            X := X + 1;
         end if;
         L := (others => (others => False));
         L (X, Y) := True;
         R := L;
         DP := not DP;
         --  Pimoroni_LED_Dot_Matrix.
         --  Write_Block_Data (I2C'Access, Address,
         --  Pimoroni_LED_Dot_Matrix.Matrix_L,
         --  Pimoroni_LED_Dot_Matrix.To_Left_Matrix (L, DP));

         Letter_Array := Font.Characters (Letter_Array_Index).Bytes;

         PLDM.
           Write_Block_Data (
                             PLDM.Matrix_L,
                             Letter_Array);

         PLDM.
           Write_Block_Data (
                             PLDM.Matrix_R,
                             PLDM.To_Right_Matrix (R, DP));

         PLDM.
           Write_Byte_Data (
                            PLDM.Update, 1);

         RP.Device.Timer.Delay_Milliseconds (250);

         if Letter_Array_Index = Font.Characters'Last then
            Letter_Array_Index := Font.Characters'First;
         else
            Letter_Array_Index := Letter_Array_Index + 1;
         end if;
         ItsyBitsy.LED.Toggle;

      end loop;
   else
      Runner := 0;
      loop
            H2D.Show (
                                      Number  => Runner);
         RP.Device.Timer.Delay_Milliseconds (250);
         ItsyBitsy.LED.Toggle;
         Runner := Runner + 1;
      end loop;
   end if;
end Main;
