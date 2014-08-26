From: Pramod Gurav <pramod.gurav@smartplayin.com>
Date: Tue, 26 Aug 2014 12:49:35 +0000
Subject: [PATCH v2 2/2] msm: msm_fb: Move to using managed resources of kzalloc
Message-Id: <1409057578-9397-1-git-send-email-pramod.gurav@smartplayin.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Pramod Gurav <pramod.gurav@smartplayin.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Jingoo Han <jg1.han@samsung.com>, Rob Clark <robdclark@gmail.com>

Move to managed verion of kzalloc. Also checks return for failure case
which was missing.

Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>

CC: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
CC: Tomi Valkeinen <tomi.valkeinen@ti.com>
CC: Stephen Boyd <sboyd@codeaurora.org>
CC: Jingoo Han <jg1.han@samsung.com>
CC: Rob Clark <robdclark@gmail.com>

---
 drivers/video/fbdev/msm/msm_fb.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/msm/msm_fb.c b/drivers/video/fbdev/msm/msm_fb.c
index 4640188..2979d7e 100644
--- a/drivers/video/fbdev/msm/msm_fb.c
+++ b/drivers/video/fbdev/msm/msm_fb.c
@@ -569,8 +569,13 @@ static int msmfb_probe(struct platform_device *pdev)
 	mutex_init(&msmfb->panel_init_lock);
 	init_waitqueue_head(&msmfb->frame_wq);
 	INIT_WORK(&msmfb->resume_work, power_on_panel);
-	msmfb->black = kzalloc(msmfb->fb->var.bits_per_pixel*msmfb->xres,
-			       GFP_KERNEL);
+	msmfb->black = devm_kzalloc(&pdev->dev,
+				    msmfb->fb->var.bits_per_pixel*msmfb->xres,
+				    GFP_KERNEL);
+	if (!msmfb->black) {
+		ret = -ENOMEM;
+		goto error_register_framebuffer;
+	}
 
 	printk(KERN_INFO "msmfb_probe() installing %d x %d panel\n",
 	       msmfb->xres, msmfb->yres);
-- 
1.7.9.5

