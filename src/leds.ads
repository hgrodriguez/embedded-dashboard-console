with RP.GPIO;
with ItsyBitsy;

package LEDs is

   LED_0_Red : RP.GPIO.GPIO_Point renames ItsyBitsy.GP12;

   procedure Initialize;

end LEDs;
