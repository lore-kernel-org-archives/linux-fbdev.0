From: Nicholas Mc Guire <hofrat@osadl.org>
Date: Fri, 20 Feb 2015 14:34:01 +0000
Subject: [PATCH v2] video: fbdev: use msecs_to_jiffies for time conversions
Message-Id: <1424442841-25466-1-git-send-email-hofrat@osadl.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jingoo Han <jg1.han@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Fabian Frederick <fabf@skynet.be>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Nicholas Mc Guire <hofrat@osadl.org>, Wolfram Sang <wsa@the-dreams.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

This is only an API consolidation and should make things more readable by
replacing  var * HZ / 1000  by msecs_to_jiffies(var).

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

v2: fixed missing closing parenthesis in pxafb_disable_controller.
    Compile testing was missing part of the patched code due to
    the missing CONFIG_FB_PXA_SMARTPANEL=y, so the missing closing
    parenthesis reported by Tomi Valkeinen <tomi.valkeinen@ti.com>
    pxafb_disable_controller went unnoticed.

Patch was only compile tested with viper_defconfig CONFIG_FB_PXA=m,
CONFIG_FB_PXA_SMARTPANEL=y

Patch is against 3.19.0 (localversion-next is -next-20150220)

 drivers/video/fbdev/pxafb.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index da2431e..d8b4743 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -1285,7 +1285,7 @@ static int pxafb_smart_thread(void *arg)
 		mutex_unlock(&fbi->ctrlr_lock);

 		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(30 * HZ / 1000);
+		schedule_timeout(msecs_to_jiffies(30));
 	}

 	pr_debug("%s(): task ending\n", __func__);
@@ -1460,7 +1460,7 @@ static void pxafb_disable_controller(struct pxafb_info *fbi)
 #ifdef CONFIG_FB_PXA_SMARTPANEL
 	if (fbi->lccr0 & LCCR0_LCDT) {
 		wait_for_completion_timeout(&fbi->refresh_done,
-				200 * HZ / 1000);
+				msecs_to_jiffies(200));
 		return;
 	}
 #endif
@@ -1472,7 +1472,7 @@ static void pxafb_disable_controller(struct pxafb_info *fbi)
 	lcd_writel(fbi, LCCR0, lccr0);
 	lcd_writel(fbi, LCCR0, lccr0 | LCCR0_DIS);

-	wait_for_completion_timeout(&fbi->disable_done, 200 * HZ / 1000);
+	wait_for_completion_timeout(&fbi->disable_done, msecs_to_jiffies(200));

 	/* disable LCD controller clock */
 	clk_disable_unprepare(fbi->clk);
--
1.7.10.4

