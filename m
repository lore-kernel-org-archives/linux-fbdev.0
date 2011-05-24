From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Tue, 24 May 2011 19:59:17 +0000
Subject: [Patch 1/2] Fix use-after-free by vga16fb on rmmod
Message-Id: <20110524215917.4b01df45@neptune.home>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Since fb_info is now refcounted and thus may get freed at any time it
gets unregistered module unloading will try to unregister framebuffer
as stored in platform data on probe though this pointer may
be stale.

Cleanup platform data on framebuffer release.

CC: stable@kernel.org
Signed-off-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
---
This should also go into 2.6.39 stable as it didn't make it into 2.6.39
with the rest of fb_info refcounting work.

This comes from
  [2.6.39-rc2, framebuffer] use after free oops
     ...
       [PATCH 0/2] fbcon sanity
thread
---
diff --git a/drivers/video/vga16fb.c b/drivers/video/vga16fb.c
index 53b2c5a..2bcfe32 100644
--- a/drivers/video/vga16fb.c
+++ b/drivers/video/vga16fb.c
@@ -1265,9 +1265,11 @@ static void vga16fb_imageblit(struct fb_info *info, =
const struct fb_image *image
=20
 static void vga16fb_destroy(struct fb_info *info)
 {
+	struct platform_device *dev =3D container_of(info->device, struct platfor=
m_device, dev);
 	iounmap(info->screen_base);
 	fb_dealloc_cmap(&info->cmap);
 	/* XXX unshare VGA regions */
+	platform_set_drvdata(dev, NULL);
 	framebuffer_release(info);
 }
=20
