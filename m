From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Fri, 13 Oct 2017 19:42:48 +0000
Subject: [PATCH v2 2/3] backlight: tdo24m: add the reset line gpio
Message-Id: <20171013194250.9001-2-robert.jarzmik@free.fr>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171013194250.9001-1-robert.jarzmik@free.fr>
In-Reply-To: <20171013194250.9001-1-robert.jarzmik@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>

The Toppoly panels have a global reset line. Add an optional gpio
control for this line, for platforms which have the ability to drive it.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/video/backlight/tdo24m.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/backlight/tdo24m.c b/drivers/video/backlight/tdo24m.c
index e4bd63e9db6b..e4b2dfabf192 100644
--- a/drivers/video/backlight/tdo24m.c
+++ b/drivers/video/backlight/tdo24m.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/device.h>
@@ -32,6 +33,7 @@ struct tdo24m {
 	struct spi_message	msg;
 	struct spi_transfer	xfer;
 	uint8_t			*buf;
+	struct gpio_desc	*xres;
 
 	int (*adj_mode)(struct tdo24m *lcd, int mode);
 	int color_invert;
@@ -364,6 +366,7 @@ static int tdo24m_probe(struct spi_device *spi)
 	if (lcd->buf = NULL)
 		return -ENOMEM;
 
+	lcd->xres = devm_gpiod_get(&spi->dev, "reset", GPIOD_OUT_LOW);
 	m = &lcd->msg;
 	x = &lcd->xfer;
 
-- 
2.11.0

