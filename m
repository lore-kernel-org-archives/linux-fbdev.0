From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] update modedb.txt documentation about
 mode_option parameter change
Date: Thu, 14 Feb 2008 22:58:34 +0100
Message-ID: <20080214225834.98a95860.krzysztof.h1@poczta.fm>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JPm1F-0003nQ-BI for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 14 Feb 2008 13:53:25 -0800
Received: from smtp35.poczta.interia.pl ([80.48.65.35]
	helo=smtp4.poczta.interia.pl)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JPm1D-0006yg-UW
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 14 Feb 2008 13:53:25 -0800
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
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@linux-foundation.org>
Cc: adaplas@gmail.com

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch adds names of drivers converted to "mode_option"
parameter.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

This is one step toward changing all fb drivers to have common "mode_option" parameter.

This patch was created against 2.6.25-rc1 kernel.

diff -urp linux-ref/Documentation/fb/modedb.txt linux-pc/Documentation/fb/modedb.txt
--- linux-ref/Documentation/fb/modedb.txt	2007-10-09 22:31:38.000000000 +0200
+++ linux-pc/Documentation/fb/modedb.txt	2008-02-05 21:34:42.000000000 +0100
@@ -125,8 +125,12 @@ There may be more modes.
     amifb	- Amiga chipset frame buffer
     aty128fb	- ATI Rage128 / Pro frame buffer
     atyfb	- ATI Mach64 frame buffer
+    pm2fb	- Permedia 2/2V frame buffer
+    pm3fb	- Permedia 3 frame buffer
+    sstfb	- Voodoo 1/2 (SST1) chipset frame buffer
     tdfxfb	- 3D Fx frame buffer
     tridentfb	- Trident (Cyber)blade chipset frame buffer
+    vt8623fb	- VIA 8623 frame buffer
 
 BTW, only a few drivers use this at the moment. Others are to follow
 (feel free to send patches).


----------------------------------------------------------------------
Sprawdz, czy pasujesz do swojego partnera!
http://link.interia.pl/f1ce7


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
