From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Date: Wed, 10 Oct 2012 18:39:26 +0000
Subject: [PATCH 3.6.0- 12/13] video/jz4740_fb: use module_platform_driver macro
Message-Id: <1349894366-9613-1-git-send-email-srinivas.kandagatla@st.com>
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
 drivers/video/jz4740_fb.c |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/drivers/video/jz4740_fb.c b/drivers/video/jz4740_fb.c
index 3c63fc2..66d0c3c 100644
--- a/drivers/video/jz4740_fb.c
+++ b/drivers/video/jz4740_fb.c
@@ -828,18 +828,7 @@ static struct platform_driver jzfb_driver = {
 		.pm = JZFB_PM_OPS,
 	},
 };
-
-static int __init jzfb_init(void)
-{
-	return platform_driver_register(&jzfb_driver);
-}
-module_init(jzfb_init);
-
-static void __exit jzfb_exit(void)
-{
-	platform_driver_unregister(&jzfb_driver);
-}
-module_exit(jzfb_exit);
+module_platform_driver(jzfb_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
-- 
1.7.0.4

