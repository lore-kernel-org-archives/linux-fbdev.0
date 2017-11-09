From: Kees Cook <keescook@chromium.org>
Date: Thu, 09 Nov 2017 18:48:40 +0000
Subject: [PATCH] video: fbdev: pxa3xx_gcu: Convert timers to use timer_setup()
Message-Id: <20171109184840.GA115388@beast>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Himanshu Jha <himanshujha199640@gmail.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

In preparation for unconditionally passing the struct timer_list pointer to
all timer callbacks, switch to using the new timer_setup() and from_timer()
to pass the timer pointer explicitly.

This also fixes the use of the "priv" variable in QERROR(), since it was
pointing to struct timer_list, not struct pxa3xx_gcu_priv.

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Himanshu Jha <himanshujha199640@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
If you can take this for v4.15, please do. Otherwise, I can carry it in the
timers tree in late rc1. Thanks!
---
 drivers/video/fbdev/pxa3xx-gcu.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/pxa3xx-gcu.c b/drivers/video/fbdev/pxa3xx-gcu.c
index 164fb524744a..208cd5a5e15c 100644
--- a/drivers/video/fbdev/pxa3xx-gcu.c
+++ b/drivers/video/fbdev/pxa3xx-gcu.c
@@ -512,24 +512,26 @@ pxa3xx_gcu_mmap(struct file *file, struct vm_area_struct *vma)
 
 #ifdef PXA3XX_GCU_DEBUG_TIMER
 static struct timer_list pxa3xx_gcu_debug_timer;
+static struct pxa3xx_gcu_priv *debug_timer_priv;
 
-static void pxa3xx_gcu_debug_timedout(unsigned long ptr)
+static void pxa3xx_gcu_debug_timedout(struct timer_list *unused)
 {
-	struct pxa3xx_gcu_priv *priv = (struct pxa3xx_gcu_priv *) ptr;
+	struct pxa3xx_gcu_priv *priv = debug_timer_priv;
 
 	QERROR("Timer DUMP");
 
-	/* init the timer structure */
-	setup_timer(&pxa3xx_gcu_debug_timer, pxa3xx_gcu_debug_timedout, ptr);
 	mod_timer(&pxa3xx_gcu_debug_timer, jiffies + 5 * HZ);
 }
 
-static void pxa3xx_gcu_init_debug_timer(void)
+static void pxa3xx_gcu_init_debug_timer(struct pxa3xx_gcu_priv *priv)
 {
-	pxa3xx_gcu_debug_timedout((unsigned long) &pxa3xx_gcu_debug_timer);
+	/* init the timer structure */
+	debug_timer_priv = priv;
+	timer_setup(&pxa3xx_gcu_debug_timer, pxa3xx_gcu_debug_timedout, 0);
+	pxa3xx_gcu_debug_timedout(NULL);
 }
 #else
-static inline void pxa3xx_gcu_init_debug_timer(void) {}
+static inline void pxa3xx_gcu_init_debug_timer(struct pxa3xx_gcu_priv *) {}
 #endif
 
 static int
@@ -666,7 +668,7 @@ static int pxa3xx_gcu_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, priv);
 	priv->resource_mem = r;
 	pxa3xx_gcu_reset(priv);
-	pxa3xx_gcu_init_debug_timer();
+	pxa3xx_gcu_init_debug_timer(priv);
 
 	dev_info(dev, "registered @0x%p, DMA 0x%p (%d bytes), IRQ %d\n",
 			(void *) r->start, (void *) priv->shared_phys,
-- 
2.7.4


-- 
Kees Cook
Pixel Security
