From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 07 Nov 2017 14:13:05 +0000
Subject: [PATCH 1/2] fbdev: pxa3xx: use ktime_get_ts64 for time stamps
Message-Id: <20171107141319.3390036-1-arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Himanshu Jha <himanshujha199640@gmail.com>

do_gettimeofday() is deprecated because it is not y2038 safe, so I'm
changing the calculation for the diagnostic output over to using
'timespec64'.

We really only print time deltas here, so changing it to monotonic
time makes this more robust, the correct accessor for this is
ktime_get_ts64().

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/pxa3xx-gcu.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/pxa3xx-gcu.c b/drivers/video/fbdev/pxa3xx-gcu.c
index 3366076f9e0f..ddca4425adc8 100644
--- a/drivers/video/fbdev/pxa3xx-gcu.c
+++ b/drivers/video/fbdev/pxa3xx-gcu.c
@@ -104,7 +104,7 @@ struct pxa3xx_gcu_priv {
 	wait_queue_head_t	  wait_idle;
 	wait_queue_head_t	  wait_free;
 	spinlock_t		  spinlock;
-	struct timeval 		  base_time;
+	struct timespec64	  base_time;
 
 	struct pxa3xx_gcu_batch *free;
 	struct pxa3xx_gcu_batch *ready;
@@ -126,18 +126,20 @@ gc_writel(struct pxa3xx_gcu_priv *priv, unsigned int off, unsigned long val)
 
 #define QPRINT(priv, level, msg)					\
 	do {								\
-		struct timeval tv;					\
+		struct timespec64 ts;					\
 		struct pxa3xx_gcu_shared *shared = priv->shared;	\
 		u32 base = gc_readl(priv, REG_GCRBBR);			\
 									\
-		do_gettimeofday(&tv);					\
+		ktime_get_ts64(&ts);					\
+		ts = timespec64_sub(ts, priv->base_time);		\
 									\
-		printk(level "%ld.%03ld.%03ld - %-17s: %-21s (%s, "	\
+		printk(level "%lld.%03ld.%03ld - %-17s: %-21s (%s, "	\
 			"STATUS "					\
 			"0x%02lx, B 0x%08lx [%ld], E %5ld, H %5ld, "	\
 			"T %5ld)\n",					\
-			tv.tv_sec - priv->base_time.tv_sec,		\
-			tv.tv_usec / 1000, tv.tv_usec % 1000,		\
+			(s64)(tv.tv_sec),				\
+			tv.tv_usec / NSEC_PER_MSEC,			\
+			(tv.tv_usec % NSEC_PER_MSEC) / USEC_PER_MSEC,	\
 			__func__, msg,					\
 			shared->hw_running ? "running" : "   idle",	\
 			gc_readl(priv, REG_GCISCR),			\
@@ -164,7 +166,7 @@ pxa3xx_gcu_reset(struct pxa3xx_gcu_priv *priv)
 	priv->shared->buffer_phys = priv->shared_phys;
 	priv->shared->magic = PXA3XX_GCU_SHARED_MAGIC;
 
-	do_gettimeofday(&priv->base_time);
+	ktime_get_ts64(&priv->base_time);
 
 	/* set up the ring buffer pointers */
 	gc_writel(priv, REG_GCRBLR, 0);
-- 
2.9.0

