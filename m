From: Jason Yan <yanaijie@huawei.com>
Date: Wed, 22 Apr 2020 07:18:36 +0000
Subject: [PATCH] video: udlfb: use true,false for bool variables
Message-Id: <20200422071836.49123-1-yanaijie@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: bernie@plugable.com, b.zolnierkie@samsung.com, yanaijie@huawei.com, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

drivers/video/fbdev/udlfb.c:67:12-19: WARNING: Assignment of 0/1 to bool
variable
drivers/video/fbdev/udlfb.c:68:12-20: WARNING: Assignment of 0/1 to bool
variable
drivers/video/fbdev/udlfb.c:69:12-18: WARNING: Assignment of 0/1 to bool
variable

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/video/fbdev/udlfb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index 07905d385949..5b014b479f83 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -64,9 +64,9 @@ static const struct usb_device_id id_table[] = {
 MODULE_DEVICE_TABLE(usb, id_table);
 
 /* module options */
-static bool console = 1; /* Allow fbcon to open framebuffer */
-static bool fb_defio = 1;  /* Detect mmap writes using page faults */
-static bool shadow = 1; /* Optionally disable shadow framebuffer */
+static bool console = true; /* Allow fbcon to open framebuffer */
+static bool fb_defio = true;  /* Detect mmap writes using page faults */
+static bool shadow = true; /* Optionally disable shadow framebuffer */
 static int pixel_limit; /* Optionally force a pixel resolution limit */
 
 struct dlfb_deferred_free {
-- 
2.21.1
