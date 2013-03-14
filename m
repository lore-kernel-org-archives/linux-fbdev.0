From: Shawn Guo <shawn.guo@linaro.org>
Date: Thu, 14 Mar 2013 05:53:27 +0000
Subject: [PATCH 3/6] video: mxsfb: remove dotclk_delay from platform_data
Message-Id: <1363240410-16865-4-git-send-email-shawn.guo@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1363240410-16865-1-git-send-email-shawn.guo@linaro.org>
In-Reply-To: <1363240410-16865-1-git-send-email-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

There is no in-tree mxsfb users using mxsfb_platform_data dotclk_delay.
Let's remove it from mxsfb_platform_data to ease full device tree
adoption of mxsfb driver.  If later we have platform/board need to
configure this parameter, we can add it into device tree bindings.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/video/mxsfb.c |    1 -
 include/linux/mxsfb.h |    1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index 776d0d5..001983a 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -700,7 +700,6 @@ static int mxsfb_init_fbinfo(struct mxsfb_info *host)
 	var->accel_flags = 0;
 	var->vmode = FB_VMODE_NONINTERLACED;
 
-	host->dotclk_delay = pdata->dotclk_delay;
 	host->ld_intf_width = pdata->ld_intf_width;
 
 	/* Memory allocation for framebuffer */
diff --git a/include/linux/mxsfb.h b/include/linux/mxsfb.h
index 93fc34b..6d64e2e 100644
--- a/include/linux/mxsfb.h
+++ b/include/linux/mxsfb.h
@@ -33,7 +33,6 @@ struct mxsfb_platform_data {
 
 	unsigned default_bpp;
 
-	unsigned dotclk_delay;	/* refer manual HW_LCDIF_VDCTRL4 register */
 	unsigned ld_intf_width;	/* refer STMLCDIF_* macros */
 };
 
-- 
1.7.9.5


