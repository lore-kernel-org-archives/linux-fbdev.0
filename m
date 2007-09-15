From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] intelfb: Fix bug in DPLL disable
Date: Sun, 16 Sep 2007 07:35:49 +0800
Message-ID: <46EC6C55.7020704@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IWhB3-0007FT-CA for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 15 Sep 2007 16:35:55 -0700
Received: from rv-out-0910.google.com ([209.85.198.186])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IWhB2-0005nK-T2
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 15 Sep 2007 16:35:53 -0700
Received: by rv-out-0910.google.com with SMTP id g11so3918415rvb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 15 Sep 2007 16:35:52 -0700 (PDT)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Airlie <airlied@gmail.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Reported in Kernel Bugzilla 9006

Fix an obvious bug in DPLL disable.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/intelfb/intelfbhw.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/intelfb/intelfbhw.c b/drivers/video/intelfb/intelfbhw.c
index 16bc8d7..c6d1c7b 100644
--- a/drivers/video/intelfb/intelfbhw.c
+++ b/drivers/video/intelfb/intelfbhw.c
@@ -1352,7 +1352,7 @@ #endif
 
 	/* turn off PLL */
 	tmp = INREG(dpll_reg);
-	dpll_reg &= ~DPLL_VCO_ENABLE;
+	tmp &= ~DPLL_VCO_ENABLE;
 	OUTREG(dpll_reg, tmp);
 
 	/* Set PLL parameters */

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
