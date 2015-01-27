From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 27 Jan 2015 10:50:34 +0000
Subject: [PATCH 06/14] OMAPDSS: add define for DRA7xx HW version
Message-Id: <1422355842-11234-7-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1422355842-11234-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1422355842-11234-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add define for DRA7xx DSS version.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 include/video/omapdss.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 6a84498ea513..60de61fea8e3 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -314,6 +314,7 @@ enum omapdss_version {
 	OMAPDSS_VER_OMAP4,		/* All other OMAP4s */
 	OMAPDSS_VER_OMAP5,
 	OMAPDSS_VER_AM43xx,
+	OMAPDSS_VER_DRA7xx,
 };
 
 /* Board specific data */
-- 
2.2.2

