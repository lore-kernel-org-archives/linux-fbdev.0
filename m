From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Fri, 07 Aug 2015 12:16:03 +0000
Subject: [PATCH 2/5] staging: sm750fb: space around operator
Message-Id: <1438949046-18765-2-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1438949046-18765-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1438949046-18765-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Kernel coding style says to have a space around the operators.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---

This patch will generate checkpatch warning about longline in 2 places,
those were not fixed to keep the readability. Will fix them later.
The warnings were already there, this patch has not introduced them.

 drivers/staging/sm750fb/sm750.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 8990ff4..c16b293 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -144,12 +144,12 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
 		/* get the 16bit color of kernel means */
 		u16 fg, bg;
 
-		fg = ((info->cmap.red[fbcursor->image.fg_color] & 0xf800))|
-		      ((info->cmap.green[fbcursor->image.fg_color] & 0xfc00) >> 5)|
+		fg = ((info->cmap.red[fbcursor->image.fg_color] & 0xf800)) |
+		      ((info->cmap.green[fbcursor->image.fg_color] & 0xfc00) >> 5) |
 		      ((info->cmap.blue[fbcursor->image.fg_color] & 0xf800) >> 11);
 
-		bg = ((info->cmap.red[fbcursor->image.bg_color] & 0xf800))|
-		      ((info->cmap.green[fbcursor->image.bg_color] & 0xfc00) >> 5)|
+		bg = ((info->cmap.red[fbcursor->image.bg_color] & 0xf800)) |
+		      ((info->cmap.green[fbcursor->image.bg_color] & 0xfc00) >> 5) |
 		      ((info->cmap.blue[fbcursor->image.bg_color] & 0xf800) >> 11);
 
 		cursor->setColor(cursor, fg, bg);
@@ -188,8 +188,9 @@ static void lynxfb_ops_fillrect(struct fb_info *info,
 	pitch = info->fix.line_length;
 	Bpp = info->var.bits_per_pixel >> 3;
 
-	color = (Bpp = 1)?region->color:((u32 *)info->pseudo_palette)[region->color];
-	rop = (region->rop != ROP_COPY) ? HW_ROP2_XOR:HW_ROP2_COPY;
+	color = (Bpp = 1) ? region->color :
+		((u32 *)info->pseudo_palette)[region->color];
+	rop = (region->rop != ROP_COPY) ? HW_ROP2_XOR : HW_ROP2_COPY;
 
 	/*
 	 * If not use spin_lock,system will die if user load driver
@@ -278,7 +279,7 @@ _do_work:
 		spin_lock(&share->slock);
 
 	share->accel.de_imageblit(&share->accel,
-				  image->data, image->width>>3, 0,
+				  image->data, image->width >> 3, 0,
 				  base, pitch, Bpp,
 				  image->dx, image->dy,
 				  image->width, image->height,
@@ -684,7 +685,8 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 	output = &par->output;
 	crtc = &par->crtc;
 
-	crtc->vidmem_size = (share->dual)?share->vidmem_size>>1:share->vidmem_size;
+	crtc->vidmem_size = (share->dual) ? share->vidmem_size >> 1 :
+			     share->vidmem_size;
 	/* setup crtc and output member */
 	spec_share->hwCursor = g_hwcursor;
 
@@ -701,10 +703,12 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 	output->proc_setMode = hw_sm750_output_setMode;
 	output->proc_checkMode = hw_sm750_output_checkMode;
 
-	output->proc_setBLANK = (share->revid = SM750LE_REVISION_ID)?hw_sm750le_setBLANK:hw_sm750_setBLANK;
+	output->proc_setBLANK = (share->revid = SM750LE_REVISION_ID) ?
+				 hw_sm750le_setBLANK : hw_sm750_setBLANK;
 	output->clear = hw_sm750_output_clear;
 	/* chip specific phase */
-	share->accel.de_wait = (share->revid = SM750LE_REVISION_ID)?hw_sm750le_deWait : hw_sm750_deWait;
+	share->accel.de_wait = (share->revid = SM750LE_REVISION_ID) ?
+				hw_sm750le_deWait : hw_sm750_deWait;
 	switch (spec_share->state.dataflow) {
 	case sm750_simul_pri:
 		output->paths = sm750_pnc;
@@ -814,7 +818,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 
 	pr_info("crtc->cursor.mmio = %p\n", crtc->cursor.mmio);
 	crtc->cursor.maxH = crtc->cursor.maxW = 64;
-	crtc->cursor.size = crtc->cursor.maxH*crtc->cursor.maxW*2/8;
+	crtc->cursor.size = crtc->cursor.maxH * crtc->cursor.maxW * 2 / 8;
 	crtc->cursor.disable = hw_cursor_disable;
 	crtc->cursor.enable = hw_cursor_enable;
 	crtc->cursor.setColor = hw_cursor_setColor;
@@ -896,13 +900,13 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 
 	/* set info */
 	line_length = PADDING(crtc->line_pad,
-			      (var->xres_virtual * var->bits_per_pixel/8));
+			      (var->xres_virtual * var->bits_per_pixel / 8));
 
 	info->pseudo_palette = &par->pseudo_palette[0];
 	info->screen_base = crtc->vScreen;
 	pr_debug("screen_base vaddr = %p\n", info->screen_base);
 	info->screen_size = line_length * var->yres_virtual;
-	info->flags = FBINFO_FLAG_DEFAULT|0;
+	info->flags = FBINFO_FLAG_DEFAULT | 0;
 
 	/* set info->fix */
 	fix->type = FB_TYPE_PACKED_PIXELS;
-- 
1.9.1

