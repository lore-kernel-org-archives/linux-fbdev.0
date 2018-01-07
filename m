From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 07 Jan 2018 16:06:13 +0000
Subject: [PATCH v3 3/3] video: smscufx: Delete an error message for a failed memory allocation in ufx_realloc
Message-Id: <93bd62c9-4011-4abd-2a2a-3a65c692974f@users.sourceforge.net>
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
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 7 Jan 2018 16:12:40 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---

v3:
This update suggestion was rebased on source files from the software
"Linux next-20180105".

 drivers/video/fbdev/smscufx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/smscufx.c b/drivers/video/fbdev/smscufx.c
index abbded605d68..22b606af0a87 100644
--- a/drivers/video/fbdev/smscufx.c
+++ b/drivers/video/fbdev/smscufx.c
@@ -1307,10 +1307,8 @@ static int ufx_realloc_framebuffer(struct ufx_data *dev, struct fb_info *info)
 		 * Alloc system memory for virtual framebuffer
 		 */
 		new_fb = vmalloc(new_len);
-		if (!new_fb) {
-			pr_err("Virtual framebuffer alloc failed");
+		if (!new_fb)
 			return -ENOMEM;
-		}
 
 		if (info->screen_base) {
 			memcpy(new_fb, old_fb, old_len);
-- 
2.15.1

