From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 11/15] fbdev: Add __iomem annotations to hgafb
Date: Fri, 29 Oct 2004 09:58:49 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410290958.49211.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CNM5T-0006ha-Hk
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Oct 2004 19:01:55 -0700
Received: from smtp-out.hotpop.com ([38.113.3.51])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CNM5T-0000aN-0d
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Oct 2004 19:01:55 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 61EC672A2E
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 29 Oct 2004 01:59:17 +0000 (UTC)
Content-Disposition: inline
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Ferenc Bakonyi <fero@drama.obuda.kando.hu>

Add __iomem annotations to hgafb

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 hgafb.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff -Nru a/drivers/video/hgafb.c b/drivers/video/hgafb.c
--- a/drivers/video/hgafb.c	2004-10-27 14:58:07 +08:00
+++ b/drivers/video/hgafb.c	2004-10-28 23:24:53 +08:00
@@ -66,9 +66,9 @@
 #define HGA_TXT			0
 #define HGA_GFX			1
 
-static inline u8* rowaddr(struct fb_info *info, u_int row)
+static inline u8 __iomem * rowaddr(struct fb_info *info, u_int row)
 {
-        return info->screen_base + HGA_ROWADDR(row);
+	return (u8 __iomem *) (fb_readl(info->screen_base + HGA_ROWADDR(row)));
 }
 
 static int hga_mode = -1;			/* 0 = txt, 1 = gfx mode */
@@ -455,7 +455,7 @@
 static void hgafb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
 {
 	u_int rows, y;
-	u8 *dest;
+	u8 __iomem *dest;
 
 	y = rect->dy;
 
@@ -466,7 +466,7 @@
 			//fb_memset(dest, rect->color, (rect->width >> 3));
 			break;
 		case ROP_XOR:
-			*dest = ~*dest;
+			fb_writeb(~(fb_readb(dest)), dest);
 			break;
 		}
 	}
@@ -475,7 +475,8 @@
 static void hgafb_copyarea(struct fb_info *info, const struct fb_copyarea *area)
 {
 	u_int rows, y1, y2;
-	u8 *src, *dest;
+	u8 __iomem *src;
+	u8 __iomem *dest;
 
 	if (area->dy <= area->sy) {
 		y1 = area->sy;
@@ -504,14 +505,15 @@
 
 static void hgafb_imageblit(struct fb_info *info, const struct fb_image *image)
 {
-	u8 *dest, *cdat = (u8 *) image->data;
+	u8 __iomem *dest;
+	u8 *cdat = (u8 *) image->data;
 	u_int rows, y = image->dy;
 	u8 d;
 
 	for (rows = image->height; rows--; y++) {
 		d = *cdat++;
 		dest = rowaddr(info, y) + (image->dx >> 3);
-		*dest = d;
+		fb_writeb(d, dest);
 	}
 }
 #else /* !CONFIG_FB_HGA_ACCEL */
@@ -570,7 +572,7 @@
 	fb_info.monspecs.vfmax = 10000;
 	fb_info.monspecs.dpms = 0;
 	fb_info.fbops = &hgafb_ops;
-	fb_info.screen_base = (char *)hga_fix.smem_start;
+	fb_info.screen_base = (char __iomem *)hga_fix.smem_start;
 
         if (register_framebuffer(&fb_info) < 0)
                 return -EINVAL;





-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
