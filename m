From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 26 Jan 2012 10:38:45 +0000
Subject: [PATCH] video: s3c-fb: fix checkpatch error
Message-Id: <000e01ccdc16$adee0430$09ca0c90$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1301642247-20926-1-git-send-email-jg1.han@samsung.com>
In-Reply-To: <1301642247-20926-1-git-send-email-jg1.han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch fixes the checkpatch error listed below:

ERROR: trailing statements should be on next line

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/s3c-fb.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 7c5158d..389189a 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -48,7 +48,8 @@
 #undef writel
 #define writel(v, r) do { \
 	printk(KERN_DEBUG "%s: %08x => %p\n", __func__, (unsigned int)v, r); \
-	__raw_writel(v, r); } while (0)
+	__raw_writel(v, r); \
+} while (0)
 #endif /* FB_S3C_DEBUG_REGWRITE */
 
 /* irq_flags bits */
-- 
1.7.1


