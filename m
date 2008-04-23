From: Roel Kluin <12o3l@tiscali.nl>
Subject: [PATCH] vga16fb: test virtual screen range before subtraction on
 unsigned
Date: Wed, 23 Apr 2008 19:20:57 +0200
Message-ID: <480F6FF9.9000605@tiscali.nl>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754652AbYDWRVT@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: adaplas@gmail.com, linux-fbdev-devel@lists.sourceforge.net
Cc: lkml <linux-kernel@vger.kernel.org>

dx and dy are u32's, so the test should occur before the subtraction

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---
diff --git a/drivers/video/vga16fb.c b/drivers/video/vga16fb.c
index 9b3c592..9d27517 100644
--- a/drivers/video/vga16fb.c
+++ b/drivers/video/vga16fb.c
@@ -1087,12 +1087,15 @@ static void vga16fb_copyarea(struct fb_info *info, const struct fb_copyarea *are
 	width = x2 - dx;
 	height = y2 - dy;
 
+	if (sx + dx < old_dx || sy + dy < old_dy)
+		return;
+
 	/* update sx1,sy1 */
 	sx += (dx - old_dx);
 	sy += (dy - old_dy);
 
 	/* the source must be completely inside the virtual screen */
-	if (sx < 0 || sy < 0 || (sx + width) > vxres || (sy + height) > vyres)
+	if (sx + width > vxres || sy + height > vyres)
 		return;
 
 	switch (info->fix.type) {
