--===========================================================================
--
--  This is the root package for the different execution possibilities
--  for the different areas available on the dashboard.
--
--===========================================================================
--
--  Copyright 2021 (C) Holger Rodriguez
--
--  SPDX-License-Identifier: BSD-3-Clause
--
package Execute is

   --------------------------------------------------------------------------
   --  LED: all LED related actions
   --       to simplify the interface, the possible error codes and
   --       actual commands are mixed into one enum
   --       [maybe not the best thing to do?]
   --------------------------------------------------------------------------
   type LED_Actions is (
                        --  Error Codes
                        OK,
                        Wrong_Block,
                        Wrong_Color,
                        Wrong_Operation,

                        --  Commands to execute
                        Red_Off, Red_On, Red_Toggle,
                        Amber_Off, Amber_On, Amber_Toggle,
                        Green_Off, Green_On, Green_Toggle,
                        White_Off, White_On, White_Toggle,
                        Blue_Off, Blue_On, Blue_Toggle
                       );
   subtype LED_Errors is LED_Actions range OK .. Wrong_Operation;
   subtype LED_Commands is LED_Actions range Red_Off .. Blue_Toggle;

   --------------------------------------------------------------------------
   --  Matrix: all Matrix related actions
   --          to simplify the interface, the possible error codes and
   --          actual commands are mixed into one enum
   --          [maybe not the best thing to do?]
   --------------------------------------------------------------------------
   type Matrix_Actions is (
                           --  Error Codes
                           M_OK,
                           M_Wrong_Block,
                           M_Wrong_Size,
                           M_Wrong_Position,
                           M_Wrong_Value,
                           --  Blocks available
                           Block_0, Block_1,
                           --  Commands to execute
                           Byte_0, Byte_1,
                           Byte_2, Byte_3,
                           Word_0, Word_1
                          );
   subtype Matrix_Errors is Matrix_Actions range M_OK .. M_Wrong_Value;
   subtype Matrix_Blocks is Matrix_Actions range Block_0 .. Block_1;
   subtype Matrix_Commands is Matrix_Actions range Byte_0 .. Word_1;

   --------------------------------------------------------------------------
   --  Represents the value given to display
   subtype Matrix_Value_Type is String (1 .. 4);

   --------------------------------------------------------------------------
   --  Represents the command and value given to display
   type Matrix_Command is record
      Block   : Matrix_Blocks;
      Command : Matrix_Commands;
      Value   : Matrix_Value_Type;
   end record;

end Execute;
