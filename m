From: Manuel Lauss <manuel.lauss@googlemail.com>
Date: Fri, 10 Jun 2011 15:23:04 +0000
Subject: [PATCH 4/4] au1200fb: switch to FB_SYS helpers
Message-Id: <1307719384-23702-5-git-send-email-manuel.lauss@googlemail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Since all video memory is in system ram, use FB_SYS helpers.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 drivers/video/Kconfig    |    7 ++++---
 drivers/video/au1200fb.c |    8 +++++---
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 549b960..5e19de9 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1756,9 +1756,10 @@ config FB_AU1100
 config FB_AU1200
 	bool "Au1200 LCD Driver"
 	depends on (FB = y) && MIPS && SOC_AU1200
-	select FB_CFB_FILLRECT
-	select FB_CFB_COPYAREA
-	select FB_CFB_IMAGEBLIT
+	select FB_SYS_FILLRECT
+	select FB_SYS_COPYAREA
+	select FB_SYS_IMAGEBLIT
+	select FB_SYS_FOPS
 	help
 	  This is the framebuffer driver for the AMD Au1200 SOC.  It can drive
 	  various panels and CRTs by passing in kernel cmd line option
diff --git a/drivers/video/au1200fb.c b/drivers/video/au1200fb.c
index 4b58f7b..b1b16d9 100644
--- a/drivers/video/au1200fb.c
+++ b/drivers/video/au1200fb.c
@@ -1502,9 +1502,11 @@ static struct fb_ops au1200fb_fb_ops = {
 	.fb_set_par	= au1200fb_fb_set_par,
 	.fb_setcolreg	= au1200fb_fb_setcolreg,
 	.fb_blank	= au1200fb_fb_blank,
-	.fb_fillrect	= cfb_fillrect,
-	.fb_copyarea	= cfb_copyarea,
-	.fb_imageblit	= cfb_imageblit,
+	.fb_fillrect	= sys_fillrect,
+	.fb_copyarea	= sys_copyarea,
+	.fb_imageblit	= sys_imageblit,
+	.fb_read	= fb_sys_read,
+	.fb_write	= fb_sys_write,
 	.fb_sync	= NULL,
 	.fb_ioctl	= au1200fb_ioctl,
 	.fb_mmap	= au1200fb_fb_mmap,
-- 
1.7.5.3

