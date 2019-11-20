From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 20 Nov 2019 13:39:11 +0000
Subject: [PATCH] staging: fbtft: Fix Kconfig indentation
Message-Id: <20191120133911.13539-1-krzk@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/staging/fbtft/Kconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/fbtft/Kconfig b/drivers/staging/fbtft/Kconfig
index d994aea84b21..19d9d88e9150 100644
--- a/drivers/staging/fbtft/Kconfig
+++ b/drivers/staging/fbtft/Kconfig
@@ -95,8 +95,8 @@ config FB_TFT_PCD8544
 	  Generic Framebuffer support for PCD8544
 
 config FB_TFT_RA8875
-        tristate "FB driver for the RA8875 LCD Controller"
-        depends on FB_TFT
+	tristate "FB driver for the RA8875 LCD Controller"
+	depends on FB_TFT
 	help
 	  Generic Framebuffer support for RA8875
 
@@ -132,10 +132,10 @@ config FB_TFT_SSD1289
 	  Framebuffer support for SSD1289
 
 config FB_TFT_SSD1305
-        tristate "FB driver for the SSD1305 OLED Controller"
-        depends on FB_TFT
-        help
-          Framebuffer support for SSD1305
+	tristate "FB driver for the SSD1305 OLED Controller"
+	depends on FB_TFT
+	help
+	  Framebuffer support for SSD1305
 
 config FB_TFT_SSD1306
 	tristate "FB driver for the SSD1306 OLED Controller"
-- 
2.17.1
