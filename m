From: syrjala@sci.fi
Subject: [patch 3/9] atyfb: Fix sparse warnings
Date: Mon, 04 Sep 2006 01:06:50 +0300
Message-ID: <20060903220700.573750000@proteus.korsu.shacknet.nu>
References: <20060903220646.894202994@proteus.korsu.shacknet.nu>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="===============0841666712=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GK00v-0008RI-Sp for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 03 Sep 2006 15:00:25 -0700
Received: from smtp4.pp.htv.fi ([213.243.153.38])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GK00u-0004py-M4
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 03 Sep 2006 15:00:26 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: alex.kern@gmx.de, Ville Syrjala <syrjala@sci.fi>

--===============0841666712==
Content-Disposition: inline; filename=atyfb_fix_sparse_warnings.patch

Silence some sparse warnings:
* Remove casts from atari out_le32() and friends.
* Move accel functions' declarations to atyfb.h.

Signed-off-by: Ville Syrjala <syrjala@sci.fi>
---

 drivers/video/aty/atyfb.h      |   13 ++++++++++---
 drivers/video/aty/atyfb_base.c |    3 ---
 2 files changed, 10 insertions(+), 6 deletions(-)

Index: linux-2.6.18-rc4/drivers/video/aty/atyfb.h
===================================================================
--- linux-2.6.18-rc4.orig/drivers/video/aty/atyfb.h
+++ linux-2.6.18-rc4/drivers/video/aty/atyfb.h
@@ -227,7 +227,7 @@ static inline u32 aty_ld_le32(int regind
 		regindex -= 0x800;
 
 #ifdef CONFIG_ATARI
-	return in_le32((volatile u32 *)(par->ati_regbase + regindex));
+	return in_le32(par->ati_regbase + regindex);
 #else
 	return readl(par->ati_regbase + regindex);
 #endif
@@ -240,7 +240,7 @@ static inline void aty_st_le32(int regin
 		regindex -= 0x800;
 
 #ifdef CONFIG_ATARI
-	out_le32((volatile u32 *)(par->ati_regbase + regindex), val);
+	out_le32(par->ati_regbase + regindex, val);
 #else
 	writel(val, par->ati_regbase + regindex);
 #endif
@@ -253,7 +253,7 @@ static inline void aty_st_le16(int regin
 	if (regindex >= 0x400)
 		regindex -= 0x800;
 #ifdef CONFIG_ATARI
-	out_le16((volatile u16 *)(par->ati_regbase + regindex), val);
+	out_le16(par->ati_regbase + regindex, val);
 #else
 	writel(val, par->ati_regbase + regindex);
 #endif
@@ -357,3 +357,10 @@ extern void aty_reset_engine(const struc
 extern void aty_init_engine(struct atyfb_par *par, struct fb_info *info);
 extern void aty_st_pll_ct(int offset, u8 val, const struct atyfb_par *par);
 extern u8   aty_ld_pll_ct(int offset, const struct atyfb_par *par);
+
+extern void atyfb_fillrect(struct fb_info *info,
+			   const struct fb_fillrect *rect);
+extern void atyfb_copyarea(struct fb_info *info,
+			   const struct fb_copyarea *area);
+extern void atyfb_imageblit(struct fb_info *info,
+			    const struct fb_image *image);
Index: linux-2.6.18-rc4/drivers/video/aty/atyfb_base.c
===================================================================
--- linux-2.6.18-rc4.orig/drivers/video/aty/atyfb_base.c
+++ linux-2.6.18-rc4/drivers/video/aty/atyfb_base.c
@@ -240,9 +240,6 @@ static int atyfb_setcolreg(u_int regno, 
 static int atyfb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info);
 static int atyfb_blank(int blank, struct fb_info *info);
 static int atyfb_ioctl(struct fb_info *info, u_int cmd, u_long arg);
-extern void atyfb_fillrect(struct fb_info *info, const struct fb_fillrect *rect);
-extern void atyfb_copyarea(struct fb_info *info, const struct fb_copyarea *area);
-extern void atyfb_imageblit(struct fb_info *info, const struct fb_image *image);
 #ifdef __sparc__
 static int atyfb_mmap(struct fb_info *info, struct vm_area_struct *vma);
 #endif

-- 
Ville Syrj������l������
syrjala@sci.fi
http://www.sci.fi/~syrjala/


--===============0841666712==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0841666712==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0841666712==--
