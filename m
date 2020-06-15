From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date: Mon, 15 Jun 2020 07:58:13 +0000
Subject: [PATCH 4/6] video: backlight: tosa_lcd: convert to use i2c_new_client_device()
Message-Id: <20200615075816.2848-5-wsa+renesas@sang-engineering.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200615075816.2848-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20200615075816.2848-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Lee Jones <lee.jones@linaro.org>

Move away from the deprecated API and return the shiny new ERRPTR where
useful.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
---

I'd like to push it via I2C for 5.8-rc2.

 drivers/video/backlight/tosa_lcd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/tosa_lcd.c b/drivers/video/backlight/tosa_lcd.c
index e8ab583e5098..113116d3585c 100644
--- a/drivers/video/backlight/tosa_lcd.c
+++ b/drivers/video/backlight/tosa_lcd.c
@@ -107,7 +107,7 @@ static void tosa_lcd_tg_on(struct tosa_lcd_data *data)
 	/* TG LCD GVSS */
 	tosa_tg_send(spi, TG_PINICTL, 0x0);
 
-	if (!data->i2c) {
+	if (IS_ERR_OR_NULL(data->i2c)) {
 		/*
 		 * after the pannel is powered up the first time,
 		 * we can access the i2c bus so probe for the DAC
@@ -119,7 +119,7 @@ static void tosa_lcd_tg_on(struct tosa_lcd_data *data)
 			.addr	= DAC_BASE,
 			.platform_data = data->spi,
 		};
-		data->i2c = i2c_new_device(adap, &info);
+		data->i2c = i2c_new_client_device(adap, &info);
 	}
 }
 
-- 
2.27.0
