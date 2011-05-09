From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 09 May 2011 14:40:24 +0000
Subject: [PATCH] OMAP2: avoid descending into disabled framebuffer dirs
Message-Id: <1304952024-28296-1-git-send-email-vapier@gentoo.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Rather than always add the omap2 dirs to the build list (and thus
force everyone to generate a useless built-in.o), bind the dirs to
their relevant kconfig symbol.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 drivers/video/omap2/Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/Makefile b/drivers/video/omap2/Makefile
index d853d05..5ddef12 100644
--- a/drivers/video/omap2/Makefile
+++ b/drivers/video/omap2/Makefile
@@ -1,6 +1,6 @@
 obj-$(CONFIG_OMAP2_VRAM) += vram.o
 obj-$(CONFIG_OMAP2_VRFB) += vrfb.o
 
-obj-y += dss/
-obj-y += omapfb/
+obj-$(CONFIG_OMAP2_DSS) += dss/
+obj-$(CONFIG_FB_OMAP2) += omapfb/
 obj-y += displays/
-- 
1.7.5.rc3

