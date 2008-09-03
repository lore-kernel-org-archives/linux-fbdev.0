From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH 3/3] cirrusfb: drop clock fields from
 cirrusfb_regs structure
Date: Wed, 3 Sep 2008 21:23:44 +0200
Message-ID: <20080903212344.ef3ce2df.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KaxqX-0006kp-Jd for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 03 Sep 2008 12:16:53 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KaxqW-0006Ax-Nf
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 03 Sep 2008 12:16:53 -0700
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

Move call to pixclock calculation into the
cirrusfb_set_par_foo(). It makes copy
of clock registers redundant.

Simplify clock calculations further.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 drivers/video/cirrusfb.c |   50 +++++++++++++++++++--------------------------
 1 files changed, 21 insertions(+), 29 deletions(-)

diff --git a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
index 20be2db..50fdd33 100644
--- a/drivers/video/cirrusfb.c
+++ b/drivers/video/cirrusfb.c
@@ -327,10 +327,6 @@ static const struct {
 #endif /* CONFIG_ZORRO */
 
 struct cirrusfb_regs {
-	long freq;
-	long nom;
-	long den;
-	long div;
 	long multiplexing;
 	long mclk;
 	long divMCLK;
@@ -429,9 +425,7 @@ static void cirrusfb_RectFill(u8 __iomem *regbase, int bits_per_pixel,
 			      u_short width, u_short height,
 			      u_char color, u_short line_length);
 
-static void bestclock(long freq, long *best,
-		      long *nom, long *den,
-		      long *div, long maxfreq);
+static void bestclock(long freq, int *nom, int *den, int *div);
 
 #ifdef CIRRUSFB_DEBUG
 static void cirrusfb_dump(void);
@@ -711,9 +705,6 @@ static int cirrusfb_decode_var(const struct fb_var_screeninfo *var,
 		break;
 	}
 #endif
-
-	bestclock(freq, &regs->freq, &regs->nom, &regs->den, &regs->div,
-		  maxclock);
 	regs->mclk = cirrusfb_get_mclk(freq, var->bits_per_pixel,
 					&regs->divMCLK);
 
@@ -756,6 +747,8 @@ static int cirrusfb_set_par_foo(struct fb_info *info)
 	const struct cirrusfb_board_info_rec *bi;
 	int hdispend, hsyncstart, hsyncend, htotal;
 	int yres, vdispend, vsyncstart, vsyncend, vtotal;
+	long freq;
+	int nom, den, div;
 
 	DPRINTK("ENTER\n");
 	DPRINTK("Requested mode: %dx%dx%d\n",
@@ -903,14 +896,17 @@ static int cirrusfb_set_par_foo(struct fb_info *info)
 	DPRINTK("CRT1a: %d\n", tmp);
 	vga_wcrt(regbase, CL_CRT1A, tmp);
 
+	freq = PICOS2KHZ(var->pixclock);
+	bestclock(freq, &nom, &den, &div);
+
 	/* set VCLK0 */
 	/* hardware RefClock: 14.31818 MHz */
 	/* formula: VClk = (OSC * N) / (D * (1+P)) */
 	/* Example: VClk = (14.31818 * 91) / (23 * (1+1)) = 28.325 MHz */
 
-	vga_wseq(regbase, CL_SEQRB, regs.nom);
-	tmp = regs.den << 1;
-	if (regs.div != 0)
+	vga_wseq(regbase, CL_SEQRB, nom);
+	tmp = den << 1;
+	if (div != 0)
 		tmp |= 1;
 
 	/* 6 bit denom; ONLY 5434!!! (bugged me 10 days) */
@@ -2923,16 +2919,14 @@ static void cirrusfb_RectFill(u8 __iomem *regbase, int bits_per_pixel,
  * bestclock() - determine closest possible clock lower(?) than the
  * desired pixel clock
  **************************************************************************/
-static void bestclock(long freq, long *best, long *nom,
-		       long *den, long *div, long maxfreq)
+static void bestclock(long freq, int *nom, int *den, int *div)
 {
-	long n, h, d, f;
+	int n, d;
+	long h, diff;
 
-	assert(best != NULL);
 	assert(nom != NULL);
 	assert(den != NULL);
 	assert(div != NULL);
-	assert(maxfreq > 0);
 
 	*nom = 0;
 	*den = 0;
@@ -2943,16 +2937,12 @@ static void bestclock(long freq, long *best, long *nom,
 	if (freq < 8000)
 		freq = 8000;
 
-	if (freq > maxfreq)
-		freq = maxfreq;
-
-	*best = 0;
-	f = freq * 10;
+	diff = freq;
 
 	for (n = 32; n < 128; n++) {
 		int s = 0;
 
-		d = (143181 * n) / f;
+		d = (14318 * n) / freq;
 		if ((d >= 7) && (d <= 63)) {
 			int temp = d;
 
@@ -2961,8 +2951,9 @@ static void bestclock(long freq, long *best, long *nom,
 				temp >>= 1;
 			}
 			h = ((14318 * n) / temp) >> s;
-			if (abs(h - freq) < abs(*best - freq)) {
-				*best = h;
+			h = h > freq ? h - freq : freq - h;
+			if (h < diff) {
+				diff = h;
 				*nom = n;
 				*den = temp;
 				*div = s;
@@ -2975,8 +2966,9 @@ static void bestclock(long freq, long *best, long *nom,
 				d >>= 1;
 			}
 			h = ((14318 * n) / d) >> s;
-			if (abs(h - freq) < abs(*best - freq)) {
-				*best = h;
+			h = h > freq ? h - freq : freq - h;
+			if (h < diff) {
+				diff = h;
 				*nom = n;
 				*den = d;
 				*div = s;
@@ -2985,7 +2977,7 @@ static void bestclock(long freq, long *best, long *nom,
 	}
 
 	DPRINTK("Best possible values for given frequency:\n");
-	DPRINTK("	best: %ld kHz  nom: %ld  den: %ld  div: %ld\n",
+	DPRINTK("	freq: %ld kHz  nom: %d  den: %d  div: %d\n",
 		freq, *nom, *den, *div);
 
 	DPRINTK("EXIT\n");
-- 
1.5.2.2


---------------------------------------------------------------
Nasilaja sie kradzieze.
Mieszkancy osiedli zaniepokojeni.
Prosimy o pomoc w tej sprawie >>> http://link.interia.pl/f1eef



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
