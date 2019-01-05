From: Aditya Pakki <pakki001@umn.edu>
Date: Sat, 05 Jan 2019 18:48:07 +0000
Subject: [PATCH] v2 bakclight: fix missing checks in ambient_light_zone_store
Message-Id: <20190105184807.4827-1-pakki001@umn.edu>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: pakki001@umn.edu
Cc: kjlu@umn.edu, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

In adp8870_bl_ambient_light_zone_store, set, clear, and write
can return an error but are not checked. The fix adds a check for these
cases and returns -1 to match the return type (ssize_t).

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/video/backlight/adp8870_bl.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/video/backlight/adp8870_bl.c b/drivers/video/backlight/adp8870_bl.c
index 8d50e0299578..56a640587a82 100644
--- a/drivers/video/backlight/adp8870_bl.c
+++ b/drivers/video/backlight/adp8870_bl.c
@@ -800,10 +800,14 @@ static ssize_t adp8870_bl_ambient_light_zone_store(struct device *dev,
 
 	if (val = 0) {
 		/* Enable automatic ambient light sensing */
-		adp8870_set_bits(data->client, ADP8870_MDCR, CMP_AUTOEN);
+		ret = adp8870_set_bits(data->client, ADP8870_MDCR, CMP_AUTOEN);
+		if (ret < 0)
+			goto adp8870_bl_err;
 	} else if ((val > 0) && (val < 6)) {
 		/* Disable automatic ambient light sensing */
-		adp8870_clr_bits(data->client, ADP8870_MDCR, CMP_AUTOEN);
+		ret = adp8870_clr_bits(data->client, ADP8870_MDCR, CMP_AUTOEN);
+		if (ret < 0)
+			goto adp8870_bl_err;
 
 		/* Set user supplied ambient light zone */
 		mutex_lock(&data->lock);
@@ -811,12 +815,18 @@ static ssize_t adp8870_bl_ambient_light_zone_store(struct device *dev,
 		if (!ret) {
 			reg_val &= ~(CFGR_BLV_MASK << CFGR_BLV_SHIFT);
 			reg_val |= (val - 1) << CFGR_BLV_SHIFT;
-			adp8870_write(data->client, ADP8870_CFGR, reg_val);
+			ret = adp8870_write(data->client, ADP8870_CFGR,
+						reg_val);
 		}
 		mutex_unlock(&data->lock);
+		if (ret < 0)
+			goto adp8870_bl_err;
 	}
 
 	return count;
+
+adp8870_bl_err:
+	return -1;
 }
 static DEVICE_ATTR(ambient_light_zone, 0664,
 		adp8870_bl_ambient_light_zone_show,
-- 
2.17.1
