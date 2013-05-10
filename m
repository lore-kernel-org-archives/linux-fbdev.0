From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Fri, 10 May 2013 11:58:48 +0000
Subject: [PATCH 1/2] video: udlfb: Use NULL instead of 0
Message-Id: <1368186409-30709-1-git-send-email-sachin.kamat@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Pointer variables should be initialized with NULL instead of 0.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/video/udlfb.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/udlfb.c b/drivers/video/udlfb.c
index ec03e72..20353a6 100644
--- a/drivers/video/udlfb.c
+++ b/drivers/video/udlfb.c
@@ -434,10 +434,10 @@ static void dlfb_compress_hline(
 
 	while ((pixel_end > pixel) &&
 	       (cmd_buffer_end - MIN_RLX_CMD_BYTES > cmd)) {
-		uint8_t *raw_pixels_count_byte = 0;
-		uint8_t *cmd_pixels_count_byte = 0;
-		const uint16_t *raw_pixel_start = 0;
-		const uint16_t *cmd_pixel_start, *cmd_pixel_end = 0;
+		uint8_t *raw_pixels_count_byte = NULL;
+		uint8_t *cmd_pixels_count_byte = NULL;
+		const uint16_t *raw_pixel_start = NULL;
+		const uint16_t *cmd_pixel_start, *cmd_pixel_end = NULL;
 
 		prefetchw((void *) cmd); /* pull in one cache line at least */
 
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

