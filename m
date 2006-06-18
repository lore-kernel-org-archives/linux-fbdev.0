From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] fbdev: Fix logo rotation if width !=
	height
Date: Sun, 18 Jun 2006 23:39:28 +0800
Message-ID: <449573B0.9070607@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fs0Gv-0006At-1Q for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 18 Jun 2006 09:37:13 -0700
Received: from py-out-1112.google.com ([64.233.166.182])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FrzW2-0000XY-0e
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 18 Jun 2006 08:48:46 -0700
Received: by py-out-1112.google.com with SMTP id i49so1055622pye
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 18 Jun 2006 08:48:45 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Logo drawing crashes or produces a corrupt display if the logo width and
height are not equal.  The dimensions are transposed prior to the actual
rotation and the width is used instead of the height in the actual rotation
code. These produce a corrupt image.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/fbmem.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 9527a52..31143af 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -334,11 +334,11 @@ static void fb_rotate_logo_ud(const u8 *
 
 static void fb_rotate_logo_cw(const u8 *in, u8 *out, u32 width, u32 height)
 {
-	int i, j, w = width - 1;
+	int i, j, h = height - 1;
 
 	for (i = 0; i < height; i++)
 		for (j = 0; j < width; j++)
-			out[height * j + w - i] = *in++;
+				out[height * j + h - i] = *in++;
 }
 
 static void fb_rotate_logo_ccw(const u8 *in, u8 *out, u32 width, u32 height)
@@ -356,24 +356,24 @@ static void fb_rotate_logo(struct fb_inf
 	u32 tmp;
 
 	if (rotate == FB_ROTATE_UD) {
-		image->dx = info->var.xres - image->width;
-		image->dy = info->var.yres - image->height;
 		fb_rotate_logo_ud(image->data, dst, image->width,
 				  image->height);
+		image->dx = info->var.xres - image->width;
+		image->dy = info->var.yres - image->height;
 	} else if (rotate == FB_ROTATE_CW) {
-		tmp = image->width;
-		image->width = image->height;
-		image->height = tmp;
-		image->dx = info->var.xres - image->height;
 		fb_rotate_logo_cw(image->data, dst, image->width,
 				  image->height);
-	} else if (rotate == FB_ROTATE_CCW) {
 		tmp = image->width;
 		image->width = image->height;
 		image->height = tmp;
-		image->dy = info->var.yres - image->width;
+		image->dx = info->var.xres - image->width;
+	} else if (rotate == FB_ROTATE_CCW) {
 		fb_rotate_logo_ccw(image->data, dst, image->width,
 				   image->height);
+		tmp = image->width;
+		image->width = image->height;
+		image->height = tmp;
+		image->dy = info->var.yres - image->height;
 	}
 
 	image->data = dst;
