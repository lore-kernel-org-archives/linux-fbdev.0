From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH 1/3] cirrusfb: add __devinit attribute
	to probing functions
Date: Wed, 3 Sep 2008 21:21:45 +0200
Message-ID: <20080903212145.b67a2739.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Kaxoc-0006Yh-Mj for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 03 Sep 2008 12:14:54 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Kaxoc-0005In-1v
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 03 Sep 2008 12:14:54 -0700
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

Add __devinit attribute to probing functions.
This fixed section mismatch warning from my
previous patch.

Kill one redundant forward declaration.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 drivers/video/cirrusfb.c |   18 +++++++-----------
 1 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
index 4c16b68..4e34a68 100644
--- a/drivers/video/cirrusfb.c
+++ b/drivers/video/cirrusfb.c
@@ -417,10 +417,6 @@ static struct fb_ops cirrusfb_ops = {
 	.fb_imageblit	= cirrusfb_imageblit,
 };
 
-/*--- Hardware Specific Routines -------------------------------------------*/
-static int cirrusfb_decode_var(const struct fb_var_screeninfo *var,
-				struct cirrusfb_regs *regs,
-				struct fb_info *info);
 /*--- Internal routines ----------------------------------------------------*/
 static void init_vgachip(struct fb_info *info);
 static void switch_monitor(struct cirrusfb_info *cinfo, int on);
@@ -2020,7 +2016,7 @@ static int release_io_ports;
  * based on the DRAM bandwidth bit and DRAM bank switching bit.  This
  * works with 1MB, 2MB and 4MB configurations (which the Motorola boards
  * seem to have. */
-static unsigned int cirrusfb_get_memsize(u8 __iomem *regbase)
+static unsigned int __devinit cirrusfb_get_memsize(u8 __iomem *regbase)
 {
 	unsigned long mem;
 	unsigned char SRF;
@@ -2117,7 +2113,7 @@ static void __devexit cirrusfb_zorro_unmap(struct fb_info *info)
 }
 #endif /* CONFIG_ZORRO */
 
-static int cirrusfb_set_fbinfo(struct fb_info *info)
+static int __devinit cirrusfb_set_fbinfo(struct fb_info *info)
 {
 	struct cirrusfb_info *cinfo = info->par;
 	struct fb_var_screeninfo *var = &info->var;
@@ -2161,7 +2157,7 @@ static int cirrusfb_set_fbinfo(struct fb_info *info)
 	return 0;
 }
 
-static int cirrusfb_register(struct fb_info *info)
+static int __devinit cirrusfb_register(struct fb_info *info)
 {
 	struct cirrusfb_info *cinfo = info->par;
 	int err;
@@ -2232,8 +2228,8 @@ static void __devexit cirrusfb_cleanup(struct fb_info *info)
 }
 
 #ifdef CONFIG_PCI
-static int cirrusfb_pci_register(struct pci_dev *pdev,
-				  const struct pci_device_id *ent)
+static int __devinit cirrusfb_pci_register(struct pci_dev *pdev,
+					   const struct pci_device_id *ent)
 {
 	struct cirrusfb_info *cinfo;
 	struct fb_info *info;
@@ -2360,8 +2356,8 @@ static struct pci_driver cirrusfb_pci_driver = {
 #endif /* CONFIG_PCI */
 
 #ifdef CONFIG_ZORRO
-static int cirrusfb_zorro_register(struct zorro_dev *z,
-				   const struct zorro_device_id *ent)
+static int __devinit cirrusfb_zorro_register(struct zorro_dev *z,
+					     const struct zorro_device_id *ent)
 {
 	struct cirrusfb_info *cinfo;
 	struct fb_info *info;
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
