From: Alexander Todorov <atodorov@otb.bg>
Date: Sat, 19 Mar 2011 14:18:47 +0000
Subject: Xrandr and udlfb
Message-Id: <4D84BB47.2030100@otb.bg>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hello folks,
does udlfb support Xrandr? What I need is to be able to rotate the display which 
for some reason I can't. My xorg.conf:

Section "ServerFlags"
         Option "RandR" "on
EndSection

Section "Device"
         Identifier "dl"
         driver     "fbdev"
         Option "ReportDamage" "true"
         Option "fbdev"  "/dev/fb1"
EndSection

Section "Monitor"
         Identifier "monitor"
         Option "Rotate" "left"
         Option "DPMS" "false"
EndSection


I'm using the fbdev DisplayLink Xorg drvier.

When X starts and shows a browser on the screen it is in normal orientation. If 
I decide to use xrandr command I get:

$ xrandr -o left
RANDR failure: 8 (extension base 160)
00060294 000000e2 00000000 00057b2b
00020000 0000003c
X Error of failed request:  BadMatch (invalid parameter attributes)
   Major opcode of failed request:  148 (RANDR)
   Minor opcode of failed request:  2 (RRSetScreenConfig)
   Serial number of failed request:  14
   Current serial number in output stream:  14


Not sure if it is supported or I am missing something.


Regards,
Alexander.
