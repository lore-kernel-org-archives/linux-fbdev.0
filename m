From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 1/5] atyfb: Possible cleanups
Date: Mon, 21 Aug 2006 18:53:54 +0800
Message-ID: <1156157635.6254.25.camel@daplas.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GF7Q0-0001HK-3u for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 21 Aug 2006 03:54:08 -0700
Received: from py-out-1112.google.com ([64.233.166.182])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GF7Pw-0004ga-5b
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 21 Aug 2006 03:54:08 -0700
Received: by py-out-1112.google.com with SMTP id x31so2248314pye
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 21 Aug 2006 03:54:00 -0700 (PDT)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Adrian Bunk <bunk@stusta.de>

From: Adrian Bunk <bunk@stusta.de>

- make the following needlessly global function static:
  - mach64_ct.c: aty_st_pll_ct()
- proper prototypes for the following functions:
  - atyfb_base.c: atyfb_copyarea()
  - atyfb_base.c: atyfb_fillrect()
  - atyfb_base.c: atyfb_imageblit()

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/aty/atyfb.h      |    6 +++++-
 drivers/video/aty/atyfb_base.c |    3 ---
 drivers/video/aty/mach64_ct.c  |    2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/video/aty/atyfb.h b/drivers/video/aty/atyfb.h
index 55fb8b0..b04f49f 100644
--- a/drivers/video/aty/atyfb.h
+++ b/drivers/video/aty/atyfb.h
@@ -355,5 +355,9 @@ static inline void wait_for_idle(struct 
 
 extern void aty_reset_engine(const struct atyfb_par *par);
 extern void aty_init_engine(struct atyfb_par *par, struct fb_info *info);
-extern void aty_st_pll_ct(int offset, u8 val, const struct atyfb_par *par);
 extern u8   aty_ld_pll_ct(int offset, const struct atyfb_par *par);
+
+void atyfb_copyarea(struct fb_info *info, const struct fb_copyarea *area);
+void atyfb_fillrect(struct fb_info *info, const struct fb_fillrect *rect);
+void atyfb_imageblit(struct fb_info *info, const struct fb_image *image);
+
diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
index d6be4c7..f295005 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
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
diff --git a/drivers/video/aty/mach64_ct.c b/drivers/video/aty/mach64_ct.c
index e705693..5080816 100644
--- a/drivers/video/aty/mach64_ct.c
+++ b/drivers/video/aty/mach64_ct.c
@@ -27,7 +27,7 @@ u8 aty_ld_pll_ct(int offset, const struc
 	return res;
 }
 
-void aty_st_pll_ct(int offset, u8 val, const struct atyfb_par *par)
+static void aty_st_pll_ct(int offset, u8 val, const struct atyfb_par *par)
 {
 	/* write addr byte */
 	aty_st_8(CLOCK_CNTL_ADDR, ((offset << 2) & PLL_ADDR) | PLL_WR_EN, par);



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
