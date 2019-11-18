From: Chuhong Yuan <hslester96@gmail.com>
Date: Mon, 18 Nov 2019 11:41:50 +0000
Subject: [PATCH] video: ssd1307fb: add the missed regulator_disable
Message-Id: <20191118114150.25724-1-hslester96@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>

The driver forgets to disable the regulator in remove like what is done
in probe failure.
Add the missed call to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/video/fbdev/ssd1307fb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 78ca7ffc40c2..819fbee18dda 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -791,6 +791,8 @@ static int ssd1307fb_remove(struct i2c_client *client)
 		pwm_disable(par->pwm);
 		pwm_put(par->pwm);
 	}
+	if (par->vbat_reg)
+		regulator_disable(par->vbat_reg);
 	fb_deferred_io_cleanup(info);
 	__free_pages(__va(info->fix.smem_start), get_order(info->fix.smem_len));
 	framebuffer_release(info);
-- 
2.24.0
