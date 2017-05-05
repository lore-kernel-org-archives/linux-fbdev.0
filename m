From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 05 May 2017 19:47:20 +0000
Subject: [PATCH 3.16-stable 62/87] video: mx3fb: always enable BACKLIGHT_LCD_SUPPORT
Message-Id: <20170505194745.3627137-63-arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170505194745.3627137-1-arnd@arndb.de>
In-Reply-To: <20170505194745.3627137-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Hutchings <ben@decadent.org.uk>
Cc: stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Alexander Stein <alexander.stein@systec-electronic.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

Commit d06268f2c4867279648f499a31fba79a4066f3af upstream.

Commit 7edaa761ee81b ("video: mx3fb: Add backlight control support")
changed the mx3fb driver so it always selects the BACKLIGHT_CLASS_DEVICE
symbol, but that is hidden behind BACKLIGHT_LCD_SUPPORT in Kconfig, so
we get a Kconfig warning for multi_v5_defconfig, which doesn't have that:

Warning: (DRM_RADEON && DRM_NOUVEAU && DRM_I915 && DRM_GMA500 &&
DRM_SHMOBILE && DRM_TILCDC && FB_BACKLIGHT && FB_MX3 && USB_APPLEDISPLAY
&& FB_OLPC_DCON && ASUS_LAPTOP && SONY_LAPTOP && THINKPAD_ACPI &&
EEEPC_LAPTOP && ACPI_CMPC && SAMSUNG_Q10) selects BACKLIGHT_CLASS_DEVICE
which has unmet direct dependencies (HAS_IOMEM && BACKLIGHT_LCD_SUPPORT)

This makes sure we always enable both symbols together for mx3fb, like
we do for the other drivers that can't be built without backlight
support. Note that a better solution would be to ensure the driver can
work with or without backlight support.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index fac73ceb90e5..3b453c34f7a2 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -2332,10 +2332,11 @@ config FB_MSM
 config FB_MX3
 	tristate "MX3 Framebuffer support"
 	depends on FB && MX3_IPU
+	select BACKLIGHT_CLASS_DEVICE
+	select BACKLIGHT_LCD_SUPPORT
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select BACKLIGHT_CLASS_DEVICE
 	default y
 	help
 	  This is a framebuffer device for the i.MX31 LCD Controller. So
-- 
2.9.0

