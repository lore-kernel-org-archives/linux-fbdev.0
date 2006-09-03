From: syrjala@sci.fi
Subject: [patch 6/9] atyfb: Fix __init and __devinit
	annotations
Date: Mon, 04 Sep 2006 01:06:53 +0300
Message-ID: <20060903220703.009244062@proteus.korsu.shacknet.nu>
References: <20060903220646.894202994@proteus.korsu.shacknet.nu>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="===============0639583335=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GK00v-0008RH-Ps for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 03 Sep 2006 15:00:25 -0700
Received: from smtp5.pp.htv.fi ([213.243.153.39])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GK00t-0004qb-JF
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

--===============0639583335==
Content-Disposition: inline;
	filename=atyfb_fix_init_and_devinit_annotations.patch

Fix some __init and __devinit annotations.

Signed-off-by: Ville Syrjala <syrjala@sci.fi>
---

 drivers/video/aty/atyfb_base.c |    8 ++++----
 drivers/video/aty/mach64_ct.c  |    8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

Index: linux-2.6.18-rc4/drivers/video/aty/atyfb_base.c
===================================================================
--- linux-2.6.18-rc4.orig/drivers/video/aty/atyfb_base.c
+++ linux-2.6.18-rc4/drivers/video/aty/atyfb_base.c
@@ -3177,7 +3177,7 @@ static int __devinit atyfb_setup_sparc(s
 
 #ifdef __i386__
 #ifdef CONFIG_FB_ATY_GENERIC_LCD
-static void aty_init_lcd(struct atyfb_par *par, u32 bios_base)
+static void __devinit aty_init_lcd(struct atyfb_par *par, u32 bios_base)
 {
 	u32 driv_inf_tab, sig;
 	u16 lcd_ofs;
@@ -3636,7 +3636,7 @@ err_release_mem:
 
 #ifdef CONFIG_ATARI
 
-static int __devinit atyfb_atari_probe(void)
+static int __init atyfb_atari_probe(void)
 {
 	struct atyfb_par *par;
 	struct fb_info *info;
@@ -3782,7 +3782,7 @@ static struct pci_driver atyfb_driver = 
 #endif /* CONFIG_PCI */
 
 #ifndef MODULE
-static int __devinit atyfb_setup(char *options)
+static int __init atyfb_setup(char *options)
 {
 	char *this_opt;
 
@@ -3854,7 +3854,7 @@ static int __devinit atyfb_setup(char *o
 }
 #endif  /*  MODULE  */
 
-static int __devinit atyfb_init(void)
+static int __init atyfb_init(void)
 {
 #ifndef MODULE
     char *option = NULL;
Index: linux-2.6.18-rc4/drivers/video/aty/mach64_ct.c
===================================================================
--- linux-2.6.18-rc4.orig/drivers/video/aty/mach64_ct.c
+++ linux-2.6.18-rc4/drivers/video/aty/mach64_ct.c
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

-- 
Ville Syrj������l������
syrjala@sci.fi
http://www.sci.fi/~syrjala/


--===============0639583335==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0639583335==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0639583335==--
