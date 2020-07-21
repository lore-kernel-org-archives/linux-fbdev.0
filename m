From: Lee Jones <lee.jones@linaro.org>
Date: Tue, 21 Jul 2020 07:39:19 +0000
Subject: [PATCH 1/1] video: backlight: cr_bllcd: Remove unused variable 'intensity'
Message-Id: <20200721073919.925935-1-lee.jones@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lee.jones@linaro.org
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, linux-arm-kernel@lists.infradead.org

Fixes the following kernel build warning:

 drivers/video/backlight/cr_bllcd.c: In function ‘cr_backlight_set_intensity’:
 drivers/video/backlight/cr_bllcd.c:62:6: warning: unused variable ‘intensity’ [-Wunused-variable]
 62 | int intensity = bd->props.brightness;
 | ^~~~~~~~~

Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Fixes: 24d34617c24f ("backlight: cr_bllcd: Introduce gpio-backlight semantics")
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/backlight/cr_bllcd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/backlight/cr_bllcd.c b/drivers/video/backlight/cr_bllcd.c
index a24d42e1ea3cd..4ad0a72531fe2 100644
--- a/drivers/video/backlight/cr_bllcd.c
+++ b/drivers/video/backlight/cr_bllcd.c
@@ -59,7 +59,6 @@ struct cr_panel {
 
 static int cr_backlight_set_intensity(struct backlight_device *bd)
 {
-	int intensity = bd->props.brightness;
 	u32 addr = gpio_bar + CRVML_PANEL_PORT;
 	u32 cur = inl(addr);
 
-- 
2.25.1
