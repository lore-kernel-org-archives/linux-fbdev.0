From: Ville Syrjala <syrjala@sci.fi>
Subject: [PATCH] atyfb: correct_chipset() can fail
Date: Wed,  4 Jun 2008 12:14:22 +0300
Message-ID: <1212570865-31419-4-git-send-email-syrjala@sci.fi>
References: <1212570865-31419-1-git-send-email-syrjala@sci.fi>
	<1212570865-31419-2-git-send-email-syrjala@sci.fi>
	<1212570865-31419-3-git-send-email-syrjala@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K3p4k-0008IL-Rq for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 04 Jun 2008 02:14:35 -0700
Received: from smtp5.pp.htv.fi ([213.243.153.39])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K3p4k-0003Vf-AL
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 04 Jun 2008 02:14:34 -0700
In-Reply-To: <1212570865-31419-3-git-send-email-syrjala@sci.fi>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: akpm@linux-foundation.org, Ville Syrjala <syrjala@sci.fi>, adaplas@gmail.com

Atari probe code relies on correct_chipset() failing if the device is
not a mach64 GX/CX. aty_chips[] array would be indexed with -1 in that
case.

Signed-off-by: Ville Syrjala <syrjala@sci.fi>
---
 drivers/video/aty/atyfb_base.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
index d7ba3f1..d6903c7 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -424,7 +424,6 @@ static struct {
 #endif /* CONFIG_FB_ATY_CT */
 };
 
-/* can not fail */
 static int __devinit correct_chipset(struct atyfb_par *par)
 {
 	u8 rev;
@@ -437,6 +436,9 @@ static int __devinit correct_chipset(struct atyfb_par *par)
 		if (par->pci_id == aty_chips[i].pci_id)
 			break;
 
+	if (i < 0)
+		return -ENODEV;
+
 	name = aty_chips[i].name;
 	par->pll_limits.pll_max = aty_chips[i].pll;
 	par->pll_limits.mclk = aty_chips[i].mclk;
-- 
1.5.3.7


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
