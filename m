From: Roel Kluin <12o3l@tiscali.nl>
Subject: [PATCH] atafb: test virtual screen range before subtraction on unsigned
Date: Wed, 23 Apr 2008 20:51:14 +0200
Message-ID: <480F8522.4090805@tiscali.nl>
References: <480F6FF9.9000605@tiscali.nl>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756294AbYDWSv1@vger.kernel.org>
In-Reply-To: <480F6FF9.9000605@tiscali.nl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: adaplas@gmail.com, linux-fbdev-devel@lists.sourceforge.net
Cc: lkml <linux-kernel@vger.kernel.org>

a bit similar to vga16fb,
---
dx and dy are u32's, so the test should occur before the subtraction

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---
diff --git a/drivers/video/atafb.c b/drivers/video/atafb.c
index 5d4fbaa..8f60a8f 100644
--- a/drivers/video/atafb.c
+++ b/drivers/video/atafb.c
@@ -2593,13 +2593,16 @@ static void atafb_copyarea(struct fb_info *info, const struct fb_copyarea *area)
 	width = x2 - dx;
 	height = y2 - dy;
 
+	if (area->sx + dx < area->dx || area->sy + dy < area->dy)
+		return;
+
 	/* update sx,sy */
 	sx = area->sx + (dx - area->dx);
 	sy = area->sy + (dy - area->dy);
 
 	/* the source must be completely inside the virtual screen */
-	if (sx < 0 || sy < 0 || (sx + width) > info->var.xres_virtual ||
-	    (sy + height) > info->var.yres_virtual)
+	if (sx + width > info->var.xres_virtual ||
+			sy + height > info->var.yres_virtual)
 		return;
 
 	if (dy > sy || (dy == sy && dx > sx)) {
