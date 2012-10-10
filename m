From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Date: Wed, 10 Oct 2012 18:38:44 +0000
Subject: [PATCH 3.6.0- 07/13] video/cobalt_lcdfb: use module_platform_driver macro
Message-Id: <1349894324-9428-1-git-send-email-srinivas.kandagatla@st.com>
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
 drivers/video/cobalt_lcdfb.c |   14 +-------------
 1 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/drivers/video/cobalt_lcdfb.c b/drivers/video/cobalt_lcdfb.c
index eae46f6..9d43f1c 100644
--- a/drivers/video/cobalt_lcdfb.c
+++ b/drivers/video/cobalt_lcdfb.c
@@ -396,19 +396,7 @@ static struct platform_driver cobalt_lcdfb_driver = {
 		.owner	= THIS_MODULE,
 	},
 };
-
-static int __init cobalt_lcdfb_init(void)
-{
-	return platform_driver_register(&cobalt_lcdfb_driver);
-}
-
-static void __exit cobalt_lcdfb_exit(void)
-{
-	platform_driver_unregister(&cobalt_lcdfb_driver);
-}
-
-module_init(cobalt_lcdfb_init);
-module_exit(cobalt_lcdfb_exit);
+module_platform_driver(cobalt_lcdfb_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Yoichi Yuasa");
-- 
1.7.0.4

