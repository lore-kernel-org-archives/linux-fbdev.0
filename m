From: Lee Jones <lee.jones@linaro.org>
Date: Wed, 24 Jun 2020 14:57:15 +0000
Subject: [PATCH 2/8] backlight: lcd: Add missing kerneldoc entry for 'struct device parent'
Message-Id: <20200624145721.2590327-3-lee.jones@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200624145721.2590327-1-lee.jones@linaro.org>
In-Reply-To: <20200624145721.2590327-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: daniel.thompson@linaro.org, jingoohan1@gmail.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: Andrew Zabolotny <zap@homelink.ru>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jamey Hicks <jamey.hicks@hp.com>, stable@vger.kernel.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org

This has been missing since the conversion to 'struct device' in 2007.

Cc: <stable@vger.kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Jamey Hicks <jamey.hicks@hp.com>
Cc: Andrew Zabolotny <zap@homelink.ru>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/backlight/lcd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/lcd.c b/drivers/video/backlight/lcd.c
index 78b0333586258..db56e465aaff3 100644
--- a/drivers/video/backlight/lcd.c
+++ b/drivers/video/backlight/lcd.c
@@ -179,6 +179,7 @@ ATTRIBUTE_GROUPS(lcd_device);
  * lcd_device_register - register a new object of lcd_device class.
  * @name: the name of the new object(must be the same as the name of the
  *   respective framebuffer device).
+ * @parent: pointer to the parent's struct device .
  * @devdata: an optional pointer to be stored in the device. The
  *   methods may retrieve it by using lcd_get_data(ld).
  * @ops: the lcd operations structure.
-- 
2.25.1
