From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 04 Dec 2015 13:14:58 +0000
Subject: [patch] OMAPDSS: DSS: fix a warning message
Message-Id: <20151204131458.GA12792@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org

The WARN() macro has to take a condition.  The current code will just
print the stack trace and the function name instead of the intended
warning message.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/video/fbdev/omap2/dss/dss.h b/drivers/video/fbdev/omap2/dss/dss.h
index 2406bcd..da3a85a 100644
--- a/drivers/video/fbdev/omap2/dss/dss.h
+++ b/drivers/video/fbdev/omap2/dss/dss.h
@@ -343,7 +343,8 @@ u8 dsi_get_pixel_size(enum omap_dss_dsi_pixel_format fmt);
 #else
 static inline u8 dsi_get_pixel_size(enum omap_dss_dsi_pixel_format fmt)
 {
-	WARN("%s: DSI not compiled in, returning pixel_size as 0\n", __func__);
+	WARN(1, "%s: DSI not compiled in, returning pixel_size as 0\n",
+	     __func__);
 	return 0;
 }
 #endif
