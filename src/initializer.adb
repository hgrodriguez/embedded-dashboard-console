with RP.Device;
with RP.Clock;
with RP.GPIO;
with RP.I2C_Master;

with ItsyBitsy;

with Transport.Serial;

with Matrix_Area_Word;
with Matrix_Area_Double_Word;

package body Initializer is

   --------------------------------------------------------------------------
   --               Minor Title Here
   --------------------------------------------------------------------------
   procedure Initialize_Device;
   --------------------------------------------------------------------------
   --               Minor Title Here
   --------------------------------------------------------------------------
   procedure Initialize_I2C_0;
   --------------------------------------------------------------------------
   --               Minor Title Here
   --------------------------------------------------------------------------
   procedure Initialize_I2C_1;

   --------------------------------------------------------------------------
   --  see .ads
   --------------------------------------------------------------------------
   procedure Initialize_All is
   begin
      Initialize_Device;

      ItsyBitsy.LED.Configure (RP.GPIO.Output);

      Initialize_I2C_0;
      Initialize_I2C_1;

      Matrix_Area_Word.Initialize;
      Matrix_Area_Double_Word.Initialize;

      Transport.Serial.Initialize;
   end Initialize_All;

   --------------------------------------------------------------------------
   --
   --------------------------------------------------------------------------
   procedure Initialize_Device is
   begin
      RP.Clock.Initialize (ItsyBitsy.XOSC_Frequency);
      RP.Clock.Enable (RP.Clock.PERI);
      RP.Device.Timer.Enable;
   end Initialize_Device;

   --------------------------------------------------------------------------
   --
   --------------------------------------------------------------------------
   procedure Initialize_I2C_0 is
      SDA     : RP.GPIO.GPIO_Point renames ItsyBitsy.D10;
      SCL     : RP.GPIO.GPIO_Point renames ItsyBitsy.D11;
      I2C_0_0 : RP.I2C_Master.I2C_Master_Port renames RP.Device.I2C_0;
   begin
      SDA.Configure (RP.GPIO.Output, RP.GPIO.Pull_Up, RP.GPIO.I2C);
      SCL.Configure (RP.GPIO.Output, RP.GPIO.Pull_Up, RP.GPIO.I2C);
      I2C_0_0.Enable (100_000);
   end Initialize_I2C_0;

   --------------------------------------------------------------------------
   --
   --------------------------------------------------------------------------
   procedure Initialize_I2C_1 is
      SDA   : RP.GPIO.GPIO_Point renames ItsyBitsy.SDA;
      SCL   : RP.GPIO.GPIO_Point renames ItsyBitsy.SCL;
      I2C_1 : RP.I2C_Master.I2C_Master_Port renames ItsyBitsy.I2C;
   begin
      SDA.Configure (RP.GPIO.Output, RP.GPIO.Pull_Up, RP.GPIO.I2C);
      SCL.Configure (RP.GPIO.Output, RP.GPIO.Pull_Up, RP.GPIO.I2C);
      I2C_1.Enable (100_000);
   end Initialize_I2C_1;

end Initializer;
