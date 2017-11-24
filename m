From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 24 Nov 2017 20:54:19 +0000
Subject: [PATCH 4/4] video: udlfb: Delete an unnecessary return statement in two functions
Message-Id: <1e2d3f13-0184-4504-9813-0982fa3f4c67@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <6fb11bb4-2c1d-a939-087b-de31c42328b9@users.sourceforge.net>
In-Reply-To: <6fb11bb4-2c1d-a939-087b-de31c42328b9@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bernie Thompson <bernie@plugable.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 24 Nov 2017 21:36:39 +0100

The script "checkpatch.pl" pointed information out like the following.

WARNING: void function return statements are not generally useful

Thus remove such a statement in the affected functions.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/udlfb.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index 059883962698..c6bf7088f5f4 100644
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
@@ -1768,8 +1766,6 @@ static void dlfb_usb_disconnect(struct usb_interface *interface)
 	kref_put(&dev->kref, dlfb_free);
 
 	/* consider dlfb_data freed */
-
-	return;
 }
 
 static struct usb_driver dlfb_driver = {
-- 
2.15.0

