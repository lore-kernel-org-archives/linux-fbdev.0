From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 07 Jan 2018 13:34:51 +0000
Subject: [PATCH v2 1/2] video: udlfb: Return an error code only as a constant in dlfb_realloc_framebuffer()
Message-Id: <632abf1e-8c40-cbd2-4bbe-5dfdf89cb95f@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20171124204825epcas1p41626d598b6e437dfb4c6b648e3730cc1@epcas1p4.samsung.com>
 <6fb11bb4-2c1d-a939-087b-de31c42328b9@users.sourceforge.net>
 <1768474.zA76iyE2Y1@amdc3058>
 <25aee051-12fb-de5f-c806-f419fa4c0ef1@users.sourceforge.net>
In-Reply-To: <25aee051-12fb-de5f-c806-f419fa4c0ef1@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bernie Thompson <bernie@plugable.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 7 Jan 2018 14:02:36 +0100

* Return an error code without storing it in an intermediate variable.

* Delete the label "error" and local variable "retval"
  which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---

v2:
This update suggestion was rebased on source files from the software
"Linux next-20180105".

 drivers/video/fbdev/udlfb.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index 99ce445986b3..560a6b6044a5 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1157,7 +1157,6 @@ static struct fb_ops dlfb_ops = {
  */
 static int dlfb_realloc_framebuffer(struct dlfb_data *dev, struct fb_info *info)
 {
-	int retval = -ENOMEM;
 	int old_len = info->fix.smem_len;
 	int new_len;
 	unsigned char *old_fb = info->screen_base;
@@ -1175,7 +1174,7 @@ static int dlfb_realloc_framebuffer(struct dlfb_data *dev, struct fb_info *info)
 		new_fb = vmalloc(new_len);
 		if (!new_fb) {
 			pr_err("Virtual framebuffer alloc failed\n");
-			goto error;
+			return -ENOMEM;
 		}
 
 		if (info->screen_base) {
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
2.15.1

