From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 468] m68k sparse floating point
Date: Tue, 20 Jul 2004 20:38:04 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200407201838.i6KIc4er015409@anakin.of.borg>
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BmzVJ-0004uc-7V
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Jul 2004 11:38:17 -0700
Received: from amsfep17-int.chello.nl ([213.46.243.15])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BmzVI-0007Kq-Kj
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Jul 2004 11:38:17 -0700
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
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>, Linux Fbdev <linux-fbdev-devel@lists.sourceforge.net>, Geert Uytterhoeven <geert@linux-m68k.org>

M68k: Replace floating point by integer constants (found by sparse)
Affected drivers:
  - Amiga frame buffer
  - ATI Mach64 frame buffer

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.8-rc2/drivers/video/amifb.c	2004-04-28 15:49:02.000000000 +0200
+++ linux-m68k-2.6.8-rc2/drivers/video/amifb.c	2004-07-10 21:07:38.000000000 +0200
@@ -2351,7 +2351,7 @@
 	 */
 
 	{
-	u_long tmp = DIVUL(200E9, amiga_eclock);
+	u_long tmp = DIVUL(200000000000ULL, amiga_eclock);
 
 	pixclock[TAG_SHRES] = (tmp + 4) / 8;	/* SHRES:  35 ns / 28 MHz */
 	pixclock[TAG_HIRES] = (tmp + 2) / 4;	/* HIRES:  70 ns / 14 MHz */
--- linux-2.6.8-rc2/drivers/video/aty/mach64_gx.c	2004-04-27 20:30:51.000000000 +0200
+++ linux-m68k-2.6.8-rc2/drivers/video/aty/mach64_gx.c	2004-07-10 21:06:54.000000000 +0200
@@ -653,7 +653,7 @@
 
 		for (m = MIN_M; m <= MAX_M; m++) {
 			for (n = MIN_N; n <= MAX_N; n++) {
-				tempA = (14.31818 * 65536);
+				tempA = 938356;		/* 14.31818 * 65536 */
 				tempA *= (n + 8);	/* 43..256 */
 				tempB = twoToKth * 256;
 				tempB *= (m + 2);	/* 4..32 */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
