From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6 patch] video/sis/: remove compat code
Date: Mon, 5 May 2008 21:25:57 +0300
Message-ID: <20080505182557.GV17139@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jt5P3-0000Cw-D6 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 May 2008 11:27:09 -0700
Received: from smtp4.pp.htv.fi ([213.243.153.38])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jt5P0-0006hS-CY
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 May 2008 11:27:09 -0700
Content-Disposition: inline
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
To: thomas@winischhofer.net, adaplas@gmail.com
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

This patch removes compat code for older kernel versions.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

This patch hasbeen sent on:
- 17 Apr 2008

 drivers/video/sis/init.h       |    1 
 drivers/video/sis/init301.h    |    1 
 drivers/video/sis/initextlfb.c |    1 
 drivers/video/sis/osdef.h      |    1 
 drivers/video/sis/sis.h        |   22 +++-------------
 drivers/video/sis/sis_accel.c  |    1 
 drivers/video/sis/sis_main.c   |   44 +++++++--------------------------
 drivers/video/sis/sis_main.h   |    4 +--
 drivers/video/sis/vgatypes.h   |    4 ---
 9 files changed, 17 insertions(+), 62 deletions(-)

2a64dba04671b006cfa32c17e4ec8ef02c177992 diff --git a/drivers/video/sis/init.h b/drivers/video/sis/init.h
index f40a680..b96005c 100644
--- a/drivers/video/sis/init.h
+++ b/drivers/video/sis/init.h
@@ -73,7 +73,6 @@
 #ifdef SIS_CP
 #undef SIS_CP
 #endif
-#include <linux/version.h>
 #include <linux/types.h>
 #include <asm/io.h>
 #include <linux/fb.h>
diff --git a/drivers/video/sis/init301.h b/drivers/video/sis/init301.h
index 7708e1e..51d9922 100644
--- a/drivers/video/sis/init301.h
+++ b/drivers/video/sis/init301.h
@@ -67,7 +67,6 @@
 #ifdef SIS_CP
 #undef SIS_CP
 #endif
-#include <linux/version.h>
 #include <linux/types.h>
 #include <asm/io.h>
 #include <linux/fb.h>
diff --git a/drivers/video/sis/initextlfb.c b/drivers/video/sis/initextlfb.c
index 47a3350..99c04a4 100644
--- a/drivers/video/sis/initextlfb.c
+++ b/drivers/video/sis/initextlfb.c
@@ -30,7 +30,6 @@
 #include "vgatypes.h"
 #include "vstruct.h"
 
-#include <linux/version.h>
 #include <linux/types.h>
 #include <linux/fb.h>
 
diff --git a/drivers/video/sis/osdef.h b/drivers/video/sis/osdef.h
index c149278..6ff8f98 100644
--- a/drivers/video/sis/osdef.h
+++ b/drivers/video/sis/osdef.h
@@ -87,7 +87,6 @@
 /**********************************************************************/
 
 #ifdef SIS_LINUX_KERNEL
-#include <linux/version.h>
 
 #ifdef CONFIG_FB_SIS_300
 #define SIS300
diff --git a/drivers/video/sis/sis.h b/drivers/video/sis/sis.h
index 9b05da6..6fcf8f5 100644
--- a/drivers/video/sis/sis.h
+++ b/drivers/video/sis/sis.h
@@ -24,8 +24,6 @@
 #ifndef _SIS_H_
 #define _SIS_H_
 
-#include <linux/version.h>
-
 #include "osdef.h"
 #include <video/sisfb.h>
 
@@ -42,16 +40,6 @@
 #define SIS_NEW_CONFIG_COMPAT
 #endif	/* CONFIG_COMPAT */
 
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,8)
-#define SIS_IOTYPE1 void __iomem
-#define SIS_IOTYPE2 __iomem
-#define SISINITSTATIC static
-#else
-#define SIS_IOTYPE1 unsigned char
-#define SIS_IOTYPE2
-#define SISINITSTATIC
-#endif
-
 #undef SISFBDEBUG
 
 #ifdef SISFBDEBUG
@@ -505,8 +493,8 @@ struct sis_video_info {
 
 	unsigned long	UMAsize, LFBsize;
 
-	SIS_IOTYPE1	*video_vbase;
-	SIS_IOTYPE1	*mmio_vbase;
+	void __iomem	*video_vbase;
+	void __iomem	*mmio_vbase;
 
 	unsigned char	*bios_abase;
 
@@ -533,8 +521,8 @@ struct sis_video_info {
 	int		sisfb_nocrt2rate;
 
 	u32		heapstart;		/* offset  */
-	SIS_IOTYPE1	*sisfb_heap_start;	/* address */
-	SIS_IOTYPE1	*sisfb_heap_end;	/* address */
+	void __iomem	*sisfb_heap_start;	/* address */
+	void __iomem	*sisfb_heap_end;	/* address */
 	u32		sisfb_heap_size;
 	int		havenoheap;
 
@@ -612,7 +600,7 @@ struct sis_video_info {
 	u8		detectedpdca;
 	u8		detectedlcda;
 
-	SIS_IOTYPE1	*hwcursor_vbase;
+	void __iomem	*hwcursor_vbase;
 
 	int		chronteltype;
 	int		tvxpos, tvypos;
diff --git a/drivers/video/sis/sis_accel.c b/drivers/video/sis/sis_accel.c
index 7addf91..ceb434c 100644
--- a/drivers/video/sis/sis_accel.c
+++ b/drivers/video/sis/sis_accel.c
@@ -28,7 +28,6 @@
  *			for more information and updates)
  */
 
-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/fb.h>
diff --git a/drivers/video/sis/sis_main.c b/drivers/video/sis/sis_main.c
index 7380362..cad2095 100644
--- a/drivers/video/sis/sis_main.c
+++ b/drivers/video/sis/sis_main.c
@@ -33,7 +33,6 @@
  *
  */
 
-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/kernel.h>
@@ -41,13 +40,7 @@
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,17)
-#include <linux/tty.h>
-#else
 #include <linux/screen_info.h>
-#endif
-
 #include <linux/slab.h>
 #include <linux/fb.h>
 #include <linux/selection.h>
@@ -1167,11 +1160,7 @@ sisfb_set_mode(struct sis_video_info *ivideo, int clrscrn)
 	unsigned short modeno = ivideo->mode_no;
 
 	/* >=2.6.12's fbcon clears the screen anyway */
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,12)
-	if(!clrscrn) modeno |= 0x80;
-#else
 	modeno |= 0x80;
-#endif
 
 	outSISIDXREG(SISSR, IND_SIS_PASSWORD, SIS_PASSWORD);
 
@@ -1436,11 +1425,8 @@ sisfb_set_par(struct fb_info *info)
 	if((err = sisfb_do_set_var(&info->var, 1, info)))
 		return err;
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,10)
-	sisfb_get_fix(&info->fix, info->currcon, info);
-#else
 	sisfb_get_fix(&info->fix, -1, info);
-#endif
+
 	return 0;
 }
 
@@ -1676,14 +1662,8 @@ sisfb_blank(int blank, struct fb_info *info)
 
 /* ----------- FBDev related routines for all series ---------- */
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,15)
 static int	sisfb_ioctl(struct fb_info *info, unsigned int cmd,
 			    unsigned long arg)
-#else
-static int	sisfb_ioctl(struct inode *inode, struct file *file,
-				unsigned int cmd, unsigned long arg,
-				struct fb_info *info)
-#endif
 {
 	struct sis_video_info	*ivideo = (struct sis_video_info *)info->par;
 	struct sis_memreq	sismemreq;
@@ -3986,8 +3966,7 @@ sisfb_handle_command(struct sis_video_info *ivideo, struct sisfb_cmd *sisfb_comm
 }
 
 #ifndef MODULE
-SISINITSTATIC int __init
-sisfb_setup(char *options)
+static int __init sisfb_setup(char *options)
 {
 	char *this_opt;
 
@@ -4086,9 +4065,9 @@ sisfb_setup(char *options)
 #endif
 
 static int __devinit
-sisfb_check_rom(SIS_IOTYPE1 *rom_base, struct sis_video_info *ivideo)
+sisfb_check_rom(void __iomem *rom_base, struct sis_video_info *ivideo)
 {
-	SIS_IOTYPE1 *rom;
+	void __iomem *rom;
 	int romptr;
 
 	if((readb(rom_base) != 0x55) || (readb(rom_base + 1) != 0xaa))
@@ -4117,10 +4096,9 @@ static unsigned char * __devinit
 sisfb_find_rom(struct pci_dev *pdev)
 {
 	struct sis_video_info *ivideo = pci_get_drvdata(pdev);
-	SIS_IOTYPE1 *rom_base;
+	void __iomem *rom_base;
 	unsigned char *myrombase = NULL;
 	u32 temp;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,11)
 	size_t romsize;
 
 	/* First, try the official pci ROM functions (except
@@ -4151,7 +4129,6 @@ sisfb_find_rom(struct pci_dev *pdev)
 	}
 
 	if(myrombase) return myrombase;
-#endif
 
 	/* Otherwise do it the conventional way. */
 
@@ -4225,7 +4202,7 @@ sisfb_post_map_vram(struct sis_video_info *ivideo, unsigned int *mapsize,
 static int __devinit
 sisfb_post_300_buswidth(struct sis_video_info *ivideo)
 {
-	SIS_IOTYPE1 *FBAddress = ivideo->video_vbase;
+	void __iomem *FBAddress = ivideo->video_vbase;
 	unsigned short temp;
 	unsigned char reg;
 	int i, j;
@@ -4273,7 +4250,7 @@ sisfb_post_300_rwtest(struct sis_video_info *ivideo, int iteration, int buswidth
 			int PseudoRankCapacity, int PseudoAdrPinCount,
 			unsigned int mapsize)
 {
-	SIS_IOTYPE1 *FBAddr = ivideo->video_vbase;
+	void __iomem *FBAddr = ivideo->video_vbase;
 	unsigned short sr14;
 	unsigned int k, RankCapacity, PageCapacity, BankNumHigh, BankNumMid;
 	unsigned int PhysicalAdrOtherPage, PhysicalAdrHigh, PhysicalAdrHalfPage;
@@ -5829,7 +5806,7 @@ sisfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	ivideo->engineok = 0;
 
 	ivideo->sisfb_was_boot_device = 0;
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,12))
+
 	if(pdev->resource[PCI_ROM_RESOURCE].flags & IORESOURCE_ROM_SHADOW) {
 		if(ivideo->sisvga_enabled)
 			ivideo->sisfb_was_boot_device = 1;
@@ -5840,7 +5817,6 @@ sisfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 				"as the primary VGA device\n");
 		}
 	}
-#endif
 
 	ivideo->sisfb_parm_mem = sisfb_parm_mem;
 	ivideo->sisfb_accel = sisfb_accel;
@@ -6010,7 +5986,7 @@ sisfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		ivideo->modeprechange = reg & 0x7f;
 	} else if(ivideo->sisvga_enabled) {
 #if defined(__i386__) || defined(__x86_64__)
-		unsigned char SIS_IOTYPE2 *tt = ioremap(0x400, 0x100);
+		unsigned char __iomem *tt = ioremap(0x400, 0x100);
 		if(tt) {
 			ivideo->modeprechange = readb(tt + 0x49);
 			iounmap(tt);
@@ -6503,7 +6479,7 @@ static struct pci_driver sisfb_driver = {
 	.remove 	= __devexit_p(sisfb_remove)
 };
 
-SISINITSTATIC int __init sisfb_init(void)
+static int __init sisfb_init(void)
 {
 #ifndef MODULE
 	char *options = NULL;
diff --git a/drivers/video/sis/sis_main.h b/drivers/video/sis/sis_main.h
index 3e3b7fa..9540e97 100644
--- a/drivers/video/sis/sis_main.h
+++ b/drivers/video/sis/sis_main.h
@@ -665,11 +665,11 @@ static struct _customttable {
 
 /* Interface used by the world */
 #ifndef MODULE
-SISINITSTATIC int sisfb_setup(char *options);
+static int sisfb_setup(char *options);
 #endif
 
 /* Interface to the low level console driver */
-SISINITSTATIC int sisfb_init(void);
+static int sisfb_init(void);
 
 /* fbdev routines */
 static int	sisfb_get_fix(struct fb_fix_screeninfo *fix, int con,
diff --git a/drivers/video/sis/vgatypes.h b/drivers/video/sis/vgatypes.h
index b532fbd..81a22ea 100644
--- a/drivers/video/sis/vgatypes.h
+++ b/drivers/video/sis/vgatypes.h
@@ -53,10 +53,6 @@
 #ifndef _VGATYPES_H_
 #define _VGATYPES_H_
 
-#ifdef SIS_LINUX_KERNEL
-#include <linux/version.h>
-#endif
-
 #define SISIOMEMTYPE
 
 #ifdef SIS_LINUX_KERNEL


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
