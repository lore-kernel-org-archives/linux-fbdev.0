From: Richard Drummond <evilrich@rcdrummond.net>
Subject: [PATCH] Better PLL frequency matching for tdfxfb driver
Date: Thu, 21 Apr 2005 22:58:00 -0500
Message-ID: <200504212258.00570.evilrich@rcdrummond.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_IZHaCqkOpSzY1nK"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DOpU3-0006uG-8q
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 21 Apr 2005 21:09:39 -0700
Received: from mail03.powweb.com ([66.152.97.36])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DOpU1-0003kA-TW
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 21 Apr 2005 21:09:39 -0700
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org

--Boundary-00=_IZHaCqkOpSzY1nK
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Attached is a patch against 2.6.11.7 which improves the PLL frequency matching 
in the tdfxfb driver. Instead of requiring 64260 iterations to obtain the 
closest supported PLL frequency, this code does it with the same degree of 
accuracy in at most 768 iterations.

Signed-off-by: Richard Drummond <evilrich@rcdrummond.net>

--Boundary-00=_IZHaCqkOpSzY1nK
Content-Type: text/x-diff;
  charset="us-ascii";
  name="tdfxfb_pll_fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="tdfxfb_pll_fix.diff"

--- drivers/video/tdfxfb.c_orig	2005-04-20 15:04:23.000000000 -0500
+++ drivers/video/tdfxfb.c	2005-04-21 09:26:18.000000000 -0500
@@ -320,30 +320,40 @@
 
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
-				}
+   
+	for (k = 3; k >= 0; k--) {	
+		for (m = 63; m >= 0; m--) {
+			/* Estimate value of n that produces target frequency with current m and k */
+			int n_estimated = (freq * (m + 2) * (1 << k) / fref) - 2;
+	     
+			/* Search neighborhood of estimated n */
+			for (n = max(0, n_estimated - 1); n <= min(255, n_estimated + 1); n++) {
+				/* Calculate PLL freqency with current m, k and estimated n */
+				int f     = fref * (n + 2) / (m + 2) / (1 << k);
+				int error = abs (f - freq);
+		  
+				/* If this is the closest we've come to the target frequency
+				 * then remember n, m and k */
+				if (error  < best_error) {
+					best_error = error;
+					best_n     = n;
+					best_m     = m;
+					best_k     = k;
+				}  
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
 

--Boundary-00=_IZHaCqkOpSzY1nK--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
