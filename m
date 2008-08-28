From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH 1/4] cirrusfb: remove information about
 memory size during mode change
Date: Thu, 28 Aug 2008 22:09:57 +0200
Message-ID: <20080828220957.06d1f08a.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KYniQ-0005H2-ED for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 28 Aug 2008 13:03:34 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KYniP-0005co-0b
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 28 Aug 2008 13:03:34 -0700
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

Remove information about memory size displayed
twice each time a display mode change.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 drivers/video/cirrusfb.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
index c14b243..66e768d 100644
--- a/drivers/video/cirrusfb.c
+++ b/drivers/video/cirrusfb.c
@@ -1972,8 +1972,6 @@ static void init_vgachip(struct fb_info *info)
 	/* misc... */
 	WHDR(cinfo, 0);	/* Hidden DAC register: - */
 
-	printk(KERN_DEBUG "cirrusfb: This board has %ld bytes of DRAM memory\n",
-		info->screen_size);
 	DPRINTK("EXIT\n");
 	return;
 }
-- 
1.5.2.2


----------------------------------------------------------------------
Tani telefon!
Sprawdz >>> http://link.interia.pl/f1ef5 



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
