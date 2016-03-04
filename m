From: Wang Hongcheng <annie.wang@amd.com>
Date: Fri, 04 Mar 2016 02:10:06 +0000
Subject: [PATCH] video: AMBA CLCD: Remove duplicated include in amba-clcd.c
Message-Id: <1457057406-4069-1-git-send-email-annie.wang@amd.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King <linux@arm.linux.org.uk>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>, SPG_Linux_Kernel <SPG_Linux_Kernel@amd.com>
Cc: Wang Hongcheng <annie.wang@amd.com>

The header file asm/sizes.h is unnecessary.
And it can also be compiled under X86 arch after the removal.

Signed-off-by: Wang Hongcheng <annie.wang@amd.com>
---
 drivers/video/fbdev/amba-clcd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba-clcd.c
index 9362424..1a1ed80 100644
--- a/drivers/video/fbdev/amba-clcd.c
+++ b/drivers/video/fbdev/amba-clcd.c
@@ -34,8 +34,6 @@
 #include <video/of_display_timing.h>
 #include <video/videomode.h>
 
-#include <asm/sizes.h>
-
 #define to_clcd(info)	container_of(info, struct clcd_fb, fb)
 
 /* This is limited to 16 characters when displayed by X startup */
-- 
1.9.1

