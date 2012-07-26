From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 26 Jul 2012 12:36:55 +0000
Subject: [PATCH] fbdev: sh_mobile_lcdc: Fix vertical panning step
Message-Id: <1343306215-20868-1-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Commit 15dede882e564601947f2ce4b647742c0351be6d added support for
horizontal panning but accidentally computes the Y pan step value
incorrectly for NV12/21 and NV16/61 formats. Fix this.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_lcdcfb.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 8cb653b..699487c 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -1716,11 +1716,11 @@ sh_mobile_lcdc_overlay_fb_init(struct sh_mobile_lcdc_overlay *ovl)
 		info->fix.visual = FB_VISUAL_TRUECOLOR;
 
 	switch (ovl->format->fourcc) {
-	case V4L2_PIX_FMT_NV16:
-	case V4L2_PIX_FMT_NV61:
-		info->fix.ypanstep = 2;
 	case V4L2_PIX_FMT_NV12:
 	case V4L2_PIX_FMT_NV21:
+		info->fix.ypanstep = 2;
+	case V4L2_PIX_FMT_NV16:
+	case V4L2_PIX_FMT_NV61:
 		info->fix.xpanstep = 2;
 	}
 
@@ -2215,11 +2215,11 @@ sh_mobile_lcdc_channel_fb_init(struct sh_mobile_lcdc_chan *ch,
 		info->fix.visual = FB_VISUAL_TRUECOLOR;
 
 	switch (ch->format->fourcc) {
-	case V4L2_PIX_FMT_NV16:
-	case V4L2_PIX_FMT_NV61:
-		info->fix.ypanstep = 2;
 	case V4L2_PIX_FMT_NV12:
 	case V4L2_PIX_FMT_NV21:
+		info->fix.ypanstep = 2;
+	case V4L2_PIX_FMT_NV16:
+	case V4L2_PIX_FMT_NV61:
 		info->fix.xpanstep = 2;
 	}
 
-- 
Regards,

Laurent Pinchart

