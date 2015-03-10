From: Adam Richter <adamrichter4@gmail.com>
Date: Tue, 10 Mar 2015 22:11:58 +0000
Subject: Fwd: [PATCH] fbdev: udl: fix oops on USB unplug due to missing get_vblank_counter function
Message-Id: <CAGn-TgiZAbeXNO_fsKT0fMDTd7K0oZEFJvq4dGbKtqG=hWck7w@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="f46d0442678e77a4c20510f67055"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org

--f46d0442678e77a4c20510f67055
Content-Type: text/plain; charset=UTF-8

[This is a third submission of a message that vger first bounched from
my Yahoo account, and then
from gmail when I failed to disable HTML formatting.  I apologize if
it is a duplicate or triplicate. -Adam]

Hello, Bernie.

In Linux-4.0-rc3, the DisplayLink driver gets a kernel memory fault when its
USB device is unplugged, specifically when vblank_disable_and_save in
linux-4.0-rc3/drivers/gpu/drm/drm_irq.c attempts to call the NULL function
pointer dev->driver_get_vblank_counter.

linux-4.0-rc3/Documentation/DocBook/drm.tmpl says of that field, "Otherwise
drivers can use the drm_vblank_count helper function to handle this
operation."  Trying that seems to have eliminated the oops when I unplug the
device, although I do see these lines in the console log at device driver
initialization time that I think are probably fine, but which I should
mention in case the indicate that I did the wrong the thing:

[drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[drm] No driver support for vblank timestamp query.

If that doesn't look like a problem to you, then I suggest you apply the
patch, appended below and also included as an attachment, and push the
change upstream.  The patch just adds one line that appears in six other
framebuffer drivers to initialize the driver_get_vblank_counter drm_driver
function.


Thank you for maintaining the USB DisplayLink driver, and thanks for your
attention to this.

Adam Richter

--- drivers/gpu/drm/udl/udl_drv.c.orig    2015-03-09 22:10:14.292335527 -0700
+++ drivers/gpu/drm/udl/udl_drv.c    2015-03-09 22:22:14.148342842 -0700
@@ -41,6 +41,7 @@ static struct drm_driver driver = {
     .load = udl_driver_load,
     .unload = udl_driver_unload,
     .set_busid = udl_driver_set_busid,
+    .get_vblank_counter = drm_vblank_count,

     /* gem hooks */
     .gem_free_object = udl_gem_free_object,

--f46d0442678e77a4c20510f67055
Content-Type: text/plain; charset=US-ASCII; name="displaylink.diff"
Content-Disposition: attachment; filename="displaylink.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i73uo0yb0

LS0tIGRyaXZlcnMvZ3B1L2RybS91ZGwvdWRsX2Rydi5jLm9yaWcJMjAxNS0wMy0wOSAyMjoxMDox
NC4yOTIzMzU1MjcgLTA3MDAKKysrIGRyaXZlcnMvZ3B1L2RybS91ZGwvdWRsX2Rydi5jCTIwMTUt
MDMtMDkgMjI6MjI6MTQuMTQ4MzQyODQyIC0wNzAwCkBAIC00MSw2ICs0MSw3IEBAIHN0YXRpYyBz
dHJ1Y3QgZHJtX2RyaXZlciBkcml2ZXIgPSB7CiAJLmxvYWQgPSB1ZGxfZHJpdmVyX2xvYWQsCiAJ
LnVubG9hZCA9IHVkbF9kcml2ZXJfdW5sb2FkLAogCS5zZXRfYnVzaWQgPSB1ZGxfZHJpdmVyX3Nl
dF9idXNpZCwKKwkuZ2V0X3ZibGFua19jb3VudGVyID0gZHJtX3ZibGFua19jb3VudCwKIAogCS8q
IGdlbSBob29rcyAqLwogCS5nZW1fZnJlZV9vYmplY3QgPSB1ZGxfZ2VtX2ZyZWVfb2JqZWN0LAo=
--f46d0442678e77a4c20510f67055--
