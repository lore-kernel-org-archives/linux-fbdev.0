From: Corentin Labbe <clabbe.montjoie@gmail.com>
Date: Mon, 22 Jan 2018 12:35:00 +0000
Subject: [PATCH] video: remove unused kconfig SH_LCD_MIPI_DSI
Message-Id: <20180122123500.12359-1-clabbe.montjoie@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com
Cc: linux-fbdev@vger.kernel.org, Corentin Labbe <clabbe.montjoie@gmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

SH_LCD_MIPI_DSI is unused since commit 18b6562c243f ("fbdev: sh_mipi_dsi: remove driver")
So no need to keep it.
Fixes: 18b6562c243f ("fbdev: sh_mipi_dsi: remove driver")

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/video/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 3c20af999893..429f15b2b51a 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -8,9 +8,6 @@ menu "Graphics support"
 config HAVE_FB_ATMEL
 	bool
 
-config SH_LCD_MIPI_DSI
-	bool
-
 source "drivers/char/agp/Kconfig"
 
 source "drivers/gpu/vga/Kconfig"
-- 
2.13.6

