From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Date: Wed, 10 Oct 2012 18:38:29 +0000
Subject: [PATCH 3.6.0- 05/13] video/bfin-t350mcqb: use module_platform_driver macro
Message-Id: <1349894309-9361-1-git-send-email-srinivas.kandagatla@st.com>
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
 drivers/video/bfin-t350mcqb-fb.c |   14 +-------------
 1 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/drivers/video/bfin-t350mcqb-fb.c b/drivers/video/bfin-t350mcqb-fb.c
index 7a0c05f..b4518f8 100644
--- a/drivers/video/bfin-t350mcqb-fb.c
+++ b/drivers/video/bfin-t350mcqb-fb.c
@@ -666,18 +666,6 @@ static struct platform_driver bfin_t350mcqb_driver = {
 		   },
 };
 
-static int __init bfin_t350mcqb_driver_init(void)
-{
-	return platform_driver_register(&bfin_t350mcqb_driver);
-}
-
-static void __exit bfin_t350mcqb_driver_cleanup(void)
-{
-	platform_driver_unregister(&bfin_t350mcqb_driver);
-}
-
 MODULE_DESCRIPTION("Blackfin TFT LCD Driver");
 MODULE_LICENSE("GPL");
-
-module_init(bfin_t350mcqb_driver_init);
-module_exit(bfin_t350mcqb_driver_cleanup);
+module_platform_driver(bfin_t350mcqb_driver);
-- 
1.7.0.4

