From: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: [patch] FB: Export symbol fb_mode_option
Date: Thu, 29 May 2008 11:59:39 -0700
Message-ID: <483EFD1B.1070308@am.sony.com>
References: <48349676.5030608@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K1nLv-0001Hk-6R for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 29 May 2008 11:59:55 -0700
Received: from outbound-wa4.frontbridge.com ([216.32.181.16]
	helo=outbound6-wa4-R.bigfish.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1K1nLr-0001nW-SM
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 29 May 2008 11:59:55 -0700
In-Reply-To: <48349676.5030608@am.sony.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: akpm@linux-foundation.org
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com

Frame buffer and mode setting drivers can be built as modules,
so fb_mode_option needs to be exported to support these.

Prevents this error:

  ERROR: "fb_mode_option" [drivers/ps3/ps3av_mod.ko] undefined!

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
Acked-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
Hi Andrew,

I posted this to the linux-fbdev some time ago, but no
one picked it up.  Could you please merge it for 2.6.26.

-Geoff

 drivers/video/modedb.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/video/modedb.c
+++ b/drivers/video/modedb.c
@@ -28,6 +28,7 @@
 #endif
 
 const char *fb_mode_option;
+EXPORT_SYMBOL_GPL(fb_mode_option);
 
     /*
      *  Standard video mode definitions (taken from XFree86)


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
