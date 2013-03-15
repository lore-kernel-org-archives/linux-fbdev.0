From: H Hartley Sweeten <hartleys@visionengravers.com>
Date: Fri, 15 Mar 2013 22:20:26 +0000
Subject: [PATCH] video: ep93xx_fb: include <linux/io.h> for devm_ioremap()
Message-Id: <201303151520.26873.hartleys@visionengravers.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, stable@vger.kernel.org, FlorianSchandinat@gmx.de, rmallon@gmail.com, damien.cassou@lifl.fr

commit be867814 "drivers/video/ep93xx-fb.c: use devm_ functions"

Introduced a build error:

drivers/video/ep93xx-fb.c: In function 'ep93xxfb_probe':
drivers/video/ep93xx-fb.c:532: error: implicit declaration of function 'devm_ioremap'
drivers/video/ep93xx-fb.c:533: warning: assignment makes pointer from integer without a cast

Include <linux/io.h> to pickup the declaration of 'devm_ioremap'.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: <stable@vger.kernel.org>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Ryan Mallon <rmallon@gmail.com>
Cc: Damien Cassou <damien.cassou@lifl.fr>

---
 drivers/video/ep93xx-fb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/ep93xx-fb.c b/drivers/video/ep93xx-fb.c
index 3f2519d..e06cd5d 100644
--- a/drivers/video/ep93xx-fb.c
+++ b/drivers/video/ep93xx-fb.c
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/clk.h>
 #include <linux/fb.h>
+#include <linux/io.h>
 
 #include <linux/platform_data/video-ep93xx.h>
 
-- 
1.8.1.4

