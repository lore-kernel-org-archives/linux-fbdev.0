From: Ladislav Michl <ladis@linux-mips.org>
Date: Mon, 11 Dec 2017 21:42:59 +0000
Subject: [PATCH 6/6] video: udlfb: Switch from the pr_*() to the dev_*() logging functions
Message-Id: <20171211214259.GG29173@lenoch>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Use dev_err() and dev_info() instead of pr_err() and pr_info().
USB device is used as argument to dev_*() functions for probe
and urb manipulation, FB device for framebuffer related info.

Also noisy device probe output was partly removed as idVendor,
idProduct, name and serial are already printed by usb core,
and partly turned into debug output.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 drivers/video/fbdev/udlfb.c | 199 +++++++++++++++++++-------------------------
 1 file changed, 84 insertions(+), 115 deletions(-)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index 2b22b09e5c3c..fb3cb8b1b011 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -16,8 +16,6 @@
  * from Florian Echtler, Henrik Bjerregaard Pedersen, and others.
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -333,8 +331,8 @@ static int dlfb_ops_mmap(struct fb_info *info, struct vm_area_struct *vma)
 
 	pos = (unsigned long)info->fix.smem_start + offset;
 
-	pr_notice("mmap() framebuffer addr:%lu size:%lu\n",
-		  pos, size);
+	dev_dbg(info->dev, "mmap() framebuffer addr:%lu size:%lu\n",
+		pos, size);
 
 	while (size > 0) {
 		page = vmalloc_to_pfn((void *)pos);
@@ -757,8 +755,7 @@ static void dlfb_dpy_deferred_io(struct fb_info *info,
 
 static int dlfb_get_edid(struct dlfb_data *dlfb, char *edid, int len)
 {
-	int i;
-	int ret;
+	int i, ret;
 	char *rbuf;
 
 	rbuf = kmalloc(2, GFP_KERNEL);
@@ -771,7 +768,8 @@ static int dlfb_get_edid(struct dlfb_data *dlfb, char *edid, int len)
 				      (0x80 | (0x02 << 5)), i << 8, 0xA1,
 				      rbuf, 2, USB_CTRL_GET_TIMEOUT);
 		if (ret < 2) {
-			pr_err("Read EDID byte %d failed: %d\n", i, ret);
+			dev_err(&dlfb->udev->dev,
+				"Read EDID byte %d failed: %d\n", i, ret);
 			i--;
 			break;
 		}
@@ -905,8 +903,8 @@ static int dlfb_ops_open(struct fb_info *info, int user)
 		fb_deferred_io_init(info);
 	}
 
-	pr_notice("open /dev/fb%d user=%d fb_info=%p count=%d\n",
-	    info->node, user, info, dlfb->fb_count);
+	dev_dbg(info->dev, "open, user=%d fb_info=%p count=%d\n",
+		user, info, dlfb->fb_count);
 
 	return 0;
 }
@@ -921,11 +919,7 @@ static void dlfb_free(struct kref *kref)
 	struct dlfb_data *dlfb = container_of(kref, struct dlfb_data, kref);
 
 	vfree(dlfb->backing_buffer);
-
 	kfree(dlfb->edid);
-
-	pr_warn("freeing dlfb_data %p\n", dlfb);
-
 	kfree(dlfb);
 }
 
@@ -942,8 +936,6 @@ static void dlfb_free_framebuffer(struct dlfb_data *dlfb)
 	struct fb_info *info = dlfb->info;
 
 	if (info) {
-		int node = info->node;
-
 		unregister_framebuffer(info);
 
 		if (info->cmap.len != 0)
@@ -958,8 +950,6 @@ static void dlfb_free_framebuffer(struct dlfb_data *dlfb)
 
 		/* Assume info structure is freed after this point */
 		framebuffer_release(info);
-
-		pr_warn("fb_info for /dev/fb%d has been freed\n", node);
 	}
 
 	/* ref taken in probe() as part of registering framebfufer */
@@ -992,8 +982,7 @@ static int dlfb_ops_release(struct fb_info *info, int user)
 		info->fbops->fb_mmap = dlfb_ops_mmap;
 	}
 
-	pr_warn("released /dev/fb%d user=%d count=%d\n",
-		  info->node, user, dlfb->fb_count);
+	dev_dbg(info->dev, "release, user=%d count=%d\n", user, dlfb->fb_count);
 
 	kref_put(&dlfb->kref, dlfb_free);
 
@@ -1009,14 +998,8 @@ static int dlfb_is_valid_mode(struct fb_videomode *mode,
 {
 	struct dlfb_data *dlfb = info->par;
 
-	if (mode->xres * mode->yres > dlfb->sku_pixel_limit) {
-		pr_warn("%dx%d beyond chip capabilities\n",
-		       mode->xres, mode->yres);
+	if (mode->xres * mode->yres > dlfb->sku_pixel_limit)
 		return 0;
-	}
-
-	pr_info("%dx%d @ %d Hz valid mode\n", mode->xres, mode->yres,
-		mode->refresh);
 
 	return 1;
 }
@@ -1060,8 +1043,6 @@ static int dlfb_ops_set_par(struct fb_info *info)
 	u16 *pix_framebuffer;
 	int i;
 
-	pr_notice("set_par mode %dx%d\n", info->var.xres, info->var.yres);
-
 	result = dlfb_set_video_mode(dlfb, &info->var);
 
 	if ((result = 0) && (dlfb->fb_count = 0)) {
@@ -1103,8 +1084,8 @@ static int dlfb_ops_blank(int blank_mode, struct fb_info *info)
 	char *bufptr;
 	struct urb *urb;
 
-	pr_debug("/dev/fb%d FB_BLANK mode %d --> %d\n",
-		 info->node, dlfb->blank_mode, blank_mode);
+	dev_dbg(info->dev, "blank, mode %d --> %d\n",
+		dlfb->blank_mode, blank_mode);
 
 	if ((dlfb->blank_mode = FB_BLANK_POWERDOWN) &&
 	    (blank_mode != FB_BLANK_POWERDOWN)) {
@@ -1164,8 +1145,6 @@ static int dlfb_realloc_framebuffer(struct dlfb_data *dlfb, struct fb_info *info
 	unsigned char *new_fb;
 	unsigned char *new_back = NULL;
 
-	pr_warn("Reallocating framebuffer. Addresses will change!\n");
-
 	new_len = info->fix.line_length * info->var.yres;
 
 	if (PAGE_ALIGN(new_len) > old_len) {
@@ -1195,7 +1174,8 @@ static int dlfb_realloc_framebuffer(struct dlfb_data *dlfb, struct fb_info *info
 		if (shadow)
 			new_back = vzalloc(new_len);
 		if (!new_back)
-			pr_info("No shadow/backing buffer allocated\n");
+			dev_info(info->dev,
+				 "No shadow/backing buffer allocated\n");
 		else {
 			vfree(dlfb->backing_buffer);
 			dlfb->backing_buffer = new_back;
@@ -1226,14 +1206,17 @@ static int dlfb_setup_modes(struct dlfb_data *dlfb,
 			   struct fb_info *info,
 			   char *default_edid, size_t default_edid_size)
 {
-	int i;
-	const struct fb_videomode *default_vmode = NULL;
-	int result = 0;
 	char *edid;
-	int tries = 3;
+	int i, result = 0, tries = 3;
+	struct device *dev = info->device;
+	const struct fb_videomode *default_vmode = NULL;
 
-	if (info->dev) /* only use mutex if info has been registered */
+	if (info->dev) {
+		/* only use mutex if info has been registered */
 		mutex_lock(&info->lock);
+		/* parent device is used otherwise*/
+		dev = info->dev;
+	}
 
 	edid = kmalloc(EDID_LENGTH, GFP_KERNEL);
 	if (!edid) {
@@ -1265,13 +1248,12 @@ static int dlfb_setup_modes(struct dlfb_data *dlfb,
 
 	/* If that fails, use a previously returned EDID if available */
 	if (info->monspecs.modedb_len = 0) {
-
-		pr_err("Unable to get valid EDID from device/display\n");
+		dev_err(dev, "Unable to get valid EDID from device/display\n");
 
 		if (dlfb->edid) {
 			fb_edid_to_monspecs(dlfb->edid, &info->monspecs);
 			if (info->monspecs.modedb_len > 0)
-				pr_err("Using previously queried EDID\n");
+				dev_err(dev, "Using previously queried EDID\n");
 		}
 	}
 
@@ -1283,7 +1265,7 @@ static int dlfb_setup_modes(struct dlfb_data *dlfb,
 				memcpy(edid, default_edid, default_edid_size);
 				dlfb->edid = edid;
 				dlfb->edid_size = default_edid_size;
-				pr_err("Using default/backup EDID\n");
+				dev_err(dev, "Using default/backup EDID\n");
 			}
 		}
 	}
@@ -1413,9 +1395,6 @@ static ssize_t edid_show(
 	if (off + count > dlfb->edid_size)
 		count = dlfb->edid_size - off;
 
-	pr_info("sysfs edid copy %p to %p, %d bytes\n",
-		dlfb->edid, buf, (int) count);
-
 	memcpy(buf, dlfb->edid, count);
 
 	return count;
@@ -1441,7 +1420,6 @@ static ssize_t edid_store(
 	if (!dlfb->edid || memcmp(src, dlfb->edid, src_size))
 		return -EINVAL;
 
-	pr_info("sysfs written EDID is new default\n");
 	dlfb_ops_set_par(fb_info);
 	return src_size;
 }
@@ -1506,7 +1484,7 @@ static int dlfb_select_std_channel(struct dlfb_data *dlfb)
 }
 
 static int dlfb_parse_vendor_descriptor(struct dlfb_data *dlfb,
-					struct usb_interface *interface)
+					struct usb_interface *intf)
 {
 	char *desc;
 	char *buf;
@@ -1518,20 +1496,20 @@ static int dlfb_parse_vendor_descriptor(struct dlfb_data *dlfb,
 		return false;
 	desc = buf;
 
-	total_len = usb_get_descriptor(interface_to_usbdev(interface),
+	total_len = usb_get_descriptor(interface_to_usbdev(intf),
 					0x5f, /* vendor specific */
 					0, desc, MAX_VENDOR_DESCRIPTOR_SIZE);
 
 	/* if not found, look in configuration descriptor */
 	if (total_len < 0) {
-		if (0 = usb_get_extra_descriptor(interface->cur_altsetting,
+		if (0 = usb_get_extra_descriptor(intf->cur_altsetting,
 			0x5f, &desc))
 			total_len = (int) desc[0];
 	}
 
 	if (total_len > 5) {
-		pr_info("vendor descriptor length:%x data:%11ph\n", total_len,
-			desc);
+		dev_info(&intf->dev, "vendor descriptor length:%x data:%11ph\n",
+			 total_len, desc);
 
 		if ((desc[0] != total_len) || /* descriptor length */
 		    (desc[1] != 0x5f) ||   /* vendor descriptor type */
@@ -1556,8 +1534,9 @@ static int dlfb_parse_vendor_descriptor(struct dlfb_data *dlfb,
 			case 0x0200: { /* max_area */
 				u32 max_area;
 				max_area = le32_to_cpu(*((u32 *)desc));
-				pr_warn("DL chip limited to %d pixel modes\n",
-					max_area);
+				dev_warn(&intf->dev,
+					 "DL chip limited to %d pixel modes\n",
+					 max_area);
 				dlfb->sku_pixel_limit = max_area;
 				break;
 			}
@@ -1567,14 +1546,15 @@ static int dlfb_parse_vendor_descriptor(struct dlfb_data *dlfb,
 			desc += length;
 		}
 	} else {
-		pr_info("vendor descriptor not available (%d)\n", total_len);
+		dev_info(&intf->dev, "vendor descriptor not available (%d)\n",
+			 total_len);
 	}
 
 	goto success;
 
 unrecognized:
 	/* allow udlfb to load for now even if firmware unrecognized */
-	pr_err("Unrecognized vendor firmware descriptor\n");
+	dev_err(&intf->dev, "Unrecognized vendor firmware descriptor\n");
 
 success:
 	kfree(buf);
@@ -1583,17 +1563,14 @@ static int dlfb_parse_vendor_descriptor(struct dlfb_data *dlfb,
 
 static void dlfb_init_framebuffer_work(struct work_struct *work);
 
-static int dlfb_usb_probe(struct usb_interface *interface,
-			const struct usb_device_id *id)
+static int dlfb_usb_probe(struct usb_interface *intf,
+			  const struct usb_device_id *id)
 {
-	struct usb_device *usbdev;
 	struct dlfb_data *dlfb;
 	int retval = -ENOMEM;
+	struct usb_device *usbdev = interface_to_usbdev(intf);
 
 	/* usb initialization */
-
-	usbdev = interface_to_usbdev(interface);
-
 	dlfb = kzalloc(sizeof(*dlfb), GFP_KERNEL);
 	if (!dlfb)
 		goto error;
@@ -1601,29 +1578,24 @@ static int dlfb_usb_probe(struct usb_interface *interface,
 	kref_init(&dlfb->kref); /* matching kref_put in usb .disconnect fn */
 
 	dlfb->udev = usbdev;
-	usb_set_intfdata(interface, dlfb);
-
-	pr_info("%s %s - serial #%s\n",
-		usbdev->manufacturer, usbdev->product, usbdev->serial);
-	pr_info("vid_%04x&pid_%04x&rev_%04x driver's dlfb_data struct at %p\n",
-		le16_to_cpu(usbdev->descriptor.idVendor),
-		le16_to_cpu(usbdev->descriptor.idProduct),
-		le16_to_cpu(usbdev->descriptor.bcdDevice), dlfb);
-	pr_info("console enable=%d\n", console);
-	pr_info("fb_defio enable=%d\n", fb_defio);
-	pr_info("shadow enable=%d\n", shadow);
+	usb_set_intfdata(intf, dlfb);
+
+	dev_dbg(&intf->dev, "console enable=%d\n", console);
+	dev_dbg(&intf->dev, "fb_defio enable=%d\n", fb_defio);
+	dev_dbg(&intf->dev, "shadow enable=%d\n", shadow);
 
 	dlfb->sku_pixel_limit = 2048 * 1152; /* default to maximum */
 
-	if (!dlfb_parse_vendor_descriptor(dlfb, interface)) {
-		pr_err("firmware not recognized. Assume incompatible device\n");
+	if (!dlfb_parse_vendor_descriptor(dlfb, intf)) {
+		dev_err(&intf->dev,
+			"firmware not recognized, incompatible device?\n");
 		goto error;
 	}
 
 	if (pixel_limit) {
-		pr_warn("DL chip limit of %d overridden"
-			" by module param to %d\n",
-			dlfb->sku_pixel_limit, pixel_limit);
+		dev_warn(&intf->dev,
+			 "DL chip limit of %d overridden to %d\n",
+			 dlfb->sku_pixel_limit, pixel_limit);
 		dlfb->sku_pixel_limit = pixel_limit;
 	}
 
@@ -1657,11 +1629,10 @@ static int dlfb_usb_probe(struct usb_interface *interface,
 
 static void dlfb_init_framebuffer_work(struct work_struct *work)
 {
+	int i, retval;
+	struct fb_info *info;
 	struct dlfb_data *dlfb = container_of(work, struct dlfb_data,
 					     init_framebuffer_work.work);
-	struct fb_info *info;
-	int retval;
-	int i;
 
 	/* allocates framebuffer driver structure, not framebuffer memory */
 	info = framebuffer_alloc(0, &dlfb->udev->dev);
@@ -1684,7 +1655,8 @@ static void dlfb_init_framebuffer_work(struct work_struct *work)
 
 	retval = dlfb_setup_modes(dlfb, info, NULL, 0);
 	if (retval != 0) {
-		pr_err("unable to find common mode for display and adapter\n");
+		dev_err(info->device,
+			"unable to find common mode for display and adapter\n");
 		goto error;
 	}
 
@@ -1697,43 +1669,37 @@ static void dlfb_init_framebuffer_work(struct work_struct *work)
 
 	retval = register_framebuffer(info);
 	if (retval < 0) {
-		pr_err("register_framebuffer failed %d\n", retval);
+		dev_err(info->device, "register_framebuffer failed %d\n", retval);
 		goto error;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(fb_device_attrs); i++) {
-		retval = device_create_file(info->dev, &fb_device_attrs[i]);
-		if (retval) {
-			pr_warn("device_create_file failed %d\n", retval);
-		}
+		device_create_file(info->dev, &fb_device_attrs[i]);
 	}
 
-	retval = device_create_bin_file(info->dev, &edid_attr);
-	if (retval) {
-		pr_warn("device_create_bin_file failed %d\n", retval);
-	}
+	device_create_bin_file(info->dev, &edid_attr);
 
-	pr_info("DisplayLink USB device /dev/fb%d attached. %dx%d resolution."
-			" Using %dK framebuffer memory\n", info->node,
-			info->var.xres, info->var.yres,
-			((dlfb->backing_buffer) ?
-			info->fix.smem_len * 2 : info->fix.smem_len) >> 10);
+	dev_info(info->device,
+		 "%s is DisplayLink USB device (%dx%d, %dK framebuffer memory)\n",
+		 dev_name(info->dev), info->var.xres, info->var.yres,
+		 ((dlfb->backing_buffer) ?
+		 info->fix.smem_len * 2 : info->fix.smem_len) >> 10);
 	return;
 
 error:
 	dlfb_free_framebuffer(dlfb);
 }
 
-static void dlfb_usb_disconnect(struct usb_interface *interface)
+static void dlfb_usb_disconnect(struct usb_interface *intf)
 {
 	struct dlfb_data *dlfb;
 	struct fb_info *info;
 	int i;
 
-	dlfb = usb_get_intfdata(interface);
+	dlfb = usb_get_intfdata(intf);
 	info = dlfb->info;
 
-	pr_info("USB disconnect starting\n");
+	dev_dbg(&intf->dev, "USB disconnect starting\n");
 
 	/* we virtualize until all fb clients release. Then we free */
 	dlfb->virtualized = true;
@@ -1752,7 +1718,7 @@ static void dlfb_usb_disconnect(struct usb_interface *interface)
 		unlink_framebuffer(info);
 	}
 
-	usb_set_intfdata(interface, NULL);
+	usb_set_intfdata(intf, NULL);
 	dlfb->udev = NULL;
 
 	/* if clients still have us open, will be freed on last close */
@@ -1780,15 +1746,21 @@ static void dlfb_urb_completion(struct urb *urb)
 	struct dlfb_data *dlfb = unode->dlfb;
 	unsigned long flags;
 
-	/* sync/async unlink faults aren't errors */
-	if (urb->status) {
-		if (!(urb->status = -ENOENT ||
-		    urb->status = -ECONNRESET ||
-		    urb->status = -ESHUTDOWN)) {
-			pr_err("%s - nonzero write bulk status received: %d\n",
-				__func__, urb->status);
-			atomic_set(&dlfb->lost_pixels, 1);
-		}
+	switch (urb->status) {
+	case 0:
+		/* success */
+		break;
+	case -ECONNRESET:
+	case -ENOENT:
+	case -ESHUTDOWN:
+		/* sync/async unlink faults aren't errors */
+		break;
+	default:
+		dev_err(&dlfb->udev->dev,
+			"%s - nonzero write bulk status received: %d\n",
+			__func__, urb->status);
+		atomic_set(&dlfb->lost_pixels, 1);
+		break;
 	}
 
 	urb->transfer_buffer_length = dlfb->urbs.size; /* reset to actual */
@@ -1817,8 +1789,6 @@ static void dlfb_free_urb_list(struct dlfb_data *dlfb)
 	int ret;
 	unsigned long flags;
 
-	pr_notice("Freeing all render urbs\n");
-
 	/* keep waiting and freeing, until we've got 'em all */
 	while (count--) {
 
@@ -1897,8 +1867,6 @@ static int dlfb_alloc_urb_list(struct dlfb_data *dlfb, int count, size_t size)
 	dlfb->urbs.count = i;
 	dlfb->urbs.available = i;
 
-	pr_notice("allocated %d %d byte urbs\n", i, (int) size);
-
 	return i;
 }
 
@@ -1913,8 +1881,9 @@ static struct urb *dlfb_get_urb(struct dlfb_data *dlfb)
 	ret = down_timeout(&dlfb->urbs.limit_sem, GET_URB_TIMEOUT);
 	if (ret) {
 		atomic_set(&dlfb->lost_pixels, 1);
-		pr_warn("wait for urb interrupted: %x available: %d\n",
-		       ret, dlfb->urbs.available);
+		dev_warn(&dlfb->udev->dev,
+			 "wait for urb interrupted: %d available: %d\n",
+			 ret, dlfb->urbs.available);
 		return NULL;
 	}
 
@@ -1942,7 +1911,7 @@ static int dlfb_submit_urb(struct dlfb_data *dlfb, struct urb *urb, size_t len)
 	if (ret) {
 		dlfb_urb_completion(urb); /* because no one else will */
 		atomic_set(&dlfb->lost_pixels, 1);
-		pr_err("usb_submit_urb error %x\n", ret);
+		dev_err(&dlfb->udev->dev, "usb_submit_urb error %x\n", ret);
 	}
 	return ret;
 }
-- 
2.15.1

