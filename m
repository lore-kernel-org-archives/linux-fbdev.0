From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 24 Jan 2012 10:00:20 +0000
Subject: [PATCH 05/16] OMAP2+: remove unneeded #include omapfb.h
Message-Id: <1327399231-20826-6-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, tony@atomide.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/io.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 3f174d5..7fee69c 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -21,7 +21,6 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/clk.h>
-#include <linux/omapfb.h>
 
 #include <asm/tlb.h>
 
-- 
1.7.4.1

