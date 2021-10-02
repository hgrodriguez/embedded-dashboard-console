with HAL.I2C;

generic
   Matrix_Address : HAL.I2C.I2C_Address;

package LED_Dot_Matrix is

   procedure LED_Dot_Matrix_Initialise_I2C;
   procedure LED_Dot_Matrix_Initialise;
   procedure LED_Dot_Matrix_Run;

end LED_Dot_Matrix;
