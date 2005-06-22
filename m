From: akpm@osdl.org
Subject: [patch 127/167] Bring back Tux on Chips 65550 framebuffer
Date: Tue, 21 Jun 2005 17:16:54 -0700
Message-ID: <200506220017.j5M0HDwD008062@shell0.pdx.osdl.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dksve-0001YO-TU
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 21 Jun 2005 17:17:18 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1Dksve-0007Ug-Dr
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 21 Jun 2005 17:17:18 -0700
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
To: torvalds@osdl.org
Cc: akpm@osdl.org, keenanpepper@gmail.com, linux-fbdev-devel@lists.sourceforge.net


From: Keenan Pepper <keenanpepper@gmail.com>

I don't see any reason why the framebuffer should need to be cleared, 
and it makes Tux vanish.

Cc: <linux-fbdev-devel@lists.sourceforge.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/video/chipsfb.c |    3 ---
 1 files changed, 3 deletions(-)

diff -puN drivers/video/chipsfb.c~bring-back-tux-on-chips-65550-framebuffer drivers/video/chipsfb.c
--- 25/drivers/video/chipsfb.c~bring-back-tux-on-chips-65550-framebuffer	2005-06-21 16:45:51.000000000 -0700
+++ 25-akpm/drivers/video/chipsfb.c	2005-06-21 16:45:51.000000000 -0700
@@ -423,9 +423,6 @@ chipsfb_pci_init(struct pci_dev *dp, con
 	pmu_register_sleep_notifier(&chips_sleep_notifier);
 #endif /* CONFIG_PMAC_PBOOK */
 
-	/* Clear the entire framebuffer */
-	memset(p->screen_base, 0, 0x100000);
-
 	pci_set_drvdata(dp, p);
 	return 0;
 }
_


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
