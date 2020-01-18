# voltage monitor
 Programs to monitor the kern.log file for system voltage messages and report to a central display.

   One of my RPi computers is "crashing" more often than it should.  The network watchdog shows that the RPi and the major programs are not running. Another symptom is that the RPi computer no longer responds to pings, or ssh connects.  But, according to the deadman blinking LED, the computer <i>is</i> still running. (The UPS would have commanded a reboot if it were not).  Sometimes, rebooting the network router will allow new connections to the recalcitrant RPi.  The logs show that there was a problem with the WiFi adapter on the RPi.  

   Unstable power is known to cause the RPi WiFi, Ethernet, or USB interfaces to fail without killing the core of the computer. But this failing RPi is on a SwannCo UPS, so power <i>should not</i> be a problem.  However, in the logfile, I see messages like <b>Under-voltage detected! (0x00050005)</b>.  Obviously, this requires further investigation.

## voltage.sh
  The main program
1. this program monitors (tail) the kern.log file.
2. greps for presence of the word "oltage" in a line.
3. if present, uses mqtt_publish to send that message to the central broker.

I can run an MQTT monitor to display this message from every computer without having to login to each RPi computer.  The voltage.sh program on the RPi computer is started in a screen so that if the ssh (putty) window closes, the program continues to run and report.

The downside, is that the kern.log file is rotated every 5-10 days so that tail will silently fail. ~~I need to figure that out.~~  Oh, the "-F" flag for grep follows by name rather than inode.  Problem solved.

The program does report that it has started and the program version number to the central broker.

## updateall
 A script file to copy the files to all computers.  The main program (voltage.sh) can be edited on one computer, then copied to all the others.  There's no facility to automatically restart.  
 
 ## screenrc
  The screen runtime configuration file to run the main program in a screen.
  
 ## 1.sh
  Run this script on the client RPi computer to start a screen and run the voltage.sh program.
  
 ## pi_stat
   Nice script to tell you several bits of information about the state of your Raspberry Pi.  Be sure to see James' website
   at:    https://jamesachambers.com/measure-raspberry-pi-undervoltage-true-clock-speeds/
   
   
  
