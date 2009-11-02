From: Alexander Graf <agraf@suse.de>
Subject: [PATCH 2/2] Add PCI virtio support for frame buffer
Date: Mon,  2 Nov 2009 23:11:50 +0100
Message-ID: <1257199910-3197-2-git-send-email-agraf@suse.de>
References: <1257199910-3197-1-git-send-email-agraf@suse.de>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1257199910-3197-1-git-send-email-agraf@suse.de>
Sender: kvm-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kvm@vger.kernel.org
Cc: qemu-devel@nongnu.org, linux-fbdev-devel@lists.sourceforge.net, anthony@codemonkey.ws

We now know how to use a frame buffer on VirtIO, but we still can't use it on
x86. In order to leverage the power of VirtIO FB, we need to wrap it through
virtio-pci.

So let's add all the shiny wrappers and add a -vga option.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 hw/pc.c         |    5 +++++
 hw/pci.h        |    1 +
 hw/virtio-pci.c |   29 +++++++++++++++++++++++++++++
 sysemu.h        |    3 ++-
 vl.c            |    2 ++
 5 files changed, 39 insertions(+), 1 deletions(-)

diff --git a/hw/pc.c b/hw/pc.c
index bf4718e..4b0d019 100644
--- a/hw/pc.c
+++ b/hw/pc.c
@@ -1190,6 +1190,11 @@ static void pc_init1(ram_addr_t ram_size,
         } else {
             isa_vga_init();
         }
+    } else if (virtio_fb_enabled) {
+        if (pci_enabled)
+            pci_create_simple(pci_bus, -1, "virtio-fb-pci");
+        else
+            fprintf(stderr, "%s: virtio_fb: no PCI bus\n", __FUNCTION__);
     }
 
     rtc_state = rtc_init(2000);
diff --git a/hw/pci.h b/hw/pci.h
index 93f93fb..b65a6df 100644
--- a/hw/pci.h
+++ b/hw/pci.h
@@ -70,6 +70,7 @@ extern target_phys_addr_t pci_mem_base;
 #define PCI_DEVICE_ID_VIRTIO_BLOCK       0x1001
 #define PCI_DEVICE_ID_VIRTIO_BALLOON     0x1002
 #define PCI_DEVICE_ID_VIRTIO_CONSOLE     0x1003
+#define PCI_DEVICE_ID_VIRTIO_FB          0x1004
 
 typedef void PCIConfigWriteFunc(PCIDevice *pci_dev,
                                 uint32_t address, uint32_t data, int len);
diff --git a/hw/virtio-pci.c b/hw/virtio-pci.c
index 1665b59..34937de 100644
--- a/hw/virtio-pci.c
+++ b/hw/virtio-pci.c
@@ -490,6 +490,25 @@ static int virtio_console_init_pci(PCIDevice *pci_dev)
     return 0;
 }
 
+static int virtio_fb_init_pci(PCIDevice *pci_dev)
+{
+    VirtIOPCIProxy *proxy = DO_UPCAST(VirtIOPCIProxy, pci_dev, pci_dev);
+    VirtIODevice *vdev;
+
+    if (proxy->class_code != PCI_CLASS_DISPLAY_OTHER)
+        proxy->class_code = PCI_CLASS_DISPLAY_OTHER;
+
+    vdev = virtio_fb_init(&pci_dev->qdev);
+    if (!vdev) {
+        return -1;
+    }
+    virtio_init_pci(proxy, vdev,
+                    PCI_VENDOR_ID_REDHAT_QUMRANET,
+                    PCI_DEVICE_ID_VIRTIO_FB,
+                    proxy->class_code, 0x00);
+    return 0;
+}
+
 static int virtio_net_init_pci(PCIDevice *pci_dev)
 {
     VirtIOPCIProxy *proxy = DO_UPCAST(VirtIOPCIProxy, pci_dev, pci_dev);
@@ -574,6 +593,16 @@ static PCIDeviceInfo virtio_info[] = {
         },
         .qdev.reset = virtio_pci_reset,
     },{
+        .qdev.name = "virtio-fb-pci",
+        .qdev.size = sizeof(VirtIOPCIProxy),
+        .init      = virtio_fb_init_pci,
+        .exit      = virtio_exit_pci,
+        .qdev.props = (Property[]) {
+            DEFINE_PROP_HEX32("class", VirtIOPCIProxy, class_code, 0),
+            DEFINE_PROP_END_OF_LIST(),
+        },
+        .qdev.reset = virtio_pci_reset,
+    },{
         .qdev.name = "virtio-balloon-pci",
         .qdev.size = sizeof(VirtIOPCIProxy),
         .init      = virtio_balloon_init_pci,
diff --git a/sysemu.h b/sysemu.h
index 96804b4..c1bc5a3 100644
--- a/sysemu.h
+++ b/sysemu.h
@@ -104,13 +104,14 @@ extern int autostart;
 extern int bios_size;
 
 typedef enum {
-    VGA_NONE, VGA_STD, VGA_CIRRUS, VGA_VMWARE, VGA_XENFB
+    VGA_NONE, VGA_STD, VGA_CIRRUS, VGA_VMWARE, VGA_XENFB, VGA_VIRTIO
 } VGAInterfaceType;
 
 extern int vga_interface_type;
 #define cirrus_vga_enabled (vga_interface_type == VGA_CIRRUS)
 #define std_vga_enabled (vga_interface_type == VGA_STD)
 #define xenfb_enabled (vga_interface_type == VGA_XENFB)
+#define virtio_fb_enabled (vga_interface_type == VGA_VIRTIO)
 #define vmsvga_enabled (vga_interface_type == VGA_VMWARE)
 
 extern int graphic_width;
diff --git a/vl.c b/vl.c
index e57f58f..f999514 100644
--- a/vl.c
+++ b/vl.c
@@ -4297,6 +4297,8 @@ static void select_vgahw (const char *p)
         vga_interface_type = VGA_VMWARE;
     } else if (strstart(p, "xenfb", &opts)) {
         vga_interface_type = VGA_XENFB;
+    } else if (strstart(p, "virtio", &opts)) {
+        vga_interface_type = VGA_VIRTIO;
     } else if (!strstart(p, "none", &opts)) {
     invalid_vga:
         fprintf(stderr, "Unknown vga type: %s\n", p);
-- 
1.6.0.2

