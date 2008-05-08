From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] tridentfb: use mmio access for clock
	setting
Date: Thu, 8 May 2008 22:28:42 +0200
Message-ID: <20080508222842.667e5eed.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JuCk0-0006sx-3L for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 May 2008 13:29:24 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JuCjj-0005mp-SB
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 May 2008 13:29:13 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: akpm@linux-foundation.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Use the mmio outb function instead of direct one. 
The mmio registers are already mapped (in the probe function).

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

diff -urp linux-old/drivers/video/tridentfb.c linux-pc/drivers/video/tridentfb.c
--- linux-old/drivers/video/tridentfb.c	2008-05-03 08:11:52.000000000 +0200
+++ linux-pc/drivers/video/tridentfb.c	2008-05-03 08:10:52.000000000 +0200
@@ -680,8 +680,8 @@ static void set_vclk(struct tridentfb_pa
 		vga_mm_wseq(par->io_virt, ClockHigh, hi);
 		vga_mm_wseq(par->io_virt, ClockLow, lo);
 	} else {
-		outb(lo, 0x43C8);
-		outb(hi, 0x43C9);
+		t_outb(par, lo, 0x43C8);
+		t_outb(par, hi, 0x43C9);
 	}
 	debug("VCLK = %X %X\n", hi, lo);
 }

----------------------------------------------------------------------
Poprowadz swoj klub do zwyciestwa!
Sprawdz >>> http://link.interia.pl/f1d76


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
