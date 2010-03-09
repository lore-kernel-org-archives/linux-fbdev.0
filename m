From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 09 Mar 2010 16:04:19 +0000
Subject: [PATCH] fbdev: bfin-lq035q1-fb: remove duplicated #include
Message-Id: <1268150659-27335-1-git-send-email-vapier@gentoo.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, Huang Weiyi <weiyi.huang@gmail.com>

From: Huang Weiyi <weiyi.huang@gmail.com>

Remove duplicated #include('s) in
  drivers/video/bfin-lq035q1-fb.c

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 drivers/video/bfin-lq035q1-fb.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/video/bfin-lq035q1-fb.c b/drivers/video/bfin-lq035q1-fb.c
index b690c26..0387236 100644
--- a/drivers/video/bfin-lq035q1-fb.c
+++ b/drivers/video/bfin-lq035q1-fb.c
@@ -22,7 +22,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
-#include <linux/dma-mapping.h>
 
 #include <asm/blackfin.h>
 #include <asm/irq.h>
-- 
1.7.0.2

