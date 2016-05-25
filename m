From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Wed, 25 May 2016 12:31:48 +0000
Subject: [PATCH] video: smscufx: remove unused variable
Message-Id: <1464178788-10591-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steve Glendinning <steve.glendinning@shawell.net>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

The variable was only assigned with the pointer but was never used.
We can safely remove it.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
---
 drivers/video/fbdev/smscufx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/fbdev/smscufx.c b/drivers/video/fbdev/smscufx.c
index 9279e5f..ec2e7e3 100644
--- a/drivers/video/fbdev/smscufx.c
+++ b/drivers/video/fbdev/smscufx.c
@@ -1761,10 +1761,8 @@ error:
 static void ufx_usb_disconnect(struct usb_interface *interface)
 {
 	struct ufx_data *dev;
-	struct fb_info *info;
 
 	dev = usb_get_intfdata(interface);
-	info = dev->info;
 
 	pr_debug("USB disconnect starting\n");
 
-- 
1.9.1

