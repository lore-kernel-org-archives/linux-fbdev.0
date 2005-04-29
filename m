From: akpm@osdl.org
Subject: patch better-pll-frequency-matching-for-tdfxfb-driver.patch added to -mm tree
Date: Fri, 29 Apr 2005 16:18:45 -0700
Message-ID: <200504292318.j3TNIEE4011552@shell0.pdx.osdl.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DRekU-0000uL-LX
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Apr 2005 16:18:18 -0700
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DRekT-0005v1-3O
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Apr 2005 16:18:18 -0700
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: evilrich@rcdrummond.net, linux-fbdev-devel@lists.sourceforge.net


This is a note to let you know that I've just added the patch titled

     Better PLL frequency matching for tdfxfb driver

to the -mm tree.  Its filename is

     better-pll-frequency-matching-for-tdfxfb-driver.patch

Patches currently in -mm which might be from evilrich@rcdrummond.net are

better-pll-frequency-matching-for-tdfxfb-driver.patch



From: Richard Drummond <evilrich@rcdrummond.net>

Improve the PLL frequency matching in the tdfxfb driver.  Instead of
requiring 64260 iterations to obtain the closest supported PLL frequency,
this code does it with the same degree of accuracy in at most 768
iterations.

Signed-off-by: Richard Drummond <evilrich@rcdrummond.net>
Cc: <linux-fbdev-devel@lists.sourceforge.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/video/tdfxfb.c |   43 +++++++++++++++++++++++++++++++------------
 1 files changed, 31 insertions(+), 12 deletions(-)

diff -puN drivers/video/tdfxfb.c~better-pll-frequency-matching-for-tdfxfb-driver drivers/video/tdfxfb.c
--- 25/drivers/video/tdfxfb.c~better-pll-frequency-matching-for-tdfxfb-driver	Fri Apr 29 16:17:28 2005
+++ 25-akpm/drivers/video/tdfxfb.c	Fri Apr 29 16:18:27 2005
@@ -317,30 +317,49 @@ static inline void do_setpalentry(struct
 
 static u32 do_calc_pll(int freq, int* freq_out) 
 {
-	int m, n, k, best_m, best_n, best_k, f_cur, best_error;
+	int m, n, k, best_m, best_n, best_k, best_error;
 	int fref = 14318;
   
-	/* this really could be done with more intelligence --
-	   255*63*4 = 64260 iterations is silly */
 	best_error = freq;
 	best_n = best_m = best_k = 0;
-	for (n = 1; n < 256; n++) {
-		for (m = 1; m < 64; m++) {
-			for (k = 0; k < 4; k++) {
-				f_cur = fref*(n + 2)/(m + 2)/(1 << k);
-				if (abs(f_cur - freq) < best_error) {
-					best_error = abs(f_cur-freq);
-					best_n = n;
-					best_m = m;
-					best_k = k;
+
+	for (k = 3; k >= 0; k--) {
+		for (m = 63; m >= 0; m--) {
+			/*
+			 * Estimate value of n that produces target frequency
+			 * with current m and k
+			 */
+			int n_estimated = (freq * (m + 2) * (1 << k) / fref) - 2;
+
+			/* Search neighborhood of estimated n */
+			for (n = max(0, n_estimated - 1);
+					n <= min(255, n_estimated + 1); n++) {
+				/*
+				 * Calculate PLL freqency with current m, k and
+				 * estimated n
+				 */
+				int f = fref * (n + 2) / (m + 2) / (1 << k);
+				int error = abs (f - freq);
+
+				/*
+				 *  If this is the closest we've come to the
+				 * target frequency then remember n, m and k
+				 */
+				if (error  < best_error) {
+					best_error = error;
+					best_n     = n;
+					best_m     = m;
+					best_k     = k;
 				}
 			}
 		}
 	}
+
 	n = best_n;
 	m = best_m;
 	k = best_k;
 	*freq_out = fref*(n + 2)/(m + 2)/(1 << k);
+
 	return (n << 8) | (m << 2) | k;
 }
 
_


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
