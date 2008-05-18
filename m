From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [patch 09/18] m68k: dnfb doesnt check for Apollo
Date: Sun, 18 May 2008 20:47:15 +0200
Message-ID: <20080518185151.958136548@mail.of.borg>
References: <20080518184706.631023070@mail.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jxo1L-000262-V3 for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 18 May 2008 11:54:11 -0700
Received: from winston.telenet-ops.be ([195.130.137.75])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jxo1K-00081Z-JZ
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 18 May 2008 11:54:11 -0700
Content-Disposition: inline; filename=m68k-dnfb-breaks-multi-platform.diff
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

The Apollo frame buffer device driver (dnfb) doesn't check whether it's
actually running on Apollo hardware, causing a crash if it isn't.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/video/dnfb.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/video/dnfb.c
+++ b/drivers/video/dnfb.c
@@ -284,6 +284,9 @@ int __init dnfb_init(void)
 {
 	int ret;
 
+	if (!MACH_IS_APOLLO)
+		return -ENODEV;
+
 	if (fb_get_options("dnfb", NULL))
 		return -ENODEV;
 

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
