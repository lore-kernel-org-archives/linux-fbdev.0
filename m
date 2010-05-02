From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 02 May 2010 15:17:34 +0000
Subject: [PATCH 4/4] viafb: fix hardware acceleration for suspend & resume
Message-Id: <1272813454-3229-5-git-send-email-FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1272813454-3229-1-git-send-email-FlorianSchandinat@gmx.de>
In-Reply-To: <1272813454-3229-1-git-send-email-FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn, corbet@lwn.net, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

viafb: fix hardware acceleration for suspend & resume

This patch splits the acceleration initialization in two parts:
The first is only called during probe and is used to allocate
resources. The second part is also called on resume to reinitalize
the 2D engine. This should fix all acceleration issues after resume
most notable an "invisible" cursor and as we do nothing special it is
reasonable to assume that it works on all supported IGPs.

Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
---
 drivers/video/via/accel.c    |   41 +++++++++++++++++++++++++----------------
 drivers/video/via/accel.h    |    1 +
 drivers/video/via/viafbdev.c |    2 ++
 3 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/video/via/accel.c b/drivers/video/via/accel.c
index 189aba4..49c27b5 100644
--- a/drivers/video/via/accel.c
+++ b/drivers/video/via/accel.c
@@ -318,9 +318,7 @@ int viafb_init_engine(struct fb_info *info)
 {
 	struct viafb_par *viapar = info->par;
 	void __iomem *engine;
-	int highest_reg, i;
-	u32 vq_start_addr, vq_end_addr, vq_start_low, vq_end_low, vq_high,
-		vq_len, chip_name = viapar->shared->chip_info.gfx_chip_name;
+	u32 chip_name = viapar->shared->chip_info.gfx_chip_name;
 
 	engine = viapar->shared->vdev->engine_mmio;
 	if (!engine) {
@@ -329,18 +327,6 @@ int viafb_init_engine(struct fb_info *info)
 		return -ENOMEM;
 	}
 
-	/* Initialize registers to reset the 2D engine */
-	switch (viapar->shared->chip_info.twod_engine) {
-	case VIA_2D_ENG_M1:
-		highest_reg = 0x5c;
-		break;
-	default:
-		highest_reg = 0x40;
-		break;
-	}
-	for (i = 0; i <= highest_reg; i += 4)
-		writel(0x0, engine + i);
-
 	switch (chip_name) {
 	case UNICHROME_CLE266:
 	case UNICHROME_K400:
@@ -386,6 +372,29 @@ int viafb_init_engine(struct fb_info *info)
 	viapar->shared->vdev->camera_fbmem_offset = viapar->fbmem_free;
 #endif
 
+	viafb_start_engine(viapar);
+	return 0;
+}
+
+void viafb_start_engine(struct viafb_par *viapar)
+{
+	void __iomem *engine = viapar->shared->vdev->engine_mmio;
+	int highest_reg, i;
+	u32 vq_start_addr, vq_end_addr, vq_start_low, vq_end_low, vq_high,
+		vq_len, chip_name = viapar->shared->chip_info.gfx_chip_name;
+
+	/* Initialize registers to reset the 2D engine */
+	switch (viapar->shared->chip_info.twod_engine) {
+	case VIA_2D_ENG_M1:
+		highest_reg = 0x5c;
+		break;
+	default:
+		highest_reg = 0x40;
+		break;
+	}
+	for (i = 0; i <= highest_reg; i += 4)
+		writel(0x0, engine + i);
+
 	/* Init AGP and VQ regs */
 	switch (chip_name) {
 	case UNICHROME_K8M890:
@@ -473,7 +482,7 @@ int viafb_init_engine(struct fb_info *info)
 	writel(0x0, engine + VIA_REG_CURSOR_ORG);
 	writel(0x0, engine + VIA_REG_CURSOR_BG);
 	writel(0x0, engine + VIA_REG_CURSOR_FG);
-	return 0;
+	return;
 }
 
 void viafb_show_hw_cursor(struct fb_info *info, int Status)
diff --git a/drivers/video/via/accel.h b/drivers/video/via/accel.h
index 2c122d2..5352f87 100644
--- a/drivers/video/via/accel.h
+++ b/drivers/video/via/accel.h
@@ -204,6 +204,7 @@
 #define VIA_BITBLT_FILL		3
 
 int viafb_init_engine(struct fb_info *info);
+void viafb_start_engine(struct viafb_par *viapar);
 void viafb_show_hw_cursor(struct fb_info *info, int Status);
 void viafb_wait_engine_idle(struct fb_info *info);
 
diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
index b5099b9..aaf572a 100644
--- a/drivers/video/via/viafbdev.c
+++ b/drivers/video/via/viafbdev.c
@@ -1767,6 +1767,8 @@ int viafb_resume(struct pci_dev *pdev)
 	if (pci_enable_device(pdev))
 		goto fail;
 	pci_set_master(pdev);
+	if (viaparinfo->shared->vdev->engine_mmio)
+		viafb_start_engine(viaparinfo);
 	viafb_set_par(viafbinfo);
 	if (viafb_dual_fb)
 		viafb_set_par(viafbinfo1);
-- 
1.6.3.2

