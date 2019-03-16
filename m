From: Yifeng Li <tomli@tomli.me>
Date: Sat, 16 Mar 2019 22:25:04 +0000
Subject: [PATCH 8/8] fbdev: sm712fb: use 1024x768 by default on non-MIPS, fix garbled display.
Message-Id: <20190316222504.27170-9-tomli@tomli.me>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190316222504.27170-1-tomli@tomli.me>
In-Reply-To: <20190316222504.27170-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Yifeng Li <tomli@tomli.me>, stable@vger.kernel.org

Loongson MIPS netbooks use 1024x600 LCD panels, which is the original
target platform of this driver, but nearly all old x86 laptops have
1024x768. Lighting 768 panels using 600's timings would partially
garble the display. Since it's not possible to distinguish them reliably,
we change the default to 768, but keep 600 as-is on MIPS.

Further, earlier laptops, such as IBM Thinkpad 240X, has a 800x600 LCD
panel, this driver would probably garbled those display. As we don't
have one for testing, the original behavior of the driver is kept as-is,
but the problem has been documented is the comments.

Signed-off-by: Yifeng Li <tomli@tomli.me>
Cc: stable@vger.kernel.org  # v4.4+
---
 drivers/video/fbdev/sm712.h   |  7 +++--
 drivers/video/fbdev/sm712fb.c | 53 ++++++++++++++++++++++++++---------
 2 files changed, 44 insertions(+), 16 deletions(-)

diff --git a/drivers/video/fbdev/sm712.h b/drivers/video/fbdev/sm712.h
index 2cba1e73ed24..c7ebf03b8d53 100644
--- a/drivers/video/fbdev/sm712.h
+++ b/drivers/video/fbdev/sm712.h
@@ -15,9 +15,10 @@
 
 #define FB_ACCEL_SMI_LYNX 88
 
-#define SCREEN_X_RES      1024
-#define SCREEN_Y_RES      600
-#define SCREEN_BPP        16
+#define SCREEN_X_RES          1024
+#define SCREEN_Y_RES_PC       768
+#define SCREEN_Y_RES_NETBOOK  600
+#define SCREEN_BPP            16
 
 #define dac_reg	(0x3c8)
 #define dac_val	(0x3c9)
diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
index c39a2641182a..1e2503b52c6f 100644
--- a/drivers/video/fbdev/sm712fb.c
+++ b/drivers/video/fbdev/sm712fb.c
@@ -1475,6 +1475,43 @@ static u_long sm7xx_vram_probe(struct smtcfb_info *sfb)
 	return 0;  /* unknown hardware */
 }
 
+static void sm7xx_resolution_probe(struct smtcfb_info *sfb)
+{
+	/* get mode parameter from smtc_scr_info */
+	if (smtc_scr_info.lfb_width != 0) {
+		sfb->fb->var.xres = smtc_scr_info.lfb_width;
+		sfb->fb->var.yres = smtc_scr_info.lfb_height;
+		sfb->fb->var.bits_per_pixel = smtc_scr_info.lfb_depth;
+		goto final;
+	}
+
+	/*
+	 * No parameter, default resolution is 1024x768-16.
+	 *
+	 * FIXME: earlier laptops, such as IBM Thinkpad 240X, has a 800x600
+	 * panel, also see the comments about Thinkpad 240X above.
+	 */
+	sfb->fb->var.xres = SCREEN_X_RES;
+	sfb->fb->var.yres = SCREEN_Y_RES_PC;
+	sfb->fb->var.bits_per_pixel = SCREEN_BPP;
+
+#ifdef CONFIG_MIPS
+	/*
+	 * Loongson MIPS netbooks use 1024x600 LCD panels, which is the original
+	 * target platform of this driver, but nearly all old x86 laptops have
+	 * 1024x768. Lighting 768 panels using 600's timings would partially
+	 * garble the display, so we don't want that. But it's not possible to
+	 * distinguish them reliably.
+	 *
+	 * So we change the default to 768, but keep 600 as-is on MIPS.
+	 */
+	sfb->fb->var.yres = SCREEN_Y_RES_NETBOOK;
+#endif
+
+final:
+	big_pixel_depth(sfb->fb->var.bits_per_pixel, smtc_scr_info.lfb_depth);
+}
+
 static int smtcfb_pci_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *ent)
 {
@@ -1520,19 +1557,6 @@ static int smtcfb_pci_probe(struct pci_dev *pdev,
 
 	sm7xx_init_hw();
 
-	/* get mode parameter from smtc_scr_info */
-	if (smtc_scr_info.lfb_width != 0) {
-		sfb->fb->var.xres = smtc_scr_info.lfb_width;
-		sfb->fb->var.yres = smtc_scr_info.lfb_height;
-		sfb->fb->var.bits_per_pixel = smtc_scr_info.lfb_depth;
-	} else {
-		/* default resolution 1024x600 16bit mode */
-		sfb->fb->var.xres = SCREEN_X_RES;
-		sfb->fb->var.yres = SCREEN_Y_RES;
-		sfb->fb->var.bits_per_pixel = SCREEN_BPP;
-	}
-
-	big_pixel_depth(sfb->fb->var.bits_per_pixel, smtc_scr_info.lfb_depth);
 	/* Map address and memory detection */
 	mmio_base = pci_resource_start(pdev, 0);
 	pci_read_config_byte(pdev, PCI_REVISION_ID, &sfb->chip_rev_id);
@@ -1594,6 +1618,9 @@ static int smtcfb_pci_probe(struct pci_dev *pdev,
 		goto failed_fb;
 	}
 
+	/* probe and decide resolution */
+	sm7xx_resolution_probe(sfb);
+
 	/* can support 32 bpp */
 	if (sfb->fb->var.bits_per_pixel = 15)
 		sfb->fb->var.bits_per_pixel = 16;
-- 
2.20.1
