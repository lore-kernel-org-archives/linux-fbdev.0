From: Sebastian Frias <sf84@laposte.net>
Date: Tue, 29 Dec 2015 13:15:19 +0000
Subject: [RFC PATCH] fbdev: add support for Sigma Designs' smp8xxxfb.ko
Message-Id: <56828767.4050302@laposte.net>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, mason <slash.tmp@free.fr>, =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>

Hi,

We are wondering what is the recommended way of adding support for a 
framebuffer driver on the Linux kernel.
Below you can find a patch with a proposed solution.

Our frambuffer driver source code is provided separately, but right now 
it requires "cfb_fillrect", "cfb_copyarea" and "cfb_imageblit" to be 
provided by the kernel.

Our current kernel fork (based on 3.4) hardcodes FB_CFB_FILLRECT, 
FB_CFB_COPYAREA and FB_CFB_IMAGEBLIT to yes.
Since we are in the process of migrating to 4.x and upstreaming changes 
along the way, we would like to know if the patch below is the way to go 
with it or if you have suggestions to improve it.

Thanks in advance,

Sebastian


-- >8 --

Subject: [RFC PATCH] fbdev: add support for Sigma Designs' smp8xxxfb.ko

Signed-off-by: Sebastian Frias <sf84@laposte.net>
---
  drivers/video/fbdev/Kconfig |   10 ++++++++++
  1 file changed, 10 insertions(+)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index e6d16d6..46c4ab2 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -615,6 +615,16 @@ config FB_BF537_LQ035
           To compile this driver as a module, choose M here: the
           module will be called bf537-lq035.

+config FB_TANGO
+       bool "Sigma Designs FrameBuffer support"
+       depends on FB && ARCH_TANGO
+       select FB_CFB_FILLRECT
+       select FB_CFB_COPYAREA
+       select FB_CFB_IMAGEBLIT
+       help
+         You need to enable this if you intend to use Sigma
+         Designs' smp8xxxfb.ko driver.
+
  config FB_BFIN_7393
         tristate "Blackfin ADV7393 Video encoder"
         depends on FB && BLACKFIN
-- 
1.7.10.4
