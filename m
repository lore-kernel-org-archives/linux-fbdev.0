From: Markus Pargmann <mpa@pengutronix.de>
Date: Wed, 24 Apr 2013 08:08:14 +0000
Subject: [PATCH 2/2] drivers/video: mxs-fb: Fix build, use renamed function
Message-Id: <1366790894-20426-3-git-send-email-mpa@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1366790894-20426-1-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1366790894-20426-1-git-send-email-mpa@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Markus Pargmann <mpargmann@allfex.org>

Kernel build fails with commit 669406534b4abb827d1bdc39bb5e2d5255818ae2

This patch renames videomode_from_timing to videomode_from_timings and
vm.data_flags to vm.flags.

Signed-off-by: Markus Pargmann <mpargmann@allfex.org>
---
 drivers/video/mxsfb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index 1b2c26d..d78827e 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -777,16 +777,16 @@ static int mxsfb_init_fbinfo_dt(struct mxsfb_info *host)
 		struct videomode vm;
 		struct fb_videomode fb_vm;
 
-		ret = videomode_from_timing(timings, &vm, i);
+		ret = videomode_from_timings(timings, &vm, i);
 		if (ret < 0)
 			goto put_timings_node;
 		ret = fb_videomode_from_videomode(&vm, &fb_vm);
 		if (ret < 0)
 			goto put_timings_node;
 
-		if (vm.data_flags & DISPLAY_FLAGS_DE_HIGH)
+		if (vm.flags & DISPLAY_FLAGS_DE_HIGH)
 			host->sync |= MXSFB_SYNC_DATA_ENABLE_HIGH_ACT;
-		if (vm.data_flags & DISPLAY_FLAGS_PIXDATA_NEGEDGE)
+		if (vm.flags & DISPLAY_FLAGS_PIXDATA_NEGEDGE)
 			host->sync |= MXSFB_SYNC_DOTCLK_FALLING_ACT;
 		fb_add_videomode(&fb_vm, &fb_info->modelist);
 	}
-- 
1.8.1.5

