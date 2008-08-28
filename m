From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH 4/4] cirrusfb: drop device pointers from
	cirrusfb_info
Date: Thu, 28 Aug 2008 22:15:16 +0200
Message-ID: <20080828221516.e34f982d.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KYnnU-0005kg-Tp for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 28 Aug 2008 13:08:48 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KYnnU-0001bn-IA
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 28 Aug 2008 13:08:48 -0700
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

The device pointer can be easily obtained
from fb_info->device if needed.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 drivers/video/cirrusfb.c |   20 ++++++--------------
 1 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
index 4888ff6..0eb429a 100644
--- a/drivers/video/cirrusfb.c
+++ b/drivers/video/cirrusfb.c
@@ -367,15 +367,8 @@ struct cirrusfb_info {
 
 	struct cirrusfb_regs currentmode;
 	int blank_mode;
+	u32 pseudo_palette[16];
 
-	u32	pseudo_palette[16];
-
-#ifdef CONFIG_ZORRO
-	struct zorro_dev *zdev;
-#endif
-#ifdef CONFIG_PCI
-	struct pci_dev *pdev;
-#endif
 	void (*unmap)(struct fb_info *info);
 };
 
@@ -2183,8 +2176,7 @@ static void get_pci_addrs(const struct pci_dev *pdev,
 
 static void cirrusfb_pci_unmap(struct fb_info *info)
 {
-	struct cirrusfb_info *cinfo = info->par;
-	struct pci_dev *pdev = cinfo->pdev;
+	struct pci_dev *pdev = to_pci_dev(info->device);
 
 	iounmap(info->screen_base);
 #if 0 /* if system didn't claim this region, we would... */
@@ -2200,14 +2192,16 @@ static void cirrusfb_pci_unmap(struct fb_info *info)
 static void __devexit cirrusfb_zorro_unmap(struct fb_info *info)
 {
 	struct cirrusfb_info *cinfo = info->par;
-	zorro_release_device(cinfo->zdev);
+	struct zorro_dev *zdev = to_zorro_dev(info->device);
+
+	zorro_release_device(zdev);
 
 	if (cinfo->btype == BT_PICASSO4) {
 		cinfo->regbase -= 0x600000;
 		iounmap((void *)cinfo->regbase);
 		iounmap(info->screen_base);
 	} else {
-		if (zorro_resource_start(cinfo->zdev) > 0x01000000)
+		if (zorro_resource_start(zdev) > 0x01000000)
 			iounmap(info->screen_base);
 	}
 }
@@ -2348,7 +2342,6 @@ static int cirrusfb_pci_register(struct pci_dev *pdev,
 	}
 
 	cinfo = info->par;
-	cinfo->pdev = pdev;
 	cinfo->btype = btype = (enum cirrus_board) ent->driver_data;
 
 	DPRINTK(" Found PCI device, base address 0 is 0x%x, btype set to %d\n",
@@ -2484,7 +2477,6 @@ static int cirrusfb_zorro_register(struct zorro_dev *z,
 	assert(z);
 	assert(btype != BT_NONE);
 
-	cinfo->zdev = z;
 	board_addr = zorro_resource_start(z);
 	board_size = zorro_resource_len(z);
 	info->screen_size = size;
-- 
1.5.2.2


----------------------------------------------------------------------
Tylko u nas - swieza krew w rozsadnych cenach!
>> http://link.interia.pl/f1eed


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
