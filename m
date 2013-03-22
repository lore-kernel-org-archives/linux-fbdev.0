From: Wei Yongjun <weiyj.lk@gmail.com>
Date: Fri, 22 Mar 2013 11:30:42 +0000
Subject: [PATCH -next] backlight: adp8870: fix error return code in adp8870_led_probe()
Message-Id: <CAPgLHd_V1M9DaO-XfrVh5k7on7cYRiLONQiu+SGrQM81MT5+Qg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fix to return a negative error code from the error handling
case instead of 0, as returned elsewhere in this function.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/video/backlight/adp8870_bl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/backlight/adp8870_bl.c b/drivers/video/backlight/adp8870_bl.c
index 302c800..759bf23 100644
--- a/drivers/video/backlight/adp8870_bl.c
+++ b/drivers/video/backlight/adp8870_bl.c
@@ -274,12 +274,14 @@ static int adp8870_led_probe(struct i2c_client *client)
 		if (led_dat->id > 7 || led_dat->id < 1) {
 			dev_err(&client->dev, "Invalid LED ID %d\n",
 				led_dat->id);
+			ret = -EINVAL;
 			goto err;
 		}
 
 		if (pdata->bl_led_assign & (1 << (led_dat->id - 1))) {
 			dev_err(&client->dev, "LED %d used by Backlight\n",
 				led_dat->id);
+			ret = -EBUSY;
 			goto err;
 		}
 


