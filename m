From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 26 Nov 2017 21:32:06 +0000
Subject: [PATCH] video: matroxfb: Delete an error message for a failed memory allocation in matroxfb_crtc2_pr
Message-Id: <f903f284-bdba-7eb7-c666-301577fcfa94@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 26 Nov 2017 22:13:55 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/matrox/matroxfb_crtc2.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/matrox/matroxfb_crtc2.c b/drivers/video/fbdev/matrox/matroxfb_crtc2.c
index 02796a4317a9..f64e1d55d7a1 100644
--- a/drivers/video/fbdev/matrox/matroxfb_crtc2.c
+++ b/drivers/video/fbdev/matrox/matroxfb_crtc2.c
@@ -696,10 +696,9 @@ static void* matroxfb_crtc2_probe(struct matrox_fb_info* minfo) {
 	if (!minfo->devflags.crtc2)
 		return NULL;
 	m2info = kzalloc(sizeof(*m2info), GFP_KERNEL);
-	if (!m2info) {
-		printk(KERN_ERR "matroxfb_crtc2: Not enough memory for CRTC2 control structs\n");
+	if (!m2info)
 		return NULL;
-	}
+
 	m2info->primary_dev = minfo;
 	if (matroxfb_dh_registerfb(m2info)) {
 		kfree(m2info);
-- 
2.15.0

