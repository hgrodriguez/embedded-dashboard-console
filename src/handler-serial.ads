--===========================================================================
--
--  Handles all the functionality for the serial transport input method
--
--===========================================================================
--
--  Copyright 2021 (C) Holger Rodriguez
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with Transport;

package Handler.Serial is

   --------------------------------------------------------------------------
   --  Handles the serial input request for the area given as parameter
   --------------------------------------------------------------------------
   procedure Handle_Request (Area_Selector : Transport.Area_Selector);

end Handler.Serial;
