From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [patch 02/18] m68k: Kill CONFIG_FB_DAFB
Date: Sun, 18 May 2008 20:47:08 +0200
Message-ID: <20080518185150.302370159@mail.of.borg>
References: <20080518184706.631023070@mail.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jxo1D-00023q-V3 for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 18 May 2008 11:54:04 -0700
Received: from nelson.telenet-ops.be ([195.130.133.66])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jxo1C-0006E9-Hk
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 18 May 2008 11:54:03 -0700
Content-Disposition: inline; filename=m68k-kill-CONFIG_FB_DAFB.diff
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
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-m68k@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert@linux-m68k.org>

CONFIG_FB_DAFB is a leftover from pre-Kconfig

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/video/Kconfig |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -627,7 +627,6 @@ config FB_MAC
 	select FB_CFB_IMAGEBLIT
 	select FB_MACMODES
 
-#      bool '  Apple DAFB display support' CONFIG_FB_DAFB
 config FB_HP300
 	bool
 	depends on (FB = y) && HP300

-- 
Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
