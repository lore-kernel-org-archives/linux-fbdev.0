From: H Hartley Sweeten <hartleys@visionengravers.com>
Date: Thu, 03 May 2012 00:37:35 +0000
Subject: [PATCH] video: mb862xxfbdrv.c: local functions should not be exposed globally
Message-Id: <201205021737.35719.hartleys@visionengravers.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: linux-fbdev@vger.kernel.org, FlorianSchandinat@gmx.de, agust@denx.de

Functions not referenced outside of a source file should be marked
static to prevent them from being exposed globally.

Quiets the sparse warnings:

warning: symbol 'mb862xx_intr' was not declared. Should it be static?

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Anatolij Gustschin <agust@denx.de>

---

diff --git a/drivers/video/mb862xx/mb862xxfbdrv.c b/drivers/video/mb862xx/mb862xxfbdrv.c
index 11a7a33..00ce1f3 100644
--- a/drivers/video/mb862xx/mb862xxfbdrv.c
+++ b/drivers/video/mb862xx/mb862xxfbdrv.c
@@ -579,7 +579,7 @@ static ssize_t mb862xxfb_show_dispregs(struct device *dev,
 
 static DEVICE_ATTR(dispregs, 0444, mb862xxfb_show_dispregs, NULL);
 
-irqreturn_t mb862xx_intr(int irq, void *dev_id)
+static irqreturn_t mb862xx_intr(int irq, void *dev_id)
 {
 	struct mb862xxfb_par *par = (struct mb862xxfb_par *) dev_id;
 	unsigned long reg_ist, mask;
