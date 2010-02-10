From: Baruch Siach <baruch@tkos.co.il>
Date: Wed, 10 Feb 2010 12:52:45 +0000
Subject: [PATCH v2] imxfb: add support for i.MX25
Message-Id: <4a9d6157ec463ea6142ab6cc20dac0a6eb761fc7.1265806123.git.baruch@tkos.co.il>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100210082654.GC10185@pengutronix.de>
In-Reply-To: <20100210082654.GC10185@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/mach-mx25/Kconfig |    1 +
 drivers/video/Kconfig      |    5 ++++-
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx25/Kconfig b/arch/arm/mach-mx25/Kconfig
index cc28f56..3520d49 100644
--- a/arch/arm/mach-mx25/Kconfig
+++ b/arch/arm/mach-mx25/Kconfig
@@ -4,6 +4,7 @@ comment "MX25 platforms:"
 
 config MACH_MX25_3DS
 	select ARCH_MXC_IOMUX_V3
+	select HAVE_FB_IMX
 	bool "Support MX25PDK (3DS) Platform"
 
 endif
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 5a5c303..3371e34 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -400,9 +400,12 @@ config FB_SA1100
 	  If you plan to use the LCD display with your SA-1100 system, say
 	  Y here.
 
+config HAVE_FB_IMX
+	bool
+
 config FB_IMX
 	tristate "Motorola i.MX LCD support"
-	depends on FB && (ARCH_MX1 || ARCH_MX2)
+	depends on HAVE_FB_IMX || ARCH_MX1 || ARCH_MX2
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-- 
1.6.6.1

