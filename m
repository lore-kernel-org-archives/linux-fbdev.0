From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: linux-2.6.21-rc1-g9654640d build
	#241	failed with WARNING: "aty_st_lcd"
	[drivers/video/aty/atyfb.ko] undefined!
Date: Mon, 26 Feb 2007 20:35:51 +0800
Message-ID: <1172493351.20842.1.camel@daplas>
References: <200702261143.28770.toralf.foerster@gmx.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-9h6oMqdtxgDdUDZFW/Jt"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HLf2q-0007qk-6w for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 26 Feb 2007 04:33:32 -0800
Received: from nz-out-0506.google.com ([64.233.162.230])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HLf2o-0006ju-KO
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 26 Feb 2007 04:33:32 -0800
Received: by nz-out-0506.google.com with SMTP id i11so2134695nzi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 26 Feb 2007 04:33:29 -0800 (PST)
In-Reply-To: <200702261143.28770.toralf.foerster@gmx.de>
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
Cc: Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>


--=-9h6oMqdtxgDdUDZFW/Jt
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-02-26 at 11:43 +0100, Toralf F=C3=B6rster wrote:
>   MODPOST 327 modules
> WARNING: "aty_st_lcd" [drivers/video/aty/atyfb.ko] undefined!
> WARNING: "aty_ld_lcd" [drivers/video/aty/atyfb.ko] undefined!
> make[1]: *** [__modpost] Error 1
> make: *** [modules] Error 2=20

Try the attached patch:

Tony

--=-9h6oMqdtxgDdUDZFW/Jt
Content-Disposition: attachment; filename=atyfb_kconfig.diff
Content-Type: text/x-patch; name=atyfb_kconfig.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
index 56b38f5..9ebc4a0 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -131,7 +131,8 @@ #endif
 #define PRINTKI(fmt, args...)	printk(KERN_INFO "atyfb: " fmt, ## args)
 #define PRINTKE(fmt, args...)	 printk(KERN_ERR "atyfb: " fmt, ## args)
 
-#if defined(CONFIG_PM) || defined(CONFIG_PMAC_BACKLIGHT) || defined (CONFIG_FB_ATY_GENERIC_LCD)
+#if defined(CONFIG_PM) || defined(CONFIG_PMAC_BACKLIGHT) || \
+defined (CONFIG_FB_ATY_GENERIC_LCD) || defined(CONFIG_FB_ATY_BACKLIGHT)
 static const u32 lt_lcd_regs[] = {
 	CONFIG_PANEL_LG,
 	LCD_GEN_CNTL_LG,

--=-9h6oMqdtxgDdUDZFW/Jt
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-9h6oMqdtxgDdUDZFW/Jt
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--=-9h6oMqdtxgDdUDZFW/Jt--
