From: Mikael Eriksson <miffe-miffe@telia.com>
Subject: Re: Mobility M1 refresh code problem 2.4.26?
Date: Thu, 06 May 2004 21:57:25 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <409A98A5.2040809@telia.com>
References: <20040430150627.GB1543@sci.fi> <Pine.LNX.4.44.0404301707110.12865-100000@phoenix.infradead.org> <20040501004059.GD30285@guug.org> <409A91D6.4000508@bitworks.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BLozj-0000MV-1R
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 06 May 2004 12:57:23 -0700
Received: from av1-1-sn4.m-sp.skanova.net ([81.228.10.116])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BLozi-0005zp-Ec
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 06 May 2004 12:57:22 -0700
In-Reply-To: <409A91D6.4000508@bitworks.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: rsmith@bitworks.com
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

Richard Smith wrote:
> I'm trying to get the Mobility M1 atyfb in 2.4.26 to work on Dell 
> Latitude CPx.

I have the same laptop over here, and it works perfectly with 2.4.26.

dmesg:
atyfb: using auxiliary register aperture
atyfb: Mach64 BIOS is located at c0000, mapped at c00c0000.
atyfb: BIOS contains driver information table.
atyfb: colour active matrix monitor detected: Samsung LT141X4-156
         id=2, 1024x768 pixels, 262144 colours (LT mode)
         supports 60 Hz refresh rates, default 60 Hz
         LCD CRTC parameters: 15384 167 127 130 0 17 805 767 769 6
atyfb: 3D RAGE Mobility (PCI) [0x4c4d rev 0x64] 8M SDRAM, 29.498928 MHz 
XTAL, 230 MHz PLL, 83 Mhz MCLK, 125 Mhz XCLK

.config:
CONFIG_FB_ATY=y
# CONFIG_FB_ATY_GX is not set
CONFIG_FB_ATY_CT=y
CONFIG_FB_ATY_GENERIC_LCD=y
# CONFIG_FB_ATY128 is not set

boot-param:
video=atyfb:1024x768-32

> 
> If I boot he laptop with a CRT connected and run X windows everything 
> works.  The x windows log reports its using a refresh rate code of 12
> 
> Compile atyfb without generic LCD support.
> 
> If I load atyfb the screen is almost there but lots of the text is 
> messed up.  Line spacing seems correct but the actual text is 
> unreadable.  Like a clock is off or something
> 
> If I now load the X windows driver (Still using ATI driver and not FB) 
> the same type issues apears on the graphics.  It's almost there but some 
> pixels appear to be mssing or in the wrong spot.
> 
> The X log now is pretty much identical but says that its useing a 
> refresh rate code of 7.  XCLK and reference clocks are the same.
> 
> If I boot under the LCD and run X I get refresh rate of 12
> When I load atyfb the LCD blanks out. But if I "modprobe atyfb;startx"
> I get the same wiggy screen as under an CRT and again a refresh code of
> 7.
> 
> If I enable the Generic LCD support and load atyfb the LCD now displays 
> data but has the same problem as the CRT and againg a refresh rate code 
> of 7 if I run X and similar issues as the CRT setup yet the wiggyness is 
> different.  Still mostly recognizeable though.
> 
> Where does atyfb calculate what it need to to set the refresh rate code 
> and any idea why it might be doing it incorrectly on this laptop?
> 
> Its my understanding that the atyfb tree in 2.4 currently has the best 
> M1 support and not 2.6.x.  If not then can someone point me to where I 
> can find the latest patch for 2.6
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by Sleepycat Software
> Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
> deliver higher performing products faster, at low TCO.
> http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
