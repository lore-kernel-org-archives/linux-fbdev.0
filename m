From: Bhushan Shah <bshah@kde.org>
Date: Wed, 21 Jun 2017 05:36:50 +0000
Subject: [PATCH] backlight: lm3630a: bump REG_MAX value to 0x50 instead of 0x1F
Message-Id: <20170621052450.2258-1-bshah@kde.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bhushan Shah <bshah@kde.org>

In the lm3630a_chip_init we try to write to 0x50 register, which is
higher value then the max_register value, this resulted in regmap_write
return -EIO.

Fix this by bumping REG_MAX value to 0x50.

Signed-off-by: Bhushan Shah <bshah@kde.org>
Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/video/backlight/lm3630a_bl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index 60d6c2ac87aa..42496b6c09d0 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -31,7 +31,8 @@
 #define REG_FAULT	0x0B
 #define REG_PWM_OUTLOW	0x12
 #define REG_PWM_OUTHIGH	0x13
-#define REG_MAX		0x1F
+#define REG_FLTR_STR	0x50
+#define REG_MAX		0x50
 
 #define INT_DEBOUNCE_MSEC	10
 struct lm3630a_chip {
@@ -80,7 +81,7 @@ static int lm3630a_chip_init(struct lm3630a_chip *pchip)
 
 	usleep_range(1000, 2000);
 	/* set Filter Strength Register */
-	rval = lm3630a_write(pchip, 0x50, 0x03);
+	rval = lm3630a_write(pchip, FLTR_STR, 0x03);
 	/* set Cofig. register */
 	rval |= lm3630a_update(pchip, REG_CONFIG, 0x07, pdata->pwm_ctrl);
 	/* set boost control */
-- 
2.13.0

