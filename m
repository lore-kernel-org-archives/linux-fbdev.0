From: akpm@osdl.org
Subject: pm_message_t-fix-for-radeon_pmc.patch added to -mm tree
Date: Mon, 23 May 2005 16:19:14 -0700
Message-ID: <200505232318.j4NNIPE7025943@shell0.pdx.osdl.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DaMBw-0006YP-64
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 23 May 2005 16:18:36 -0700
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DaMBs-0003QJ-8b
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 23 May 2005 16:18:36 -0700
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
To: brix@gentoo.org, benh@kernel.crashing.org, linux-fbdev-devel@lists.sourceforge.net, mm-commits@vger.kernel.org


The patch titled

     pm_message_t fix for radeon_pm.c

has been added to the -mm tree.  Its filename is

     pm_message_t-fix-for-radeon_pmc.patch

Patches currently in -mm which might be from brix@gentoo.org are

pm_message_t-fix-for-radeon_pmc.patch



From: Henrik Brix Andersen <brix@gentoo.org>

This patch adds a missing .event to pm_message_t handling in
drivers/video/aty/radeon_pm.c

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: <linux-fbdev-devel@lists.sourceforge.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/video/aty/radeon_pm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/video/aty/radeon_pm.c~pm_message_t-fix-for-radeon_pmc drivers/video/aty/radeon_pm.c
--- 25/drivers/video/aty/radeon_pm.c~pm_message_t-fix-for-radeon_pmc	Mon May 23 16:18:46 2005
+++ 25-akpm/drivers/video/aty/radeon_pm.c	Mon May 23 16:18:46 2005
@@ -2526,11 +2526,11 @@ int radeonfb_pci_suspend(struct pci_dev 
         struct radeonfb_info *rinfo = info->par;
 	int i;
 
-	if (state == pdev->dev.power.power_state)
+	if (state.event == pdev->dev.power.power_state.event)
 		return 0;
 
 	printk(KERN_DEBUG "radeonfb (%s): suspending to state: %d...\n",
-	       pci_name(pdev), state);
+	       pci_name(pdev), state.event);
 
 	/* For suspend-to-disk, we cheat here. We don't suspend anything and
 	 * let fbcon continue drawing until we are all set. That shouldn't
_


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
