From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 20 Jul 2011 11:24:25 +0000
Subject: [PATCH v2 2/6] fbdev: sh_mobile_lcdc: Don't acknowlege interrupts unintentionally
Message-Id: <1311161069-11918-3-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The LDINTR register caries both interrupt enable and interrupt status
bits. When setting or clearing interrupt enable bits, write all status
bits to 1 to avoid acknowledging interrupts by mistake.

When acknowledging interrupts, write 1 to all non-triggered interrupt
bits to avoid losing interrupts.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_lcdcfb.c |   20 ++++++++------------
 1 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index abc2a91..ba946f4 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -318,19 +318,13 @@ static irqreturn_t sh_mobile_lcdc_irq(int irq, void *data)
 {
 	struct sh_mobile_lcdc_priv *priv = data;
 	struct sh_mobile_lcdc_chan *ch;
-	unsigned long tmp;
 	unsigned long ldintr;
 	int is_sub;
 	int k;
 
-	/* acknowledge interrupt */
-	ldintr = tmp = lcdc_read(priv, _LDINTR);
-	/*
-	 * disable further VSYNC End IRQs, preserve all other enabled IRQs,
-	 * write 0 to bits 0-6 to ack all triggered IRQs.
-	 */
-	tmp &= ~LDINTR_STATUS_MASK & ~LDINTR_VEE;
-	lcdc_write(priv, _LDINTR, tmp);
+	/* Acknowledge interrupts and disable further VSYNC End IRQs. */
+	ldintr = lcdc_read(priv, _LDINTR);
+	lcdc_write(priv, _LDINTR, (ldintr ^ LDINTR_STATUS_MASK) & ~LDINTR_VEE);
 
 	/* figure out if this interrupt is for main or sub lcd */
 	is_sub = (lcdc_read(priv, _LDSR) & LDSR_MSS) ? 1 : 0;
@@ -342,7 +336,7 @@ static irqreturn_t sh_mobile_lcdc_irq(int irq, void *data)
 		if (!ch->enabled)
 			continue;
 
-		/* Frame Start */
+		/* Frame End */
 		if (ldintr & LDINTR_FS) {
 			if (is_sub = lcdc_chan_is_sublcd(ch)) {
 				ch->frame_end = 1;
@@ -971,9 +965,11 @@ static int sh_mobile_wait_for_vsync(struct fb_info *info)
 	unsigned long ldintr;
 	int ret;
 
-	/* Enable VSync End interrupt */
+	/* Enable VSync End interrupt and be careful not to acknowledge any
+	 * pending interrupt.
+	 */
 	ldintr = lcdc_read(ch->lcdc, _LDINTR);
-	ldintr |= LDINTR_VEE;
+	ldintr |= LDINTR_VEE | LDINTR_STATUS_MASK;
 	lcdc_write(ch->lcdc, _LDINTR, ldintr);
 
 	ret = wait_for_completion_interruptible_timeout(&ch->vsync_completion,
-- 
1.7.3.4

