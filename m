From: Timur Tabi <timur@freescale.com>
Date: Thu, 15 Sep 2011 21:44:54 +0000
Subject: [PATCH 09/13] drivers/video: fsl-diu-fb: fix potential memcpy buffer overflow bug
Message-Id: <1316123098-30967-10-git-send-email-timur@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

It makes no sense to limit the size of a strncpy() to the length of
the source string.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 drivers/video/fsl-diu-fb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index 19bfbf5..3776949 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -655,7 +655,7 @@ static void set_fix(struct fb_info *info)
 	struct fb_var_screeninfo *var = &info->var;
 	struct mfb_info *mfbi = info->par;
 
-	strncpy(fix->id, mfbi->id, strlen(mfbi->id));
+	strncpy(fix->id, mfbi->id, sizeof(fix->id));
 	fix->line_length = var->xres_virtual * var->bits_per_pixel / 8;
 	fix->type = FB_TYPE_PACKED_PIXELS;
 	fix->accel = FB_ACCEL_NONE;
-- 
1.7.3.4


