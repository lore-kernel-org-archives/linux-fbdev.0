From: Lee Jones <lee.jones@linaro.org>
Date: Wed, 08 Jul 2020 13:04:19 +0000
Subject: [PATCH 1/1] video: backlight: sky81452-backlight: Fix some kerneldoc issues
Message-Id: <20200708130419.3445042-1-lee.jones@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lee.jones@linaro.org
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, Gyungoh Yoo <jack.yoo@skyworksinc.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Firstly, all lines must begin with a '*'.  Secondly, arg descriptions
must be spelt correctly, so fix misspelling of 'gpioD_enable' and
'short_detecTion_threshold'

Fixes the following W=1 kernel build warning(s):

 drivers/video/backlight/sky81452-backlight.c:46: warning: bad line:                 If it is not defined, default name is lcd-backlight.
 drivers/video/backlight/sky81452-backlight.c:64: warning: Function parameter or member 'gpiod_enable' not described in 'sky81452_bl_platform_data'
 drivers/video/backlight/sky81452-backlight.c:64: warning: Function parameter or member 'short_detection_threshold' not described in 'sky81452_bl_platform_data'

Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Gyungoh Yoo <jack.yoo@skyworksinc.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/backlight/sky81452-backlight.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/backlight/sky81452-backlight.c b/drivers/video/backlight/sky81452-backlight.c
index 83ccb3d940fae..0ce1815850080 100644
--- a/drivers/video/backlight/sky81452-backlight.c
+++ b/drivers/video/backlight/sky81452-backlight.c
@@ -43,13 +43,13 @@
 /**
  * struct sky81452_platform_data
  * @name:	backlight driver name.
-		If it is not defined, default name is lcd-backlight.
- * @gpios_enable:GPIO descriptor which control EN pin
+ *		If it is not defined, default name is lcd-backlight.
+ * @gpiod_enable:GPIO descriptor which control EN pin
  * @enable:	Enable mask for current sink channel 1, 2, 3, 4, 5 and 6.
  * @ignore_pwm:	true if DPWMI should be ignored.
  * @dpwm_mode:	true is DPWM dimming mode, otherwise Analog dimming mode.
  * @phase_shift:true is phase shift mode.
- * @short_detecion_threshold:	It should be one of 4, 5, 6 and 7V.
+ * @short_detection_threshold:	It should be one of 4, 5, 6 and 7V.
  * @boost_current_limit:	It should be one of 2300, 2750mA.
  */
 struct sky81452_bl_platform_data {
-- 
2.25.1
