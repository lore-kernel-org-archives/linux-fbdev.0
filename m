From: Daniel Drake <dsd@laptop.org>
Date: Sun, 14 Nov 2010 14:12:31 +0000
Subject: [PATCH] lxfb: Program panel v/h sync output polarity correctly
Message-Id: <20101114141231.414F29D401B@zog.reactivated.net>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Commit b5c26f97ec4a17c65 introduced some breakage for the OLPC XO-1 laptop,
differences in the output video signal after the patch caused some problems
with the XO's display controller chip.

Reviewing of that commit against the AMD Geode LX Data Book, it seems
that these bits were being set inversely. In both cases, active high
output is denoted by a value of 0. See section 6.8.3.44 of the databook
from February 2009 (Publication ID: 33234H)

Signed-off-by: Daniel Drake <dsd@laptop.org>
---
 drivers/video/geode/lxfb_ops.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/geode/lxfb_ops.c b/drivers/video/geode/lxfb_ops.c
index bc35a95..85ec7f6 100644
--- a/drivers/video/geode/lxfb_ops.c
+++ b/drivers/video/geode/lxfb_ops.c
@@ -276,10 +276,10 @@ static void lx_graphics_enable(struct fb_info *info)
 		write_fp(par, FP_PT1, 0);
 		temp = FP_PT2_SCRC;
 
-		if (info->var.sync & FB_SYNC_HOR_HIGH_ACT)
+		if (!(info->var.sync & FB_SYNC_HOR_HIGH_ACT))
 			temp |= FP_PT2_HSP;
 
-		if (info->var.sync & FB_SYNC_VERT_HIGH_ACT)
+		if (!(info->var.sync & FB_SYNC_VERT_HIGH_ACT))
 			temp |= FP_PT2_VSP;
 
 		write_fp(par, FP_PT2, temp);
-- 
1.7.3.2

