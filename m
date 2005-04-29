From: akpm@osdl.org
Subject: patch clean-up-and-bug-fix-for-tdfxfb-framebuffer-size-detection.patch added to -mm tree
Date: Fri, 29 Apr 2005 16:20:27 -0700
Message-ID: <200504292319.j3TNJupI011596@shell0.pdx.osdl.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DRem9-0000wk-0G
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Apr 2005 16:20:01 -0700
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DRem6-0007t6-Db
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Apr 2005 16:20:00 -0700
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: evilrich@rcdrummond.net, linux-fbdev-devel@lists.sourceforge.net


This is a note to let you know that I've just added the patch titled

     Clean-up and bug fix for tdfxfb framebuffer size detection

to the -mm tree.  Its filename is

     clean-up-and-bug-fix-for-tdfxfb-framebuffer-size-detection.patch

Patches currently in -mm which might be from evilrich@rcdrummond.net are

better-pll-frequency-matching-for-tdfxfb-driver.patch
clean-up-and-bug-fix-for-tdfxfb-framebuffer-size-detection.patch



From: Richard Drummond <evilrich@rcdrummond.net>

Attached is a patch against 2.6.11.7 which tidies up the tdfxfb framebuffer
size detection code a little and fixes the broken support for Voodoo4/5
cards.  (I haven't tested this on a Voodoo5, however, because I don't have
the hardware).

Signed-off-by: Richard Drummond <evilrich@rcdrummond.net>
Cc: <linux-fbdev-devel@lists.sourceforge.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/video/tdfxfb.c |   43 +++++++++++++++++++++----------------------
 include/video/tdfx.h   |    2 ++
 2 files changed, 23 insertions(+), 22 deletions(-)

diff -puN drivers/video/tdfxfb.c~clean-up-and-bug-fix-for-tdfxfb-framebuffer-size-detection drivers/video/tdfxfb.c
--- 25/drivers/video/tdfxfb.c~clean-up-and-bug-fix-for-tdfxfb-framebuffer-size-detection	Fri Apr 29 16:19:43 2005
+++ 25-akpm/drivers/video/tdfxfb.c	Fri Apr 29 16:19:43 2005
@@ -430,36 +430,35 @@ static void do_write_regs(struct fb_info
 
 static unsigned long do_lfb_size(struct tdfx_par *par, unsigned short dev_id) 
 {
-	u32 draminit0 = 0;
-	u32 draminit1 = 0;
-	u32 miscinit1 = 0;
-	u32 lfbsize   = 0;
-	int sgram_p   = 0;
+	u32 draminit0;
+	u32 draminit1;
+	u32 miscinit1;
+
+	int num_chips;
+	int chip_size; /* in MB */
+	u32 lfbsize;
+	int has_sgram;
 
 	draminit0 = tdfx_inl(par, DRAMINIT0);  
 	draminit1 = tdfx_inl(par, DRAMINIT1);
+
+	num_chips = (draminit0 & DRAMINIT0_SGRAM_NUM) ? 8 : 4;
  
-	if ((dev_id == PCI_DEVICE_ID_3DFX_BANSHEE) ||
-	    (dev_id == PCI_DEVICE_ID_3DFX_VOODOO3)) {             	 
-		sgram_p = (draminit1 & DRAMINIT1_MEM_SDRAM) ? 0 : 1;
-  
-	lfbsize = sgram_p ?
-		(((draminit0 & DRAMINIT0_SGRAM_NUM)  ? 2 : 1) * 
-		((draminit0 & DRAMINIT0_SGRAM_TYPE) ? 8 : 4) * 1024 * 1024) :
-		16 * 1024 * 1024;
+	if (dev_id < PCI_DEVICE_ID_3DFX_VOODOO5) {
+		/* Banshee/Voodoo3 */
+		has_sgram = draminit1 & DRAMINIT1_MEM_SDRAM;
+		chip_size = has_sgram ? ((draminit0 & DRAMINIT0_SGRAM_TYPE) ? 2 : 1)
+				      : 2;
 	} else {
 		/* Voodoo4/5 */
-		u32 chips, psize, banks;
+		has_sgram = 0;
+		chip_size = 1 << ((draminit0 & DRAMINIT0_SGRAM_TYPE_MASK) >> DRAMINIT0_SGRAM_TYPE_SHIFT);
+	}
+	lfbsize = num_chips * chip_size * 1024 * 1024;
 
-		chips = ((draminit0 & (1 << 26)) == 0) ? 4 : 8;
-		psize = 1 << ((draminit0 & 0x38000000) >> 28);
-		banks = ((draminit0 & (1 << 30)) == 0) ? 2 : 4;
-		lfbsize = chips * psize * banks;
-		lfbsize <<= 20;
-	}                 
-	/* disable block writes for SDRAM (why?) */
+	/* disable block writes for SDRAM */
 	miscinit1 = tdfx_inl(par, MISCINIT1);
-	miscinit1 |= sgram_p ? 0 : MISCINIT1_2DBLOCK_DIS;
+	miscinit1 |= has_sgram ? 0 : MISCINIT1_2DBLOCK_DIS;
 	miscinit1 |= MISCINIT1_CLUT_INV;
 
 	banshee_make_room(par, 1); 
diff -puN include/video/tdfx.h~clean-up-and-bug-fix-for-tdfxfb-framebuffer-size-detection include/video/tdfx.h
--- 25/include/video/tdfx.h~clean-up-and-bug-fix-for-tdfxfb-framebuffer-size-detection	Fri Apr 29 16:19:43 2005
+++ 25-akpm/include/video/tdfx.h	Fri Apr 29 16:19:43 2005
@@ -99,6 +99,8 @@
 #define MISCINIT1_2DBLOCK_DIS           BIT(15)
 #define DRAMINIT0_SGRAM_NUM             BIT(26)
 #define DRAMINIT0_SGRAM_TYPE            BIT(27)
+#define DRAMINIT0_SGRAM_TYPE_MASK       (BIT(27)|BIT(28)|BIT(29))
+#define DRAMINIT0_SGRAM_TYPE_SHIFT      27
 #define DRAMINIT1_MEM_SDRAM             BIT(30)
 #define VGAINIT0_VGA_DISABLE            BIT(0)
 #define VGAINIT0_EXT_TIMING             BIT(1)
_


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
