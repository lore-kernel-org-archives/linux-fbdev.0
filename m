From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Thu, 17 Feb 2011 07:43:08 +0000
Subject: [PATCH 2/2] ARM: PXA: PXAFB: fix plane Z-ordering problem
Message-Id: <1297928588-10545-2-git-send-email-anarsoul@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201102151718.00800.anarsoul@gmail.com>
	<1297928588-10545-1-git-send-email-anarsoul@gmail.com>
In-Reply-To: <1297928588-10545-1-git-send-email-anarsoul@gmail.com>
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
index c6aad56..590a99a 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -942,8 +942,6 @@ static int __devinit pxafb_overlay_init(struct pxafb_info *fbi)
 	/* mask all IU/BS/EOF/SOF interrupts */
 	lcd_writel(fbi, LCCR5, ~0);
 
-	/* place overlay(s) on top of base */
-	fbi->lccr0 |= LCCR0_OUC;
 	pr_info("PXA Overlay driver loaded successfully!\n");
 	return 0;
 }
@@ -1827,6 +1825,12 @@ static struct pxafb_info * __devinit pxafb_init_fbinfo(struct device *dev)
 
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

