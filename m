From: =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Date: Sun, 24 Apr 2016 20:48:59 +0000
Subject: [PATCH v2 5/8] fbdev: fb_defio: Export fb_deferred_io_mmap
Message-Id: <1461530942-22485-6-git-send-email-noralf@tronnes.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461530942-22485-1-git-send-email-noralf@tronnes.org>
In-Reply-To: <1461530942-22485-1-git-send-email-noralf@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: daniel@ffwll.ch, laurent.pinchart@ideasonboard.com, tomi.valkeinen@ti.com, linux-kernel@vger.kernel.org, =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>

Export fb_deferred_io_mmap so drivers can change vma->vm_page_prot.
When the framebuffer memory is allocated using dma_alloc_writecombine()
instead of vmalloc(), I get cache syncing problems on ARM.
This solves it:

static int drm_fbdev_cma_deferred_io_mmap(struct fb_info *info,
					  struct vm_area_struct *vma)
{
	fb_deferred_io_mmap(info, vma);
	vma->vm_page_prot =3D pgprot_writecombine(vma->vm_page_prot);

	return 0;
}

Could this have been done in the core?
Drivers that don't set (struct fb_ops *)->fb_mmap, gets a call to
fb_pgprotect() at the end of the default fb_mmap implementation
(drivers/video/fbdev/core/fbmem.c). This is an architecture specific
function that on many platforms uses pgprot_writecombine(), but not on
all. And looking at some of the fb_mmap implementations, some of them
sets vm_page_prot to nocache for instance, so I think the safest bet is
to do this in the driver and not in the fbdev core. And we can't call
fb_pgprotect() from fb_deferred_io_mmap() either because we don't have
access to the file pointer that powerpc needs.

Signed-off-by: Noralf Tr=C3=B8nnes <noralf@tronnes.org>
---

Changes since v1:
- Expand commit message

 drivers/video/fbdev/core/fb_defio.c | 3 ++-
 include/linux/fb.h                  | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core=
/fb_defio.c
index 57721c7..74b5bca 100644
--- a/drivers/video/fbdev/core/fb_defio.c
+++ b/drivers/video/fbdev/core/fb_defio.c
@@ -164,7 +164,7 @@ static const struct address_space_operations fb_deferre=
d_io_aops =3D {
 	.set_page_dirty =3D fb_deferred_io_set_page_dirty,
 };

-static int fb_deferred_io_mmap(struct fb_info *info, struct vm_area_struct=
 *vma)
+int fb_deferred_io_mmap(struct fb_info *info, struct vm_area_struct *vma)
 {
 	vma->vm_ops =3D &fb_deferred_io_vm_ops;
 	vma->vm_flags |=3D VM_DONTEXPAND | VM_DONTDUMP;
@@ -173,6 +173,7 @@ static int fb_deferred_io_mmap(struct fb_info *info, st=
ruct vm_area_struct *vma)
 	vma->vm_private_data =3D info;
 	return 0;
 }
+EXPORT_SYMBOL(fb_deferred_io_mmap);

 /* workqueue callback */
 static void fb_deferred_io_work(struct work_struct *work)
diff --git a/include/linux/fb.h b/include/linux/fb.h
index dfe8835..a964d07 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -673,6 +673,7 @@ static inline void __fb_pad_aligned_buffer(u8 *dst, u32=
 d_pitch,
 }

 /* drivers/video/fb_defio.c */
+int fb_deferred_io_mmap(struct fb_info *info, struct vm_area_struct *vma);
 extern void fb_deferred_io_init(struct fb_info *info);
 extern void fb_deferred_io_open(struct fb_info *info,
 				struct inode *inode,
--
2.2.2

