From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 17 Sep 2013 04:57:22 +0000
Subject: [PATCH 02/19] video: mx3fb: use dev_get_platdata()
Message-Id: <000701ceb362$650a3de0$2f1eb9a0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Use the wrapper function for retrieving the platform data instead of
accessing dev->platform_data directly. This is a cosmetic change
to make the code simpler and enhance the readability.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/mx3fb.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/mx3fb.c b/drivers/video/mx3fb.c
index cfdb380..804f874 100644
--- a/drivers/video/mx3fb.c
+++ b/drivers/video/mx3fb.c
@@ -1354,7 +1354,7 @@ static struct fb_info *mx3fb_init_fbinfo(struct device *dev, struct fb_ops *ops)
 static int init_fb_chan(struct mx3fb_data *mx3fb, struct idmac_channel *ichan)
 {
 	struct device *dev = mx3fb->dev;
-	struct mx3fb_platform_data *mx3fb_pdata = dev->platform_data;
+	struct mx3fb_platform_data *mx3fb_pdata = dev_get_platdata(dev);
 	const char *name = mx3fb_pdata->name;
 	unsigned int irq;
 	struct fb_info *fbi;
@@ -1462,7 +1462,7 @@ static bool chan_filter(struct dma_chan *chan, void *arg)
 		return false;
 
 	dev = rq->mx3fb->dev;
-	mx3fb_pdata = dev->platform_data;
+	mx3fb_pdata = dev_get_platdata(dev);
 
 	return rq->id = chan->chan_id &&
 		mx3fb_pdata->dma_dev = chan->device->dev;
-- 
1.7.10.4


