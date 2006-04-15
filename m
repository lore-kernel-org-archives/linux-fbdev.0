From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: [PATCH] radeonfb section mismatches
Date: Fri, 14 Apr 2006 21:25:30 -0700
Message-ID: <20060414212530.0140b70f.rdunlap@xenotime.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FUcJM-0001uf-Po
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 14 Apr 2006 21:23:04 -0700
Received: from xenotime.net ([66.160.160.81])
	by mail.sourceforge.net with smtp (Exim 4.44)
	id 1FUcJM-000638-FT
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 14 Apr 2006 21:23:04 -0700
Received: from midway.site ([71.111.157.99]) by xenotime.net for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 14 Apr 2006 21:23:02 -0700
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
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: adaplas@pol.net, benh@kernel.crashing.org, akpm <akpm@osdl.org>

From: Randy Dunlap <rdunlap@xenotime.net>

Marking radeon_pci_register() as __devinit clears up all section
mismatch warnings that are caused by radeon_pci_register() calling
various __devinit function.  Is there some reason not to do this?

WARNING: drivers/video/aty/radeonfb.o - Section mismatch: reference to .init.text: from .text.radeonfb_pci_register after 'radeonfb_pci_register' (at offset 0x628)
WARNING: drivers/video/aty/radeonfb.o - Section mismatch: reference to .init.text: from .text.radeonfb_pci_register after 'radeonfb_pci_register' (at offset 0x6b5)
WARNING: drivers/video/aty/radeonfb.o - Section mismatch: reference to .init.text: from .text.radeonfb_pci_register after 'radeonfb_pci_register' (at offset 0x6bd)
WARNING: drivers/video/aty/radeonfb.o - Section mismatch: reference to .init.text:radeon_probe_screens from .text.radeonfb_pci_register after 'radeonfb_pci_register' (at offset 0x7d6)
WARNING: drivers/video/aty/radeonfb.o - Section mismatch: reference to .init.text:radeon_check_modes from .text.radeonfb_pci_register after 'radeonfb_pci_register' (at offset 0x7e5)

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/video/aty/radeon_base.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2617-rc1g8.orig/drivers/video/aty/radeon_base.c
+++ linux-2617-rc1g8/drivers/video/aty/radeon_base.c
@@ -2265,7 +2265,7 @@ static struct bin_attribute edid2_attr =
 };
 
 
-static int radeonfb_pci_register (struct pci_dev *pdev,
+static int __devinit radeonfb_pci_register (struct pci_dev *pdev,
 				  const struct pci_device_id *ent)
 {
 	struct fb_info *info;


---


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
