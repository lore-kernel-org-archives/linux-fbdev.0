From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Date: Wed, 10 Oct 2012 18:38:36 +0000
Subject: [PATCH 3.6.0- 06/13] video/broadsheetfb: use module_platform_driver macro
Message-Id: <1349894316-9394-1-git-send-email-srinivas.kandagatla@st.com>
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
 drivers/video/broadsheetfb.c |   14 +-------------
 1 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/drivers/video/broadsheetfb.c b/drivers/video/broadsheetfb.c
index c95b417..d69c5de 100644
--- a/drivers/video/broadsheetfb.c
+++ b/drivers/video/broadsheetfb.c
@@ -1217,19 +1217,7 @@ static struct platform_driver broadsheetfb_driver = {
 		.name	= "broadsheetfb",
 	},
 };
-
-static int __init broadsheetfb_init(void)
-{
-	return platform_driver_register(&broadsheetfb_driver);
-}
-
-static void __exit broadsheetfb_exit(void)
-{
-	platform_driver_unregister(&broadsheetfb_driver);
-}
-
-module_init(broadsheetfb_init);
-module_exit(broadsheetfb_exit);
+module_platform_driver(broadsheetfb_driver);
 
 MODULE_DESCRIPTION("fbdev driver for Broadsheet controller");
 MODULE_AUTHOR("Jaya Kumar");
-- 
1.7.0.4

