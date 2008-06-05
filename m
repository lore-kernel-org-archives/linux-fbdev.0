From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [RESEND] [PATCH] convert sticore.c to PCI ROM
	API
Date: Thu, 5 Jun 2008 23:13:27 +0200
Message-ID: <20080605231327.af9cc9e6.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K4Mjp-0002FQ-5Q for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 05 Jun 2008 14:11:13 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K4Mjo-0006EO-BY
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 05 Jun 2008 14:11:13 -0700
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
Cc: Andrew Morton <akpm@linux-foundation.org>, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Convert console/sticore.c file to use PCI ROM API.

Addresses http://bugzilla.kernel.org/show_bug.cgi?id=9425

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Signed-off-by: Helge Deller <deller@gmx.de>

---
This patch was fixed and tested by Helge Deller on his
PARISC machine.


diff --git a/drivers/video/console/sticore.c b/drivers/video/console/sticore.c
index e9ab657..df30499 100644
--- a/drivers/video/console/sticore.c
+++ b/drivers/video/console/sticore.c
@@ -780,11 +780,13 @@ out_err:
 }
 
 static struct sti_struct * __devinit
-sti_try_rom_generic(unsigned long address, unsigned long hpa, struct pci_dev *pd)
+sti_try_rom_generic(unsigned long address, unsigned long hpa,
+		    struct pci_dev *pd)
 {
+	char __iomem *rom_base = (char __iomem *) address;
 	struct sti_struct *sti;
 	int ok;
-	u32 sig;
+	__le32 sig;
 
 	if (num_sti_roms >= MAX_STI_ROMS) {
 		printk(KERN_WARNING "maximum number of STI ROMS reached !\n");
@@ -808,7 +810,7 @@ test_rom:
 	sig = gsc_readl(address);
 
 	/* check for a PCI ROM structure */
-	if ((le32_to_cpu(sig)==0xaa55)) {
+	if (sig == cpu_to_le32(0xaa55)) {
 		unsigned int i, rm_offset;
 		u32 *rm;
 		i = gsc_readl(address+0x04);
@@ -868,10 +870,8 @@ test_rom:
 	/* disable STI PCI ROM. ROM and card RAM overlap and
 	 * leaving it enabled would force HPMCs
 	 */
-	if (sti->pd) {
-		unsigned long rom_base;
-		rom_base = pci_resource_start(sti->pd, PCI_ROM_RESOURCE);	
-		pci_write_config_dword(sti->pd, PCI_ROM_ADDRESS, rom_base & ~PCI_ROM_ADDRESS_ENABLE);
+	if (sti->pd && rom_base) {
+		pci_unmap_rom(sti->pd, rom_base);
 		DPRINTK((KERN_DEBUG "STI PCI ROM disabled\n"));
 	}
 
@@ -930,28 +930,25 @@ static int __devinit sticore_pci_init(struct pci_dev *pd,
 		const struct pci_device_id *ent)
 {
 #ifdef CONFIG_PCI
-	unsigned long fb_base, rom_base;
-	unsigned int fb_len, rom_len;
+	unsigned long fb_base;
+	unsigned int fb_len;
+	char __iomem *rom_base;
+	size_t rom_len;
 	struct sti_struct *sti;
 	
 	pci_enable_device(pd);
 
 	fb_base = pci_resource_start(pd, 0);
 	fb_len = pci_resource_len(pd, 0);
-	rom_base = pci_resource_start(pd, PCI_ROM_RESOURCE);
-	rom_len = pci_resource_len(pd, PCI_ROM_RESOURCE);
-	if (rom_base) {
-		pci_write_config_dword(pd, PCI_ROM_ADDRESS, rom_base | PCI_ROM_ADDRESS_ENABLE);
-		DPRINTK((KERN_DEBUG "STI PCI ROM enabled at 0x%08lx\n", rom_base));
-	}
+	rom_base = pci_map_rom(pd, &rom_len);
 
-	printk(KERN_INFO "STI PCI graphic ROM found at %08lx (%u kB), fb at %08lx (%u MB)\n",
+	printk(KERN_INFO "STI PCI graphic ROM found at %p (%u kB), fb at %08lx (%u MB)\n",
 		rom_base, rom_len/1024, fb_base, fb_len/1024/1024);
 
-	DPRINTK((KERN_DEBUG "Trying PCI STI ROM at %08lx, PCI hpa at %08lx\n",
+	DPRINTK((KERN_DEBUG "Trying PCI STI ROM at %p, PCI hpa at %08lx\n",
 		    rom_base, fb_base));
 
-	sti = sti_try_rom_generic(rom_base, fb_base, pd);
+	sti = sti_try_rom_generic((unsigned long)rom_base, fb_base, pd);
 	if (sti) {
 		char pa_path[30];
 		print_pci_hwpath(pd, pa_path);
@@ -975,7 +972,7 @@ static void __devexit sticore_pci_remove(struct pci_dev *pd)
 }
 
 
-static struct pci_device_id sti_pci_tbl[] = {
+DEFINE_PCI_DEVICE_TABLE(sti_pci_tbl) = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_VISUALIZE_EG) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_VISUALIZE_FX6) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_VISUALIZE_FX4) },




----------------------------------------------------------------------
Tanie rozmowy!
Sprawdz >>> http://link.interia.pl/f1e20 



-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
