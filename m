From: maximilian attems <janitor@sternwelten.at>
Subject: [patch-kj] remove faulty __init's from drivers/video/fbmem.c
Date: Fri, 23 Jul 2004 11:42:52 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040723094252.GE1795@stro.at>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BnwZu-0001qX-EN
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 23 Jul 2004 02:42:58 -0700
Received: from baikonur.stro.at ([213.239.196.228])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BnwZt-0006SE-Nl
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 23 Jul 2004 02:42:58 -0700
Content-Disposition: inline
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
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: jsimmons@infradead.org, geert@linux-m68k.org



Hi.

These four are called from fb_show_logo, which is exported symbol,
called by fbcon_switch.

Compile tested.

	Domen

patch is against 2.6.7-bk20, please tell if you need against newer.

From: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems



---

 linux-2.6.7-bk20-max/drivers/video/fbmem.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff -puN drivers/video/fbmem.c~faulty-inits-fbmem drivers/video/fbmem.c
--- linux-2.6.7-bk20/drivers/video/fbmem.c~faulty-inits-fbmem	2004-07-11 14:40:42.000000000 +0200
+++ linux-2.6.7-bk20-max/drivers/video/fbmem.c	2004-07-11 14:40:42.000000000 +0200
@@ -563,7 +563,7 @@ static inline unsigned safe_shift(unsign
 	return n < 0 ? d >> -n : d << n;
 }
 
-static void __init fb_set_logocmap(struct fb_info *info,
+static void fb_set_logocmap(struct fb_info *info,
 				   const struct linux_logo *logo)
 {
 	struct fb_cmap palette_cmap;
@@ -597,7 +597,7 @@ static void __init fb_set_logocmap(struc
 	}
 }
 
-static void  __init fb_set_logo_truepalette(struct fb_info *info,
+static void  fb_set_logo_truepalette(struct fb_info *info,
 					    const struct linux_logo *logo,
 					    u32 *palette)
 {
@@ -627,7 +627,7 @@ static void  __init fb_set_logo_truepale
 	}
 }
 
-static void __init fb_set_logo_directpalette(struct fb_info *info,
+static void fb_set_logo_directpalette(struct fb_info *info,
 					     const struct linux_logo *logo,
 					     u32 *palette)
 {
@@ -642,7 +642,7 @@ static void __init fb_set_logo_directpal
 		palette[i] = i << redshift | i << greenshift | i << blueshift;
 }
 
-static void __init fb_set_logo(struct fb_info *info,
+static void fb_set_logo(struct fb_info *info,
 			       const struct linux_logo *logo, u8 *dst,
 			       int depth)
 {



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
