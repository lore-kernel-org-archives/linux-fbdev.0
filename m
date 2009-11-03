From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mb862xxfb: add acceleration support for
 Coral-P/Coral-PA. * imageblt * copyarea * fillrect
Date: Mon, 2 Nov 2009 23:58:08 -0800
Message-ID: <20091102235808.6ccc1bcd.akpm@linux-foundation.org>
References: <1256041745-21128-1-git-send-email-valentin.sitdikov@siemens.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756233AbZKCH7C@vger.kernel.org>
In-Reply-To: <1256041745-21128-1-git-send-email-valentin.sitdikov@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Valentin Sitdikov <valentin.sitdikov@siemens.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Tue, 20 Oct 2009 16:29:05 +0400 Valentin Sitdikov <valentin.sitdikov@siemens.com> wrote:

> 
> ...
>
> +/* Fill in the cmd array /GDC FIFO commands/ to draw a 1bit image.
> + * Make sure cmd has enough room! */

The comment layout is sicky-looking.

> +static void mb86290fb_imageblit(struct fb_info *info,
> +				const struct fb_image *image)
> +{
> +	int mdr;
> +	u32 *cmd = NULL;
> +	void (*cmdfn) (u32 *, u16, u16, u16, u16, u16, u32, u32,
> +		       const struct fb_image *, struct fb_info *) = NULL;
> +	u32 cmdlen;
> +	u32 fgcolor = 0, bgcolor = 0;
> +	u16 step;
> +
> +	u16 width = image->width, height = image->height;
> +	u16 dx = image->dx, dy = image->dy;
> +	int x2, y2, vxres, vyres;
> +
> +	mdr = (GDC_ROP_COPY << 9);
> +	x2 = image->dx + image->width;
> +	y2 = image->dy + image->height;
> +	dx = image->dx > 0 ? image->dx : 0;
> +	dy = image->dy > 0 ? image->dy : 0;

image->dz and image->dy are unsigned, so the above two statements
have no effect.

> +	vxres = info->var.xres_virtual;
> +	vyres = info->var.yres_virtual;
> +	x2 = x2 < vxres ? x2 : vxres;
> +	y2 = y2 < vyres ? y2 : vyres;

We have nice helper macros for this - please don't open code them.


Please review:

--- a/drivers/video/mb862xx/mb862xxfb_accel.c~mb862xxfb-add-acceleration-support-for-coral-p-coral-pa-imageblt-copyarea-fillrect-fix
+++ a/drivers/video/mb862xx/mb862xxfb_accel.c
@@ -66,8 +66,10 @@ static void mb86290fb_copyarea(struct fb
 	mb862xxfb_write_fifo(6, cmd, info);
 }
 
-/* Fill in the cmd array /GDC FIFO commands/ to draw a 1bit image.
- * Make sure cmd has enough room! */
+/*
+ * Fill in the cmd array /GDC FIFO commands/ to draw a 1bit image.
+ * Make sure cmd has enough room!
+ */
 static void mb86290fb_imageblit1(u32 *cmd, u16 step, u16 dx, u16 dy,
 				 u16 width, u16 height, u32 fgcolor,
 				 u32 bgcolor, const struct fb_image *image,
@@ -113,8 +115,10 @@ static void mb86290fb_imageblit1(u32 *cm
 	}
 }
 
-/* Fill in the cmd array /GDC FIFO commands/ to draw a 8bit image.
- * Make sure cmd has enough room! */
+/*
+ * Fill in the cmd array /GDC FIFO commands/ to draw a 8bit image.
+ * Make sure cmd has enough room!
+ */
 static void mb86290fb_imageblit8(u32 *cmd, u16 step, u16 dx, u16 dy,
 				 u16 width, u16 height, u32 fgcolor,
 				 u32 bgcolor, const struct fb_image *image,
@@ -150,8 +154,10 @@ static void mb86290fb_imageblit8(u32 *cm
 	}
 }
 
-/* Fill in the cmd array /GDC FIFO commands/ to draw a 16bit image.
- * Make sure cmd has enough room! */
+/*
+ * Fill in the cmd array /GDC FIFO commands/ to draw a 16bit image.
+ * Make sure cmd has enough room!
+ */
 static void mb86290fb_imageblit16(u32 *cmd, u16 step, u16 dx, u16 dy,
 				  u16 width, u16 height, u32 fgcolor,
 				  u32 bgcolor, const struct fb_image *image,
@@ -195,12 +201,10 @@ static void mb86290fb_imageblit(struct f
 	mdr = (GDC_ROP_COPY << 9);
 	x2 = image->dx + image->width;
 	y2 = image->dy + image->height;
-	dx = image->dx > 0 ? image->dx : 0;
-	dy = image->dy > 0 ? image->dy : 0;
 	vxres = info->var.xres_virtual;
 	vyres = info->var.yres_virtual;
-	x2 = x2 < vxres ? x2 : vxres;
-	y2 = y2 < vyres ? y2 : vyres;
+	x2 = min(x2, vxres);
+	y2 = min(y2, vyres);
 	width = x2 - dx;
 	height = y2 - dy;
 
@@ -265,8 +269,8 @@ static void mb86290fb_fillrect(struct fb
 	 * hardware clipping by writing to framebuffer directly. */
 	x2 = rect->dx + rect->width;
 	y2 = rect->dy + rect->height;
-	x2 = x2 < vxres ? x2 : vxres;
-	y2 = y2 < vyres ? y2 : vyres;
+	x2 = min(x2, vxres);
+	y2 = min(y2, vyres);
 	width = x2 - rect->dx;
 	height = y2 - rect->dy;
 	if (info->fix.visual == FB_VISUAL_TRUECOLOR ||
diff -puN drivers/video/mb862xx/mb862xxfb_accel.h~mb862xxfb-add-acceleration-support-for-coral-p-coral-pa-imageblt-copyarea-fillrect-fix drivers/video/mb862xx/mb862xxfb_accel.h
_
