From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: fbmem: is bootup logo broken for monochrome LCD ?
Date: Thu, 09 Nov 2006 17:49:12 +0100
Message-ID: <45535C08.5020607@innova-card.com>
Reply-To: Franck <vagabon.xyz@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1424109AbWKIQse@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net

I'm trying to display the bootup logo on a monochrome LCD (1 bit per
pixel). I had to hack fbmem.c in a couple of place to make it
works. I'm wondering now if these changes are correct since I'm not
familiar with this code. Could anybody take a look and tell me ?

Thanks
		Franck

-- >8 --

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 17961e3..8c9d51f 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -247,6 +247,7 @@ static void fb_set_logo(struct fb_info *
 			       const struct linux_logo *logo, u8 *dst,
 			       int depth)
 {
+	u32 bpp = info->var.bits_per_pixel;
 	int i, j, k;
 	const u8 *src = logo->data;
 	u8 xor = (info->fix.visual == FB_VISUAL_MONO01) ? 0xff : 0;
@@ -275,9 +276,14 @@ static void fb_set_logo(struct fb_info *
 		for (i = 0; i < logo->height; i++) {
 			for (j = 0; j < logo->width; src++) {
 				d = *src ^ xor;
-				for (k = 7; k >= 0; k--) {
-					*dst++ = ((d >> k) & 1) ? fg : 0;
+				if (bpp == 1) {
+					*dst++ = d;
 					j++;
+				} else {
+					for (k = 7; k >= 0; k--) {
+						*dst++ = ((d >> k) & 1) ? fg : 0;
+						j++;
+					}
 				}
 			}
 		}
@@ -487,7 +493,6 @@ int fb_show_logo(struct fb_info *info, i
 	if (fb_logo.logo == NULL || info->state != FBINFO_STATE_RUNNING)
 		return 0;
 
-	image.depth = 8;
 	image.data = fb_logo.logo->data;
 
 	if (fb_logo.needs_cmapreset)
@@ -506,6 +511,9 @@ int fb_show_logo(struct fb_info *info, i
 
 		saved_pseudo_palette = info->pseudo_palette;
 		info->pseudo_palette = palette;
+	} else {
+		image.fg_color = 1;
+		image.bg_color = 0;
 	}
 
 	if (fb_logo.depth <= 4) {
@@ -525,6 +533,7 @@ int fb_show_logo(struct fb_info *info, i
 	image.dy = 0;
 	image.width = fb_logo.logo->width;
 	image.height = fb_logo.logo->height;
+	image.depth = fb_logo.depth;
 
 	if (rotate) {
 		logo_rotate = kmalloc(fb_logo.logo->width *
