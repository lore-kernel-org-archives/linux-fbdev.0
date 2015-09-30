From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Wed, 30 Sep 2015 10:06:08 +0000
Subject: [PATCH] video: of: fix memory leak
Message-Id: <1443606848-31510-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

If of_parse_display_timing() fails we are printing an error message and
jumping to the error path but we missed freeing "dt".

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/video/of_display_timing.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/of_display_timing.c b/drivers/video/of_display_timing.c
index 32d8275..8a1076b 100644
--- a/drivers/video/of_display_timing.c
+++ b/drivers/video/of_display_timing.c
@@ -210,6 +210,7 @@ struct display_timings *of_get_display_timings(struct device_node *np)
 			 */
 			pr_err("%s: error in timing %d\n",
 				of_node_full_name(np), disp->num_timings + 1);
+			kfree(dt);
 			goto timingfail;
 		}
 
-- 
1.9.1

