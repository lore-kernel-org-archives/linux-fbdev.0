From: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: FB: Export symbol fb_mode_option
Date: Wed, 21 May 2008 14:39:02 -0700
Message-ID: <48349676.5030608@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jyw4X-0008Bx-Vi for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 May 2008 14:42:10 -0700
Received: from outbound-wa4.frontbridge.com ([216.32.181.16]
	helo=outbound4-wa4-R.bigfish.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Jyw4V-000463-SP
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 May 2008 14:42:09 -0700
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
To: adaplas@gmail.com
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, linux-fbdev-devel@lists.sourceforge.net

Frame buffer drivers and the associated mode setting
drivers can be built as modules, so fb_mode_option needs
to be exported to support these.

Prevents this error:

  ERROR: "fb_mode_option" [drivers/ps3/ps3av_mod.ko] undefined!

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
Acked-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
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
