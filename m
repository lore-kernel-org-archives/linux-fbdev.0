From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Sun Blade 100 with 2 pgx64 (ATi Mach64 ?) framebuffers (fwd)
Date: Tue, 11 May 2004 16:20:37 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0405111620100.27719@waterleaf.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BNY7e-0004np-6O
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 11 May 2004 07:20:42 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BNY7d-0003bo-MC
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 11 May 2004 07:20:41 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: Admar Schoonen <admar@luon.net>

---------- Forwarded message ----------
Date: Tue, 11 May 2004 16:11:30 +0200
From: Admar Schoonen <admar@luon.net>
To: geert@linux-m68k.org
Subject: Sun Blade 100 with 2 pgx64 (ATi Mach64 ?) framebuffers

Dear Geert Uytterhoeven,

I have a Sun Blade 100 ultra sparc with 2 pgx64 framebuffers, one on
board and one pci. The machine is running an up to date Debian GNU/Linux
unstable. With linux 2.4.24, both cards work fine (I can move consoles
around with con2fbmap and XFree86 sees 2 cards and starts an X server on
both screens (I haven't tried xinerama though)).

With 2.6.6, this doesn't work anymore. dmesg output seems good:
$ dmesg |grep -i aty
atyfb: 3D RAGE (XL) [0x4752 rev 0x27] 8M SDRAM, 29.498928 MHz XTAL, 230
MHz PLL, 100 Mhz MCLK
fb0: ATY Mach64 frame buffer device on PCI
atyfb: 3D RAGE (XL) [0x4752 rev 0x27] 8M SGRAM, 29.498928 MHz XTAL, 230
MHz PLL, 100 Mhz MCLK

but the second head stays black if I try to move consoles. Also, XFree86
only sees my onboard card.

I don't know how I should debug this issue, but I hope you can give me
some clues.

Best regards

Admar Schoonen
---------- Forwarded message ----------
Date: Tue, 11 May 2004 16:18:51 +0200
From: Admar Schoonen <admar@luon.net>
To: geert@linux-m68k.org
Subject: Sun Blade 100 with 2 pgx64 (ATi Mach64 ?) framebuffers

Hi Geert Uytterhoeven,

Sorry, but I forgot to add that I had to apply a small patch to 2.6 to
make it recognize the on board pgx64 in first place. The patch is a one
liner to get around the fact that XFree86 not knowing the new 2.6 pci
device naming scheme, and I don't think it is causing the problem I have
with 2 pgx64 framebuffers.

The patch is at
http://lists.debian.org/debian-sparc/2004/02/msg00013.html

Best regards

Admar


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
