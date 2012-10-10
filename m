From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Date: Wed, 10 Oct 2012 18:38:21 +0000
Subject: [PATCH 3.6.0- 04/13] video/bfin-lq035q1: use module_platform_driver macro
Message-Id: <1349894301-9326-1-git-send-email-srinivas.kandagatla@st.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

This patch removes some code duplication by using
module_platform_driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
---
 drivers/video/bfin-lq035q1-fb.c |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/drivers/video/bfin-lq035q1-fb.c b/drivers/video/bfin-lq035q1-fb.c
index 353c02f..092ca6b 100644
--- a/drivers/video/bfin-lq035q1-fb.c
+++ b/drivers/video/bfin-lq035q1-fb.c
@@ -852,18 +852,7 @@ static struct platform_driver bfin_lq035q1_driver = {
 #endif
 	},
 };
-
-static int __init bfin_lq035q1_driver_init(void)
-{
-	return platform_driver_register(&bfin_lq035q1_driver);
-}
-module_init(bfin_lq035q1_driver_init);
-
-static void __exit bfin_lq035q1_driver_cleanup(void)
-{
-	platform_driver_unregister(&bfin_lq035q1_driver);
-}
-module_exit(bfin_lq035q1_driver_cleanup);
+module_platform_driver(bfin_lq035q1_driver);
 
 MODULE_DESCRIPTION("Blackfin TFT LCD Driver");
 MODULE_LICENSE("GPL");
-- 
1.7.0.4

