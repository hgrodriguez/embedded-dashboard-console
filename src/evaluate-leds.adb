--
--  Copyright 2021 (C) Holger Rodriguez
--
--  SPDX-License-Identifier: BSD-3-Clause
--
package body Evaluate.LEDs is

   --------------------------------------------------------------------------
   --  Check functions for the input received
   --  Those functions set the global variables to the received value
   --------------------------------------------------------------------------
   function Check_Block (Block_Char : Character) return Boolean;
   function Check_Color (Color_Char : Character) return Boolean;
   function Check_Operation (Operation_Char : Character) return Boolean;

   --------------------------------------------------------------------------
   --  Those variables hold the input received and are set by the
   --  different Check_ functions
   --------------------------------------------------------------------------
   Block     : Blocks; pragma Warnings (Off, Block);
   Color     : Colors;
   Operation : Operations;

   --------------------------------------------------------------------------
   --  see: .ads file
   --------------------------------------------------------------------------
   function Check_Input (Instruction : LED_Instruction)
                         return Execute.LED_Errors is
   begin
      if not Check_Block (Instruction (1)) then
         return Execute.Wrong_Block;
      end if;

      if not Check_Color (Instruction (2)) then
         return Execute.Wrong_Color;
      end if;

      if not Check_Operation (Instruction (3)) then
         return Execute.Wrong_Operation;
      end if;

      return Execute.OK;
   end Check_Input;

   --------------------------------------------------------------------------
   --  see: .ads file
   --------------------------------------------------------------------------
   function Evaluate (Instruction : LED_Instruction)
                      return Execute.LED_Commands is
      subtype Command is Execute.LED_Commands;
      type Command_Map is array (Blocks, Colors, Operations) of Command;

      Command_Mapper : constant Command_Map
        := (Zero => (
                     Red => (
                             Off => Execute.Red_Off,
                             On => Execute.Red_On,
                             Toggle => Execute.Red_Toggle),
                     Amber => (
                               Off => Execute.Amber_Off,
                               On => Execute.Amber_On,
                               Toggle => Execute.Amber_Toggle),
                     Green => (
                               Off => Execute.Green_Off,
                               On => Execute.Green_On,
                               Toggle => Execute.Green_Toggle),
                     White => (
                               Off => Execute.White_Off,
                               On => Execute.White_On,
                               Toggle => Execute.White_Toggle),
                     Blue => (
                              Off => Execute.Blue_Off,
                              On => Execute.Blue_On,
                              Toggle => Execute.Blue_Toggle)
                    )
           );

   begin
      return Command_Mapper (Block, Color, Operation);
   end Evaluate;

   --------------------------------------------------------------------------
   --  Checks the character for the correct block request
   --------------------------------------------------------------------------
   function Check_Block (Block_Char : Character) return Boolean is
      type B_2_C_Map is array (Blocks) of Character;
      B_2_C : constant B_2_C_Map := (Zero => '0');
   begin
      for B in B_2_C_Map'First .. B_2_C_Map'Last loop
         if Block_Char = B_2_C (B) then
            Block := B;
            return True;
         end if;
      end loop;
      return False;
   end Check_Block;

   --------------------------------------------------------------------------
   --  Checks the character for the correct color request
   --------------------------------------------------------------------------
   function Check_Color (Color_Char : Character) return Boolean is
      type C_2_C_Map is array (Colors) of Character;
      C_2_C : constant C_2_C_Map := (Red => 'R',
                                     Amber => 'A',
                                     Green => 'G',
                                     White => 'W',
                                     Blue => 'B'
                                    );
   begin
      for C in C_2_C_Map'First .. C_2_C_Map'Last loop
         if Color_Char = C_2_C (C) then
            Color := C;
            return True;
         end if;
      end loop;
      return False;
   end Check_Color;

   --------------------------------------------------------------------------
   --  Checks the character for the correct operation request
   --------------------------------------------------------------------------
   function Check_Operation (Operation_Char : Character) return Boolean is
      type O_2_C_Map is array (Operations) of Character;
      O_2_C : constant O_2_C_Map
        := (Off => '0',
            On => '1',
            Toggle => '2');
   begin
      for O in
        O_2_C_Map'First .. O_2_C_Map'Last loop
         if Operation_Char = O_2_C (O) then
            Operation := O;
            return True;
         end if;
      end loop;
      return False;
   end Check_Operation;

end Evaluate.LEDs;
