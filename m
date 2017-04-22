From: Maksim Salau <maksim.salau@gmail.com>
Date: Sat, 22 Apr 2017 16:49:22 +0000
Subject: [PATCH] video: fbdev: udlfb: Fix buffer on stack
Message-Id: <20170422164922.9472-1-maksim.salau@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Allocate buffers on HEAP instead of STACK for local array
that is to be sent using usb_control_msg().

Signed-off-by: Maksim Salau <maksim.salau@gmail.com>
---
 drivers/video/fbdev/udlfb.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index e9c2f7b..1e83e19 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1487,15 +1487,27 @@ static struct device_attribute fb_device_attrs[] = {
 static int dlfb_select_std_channel(struct dlfb_data *dev)
 {
 	int ret;
-	u8 set_def_chn[] = {	   0x57, 0xCD, 0xDC, 0xA7,
+	void *buf = NULL;
+	const u8 set_def_chn[] = {
+				0x57, 0xCD, 0xDC, 0xA7,
 				0x1C, 0x88, 0x5E, 0x15,
 				0x60, 0xFE, 0xC6, 0x97,
 				0x16, 0x3D, 0x47, 0xF2  };
 
+	buf = kmalloc(sizeof(set_def_chn), GFP_KERNEL);
+
+	if (!buf)
+		return -ENOMEM;
+
+	memcpy(buf, set_def_chn, sizeof(set_def_chn));
+
 	ret = usb_control_msg(dev->udev, usb_sndctrlpipe(dev->udev, 0),
 			NR_USB_REQUEST_CHANNEL,
 			(USB_DIR_OUT | USB_TYPE_VENDOR), 0, 0,
-			set_def_chn, sizeof(set_def_chn), USB_CTRL_SET_TIMEOUT);
+			buf, sizeof(set_def_chn), USB_CTRL_SET_TIMEOUT);
+
+	kfree(buf);
+
 	return ret;
 }
 
-- 
2.9.3

