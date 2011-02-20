From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Sun, 20 Feb 2011 15:02:26 +0000
Subject: [PATCH v2 2/3] ARM: PXA: PXAFB: Fix plane Z-ordering problem
Message-Id: <1298214147-11578-2-git-send-email-anarsoul@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20110217110321.GF24627@n2100.arm.linux.org.uk>
	<1298214147-11578-1-git-send-email-anarsoul@gmail.com>
In-Reply-To: <1298214147-11578-1-git-send-email-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

pxafb_overlay_init is not right place to change Z-ordering,
move it to main plane initialization.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/video/pxafb.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index 41a499f..54a9ab8 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -940,8 +940,6 @@ static int __devinit pxafb_overlay_init(struct pxafb_info *fbi)
 	/* mask all IU/BS/EOF/SOF interrupts */
 	lcd_writel(fbi, LCCR5, ~0);
 
-	/* place overlay(s) on top of base */
-	fbi->lccr0 |= LCCR0_OUC;
 	pr_info("PXA Overlay driver loaded successfully!\n");
 	return 0;
 }
@@ -1825,6 +1823,12 @@ static struct pxafb_info * __devinit pxafb_init_fbinfo(struct device *dev)
 
 	pxafb_decode_mach_info(fbi, inf);
 
+#ifdef CONFIG_FB_PXA_OVERLAY
+	/* place overlay(s) on top of base */
+	if (pxafb_overlay_supported())
+		fbi->lccr0 |= LCCR0_OUC;
+#endif
+
 	init_waitqueue_head(&fbi->ctrlr_wait);
 	INIT_WORK(&fbi->task, pxafb_task);
 	mutex_init(&fbi->ctrlr_lock);
-- 
1.7.4

