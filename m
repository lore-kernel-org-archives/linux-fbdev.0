From: Ladislav Michl <ladis@linux-mips.org>
Date: Mon, 11 Dec 2017 21:40:59 +0000
Subject: [PATCH 2/6] video: udlfb: Remove unnecessary 'return'
Message-Id: <20171211214059.GC29173@lenoch>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Remove unnecessary void return at the end of a function.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 drivers/video/fbdev/udlfb.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index 16a3287409b2..4abf538c9b72 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -505,8 +505,6 @@ static void dlfb_compress_hline(
 	*command_buffer_ptr = cmd;
 	*pixel_start_ptr = pixel;
 	*device_address_ptr = dev_addr;
-
-	return;
 }
 
 /*
@@ -1777,8 +1775,6 @@ static void dlfb_usb_disconnect(struct usb_interface *interface)
 	kref_put(&dlfb->kref, dlfb_free);
 
 	/* consider dlfb_data freed */
-
-	return;
 }
 
 static struct usb_driver dlfb_driver = {
-- 
2.15.1

