--===========================================================================
--
--  This package represents the definitions for
--    all ports
--    all standard definitions
--    for the ItstyBitsy board
--
--===========================================================================
--
--  Copyright 2021 (C) Holger Rodriguez
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with RP.GPIO;
with RP.I2C_Master;
with RP.Device;
with RP.Clock;
with RP.UART;
with RP.SPI;

package ItsyBitsy is

   ------------------------------------------------------
   --  Just the list of all GPIO pins for the RP2040 chip
   --  The commented lines do not have a board connection
   ------------------------------------------------------
   GP0  : aliased RP.GPIO.GPIO_Point := (Pin => 0);
   GP1  : aliased RP.GPIO.GPIO_Point := (Pin => 1);
   GP2  : aliased RP.GPIO.GPIO_Point := (Pin => 2);
   GP3  : aliased RP.GPIO.GPIO_Point := (Pin => 3);
   GP4  : aliased RP.GPIO.GPIO_Point := (Pin => 4);
   GP5  : aliased RP.GPIO.GPIO_Point := (Pin => 5);
   GP6  : aliased RP.GPIO.GPIO_Point := (Pin => 6);
   GP7  : aliased RP.GPIO.GPIO_Point := (Pin => 7);
   GP8  : aliased RP.GPIO.GPIO_Point := (Pin => 8);
   GP9  : aliased RP.GPIO.GPIO_Point := (Pin => 9);
   GP10 : aliased RP.GPIO.GPIO_Point := (Pin => 10);
   GP11 : aliased RP.GPIO.GPIO_Point := (Pin => 11);
   GP12 : aliased RP.GPIO.GPIO_Point := (Pin => 12);
   GP13 : aliased RP.GPIO.GPIO_Point := (Pin => 13);
   GP14 : aliased RP.GPIO.GPIO_Point := (Pin => 14);
   --  GP15 : aliased RP.GPIO.GPIO_Point := (Pin => 15);
   GP16 : aliased RP.GPIO.GPIO_Point := (Pin => 16);
   GP17 : aliased RP.GPIO.GPIO_Point := (Pin => 17);
   GP18 : aliased RP.GPIO.GPIO_Point := (Pin => 18);
   GP19 : aliased RP.GPIO.GPIO_Point := (Pin => 19);
   GP20 : aliased RP.GPIO.GPIO_Point := (Pin => 20);
   --  GP21 : aliased RP.GPIO.GPIO_Point := (Pin => 21);
   --  GP22 : aliased RP.GPIO.GPIO_Point := (Pin => 22);
   --  GP23 : aliased RP.GPIO.GPIO_Point := (Pin => 23);
   GP24 : aliased RP.GPIO.GPIO_Point := (Pin => 24);
   GP25 : aliased RP.GPIO.GPIO_Point := (Pin => 25);
   GP26 : aliased RP.GPIO.GPIO_Point := (Pin => 26);
   GP27 : aliased RP.GPIO.GPIO_Point := (Pin => 27);
   GP28 : aliased RP.GPIO.GPIO_Point := (Pin => 28);
   GP29 : aliased RP.GPIO.GPIO_Point := (Pin => 29);

   -----------------------------------------------
   --  Order is counter clockwise around the chip,
   --  if you look at it holding the USB port top
   --  the identifiers are the ones on the board
   -----------------------------------------------

   --------------------
   --  Left row of pins
   --------------------
   A0   : aliased RP.GPIO.GPIO_Point := GP26;
   A1   : aliased RP.GPIO.GPIO_Point := GP27;
   A2   : aliased RP.GPIO.GPIO_Point := GP28;
   A3   : aliased RP.GPIO.GPIO_Point := GP29;
   D24  : aliased RP.GPIO.GPIO_Point := GP24;
   D25  : aliased RP.GPIO.GPIO_Point := GP25;
   SCK  : aliased RP.GPIO.GPIO_Point := GP18;
   MOSI : aliased RP.GPIO.GPIO_Point := GP19;
   MISO : aliased RP.GPIO.GPIO_Point := GP20;
   D2   : aliased RP.GPIO.GPIO_Point := GP12;

   ----------------------
   --  Bottom row of pins
   ----------------------
   D4   : aliased RP.GPIO.GPIO_Point := GP4;
   D3   : aliased RP.GPIO.GPIO_Point := GP5;

   ---------------------
   --  Right row of pins
   ---------------------
   RX   : aliased RP.GPIO.GPIO_Point := GP1;
   TX   : aliased RP.GPIO.GPIO_Point := GP0;
   SDA  : aliased RP.GPIO.GPIO_Point := GP2;
   SCL  : aliased RP.GPIO.GPIO_Point := GP3;
   D5   : aliased RP.GPIO.GPIO_Point := GP14;
   D7   : aliased RP.GPIO.GPIO_Point := GP6;
   D9   : aliased RP.GPIO.GPIO_Point := GP7;
   D10  : aliased RP.GPIO.GPIO_Point := GP8;
   D11  : aliased RP.GPIO.GPIO_Point := GP9;
   D12  : aliased RP.GPIO.GPIO_Point := GP10;
   D13  : aliased RP.GPIO.GPIO_Point := GP11;

   NEOPIXEL : aliased RP.GPIO.GPIO_Point := GP16;

   XOSC_Frequency : RP.Clock.XOSC_Hertz := 12_000_000;

   LED  : RP.GPIO.GPIO_Point renames D13;

   SPI  : RP.SPI.SPI_Port renames RP.Device.SPI_0;
   I2C  : RP.I2C_Master.I2C_Master_Port renames RP.Device.I2C_1;
   UART : RP.UART.UART_Port renames RP.Device.UART_0;

end ItsyBitsy;
