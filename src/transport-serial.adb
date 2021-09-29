--
--  Copyright 2021 (C) Holger Rodriguez
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with HAL.UART;

with RP.GPIO;
with RP.UART;
with ItsyBitsy;

package body Transport.Serial is

   UART_TX : RP.GPIO.GPIO_Point renames ItsyBitsy.TX;
   UART_RX : RP.GPIO.GPIO_Point renames ItsyBitsy.RX;

   Port : RP.UART.UART_Port renames ItsyBitsy.UART;

   Initialized : Boolean := False;

   function Get (Timeout : Natural := 0) return Character;

   procedure Initialize is
      Console_Config : constant RP.UART.UART_Configuration
        := (Baud => 115_200, others => <>);
   begin
      if Initialized then
         return;
      end if;

      UART_TX.Configure (Mode => RP.GPIO.Output,
                         Pull      => RP.GPIO.Pull_Up,
                         Func      => RP.GPIO.UART);
      UART_RX.Configure (Mode => RP.GPIO.Input,
                         Pull      => RP.GPIO.Floating,
                         Func      => RP.GPIO.UART);
      Port.Configure (Config => Console_Config);
      Initialized := True;
   end Initialize;

   function Get_LED_Instruction return Evaluate.LEDs.LED_Instruction is
      RetVal : Evaluate.LEDs.LED_Instruction;
   begin
      for I in RetVal'First .. RetVal'Last loop
         RetVal (I) := Get;
      end loop;
      return RetVal;
   end Get_LED_Instruction;

   function Get_Area_Selector return Area_Selector is
      Selector : constant Character := Get (100);
   begin
      if Selector = 'L' then
         return Transport.Led;
      else
         return Transport.None;
      end if;
   end Get_Area_Selector;

   function Get (Timeout : Natural := 0) return Character is
      use HAL.UART;
      Data   : UART_Data_8b (1 .. 1);
      Status : UART_Status;
   begin
      Port.Receive (Data, Status, Timeout => Timeout);
      case Status is
         when Ok =>
            return Character'Val (Data (1));
         when Err_Error | Err_Timeout | Busy =>
            return ASCII.NUL;
      end case;
   end Get;

end Transport.Serial;
