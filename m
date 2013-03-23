From: Tony Prisk <linux@prisktech.co.nz>
Date: Sat, 23 Mar 2013 06:46:33 +0000
Subject: [PATCH 5/5] video: vt8500: Adjust contrast in wm8505 framebuffer driver.
Message-Id: <1364021193-19835-6-git-send-email-linux@prisktech.co.nz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1364021193-19835-1-git-send-email-linux@prisktech.co.nz>
In-Reply-To: <1364021193-19835-1-git-send-email-linux@prisktech.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The contrast value was typo'd on the original commit (0x80 instead of
0x08). Following feedback from an enduser, a value of 0x10 seems more
suitable due to the default backlight being <100%.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 drivers/video/wm8505fb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/wm8505fb.c b/drivers/video/wm8505fb.c
index b94ebc9..5057457 100644
--- a/drivers/video/wm8505fb.c
+++ b/drivers/video/wm8505fb.c
@@ -373,7 +373,7 @@ static int wm8505fb_probe(struct platform_device *pdev)
 	fbi->fb.screen_base		= fb_mem_virt;
 	fbi->fb.screen_size		= fb_mem_len;
 
-	fbi->contrast = 0x80;
+	fbi->contrast = 0x10;
 	ret = wm8505fb_set_par(&fbi->fb);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to set parameters\n");
-- 
1.7.9.5

