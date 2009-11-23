From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Date: Mon, 23 Nov 2009 18:11:22 +0000
Subject: [PATCH 2/2] OMAP: ams_delta_defconfig: enable LCD class device support
Message-Id: <200911231911.27418.jkrzyszt@tis.icnet.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <200911231857.55566.jkrzyszt@tis.icnet.pl>
In-Reply-To: <200911231857.55566.jkrzyszt@tis.icnet.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, Imre Deak <imre.deak@nokia.com>, Tony Lindgren <tony@atomide.com>

The patch enables LCD class device support in ams_delta_defconfig in order to
get optional contrast control functional.

Created and tested against linux-omap for-next,
commit 155a75d9725e66e5ec8a383822957dee52427057.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

---
--- a/arch/arm/configs/ams_delta_defconfig	2009-11-14 23:48:40.000000000 +0100
+++ b/arch/arm/configs/ams_delta_defconfig	2009-11-16 01:06:12.000000000 +0100
@@ -836,7 +836,8 @@
 #
 # Graphics support
 #
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+CONFIG_BACKLIGHT_LCD_SUPPORT=y
+CONFIG_LCD_CLASS_DEVICE=y
 
 #
 # Display device support



