From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Thu, 14 Nov 2019 12:51:06 +0000
Subject: [PATCH v5 3/3] fbdev: Unexport unlink_framebuffer()
Message-Id: <20191114125106.28347-4-tzimmermann@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191114125106.28347-1-tzimmermann@suse.de>
In-Reply-To: <20191114125106.28347-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: airlied@redhat.com, sean@poorly.run, daniel@ffwll.ch, b.zolnierkie@samsung.com, noralf@tronnes.org, kraxel@redhat.com, sam@ravnborg.org, emil.velikov@collabora.com
Cc: linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org

There are no external callers of unlink_framebuffer() left. Make the
function an internal interface.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Noralf Tr=C3=B8nnes <noralf@tronnes.org>
---
 drivers/video/fbdev/core/fbmem.c | 3 +--
 include/linux/fb.h               | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fb=
mem.c
index 95c32952fa8a..86b06a599f96 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1673,7 +1673,7 @@ static void unbind_console(struct fb_info *fb_info)
 	console_unlock();
 }
=20
-void unlink_framebuffer(struct fb_info *fb_info)
+static void unlink_framebuffer(struct fb_info *fb_info)
 {
 	int i;
=20
@@ -1692,7 +1692,6 @@ void unlink_framebuffer(struct fb_info *fb_info)
=20
 	fb_info->dev =3D NULL;
 }
-EXPORT_SYMBOL(unlink_framebuffer);
=20
 static void do_unregister_framebuffer(struct fb_info *fb_info)
 {
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 41e0069eca0a..a6ad528990de 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -606,7 +606,6 @@ extern ssize_t fb_sys_write(struct fb_info *info, const=
 char __user *buf,
 /* drivers/video/fbmem.c */
 extern int register_framebuffer(struct fb_info *fb_info);
 extern void unregister_framebuffer(struct fb_info *fb_info);
-extern void unlink_framebuffer(struct fb_info *fb_info);
 extern int remove_conflicting_pci_framebuffers(struct pci_dev *pdev,
 					       const char *name);
 extern int remove_conflicting_framebuffers(struct apertures_struct *a,
--=20
2.23.0
