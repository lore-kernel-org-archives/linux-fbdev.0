From: Antonino Daplas <adaplas@pol.net>
Subject: Re: rivafb "Badness" using fbdev.diff.gz and
	2.5.5[45]
Date: 19 Jan 2003 23:40:46 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1042990390.1058.4.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0301150042470.23774-100000@phoenix.infradead.org> 
	<200301182028.33155.rfjak@eircom.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18aHj7-0002mB-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 19 Jan 2003 07:51:13 -0800
In-Reply-To: <200301182028.33155.rfjak@eircom.net>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Jak <rfjak@eircom.net>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sun, 2003-01-19 at 04:28, Jak wrote: 
> 
> James,
> 		I still see the same problem using 2.5.59. I think this
> is the same problem as that referred to by Udo A. Steinberg
> http://marc.theaimsgroup.com/?l=linux-kernel&m=104278873827538&w=2
> ( I get similar results as him if I compile rivafb built-in )
> 
> Is this possibly related to driver-model issues discussed in this thread ?
> http://marc.theaimsgroup.com/?l=linux-kernel&m=104283662023857&w=2
> 
> Good news is that 2.5.59 seems quite stable as regards framebuffer.
> It no longer locks up after loading fbcon. But rmmod fbcon still
> causes instant death accompanied by increased whirring noises from inside
> box.
> 
> To summarise:
>  insmod rivafb causes "Badness in kobject_register" every time 
>    ( after pci_register_driver() in rivafb_init(),see below )
>  after insmod rivafb, I have a green screen, which can be cleared by fbset
>   ( fbset now changes resolution of all VTs, this is different from 2.4.x )
The green screen is expected because the driver partly initializes the
hardware (in riva_common_setup()).  Running fbset() will complete the
initialization, but... 

>  after clearing green screen using fbset, text colours are wrong
...unfortunately, upon exit, the driver restores only the partly
initialized state, thus the vga console text colors are wrong. 

>  now ( 2.5.59 ), I can insmod fbcon, and screen looks OK again ( apart from
When fbcon is loaded, it goes to graphics mode, so the screen should
look okay.  

>   the left-hand-most column of screen appears at right-hand side of screen )
Try running stty to fix your display. 

>  rmmod fbcon locks up machine, no ALT-SYSRQ effective
This is wishful thinking :-), as fbcon cannot be unloaded (yet). 

James, 

Calling riva_common_setup() calls RivaGetConfig() which modifies the
hardware.  Since we only need fix->smem_len and the bandwidth from
RivaGetConfig(), I isolated them into riva_get_memlen() and
riva_get_maxdclk().  RivaGetConfig will be called from rivafb_open()
anyway.

So can you and Jak try the attached patch?  It should prevent VGA
console corruption on insmod and it should eliminate the kobject trace
messages.

Diff is against 2.5.59.

Tony

diff -Naur linux-2.5.59/drivers/video/riva/fbdev.c linux/drivers/video/riva/fbdev.c
--- linux-2.5.59/drivers/video/riva/fbdev.c	2003-01-19 15:24:14.000000000 +0000
+++ linux/drivers/video/riva/fbdev.c	2003-01-19 15:23:18.000000000 +0000
@@ -150,7 +150,7 @@
 static struct riva_chip_info {
 	const char *name;
 	unsigned arch_rev;
-} riva_chip_info[] __devinitdata = {
+} riva_chip_info[] __initdata = {
 	{ "RIVA-128", NV_ARCH_03 },
 	{ "RIVA-TNT", NV_ARCH_04 },
 	{ "RIVA-TNT2", NV_ARCH_04 },
@@ -193,7 +193,7 @@
 	{ "Quadro4-700-XGL", NV_ARCH_20 }
 };
 
-static struct pci_device_id rivafb_pci_tbl[] __devinitdata = {
+static struct pci_device_id rivafb_pci_tbl[] __initdata = {
 	{ PCI_VENDOR_ID_NVIDIA_SGS, PCI_DEVICE_ID_NVIDIA_SGS_RIVA128,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_RIVA_128 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_TNT,
@@ -1543,7 +1543,7 @@
 	.fb_sync 	= rivafb_sync,
 };
 
-static int __devinit riva_set_fbinfo(struct fb_info *info)
+static int __init riva_set_fbinfo(struct fb_info *info)
 {
 	struct riva_par *par = (struct riva_par *) info->par;
 	unsigned int cmap_len;
@@ -1689,8 +1689,8 @@
  *
  * ------------------------------------------------------------------------- */
 
-static int __devinit rivafb_probe(struct pci_dev *pd,
-				     const struct pci_device_id *ent)
+static int __init rivafb_probe(struct pci_dev *pd,
+			       const struct pci_device_id *ent)
 {
 	struct riva_chip_info *rci = &riva_chip_info[ent->driver_data];
 	struct riva_par *default_par;
@@ -1788,8 +1788,8 @@
 		default_par->riva.PCRTC = default_par->riva.PCRTC0 = default_par->riva.PGRAPH;
 	}
 
-	rivafb_fix.smem_len = default_par->riva.RamAmountKBytes * 1024;
-	default_par->dclk_max = default_par->riva.MaxVClockFreqKHz * 1000;
+	rivafb_fix.smem_len = riva_get_memlen(default_par) * 1024;
+	default_par->dclk_max = riva_get_maxdclk(default_par) * 1000;
 
 	if (!request_mem_region(rivafb_fix.smem_start,
 				rivafb_fix.smem_len, "rivafb")) {
@@ -1819,12 +1819,6 @@
 	}
 #endif /* CONFIG_MTRR */
 
-	/* unlock io */
-	CRTCout(default_par, 0x11, 0xFF);/* vgaHWunlock() + riva unlock (0x7F) */
-	default_par->riva.LockUnlock(&default_par->riva, 0);
-
-	riva_save_state(default_par, &default_par->initial_state);
-
 	if (riva_set_fbinfo(info) < 0) {
 		printk(KERN_ERR PFX "error setting initial video mode\n");
 		goto err_out_load_state;
@@ -1869,7 +1863,7 @@
 	return -ENODEV;
 }
 
-static void __devexit rivafb_remove(struct pci_dev *pd)
+static void __exit rivafb_remove(struct pci_dev *pd)
 {
 	struct fb_info *info = pci_get_drvdata(pd);
 	struct riva_par *par = (struct riva_par *) info->par;
@@ -1877,8 +1871,6 @@
 	if (!info)
 		return;
 
-	riva_load_state(par, &par->initial_state);
-
 	unregister_framebuffer(info);
 
 #ifdef CONFIG_MTRR
@@ -1948,7 +1940,7 @@
 	name:		"rivafb",
 	id_table:	rivafb_pci_tbl,
 	probe:		rivafb_probe,
-	remove:		__devexit_p(rivafb_remove),
+	remove:		__exit_p(rivafb_remove),
 };
 

@@ -1961,12 +1953,7 @@
 
 int __init rivafb_init(void)
 {
-	int err;
-	err = pci_module_init(&rivafb_driver);
-	if (err)
-		return err;
-	pci_register_driver(&rivafb_driver);
-	return 0;
+	return pci_module_init(&rivafb_driver);
 }
 

diff -Naur linux-2.5.59/drivers/video/riva/nv_driver.c linux/drivers/video/riva/nv_driver.c
--- linux-2.5.59/drivers/video/riva/nv_driver.c	2003-01-19 15:24:14.000000000 +0000
+++ linux/drivers/video/riva/nv_driver.c	2003-01-19 15:23:18.000000000 +0000
@@ -35,6 +35,7 @@
 5 20:47:06 mvojkovi Exp $ */
 
 #include <linux/delay.h>
+#include <linux/pci.h>
 #include <linux/pci_ids.h>
 #include "nv_type.h"
 #include "rivafb.h"
@@ -133,6 +134,159 @@
 	riva_override_CRTC(par);
 }
 
+unsigned long riva_get_memlen(struct riva_par *par)
+{
+	RIVA_HW_INST *chip = &par->riva;
+	unsigned long memlen = 0;
+	unsigned int chipset = par->Chipset;
+	struct pci_dev* dev;
+	int amt;
+
+	switch (chip->Architecture) {
+	case NV_ARCH_03:
+		if (chip->PFB[0x00000000/4] & 0x00000020) {
+			if (((chip->PMC[0x00000000/4] & 0xF0) == 0x20)
+			    && ((chip->PMC[0x00000000/4] & 0x0F) >= 0x02)) {
+				/*
+				 * SDRAM 128 ZX.
+				 */
+				switch (chip->PFB[0x00000000/4] & 0x03) {
+				case 2:
+					memlen = 1024 * 4;
+					break;
+				case 1:
+					memlen = 1024 * 2;
+					break;
+				default:
+					memlen = 1024 * 8;
+					break;
+				}
+			} else {
+				memlen = 1024 * 8;
+			}            
+		} else 	{
+			/*
+			 * SGRAM 128.
+			 */
+			switch (chip->PFB[0x00000000/4] & 0x00000003) {
+			case 0:
+				memlen = 1024 * 8;
+				break;
+			case 2:
+				memlen = 1024 * 4;
+				break;
+			default:
+				memlen = 1024 * 2;
+				break;
+			}
+		}        
+		break;
+	case NV_ARCH_04:
+		if (chip->PFB[0x00000000/4] & 0x00000100) {
+			memlen = ((chip->PFB[0x00000000/4] >> 12) & 0x0F) * 
+				1024 * 2 + 1024 * 2;
+		} else {
+			switch (chip->PFB[0x00000000/4] & 0x00000003) {
+			case 0:
+				memlen = 1024 * 32;
+				break;
+			case 1:
+				memlen = 1024 * 4;
+				break;
+			case 2:
+				memlen = 1024 * 8;
+				break;
+			case 3:
+			default:
+				memlen = 1024 * 16;
+				break;
+			}
+		}
+		break;
+	case NV_ARCH_10:
+	case NV_ARCH_20:
+		if(chipset == NV_CHIP_IGEFORCE2) {
+
+			dev = pci_find_slot(0, 1);
+			pci_read_config_dword(dev, 0x7C, &amt);
+			memlen = (((amt >> 6) & 31) + 1) * 1024;
+		} else if (chipset == NV_CHIP_0x01F0) {
+			dev = pci_find_slot(0, 1);
+			pci_read_config_dword(dev, 0x84, &amt);
+			memlen = (((amt >> 4) & 127) + 1) * 1024;
+		} else {
+			switch ((chip->PFB[0x0000020C/4] >> 20) & 0x000000FF){
+			case 0x02:
+				memlen = 1024 * 2;
+				break;
+			case 0x04:
+				memlen = 1024 * 4;
+				break;
+			case 0x08:
+				memlen = 1024 * 8;
+				break;
+			case 0x10:
+				memlen = 1024 * 16;
+				break;
+			case 0x20:
+				memlen = 1024 * 32;
+				break;
+			case 0x40:
+				memlen = 1024 * 64;
+				break;
+			case 0x80:
+				memlen = 1024 * 128;
+				break;
+			default:
+				memlen = 1024 * 16;
+				break;
+			}
+		}
+		break;
+	}
+	return memlen;
+}
+
+unsigned long riva_get_maxdclk(struct riva_par *par)
+{
+	RIVA_HW_INST *chip = &par->riva;
+	unsigned long dclk = 0;
+
+	switch (chip->Architecture) {
+	case NV_ARCH_03:
+		if (chip->PFB[0x00000000/4] & 0x00000020) {
+			if (((chip->PMC[0x00000000/4] & 0xF0) == 0x20)
+			    && ((chip->PMC[0x00000000/4] & 0x0F) >= 0x02)) {   
+				/*
+				 * SDRAM 128 ZX.
+				 */
+				dclk = 800000;
+			} else {
+				dclk = 1000000;
+			}            
+		} else {
+			/*
+			 * SGRAM 128.
+			 */
+			dclk = 1000000;
+		} 
+		break;
+	case NV_ARCH_04:
+	case NV_ARCH_10:
+	case NV_ARCH_20:
+		switch ((chip->PFB[0x00000000/4] >> 3) & 0x00000003) {
+		case 3:
+			dclk = 800000;
+			break;
+		default:
+			dclk = 1000000;
+			break;
+		}
+		break;
+	}
+	return dclk;
+}
+
 void
 riva_common_setup(struct riva_par *par)
 {
diff -Naur linux-2.5.59/drivers/video/riva/rivafb.h linux/drivers/video/riva/rivafb.h
--- linux-2.5.59/drivers/video/riva/rivafb.h	2003-01-19 15:24:17.000000000 +0000
+++ linux/drivers/video/riva/rivafb.h	2003-01-19 15:23:20.000000000 +0000
@@ -55,5 +55,7 @@
 };
 
 void riva_common_setup(struct riva_par *);
+unsigned long riva_get_memlen(struct riva_par *);
+unsigned long riva_get_maxdclk(struct riva_par *);
 
 #endif /* __RIVAFB_H */




-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
