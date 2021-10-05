with Pimoroni_LED_Dot_Matrix;

package body Matrix_Area_Double_Word is

   procedure Initialize is
      package PLDM_0 is new Pimoroni_LED_Dot_Matrix (Byte_0_I2C,
                                                     Byte_0_Address);
      package PLDM_1 is new Pimoroni_LED_Dot_Matrix (Byte_1_I2C,
                                                     Byte_1_Address);
      package PLDM_2 is new Pimoroni_LED_Dot_Matrix (Byte_2_I2C,
                                                     Byte_2_Address);
      package PLDM_3 is new Pimoroni_LED_Dot_Matrix (Byte_3_I2C,
                                                     Byte_3_Address);

   begin
      PLDM_0.Initialize;
      PLDM_1.Initialize;
      PLDM_2.Initialize;
      PLDM_3.Initialize;
   end Initialize;

end Matrix_Area_Double_Word;
