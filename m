From: Michael Opdenacker <michael.opdenacker@free-electrons.com>
Date: Mon, 08 Jul 2013 05:03:26 +0000
Subject: [PATCH] drivers/video: remove unused parameter in Kconfig
Message-Id: <1373259806-23067-1-git-send-email-michael.opdenacker@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Opdenacker <michael.opdenacker@free-electrons.com>

This patch proposes to remove the FB_NUC900_DEBUG kernel configuration
parameter defined in drivers/video/Kconfig, but used nowhere
in the makefiles and source code.

Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
---
 drivers/video/Kconfig | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 2e937bd..a9c0964 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -2098,13 +2098,6 @@ config GPM1040A0_320X240
         bool "Giantplus Technology GPM1040A0 320x240 Color TFT LCD"
         depends on FB_NUC900
 
-config FB_NUC900_DEBUG
-        bool "NUC900 lcd debug messages"
-        depends on FB_NUC900
-        help
-          Turn on debugging messages. Note that you can set/unset at run time
-          through sysfs
-
 config FB_SM501
 	tristate "Silicon Motion SM501 framebuffer support"
 	depends on FB && MFD_SM501
-- 
1.8.1.2

