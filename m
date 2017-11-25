From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 25 Nov 2017 20:46:39 +0000
Subject: [PATCH 3/5] video: smscufx: Return an error code only as a constant in ufx_realloc_framebuffer()
Message-Id: <4bc004f9-b7b1-bcf6-de3b-32042a510144@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <f12dd7c4-412d-813e-c859-e5d4b3e6d56f@users.sourceforge.net>
In-Reply-To: <f12dd7c4-412d-813e-c859-e5d4b3e6d56f@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Steve Glendinning <steve.glendinning@shawell.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 25 Nov 2017 19:56:44 +0100

* Return an error code without storing it in an intermediate variable.

* Delete the label "error" and local variable "retval"
  which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/smscufx.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/smscufx.c b/drivers/video/fbdev/smscufx.c
index 08271dafd138..c77fc45a76fc 100644
--- a/drivers/video/fbdev/smscufx.c
+++ b/drivers/video/fbdev/smscufx.c
@@ -1294,7 +1294,6 @@ static struct fb_ops ufx_ops = {
  * Assumes no active clients have framebuffer open */
 static int ufx_realloc_framebuffer(struct ufx_data *dev, struct fb_info *info)
 {
-	int retval = -ENOMEM;
 	int old_len = info->fix.smem_len;
 	int new_len;
 	unsigned char *old_fb = info->screen_base;
@@ -1310,7 +1309,7 @@ static int ufx_realloc_framebuffer(struct ufx_data *dev, struct fb_info *info)
 		 */
 		new_fb = vmalloc(new_len);
 		if (!new_fb)
-			goto error;
+			return -ENOMEM;
 
 		if (info->screen_base) {
 			memcpy(new_fb, old_fb, old_len);
@@ -1322,11 +1321,7 @@ static int ufx_realloc_framebuffer(struct ufx_data *dev, struct fb_info *info)
 		info->fix.smem_start = (unsigned long) new_fb;
 		info->flags = smscufx_info_flags;
 	}
-
-	retval = 0;
-
-error:
-	return retval;
+	return 0;
 }
 
 /* sets up I2C Controller for 100 Kbps, std. speed, 7-bit addr, master,
-- 
2.15.0

