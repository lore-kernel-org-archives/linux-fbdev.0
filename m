From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 19 Jul 2012 00:39:20 +0000
Subject: [PATCH 7/9] fbdev: sh_mobile_lcdc: Support horizontal panning
Message-Id: <1342658362-19491-8-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_lcdcfb.c |   22 ++++++++++++++++------
 1 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 68011b5..aeb7585 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -1493,7 +1493,7 @@ static const struct fb_fix_screeninfo sh_mobile_lcdc_overlay_fix  = {
 	.type =		FB_TYPE_PACKED_PIXELS,
 	.visual =	FB_VISUAL_TRUECOLOR,
 	.accel =	FB_ACCEL_NONE,
-	.xpanstep =	0,
+	.xpanstep =	1,
 	.ypanstep =	1,
 	.ywrapstep =	0,
 	.capabilities =	FB_CAP_FOURCC,
@@ -1714,9 +1714,14 @@ sh_mobile_lcdc_overlay_fb_init(struct sh_mobile_lcdc_overlay *ovl)
 	else
 		info->fix.visual = FB_VISUAL_TRUECOLOR;
 
-	if (ovl->format->fourcc = V4L2_PIX_FMT_NV12 ||
-	    ovl->format->fourcc = V4L2_PIX_FMT_NV21)
+	switch (ovl->format->fourcc) {
+	case V4L2_PIX_FMT_NV16:
+	case V4L2_PIX_FMT_NV61:
+		info->fix.xpanstep = 2;
+	case V4L2_PIX_FMT_NV12:
+	case V4L2_PIX_FMT_NV21:
 		info->fix.ypanstep = 2;
+	}
 
 	/* Initialize variable screen information. */
 	var = &info->var;
@@ -1771,7 +1776,7 @@ static const struct fb_fix_screeninfo sh_mobile_lcdc_fix  = {
 	.type =		FB_TYPE_PACKED_PIXELS,
 	.visual =	FB_VISUAL_TRUECOLOR,
 	.accel =	FB_ACCEL_NONE,
-	.xpanstep =	0,
+	.xpanstep =	1,
 	.ypanstep =	1,
 	.ywrapstep =	0,
 	.capabilities =	FB_CAP_FOURCC,
@@ -2209,9 +2214,14 @@ sh_mobile_lcdc_channel_fb_init(struct sh_mobile_lcdc_chan *ch,
 	else
 		info->fix.visual = FB_VISUAL_TRUECOLOR;
 
-	if (ch->format->fourcc = V4L2_PIX_FMT_NV12 ||
-	    ch->format->fourcc = V4L2_PIX_FMT_NV21)
+	switch (ch->format->fourcc) {
+	case V4L2_PIX_FMT_NV16:
+	case V4L2_PIX_FMT_NV61:
+		info->fix.xpanstep = 2;
+	case V4L2_PIX_FMT_NV12:
+	case V4L2_PIX_FMT_NV21:
 		info->fix.ypanstep = 2;
+	}
 
 	/* Initialize variable screen information using the first mode as
 	 * default.
-- 
1.7.8.6

