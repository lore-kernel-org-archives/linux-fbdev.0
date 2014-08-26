From: Pramod Gurav <pramod.gurav@smartplayin.com>
Date: Tue, 26 Aug 2014 12:22:37 +0000
Subject: [PATCH v2 1/2] msm: msm_fb: Add remove function for platform driver for clean unloading
Message-Id: <1409055038-9204-1-git-send-email-pramod.gurav@smartplayin.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Pramod Gurav <pramod.gurav@smartplayin.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Jingoo Han <jg1.han@samsung.com>, Rob Clark <robdclark@gmail.com>

This adds a  remove function to platform driver structure so that
resources are released when driver is unloaded.

Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>

CC: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
CC: Tomi Valkeinen <tomi.valkeinen@ti.com>
CC: Stephen Boyd <sboyd@codeaurora.org>
CC: Jingoo Han <jg1.han@samsung.com>
CC: Rob Clark <robdclark@gmail.com>

---
 drivers/video/fbdev/msm/msm_fb.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/video/fbdev/msm/msm_fb.c b/drivers/video/fbdev/msm/msm_fb.c
index 1374803..4640188 100644
--- a/drivers/video/fbdev/msm/msm_fb.c
+++ b/drivers/video/fbdev/msm/msm_fb.c
@@ -589,6 +589,8 @@ static int msmfb_probe(struct platform_device *pdev)
 
 	msmfb->sleeping = WAKING;
 
+	platform_set_drvdata(pdev, msmfb);
+
 	return 0;
 
 error_register_framebuffer:
@@ -598,9 +600,23 @@ error_setup_fbmem:
 	return ret;
 }
 
+static int msmfb_remove(struct platform_device *pdev)
+{
+	struct msmfb_info *msmfb;
+
+	msmfb = platform_get_drvdata(pdev);
+
+	unregister_framebuffer(msmfb->fb);
+	iounmap(msmfb->fb->screen_base);
+	framebuffer_release(msmfb->fb);
+
+	return 0;
+}
+
 static struct platform_driver msm_panel_driver = {
 	/* need to write remove */
 	.probe = msmfb_probe,
+	.remove = msmfb_remove,
 	.driver = {.name = "msm_panel"},
 };
 
-- 
1.7.9.5

