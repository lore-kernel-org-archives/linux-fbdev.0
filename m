From: Steven Miao <realmz6@kernel.org>
Date: Tue, 15 Apr 2014 07:17:19 +0000
Subject: [PATCH RESEND] video: bf54x-lq043fb: fix build error
Message-Id: <1397546239-6650-1-git-send-email-realmz6@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: adi-buildroot-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Steven Miao <realmz6@gmail.com>

From: Steven Miao <realmz6@gmail.com>

include <linux/gpio.h>, drop <asm/gpio.h>

Signed-off-by: Steven Miao <realmz6@gmail.com>
---
 drivers/video/bf54x-lq043fb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/bf54x-lq043fb.c b/drivers/video/bf54x-lq043fb.c
index 42b8f9d..e2c42ad 100644
--- a/drivers/video/bf54x-lq043fb.c
+++ b/drivers/video/bf54x-lq043fb.c
@@ -49,13 +49,13 @@
 #include <linux/spinlock.h>
 #include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
+#include <linux/gpio.h>
 
 #include <asm/blackfin.h>
 #include <asm/irq.h>
 #include <asm/dpmc.h>
 #include <asm/dma-mapping.h>
 #include <asm/dma.h>
-#include <asm/gpio.h>
 #include <asm/portmux.h>
 
 #include <mach/bf54x-lq043.h>
-- 
1.7.9.5

