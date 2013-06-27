From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Thu, 27 Jun 2013 07:27:17 +0000
Subject: [PATCH 1/1] video: i740fb: Make i740fb_init static
Message-Id: <1372317317-4649-1-git-send-email-sachin.kamat@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

i740fb_init is referenced only in this function. Make it static.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Ondrej Zary <linux@rainbow-software.org>
---
 drivers/video/i740fb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/i740fb.c b/drivers/video/i740fb.c
index cfd0c52e..6c48388 100644
--- a/drivers/video/i740fb.c
+++ b/drivers/video/i740fb.c
@@ -1302,7 +1302,7 @@ static int  __init i740fb_setup(char *options)
 }
 #endif
 
-int __init i740fb_init(void)
+static int __init i740fb_init(void)
 {
 #ifndef MODULE
 	char *option = NULL;
-- 
1.7.9.5

