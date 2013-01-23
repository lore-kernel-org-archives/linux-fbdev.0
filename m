From: Afzal Mohammed <afzal@ti.com>
Date: Wed, 23 Jan 2013 11:51:32 +0000
Subject: [PATCH v4 05/12] video: da8xx-fb: ensure non-null cfg in pdata
Message-Id: <b32d0c0113c3494204a98e3d93f05ae03831bcd2.1358937685.git.afzal@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1358937685.git.afzal@ti.com>
In-Reply-To: <cover.1358937685.git.afzal@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Mike Turquette <mturquette@linaro.org>

Ensure that platform data contains pointer for lcd_ctrl_config.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 drivers/video/da8xx-fb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 7a32e83..3b146bc 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -1320,6 +1320,11 @@ static int fb_probe(struct platform_device *device)
 
 	lcd_cfg = (struct lcd_ctrl_config *)fb_pdata->controller_data;
 
+	if (!lcd_cfg) {
+		ret = -EINVAL;
+		goto err_pm_runtime_disable;
+	}
+
 	da8xx_fb_info = framebuffer_alloc(sizeof(struct da8xx_fb_par),
 					&device->dev);
 	if (!da8xx_fb_info) {
-- 
1.7.12

