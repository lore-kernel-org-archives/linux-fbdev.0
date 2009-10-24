From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] add palette register check
Date: Sat, 24 Oct 2009 17:18:23 +0200
Message-ID: <20091024171823.27896031.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1N1i7N-0005TK-Tc
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 24 Oct 2009 15:01:21 +0000
Received: from smtp240.poczta.interia.pl ([217.74.64.240])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N1i7I-0000sr-3c for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 24 Oct 2009 15:01:21 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@linux-foundation.org>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Add check if palette register number is in correct range
for few drivers which miss it. The regno value comes
indirectly from user space.

Two drivers has converted check from BUG_ON() macro
to just return an error (non-zero value).

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

diff --git a/drivers/video/atafb.c b/drivers/video/atafb.c
index 8cd279b..2682938 100644
--- a/drivers/video/atafb.c
+++ b/drivers/video/atafb.c
@@ -2248,6 +2248,9 @@ static int ext_setcolreg(unsigned int regno, unsigned int red,
 	if (!external_vgaiobase)
 		return 1;
 
+	if (regno > 255)
+		return 1;
+
 	switch (external_card_type) {
 	case IS_VGA:
 		OUTB(0x3c8, regno);
diff --git a/drivers/video/ep93xx-fb.c b/drivers/video/ep93xx-fb.c
index bd9d46f..27aab4a 100644
--- a/drivers/video/ep93xx-fb.c
+++ b/drivers/video/ep93xx-fb.c
@@ -358,6 +358,8 @@ static int ep93xxfb_setcolreg(unsigned int regno, unsigned int red,
 
 	switch (info->fix.visual) {
 	case FB_VISUAL_PSEUDOCOLOR:
+		if (regno > 255)
+			return 1;
 		rgb = ((red & 0xff00) << 8) | (green & 0xff00) |
 			((blue & 0xff00) >> 8);
 
diff --git a/drivers/video/maxinefb.c b/drivers/video/maxinefb.c
index 5e91c2b..7854c7a 100644
--- a/drivers/video/maxinefb.c
+++ b/drivers/video/maxinefb.c
@@ -92,6 +92,9 @@ static int maxinefb_setcolreg(unsigned regno, unsigned red, unsigned green,
 	/* value to be written into the palette reg. */
 	unsigned long hw_colorvalue = 0;
 
+	if (regno > 255)
+		return 1;
+
 	red   >>= 8;    /* The cmap fields are 16 bits    */
 	green >>= 8;    /* wide, but the harware colormap */
 	blue  >>= 8;    /* registers are only 8 bits wide */
diff --git a/drivers/video/pmag-ba-fb.c b/drivers/video/pmag-ba-fb.c
index 0573ec6..0f361b6 100644
--- a/drivers/video/pmag-ba-fb.c
+++ b/drivers/video/pmag-ba-fb.c
@@ -98,7 +98,8 @@ static int pmagbafb_setcolreg(unsigned int regno, unsigned int red,
 {
 	struct pmagbafb_par *par = info->par;
 
-	BUG_ON(regno >= info->cmap.len);
+	if (regno >= info->cmap.len)
+		return 1;
 
 	red   >>= 8;	/* The cmap fields are 16 bits    */
 	green >>= 8;	/* wide, but the hardware colormap */
diff --git a/drivers/video/pmagb-b-fb.c b/drivers/video/pmagb-b-fb.c
index 9874872..2de0806 100644
--- a/drivers/video/pmagb-b-fb.c
+++ b/drivers/video/pmagb-b-fb.c
@@ -102,7 +102,8 @@ static int pmagbbfb_setcolreg(unsigned int regno, unsigned int red,
 {
 	struct pmagbbfb_par *par = info->par;
 
-	BUG_ON(regno >= info->cmap.len);
+	if (regno >= info->cmap.len)
+		return 1;
 
 	red   >>= 8;	/* The cmap fields are 16 bits    */
 	green >>= 8;	/* wide, but the hardware colormap */

 
----------------------------------------------------------------------
Nie dla nich ciepla praca za biurkiem.
Sprawdz >>> http://link.interia.pl/f2383


------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
