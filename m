From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 07 Jul 2015 08:26:36 +0000
Subject: [PATCH 4/5] staging: sm7xxfb: define new macros
Message-Id: <1436256877-10754-5-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1436256877-10754-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1436256877-10754-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, Dan Carpenter <dan.carpenter@oracle.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Define and use some new macros to work with different situations
based on little-endian and big-endian.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/staging/sm7xxfb/sm7xx.h   | 19 ++++++++++++++++
 drivers/staging/sm7xxfb/sm7xxfb.c | 48 ++++++++-------------------------------
 2 files changed, 29 insertions(+), 38 deletions(-)

diff --git a/drivers/staging/sm7xxfb/sm7xx.h b/drivers/staging/sm7xxfb/sm7xx.h
index 31a21bd..6905177 100644
--- a/drivers/staging/sm7xxfb/sm7xx.h
+++ b/drivers/staging/sm7xxfb/sm7xx.h
@@ -95,3 +95,22 @@ struct modeinit {
 	unsigned char init_cr30_cr4d[SIZE_CR30_CR4D];
 	unsigned char init_cr90_cra7[SIZE_CR90_CRA7];
 };
+
+#ifdef __BIG_ENDIAN
+#define pal_rgb(r, g, b, val)	(((r & 0xf800) >> 8) | \
+				((g & 0xe000) >> 13) | \
+				((g & 0x1c00) << 3) | \
+				((b & 0xf800) >> 3))
+#define big_addr		0x800000
+#define mmio_addr		0x00800000
+#define seqw17			smtc_seqw(0x17, 0x30)
+#define big_pixel_depth(p, d)	{if (p = 24) {p = 32; d = 32; } }
+#define big_swap(p)		((p & 0xff00ff00 >> 8) | (p & 0x00ff00ff << 8))
+#else
+#define pal_rgb(r, g, b, val)	val
+#define big_addr		0
+#define mmio_addr		0x00c00000
+#define seqw17
+#define big_pixel_depth(p, d)
+#define big_swap(p)		p
+#endif
diff --git a/drivers/staging/sm7xxfb/sm7xxfb.c b/drivers/staging/sm7xxfb/sm7xxfb.c
index 4dc9d5f..252f110a 100644
--- a/drivers/staging/sm7xxfb/sm7xxfb.c
+++ b/drivers/staging/sm7xxfb/sm7xxfb.c
@@ -923,25 +923,14 @@ static int smtc_setcolreg(unsigned regno, unsigned red, unsigned green,
 			val = chan_to_field(red, &sfb->fb->var.red);
 			val |= chan_to_field(green, &sfb->fb->var.green);
 			val |= chan_to_field(blue, &sfb->fb->var.blue);
-#ifdef __BIG_ENDIAN
-			pal[regno] = ((red & 0xf800) >> 8) |
-				     ((green & 0xe000) >> 13) |
-				     ((green & 0x1c00) << 3) |
-				     ((blue & 0xf800) >> 3);
-#else
-			pal[regno] = val;
-#endif
+			pal[regno] = pal_rgb(red, green, blue, val);
 		} else {
 			u32 *pal = sfb->fb->pseudo_palette;
 
 			val = chan_to_field(red, &sfb->fb->var.red);
 			val |= chan_to_field(green, &sfb->fb->var.green);
 			val |= chan_to_field(blue, &sfb->fb->var.blue);
-#ifdef __BIG_ENDIAN
-			val = (val & 0xff00ff00 >> 8) |
-			      (val & 0x00ff00ff << 8);
-#endif
-			pal[regno] = val;
+			pal[regno] = big_swap(val);
 		}
 		break;
 
@@ -1002,8 +991,7 @@ static ssize_t smtcfb_read(struct fb_info *info, char __user *buf,
 		dst = buffer;
 		for (i = c >> 2; i--;) {
 			*dst = fb_readl(src++);
-			*dst = (*dst & 0xff00ff00 >> 8) |
-			       (*dst & 0x00ff00ff << 8);
+			*dst = big_swap(*dst);
 			dst++;
 		}
 		if (c & 3) {
@@ -1091,8 +1079,7 @@ static ssize_t smtcfb_write(struct fb_info *info, const char __user *buf,
 		}
 
 		for (i = c >> 2; i--;) {
-			fb_writel((*src & 0xff00ff00 >> 8) |
-				  (*src & 0x00ff00ff << 8), dst++);
+			fb_writel(big_swap(*src), dst++);
 			src++;
 		}
 		if (c & 3) {
@@ -1341,10 +1328,8 @@ static int smtc_map_smem(struct smtcfb_info *sfb,
 {
 	sfb->fb->fix.smem_start = pci_resource_start(pdev, 0);
 
-#ifdef __BIG_ENDIAN
 	if (sfb->fb->var.bits_per_pixel = 32)
-		sfb->fb->fix.smem_start += 0x800000;
-#endif
+		sfb->fb->fix.smem_start += big_addr;
 
 	sfb->fb->fix.smem_len = smem_len;
 
@@ -1437,10 +1422,7 @@ static int smtcfb_pci_probe(struct pci_dev *pdev,
 		sfb->fb->var.bits_per_pixel = SCREEN_BPP;
 	}
 
-#ifdef __BIG_ENDIAN
-	if (sfb->fb->var.bits_per_pixel = 24)
-		sfb->fb->var.bits_per_pixel = (smtc_scr_info.lfb_depth = 32);
-#endif
+	big_pixel_depth(sfb->fb->var.bits_per_pixel, smtc_scr_info.lfb_depth);
 	/* Map address and memory detection */
 	mmio_base = pci_resource_start(pdev, 0);
 	pci_read_config_byte(pdev, PCI_REVISION_ID, &sfb->chip_rev_id);
@@ -1451,11 +1433,7 @@ static int smtcfb_pci_probe(struct pci_dev *pdev,
 		sfb->fb->fix.mmio_start = mmio_base + 0x00400000;
 		sfb->fb->fix.mmio_len = 0x00400000;
 		smem_size = SM712_VIDEOMEMORYSIZE;
-#ifdef __BIG_ENDIAN
-		sfb->lfb = ioremap(mmio_base, 0x00c00000);
-#else
-		sfb->lfb = ioremap(mmio_base, 0x00800000);
-#endif
+		sfb->lfb = ioremap(mmio_base, mmio_addr);
 		if (!sfb->lfb) {
 			dev_err(&pdev->dev,
 				"%s: unable to map memory mapped IO!\n",
@@ -1468,12 +1446,10 @@ static int smtcfb_pci_probe(struct pci_dev *pdev,
 		    sfb->lfb + 0x00700000);
 		sfb->dp_regs = sfb->lfb + 0x00408000;
 		sfb->vp_regs = sfb->lfb + 0x0040c000;
-#ifdef __BIG_ENDIAN
 		if (sfb->fb->var.bits_per_pixel = 32) {
-			sfb->lfb += 0x800000;
+			sfb->lfb += big_addr;
 			dev_info(&pdev->dev, "sfb->lfb=%p\n", sfb->lfb);
 		}
-#endif
 
 		/* set MCLK = 14.31818 * (0x16 / 0x2) */
 		smtc_seqw(0x6a, 0x16);
@@ -1482,10 +1458,8 @@ static int smtcfb_pci_probe(struct pci_dev *pdev,
 		/* enable PCI burst */
 		smtc_seqw(0x17, 0x20);
 		/* enable word swap */
-#ifdef __BIG_ENDIAN
 		if (sfb->fb->var.bits_per_pixel = 32)
-			smtc_seqw(0x17, 0x30);
-#endif
+			seqw17;
 		break;
 	case 0x720:
 		sfb->fb->fix.mmio_start = mmio_base;
@@ -1617,10 +1591,8 @@ static int smtcfb_pci_resume(struct device *device)
 		smtc_seqw(0x62, 0x3e);
 		/* enable PCI burst */
 		smtc_seqw(0x17, 0x20);
-#ifdef __BIG_ENDIAN
 		if (sfb->fb->var.bits_per_pixel = 32)
-			smtc_seqw(0x17, 0x30);
-#endif
+			seqw17;
 		break;
 	case 0x720:
 		smtc_seqw(0x62, 0xff);
-- 
1.8.1.2

