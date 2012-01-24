From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 24 Jan 2012 10:00:29 +0000
Subject: [PATCH 14/16] OMAP: Remove OMAP_TAG_LCD and OMAP_TAG_FBMEM
Message-Id: <1327399231-20826-15-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, tony@atomide.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

These tags are no longer used and can be removed.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/plat-omap/include/plat/board.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/board.h b/arch/arm/plat-omap/include/plat/board.h
index 97126df..d5eb4c8 100644
--- a/arch/arm/plat-omap/include/plat/board.h
+++ b/arch/arm/plat-omap/include/plat/board.h
@@ -28,9 +28,7 @@ enum {
 
 /* Different peripheral ids */
 #define OMAP_TAG_CLOCK		0x4f01
-#define OMAP_TAG_LCD		0x4f05
 #define OMAP_TAG_GPIO_SWITCH	0x4f06
-#define OMAP_TAG_FBMEM		0x4f08
 #define OMAP_TAG_STI_CONSOLE	0x4f09
 #define OMAP_TAG_CAMERA_SENSOR	0x4f0a
 
-- 
1.7.4.1

