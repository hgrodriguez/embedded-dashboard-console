--===========================================================================
--
--  This is the root package for all transport capabilities available
--  Every transport capability shall offer the same functionality,
--  independent of any channel used.
--
--===========================================================================
--
--  Copyright 2021 (C) Holger Rodriguez
--
--  SPDX-License-Identifier: BSD-3-Clause
--
package Transport is

   --------------------------------------------------------------------------
   --  Available areas for the dashboard
   --------------------------------------------------------------------------
   type Area_Selector is (None, Led);

end Transport;
