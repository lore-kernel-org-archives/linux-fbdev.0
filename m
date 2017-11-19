From: Randy Dunlap <rdunlap@infradead.org>
Date: Sun, 19 Nov 2017 01:41:05 +0000
Subject: [PATCH] fb: intelfb: fix Kconfig symbol info in help text
Message-Id: <aa2cc6ee-c335-9ae3-98c5-1753cb2b4888@infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix Kconfig symbol typo; it should be FB_INTEL.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 drivers/video/fbdev/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-414.orig/drivers/video/fbdev/Kconfig
+++ lnx-414/drivers/video/fbdev/Kconfig
@@ -1197,7 +1197,7 @@ config FB_INTEL
           830M/845G/852GM/855GM/865G/915G/915GM/945G/945GM/965G/965GM chipsets.
           Say Y if you have and plan to use such a board.
 
-	  To make FB_INTELFB=Y work you need to say AGP_INTEL=y too.
+	  To make FB_INTEL=Y work you need to say AGP_INTEL=y too.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called intelfb.


