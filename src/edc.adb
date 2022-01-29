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
with RP.Device;

with ItsyBitsy;

with Initializer;

with Transport.Serial;

with Evaluate.LEDs;
with Evaluate.Matrices;

with Execute;
with Execute.LEDs;
with Execute.Matrices;

procedure Edc is

   --------------------------------------------------------------------------
   --  Processes a request for the LED area
   --  * gets the serial command request
   --  * checks the input for correctness
   --  * if OK, then executes the command given
   --------------------------------------------------------------------------
   procedure Process_LED (Instruction : Evaluate.LEDs.LED_Instruction);
   procedure Process_LED (Instruction : Evaluate.LEDs.LED_Instruction) is
      Error  : Execute.LED_Errors;
      Action : Execute.LED_Actions;
   begin
      Error := Evaluate.LEDs.Check_Input (Instruction);
      case Error is
         when Execute.OK =>
            ItsyBitsy.LED.Clear;
            Action := Evaluate.LEDs.Evaluate (Instruction);
            Execute.LEDs.Execute (Action);
         when others =>
            ItsyBitsy.LED.Set;
      end case;
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
      Error  : Execute.Matrix_Errors;
      Action : Execute.Matrix_Command;
      use Execute;
   begin
      Error := Evaluate.Matrices.Check_Input (Instruction);
      case Error is
         when Execute.M_OK =>
            ItsyBitsy.LED.Clear;
            Action := Evaluate.Matrices.Evaluate (Instruction => Instruction);
            Execute.Matrices.Execute (Action);
         when others =>
            ItsyBitsy.LED.Set;
      end case;
   end Process_Matrix;

   procedure Show_Patterns_After_Reset;
   procedure Show_Patterns_After_Reset is
      Word_Pattern_0000 : constant Execute.Matrix_Command
        := (Block   => Execute.Block_0,
            Command => Execute.Word_0,
            Value   => "00000000"
           );
      Word_Pattern_000F : constant Execute.Matrix_Command
        := (Block   => Execute.Block_0,
            Command => Execute.Word_0,
            Value   => "000F0000"
           );
      Word_Pattern_00F0 : constant Execute.Matrix_Command
        := (Block   => Execute.Block_0,
            Command => Execute.Word_0,
            Value   => "00F00000"
           );
      Word_Pattern_0F00 : constant Execute.Matrix_Command
        := (Block   => Execute.Block_0,
            Command => Execute.Word_0,
            Value   => "0F000000"
           );
      Word_Pattern_F000 : constant Execute.Matrix_Command
        := (Block   => Execute.Block_0,
            Command => Execute.Word_0,
            Value   => "F0000000"
           );
      Word_Pattern_FFFF : constant Execute.Matrix_Command
        := (Block   => Execute.Block_0,
            Command => Execute.Word_0,
            Value   => "FFFF0000"
           );

      Double_Word_Pattern_00000000 : constant Execute.Matrix_Command
        := (Block   => Execute.Block_1,
            Command => Execute.Double_Word_0,
            Value   => "00000000"
           );
      Double_Word_Pattern_0000000F : constant Execute.Matrix_Command
        := (Block   => Execute.Block_1,
            Command => Execute.Double_Word_0,
            Value   => "0000000F"
           );
      Double_Word_Pattern_000000F0 : constant Execute.Matrix_Command
        := (Block   => Execute.Block_1,
            Command => Execute.Double_Word_0,
            Value   => "000000F0"
           );
      Double_Word_Pattern_00000F00 : constant Execute.Matrix_Command
        := (Block   => Execute.Block_1,
            Command => Execute.Double_Word_0,
            Value   => "00000F00"
           );
      Double_Word_Pattern_0000F000 : constant Execute.Matrix_Command
        := (Block   => Execute.Block_1,
            Command => Execute.Double_Word_0,
            Value   => "0000F000"
           );
      Double_Word_Pattern_000F0000 : constant Execute.Matrix_Command
        := (Block   => Execute.Block_1,
            Command => Execute.Double_Word_0,
            Value   => "000F0000"
           );
      Double_Word_Pattern_00F00000 : constant Execute.Matrix_Command
        := (Block   => Execute.Block_1,
            Command => Execute.Double_Word_0,
            Value   => "00F00000"
           );
      Double_Word_Pattern_0F000000 : constant Execute.Matrix_Command
        := (Block   => Execute.Block_1,
            Command => Execute.Double_Word_0,
            Value   => "0F000000"
           );
      Double_Word_Pattern_F0000000 : constant Execute.Matrix_Command
        := (Block   => Execute.Block_1,
            Command => Execute.Double_Word_0,
            Value   => "F0000000"
           );

      TIME_BETWEEN_PATTERN : constant Integer := 100;
   begin
      -----------------------------------------------------------------------
      --  Pattern with LEDs ON
      Execute.LEDs.Execute (Cmd => Execute.Red_On);
      Execute.LEDs.Execute (Cmd => Execute.Amber_On);
      Execute.LEDs.Execute (Cmd => Execute.Green_On);
      Execute.LEDs.Execute (Cmd => Execute.White_On);
      Execute.LEDs.Execute (Cmd => Execute.Blue_On);
      RP.Device.Timer.Delay_Milliseconds (TIME_BETWEEN_PATTERN);

      -----------------------------------------------------------------------
      --  Pattern with Matrix Word
      Execute.Matrices.Execute (Cmd => Word_Pattern_0000);
      RP.Device.Timer.Delay_Milliseconds (TIME_BETWEEN_PATTERN);
      Execute.Matrices.Execute (Cmd => Word_Pattern_000F);
      RP.Device.Timer.Delay_Milliseconds (TIME_BETWEEN_PATTERN);
      Execute.Matrices.Execute (Cmd => Word_Pattern_00F0);
      RP.Device.Timer.Delay_Milliseconds (TIME_BETWEEN_PATTERN);
      Execute.Matrices.Execute (Cmd => Word_Pattern_0F00);
      RP.Device.Timer.Delay_Milliseconds (TIME_BETWEEN_PATTERN);
      Execute.Matrices.Execute (Cmd => Word_Pattern_F000);
      RP.Device.Timer.Delay_Milliseconds (TIME_BETWEEN_PATTERN);

      -----------------------------------------------------------------------
      --  Pattern with Matrix Double Word
      Execute.Matrices.Execute (Cmd => Double_Word_Pattern_00000000);
      RP.Device.Timer.Delay_Milliseconds (TIME_BETWEEN_PATTERN);
      Execute.Matrices.Execute (Cmd => Double_Word_Pattern_0000000F);
      RP.Device.Timer.Delay_Milliseconds (TIME_BETWEEN_PATTERN);
      Execute.Matrices.Execute (Cmd => Double_Word_Pattern_000000F0);
      RP.Device.Timer.Delay_Milliseconds (TIME_BETWEEN_PATTERN);
      Execute.Matrices.Execute (Cmd => Double_Word_Pattern_00000F00);
      RP.Device.Timer.Delay_Milliseconds (TIME_BETWEEN_PATTERN);
      Execute.Matrices.Execute (Cmd => Double_Word_Pattern_0000F000);
      RP.Device.Timer.Delay_Milliseconds (TIME_BETWEEN_PATTERN);
      Execute.Matrices.Execute (Cmd => Double_Word_Pattern_000F0000);
      RP.Device.Timer.Delay_Milliseconds (TIME_BETWEEN_PATTERN);
      Execute.Matrices.Execute (Cmd => Double_Word_Pattern_00F00000);
      RP.Device.Timer.Delay_Milliseconds (TIME_BETWEEN_PATTERN);
      Execute.Matrices.Execute (Cmd => Double_Word_Pattern_0F000000);
      RP.Device.Timer.Delay_Milliseconds (TIME_BETWEEN_PATTERN);
      Execute.Matrices.Execute (Cmd => Double_Word_Pattern_F0000000);
      RP.Device.Timer.Delay_Milliseconds (TIME_BETWEEN_PATTERN);

      -----------------------------------------------------------------------
      --  Pattern with Matrix Word
      Execute.Matrices.Execute (Cmd => Word_Pattern_0000);
      RP.Device.Timer.Delay_Milliseconds (TIME_BETWEEN_PATTERN);

      -----------------------------------------------------------------------
      --  Pattern with Matrix Double Word
      Execute.Matrices.Execute (Cmd => Double_Word_Pattern_00000000);
      RP.Device.Timer.Delay_Milliseconds (TIME_BETWEEN_PATTERN);

      -----------------------------------------------------------------------
      --  Pattern with LEDs OFF
      Execute.LEDs.Execute (Cmd => Execute.Red_Off);
      Execute.LEDs.Execute (Cmd => Execute.Amber_Off);
      Execute.LEDs.Execute (Cmd => Execute.Green_Off);
      Execute.LEDs.Execute (Cmd => Execute.White_Off);
      Execute.LEDs.Execute (Cmd => Execute.Blue_Off);

   end Show_Patterns_After_Reset;

   Area_Selector      : Transport.Area_Selector;
   LED_Instruction    : Evaluate.LEDs.LED_Instruction;
   Matrix_Instruction : Evaluate.Matrices.Matrix_Instruction;

begin
   Initializer.Initialize_All;

   Show_Patterns_After_Reset;

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
