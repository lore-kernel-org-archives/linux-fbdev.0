From: H Hartley Sweeten <hartleys@visionengravers.com>
Date: Sat, 16 Mar 2013 01:03:08 +0000
Subject: [PATCH 1/3] backlight: ep93xx_bl: fix section mismatch
Message-Id: <201303151803.08774.hartleys@visionengravers.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: linux-fbdev@vger.kernel.org, Ryan Mallon <rmallon@gmail.com>, rpurdie@rpsys.net, FlorianSchandinat@gmx.de

Remove the __init tag from ep93xxbl_probe() to fix the section
mismatch warning.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <rmallon@gmail.com>
Cc: Richard Purdie <rpurdie@rpsys.net>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
---
 drivers/video/backlight/ep93xx_bl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/backlight/ep93xx_bl.c b/drivers/video/backlight/ep93xx_bl.c
index ef3e21e..17b8abb 100644
--- a/drivers/video/backlight/ep93xx_bl.c
+++ b/drivers/video/backlight/ep93xx_bl.c
@@ -60,7 +60,7 @@ static const struct backlight_ops ep93xxbl_ops = {
 	.get_brightness	= ep93xxbl_get_brightness,
 };
 
-static int __init ep93xxbl_probe(struct platform_device *dev)
+static int ep93xxbl_probe(struct platform_device *dev)
 {
 	struct ep93xxbl *ep93xxbl;
 	struct backlight_device *bl;
@@ -145,7 +145,6 @@ static struct platform_driver ep93xxbl_driver = {
 	.suspend	= ep93xxbl_suspend,
 	.resume		= ep93xxbl_resume,
 };
-
 module_platform_driver(ep93xxbl_driver);
 
 MODULE_DESCRIPTION("EP93xx Backlight Driver");
-- 
1.8.1.4

