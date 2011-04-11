From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 11 Apr 2011 07:25:37 +0000
Subject: [PATCH] video: s3c-fb: add spinlock to interrupt routine
Message-Id: <1302506737-22764-1-git-send-email-jg1.han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The spinlock is added to interrupt routine to ensure that the driver
is protected against multiple accesses.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/s3c-fb.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 6817d18..23481f3 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -182,6 +182,7 @@ struct s3c_fb_vsync {
 
 /**
  * struct s3c_fb - overall hardware state of the hardware
+ * @slock: The spinlock protection for this data sturcture.
  * @dev: The device that we bound to, for printing, etc.
  * @regs_res: The resource we claimed for the IO registers.
  * @bus_clk: The clk (hclk) feeding our interface and possibly pixclk.
@@ -195,6 +196,7 @@ struct s3c_fb_vsync {
  * @vsync_info: VSYNC-related information (count, queues...)
  */
 struct s3c_fb {
+	spinlock_t		slock;
 	struct device		*dev;
 	struct resource		*regs_res;
 	struct clk		*bus_clk;
@@ -947,6 +949,8 @@ static irqreturn_t s3c_fb_irq(int irq, void *dev_id)
 	void __iomem  *regs = sfb->regs;
 	u32 irq_sts_reg;
 
+	spin_lock(&sfb->slock);
+
 	irq_sts_reg = readl(regs + VIDINTCON1);
 
 	if (irq_sts_reg & VIDINTCON1_INT_FRAME) {
@@ -963,6 +967,7 @@ static irqreturn_t s3c_fb_irq(int irq, void *dev_id)
 	 */
 	s3c_fb_disable_irq(sfb);
 
+	spin_unlock(&sfb->slock);
 	return IRQ_HANDLED;
 }
 
@@ -1337,6 +1342,8 @@ static int __devinit s3c_fb_probe(struct platform_device *pdev)
 	sfb->pdata = pd;
 	sfb->variant = fbdrv->variant;
 
+	spin_lock_init(&sfb->slock);
+
 	sfb->bus_clk = clk_get(dev, "lcd");
 	if (IS_ERR(sfb->bus_clk)) {
 		dev_err(dev, "failed to get bus clock\n");
-- 
1.7.1

