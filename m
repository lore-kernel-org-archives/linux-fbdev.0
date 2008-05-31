From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] convert sticore.c to PCI ROM API (bugzilla #9425)
Date: Sat, 31 May 2008 19:15:16 +0200
Message-ID: <20080531191516.ae60240f.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
Sender: linux-parisc-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: linux-parisc@vger.kernel.org, Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: adaplas@gmail.com, protasnb@gmail.com, jsimmons@infradead.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Convert console/sticore.c file to use PCI ROM API.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---
I don't have cross-compiler nor the hardware so PARISC guys
please test it.

diff -urp linux-2.6.25/drivers/video/console/sticore.c linux-new/drivers/video/console/sticore.c
--- linux-2.6.25/drivers/video/console/sticore.c	2008-04-17 04:49:44.000000000 +0200
+++ linux-new/drivers/video/console/sticore.c	2008-05-31 14:47:14.794107818 +0200
@@ -780,7 +780,8 @@ out_err:
 }
 
 static struct sti_struct * __devinit
-sti_try_rom_generic(unsigned long address, unsigned long hpa, struct pci_dev *pd)
+sti_try_rom_generic(char __iomem *address, unsigned long hpa,
+		    struct pci_dev *pd)
 {
 	struct sti_struct *sti;
 	int ok;
@@ -868,10 +869,8 @@ test_rom:
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
 
@@ -930,22 +929,22 @@ static int __devinit sticore_pci_init(st
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
+	rom_base = pci_map_rom(pd, &rom_len);
 	if (rom_base) {
-		pci_write_config_dword(pd, PCI_ROM_ADDRESS, rom_base | PCI_ROM_ADDRESS_ENABLE);
-		DPRINTK((KERN_DEBUG "STI PCI ROM enabled at 0x%08lx\n", rom_base));
+		DPRINTK((KERN_DEBUG "STI PCI ROM enabled at 0x%p\n", rom_base));
 	}
 
-	printk(KERN_INFO "STI PCI graphic ROM found at %08lx (%u kB), fb at %08lx (%u MB)\n",
+	printk(KERN_INFO "STI PCI graphic ROM found at %p (%u kB), fb at %08lx (%u MB)\n",
 		rom_base, rom_len/1024, fb_base, fb_len/1024/1024);
 
 	DPRINTK((KERN_DEBUG "Trying PCI STI ROM at %08lx, PCI hpa at %08lx\n",



----------------------------------------------------------------------
Podbij Dziki Zachod!Gra strategiczna online
Sprawdz >>> http://link.interia.pl/f1dff

