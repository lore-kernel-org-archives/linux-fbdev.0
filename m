From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 14 Mar 2018 15:35:30 +0000
Subject: [PATCH 17/47] fbdev: remove blackfin drivers
Message-Id: <20180314153603.3127932-18-arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180314153603.3127932-1-arnd@arndb.de>
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

The blackfin architecture is getting removed, this removes the
associated fbdev drivers as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/Kconfig            | 103 ----
 drivers/video/fbdev/Makefile           |   5 -
 drivers/video/fbdev/bf537-lq035.c      | 891 ---------------------------------
 drivers/video/fbdev/bf54x-lq043fb.c    | 764 ----------------------------
 drivers/video/fbdev/bfin-lq035q1-fb.c  | 864 --------------------------------
 drivers/video/fbdev/bfin-t350mcqb-fb.c | 669 -------------------------
 drivers/video/fbdev/bfin_adv7393fb.c   | 828 ------------------------------
 drivers/video/fbdev/bfin_adv7393fb.h   | 319 ------------
 8 files changed, 4443 deletions(-)
 delete mode 100644 drivers/video/fbdev/bf537-lq035.c
 delete mode 100644 drivers/video/fbdev/bf54x-lq043fb.c
 delete mode 100644 drivers/video/fbdev/bfin-lq035q1-fb.c
 delete mode 100644 drivers/video/fbdev/bfin-t350mcqb-fb.c
 delete mode 100644 drivers/video/fbdev/bfin_adv7393fb.c
 delete mode 100644 drivers/video/fbdev/bfin_adv7393fb.h

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 11e699f1062b..399573742487 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -580,109 +580,6 @@ config FB_VGA16
 	  To compile this driver as a module, choose M here: the
 	  module will be called vga16fb.
 
-config FB_BF54X_LQ043
-	tristate "SHARP LQ043 TFT LCD (BF548 EZKIT)"
-	depends on FB && (BF54x) && !BF542
-	select FB_CFB_FILLRECT
-	select FB_CFB_COPYAREA
-	select FB_CFB_IMAGEBLIT
-	help
-	 This is the framebuffer device driver for a SHARP LQ043T1DG01 TFT LCD
-
-config FB_BFIN_T350MCQB
-	tristate "Varitronix COG-T350MCQB TFT LCD display (BF527 EZKIT)"
-	depends on FB && BLACKFIN
-	select BFIN_GPTIMERS
-	select FB_CFB_FILLRECT
-	select FB_CFB_COPYAREA
-	select FB_CFB_IMAGEBLIT
-	help
-	 This is the framebuffer device driver for a Varitronix VL-PS-COG-T350MCQB-01 display TFT LCD
-	 This display is a QVGA 320x240 24-bit RGB display interfaced by an 8-bit wide PPI
-	 It uses PPI[0..7] PPI_FS1, PPI_FS2 and PPI_CLK.
-
-config FB_BFIN_LQ035Q1
-	tristate "SHARP LQ035Q1DH02 TFT LCD"
-	depends on FB && BLACKFIN && SPI
-	select FB_CFB_FILLRECT
-	select FB_CFB_COPYAREA
-	select FB_CFB_IMAGEBLIT
-	select BFIN_GPTIMERS
-	help
-	  This is the framebuffer device driver for a SHARP LQ035Q1DH02 TFT display found on
-	  the Blackfin Landscape LCD EZ-Extender Card.
-	  This display is a QVGA 320x240 18-bit RGB display interfaced by an 16-bit wide PPI
-	  It uses PPI[0..15] PPI_FS1, PPI_FS2 and PPI_CLK.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called bfin-lq035q1-fb.
-
-config FB_BF537_LQ035
-	tristate "SHARP LQ035 TFT LCD (BF537 STAMP)"
-	depends on FB && (BF534 || BF536 || BF537) && I2C_BLACKFIN_TWI
-	select FB_CFB_FILLRECT
-	select FB_CFB_COPYAREA
-	select FB_CFB_IMAGEBLIT
-	select BFIN_GPTIMERS
-	help
-	  This is the framebuffer device for a SHARP LQ035Q7DB03 TFT LCD
-	  attached to a BF537.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called bf537-lq035.
-
-config FB_BFIN_7393
-	tristate "Blackfin ADV7393 Video encoder"
-	depends on FB && BLACKFIN
-	select I2C
-	select FB_CFB_FILLRECT
-	select FB_CFB_COPYAREA
-	select FB_CFB_IMAGEBLIT
-	help
-	  This is the framebuffer device for a ADV7393 video encoder
-	  attached to a Blackfin on the PPI port.
-	  If your Blackfin board has a ADV7393 select Y.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called bfin_adv7393fb.
-
-choice
-	prompt  "Video mode support"
-	depends on FB_BFIN_7393
-	default NTSC
-
-config NTSC
-	bool 'NTSC 720x480'
-
-config PAL
-	bool 'PAL 720x576'
-
-config NTSC_640x480
-	bool 'NTSC 640x480 (Experimental)'
-
-config PAL_640x480
-	bool 'PAL 640x480 (Experimental)'
-
-config NTSC_YCBCR
-	bool 'NTSC 720x480 YCbCR input'
-
-config PAL_YCBCR
-	bool 'PAL 720x576 YCbCR input'
-
-endchoice
-
-choice
-	prompt  "Size of ADV7393 frame buffer memory Single/Double Size"
-	depends on (FB_BFIN_7393)
-	default ADV7393_1XMEM
-
-config ADV7393_1XMEM
-	bool 'Single'
-
-config ADV7393_2XMEM
-	bool 'Double'
-endchoice
-
 config FB_STI
 	tristate "HP STI frame buffer device support"
 	depends on FB && PARISC
diff --git a/drivers/video/fbdev/Makefile b/drivers/video/fbdev/Makefile
index 115961e0721b..55282a21b500 100644
--- a/drivers/video/fbdev/Makefile
+++ b/drivers/video/fbdev/Makefile
@@ -136,11 +136,6 @@ obj-$(CONFIG_FB_VESA)             += vesafb.o
 obj-$(CONFIG_FB_EFI)              += efifb.o
 obj-$(CONFIG_FB_VGA16)            += vga16fb.o
 obj-$(CONFIG_FB_OF)               += offb.o
-obj-$(CONFIG_FB_BF537_LQ035)      += bf537-lq035.o
-obj-$(CONFIG_FB_BF54X_LQ043)	  += bf54x-lq043fb.o
-obj-$(CONFIG_FB_BFIN_LQ035Q1)     += bfin-lq035q1-fb.o
-obj-$(CONFIG_FB_BFIN_T350MCQB)	  += bfin-t350mcqb-fb.o
-obj-$(CONFIG_FB_BFIN_7393)        += bfin_adv7393fb.o
 obj-$(CONFIG_FB_MX3)		  += mx3fb.o
 obj-$(CONFIG_FB_DA8XX)		  += da8xx-fb.o
 obj-$(CONFIG_FB_MXS)		  += mxsfb.o
diff --git a/drivers/video/fbdev/bf537-lq035.c b/drivers/video/fbdev/bf537-lq035.c
deleted file mode 100644
index ef29fb425122..000000000000
diff --git a/drivers/video/fbdev/bf54x-lq043fb.c b/drivers/video/fbdev/bf54x-lq043fb.c
deleted file mode 100644
index 8f1f97c75619..000000000000
diff --git a/drivers/video/fbdev/bfin-lq035q1-fb.c b/drivers/video/fbdev/bfin-lq035q1-fb.c
deleted file mode 100644
index b459354ad940..000000000000
diff --git a/drivers/video/fbdev/bfin-t350mcqb-fb.c b/drivers/video/fbdev/bfin-t350mcqb-fb.c
deleted file mode 100644
index e5ee4d9677f7..000000000000
diff --git a/drivers/video/fbdev/bfin_adv7393fb.c b/drivers/video/fbdev/bfin_adv7393fb.c
deleted file mode 100644
index 542ffaddc6ab..000000000000
diff --git a/drivers/video/fbdev/bfin_adv7393fb.h b/drivers/video/fbdev/bfin_adv7393fb.h
deleted file mode 100644
index afd0380e19e1..000000000000
-- 
2.9.0

