From: Jesper Juhl <jj@chaosbits.net>
Date: Thu, 23 Jun 2011 22:35:17 +0000
Subject: [PATCH 18/37] Remove unneeded version.h includes from
Message-Id: <alpine.LNX.2.00.1106240032560.17688@swampdragon.chaosbits.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LNX.2.00.1106232344480.17688@swampdragon.chaosbits.net>
In-Reply-To: <alpine.LNX.2.00.1106232344480.17688@swampdragon.chaosbits.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: trivial@kernel.org, Michael Hennerich <michael.hennerich@analog.com>, Richard Purdie <rpurdie@rpsys.net>, Paul Mundt <lethal@linux-sh.org>, device-drivers-devel@blackfin.uclinux.org, linux-fbdev@vger.kernel.org

It was pointed out by 'make versioncheck' that some includes of
linux/version.h are not needed in drivers/video/.
This patch removes them.

Signed-off-by: Jesper Juhl <jj@chaosbits.net>
---
 drivers/video/backlight/adp8860_bl.c |    1 -
 drivers/video/backlight/adp8870_bl.c |    1 -
 drivers/video/pxa3xx-gcu.c           |    2 --
 drivers/video/xilinxfb.c             |    1 -
 4 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/video/backlight/adp8860_bl.c b/drivers/video/backlight/adp8860_bl.c
index d2a96a4..24a6dfd 100644
--- a/drivers/video/backlight/adp8860_bl.c
+++ b/drivers/video/backlight/adp8860_bl.c
@@ -7,7 +7,6 @@
  */
 
 #include <linux/module.h>
-#include <linux/version.h>
 #include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/pm.h>
diff --git a/drivers/video/backlight/adp8870_bl.c b/drivers/video/backlight/adp8870_bl.c
index 05a8832..383c4c3 100644
--- a/drivers/video/backlight/adp8870_bl.c
+++ b/drivers/video/backlight/adp8870_bl.c
@@ -7,7 +7,6 @@
  */
 
 #include <linux/module.h>
-#include <linux/version.h>
 #include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/pm.h>
diff --git a/drivers/video/pxa3xx-gcu.c b/drivers/video/pxa3xx-gcu.c
index 0283c70..d8de557 100644
--- a/drivers/video/pxa3xx-gcu.c
+++ b/drivers/video/pxa3xx-gcu.c
@@ -31,8 +31,6 @@
  */
 
 #include <linux/module.h>
-#include <linux/version.h>
-
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/miscdevice.h>
diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
index 77dea01..fcb6cd9 100644
--- a/drivers/video/xilinxfb.c
+++ b/drivers/video/xilinxfb.c
@@ -23,7 +23,6 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/version.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-- 
1.7.5.2


-- 
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.

