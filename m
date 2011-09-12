From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 12 Sep 2011 09:12:49 +0000
Subject: [PATCHv2 4/8] OMAP: DSS2: DSI: Add comment about regn
Message-Id: <1315818773-18660-5-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1315818773-18660-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1315818773-18660-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

regn divider is one greater than the REGN divider in TRM. Add a comment
to point this out.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 include/video/omapdss.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 528cf79..ce1aacd 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -503,6 +503,7 @@ struct omap_dss_device {
 		} dispc;
 
 		struct {
+			/* regn is one greater than TRM's REGN value */
 			u16 regn;
 			u16 regm;
 			u16 regm_dispc;
-- 
1.7.4.1

