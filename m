From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: atyfb expert needed
Date: Tue, 17 Feb 2004 17:41:12 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1077000071.1056.171.camel@gaston>
References: <1076537453.868.123.camel@gaston>
	 <200402131641.29028.alex.kern@gmx.de> <1076714453.7304.103.camel@gaston>
	 <200402141626.39311.alex.kern@gmx.de>  <1076997609.1046.168.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Asz0B-0005z4-QZ
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 16 Feb 2004 22:46:39 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1AsyqF-00006I-MH
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 16 Feb 2004 22:36:23 -0800
In-Reply-To: <1076997609.1046.168.camel@gaston>
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
To: Alexander Kern <alex.kern@gmx.de>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, James Simmons <jsimmons@infradead.org>

Ok, that patch makes it back working for me based on the version
in James fbdev tree.

I don't know _WHY_, but I couldn't get it to not lockup without
adding the to wait_for_idle after the fillrect & copyarea.

James, please apply.

Ben.

===== drivers/video/aty/mach64_accel.c 1.12 vs edited =====
--- 1.12/drivers/video/aty/mach64_accel.c	Mon Feb  9 18:10:12 2004
+++ edited/drivers/video/aty/mach64_accel.c	Tue Feb 17 17:38:29 2004
@@ -186,7 +186,7 @@
 	wait_for_fifo(2, par);
 	aty_st_le32(DST_Y_X, (x << 16) | y, par);
 	aty_st_le32(DST_HEIGHT_WIDTH, (width << 16) | height, par);
-	par->blitter_may_be_busy = 1;
+       	par->blitter_may_be_busy = 1;
 }
 
 void atyfb_copyarea(struct fb_info *info, const struct fb_copyarea *area)
@@ -236,6 +236,8 @@
 	aty_st_le32(SRC_HEIGHT1_WIDTH1, (width << 16) | area->height, par);
 	aty_st_le32(DST_CNTL, direction | rotation, par);
 	draw_rect(dx, dy, width, area->height, par);
+
+	wait_for_idle(par);
 }
 
 void atyfb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
@@ -274,6 +276,8 @@
 		    DST_LAST_PEL | DST_Y_TOP_TO_BOTTOM |
 		    DST_X_LEFT_TO_RIGHT | rotation, par);
 	draw_rect(dx, rect->dy, width, rect->height, par);
+
+	wait_for_idle(par);
 }
 
 void atyfb_imageblit(struct fb_info *info, const struct fb_image *image)
@@ -419,9 +423,9 @@
 		}
 	} else {
 		u32 *pbitmap;
-		for(pbitmap = (u32*)(image->data); dwords; dwords--, pbitmap++) {
+		for (pbitmap = (u32*)(image->data); dwords; dwords--, pbitmap++) {
 			wait_for_fifo(1, par);
-			aty_st_le32(HOST_DATA0, *pbitmap, par);
+			aty_st_le32(HOST_DATA0, le32_to_cpup(pbitmap), par);
 		}
 	}
 
@@ -430,4 +434,6 @@
 	/* restore pix_width */
 	wait_for_fifo(1, par);
 	aty_st_le32(DP_PIX_WIDTH, pix_width_save, par);
+
+	wait_for_idle(par);
 }
===== drivers/video/aty/atyfb_base.c 1.39 vs edited =====
--- 1.39/drivers/video/aty/atyfb_base.c	Mon Feb  9 18:10:12 2004
+++ edited/drivers/video/aty/atyfb_base.c	Tue Feb 17 15:21:05 2004
@@ -343,7 +343,7 @@
 
 	/* Mach64 LT */
 	{ 0x4c54, 0x4c54, 0x00, 0x00, m64n_lt, 135, 63, 63, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP },
-	{ 0x4c47, 0x4c47, 0x00, 0x00, m64n_ltg, 230, 63, 63, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT | M64F_LT_SLEEP | M64F_G3_PB_1024x768 },
+	{ 0x4c47, 0x4c47, 0x00, 0x00, m64n_ltg, 230, 63, 63, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL | M64F_FIFO_24 | M64F_EXTRA_BRIGHT | M64F_LT_SLEEP | M64F_G3_PB_1024x768 },
 
 	/* Mach64 GTC (3D RAGE PRO) */
 	{ 0x4742, 0x4742, 0x00, 0x00, m64n_gtc_ba, 230, 100, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
