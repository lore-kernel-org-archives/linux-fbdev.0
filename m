From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] atyfb: Fix section warnings
Date: Sun, 18 Jun 2006 23:42:08 +0800
Message-ID: <44957450.1030803@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fs0bG-00083c-67 for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 18 Jun 2006 09:58:14 -0700
Received: from py-out-1112.google.com ([64.233.166.182])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FrzWC-0000XY-8z
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 18 Jun 2006 08:48:56 -0700
Received: by py-out-1112.google.com with SMTP id i49so1055622pye
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 18 Jun 2006 08:48:56 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Fix the following warning:

WARNING: drivers/video/aty/atyfb.o - Section mismatch: reference to
.init.text:aty_init_cursor from .text between 'aty_init' (at offset 0x241d)
and 'atyfb_blank' 

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/aty/atyfb_base.c    |   26 +++++++++++++-------------
 drivers/video/aty/mach64_cursor.c |    2 +-
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
index 055a7d2..b1a30f4 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -316,12 +316,12 @@ static int vram;
 static int pll;
 static int mclk;
 static int xclk;
-static int comp_sync __initdata = -1;
+static int comp_sync __devinitdata = -1;
 static char *mode;
 
 #ifdef CONFIG_PPC
-static int default_vmode __initdata = VMODE_CHOOSE;
-static int default_cmode __initdata = CMODE_CHOOSE;
+static int default_vmode __devinitdata = VMODE_CHOOSE;
+static int default_cmode __devinitdata = CMODE_CHOOSE;
 
 module_param_named(vmode, default_vmode, int, 0);
 MODULE_PARM_DESC(vmode, "int: video mode for mac");
@@ -330,10 +330,10 @@ MODULE_PARM_DESC(cmode, "int: color mode
 #endif
 
 #ifdef CONFIG_ATARI
-static unsigned int mach64_count __initdata = 0;
-static unsigned long phys_vmembase[FB_MAX] __initdata = { 0, };
-static unsigned long phys_size[FB_MAX] __initdata = { 0, };
-static unsigned long phys_guiregbase[FB_MAX] __initdata = { 0, };
+static unsigned int mach64_count __devinitdata = 0;
+static unsigned long phys_vmembase[FB_MAX] __devinitdata = { 0, };
+static unsigned long phys_size[FB_MAX] __devinitdata = { 0, };
+static unsigned long phys_guiregbase[FB_MAX] __devinitdata = { 0, };
 #endif
 
 /* top -> down is an evolution of mach64 chipset, any corrections? */
@@ -583,7 +583,7 @@ #if defined(CONFIG_PPC)
  *  Apple monitor sense
  */
 
-static int __init read_aty_sense(const struct atyfb_par *par)
+static int __devinit read_aty_sense(const struct atyfb_par *par)
 {
 	int sense, i;
 
@@ -2261,7 +2261,7 @@ #endif
 
 #endif /* CONFIG_FB_ATY_BACKLIGHT */
 
-static void __init aty_calc_mem_refresh(struct atyfb_par *par, int xclk)
+static void __devinit aty_calc_mem_refresh(struct atyfb_par *par, int xclk)
 {
 	const int ragepro_tbl[] = {
 		44, 50, 55, 66, 75, 80, 100
@@ -2321,7 +2321,7 @@ static int __devinit atyfb_get_timings_f
 }
 #endif /* defined(__i386__) && defined(CONFIG_FB_ATY_GENERIC_LCD) */
 
-static int __init aty_init(struct fb_info *info, const char *name)
+static int __devinit aty_init(struct fb_info *info, const char *name)
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 	const char *ramname = NULL, *xtal;
@@ -2748,7 +2748,7 @@ #endif
 }
 
 #ifdef CONFIG_ATARI
-static int __init store_video_par(char *video_str, unsigned char m64_num)
+static int __devinit store_video_par(char *video_str, unsigned char m64_num)
 {
 	char *p;
 	unsigned long vmembase, size, guiregbase;
@@ -3779,7 +3779,7 @@ #endif /* CONFIG_PM */
 #endif /* CONFIG_PCI */
 
 #ifndef MODULE
-static int __init atyfb_setup(char *options)
+static int __devinit atyfb_setup(char *options)
 {
 	char *this_opt;
 
@@ -3851,7 +3851,7 @@ #endif
 }
 #endif  /*  MODULE  */
 
-static int __init atyfb_init(void)
+static int __devinit atyfb_init(void)
 {
 #ifndef MODULE
     char *option = NULL;
diff --git a/drivers/video/aty/mach64_cursor.c b/drivers/video/aty/mach64_cursor.c
index 27bf013..2a7f381 100644
--- a/drivers/video/aty/mach64_cursor.c
+++ b/drivers/video/aty/mach64_cursor.c
@@ -187,7 +187,7 @@ #endif
 	return 0;
 }
 
-int __init aty_init_cursor(struct fb_info *info)
+int __devinit aty_init_cursor(struct fb_info *info)
 {
 	unsigned long addr;
