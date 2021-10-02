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

   type Matrix_Actions is (
                           --  Error Codes
                           M_OK,
                           M_Wrong_Block,
                           M_Wrong_Size,
                           M_Wrong_Position,
                           M_Wrong_Value,
                           --  Commands to execute
                           Byte_0, Byte_1,
                           Word_0
                          );

   subtype Matrix_Errors
     is Matrix_Actions range M_OK
       .. M_Wrong_Value;
   subtype Matrix_Commands is Matrix_Actions range Byte_0 .. Word_0;

   --------------------------------------------------------------------------
   --  Represents the value given to display
   subtype Value_String_Type is String (1 .. 4);

   --------------------------------------------------------------------------
   --  Represents the command and value given to display
   type Matrix_Command is record
      Command : Matrix_Commands;
      Value   : Value_String_Type;
   end record;

end Execute;
