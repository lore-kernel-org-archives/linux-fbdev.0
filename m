From: Andrew Morton <akpm@osdl.org>
Subject: Fw: radeonfb driver doesn't properly configure DVI monitor
 (2.6.8.1)
Date: Wed, 18 Aug 2004 11:51:01 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040818115101.3f3d8c24.akpm@osdl.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BxVYA-000095-2n
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 18 Aug 2004 11:52:42 -0700
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BxVY8-0007qi-AK
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 18 Aug 2004 11:52:42 -0700
Received: from bix (build.pdx.osdl.net [172.20.1.2])
	by mail.osdl.org (8.11.6/8.11.6) with SMTP id i7IIqc108299
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 18 Aug 2004 11:52:38 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net



Begin forwarded message:

Date: Wed, 18 Aug 2004 00:41:21 -0400
From: Clem Taylor <clemtaylor@comcast.net>
To: linux-kernel@vger.kernel.org
Subject: radeonfb driver doesn't properly configure DVI monitor (2.6.8.1)


I have an older Radeon 8500 LE on my dual Opteron box. The radeonfb 
driver doesn't properly configure the DVI monitor output on startup. The 
analog output looks okay, but the DVI output is covered with redish 
noise that gets progressively worse as the system runs. It looks like 
some PLL or DLL is not being configured correctly. The monitor reports 
the correct resolution and refresh rate, so at least hsync/vsync timing 
is correct. The right edge of the image contains a fixed pattern that 
moves with screen scroll. Also, the last 5-10 lines of the analog output 
contains a series of random colored characters. It looks like the text 
buffer isn't being fully cleared (the LCD panel I'm using is 1920x1200).

X (xorg) properly configures the DVI, but when I switch back to the 
console, the output looks less broken but still contains a fairly strong 
RGB noise pattern.

On boot the radeonfb driver reports:
radeonfb: Invalid ROM signature 0 should be 0xaa55
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=275.00 Mhz, 
System=275.00 MHz
radeonfb: Monitor 1 type DFP found
radeonfb: EDID probed
radeonfb: Monitor 2 type CRT found
radeonfb: EDID probed
radeonfb: ATI Radeon QL  DDR SGRAM 64 MB

Another curious point is that the DVI output doesn't work at all from 
the BIOS, which means I have to switch to the analog output to boot. I 
updated the firmware on the graphics card, but that made things worse, 
the noise problem showed up in the BIOS and starting X didn't fix the 
noise (so I reverted to the previous version). ATIs response to this was 
that it was a BIOS problem and then that the card was old.

Has anyone else seen similar problems? I haven't tried compiling with 
CONFIG_FB_RADEON_DEBUG, but I think that should be the next thing.

                  --Clem
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
