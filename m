From: Jarkko Nikula <jhnikula@gmail.com>
Date: Tue, 01 Mar 2011 08:40:37 +0000
Subject: [PATCH] omapfb: Fix linker error in drivers/video/omap/lcd_2430sdp.c
Message-Id: <1298968837-13584-1-git-send-email-jhnikula@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1298905757.9809.135.camel@deskari>
In-Reply-To: <1298905757.9809.135.camel@deskari>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jarkko Nikula <jhnikula@gmail.com>

There is a linker error from lcd_2430sdp.c if CONFIG_TWL4030_CORE is not
set. This can be triggered on OMAP2 builds when OMAP3 or OMAP4 are not set.

drivers/built-in.o: In function `sdp2430_panel_disable':
drivers/video/omap/lcd_2430sdp.c:123: undefined reference to `twl_i2c_write_u8'
drivers/video/omap/lcd_2430sdp.c:124: undefined reference to `twl_i2c_write_u8'
drivers/built-in.o: In function `sdp2430_panel_enable':
drivers/video/omap/lcd_2430sdp.c:110: undefined reference to `twl_i2c_write_u8'
drivers/video/omap/lcd_2430sdp.c:112: undefined reference to `twl_i2c_write_u8'

Fix this by selecting the TWL4030_CORE for MACH_OMAP_2430SDP when building
with CONFIG_FB_OMAP as there is no own Kconfig entry for lcd_2430 and it is
compiled always when both MACH_OMAP_2430SDP and FB_OMAP are set.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
Quite old issue probably. I don't think any fancier fix is required as this
is legacy omapfb code?
---
 drivers/video/omap/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap/Kconfig b/drivers/video/omap/Kconfig
index 083c8fe..c981249 100644
--- a/drivers/video/omap/Kconfig
+++ b/drivers/video/omap/Kconfig
@@ -5,6 +5,7 @@ config FB_OMAP
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
+	select TWL4030_CORE if MACH_OMAP_2430SDP
 	help
           Frame buffer driver for OMAP based boards.
 
-- 
1.7.2.3

