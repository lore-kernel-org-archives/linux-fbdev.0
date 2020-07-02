From: Evgeny Novikov <novikov@ispras.ru>
Date: Thu, 02 Jul 2020 16:05:40 +0000
Subject: [PATCH] fbdev: da8xx-fb: go to proper label on error handling paths in probe
Message-Id: <20200702160540.24546-1-novikov@ispras.ru>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: ldv-project@linuxtesting.org, Jani Nikula <jani.nikula@intel.com>, Evgeny Novikov <novikov@ispras.ru>, Daniel Vetter <daniel.vetter@ffwll.ch>, Sekhar Nori <nsekhar@ti.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>

fb_probe() can successfully allocate a new frame buffer, but then fail
to perform some operations with regulator. In these cases fb_probe()
goes to label err_pm_runtime_disable where the frame buffer is not
released. The patch makes fb_probe() to go to label err_release_fb on
corresponding error handling paths.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
---
 drivers/video/fbdev/da8xx-fb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/da8xx-fb.c b/drivers/video/fbdev/da8xx-fb.c
index 73c3c4c8cc12..e38c0e3f9c61 100644
--- a/drivers/video/fbdev/da8xx-fb.c
+++ b/drivers/video/fbdev/da8xx-fb.c
@@ -1402,14 +1402,14 @@ static int fb_probe(struct platform_device *device)
 	if (IS_ERR(par->lcd_supply)) {
 		if (PTR_ERR(par->lcd_supply) = -EPROBE_DEFER) {
 			ret = -EPROBE_DEFER;
-			goto err_pm_runtime_disable;
+			goto err_release_fb;
 		}
 
 		par->lcd_supply = NULL;
 	} else {
 		ret = regulator_enable(par->lcd_supply);
 		if (ret)
-			goto err_pm_runtime_disable;
+			goto err_release_fb;
 	}
 
 	fb_videomode_to_var(&da8xx_fb_var, lcdc_info);
-- 
2.16.4
