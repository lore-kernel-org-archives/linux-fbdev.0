From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Fri, 10 May 2013 11:50:26 +0000
Subject: [PATCH 1/1] video: udlfb: Use NULL instead of 0
Message-Id: <1368185906-13351-1-git-send-email-sachin.kamat@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

'dev' is a pointer. Use NULL instead of 0.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/video/udlfb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/udlfb.c b/drivers/video/udlfb.c
index ec03e72..04eadc6 100644
--- a/drivers/video/udlfb.c
+++ b/drivers/video/udlfb.c
@@ -1588,7 +1588,7 @@ static int dlfb_usb_probe(struct usb_interface *interface,
 			const struct usb_device_id *id)
 {
 	struct usb_device *usbdev;
-	struct dlfb_data *dev = 0;
+	struct dlfb_data *dev = NULL;
 	int retval = -ENOMEM;
 
 	/* usb initialization */
-- 
1.7.9.5

