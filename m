From: Nishka Dasgupta <nishkadg.linux@gmail.com>
Date: Tue, 13 Aug 2019 08:59:22 +0000
Subject: [PATCH] backlight: ipaq_micro: Make structure micro_bl_props constant
Message-Id: <20190813085855.8302-1-nishkadg.linux@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lee.jones@linaro.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: Nishka Dasgupta <nishkadg.linux@gmail.com>

Static structure micro_bl_props, having type backlight_properties, is
used only once, when it is passed as the last argument to function
devm_backlight_device_register(). devm_backlight_device_register() is
defined with its last parameter being declared constant. Hence make
micro_bl_props itself constant as well.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/video/backlight/ipaq_micro_bl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/ipaq_micro_bl.c b/drivers/video/backlight/ipaq_micro_bl.c
index 1123f67c12b3..85b16cc82878 100644
--- a/drivers/video/backlight/ipaq_micro_bl.c
+++ b/drivers/video/backlight/ipaq_micro_bl.c
@@ -44,7 +44,7 @@ static const struct backlight_ops micro_bl_ops = {
 	.update_status  = micro_bl_update_status,
 };
 
-static struct backlight_properties micro_bl_props = {
+static const struct backlight_properties micro_bl_props = {
 	.type = BACKLIGHT_RAW,
 	.max_brightness = 255,
 	.power = FB_BLANK_UNBLANK,
-- 
2.19.1
