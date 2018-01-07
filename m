From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 07 Jan 2018 13:38:09 +0000
Subject: [PATCH v2 2/2] video: udlfb: Delete an error message for a failed memory allocation in dlfb_realloc_
Message-Id: <0caca4c2-bf2b-42fd-5f78-460630015692@users.sourceforge.net>
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
Date: Sun, 7 Jan 2018 14:07:36 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---

v2:
This update suggestion was rebased on source files from the software
"Linux next-20180105" together with an other change combination.

 drivers/video/fbdev/udlfb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index 560a6b6044a5..0c781b077aab 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1172,10 +1172,8 @@ static int dlfb_realloc_framebuffer(struct dlfb_data *dev, struct fb_info *info)
 		 * Alloc system memory for virtual framebuffer
 		 */
 		new_fb = vmalloc(new_len);
-		if (!new_fb) {
-			pr_err("Virtual framebuffer alloc failed\n");
+		if (!new_fb)
 			return -ENOMEM;
-		}
 
 		if (info->screen_base) {
 			memcpy(new_fb, old_fb, old_len);
-- 
2.15.1

