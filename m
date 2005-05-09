From: akpm@osdl.org
Subject: patch bring-back-tux-on-chips-65550-framebuffer.patch added to -mm tree
Date: Mon,  9 May 2005 16:38:52 -0700
Message-ID: <200505092338.j49NcDnW016024@shell0.pdx.osdl.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DVHpW-000426-QK
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 09 May 2005 16:38:30 -0700
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DVHpW-0000Rn-6w
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 09 May 2005 16:38:30 -0700
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
To: keenanpepper@gmail.com, linux-fbdev-devel@lists.sourceforge.net


This is a note to let you know that I've just added the patch titled

     Bring back Tux on Chips 65550 framebuffer

to the -mm tree.  Its filename is

     bring-back-tux-on-chips-65550-framebuffer.patch

Patches currently in -mm which might be from keenanpepper@gmail.com are

bring-back-tux-on-chips-65550-framebuffer.patch



From: Keenan Pepper <keenanpepper@gmail.com>

I don't see any reason why the framebuffer should need to be cleared, 
and it makes Tux vanish.

Cc: <linux-fbdev-devel@lists.sourceforge.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/video/chipsfb.c |    3 ---
 1 files changed, 3 deletions(-)

diff -puN drivers/video/chipsfb.c~bring-back-tux-on-chips-65550-framebuffer drivers/video/chipsfb.c
--- 25/drivers/video/chipsfb.c~bring-back-tux-on-chips-65550-framebuffer	Mon May  9 16:38:24 2005
+++ 25-akpm/drivers/video/chipsfb.c	Mon May  9 16:38:24 2005
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
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
