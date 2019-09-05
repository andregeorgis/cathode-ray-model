# Cathode Ray Model
Model of a cathode ray using Arduino Uno and Processing for Year 12 Physics
Assignment :stuck_out_tongue:. Really should have put this here earlier
:confused: just been sitting in a g-drive :joy:


## Summary
In Year 12 Physics we were given an assignment to model the behaviour of a
cathode ray. This project uses an Arduino Uno with connected potentiometers and
ultrasonic sensors, connected to a Processing sketch via Serial.

Arduino Uno - meant to model the cathode ray apparatus
Ultrasonic Sensors - meant to model the distance between a magnet (which would
  have been someone's hand) and the cathode ray (arduino)
Potentiometer - meant to model the AC current in an electric coil near the
  cathode ray (arduino) AND a voltage in electric plates near the cathode ray
Processing - showed the effects of the above and also has its own demonstrations

## model_arduino
Contains the code for the Arduino to read the voltage output from the
potentiometer, to calculate the distance between the ultrasonic sensor and
someone's hand, and to send this information to the processing sketch via a
Serial connection.

## model_processing
Contains the code to visualise what is happening; including:
1. Showing the movement of a magnet as a person move's their hand
2. Showing the change in current in coils as a potentiometer is played with
3. Showing the change in voltage in plates as a potentiometer is played with
3. Showing the effect of magnet/coil on a cathode ray (causing it to bend)
  - Showed in Top, Side and Front view

The sketch was able to demonstrate the effect of multiple magnets, or multiple
coils, or multiple plates to achieve a bending in any direction.

## model_processing_no_arduino
Same function as above but instead using a (dodgy :stuck_out_tongue:) set of GUI
controls. Used for testing sketch when Arduino wasn't available/when I wasn't
bothered wiring that hideous monstrosity :joy:.

## image_test
A processing sketch that would demonstrate the specific use of cathode rays in
TVs - demonstrating how an image would form out of RGB pixels. This was done
using images converted to bitmaps. It also has the functionality to take a photo
using my laptop camera and demonstrating the same process but with this photo
instead. (apparently I tried to integrate sound as well but I can't remember why
sooo :stuck_out_tongue:).
