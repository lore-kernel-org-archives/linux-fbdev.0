From: Jon Smirl <jonsmirl@yahoo.com>
Subject: New kernel API for ROMs
Date: Fri, 6 Aug 2004 14:21:33 -0700 (PDT)
Sender: dri-devel-admin@lists.sourceforge.net
Message-ID: <20040806212133.22637.qmail@web14923.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1555818445-1091827293=:19169"
Return-path: <dri-devel-admin@lists.sourceforge.net>
Errors-To: dri-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:dri-devel@lists.sourceforge.net>
List-Help: <mailto:dri-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=dri-devel>
To: dri-devel <dri-devel@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

--0-1555818445-1091827293=:19169
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

This patch provides a new kernel API for access ROMs from device
drivers. If you're working on a driver that uses the ROM (most video
drivers) please give this patch a try and send some feedback/bugs.

pci_map_rom() - map the rom and provide virtual address, transparently
return shadow/copy if needed. Normal drivers call this

pci_map_rom_copy() - same as pci_map_rom except the ROM will copied,
future reads of ROM will use copy. Hardware with minimal decoding calls
use this

pci_unmap_rom() - release the ioremap if there is one

The ROMs also appear in sysfs and you can use hexdump to see them.

If the Radeon ROM is all FFFF. Load a radeon device driver and it will
appear. Radeon cards have a bug that loading the driver will fix.

=====
Jon Smirl
jonsmirl@yahoo.com


	
		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - 100MB free storage!
http://promotions.yahoo.com/new_mail 
--0-1555818445-1091827293=:19169
Content-Type: text/x-patch; name="pci-sysfs-rom-11.patch"
Content-Description: pci-sysfs-rom-11.patch
Content-Disposition: inline; filename="pci-sysfs-rom-11.patch"

===== arch/i386/pci/fixup.c 1.19 vs edited =====
--- 1.19/arch/i386/pci/fixup.c	Thu Jun  3 10:58:17 2004
+++ edited/arch/i386/pci/fixup.c	Thu Aug  5 00:20:08 2004
@@ -237,6 +237,29 @@
 	}
 }
 
+static void __devinit pci_fixup_video(struct pci_dev *pdev)
+{
+	struct pci_dev *bridge;
+	struct pci_bus *bus;
+	u16 l;
+	
+	if ((pdev->class >> 8) != PCI_CLASS_DISPLAY_VGA)
+		return;
+	       
+	/* Is VGA routed to us? */
+	bus = pdev->bus;
+	while (bus) {
+		bridge = bus->self;
+		if (bridge) {
+			pci_read_config_word(bridge, PCI_BRIDGE_CONTROL, &l);
+			if (!(l & PCI_BRIDGE_CTL_VGA))
+				return;
+		}
+		bus = bus->parent;
+	}
+	pdev->resource[PCI_ROM_RESOURCE].flags |= PCI_ROM_SHADOW;
+}
+
 struct pci_fixup pcibios_fixups[] = {
 	{
 		.pass		= PCI_FIXUP_HEADER,
@@ -345,6 +368,12 @@
 		.vendor		= PCI_VENDOR_ID_NVIDIA,
 		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE2,
 		.hook		= pci_fixup_nforce2
+	},
+	{
+		.pass		= PCI_FIXUP_FINAL,
+		.vendor		= PCI_ANY_ID,
+		.device		= PCI_ANY_ID,
+		.hook		= pci_fixup_video
 	},
 	{ .pass = 0 }
 };
===== drivers/pci/pci-sysfs.c 1.10 vs edited =====
--- 1.10/drivers/pci/pci-sysfs.c	Fri Jun  4 09:23:04 2004
+++ edited/drivers/pci/pci-sysfs.c	Fri Aug  6 16:38:00 2004
@@ -5,6 +5,7 @@
  * (C) Copyright 2002-2004 IBM Corp.
  * (C) Copyright 2003 Matthew Wilcox
  * (C) Copyright 2003 Hewlett-Packard
+ * (C) Copyright 2004 Jon Smirl
  *
  * File attributes for PCI devices
  *
@@ -164,6 +165,176 @@
 	return count;
 }
 
+/**
+ * pci_enable_rom - enable ROM decoding for a PCI device
+ * @dev: PCI device to enable
+ *
+ * Enable ROM decoding on @dev.  This involves simply turning on the last
+ * bit of the PCI ROM BAR.  Note that some cards may share address decoders
+ * between the ROM and other resources, so enabling it may disable access
+ * to MMIO registers or other card memory.
+ */
+static void
+pci_enable_rom(struct pci_dev *dev)
+{
+	u32 rom_addr;
+	
+	pci_read_config_dword(dev, dev->rom_base_reg, &rom_addr);
+	rom_addr |= PCI_ROM_ADDRESS_ENABLE;
+	pci_write_config_dword(dev, dev->rom_base_reg, rom_addr);
+}
+
+/**
+ * pci_disable_rom - disable ROM decoding for a PCI device
+ * @dev: PCI device to disable
+ *
+ * Disable ROM decoding on a PCI device by turning off the last bit in the
+ * ROM BAR.
+ */
+static void
+pci_disable_rom(struct pci_dev *dev)
+{
+	u32 rom_addr;
+	pci_read_config_dword(dev, dev->rom_base_reg, &rom_addr);
+	rom_addr &= ~PCI_ROM_ADDRESS_ENABLE;
+	pci_write_config_dword(dev, dev->rom_base_reg, rom_addr);
+}
+
+/**
+ * pci_map_rom - map a PCI ROM to kernel space
+ * @dev: pointer to pci device struct
+ * @size: pointer to receive size of pci window over ROM
+ * @return: kernel virtual pointer to image of ROM
+ *
+ * Map a PCI ROM into kernel space. If ROM is boot video ROM,
+ * the shadow BIOS copy will be returned instead of the 
+ * actual ROM.
+ */
+unsigned char *
+pci_map_rom(struct pci_dev *dev, size_t *size) {
+	struct resource *res = &dev->resource[PCI_ROM_RESOURCE];
+	loff_t start;
+	unsigned char *rom;
+	
+	if (res->flags & PCI_ROM_SHADOW) {	/* PCI_ROM_SHADOW only set on x86 */
+		start = (loff_t)0xC0000; 	/* primary video rom always starts here */
+		*size = 0x20000;		/* cover C000:0 through E000:0 */
+	} else if (res->flags & PCI_ROM_COPY) {
+		*size = pci_resource_len(dev, PCI_ROM_RESOURCE);
+		return (unsigned char *)pci_resource_start(dev, PCI_ROM_RESOURCE);
+	} else {
+		start = pci_resource_start(dev, PCI_ROM_RESOURCE);
+		*size = pci_resource_len(dev, PCI_ROM_RESOURCE);
+		if (*size == 0)
+			return NULL;
+		
+		/* Enable ROM space decodes */
+		pci_enable_rom(dev);
+	}
+	
+	rom = ioremap(start, *size);
+	if (!rom) {
+		/* restore enable if ioremap fails */
+		if (!(res->flags & (PCI_ROM_ADDRESS_ENABLE | PCI_ROM_SHADOW | PCI_ROM_COPY)))
+			pci_disable_rom(dev);
+		return NULL;
+	}		
+	/* Standard PCI ROMs start out with these three bytes 55 AA size/512 */
+	if ((*rom == 0x55) && (*(rom + 1) == 0xAA))
+		*size = *(rom + 2) * 512;	/* return true ROM size, not PCI window size */
+		
+	return rom;
+}
+
+/**
+ * pci_map_rom_copy - map a PCI ROM to kernel space, create a copy
+ * @dev: pointer to pci device struct
+ * @size: pointer to receive size of pci window over ROM
+ * @return: kernel virtual pointer to image of ROM
+ *
+ * Map a PCI ROM into kernel space. If ROM is boot video ROM,
+ * the shadow BIOS copy will be returned instead of the 
+ * actual ROM.
+ */
+unsigned char *
+pci_map_rom_copy(struct pci_dev *dev, size_t *size) {
+	struct resource *res = &dev->resource[PCI_ROM_RESOURCE];
+	unsigned char *rom;
+	
+	rom = pci_map_rom(dev, size);
+	if (!rom)
+		return NULL;
+		
+	if (res->flags & (PCI_ROM_COPY | PCI_ROM_SHADOW))
+		return rom;
+		
+	res->start = (unsigned long)kmalloc(*size, GFP_KERNEL);
+	if (!res->start) 
+		return rom;
+
+	res->end = res->start + *size; 
+	memcpy((void*)res->start, rom, *size);
+	pci_unmap_rom(dev, rom);
+	res->flags |= PCI_ROM_COPY;
+	
+	return (unsigned char *)res->start;
+}
+
+/**
+ * pci_unmap_rom - unmap the ROM from kernel space
+ * @dev: pointer to pci device struct
+ * @rom: virtual address of the previous mapping
+ *
+ * Remove a mapping of a previously mapped ROM
+ */
+void 
+pci_unmap_rom(struct pci_dev *dev, unsigned char *rom) {
+	struct resource *res = &dev->resource[PCI_ROM_RESOURCE];
+
+	if (res->flags & PCI_ROM_COPY)
+		return;
+		
+	iounmap(rom);
+		
+	/* Disable again before continuing, leave enabled if pci=rom */
+	if (!(res->flags & (PCI_ROM_ADDRESS_ENABLE | PCI_ROM_SHADOW)))
+		pci_disable_rom(dev);
+}
+
+/**
+ * pci_read_rom - read a PCI ROM
+ * @kobj: kernel object handle
+ * @buf: where to put the data we read from the ROM
+ * @off: file offset
+ * @count: number of bytes to read
+ *
+ * Put @count bytes starting at @off into @buf from the ROM in the PCI
+ * device corresponding to @kobj.
+ */
+static ssize_t
+pci_read_rom(struct kobject *kobj, char *buf, loff_t off, size_t count)
+{
+	struct pci_dev *dev = to_pci_dev(container_of(kobj,struct device,kobj));
+	unsigned char *rom;
+	size_t size;
+	
+	rom = pci_map_rom(dev, &size);	/* size starts out as PCI window size */
+	if (!rom)
+		return 0;
+		
+	if (off >= size)
+		count = 0;
+	else {
+		if (off + count > size)
+			count = size - off;
+		
+		memcpy_fromio(buf, rom + off, count);
+	}
+	pci_unmap_rom(dev, rom);
+		
+	return count;
+}
+
 static struct bin_attribute pci_config_attr = {
 	.attr =	{
 		.name = "config",
@@ -186,13 +357,53 @@
 	.write = pci_write_config,
 };
 
-void pci_create_sysfs_dev_files (struct pci_dev *pdev)
+static struct bin_attribute rom_attr = {
+	.attr =	{
+		.name = "rom",
+		.mode = S_IRUSR,
+		.owner = THIS_MODULE,
+	},
+	/* .size is set individually for each device, sysfs copies it into dentry */
+	.read = pci_read_rom,
+};
+
+void pci_create_sysfs_dev_files(struct pci_dev *pdev)
 {
 	if (pdev->cfg_size < 4096)
 		sysfs_create_bin_file(&pdev->dev.kobj, &pci_config_attr);
 	else
 		sysfs_create_bin_file(&pdev->dev.kobj, &pcie_config_attr);
 
+	/* If the device has a ROM, try to expose it in sysfs. */
+	if (pci_resource_len(pdev, PCI_ROM_RESOURCE)) {
+		unsigned char *rom;
+		rom = pci_map_rom(pdev, &rom_attr.size);
+		if (rom) {
+			pci_unmap_rom(pdev, rom);
+			sysfs_create_bin_file(&pdev->dev.kobj, &rom_attr);
+		}
+	}
 	/* add platform-specific attributes */
 	pcibios_add_platform_entries(pdev);
 }
+
+/**
+ * pci_remove_sysfs_dev_files - cleanup PCI specific sysfs files
+ * @pdev: device whose entries we should free
+ *
+ * Cleanup when @pdev is removed from sysfs.
+ */
+void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
+{
+	if (pdev->cfg_size < 4096)
+		sysfs_remove_bin_file(&pdev->dev.kobj, &pci_config_attr);
+	else
+		sysfs_remove_bin_file(&pdev->dev.kobj, &pcie_config_attr);
+
+	if (pci_resource_len(pdev, PCI_ROM_RESOURCE))
+		sysfs_remove_bin_file(&pdev->dev.kobj, &rom_attr);
+}
+
+EXPORT_SYMBOL(pci_map_rom);
+EXPORT_SYMBOL(pci_map_rom_copy);
+EXPORT_SYMBOL(pci_unmap_rom);
===== drivers/pci/pci.h 1.12 vs edited =====
--- 1.12/drivers/pci/pci.h	Fri Jun  4 09:23:04 2004
+++ edited/drivers/pci/pci.h	Tue Aug  3 17:05:19 2004
@@ -3,6 +3,7 @@
 extern int pci_hotplug (struct device *dev, char **envp, int num_envp,
 			 char *buffer, int buffer_size);
 extern void pci_create_sysfs_dev_files(struct pci_dev *pdev);
+extern void pci_remove_sysfs_dev_files(struct pci_dev *pdev);
 extern int pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
 				  unsigned long size, unsigned long align,
 				  unsigned long min, unsigned int type_mask,
===== drivers/pci/remove.c 1.3 vs edited =====
--- 1.3/drivers/pci/remove.c	Tue Feb  3 12:17:30 2004
+++ edited/drivers/pci/remove.c	Fri Aug  6 15:36:18 2004
@@ -12,12 +12,22 @@
 
 static void pci_free_resources(struct pci_dev *dev)
 {
+	struct resource *res;
 	int i;
 
  	msi_remove_pci_irq_vectors(dev);
 
+	if (dev->hdr_type == PCI_HEADER_TYPE_NORMAL) {
+		res = &dev->resource[PCI_ROM_RESOURCE];
+		if (res->flags & PCI_ROM_COPY) {
+			kfree((void*)res->start);
+			res->flags &= !PCI_ROM_COPY;
+			res->start = 0;
+			res->end = 0;
+		}
+	}
 	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-		struct resource *res = dev->resource + i;
+		res = dev->resource + i;
 		if (res->parent)
 			release_resource(res);
 	}
@@ -26,6 +36,7 @@
 static void pci_destroy_dev(struct pci_dev *dev)
 {
 	pci_proc_detach_device(dev);
+	pci_remove_sysfs_dev_files(dev);
 	device_unregister(&dev->dev);
 
 	/* Remove the device from the device lists, and prevent any further
===== include/linux/pci.h 1.132 vs edited =====
--- 1.132/include/linux/pci.h	Mon Aug  2 04:00:43 2004
+++ edited/include/linux/pci.h	Fri Aug  6 00:34:27 2004
@@ -102,6 +102,8 @@
 #define PCI_SUBSYSTEM_ID	0x2e  
 #define PCI_ROM_ADDRESS		0x30	/* Bits 31..11 are address, 10..1 reserved */
 #define  PCI_ROM_ADDRESS_ENABLE	0x01
+#define  PCI_ROM_SHADOW		0x02	/* resource flag, ROM is copy at C000:0 */
+#define  PCI_ROM_COPY		0x04	/* resource flag, ROM is alloc'd copy */
 #define PCI_ROM_ADDRESS_MASK	(~0x7ffUL)
 
 #define PCI_CAPABILITY_LIST	0x34	/* Offset of first capability list entry */
@@ -777,6 +779,9 @@
 int pci_dac_set_dma_mask(struct pci_dev *dev, u64 mask);
 int pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask);
 int pci_assign_resource(struct pci_dev *dev, int i);
+unsigned char *pci_map_rom(struct pci_dev *dev, size_t *size);
+unsigned char *pci_map_rom_copy(struct pci_dev *dev, size_t *size);
+void pci_unmap_rom(struct pci_dev *dev, unsigned char *rom);
 
 /* Power management related routines */
 int pci_save_state(struct pci_dev *dev, u32 *buffer);

--0-1555818445-1091827293=:19169--


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
--
