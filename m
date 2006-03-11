From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 17/18] imsttfb: Remove dead code
Date: Sat, 11 Mar 2006 09:51:53 +0800
Message-ID: <44122D39.1070805@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FHuBB-0007Xh-UU
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Mar 2006 18:50:05 -0800
Received: from pproxy.gmail.com ([64.233.166.180])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FHtOB-0003lQ-NL
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Mar 2006 17:59:28 -0800
Received: by pproxy.gmail.com with SMTP id z59so419612pyg
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 10 Mar 2006 17:59:24 -0800 (PST)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

clk_p is always 0.

Coverity Bug 67

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/imsttfb.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/imsttfb.c b/drivers/video/imsttfb.c
index 7db4254..859ba7e 100644
--- a/drivers/video/imsttfb.c
+++ b/drivers/video/imsttfb.c
@@ -440,9 +440,9 @@ getclkMHz(struct imstt_par *par)
 static void
 setclkMHz(struct imstt_par *par, __u32 MHz)
 {
-	__u32 clk_m, clk_n, clk_p, x, stage, spilled;
+	__u32 clk_m, clk_n, x, stage, spilled;
 
-	clk_m = clk_n = clk_p = 0;
+	clk_m = clk_n = 0;
 	stage = spilled = 0;
 	for (;;) {
 		switch (stage) {
@@ -453,7 +453,7 @@ setclkMHz(struct imstt_par *par, __u32 M
 				clk_n++;
 				break;
 		}
-		x = 20 * (clk_m + 1) / ((clk_n + 1) * (clk_p ? 2 * clk_p : 1));
+		x = 20 * (clk_m + 1) / (clk_n + 1);
 		if (x == MHz)
 			break;
 		if (x > MHz) {
@@ -466,7 +466,7 @@ setclkMHz(struct imstt_par *par, __u32 M
 
 	par->init.pclk_m = clk_m;
 	par->init.pclk_n = clk_n;
-	par->init.pclk_p = clk_p;
+	par->init.pclk_p = 0;
 }
 
 static struct imstt_regvals *




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
