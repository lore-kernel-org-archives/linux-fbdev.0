From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 31 Jan 2017 18:25:36 +0000
Subject: [PATCH] video: fbdev: offb: switch to using for_each_node_by_type
Message-Id: <20170131182536.GA30076@dtor-ws>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Yongji Xie <xyjxie@linux.vnet.ibm.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Instead of open-coding loops let's switch to a nice macro.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/video/fbdev/offb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/offb.c b/drivers/video/fbdev/offb.c
index 906c6e75c260..9be884b0c778 100644
--- a/drivers/video/fbdev/offb.c
+++ b/drivers/video/fbdev/offb.c
@@ -668,14 +668,14 @@ static int __init offb_init(void)
 		offb_init_nodriver(of_chosen, 1);
 	}
 
-	for (dp = NULL; (dp = of_find_node_by_type(dp, "display"));) {
+	for_each_node_by_type(dp, "display") {
 		if (of_get_property(dp, "linux,opened", NULL) &&
 		    of_get_property(dp, "linux,boot-display", NULL)) {
 			boot_disp = dp;
 			offb_init_nodriver(dp, 0);
 		}
 	}
-	for (dp = NULL; (dp = of_find_node_by_type(dp, "display"));) {
+	for_each_node_by_type(dp, "display") {
 		if (of_get_property(dp, "linux,opened", NULL) &&
 		    dp != boot_disp)
 			offb_init_nodriver(dp, 0);
-- 
2.11.0.483.g087da7b7c-goog


-- 
Dmitry
