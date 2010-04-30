From: Jonathan Corbet <corbet@lwn.net>
Date: Fri, 30 Apr 2010 21:39:49 +0000
Subject: [PATCH 3/3] viafb: Don't build in camera-specific code without the camera
Message-Id: <1272663589-4950-4-git-send-email-corbet@lwn.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1272663589-4950-1-git-send-email-corbet@lwn.net>
In-Reply-To: <1272663589-4950-1-git-send-email-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-kernel@vger.kernel.org
Cc: Harald Welte <laforge@gnumonks.org>, linux-fbdev@vger.kernel.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn, =?UTF-8?q?Bruno=20Pr=C3=A9mont?= <bonbons@linux-vserver.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

Bruno noted that the camera subdev was being created even in the absence of
the camera module; stop that.  While I was at it, I also put an #ifdef
guard around the DMA code.  Viafb users have gotten along just fine without
that functionality so far, and only the camera uses it, so there is no
point in bloating the driver if the camera is not being built.

Reported-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 drivers/video/via/via-core.c |   12 ++++++++++--
 drivers/video/via/via-core.h |    3 ++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/video/via/via-core.c b/drivers/video/via/via-core.c
index 1c6835e..a084363 100644
--- a/drivers/video/via/via-core.c
+++ b/drivers/video/via/via-core.c
@@ -34,7 +34,6 @@ static struct via_port_cfg adap_configs[] =3D {
  */
 static struct viafb_dev global_dev;
=20
-
 /*
  * Basic register access; spinlock required.
  */
@@ -95,6 +94,13 @@ EXPORT_SYMBOL_GPL(viafb_irq_disable);
=20
 /* ---------------------------------------------------------------------- =
*/
 /*
+ * Currently, the camera driver is the only user of the DMA code, so we
+ * only compile it in if the camera driver is being built.  Chances are,
+ * most viafb systems will not need to have this extra code for a while.
+ * As soon as another user comes long, the ifdef can be removed.
+ */
+#if defined(CONFIG_FB_VIA_CAMERA) || defined(CONFIG_FB_VIA_CAMERA_MODULE)
+/*
  * Access to the DMA engine.  This currently provides what the camera
  * driver needs (i.e. outgoing only) but is easily expandable if need
  * be.
@@ -322,7 +328,7 @@ int viafb_dma_copy_out_sg(unsigned int offset, struct s=
catterlist *sg, int nsg)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(viafb_dma_copy_out_sg);
-
+#endif /* CONFIG_FB_VIA_CAMERA */
=20
 /* ---------------------------------------------------------------------- =
*/
 /*
@@ -508,9 +514,11 @@ static struct viafb_subdev_info {
 	{
 		.name =3D "viafb-i2c",
 	},
+#if defined(CONFIG_FB_VIA_CAMERA) || defined(CONFIG_FB_VIA_CAMERA_MODULE)
 	{
 		.name =3D "viafb-camera",
 	},
+#endif
 };
 #define N_SUBDEVS ARRAY_SIZE(viafb_subdevs)
=20
diff --git a/drivers/video/via/via-core.h b/drivers/video/via/via-core.h
index 087c562..ca52dfe 100644
--- a/drivers/video/via/via-core.h
+++ b/drivers/video/via/via-core.h
@@ -94,7 +94,6 @@ struct viafb_dev {
 /*
  * Interrupt management.
  */
-
 void viafb_irq_enable(u32 mask);
 void viafb_irq_disable(u32 mask);
=20
@@ -135,6 +134,7 @@ void viafb_irq_disable(u32 mask);
 #define   VDE_I_LVDSSIEN  0x40000000  /* LVDS Sense enable */
 #define   VDE_I_ENABLE	  0x80000000  /* Global interrupt enable */
=20
+#if defined(CONFIG_FB_VIA_CAMERA) || defined(CONFIG_FB_VIA_CAMERA_MODULE)
 /*
  * DMA management.
  */
@@ -169,5 +169,6 @@ int viafb_dma_copy_out_sg(unsigned int offset, struct s=
catterlist *sg, int nsg);
  */
 #define VGA_WIDTH	640
 #define VGA_HEIGHT	480
+#endif /* CONFIG_FB_VIA_CAMERA */
=20
 #endif /* __VIA_CORE_H__ */
--=20
1.7.0.1

