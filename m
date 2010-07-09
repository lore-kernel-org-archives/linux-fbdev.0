From: Pawel Osciak <p.osciak@samsung.com>
Date: Fri, 09 Jul 2010 08:50:07 +0000
Subject: [PATCH 19/19] s3c-fb: Add support for DMA channel control on S5PV210
Message-Id: <1278665407-18002-20-git-send-email-p.osciak@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1278665407-18002-1-git-send-email-p.osciak@samsung.com>
In-Reply-To: <1278665407-18002-1-git-send-email-p.osciak@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

S5PV210 SoCs allow enabling/disabling DMA channels per window. For a window
to display data from framebuffer memory, its channel has to be enabled.

Signed-off-by: Pawel Osciak <p.osciak@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-samsung/include/plat/regs-fb.h |    4 ++++
 drivers/video/s3c-fb.c                       |   15 +++++++++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/regs-fb.h b/arch/arm/plat-samsung/include/plat/regs-fb.h
index 4359918..8f39aa5 100644
--- a/arch/arm/plat-samsung/include/plat/regs-fb.h
+++ b/arch/arm/plat-samsung/include/plat/regs-fb.h
@@ -223,6 +223,10 @@
 /* S5PV210 */
 #define SHADOWCON				(0x34)
 #define SHADOWCON_WINx_PROTECT(_win)		(1 << (10 + (_win)))
+/* DMA channels (all windows) */
+#define SHADOWCON_CHx_ENABLE(_win)		(1 << (_win))
+/* Local input channels (windows 0-2) */
+#define SHADOWCON_CHx_LOCAL_ENABLE(_win)	(1 << (5 + (_win)))
 
 #define VIDOSDxA_TOPLEFT_X_MASK			(0x7ff << 11)
 #define VIDOSDxA_TOPLEFT_X_SHIFT		(11)
diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index a95314d..8ea974d 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -634,6 +634,13 @@ static int s3c_fb_set_par(struct fb_info *info)
 	writel(data, regs + sfb->variant.wincon + (win_no * 4));
 	writel(0x0, regs + sfb->variant.winmap + (win_no * 4));
 
+	/* Enable DMA channel for this window */
+	if (sfb->variant.has_shadowcon) {
+		data = readl(sfb->regs + SHADOWCON);
+		data |= SHADOWCON_CHx_ENABLE(win_no);
+		writel(data, sfb->regs + SHADOWCON);
+	}
+
 	shadow_protect_win(win, 0);
 
 	return 0;
@@ -1091,7 +1098,15 @@ static void s3c_fb_free_memory(struct s3c_fb *sfb, struct s3c_fb_win *win)
  */
 static void s3c_fb_release_win(struct s3c_fb *sfb, struct s3c_fb_win *win)
 {
+	u32 data;
+
 	if (win->fbinfo) {
+		if (sfb->variant.has_shadowcon) {
+			data = readl(sfb->regs + SHADOWCON);
+			data &= ~SHADOWCON_CHx_ENABLE(win->index);
+			data &= ~SHADOWCON_CHx_LOCAL_ENABLE(win->index);
+			writel(data, sfb->regs + SHADOWCON);
+		}
 		unregister_framebuffer(win->fbinfo);
 		if (win->fbinfo->cmap.len)
 			fb_dealloc_cmap(&win->fbinfo->cmap);
-- 
1.7.1.569.g6f426

