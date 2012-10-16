From: Timur Tabi <timur@freescale.com>
Date: Tue, 16 Oct 2012 22:33:47 +0000
Subject: [PATCH 6/9] drivers/video: fsl-diu-fb: remove unused 'cursor_reset' variable
Message-Id: <1350426830-12140-6-git-send-email-timur@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Probably left over from initial development in hardware cursor support
that never made it upstream.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 drivers/video/fsl-diu-fb.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index 6e32ba8..fa7f200 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -337,7 +337,6 @@ struct mfb_info {
 	int registered;
 	unsigned long pseudo_palette[16];
 	struct diu_ad *ad;
-	int cursor_reset;
 	unsigned char g_alpha;
 	unsigned int count;
 	int x_aoi_d;		/* aoi display x offset to physical screen */
@@ -982,7 +981,6 @@ static int fsl_diu_set_par(struct fb_info *info)
 	hw = data->diu_reg;
 
 	set_fix(info);
-	mfbi->cursor_reset = 1;
 
 	len = info->var.yres_virtual * info->fix.line_length;
 	/* Alloc & dealloc each time resolution/bpp change */
-- 
1.7.3.4


