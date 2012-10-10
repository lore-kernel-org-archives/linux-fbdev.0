From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Date: Wed, 10 Oct 2012 18:38:59 +0000
Subject: [PATCH 3.6.0- 09/13] video/ep93xx_fb: use module_platform_driver macro
Message-Id: <1349894339-9495-1-git-send-email-srinivas.kandagatla@st.com>
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
 drivers/video/ep93xx-fb.c |   14 +-------------
 1 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/drivers/video/ep93xx-fb.c b/drivers/video/ep93xx-fb.c
index f2c092d..cfebe9f 100644
--- a/drivers/video/ep93xx-fb.c
+++ b/drivers/video/ep93xx-fb.c
@@ -631,19 +631,7 @@ static struct platform_driver ep93xxfb_driver = {
 		.owner	= THIS_MODULE,
 	},
 };
-
-static int __devinit ep93xxfb_init(void)
-{
-	return platform_driver_register(&ep93xxfb_driver);
-}
-
-static void __exit ep93xxfb_exit(void)
-{
-	platform_driver_unregister(&ep93xxfb_driver);
-}
-
-module_init(ep93xxfb_init);
-module_exit(ep93xxfb_exit);
+module_platform_driver(ep93xxfb_driver);
 
 MODULE_DESCRIPTION("EP93XX Framebuffer Driver");
 MODULE_ALIAS("platform:ep93xx-fb");
-- 
1.7.0.4

