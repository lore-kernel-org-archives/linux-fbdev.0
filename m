From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Date: Wed, 10 Oct 2012 18:38:05 +0000
Subject: [PATCH 3.6.0- 03/13] video/bf54x-lq043fb: use module_platform_driver macro
Message-Id: <1349894285-9291-1-git-send-email-srinivas.kandagatla@st.com>
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
 drivers/video/bf54x-lq043fb.c |   14 +-------------
 1 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/drivers/video/bf54x-lq043fb.c b/drivers/video/bf54x-lq043fb.c
index dc2f004..a33cfaf 100644
--- a/drivers/video/bf54x-lq043fb.c
+++ b/drivers/video/bf54x-lq043fb.c
@@ -764,18 +764,6 @@ static struct platform_driver bfin_bf54x_driver = {
 		   },
 };
 
-static int __init bfin_bf54x_driver_init(void)
-{
-	return platform_driver_register(&bfin_bf54x_driver);
-}
-
-static void __exit bfin_bf54x_driver_cleanup(void)
-{
-	platform_driver_unregister(&bfin_bf54x_driver);
-}
-
 MODULE_DESCRIPTION("Blackfin BF54x TFT LCD Driver");
 MODULE_LICENSE("GPL");
-
-module_init(bfin_bf54x_driver_init);
-module_exit(bfin_bf54x_driver_cleanup);
+module_platform_driver(bfin_bf54x_driver);
-- 
1.7.0.4

