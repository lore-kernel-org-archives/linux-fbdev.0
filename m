From: "Eric Miao" <eric.y.miao@gmail.com>
Subject: [PATCH 1/5] pxafb: small cleanup of the smart
	panel code
Date: Thu, 11 Dec 2008 17:46:30 +0800
Message-ID: <f17812d70812110146x5392f222ke41e5d8dc4ea40dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <eric.y.miao@gmail.com>) id 1LAi7v-0006gI-Qj
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 11 Dec 2008 09:46:35 +0000
Received: from rv-out-0708.google.com ([209.85.198.245])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LAi7s-00066I-CB for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 11 Dec 2008 09:46:35 +0000
Received: by rv-out-0708.google.com with SMTP id f25so795928rvb.22
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 11 Dec 2008 01:46:30 -0800 (PST)
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: ARM Linux <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: linux-fbdev-devel@lists.sourceforge.net

Signed-off-by: Eric Miao <eric.miao@marvell.com>
---
 drivers/video/pxafb.c |   19 +++++++++----------
 1 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index ab60537..e0bba02 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -800,14 +800,16 @@ static int pxafb_smart_thread(void *arg)

 static int pxafb_smart_init(struct pxafb_info *fbi)
 {
-	if (!(fbi->lccr0 | LCCR0_LCDT))
+	if (!(fbi->lccr0 & LCCR0_LCDT))
 		return 0;

+	init_completion(&fbi->command_done);
+	init_completion(&fbi->refresh_done);
+
 	fbi->smart_thread = kthread_run(pxafb_smart_thread, fbi,
 					"lcd_refresh");
 	if (IS_ERR(fbi->smart_thread)) {
-		printk(KERN_ERR "%s: unable to create kernel thread\n",
-				__func__);
+		pr_err("%s: unable to create kernel thread\n", __func__);
 		return PTR_ERR(fbi->smart_thread);
 	}

@@ -823,7 +825,9 @@ int pxafb_smart_flush(struct fb_info *info)
 {
 	return 0;
 }
-#endif /* CONFIG_FB_SMART_PANEL */
+
+static inline int pxafb_smart_init(struct pxafb_info *fbi) { return 0; }
+#endif /* CONFIG_FB_PXA_SMARTPANEL */

 static void setup_parallel_timing(struct pxafb_info *fbi,
 				  struct fb_var_screeninfo *var)
@@ -1412,10 +1416,6 @@ static struct pxafb_info * __devinit
pxafb_init_fbinfo(struct device *dev)
 	INIT_WORK(&fbi->task, pxafb_task);
 	mutex_init(&fbi->ctrlr_lock);
 	init_completion(&fbi->disable_done);
-#ifdef CONFIG_FB_PXA_SMARTPANEL
-	init_completion(&fbi->command_done);
-	init_completion(&fbi->refresh_done);
-#endif

 	return fbi;
 }
@@ -1747,13 +1747,12 @@ static int __devinit pxafb_probe(struct
platform_device *dev)
 		goto failed_free_mem;
 	}

-#ifdef CONFIG_FB_PXA_SMARTPANEL
 	ret = pxafb_smart_init(fbi);
 	if (ret) {
 		dev_err(&dev->dev, "failed to initialize smartpanel\n");
 		goto failed_free_irq;
 	}
-#endif
+
 	/*
 	 * This makes sure that our colour bitfield
 	 * descriptors are correctly initialised.
-- 
1.6.0.4

------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
