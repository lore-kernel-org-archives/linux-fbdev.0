From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Thu, 28 Mar 2013 21:03:26 +0000
Subject: [PATCH 1/1] video: fbomn: fix type VESA_DMT_VSYNC_HIGH
Message-Id: <1364504606-2087-1-git-send-email-plagnioj@jcrosoft.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

it's VESA_DMT_VSYNC_HIGH not VESA_DMT_HSYNC_HIGH
to check to enable the FB_SYNC_VERT_HIGH_ACT

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/fbmon.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
index 94ad0f7..7f67099 100644
--- a/drivers/video/fbmon.c
+++ b/drivers/video/fbmon.c
@@ -1400,7 +1400,7 @@ int fb_videomode_from_videomode(const struct videomode *vm,
 	fbmode->vmode = 0;
 	if (vm->dmt_flags & VESA_DMT_HSYNC_HIGH)
 		fbmode->sync |= FB_SYNC_HOR_HIGH_ACT;
-	if (vm->dmt_flags & VESA_DMT_HSYNC_HIGH)
+	if (vm->dmt_flags & VESA_DMT_VSYNC_HIGH)
 		fbmode->sync |= FB_SYNC_VERT_HIGH_ACT;
 	if (vm->data_flags & DISPLAY_FLAGS_INTERLACED)
 		fbmode->vmode |= FB_VMODE_INTERLACED;
-- 
1.7.10.4

