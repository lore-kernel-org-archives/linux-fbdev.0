From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] MIPS DEC/SGI Linux logo
Date: Sat, 26 Jul 2003 16:51:56 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200307261451.h6QEpusD002436@callisto.of.borg>
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from amsfep11-int.chello.nl ([213.46.243.20])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19gQLF-0005VL-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 26 Jul 2003 07:48:13 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@transmeta.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Fbdev <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, Geert Uytterhoeven <geert@linux-m68k.org>

MIPS: Show the correct logo on DEC and SGI machines.

--- linux-2.6.x/drivers/video/logo/logo.c	Tue May 27 19:03:30 2003
+++ linux-m68k-2.6.x/drivers/video/logo/logo.c	Sat Jun 28 14:54:12 2003
@@ -66,7 +66,7 @@
 #endif
 #ifdef CONFIG_LOGO_DEC_CLUT224
 		/* DEC Linux logo on MIPS/MIPS64 */
-		if (mips_machgroup == MACH_GROUP_SGI)
+		if (mips_machgroup == MACH_GROUP_DEC)
 			logo = &logo_dec_clut224;
 #endif
 #ifdef CONFIG_LOGO_MAC_CLUT224

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
