From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] fbdev: Batch cmap changes at driver level
Date: Mon, 11 Apr 2005 09:19:25 +1000
Message-ID: <1113175165.9568.516.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DKlkW-00086l-Mv
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 10 Apr 2005 16:21:52 -0700
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DKlkD-00059C-BK
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 10 Apr 2005 16:21:52 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, "Antonino A. Daplas" <adaplas@hotpop.com>
Cc: Andrew Morton <akpm@osdl.org>

Hi ! Andrew, if Tony ack's it, please push that upstream.

This patch adds to the fbdev interface a set_cmap callback that allow
the driver to "batch" palette changes. This is useful for drivers like
radeonfb which might require lenghtly workarounds on palette accesses,
thus allowing to factor out those workarounds efficiently.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/include/linux/fb.h
===================================================================
--- linux-work.orig/include/linux/fb.h	2005-04-01 09:04:19.000000000 +1000
+++ linux-work/include/linux/fb.h	2005-04-08 10:24:56.000000000 +1000
@@ -563,6 +563,9 @@
 	int (*fb_setcolreg)(unsigned regno, unsigned red, unsigned green,
 			    unsigned blue, unsigned transp, struct fb_info *info);
 
+	/* set color registers in batch */
+	int (*fb_setcmap)(struct fb_cmap *cmap, struct fb_info *info);
+
 	/* blank display */
 	int (*fb_blank)(int blank, struct fb_info *info);
 
Index: linux-work/drivers/video/aty/radeon_base.c
===================================================================
--- linux-work.orig/drivers/video/aty/radeon_base.c	2005-04-01 09:04:18.000000000 +1000
+++ linux-work/drivers/video/aty/radeon_base.c	2005-04-08 11:15:13.000000000 +1000
@@ -1057,13 +1057,14 @@
 	return radeon_screen_blank(rinfo, blank, 0);
 }
 
-static int radeonfb_setcolreg (unsigned regno, unsigned red, unsigned green,
-                             unsigned blue, unsigned transp, struct fb_info *info)
+static int radeon_setcolreg (unsigned regno, unsigned red, unsigned green,
+                             unsigned blue, unsigned transp,
+			     struct radeonfb_info *rinfo)
 {
-        struct radeonfb_info *rinfo = info->par;
 	u32 pindex;
 	unsigned int i;
-	
+
+
 	if (regno > 255)
 		return 1;
 
@@ -1078,20 +1079,7 @@
         pindex = regno;
 
         if (!rinfo->asleep) {
-        	u32 dac_cntl2, vclk_cntl = 0;
-        	
 		radeon_fifo_wait(9);
-		if (rinfo->is_mobility) {
-			vclk_cntl = INPLL(VCLK_ECP_CNTL);
-			OUTPLL(VCLK_ECP_CNTL, vclk_cntl & ~PIXCLK_DAC_ALWAYS_ONb);
-		}
-
-		/* Make sure we are on first palette */
-		if (rinfo->has_CRTC2) {
-			dac_cntl2 = INREG(DAC_CNTL2);
-			dac_cntl2 &= ~DAC2_PALETTE_ACCESS_CNTL;
-			OUTREG(DAC_CNTL2, dac_cntl2);
-		}
 
 		if (rinfo->bpp == 16) {
 			pindex = regno * 8;
@@ -1101,24 +1089,27 @@
 			if (rinfo->depth == 15 && regno > 31)
 				return 1;
 
-			/* For 565, the green component is mixed one order below */
+			/* For 565, the green component is mixed one order
+			 * below
+			 */
 			if (rinfo->depth == 16) {
 		                OUTREG(PALETTE_INDEX, pindex>>1);
-	       	         	OUTREG(PALETTE_DATA, (rinfo->palette[regno>>1].red << 16) |
-	                        	(green << 8) | (rinfo->palette[regno>>1].blue));
+	       	         	OUTREG(PALETTE_DATA,
+				       (rinfo->palette[regno>>1].red << 16) |
+	                        	(green << 8) |
+				       (rinfo->palette[regno>>1].blue));
 	                	green = rinfo->palette[regno<<1].green;
 	        	}
 		}
 
 		if (rinfo->depth != 16 || regno < 32) {
 			OUTREG(PALETTE_INDEX, pindex);
-			OUTREG(PALETTE_DATA, (red << 16) | (green << 8) | blue);
+			OUTREG(PALETTE_DATA, (red << 16) |
+			       (green << 8) | blue);
 		}
-		if (rinfo->is_mobility)
-			OUTPLL(VCLK_ECP_CNTL, vclk_cntl);
 	}
  	if (regno < 16) {
-		u32 *pal = info->pseudo_palette;
+		u32 *pal = rinfo->info->pseudo_palette;
         	switch (rinfo->depth) {
 		case 15:
 			pal[regno] = (regno << 10) | (regno << 5) | regno;
@@ -1138,6 +1129,84 @@
 	return 0;
 }
 
+static int radeonfb_setcolreg (unsigned regno, unsigned red, unsigned green,
+			       unsigned blue, unsigned transp,
+			       struct fb_info *info)
+{
+        struct radeonfb_info *rinfo = info->par;
+	u32 dac_cntl2, vclk_cntl = 0;
+	int rc;
+
+        if (!rinfo->asleep) {
+		if (rinfo->is_mobility) {
+			vclk_cntl = INPLL(VCLK_ECP_CNTL);
+			OUTPLL(VCLK_ECP_CNTL,
+			       vclk_cntl & ~PIXCLK_DAC_ALWAYS_ONb);
+		}
+
+		/* Make sure we are on first palette */
+		if (rinfo->has_CRTC2) {
+			dac_cntl2 = INREG(DAC_CNTL2);
+			dac_cntl2 &= ~DAC2_PALETTE_ACCESS_CNTL;
+			OUTREG(DAC_CNTL2, dac_cntl2);
+		}
+	}
+
+	rc = radeon_setcolreg (regno, red, green, blue, transp, rinfo);
+	
+	if (!rinfo->asleep && rinfo->is_mobility)
+		OUTPLL(VCLK_ECP_CNTL, vclk_cntl);
+
+	return rc;
+}
+
+static int radeonfb_setcmap(struct fb_cmap *cmap, struct fb_info *info)
+{
+        struct radeonfb_info *rinfo = info->par;
+	u16 *red, *green, *blue, *transp;
+	u32 dac_cntl2, vclk_cntl = 0;
+	int i, start, rc = 0;
+
+        if (!rinfo->asleep) {
+		if (rinfo->is_mobility) {
+			vclk_cntl = INPLL(VCLK_ECP_CNTL);
+			OUTPLL(VCLK_ECP_CNTL,
+			       vclk_cntl & ~PIXCLK_DAC_ALWAYS_ONb);
+		}
+
+		/* Make sure we are on first palette */
+		if (rinfo->has_CRTC2) {
+			dac_cntl2 = INREG(DAC_CNTL2);
+			dac_cntl2 &= ~DAC2_PALETTE_ACCESS_CNTL;
+			OUTREG(DAC_CNTL2, dac_cntl2);
+		}
+	}
+
+	red = cmap->red;
+	green = cmap->green;
+	blue = cmap->blue;
+	transp = cmap->transp;
+	start = cmap->start;
+
+	for (i = 0; i < cmap->len; i++) {
+		u_int hred, hgreen, hblue, htransp = 0xffff;
+
+		hred = *red++;
+		hgreen = *green++;
+		hblue = *blue++;
+		if (transp)
+			htransp = *transp++;
+		rc = radeon_setcolreg (start++, hred, hgreen, hblue, htransp,
+				       rinfo);
+		if (rc)
+			break;
+	}
+	
+	if (!rinfo->asleep && rinfo->is_mobility)
+		OUTPLL(VCLK_ECP_CNTL, vclk_cntl);
+
+	return rc;
+}
 
 static void radeon_save_state (struct radeonfb_info *rinfo,
 			       struct radeon_regs *save)
@@ -1796,6 +1865,7 @@
 	.fb_check_var		= radeonfb_check_var,
 	.fb_set_par		= radeonfb_set_par,
 	.fb_setcolreg		= radeonfb_setcolreg,
+	.fb_setcmap		= radeonfb_setcmap,
 	.fb_pan_display 	= radeonfb_pan_display,
 	.fb_blank		= radeonfb_blank,
 	.fb_ioctl		= radeonfb_ioctl,
Index: linux-work/drivers/video/fbcmap.c
===================================================================
--- linux-work.orig/drivers/video/fbcmap.c	2005-03-15 11:58:33.000000000 +1100
+++ linux-work/drivers/video/fbcmap.c	2005-04-08 11:14:51.000000000 +1000
@@ -222,8 +222,11 @@
 	transp = cmap->transp;
 	start = cmap->start;
 
-	if (start < 0 || !info->fbops->fb_setcolreg)
+	if (start < 0 || (!info->fbops->fb_setcolreg &&
+			  !info->fbops->fb_setcmap))
 		return -EINVAL;
+	if (info->fbops->fb_setcmap)
+		return info->fbops->fb_setcmap(cmap, info);
 	for (i = 0; i < cmap->len; i++) {
 		hred = *red++;
 		hgreen = *green++;
@@ -243,15 +246,40 @@
 	int i, start;
 	u16 __user *red, *green, *blue, *transp;
 	u_int hred, hgreen, hblue, htransp = 0xffff;
-
+	
 	red = cmap->red;
 	green = cmap->green;
 	blue = cmap->blue;
 	transp = cmap->transp;
 	start = cmap->start;
 
-	if (start < 0 || !info->fbops->fb_setcolreg)
+	if (start < 0 || (!info->fbops->fb_setcolreg &&
+			  !info->fbops->fb_setcmap))
 		return -EINVAL;
+	
+	/* If we can batch, do it */
+	if (info->fbops->fb_setcmap && cmap->len > 1) {
+		struct fb_cmap umap;
+		int size = cmap->len * sizeof(u16);
+		int rc;
+
+		memset(&umap, 0, sizeof(struct fb_cmap));
+		rc = fb_alloc_cmap(&umap, cmap->len, transp != NULL);
+		if (rc)
+			return rc;
+		if (copy_from_user(umap.red, red, size) ||
+		    copy_from_user(umap.green, green, size) ||
+		    copy_from_user(umap.blue, blue, size) ||
+		    (transp && copy_from_user(umap.transp, transp, size))) {
+			rc = -EFAULT;
+		}
+		umap.start = start;
+		if (rc == 0)
+			rc = info->fbops->fb_setcmap(&umap, info);
+		fb_dealloc_cmap(&umap);
+		return rc;
+	}
+
 	for (i = 0; i < cmap->len; i++, red++, blue++, green++) {
 		if (get_user(hred, red) ||
 		    get_user(hgreen, green) ||




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
