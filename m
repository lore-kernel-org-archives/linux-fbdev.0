From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 3/5] fbdev: Sanitize ->fb_ioctl prototype
Date: Wed, 11 Jan 2006 19:58:39 +0800
Message-ID: <43C4F2EF.7070503@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ewf5Z-0005po-Ah
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 11 Jan 2006 04:28:29 -0800
Received: from zproxy.gmail.com ([64.233.162.201])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Ewf5Y-0006rP-Fa
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 11 Jan 2006 04:28:29 -0800
Received: by zproxy.gmail.com with SMTP id 13so123669nzp
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 11 Jan 2006 04:28:28 -0800 (PST)
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

The ioctl and file arguments to ->fb_mmap are totally unused and there's
not reason a driver should need them.

Also update the ->fb_compat_ioctl prototype to be the same as ->fb_mmap.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/amifb.c                 |    9 +++------
 drivers/video/arcfb.c                 |    5 ++---
 drivers/video/atafb.c                 |    3 +--
 drivers/video/aty/aty128fb.c          |    6 ++----
 drivers/video/aty/atyfb_base.c        |    6 ++----
 drivers/video/aty/radeon_base.c       |    4 ++--
 drivers/video/bw2.c                   |    6 ++----
 drivers/video/cg14.c                  |    6 ++----
 drivers/video/cg3.c                   |    6 ++----
 drivers/video/cg6.c                   |    6 ++----
 drivers/video/fbmem.c                 |    4 ++--
 drivers/video/ffb.c                   |    6 ++----
 drivers/video/imsttfb.c               |    3 +--
 drivers/video/intelfb/intelfbdrv.c    |    8 +++-----
 drivers/video/kyro/fbdev.c            |    5 ++---
 drivers/video/leo.c                   |    6 ++----
 drivers/video/matrox/matroxfb_base.c  |    5 ++---
 drivers/video/matrox/matroxfb_crtc2.c |    9 ++++-----
 drivers/video/p9100.c                 |    7 +++----
 drivers/video/pm3fb.c                 |    8 ++------
 drivers/video/pmag-aa-fb.c            |    3 +--
 drivers/video/radeonfb.c              |    4 ++--
 drivers/video/sis/sis_main.c          |   28 ++++++++--------------------
 drivers/video/sis/sis_main.h          |    5 +++++
 drivers/video/sstfb.c                 |    3 +--
 drivers/video/tcx.c                   |    7 +++----
 include/linux/fb.h                    |    8 ++++----
 27 files changed, 67 insertions(+), 109 deletions(-)

diff --git a/drivers/video/amifb.c b/drivers/video/amifb.c
index 2c42a81..3033c72 100644
--- a/drivers/video/amifb.c
+++ b/drivers/video/amifb.c
@@ -1131,9 +1131,7 @@ static void amifb_copyarea(struct fb_inf
 			   const struct fb_copyarea *region);
 static void amifb_imageblit(struct fb_info *info,
 			    const struct fb_image *image);
-static int amifb_ioctl(struct inode *inode, struct file *file,
-		       unsigned int cmd, unsigned long arg,
-		       struct fb_info *info);
+static int amifb_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg);
 
 
 	/*
@@ -2172,9 +2170,8 @@ static void amifb_imageblit(struct fb_in
 	 * Amiga Frame Buffer Specific ioctls
 	 */
 
-static int amifb_ioctl(struct inode *inode, struct file *file,
-		       unsigned int cmd, unsigned long arg,
-		       struct fb_info *info)
+static int amifb_ioctl(struct fb_info *info,
+		       unsigned int cmd, unsigned long arg)
 {
 	union {
 		struct fb_fix_cursorinfo fix;
diff --git a/drivers/video/arcfb.c b/drivers/video/arcfb.c
index 89060b2..df8e566 100644
--- a/drivers/video/arcfb.c
+++ b/drivers/video/arcfb.c
@@ -399,9 +399,8 @@ static void arcfb_imageblit(struct fb_in
 				image->height);
 }
 
-static int arcfb_ioctl(struct inode *inode, struct file *file,
-			  unsigned int cmd, unsigned long arg,
-			  struct fb_info *info)
+static int arcfb_ioctl(struct fb_info *info,
+			  unsigned int cmd, unsigned long arg)
 {
 	void __user *argp = (void __user *)arg;
 	struct arcfb_par *par = info->par;
diff --git a/drivers/video/atafb.c b/drivers/video/atafb.c
index 15ec129..e69ab65 100644
--- a/drivers/video/atafb.c
+++ b/drivers/video/atafb.c
@@ -2571,8 +2571,7 @@ atafb_pan_display(struct fb_var_screenin
 }
 
 static int
-atafb_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
-	       unsigned long arg, int con, struct fb_info *info)
+atafb_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg)
 {
 	switch (cmd) {
 #ifdef FBCMD_GET_CURRENTPAR
diff --git a/drivers/video/aty/aty128fb.c b/drivers/video/aty/aty128fb.c
index e686185..bfc8a93 100644
--- a/drivers/video/aty/aty128fb.c
+++ b/drivers/video/aty/aty128fb.c
@@ -431,8 +431,7 @@ static int aty128fb_setcolreg(u_int regn
 static int aty128fb_pan_display(struct fb_var_screeninfo *var,
 			   struct fb_info *fb);
 static int aty128fb_blank(int blank, struct fb_info *fb);
-static int aty128fb_ioctl(struct inode *inode, struct file *file, u_int cmd,
-			  u_long arg, struct fb_info *info);
+static int aty128fb_ioctl(struct fb_info *info, u_int cmd, unsigned long arg);
 static int aty128fb_sync(struct fb_info *info);
 
     /*
@@ -2108,8 +2107,7 @@ static int aty128fb_setcolreg(u_int regn
 /* in param: u32*	backlight value: 0 to 15 */
 #define FBIO_ATY128_SET_MIRROR	_IOW('@', 2, __u32)
 
-static int aty128fb_ioctl(struct inode *inode, struct file *file, u_int cmd,
-			  u_long arg, struct fb_info *info)
+static int aty128fb_ioctl(struct fb_info *info, u_int cmd, u_long arg)
 {
 	struct aty128fb_par *par = info->par;
 	u32 value;
diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
index ed81005..75b463a 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -238,8 +238,7 @@ static int atyfb_setcolreg(u_int regno, 
 	u_int transp, struct fb_info *info);
 static int atyfb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info);
 static int atyfb_blank(int blank, struct fb_info *info);
-static int atyfb_ioctl(struct inode *inode, struct file *file, u_int cmd,
-	u_long arg, struct fb_info *info);
+static int atyfb_ioctl(struct fb_info *info, u_int cmd, u_long arg);
 extern void atyfb_fillrect(struct fb_info *info, const struct fb_fillrect *rect);
 extern void atyfb_copyarea(struct fb_info *info, const struct fb_copyarea *area);
 extern void atyfb_imageblit(struct fb_info *info, const struct fb_image *image);
@@ -1739,8 +1738,7 @@ struct atyclk {
 #define FBIO_WAITFORVSYNC _IOW('F', 0x20, __u32)
 #endif
 
-static int atyfb_ioctl(struct inode *inode, struct file *file, u_int cmd,
-	u_long arg, struct fb_info *info)
+static int atyfb_ioctl(struct fb_info *info, u_int cmd, u_long arg)
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 #ifdef __sparc__
diff --git a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
index 156db84..c9f0c5a 100644
--- a/drivers/video/aty/radeon_base.c
+++ b/drivers/video/aty/radeon_base.c
@@ -864,8 +864,8 @@ static int radeonfb_pan_display (struct 
 }
 
 
-static int radeonfb_ioctl (struct inode *inode, struct file *file, unsigned int cmd,
-                           unsigned long arg, struct fb_info *info)
+static int radeonfb_ioctl (struct fb_info *info, unsigned int cmd,
+                           unsigned long arg)
 {
         struct radeonfb_info *rinfo = info->par;
 	unsigned int tmp;
diff --git a/drivers/video/bw2.c b/drivers/video/bw2.c
index 9248fe1..641a6c1 100644
--- a/drivers/video/bw2.c
+++ b/drivers/video/bw2.c
@@ -36,8 +36,7 @@
 static int bw2_blank(int, struct fb_info *);
 
 static int bw2_mmap(struct fb_info *, struct file *, struct vm_area_struct *);
-static int bw2_ioctl(struct inode *, struct file *, unsigned int,
-		     unsigned long, struct fb_info *);
+static int bw2_ioctl(struct fb_info *, unsigned int, unsigned long);
 
 /*
  *  Frame buffer operations
@@ -181,8 +180,7 @@ static int bw2_mmap(struct fb_info *info
 				  vma);
 }
 
-static int bw2_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
-		     unsigned long arg, struct fb_info *info)
+static int bw2_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg)
 {
 	struct bw2_par *par = (struct bw2_par *) info->par;
 
diff --git a/drivers/video/cg14.c b/drivers/video/cg14.c
index a561471..edb9936 100644
--- a/drivers/video/cg14.c
+++ b/drivers/video/cg14.c
@@ -32,8 +32,7 @@ static int cg14_setcolreg(unsigned, unsi
 			 unsigned, struct fb_info *);
 
 static int cg14_mmap(struct fb_info *, struct file *, struct vm_area_struct *);
-static int cg14_ioctl(struct inode *, struct file *, unsigned int,
-		      unsigned long, struct fb_info *);
+static int cg14_ioctl(struct fb_info *, unsigned int, unsigned long);
 static int cg14_pan_display(struct fb_var_screeninfo *, struct fb_info *);
 
 /*
@@ -277,8 +276,7 @@ static int cg14_mmap(struct fb_info *inf
 				  par->iospace, vma);
 }
 
-static int cg14_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
-		      unsigned long arg, struct fb_info *info)
+static int cg14_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg)
 {
 	struct cg14_par *par = (struct cg14_par *) info->par;
 	struct cg14_regs __iomem *regs = par->regs;
diff --git a/drivers/video/cg3.c b/drivers/video/cg3.c
index 9fcd896..027f707 100644
--- a/drivers/video/cg3.c
+++ b/drivers/video/cg3.c
@@ -34,8 +34,7 @@ static int cg3_setcolreg(unsigned, unsig
 static int cg3_blank(int, struct fb_info *);
 
 static int cg3_mmap(struct fb_info *, struct file *, struct vm_area_struct *);
-static int cg3_ioctl(struct inode *, struct file *, unsigned int,
-		     unsigned long, struct fb_info *);
+static int cg3_ioctl(struct fb_info *, unsigned int, unsigned long);
 
 /*
  *  Frame buffer operations
@@ -240,8 +239,7 @@ static int cg3_mmap(struct fb_info *info
 				  vma);
 }
 
-static int cg3_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
-		     unsigned long arg, struct fb_info *info)
+static int cg3_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg)
 {
 	struct cg3_par *par = (struct cg3_par *) info->par;
 
diff --git a/drivers/video/cg6.c b/drivers/video/cg6.c
index 050835e..678e335 100644
--- a/drivers/video/cg6.c
+++ b/drivers/video/cg6.c
@@ -37,8 +37,7 @@ static void cg6_imageblit(struct fb_info
 static void cg6_fillrect(struct fb_info *, const struct fb_fillrect *);
 static int cg6_sync(struct fb_info *);
 static int cg6_mmap(struct fb_info *, struct file *, struct vm_area_struct *);
-static int cg6_ioctl(struct inode *, struct file *, unsigned int,
-		     unsigned long, struct fb_info *);
+static int cg6_ioctl(struct fb_info *, unsigned int, unsigned long);
 
 /*
  *  Frame buffer operations
@@ -534,8 +533,7 @@ static int cg6_mmap(struct fb_info *info
 				  vma);
 }
 
-static int cg6_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
-		     unsigned long arg, struct fb_info *info)
+static int cg6_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg)
 {
 	struct cg6_par *par = (struct cg6_par *) info->par;
 
diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 83e2594..571069b 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -957,7 +957,7 @@ fb_ioctl(struct inode *inode, struct fil
 	default:
 		if (fb->fb_ioctl == NULL)
 			return -EINVAL;
-		return fb->fb_ioctl(inode, file, cmd, arg, info);
+		return fb->fb_ioctl(info, cmd, arg);
 	}
 }
 
@@ -1107,7 +1107,7 @@ fb_compat_ioctl(struct file *file, unsig
 
 	default:
 		if (fb->fb_compat_ioctl)
-			ret = fb->fb_compat_ioctl(file, cmd, arg, info);
+			ret = fb->fb_compat_ioctl(cmd, arg, info);
 		break;
 	}
 	unlock_kernel();
diff --git a/drivers/video/ffb.c b/drivers/video/ffb.c
index c4870d5..d096c12 100644
--- a/drivers/video/ffb.c
+++ b/drivers/video/ffb.c
@@ -38,8 +38,7 @@ static void ffb_fillrect(struct fb_info 
 static void ffb_copyarea(struct fb_info *, const struct fb_copyarea *);
 static int ffb_sync(struct fb_info *);
 static int ffb_mmap(struct fb_info *, struct file *, struct vm_area_struct *);
-static int ffb_ioctl(struct inode *, struct file *, unsigned int,
-		     unsigned long, struct fb_info *);
+static int ffb_ioctl(struct fb_info *, unsigned int, unsigned long);
 static int ffb_pan_display(struct fb_var_screeninfo *, struct fb_info *);
 
 /*
@@ -848,8 +847,7 @@ static int ffb_mmap(struct fb_info *info
 				  0, vma);
 }
 
-static int ffb_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
-		     unsigned long arg, struct fb_info *info)
+static int ffb_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg)
 {
 	struct ffb_par *par = (struct ffb_par *) info->par;
 
diff --git a/drivers/video/imsttfb.c b/drivers/video/imsttfb.c
index a5d8130..ad416ae 100644
--- a/drivers/video/imsttfb.c
+++ b/drivers/video/imsttfb.c
@@ -1267,8 +1267,7 @@ imsttfb_cursor(struct fb_info *info, str
 #define FBIMSTT_GETIDXREG	0x545406
 
 static int
-imsttfb_ioctl(struct inode *inode, struct file *file, u_int cmd,
-	      u_long arg, struct fb_info *info)
+imsttfb_ioctl(struct fb_info *info, u_int cmd, u_long arg)
 {
 	struct imstt_par *par = info->par;
 	void __user *argp = (void __user *)arg;
diff --git a/drivers/video/intelfb/intelfbdrv.c b/drivers/video/intelfb/intelfbdrv.c
index 0090544..6b8bd3c 100644
--- a/drivers/video/intelfb/intelfbdrv.c
+++ b/drivers/video/intelfb/intelfbdrv.c
@@ -157,9 +157,8 @@ static int intelfb_cursor(struct fb_info
 
 static int intelfb_sync(struct fb_info *info);
 
-static int intelfb_ioctl(struct inode *inode, struct file *file,
-			 unsigned int cmd, unsigned long arg,
-			 struct fb_info *info);
+static int intelfb_ioctl(struct fb_info *info,
+			 unsigned int cmd, unsigned long arg);
 
 static int __devinit intelfb_pci_register(struct pci_dev *pdev,
 					  const struct pci_device_id *ent);
@@ -1380,8 +1379,7 @@ intelfb_pan_display(struct fb_var_screen
 
 /* When/if we have our own ioctls. */
 static int
-intelfb_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
-	      unsigned long arg, struct fb_info *info)
+intelfb_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg)
 {
 	int retval = 0;
 
diff --git a/drivers/video/kyro/fbdev.c b/drivers/video/kyro/fbdev.c
index bcd359b..477ad29 100644
--- a/drivers/video/kyro/fbdev.c
+++ b/drivers/video/kyro/fbdev.c
@@ -586,9 +586,8 @@ static int __init kyrofb_setup(char *opt
 }
 #endif
 
-static int kyrofb_ioctl(struct inode *inode, struct file *file,
-			unsigned int cmd, unsigned long arg,
-			struct fb_info *info)
+static int kyrofb_ioctl(struct fb_info *info,
+			unsigned int cmd, unsigned long arg)
 {
 	overlay_create ol_create;
 	overlay_viewport_set ol_viewport_set;
diff --git a/drivers/video/leo.c b/drivers/video/leo.c
index 494287f..fb14787 100644
--- a/drivers/video/leo.c
+++ b/drivers/video/leo.c
@@ -33,8 +33,7 @@ static int leo_setcolreg(unsigned, unsig
 static int leo_blank(int, struct fb_info *);
 
 static int leo_mmap(struct fb_info *, struct file *, struct vm_area_struct *);
-static int leo_ioctl(struct inode *, struct file *, unsigned int,
-		     unsigned long, struct fb_info *);
+static int leo_ioctl(struct fb_info *, unsigned int, unsigned long);
 static int leo_pan_display(struct fb_var_screeninfo *, struct fb_info *);
 
 /*
@@ -373,8 +372,7 @@ static int leo_mmap(struct fb_info *info
 				  vma);
 }
 
-static int leo_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
-		     unsigned long arg, struct fb_info *info)
+static int leo_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg)
 {
 	struct leo_par *par = (struct leo_par *) info->par;
 
diff --git a/drivers/video/matrox/matroxfb_base.c b/drivers/video/matrox/matroxfb_base.c
index 1be8e30..951c997 100644
--- a/drivers/video/matrox/matroxfb_base.c
+++ b/drivers/video/matrox/matroxfb_base.c
@@ -864,9 +864,8 @@ static struct matrox_altout panellink_ou
 	.name	 = "Panellink output",
 };
 
-static int matroxfb_ioctl(struct inode *inode, struct file *file,
-			  unsigned int cmd, unsigned long arg,
-			  struct fb_info *info)
+static int matroxfb_ioctl(struct fb_info *info,
+			  unsigned int cmd, unsigned long arg)
 {
 	void __user *argp = (void __user *)arg;
 	MINFO_FROM_INFO(info);
diff --git a/drivers/video/matrox/matroxfb_crtc2.c b/drivers/video/matrox/matroxfb_crtc2.c
index d52d7d8..27eb4bb 100644
--- a/drivers/video/matrox/matroxfb_crtc2.c
+++ b/drivers/video/matrox/matroxfb_crtc2.c
@@ -419,11 +419,10 @@ static int matroxfb_dh_get_vblank(const 
 	return 0;
 }
 
-static int matroxfb_dh_ioctl(struct inode* inode,
-		struct file* file,
+static int matroxfb_dh_ioctl(struct fb_info *info,
 		unsigned int cmd,
-		unsigned long arg,
-		struct fb_info* info) {
+		unsigned long arg)
+{
 #define m2info (container_of(info, struct matroxfb_dh_fb_info, fbcon))
 	MINFO_FROM(m2info->primary_dev);
 
@@ -457,7 +456,7 @@ static int matroxfb_dh_ioctl(struct inod
 		case MATROXFB_GET_OUTPUT_MODE:
 		case MATROXFB_GET_ALL_OUTPUTS:
 			{
-				return ACCESS_FBINFO(fbcon.fbops)->fb_ioctl(inode, file, cmd, arg, &ACCESS_FBINFO(fbcon));
+				return ACCESS_FBINFO(fbcon.fbops)->fb_ioctl(&ACCESS_FBINFO(fbcon), cmd, arg);
 			}
 		case MATROXFB_SET_OUTPUT_CONNECTION:
 			{
diff --git a/drivers/video/p9100.c b/drivers/video/p9100.c
index b251e75..a1025e9 100644
--- a/drivers/video/p9100.c
+++ b/drivers/video/p9100.c
@@ -32,8 +32,7 @@ static int p9100_setcolreg(unsigned, uns
 static int p9100_blank(int, struct fb_info *);
 
 static int p9100_mmap(struct fb_info *, struct file *, struct vm_area_struct *);
-static int p9100_ioctl(struct inode *, struct file *, unsigned int,
-		       unsigned long, struct fb_info *);
+static int p9100_ioctl(struct fb_info *, unsigned int, unsigned long);
 
 /*
  *  Frame buffer operations
@@ -232,8 +231,8 @@ static int p9100_mmap(struct fb_info *in
 				  vma);
 }
 
-static int p9100_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
-		       unsigned long arg, struct fb_info *info)
+static int p9100_ioctl(struct fb_info *info, unsigned int cmd,
+		       unsigned long arg)
 {
 	struct p9100_par *par = (struct p9100_par *) info->par;
 
diff --git a/drivers/video/pm3fb.c b/drivers/video/pm3fb.c
index 2e11b60..0e78ddc 100644
--- a/drivers/video/pm3fb.c
+++ b/drivers/video/pm3fb.c
@@ -657,9 +657,7 @@ static void pm3fb_set_disp(const void *p
 static void pm3fb_detect(void);
 static int pm3fb_pan_display(const struct fb_var_screeninfo *var,
 			     struct fb_info_gen *info);
-static int pm3fb_ioctl(struct inode *inode, struct file *file,
-                       u_int cmd, u_long arg, int con,
-		       struct fb_info *info);
+static int pm3fb_ioctl(struct fb_info *info, u_int cmd, u_long arg);
 
 
 /* the struct that hold them together */
@@ -3438,9 +3436,7 @@ static int pm3fb_pan_display(const struc
 	return 0;
 }
 
-static int pm3fb_ioctl(struct inode *inode, struct file *file,
-                       u_int cmd, u_long arg, int con,
-		       struct fb_info *info)
+static int pm3fb_ioctl(struct fb_info *info, u_int cmd, u_long arg)
 {
 	struct pm3fb_info *l_fb_info = (struct pm3fb_info *) info;
 	u32 cm, i;
diff --git a/drivers/video/pmag-aa-fb.c b/drivers/video/pmag-aa-fb.c
index 28d1fe5..d92f352 100644
--- a/drivers/video/pmag-aa-fb.c
+++ b/drivers/video/pmag-aa-fb.c
@@ -299,8 +299,7 @@ static int aafb_set_cmap(struct fb_cmap 
 		return -EINVAL;
 }
 
-static int aafb_ioctl(struct inode *inode, struct file *file, u32 cmd,
-		      unsigned long arg, int con, struct fb_info *info)
+static int aafb_ioctl(struct fb_info *info, u32 cmd, unsigned long arg)
 {
 	/* TODO: Not yet implemented */
 	return -ENOIOCTLCMD;
diff --git a/drivers/video/radeonfb.c b/drivers/video/radeonfb.c
index 600318f..db9fb90 100644
--- a/drivers/video/radeonfb.c
+++ b/drivers/video/radeonfb.c
@@ -1497,8 +1497,8 @@ static int radeonfb_pan_display (struct 
 }
 
 
-static int radeonfb_ioctl (struct inode *inode, struct file *file, unsigned int cmd,
-                           unsigned long arg, struct fb_info *info)
+static int radeonfb_ioctl (struct fb_info *info, unsigned int cmd,
+                           unsigned long arg)
 {
         struct radeonfb_info *rinfo = (struct radeonfb_info *) info;
 	unsigned int tmp;
diff --git a/drivers/video/sis/sis_main.c b/drivers/video/sis/sis_main.c
index dea1a46..8adf5bf 100644
--- a/drivers/video/sis/sis_main.c
+++ b/drivers/video/sis/sis_main.c
@@ -1743,13 +1743,14 @@ sisfb_blank(int blank, struct fb_info *i
 
 /* ----------- FBDev related routines for all series ---------- */
 
-static int
-sisfb_ioctl(struct inode *inode, struct file *file,
-            unsigned int cmd, unsigned long arg,
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-	    int con,
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,15)
+static int	sisfb_ioctl(struct fb_info *info, unsigned int cmd,
+			    unsigned long arg)
+#else
+static int	sisfb_ioctl(struct inode *inode, struct file *file,
+				unsigned int cmd, unsigned long arg,
+				struct fb_info *info)
 #endif
-	    struct fb_info *info)
 {
 	struct sis_video_info	*ivideo = (struct sis_video_info *)info->par;
 	struct sis_memreq	sismemreq;
@@ -1924,19 +1925,6 @@ sisfb_ioctl(struct inode *inode, struct 
 	return 0;
 }
 
-#ifdef SIS_NEW_CONFIG_COMPAT
-static long
-sisfb_compat_ioctl(struct file *f, unsigned int cmd, unsigned long arg, struct fb_info *info)
-{
-	int ret;
-
-	lock_kernel();
-	ret = sisfb_ioctl(NULL, f, cmd, arg, info);
-	unlock_kernel();
-	return ret;
-}
-#endif
-
 static int
 sisfb_get_fix(struct fb_fix_screeninfo *fix, int con, struct fb_info *info)
 {
@@ -2007,7 +1995,7 @@ static struct fb_ops sisfb_ops = {
 #endif
 	.fb_sync	= fbcon_sis_sync,
 #ifdef SIS_NEW_CONFIG_COMPAT
-	.fb_compat_ioctl= sisfb_compat_ioctl,
+	.fb_compat_ioctl= sisfb_ioctl,
 #endif
 	.fb_ioctl	= sisfb_ioctl
 };
diff --git a/drivers/video/sis/sis_main.h b/drivers/video/sis/sis_main.h
index 445bcbb..70b6df3 100644
--- a/drivers/video/sis/sis_main.h
+++ b/drivers/video/sis/sis_main.h
@@ -727,9 +727,14 @@ static int	sisfb_ioctl(struct inode *ino
 #endif
 
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,15)
+static int	sisfb_ioctl(struct fb_info *info, unsigned int cmd,
+			    unsigned long arg);
+#else
 static int	sisfb_ioctl(struct inode *inode, struct file *file,
 				unsigned int cmd, unsigned long arg,
 				struct fb_info *info);
+#endif
 static int	sisfb_set_par(struct fb_info *info);
 static int	sisfb_blank(int blank,
 				struct fb_info *info);
diff --git a/drivers/video/sstfb.c b/drivers/video/sstfb.c
index 8a5ce21..99921df 100644
--- a/drivers/video/sstfb.c
+++ b/drivers/video/sstfb.c
@@ -771,8 +771,7 @@ static int sstfb_setcolreg(u_int regno, 
 	return 0;
 }
 
-static int sstfb_ioctl(struct inode *inode, struct file *file,
-                       u_int cmd, u_long arg, struct fb_info *info )
+static int sstfb_ioctl(struct fb_info *info, u_int cmd, u_long arg)
 {
 	struct sstfb_par *par = info->par;
 	struct pci_dev *sst_dev = par->dev;
diff --git a/drivers/video/tcx.c b/drivers/video/tcx.c
index 2b27b44..cb94077 100644
--- a/drivers/video/tcx.c
+++ b/drivers/video/tcx.c
@@ -34,8 +34,7 @@ static int tcx_setcolreg(unsigned, unsig
 static int tcx_blank(int, struct fb_info *);
 
 static int tcx_mmap(struct fb_info *, struct file *, struct vm_area_struct *);
-static int tcx_ioctl(struct inode *, struct file *, unsigned int,
-		     unsigned long, struct fb_info *);
+static int tcx_ioctl(struct fb_info *, unsigned int, unsigned long);
 static int tcx_pan_display(struct fb_var_screeninfo *, struct fb_info *);
 
 /*
@@ -312,8 +311,8 @@ static int tcx_mmap(struct fb_info *info
 				  vma);
 }
 
-static int tcx_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
-		     unsigned long arg, struct fb_info *info)
+static int tcx_ioctl(struct fb_info *info, unsigned int cmd,
+		     unsigned long arg)
 {
 	struct tcx_par *par = (struct tcx_par *) info->par;
 
diff --git a/include/linux/fb.h b/include/linux/fb.h
index a973be2..6da8a80 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -608,12 +608,12 @@ struct fb_ops {
 	int (*fb_sync)(struct fb_info *info);
 
 	/* perform fb specific ioctl (optional) */
-	int (*fb_ioctl)(struct inode *inode, struct file *file, unsigned int cmd,
-			unsigned long arg, struct fb_info *info);
+	int (*fb_ioctl)(struct fb_info *info, unsigned int cmd,
+			unsigned long arg);
 
 	/* Handle 32bit compat ioctl (optional) */
-	long (*fb_compat_ioctl)(struct file *f, unsigned cmd, unsigned long arg,
-			       struct fb_info *info);
+	int (*fb_compat_ioctl)(struct fb_info *info, unsigned cmd,
+			unsigned long arg);
 
 	/* perform fb specific mmap */
 	int (*fb_mmap)(struct fb_info *info, struct file *file, struct vm_area_struct *vma);



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
