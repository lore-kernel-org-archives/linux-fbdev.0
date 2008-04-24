From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [patch 09/15] m68k: dnfb doesnt check for Apollo
Date: Thu, 24 Apr 2008 20:29:49 +0200
Message-ID: <20080424183242.692694606@mail.of.borg>
References: <20080424182940.424312704@mail.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jp6H3-0005ev-TY for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 24 Apr 2008 11:34:25 -0700
Received: from winston.telenet-ops.be ([195.130.137.75])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jp6Gx-0003Pg-Hl
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 24 Apr 2008 11:34:24 -0700
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
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
