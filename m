From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH 2/2] tdfxfb: fix frame buffer name
	overrun
Date: Wed, 27 Aug 2008 21:07:39 +0200
Message-ID: <20080827210739.21936b36.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KYQGb-0005pR-4R for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 Aug 2008 12:01:17 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KYQGZ-0002he-D1
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 Aug 2008 12:01:16 -0700
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

If there are more then one graphics card handled 
by the tdfxfb driver the name of the frame buffer 
overruns reserved name size.
---
This also is good candidate for 2.6.27 fix.

 drivers/video/tdfxfb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/tdfxfb.c b/drivers/video/tdfxfb.c
index fa7cbec..ed86ef3 100644
--- a/drivers/video/tdfxfb.c
+++ b/drivers/video/tdfxfb.c
@@ -95,7 +95,6 @@ static inline int mtrr_del(int reg, unsigned long base,
 #define VOODOO5_MAX_PIXCLOCK 350000
 
 static struct fb_fix_screeninfo tdfx_fix __devinitdata = {
-	.id =		"3Dfx",
 	.type =		FB_TYPE_PACKED_PIXELS,
 	.visual =	FB_VISUAL_PSEUDOCOLOR,
 	.ypanstep =	1,
@@ -1196,6 +1195,7 @@ static int __devinit tdfxfb_probe(struct pci_dev *pdev,
 		return -ENOMEM;
 
 	default_par = info->par;
+	strcpy(tdfx_fix.id, "3Dfx");
 
 	/* Configure the default fb_fix_screeninfo first */
 	switch (pdev->device) {
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
