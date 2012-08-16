From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 16 Aug 2012 13:00:51 +0000
Subject: [PATCH 16/19] fbdev: sh_mobile_lcdc: Remove unused get_brightness pdata callback
Message-Id: <1345122054-16013-17-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The callback isn't used anymore, remove it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 include/video/sh_mobile_lcdc.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/include/video/sh_mobile_lcdc.h b/include/video/sh_mobile_lcdc.h
index ff43ffc..2605fa8 100644
--- a/include/video/sh_mobile_lcdc.h
+++ b/include/video/sh_mobile_lcdc.h
@@ -163,7 +163,6 @@ struct sh_mobile_lcdc_bl_info {
 	const char *name;
 	int max_brightness;
 	int (*set_brightness)(int brightness);
-	int (*get_brightness)(void);
 };
 
 struct sh_mobile_lcdc_overlay_cfg {
-- 
1.7.8.6

