From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 17 Apr 2020 15:55:48 +0000
Subject: [PATCH 3/8] fbdev: rework FB_DDC dependencies
Message-Id: <20200417155553.675905-4-arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200417155553.675905-1-arnd@arndb.de>
In-Reply-To: <20200417155553.675905-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: dri-devel@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>, linux-fbdev@vger.kernel.org
Cc: marex@denx.de, dsd@laptop.org, Arnd Bergmann <arnd@arndb.de>, Andrzej Hajda <a.hajda@samsung.com>, airlied@linux.ie, masahiroy@kernel.org, Nicolas Pitre <nico@fluxnic.net>, Saeed Mahameed <saeedm@mellanox.com>, thellstrom@vmware.com, haojian.zhuang@gmail.com, geert@linux-m68k.org, linux-renesas-soc@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, kieran.bingham+renesas@ideasonboard.com, linux-graphics-maintainer@vmware.com, Laurent.pinchart@ideasonboard.com, jfrederich@gmail.com, robert.jarzmik@free.fr, daniel@zonque.org

Selecting FB_DDC currently turns on CONFIG_I2C implicitly,
which is often not desired and can lead to circular dependencies.

Change this to a 'depends on' and change all drivers that
rely on FB_DDC to have an appropriate I2C dependency as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/Kconfig | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 91b0a719d221..bcf7834dbdbf 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -62,9 +62,8 @@ config FIRMWARE_EDID
=20
 config FB_DDC
 	tristate
-	depends on FB
+	depends on FB && I2C
 	select I2C_ALGOBIT
-	select I2C
=20
 config FB_BOOT_VESA_SUPPORT
 	bool
@@ -356,6 +355,7 @@ config FB_CYBER2000
 config FB_CYBER2000_DDC
 	bool "DDC for CyberPro support"
 	depends on FB_CYBER2000
+	depends on I2C=3Dy || I2C=FB_CYBER2000
 	select FB_DDC
 	default y
 	help
@@ -892,6 +892,7 @@ config FB_NVIDIA
 config FB_NVIDIA_I2C
 	bool "Enable DDC Support"
 	depends on FB_NVIDIA
+	depends on I2C=3Dy || I2C=FB_NVIDIA
 	select FB_DDC
 	help
 	  This enables I2C support for nVidia Chipsets.  This is used
@@ -938,6 +939,7 @@ config FB_RIVA
 config FB_RIVA_I2C
 	bool "Enable DDC Support"
 	depends on FB_RIVA
+	depends on I2C=3Dy || I2C=FB_RIVA
 	select FB_DDC
 	help
 	  This enables I2C support for nVidia Chipsets.  This is used
@@ -965,7 +967,7 @@ config FB_RIVA_BACKLIGHT
=20
 config FB_I740
 	tristate "Intel740 support"
-	depends on FB && PCI
+	depends on FB && PCI && I2C
 	select FB_MODE_HELPERS
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
@@ -1019,6 +1021,7 @@ config FB_I810_GTF
 config FB_I810_I2C
 	bool "Enable DDC Support"
 	depends on FB_I810 && FB_I810_GTF
+	depends on I2C=3Dy || I2C=FB_I810
 	select FB_DDC
 	help
 	  Add DDC/I2C support for i810fb.  This will allow the driver to get
@@ -1074,6 +1077,7 @@ config FB_INTEL_DEBUG
 config FB_INTEL_I2C
 	bool "DDC/I2C for Intel framebuffer support"
 	depends on FB_INTEL
+	depends on I2C=3Dy || I2C=FB_INTEL
 	select FB_DDC
 	default y
 	help
@@ -1153,6 +1157,7 @@ config FB_MATROX_G
 config FB_MATROX_I2C
 	tristate "Matrox I2C support"
 	depends on FB_MATROX
+	depends on I2C=3Dy || I2C=FB_MATROX
 	select FB_DDC
 	---help---
 	  This drivers creates I2C buses which are needed for accessing the
@@ -1218,6 +1223,7 @@ config FB_RADEON
 config FB_RADEON_I2C
 	bool "DDC/I2C for ATI Radeon support"
 	depends on FB_RADEON
+	depends on I2C=3Dy || I2C=FB_RADEON
 	select FB_DDC
 	default y
 	help
@@ -1327,6 +1333,7 @@ config FB_S3
 config FB_S3_DDC
 	bool "DDC for S3 support"
 	depends on FB_S3
+	depends on I2C=3Dy || I2C=FB_S3
 	select FB_DDC
 	default y
 	help
@@ -1352,6 +1359,7 @@ config FB_SAVAGE
 config FB_SAVAGE_I2C
 	bool "Enable DDC2 Support"
 	depends on FB_SAVAGE
+	depends on I2C=3Dy || I2C=FB_SAVAGE
 	select FB_DDC
 	help
 	  This enables I2C support for S3 Savage Chipsets.  This is used
@@ -1491,6 +1499,7 @@ config FB_3DFX_ACCEL
 config FB_3DFX_I2C
 	bool "Enable DDC/I2C support"
 	depends on FB_3DFX
+	depends on I2C=3Dy || I2C=FB_3DFX
 	select FB_DDC
 	default y
 	help
@@ -1530,7 +1539,7 @@ config FB_VT8623
=20
 config FB_TRIDENT
 	tristate "Trident/CyberXXX/CyberBlade support"
-	depends on FB && PCI
+	depends on FB && PCI && I2C
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
--=20
2.26.0
