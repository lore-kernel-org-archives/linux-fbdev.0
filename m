From: Steve Longerbeam <slongerbeam@gmail.com>
Date: Wed, 20 Jul 2016 01:11:10 +0000
Subject: [PATCH v2 12/13] gpu: ipu-ic: allow multiple handles to ic
Message-Id: <1468977071-29240-13-git-send-email-steve_longerbeam@mentor.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1467932621-358-1-git-send-email-steve_longerbeam@mentor.com>
 <1468977071-29240-1-git-send-email-steve_longerbeam@mentor.com>
In-Reply-To: <1468977071-29240-1-git-send-email-steve_longerbeam@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: p.zabel@pengutronix.de, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Steve Longerbeam <steve_longerbeam@mentor.com>

The image converter kernel API supports conversion contexts and
job queues, so we should allow more than one handle to the IC, so
that multiple users can add jobs to the queue.

Note however that users that control the IC manually (that do not
use the image converter APIs but setup the IC task by hand via calls
to ipu_ic_task_enable(), ipu_ic_enable(), etc.) must still be careful not
to share the IC handle with other threads. At this point, the only user
that still controls the IC manually is the i.mx capture driver. In that
case the capture driver only allows one open context to get a handle
to the IC at a time, so we should be ok there.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 drivers/gpu/ipu-v3/ipu-ic.c | 25 +------------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-ic.c b/drivers/gpu/ipu-v3/ipu-ic.c
index 5471b72..cc0780b 100644
--- a/drivers/gpu/ipu-v3/ipu-ic.c
+++ b/drivers/gpu/ipu-v3/ipu-ic.c
@@ -342,7 +342,6 @@ struct ipu_ic {
 	enum ipu_color_space out_cs;
 	bool graphics;
 	bool rotation;
-	bool in_use;
 
 	struct image_converter cvt;
 
@@ -2367,38 +2366,16 @@ EXPORT_SYMBOL_GPL(ipu_ic_disable);
 struct ipu_ic *ipu_ic_get(struct ipu_soc *ipu, enum ipu_ic_task task)
 {
 	struct ipu_ic_priv *priv = ipu->ic_priv;
-	unsigned long flags;
-	struct ipu_ic *ic, *ret;
 
 	if (task >= IC_NUM_TASKS)
 		return ERR_PTR(-EINVAL);
 
-	ic = &priv->task[task];
-
-	spin_lock_irqsave(&priv->lock, flags);
-
-	if (ic->in_use) {
-		ret = ERR_PTR(-EBUSY);
-		goto unlock;
-	}
-
-	ic->in_use = true;
-	ret = ic;
-
-unlock:
-	spin_unlock_irqrestore(&priv->lock, flags);
-	return ret;
+	return &priv->task[task];
 }
 EXPORT_SYMBOL_GPL(ipu_ic_get);
 
 void ipu_ic_put(struct ipu_ic *ic)
 {
-	struct ipu_ic_priv *priv = ic->priv;
-	unsigned long flags;
-
-	spin_lock_irqsave(&priv->lock, flags);
-	ic->in_use = false;
-	spin_unlock_irqrestore(&priv->lock, flags);
 }
 EXPORT_SYMBOL_GPL(ipu_ic_put);
 
-- 
1.9.1

