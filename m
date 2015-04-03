From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 03 Apr 2015 12:50:28 +0000
Subject: [PATCH] fbdev: sh_mobile_lcdc: Fix destruction of uninitialized mutex
Message-Id: <1428065428-25473-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

If sh_mobile_lcdc_probe() fails after the allocation of driver-private
data, but before the initialization of all channels, a warning will be
printed due to the destruction of an uninitialized mutex:

    WARNING: CPU: 0 PID: 1 at kernel/locking/mutex-debug.c:116 mutex_destroy+0x5c/0x7c()
    DEBUG_LOCKS_WARN_ON(mutex_is_locked(lock))
    ...
    Backtrace:
    ...
    [<c00425b4>] (mutex_destroy) from [<c01d5858>] (sh_mobile_lcdc_remove+0x1bc/0x230)
     r4:df6a4800 r3:00000000
    [<c01d569c>] (sh_mobile_lcdc_remove) from [<c01d6620>] (sh_mobile_lcdc_probe+0xd54/0xe28)

Move the initialization of the mutexes from sh_mobile_lcdc_channel_init()
to immediately after the allocation of driver-private data to fix this.

Note that the interrupt number is moved to a new variable "irq", so we
can reuse the existing variable "i" for iterating over the channels.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/video/fbdev/sh_mobile_lcdcfb.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index d3013cd9f9769663..97141da154c663b8 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -2605,7 +2605,6 @@ sh_mobile_lcdc_channel_init(struct sh_mobile_lcdc_chan *ch)
 	unsigned int max_size;
 	unsigned int i;
 
-	mutex_init(&ch->open_lock);
 	ch->notify = sh_mobile_lcdc_display_notify;
 
 	/* Validate the format. */
@@ -2704,7 +2703,7 @@ static int sh_mobile_lcdc_probe(struct platform_device *pdev)
 	struct resource *res;
 	int num_channels;
 	int error;
-	int i;
+	int irq, i;
 
 	if (!pdata) {
 		dev_err(&pdev->dev, "no platform data defined\n");
@@ -2712,8 +2711,8 @@ static int sh_mobile_lcdc_probe(struct platform_device *pdev)
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	i = platform_get_irq(pdev, 0);
-	if (!res || i < 0) {
+	irq = platform_get_irq(pdev, 0);
+	if (!res || irq < 0) {
 		dev_err(&pdev->dev, "cannot get platform resources\n");
 		return -ENOENT;
 	}
@@ -2726,16 +2725,18 @@ static int sh_mobile_lcdc_probe(struct platform_device *pdev)
 
 	priv->dev = &pdev->dev;
 	priv->meram_dev = pdata->meram_dev;
+	for (i = 0; i < ARRAY_SIZE(priv->ch); i++)
+		mutex_init(&priv->ch[i].open_lock);
 	platform_set_drvdata(pdev, priv);
 
-	error = request_irq(i, sh_mobile_lcdc_irq, 0,
+	error = request_irq(irq, sh_mobile_lcdc_irq, 0,
 			    dev_name(&pdev->dev), priv);
 	if (error) {
 		dev_err(&pdev->dev, "unable to request irq\n");
 		goto err1;
 	}
 
-	priv->irq = i;
+	priv->irq = irq;
 	atomic_set(&priv->hw_usecnt, -1);
 
 	for (i = 0, num_channels = 0; i < ARRAY_SIZE(pdata->ch); i++) {
-- 
1.9.1

