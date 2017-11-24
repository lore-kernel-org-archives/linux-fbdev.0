From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 24 Nov 2017 20:51:13 +0000
Subject: [PATCH 2/4] video: udlfb: Return an error code only as a constant in dlfb_realloc_framebuffer()
Message-Id: <65441eb1-3a22-27ad-b9af-03111855a6e6@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <6fb11bb4-2c1d-a939-087b-de31c42328b9@users.sourceforge.net>
In-Reply-To: <6fb11bb4-2c1d-a939-087b-de31c42328b9@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bernie Thompson <bernie@plugable.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 24 Nov 2017 21:22:25 +0100

* Return an error code without storing it in an intermediate variable.

* Delete the label "error" and local variable "retval"
  which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/udlfb.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index 77633c58bb9b..cb2d59ca67a4 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1159,7 +1159,6 @@ static struct fb_ops dlfb_ops = {
  */
 static int dlfb_realloc_framebuffer(struct dlfb_data *dev, struct fb_info *info)
 {
-	int retval = -ENOMEM;
 	int old_len = info->fix.smem_len;
 	int new_len;
 	unsigned char *old_fb = info->screen_base;
@@ -1176,7 +1175,7 @@ static int dlfb_realloc_framebuffer(struct dlfb_data *dev, struct fb_info *info)
 		 */
 		new_fb = vmalloc(new_len);
 		if (!new_fb)
-			goto error;
+			return -ENOMEM;
 
 		if (info->screen_base) {
 			memcpy(new_fb, old_fb, old_len);
@@ -1203,11 +1202,7 @@ static int dlfb_realloc_framebuffer(struct dlfb_data *dev, struct fb_info *info)
 			dev->backing_buffer = new_back;
 		}
 	}
-
-	retval = 0;
-
-error:
-	return retval;
+	return 0;
 }
 
 /*
-- 
2.15.0

