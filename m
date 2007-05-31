From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 3/8] nvidiafb: Add proper support for
	Geforce 7600 chipset
Date: Thu, 31 May 2007 20:59:43 +0800
Message-ID: <465EC6BF.6070008@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HtkQA-0001HN-EJ for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 May 2007 06:10:30 -0700
Received: from wr-out-0506.google.com ([64.233.184.231])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HtkQ9-0005Jc-PU
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 May 2007 06:10:30 -0700
Received: by wr-out-0506.google.com with SMTP id 76so143940wra
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 31 May 2007 06:10:27 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Jurriaan <thunder7@xs4all.nl>

Add proper support for the Geforce 7600 (device id 0x039x).  This also sync's
nvidiafb with the latest Xorg nv driver.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---
Michal,

Can you test this patch? It might directly impact your 7300.

Thanks.

 drivers/video/nvidia/nv_hw.c    |   62 +++++++++++++++++++++++++++------------
 drivers/video/nvidia/nv_setup.c |   12 ++++----
 drivers/video/nvidia/nv_type.h  |    1 +
 drivers/video/nvidia/nvidia.c   |    7 ++--
 4 files changed, 54 insertions(+), 28 deletions(-)

diff --git a/drivers/video/nvidia/nv_hw.c b/drivers/video/nvidia/nv_hw.c
index aff11bb..d1a1054 100644
--- a/drivers/video/nvidia/nv_hw.c
+++ b/drivers/video/nvidia/nv_hw.c
@@ -150,8 +150,7 @@ static void nvGetClocks(struct nvidia_pa
 		M = pll & 0xFF;
 		N = (pll >> 8) & 0xFF;
 		if (((par->Chipset & 0xfff0) == 0x0290) ||
-			((par->Chipset & 0xfff0) == 0x0390) ||
-			((par->Chipset & 0xfff0) == 0x02E0)) {
+		    ((par->Chipset & 0xfff0) == 0x0390)) {
 			MB = 1;
 			NB = 1;
 		} else {
@@ -161,7 +160,7 @@ static void nvGetClocks(struct nvidia_pa
 		*MClk = ((N * NB * par->CrystalFreqKHz) / (M * MB)) >> P;
 
 		pll = NV_RD32(par->PMC, 0x4000);
-		P = (pll >> 16) & 0x03;
+		P = (pll >> 16) & 0x07;
 		pll = NV_RD32(par->PMC, 0x4004);
 		M = pll & 0xFF;
 		N = (pll >> 8) & 0xFF;
@@ -892,11 +891,17 @@ void NVCalcStateExt(struct nvidia_par *p
 		state->general = bpp == 16 ? 0x00101100 : 0x00100100;
 		state->repaint1 = hDisplaySize < 1280 ? 0x04 : 0x00;
 		break;
+	case NV_ARCH_40:
+		if (!par->FlatPanel)
+			state->control = NV_RD32(par->PRAMDAC0, 0x0580) &
+				0xeffffeff;
+		/* fallthrough */
 	case NV_ARCH_10:
 	case NV_ARCH_20:
 	case NV_ARCH_30:
 	default:
-		if ((par->Chipset & 0xfff0) == 0x0240) {
+		if ((par->Chipset & 0xfff0) == 0x0240 ||
+		    (par->Chipset & 0xfff0) == 0x03d0) {
 			state->arbitration0 = 256;
 			state->arbitration1 = 0x0480;
 		} else if (((par->Chipset & 0xffff) == 0x01A0) ||
@@ -939,7 +944,7 @@ void NVCalcStateExt(struct nvidia_par *p
 
 void NVLoadStateExt(struct nvidia_par *par, RIVA_HW_STATE * state)
 {
-	int i;
+	int i, j;
 
 	NV_WR32(par->PMC, 0x0140, 0x00000000);
 	NV_WR32(par->PMC, 0x0200, 0xFFFF00FF);
@@ -951,7 +956,8 @@ void NVLoadStateExt(struct nvidia_par *p
 	NV_WR32(par->PTIMER, 0x0100 * 4, 0xFFFFFFFF);
 
 	if (par->Architecture == NV_ARCH_04) {
-		NV_WR32(par->PFB, 0x0200, state->config);
+		if (state)
+			NV_WR32(par->PFB, 0x0200, state->config);
 	} else if ((par->Architecture < NV_ARCH_40) ||
 		   (par->Chipset & 0xfff0) == 0x0040) {
 		for (i = 0; i < 8; i++) {
@@ -964,8 +970,9 @@ void NVLoadStateExt(struct nvidia_par *p
 
 		if (((par->Chipset & 0xfff0) == 0x0090) ||
 		    ((par->Chipset & 0xfff0) == 0x01D0) ||
-		    ((par->Chipset & 0xfff0) == 0x02E0) ||
-		    ((par->Chipset & 0xfff0) == 0x0290))
+		    ((par->Chipset & 0xfff0) == 0x0290) ||
+		    ((par->Chipset & 0xfff0) == 0x0390) ||
+		    ((par->Chipset & 0xfff0) == 0x03D0))
 			regions = 15;
 		for(i = 0; i < regions; i++) {
 			NV_WR32(par->PFB, 0x0600 + (i * 0x10), 0);
@@ -1206,16 +1213,20 @@ #endif
 			NV_WR32(par->PGRAPH, 0x0608, 0xFFFFFFFF);
 		} else {
 			if (par->Architecture >= NV_ARCH_40) {
-				u32 tmp;
-
 				NV_WR32(par->PGRAPH, 0x0084, 0x401287c0);
 				NV_WR32(par->PGRAPH, 0x008C, 0x60de8051);
 				NV_WR32(par->PGRAPH, 0x0090, 0x00008000);
 				NV_WR32(par->PGRAPH, 0x0610, 0x00be3c5f);
+				NV_WR32(par->PGRAPH, 0x0bc4,
+					NV_RD32(par->PGRAPH, 0x0bc4) |
+					0x00008000);
 
-				tmp = NV_RD32(par->REGS, 0x1540) & 0xff;
-				for(i = 0; tmp && !(tmp & 1); tmp >>= 1, i++);
-				NV_WR32(par->PGRAPH, 0x5000, i);
+				j = NV_RD32(par->REGS, 0x1540) & 0xff;
+
+				if (j) {
+					for (i = 0; !(j & 1); j >>= 1, i++);
+					NV_WR32(par->PGRAPH, 0x5000, i);
+				}
 
 				if ((par->Chipset & 0xfff0) == 0x0040) {
 					NV_WR32(par->PGRAPH, 0x09b0,
@@ -1250,6 +1261,7 @@ #endif
 				case 0x0160:
 				case 0x01D0:
 				case 0x0240:
+				case 0x03D0:
 					NV_WR32(par->PMC, 0x1700,
 						NV_RD32(par->PFB, 0x020C));
 					NV_WR32(par->PMC, 0x1704, 0);
@@ -1269,7 +1281,6 @@ #endif
 						0x00000108);
 					break;
 				case 0x0220:
-				case 0x0230:
 					NV_WR32(par->PGRAPH, 0x0860, 0);
 					NV_WR32(par->PGRAPH, 0x0864, 0);
 					NV_WR32(par->PRAMDAC, 0x0608,
@@ -1277,8 +1288,8 @@ #endif
 						0x00100000);
 					break;
 				case 0x0090:
-				case 0x02E0:
 				case 0x0290:
+				case 0x0390:
 					NV_WR32(par->PRAMDAC, 0x0608,
 						NV_RD32(par->PRAMDAC, 0x0608) |
 						0x00100000);
@@ -1355,8 +1366,9 @@ #endif
 			} else {
 				if (((par->Chipset & 0xfff0) == 0x0090) ||
 				    ((par->Chipset & 0xfff0) == 0x01D0) ||
-				    ((par->Chipset & 0xfff0) == 0x02E0) ||
-				    ((par->Chipset & 0xfff0) == 0x0290)) {
+				    ((par->Chipset & 0xfff0) == 0x0290) ||
+				    ((par->Chipset & 0xfff0) == 0x0390) ||
+				    ((par->Chipset & 0xfff0) == 0x03D0)) {
 					for (i = 0; i < 60; i++) {
 						NV_WR32(par->PGRAPH,
 							0x0D00 + i*4,
@@ -1407,8 +1419,8 @@ #endif
 				} else {
 					if ((par->Chipset & 0xfff0) == 0x0090 ||
 					    (par->Chipset & 0xfff0) == 0x01D0 ||
-					    (par->Chipset & 0xfff0) == 0x02E0 ||
-					    (par->Chipset & 0xfff0) == 0x0290) {
+					    (par->Chipset & 0xfff0) == 0x0290 ||
+					    (par->Chipset & 0xfff0) == 0x0390) {
 						NV_WR32(par->PGRAPH, 0x0DF0,
 							NV_RD32(par->PFB, 0x0200));
 						NV_WR32(par->PGRAPH, 0x0DF4,
@@ -1495,6 +1507,12 @@ #endif
 	NV_WR32(par->PFIFO, 0x0494 * 4, 0x00000001);
 	NV_WR32(par->PFIFO, 0x0495 * 4, 0x00000001);
 	NV_WR32(par->PFIFO, 0x0140 * 4, 0x00000001);
+
+    if (!state) {
+	    par->CurrentState = NULL;
+	    return;
+    }
+
 	if (par->Architecture >= NV_ARCH_10) {
 		if (par->twoHeads) {
 			NV_WR32(par->PCRTC0, 0x0860, state->head);
@@ -1566,6 +1584,9 @@ #endif
 	VGA_WR08(par->PCIO, 0x03D5, state->interlace);
 
 	if (!par->FlatPanel) {
+		if (par->Architecture >= NV_ARCH_40)
+			NV_WR32(par->PRAMDAC0, 0x0580, state->control);
+
 		NV_WR32(par->PRAMDAC0, 0x050C, state->pllsel);
 		NV_WR32(par->PRAMDAC0, 0x0508, state->vpll);
 		if (par->twoHeads)
@@ -1631,6 +1652,9 @@ void NVUnloadStateExt(struct nvidia_par 
 	state->scale = NV_RD32(par->PRAMDAC, 0x0848);
 	state->config = NV_RD32(par->PFB, 0x0200);
 
+	if (par->Architecture >= NV_ARCH_40 && !par->FlatPanel)
+		state->control  = NV_RD32(par->PRAMDAC0, 0x0580);
+
 	if (par->Architecture >= NV_ARCH_10) {
 		if (par->twoHeads) {
 			state->head = NV_RD32(par->PCRTC0, 0x0860);
diff --git a/drivers/video/nvidia/nv_setup.c b/drivers/video/nvidia/nv_setup.c
index 707e2c8..82579d3 100644
--- a/drivers/video/nvidia/nv_setup.c
+++ b/drivers/video/nvidia/nv_setup.c
@@ -166,11 +166,13 @@ u8 NVReadDacData(struct nvidia_par *par)
 static int NVIsConnected(struct nvidia_par *par, int output)
 {
 	volatile u32 __iomem *PRAMDAC = par->PRAMDAC0;
-	u32 reg52C, reg608;
+	u32 reg52C, reg608, dac0_reg608 = 0;
 	int present;
 
-	if (output)
-		PRAMDAC += 0x800;
+	if (output) {
+	    dac0_reg608 = NV_RD32(PRAMDAC, 0x0608);
+	    PRAMDAC += 0x800;
+	}
 
 	reg52C = NV_RD32(PRAMDAC, 0x052C);
 	reg608 = NV_RD32(PRAMDAC, 0x0608);
@@ -194,8 +196,8 @@ static int NVIsConnected(struct nvidia_p
 	else
 		printk("nvidiafb: CRTC%i analog not found\n", output);
 
-	NV_WR32(par->PRAMDAC0, 0x0608, NV_RD32(par->PRAMDAC0, 0x0608) &
-		0x0000EFFF);
+	if (output)
+	    NV_WR32(par->PRAMDAC0, 0x0608, dac0_reg608);
 
 	NV_WR32(PRAMDAC, 0x052C, reg52C);
 	NV_WR32(PRAMDAC, 0x0608, reg608);
diff --git a/drivers/video/nvidia/nv_type.h b/drivers/video/nvidia/nv_type.h
index 38f7cc0..2fdf77e 100644
--- a/drivers/video/nvidia/nv_type.h
+++ b/drivers/video/nvidia/nv_type.h
@@ -86,6 +86,7 @@ typedef struct _riva_hw_state {
 	u32 timingV;
 	u32 displayV;
 	u32 crtcSync;
+	u32 control;
 } RIVA_HW_STATE;
 
 struct riva_regs {
diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
index 8c3a253..a7fe214 100644
--- a/drivers/video/nvidia/nvidia.c
+++ b/drivers/video/nvidia/nvidia.c
@@ -1195,7 +1195,8 @@ static u32 __devinit nvidia_get_chipset(
 
 	printk(KERN_INFO PFX "Device ID: %x \n", id);
 
-	if ((id & 0xfff0) == 0x00f0) {
+	if ((id & 0xfff0) == 0x00f0 ||
+	    (id & 0xfff0) == 0x02e0) {
 		/* pci-e */
 		id = NV_RD32(par->REGS, 0x1800);
 
@@ -1240,18 +1241,16 @@ static u32 __devinit nvidia_get_arch(str
 	case 0x0040:		/* GeForce 6800 */
 	case 0x00C0:		/* GeForce 6800 */
 	case 0x0120:		/* GeForce 6800 */
-	case 0x0130:
 	case 0x0140:		/* GeForce 6600 */
 	case 0x0160:		/* GeForce 6200 */
 	case 0x01D0:		/* GeForce 7200, 7300, 7400 */
-	case 0x02E0:		/* GeForce 7300 GT */
 	case 0x0090:		/* GeForce 7800 */
 	case 0x0210:		/* GeForce 6800 */
 	case 0x0220:		/* GeForce 6200 */
-	case 0x0230:
 	case 0x0240:		/* GeForce 6100 */
 	case 0x0290:		/* GeForce 7900 */
 	case 0x0390:		/* GeForce 7600 */
+	case 0x03D0:
 		arch = NV_ARCH_40;
 		break;
 	case 0x0020:		/* TNT, TNT2 */



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
