From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] convert sticore.c to PCI ROM API
	(bugzilla #9425)
Date: Sun, 1 Jun 2008 09:03:38 +0200
Message-ID: <20080601090338.515be7d1.krzysztof.h1@poczta.fm>
References: <20080531191516.ae60240f.krzysztof.h1@poczta.fm>
	<200806010022.24033.deller@gmx.de>
	<20080601010155.6ec18fb7.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K2hZZ-00007l-5k for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 01 Jun 2008 00:01:45 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K2hZW-0004Kw-3n
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 01 Jun 2008 00:01:45 -0700
In-Reply-To: <20080601010155.6ec18fb7.krzysztof.h1@poczta.fm>
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
To: Helge Deller <deller@gmx.de>, Andrew Morton <akpm@linux-foundation.org>
Cc: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, jsimmons@infradead.org, adaplas@gmail.com, protasnb@gmail.com, linux-parisc@vger.kernel.org

On Sun, 1 Jun 2008 01:01:55 +0200
Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:

> On Sun, 1 Jun 2008 00:22:23 +0200
> Helge Deller <deller@gmx.de> wrote:
> 
>> Thanks for the patch.
>> Below is the fixed version for parisc.
>> Compile- and run-tested by me.
>> Please apply.
> 
> Thank you for testing. I have only one question. Why does the address
> parameter to the sti_try_rom_generic() is unsigned long and not (char __iomem *)?
> It would simplify the code (two type casts removed). Now, I see that I have made
> an error in the patch that no rom_base variable has been defined in 
> the sti_try_rom_generic(). My intention was to use the address parameter directly.
> Is this ok (change the parameter type) on parisc linux?
> 

It was late night when I answered. I see it now - one uses gsc_readl function
on the address so one needs the address represented as unsigned long (or casted).

Your patch is 100% correct (copied without changes below).

Regards,
Krzysztof

------------------------

Convert console/sticore.c file to use PCI ROM API.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Signed-off-by: Helge Deller <deller@gmx.de>

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
Za co Doda nienawidzi Feel?
Sprawdz >>> http://link.interia.pl/f1e0b


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
