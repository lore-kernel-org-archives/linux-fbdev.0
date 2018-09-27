From: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Date: Thu, 27 Sep 2018 09:24:40 +0000
Subject: [RESEND PATCH v2 2/3] video: ssd1307fb: Do not hard code active-low reset sequence
Message-Id: <1538040281-21319-2-git-send-email-michal.vokac@ysoft.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1538040281-21319-1-git-send-email-michal.vokac@ysoft.com>
In-Reply-To: <1538040281-21319-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>

The SSD130x OLED display reset signal is active low. Now the reset
sequence is implemented in such a way that users are forced to
define reset-gpios as GPIO_ACTIVE_HIGH in DT to make the reset work.

Do not hard code the active-low sequence into the driver but instead
allow the user to specify the gpio as GPIO_ACTIVE_LOW to reflect
the real world.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
v2 changes: Split the DT changes into separate patch.

 drivers/video/fbdev/ssd1307fb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index e7ae135..7b5bc42 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -728,10 +728,10 @@ static int ssd1307fb_probe(struct i2c_client *client,
 
 	if (par->reset) {
 		/* Reset the screen */
-		gpiod_set_value_cansleep(par->reset, 0);
-		udelay(4);
 		gpiod_set_value_cansleep(par->reset, 1);
 		udelay(4);
+		gpiod_set_value_cansleep(par->reset, 0);
+		udelay(4);
 	}
 
 	if (par->vbat_reg) {
-- 
2.1.4
