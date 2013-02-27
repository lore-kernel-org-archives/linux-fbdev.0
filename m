From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Wed, 27 Feb 2013 18:26:56 +0000
Subject: [PATCH] video: make goldfish option have a dependency on goldfish
Message-Id: <1361989616-1842-1-git-send-email-paul.gortmaker@windriver.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

Nearly all the other goldfish peripherals (mtd, keyboard, etc)
have a dependency on the main platform's GOLDFISH Kconfig item,
but this one got skipped, so add it.

Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/video/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 4c1546f..2df6d9c 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -2208,7 +2208,7 @@ config FB_XILINX
 
 config FB_GOLDFISH
 	tristate "Goldfish Framebuffer"
-	depends on FB
+	depends on FB && GOLDFISH
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-- 
1.8.1.2

