From: Steve Longerbeam <slongerbeam@gmail.com>
Date: Sun, 31 Jul 2016 19:42:22 +0000
Subject: [PATCH v3 07/12] gpu: ipu-v3: Fix IRT usage
Message-Id: <1469994147-17549-8-git-send-email-steve_longerbeam@mentor.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1469994147-17549-1-git-send-email-steve_longerbeam@mentor.com>
In-Reply-To: <1469994147-17549-1-git-send-email-steve_longerbeam@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: p.zabel@pengutronix.de, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Steve Longerbeam <steve_longerbeam@mentor.com>

There can be multiple IC tasks using the IRT, so the IRT needs
a separate use counter. Create a private ipu_irt_enable() to
enable the IRT module when any IC task requires rotation, and
ipu_irt_disable() when a task no longer needs the IRT.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>

---

v3: no changes
v2:
- cleaned up irt_use_count decrement in ipu_irt_disable()
---
 drivers/gpu/ipu-v3/ipu-ic.c | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-ic.c b/drivers/gpu/ipu-v3/ipu-ic.c
index 1dcb96c..1a37afc 100644
--- a/drivers/gpu/ipu-v3/ipu-ic.c
+++ b/drivers/gpu/ipu-v3/ipu-ic.c
@@ -160,6 +160,7 @@ struct ipu_ic_priv {
 	spinlock_t lock;
 	struct ipu_soc *ipu;
 	int use_count;
+	int irt_use_count;
 	struct ipu_ic task[IC_NUM_TASKS];
 };
 
@@ -379,8 +380,6 @@ void ipu_ic_task_disable(struct ipu_ic *ic)
 
 	ipu_ic_write(ic, ic_conf, IC_CONF);
 
-	ic->rotation = ic->graphics = false;
-
 	spin_unlock_irqrestore(&priv->lock, flags);
 }
 EXPORT_SYMBOL_GPL(ipu_ic_task_disable);
@@ -629,22 +628,41 @@ unlock:
 }
 EXPORT_SYMBOL_GPL(ipu_ic_task_idma_init);
 
+static void ipu_irt_enable(struct ipu_ic *ic)
+{
+	struct ipu_ic_priv *priv = ic->priv;
+
+	if (!priv->irt_use_count)
+		ipu_module_enable(priv->ipu, IPU_CONF_ROT_EN);
+
+	priv->irt_use_count++;
+}
+
+static void ipu_irt_disable(struct ipu_ic *ic)
+{
+	struct ipu_ic_priv *priv = ic->priv;
+
+	if (priv->irt_use_count) {
+		if (!--priv->irt_use_count)
+			ipu_module_disable(priv->ipu, IPU_CONF_ROT_EN);
+	}
+}
+
 int ipu_ic_enable(struct ipu_ic *ic)
 {
 	struct ipu_ic_priv *priv = ic->priv;
 	unsigned long flags;
-	u32 module = IPU_CONF_IC_EN;
 
 	spin_lock_irqsave(&priv->lock, flags);
 
-	if (ic->rotation)
-		module |= IPU_CONF_ROT_EN;
-
 	if (!priv->use_count)
-		ipu_module_enable(priv->ipu, module);
+		ipu_module_enable(priv->ipu, IPU_CONF_IC_EN);
 
 	priv->use_count++;
 
+	if (ic->rotation)
+		ipu_irt_enable(ic);
+
 	spin_unlock_irqrestore(&priv->lock, flags);
 
 	return 0;
@@ -655,18 +673,22 @@ int ipu_ic_disable(struct ipu_ic *ic)
 {
 	struct ipu_ic_priv *priv = ic->priv;
 	unsigned long flags;
-	u32 module = IPU_CONF_IC_EN | IPU_CONF_ROT_EN;
 
 	spin_lock_irqsave(&priv->lock, flags);
 
 	priv->use_count--;
 
 	if (!priv->use_count)
-		ipu_module_disable(priv->ipu, module);
+		ipu_module_disable(priv->ipu, IPU_CONF_IC_EN);
 
 	if (priv->use_count < 0)
 		priv->use_count = 0;
 
+	if (ic->rotation)
+		ipu_irt_disable(ic);
+
+	ic->rotation = ic->graphics = false;
+
 	spin_unlock_irqrestore(&priv->lock, flags);
 
 	return 0;
-- 
1.9.1

