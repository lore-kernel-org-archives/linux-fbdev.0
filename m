From: Ondrej Zary <linux@rainbow-software.org>
Date: Mon, 24 Aug 2015 19:37:27 +0000
Subject: [PATCH 3/4] [resend #2] fb_ddc: Allow I2C adapters without SCL read capability
Message-Id: <1440445048-24694-3-git-send-email-linux@rainbow-software.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440445048-24694-1-git-send-email-linux@rainbow-software.org>
In-Reply-To: <1440445048-24694-1-git-send-email-linux@rainbow-software.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Krzysztof Helt <krzysztof.h1@wp.pl>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

i2c-algo-bit allows I2C adapters without SCL read capability to work but
fb_ddc_read fails to work on them.

Fix fb_ddc_read to work with I2C adapters not capable of reading SCL.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 drivers/video/fbdev/core/fb_ddc.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/core/fb_ddc.c b/drivers/video/fbdev/core/fb_ddc.c
index 94322cc..22c694a 100644
--- a/drivers/video/fbdev/core/fb_ddc.c
+++ b/drivers/video/fbdev/core/fb_ddc.c
@@ -69,10 +69,11 @@ unsigned char *fb_ddc_read(struct i2c_adapter *adapter)
 		algo_data->setscl(algo_data->data, 1);
 		for (j = 0; j < 5; j++) {
 			msleep(10);
-			if (algo_data->getscl(algo_data->data))
+			if (algo_data->getscl &&
+			    algo_data->getscl(algo_data->data))
 				break;
 		}
-		if (j = 5)
+		if (algo_data->getscl && j = 5)
 			continue;
 
 		algo_data->setsda(algo_data->data, 0);
@@ -91,7 +92,8 @@ unsigned char *fb_ddc_read(struct i2c_adapter *adapter)
 		algo_data->setscl(algo_data->data, 1);
 		for (j = 0; j < 10; j++) {
 			msleep(10);
-			if (algo_data->getscl(algo_data->data))
+			if (algo_data->getscl &&
+			    algo_data->getscl(algo_data->data))
 				break;
 		}
 
-- 
Ondrej Zary

