From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] neofb: simplify clock calculation
Date: Sun, 29 Jun 2008 18:24:53 +0200
Message-ID: <20080629182453.003d7a0e.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KD04t-0008Ii-0R for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 29 Jun 2008 09:48:39 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KD04r-0007Vo-Hs
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 29 Jun 2008 09:48:38 -0700
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

There is nothing to gain by converting value in kHz to
fixed point MHz. Just calculate everything in kHz.

A reorder of the loop allows reducing number
of iterations (check if frequency is not too high
already).

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

--- linux-mm/drivers/video/neofb.c	2008-04-17 04:49:44.000000000 +0200
+++ linux-new/drivers/video/neofb.c	2008-06-29 18:20:35.000395382 +0200
@@ -201,7 +201,6 @@ static int neoFindMode(int xres, int yre
  *
  * Determine the closest clock frequency to the one requested.
  */
-#define REF_FREQ 0xe517		/* 14.31818 in 20.12 fixed point */
 #define MAX_N 127
 #define MAX_D 31
 #define MAX_F 1
@@ -211,27 +210,24 @@ static void neoCalcVCLK(const struct fb_
 {
 	int n, d, f;
 	int n_best = 0, d_best = 0, f_best = 0;
-	long f_best_diff = (0x7ffff << 12);	/* 20.12 */
-	long f_target = (freq << 12) / 1000;	/* 20.12 */
+	long f_best_diff = 0x7ffff;
 
 	for (f = 0; f <= MAX_F; f++)
-		for (n = 0; n <= MAX_N; n++)
-			for (d = 0; d <= MAX_D; d++) {
-				long f_out;	/* 20.12 */
-				long f_diff;	/* 20.12 */
-
-				f_out =
-				    ((((n + 1) << 12) / ((d +
-							  1) *
-							 (1 << f))) >> 12)
-				    * REF_FREQ;
-				f_diff = abs(f_out - f_target);
-				if (f_diff < f_best_diff) {
+		for (d = 0; d <= MAX_D; d++)
+			for (n = 0; n <= MAX_N; n++) {
+				long f_out;
+				long f_diff;
+
+				f_out = ((14318 * (n + 1)) / (d + 1)) >> f;
+				f_diff = abs(f_out - freq);
+				if (f_diff <= f_best_diff) {
 					f_best_diff = f_diff;
 					n_best = n;
 					d_best = d;
 					f_best = f;
 				}
+				if (f_out > freq)
+					break;
 			}
 
 	if (info->fix.accel == FB_ACCEL_NEOMAGIC_NM2200 ||
@@ -248,11 +244,11 @@ static void neoCalcVCLK(const struct fb_
 	par->VCLK3Denominator = d_best;
 
 #ifdef NEOFB_DEBUG
-	printk("neoVCLK: f:%d NumLow=%d NumHi=%d Den=%d Df=%d\n",
-	       f_target >> 12,
+	printk(KERN_DEBUG "neoVCLK: f:%ld NumLow=%d NumHi=%d Den=%d Df=%ld\n",
+	       freq,
 	       par->VCLK3NumeratorLow,
 	       par->VCLK3NumeratorHigh,
-	       par->VCLK3Denominator, f_best_diff >> 12);
+	       par->VCLK3Denominator, f_best_diff);
 #endif
 }
 


----------------------------------------------------------------------
Posluchaj ballady o Lukaszu Podolskim!
kliknij >>> http://link.interia.pl/f1e55


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
