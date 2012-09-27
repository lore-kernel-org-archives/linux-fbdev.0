From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 27 Sep 2012 10:41:29 +0000
Subject: [PATCH] video: s3c-fb: fix help message for FB_S3C_DEBUG_REGWRITE
Message-Id: <001501cd9c9c$a74fd2b0$f5ef7810$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The help message of config FB_S3C_DEBUG_REGWRITE is fixed,
because printk(KERN_DEBUG) was replaced with pr_debug().

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index ab621f8..d823064 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -2057,7 +2057,7 @@ config FB_S3C_DEBUG_REGWRITE
        bool "Debug register writes"
        depends on FB_S3C
        ---help---
-         Show all register writes via printk(KERN_DEBUG)
+         Show all register writes via pr_debug()
 
 config FB_S3C2410
 	tristate "S3C2410 LCD framebuffer support"
-- 
1.7.1


