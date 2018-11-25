From: Nishad Kamdar <nishadkamdar@gmail.com>
Date: Sun, 25 Nov 2018 11:41:01 +0000
Subject: [PATCH 07/26] Staging: fbtft: fb_sh1106: Switch to the gpio descriptor interface
Message-Id: <efb6414a9e3e04f766188c4e6aee8d125b1cdd2d.1543142440.git.nishadkamdar@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1543142440.git.nishadkamdar@gmail.com>
In-Reply-To: <cover.1543142440.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org

This switches the fb_sh1106.c to use GPIO descriptors
rather than numerical gpios.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/fbtft/fb_sh1106.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_sh1106.c b/drivers/staging/fbtft/fb_sh1106.c
index 00096f8d249a..6f7249493ea3 100644
--- a/drivers/staging/fbtft/fb_sh1106.c
+++ b/drivers/staging/fbtft/fb_sh1106.c
@@ -9,7 +9,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 
 #include "fbtft.h"
-- 
2.17.1
