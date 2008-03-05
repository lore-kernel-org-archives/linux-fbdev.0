From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] tridentfb: register should be left in
	non-locked state
Date: Wed, 5 Mar 2008 21:48:49 +0100
Message-ID: <20080305214849.c727a214.krzysztof.h1@poczta.fm>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JX0nh-0006bS-Tk for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 05 Mar 2008 13:05:22 -0800
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JX0nf-0004VE-U8
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 05 Mar 2008 13:05:21 -0800
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
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@linux-foundation.org>
Cc: adaplas@gmail.com

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch removes locking registers after they are unlocked 
during switch to/from MMIO mode. This fixes regression on the
Blade3D (Trident 9880) caused by the previous patch (probe
fixes).

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

This patch was done against 2.6.25-rc3-mm1 tree. The patch fixes regression
in 2.6.24-rc5.

diff -urp linux-mm/drivers/video/tridentfb.c linux-2.6.25/drivers/video/tridentfb.c
--- linux-mm/drivers/video/tridentfb.c	2008-03-05 21:33:53.716934685 +0100
+++ linux-2.6.25/drivers/video/tridentfb.c	2008-03-05 20:49:28.419759843 +0100
@@ -569,44 +566,32 @@ static inline void write3CE(int reg, uns
 
 static void enable_mmio(void)
 {
-	unsigned char tmp;
-
 	/* Goto New Mode */
 	outb(0x0B, 0x3C4);
 	inb(0x3C5);
 
 	/* Unprotect registers */
 	outb(NewMode1, 0x3C4);
-	tmp = inb(0x3C5);
 	outb(0x80, 0x3C5);
 
 	/* Enable MMIO */
 	outb(PCIReg, 0x3D4);
 	outb(inb(0x3D5) | 0x01, 0x3D5);
-
-	t_outb(NewMode1, 0x3C4);
-	t_outb(tmp, 0x3C5);
 }
 
 static void disable_mmio(void)
 {
-	unsigned char tmp;
-
 	/* Goto New Mode */
 	t_outb(0x0B, 0x3C4);
 	t_inb(0x3C5);
 
 	/* Unprotect registers */
 	t_outb(NewMode1, 0x3C4);
-	tmp = t_inb(0x3C5);
 	t_outb(0x80, 0x3C5);
 
 	/* Disable MMIO */
 	t_outb(PCIReg, 0x3D4);
 	t_outb(t_inb(0x3D5) & ~0x01, 0x3D5);
-
-	outb(NewMode1, 0x3C4);
-	outb(tmp, 0x3C5);
 }
 
 #define crtc_unlock()	write3X4(CRTVSyncEnd, read3X4(CRTVSyncEnd) & 0x7F)

----------------------------------------------------------------------
Wojna wampirow trwa - po ktorej jestes stronie?
Zagraj >>> http://link.interia.pl/f1cf4


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
