From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 07 Jan 2018 16:04:04 +0000
Subject: [PATCH v3 2/3] video: smscufx: Return an error code only as a constant in ufx_realloc_framebuffer()
Message-Id: <31ecfef4-a193-dea0-0ff3-0d5a108a14f3@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20171125204312epcas2p149d6487ac83e886f95aefe0b35aef1b0@epcas2p1.samsung.com>
 <f12dd7c4-412d-813e-c859-e5d4b3e6d56f@users.sourceforge.net>
 <1736749.UIs06O4xc5@amdc3058>
 <a36fa112-40a1-703c-c2ac-ce7e88bb8609@users.sourceforge.net>
In-Reply-To: <a36fa112-40a1-703c-c2ac-ce7e88bb8609@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Steve Glendinning <steve.glendinning@shawell.net>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 7 Jan 2018 16:07:11 +0100

* Return an error code without storing it in an intermediate variable.

* Delete the label "error" and local variable "retval"
  which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---

v3:
This update suggestion was rebased on source files from the software
"Linux next-20180105".

 drivers/video/fbdev/smscufx.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/smscufx.c b/drivers/video/fbdev/smscufx.c
index 893daeb1ffd9..abbded605d68 100644
--- a/drivers/video/fbdev/smscufx.c
+++ b/drivers/video/fbdev/smscufx.c
@@ -1293,7 +1293,6 @@ static struct fb_ops ufx_ops = {
  * Assumes no active clients have framebuffer open */
 static int ufx_realloc_framebuffer(struct ufx_data *dev, struct fb_info *info)
 {
-	int retval = -ENOMEM;
 	int old_len = info->fix.smem_len;
 	int new_len;
 	unsigned char *old_fb = info->screen_base;
@@ -1310,7 +1309,7 @@ static int ufx_realloc_framebuffer(struct ufx_data *dev, struct fb_info *info)
 		new_fb = vmalloc(new_len);
 		if (!new_fb) {
 			pr_err("Virtual framebuffer alloc failed");
-			goto error;
+			return -ENOMEM;
 		}
 
 		if (info->screen_base) {
@@ -1323,11 +1322,7 @@ static int ufx_realloc_framebuffer(struct ufx_data *dev, struct fb_info *info)
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
2.15.1

