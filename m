From: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Date: Thu, 27 Sep 2018 09:24:39 +0000
Subject: [RESEND PATCH v2 1/3] video: ssd1307fb: Use gpiod_set_value_cansleep() for reset
Message-Id: <1538040281-21319-1-git-send-email-michal.vokac@ysoft.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>

The reset signal can be produced by GPIO expander that can sleep.
In that case the probe function fails. Allow using GPIO expanders for
the reset signal by using the non-atomic gpiod_set_value_cansleep()
function.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
---
v2 changes: add R-by from Fabio

 drivers/video/fbdev/ssd1307fb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index ba66c02..e7ae135 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -728,9 +728,9 @@ static int ssd1307fb_probe(struct i2c_client *client,
 
 	if (par->reset) {
 		/* Reset the screen */
-		gpiod_set_value(par->reset, 0);
+		gpiod_set_value_cansleep(par->reset, 0);
 		udelay(4);
-		gpiod_set_value(par->reset, 1);
+		gpiod_set_value_cansleep(par->reset, 1);
 		udelay(4);
 	}
 
-- 
2.1.4
