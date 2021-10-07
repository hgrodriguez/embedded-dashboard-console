# embedded-dashboard-console
Implementation of an embedded dashboard console offering status views using LEDs, 5x7 matrix and OLED

The project uses the alr environment to manage all outside dependencies.

## Overall idea
This project offers an embedded dashabord, which can display:
1. LEDs with different colors, e.g. Red/Amber/Green/White/Blue, commanded by Off, On, Toggle
1. 5x7 Matrix displays, where
   * one can display two independent Byte values or 16-bit Word value
   * the other can display four independent Byte, two independent 16-bit Word or one 32-bit DWord value
1. OLED display: details tbd.

## Input capabilities
Planned are the following input capabilities:
1. UART
1. SPI - Slave
1. I2C - Slave (not sure how to implement this, as there is no Ada code available how to do this)

## Versioning scheme
Major.Minor.Patch

### Major
1 = UART

2 = UART + SPI
 
3 = UART + SPI + I2C

### Minor
1 = LEDs

2 = LEDs + Matrix 16-bit Word HEX display

3 = LEDs + Matrix 16-bit Word HEX Display + Matrix 32-bit DWord HEX Display

4 = LEDs + Matrix 16-bit Word HEX Display + Matrix 32-bit DWord HEX Display + Character Display

5 = LEDs + Matrix 16-bit Word HEX Display + Matrix 32-bit DWord HEX Display + Character Display + Horizontal Scrolling Character Display

6 = OLED
