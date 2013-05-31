From: Richard Genoud <richard.genoud@gmail.com>
Date: Fri, 31 May 2013 14:28:39 +0000
Subject: [PATCH 2/2] atmel_lcdfb: blank the backlight on remove
Message-Id: <1370010519-18691-2-git-send-email-richard.genoud@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1370010519-18691-1-git-send-email-richard.genoud@gmail.com>
In-Reply-To: <1370010519-18691-1-git-send-email-richard.genoud@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Richard Genoud <richard.genoud@gmail.com>

When removing atmel_lcdfb module, the backlight is unregistered but not
blanked. (only for CONFIG_BACKLIGHT_ATMEL_LCDC case).
This can result in the screen going full white depending on how the PWM
is wired.

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 drivers/video/atmel_lcdfb.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
index 6e6491f..e00318f 100644
--- a/drivers/video/atmel_lcdfb.c
+++ b/drivers/video/atmel_lcdfb.c
@@ -223,8 +223,13 @@ static void init_backlight(struct atmel_lcdfb_info *sinfo)
 
 static void exit_backlight(struct atmel_lcdfb_info *sinfo)
 {
-	if (sinfo->backlight)
+	if (sinfo->backlight) {
+		if (sinfo->backlight->ops) {
+			sinfo->backlight->props.power = FB_BLANK_POWERDOWN;
+			sinfo->backlight->ops->update_status(sinfo->backlight);
+		}
 		backlight_device_unregister(sinfo->backlight);
+	}
 }
 
 #else
-- 
1.7.10.4

