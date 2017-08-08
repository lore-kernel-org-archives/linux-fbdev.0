From: Michal Simek <michal.simek@xilinx.com>
Date: Tue, 08 Aug 2017 08:10:26 +0000
Subject: [PATCH 2/2] video: fbdev: Enable Xilinx FB for ZynqMP
Message-Id: <b10c4df7c5ac10d9290c3b9d2f113fb2f337b110.1502179820.git.michal.simek@xilinx.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <b07b143769ed5dccf44e9de4cb0d5c6203b3eca0.1502179820.git.michal.simek@xilinx.com>
In-Reply-To: <b07b143769ed5dccf44e9de4cb0d5c6203b3eca0.1502179820.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Arnd Bergmann <arnd@arndb.de>, linux-fbdev@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, Paul Burton <paul.burton@imgtec.com>

Enable this driver for Xilinx ZynqMP.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/video/fbdev/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 5c6696bb56da..5e58f5ec0a28 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -2173,7 +2173,7 @@ config FB_PS3_DEFAULT_SIZE_M
 
 config FB_XILINX
 	tristate "Xilinx frame buffer support"
-	depends on FB && (XILINX_VIRTEX || MICROBLAZE || ARCH_ZYNQ)
+	depends on FB && (XILINX_VIRTEX || MICROBLAZE || ARCH_ZYNQ || ARCH_ZYNQMP)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-- 
1.9.1

