From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] tridentfb: Blade3D clock fixes
Date: Fri, 30 May 2008 21:36:11 +0200
Message-ID: <20080530213611.0910d8fa.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K2AMY-0004Qx-8V for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 30 May 2008 12:34:06 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K2AMW-0001lt-Qf
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 30 May 2008 12:34:06 -0700
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

This patch fixes following problems:
- does not allow the m parameter to reach 0 as
  it locks the graphics core (power cycle needed)
- for the newer chips (with new clock registers)
  does not allow of n / m ratio below 4 as it gives
  unstable image on the Blade3D core
- extend shift parameter (k) range  to 2 for the newer 
  chips to cope with the n /m >= 4 limit at low resolution
  (bandwidth) modes
- prefer modes with higher n / m ratio (higher k values)

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---
Another test, another patch...

diff -urp linux-old/drivers/video/tridentfb.c linux-new/drivers/video/tridentfb.c
--- linux-old/drivers/video/tridentfb.c	2008-05-30 20:43:03.416124771 +0200
+++ linux-new/drivers/video/tridentfb.c	2008-05-30 21:12:37.887397930 +0200
@@ -672,15 +672,16 @@ static void set_vclk(struct tridentfb_pa
 	unsigned long fi, d, di;
 	unsigned char best_m = 0, best_n = 0, best_k = 0;
 	unsigned char hi, lo;
+	unsigned char shift = !is_oldclock(par->chip_id) ? 2 : 1;
 
 	d = 20000;
-	for (k = 1; k >= 0; k--)
-		for (m = 0; m < 32; m++) {
-			n = 2 * (m + 2) - 8;
+	for (k = shift; k >= 0; k--)
+		for (m = 1; m < 32; m++) {
+			n = ((m + 2) << shift) - 8;
 			for (n = (n < 0 ? 0 : n); n < 122; n++) {
 				fi = ((14318l * (n + 8)) / (m + 2)) >> k;
 				di = abs(fi - freq);
-				if (di <= d) {
+				if (di < d || (di == d && k == best_k)) {
 					d = di;
 					best_n = n;
 					best_m = m;


----------------------------------------------------------------------
Mucha powraca!
Sprawdz >>> http://link.interia.pl/f1e0d


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
