From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Fri, 10 May 2013 11:47:07 +0000
Subject: [PATCH 1/1] video: smscufx: Use NULL instead of 0
Message-Id: <1368185707-12852-1-git-send-email-sachin.kamat@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

'info' is a pointer. Use NULL instead of 0.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/video/smscufx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/smscufx.c b/drivers/video/smscufx.c
index b2b33fc..e188ada 100644
--- a/drivers/video/smscufx.c
+++ b/drivers/video/smscufx.c
@@ -1622,7 +1622,7 @@ static int ufx_usb_probe(struct usb_interface *interface,
 {
 	struct usb_device *usbdev;
 	struct ufx_data *dev;
-	struct fb_info *info = 0;
+	struct fb_info *info = NULL;
 	int retval = -ENOMEM;
 	u32 id_rev, fpga_rev;
 
-- 
1.7.9.5

