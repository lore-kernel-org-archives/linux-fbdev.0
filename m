From: Steven Miao <realmz6@kernel.org>
Date: Sat, 12 Apr 2014 01:30:45 +0000
Subject: [PATCH] video: bf54x-lq043fb: fix build error
Message-Id: <1397266245-3144-1-git-send-email-realmz6@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: adi-buildroot-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Steven Miao <realmz6@gmail.com>

From: Steven Miao <realmz6@gmail.com>

should include linux/gpio.h

Signed-off-by: Steven Miao <realmz6@gmail.com>
---
 drivers/video/bf54x-lq043fb.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/bf54x-lq043fb.c b/drivers/video/bf54x-lq043fb.c
index 42b8f9d..d2b54f1 100644
--- a/drivers/video/bf54x-lq043fb.c
+++ b/drivers/video/bf54x-lq043fb.c
@@ -49,6 +49,7 @@
 #include <linux/spinlock.h>
 #include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
+#include <linux/gpio.h>
 
 #include <asm/blackfin.h>
 #include <asm/irq.h>
-- 
1.7.9.5

