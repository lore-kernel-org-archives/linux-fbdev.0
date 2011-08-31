From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 31 Aug 2011 13:21:44 +0000
Subject: [PATCH 4/8] OMAP: DSS2: DSI: Add comment about regn
Message-Id: <1314796908-17354-5-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1314796908-17354-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1314796908-17354-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, mythripk@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

regn divider is one greater than the REGN divider in TRM. Add a comment
to point this out.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 include/video/omapdss.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 534e3d1..d4c85f2 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -450,6 +450,7 @@ struct omap_dss_device {
 		} dispc;
 
 		struct {
+			/* regn is one greater than TRM's REGN value */
 			u16 regn;
 			u16 regm;
 			u16 regm_dispc;
-- 
1.7.4.1

