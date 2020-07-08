From: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Date: Wed, 08 Jul 2020 16:38:47 +0000
Subject: [PATCH] Replace HTTP links with HTTPS ones: BACKLIGHT CLASS/SUBSYSTEM
Message-Id: <20200708163847.15250-1-grandmaster@al2klimov.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lee.jones@linaro.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Alexander A. Klimov" <grandmaster@al2klimov.de>

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5.
 See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
 (Actually letting a shell for loop submit all this stuff for me.)

 If there are any URLs to be removed completely or at least not HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.


 drivers/video/backlight/led_bl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/led_bl.c b/drivers/video/backlight/led_bl.c
index 3f66549997c8..2c48957e9b60 100644
--- a/drivers/video/backlight/led_bl.c
+++ b/drivers/video/backlight/led_bl.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2015-2019 Texas Instruments Incorporated -  http://www.ti.com/
+ * Copyright (C) 2015-2019 Texas Instruments Incorporated -  https://www.ti.com/
  * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
  *
  * Based on pwm_bl.c
-- 
2.27.0
