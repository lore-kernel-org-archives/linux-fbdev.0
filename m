From: Vinod Koul <vinod.koul@intel.com>
Date: Wed, 24 Sep 2014 16:27:17 +0000
Subject: [PATCH 27/27] video: fbdev: use pm_runtime_last_busy_and_autosuspend helper
Message-Id: <1411575342-31048-28-git-send-email-vinod.koul@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1411575342-31048-1-git-send-email-vinod.koul@intel.com>
In-Reply-To: <1411575342-31048-1-git-send-email-vinod.koul@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: subhransu.s.prusty@intel.com, vinod.koul@intel.com, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jingoo Han <jg1.han@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Clark <robdclark@gmail.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, linux-fbdev@vger.kernel.org

Use the new pm_runtime_last_busy_and_autosuspend helper instead of open
coding the same code

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/video/fbdev/auo_k190x.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/auo_k190x.c b/drivers/video/fbdev/auo_k190x.c
index 8d2499d..e12f513 100644
--- a/drivers/video/fbdev/auo_k190x.c
+++ b/drivers/video/fbdev/auo_k190x.c
@@ -354,8 +354,7 @@ static void auok190xfb_dpy_deferred_io(struct fb_info *info,
 		par->update_partial(par, y1, min((u16) (y1 + h), yres));
 
 out:
-	pm_runtime_mark_last_busy(info->device);
-	pm_runtime_put_autosuspend(info->device);
+	pm_runtime_last_busy_and_autosuspend(info->device);
 }
 
 /*
@@ -591,8 +590,7 @@ static int auok190x_read_temperature(struct auok190xfb_par *par)
 
 	mutex_unlock(&(par->io_lock));
 
-	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
+	pm_runtime_last_busy_and_autosuspend(dev);
 
 	/* sanitize and split of half-degrees for now */
 	temp = ((data[0] & AUOK190X_VERSION_TEMP_MASK) >> 1);
@@ -630,8 +628,7 @@ static void auok190x_identify(struct auok190xfb_par *par)
 		par->panel_size_int, par->panel_size_float, par->panel_model,
 		par->epd_type, par->tcon_version, par->lut_version);
 
-	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
+	pm_runtime_last_busy_and_autosuspend(dev);
 }
 
 /*
-- 
1.7.0.4

