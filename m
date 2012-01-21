From: Kay Sievers <kay.sievers@vrfy.org>
Date: Sat, 21 Jan 2012 14:32:02 +0000
Subject: Re: udlfb: remove sysfs framebuffer device with USB .disconnect()
Message-Id: <1327156322.2037.1.camel@mop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1327090686.1555.2.camel@mop>
In-Reply-To: <1327090686.1555.2.camel@mop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Sat, 2012-01-21 at 14:13 +0000, Florian Tobias Schandinat wrote:
> On 01/21/2012 01:57 PM, Kay Sievers wrote:

> > That's true. If one calls the current _unregister() *before* calling
> > _unlink(), the _unlink() is a NOP. But that's intentional.
> 
> I don't think you got me right. My complaint was that after your patch
> do_unregister_framebuffer itself calls unlink_framebuffer _after_ it set
> registered_fb[i] = NULL;
> So for any framebuffer that does not call unlink_framebuffer directly the line
> device_destroy(fb_class, MKDEV(FB_MAJOR, i));
> will no longer be executed. Do you agree?

Yes, I absolutely agree. :)

Thanks,
Kay


From: Kay Sievers <kay.sievers@vrfy.org>
Subject: udlfb: remove sysfs framebuffer device with USB .disconnect()

The USB graphics card driver delays the unregistering of the framebuffer
device to a workqueue, which breaks the userspace visible remove uevent
sequence. Recent userspace tools started to support USB graphics card
hotplug out-of-the-box and rely on proper events sent by the kernel.

The framebuffer device is a direct child of the USB interface which is
removed immediately after the USB .disconnect() callback. But the fb device
in /sys stays around until its final cleanup, at a time where all the parent
devices have been removed already.

To work around that, we remove the sysfs fb device directly in the USB
.disconnect() callback and leave only the cleanup of the internal fb
data to the delayed work.

Before:
 add      /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2 (usb)
 add      /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2:1.0 (usb)
 add      /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2:1.0/graphics/fb0 (graphics)
 remove   /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2:1.0 (usb)
 remove   /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2 (usb)
 remove   /2-1.2:1.0/graphics/fb0 (graphics)

After:
 add      /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2 (usb)
 add      /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2:1.0 (usb)
 add      /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2:1.0/graphics/fb1 (graphics)
 remove   /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2:1.0/graphics/fb1 (graphics)
 remove   /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2:1.0 (usb)
 remove   /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2 (usb)

Cc: stable@vger.kernel.org
Tested-By: Bernie Thompson <bernie@plugable.com>
Acked-By: Bernie Thompson <bernie@plugable.com>
Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
---
 drivers/video/fbmem.c |   18 +++++++++++++++++-
 drivers/video/udlfb.c |    2 +-
 include/linux/fb.h    |    1 +
 3 files changed, 19 insertions(+), 2 deletions(-)

--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1665,6 +1665,7 @@ static int do_unregister_framebuffer(str
 	if (ret)
 		return -EINVAL;
 
+	unlink_framebuffer(fb_info);
 	if (fb_info->pixmap.addr &&
 	    (fb_info->pixmap.flags & FB_PIXMAP_DEFAULT))
 		kfree(fb_info->pixmap.addr);
@@ -1672,7 +1673,6 @@ static int do_unregister_framebuffer(str
 	registered_fb[i] = NULL;
 	num_registered_fb--;
 	fb_cleanup_device(fb_info);
-	device_destroy(fb_class, MKDEV(FB_MAJOR, i));
 	event.info = fb_info;
 	fb_notifier_call_chain(FB_EVENT_FB_UNREGISTERED, &event);
 
@@ -1681,6 +1681,22 @@ static int do_unregister_framebuffer(str
 	return 0;
 }
 
+int unlink_framebuffer(struct fb_info *fb_info)
+{
+	int i;
+
+	i = fb_info->node;
+	if (i < 0 || i >= FB_MAX || registered_fb[i] != fb_info)
+		return -EINVAL;
+
+	if (fb_info->dev) {
+		device_destroy(fb_class, MKDEV(FB_MAJOR, i));
+		fb_info->dev = NULL;
+	}
+	return 0;
+}
+EXPORT_SYMBOL(unlink_framebuffer);
+
 void remove_conflicting_framebuffers(struct apertures_struct *a,
 				     const char *name, bool primary)
 {
--- a/drivers/video/udlfb.c
+++ b/drivers/video/udlfb.c
@@ -1739,7 +1739,7 @@ static void dlfb_usb_disconnect(struct u
 	for (i = 0; i < ARRAY_SIZE(fb_device_attrs); i++)
 		device_remove_file(info->dev, &fb_device_attrs[i]);
 	device_remove_bin_file(info->dev, &edid_attr);
-
+	unlink_framebuffer(info);
 	usb_set_intfdata(interface, NULL);
 
 	/* if clients still have us open, will be freed on last close */
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -1003,6 +1003,7 @@ extern ssize_t fb_sys_write(struct fb_in
 /* drivers/video/fbmem.c */
 extern int register_framebuffer(struct fb_info *fb_info);
 extern int unregister_framebuffer(struct fb_info *fb_info);
+extern int unlink_framebuffer(struct fb_info *fb_info);
 extern void remove_conflicting_framebuffers(struct apertures_struct *a,
 				const char *name, bool primary);
 extern int fb_prepare_logo(struct fb_info *fb_info, int rotate);


