From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 25 Nov 2017 20:50:06 +0000
Subject: [PATCH 5/5] video: smscufx: Adjust three checks for null pointers
Message-Id: <0c4fc190-122a-6a46-2dcc-a17b4acd84b5@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <f12dd7c4-412d-813e-c859-e5d4b3e6d56f@users.sourceforge.net>
In-Reply-To: <f12dd7c4-412d-813e-c859-e5d4b3e6d56f@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Steve Glendinning <steve.glendinning@shawell.net>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 25 Nov 2017 21:21:20 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The script “checkpatch.pl” pointed information out like the following.

Comparison to NULL could be written …

Thus fix the affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/smscufx.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/smscufx.c b/drivers/video/fbdev/smscufx.c
index 03d35429e1b9..d14604536e63 100644
--- a/drivers/video/fbdev/smscufx.c
+++ b/drivers/video/fbdev/smscufx.c
@@ -1081,7 +1081,7 @@ static int ufx_ops_open(struct fb_info *info, int user)
 
 	kref_get(&dev->kref);
 
-	if (fb_defio && (info->fbdefio = NULL)) {
+	if (fb_defio && !info->fbdefio) {
 		/* enable defio at last moment if not disabled by client */
 
 		struct fb_deferred_io *fbdefio;
@@ -1556,8 +1556,7 @@ static int ufx_setup_modes(struct ufx_data *dev, struct fb_info *info,
 	}
 
 	/* If everything else has failed, fall back to safe default mode */
-	if (default_vmode = NULL) {
-
+	if (!default_vmode) {
 		struct fb_videomode fb_vmode = {0};
 
 		/* Add the standard VESA modes to our modelist
@@ -1583,8 +1582,7 @@ static int ufx_setup_modes(struct ufx_data *dev, struct fb_info *info,
 	}
 
 	/* If we have good mode and no active clients */
-	if ((default_vmode != NULL) && (dev->fb_count = 0)) {
-
+	if (default_vmode && dev->fb_count = 0) {
 		fb_videomode_to_var(&info->var, default_vmode);
 		ufx_var_color_format(&info->var);
 
@@ -1594,10 +1592,9 @@ static int ufx_setup_modes(struct ufx_data *dev, struct fb_info *info,
 			(info->var.bits_per_pixel / 8);
 
 		result = ufx_realloc_framebuffer(dev, info);
-
-	} else
+	} else {
 		result = -EINVAL;
-
+	}
 error:
 	if (edid && (dev->edid != edid))
 		kfree(edid);
-- 
2.15.0

