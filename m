From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Wed, 22 Jun 2011 07:49:50 +0000
Subject: [PATCH 3/5] fbdev: sh_mobile_meram: Move private data from .h to .c
Message-Id: <1308728992-9660-4-git-send-email-dhobsong@igel.co.jp>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

There is no reason for sh_mobile_meram_priv to be in the .h file
since it should be private to sh_mobile_meram.c

Signed-off-by: Damian Hobson-Garcia <dhobsong@igel.co.jp>
---
 drivers/video/sh_mobile_meram.c |    8 ++++++++
 drivers/video/sh_mobile_meram.h |    8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/video/sh_mobile_meram.c b/drivers/video/sh_mobile_meram.c
index 371f129..cc71cbf 100644
--- a/drivers/video/sh_mobile_meram.c
+++ b/drivers/video/sh_mobile_meram.c
@@ -37,6 +37,14 @@
 #define MEQSEL1 0x40
 #define MEQSEL2 0x44
 
+struct sh_mobile_meram_priv {
+	void __iomem	*base;
+	struct mutex	lock;
+	unsigned long	used_icb;
+	int		used_meram_cache_regions;
+	unsigned long	used_meram_cache[SH_MOBILE_MERAM_ICB_NUM];
+};
+
 /* settings */
 #define MERAM_SEC_LINE 15
 #define MERAM_LINE_WIDTH 2048
diff --git a/drivers/video/sh_mobile_meram.h b/drivers/video/sh_mobile_meram.h
index 82c54fb..1615204 100644
--- a/drivers/video/sh_mobile_meram.h
+++ b/drivers/video/sh_mobile_meram.h
@@ -17,14 +17,6 @@
 #define SH_MOBILE_MERAM_CACHE_OFFSET(p)	((p) >> 16)
 #define SH_MOBILE_MERAM_CACHE_SIZE(p)	((p) & 0xffff)
 
-struct sh_mobile_meram_priv {
-	void __iomem	*base;
-	struct mutex	lock;
-	unsigned long	used_icb;
-	int		used_meram_cache_regions;
-	unsigned long	used_meram_cache[SH_MOBILE_MERAM_ICB_NUM];
-};
-
 int sh_mobile_meram_alloc_icb(const struct sh_mobile_meram_cfg *cfg,
 		   int xres,
 		   int yres,
-- 
1.7.1

