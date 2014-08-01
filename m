From: Pawel Moll <pawel.moll@arm.com>
Date: Fri, 01 Aug 2014 14:43:34 +0000
Subject: [PATCH] video: ARM CLCD: Fix DT-related build problems
Message-Id: <1406904214-7360-1-git-send-email-pawel.moll@arm.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

This patch fixes the following error when !CONFIG_OF:

drivers/video/fbdev/amba-clcd.c:800:54: warning: ‘struct amba_dev’ declared inside parameter list [enabled by default]
 static struct clcd_board *clcdfb_of_get_board(struct amba_dev *dev)
                                                      ^
and adds a missing Kconfig select causing this
when CONFIG_OF && !CONFIG_FB_MODE_HELPERS:

drivers/video/fbdev/amba-clcd.c:567: undefined reference to `fb_videomode_from_videomode'

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---

Hi Tomi,

This fixes two small problems detected in next by the kbuild test robot
(thanks, Fengguang!) Hope you can apply it before the merge window.

Cheers!

Pawel

 drivers/video/fbdev/Kconfig     | 1 +
 drivers/video/fbdev/amba-clcd.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index a518fe5..7eed249 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -280,6 +280,7 @@ config FB_ARMCLCD
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
+	select FB_MODE_HELPERS if OF
 	select VIDEOMODE_HELPERS if OF
 	help
 	  This framebuffer device driver is for the ARM PrimeCell PL110
diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba-clcd.c
index 23b3519..beadd3e 100644
--- a/drivers/video/fbdev/amba-clcd.c
+++ b/drivers/video/fbdev/amba-clcd.c
@@ -797,7 +797,7 @@ static struct clcd_board *clcdfb_of_get_board(struct amba_device *dev)
 	return board;
 }
 #else
-static struct clcd_board *clcdfb_of_get_board(struct amba_dev *dev)
+static struct clcd_board *clcdfb_of_get_board(struct amba_device *dev)
 {
 	return NULL;
 }
-- 
1.9.1

