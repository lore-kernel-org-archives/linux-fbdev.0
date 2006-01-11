From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 4/5] fbdev: Sanitize ->fb_mmap prototype
Date: Wed, 11 Jan 2006 19:59:27 +0800
Message-ID: <43C4F31F.9000904@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ewf5e-0005pr-Gu
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 11 Jan 2006 04:28:34 -0800
Received: from zproxy.gmail.com ([64.233.162.206])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Ewf5d-0006t5-Ip
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 11 Jan 2006 04:28:34 -0800
Received: by zproxy.gmail.com with SMTP id r28so137883nza
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 11 Jan 2006 04:28:33 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Christoph Hellwig <hch@lst.de>

From: Christoph Hellwig <hch@lst.de>

Again, no need for a file argument.  If we'd really need it it's in
vma->vm_file already.  gbefb and sgivwfb used to set vma->vm_file to
the file argument, but the kernel alrady did that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/68328fb.c        |    6 ++----
 drivers/video/acornfb.c        |    2 +-
 drivers/video/amba-clcd.c      |    2 +-
 drivers/video/aty/atyfb_base.c |    4 ++--
 drivers/video/au1100fb.c       |    2 +-
 drivers/video/bw2.c            |    4 ++--
 drivers/video/cg14.c           |    4 ++--
 drivers/video/cg3.c            |    4 ++--
 drivers/video/cg6.c            |    4 ++--
 drivers/video/controlfb.c      |    4 ++--
 drivers/video/fbmem.c          |    2 +-
 drivers/video/ffb.c            |    4 ++--
 drivers/video/gbefb.c          |    3 +--
 drivers/video/igafb.c          |    2 +-
 drivers/video/leo.c            |    4 ++--
 drivers/video/p9100.c          |    4 ++--
 drivers/video/pxafb.c          |    2 +-
 drivers/video/sa1100fb.c       |    2 +-
 drivers/video/sgivwfb.c        |    5 ++---
 drivers/video/tcx.c            |    4 ++--
 drivers/video/vfb.c            |    4 ++--
 include/linux/fb.h             |    2 +-
 22 files changed, 35 insertions(+), 39 deletions(-)

diff --git a/drivers/video/68328fb.c b/drivers/video/68328fb.c
index 3b0ddc5..78488bb 100644
--- a/drivers/video/68328fb.c
+++ b/drivers/video/68328fb.c
@@ -102,8 +102,7 @@ static int mc68x328fb_setcolreg(u_int re
 			 u_int transp, struct fb_info *info);
 static int mc68x328fb_pan_display(struct fb_var_screeninfo *var,
 			   struct fb_info *info);
-static int mc68x328fb_mmap(struct fb_info *info, struct file *file,
-		    struct vm_area_struct *vma);
+static int mc68x328fb_mmap(struct fb_info *info, struct vm_area_struct *vma);
 
 static struct fb_ops mc68x328fb_ops = {
 	.fb_check_var	= mc68x328fb_check_var,
@@ -398,8 +397,7 @@ static int mc68x328fb_pan_display(struct
      *  Most drivers don't need their own mmap function 
      */
 
-static int mc68x328fb_mmap(struct fb_info *info, struct file *file,
-		    struct vm_area_struct *vma)
+static int mc68x328fb_mmap(struct fb_info *info, struct vm_area_struct *vma)
 {
 #ifndef MMU
 	/* this is uClinux (no MMU) specific code */
diff --git a/drivers/video/acornfb.c b/drivers/video/acornfb.c
index 750cebb..b058273 100644
--- a/drivers/video/acornfb.c
+++ b/drivers/video/acornfb.c
@@ -883,7 +883,7 @@ acornfb_pan_display(struct fb_var_screen
  * Note that we are entered with the kernel locked.
  */
 static int
-acornfb_mmap(struct fb_info *info, struct file *file, struct vm_area_struct *vma)
+acornfb_mmap(struct fb_info *info, struct vm_area_struct *vma)
 {
 	unsigned long off, start;
 	u32 len;
diff --git a/drivers/video/amba-clcd.c b/drivers/video/amba-clcd.c
index 69421c8..4881d06 100644
--- a/drivers/video/amba-clcd.c
+++ b/drivers/video/amba-clcd.c
@@ -308,7 +308,7 @@ static int clcdfb_blank(int blank_mode, 
 	return 0;
 }
 
-static int clcdfb_mmap(struct fb_info *info, struct file *file,
+static int clcdfb_mmap(struct fb_info *info,
 		       struct vm_area_struct *vma)
 {
 	struct clcd_fb *fb = to_clcd(info);
diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
index 75b463a..485be38 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -243,7 +243,7 @@ extern void atyfb_fillrect(struct fb_inf
 extern void atyfb_copyarea(struct fb_info *info, const struct fb_copyarea *area);
 extern void atyfb_imageblit(struct fb_info *info, const struct fb_image *image);
 #ifdef __sparc__
-static int atyfb_mmap(struct fb_info *info, struct file *file, struct vm_area_struct *vma);
+static int atyfb_mmap(struct fb_info *info, struct vm_area_struct *vma);
 #endif
 static int atyfb_sync(struct fb_info *info);
 
@@ -1843,7 +1843,7 @@ static int atyfb_sync(struct fb_info *in
 }
 
 #ifdef __sparc__
-static int atyfb_mmap(struct fb_info *info, struct file *file, struct vm_area_struct *vma)
+static int atyfb_mmap(struct fb_info *info, struct vm_area_struct *vma)
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 	unsigned int size, page, map_size = 0;
diff --git a/drivers/video/au1100fb.c b/drivers/video/au1100fb.c
index a512980..2406899 100644
--- a/drivers/video/au1100fb.c
+++ b/drivers/video/au1100fb.c
@@ -379,7 +379,7 @@ void au1100fb_fb_rotate(struct fb_info *
  * Map video memory in user space. We don't use the generic fb_mmap method mainly
  * to allow the use of the TLB streaming flag (CCA=6)
  */
-int au1100fb_fb_mmap(struct fb_info *fbi, struct file *file, struct vm_area_struct *vma)
+int au1100fb_fb_mmap(struct fb_info *fbi, struct vm_area_struct *vma)
 {
 	struct au1100fb_device *fbdev = to_au1100fb_device(fbi);
 	unsigned int len;
diff --git a/drivers/video/bw2.c b/drivers/video/bw2.c
index 641a6c1..c029db4 100644
--- a/drivers/video/bw2.c
+++ b/drivers/video/bw2.c
@@ -35,7 +35,7 @@
 
 static int bw2_blank(int, struct fb_info *);
 
-static int bw2_mmap(struct fb_info *, struct file *, struct vm_area_struct *);
+static int bw2_mmap(struct fb_info *, struct vm_area_struct *);
 static int bw2_ioctl(struct fb_info *, unsigned int, unsigned long);
 
 /*
@@ -168,7 +168,7 @@ static struct sbus_mmap_map bw2_mmap_map
 	{ .size = 0 }
 };
 
-static int bw2_mmap(struct fb_info *info, struct file *file, struct vm_area_struct *vma)
+static int bw2_mmap(struct fb_info *info, struct vm_area_struct *vma)
 {
 	struct bw2_par *par = (struct bw2_par *)info->par;
 
diff --git a/drivers/video/cg14.c b/drivers/video/cg14.c
index edb9936..63b6c79 100644
--- a/drivers/video/cg14.c
+++ b/drivers/video/cg14.c
@@ -31,7 +31,7 @@
 static int cg14_setcolreg(unsigned, unsigned, unsigned, unsigned,
 			 unsigned, struct fb_info *);
 
-static int cg14_mmap(struct fb_info *, struct file *, struct vm_area_struct *);
+static int cg14_mmap(struct fb_info *, struct vm_area_struct *);
 static int cg14_ioctl(struct fb_info *, unsigned int, unsigned long);
 static int cg14_pan_display(struct fb_var_screeninfo *, struct fb_info *);
 
@@ -267,7 +267,7 @@ static int cg14_setcolreg(unsigned regno
 	return 0;
 }
 
-static int cg14_mmap(struct fb_info *info, struct file *file, struct vm_area_struct *vma)
+static int cg14_mmap(struct fb_info *info, struct vm_area_struct *vma)
 {
 	struct cg14_par *par = (struct cg14_par *) info->par;
 
diff --git a/drivers/video/cg3.c b/drivers/video/cg3.c
index 027f707..3de6e1b 100644
--- a/drivers/video/cg3.c
+++ b/drivers/video/cg3.c
@@ -33,7 +33,7 @@ static int cg3_setcolreg(unsigned, unsig
 			 unsigned, struct fb_info *);
 static int cg3_blank(int, struct fb_info *);
 
-static int cg3_mmap(struct fb_info *, struct file *, struct vm_area_struct *);
+static int cg3_mmap(struct fb_info *, struct vm_area_struct *);
 static int cg3_ioctl(struct fb_info *, unsigned int, unsigned long);
 
 /*
@@ -229,7 +229,7 @@ static struct sbus_mmap_map cg3_mmap_map
 	{ .size = 0 }
 };
 
-static int cg3_mmap(struct fb_info *info, struct file *file, struct vm_area_struct *vma)
+static int cg3_mmap(struct fb_info *info, struct vm_area_struct *vma)
 {
 	struct cg3_par *par = (struct cg3_par *)info->par;
 
diff --git a/drivers/video/cg6.c b/drivers/video/cg6.c
index 678e335..7aab91e 100644
--- a/drivers/video/cg6.c
+++ b/drivers/video/cg6.c
@@ -36,7 +36,7 @@ static int cg6_blank(int, struct fb_info
 static void cg6_imageblit(struct fb_info *, const struct fb_image *);
 static void cg6_fillrect(struct fb_info *, const struct fb_fillrect *);
 static int cg6_sync(struct fb_info *);
-static int cg6_mmap(struct fb_info *, struct file *, struct vm_area_struct *);
+static int cg6_mmap(struct fb_info *, struct vm_area_struct *);
 static int cg6_ioctl(struct fb_info *, unsigned int, unsigned long);
 
 /*
@@ -523,7 +523,7 @@ static struct sbus_mmap_map cg6_mmap_map
 	{ .size	= 0 }
 };
 
-static int cg6_mmap(struct fb_info *info, struct file *file, struct vm_area_struct *vma)
+static int cg6_mmap(struct fb_info *info, struct vm_area_struct *vma)
 {
 	struct cg6_par *par = (struct cg6_par *)info->par;
 
diff --git a/drivers/video/controlfb.c b/drivers/video/controlfb.c
index 03798e9..655301a 100644
--- a/drivers/video/controlfb.c
+++ b/drivers/video/controlfb.c
@@ -128,7 +128,7 @@ static int controlfb_pan_display(struct 
 static int controlfb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 	u_int transp, struct fb_info *info);
 static int controlfb_blank(int blank_mode, struct fb_info *info);
-static int controlfb_mmap(struct fb_info *info, struct file *file,
+static int controlfb_mmap(struct fb_info *info,
 	struct vm_area_struct *vma);
 static int controlfb_set_par (struct fb_info *info);
 static int controlfb_check_var (struct fb_var_screeninfo *var, struct fb_info *info);
@@ -280,7 +280,7 @@ static int controlfb_pan_display(struct 
  * for controlfb.
  * Note there's no locking in here; it's done in fb_mmap() in fbmem.c.
  */
-static int controlfb_mmap(struct fb_info *info, struct file *file,
+static int controlfb_mmap(struct fb_info *info,
                        struct vm_area_struct *vma)
 {
        unsigned long off, start;
diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 571069b..49c9536 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1135,7 +1135,7 @@ fb_mmap(struct file *file, struct vm_are
 	if (fb->fb_mmap) {
 		int res;
 		lock_kernel();
-		res = fb->fb_mmap(info, file, vma);
+		res = fb->fb_mmap(info, vma);
 		unlock_kernel();
 		return res;
 	}
diff --git a/drivers/video/ffb.c b/drivers/video/ffb.c
index d096c12..9c9b21d 100644
--- a/drivers/video/ffb.c
+++ b/drivers/video/ffb.c
@@ -37,7 +37,7 @@ static void ffb_imageblit(struct fb_info
 static void ffb_fillrect(struct fb_info *, const struct fb_fillrect *);
 static void ffb_copyarea(struct fb_info *, const struct fb_copyarea *);
 static int ffb_sync(struct fb_info *);
-static int ffb_mmap(struct fb_info *, struct file *, struct vm_area_struct *);
+static int ffb_mmap(struct fb_info *, struct vm_area_struct *);
 static int ffb_ioctl(struct fb_info *, unsigned int, unsigned long);
 static int ffb_pan_display(struct fb_var_screeninfo *, struct fb_info *);
 
@@ -838,7 +838,7 @@ static struct sbus_mmap_map ffb_mmap_map
 	{ .size = 0 }
 };
 
-static int ffb_mmap(struct fb_info *info, struct file *file, struct vm_area_struct *vma)
+static int ffb_mmap(struct fb_info *info, struct vm_area_struct *vma)
 {
 	struct ffb_par *par = (struct ffb_par *)info->par;
 
diff --git a/drivers/video/gbefb.c b/drivers/video/gbefb.c
index d744c51..38d2272 100644
--- a/drivers/video/gbefb.c
+++ b/drivers/video/gbefb.c
@@ -979,7 +979,7 @@ static int gbefb_check_var(struct fb_var
 	return 0;
 }
 
-static int gbefb_mmap(struct fb_info *info, struct file *file,
+static int gbefb_mmap(struct fb_info *info,
 			struct vm_area_struct *vma)
 {
 	unsigned long size = vma->vm_end - vma->vm_start;
@@ -1000,7 +1000,6 @@ static int gbefb_mmap(struct fb_info *in
 		pgprot_fb(pgprot_val(vma->vm_page_prot));
 
 	vma->vm_flags |= VM_IO | VM_RESERVED;
-	vma->vm_file = file;
 
 	/* look for the starting tile */
 	tile = &gbe_tiles.cpu[offset >> TILE_SHIFT];
diff --git a/drivers/video/igafb.c b/drivers/video/igafb.c
index e326f44..6b88050 100644
--- a/drivers/video/igafb.c
+++ b/drivers/video/igafb.c
@@ -219,7 +219,7 @@ static void iga_blank_border(struct iga_
 }
 
 #ifdef __sparc__
-static int igafb_mmap(struct fb_info *info, struct file *file,
+static int igafb_mmap(struct fb_info *info,
 		      struct vm_area_struct *vma)
 {
 	struct iga_par *par = (struct iga_par *)info->par;
diff --git a/drivers/video/leo.c b/drivers/video/leo.c
index fb14787..a23cfdb 100644
--- a/drivers/video/leo.c
+++ b/drivers/video/leo.c
@@ -32,7 +32,7 @@ static int leo_setcolreg(unsigned, unsig
 			 unsigned, struct fb_info *);
 static int leo_blank(int, struct fb_info *);
 
-static int leo_mmap(struct fb_info *, struct file *, struct vm_area_struct *);
+static int leo_mmap(struct fb_info *, struct vm_area_struct *);
 static int leo_ioctl(struct fb_info *, unsigned int, unsigned long);
 static int leo_pan_display(struct fb_var_screeninfo *, struct fb_info *);
 
@@ -362,7 +362,7 @@ static struct sbus_mmap_map leo_mmap_map
 	{ .size = 0 }
 };
 
-static int leo_mmap(struct fb_info *info, struct file *file, struct vm_area_struct *vma)
+static int leo_mmap(struct fb_info *info, struct vm_area_struct *vma)
 {
 	struct leo_par *par = (struct leo_par *)info->par;
 
diff --git a/drivers/video/p9100.c b/drivers/video/p9100.c
index a1025e9..0d19575 100644
--- a/drivers/video/p9100.c
+++ b/drivers/video/p9100.c
@@ -31,7 +31,7 @@ static int p9100_setcolreg(unsigned, uns
 			   unsigned, struct fb_info *);
 static int p9100_blank(int, struct fb_info *);
 
-static int p9100_mmap(struct fb_info *, struct file *, struct vm_area_struct *);
+static int p9100_mmap(struct fb_info *, struct vm_area_struct *);
 static int p9100_ioctl(struct fb_info *, unsigned int, unsigned long);
 
 /*
@@ -221,7 +221,7 @@ static struct sbus_mmap_map p9100_mmap_m
 	{ 0,			0,		0		    }
 };
 
-static int p9100_mmap(struct fb_info *info, struct file *file, struct vm_area_struct *vma)
+static int p9100_mmap(struct fb_info *info, struct vm_area_struct *vma)
 {
 	struct p9100_par *par = (struct p9100_par *)info->par;
 
diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index 9fc10b9..53ad61f 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -395,7 +395,7 @@ static int pxafb_blank(int blank, struct
 	return 0;
 }
 
-static int pxafb_mmap(struct fb_info *info, struct file *file,
+static int pxafb_mmap(struct fb_info *info,
 		      struct vm_area_struct *vma)
 {
 	struct pxafb_info *fbi = (struct pxafb_info *)info;
diff --git a/drivers/video/sa1100fb.c b/drivers/video/sa1100fb.c
index 2ea1354..feaa3c0 100644
--- a/drivers/video/sa1100fb.c
+++ b/drivers/video/sa1100fb.c
@@ -816,7 +816,7 @@ static int sa1100fb_blank(int blank, str
 	return 0;
 }
 
-static int sa1100fb_mmap(struct fb_info *info, struct file *file,
+static int sa1100fb_mmap(struct fb_info *info,
 			 struct vm_area_struct *vma)
 {
 	struct sa1100fb_info *fbi = (struct sa1100fb_info *)info;
diff --git a/drivers/video/sgivwfb.c b/drivers/video/sgivwfb.c
index 7054660..2e6df1f 100644
--- a/drivers/video/sgivwfb.c
+++ b/drivers/video/sgivwfb.c
@@ -115,7 +115,7 @@ static int sgivwfb_set_par(struct fb_inf
 static int sgivwfb_setcolreg(u_int regno, u_int red, u_int green,
 			     u_int blue, u_int transp,
 			     struct fb_info *info);
-static int sgivwfb_mmap(struct fb_info *info, struct file *file,
+static int sgivwfb_mmap(struct fb_info *info,
 			struct vm_area_struct *vma);
 
 static struct fb_ops sgivwfb_ops = {
@@ -706,7 +706,7 @@ static int sgivwfb_setcolreg(u_int regno
 	return 0;
 }
 
-static int sgivwfb_mmap(struct fb_info *info, struct file *file,
+static int sgivwfb_mmap(struct fb_info *info,
 			struct vm_area_struct *vma)
 {
 	unsigned long size = vma->vm_end - vma->vm_start;
@@ -723,7 +723,6 @@ static int sgivwfb_mmap(struct fb_info *
 	if (remap_pfn_range(vma, vma->vm_start, offset >> PAGE_SHIFT,
 						size, vma->vm_page_prot))
 		return -EAGAIN;
-	vma->vm_file = file;
 	printk(KERN_DEBUG "sgivwfb: mmap framebuffer P(%lx)->V(%lx)\n",
 	       offset, vma->vm_start);
 	return 0;
diff --git a/drivers/video/tcx.c b/drivers/video/tcx.c
index cb94077..95b9182 100644
--- a/drivers/video/tcx.c
+++ b/drivers/video/tcx.c
@@ -33,7 +33,7 @@ static int tcx_setcolreg(unsigned, unsig
 			 unsigned, struct fb_info *);
 static int tcx_blank(int, struct fb_info *);
 
-static int tcx_mmap(struct fb_info *, struct file *, struct vm_area_struct *);
+static int tcx_mmap(struct fb_info *, struct vm_area_struct *);
 static int tcx_ioctl(struct fb_info *, unsigned int, unsigned long);
 static int tcx_pan_display(struct fb_var_screeninfo *, struct fb_info *);
 
@@ -301,7 +301,7 @@ static struct sbus_mmap_map __tcx_mmap_m
 	{ .size = 0 }
 };
 
-static int tcx_mmap(struct fb_info *info, struct file *file, struct vm_area_struct *vma)
+static int tcx_mmap(struct fb_info *info, struct vm_area_struct *vma)
 {
 	struct tcx_par *par = (struct tcx_par *)info->par;
 
diff --git a/drivers/video/vfb.c b/drivers/video/vfb.c
index ffa1ad4..53208cb 100644
--- a/drivers/video/vfb.c
+++ b/drivers/video/vfb.c
@@ -81,7 +81,7 @@ static int vfb_setcolreg(u_int regno, u_
 			 u_int transp, struct fb_info *info);
 static int vfb_pan_display(struct fb_var_screeninfo *var,
 			   struct fb_info *info);
-static int vfb_mmap(struct fb_info *info, struct file *file,
+static int vfb_mmap(struct fb_info *info,
 		    struct vm_area_struct *vma);
 
 static struct fb_ops vfb_ops = {
@@ -368,7 +368,7 @@ static int vfb_pan_display(struct fb_var
      *  Most drivers don't need their own mmap function 
      */
 
-static int vfb_mmap(struct fb_info *info, struct file *file,
+static int vfb_mmap(struct fb_info *info,
 		    struct vm_area_struct *vma)
 {
 	return -EINVAL;
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 6da8a80..2cb19e6 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -616,7 +616,7 @@ struct fb_ops {
 			unsigned long arg);
 
 	/* perform fb specific mmap */
-	int (*fb_mmap)(struct fb_info *info, struct file *file, struct vm_area_struct *vma);
+	int (*fb_mmap)(struct fb_info *info, struct vm_area_struct *vma);
 
 	/* save current hardware state */
 	void (*fb_save_state)(struct fb_info *info);



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
