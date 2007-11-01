From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] tridentfb: various fixes
Date: Thu, 1 Nov 2007 15:09:26 +0100
Message-ID: <20071101150926.0f775558.krzysztof.h1@poczta.fm>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1InaZU-0001TB-VW for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 01 Nov 2007 06:58:57 -0700
Received: from smtp35.poczta.interia.pl ([80.48.65.35]
	helo=smtp4.poczta.interia.pl)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1InaZT-0002Ca-Ep
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 01 Nov 2007 06:58:56 -0700
Received: from poczta.interia.pl (mi01.poczta.interia.pl [10.217.12.1])
	by smtp4.poczta.interia.pl (INTERIA.PL) with ESMTP id 3A72642EEFA
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu,  1 Nov 2007 14:58:52 +0100 (CET)
Received: from krzysio.net (host-87-99-61-239.lanet.net.pl [87.99.61.239])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.poczta.fm (INTERIA.PL) with ESMTP id 7EF88769BE7
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu,  1 Nov 2007 14:58:53 +0100 (CET)
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

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Few more fixes for the tridentfb driver:
- the set_vclk() function uses mmio region outb() (because mmio is already enabled)
- the memory size of 512KB is correctly calculated
- enable_mmio() in the setpar function is removed as the mmio is already enabled
- mmio is disabled on driver removal

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

diff -urp linux-ref/drivers/video/tridentfb.c linux-2.6.23/drivers/video/tridentfb.c
--- linux-ref/drivers/video/tridentfb.c	2007-11-01 14:07:27.461666762 +0100
+++ linux-2.6.23/drivers/video/tridentfb.c	2007-11-01 15:02:17.622078751 +0100
@@ -702,8 +701,8 @@ static void set_vclk(int freq)
 		write3C4(ClockHigh, hi);
 		write3C4(ClockLow, lo);
 	} else {
-		outb(lo, 0x43C8);
-		outb(hi, 0x43C9);
+		t_outb(lo, 0x43C8);
+		t_outb(hi, 0x43C9);
 	}
 	debug("VCLK = %X %X\n", hi, lo);
 }
@@ -755,7 +754,7 @@ static unsigned int __devinit get_memsiz
 			switch (tmp) {
 
 			case 0x01:
-				k = 512;
+				k = 512 * Kb;
 				break;
 			case 0x02:
 				k = 6 * Mb;	/* XP */
@@ -864,7 +863,6 @@ static int tridentfb_check_var(struct fb
 	debug("exit\n");
 
 	return 0;
-
 }
 
 /* Pan the display */
@@ -912,7 +912,6 @@ static int tridentfb_set_par(struct fb_i
 	vblankstart = var->yres;
 	vblankend = vtotal + 2;
 
-	enable_mmio();
 	crtc_unlock();
 	write3CE(CyberControl, 8);
 
@@ -1348,9 +1347,10 @@ static void __devexit trident_pci_remove
 	struct tridentfb_par *par = (struct tridentfb_par*)fb_info.par;
 	unregister_framebuffer(&fb_info);
 	iounmap(par->io_virt);
+	release_mem_region(tridentfb_fix.mmio_start, tridentfb_fix.mmio_len);
+	disable_mmio();
 	iounmap(fb_info.screen_base);
 	release_mem_region(tridentfb_fix.smem_start, tridentfb_fix.smem_len);
-	release_mem_region(tridentfb_fix.mmio_start, tridentfb_fix.mmio_len);
 }
 
 /* List of boards that we are trying to support */

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
