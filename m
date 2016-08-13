From: Wei Yongjun <weiyj.lk@gmail.com>
Date: Sat, 13 Aug 2016 01:26:26 +0000
Subject: [PATCH -next] video: ARM CLCD: fix return value check in versatile_clcd_init_panel()
Message-Id: <1471051586-26189-1-git-send-email-weiyj.lk@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

In case of error, the function syscon_node_to_regmap() returns ERR_PTR()
and never returns NULL. The NULL test in the return value check should
be replaced with IS_ERR().

Fixes: 25348160e9a4 ("video: ARM CLCD: add special panel hook for Versatiles")
Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
---
 drivers/video/fbdev/amba-clcd-versatile.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/amba-clcd-versatile.c b/drivers/video/fbdev/amba-clcd-versatile.c
index 9a90817..56161f9 100644
--- a/drivers/video/fbdev/amba-clcd-versatile.c
+++ b/drivers/video/fbdev/amba-clcd-versatile.c
@@ -528,9 +528,9 @@ int versatile_clcd_init_panel(struct clcd_fb *fb,
 	versatile_clcd_type = (enum versatile_clcd)clcd_id->data;
 
 	map = syscon_node_to_regmap(np);
-	if (!map) {
+	if (IS_ERR(map)) {
 		dev_err(dev, "no Versatile syscon regmap\n");
-		return -ENODEV;
+		return PTR_ERR(map);
 	}
 
 	switch (versatile_clcd_type) {

