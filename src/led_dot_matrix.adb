with RP.Device;
with RP.I2C_Master;
with RP.GPIO;

with ItsyBitsy;

with Pimoroni_LED_Dot_Matrix;

package body LED_Dot_Matrix is

   LED_I2C      : RP.I2C_Master.I2C_Master_Port renames ItsyBitsy.I2C;

   package Dot_Matrix is new Pimoroni_LED_Dot_Matrix (LED_I2C'Access,
                                                         Matrix_Address);

   LED_SDA      : RP.GPIO.GPIO_Point renames ItsyBitsy.SDA;
   LED_SCL      : RP.GPIO.GPIO_Point renames ItsyBitsy.SCL;
   LED_DP       : Boolean := False;
   LED_L, LED_R : Dot_Matrix.Display_Matrix := (others => (others => False));
   LED_X        : Dot_Matrix.Display_Column
     := Dot_Matrix.Display_Column'First;
   LED_Y        : Dot_Matrix.Display_Row := Dot_Matrix.Display_Row'First;

   procedure LED_Dot_Matrix_Initialise_I2C is
   begin
      LED_SDA.Configure (RP.GPIO.Output, RP.GPIO.Floating, RP.GPIO.I2C);
      LED_SCL.Configure (RP.GPIO.Output, RP.GPIO.Floating, RP.GPIO.I2C);
      LED_I2C.Enable (100_000);
   end LED_Dot_Matrix_Initialise_I2C;

   procedure LED_Dot_Matrix_Initialise is
   begin
      Dot_Matrix.Write_Byte_Data (Dot_Matrix.Reset, 16#FF#);
   end LED_Dot_Matrix_Initialise;

   procedure LED_Dot_Matrix_Run is
   begin
      if LED_X = Dot_Matrix.Display_Column'Last then
         LED_X := 0;
         if LED_Y = Dot_Matrix.Display_Row'Last then
            LED_Y := 0;
         else
            LED_Y := LED_Y + 1;
         end if;
      else
         LED_X := LED_X + 1;
      end if;
      LED_L := (others => (others => False));
      LED_L (LED_X, LED_Y) := True;
      LED_R := LED_L;
      LED_DP := not LED_DP;
      Dot_Matrix.
        Write_Block_Data (Dot_Matrix.Matrix_L,
                          Dot_Matrix.To_Left_Matrix (LED_L, LED_DP));
      Dot_Matrix.
        Write_Block_Data (Dot_Matrix.Matrix_R,
                          Dot_Matrix.To_Right_Matrix (LED_R, LED_DP));
      Dot_Matrix.Write_Byte_Data (Dot_Matrix.Mode, 2#00011000#);
      Dot_Matrix.Write_Byte_Data (Dot_Matrix.Options, 2#00001110#);
      Dot_Matrix.Write_Byte_Data (Dot_Matrix.Brightness, 255);
      Dot_Matrix.Write_Byte_Data (Dot_Matrix.Update, 1);
   end LED_Dot_Matrix_Run;

end LED_Dot_Matrix;
