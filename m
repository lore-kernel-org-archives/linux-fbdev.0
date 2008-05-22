From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] fbcon: make logo_height a local variable
Date: Thu, 22 May 2008 18:34:15 +0200
Message-ID: <20080522183415.0669d04f.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JzDiZ-0005yD-Qf for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 May 2008 09:32:40 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JzDiV-0006or-PT
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 May 2008 09:32:39 -0700
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
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@linux-foundation.org>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Make logo_height variable local in the only
function it is used.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

diff -urp linux-2.6.25/drivers/video/console/fbcon.c linux-new/drivers/video/console/fbcon.c
--- linux-2.6.25/drivers/video/console/fbcon.c	2008-05-17 07:59:01.964211711 +0200
+++ linux-new/drivers/video/console/fbcon.c	2008-05-22 18:30:18.204052393 +0200
@@ -107,9 +107,7 @@ static struct display fb_display[MAX_NR_
 
 static signed char con2fb_map[MAX_NR_CONSOLES];
 static signed char con2fb_map_boot[MAX_NR_CONSOLES];
-#ifndef MODULE
-static int logo_height;
-#endif
+
 static int logo_lines;
 /* logo_shown is an index to vc_cons when >= 0; otherwise follows FBCON_LOGO
    enums.  */
@@ -607,6 +605,7 @@ static void fbcon_prepare_logo(struct vc
 	struct fbcon_ops *ops = info->fbcon_par;
 	int cnt, erase = vc->vc_video_erase_char, step;
 	unsigned short *save = NULL, *r, *q;
+	int logo_height;
 
 	if (info->flags & FBINFO_MODULE) {
 		logo_shown = FBCON_LOGO_DONTSHOW;

----------------------------------------------------------------------
Dlugi weekend w deszczu?.. Lepiej sprawdz pogode! 	
http://link.interia.pl/f1dcd


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
