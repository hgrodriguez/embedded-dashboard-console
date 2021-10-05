with RP.GPIO;
with RP.I2C_Master;

with Pimoroni_LED_Dot_Matrix;

package body Matrix_Area_Word is

   procedure Initialize is
      package PLDM_0 is new Pimoroni_LED_Dot_Matrix (Byte_0_I2C,
                                                     Byte_0_Address);
      package PLDM_1 is new Pimoroni_LED_Dot_Matrix (Byte_1_I2C,
                                                     Byte_1_Address);
   begin
      PLDM_0.Initialize;
      PLDM_1.Initialize;
   end Initialize;

end Matrix_Area_Word;
