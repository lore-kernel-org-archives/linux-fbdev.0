From: =?iso-8859-1?q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
Subject: Radeon X300, radeonfb, dual head
Date: Wed, 18 Apr 2007 14:09:51 +0200
Message-ID: <200704181409.51475.hjk@linutronix.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1He8z2-0006fs-U4 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 18 Apr 2007 05:10:01 -0700
Received: from www.osadl.org ([213.239.205.134] helo=mail.tglx.de)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1He8z1-00026y-Ph
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 18 Apr 2007 05:10:00 -0700
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: xorg@lists.freedesktop.org
Cc: linux-fbdev-devel@lists.sourceforge.net

I've got a Radeon X300 (MSI RX300HM) PCIE card. The card has a 
VGA and a DVI-I output. I connect two LCD monitors (1680x1050 each)
using VGA outputs (DVI-VGA adapter for one monitor).

I'd like to run xserver-xorg with KDE from Debian unstable in 
mergedfb mode showing a 3360x1050 desktop across the two monitors.

I'm running a vanilla 2.6.21-rc7. Now I've got two problems that
might or might not be related:

1.) I compiled radeonfb statically into my kernel and booted with
video=radeonfb:1280x1024-32@60. This works fine, the framebuffer
console works as expected. But the X server doesn't come up
properly. Xorg.0.log ends like this:

[...]
(**) RADEON(0): RADEONSaveScreen(2)
(**) RADEON(0): FIFO timed out: 2 entries, stat=0x80026102
(EE) RADEON(0): FIFO timed out, resetting engine...
(**) RADEON(0): EngineRestore (32/32)
(**) RADEON(0): FIFO timed out: 31 entries, stat=0x8002611f
(EE) RADEON(0): FIFO timed out, resetting engine...
(**) RADEON(0): EngineRestore (32/32)
(**) RADEON(0): FIFO timed out: 15 entries, stat=0x8002610f
(EE) RADEON(0): FIFO timed out, resetting engine...
(**) RADEON(0): EngineRestore (32/32)
(**) RADEON(0): FIFO timed out: 15 entries, stat=0x8002610f
(EE) RADEON(0): FIFO timed out, resetting engine...
(**) RADEON(0): EngineRestore (32/32)
(**) RADEON(0): FIFO timed out: 31 entries, stat=0x8002611f
(EE) RADEON(0): FIFO timed out, resetting engine...
(**) RADEON(0): EngineRestore (32/32)
(**) RADEON(0): FIFO timed out: 3 entries, stat=0x80026103
(EE) RADEON(0): FIFO timed out, resetting engine...
(**) RADEON(0): EngineRestore (32/32)
(**) RADEON(0): FIFO timed out: 6 entries, stat=0x80026106
(EE) RADEON(0): FIFO timed out, resetting engine...
(**) RADEON(0): EngineRestore (32/32)
(**) RADEON(0): RADEONCloseScreen
(**) RADEON(0): RADEONDRIStop
(**) RADEON(0): RADEONDisplayPowerManagementSet(0,0x0)
(**) RADEON(0): RADEONRestore
(**) RADEON(0): RADEONRestoreMode()
(**) RADEON(0): RADEONRestoreMode(0x8202e40)
(**) RADEON(0): RADEONRestoreMemMapRegisters() :
(**) RADEON(0):   MC_FB_LOCATION   : 0x1fff0000
(**) RADEON(0):   MC_AGP_LOCATION  : 0x27ff2000
(**) RADEON(0):   Map Changed ! Applying ...
(**) RADEON(0):   Map applied, resetting engine ...
(**) RADEON(0): Updating display base addresses...
(**) RADEON(0): Memory map updated.
(**) RADEON(0): Programming CRTC2, offset: 0x00000000
(**) RADEON(0): Wrote: 0x00000000 0x00000000 0x00000000 (0x0000a400)
(**) RADEON(0): Wrote: rd=0, fd=0, pd=0
(**) RADEON(0): Programming CRTC1, offset: 0x00000000
(**) RADEON(0): Wrote: 0x0030000c 0x00010060 0x00000000 (0x0000a700)
(**) RADEON(0): Wrote: rd=12, fd=96, pd=1
(**) RADEON(0): Disposing accel...
(**) RADEON(0): Disposing cusor info
(**) RADEON(0): Disposing DGA
(**) RADEON(0): Unmapping memory
FreeFontPath: FPE "unix/:7100" refcount is 2, should be 1; fixing.

That's all, I end up with two black screens.

2.) I compiled vesafb statically, radeonfb only as module. If I boot
with vga=0x318, the framebuffer console works as expected. The
X server starts up, Xorg.0.log looks good (except that DRI is disabled).

But when kdm comes up, I see the same picture on both monitors. What I
see looks like the right half of the 3360x1050 desktop (mouse can be
moved across the left border of the screen, stops at the right border).
Both screens are driven properly with 1680x1050. I tried several
modifications of my xorg.conf, but never managed to get different
images on the two monitors, they always show the same. 

Here are the relevant parts of my current xorg.conf:

Section "Device"
        Identifier      "RadeonX300"
        Driver          "radeon"
        BusID           "PCI:1:0:0"
        Option          "MergedFB" "true"
        Option          "MonitorLayout" "TMDS,TMDS"
        Option          "CRT2Position" "RightOf"
        Option          "CRT2HSync" "32-82"
        Option          "CRT2VRefresh" "56-75"
        Option          "MetaModes" "1680x1050-1680x1050"
EndSection

Section "Monitor"
        Identifier      "NECMonitor1"
        Option          "DPMS"
        HorizSync       32-82
        VertRefresh     56-75
EndSection

Section "Monitor"
        Identifier      "NECMonitor2"
        Option          "DPMS"
        HorizSync       32-82
        VertRefresh     56-75
EndSection

Section "Screen"
        Identifier      "Screen1"
        Device          "RadeonX300"
        Monitor         "NECMonitor1"
        DefaultDepth    24
        SubSection "Display"
                Depth           16
                Modes           "1680x1050"
        EndSubSection
        SubSection "Display"
                Depth           24
                Modes           "1680x1050"
        EndSubSection
EndSection

Section "ServerLayout"
        Identifier      "Default Layout"
        Screen          "Screen1" 0 0
        InputDevice     "Generic Keyboard"
        InputDevice     "Configured Mouse"
EndSection

So, at the moment I've got the choice between radeonfb and no X at all
or vesafb and X without proper dual head functionality. That's like
the difference between a rock and a hard place :-)

If you need more information, please tell me.

Any ideas?

Thanks,
Hans



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
