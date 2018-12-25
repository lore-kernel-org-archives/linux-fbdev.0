From: Kangjie Lu <kjlu@umn.edu>
Date: Tue, 25 Dec 2018 06:21:09 +0000
Subject: [PATCH] backlight: (adp8870) fix a missing check for adp8870_write
Message-Id: <20181225062109.66943-1-kjlu@umn.edu>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kjlu@umn.edu
Cc: pakki001@umn.edu, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

adp8870_write() may fail. This fix checks if adp8870_write fails, and if
so, returns its error code.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/video/backlight/adp8870_bl.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/video/backlight/adp8870_bl.c b/drivers/video/backlight/adp8870_bl.c
index 8d50e0299578..79901fb4fcd1 100644
--- a/drivers/video/backlight/adp8870_bl.c
+++ b/drivers/video/backlight/adp8870_bl.c
@@ -811,9 +811,14 @@ static ssize_t adp8870_bl_ambient_light_zone_store(struct device *dev,
 		if (!ret) {
 			reg_val &= ~(CFGR_BLV_MASK << CFGR_BLV_SHIFT);
 			reg_val |= (val - 1) << CFGR_BLV_SHIFT;
-			adp8870_write(data->client, ADP8870_CFGR, reg_val);
-		}
-		mutex_unlock(&data->lock);
+			ret = adp8870_write(data->client,
+					ADP8870_CFGR, reg_val);
+			if (ret) {
+				mutex_unlock(&data->lock);
+				return ret;
+			}
+		}	else
+			mutex_unlock(&data->lock);
 	}
 
 	return count;
-- 
2.17.2 (Apple Git-113)
