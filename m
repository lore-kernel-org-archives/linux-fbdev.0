From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 01 Mar 2012 15:08:08 +0000
Subject: [PATCH v2 55/57] fbdev: sh_mobile_lcdc: Constify sh_mobile_lcdc_fix structure
Message-Id: <1330614490-14149-56-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The structure is only read, make it const.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_lcdcfb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 7a0b301..b6fb8a4 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -1002,7 +1002,7 @@ static int sh_mobile_lcdc_setcolreg(u_int regno,
 	return 0;
 }
 
-static struct fb_fix_screeninfo sh_mobile_lcdc_fix  = {
+static const struct fb_fix_screeninfo sh_mobile_lcdc_fix  = {
 	.id =		"SH Mobile LCDC",
 	.type =		FB_TYPE_PACKED_PIXELS,
 	.visual =	FB_VISUAL_TRUECOLOR,
-- 
1.7.3.4

