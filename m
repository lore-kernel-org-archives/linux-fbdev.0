From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Sun, 06 Aug 2017 07:21:27 +0000
Subject: [PATCH 1/2] video: fbdev: smscufx: constify usb_device_id.
Message-Id: <1502003368-12355-2-git-send-email-arvind.yadav.cs@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1502003368-12355-1-git-send-email-arvind.yadav.cs@gmail.com>
In-Reply-To: <1502003368-12355-1-git-send-email-arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: steve.glendinning@shawell.net, b.zolnierkie@samsung.com, bernie@plugable.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

usb_device_id are not supposed to change at runtime. All functions
working with usb_device_id provided by <linux/usb.h> work with
const usb_device_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/video/fbdev/smscufx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/smscufx.c b/drivers/video/fbdev/smscufx.c
index 449fcea..2275e80 100644
--- a/drivers/video/fbdev/smscufx.c
+++ b/drivers/video/fbdev/smscufx.c
@@ -122,7 +122,7 @@ static const u32 smscufx_info_flags = FBINFO_DEFAULT | FBINFO_READS_FAST |
 	FBINFO_VIRTFB |	FBINFO_HWACCEL_IMAGEBLIT | FBINFO_HWACCEL_FILLRECT |
 	FBINFO_HWACCEL_COPYAREA | FBINFO_MISC_ALWAYS_SETPAR;
 
-static struct usb_device_id id_table[] = {
+static const struct usb_device_id id_table[] = {
 	{USB_DEVICE(0x0424, 0x9d00),},
 	{USB_DEVICE(0x0424, 0x9d01),},
 	{},
-- 
2.7.4

