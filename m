From: Jean Delvare <jdelvare@suse.de>
Date: Sun, 31 Mar 2013 13:04:15 +0000
Subject: [PATCH] geodefb: Depend on X86_32
Message-Id: <1364735055.4223.4.camel@amber.site>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Jeff Mahoney <jeffm@suse.com>

Geode is 32-bit only so only enable it for X86_32.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
Signed-off-by: Jean Delvare <jdelvare@suse.de>
---
We have this patch in the Suse kernel tree for almost a year, it would
be great if it could finally make it upstream.

 drivers/video/geode/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/video/geode/Kconfig
+++ b/drivers/video/geode/Kconfig
@@ -3,7 +3,7 @@
 #
 config FB_GEODE
 	bool "AMD Geode family framebuffer support"
-	depends on FB && PCI && X86
+	depends on FB && PCI && X86_32
 	---help---
 	  Say 'Y' here to allow you to select framebuffer drivers for
 	  the AMD Geode family of processors.

-- 
Jean Delvare
Suse L3

