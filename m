From: Ben Hutchings <ben@decadent.org.uk>
Date: Thu, 12 May 2011 12:42:17 +0000
Subject: [PATCH] video: mb862xxfb: Require either FB_MB862XX_PCI_GDC or
Message-Id: <1305204137.4065.394.camel@localhost>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The driver can be built as either a PCI or platform (OF) driver.  It
might make sense to built it as both (though that is not currently
possible) but it certainly doesn't make sense to build it as neither!
Add dependencies and add a choice group to ensure that exactly one of
FB_MB862XX_PCI_GDC and FB_MB862XX_LIME is selected.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/video/Kconfig |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 1d0aa5e..eb468f6 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -2254,29 +2254,34 @@ config FB_METRONOME
 config FB_MB862XX
 	tristate "Fujitsu MB862xx GDC support"
 	depends on FB
+	depends on PCI || (OF && PPC)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
 	---help---
 	  Frame buffer driver for Fujitsu Carmine/Coral-P(A)/Lime controllers.
 
+choice
+	prompt "GDC variant"
+	depends on FB_MB862XX
+
 config FB_MB862XX_PCI_GDC
 	bool "Carmine/Coral-P(A) GDC"
-	depends on PCI && FB_MB862XX
+	depends on PCI
 	---help---
 	  This enables framebuffer support for Fujitsu Carmine/Coral-P(A)
 	  PCI graphics controller devices.
 
 config FB_MB862XX_LIME
 	bool "Lime GDC"
-	depends on FB_MB862XX
-	depends on OF && !FB_MB862XX_PCI_GDC
-	depends on PPC
+	depends on OF && PPC
 	select FB_FOREIGN_ENDIAN
 	select FB_LITTLE_ENDIAN
 	---help---
 	  Framebuffer support for Fujitsu Lime GDC on host CPU bus.
 
+endchoice
+
 config FB_EP93XX
 	tristate "EP93XX frame buffer support"
 	depends on FB && ARCH_EP93XX
-- 
1.7.4.4


