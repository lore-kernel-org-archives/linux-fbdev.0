From: Ondrej Zary <linux@rainbow-software.org>
Date: Mon, 24 Aug 2015 20:15:13 +0000
Subject: [PATCH 1/5] [resend] gxt4500: enable on non-PPC architectures
Message-Id: <1440447317-32604-2-git-send-email-linux@rainbow-software.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440447317-32604-1-git-send-email-linux@rainbow-software.org>
In-Reply-To: <1440447317-32604-1-git-send-email-linux@rainbow-software.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mackerras <paulus@samba.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

These chips can be present at least on x86 too - Fire GL2 AGP has GXT6000P but
this driver is currently limited to PPC.
Enable it for all architectures and add chip configuration for little-endian.

Tested on x86 with Fire GL2 AGP.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
---
 drivers/video/fbdev/Kconfig   |    5 +++--
 drivers/video/fbdev/gxt4500.c |    7 +++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 2d98de5..78335bd 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -2132,7 +2132,7 @@ config FB_UDL
 
 config FB_IBM_GXT4500
 	tristate "Framebuffer support for IBM GXT4000P/4500P/6000P/6500P adaptors"
-	depends on FB && PPC
+	depends on FB
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -2140,7 +2140,8 @@ config FB_IBM_GXT4500
 	  Say Y here to enable support for the IBM GXT4000P/6000P and
 	  GXT4500P/6500P display adaptor based on Raster Engine RC1000,
 	  found on some IBM System P (pSeries) machines. This driver
-	  doesn't use Geometry Engine GT1000.
+	  doesn't use Geometry Engine GT1000. This driver also supports
+	  AGP Fire GL2/3/4 cards on x86.
 
 config FB_PS3
 	tristate "PS3 GPU framebuffer driver"
diff --git a/drivers/video/fbdev/gxt4500.c b/drivers/video/fbdev/gxt4500.c
index 135d78a..1bf9894 100644
--- a/drivers/video/fbdev/gxt4500.c
+++ b/drivers/video/fbdev/gxt4500.c
@@ -670,8 +670,15 @@ static int gxt4500_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	pci_set_drvdata(pdev, info);
 
+#ifdef __BIG_ENDIAN
 	/* Set byte-swapping for DFA aperture for all pixel sizes */
 	pci_write_config_dword(pdev, CFG_ENDIAN0, 0x333300);
+#else /* __LITTLE_ENDIAN */
+	/* not sure what this means but fgl23 driver does that */
+	pci_write_config_dword(pdev, CFG_ENDIAN0, 0x2300);
+/*	pci_write_config_dword(pdev, CFG_ENDIAN0 + 4, 0x400000);*/
+	pci_write_config_dword(pdev, CFG_ENDIAN0 + 8, 0x98530000);
+#endif
 
 	info->fbops = &gxt4500_ops;
 	info->flags = FBINFO_FLAG_DEFAULT;
-- 
Ondrej Zary

