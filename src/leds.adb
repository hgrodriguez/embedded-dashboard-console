package body LEDs is

   procedure Initialize is
   begin
      null;
   end Initialize;

begin
   LED_0_Red.Configure (RP.GPIO.Output);
end LEDs;
