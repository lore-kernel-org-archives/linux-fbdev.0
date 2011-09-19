From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 19 Sep 2011 00:28:06 +0000
Subject: [WIP/RFC 28/31] fbdev: sh_mobile_lcdc: Make LCDC entity inherit from media_entity
Message-Id: <1316392089-27598-29-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_lcdcfb.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.h b/drivers/video/sh_mobile_lcdcfb.h
index ec57533..fa60d00 100644
--- a/drivers/video/sh_mobile_lcdcfb.h
+++ b/drivers/video/sh_mobile_lcdcfb.h
@@ -5,6 +5,7 @@
 #include <linux/fb.h>
 #include <linux/mutex.h>
 #include <linux/wait.h>
+#include <media/media-entity.h>
 
 /* per-channel registers */
 enum { LDDCKPAT1R, LDDCKPAT2R, LDMT1R, LDMT2R, LDMT3R, LDDFR, LDSM1R,
@@ -34,6 +35,7 @@ enum sh_mobile_lcdc_entity_event {
 };
 
 struct sh_mobile_lcdc_entity {
+	struct media_entity entity;
 	struct module *owner;
 	const struct sh_mobile_lcdc_entity_ops *ops;
 	struct sh_mobile_lcdc_chan *lcdc;
-- 
1.7.3.4

