From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 07 May 2012 00:20:09 +0000
Subject: [PATCH] video: s3c-fb: use pr_debug instead of printk
Message-Id: <003701cd2be7$298eda40$7cac8ec0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch uses pr_debug instead of printk to allow dynamic debugging.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/s3c-fb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index ecb82bb..038546a 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -47,7 +47,7 @@
 #ifdef CONFIG_FB_S3C_DEBUG_REGWRITE
 #undef writel
 #define writel(v, r) do { \
-	printk(KERN_DEBUG "%s: %08x => %p\n", __func__, (unsigned int)v, r); \
+	pr_debug("%s: %08x => %p\n", __func__, (unsigned int)v, r); \
 	__raw_writel(v, r); \
 } while (0)
 #endif /* FB_S3C_DEBUG_REGWRITE */
-- 
1.7.1


