--===========================================================================
--
--  This application provides an embedded dashboard controller offering:
--    - UART Interface
--    -  LED Area
--    -  5x7 Matrix Display with two displays as one logical unit
--
--===========================================================================
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

with Transport.Serial;

with Evaluate.LEDs;
with Evaluate.Matrices;

with Execute;
with Execute.LEDs;
with Execute.Matrices;

with Matrix_Area_Word;
with Matrix_Area_Double_Word;

procedure Edc is

   procedure Initialize_Device;
   procedure Initialize_Device is
   begin
      RP.Clock.Initialize (ItsyBitsy.XOSC_Frequency);
      RP.Clock.Enable (RP.Clock.PERI);
      RP.Device.Timer.Enable;
   end Initialize_Device;

   procedure Initialize_I2C_0;
   procedure Initialize_I2C_0 is
      SDA     : RP.GPIO.GPIO_Point renames ItsyBitsy.D10;
      SCL     : RP.GPIO.GPIO_Point renames ItsyBitsy.D11;
      I2C_0_0 : RP.I2C_Master.I2C_Master_Port renames RP.Device.I2C_0;
   begin
      SDA.Configure (RP.GPIO.Output, RP.GPIO.Pull_Up, RP.GPIO.I2C);
      SCL.Configure (RP.GPIO.Output, RP.GPIO.Pull_Up, RP.GPIO.I2C);
      I2C_0_0.Enable (100_000);
   end Initialize_I2C_0;

   procedure Initialize_I2C_1;
   procedure Initialize_I2C_1 is
      SDA   : RP.GPIO.GPIO_Point renames ItsyBitsy.SDA;
      SCL   : RP.GPIO.GPIO_Point renames ItsyBitsy.SCL;
      I2C_1 : RP.I2C_Master.I2C_Master_Port renames ItsyBitsy.I2C;
   begin
      SDA.Configure (RP.GPIO.Output, RP.GPIO.Pull_Up, RP.GPIO.I2C);
      SCL.Configure (RP.GPIO.Output, RP.GPIO.Pull_Up, RP.GPIO.I2C);
      I2C_1.Enable (100_000);
   end Initialize_I2C_1;

   --------------------------------------------------------------------------
   --  Processes a request for the LED area
   --  * gets the serial command request
   --  * checks the input for correctness
   --  * if OK, then executes the command given
   --------------------------------------------------------------------------
   procedure Process_LED (LED_Instruction : Evaluate.LEDs.LED_Instruction);
   procedure Process_LED (LED_Instruction : Evaluate.LEDs.LED_Instruction) is
      LED_Error       : Execute.LED_Errors;
      LED_Action      : Execute.LED_Actions;
      use Execute;
   begin
      LED_Error := Evaluate.LEDs.Check_Input (LED_Instruction);
      if LED_Error = Execute.OK then
         ItsyBitsy.LED.Clear;
         LED_Action := Evaluate.LEDs.Evaluate (LED_Instruction);
         Execute.LEDs.Execute (LED_Action);
      else
         ItsyBitsy.LED.Set;
      end if;
   end Process_LED;

   --------------------------------------------------------------------------
   --  Processes a request for the Matrix area
   --  * gets the serial command request
   --  * checks the input for correctness
   --  * if OK, then executes the command given
   --------------------------------------------------------------------------
   procedure Process_Matrix (Instruction
                             : Evaluate.Matrices.Matrix_Instruction);
   procedure Process_Matrix (Instruction
                             : Evaluate.Matrices.Matrix_Instruction) is
      Error       : Execute.Matrix_Errors;
      Action      : Execute.Matrix_Command;
      use Execute;
   begin
      Error := Evaluate.Matrices.Check_Input (Instruction);
      if Error = Execute.M_OK then
         ItsyBitsy.LED.Clear;
         Action := Evaluate.Matrices.Evaluate (Instruction => Instruction);
         Execute.Matrices.Execute (Action);
      else
         ItsyBitsy.LED.Set;
      end if;
   end Process_Matrix;

   use Transport;
   Area_Selector      : Transport.Area_Selector;
   LED_Instruction    : Evaluate.LEDs.LED_Instruction;
   Matrix_Instruction : Evaluate.Matrices.Matrix_Instruction;

begin
   Initialize_Device;

   ItsyBitsy.LED.Configure (RP.GPIO.Output);

   Initialize_I2C_0;
   Initialize_I2C_1;

   Matrix_Area_Word.Initialize;
   Matrix_Area_Double_Word.Initialize;

   Transport.Serial.Initialize;

   loop
      --  Check for Serial Channel input
      Area_Selector := Transport.Serial.Get_Area_Selector;
      case Area_Selector is
         when Transport.Led =>
            --  something arrived on serial, handle it
            LED_Instruction := Transport.Serial.Get_LED_Instruction;
            Process_LED (LED_Instruction);
         when Transport.Matrix =>
            --  something arrived on serial, handle it
            Matrix_Instruction := Transport.Serial.Get_Matrix_Instruction;
            Process_Matrix (Matrix_Instruction);
         when Transport.None =>
            null;
      end case;
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
---------------------
