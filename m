From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Atyfb: kill assignment warnings on Atari due to __iomem
 changes
Date: Sun, 24 Oct 2004 13:15:52 +0200 (CEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.61.0410241314550.27526@anakin>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CLgLy-0007vl-M5
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 24 Oct 2004 04:16:02 -0700
Received: from nl-ams-slo-l4-01-pip-5.chellonetwork.com ([213.46.243.21] helo=amsfep14-int.chello.nl)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CLgLw-0004hk-Uh
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 24 Oct 2004 04:16:02 -0700
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
To: Antonino Daplas <adaplas@pol.net>, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>


Atyfb: kill assignment warnings on Atari due to __iomem changes

--- linux-2.6.10-rc1/drivers/video/aty/atyfb_base.c.orig	2004-10-23 10:33:27.000000000 +0200
+++ linux-2.6.10-rc1/drivers/video/aty/atyfb_base.c	2004-10-24 12:59:07.000000000 +0200
@@ -2344,9 +2344,9 @@ int __init atyfb_do_init(void)
 		info->screen_base = ioremap(phys_vmembase[m64_num],
 					 		   phys_size[m64_num]);	
 		info->fix.smem_start = (unsigned long)info->screen_base;	/* Fake! */
-		default_par->ati_regbase = (unsigned long)ioremap(phys_guiregbase[m64_num],
-							  0x10000) + 0xFC00ul;
-		info->fix.mmio_start = default_par->ati_regbase; /* Fake! */
+		default_par->ati_regbase = ioremap(phys_guiregbase[m64_num],
+						   0x10000) + 0xFC00ul;
+		info->fix.mmio_start = (unsigned long)default_par->ati_regbase; /* Fake! */
 
 		aty_st_le32(CLOCK_CNTL, 0x12345678, default_par);
 		clock_r = aty_ld_le32(CLOCK_CNTL, default_par);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
