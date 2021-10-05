--===========================================================================
--
--  This is the root package for the different evaluations for the different
--  available dashboard elements.
--
--===========================================================================
--
--  Copyright 2021 (C) Holger Rodriguez
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with Transport;

package Evaluate is

   --------------------------------------------------------------------------
   --  Definitions of area selectors for the different areas available
   --------------------------------------------------------------------------
   LED_Prefix    : constant Transport.Area_Selector := Transport.Led;
   Matrix_Prefix : constant Transport.Area_Selector := Transport.Matrix;

end Evaluate;
