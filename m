From: Alexey Klimov <klimov.linux@gmail.com>
Date: Sun, 07 Jun 2015 23:02:47 +0000
Subject: [PATCH] fbdev: udlfb: remove unneeded initialization in few places
Message-Id: <1433718167.8234.4.camel@mtux>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Small minor cleanup.
This patch removes unneeded initializations of variables
in few places in different functions and one empty line.

Signed-off-by: Alexey Klimov <klimov.linux@gmail.com>
---
 drivers/video/fbdev/udlfb.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index ff2b873..e9c2f7b 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -279,7 +279,7 @@ static int dlfb_set_video_mode(struct dlfb_data *dev,
 {
 	char *buf;
 	char *wrptr;
-	int retval = 0;
+	int retval;
 	int writesize;
 	struct urb *urb;
 
@@ -1505,8 +1505,7 @@ static int dlfb_parse_vendor_descriptor(struct dlfb_data *dev,
 	char *desc;
 	char *buf;
 	char *desc_end;
-
-	int total_len = 0;
+	int total_len;
 
 	buf = kzalloc(MAX_VENDOR_DESCRIPTOR_SIZE, GFP_KERNEL);
 	if (!buf)
@@ -1582,7 +1581,7 @@ static int dlfb_usb_probe(struct usb_interface *interface,
 			const struct usb_device_id *id)
 {
 	struct usb_device *usbdev;
-	struct dlfb_data *dev = NULL;
+	struct dlfb_data *dev;
 	int retval = -ENOMEM;
 
 	/* usb initialization */
@@ -1665,7 +1664,6 @@ static void dlfb_init_framebuffer_work(struct work_struct *work)
 	/* allocates framebuffer driver structure, not framebuffer memory */
 	info = framebuffer_alloc(0, dev->gdev);
 	if (!info) {
-		retval = -ENOMEM;
 		pr_err("framebuffer_alloc failed\n");
 		goto error;
 	}
@@ -1912,7 +1910,7 @@ static int dlfb_alloc_urb_list(struct dlfb_data *dev, int count, size_t size)
 
 static struct urb *dlfb_get_urb(struct dlfb_data *dev)
 {
-	int ret = 0;
+	int ret;
 	struct list_head *entry;
 	struct urb_node *unode;
 	struct urb *urb = NULL;
-- 
2.1.4



