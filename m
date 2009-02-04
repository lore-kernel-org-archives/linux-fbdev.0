From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] cirrusfb: fix Laguna chipset memory
 detection and clock setting
Date: Wed, 4 Feb 2009 17:39:57 +0100
Message-ID: <20090204173957.68e3845a.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1LUkjV-0001Z4-I2
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 04 Feb 2009 16:36:13 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LUkjS-0007Ti-A9 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 04 Feb 2009 16:36:13 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@linux-foundation.org>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Fix memory detection and clock setting
for Cirrus Laguna chipsets (GD5464/GD5465).
The changes are done after the Xorg code.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
The driver still does not display anything on the GD5465 but
it switches resolutions correctly at least.

 drivers/video/cirrusfb.c |   65 +++++++++++++++++++++++++++-------------------
 1 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
index 7ab555a..7e477d7 100644
--- a/drivers/video/cirrusfb.c
+++ b/drivers/video/cirrusfb.c
@@ -867,19 +867,24 @@ static int cirrusfb_set_par_foo(struct fb_info *info)
 		}
 	}
 	if (nom) {
-		vga_wseq(regbase, CL_SEQRB, nom);
 		tmp = den << 1;
 		if (div != 0)
 			tmp |= 1;
-
 		/* 6 bit denom; ONLY 5434!!! (bugged me 10 days) */
 		if ((cinfo->btype == BT_SD64) ||
 		    (cinfo->btype == BT_ALPINE) ||
 		    (cinfo->btype == BT_GD5480))
 			tmp |= 0x80;
 
-		dev_dbg(info->device, "CL_SEQR1B: %ld\n", (long) tmp);
-		vga_wseq(regbase, CL_SEQR1B, tmp);
+		dev_dbg(info->device, "CL_SEQR1B: %d\n", (int) tmp);
+		/* Laguna chipset has reversed clock registers */
+		if (cinfo->btype == BT_LAGUNA) {
+			vga_wseq(regbase, CL_SEQRE, tmp);
+			vga_wseq(regbase, CL_SEQR1E, nom);
+		} else {
+			vga_wseq(regbase, CL_SEQRB, nom);
+			vga_wseq(regbase, CL_SEQR1B, tmp);
+		}
 	}
 
 	if (yres >= 1024)
@@ -1917,31 +1922,37 @@ static unsigned int __devinit cirrusfb_get_memsize(struct fb_info *info,
 						   u8 __iomem *regbase)
 {
 	unsigned long mem;
-	unsigned char SRF;
+	struct cirrusfb_info *cinfo = info->par;
 
-	SRF = vga_rseq(regbase, CL_SEQRF);
-	switch ((SRF & 0x18)) {
-	case 0x08:
-		mem = 512 * 1024;
-		break;
-	case 0x10:
-		mem = 1024 * 1024;
-		break;
-	/* 64-bit DRAM data bus width; assume 2MB. Also indicates 2MB memory
-	 * on the 5430.
-	 */
-	case 0x18:
-		mem = 2048 * 1024;
-		break;
-	default:
-		dev_warn(info->device, "CLgenfb: Unknown memory size!\n");
-		mem = 1024 * 1024;
+	if (cinfo->btype == BT_LAGUNA) {
+		unsigned char SR14 = vga_rseq(regbase, CL_SEQR14);
+
+		mem = ((SR14 & 7) + 1) << 20;
+	} else {
+		unsigned char SRF = vga_rseq(regbase, CL_SEQRF);
+		switch ((SRF & 0x18)) {
+		case 0x08:
+			mem = 512 * 1024;
+			break;
+		case 0x10:
+			mem = 1024 * 1024;
+			break;
+		/* 64-bit DRAM data bus width; assume 2MB.
+		 * Also indicates 2MB memory on the 5430.
+		 */
+		case 0x18:
+			mem = 2048 * 1024;
+			break;
+		default:
+			dev_warn(info->device, "Unknown memory size!\n");
+			mem = 1024 * 1024;
+		}
+		/* If DRAM bank switching is enabled, there must be
+		 * twice as much memory installed. (4MB on the 5434)
+		 */
+		if (SRF & 0x80)
+			mem *= 2;
 	}
-	if (SRF & 0x80)
-	/* If DRAM bank switching is enabled, there must be twice as much
-	 * memory installed. (4MB on the 5434)
-	 */
-		mem *= 2;
 
 	/* TODO: Handling of GD5446/5480 (see XF86 sources ...) */
 	return mem;
-- 
1.5.2.2


----------------------------------------------------------------------
Nie boj sie przyszlosci!
Zapytaj wrozke >>  http://link.interia.pl/f2049 


------------------------------------------------------------------------------
Create and Deploy Rich Internet Apps outside the browser with Adobe(R)AIR(TM)
software. With Adobe AIR, Ajax developers can use existing skills and code to
build responsive, highly engaging applications that combine the power of local
resources and data with the reach of the web. Download the Adobe AIR SDK and
Ajax docs to start building applications today-http://p.sf.net/sfu/adobe-com
