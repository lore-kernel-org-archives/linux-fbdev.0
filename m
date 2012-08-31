From: Axel Lin <axel.lin@gmail.com>
Date: Fri, 31 Aug 2012 13:39:03 +0000
Subject: [PATCH] video: mbxfb: Include linux/io.h instead of asm/io.h
Message-Id: <1346420343.3107.0.camel@phoenix>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Mathieu Poirier <mathieu.poirier@linaro.org>, Damien Cassou <damien.cassou@lifl.fr>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

This fixes below build error:

  CC [M]  drivers/video/mbx/mbxfb.o
drivers/video/mbx/mbxfb.c: In function 'mbxfb_probe':
drivers/video/mbx/mbxfb.c:942:2: error: implicit declaration of function 'devm_ioremap_nocache' [-Werror=implicit-function-declaration]
drivers/video/mbx/mbxfb.c:942:22: warning: assignment makes pointer from integer without a cast [enabled by default]
drivers/video/mbx/mbxfb.c:952:21: warning: assignment makes pointer from integer without a cast [enabled by default]
cc1: some warnings being treated as errors

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/video/mbx/mbxfb.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/mbx/mbxfb.c b/drivers/video/mbx/mbxfb.c
index 9229acf..6563e50 100644
--- a/drivers/video/mbx/mbxfb.c
+++ b/drivers/video/mbx/mbxfb.c
@@ -26,8 +26,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/uaccess.h>
-
-#include <asm/io.h>
+#include <linux/io.h>
 
 #include <video/mbxfb.h>
 
-- 
1.7.9.5




