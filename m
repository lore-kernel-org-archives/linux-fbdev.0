From: Paul Bolle <pebolle@tiscali.nl>
Date: Thu, 21 Mar 2013 20:20:58 +0000
Subject: [PATCH] video: nuc900fb: remove "config FB_NUC900_DEBUG"
Message-Id: <1363897258.1390.153.camel@x61.thuisdomein>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

When the NUC900 LCD Controller Driver got added (in v3.4) a Kconfig
entry for FB_NUC900_DEBUG got added too. It has never been used. It
appears that its users were dropped during review. Anyhow, this entry
can be removed.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Untested.

 drivers/video/Kconfig | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 4c1546f..fba178b 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -2107,13 +2107,6 @@ config GPM1040A0_320X240
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
1.7.11.7

