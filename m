From: Xiaofei Tan <tanxiaofei@huawei.com>
Date: Thu, 17 Sep 2020 09:19:20 +0000
Subject: [PATCH] fbdev: mx3fb: remove unused variable 'irq'
Message-Id: <1600334360-4214-1-git-send-email-tanxiaofei@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, sam@ravnborg.org, arnd@arndb.de, laurent.pinchart@ideasonboard.com, jani.nikula@intel.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Xiaofei Tan <tanxiaofei@huawei.com>, linuxarm@huawei.com

Remove the variable 'irq' that is set but never used.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 drivers/video/fbdev/mx3fb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/fbdev/mx3fb.c b/drivers/video/fbdev/mx3fb.c
index 603731a..894617d 100644
--- a/drivers/video/fbdev/mx3fb.c
+++ b/drivers/video/fbdev/mx3fb.c
@@ -1428,7 +1428,6 @@ static int init_fb_chan(struct mx3fb_data *mx3fb, struct idmac_channel *ichan)
 	struct device *dev = mx3fb->dev;
 	struct mx3fb_platform_data *mx3fb_pdata = dev_get_platdata(dev);
 	const char *name = mx3fb_pdata->name;
-	unsigned int irq;
 	struct fb_info *fbi;
 	struct mx3fb_info *mx3fbi;
 	const struct fb_videomode *mode;
@@ -1441,7 +1440,6 @@ static int init_fb_chan(struct mx3fb_data *mx3fb, struct idmac_channel *ichan)
 	}
 
 	ichan->client = mx3fb;
-	irq = ichan->eof_irq;
 
 	if (ichan->dma_chan.chan_id != IDMAC_SDC_0)
 		return -EINVAL;
-- 
2.8.1
