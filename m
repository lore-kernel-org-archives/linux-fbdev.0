From: Gaurav Singh <gaurav1086@gmail.com>
Date: Sun, 26 Jul 2020 05:20:45 +0000
Subject: [PATCH] [video/fbdev] mbxfb_remove: fix null pointer dereference
Message-Id: <20200726052047.9856-1-gaurav1086@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gaurav1086@gmail.com, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Daniel Vetter <daniel.vetter@ffwll.ch>, Jani Nikula <jani.nikula@intel.com>, "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>, "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

Function mbxfb_debugfs_remove() accesses fbi->par without NULL check,
hence do the NULL check in the caller mbxfb_remove().

Signed-off-by: Gaurav Singh <gaurav1086@gmail.com>
---
 drivers/video/fbdev/mbx/mbxfb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/mbx/mbxfb.c b/drivers/video/fbdev/mbx/mbxfb.c
index 6dc287c819cb..515c0cda1994 100644
--- a/drivers/video/fbdev/mbx/mbxfb.c
+++ b/drivers/video/fbdev/mbx/mbxfb.c
@@ -1012,11 +1012,10 @@ static int mbxfb_remove(struct platform_device *dev)
 
 	write_reg_dly(SYSRST_RST, SYSRST);
 
-	mbxfb_debugfs_remove(fbi);
-
 	if (fbi) {
 		struct mbxfb_info *mfbi = fbi->par;
 
+		mbxfb_debugfs_remove(fbi);
 		unregister_framebuffer(fbi);
 		if (mfbi) {
 			if (mfbi->platform_remove)
-- 
2.17.1
