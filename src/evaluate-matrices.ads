--===========================================================================
--
--  This package checks and evaluates the input received from the serial
--  line for commanding the LEDs
--
--===========================================================================
--
--  Copyright 2021 (C) Holger Rodriguez
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with Execute;

package Evaluate.Matrices is

   --------------------------------------------------------------------------
   --  Matrix section
   --  The complete instruction is built as (all elements are Character):
   --  <Matrix_Prefix><Block Code><Size Code><Selector><Value>
   --  Matrix_Prefix := M
   --  This Matrix_Instruction is the part *after* the Matrix_Prefix
   --  Block Code := (0) --  only one block available at the moment
   --  Size Code := B=Byte, W=Word
   --  Position := 0/1 (counting from the right)
   --  Value :=
   --           If Size Code = B then
   --              '00' .. 'FF'
   --           elseif Size_Code = W then
   --              '0000'.. 'FFFF'
   --           end if;
   subtype Matrix_Instruction is String (1 .. 11);

   --------------------------------------------------------------------------
   --  Blocks of Matrices defined.
   --------------------------------------------------------------------------
   type Blocks is (Zero, One);

   --------------------------------------------------------------------------
   --  Sizes of Matrix available
   --------------------------------------------------------------------------
   type Sizes is (Byte, Word, Double_Word);

   --------------------------------------------------------------------------
   --  Positions of Value in the Matrix
   --------------------------------------------------------------------------
   type Positions is (Zero, One, Two, Three);

   --------------------------------------------------------------------------
   --  Checks the input received against the rules defined above
   --------------------------------------------------------------------------
   function Check_Input (Instruction : Matrix_Instruction)
                         return Execute.Matrix_Errors;

   --------------------------------------------------------------------------
   --  Evaluates the input received and returns the equivalent LED Command
   --------------------------------------------------------------------------
   function Evaluate (Instruction : Matrix_Instruction)
                      return Execute.Matrix_Command;


end Evaluate.Matrices;
