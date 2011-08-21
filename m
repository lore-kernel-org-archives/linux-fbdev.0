From: Axel Lin <axel.lin@gmail.com>
Date: Sun, 21 Aug 2011 14:39:05 +0000
Subject: [PATCH] video: ep93xx-fb: add missing include of linux/module.h
Message-Id: <1313937545.13671.5.camel@phoenix>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>, Paul Mundt <lethal@linux-sh.org>, linux-fbdev@vger.kernel.org

ep93xx-fb.c uses interfaces from linux/module.h,
so it should include that file.  This patch fixes below build errors.

  CC      drivers/video/ep93xx-fb.o
drivers/video/ep93xx-fb.c:120: error: expected ')' before 'int'
drivers/video/ep93xx-fb.c:122: error: expected ')' before string constant
drivers/video/ep93xx-fb.c:409: error: 'THIS_MODULE' undeclared here (not in a function)
drivers/video/ep93xx-fb.c:645: error: expected declaration specifiers or '...' before string constant
drivers/video/ep93xx-fb.c:645: warning: data definition has no type or storage class
drivers/video/ep93xx-fb.c:645: warning: type defaults to 'int' in declaration of 'MODULE_DESCRIPTION'
drivers/video/ep93xx-fb.c:645: warning: function declaration isn't a prototype
drivers/video/ep93xx-fb.c:646: error: expected declaration specifiers or '...' before string constant
drivers/video/ep93xx-fb.c:646: warning: data definition has no type or storage class
drivers/video/ep93xx-fb.c:646: warning: type defaults to 'int' in declaration of 'MODULE_ALIAS'
drivers/video/ep93xx-fb.c:646: warning: function declaration isn't a prototype
drivers/video/ep93xx-fb.c:647: error: expected declaration specifiers or '...' before string constant
drivers/video/ep93xx-fb.c:647: warning: data definition has no type or storage class
drivers/video/ep93xx-fb.c:647: warning: type defaults to 'int' in declaration of 'MODULE_AUTHOR'
drivers/video/ep93xx-fb.c:647: warning: function declaration isn't a prototype
drivers/video/ep93xx-fb.c:649: error: expected declaration specifiers or '...' before string constant
drivers/video/ep93xx-fb.c:649: warning: data definition has no type or storage class
drivers/video/ep93xx-fb.c:649: warning: type defaults to 'int' in declaration of 'MODULE_LICENSE'
drivers/video/ep93xx-fb.c:649: warning: function declaration isn't a prototype
make[2]: *** [drivers/video/ep93xx-fb.o] Error 1
make[1]: *** [drivers/video] Error 2
make: *** [drivers] Error 2

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/video/ep93xx-fb.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/video/ep93xx-fb.c b/drivers/video/ep93xx-fb.c
index 40e5f17..8133a9d 100644
--- a/drivers/video/ep93xx-fb.c
+++ b/drivers/video/ep93xx-fb.c
@@ -17,6 +17,7 @@
  *
  */
 
+#include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
-- 
1.7.4.1



