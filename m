From: Chad A Daelhousen <cd9@cse.Buffalo.EDU>
Subject: radeonfb + RV200 + DVI broken
Date: Thu, 5 Jun 2003 19:36:38 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030605233638.GA9842@gagarin.cse.Buffalo.EDU>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from gagarin.cse.buffalo.edu ([128.205.36.11] ident=daemon)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19O4Hh-0007As-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 05 Jun 2003 16:36:41 -0700
Received: (from cd9@localhost)
	by gagarin.cse.buffalo.edu (8.11.6+Sun/8.11.6) id h55NacJ09977
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 5 Jun 2003 19:36:38 -0400 (EDT)
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

Greetings,

I have some new hardware to play with: an ATI Radeon 7500 QW and a
Mitsubishi DiamondPoint NXM76LCD monitor, a 17-inch flatpanel. Last
night, I finally got a 1280x1024 textmode up and running on the Radeon's
VGA output. Today, the DVI cable arrived, and the setup no longer works.

Before I get too far, I'm using kernel 2.4.20-ck6, and I did a quick
check on 2.5.68 as well. Most of this message pertains to 2.4.

If I don't specify panel_yres, then the video is unchanged. If I do
specify it, then the screen says "no signal" and shuts down. In this
case, I can still wait for it to boot, log in, and run startx, and X
will come up fine. (X is configured to use driver "radeon". Everything
works, including DRI.)

video=1280x1024@61 dmesg:

  radeonfb: detected DFP panel size from BIOS: 1x0
  radeonfb: Failed to detect DFP panel size

The panel ID string printed immediately before those messages is binary.
In hex: AA 68 E9 A2 05

video=1280x1024@61,panel_yres:1024 dmesg:

  radeonfb: detected DFP panel size from BIOS: 1x0
  radeonfb: detected DFP panel size from registers: 1280x1024
  Console: switching to colour frame buffer device 160x64
  radeonfb: ATI Radeon 7500 QW  DDR SGRAM 64 MB
  radeonfb: DVI port DFP monitor connected
  radeonfb: CRT port no monitor connected

Chipset, memory, and monitors are probed correctly.

I tried hooking up the VGA cable to the same monitor and selecting
different inputs, but the VGA port copies the DVI port's
characteristics. Namely, 80x25 VGA text mode (which should be 640x400)
comes into the monitor at 1024x768. However, in such configuration, both
cables are correctly detected as present.

The same symptoms occur with panel_yres:768 as with panel_yres:1024. I
tried it because the Radeon scales 80x25 textmode to 1024x768 before
putting out on DVI.

Incidentally, I tried this on 2.5.68 as well; it simply ignores
panel_yres, detects the panel as being 1x0, and doesn't change the video
mode.

I would really like a digital full-resolution framebuffer console, if
only for the 1337ness points. Where should I look to work on this? Is
there any documentation for the RV200 available for free? If I could at
least read the register states on VGA and (blank) DVI, it'd be a start.

-- 
Chad Daelhousen
My opinions are my own, until UB purchases my soul.



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
