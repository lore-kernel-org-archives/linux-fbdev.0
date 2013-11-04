From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 04 Nov 2013 08:42:30 +0000
Subject: [PATCH] video/logo: Remove MIPS-specific include section
Message-Id: <1383554550-20901-1-git-send-email-geert@linux-m68k.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-fbdev@vger.kernel.org, linux-mips@linux-mips.org, Geert Uytterhoeven <geert@linux-m68k.org>

Since commit 41702d9a4fffa9e25b2ad9d4af09b3013fa155e1 ("logo.c: get rid of
mips_machgroup") there's no longer a need to include <asm/bootinfo.h> on
MIPS.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/video/logo/logo.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/video/logo/logo.c b/drivers/video/logo/logo.c
index 080c35b34bbb..b670cbda38e3 100644
--- a/drivers/video/logo/logo.c
+++ b/drivers/video/logo/logo.c
@@ -17,10 +17,6 @@
 #include <asm/setup.h>
 #endif
 
-#ifdef CONFIG_MIPS
-#include <asm/bootinfo.h>
-#endif
-
 static bool nologo;
 module_param(nologo, bool, 0);
 MODULE_PARM_DESC(nologo, "Disables startup logo");
-- 
1.7.9.5

