--
--  Copyright 2021 (C) Holger Rodriguez
--
--  SPDX-License-Identifier: BSD-3-Clause
--
package body Evaluate.LEDs is

   subtype LED_Switch is String (1 .. 2);
   subtype LED_State is String (1 .. 1);

   Block     : Blocks; pragma Warnings (Off, Block);
   Color     : Colors;
   Operation : Operations;

   subtype Command is Execute.LED_Commands;
   type Command_Map is array (Colors, Operations) of Command;

   Command_Mapper : constant Command_Map
     := (
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
        );

   function Check_Input (Instruction : LED_Instruction)
                          return Execute.LED_Errors is
      Block_Char     : constant Character := Instruction (1);
      Color_Char     :  constant Character := Instruction (2);
      Operation_Char :  constant Character := Instruction (3);

      Check     : Boolean;

      type Block_To_Character_Map is array (Blocks) of Character;
      Block_To_Character : constant Block_To_Character_Map := (Zero => '0');

      type Color_To_Character_Map is array (Colors) of Character;
      Color_To_Character : constant Color_To_Character_Map := (Red => 'R',
                                                               Amber => 'A',
                                                               Green => 'G',
                                                               White => 'W',
                                                               Blue => 'B'
                                                              );

      type Operation_To_Character_Map is array (Operations) of Character;
      Operation_To_Character : constant Operation_To_Character_Map
        := (Off => '0',
            On => '1',
            Toggle => '2');

   begin
      Check := False;
      for B in Block_To_Character_Map'First .. Block_To_Character_Map'Last loop
         if Block_Char = Block_To_Character (B) then
            Check := True;
            Block := B;
            exit;
         end if;
      end loop;
      if not Check then
         return Execute.Wrong_Block;
      end if;

      Check := False;
      for C in Color_To_Character_Map'First .. Color_To_Character_Map'Last loop
         if Color_Char = Color_To_Character (C) then
            Check := True;
            Color := C;
            exit;
         end if;
      end loop;
      if not Check then
         return Execute.Wrong_Color;
      end if;

      Check := False;
      for O in
        Operation_To_Character_Map'First
          ..
            Operation_To_Character_Map'Last loop

         if Operation_Char = Operation_To_Character (O) then
            Check := True;
            Operation := O;
            exit;
         end if;
      end loop;
      if not Check then
         return Execute.Wrong_Operation;
      end if;
      return Execute.OK;
   end Check_Input;

   function Evaluate_Block_0 (Switch : LED_Switch)
                              return Execute.LED_Commands;

   function Evaluate (Instruction : LED_Instruction)
                      return Execute.LED_Commands is
      Switch : constant LED_Switch := Instruction (2 .. 3);
   begin
      return Evaluate_Block_0 (Switch);
   end Evaluate;

   function Evaluate_Block_0_Red (Operation : Operations)
                                  return Execute.LED_Commands;
   function Evaluate_Block_0_Amber (Operation : Operations)
                                    return Execute.LED_Commands;
   function Evaluate_Block_0_Green (Operation : Operations)
                                    return Execute.LED_Commands;
   function Evaluate_Block_0_White (Operation : Operations)
                                    return Execute.LED_Commands;
   function Evaluate_Block_0_Blue (Operation : Operations)
                                   return Execute.LED_Commands;

   type Block_0_Evaluate is access function (Operation : Operations)
                                             return Execute.LED_Commands;
   type Block_0_Evaluate_Map is array (Colors) of Block_0_Evaluate;

   Block_0_Evaluate_Mapper : constant Block_0_Evaluate_Map
     := (
         Red => Evaluate_Block_0_Red'Access,
         Amber => Evaluate_Block_0_Amber'Access,
         Green => Evaluate_Block_0_Green'Access,
         White => Evaluate_Block_0_White'Access,
         Blue => Evaluate_Block_0_Blue'Access
        );

   function Evaluate_Block_0 (Switch : LED_Switch)
                              return Execute.LED_Commands is
      State      : constant LED_State := Switch (2 .. 2);
   begin
      return Block_0_Evaluate_Mapper (Color).all (Operation);
   end Evaluate_Block_0;

   function Evaluate_Block_0_Red (Operation : Operations)
                                  return Execute.LED_Commands is
   begin
      return Command_Mapper (Color, Operation);
   end Evaluate_Block_0_Red;

   function Evaluate_Block_0_Amber (Operation : Operations)
                                    return Execute.LED_Commands is
   begin
      return Command_Mapper (Color, Operation);
   end Evaluate_Block_0_Amber;

   function Evaluate_Block_0_Green (Operation : Operations)
                                    return Execute.LED_Commands is
   begin
      return Command_Mapper (Color, Operation);
   end Evaluate_Block_0_Green;

   function Evaluate_Block_0_White (Operation : Operations)
                                    return Execute.LED_Commands is
   begin
      return Command_Mapper (Color, Operation);
   end Evaluate_Block_0_White;

   function Evaluate_Block_0_Blue (Operation : Operations)
                                   return Execute.LED_Commands is
   begin
      return Command_Mapper (Color, Operation);
   end Evaluate_Block_0_Blue;

end Evaluate.LEDs;
