From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Date: Thu, 27 Aug 2015 17:41:15 +0000
Subject: [PATCH] backlight: lp855x: Make sure props struct is zeroed
Message-Id: <1440697275-4469-1-git-send-email-bjorn.andersson@sonymobile.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Milo Kim <milo.kim@ti.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Werner Johansson <werner.johansson@sonymobile.com>

From: Werner Johansson <werner.johansson@sonymobile.com>

The driver occasionally got stuck in suspend mode or other strange
states as those parts of the props struct were never initialized.

Signed-off-by: Werner Johansson <werner.johansson@sonymobile.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
---
 drivers/video/backlight/lp855x_bl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/lp855x_bl.c b/drivers/video/backlight/lp855x_bl.c
index 88116b493f3b..0a7f88ce1ab0 100644
--- a/drivers/video/backlight/lp855x_bl.c
+++ b/drivers/video/backlight/lp855x_bl.c
@@ -282,6 +282,7 @@ static int lp855x_backlight_register(struct lp855x *lp)
 	struct lp855x_platform_data *pdata = lp->pdata;
 	const char *name = pdata->name ? : DEFAULT_BL_NAME;
 
+	memset(&props, 0, sizeof(props));
 	props.type = BACKLIGHT_PLATFORM;
 	props.max_brightness = MAX_BRIGHTNESS;
 
-- 
1.8.2.2

