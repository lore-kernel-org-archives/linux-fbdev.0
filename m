From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH 1/2] tdfxfb: fix SDRAM memory size
	detection
Date: Wed, 27 Aug 2008 21:07:20 +0200
Message-ID: <20080827210720.535b19b0.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KYQGU-0005pF-ON for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 Aug 2008 12:01:10 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KYQGT-0002dT-3y
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 Aug 2008 12:01:10 -0700
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

Fix memory detection on Voodoo3 cards
with SDRAM memory.
---
This is good candidate for 2.6.27 fix.

 drivers/video/tdfxfb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/tdfxfb.c b/drivers/video/tdfxfb.c
index 77aafcf..fa7cbec 100644
--- a/drivers/video/tdfxfb.c
+++ b/drivers/video/tdfxfb.c
@@ -426,7 +426,7 @@ static unsigned long do_lfb_size(struct tdfx_par *par, unsigned short dev_id)
 	if (dev_id < PCI_DEVICE_ID_3DFX_VOODOO5) {
 		/* Banshee/Voodoo3 */
 		chip_size = 2;
-		if (has_sgram && (draminit0 & DRAMINIT0_SGRAM_TYPE))
+		if (has_sgram && !(draminit0 & DRAMINIT0_SGRAM_TYPE))
 			chip_size = 1;
 	} else {
 		/* Voodoo4/5 */
-- 
1.5.2.2



----------------------------------------------------------------------
>> Sprawdz, czy do siebie pasujecie!
>> http://link.interia.pl/f1eea


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
