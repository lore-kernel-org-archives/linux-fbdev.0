From: Ondrej Zary <linux@rainbow-software.org>
Date: Thu, 24 Sep 2015 22:14:13 +0000
Subject: [PATCH v2 1/2] fb_ddc: Allow I2C adapters without SCL read capability
Message-Id: <1443132854-31786-1-git-send-email-linux@rainbow-software.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Krzysztof Helt <krzysztof.h1@wp.pl>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

i2c-algo-bit allows I2C adapters without SCL read capability to work
but fb_ddc_read fails to work on them.

Fix fb_ddc_read to work with I2C adapters not capable of reading SCL.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
---
 drivers/video/fbdev/core/fb_ddc.c |   28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/video/fbdev/core/fb_ddc.c b/drivers/video/fbdev/core/fb_ddc.c
index 94322cc..8bf5f2f 100644
--- a/drivers/video/fbdev/core/fb_ddc.c
+++ b/drivers/video/fbdev/core/fb_ddc.c
@@ -67,13 +67,17 @@ unsigned char *fb_ddc_read(struct i2c_adapter *adapter)
 		msleep(13);
 
 		algo_data->setscl(algo_data->data, 1);
-		for (j = 0; j < 5; j++) {
-			msleep(10);
-			if (algo_data->getscl(algo_data->data))
-				break;
+		if (algo_data->getscl) {
+			for (j = 0; j < 5; j++) {
+				msleep(10);
+				if (algo_data->getscl(algo_data->data))
+					break;
+			}
+			if (j = 5)
+				continue;
+		} else {
+			udelay(algo_data->udelay);
 		}
-		if (j = 5)
-			continue;
 
 		algo_data->setsda(algo_data->data, 0);
 		msleep(15);
@@ -89,10 +93,14 @@ unsigned char *fb_ddc_read(struct i2c_adapter *adapter)
 		msleep(15);
 
 		algo_data->setscl(algo_data->data, 1);
-		for (j = 0; j < 10; j++) {
-			msleep(10);
-			if (algo_data->getscl(algo_data->data))
-				break;
+		if (algo_data->getscl) {
+			for (j = 0; j < 10; j++) {
+				msleep(10);
+				if (algo_data->getscl(algo_data->data))
+					break;
+			}
+		} else {
+			udelay(algo_data->udelay);
 		}
 
 		algo_data->setsda(algo_data->data, 1);
-- 
Ondrej Zary

