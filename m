From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 1/8] fbdev: Fix IO access in rivafb (part 2)
Date: Sun, 7 Nov 2004 22:41:36 +0800
Message-ID: <20041107213313.B9C9311C6021@smtp-3.hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CQufh-00046X-Lw
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Nov 2004 13:34:01 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CQuff-0008G8-5K
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Nov 2004 13:34:01 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id D51D49BF046
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun,  7 Nov 2004 21:33:19 +0000 (UTC)
Content-Disposition: inline
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Convert direct pointer manipulation to NV_RD*/NV_WR* in nv_driver.c

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 nv_driver.c |   87 +++++++++++++++++++++++++++++++++---------------------------
 1 files changed, 49 insertions(+), 38 deletions(-)

diff -Nru a/drivers/video/riva/nv_driver.c b/drivers/video/riva/nv_driver.c
--- a/drivers/video/riva/nv_driver.c	2004-10-30 19:10:42 +08:00
+++ b/drivers/video/riva/nv_driver.c	2004-11-06 17:42:25 +08:00
@@ -56,32 +56,33 @@
 static Bool 
 riva_is_connected(struct riva_par *par, Bool second)
 {
-	volatile U032 *PRAMDAC = par->riva.PRAMDAC0;
+	volatile U032 __iomem *PRAMDAC = par->riva.PRAMDAC0;
 	U032 reg52C, reg608;
 	Bool present;
 
 	if(second) PRAMDAC += 0x800;
 
-	reg52C = PRAMDAC[0x052C/4];
-	reg608 = PRAMDAC[0x0608/4];
+	reg52C = NV_RD32(PRAMDAC, 0x052C);
+	reg608 = NV_RD32(PRAMDAC, 0x0608);
 
-	PRAMDAC[0x0608/4] = reg608 & ~0x00010000;
+	NV_WR32(PRAMDAC, 0x0608, reg608 & ~0x00010000);
 
-	PRAMDAC[0x052C/4] = reg52C & 0x0000FEEE;
+	NV_WR32(PRAMDAC, 0x052C, reg52C & 0x0000FEEE);
 	mdelay(1); 
-	PRAMDAC[0x052C/4] |= 1;
+	NV_WR32(PRAMDAC, 0x052C, NV_RD32(PRAMDAC, 0x052C) | 1);
 
-	par->riva.PRAMDAC0[0x0610/4] = 0x94050140;
-	par->riva.PRAMDAC0[0x0608/4] |= 0x00001000;
+	NV_WR32(par->riva.PRAMDAC0, 0x0610, 0x94050140);
+	NV_WR32(par->riva.PRAMDAC0, 0x0608, 0x00001000);
 
 	mdelay(1);
 
-	present = (PRAMDAC[0x0608/4] & (1 << 28)) ? TRUE : FALSE;
+	present = (NV_RD32(PRAMDAC, 0x0608) & (1 << 28)) ? TRUE : FALSE;
 
-	par->riva.PRAMDAC0[0x0608/4] &= 0x0000EFFF;
+	NV_WR32(par->riva.PRAMDAC0, 0x0608,
+		NV_RD32(par->riva.PRAMDAC0, 0x0608) & 0x0000EFFF);
 
-	PRAMDAC[0x052C/4] = reg52C;
-	PRAMDAC[0x0608/4] = reg608;
+	NV_WR32(PRAMDAC, 0x052C, reg52C);
+	NV_WR32(PRAMDAC, 0x0608, reg608);
 
 	return present;
 }
@@ -139,13 +140,14 @@
 		}
 	} else {
 		if(riva_is_connected(par, 0)) {
-			if(par->riva.PRAMDAC0[0x0000052C/4] & 0x100)
+
+			if (NV_RD32(par->riva.PRAMDAC0, 0x0000052C) & 0x100)
 				par->SecondCRTC = TRUE;
 			else
 				par->SecondCRTC = FALSE;
 		} else 
 		if (riva_is_connected(par, 1)) {
-			if(par->riva.PRAMDAC0[0x0000252C/4] & 0x100)
+			if(NV_RD32(par->riva.PRAMDAC0, 0x0000252C) & 0x100)
 				par->SecondCRTC = TRUE;
 			else
 				par->SecondCRTC = FALSE;
@@ -165,13 +167,13 @@
 
 	switch (chip->Architecture) {
 	case NV_ARCH_03:
-		if (chip->PFB[0x00000000/4] & 0x00000020) {
-			if (((chip->PMC[0x00000000/4] & 0xF0) == 0x20)
-			    && ((chip->PMC[0x00000000/4] & 0x0F) >= 0x02)) {
+		if (NV_RD32(chip->PFB, 0x00000000) & 0x00000020) {
+			if (((NV_RD32(chip->PMC, 0x00000000) & 0xF0) == 0x20)
+			    && ((NV_RD32(chip->PMC, 0x00000000)&0x0F)>=0x02)) {
 				/*
 				 * SDRAM 128 ZX.
 				 */
-				switch (chip->PFB[0x00000000/4] & 0x03) {
+				switch (NV_RD32(chip->PFB,0x00000000) & 0x03) {
 				case 2:
 					memlen = 1024 * 4;
 					break;
@@ -189,7 +191,7 @@
 			/*
 			 * SGRAM 128.
 			 */
-			switch (chip->PFB[0x00000000/4] & 0x00000003) {
+			switch (NV_RD32(chip->PFB, 0x00000000) & 0x00000003) {
 			case 0:
 				memlen = 1024 * 8;
 				break;
@@ -203,11 +205,11 @@
 		}        
 		break;
 	case NV_ARCH_04:
-		if (chip->PFB[0x00000000/4] & 0x00000100) {
-			memlen = ((chip->PFB[0x00000000/4] >> 12) & 0x0F) * 
+		if (NV_RD32(chip->PFB, 0x00000000) & 0x00000100) {
+			memlen = ((NV_RD32(chip->PFB, 0x00000000)>>12)&0x0F) *
 				1024 * 2 + 1024 * 2;
 		} else {
-			switch (chip->PFB[0x00000000/4] & 0x00000003) {
+			switch (NV_RD32(chip->PFB, 0x00000000) & 0x00000003) {
 			case 0:
 				memlen = 1024 * 32;
 				break;
@@ -237,7 +239,8 @@
 			pci_read_config_dword(dev, 0x84, &amt);
 			memlen = (((amt >> 4) & 127) + 1) * 1024;
 		} else {
-			switch ((chip->PFB[0x0000020C/4] >> 20) & 0x000000FF){
+			switch ((NV_RD32(chip->PFB, 0x0000020C) >> 20) &
+				0x000000FF){
 			case 0x02:
 				memlen = 1024 * 2;
 				break;
@@ -276,9 +279,9 @@
 
 	switch (chip->Architecture) {
 	case NV_ARCH_03:
-		if (chip->PFB[0x00000000/4] & 0x00000020) {
-			if (((chip->PMC[0x00000000/4] & 0xF0) == 0x20)
-			    && ((chip->PMC[0x00000000/4] & 0x0F) >= 0x02)) {   
+		if (NV_RD32(chip->PFB, 0x00000000) & 0x00000020) {
+			if (((NV_RD32(chip->PMC, 0x00000000) & 0xF0) == 0x20)
+			    && ((NV_RD32(chip->PMC,0x00000000)&0x0F) >= 0x02)) {
 				/*
 				 * SDRAM 128 ZX.
 				 */
@@ -297,7 +300,7 @@
 	case NV_ARCH_10:
 	case NV_ARCH_20:
 	case NV_ARCH_30:
-		switch ((chip->PFB[0x00000000/4] >> 3) & 0x00000003) {
+		switch ((NV_RD32(chip->PFB, 0x00000000) >> 3) & 0x00000003) {
 		case 3:
 			dclk = 800000;
 			break;
@@ -314,17 +317,25 @@
 riva_common_setup(struct riva_par *par)
 {
 	par->riva.EnableIRQ = 0;
-	par->riva.PRAMDAC0 = (unsigned *)(par->ctrl_base + 0x00680000);
-	par->riva.PFB = (unsigned *)(par->ctrl_base + 0x00100000);
-	par->riva.PFIFO = (unsigned *)(par->ctrl_base + 0x00002000);
-	par->riva.PGRAPH = (unsigned *)(par->ctrl_base + 0x00400000);
-	par->riva.PEXTDEV = (unsigned *)(par->ctrl_base + 0x00101000);
-	par->riva.PTIMER = (unsigned *)(par->ctrl_base + 0x00009000);
-	par->riva.PMC = (unsigned *)(par->ctrl_base + 0x00000000);
-	par->riva.FIFO = (unsigned *)(par->ctrl_base + 0x00800000);
-	par->riva.PCIO0 = (U008 *)(par->ctrl_base + 0x00601000);
-	par->riva.PDIO0 = (U008 *)(par->ctrl_base + 0x00681000);
-	par->riva.PVIO = (U008 *)(par->ctrl_base + 0x000C0000);
+	par->riva.PRAMDAC0 =
+		(volatile U032 __iomem *)(par->ctrl_base + 0x00680000);
+	par->riva.PFB =
+		(volatile U032 __iomem *)(par->ctrl_base + 0x00100000);
+	par->riva.PFIFO =
+		(volatile U032 __iomem *)(par->ctrl_base + 0x00002000);
+	par->riva.PGRAPH =
+		(volatile U032 __iomem *)(par->ctrl_base + 0x00400000);
+	par->riva.PEXTDEV =
+		(volatile U032 __iomem *)(par->ctrl_base + 0x00101000);
+	par->riva.PTIMER =
+		(volatile U032 __iomem *)(par->ctrl_base + 0x00009000);
+	par->riva.PMC =
+		(volatile U032 __iomem *)(par->ctrl_base + 0x00000000);
+	par->riva.FIFO =
+		(volatile U032 __iomem *)(par->ctrl_base + 0x00800000);
+	par->riva.PCIO0 = par->ctrl_base + 0x00601000;
+	par->riva.PDIO0 = par->ctrl_base + 0x00681000;
+	par->riva.PVIO = par->ctrl_base + 0x000C0000;
 
 	par->riva.IO = (MISCin(par) & 0x01) ? 0x3D0 : 0x3B0;
 	




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
