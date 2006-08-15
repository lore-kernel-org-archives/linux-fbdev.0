From: Adrian Bunk <bunk@stusta.de>
Subject: [RFC: 2.6 patch] drivers/video/aty/: possible
	cleanups
Date: Tue, 15 Aug 2006 02:41:01 +0200
Message-ID: <20060815004101.GE3543@stusta.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GCn0E-0002Td-Pt for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 14 Aug 2006 17:41:54 -0700
Received: from mailout.stusta.mhn.de ([141.84.69.5])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GCn0D-00047Y-5p
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 14 Aug 2006 17:41:54 -0700
Content-Disposition: inline
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
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make the following needlessly global function static:
  - mach64_ct.c: aty_st_pll_ct()
- proper prototypes for the following functions:
  - atyfb_base.c: atyfb_copyarea()
  - atyfb_base.c: atyfb_fillrect()
  - atyfb_base.c: atyfb_imageblit()

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/video/aty/atyfb.h      |    6 +++++-
 drivers/video/aty/atyfb_base.c |    3 ---
 drivers/video/aty/mach64_ct.c  |    2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

--- linux-2.6.18-rc4-mm1/drivers/video/aty/atyfb.h.old	2006-08-13 23:45:13.000000000 +0200
+++ linux-2.6.18-rc4-mm1/drivers/video/aty/atyfb.h	2006-08-13 23:50:36.000000000 +0200
@@ -355,5 +355,9 @@
 
 extern void aty_reset_engine(const struct atyfb_par *par);
 extern void aty_init_engine(struct atyfb_par *par, struct fb_info *info);
-extern void aty_st_pll_ct(int offset, u8 val, const struct atyfb_par *par);
 extern u8   aty_ld_pll_ct(int offset, const struct atyfb_par *par);
+
+void atyfb_copyarea(struct fb_info *info, const struct fb_copyarea *area);
+void atyfb_fillrect(struct fb_info *info, const struct fb_fillrect *rect);
+void atyfb_imageblit(struct fb_info *info, const struct fb_image *image);
+
--- linux-2.6.18-rc4-mm1/drivers/video/aty/mach64_ct.c.old	2006-08-13 23:45:31.000000000 +0200
+++ linux-2.6.18-rc4-mm1/drivers/video/aty/mach64_ct.c	2006-08-13 23:45:36.000000000 +0200
@@ -27,7 +27,7 @@
 	return res;
 }
 
-void aty_st_pll_ct(int offset, u8 val, const struct atyfb_par *par)
+static void aty_st_pll_ct(int offset, u8 val, const struct atyfb_par *par)
 {
 	/* write addr byte */
 	aty_st_8(CLOCK_CNTL_ADDR, ((offset << 2) & PLL_ADDR) | PLL_WR_EN, par);
--- linux-2.6.18-rc4-mm1/drivers/video/aty/atyfb_base.c.old	2006-08-13 23:48:29.000000000 +0200
+++ linux-2.6.18-rc4-mm1/drivers/video/aty/atyfb_base.c	2006-08-13 23:50:25.000000000 +0200
@@ -240,9 +240,6 @@
 static int atyfb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info);
 static int atyfb_blank(int blank, struct fb_info *info);
 static int atyfb_ioctl(struct fb_info *info, u_int cmd, u_long arg);
-extern void atyfb_fillrect(struct fb_info *info, const struct fb_fillrect *rect);
-extern void atyfb_copyarea(struct fb_info *info, const struct fb_copyarea *area);
-extern void atyfb_imageblit(struct fb_info *info, const struct fb_image *image);
 #ifdef __sparc__
 static int atyfb_mmap(struct fb_info *info, struct vm_area_struct *vma);
 #endif



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
