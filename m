From: Archit Taneja <archit@ti.com>
Date: Thu, 08 May 2014 09:27:12 +0000
Subject: [RFC 1/6] omapdss: remove check for simpler port/endpoint binding
Message-Id: <1399540517-17883-1-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

The support for simpler port/endpoint binding was removed in the merged version
of omapdss DT. But dss_init_ports still tries to get to an endpoint even if no
port exists. Remove this as this doesn't work.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/fbdev/omap2/dss/dss.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dss.c b/drivers/video/fbdev/omap2/dss/dss.c
index d55266c..31ef262 100644
--- a/drivers/video/fbdev/omap2/dss/dss.c
+++ b/drivers/video/fbdev/omap2/dss/dss.c
@@ -784,12 +784,8 @@ static int __init dss_init_ports(struct platform_device *pdev)
 		return 0;
 
 	port = omapdss_of_get_next_port(parent, NULL);
-	if (!port) {
-#ifdef CONFIG_OMAP2_DSS_DPI
-		dpi_init_port(pdev, parent);
-#endif
+	if (!port)
 		return 0;
-	}
 
 	do {
 		u32 reg;
-- 
1.8.3.2

