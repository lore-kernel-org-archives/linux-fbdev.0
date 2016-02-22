From: "Maciej W. Rozycki" <macro@linux-mips.org>
Date: Mon, 22 Feb 2016 01:55:07 +0000
Subject: [PATCH 2/7] video: fbdev: pmag-aa-fb: Enable building as a module
Message-Id: <alpine.LFD.2.20.1602220137520.7431@eddie.linux-mips.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LFD.2.20.1602220110330.7431@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.20.1602220110330.7431@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

With the current TURBOchannel API support is automagical.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-pmag-aa-module.patch
Index: linux-20160211-4maxp64/drivers/video/fbdev/Kconfig
=================================--- linux-20160211-4maxp64.orig/drivers/video/fbdev/Kconfig
+++ linux-20160211-4maxp64/drivers/video/fbdev/Kconfig
@@ -1808,8 +1808,8 @@ config FB_HIT
 	  frame buffer card.
 
 config FB_PMAG_AA
-	bool "PMAG-AA TURBOchannel framebuffer support"
-	depends on (FB = y) && TC
+	tristate "PMAG-AA TURBOchannel framebuffer support"
+	depends on FB && TC
  	select FB_CFB_FILLRECT
  	select FB_CFB_COPYAREA
  	select FB_CFB_IMAGEBLIT
