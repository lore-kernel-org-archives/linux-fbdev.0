From: Yifeng Li <tomli@tomli.me>
Date: Sat, 02 Feb 2019 06:16:47 +0000
Subject: [PATCH 7/8] fbdev: sm712fb: Kconfig: add information about docs.
Message-Id: <20190202061648.30374-8-tomli@tomli.me>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190202061648.30374-1-tomli@tomli.me>
In-Reply-To: <20190202061648.30374-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Yifeng Li <tomli@tomli.me>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Randy Dunlap <rdunlap@infradead.org>, Ulf Magnusson <ulfalizer@gmail.com>, Arnd Bergmann <arnd@arndb.de>

This commits update the Kconfig description of sm712fb,
and inform the user about the existence of documentation.

Signed-off-by: Yifeng Li <tomli@tomli.me>
---
 drivers/video/fbdev/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index ae7712c9687a..4f3c0075352a 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -2302,6 +2302,10 @@ config FB_SM712
 	  called sm712fb. If you want to compile it as a module, say M
 	  here and read <file:Documentation/kbuild/modules.txt>.
 
+	  Warning: this driver has many known problems and limitations,
+	  please make sure you've checked the documentation, at
+	  <file:Documentation/fb/sm712fb.txt>.
+
 source "drivers/video/fbdev/omap/Kconfig"
 source "drivers/video/fbdev/omap2/Kconfig"
 source "drivers/video/fbdev/mmp/Kconfig"
-- 
2.20.1
