From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 24 Oct 2013 06:50:50 +0000
Subject: [PATCH] drm/omap: fix (un)registering irqs inside an irq handler
Message-Id: <1382597450-23066-1-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

omapdrm (un)registers irqs inside an irq handler. The problem is that
the (un)register function uses dispc_runtime_get/put() to enable the
clocks, and those functions are not irq safe by default.

This was kind of fixed in 48664b21aeeffb40c5fa06843f18052e2c4ec9ef
(OMAPDSS: DISPC: set irq_safe for runtime PM), which makes dispc's
runtime calls irq-safe.

However, using pm_runtime_irq_safe in dispc makes the parent of dispc,
dss, always enabled, effectively preventing PM for the whole DSS module.

This patch makes omapdrm behave better by adding new irq (un)register
functions that do not use dispc_runtime_get/put, and using those
functions in interrupt context. Thus we can make dispc again
non-irq-safe, allowing proper PM.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Rob Clark <robdclark@gmail.com>
---
 drivers/gpu/drm/omapdrm/omap_crtc.c |  6 +++---
 drivers/gpu/drm/omapdrm/omap_drv.h  |  2 ++
 drivers/gpu/drm/omapdrm/omap_irq.c  | 22 ++++++++++++++++++----
 drivers/video/omap2/dss/dispc.c     |  1 -
 4 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.c b/drivers/gpu/drm/omapdrm/omap_crtc.c
index 0fd2eb1..e6241c2 100644
--- a/drivers/gpu/drm/omapdrm/omap_crtc.c
+++ b/drivers/gpu/drm/omapdrm/omap_crtc.c
@@ -411,7 +411,7 @@ static void omap_crtc_error_irq(struct omap_drm_irq *irq, uint32_t irqstatus)
 	struct drm_crtc *crtc = &omap_crtc->base;
 	DRM_ERROR("%s: errors: %08x\n", omap_crtc->name, irqstatus);
 	/* avoid getting in a flood, unregister the irq until next vblank */
-	omap_irq_unregister(crtc->dev, &omap_crtc->error_irq);
+	__omap_irq_unregister(crtc->dev, &omap_crtc->error_irq);
 }
 
 static void omap_crtc_apply_irq(struct omap_drm_irq *irq, uint32_t irqstatus)
@@ -421,13 +421,13 @@ static void omap_crtc_apply_irq(struct omap_drm_irq *irq, uint32_t irqstatus)
 	struct drm_crtc *crtc = &omap_crtc->base;
 
 	if (!omap_crtc->error_irq.registered)
-		omap_irq_register(crtc->dev, &omap_crtc->error_irq);
+		__omap_irq_register(crtc->dev, &omap_crtc->error_irq);
 
 	if (!dispc_mgr_go_busy(omap_crtc->channel)) {
 		struct omap_drm_private *priv  				crtc->dev->dev_private;
 		DBG("%s: apply done", omap_crtc->name);
-		omap_irq_unregister(crtc->dev, &omap_crtc->apply_irq);
+		__omap_irq_unregister(crtc->dev, &omap_crtc->apply_irq);
 		queue_work(priv->wq, &omap_crtc->apply_work);
 	}
 }
diff --git a/drivers/gpu/drm/omapdrm/omap_drv.h b/drivers/gpu/drm/omapdrm/omap_drv.h
index 30b95b7..cfb6c2e 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.h
+++ b/drivers/gpu/drm/omapdrm/omap_drv.h
@@ -145,6 +145,8 @@ irqreturn_t omap_irq_handler(DRM_IRQ_ARGS);
 void omap_irq_preinstall(struct drm_device *dev);
 int omap_irq_postinstall(struct drm_device *dev);
 void omap_irq_uninstall(struct drm_device *dev);
+void __omap_irq_register(struct drm_device *dev, struct omap_drm_irq *irq);
+void __omap_irq_unregister(struct drm_device *dev, struct omap_drm_irq *irq);
 void omap_irq_register(struct drm_device *dev, struct omap_drm_irq *irq);
 void omap_irq_unregister(struct drm_device *dev, struct omap_drm_irq *irq);
 int omap_drm_irq_uninstall(struct drm_device *dev);
diff --git a/drivers/gpu/drm/omapdrm/omap_irq.c b/drivers/gpu/drm/omapdrm/omap_irq.c
index 9263db1..b08b902 100644
--- a/drivers/gpu/drm/omapdrm/omap_irq.c
+++ b/drivers/gpu/drm/omapdrm/omap_irq.c
@@ -45,12 +45,11 @@ static void omap_irq_update(struct drm_device *dev)
 	dispc_read_irqenable();        /* flush posted write */
 }
 
-void omap_irq_register(struct drm_device *dev, struct omap_drm_irq *irq)
+void __omap_irq_register(struct drm_device *dev, struct omap_drm_irq *irq)
 {
 	struct omap_drm_private *priv = dev->dev_private;
 	unsigned long flags;
 
-	dispc_runtime_get();
 	spin_lock_irqsave(&list_lock, flags);
 
 	if (!WARN_ON(irq->registered)) {
@@ -60,14 +59,21 @@ void omap_irq_register(struct drm_device *dev, struct omap_drm_irq *irq)
 	}
 
 	spin_unlock_irqrestore(&list_lock, flags);
+}
+
+void omap_irq_register(struct drm_device *dev, struct omap_drm_irq *irq)
+{
+	dispc_runtime_get();
+
+	__omap_irq_register(dev, irq);
+
 	dispc_runtime_put();
 }
 
-void omap_irq_unregister(struct drm_device *dev, struct omap_drm_irq *irq)
+void __omap_irq_unregister(struct drm_device *dev, struct omap_drm_irq *irq)
 {
 	unsigned long flags;
 
-	dispc_runtime_get();
 	spin_lock_irqsave(&list_lock, flags);
 
 	if (!WARN_ON(!irq->registered)) {
@@ -77,6 +83,14 @@ void omap_irq_unregister(struct drm_device *dev, struct omap_drm_irq *irq)
 	}
 
 	spin_unlock_irqrestore(&list_lock, flags);
+}
+
+void omap_irq_unregister(struct drm_device *dev, struct omap_drm_irq *irq)
+{
+	dispc_runtime_get();
+
+	__omap_irq_unregister(dev, irq);
+
 	dispc_runtime_put();
 }
 
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 4779750..02a7340 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -3691,7 +3691,6 @@ static int __init omap_dispchw_probe(struct platform_device *pdev)
 	}
 
 	pm_runtime_enable(&pdev->dev);
-	pm_runtime_irq_safe(&pdev->dev);
 
 	r = dispc_runtime_get();
 	if (r)
-- 
1.8.1.2

