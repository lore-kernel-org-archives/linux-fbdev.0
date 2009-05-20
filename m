From: Harald Welte <HaraldWelte@viatech.com>
Subject: [PATCH 15/15] viafb: Add support for 2D
	accelerated framebuffer on VX800/VX855
Date: Thu, 21 May 2009 04:28:53 +0800
Message-ID: <1242851333-325-15-git-send-email-HaraldWelte@viatech.com>
References: <1242851333-325-1-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-2-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-3-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-4-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-5-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-6-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-7-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-8-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-9-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-10-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-11-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-12-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-13-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-14-git-send-email-HaraldWelte@viatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <laforge@prithivi.openmoko.org>) id 1M6siQ-0002G2-44
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 May 2009 20:48:42 +0000
Received: from ganesha.gnumonks.org ([213.95.27.120])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M6siH-00074b-MH
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 May 2009 20:48:37 +0000
In-Reply-To: <1242851333-325-14-git-send-email-HaraldWelte@viatech.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Harald Welte <HaraldWelte@viatech.com>

From: Harald Welte <laforge@gnumonks.org>

The VX800/VX820 and the VX855/VX875 chipsets have a different 2D
acceleration engine called "M1".  The M1 engine has some subtle
(and some not-so-subtle) differences to the previous engines,
so support for accelerated framebuffer on those chipsets was
disabled so far.

This patch adds full support for the M1 engine to viafb.

Signed-off-by: Harald Welte <HaraldWelte@viatech.com>
---
 drivers/video/via/accel.c    |   72 ++++++++++++++++++++++++++++++++++++-----
 drivers/video/via/accel.h    |   40 +++++++++++++++++++++++
 drivers/video/via/viafbdev.c |    2 -
 3 files changed, 103 insertions(+), 11 deletions(-)

diff --git a/drivers/video/via/accel.c b/drivers/video/via/accel.c
index b3a414e..a4b66be 100644
--- a/drivers/video/via/accel.c
+++ b/drivers/video/via/accel.c
@@ -20,8 +20,34 @@
  */
 #include "global.h"
 
+/* Somehow, the M1 engine has the registers in slightly different
+ * locations than previous 2D acceleration engines */
+static u_int8_t via_m1_eng_reg[] = {
+	[VIA_REG_GECMD]		= VIA_REG_GECMD_M1,
+	[VIA_REG_GEMODE]	= VIA_REG_GEMODE_M1,
+	[VIA_REG_SRCPOS]	= VIA_REG_SRCPOS_M1,
+	[VIA_REG_DSTPOS]	= VIA_REG_DSTPOS_M1,
+	[VIA_REG_DIMENSION]	= VIA_REG_DIMENSION_M1,
+	[VIA_REG_PATADDR]	= VIA_REG_PATADDR_M1,
+	[VIA_REG_FGCOLOR]	= VIA_REG_FGCOLOR_M1,
+	[VIA_REG_BGCOLOR]	= VIA_REG_BGCOLOR_M1,
+	[VIA_REG_CLIPTL]	= VIA_REG_CLIPTL_M1,
+	[VIA_REG_CLIPBR]	= VIA_REG_CLIPBR_M1,
+	[VIA_REG_OFFSET]	= VIA_REG_OFFSET_M1,
+	[VIA_REG_KEYCONTROL]	= VIA_REG_KEYCONTROL_M1,
+	[VIA_REG_SRCBASE]	= VIA_REG_SRCBASE_M1,
+	[VIA_REG_DSTBASE]	= VIA_REG_DSTBASE_M1,
+	[VIA_REG_PITCH]		= VIA_REG_PITCH_M1,
+	[VIA_REG_MONOPAT0]	= VIA_REG_MONOPAT0_M1,
+	[VIA_REG_MONOPAT1]	= VIA_REG_MONOPAT1_M1,
+};
+
 void viafb_2d_writel(u_int32_t val, u_int32_t reg)
 {
+	if (viaparinfo->chip_info->twod_engine == VIA_2D_ENG_M1 &&
+	    reg < ARRAY_SIZE(via_m1_eng_reg))
+		reg = via_m1_eng_reg[reg];
+
 	writel(val, viaparinfo->io_virt + reg);
 }
 
@@ -41,16 +67,26 @@ void viafb_init_2d_engine(void)
 {
 	u32 dwVQStartAddr, dwVQEndAddr;
 	u32 dwVQLen, dwVQStartL, dwVQEndL, dwVQStartEndH;
-	int i;
+	int i, highest_reg;
 
 	/* init 2D engine regs to reset 2D engine */
-	for (i = 0; i <= 0x40; i+= 4)
+	switch (viaparinfo->chip_info->twod_engine) {
+	case VIA_2D_ENG_M1:
+		highest_reg = 0x5c;
+		break;
+	default:
+		highest_reg = 0x40;
+		break;
+	}
+	for (i = 0; i <= highest_reg; i+= 4)
 		writel(0x0, viaparinfo->io_virt + i);
 
 	/* Init AGP and VQ regs */
 	switch (viaparinfo->chip_info->gfx_chip_name) {
 	case UNICHROME_K8M890:
 	case UNICHROME_P4M900:
+	case UNICHROME_VX800:
+	case UNICHROME_VX855:
 		writel(0x00100000, viaparinfo->io_virt + VIA_REG_CR_TRANSET);
 		writel(0x680A0000, viaparinfo->io_virt + VIA_REG_CR_TRANSPACE);
 		writel(0x02000000, viaparinfo->io_virt + VIA_REG_CR_TRANSPACE);
@@ -85,6 +121,8 @@ void viafb_init_2d_engine(void)
 		switch (viaparinfo->chip_info->gfx_chip_name) {
 		case UNICHROME_K8M890:
 		case UNICHROME_P4M900:
+		case UNICHROME_VX800:
+		case UNICHROME_VX855:
 			dwVQStartL |= 0x20000000;
 			dwVQEndL |= 0x20000000;
 			dwVQStartEndH |= 0x20000000;
@@ -97,6 +135,8 @@ void viafb_init_2d_engine(void)
 		switch (viaparinfo->chip_info->gfx_chip_name) {
 		case UNICHROME_K8M890:
 		case UNICHROME_P4M900:
+		case UNICHROME_VX800:
+		case UNICHROME_VX855:
 			writel(0x00100000,
 				viaparinfo->io_virt + VIA_REG_CR_TRANSET);
 			writel(dwVQStartEndH,
@@ -162,6 +202,8 @@ void viafb_init_2d_engine(void)
 		switch (viaparinfo->chip_info->gfx_chip_name) {
 		case UNICHROME_K8M890:
 		case UNICHROME_P4M900:
+		case UNICHROME_VX800:
+		case UNICHROME_VX855:
 			writel(0x00100000,
 				viaparinfo->io_virt + VIA_REG_CR_TRANSET);
 			writel(0x74301000,
@@ -216,7 +258,8 @@ void viafb_set_2d_mode(struct fb_info *info)
 	/* Set source and destination pitch (128bit aligned) */
 	pitch = (viaparinfo->hres * viaparinfo->bpp >> 3) >> 3;
 	pitch_reg = pitch | (pitch << 16);
-	pitch_reg |= VIA_PITCH_ENABLE;
+	if (viaparinfo->chip_info->twod_engine != VIA_2D_ENG_M1)
+		pitch_reg |= VIA_PITCH_ENABLE;
 	viafb_2d_writel(pitch_reg, VIA_REG_PITCH);
 }
 
@@ -259,15 +302,26 @@ void viafb_show_hw_cursor(struct fb_info *info, int Status)
 int viafb_wait_engine_idle(void)
 {
 	int loop = 0;
+	u_int32_t status_mask;
 
-	while (!(readl(viaparinfo->io_virt + VIA_REG_STATUS) &
-			VIA_VR_QUEUE_BUSY) && (loop < MAXLOOP)) {
-		loop++;
-		cpu_relax();
+	switch (viaparinfo->chip_info->twod_engine) {
+	case VIA_2D_ENG_H5:
+	case VIA_2D_ENG_M1:
+		status_mask = VIA_CMD_RGTR_BUSY_M1 | VIA_2D_ENG_BUSY_M1 |
+			      VIA_3D_ENG_BUSY_M1;
+		break;
+	default:
+		while (!(readl(viaparinfo->io_virt + VIA_REG_STATUS) &
+				VIA_VR_QUEUE_BUSY) && (loop < MAXLOOP)) {
+			loop++;
+			cpu_relax();
+		}
+		status_mask = VIA_CMD_RGTR_BUSY | VIA_2D_ENG_BUSY |
+			      VIA_3D_ENG_BUSY;
+		break;
 	}
 
-	while ((readl(viaparinfo->io_virt + VIA_REG_STATUS) &
-		    (VIA_CMD_RGTR_BUSY | VIA_2D_ENG_BUSY | VIA_3D_ENG_BUSY)) &&
+	while ((readl(viaparinfo->io_virt + VIA_REG_STATUS) & status_mask) &&
 		    (loop < MAXLOOP)) {
 		loop++;
 		cpu_relax();
diff --git a/drivers/video/via/accel.h b/drivers/video/via/accel.h
index 5081ac2..9a39ed1 100644
--- a/drivers/video/via/accel.h
+++ b/drivers/video/via/accel.h
@@ -67,6 +67,34 @@
 /* from 0x100 to 0x1ff */
 #define VIA_REG_COLORPAT        0x100
 
+/* defines for VIA 2D registers for vt3353/3409 (M1 engine)*/
+#define VIA_REG_GECMD_M1        0x000
+#define VIA_REG_GEMODE_M1       0x004
+#define VIA_REG_GESTATUS_M1     0x004       /* as same as VIA_REG_GEMODE */
+#define VIA_REG_PITCH_M1        0x008       /* pitch of src and dst */
+#define VIA_REG_DIMENSION_M1    0x00C       /* width and height */
+#define VIA_REG_DSTPOS_M1       0x010
+#define VIA_REG_LINE_XY_M1      0x010
+#define VIA_REG_DSTBASE_M1      0x014
+#define VIA_REG_SRCPOS_M1       0x018
+#define VIA_REG_LINE_K1K2_M1    0x018
+#define VIA_REG_SRCBASE_M1      0x01C
+#define VIA_REG_PATADDR_M1      0x020
+#define VIA_REG_MONOPAT0_M1     0x024
+#define VIA_REG_MONOPAT1_M1     0x028
+#define VIA_REG_OFFSET_M1       0x02C
+#define VIA_REG_LINE_ERROR_M1   0x02C
+#define VIA_REG_CLIPTL_M1       0x040       /* top and left of clipping */
+#define VIA_REG_CLIPBR_M1       0x044       /* bottom and right of clipping */
+#define VIA_REG_KEYCONTROL_M1   0x048       /* color key control */
+#define VIA_REG_FGCOLOR_M1      0x04C
+#define VIA_REG_DSTCOLORKEY_M1  0x04C       /* as same as VIA_REG_FG */
+#define VIA_REG_BGCOLOR_M1      0x050
+#define VIA_REG_SRCCOLORKEY_M1  0x050       /* as same as VIA_REG_BG */
+#define VIA_REG_MONOPATFGC_M1   0x058       /* Add BG color of Pattern. */
+#define VIA_REG_MONOPATBGC_M1   0x05C       /* Add FG color of Pattern. */
+#define VIA_REG_COLORPAT_M1     0x100       /* from 0x100 to 0x1ff */
+
 /* VIA_REG_PITCH(0x38): Pitch Setting */
 #define VIA_PITCH_ENABLE        0x80000000
 
@@ -157,6 +185,18 @@
 /* Virtual Queue is busy */
 #define VIA_VR_QUEUE_BUSY       0x00020000
 
+/* VIA_REG_STATUS(0x400): Engine Status for H5 */
+#define VIA_CMD_RGTR_BUSY_H5   0x00000010  /* Command Regulator is busy */
+#define VIA_2D_ENG_BUSY_H5     0x00000002  /* 2D Engine is busy */
+#define VIA_3D_ENG_BUSY_H5     0x00001FE1  /* 3D Engine is busy */
+#define VIA_VR_QUEUE_BUSY_H5   0x00000004  /* Virtual Queue is busy */
+
+/* VIA_REG_STATUS(0x400): Engine Status for VT3353/3409 */
+#define VIA_CMD_RGTR_BUSY_M1   0x00000010  /* Command Regulator is busy */
+#define VIA_2D_ENG_BUSY_M1     0x00000002  /* 2D Engine is busy */
+#define VIA_3D_ENG_BUSY_M1     0x00001FE1  /* 3D Engine is busy */
+#define VIA_VR_QUEUE_BUSY_M1   0x00000004  /* Virtual Queue is busy */
+
 #define MAXLOOP                 0xFFFFFF
 
 void viafb_2d_writel(u_int32_t val, u_int32_t reg);
diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
index d6a38ca..3a22a3a 100644
--- a/drivers/video/via/viafbdev.c
+++ b/drivers/video/via/viafbdev.c
@@ -214,8 +214,6 @@ static int viafb_check_var(struct fb_var_screeninfo *var,
 	if (!info->par)
 		return -1;
 	p_viafb_par = (struct viafb_par *)info->par;
-	if (p_viafb_par->chip_info->twod_engine == VIA_2D_ENG_M1)
-		var->accel_flags = 0;
 
 	return 0;
 }
-- 
1.6.2.4


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
