From: Ville Syrjala <syrjala@sci.fi>
Subject: [PATCH 5/7] sm501: Remove a duplicated table
Date: Sun, 25 Nov 2007 22:01:30 +0200
Message-ID: <1196020893943-git-send-email-syrjala@sci.fi>
References: <1196020892591-git-send-email-syrjala@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IwNff-0002Rw-Ta for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Nov 2007 12:01:39 -0800
Received: from smtp6.pp.htv.fi ([213.243.153.40])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IwNfd-0000p1-5l
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Nov 2007 12:01:39 -0800
In-Reply-To: <1196020892591-git-send-email-syrjala@sci.fi>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: ben@simtec.co.uk, vince@simtec.co.uk, Ville Syrjala <syrjala@sci.fi>

misc_div is a subset of px_div so eliminate the smaller table.

Signed-off-by: Ville Syrjala <syrjala@sci.fi>
---
 drivers/mfd/sm501.c |   45 +++++++++++++--------------------------------
 1 files changed, 13 insertions(+), 32 deletions(-)

diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index 8135e4c..f31947c 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -53,26 +53,7 @@ struct sm501_devdata {
 #define MHZ (1000 * 1000)
 
 #ifdef DEBUG
-static const unsigned int misc_div[] = {
-	[0]		= 1,
-	[1]		= 2,
-	[2]		= 4,
-	[3]		= 8,
-	[4]		= 16,
-	[5]		= 32,
-	[6]		= 64,
-	[7]		= 128,
-	[8]		= 3,
-	[9]		= 6,
-	[10]		= 12,
-	[11]		= 24,
-	[12]		= 48,
-	[13]		= 96,
-	[14]		= 192,
-	[15]		= 384,
-};
-
-static const unsigned int px_div[] = {
+static const unsigned int div_tab[] = {
 	[0]		= 1,
 	[1]		= 2,
 	[2]		= 4,
@@ -101,12 +82,12 @@ static const unsigned int px_div[] = {
 
 static unsigned long decode_div(unsigned long pll2, unsigned long val,
 				unsigned int lshft, unsigned int selbit,
-				unsigned long mask, const unsigned int *dtab)
+				unsigned long mask)
 {
 	if (val & selbit)
 		pll2 = 288 * MHZ;
 
-	return pll2 / dtab[(val >> lshft) & mask];
+	return pll2 / div_tab[(val >> lshft) & mask];
 }
 
 #define fmt_freq(x) ((x) / MHZ), ((x) % MHZ), (x)
@@ -141,10 +122,10 @@ static void sm501_dump_clk(struct sm501_devdata *sm)
 	}
 
 	sdclk0 = (misct & (1<<12)) ? pll2 : 288 * MHZ;
-	sdclk0 /= misc_div[((misct >> 8) & 0xf)];
+	sdclk0 /= div_tab[((misct >> 8) & 0xf)];
 
 	sdclk1 = (misct & (1<<20)) ? pll2 : 288 * MHZ;
-	sdclk1 /= misc_div[((misct >> 16) & 0xf)];
+	sdclk1 /= div_tab[((misct >> 16) & 0xf)];
 
 	dev_dbg(sm->dev, "MISCT=%08lx, PM0=%08lx, PM1=%08lx\n",
 		misct, pm0, pm1);
@@ -158,19 +139,19 @@ static void sm501_dump_clk(struct sm501_devdata *sm)
 		 "P2 %ld.%ld MHz (%ld), V2 %ld.%ld (%ld), "
 x		 "M %ld.%ld (%ld), MX1 %ld.%ld (%ld)\n",
 		 (pmc & 3 ) == 0 ? '*' : '-',
-		 fmt_freq(decode_div(pll2, pm0, 24, 1<<29, 31, px_div)),
-		 fmt_freq(decode_div(pll2, pm0, 16, 1<<20, 15, misc_div)),
-		 fmt_freq(decode_div(pll2, pm0, 8,  1<<12, 15, misc_div)),
-		 fmt_freq(decode_div(pll2, pm0, 0,  1<<4,  15, misc_div)));
+		 fmt_freq(decode_div(pll2, pm0, 24, 1<<29, 31)),
+		 fmt_freq(decode_div(pll2, pm0, 16, 1<<20, 15)),
+		 fmt_freq(decode_div(pll2, pm0, 8,  1<<12, 15)),
+		 fmt_freq(decode_div(pll2, pm0, 0,  1<<4,  15)));
 
 	dev_dbg(sm->dev, "PM1[%c]: "
 		"P2 %ld.%ld MHz (%ld), V2 %ld.%ld (%ld), "
 		"M %ld.%ld (%ld), MX1 %ld.%ld (%ld)\n",
 		(pmc & 3 ) == 1 ? '*' : '-',
-		fmt_freq(decode_div(pll2, pm1, 24, 1<<29, 31, px_div)),
-		fmt_freq(decode_div(pll2, pm1, 16, 1<<20, 15, misc_div)),
-		fmt_freq(decode_div(pll2, pm1, 8,  1<<12, 15, misc_div)),
-		fmt_freq(decode_div(pll2, pm1, 0,  1<<4,  15, misc_div)));
+		fmt_freq(decode_div(pll2, pm1, 24, 1<<29, 31)),
+		fmt_freq(decode_div(pll2, pm1, 16, 1<<20, 15)),
+		fmt_freq(decode_div(pll2, pm1, 8,  1<<12, 15)),
+		fmt_freq(decode_div(pll2, pm1, 0,  1<<4,  15)));
 }
 
 static void sm501_dump_regs(struct sm501_devdata *sm)
-- 
1.5.2.5


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
