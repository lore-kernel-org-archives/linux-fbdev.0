From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Sun, 06 Aug 2017 07:21:28 +0000
Subject: [PATCH 2/2] video: fbdev: udlfb: constify usb_device_id.
Message-Id: <1502003368-12355-3-git-send-email-arvind.yadav.cs@gmail.com>
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
 drivers/video/fbdev/udlfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index 05ef657..d836e6e 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -54,7 +54,7 @@ static const u32 udlfb_info_flags = FBINFO_DEFAULT | FBINFO_READS_FAST |
  * which is compatible with all known USB 2.0 era graphics chips and firmware,
  * but allows DisplayLink to increment those for any future incompatible chips
  */
-static struct usb_device_id id_table[] = {
+static const struct usb_device_id id_table[] = {
 	{.idVendor = 0x17e9,
 	 .bInterfaceClass = 0xff,
 	 .bInterfaceSubClass = 0x00,
-- 
2.7.4

