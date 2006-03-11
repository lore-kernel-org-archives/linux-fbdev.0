From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 15/18] aty128fb: Fix array overrun
Date: Sat, 11 Mar 2006 09:51:34 +0800
Message-ID: <44122D26.8070907@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FHtyP-0006Fx-Bu
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Mar 2006 18:36:53 -0800
Received: from pproxy.gmail.com ([64.233.166.180])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FHtO1-0003lQ-RF
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Mar 2006 17:59:18 -0800
Received: by pproxy.gmail.com with SMTP id z59so419612pyg
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 10 Mar 2006 17:59:15 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Brad Douglas <brad@neruo.com>

Fix static array overrun

Coverity Bug 556

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/aty/aty128fb.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/video/aty/aty128fb.c b/drivers/video/aty/aty128fb.c
index bfc8a93..620c9a9 100644
--- a/drivers/video/aty/aty128fb.c
+++ b/drivers/video/aty/aty128fb.c
@@ -1326,7 +1326,7 @@ static int aty128_var_to_pll(u32 period_
 	unsigned char post_dividers[] = {1,2,4,8,3,6,12};
 	u32 output_freq;
 	u32 vclk;        /* in .01 MHz */
-	int i;
+	int i = 0;
 	u32 n, d;
 
 	vclk = 100000000 / period_in_ps;	/* convert units to 10 kHz */
@@ -1340,15 +1340,16 @@ static int aty128_var_to_pll(u32 period_
 	/* now, find an acceptable divider */
 	for (i = 0; i < sizeof(post_dividers); i++) {
 		output_freq = post_dividers[i] * vclk;
-		if (output_freq >= c.ppll_min && output_freq <= c.ppll_max)
+		if (output_freq >= c.ppll_min && output_freq <= c.ppll_max) {
+			pll->post_divider = post_dividers[i];
 			break;
+		}
 	}
 
 	/* calculate feedback divider */
 	n = c.ref_divider * output_freq;
 	d = c.ref_clk;
 
-	pll->post_divider = post_dividers[i];
 	pll->feedback_divider = round_div(n, d);
 	pll->vclk = vclk;
 




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
