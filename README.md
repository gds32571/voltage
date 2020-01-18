# voltage monitor
 Programs to monitor the kern.log file for system voltage messages and report to a central display.

One of my RPi computers is "crashing" more often than it should.  It's on a SwannCo UPS, so power should not be a problem.  But in the logfile, I see messages like <b>Under-voltage detected! (0x00050005)</b>.

## voltage.sh
1. So this program monitors (tail) the kern.log file.
2. greps for presence of the word "oltage" in a line.
3. if present, uses mqtt_publish to send that message to the central broker.

I can run a MQTT monitor to display this message from every computer without having to login to each RPi computer.  The voltage.sh program on the RPi computer is started in a screen so that if the ssh (putty) window closes, the program continues to run and report.

The downside, is that the kern.log file is rotated every 5-10 days so that tail will silently fail.  I need to figure that out.

## updateall
 A script file to copy the files to all computers.  The main proram (voltage.sh) can be edited on one computer, then copied to all the others.  There's no facility to automatically restart.  
 
 ## screenrc
  The screen startup file to run the program in a screen.
  
 ## 1.sh
  Run this to start a screen and run the voltage.sh program.
  
