From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH] atyfb: Fix kconfig error
Date: Fri, 2 Mar 2007 18:31:54 -0800
Message-ID: <20070302183154.9722ca55.rdunlap@xenotime.net>
References: <45E356B8.8000707@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HNK4b-0001Dg-PZ for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 02 Mar 2007 18:34:14 -0800
Received: from xenotime.net ([66.160.160.81])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HNK4Z-0005Q6-GB
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 02 Mar 2007 18:34:13 -0800
Received: from midway.site ([71.245.96.156]) by xenotime.net for
	<linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 2 Mar 2007 18:34:06 -0800
In-Reply-To: <45E356B8.8000707@gmail.com>
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
Cc: Andrew Morton <akpm@osdl.org>, "Antonino A. Daplas" <adaplas@gmail.com>

On Tue, 27 Feb 2007 05:52:56 +0800 Antonino A. Daplas wrote:

> Fix the following compile error:
> 
>   MODPOST 327 modules
> WARNING: "aty_st_lcd" [drivers/video/aty/atyfb.ko] undefined!
> WARNING: "aty_ld_lcd" [drivers/video/aty/atyfb.ko] undefined!
> make[1]: *** [__modpost] Error 1
> make: *** [modules] Error 2
> 
> Signed-off-by: Antonino Daplas <adaplas@gmail.com>
> ---
> 
>  drivers/video/aty/atyfb_base.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
> index 56b38f5..9ebc4a0 100644
> --- a/drivers/video/aty/atyfb_base.c
> +++ b/drivers/video/aty/atyfb_base.c
> @@ -131,7 +131,8 @@ #endif
>  #define PRINTKI(fmt, args...)	printk(KERN_INFO "atyfb: " fmt, ## args)
>  #define PRINTKE(fmt, args...)	 printk(KERN_ERR "atyfb: " fmt, ## args)
>  
> -#if defined(CONFIG_PM) || defined(CONFIG_PMAC_BACKLIGHT) || defined (CONFIG_FB_ATY_GENERIC_LCD)
> +#if defined(CONFIG_PM) || defined(CONFIG_PMAC_BACKLIGHT) || \
> +defined (CONFIG_FB_ATY_GENERIC_LCD) || defined(CONFIG_FB_ATY_BACKLIGHT)
>  static const u32 lt_lcd_regs[] = {
>  	CONFIG_PANEL_LG,
>  	LCD_GEN_CNTL_LG,

Hm, I did a version of this patch, but I did that change in
atyfb.h also, due to missing (implicit) declaration warnings as well.

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix implicit declarations and missing code in atyfb.

drivers/video/aty/atyfb_base.c:2137: warning: implicit declaration of function 'a
ty_ld_lcd'
drivers/video/aty/atyfb_base.c:2154: warning: implicit declaration of function 'a
ty_st_lcd'
atyfb_base.c:(.text+0x33e5c): undefined reference to `aty_ld_lcd'
atyfb_base.c:(.text+0x33eb2): undefined reference to `aty_st_lcd'

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/video/aty/atyfb.h      |    2 +-
 drivers/video/aty/atyfb_base.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2621-rc2.orig/drivers/video/aty/atyfb.h
+++ linux-2621-rc2/drivers/video/aty/atyfb.h
@@ -284,7 +284,7 @@ static inline void aty_st_8(int regindex
 #endif
 }
 
-#if defined(CONFIG_PM) || defined(CONFIG_PMAC_BACKLIGHT) || defined (CONFIG_FB_ATY_GENERIC_LCD)
+#if defined(CONFIG_PM) || defined(CONFIG_PMAC_BACKLIGHT) || defined (CONFIG_FB_ATY_GENERIC_LCD) || defined(CONFIG_FB_ATY_BACKLIGHT)
 extern void aty_st_lcd(int index, u32 val, const struct atyfb_par *par);
 extern u32 aty_ld_lcd(int index, const struct atyfb_par *par);
 #endif
--- linux-2621-rc2.orig/drivers/video/aty/atyfb_base.c
+++ linux-2621-rc2/drivers/video/aty/atyfb_base.c
@@ -131,7 +131,7 @@
 #define PRINTKI(fmt, args...)	printk(KERN_INFO "atyfb: " fmt, ## args)
 #define PRINTKE(fmt, args...)	 printk(KERN_ERR "atyfb: " fmt, ## args)
 
-#if defined(CONFIG_PM) || defined(CONFIG_PMAC_BACKLIGHT) || defined (CONFIG_FB_ATY_GENERIC_LCD)
+#if defined(CONFIG_PM) || defined(CONFIG_PMAC_BACKLIGHT) || defined (CONFIG_FB_ATY_GENERIC_LCD) || defined(CONFIG_FB_ATY_BACKLIGHT)
 static const u32 lt_lcd_regs[] = {
 	CONFIG_PANEL_LG,
 	LCD_GEN_CNTL_LG,
@@ -173,7 +173,7 @@ u32 aty_ld_lcd(int index, const struct a
 		return aty_ld_le32(LCD_DATA, par);
 	}
 }
-#endif /* defined(CONFIG_PM) || defined(CONFIG_PMAC_BACKLIGHT) || defined (CONFIG_FB_ATY_GENERIC_LCD) */
+#endif /* defined(CONFIG_PM) || defined(CONFIG_PMAC_BACKLIGHT) || defined (CONFIG_FB_ATY_GENERIC_LCD) || defined(CONFIG_FB_ATY_BACKLIGHT) */
 
 #ifdef CONFIG_FB_ATY_GENERIC_LCD
 /*

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
