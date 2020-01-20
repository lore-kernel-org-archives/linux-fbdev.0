From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 20 Jan 2020 10:00:13 +0000
Subject: [PATCH] fbdev: wait for references go away
Message-Id: <20200120100014.23488-1-kraxel@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: dri-devel@lists.freedesktop.org
Cc: open list <linux-kernel@vger.kernel.org>, "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, marmarek@invisiblethingslab.com, Gerd Hoffmann <kraxel@redhat.com>

Problem: do_unregister_framebuffer() might return before the device is
fully cleaned up, due to userspace having a file handle for /dev/fb0
open.  Which can result in drm driver not being able to grab resources
(and fail initialization) because the firmware framebuffer still holds
them.  Reportedly plymouth can trigger this.

Fix this by trying to wait until all references are gone.  Don't wait
forever though given that userspace might keep the file handle open.

Reported-by: Marek Marczykowski-G=C3=B3recki <marmarek@invisiblethingslab.c=
om>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/video/fbdev/core/fbmem.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fb=
mem.c
index d04554959ea7..2ea8ac05b065 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -35,6 +35,7 @@
 #include <linux/fbcon.h>
 #include <linux/mem_encrypt.h>
 #include <linux/pci.h>
+#include <linux/delay.h>
=20
 #include <asm/fb.h>
=20
@@ -1707,6 +1708,8 @@ static void unlink_framebuffer(struct fb_info *fb_inf=
o)
=20
 static void do_unregister_framebuffer(struct fb_info *fb_info)
 {
+	int limit =3D 100;
+
 	unlink_framebuffer(fb_info);
 	if (fb_info->pixmap.addr &&
 	    (fb_info->pixmap.flags & FB_PIXMAP_DEFAULT))
@@ -1726,6 +1729,10 @@ static void do_unregister_framebuffer(struct fb_info=
 *fb_info)
 	fbcon_fb_unregistered(fb_info);
 	console_unlock();
=20
+	/* try wait until all references are gone */
+	while (atomic_read(&fb_info->count) > 1 && --limit > 0)
+		msleep(10);
+
 	/* this may free fb info */
 	put_fb_info(fb_info);
 }
--=20
2.18.1
