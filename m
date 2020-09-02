From: Helge Deller <deller@gmx.de>
Date: Wed, 02 Sep 2020 15:39:43 +0000
Subject: [PATCH] parisc/stifb: Convert STI core driver to dynamic printk
Message-Id: <20200902153943.GA16250@ls3530.fritz.box>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-parisc@vger.kernel.org, linux-fbdev@vger.kernel.org, James Bottomley <James.Bottomley@hansenpartnership.com>, John David Anglin <dave.anglin@bell.net>

Convert to dynamic printk - this helps me during development of the STI
emulation for qemu.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/drivers/video/console/sticore.c b/drivers/video/console/sticore.c
index 84c3ca37040a..41b6f2505e16 100644
--- a/drivers/video/console/sticore.c
+++ b/drivers/video/console/sticore.c
@@ -14,6 +14,8 @@
  *
  */

+#define pr_fmt(fmt) "%s: " fmt, KBUILD_MODNAME
+
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
@@ -364,8 +366,7 @@ static void sti_dump_globcfg(struct sti_glob_cfg *glob_cfg,
 {
 	struct sti_glob_cfg_ext *cfg;

-	DPRINTK((KERN_INFO
-		"%d text planes\n"
+	pr_debug("%d text planes\n"
 		"%4d x %4d screen resolution\n"
 		"%4d x %4d offscreen\n"
 		"%4d x %4d layout\n"
@@ -382,13 +383,12 @@ static void sti_dump_globcfg(struct sti_glob_cfg *glob_cfg,
 		glob_cfg->region_ptrs[4], glob_cfg->region_ptrs[5],
 		glob_cfg->region_ptrs[6], glob_cfg->region_ptrs[7],
 		glob_cfg->reent_lvl,
-		glob_cfg->save_addr));
+		glob_cfg->save_addr);

 	/* dump extended cfg */
 	cfg = PTR_STI((unsigned long)glob_cfg->ext_ptr);
-	DPRINTK(( KERN_INFO
-		"monitor %d\n"
-		"in friendly mode: %d\n"
+	pr_debug("monitor %d\n"
+		"   in friendly mode: %d\n"
 		"power consumption %d watts\n"
 		"freq ref %d\n"
 		"sti_mem_addr %08x (size=%d bytes)\n",
@@ -396,20 +396,19 @@ static void sti_dump_globcfg(struct sti_glob_cfg *glob_cfg,
 		cfg->friendly_boot,
 		cfg->power,
 		cfg->freq_ref,
-		cfg->sti_mem_addr, sti_mem_request));
+		cfg->sti_mem_addr, sti_mem_request);
 }

 static void sti_dump_outptr(struct sti_struct *sti)
 {
-	DPRINTK((KERN_INFO
-		"%d bits per pixel\n"
+	pr_debug("%d bits per pixel\n"
 		"%d used bits\n"
 		"%d planes\n"
 		"attributes %08x\n",
 		 sti->sti_data->inq_outptr.bits_per_pixel,
 		 sti->sti_data->inq_outptr.bits_used,
 		 sti->sti_data->inq_outptr.planes,
-		 sti->sti_data->inq_outptr.attributes));
+		 sti->sti_data->inq_outptr.attributes);
 }

 static int sti_init_glob_cfg(struct sti_struct *sti, unsigned long rom_address,
@@ -448,8 +447,7 @@ static int sti_init_glob_cfg(struct sti_struct *sti, unsigned long rom_address,
 			if (offs != PCI_ROM_ADDRESS &&
 			    (offs < PCI_BASE_ADDRESS_0 ||
 			     offs > PCI_BASE_ADDRESS_5)) {
-				printk (KERN_WARNING
-					"STI pci region mapping for region %d (%02x) can't be mapped\n",
+				pr_warn("STI pci region mapping for region %d (%02x) can't be mapped\n",
 					i,sti->rm_entry[i]);
 				continue;
 			}
@@ -464,14 +462,14 @@ static int sti_init_glob_cfg(struct sti_struct *sti, unsigned long rom_address,
 		if (len)
 			glob_cfg->region_ptrs[i] = sti->regions_phys[i];

-		DPRINTK(("region #%d: phys %08lx, region_ptr %08x, len=%lukB, "
+		pr_debug("region #%d: phys %08lx, region_ptr %08x, len=%lukB, "
 			 "btlb=%d, sysonly=%d, cache=%d, last=%d\n",
 			i, sti->regions_phys[i], glob_cfg->region_ptrs[i],
 			len/1024,
 			sti->regions[i].region_desc.btlb,
 			sti->regions[i].region_desc.sys_only,
 			sti->regions[i].region_desc.cache,
-			sti->regions[i].region_desc.last));
+			sti->regions[i].region_desc.last);

 		/* last entry reached ? */
 		if (sti->regions[i].region_desc.last)
@@ -479,8 +477,8 @@ static int sti_init_glob_cfg(struct sti_struct *sti, unsigned long rom_address,
 	}

 	if (++i<8 && sti->regions[i].region)
-		printk(KERN_WARNING "%s: *future ptr (0x%8x) not yet supported !\n",
-				__FILE__, sti->regions[i].region);
+		pr_warn("future ptr (0x%8x) not yet supported !\n",
+			sti->regions[i].region);

 	glob_cfg_ext->sti_mem_addr = STI_PTR(sti_mem_addr);

@@ -580,18 +578,18 @@ static struct sti_cooked_font *sti_select_font(struct sti_cooked_rom *rom,

 static void sti_dump_rom(struct sti_rom *rom)
 {
-	printk(KERN_INFO "    id %04x-%04x, conforms to spec rev. %d.%02x\n",
+	pr_info("  id %04x-%04x, conforms to spec rev. %d.%02x\n",
 		rom->graphics_id[0],
 		rom->graphics_id[1],
 		rom->revno[0] >> 4,
 		rom->revno[0] & 0x0f);
-	DPRINTK(("      supports %d monitors\n", rom->num_mons));
-	DPRINTK(("      font start %08x\n", rom->font_start));
-	DPRINTK(("      region list %08x\n", rom->region_list));
-	DPRINTK(("      init_graph %08x\n", rom->init_graph));
-	DPRINTK(("      bus support %02x\n", rom->bus_support));
-	DPRINTK(("      ext bus support %02x\n", rom->ext_bus_support));
-	DPRINTK(("      alternate code type %d\n", rom->alt_code_type));
+	pr_debug("  supports %d monitors\n", rom->num_mons);
+	pr_debug("  font start %08x\n", rom->font_start);
+	pr_debug("  region list %08x\n", rom->region_list);
+	pr_debug("  init_graph %08x\n", rom->init_graph);
+	pr_debug("  bus support %02x\n", rom->bus_support);
+	pr_debug("  ext bus support %02x\n", rom->ext_bus_support);
+	pr_debug("  alternate code type %d\n", rom->alt_code_type);
 }


@@ -747,7 +745,7 @@ static int sti_read_rom(int wordmode, struct sti_struct *sti,
 		goto out_err;

 	if (!sti_cook_fonts(cooked, raw)) {
-		printk(KERN_ERR "No font found for STI at %08lx\n", address);
+		pr_warn("No font found for STI at %08lx\n", address);
 		goto out_err;
 	}

@@ -804,9 +802,9 @@ static int sti_read_rom(int wordmode, struct sti_struct *sti,
 	return 1;

 msg_not_supported:
-	printk(KERN_ERR "Sorry, this GSC/STI card is not yet supported.\n");
-	printk(KERN_ERR "Please see http://parisc-linux.org/faq/"
-			"graphics-howto.html for more info.\n");
+	pr_warn("Sorry, this GSC/STI card is not yet supported.\n");
+	pr_warn("Please see https://parisc.wiki.kernel.org/"
+		"index.php/Graphics_howto for more info.\n");
 	/* fall through */
 out_err:
 	kfree(raw);
@@ -823,7 +821,7 @@ static struct sti_struct *sti_try_rom_generic(unsigned long address,
 	u32 sig;

 	if (num_sti_roms >= MAX_STI_ROMS) {
-		printk(KERN_WARNING "maximum number of STI ROMS reached !\n");
+		pr_warn("maximum number of STI ROMS reached !\n");
 		return NULL;
 	}

@@ -849,16 +847,15 @@ static struct sti_struct *sti_try_rom_generic(unsigned long address,
 		if (i != 1) {
 			/* The ROM could have multiple architecture
 			 * dependent images (e.g. i386, parisc,...) */
-			printk(KERN_WARNING
-				"PCI ROM is not a STI ROM type image (0x%8x)\n", i);
+			pr_warn("PCI ROM is not a STI ROM type image (0x%8x)\n", i);
 			goto out_err;
 		}

 		sti->pd = pd;

 		i = gsc_readl(address+0x0c);
-		DPRINTK(("PCI ROM size (from header) = %d kB\n",
-			le16_to_cpu(i>>16)*512/1024));
+		pr_debug("PCI ROM size (from header) = %d kB\n",
+			le16_to_cpu(i>>16)*512/1024);
 		rm_offset = le16_to_cpu(i & 0xffff);
 		if (rm_offset) {
 			/* read 16 bytes from the pci region mapper array */
@@ -867,29 +864,28 @@ static struct sti_struct *sti_try_rom_generic(unsigned long address,
 			*rm++ = gsc_readl(address+rm_offset+0x04);
 			*rm++ = gsc_readl(address+rm_offset+0x08);
 			*rm++ = gsc_readl(address+rm_offset+0x0c);
-			DPRINTK(("PCI region Mapper offset = %08x: ",
-				rm_offset));
+			pr_debug("PCI region map offset = %08x: ", rm_offset);
 			for (i=0; i<16; i++)
-				DPRINTK(("%02x ", sti->rm_entry[i]));
-			DPRINTK(("\n"));
+				pr_debug("%02x ", sti->rm_entry[i]);
+			pr_debug("\n");
 		}

 		address += le32_to_cpu(gsc_readl(address+8));
-		DPRINTK(("sig %04x, PCI STI ROM at %08lx\n", sig, address));
+		pr_debug("sig %04x, PCI STI ROM at %08lx\n", sig, address);
 		goto test_rom;
 	}

 	ok = 0;

 	if ((sig & 0xff) == 0x01) {
-		DPRINTK(("    byte mode ROM at %08lx, hpa at %08lx\n",
-		       address, hpa));
+		pr_debug("    byte mode ROM at %08lx, hpa at %08lx\n",
+		       address, hpa);
 		ok = sti_read_rom(0, sti, address);
 	}

 	if ((sig & 0xffff) == 0x0303) {
-		DPRINTK(("    word mode ROM at %08lx, hpa at %08lx\n",
-		       address, hpa));
+		pr_debug("    word mode ROM at %08lx, hpa at %08lx\n",
+		       address, hpa);
 		ok = sti_read_rom(1, sti, address);
 	}

@@ -906,7 +902,7 @@ static struct sti_struct *sti_try_rom_generic(unsigned long address,
 		unsigned long rom_base;
 		rom_base = pci_resource_start(sti->pd, PCI_ROM_RESOURCE);
 		pci_write_config_dword(sti->pd, PCI_ROM_ADDRESS, rom_base & ~PCI_ROM_ADDRESS_ENABLE);
-		DPRINTK((KERN_DEBUG "STI PCI ROM disabled\n"));
+		pr_debug("STI PCI ROM disabled\n");
 	}

 	if (sti_init_graph(sti))
@@ -981,14 +977,14 @@ static int sticore_pci_init(struct pci_dev *pd, const struct pci_device_id *ent)
 	rom_len = pci_resource_len(pd, PCI_ROM_RESOURCE);
 	if (rom_base) {
 		pci_write_config_dword(pd, PCI_ROM_ADDRESS, rom_base | PCI_ROM_ADDRESS_ENABLE);
-		DPRINTK((KERN_DEBUG "STI PCI ROM enabled at 0x%08lx\n", rom_base));
+		pr_debug("STI PCI ROM enabled at 0x%08lx\n", rom_base);
 	}

-	printk(KERN_INFO "STI PCI graphic ROM found at %08lx (%u kB), fb at %08lx (%u MB)\n",
+	pr_info("STI PCI graphic ROM found at %08lx (%u kB), fb at %08lx (%u MB)\n",
 		rom_base, rom_len/1024, fb_base, fb_len/1024/1024);

-	DPRINTK((KERN_DEBUG "Trying PCI STI ROM at %08lx, PCI hpa at %08lx\n",
-		    rom_base, fb_base));
+	pr_debug("Trying PCI STI ROM at %08lx, PCI hpa at %08lx\n",
+		    rom_base, fb_base);

 	sti = sti_try_rom_generic(rom_base, fb_base, pd);
 	if (sti) {
@@ -998,8 +994,7 @@ static int sticore_pci_init(struct pci_dev *pd, const struct pci_device_id *ent)
 	}

 	if (!sti) {
-		printk(KERN_WARNING "Unable to handle STI device '%s'\n",
-			pci_name(pd));
+		pr_warn("Unable to handle STI device '%s'\n", pci_name(pd));
 		return -ENODEV;
 	}
 #endif /* CONFIG_PCI */
@@ -1058,7 +1053,7 @@ static void sti_init_roms(void)

 	sticore_initialized = 1;

-	printk(KERN_INFO "STI GSC/PCI core graphics driver "
+	pr_info("STI GSC/PCI core graphics driver "
 			STI_DRIVERVERSION "\n");

 	/* Register drivers for native & PCI cards */
diff --git a/drivers/video/fbdev/sticore.h b/drivers/video/fbdev/sticore.h
index fb8f58f9867a..9c7f4aa92a16 100644
--- a/drivers/video/fbdev/sticore.h
+++ b/drivers/video/fbdev/sticore.h
@@ -4,12 +4,6 @@

 /* generic STI structures & functions */

-#if 0
-#define DPRINTK(x)	printk x
-#else
-#define DPRINTK(x)
-#endif
-
 #define MAX_STI_ROMS 4		/* max no. of ROMs which this driver handles */

 #define STI_REGION_MAX 8	/* hardcoded STI constants */
