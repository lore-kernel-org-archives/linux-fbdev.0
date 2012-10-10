From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Date: Wed, 10 Oct 2012 18:39:41 +0000
Subject: [PATCH 3.6.0- 13/13] video/metronomefb: use module_platform_driver macro
Message-Id: <1349894381-9648-1-git-send-email-srinivas.kandagatla@st.com>
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
 drivers/video/metronomefb.c |   14 +-------------
 1 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/drivers/video/metronomefb.c b/drivers/video/metronomefb.c
index 97d45e5..2cd031f 100644
--- a/drivers/video/metronomefb.c
+++ b/drivers/video/metronomefb.c
@@ -770,21 +770,9 @@ static struct platform_driver metronomefb_driver = {
 	},
 };
 
-static int __init metronomefb_init(void)
-{
-	return platform_driver_register(&metronomefb_driver);
-}
-
-static void __exit metronomefb_exit(void)
-{
-	platform_driver_unregister(&metronomefb_driver);
-}
-
 module_param(user_wfm_size, uint, 0);
 MODULE_PARM_DESC(user_wfm_size, "Set custom waveform size");
-
-module_init(metronomefb_init);
-module_exit(metronomefb_exit);
+module_platform_driver(metronomefb_driver);
 
 MODULE_DESCRIPTION("fbdev driver for Metronome controller");
 MODULE_AUTHOR("Jaya Kumar");
-- 
1.7.0.4

