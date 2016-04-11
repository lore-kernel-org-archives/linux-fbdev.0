From: Alan <alan@linux.intel.com>
Date: Mon, 11 Apr 2016 13:30:37 +0000
Subject: [PATCH 3/4] goldfish_fb: Set pixclock = 0
Message-Id: <20160411133035.23962.14637.stgit@localhost.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Christoffer Dall <christoffer.dall@linaro.org>

User space Android code identifies pixclock = 0 as a sign for
emulation and will set the frame rate to 60 fps when reading
this value, which is the desired outcome.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jin Qian <jinqian@android.com>
Signed-off-by: Alan <alan@linux.intel.com>
---
 drivers/video/fbdev/goldfishfb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/goldfishfb.c b/drivers/video/fbdev/goldfishfb.c
index 58b33e4..131fee0 100644
--- a/drivers/video/fbdev/goldfishfb.c
+++ b/drivers/video/fbdev/goldfishfb.c
@@ -235,7 +235,7 @@ static int goldfish_fb_probe(struct platform_device *pdev)
 	fb->fb.var.activate	= FB_ACTIVATE_NOW;
 	fb->fb.var.height	= readl(fb->reg_base + FB_GET_PHYS_HEIGHT);
 	fb->fb.var.width	= readl(fb->reg_base + FB_GET_PHYS_WIDTH);
-	fb->fb.var.pixclock	= 10000;
+	fb->fb.var.pixclock	= 0;
 
 	fb->fb.var.red.offset = 11;
 	fb->fb.var.red.length = 5;

