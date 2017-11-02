From: Ladislav Michl <ladis@linux-mips.org>
Date: Thu, 02 Nov 2017 11:02:16 +0000
Subject: [PATCH] video: udlfb: Fix read EDID timeout
Message-Id: <20171102110216.fw4gqa6zkhsofl3o@lenoch>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

While usb_control_msg function expects timeout in miliseconds, a value
of HZ is used. Replace it with USB_CTRL_GET_TIMEOUT and also fix error
message which looks like:
udlfb: Read EDID byte 78 failed err ffffff92
as error is either negative errno or number of bytes transferred use %d
format specifier.

Retuned EDID is in second byte, so return error when less than two bytes
are received.

Fixes: 18dffdf8913a ("staging: udlfb: enhance EDID and mode handling support")

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 drivers/video/fbdev/udlfb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index ef08a104fb42..d44f14242016 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -769,11 +769,11 @@ static int dlfb_get_edid(struct dlfb_data *dev, char *edid, int len)
 
 	for (i = 0; i < len; i++) {
 		ret = usb_control_msg(dev->udev,
-				    usb_rcvctrlpipe(dev->udev, 0), (0x02),
-				    (0x80 | (0x02 << 5)), i << 8, 0xA1, rbuf, 2,
-				    HZ);
-		if (ret < 1) {
-			pr_err("Read EDID byte %d failed err %x\n", i, ret);
+				      usb_rcvctrlpipe(dev->udev, 0), 0x02,
+				      (0x80 | (0x02 << 5)), i << 8, 0xA1,
+				      rbuf, 2, USB_CTRL_GET_TIMEOUT);
+		if (ret < 2) {
+			pr_err("Read EDID byte %d failed: %d\n", i, ret);
 			i--;
 			break;
 		}
-- 
2.11.0

