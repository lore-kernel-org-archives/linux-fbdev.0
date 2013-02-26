From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 26 Feb 2013 03:05:50 +0000
Subject: [PATCH] fbmon: use VESA_DMT_VSYNC_HIGH to fix typo
Message-Id: <009501ce13ce$2e912d20$8bb38760$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Dave Airlie' <airlied@linux.ie>
Cc: linux-fbdev@vger.kernel.org, 'Steffen Trumtrar' <s.trumtrar@pengutronix.de>, dri-devel@lists.freedesktop.org, 'Florian Tobias Schandinat' <FlorianSchandinat@gmx.de>

VESA_DMT_VSYNC_HIGH should be used instead of VESA_DMT_HSYNC_HIGH,
because FB_SYNC_VERT_HIGH_ACT is related to vsync, not to hsync.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 drivers/video/fbmon.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

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
1.7.2.5


