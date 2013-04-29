From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 29 Apr 2013 10:22:28 +0000
Subject: [PATCH 01/10] OMAPDSS: Makefile: move omapfb after panels
Message-Id: <1367230957-32337-2-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1367230957-32337-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1367230957-32337-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, grygorii.strashko@ti.com, chf.fritz@googlemail.com, Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

omapfb requires the panels to have been probed before omapfb's probe. We
currently manage that by having omapfb in late initcall level. However,
a much simpler way is to just change the makefile so that omapfb is
after the panel drivers.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/omap2/Makefile b/drivers/video/omap2/Makefile
index 5ea7cb9..296e5c5 100644
--- a/drivers/video/omap2/Makefile
+++ b/drivers/video/omap2/Makefile
@@ -1,5 +1,5 @@
 obj-$(CONFIG_OMAP2_VRFB) += vrfb.o
 
 obj-$(CONFIG_OMAP2_DSS) += dss/
-obj-$(CONFIG_FB_OMAP2) += omapfb/
 obj-y += displays/
+obj-$(CONFIG_FB_OMAP2) += omapfb/
-- 
1.7.10.4

