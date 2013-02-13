From: Archit Taneja <archit@ti.com>
Date: Wed, 13 Feb 2013 14:34:25 +0000
Subject: [PATCH 33/33] OMAPDSS: remove reset_gpio field from omap_dss_device
Message-Id: <1360765345-19312-34-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1360765345-19312-1-git-send-email-archit@ti.com>
In-Reply-To: <1360765345-19312-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The reset_gpio field isn't used by any panel driver to retrieve a reset gpio
number. All the panel drivers receive gpio data from their corresponding
platform_data structs. Remove the reset_gpio field.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 include/video/omapdss.h |    2 --
 1 file changed, 2 deletions(-)

diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index e1ebb48..fe8672c 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -629,8 +629,6 @@ struct omap_dss_device {
 		struct rfbi_timings rfbi_timings;
 	} ctrl;
 
-	int reset_gpio;
-
 	const char *name;
 
 	/* used to match device to driver */
-- 
1.7.9.5

