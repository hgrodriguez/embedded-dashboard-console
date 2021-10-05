# embedded-dashboard-console
Implementation of an embedded dashboard console offering status views using LEDs, 5x7 matrix and OLED

The project uses the alr environment to manage all outside dependencies.

## Overall idea
This project offers an embedded dashabord, which can display:
1. LED status, commanded by Off, On, Toggle
1. 5x7 Matrix displays, where
   * one can display a 16-bit Word value
   * the other can display a 32bit DWord value

## Input capabilities
Planned are the following input capabilities:
1. UART
2. SPI - Slave
3. I2C - Slave (not sure how to implement this, as there is no Ada code available how to do this)

## Versioning scheme
Major.Minor.Patch

### Major
1 = UART
2 = UART + SPI
3 = UEAR + SPI + I2C

### Minor
1 = LEDs
2 = LEDs + Matrix 16-bit Word HEX display
3 = LEDs + Matrix 16-bit Word + Matrix 32-bit DWord HEX Display
4 = LEDs + Matrix 16-bit Word + Matrix 32-bit DWord HEX Display + Character Display

