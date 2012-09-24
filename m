From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 24 Sep 2012 13:58:37 +0000
Subject: [PATCH 7/9] OMAPDSS: DSI: Add new linebuffer size for OMAP5
Message-Id: <1348495119-8262-8-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1348495119-8262-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1348495119-8262-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

OMAP5's DSI has a larger line buffer than earlier OMAPs. This patch adds
support for this to the DSI driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index a16c8b2..0dc24f2 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -2155,6 +2155,8 @@ static unsigned dsi_get_line_buf_size(struct platform_device *dsidev)
 		return 1194 * 3;	/* 1194x24 bits */
 	case 6:
 		return 1365 * 3;	/* 1365x24 bits */
+	case 7:
+		return 1920 * 3;	/* 1920x24 bits */
 	default:
 		BUG();
 		return 0;
-- 
1.7.9.5

