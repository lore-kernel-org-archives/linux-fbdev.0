From: Miles Lane <miles@megapathdsl.net>
Subject: Rivafb colors all messed up with 2.5.20-dj2.
Date: Wed, 05 Jun 2002 00:25:24 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3CFDBCE4.9050807@megapathdsl.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from front2.mail.megapathdsl.net ([66.80.60.30])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17FVCV-0006Tc-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Jun 2002 00:27:23 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@transvirtual.com>

For a long time, I have had messed up colors when I use rivafb.
In the past, just the penguin logo has been obviously messed up
(all purple).  Now, all the colors are off.  By running
"fbset -a 1600x1200-76" I am able to get the framebuffer colors
correctly set.  Also, running this command gives me the 
desired refresh rate.  I suspect I am using an incorrect
boot parameter value.  Can someone tell me what value to use
to get 1600x1200 @ 76Hz and 16-bit color?

From the kernel log:

rivafb: RIVA MTRR set to ON
Console: switching to colour frame buffer device 200x75
rivafb: PCI nVidia NV10 framebuffer ver 0.9.3 (GeForce-DDR, 32MB @ 0xE8000000)

"lspci -v" gives:

01:05.0 VGA compatible controller: nVidia Corporation GeForce 256 DDR (rev 10) (prog-if 00 [VGA])
	Subsystem: VISIONTEK: Unknown device 000b
	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 11
	Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Memory at e8000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at feaf0000 [disabled] [size=64K]
	Capabilities: [60] Power Management version 1
	Capabilities: [44] AGP version 2.0

My append= line includes "video=riva:1600x1200-16"

fbset -a (initial state at boot time with whacked colors):

mode "1600x1200-60"
     # D: 162.022 MHz, H: 75.010 kHz, V: 60.008 Hz
     geometry 1600 1200 1600 1200 16
     timings 6172 304 64 46 1 192 3
     hsync high
     vsync high
     accel true
     rgba 5/11,6/5,5/0,0/0
endmode

After running "fbset -a 1600x1200-76" (command gives desired state)
I have:

mode "1600x1200-76"
     # D: 197.981 MHz, H: 95.183 kHz, V: 76.146 Hz
     geometry 1600 1200 1600 1200 8
     timings 5051 304 40 42 3 136 5
     accel true
     rgba 8/0,8/0,8/0,0/0
endmode



_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
