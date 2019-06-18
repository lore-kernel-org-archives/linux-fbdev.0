From: Marko Kohtala <marko.kohtala@okoko.fi>
Date: Tue, 18 Jun 2019 07:41:07 +0000
Subject: [PATCH 2/6] video: ssd1307fb: Remove unneeded semicolons
Message-Id: <20190618074111.9309-3-marko.kohtala@okoko.fi>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190618074111.9309-1-marko.kohtala@okoko.fi>
In-Reply-To: <20190618074111.9309-1-marko.kohtala@okoko.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, Marko Kohtala <marko.kohtala@okoko.fi>, Rob Herring <robh+dt@kernel.org>

coccicheck reported unneeded semicolons. Remove them.

Signed-off-by: Marko Kohtala <marko.kohtala@okoko.fi>
---
 drivers/video/fbdev/ssd1307fb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 6c2980331ffd..9ab00e0dadc7 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -313,7 +313,7 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
 
 		dev_dbg(&par->client->dev, "Using PWM%d with a %dns period.\n",
 			par->pwm->pwm, par->pwm_period);
-	};
+	}
 
 	/* Set initial contrast */
 	ret = ssd1307fb_write_cmd(par->client, SSD1307FB_CONTRAST);
@@ -329,7 +329,7 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
 		ret = ssd1307fb_write_cmd(par->client, SSD1307FB_SEG_REMAP_ON);
 		if (ret < 0)
 			return ret;
-	};
+	}
 
 	/* Set COM direction */
 	com_invdir = 0xc0 | (par->com_invdir & 0x1) << 3;
@@ -716,7 +716,7 @@ static int ssd1307fb_probe(struct i2c_client *client,
 	if (par->device_info->need_pwm) {
 		pwm_disable(par->pwm);
 		pwm_put(par->pwm);
-	};
+	}
 regulator_enable_error:
 	if (par->vbat_reg)
 		regulator_disable(par->vbat_reg);
@@ -740,7 +740,7 @@ static int ssd1307fb_remove(struct i2c_client *client)
 	if (par->device_info->need_pwm) {
 		pwm_disable(par->pwm);
 		pwm_put(par->pwm);
-	};
+	}
 	fb_deferred_io_cleanup(info);
 	__free_pages(__va(info->fix.smem_start), get_order(info->fix.smem_len));
 	framebuffer_release(info);
-- 
2.17.1
