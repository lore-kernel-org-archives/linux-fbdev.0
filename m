From: Jon Smirl <jonsmirl@gmail.com>
Subject: [PATCH] Provide control of active VGA device on PCI systems
Date: Sun, 20 Feb 2005 00:50:42 -0500
Message-ID: <9e47339105021921507545d084@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D2jzU-0005K6-S8
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Feb 2005 21:50:48 -0800
Received: from rproxy.gmail.com ([64.233.170.205])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D2jzU-0006ZR-6t
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Feb 2005 21:50:48 -0800
Received: by rproxy.gmail.com with SMTP id z35so215008rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 19 Feb 2005 21:50:42 -0800 (PST)
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
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>, Jesse Barnes <jbarnes@sgi.com>

This patch adds a 'vga' attribute to each framebuffer device on PCI
systems. For non-PCI hardware it does nothing.

If you have multiple VGA cards loaded, and you have framebuffer
drivers loaded for each, you can then set 0/1 into the VGA attributes
to move VGA console around to the different screens.

This is almost everything needed to implement reset of secondary
cards. ROM access is already in the kernel. This code is needed to
make sure you don't end up with multiple VGA devices enabled. All that
is left is to construct the proper hotplug event and fix up my user
space reset program.

-- 
Jon Smirl
jonsmirl@gmail.com

diff -Nru a/arch/i386/pci/fixup.c b/arch/i386/pci/fixup.c
--- a/arch/i386/pci/fixup.c	2005-02-20 00:44:56 -05:00
+++ b/arch/i386/pci/fixup.c	2005-02-20 00:44:56 -05:00
@@ -375,6 +375,6 @@
 		}
 		bus = bus->parent;
 	}
-	pdev->resource[PCI_ROM_RESOURCE].flags |= IORESOURCE_ROM_SHADOW;
+	pdev->resource[PCI_ROM_RESOURCE].flags |= IORESOURCE_ROM_SHADOW |
IORESOURCE_NO_RESET;
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pci_fixup_video);
diff -Nru a/drivers/video/Makefile b/drivers/video/Makefile
--- a/drivers/video/Makefile	2005-02-20 00:44:56 -05:00
+++ b/drivers/video/Makefile	2005-02-20 00:44:56 -05:00
@@ -13,6 +13,7 @@
 # Only include macmodes.o if we have FB support and are PPC
 ifneq ($(CONFIG_FB),n)
 fb-$(CONFIG_PPC)                  += macmodes.o
+fb-$(CONFIG_PCI)                  += vga.o
 endif
 fb-objs                           := $(fb-y)
 
diff -Nru a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c	2005-02-20 00:44:56 -05:00
+++ b/drivers/video/fbmem.c	2005-02-20 00:44:56 -05:00
@@ -1067,6 +1067,7 @@
 		if (!registered_fb[i])
 			break;
 	fb_info->node = i;
+	fb_vga_add_device(fb_info->device);
 
 	fb_info->class_device = class_simple_device_add(fb_class, MKDEV(FB_MAJOR, i),
 				    fb_info->device, "fb%d", i);
@@ -1130,6 +1131,7 @@
 		return -EINVAL;
 	devfs_remove("fb/%d", i);
 
+	fb_vga_remove_device(fb_info->device);
 	if (fb_info->pixmap.addr && (fb_info->pixmap.flags & FB_PIXMAP_DEFAULT))
 		kfree(fb_info->pixmap.addr);
 	fb_destroy_modelist(&fb_info->modelist);
diff -Nru a/drivers/video/vga.c b/drivers/video/vga.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/video/vga.c	2005-02-20 00:44:56 -05:00
@@ -0,0 +1,210 @@
+/*
+ * linux/drivers/pci/vga.c
+ *
+ * (C) Copyright 2004 Jon Smirl <jonsmirl@gmail.com>
+ *
+ * VGA control logic for ensuring only a single enabled VGA device
+ */
+
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/cdev.h>
+#include <linux/pci.h>
+#include <linux/major.h>
+
+static struct pci_dev *vga_active = NULL;
+
+static void bridge_yes(struct pci_dev *pdev)
+{
+	struct pci_dev *bridge;
+	struct pci_bus *bus;
+	
+	/* Make sure the bridges route to us */
+	bus = pdev->bus;
+	while (bus) {
+		bridge = bus->self;
+		if (bridge) {
+			bus->bridge_ctl |= PCI_BRIDGE_CTL_VGA;
+			pci_write_config_word(bridge, PCI_BRIDGE_CONTROL, bus->bridge_ctl);
+		}
+		bus = bus->parent;
+	}
+}
+
+static void bridge_no(struct pci_dev *pdev)
+{
+	struct pci_dev *bridge;
+	struct pci_bus *bus;
+	
+	/* Make sure the bridges don't route to us */
+	bus = pdev->bus;
+	while (bus) {
+		bridge = bus->self;
+		if (bridge) {
+			bus->bridge_ctl &= ~PCI_BRIDGE_CTL_VGA;
+			pci_write_config_word(bridge, PCI_BRIDGE_CONTROL, bus->bridge_ctl);
+		}
+		bus = bus->parent;
+	}
+}
+
+static void vga_enable(struct pci_dev *pdev, unsigned int enable)
+{
+	u16 command;
+	
+	bridge_yes(pdev);
+
+	if (enable) {
+		pci_enable_device(pdev);
+		/* this assumes all other potential VGA devices are disabled */
+		outb(0x01 | inb(0x3C3),  0x3C3);  /* 0 - enable */
+		outb(0x08 | inb(0x46e8), 0x46e8);
+		outb(0x01 | inb(0x102),  0x102);
+		vga_active = pdev;
+
+		/* return and leave the card enabled */
+		return;
+	}
+	
+	pci_read_config_word(pdev, PCI_COMMAND, &command);
+	pci_write_config_word(pdev, PCI_COMMAND, command | PCI_COMMAND_IO |
PCI_COMMAND_MEMORY);
+	
+	outb(~0x01 & inb(0x3C3),  0x3C3);
+	outb(~0x08 & inb(0x46e8), 0x46e8);
+	outb(~0x01 & inb(0x102),  0x102);
+	if (pdev == vga_active)
+		vga_active = NULL;
+	bridge_no(pdev);
+
+	pci_write_config_word(pdev, PCI_COMMAND, command);
+}
+
+/* echo these values to the sysfs vga attribute on a VGA device */
+enum eEnable {
+	VGA_DISABLE_THIS = 0,	/* If this VGA is enabled, disable it. */
+	VGA_ENABLE_THIS = 1,	/* Disable all VGAs then enable this VGA, mark
as active VGA */
+	/* Used while resetting a board, board being reset may not be the
active VGA */
+	VGA_DISABLE_ALL = 2,	/* Remember active VGA then disable all VGAa
and devices */
+	VGA_ENABLE_ACTIVE = 3,	/* Make sure all VGAs are disabled, then
reenable active VGA */
+	VGA_RESET = 4, 		/* Trigger a reset manually */
+	VGA_MAX = 5
+};
+
+static void set_state(struct pci_dev *pdev, enum eEnable enable)
+{
+	struct pci_dev *pcidev = NULL;
+	unsigned int class;
+
+	if (enable == VGA_DISABLE_THIS)
+		if (vga_active != pdev)
+			return;
+
+	if (enable == VGA_RESET) {
+		kobject_hotplug(&pdev->dev.kobj, KOBJ_ADD);
+		return;
+	}
+	
+	vga_enable(vga_active, 0);
+
+	/* loop over all devices and make sure no multiple routings */
+	while ((pcidev = pci_get_subsys(PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
PCI_ANY_ID, pcidev)) != NULL) {
+		class = pcidev->class >> 8;
+
+		if (class == PCI_CLASS_DISPLAY_VGA)
+			bridge_no(pcidev);
+	}
+
+	/* loop over all devices and make sure everyone is disabled */
+	while ((pcidev = pci_get_subsys(PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
PCI_ANY_ID, pcidev)) != NULL) {
+		class = pcidev->class >> 8;
+
+		if (class == PCI_CLASS_DISPLAY_VGA)
+			vga_enable(pcidev, 0);
+	}
+
+	switch (enable) {
+		/* Mark us active if requested */
+		case VGA_ENABLE_THIS:
+			vga_enable(pdev, 1);
+			break;
+
+		/* Restore active device if requested */
+		case VGA_ENABLE_ACTIVE:
+			vga_enable(vga_active, 1);
+			break;
+
+		default:
+			break;
+	}
+}
+
+/* sysfs store for VGA device */
+static ssize_t vga_device_store(struct device *dev, const char *buf,
size_t count)
+{
+	char *last;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	enum eEnable enable;
+
+	/* sysfs strings are terminated by \n */
+	enable = simple_strtoul(buf, &last, 0);
+	if (last == buf)
+		return -EINVAL;
+
+	if ((enable < VGA_DISABLE_THIS) || (enable >= VGA_MAX))
+		return -EINVAL;
+
+	set_state(pdev, enable);
+
+	return count;
+}
+
+/* sysfs show for VGA device */
+static ssize_t vga_device_show(struct device *dev, char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	return sprintf(buf, "%d\n", vga_active == pdev);
+}
+
+static struct device_attribute vga_device_attr = __ATTR(vga,
S_IRUGO|S_IWUSR, vga_device_show, vga_device_store);
+
+/* Add a VGA sysfs attribute */
+void fb_vga_add_device(struct device *device)
+{
+	struct pci_dev *pdev = to_pci_dev(device);
+	if (device) {
+		device_create_file(&pdev->dev, &vga_device_attr);
+	
+		/* record the active boot device when located */
+		if ((!vga_active) && (pdev->resource[PCI_ROM_RESOURCE].flags &
IORESOURCE_ROM_SHADOW))
+			vga_active = pdev;
+	}
+}
+
+/* If the device is a VGA or a bridge, remove the VGA sysfs attribute */
+void fb_vga_remove_device(struct device *device)
+{
+	struct pci_dev *pdev = to_pci_dev(device);
+	struct pci_dev *pcidev = NULL;
+	int class = pdev->class >> 8;
+
+	if (device) {
+		device_remove_file(&pdev->dev, &vga_device_attr);
+	
+		/* if the active VGA device is being removed, try to move VGA to
another device */
+		if (vga_active == pdev) {
+			while ((pcidev = pci_get_subsys(PCI_ANY_ID, PCI_ANY_ID,
PCI_ANY_ID, PCI_ANY_ID, pcidev)) != NULL) {
+				class = pcidev->class >> 8;
+				if (class != PCI_CLASS_DISPLAY_VGA)
+					continue;
+				if (pcidev == pdev)
+					continue;
+				set_state(pcidev, VGA_ENABLE_THIS);
+				break;
+			}
+			if (pcidev == NULL)
+				set_state(NULL, VGA_DISABLE_ALL);
+			
+		}
+	}
+}
+
diff -Nru a/include/linux/fb.h b/include/linux/fb.h
--- a/include/linux/fb.h	2005-02-20 00:44:56 -05:00
+++ b/include/linux/fb.h	2005-02-20 00:44:56 -05:00
@@ -893,6 +893,15 @@
 extern struct fb_cmap *fb_default_cmap(int len);
 extern void fb_invert_cmaps(void);
 
+/* drivers/video/vga.c */
+#ifdef CONFIG_PCI
+extern void fb_vga_add_device(struct device *device);
+extern void fb_vga_remove_device(struct device *device);
+#else
+static inline void fb_vga_add_device(struct device *device){}
+static inline void fb_vga_remove_device(struct device *device){}
+#endif
+
 struct fb_videomode {
 	const char *name;	/* optional */
 	u32 refresh;		/* optional */
diff -Nru a/include/linux/ioport.h b/include/linux/ioport.h
--- a/include/linux/ioport.h	2005-02-20 00:44:56 -05:00
+++ b/include/linux/ioport.h	2005-02-20 00:44:56 -05:00
@@ -86,6 +86,7 @@
 #define IORESOURCE_ROM_ENABLE		(1<<0)	/* ROM is enabled, same as
PCI_ROM_ADDRESS_ENABLE */
 #define IORESOURCE_ROM_SHADOW		(1<<1)	/* ROM is copy at C000:0 */
 #define IORESOURCE_ROM_COPY		(1<<2)	/* ROM is alloc'd copy, resource
field overlaid */
+#define IORESOURCE_NO_RESET		(1<<3)	/* Don't reset this device */
 
 /* PC/ISA/whatever - the normal PC address spaces: IO and memory */
 extern struct resource ioport_resource;


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
