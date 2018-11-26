From: Peter Rosin <peda@axentia.se>
Date: Mon, 26 Nov 2018 21:57:39 +0000
Subject: [PATCH 1/2] fbdev: fbmem: make fb_show_logo_line return the end instead of the height
Message-Id: <20181126215725.2548-2-peda@axentia.se>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181126215725.2548-1-peda@axentia.se>
In-Reply-To: <20181126215725.2548-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Peter Rosin <peda@axentia.se>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

In preparation for allowing centering of the bootup logo, make
fb_show_logo_line return where the next free framebuffer line is,
instead of returning the height of the shown logo.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/video/fbdev/core/fbmem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 861bf8081619..43d4047f472a 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -521,7 +521,7 @@ static int fb_show_logo_line(struct fb_info *info, int rotate,
 		info->pseudo_palette = saved_pseudo_palette;
 	kfree(logo_new);
 	kfree(logo_rotate);
-	return logo->height;
+	return image.dy + logo->height;
 }
 
 
@@ -573,8 +573,8 @@ static int fb_show_extra_logos(struct fb_info *info, int y, int rotate)
 	unsigned int i;
 
 	for (i = 0; i < fb_logo_ex_num; i++)
-		y += fb_show_logo_line(info, rotate,
-				       fb_logo_ex[i].logo, y, fb_logo_ex[i].n);
+		y = fb_show_logo_line(info, rotate,
+				      fb_logo_ex[i].logo, y, fb_logo_ex[i].n);
 
 	return y;
 }
-- 
2.11.0
