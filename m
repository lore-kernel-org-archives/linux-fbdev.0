From: Thomas Jahns <Thomas.Jahns@epost.de>
Subject: Re: New fbdev patch.
Date: Fri, 2 Jul 2004 13:01:48 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040702110148.GE21418@mercury.jahnsnet.de>
References: <Pine.LNX.4.56.0406231859390.27210@pentafluge.infradead.org> <40DC328C.9010707@bitworks.com> <20040629214850.GC2871@mercury.jahnsnet.de> <40E1ECCD.7080501@bitworks.com> <Pine.LNX.4.56.0406301753470.29465@pentafluge.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BgLpF-0004Kx-OY
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 02 Jul 2004 04:03:25 -0700
Received: from mail.epost.de ([193.28.100.151])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BgLpF-0002Gd-9S
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 02 Jul 2004 04:03:25 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0406301753470.29465@pentafluge.infradead.org> (from jsimmons@pentafluge.infradead.org on Wed, Jun 30, 2004 at 18:57:28 +0200)
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; format="Flowed"; delsp="Yes"; charset="us-ascii"
To: jsimmons@pentafluge.infradead.org
Cc: Richard Smith <rsmith@bitworks.com>, Thomas.Jahns@epost.de, fbdev <linux-fbdev-devel@lists.sourceforge.net>

Hi,

On 06/30/04 18:57:28, jsimmons@pentafluge.infradead.org wrote:
> The correct patch is here.
> 
> http://www.infradead.org/~jsimmons/changes.diff.gz

that does apply cleanly, but won't compile (see below). Is it perhaps
possible to access your kernel source tree so I can search for the
header in need of patching myself? Should set_palette(vc) have read
fbcon_set_palette(vc, color_table)?

/usr/bin/make -j2 EXTRAVERSION=-tungsten  ARCH=ppc \
                    CROSS_COMPILE=powerpc-linux- zImage
make[1]: Entering directory `/home/tjahns/tmp/debian_stuff/kernel-
compile/2.6.7/linux-2.6.7'
make[2]: `arch/ppc/kernel/asm-offsets.s' is up to date.
  CHK     include/asm-ppc/offsets.h
  CHK     include/linux/compile.h
  CC      drivers/video/console/fbcon.o
drivers/video/console/fbcon.c: In function `fbcon_init':
drivers/video/console/fbcon.c:640: error: `SCROLL_ACCEL' undeclared
(first use in this function)
drivers/video/console/fbcon.c:640: error: (Each undeclared identifier
is reported only once
drivers/video/console/fbcon.c:640: error: for each function it appears
in.)
drivers/video/console/fbcon.c:642: error: `SCROLL_REDRAW' undeclared
(first use in this function)
drivers/video/console/fbcon.c: In function `fbcon_scroll':
drivers/video/console/fbcon.c:1274: error: `SCROLL_ACCEL' undeclared
(first use in this function)
drivers/video/console/fbcon.c:1281: error: `SCROLL_WRAP' undeclared
(first use in this function)
drivers/video/console/fbcon.c:1299: error: `SCROLL_PAN' undeclared
(first use in this function)
drivers/video/console/fbcon.c:1322: error: `SCROLL_REDRAW' undeclared
(first use in this function)
drivers/video/console/fbcon.c: In function `updatescrollmode':
drivers/video/console/fbcon.c:1483: error: `SCROLL_WRAP' undeclared
(first use in this function)
drivers/video/console/fbcon.c:1483: error: `SCROLL_PAN' undeclared
(first use in this function)
drivers/video/console/fbcon.c:1485: error: `SCROLL_REDRAW' undeclared
(first use in this function)
drivers/video/console/fbcon.c:1488: error: `SCROLL_ACCEL' undeclared
(first use in this function)
drivers/video/console/fbcon.c: In function `fbcon_switch':
drivers/video/console/fbcon.c:1568: error: `SCROLL_WRAP' undeclared
(first use in this function)
drivers/video/console/fbcon.c:1571: error: `SCROLL_PAN' undeclared
(first use in this function)
drivers/video/console/fbcon.c: In function `fbcon_scrolldelta':
drivers/video/console/fbcon.c:2145: error: `SCROLL_WRAP' undeclared
(first use in this function)
drivers/video/console/fbcon.c:2148: error: `SCROLL_PAN' undeclared
(first use in this function)
drivers/video/console/fbcon.c: In function `fbcon_modechanged':
drivers/video/console/fbcon.c:2200: error: `SCROLL_WRAP' undeclared
(first use in this function)
drivers/video/console/fbcon.c:2203: error: `SCROLL_PAN' undeclared
(first use in this function)
drivers/video/console/fbcon.c:2215: warning: passing arg 1 of
`set_palette' makes integer from pointer without a cast
make[4]: *** [drivers/video/console/fbcon.o] Error 1
make[3]: *** [drivers/video/console] Error 2
make[2]: *** [drivers/video] Error 2
make[1]: *** [drivers] Error 2
make[1]: Leaving directory `/home/tjahns/tmp/debian_stuff/kernel-
compile/2.6.7/linux-2.6.7'
make: *** [stamp-build] Error 2


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
