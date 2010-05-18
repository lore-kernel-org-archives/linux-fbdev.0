From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Date: Tue, 18 May 2010 12:35:01 +0000
Subject: [PATCH 10/23] OMAP: DSS2: Make partial update width even
Message-Id: <1274186114-26951-11-git-send-email-tomi.valkeinen@nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1274186114-26951-1-git-send-email-tomi.valkeinen@nokia.com>
In-Reply-To: <1274186114-26951-1-git-send-email-tomi.valkeinen@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

There are some strange problems with DSI and updates with odd widths. One
particular problem is that HS TX timeout triggers easily with updates with
odd widths.

This patch makes the updates widths even, circumventing the problem. There
should be no ill side effects with increasing the update area slightly to
make the width even.

Signed-off-by: Ville Syrjälä <ville.syrjala@nokia.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap2/dss/manager.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index 0820986..32ec2ff 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -940,6 +940,22 @@ static int configure_dispc(void)
 	return r;
 }
 
+/* Make the coordinates even. There are some strange problems with OMAP and
+ * partial DSI update when the update widths are odd. */
+static void make_even(u16 *x, u16 *w)
+{
+	u16 x1, x2;
+
+	x1 = *x;
+	x2 = *x + *w;
+
+	x1 &= ~1;
+	x2 = ALIGN(x2, 2);
+
+	*x = x1;
+	*w = x2 - x1;
+}
+
 /* Configure dispc for partial update. Return possibly modified update
  * area */
 void dss_setup_partial_planes(struct omap_dss_device *dssdev,
@@ -968,6 +984,8 @@ void dss_setup_partial_planes(struct omap_dss_device *dssdev,
 		return;
 	}
 
+	make_even(&x, &w);
+
 	spin_lock_irqsave(&dss_cache.lock, flags);
 
 	/* We need to show the whole overlay if it is scaled. So look for
@@ -1029,6 +1047,8 @@ void dss_setup_partial_planes(struct omap_dss_device *dssdev,
 		w = x2 - x1;
 		h = y2 - y1;
 
+		make_even(&x, &w);
+
 		DSSDBG("changing upd area due to ovl(%d) scaling %d,%d %dx%d\n",
 				i, x, y, w, h);
 	}
-- 
1.7.0.4

