From: Liu Ying <Ying.Liu@freescale.com>
Date: Mon, 11 Jun 2012 01:06:48 +0000
Subject: [PATCH 1/3] mx3fb: do not support panning with fb blanked
Message-Id: <1339376810-8247-1-git-send-email-Ying.Liu@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patch checks if framebuffer is unblanked before
we actually trigger panning in custom pan display
function.

Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
---
 drivers/video/mx3fb.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/video/mx3fb.c b/drivers/video/mx3fb.c
index e3406ab..d53db60 100644
--- a/drivers/video/mx3fb.c
+++ b/drivers/video/mx3fb.c
@@ -1063,6 +1063,11 @@ static int mx3fb_pan_display(struct fb_var_screeninfo *var,
 	dev_dbg(fbi->device, "%s [%c]\n", __func__,
 		list_empty(&mx3_fbi->idmac_channel->queue) ? '-' : '+');
 
+	if (mx3_fbi->blank != FB_BLANK_UNBLANK) {
+		dev_dbg(fbi->device, "panning with fb blanked not supported\n");
+		return -EFAULT;
+	}
+
 	if (var->xoffset > 0) {
 		dev_dbg(fbi->device, "x panning not supported\n");
 		return -EINVAL;
-- 
1.7.1


