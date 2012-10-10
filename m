From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Date: Wed, 10 Oct 2012 18:39:18 +0000
Subject: [PATCH 3.6.0- 11/13] video/hecubafb: use module_platform_driver macro
Message-Id: <1349894358-9578-1-git-send-email-srinivas.kandagatla@st.com>
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
 drivers/video/hecubafb.c |   14 +-------------
 1 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/drivers/video/hecubafb.c b/drivers/video/hecubafb.c
index 614251a..12021ff 100644
--- a/drivers/video/hecubafb.c
+++ b/drivers/video/hecubafb.c
@@ -305,19 +305,7 @@ static struct platform_driver hecubafb_driver = {
 		.name	= "hecubafb",
 	},
 };
-
-static int __init hecubafb_init(void)
-{
-	return platform_driver_register(&hecubafb_driver);
-}
-
-static void __exit hecubafb_exit(void)
-{
-	platform_driver_unregister(&hecubafb_driver);
-}
-
-module_init(hecubafb_init);
-module_exit(hecubafb_exit);
+module_platform_driver(hecubafb_driver);
 
 MODULE_DESCRIPTION("fbdev driver for Hecuba/Apollo controller");
 MODULE_AUTHOR("Jaya Kumar");
-- 
1.7.0.4

