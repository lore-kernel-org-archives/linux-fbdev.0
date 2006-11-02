From: akpm@osdl.org
Subject: [patch 22/25] atyfb: Fix __init and __devinit
	annotations
Date: Wed, 01 Nov 2006 21:50:32 -0800
Message-ID: <200611020550.kA25oWxa002354@shell0.pdx.osdl.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GfVTa-0007a2-Eo for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Nov 2006 21:50:54 -0800
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1GfVTa-0007K8-1K
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Nov 2006 21:50:54 -0800
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
Cc: akpm@osdl.org, adaplas@pol.net, syrjala@sci.fi

From: Ville Syrjala <syrjala@sci.fi>

Fix some __init and __devinit annotations.

Signed-off-by: Ville Syrjala <syrjala@sci.fi>
Cc: "Antonino A. Daplas" <adaplas@pol.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/video/aty/atyfb_base.c |    8 ++++----
 drivers/video/aty/mach64_ct.c  |    8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff -puN drivers/video/aty/atyfb_base.c~atyfb-fix-__init-and-__devinit drivers/video/aty/atyfb_base.c
--- a/drivers/video/aty/atyfb_base.c~atyfb-fix-__init-and-__devinit
+++ a/drivers/video/aty/atyfb_base.c
@@ -3181,7 +3181,7 @@ static int __devinit atyfb_setup_sparc(s
 
 #ifdef __i386__
 #ifdef CONFIG_FB_ATY_GENERIC_LCD
-static void aty_init_lcd(struct atyfb_par *par, u32 bios_base)
+static void __devinit aty_init_lcd(struct atyfb_par *par, u32 bios_base)
 {
 	u32 driv_inf_tab, sig;
 	u16 lcd_ofs;
@@ -3644,7 +3644,7 @@ err_release_mem:
 
 #ifdef CONFIG_ATARI
 
-static int __devinit atyfb_atari_probe(void)
+static int __init atyfb_atari_probe(void)
 {
 	struct atyfb_par *par;
 	struct fb_info *info;
@@ -3794,7 +3794,7 @@ static struct pci_driver atyfb_driver = 
 #endif /* CONFIG_PCI */
 
 #ifndef MODULE
-static int __devinit atyfb_setup(char *options)
+static int __init atyfb_setup(char *options)
 {
 	char *this_opt;
 
@@ -3866,7 +3866,7 @@ static int __devinit atyfb_setup(char *o
 }
 #endif  /*  MODULE  */
 
-static int __devinit atyfb_init(void)
+static int __init atyfb_init(void)
 {
     int err1 = 1, err2 = 1;
 #ifndef MODULE
diff -puN drivers/video/aty/mach64_ct.c~atyfb-fix-__init-and-__devinit drivers/video/aty/mach64_ct.c
--- a/drivers/video/aty/mach64_ct.c~atyfb-fix-__init-and-__devinit
+++ a/drivers/video/aty/mach64_ct.c
@@ -370,8 +370,8 @@ void aty_set_pll_ct(const struct fb_info
 #endif
 }
 
-static void __init aty_get_pll_ct(const struct fb_info *info,
-				  union aty_pll *pll)
+static void __devinit aty_get_pll_ct(const struct fb_info *info,
+				     union aty_pll *pll)
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 	u8 tmp, clock;
@@ -394,8 +394,8 @@ static void __init aty_get_pll_ct(const 
 	}
 }
 
-static int __init aty_init_pll_ct(const struct fb_info *info,
-				 union aty_pll *pll)
+static int __devinit aty_init_pll_ct(const struct fb_info *info,
+				     union aty_pll *pll)
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 	u8 mpost_div, xpost_div, sclk_post_div_real, sclk_fb_div, spll_cntl2;
_

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
