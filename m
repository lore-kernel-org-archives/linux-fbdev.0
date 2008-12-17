From: "Eric Miao" <eric.y.miao@gmail.com>
Subject: [PATCH 2/3] pxafb: allow pxafb_set_par() to
	start from arbitrary yoffset
Date: Wed, 17 Dec 2008 16:59:00 +0800
Message-ID: <f17812d70812170059j64f7130fi8131c6ad60642ec6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <eric.y.miao@gmail.com>) id 1LCsFF-0005uh-Eq
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 17 Dec 2008 08:59:05 +0000
Received: from rv-out-0708.google.com ([209.85.198.243])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LCsFC-0007Pa-7i for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 17 Dec 2008 08:59:05 +0000
Received: by rv-out-0708.google.com with SMTP id f25so3406918rvb.22
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 17 Dec 2008 00:59:00 -0800 (PST)
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: ARM Linux <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: linux-fbdev-devel@lists.sourceforge.net

Signed-off-by: Eric Miao <eric.miao@marvell.com>
---
 drivers/video/pxafb.c |   22 ++++++++++------------
 1 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index 25bf4b8..d09c804 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -306,8 +306,6 @@ static void pxafb_setmode(struct fb_var_screeninfo *var,
 	var->lower_margin	= mode->lower_margin;
 	var->sync		= mode->sync;
 	var->grayscale		= mode->cmap_greyscale;
-	var->xres_virtual 	= var->xres;
-	var->yres_virtual	= var->yres;
 }

 /*
@@ -345,10 +343,9 @@ static int pxafb_check_var(struct
fb_var_screeninfo *var, struct fb_info *info)
 			return -EINVAL;
 	}

-	var->xres_virtual =
-		max(var->xres_virtual, var->xres);
-	var->yres_virtual =
-		max(var->yres_virtual, var->yres);
+	var->xres_virtual = var->xres;
+	var->yres_virtual = fbi->fb.fix.smem_len /
+				(var->xres * var->bits_per_pixel / 8);

 	/*
 	 * Setup the RGB parameters for this display.
@@ -878,7 +875,7 @@ static int pxafb_activate_var(struct fb_var_screeninfo *var,
 			      struct pxafb_info *fbi)
 {
 	u_long flags;
-	size_t nbytes;
+	size_t nbytes, offset;

 #if DEBUG_VAR
 	if (!(fbi->lccr0 & LCCR0_LCDT)) {
@@ -939,17 +936,18 @@ static int pxafb_activate_var(struct
fb_var_screeninfo *var,

 	fbi->reg_lccr3 |= pxafb_bpp_to_lccr3(var);

-	nbytes = var->yres * fbi->fb.fix.line_length;
+	nbytes = fbi->fb.fix.line_length * var->yres;
+	offset = fbi->fb.fix.line_length * var->yoffset;

 	if ((fbi->lccr0 & LCCR0_SDS) == LCCR0_Dual) {
 		nbytes = nbytes / 2;
-		setup_frame_dma(fbi, DMA_LOWER, PAL_NONE, nbytes, nbytes);
+		setup_frame_dma(fbi, DMA_LOWER, PAL_NONE, offset + nbytes, nbytes);
 	}

 	if ((var->bits_per_pixel >= 16) || (fbi->lccr0 & LCCR0_LCDT))
-		setup_frame_dma(fbi, DMA_BASE, PAL_NONE, 0, nbytes);
+		setup_frame_dma(fbi, DMA_BASE, PAL_NONE, offset, nbytes);
 	else
-		setup_frame_dma(fbi, DMA_BASE, PAL_BASE, 0, nbytes);
+		setup_frame_dma(fbi, DMA_BASE, PAL_BASE, offset, nbytes);

 	fbi->reg_lccr4 = lcd_readl(fbi, LCCR4) & ~LCCR4_PAL_FOR_MASK;
 	fbi->reg_lccr4 |= (fbi->lccr4 & LCCR4_PAL_FOR_MASK);
@@ -1362,7 +1360,7 @@ static struct pxafb_info * __devinit
pxafb_init_fbinfo(struct device *dev)
 	fbi->fb.fix.type	= FB_TYPE_PACKED_PIXELS;
 	fbi->fb.fix.type_aux	= 0;
 	fbi->fb.fix.xpanstep	= 0;
-	fbi->fb.fix.ypanstep	= 0;
+	fbi->fb.fix.ypanstep	= 1;
 	fbi->fb.fix.ywrapstep	= 0;
 	fbi->fb.fix.accel	= FB_ACCEL_NONE;

-- 
1.6.0.4

------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
