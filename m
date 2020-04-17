From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 17 Apr 2020 11:33:10 +0000
Subject: [PATCH 3/5] backlight: led_bl: add led_access locking
Message-Id: <20200417113312.24340-3-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200417113312.24340-1-tomi.valkeinen@ti.com>
In-Reply-To: <20200417113312.24340-1-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

led_bl does not lock 'led_access' when calling led_sysfs_disable and
led_sysfs_enable, causing the below WARN. Add the locking.

WARNING: CPU: 0 PID: 223 at drivers/leds/led-core.c:353 led_sysfs_disable+0x4c/0x5c

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/backlight/led_bl.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/led_bl.c b/drivers/video/backlight/led_bl.c
index c46ecdfe8b0a..63693c4f0883 100644
--- a/drivers/video/backlight/led_bl.c
+++ b/drivers/video/backlight/led_bl.c
@@ -216,8 +216,11 @@ static int led_bl_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->bl_dev);
 	}
 
-	for (i = 0; i < priv->nb_leds; i++)
+	for (i = 0; i < priv->nb_leds; i++) {
+		mutex_lock(&priv->leds[i]->led_access);
 		led_sysfs_disable(priv->leds[i]);
+		mutex_unlock(&priv->leds[i]->led_access);
+	}
 
 	backlight_update_status(priv->bl_dev);
 
@@ -233,8 +236,11 @@ static int led_bl_remove(struct platform_device *pdev)
 	backlight_device_unregister(bl);
 
 	led_bl_power_off(priv);
-	for (i = 0; i < priv->nb_leds; i++)
+	for (i = 0; i < priv->nb_leds; i++) {
+		mutex_lock(&priv->leds[i]->led_access);
 		led_sysfs_enable(priv->leds[i]);
+		mutex_unlock(&priv->leds[i]->led_access);
+	}
 
 	return 0;
 }
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
