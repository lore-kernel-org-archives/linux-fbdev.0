From: Ondrej Zary <linux@rainbow-software.org>
Date: Thu, 01 Oct 2015 21:22:54 +0000
Subject: [PATCH v2 4/5] gxt4500: Use arch_phys_wc_* for framebuffer
Message-Id: <1443734575-12468-5-git-send-email-linux@rainbow-software.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1443734575-12468-1-git-send-email-linux@rainbow-software.org>
In-Reply-To: <1443734575-12468-1-git-send-email-linux@rainbow-software.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mackerras <paulus@samba.org>
Cc: =Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

Add arch_phys_wc_* calls to allow write-combining using MTRR.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
---
 drivers/video/fbdev/gxt4500.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/gxt4500.c b/drivers/video/fbdev/gxt4500.c
index 3ceddb8..31de650 100644
--- a/drivers/video/fbdev/gxt4500.c
+++ b/drivers/video/fbdev/gxt4500.c
@@ -142,7 +142,7 @@ static const unsigned char watfmt[] = {
 
 struct gxt4500_par {
 	void __iomem *regs;
-
+	int wc_cookie;
 	int pixfmt;		/* pixel format, see DFA_PIX_* values */
 
 	/* PLL parameters */
@@ -671,6 +671,9 @@ static int gxt4500_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	pci_set_drvdata(pdev, info);
 
+	par->wc_cookie = arch_phys_wc_add(info->fix.smem_start,
+					  info->fix.smem_len);
+
 #ifdef __BIG_ENDIAN
 	/* Set byte-swapping for DFA aperture for all pixel sizes */
 	pci_write_config_dword(pdev, CFG_ENDIAN0, 0x333300);
@@ -735,6 +738,7 @@ static void gxt4500_remove(struct pci_dev *pdev)
 		return;
 	par = info->par;
 	unregister_framebuffer(info);
+	arch_phys_wc_del(par->wc_cookie);
 	fb_dealloc_cmap(&info->cmap);
 	iounmap(par->regs);
 	iounmap(info->screen_base);
-- 
Ondrej Zary

