From: Paul Mundt <lethal@linux-sh.org>
Subject: [PATCH] kyrofb support
Date: Tue, 13 Jan 2004 20:33:06 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040114013306.GB9515@linux-sh.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AgZuX-0000TU-1G
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 13 Jan 2004 17:33:33 -0800
Received: from smtp.golden.net ([199.166.210.31] helo=newsmtp.golden.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1AgZuV-0005mZ-A9
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 13 Jan 2004 17:33:31 -0800
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net
Cc: James Simmons <jsimmons@infradead.org>, Andrew Morton <akpm@osdl.org>


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch adds support for the Kyro graphics boards (STG4000/PowerVR 3/etc=
.)
to 2.6.1. This is a direct port and substantial cleanup / rewrite of the 2.4
driver that's available in the sh64 tree at linux-sh.bkbits.net. Some of the
overlay code and the STG4000 bits are still a bit ugly, so be forewarned.

Andrew, please consider for -mm unless anyone has any glaring objections.

 drivers/video/Kconfig                     |   10=20
 drivers/video/Makefile                    |    1=20
 drivers/video/fbmem.c                     |    6=20
 drivers/video/kyro/Makefile               |   13=20
 drivers/video/kyro/STG4000InitDevice.c    |  328 ++++++++++++
 drivers/video/kyro/STG4000Interface.h     |   60 ++
 drivers/video/kyro/STG4000OverlayDevice.c |  609 ++++++++++++++++++++++
 drivers/video/kyro/STG4000Ramdac.c        |  176 ++++++
 drivers/video/kyro/STG4000Reg.h           |  285 ++++++++++
 drivers/video/kyro/STG4000VTG.c           |  173 ++++++
 drivers/video/kyro/fbdev.c                |  812 +++++++++++++++++++++++++=
+++++
 include/video/kyro.h                      |  101 +++
 12 files changed, 2574 insertions(+)

--- linux-2.6.1/drivers/video/Kconfig	Thu Oct  9 09:42:00 2003
+++ fb--devel--2.6/drivers/video/Kconfig	Wed Jan  7 17:21:30 2004
@@ -734,6 +734,16 @@ config FB_NEOMAGIC
 	  To compile this driver as a module, choose M here: the
 	  module will be called neofb.
=20
+config FB_KYRO
+	tristate "IMG Kyro support"
+	depends on FB && PCI
+	help
+	  Say Y here if you have a STG4000 / Kyro / PowerVR 3 based
+	  graphics board.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called kyrofb.
+
 config FB_3DFX
 	tristate "3Dfx Banshee/Voodoo3 display support"
 	depends on FB && PCI
--- linux-2.6.1/drivers/video/Makefile	Mon Sep  8 18:33:16 2003
+++ fb--devel--2.6/drivers/video/Makefile	Wed Jan  7 17:15:24 2004
@@ -70,6 +70,7 @@ obj-$(CONFIG_FB_VIRTUAL)          +=3D vfb
 obj-$(CONFIG_FB_HIT)              +=3D hitfb.o cfbfillrect.o cfbcopyarea.o=
 cfbimgblt.o
 obj-$(CONFIG_FB_E1355)            +=3D epson1355fb.o
 obj-$(CONFIG_FB_PVR2)             +=3D pvr2fb.o cfbfillrect.o cfbcopyarea.=
o cfbimgblt.o
+obj-$(CONFIG_FB_KYRO)             +=3D kyro/ cfbfillrect.o cfbcopyarea.o c=
fbimgblt.o
 obj-$(CONFIG_FB_VOODOO1)          +=3D sstfb.o cfbfillrect.o cfbcopyarea.o=
 cfbimgblt.o
=20
 obj-$(CONFIG_FB_FFB)               +=3D ffb.o sbuslib.o cfbimgblt.o cfbcop=
yarea.o
--- linux-2.6.1/drivers/video/fbmem.c	Mon Sep  8 18:33:17 2003
+++ fb--devel--2.6/drivers/video/fbmem.c	Wed Jan  7 17:22:49 2004
@@ -159,6 +159,8 @@ extern int tcx_init(void);
 extern int tcx_setup(char*);
 extern int leo_init(void);
 extern int leo_setup(char*);
+extern int kyrofb_init(void);
+extern int kyrofb_setup(char*);
=20
 static struct {
 	const char *name;
@@ -360,6 +362,10 @@ static struct {
 #ifdef CONFIG_FB_VOODOO1
 	{ "sstfb", sstfb_init, sstfb_setup },
 #endif
+#ifdef CONFIG_FB_KYRO
+	{ "kyrofb", kyrofb_init, kyrofb_setup },
+#endif
+
 	/*
 	 * Generic drivers that don't use resource management (yet)
 	 */
--- /dev/null	Fri Aug 30 19:31:37 2002
+++ fb--devel--2.6/drivers/video/kyro/Makefile	Sat Jan 10 17:17:06 2004
@@ -0,0 +1,13 @@
+#
+# Makefile for the Kyro framebuffer driver
+#
+# Note! Dependencies are done automagically by 'make dep', which also
+# removes any old dependencies. DON'T put your own dependencies here
+# unless it's something special (ie not a .c file).
+#
+# Note 2! The CFLAGS definitions are now in the main makefile...
+
+obj-$(CONFIG_FB_KYRO)	+=3D kyrofb.o
+
+kyrofb-objs	:=3D STG4000Ramdac.o STG4000VTG.o STG4000OverlayDevice.o \
+		   STG4000InitDevice.o fbdev.o
--- /dev/null	Fri Aug 30 19:31:37 2002
+++ fb--devel--2.6/drivers/video/kyro/STG4000InitDevice.c	Wed Jan  7 17:07:=
55 2004
@@ -0,0 +1,328 @@
+/*
+ *  linux/drivers/video/kyro/STG4000InitDevice.c
+ *
+ *  Copyright (C) 2000 Imagination Technologies Ltd
+ *  Copyright (C) 2002 STMicroelectronics
+ *
+ * This file is subject to the terms and conditions of the GNU General Pub=
lic
+ * License.  See the file COPYING in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <linux/pci.h>
+
+#include "STG4000Reg.h"
+
+/* SDRAM fixed settings */
+#define SDRAM_CFG_0   0x49A1
+#define SDRAM_CFG_1   0xA732
+#define SDRAM_CFG_2   0x31
+#define SDRAM_ARB_CFG 0xA0
+#define SDRAM_REFRESH 0x20
+
+/* Reset values */
+#define PMX2_SOFTRESET_DAC_RST		0x0001
+#define PMX2_SOFTRESET_C1_RST		0x0004
+#define PMX2_SOFTRESET_C2_RST		0x0008
+#define PMX2_SOFTRESET_3D_RST		0x0010
+#define PMX2_SOFTRESET_VIDIN_RST	0x0020
+#define PMX2_SOFTRESET_TLB_RST		0x0040
+#define PMX2_SOFTRESET_SD_RST		0x0080
+#define PMX2_SOFTRESET_VGA_RST		0x0100
+#define PMX2_SOFTRESET_ROM_RST		0x0200	/* reserved bit, do not reset */
+#define PMX2_SOFTRESET_TA_RST		0x0400
+#define PMX2_SOFTRESET_REG_RST		0x4000
+#define PMX2_SOFTRESET_ALL		0x7fff
+
+/* Core clock freq */
+#define CORE_PLL_FREQ 1000000
+
+/* Reference Clock freq */
+#define REF_FREQ 14318
+
+/* PCI Registers */
+static u16 CorePllControl =3D 0x70;
+
+#define	PCI_CONFIG_SUBSYS_ID	0x2e
+
+/* Misc */
+#define CORE_PLL_MODE_REG_0_7      3
+#define CORE_PLL_MODE_REG_8_15     2
+#define CORE_PLL_MODE_CONFIG_REG   1
+#define DAC_PLL_CONFIG_REG         0
+
+#define STG_MAX_VCO 500000
+#define STG_MIN_VCO 100000
+
+/* PLL Clock */
+#define    STG4K3_PLL_SCALER      8	/* scale numbers by 2^8 for fixed poin=
t calc */
+#define    STG4K3_PLL_MIN_R       2	/* Minimum multiplier */
+#define    STG4K3_PLL_MAX_R       33	/* Max */
+#define    STG4K3_PLL_MIN_F       2	/* Minimum divisor */
+#define    STG4K3_PLL_MAX_F       513	/* Max */
+#define    STG4K3_PLL_MIN_OD      0	/* Min output divider (shift) */
+#define    STG4K3_PLL_MAX_OD      2	/* Max */
+#define    STG4K3_PLL_MIN_VCO_SC  (100000000 >> STG4K3_PLL_SCALER)	/* Min =
VCO rate */
+#define    STG4K3_PLL_MAX_VCO_SC  (500000000 >> STG4K3_PLL_SCALER)	/* Max =
VCO rate */
+#define    STG4K3_PLL_MINR_VCO_SC (100000000 >> STG4K3_PLL_SCALER)	/* Min =
VCO rate (restricted) */
+#define    STG4K3_PLL_MAXR_VCO_SC (500000000 >> STG4K3_PLL_SCALER)	/* Max =
VCO rate (restricted) */
+#define    STG4K3_PLL_MINR_VCO    100000000	/* Min VCO rate (restricted) */
+#define    STG4K3_PLL_MAX_VCO     500000000	/* Max VCO rate */
+#define    STG4K3_PLL_MAXR_VCO    500000000	/* Max VCO rate (restricted) */
+
+#define OS_DELAY(X) \
+{ \
+volatile u32 i,count=3D0; \
+    for(i=3D0;i<X;i++) count++; \
+}
+
+u32 InitSDRAMRegisters(volatile STG4000REG * pSTGReg, u32 dwSubSysID,
+			 u32 dwRevID)
+{
+	u32 adwSDRAMArgCfg0[] =3D { 0xa0, 0x80, 0xa0, 0xa0, 0xa0 };
+	u32 adwSDRAMCfg1[] =3D { 0x8732, 0x8732, 0xa732, 0xa732, 0x8732 };
+	u32 adwSDRAMCfg2[] =3D { 0x87d2, 0x87d2, 0xa7d2, 0x87d2, 0xa7d2 };
+	u32 adwSDRAMRsh[] =3D { 36, 39, 40 };
+	u32 adwChipSpeed[] =3D { 110, 120, 125 };
+	u32 dwMemTypeIdx;
+	u32 dwChipSpeedIdx;
+
+	/* Get memory tpye and chip speed indexs from the SubSysDevID */
+	dwMemTypeIdx =3D (dwSubSysID & 0x70) >> 4;
+	dwChipSpeedIdx =3D (dwSubSysID & 0x180) >> 7;
+
+	if (dwMemTypeIdx > 4 || dwChipSpeedIdx > 2)
+		return 0;
+
+	/* Program SD-RAM interface */
+	STG_WRITE_REG(SDRAMArbiterConf, adwSDRAMArgCfg0[dwMemTypeIdx]);
+	if (dwRevID < 5) {
+		STG_WRITE_REG(SDRAMConf0, 0x49A1);
+		STG_WRITE_REG(SDRAMConf1, adwSDRAMCfg1[dwMemTypeIdx]);
+	} else {
+		STG_WRITE_REG(SDRAMConf0, 0x4DF1);
+		STG_WRITE_REG(SDRAMConf1, adwSDRAMCfg2[dwMemTypeIdx]);
+	}
+
+	STG_WRITE_REG(SDRAMConf2, 0x31);
+	STG_WRITE_REG(SDRAMRefresh, adwSDRAMRsh[dwChipSpeedIdx]);
+
+	return adwChipSpeed[dwChipSpeedIdx] * 10000;
+}
+
+/*-----------------------------------------------------------------------*/
+
+u32 ProgramClock(u32 refClock,
+		   u32 coreClock,
+		   u32 * FOut, u32 * ROut, u32 * POut)
+{
+	u32 R =3D 0, F =3D 0, OD =3D 0, ODIndex =3D 0;
+	u32 ulBestR =3D 0, ulBestF =3D 0, ulBestOD =3D 0;
+	u32 ulBestVCO =3D 0, ulBestClk =3D 0, ulBestScore =3D 0;
+	u32 ulScore, ulPhaseScore, ulVcoScore;
+	u32 ulTmp =3D 0, ulVCO;
+	u32 ulScaleClockReq, ulMinClock, ulMaxClock;
+	u32 ODValues[] =3D { 1, 2, 0 };
+
+	/* Translate clock in Hz */
+	coreClock *=3D 100;	/* in Hz */
+	refClock *=3D 1000;	/* in Hz */
+
+	/* Work out acceptable clock
+	 * The method calculates ~ +- 0.4% (1/256)
+	 */
+	ulMinClock =3D coreClock - (coreClock >> 8);
+	ulMaxClock =3D coreClock + (coreClock >> 8);
+
+	/* Scale clock required for use in calculations */
+	ulScaleClockReq =3D coreClock >> STG4K3_PLL_SCALER;
+
+	/* Iterate through post divider values */
+	for (ODIndex =3D 0; ODIndex < 3; ODIndex++) {
+		OD =3D ODValues[ODIndex];
+		R =3D STG4K3_PLL_MIN_R;
+
+		/* loop for pre-divider from min to max  */
+		while (R <=3D STG4K3_PLL_MAX_R) {
+			/* estimate required feedback multiplier */
+			ulTmp =3D R * (ulScaleClockReq << OD);
+
+			/* F =3D ClkRequired * R * (2^OD) / Fref */
+			F =3D (u32)(ulTmp / (refClock >> STG4K3_PLL_SCALER));
+
+			/* compensate for accuracy */
+			if (F > STG4K3_PLL_MIN_F)
+				F--;
+
+
+			/*=20
+			 * We should be close to our target frequency (if it's
+			 * achievable with current OD & R) let's iterate
+			 * through F for best fit
+			 */
+			while ((F >=3D STG4K3_PLL_MIN_F) &&
+			       (F <=3D STG4K3_PLL_MAX_F)) {
+				/* Calc VCO at full accuracy */
+				ulVCO =3D refClock / R;
+				ulVCO =3D F * ulVCO;
+
+				/*=20
+				 * Check it's within restricted VCO range
+				 * unless of course the desired frequency is
+				 * above the restricted range, then test
+				 * against VCO limit
+				 */
+				if ((ulVCO >=3D STG4K3_PLL_MINR_VCO) &&
+				    ((ulVCO <=3D STG4K3_PLL_MAXR_VCO) ||
+				     ((coreClock > STG4K3_PLL_MAXR_VCO)
+				      && (ulVCO <=3D STG4K3_PLL_MAX_VCO)))) {
+					ulTmp =3D (ulVCO >> OD);	/* Clock =3D VCO / (2^OD) */
+
+					/* Is this clock good enough? */
+					if ((ulTmp >=3D ulMinClock)
+					    && (ulTmp <=3D ulMaxClock)) {
+						ulPhaseScore =3D (((refClock / R) - (refClock / STG4K3_PLL_MAX_R))) =
/ ((refClock - (refClock / STG4K3_PLL_MAX_R)) >> 10);
+
+						ulVcoScore =3D ((ulVCO - STG4K3_PLL_MINR_VCO)) / ((STG4K3_PLL_MAXR_V=
CO - STG4K3_PLL_MINR_VCO) >> 10);
+						ulScore =3D ulPhaseScore + ulVcoScore;=20
+
+						if (!ulBestScore) {
+							ulBestVCO =3D ulVCO;
+							ulBestOD =3D OD;
+							ulBestF =3D F;
+							ulBestR =3D R;
+							ulBestClk =3D ulTmp;
+							ulBestScore =3D
+							    ulScore;
+						}
+						/* is this better, ( aim for highest Score) */
+			/*---------------------------------------------------------------------=
-----
+                             Here we want to use a scoring system which wi=
ll take account of both the
+                            value at the phase comparater and the VCO outp=
ut                        =20
+                             to do this we will use a cumulative score bet=
ween the two                                                               =
                      =20
+                          The way this ends up is that we choose the first=
 value in the loop anyway
+                          but we shall keep this code in case new restrict=
ions come into play
+                          ------------------------------------------------=
--------------------------*/
+						if ((ulScore >=3D ulBestScore) && (OD > 0)) {
+							ulBestVCO =3D ulVCO;
+							ulBestOD =3D OD;
+							ulBestF =3D F;
+							ulBestR =3D R;
+							ulBestClk =3D ulTmp;
+							ulBestScore =3D
+							    ulScore;
+						}
+					}
+				}
+				F++;
+			}
+			R++;
+		}
+	}
+
+	/*
+	   did we find anything?
+	   Then return RFOD
+	 */
+	if (ulBestScore) {
+		*ROut =3D ulBestR;
+		*FOut =3D ulBestF;
+
+		if ((ulBestOD =3D=3D 2) || (ulBestOD =3D=3D 3)) {
+			*POut =3D 3;
+		} else
+			*POut =3D ulBestOD;
+
+	}
+
+	return (ulBestClk);
+}
+
+int SetCoreClockPLL(volatile STG4000REG * pSTGReg, struct pci_dev *pDev)
+{
+	u32 F, R, P;
+	u16 core_pll =3D 0, sub;
+	u32 ulCoreClock;
+	u32 tmp;
+	u32 ulChipSpeed;
+	u8 rev;
+
+	STG_WRITE_REG(IntMask, 0xFFFF);
+
+	/* Disable Primary Core Thread0 */
+	tmp =3D STG_READ_REG(Thread0Enable);
+	CLEAR_BIT(0);
+	STG_WRITE_REG(Thread0Enable, tmp);
+
+	/* Disable Primary Core Thread1 */
+	tmp =3D STG_READ_REG(Thread1Enable);
+	CLEAR_BIT(0);
+	STG_WRITE_REG(Thread1Enable, tmp);
+
+	STG_WRITE_REG(SoftwareReset,
+		      PMX2_SOFTRESET_REG_RST | PMX2_SOFTRESET_ROM_RST);
+	STG_WRITE_REG(SoftwareReset,
+		      PMX2_SOFTRESET_REG_RST | PMX2_SOFTRESET_TA_RST |
+		      PMX2_SOFTRESET_ROM_RST);
+
+	/* Need to play around to reset TA */
+	STG_WRITE_REG(TAConfiguration, 0);
+	STG_WRITE_REG(SoftwareReset,
+		      PMX2_SOFTRESET_REG_RST | PMX2_SOFTRESET_ROM_RST);
+	STG_WRITE_REG(SoftwareReset,
+		      PMX2_SOFTRESET_REG_RST | PMX2_SOFTRESET_TA_RST |
+		      PMX2_SOFTRESET_ROM_RST);
+
+	pci_read_config_word(pDev, PCI_CONFIG_SUBSYS_ID, &sub);
+	pci_read_config_byte(pDev, PCI_REVISION_ID, &rev);
+
+	ulChipSpeed =3D InitSDRAMRegisters(pSTGReg, (u32)sub, (u32)rev);
+
+	if (ulChipSpeed =3D=3D 0)
+		return -EINVAL;
+
+	ulCoreClock =3D ProgramClock(REF_FREQ, CORE_PLL_FREQ, &F, &R, &P);
+
+	core_pll |=3D ((P) | ((F - 2) << 2) | ((R - 2) << 11));
+
+	/* Set Core PLL Control to Core PLL Mode  */
+
+	/* Send bits 0:7 of the Core PLL Mode register */
+	tmp =3D ((CORE_PLL_MODE_REG_0_7 << 8) | (core_pll & 0x00FF));
+	pci_write_config_word(pDev, CorePllControl, tmp);
+	/* Without some delay between the PCI config writes the clock does
+	   not reliably set when the code is compiled -O3
+	 */
+	OS_DELAY(1000000);
+
+	tmp |=3D SET_BIT(14);
+	pci_write_config_word(pDev, CorePllControl, tmp);
+	OS_DELAY(1000000);
+
+	/* Send bits 8:15 of the Core PLL Mode register */
+	tmp =3D
+	    ((CORE_PLL_MODE_REG_8_15 << 8) | ((core_pll & 0xFF00) >> 8));
+	pci_write_config_word(pDev, CorePllControl, tmp);
+	OS_DELAY(1000000);
+
+	tmp |=3D SET_BIT(14);
+	pci_write_config_word(pDev, CorePllControl, tmp);
+	OS_DELAY(1000000);
+
+	STG_WRITE_REG(SoftwareReset, PMX2_SOFTRESET_ALL);
+
+#if 0
+	/* Enable Primary Core Thread0 */
+	tmp =3D ((STG_READ_REG(Thread0Enable)) | SET_BIT(0));
+	STG_WRITE_REG(Thread0Enable, tmp);
+
+	/* Enable Primary Core Thread1 */
+	tmp =3D ((STG_READ_REG(Thread1Enable)) | SET_BIT(0));
+	STG_WRITE_REG(Thread1Enable, tmp);
+#endif
+
+	return 0;
+}
--- /dev/null	Fri Aug 30 19:31:37 2002
+++ fb--devel--2.6/drivers/video/kyro/STG4000Interface.h	Sat Jan 10 20:46:4=
3 2004
@@ -0,0 +1,60 @@
+/*
+ *  linux/drivers/video/kyro/STG4000Interface.h
+ *
+ *  Copyright (C) 2002 STMicroelectronics
+ *
+ * This file is subject to the terms and conditions of the GNU General Pub=
lic
+ * License.  See the file COPYING in the main directory of this archive
+ * for more details.
+ */
+
+#ifndef _STG4000INTERFACE_H
+#define _STG4000INTERFACE_H
+
+struct pci_dev;
+
+/*
+ * Ramdac Setup
+ */
+extern int InitialiseRamdac(volatile STG4000REG *pSTGReg, u32 displayDepth,
+			    u32 displayWidth, u32 displayHeight,
+			    s32 HSyncPolarity, s32 VSyncPolarity,
+			    u32 *pixelClock);
+
+extern void DisableRamdacOutput(volatile STG4000REG * pSTGReg);
+extern void EnableRamdacOutput(volatile STG4000REG * pSTGReg);
+
+/*
+ * Timing generator setup
+ */
+extern void DisableVGA(volatile STG4000REG * pSTGReg);
+extern void StopVTG(volatile STG4000REG * pSTGReg);
+extern void StartVTG(volatile STG4000REG * pSTGReg);
+extern void SetupVTG(volatile STG4000REG * pSTGReg,
+		     const struct kyrofb_info * pTiming);
+
+extern u32 ProgramClock(u32 refClock, u32 coreClock, u32 *FOut, u32 *ROut,=
 u32 *POut);
+extern int SetCoreClockPLL(volatile STG4000REG * pSTGReg, struct pci_dev *=
pDev);
+
+/*
+ * Overlay setup
+ */
+extern void ResetOverlayRegisters(volatile STG4000REG * pSTGReg);
+
+extern int CreateOverlaySurface(volatile STG4000REG * pSTGReg,
+				u32 ulWidth, u32 ulHeight,
+				int bLinear,
+				u32 ulOverlayOffset,
+				u32 * retStride, u32 * retUVStride);
+
+extern int SetOverlayBlendMode(volatile STG4000REG * pSTGReg,
+			       OVRL_BLEND_MODE mode,
+			       u32 ulAlpha, u32 ulColorKey);
+
+extern int SetOverlayViewPort(volatile STG4000REG * pSTGReg,
+			      u32 left, u32 top,
+			      u32 right, u32 bottom);
+
+extern void EnableOverlayPlane(volatile STG4000REG * pSTGReg);
+
+#endif /* _STG4000INTERFACE_H */
--- /dev/null	Fri Aug 30 19:31:37 2002
+++ fb--devel--2.6/drivers/video/kyro/STG4000OverlayDevice.c	Wed Jan  7 17:=
07:55 2004
@@ -0,0 +1,609 @@
+/*
+ *  linux/drivers/video/kyro/STG4000OverlayDevice.c
+ *
+ *  Copyright (C) 2000 Imagination Technologies Ltd
+ *  Copyright (C) 2002 STMicroelectronics
+ *
+ * This file is subject to the terms and conditions of the GNU General Pub=
lic
+ * License.  See the file COPYING in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+
+#include "STG4000Reg.h"
+
+/* HW Defines */
+
+#define STG4000_NO_SCALING    0x800
+#define STG4000_NO_DECIMATION 0xFFFFFFFF
+
+/* Primary surface */
+#define STG4000_PRIM_NUM_PIX   5
+#define STG4000_PRIM_ALIGN     4
+#define STG4000_PRIM_ADDR_BITS 20
+
+#define STG4000_PRIM_MIN_WIDTH  640
+#define STG4000_PRIM_MAX_WIDTH  1600
+#define STG4000_PRIM_MIN_HEIGHT 480
+#define STG4000_PRIM_MAX_HEIGHT 1200
+
+/* Overlay surface */
+#define STG4000_OVRL_NUM_PIX   4
+#define STG4000_OVRL_ALIGN     2
+#define STG4000_OVRL_ADDR_BITS 20
+#define STG4000_OVRL_NUM_MODES 5
+
+#define STG4000_OVRL_MIN_WIDTH  0
+#define STG4000_OVRL_MAX_WIDTH  720
+#define STG4000_OVRL_MIN_HEIGHT 0
+#define STG4000_OVRL_MAX_HEIGHT 576
+
+/* Decimation and Scaling */
+u32 adwDecim8[33] =3D {
+	0xffffffff, 0xfffeffff, 0xffdffbff, 0xfefefeff, 0xfdf7efbf,
+	    0xfbdf7bdf, 0xf7bbddef, 0xeeeeeeef, 0xeeddbb77, 0xedb76db7,
+	    0xdb6db6db, 0xdb5b5b5b, 0xdab5ad6b, 0xd5ab55ab, 0xd555aaab,
+	    0xaaaaaaab, 0xaaaa5555, 0xaa952a55, 0xa94a5295, 0xa5252525,
+	    0xa4924925, 0x92491249, 0x91224489, 0x91111111, 0x90884211,
+	    0x88410821, 0x88102041, 0x81010101, 0x80800801, 0x80010001,
+	    0x80000001, 0x00000001, 0x00000000
+};
+
+typedef struct _OVRL_SRC_DEST {
+	/*clipped on-screen pixel position of overlay */
+	u32 ulDstX1;
+	u32 ulDstY1;
+	u32 ulDstX2;
+	u32 ulDstY2;
+
+	/*clipped pixel pos of source data within buffer thses need to be 128 bit=
 word aligned */
+	u32 ulSrcX1;
+	u32 ulSrcY1;
+	u32 ulSrcX2;
+	u32 ulSrcY2;
+
+	/* on-screen pixel position of overlay */
+	s32 lDstX1;
+	s32 lDstY1;
+	s32 lDstX2;
+	s32 lDstY2;
+} OVRL_SRC_DEST;
+
+static u32 ovlWidth, ovlHeight, ovlStride;
+static int ovlLinear;
+
+void ResetOverlayRegisters(volatile STG4000REG * pSTGReg)
+{
+	u32 tmp;
+
+	/* Set Overlay address to default */
+	tmp =3D STG_READ_REG(DACOverlayAddr);
+	CLEAR_BITS_FRM_TO(0, 20);
+	CLEAR_BIT(31);
+	STG_WRITE_REG(DACOverlayAddr, tmp);
+
+	/* Set Overlay U address */
+	tmp =3D STG_READ_REG(DACOverlayUAddr);
+	CLEAR_BITS_FRM_TO(0, 20);
+	STG_WRITE_REG(DACOverlayUAddr, tmp);
+
+	/* Set Overlay V address */
+	tmp =3D STG_READ_REG(DACOverlayVAddr);
+	CLEAR_BITS_FRM_TO(0, 20);
+	STG_WRITE_REG(DACOverlayVAddr, tmp);
+
+	/* Set Overlay Size */
+	tmp =3D STG_READ_REG(DACOverlaySize);
+	CLEAR_BITS_FRM_TO(0, 10);
+	CLEAR_BITS_FRM_TO(12, 31);
+	STG_WRITE_REG(DACOverlaySize, tmp);
+
+	/* Set Overlay Vt Decimation */
+	tmp =3D STG4000_NO_DECIMATION;
+	STG_WRITE_REG(DACOverlayVtDec, tmp);
+
+	/* Set Overlay format to default value */
+	tmp =3D STG_READ_REG(DACPixelFormat);
+	CLEAR_BITS_FRM_TO(4, 7);
+	CLEAR_BITS_FRM_TO(16, 22);
+	STG_WRITE_REG(DACPixelFormat, tmp);
+
+	/* Set Vertical scaling to default */
+	tmp =3D STG_READ_REG(DACVerticalScal);
+	CLEAR_BITS_FRM_TO(0, 11);
+	CLEAR_BITS_FRM_TO(16, 22);
+	tmp |=3D STG4000_NO_SCALING;	/* Set to no scaling */
+	STG_WRITE_REG(DACVerticalScal, tmp);
+
+	/* Set Horizontal Scaling to default */
+	tmp =3D STG_READ_REG(DACHorizontalScal);
+	CLEAR_BITS_FRM_TO(0, 11);
+	CLEAR_BITS_FRM_TO(16, 17);
+	tmp |=3D STG4000_NO_SCALING;	/* Set to no scaling */
+	STG_WRITE_REG(DACHorizontalScal, tmp);
+
+	/* Set Blend mode to Alpha Blend */
+	/* ????? SG 08/11/2001 Surely this isn't the alpha blend mode,
+	   hopefully its overwrite
+	 */
+	tmp =3D STG_READ_REG(DACBlendCtrl);
+	CLEAR_BITS_FRM_TO(0, 30);
+	tmp =3D (GRAPHICS_MODE << 28);
+	STG_WRITE_REG(DACBlendCtrl, tmp);
+
+}
+
+/*------------------------------------------------------------------------=
-*/
+
+int CreateOverlaySurface(volatile STG4000REG * pSTGReg,
+			 u32 inWidth,
+			 u32 inHeight,
+			 int bLinear,
+			 u32 ulOverlayOffset,
+			 u32 * retStride, u32 * retUVStride)
+{
+	u32 tmp;
+	u32 ulStride;
+
+	if (inWidth > STG4000_OVRL_MAX_WIDTH ||
+	    inHeight > STG4000_OVRL_MAX_HEIGHT) {
+		return -EINVAL;
+	}
+
+	/* Stride in 16 byte words - 16Bpp */
+	if (bLinear) {
+		/* Format is 16bits so num 16 byte words is width/8 */
+		if ((inWidth & 0x7) =3D=3D 0) {	/* inWidth % 8 */
+			ulStride =3D (inWidth / 8);
+		} else {
+			/* Round up to next 16byte boundary */
+			ulStride =3D ((inWidth + 8) / 8);
+		}
+	} else {
+		/* Y component is 8bits so num 16 byte words is width/16 */
+		if ((inWidth & 0xf) =3D=3D 0) {	/* inWidth % 16 */
+			ulStride =3D (inWidth / 16);
+		} else {
+			/* Round up to next 16byte boundary */
+			ulStride =3D ((inWidth + 16) / 16);
+		}
+	}
+
+
+	/* Set Overlay address and Format mode */
+	tmp =3D STG_READ_REG(DACOverlayAddr);
+	CLEAR_BITS_FRM_TO(0, 20);
+	if (bLinear) {
+		CLEAR_BIT(31);	/* Overlay format to Linear */
+	} else {
+		tmp |=3D SET_BIT(31);	/* Overlay format to Planer */
+	}
+
+	/* Only bits 24:4 of the Overlay address */
+	tmp |=3D (ulOverlayOffset >> 4);
+	STG_WRITE_REG(DACOverlayAddr, tmp);
+
+	if (!bLinear) {
+		u32 uvSize =3D
+		    (inWidth & 0x1) ? (inWidth + 1 / 2) : (inWidth / 2);
+		u32 uvStride;
+		u32 ulOffset;
+		/* Y component is 8bits so num 32 byte words is width/32 */
+		if ((uvSize & 0xf) =3D=3D 0) {	/* inWidth % 16 */
+			uvStride =3D (uvSize / 16);
+		} else {
+			/* Round up to next 32byte boundary */
+			uvStride =3D ((uvSize + 16) / 16);
+		}
+
+		ulOffset =3D ulOverlayOffset + (inHeight * (ulStride * 16));
+		/* Align U,V data to 32byte boundary */
+		if ((ulOffset & 0x1f) !=3D 0)
+			ulOffset =3D (ulOffset + 32L) & 0xffffffE0L;
+
+		tmp =3D STG_READ_REG(DACOverlayUAddr);
+		CLEAR_BITS_FRM_TO(0, 20);
+		tmp |=3D (ulOffset >> 4);
+		STG_WRITE_REG(DACOverlayUAddr, tmp);
+
+		ulOffset +=3D (inHeight / 2) * (uvStride * 16);
+		/* Align U,V data to 32byte boundary */
+		if ((ulOffset & 0x1f) !=3D 0)
+			ulOffset =3D (ulOffset + 32L) & 0xffffffE0L;
+
+		tmp =3D STG_READ_REG(DACOverlayVAddr);
+		CLEAR_BITS_FRM_TO(0, 20);
+		tmp |=3D (ulOffset >> 4);
+		STG_WRITE_REG(DACOverlayVAddr, tmp);
+
+		*retUVStride =3D uvStride * 16;
+	}
+
+
+	/* Set Overlay YUV pixel format
+	 * Make sure that LUT not used - ??????
+	 */
+	tmp =3D STG_READ_REG(DACPixelFormat);
+	/* Only support Planer or UYVY linear formats */
+	CLEAR_BITS_FRM_TO(4, 9);
+	STG_WRITE_REG(DACPixelFormat, tmp);
+
+	ovlWidth =3D inWidth;
+	ovlHeight =3D inHeight;
+	ovlStride =3D ulStride;
+	ovlLinear =3D bLinear;
+	*retStride =3D ulStride << 4;	/* In bytes */
+
+	return 0;
+}
+
+/*------------------------------------------------------------------------=
-*/
+
+int SetOverlayBlendMode(volatile STG4000REG * pSTGReg,
+			OVRL_BLEND_MODE mode,
+			u32 ulAlpha, u32 ulColorKey)
+{
+	u32 tmp;
+
+	tmp =3D STG_READ_REG(DACBlendCtrl);
+	CLEAR_BITS_FRM_TO(28, 30);
+	tmp |=3D (mode << 28);
+
+	switch (mode) {
+	case COLOR_KEY:
+		CLEAR_BITS_FRM_TO(0, 23);
+		tmp |=3D (ulColorKey & 0x00FFFFFF);
+		break;
+
+	case GLOBAL_ALPHA:
+		CLEAR_BITS_FRM_TO(24, 27);
+		tmp |=3D ((ulAlpha & 0xF) << 24);
+		break;
+
+	case CK_PIXEL_ALPHA:
+		CLEAR_BITS_FRM_TO(0, 23);
+		tmp |=3D (ulColorKey & 0x00FFFFFF);
+		break;
+
+	case CK_GLOBAL_ALPHA:
+		CLEAR_BITS_FRM_TO(0, 23);
+		tmp |=3D (ulColorKey & 0x00FFFFFF);
+		CLEAR_BITS_FRM_TO(24, 27);
+		tmp |=3D ((ulAlpha & 0xF) << 24);
+		break;
+
+	case GRAPHICS_MODE:
+	case PER_PIXEL_ALPHA:
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	STG_WRITE_REG(DACBlendCtrl, tmp);
+
+	return 0;
+}
+
+/*------------------------------------------------------------------------=
-*/
+
+void EnableOverlayPlane(volatile STG4000REG * pSTGReg)
+{
+	u32 tmp;
+	/* Enable Overlay */
+	tmp =3D STG_READ_REG(DACPixelFormat);
+	tmp |=3D SET_BIT(7);
+	STG_WRITE_REG(DACPixelFormat, tmp);
+
+	/* Set video stream control */
+	tmp =3D STG_READ_REG(DACStreamCtrl);
+	tmp |=3D SET_BIT(1);	/* video stream */
+	STG_WRITE_REG(DACStreamCtrl, tmp);
+}
+
+/*------------------------------------------------------------------------=
-*/
+
+static u32 Overlap(u32 ulBits, u32 ulPattern)
+{
+	u32 ulCount =3D 0;
+
+	while (ulBits) {
+		if (!(ulPattern & 1))
+			ulCount++;
+		ulBits--;
+		ulPattern =3D ulPattern >> 1;
+	}
+
+	return ulCount;
+
+}
+
+int SetOverlayViewPort(volatile STG4000REG * pSTGReg,
+		       u32 left, u32 top,
+		       u32 right, u32 bottom)
+{
+	OVRL_SRC_DEST srcDest;
+
+	u32 ulSrcTop, ulSrcBottom;
+	u32 ulSrc, ulDest;
+	u32 ulFxScale, ulFxOffset;
+	u32 ulHeight, ulWidth;
+	u32 ulPattern;
+	u32 ulDecimate, ulDecimated;
+	u32 ulApplied;
+	u32 ulDacXScale, ulDacYScale;
+	u32 ulScale;
+	u32 ulLeft, ulRight;
+	u32 ulSrcLeft, ulSrcRight;
+	u32 ulScaleLeft, ulScaleRight;
+	u32 ulhDecim;
+	u32 ulsVal;
+	u32 ulVertDecFactor;
+	int bResult;
+	u32 ulClipOff =3D 0;
+	u32 ulBits =3D 0;
+	u32 ulsAdd =3D 0;
+	u32 tmp, ulStride;
+	u32 ulExcessPixels, ulClip, ulExtraLines;
+
+
+	srcDest.ulSrcX1 =3D 0;
+	srcDest.ulSrcY1 =3D 0;
+	srcDest.ulSrcX2 =3D ovlWidth - 1;
+	srcDest.ulSrcY2 =3D ovlHeight - 1;
+
+	srcDest.ulDstX1 =3D left;
+	srcDest.ulDstY1 =3D top;
+	srcDest.ulDstX2 =3D right;
+	srcDest.ulDstY2 =3D bottom;
+
+	srcDest.lDstX1 =3D srcDest.ulDstX1;
+	srcDest.lDstY1 =3D srcDest.ulDstY1;
+	srcDest.lDstX2 =3D srcDest.ulDstX2;
+	srcDest.lDstY2 =3D srcDest.ulDstY2;
+
+    /************* Vertical decimation/scaling ******************/
+
+	/* Get Src Top and Bottom */
+	ulSrcTop =3D srcDest.ulSrcY1;
+	ulSrcBottom =3D srcDest.ulSrcY2;
+
+	ulSrc =3D ulSrcBottom - ulSrcTop;
+	ulDest =3D srcDest.lDstY2 - srcDest.lDstY1;	/* on-screen overlay */
+
+	if (ulSrc <=3D 1)
+		return -EINVAL;
+
+	/* First work out the position we are to display as offset from the=20
+	 * source of the buffer
+	 */
+	ulFxScale =3D (ulDest << 11) / ulSrc;	/* fixed point scale factor */
+	ulFxOffset =3D (srcDest.lDstY2 - srcDest.ulDstY2) << 11;
+
+	ulSrcBottom =3D ulSrcBottom - (ulFxOffset / ulFxScale);
+	ulSrc =3D ulSrcBottom - ulSrcTop;
+	ulHeight =3D ulSrc;
+
+	ulDest =3D srcDest.ulDstY2 - (srcDest.ulDstY1 - 1);
+	ulPattern =3D adwDecim8[ulBits];
+
+	/* At this point ulSrc represents the input decimator */
+	if (ulSrc > ulDest) {
+		ulDecimate =3D ulSrc - ulDest;
+		ulBits =3D 0;
+		ulApplied =3D ulSrc / 32;
+
+		while (((ulBits * ulApplied) +
+			Overlap((ulSrc % 32),
+				adwDecim8[ulBits])) < ulDecimate)
+			ulBits++;
+
+		ulPattern =3D adwDecim8[ulBits];
+		ulDecimated =3D
+		    (ulBits * ulApplied) + Overlap((ulSrc % 32),
+						   ulPattern);
+		ulSrc =3D ulSrc - ulDecimated;	/* the number number of lines that will g=
o into the scaler */
+	}
+
+	if (ulBits && (ulBits !=3D 32)) {
+		ulVertDecFactor =3D (63 - ulBits) / (32 - ulBits);	/* vertical decimatio=
n factor scaled up to nearest integer */
+	} else {
+		ulVertDecFactor =3D 1;
+	}
+
+	ulDacYScale =3D ((ulSrc - 1) * 2048) / (ulDest + 1);
+
+	tmp =3D STG_READ_REG(DACOverlayVtDec);	/* Decimation */
+	CLEAR_BITS_FRM_TO(0, 31);
+	tmp =3D ulPattern;
+	STG_WRITE_REG(DACOverlayVtDec, tmp);
+
+	/***************** Horizontal decimation/scaling ************************=
***/
+
+	/*=20
+	 * Now we handle the horizontal case, this is a simplified verison of
+	 * the vertical case in that we decimate by factors of 2.  as we are
+	 * working in words we should always be able to decimate by these
+	 * factors.  as we always have to have a buffer which is aligned to a
+	 * whole number of 128 bit words, we must align the left side to the
+	 * lowest to the next lowest 128 bit boundary, and the right hand edge
+	 * to the next largets boundary, (in a similar way to how we didi it in
+	 * PMX1) as the left and right hand edges are aligned to these
+	 * boundaries normally this only becomes an issue when we are chopping
+	 * of one of the sides We shall work out vertical stuff first
+	 */
+	ulSrc =3D srcDest.ulSrcX2 - srcDest.ulSrcX1;
+	ulDest =3D srcDest.lDstX2 - srcDest.lDstX1;
+#ifdef _OLDCODE
+	ulLeft =3D srcDest.ulDstX1;
+	ulRight =3D srcDest.ulDstX2;
+#else
+	if (srcDest.ulDstX1 > 2) {
+		ulLeft =3D srcDest.ulDstX1 + 2;
+		ulRight =3D srcDest.ulDstX2 + 1;
+	} else {
+		ulLeft =3D srcDest.ulDstX1;
+		ulRight =3D srcDest.ulDstX2 + 1;
+	}
+#endif
+	/* first work out the position we are to display as offset from the sourc=
e of the buffer */
+	bResult =3D 1;
+
+	do {
+		if (ulDest =3D=3D 0)
+			return -EINVAL;
+
+		/* source pixels per dest pixel <<11 */
+		ulFxScale =3D ((ulSrc - 1) << 11) / (ulDest);
+
+		/* then number of destination pixels out we are */
+		ulFxOffset =3D ulFxScale * ((srcDest.ulDstX1 - srcDest.lDstX1) + ulClipO=
ff);
+		ulFxOffset >>=3D 11;
+
+		/* this replaces the code which was making a decision as to use either u=
lFxOffset or ulSrcX1 */
+		ulSrcLeft =3D srcDest.ulSrcX1 + ulFxOffset;
+
+		/* then number of destination pixels out we are */
+		ulFxOffset =3D ulFxScale * (srcDest.lDstX2 - srcDest.ulDstX2);=09
+		ulFxOffset >>=3D 11;
+
+		ulSrcRight =3D srcDest.ulSrcX2 - ulFxOffset;
+
+		/*=20
+		 * we must align these to our 128 bit boundaries. we shall
+		 * round down the pixel pos to the nearest 8 pixels.
+		 */
+		ulScaleLeft =3D ulSrcLeft;
+		ulScaleRight =3D ulSrcRight;
+
+		/* shift fxscale until it is in the range of the scaler */
+		ulhDecim =3D 0;
+		ulScale =3D (((ulSrcRight - ulSrcLeft) - 1) << (11 - ulhDecim)) / (ulRig=
ht - ulLeft + 2);
+
+		while (ulScale > 0x800) {
+			ulhDecim++;
+			ulScale =3D (((ulSrcRight - ulSrcLeft) - 1) << (11 - ulhDecim)) / (ulRi=
ght - ulLeft + 2);
+		}
+
+		/*=20
+		 * to try and get the best values We first try and use
+		 * src/dwdest for the scale factor, then we move onto src-1
+		 *
+		 * we want to check to see if we will need to clip data, if so
+		 * then we should clip our source so that we don't need to
+		 */
+		if (!ovlLinear) {
+			ulSrcLeft &=3D ~0x1f;
+
+			/*=20
+			 * we must align the right hand edge to the next 32
+			 * pixel` boundary, must be on a 256 boundary so u, and
+			 * v are 128 bit aligned
+			 */
+			ulSrcRight =3D (ulSrcRight + 0x1f) & ~0x1f;
+		} else {
+			ulSrcLeft &=3D ~0x7;
+
+			/*=20
+			 * we must align the right hand edge to the next
+			 * 8pixel` boundary
+			 */
+			ulSrcRight =3D (ulSrcRight + 0x7) & ~0x7;
+		}
+
+		/* this is the input size line store needs to cope with */
+		ulWidth =3D ulSrcRight - ulSrcLeft;
+
+		/*=20
+		 * use unclipped value to work out scale factror this is the
+		 * scale factor we want we shall now work out the horizonal
+		 * decimation and scaling
+		 */
+		ulsVal =3D ((ulWidth / 8) >> ulhDecim);
+
+		if ((ulWidth !=3D (ulsVal << ulhDecim) * 8))
+			ulsAdd =3D 1;
+
+		/* input pixels to scaler; */
+		ulSrc =3D ulWidth >> ulhDecim;
+
+		if (ulSrc <=3D 2)
+			return -EINVAL;
+
+		ulExcessPixels =3D ((((ulScaleLeft - ulSrcLeft)) << (11 - ulhDecim)) / u=
lScale);
+
+		ulClip =3D (ulSrc << 11) / ulScale;
+		ulClip -=3D (ulRight - ulLeft);
+		ulClip +=3D ulExcessPixels;
+
+		if (ulClip)
+			ulClip--;
+
+		/* We may need to do more here if we really have a HW rev < 5 */
+	} while (!bResult);
+
+	ulExtraLines =3D (1 << ulhDecim) * ulVertDecFactor;
+	ulExtraLines +=3D 64;
+	ulHeight +=3D ulExtraLines;
+
+	ulDacXScale =3D ulScale;
+
+
+	tmp =3D STG_READ_REG(DACVerticalScal);
+	CLEAR_BITS_FRM_TO(0, 11);
+	CLEAR_BITS_FRM_TO(16, 22);	/* Vertical Scaling */
+
+	/* Calculate new output line stride, this is always the number of 422
+	   words in the line buffer, so it doesn't matter if the
+	   mode is 420. Then set the vertical scale register.
+	 */
+	ulStride =3D (ulWidth >> (ulhDecim + 3)) + ulsAdd;
+	tmp |=3D ((ulStride << 16) | (ulDacYScale));	/* DAC_LS_CTRL =3D stride */
+	STG_WRITE_REG(DACVerticalScal, tmp);
+
+	/* Now set up the overlay size using the modified width and height
+	   from decimate and scaling calculations
+	 */
+	tmp =3D STG_READ_REG(DACOverlaySize);
+	CLEAR_BITS_FRM_TO(0, 10);
+	CLEAR_BITS_FRM_TO(12, 31);
+
+	if (ovlLinear) {
+		tmp |=3D
+		    (ovlStride | ((ulHeight + 1) << 12) |
+		     (((ulWidth / 8) - 1) << 23));
+	} else {
+		tmp |=3D
+		    (ovlStride | ((ulHeight + 1) << 12) |
+		     (((ulWidth / 32) - 1) << 23));
+	}
+
+	STG_WRITE_REG(DACOverlaySize, tmp);
+
+	/* Set Video Window Start */
+	tmp =3D ((ulLeft << 16)) | (srcDest.ulDstY1);
+	STG_WRITE_REG(DACVidWinStart, tmp);
+
+	/* Set Video Window End */
+	tmp =3D ((ulRight) << 16) | (srcDest.ulDstY2);
+	STG_WRITE_REG(DACVidWinEnd, tmp);
+
+	/* Finally set up the rest of the overlay regs in the order
+	   done in the IMG driver
+	 */
+	tmp =3D STG_READ_REG(DACPixelFormat);
+	tmp =3D ((ulExcessPixels << 16) | tmp) & 0x7fffffff;
+	STG_WRITE_REG(DACPixelFormat, tmp);
+
+	tmp =3D STG_READ_REG(DACHorizontalScal);
+	CLEAR_BITS_FRM_TO(0, 11);
+	CLEAR_BITS_FRM_TO(16, 17);
+	tmp |=3D ((ulhDecim << 16) | (ulDacXScale));
+	STG_WRITE_REG(DACHorizontalScal, tmp);
+
+	return 0;
+}
+
--- /dev/null	Fri Aug 30 19:31:37 2002
+++ fb--devel--2.6/drivers/video/kyro/STG4000Ramdac.c	Sun Jan 11 00:26:04 2=
004
@@ -0,0 +1,176 @@
+/*
+ *  linux/drivers/video/kyro/STG4000Ramdac.c
+ *
+ *  Copyright (C) 2002 STMicroelectronics
+ *
+ * This file is subject to the terms and conditions of the GNU General Pub=
lic
+ * License.  See the file COPYING in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <video/kyro.h>
+
+#include "STG4000Reg.h"
+#include "STG4000Interface.h"
+
+static u32 STG_PIXEL_BUS_WIDTH =3D 128;	/* 128 bit bus width      */
+static u32 REF_CLOCK =3D 14318;
+
+
+/* -------------------------------------------------------------
+    REQUIRED STATE FROM CLASS=20
+*/
+
+STG4000REG *pSTGReg;
+
+/* ---------------------------------------------------------------*/
+
+int InitialiseRamdac(volatile STG4000REG * pSTGReg,
+		     u32 displayDepth,
+		     u32 displayWidth,
+		     u32 displayHeight,
+		     s32 HSyncPolarity,
+		     s32 VSyncPolarity, u32 * pixelClock)
+{
+	u32 tmp =3D 0;
+	u32 F =3D 0, R =3D 0, P =3D 0;
+	u32 stride =3D 0;
+	u32 ulPdiv =3D 0;
+	u32 physicalPixelDepth =3D 0;
+	/* Make sure DAC is in Reset */
+	tmp =3D STG_READ_REG(SoftwareReset);
+
+	if (tmp & 0x1) {
+		CLEAR_BIT(1);
+		STG_WRITE_REG(SoftwareReset, tmp);
+	}
+
+	/* Set Pixel Format */
+	tmp =3D STG_READ_REG(DACPixelFormat);
+	CLEAR_BITS_FRM_TO(0, 2);
+
+	/* Set LUT not used from 16bpp to 32 bpp ??? */
+	CLEAR_BITS_FRM_TO(8, 9);
+
+	switch (displayDepth) {
+	case 16:
+		{
+			physicalPixelDepth =3D 16;
+			tmp |=3D _16BPP;
+			break;
+		}
+	  /*--- case 16 */
+	case 32:
+		{
+			/* Set for 32 bits per pixel */
+			physicalPixelDepth =3D 32;
+			tmp |=3D _32BPP;
+			break;
+		}
+	  /*--- case 32  */
+	default:
+		return -EINVAL;
+	}
+      /*--- switch(displayDepth)  */
+
+	STG_WRITE_REG(DACPixelFormat, tmp);
+
+	/* Workout Bus transfer bandwidth according to pixel format */
+	ulPdiv =3D STG_PIXEL_BUS_WIDTH / physicalPixelDepth;
+
+	/* Get Screen Stride in pixels */
+	stride =3D displayWidth;
+
+	/* Set Primary size info */
+	tmp =3D STG_READ_REG(DACPrimSize);
+	CLEAR_BITS_FRM_TO(0, 10);
+	CLEAR_BITS_FRM_TO(12, 31);
+	tmp |=3D
+	    ((((displayHeight - 1) << 12) | (((displayWidth / ulPdiv) -
+					      1) << 23))
+	     | (stride / ulPdiv));
+	STG_WRITE_REG(DACPrimSize, tmp);
+
+
+	/* Set Pixel Clock */
+	*pixelClock =3D ProgramClock(REF_CLOCK, *pixelClock, &F, &R, &P);
+
+	/* Set DAC PLL Mode */
+	tmp =3D STG_READ_REG(DACPLLMode);
+	CLEAR_BITS_FRM_TO(0, 15);
+	/* tmp |=3D ((P-1) | ((F-2) << 2) | ((R-2) << 11)); */
+	tmp |=3D ((P) | ((F - 2) << 2) | ((R - 2) << 11));
+	STG_WRITE_REG(DACPLLMode, tmp);
+
+	/* Set Prim Address */
+	tmp =3D STG_READ_REG(DACPrimAddress);
+	CLEAR_BITS_FRM_TO(0, 20);
+	CLEAR_BITS_FRM_TO(20, 31);
+	STG_WRITE_REG(DACPrimAddress, tmp);
+
+	/* Set Cursor details with HW Cursor disabled */
+	tmp =3D STG_READ_REG(DACCursorCtrl);
+	tmp &=3D ~SET_BIT(31);
+	STG_WRITE_REG(DACCursorCtrl, tmp);
+
+	tmp =3D STG_READ_REG(DACCursorAddr);
+	CLEAR_BITS_FRM_TO(0, 20);
+	STG_WRITE_REG(DACCursorAddr, tmp);
+
+	/* Set Video Window */
+	tmp =3D STG_READ_REG(DACVidWinStart);
+	CLEAR_BITS_FRM_TO(0, 10);
+	CLEAR_BITS_FRM_TO(16, 26);
+	STG_WRITE_REG(DACVidWinStart, tmp);
+
+	tmp =3D STG_READ_REG(DACVidWinEnd);
+	CLEAR_BITS_FRM_TO(0, 10);
+	CLEAR_BITS_FRM_TO(16, 26);
+	STG_WRITE_REG(DACVidWinEnd, tmp);
+
+	/* Set DAC Border Color to default */
+	tmp =3D STG_READ_REG(DACBorderColor);
+	CLEAR_BITS_FRM_TO(0, 23);
+	STG_WRITE_REG(DACBorderColor, tmp);
+
+	/* Set Graphics and Overlay Burst Control */
+	STG_WRITE_REG(DACBurstCtrl, 0x0404);
+
+	/* Set CRC Trigger to default */
+	tmp =3D STG_READ_REG(DACCrcTrigger);
+	CLEAR_BIT(0);
+	STG_WRITE_REG(DACCrcTrigger, tmp);
+
+	/* Set Video Port Control to default */
+	tmp =3D STG_READ_REG(DigVidPortCtrl);
+	CLEAR_BIT(8);
+	CLEAR_BITS_FRM_TO(16, 27);
+	CLEAR_BITS_FRM_TO(1, 3);
+	CLEAR_BITS_FRM_TO(10, 11);
+	STG_WRITE_REG(DigVidPortCtrl, tmp);
+
+	return 0;
+}
+
+
+/* Ramdac control, turning output to the screen on and off */
+void DisableRamdacOutput(volatile STG4000REG * pSTGReg)
+{
+	u32 tmp;
+
+	/* Disable DAC for Graphics Stream Control */
+	tmp =3D (STG_READ_REG(DACStreamCtrl)) & ~SET_BIT(0);
+	STG_WRITE_REG(DACStreamCtrl, tmp);
+}
+
+void EnableRamdacOutput(volatile STG4000REG * pSTGReg)
+{
+	u32 tmp;
+
+	/* Enable DAC for Graphics Stream Control */
+	tmp =3D (STG_READ_REG(DACStreamCtrl)) | SET_BIT(0);
+	STG_WRITE_REG(DACStreamCtrl, tmp);
+}
--- /dev/null	Fri Aug 30 19:31:37 2002
+++ fb--devel--2.6/drivers/video/kyro/STG4000Reg.h	Wed Jan  7 17:07:56 2004
@@ -0,0 +1,285 @@
+/*
+ *  linux/drivers/video/kyro/STG4000Reg.h
+ *
+ *  Copyright (C) 2002 STMicroelectronics
+ *
+ * This file is subject to the terms and conditions of the GNU General Pub=
lic
+ * License.  See the file COPYING in the main directory of this archive
+ * for more details.
+ */
+
+#ifndef _STG4000REG_H
+#define _STG4000REG_H
+
+
+#define DWFILL unsigned long :32
+#define WFILL unsigned short :16
+
+/*
+ * Macros that access memory mapped card registers in PCI space
+ * Add an appropraite section for your OS or processor architecture.
+ */
+#if defined(__KERNEL__)
+#include <asm/page.h>
+#include <asm/io.h>
+#define STG_WRITE_REG(reg,data) (writel(data,(unsigned long)&pSTGReg->reg))
+#define STG_READ_REG(reg)      (readl((unsigned long)&pSTGReg->reg))
+#else
+#define STG_WRITE_REG(reg,data) (pSTGReg->reg =3D data)
+#define STG_READ_REG(reg)      (pSTGReg->reg)
+#endif /* __KERNEL__ */
+
+#define SET_BIT(n) (1<<(n))
+#define CLEAR_BIT(n) (tmp &=3D ~(1<<n))
+#define CLEAR_BITS_FRM_TO(frm, to) \
+{\
+int i; \
+    for(i =3D frm; i<=3D to; i++) \
+	{ \
+	    tmp &=3D ~(1<<i); \
+	} \
+}
+
+#define CLEAR_BIT_2(n) (usTemp &=3D ~(1<<n))
+#define CLEAR_BITS_FRM_TO_2(frm, to) \
+{\
+int i; \
+    for(i =3D frm; i<=3D to; i++) \
+	{ \
+	    usTemp &=3D ~(1<<i); \
+	} \
+}
+
+/* LUT select */
+typedef enum _LUT_USES {
+	NO_LUT =3D 0, RESERVED, GRAPHICS, OVERLAY
+} LUT_USES;
+
+/* Primary surface pixel format select */
+typedef enum _PIXEL_FORMAT {
+	_8BPP =3D 0, _15BPP, _16BPP, _24BPP, _32BPP
+} PIXEL_FORMAT;
+
+/* Overlay blending mode select */
+typedef enum _BLEND_MODE {
+	GRAPHICS_MODE =3D 0, COLOR_KEY, PER_PIXEL_ALPHA, GLOBAL_ALPHA,
+	CK_PIXEL_ALPHA, CK_GLOBAL_ALPHA
+} OVRL_BLEND_MODE;
+
+/* Overlay Pixel format select */
+typedef enum _OVRL_PIX_FORMAT {
+	UYVY, VYUY, YUYV, YVYU
+} OVRL_PIX_FORMAT;
+
+
+/* Register Table */
+typedef struct {
+	/* 0h  */
+	volatile unsigned long Thread0Enable;	/* 0x0000 */
+	volatile unsigned long Thread1Enable;	/* 0x0004 */
+	volatile unsigned long Thread0Recover;	/* 0x0008 */
+	volatile unsigned long Thread1Recover;	/* 0x000C */
+	volatile unsigned long Thread0Step;	/* 0x0010 */
+	volatile unsigned long Thread1Step;	/* 0x0014 */
+	volatile unsigned long VideoInStatus;	/* 0x0018 */
+	volatile unsigned long Core2InSignStart;	/* 0x001C */
+	volatile unsigned long Core1ResetVector;	/* 0x0020 */
+	volatile unsigned long Core1ROMOffset;	/* 0x0024 */
+	volatile unsigned long Core1ArbiterPriority;	/* 0x0028 */
+	volatile unsigned long VideoInControl;	/* 0x002C */
+	volatile unsigned long VideoInReg0CtrlA;	/* 0x0030 */
+	volatile unsigned long VideoInReg0CtrlB;	/* 0x0034 */
+	volatile unsigned long VideoInReg1CtrlA;	/* 0x0038 */
+	volatile unsigned long VideoInReg1CtrlB;	/* 0x003C */
+	volatile unsigned long Thread0Kicker;	/* 0x0040 */
+	volatile unsigned long Core2InputSign;	/* 0x0044 */
+	volatile unsigned long Thread0ProgCtr;	/* 0x0048 */
+	volatile unsigned long Thread1ProgCtr;	/* 0x004C */
+	volatile unsigned long Thread1Kicker;	/* 0x0050 */
+	volatile unsigned long GPRegister1;	/* 0x0054 */
+	volatile unsigned long GPRegister2;	/* 0x0058 */
+	volatile unsigned long GPRegister3;	/* 0x005C */
+	volatile unsigned long GPRegister4;	/* 0x0060 */
+	volatile unsigned long SerialIntA;	/* 0x0064 */
+
+	volatile unsigned long Fill0[6];	/* GAP 0x0068 - 0x007C */
+
+	volatile unsigned long SoftwareReset;	/* 0x0080 */
+	volatile unsigned long SerialIntB;	/* 0x0084 */
+
+	volatile unsigned long Fill1[37];	/* GAP 0x0088 - 0x011C */
+
+	volatile unsigned long ROMELQV;	/* 0x011C */
+	volatile unsigned long WLWH;	/* 0x0120 */
+	volatile unsigned long ROMELWL;	/* 0x0124 */
+
+	volatile unsigned long dwFill_1;	/* GAP 0x0128 */
+
+	volatile unsigned long IntStatus;	/* 0x012C */
+	volatile unsigned long IntMask;	/* 0x0130 */
+	volatile unsigned long IntClear;	/* 0x0134 */
+
+	volatile unsigned long Fill2[6];	/* GAP 0x0138 - 0x014C */
+
+	volatile unsigned long ROMGPIOA;	/* 0x0150 */
+	volatile unsigned long ROMGPIOB;	/* 0x0154 */
+	volatile unsigned long ROMGPIOC;	/* 0x0158 */
+	volatile unsigned long ROMGPIOD;	/* 0x015C */
+
+	volatile unsigned long Fill3[2];	/* GAP 0x0160 - 0x0168 */
+
+	volatile unsigned long AGPIntID;	/* 0x0168 */
+	volatile unsigned long AGPIntClassCode;	/* 0x016C */
+	volatile unsigned long AGPIntBIST;	/* 0x0170 */
+	volatile unsigned long AGPIntSSID;	/* 0x0174 */
+	volatile unsigned long AGPIntPMCSR;	/* 0x0178 */
+	volatile unsigned long VGAFrameBufBase;	/* 0x017C */
+	volatile unsigned long VGANotify;	/* 0x0180 */
+	volatile unsigned long DACPLLMode;	/* 0x0184 */
+	volatile unsigned long Core1VideoClockDiv;	/* 0x0188 */
+	volatile unsigned long AGPIntStat;	/* 0x018C */
+
+	/*
+	   volatile unsigned long Fill4[0x0400/4 - 0x0190/4]; //GAP 0x0190 - 0x04=
00
+	   volatile unsigned long Fill5[0x05FC/4 - 0x0400/4]; //GAP 0x0400 - 0x05=
FC Fog Table
+	   volatile unsigned long Fill6[0x0604/4 - 0x0600/4]; //GAP 0x0600 - 0x06=
04
+	   volatile unsigned long Fill7[0x0680/4 - 0x0608/4]; //GAP 0x0608 - 0x06=
80
+	   volatile unsigned long Fill8[0x07FC/4 - 0x0684/4]; //GAP 0x0684 - 0x07=
FC
+	 */
+	volatile unsigned long Fill4[412];	/* 0x0190 - 0x07FC */
+
+	volatile unsigned long TACtrlStreamBase;	/* 0x0800 */
+	volatile unsigned long TAObjDataBase;	/* 0x0804 */
+	volatile unsigned long TAPtrDataBase;	/* 0x0808 */
+	volatile unsigned long TARegionDataBase;	/* 0x080C */
+	volatile unsigned long TATailPtrBase;	/* 0x0810 */
+	volatile unsigned long TAPtrRegionSize;	/* 0x0814 */
+	volatile unsigned long TAConfiguration;	/* 0x0818 */
+	volatile unsigned long TAObjDataStartAddr;	/* 0x081C */
+	volatile unsigned long TAObjDataEndAddr;	/* 0x0820 */
+	volatile unsigned long TAXScreenClip;	/* 0x0824 */
+	volatile unsigned long TAYScreenClip;	/* 0x0828 */
+	volatile unsigned long TARHWClamp;	/* 0x082C */
+	volatile unsigned long TARHWCompare;	/* 0x0830 */
+	volatile unsigned long TAStart;	/* 0x0834 */
+	volatile unsigned long TAObjReStart;	/* 0x0838 */
+	volatile unsigned long TAPtrReStart;	/* 0x083C */
+	volatile unsigned long TAStatus1;	/* 0x0840 */
+	volatile unsigned long TAStatus2;	/* 0x0844 */
+	volatile unsigned long TAIntStatus;	/* 0x0848 */
+	volatile unsigned long TAIntMask;	/* 0x084C */
+
+	volatile unsigned long Fill5[235];	/* GAP 0x0850 - 0x0BF8 */
+
+	volatile unsigned long TextureAddrThresh;	/* 0x0BFC */
+	volatile unsigned long Core1Translation;	/* 0x0C00 */
+	volatile unsigned long TextureAddrReMap;	/* 0x0C04 */
+	volatile unsigned long RenderOutAGPRemap;	/* 0x0C08 */
+	volatile unsigned long _3DRegionReadTrans;	/* 0x0C0C */
+	volatile unsigned long _3DPtrReadTrans;	/* 0x0C10 */
+	volatile unsigned long _3DParamReadTrans;	/* 0x0C14 */
+	volatile unsigned long _3DRegionReadThresh;	/* 0x0C18 */
+	volatile unsigned long _3DPtrReadThresh;	/* 0x0C1C */
+	volatile unsigned long _3DParamReadThresh;	/* 0x0C20 */
+	volatile unsigned long _3DRegionReadAGPRemap;	/* 0x0C24 */
+	volatile unsigned long _3DPtrReadAGPRemap;	/* 0x0C28 */
+	volatile unsigned long _3DParamReadAGPRemap;	/* 0x0C2C */
+	volatile unsigned long ZBufferAGPRemap;	/* 0x0C30 */
+	volatile unsigned long TAIndexAGPRemap;	/* 0x0C34 */
+	volatile unsigned long TAVertexAGPRemap;	/* 0x0C38 */
+	volatile unsigned long TAUVAddrTrans;	/* 0x0C3C */
+	volatile unsigned long TATailPtrCacheTrans;	/* 0x0C40 */
+	volatile unsigned long TAParamWriteTrans;	/* 0x0C44 */
+	volatile unsigned long TAPtrWriteTrans;	/* 0x0C48 */
+	volatile unsigned long TAParamWriteThresh;	/* 0x0C4C */
+	volatile unsigned long TAPtrWriteThresh;	/* 0x0C50 */
+	volatile unsigned long TATailPtrCacheAGPRe;	/* 0x0C54 */
+	volatile unsigned long TAParamWriteAGPRe;	/* 0x0C58 */
+	volatile unsigned long TAPtrWriteAGPRe;	/* 0x0C5C */
+	volatile unsigned long SDRAMArbiterConf;	/* 0x0C60 */
+	volatile unsigned long SDRAMConf0;	/* 0x0C64 */
+	volatile unsigned long SDRAMConf1;	/* 0x0C68 */
+	volatile unsigned long SDRAMConf2;	/* 0x0C6C */
+	volatile unsigned long SDRAMRefresh;	/* 0x0C70 */
+	volatile unsigned long SDRAMPowerStat;	/* 0x0C74 */
+
+	volatile unsigned long Fill6[2];	/* GAP 0x0C78 - 0x0C7C */
+
+	volatile unsigned long RAMBistData;	/* 0x0C80 */
+	volatile unsigned long RAMBistCtrl;	/* 0x0C84 */
+	volatile unsigned long FIFOBistKey;	/* 0x0C88 */
+	volatile unsigned long RAMBistResult;	/* 0x0C8C */
+	volatile unsigned long FIFOBistResult;	/* 0x0C90 */
+
+	/*
+	   volatile unsigned long Fill11[0x0CBC/4 - 0x0C94/4]; //GAP 0x0C94 - 0x0=
CBC
+	   volatile unsigned long Fill12[0x0CD0/4 - 0x0CC0/4]; //GAP 0x0CC0 - 0x0=
CD0 3DRegisters
+	 */
+
+	volatile unsigned long Fill7[16];	/* 0x0c94 - 0x0cd0 */
+
+	volatile unsigned long SDRAMAddrSign;	/* 0x0CD4 */
+	volatile unsigned long SDRAMDataSign;	/* 0x0CD8 */
+	volatile unsigned long SDRAMSignConf;	/* 0x0CDC */
+
+	/* DWFILL; //GAP 0x0CE0 */
+	volatile unsigned long dwFill_2;
+
+	volatile unsigned long ISPSignature;	/* 0x0CE4 */
+
+	volatile unsigned long Fill8[454];	/*GAP 0x0CE8 - 0x13FC */
+
+	volatile unsigned long DACPrimAddress;	/* 0x1400 */
+	volatile unsigned long DACPrimSize;	/* 0x1404 */
+	volatile unsigned long DACCursorAddr;	/* 0x1408 */
+	volatile unsigned long DACCursorCtrl;	/* 0x140C */
+	volatile unsigned long DACOverlayAddr;	/* 0x1410 */
+	volatile unsigned long DACOverlayUAddr;	/* 0x1414 */
+	volatile unsigned long DACOverlayVAddr;	/* 0x1418 */
+	volatile unsigned long DACOverlaySize;	/* 0x141C */
+	volatile unsigned long DACOverlayVtDec;	/* 0x1420 */
+
+	volatile unsigned long Fill9[9];	/* GAP 0x1424 - 0x1444 */
+
+	volatile unsigned long DACVerticalScal;	/* 0x1448 */
+	volatile unsigned long DACPixelFormat;	/* 0x144C */
+	volatile unsigned long DACHorizontalScal;	/* 0x1450 */
+	volatile unsigned long DACVidWinStart;	/* 0x1454 */
+	volatile unsigned long DACVidWinEnd;	/* 0x1458 */
+	volatile unsigned long DACBlendCtrl;	/* 0x145C */
+	volatile unsigned long DACHorTim1;	/* 0x1460 */
+	volatile unsigned long DACHorTim2;	/* 0x1464 */
+	volatile unsigned long DACHorTim3;	/* 0x1468 */
+	volatile unsigned long DACVerTim1;	/* 0x146C */
+	volatile unsigned long DACVerTim2;	/* 0x1470 */
+	volatile unsigned long DACVerTim3;	/* 0x1474 */
+	volatile unsigned long DACBorderColor;	/* 0x1478 */
+	volatile unsigned long DACSyncCtrl;	/* 0x147C */
+	volatile unsigned long DACStreamCtrl;	/* 0x1480 */
+	volatile unsigned long DACLUTAddress;	/* 0x1484 */
+	volatile unsigned long DACLUTData;	/* 0x1488 */
+	volatile unsigned long DACBurstCtrl;	/* 0x148C */
+	volatile unsigned long DACCrcTrigger;	/* 0x1490 */
+	volatile unsigned long DACCrcDone;	/* 0x1494 */
+	volatile unsigned long DACCrcResult1;	/* 0x1498 */
+	volatile unsigned long DACCrcResult2;	/* 0x149C */
+	volatile unsigned long DACLinecount;	/* 0x14A0 */
+
+	volatile unsigned long Fill10[151];	/*GAP 0x14A4 - 0x16FC */
+
+	volatile unsigned long DigVidPortCtrl;	/* 0x1700 */
+	volatile unsigned long DigVidPortStat;	/* 0x1704 */
+
+	/*
+	   volatile unsigned long Fill11[0x1FFC/4 - 0x1708/4]; //GAP 0x1708 - 0x1=
FFC
+	   volatile unsigned long Fill17[0x3000/4 - 0x2FFC/4]; //GAP 0x2000 - 0x2=
FFC ALUT
+	 */
+
+	volatile unsigned long Fill11[1598];
+
+	/* DWFILL; //GAP 0x3000          ALUT 256MB offset */
+	volatile unsigned long Fill_3;
+
+} STG4000REG;
+
+#endif /* _STG4000REG_H */
--- /dev/null	Fri Aug 30 19:31:37 2002
+++ fb--devel--2.6/drivers/video/kyro/STG4000VTG.c	Sun Jan 11 00:26:18 2004
@@ -0,0 +1,173 @@
+/*
+ *  linux/drivers/video/kyro/STG4000VTG.c
+ *
+ *  Copyright (C) 2002 STMicroelectronics
+ *
+ * This file is subject to the terms and conditions of the GNU General Pub=
lic
+ * License.  See the file COPYING in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/types.h>
+#include <video/kyro.h>
+
+#include "STG4000Reg.h"
+#include "STG4000Interface.h"
+
+void DisableVGA(volatile STG4000REG * pSTGReg)
+{
+	u32 tmp;
+	volatile u32 count, i;
+
+	/* Reset the VGA registers */
+	tmp =3D STG_READ_REG(SoftwareReset);
+	CLEAR_BIT(8);
+	STG_WRITE_REG(SoftwareReset, tmp);
+
+	/* Just for Delay */
+	for (i =3D 0; i < 1000; i++) {
+		count++;
+	}
+
+	/* Pull-out the VGA registers from reset */
+	tmp =3D STG_READ_REG(SoftwareReset);
+	tmp |=3D SET_BIT(8);
+	STG_WRITE_REG(SoftwareReset, tmp);
+}
+
+
+void StopVTG(volatile STG4000REG * pSTGReg)
+{
+	u32 tmp =3D 0;
+
+	/* Stop Ver and Hor Sync Generator */
+	tmp =3D (STG_READ_REG(DACSyncCtrl)) | SET_BIT(0) | SET_BIT(2);
+	CLEAR_BIT(31);
+	STG_WRITE_REG(DACSyncCtrl, tmp);
+}
+
+void StartVTG(volatile STG4000REG * pSTGReg)
+{
+	u32 tmp =3D 0;
+
+	/* Start Ver and Hor Sync Generator */
+	tmp =3D ((STG_READ_REG(DACSyncCtrl)) | SET_BIT(31));
+	CLEAR_BIT(0);
+	CLEAR_BIT(2);
+	STG_WRITE_REG(DACSyncCtrl, tmp);
+}
+
+void SetupVTG(volatile STG4000REG * pSTGReg,
+	      const struct kyrofb_info * pTiming)
+{
+	u32 tmp =3D 0;
+	u32 margins =3D 0;
+	u32 ulBorder;
+	u32 xRes =3D pTiming->XRES;
+	u32 yRes =3D pTiming->YRES;
+
+	/* Horizontal */
+	u32 HAddrTime, HRightBorder, HLeftBorder;
+	u32 HBackPorcStrt, HFrontPorchStrt, HTotal,
+	    HLeftBorderStrt, HRightBorderStrt, HDisplayStrt;
+
+	/* Vertical */
+	u32 VDisplayStrt, VBottomBorder, VTopBorder;
+	u32 VBackPorchStrt, VTotal, VTopBorderStrt,
+	    VFrontPorchStrt, VBottomBorderStrt, VAddrTime;
+
+	/* Need to calculate the right border */
+	if ((xRes =3D=3D 640) && (yRes =3D=3D 480)) {
+		if ((pTiming->VFREQ =3D=3D 60) || (pTiming->VFREQ =3D=3D 72)) {
+			margins =3D 8;
+		}
+	}
+
+	/* Work out the Border */
+	ulBorder =3D
+	    (pTiming->HTot -
+	     (pTiming->HST + (pTiming->HBP - margins) + xRes +
+	      (pTiming->HFP - margins))) >> 1;
+
+	/* Border the same for Vertical and Horizontal */
+	VBottomBorder =3D HLeftBorder =3D VTopBorder =3D HRightBorder =3D ulBorde=
r;
+
+    /************ Get Timing values for Horizontal ******************/
+	HAddrTime =3D xRes;
+	HBackPorcStrt =3D pTiming->HST;
+	HTotal =3D pTiming->HTot;
+	HDisplayStrt =3D
+	    pTiming->HST + (pTiming->HBP - margins) + HLeftBorder;
+	HLeftBorderStrt =3D HDisplayStrt - HLeftBorder;
+	HFrontPorchStrt =3D
+	    pTiming->HST + (pTiming->HBP - margins) + HLeftBorder +
+	    HAddrTime + HRightBorder;
+	HRightBorderStrt =3D HFrontPorchStrt - HRightBorder;
+
+    /************ Get Timing values for Vertical ******************/
+	VAddrTime =3D yRes;
+	VBackPorchStrt =3D pTiming->VST;
+	VTotal =3D pTiming->VTot;
+	VDisplayStrt =3D
+	    pTiming->VST + (pTiming->VBP - margins) + VTopBorder;
+	VTopBorderStrt =3D VDisplayStrt - VTopBorder;
+	VFrontPorchStrt =3D
+	    pTiming->VST + (pTiming->VBP - margins) + VTopBorder +
+	    VAddrTime + VBottomBorder;
+	VBottomBorderStrt =3D VFrontPorchStrt - VBottomBorder;
+
+	/* Set Hor Timing 1, 2, 3 */
+	tmp =3D STG_READ_REG(DACHorTim1);
+	CLEAR_BITS_FRM_TO(0, 11);
+	CLEAR_BITS_FRM_TO(16, 27);
+	tmp |=3D (HTotal) | (HBackPorcStrt << 16);
+	STG_WRITE_REG(DACHorTim1, tmp);
+
+	tmp =3D STG_READ_REG(DACHorTim2);
+	CLEAR_BITS_FRM_TO(0, 11);
+	CLEAR_BITS_FRM_TO(16, 27);
+	tmp |=3D (HDisplayStrt << 16) | HLeftBorderStrt;
+	STG_WRITE_REG(DACHorTim2, tmp);
+
+
+	tmp =3D STG_READ_REG(DACHorTim3);
+	CLEAR_BITS_FRM_TO(0, 11);
+	CLEAR_BITS_FRM_TO(16, 27);
+	tmp |=3D (HFrontPorchStrt << 16) | HRightBorderStrt;
+	STG_WRITE_REG(DACHorTim3, tmp);
+
+	/* Set Ver Timing 1, 2, 3 */
+	tmp =3D STG_READ_REG(DACVerTim1);
+	CLEAR_BITS_FRM_TO(0, 11);
+	CLEAR_BITS_FRM_TO(16, 27);
+	tmp |=3D (VBackPorchStrt << 16) | (VTotal);
+	STG_WRITE_REG(DACVerTim1, tmp);
+
+	tmp =3D STG_READ_REG(DACVerTim2);
+	CLEAR_BITS_FRM_TO(0, 11);
+	CLEAR_BITS_FRM_TO(16, 27);
+	tmp |=3D (VDisplayStrt << 16) | VTopBorderStrt;
+	STG_WRITE_REG(DACVerTim2, tmp);
+
+	tmp =3D STG_READ_REG(DACVerTim3);
+	CLEAR_BITS_FRM_TO(0, 11);
+	CLEAR_BITS_FRM_TO(16, 27);
+	tmp |=3D (VFrontPorchStrt << 16) | VBottomBorderStrt;
+	STG_WRITE_REG(DACVerTim3, tmp);
+
+
+	/* Set Verical and Horizontal Polarity */
+	tmp =3D STG_READ_REG(DACSyncCtrl) | SET_BIT(3) | SET_BIT(1);
+
+	if ((pTiming->HSP > 0) && (pTiming->VSP < 0)) {	/* +hsync -vsync */
+		tmp &=3D ~0x8;
+	} else if ((pTiming->HSP < 0) && (pTiming->VSP > 0)) {	/* -hsync +vsync */
+		tmp &=3D ~0x2;
+	} else if ((pTiming->HSP < 0) && (pTiming->VSP < 0)) {	/* -hsync -vsync */
+		tmp &=3D ~0xA;
+	} else if ((pTiming->HSP > 0) && (pTiming->VSP > 0)) {	/* +hsync -vsync */
+		tmp &=3D ~0x0;
+	}
+
+	STG_WRITE_REG(DACSyncCtrl, tmp);
+}
--- /dev/null	Fri Aug 30 19:31:37 2002
+++ fb--devel--2.6/drivers/video/kyro/fbdev.c	Sun Jan 11 11:14:11 2004
@@ -0,0 +1,812 @@
+/*
+ *  linux/drivers/video/kyro/kyrofb.c
+ *
+ *  Copyright (C) 2002 STMicroelectronics
+ *  Copyright (C) 2003, 2004 Paul Mundt
+ *
+ * This file is subject to the terms and conditions of the GNU General Pub=
lic
+ * License.  See the file COPYING in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/tty.h>
+#include <linux/delay.h>
+#include <linux/fb.h>
+#include <linux/ioctl.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <asm/io.h>
+#include <asm/uaccess.h>
+#ifdef CONFIG_MTRR
+#include <asm/mtrr.h>
+#endif
+
+#include <video/kyro.h>
+
+#include "STG4000Reg.h"
+#include "STG4000Interface.h"
+
+/*
+ * PCI Definitions
+ */
+#define PCI_VENDOR_ID_ST	0x104a
+#define PCI_DEVICE_ID_STG4000	0x0010
+
+#define KHZ2PICOS(a) (1000000000UL/(a))
+
+/*************************************************************************=
***/
+static struct fb_fix_screeninfo kyro_fix __initdata =3D {
+	.id		=3D "ST Kyro",
+	.type		=3D FB_TYPE_PACKED_PIXELS,
+	.visual		=3D FB_VISUAL_TRUECOLOR,
+	.accel		=3D FB_ACCEL_NONE,
+};
+
+static struct fb_var_screeninfo kyro_var __initdata =3D {
+	/* 640x480, 16bpp @ 60 Hz */
+	.xres		=3D 640,
+	.yres		=3D 480,
+	.xres_virtual	=3D 640,
+	.yres_virtual	=3D 480,
+	.bits_per_pixel	=3D 16,
+	.red		=3D { 11, 5, 0 },
+	.green		=3D {  5, 6, 0 },
+	.blue		=3D {  0, 5, 0 },
+	.activate	=3D FB_ACTIVATE_NOW,
+	.height		=3D -1,
+	.width		=3D -1,
+	.pixclock	=3D KHZ2PICOS(25175),
+	.left_margin	=3D 48,
+	.right_margin	=3D 16,
+	.upper_margin	=3D 33,
+	.lower_margin	=3D 10,
+	.hsync_len	=3D 96,
+	.vsync_len	=3D 2,
+	.vmode		=3D FB_VMODE_NONINTERLACED,
+};
+
+static struct kyrofb_info *currentpar;
+
+typedef struct {
+	STG4000REG *pSTGReg;	/* Virtual address of PCI register region */
+	u32 ulNextFreeVidMem;	/* Offset from start of vid mem to next free region=
 */
+	u32 ulOverlayOffset;	/* Offset from start of vid mem to overlay */
+	u32 ulOverlayStride;	/* Interleaved YUV and 422 mode Y stride */
+	u32 ulOverlayUVStride;	/* 422 mode U & V stride */
+} device_info_t;
+
+/* global graphics card info structure (one per card) */
+static device_info_t deviceInfo =3D { 0 };
+
+static char *mode_option __initdata =3D NULL;
+static int nopan __initdata =3D 0;
+static int nowrap __initdata =3D 1;
+#ifdef CONFIG_MTRR
+static int nomtrr __initdata =3D 0;
+#endif
+
+/* PCI driver prototypes */
+static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *=
ent);
+static void kyrofb_remove(struct pci_dev *pdev);
+
+#ifndef MODULE
+static struct fb_videomode kyro_modedb[] __initdata =3D {
+	{
+		/* 640x350 @ 85Hz */
+		NULL, 85, 640, 350, KHZ2PICOS(31500),
+		96, 32, 60, 32, 64, 3,
+		FB_SYNC_HOR_HIGH_ACT, FB_VMODE_NONINTERLACED
+	}, {
+		/* 640x400 @ 85Hz */
+		NULL, 85, 640, 400, KHZ2PICOS(31500),
+		96, 32, 41, 1, 64, 3,
+		FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+	}, {
+		/* 720x400 @ 85Hz */
+		NULL, 85, 720, 400, KHZ2PICOS(35500),
+		108, 36, 42, 1, 72, 3,
+		FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+	}, {
+		/* 640x480 @ 60Hz */
+		NULL, 60, 640, 480, KHZ2PICOS(25175),
+		48, 16, 33, 10, 96, 2,
+		0, FB_VMODE_NONINTERLACED
+	}, {
+		/* 640x480 @ 72Hz */
+		NULL, 72, 640, 480, KHZ2PICOS(31500),
+		128, 24, 28, 9, 40, 3,
+		0, FB_VMODE_NONINTERLACED
+	}, {
+		/* 640x480 @ 75Hz */
+		NULL, 75, 640, 480, KHZ2PICOS(31500),
+		120, 16, 16, 1, 64, 3,
+		0, FB_VMODE_NONINTERLACED
+	}, {
+		/* 640x480 @ 85Hz */
+		NULL, 85, 640, 480, KHZ2PICOS(36000),
+		80, 56, 25, 1, 56, 3,
+		0, FB_VMODE_NONINTERLACED
+	}, {
+		/* 800x600 @ 56Hz */
+		NULL, 56, 800, 600, KHZ2PICOS(36000),
+		128, 24, 22, 1, 72, 2,
+		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+	}, {
+		/* 800x600 @ 60Hz */
+		NULL, 60, 800, 600, KHZ2PICOS(40000),
+		88, 40, 23, 1, 128, 4,
+		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+	}, {
+		/* 800x600 @ 72Hz */
+		NULL, 72, 800, 600, KHZ2PICOS(50000),
+		64, 56, 23, 37, 120, 6,
+		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+	}, {
+		/* 800x600 @ 75Hz */
+		NULL, 75, 800, 600, KHZ2PICOS(49500),
+		160, 16, 21, 1, 80, 3,
+		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+	}, {
+		/* 800x600 @ 85Hz */
+		NULL, 85, 800, 600, KHZ2PICOS(56250),
+		152, 32, 27, 1, 64, 3,
+		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+	}, {
+		/* 1024x768 @ 60Hz */
+		NULL, 60, 1024, 768, KHZ2PICOS(65000),
+		160, 24, 29, 3, 136, 6,
+		0, FB_VMODE_NONINTERLACED
+	}, {
+		/* 1024x768 @ 70Hz */
+		NULL, 70, 1024, 768, KHZ2PICOS(75000),
+		144, 24, 29, 3, 136, 6,
+		0, FB_VMODE_NONINTERLACED
+	}, {
+		/* 1024x768 @ 75Hz */
+		NULL, 75, 1024, 768, KHZ2PICOS(78750),
+		176, 16, 28, 1, 96, 3,
+		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+	}, {
+		/* 1024x768 @ 85Hz */
+		NULL, 85, 1024, 768, KHZ2PICOS(94500),
+		208, 48, 36, 1, 96, 3,
+		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+	}, {
+		/* 1152x864 @ 75Hz */
+		NULL, 75, 1152, 864, KHZ2PICOS(108000),
+		256, 64, 32, 1, 128, 3,
+		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+	}, {
+		/* 1280x960 @ 60Hz */
+		NULL, 60, 1280, 960, KHZ2PICOS(108000),
+		312, 96, 36, 1, 112, 3,
+		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+	}, {
+		/* 1280x960 @ 85Hz */
+		NULL, 85, 1280, 960, KHZ2PICOS(148500),
+		224, 64, 47, 1, 160, 3,
+		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+	}, {
+		/* 1280x1024 @ 60Hz */
+		NULL, 60, 1280, 1024, KHZ2PICOS(108000),
+		248, 48, 38, 1, 112, 3,
+		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+	}, {
+		/* 1280x1024 @ 75Hz */
+		NULL, 75, 1280, 1024, KHZ2PICOS(135000),
+		248, 16, 38, 1, 144, 3,
+		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+	}, {
+		/* 1280x1024 @ 85Hz */
+		NULL, 85, 1280, 1024, KHZ2PICOS(157500),
+		224, 64, 44, 1, 160, 3,
+		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+	}, {
+		/* 1600x1200 @ 60Hz */
+		NULL, 60, 1600, 1200, KHZ2PICOS(162000),
+		304, 64, 46, 1, 192, 3,
+		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+	}, {
+		/* 1600x1200 @ 65Hz */
+		NULL, 65, 1600, 1200, KHZ2PICOS(175500),
+		304, 64, 46, 1, 192, 3,
+		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+	}, {
+		/* 1600x1200 @ 70Hz */
+		NULL, 70, 1600, 1200, KHZ2PICOS(189000),
+		304, 64, 46, 1, 192, 3,
+		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+	}, {
+		/* 1600x1200 @ 75Hz */
+		NULL, 75, 1600, 1200, KHZ2PICOS(202500),
+		304, 64, 46, 1, 192, 3,
+		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+	}, {
+		/* 1600x1200 @ 85Hz */
+		NULL, 85, 1600, 1200, KHZ2PICOS(229500),
+		304, 64, 46, 1, 192, 3,
+		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+	}, {
+		/* 1792x1344 @ 60Hz */
+		NULL, 60, 1792, 1344, KHZ2PICOS(204750),
+		328, 128, 46, 1, 200, 3,
+		FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+	}, {
+		/* 1792x1344 @ 75Hz */
+		NULL, 75, 1792, 1344, KHZ2PICOS(261000),
+		352, 96, 69, 1, 216, 3,
+		FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+	}, {
+		/* 1856x1392 @ 60Hz */
+		NULL, 60, 1856, 1392, KHZ2PICOS(218250),
+		352, 96, 43, 1, 224, 3,
+		FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+	}, {
+		/* 1856x1392 @ 75Hz */
+		NULL, 75, 1856, 1392, KHZ2PICOS(288000),
+		352, 128, 104, 1, 224, 3,
+		FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+	}, {
+		/* 1920x1440 @ 60Hz */
+		NULL, 60, 1920, 1440, KHZ2PICOS(234000),
+		344, 128, 56, 1, 208, 3,
+		FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+	}, {
+		/* 1920x1440 @ 75Hz */
+		NULL, 75, 1920, 1440, KHZ2PICOS(297000),
+		352, 144, 56, 1, 224, 3,
+		FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+	},
+};
+#define NUM_TOTAL_MODES	ARRAY_SIZE(kyro_modedb)
+
+/*
+ * This needs to be kept ordered corresponding to kyro_modedb.
+ */
+enum {
+	VMODE_640_350_85,
+	VMODE_640_400_85,
+	VMODE_720_400_85,
+	VMODE_640_480_60,
+	VMODE_640_480_72,
+	VMODE_640_480_75,
+	VMODE_640_480_85,
+	VMODE_800_600_56,
+	VMODE_800_600_60,
+	VMODE_800_600_72,
+	VMODE_800_600_75,
+	VMODE_800_600_85,
+	VMODE_1024_768_60,
+	VMODE_1024_768_70,
+	VMODE_1024_768_75,
+	VMODE_1024_768_85,
+	VMODE_1152_864_75,
+	VMODE_1280_960_60,
+	VMODE_1280_960_85,
+	VMODE_1280_1024_60,
+	VMODE_1280_1024_75,
+	VMODE_1280_1024_85,
+	VMODE_1600_1200_60,
+	VMODE_1600_1200_65,
+	VMODE_1600_1200_70,
+	VMODE_1600_1200_75,
+	VMODE_1600_1200_85,
+	VMODE_1792_1344_60,
+	VMODE_1792_1344_75,
+	VMODE_1856_1392_60,
+	VMODE_1856_1392_75,
+	VMODE_1920_1440_60,
+	VMODE_1920_1440_75,
+};
+#endif
+
+/* Accessors */
+int kyro_dev_video_mode_set(struct fb_info *info)
+{
+	struct kyrofb_info *par =3D (struct kyrofb_info *)info->par;
+
+	/* Turn off display */
+	StopVTG(deviceInfo.pSTGReg);
+	DisableRamdacOutput(deviceInfo.pSTGReg);
+
+	/* Bring us out of VGA and into Hi-Res mode, if not already. */
+	DisableVGA(deviceInfo.pSTGReg);
+
+	if (InitialiseRamdac(deviceInfo.pSTGReg,
+			     info->var.bits_per_pixel,
+			     info->var.xres, info->var.yres,
+			     par->HSP, par->VSP, &par->PIXCLK) < 0)
+		return -EINVAL;
+
+	SetupVTG(deviceInfo.pSTGReg, par);
+
+	ResetOverlayRegisters(deviceInfo.pSTGReg);
+
+	/* Turn on display in new mode */
+	EnableRamdacOutput(deviceInfo.pSTGReg);
+	StartVTG(deviceInfo.pSTGReg);
+
+	deviceInfo.ulNextFreeVidMem =3D info->var.xres * info->var.yres *
+				      info->var.bits_per_pixel;
+	deviceInfo.ulOverlayOffset =3D 0;
+
+	return 0;
+}
+
+/*---------------------------------------------------------------*/
+
+int kyro_dev_overlay_create(u32 ulWidth,
+			    u32 ulHeight, int bLinear)
+{
+	u32 offset;
+	u32 stride, uvStride;
+
+	if (deviceInfo.ulOverlayOffset !=3D 0)
+		/*=20
+		 * Can only create one overlay without resetting the card or
+		 * changing display mode
+		 */
+		return -EINVAL;
+
+	ResetOverlayRegisters(deviceInfo.pSTGReg);
+
+	/* Overlays are addressed in multiples of 16bytes or 32bytes, so make
+	 * sure the start offset is on an appropriate boundary.
+	 */
+	offset =3D deviceInfo.ulNextFreeVidMem;
+	if ((offset & 0x1f) !=3D 0) {
+		offset =3D (offset + 32L) & 0xffffffE0L;
+	}
+
+	if (CreateOverlaySurface(deviceInfo.pSTGReg, ulWidth, ulHeight,
+				 bLinear, offset, &stride, &uvStride) < 0)
+		return -EINVAL;
+
+	deviceInfo.ulOverlayOffset =3D offset;
+	deviceInfo.ulOverlayStride =3D stride;
+	deviceInfo.ulOverlayUVStride =3D uvStride;
+	deviceInfo.ulNextFreeVidMem =3D offset + (ulHeight * stride) + (ulHeight =
* 2 * uvStride);
+
+	SetOverlayBlendMode(deviceInfo.pSTGReg, GLOBAL_ALPHA, 0xf, 0x0);
+
+	return 0;
+}
+
+int kyro_dev_overlay_viewport_set(u32 x, u32 y, u32 ulWidth, u32 ulHeight)
+{
+	if (deviceInfo.ulOverlayOffset =3D=3D 0)
+		/* probably haven't called CreateOverlay yet */
+		return -EINVAL;
+
+	/* Stop Ramdac Output */
+	DisableRamdacOutput(deviceInfo.pSTGReg);
+
+	SetOverlayViewPort(deviceInfo.pSTGReg,
+			   x, y, x + ulWidth - 1, y + ulHeight - 1);
+
+	EnableOverlayPlane(deviceInfo.pSTGReg);
+	/* Start Ramdac Output */
+	EnableRamdacOutput(deviceInfo.pSTGReg);
+
+	return 0;
+}
+
+static inline unsigned long get_line_length(int x, int bpp)
+{
+	return (unsigned long)((((x*bpp)+31)&~31) >> 3);
+}
+
+static int kyrofb_check_var(struct fb_var_screeninfo *var, struct fb_info =
*info)
+{
+	struct kyrofb_info *par =3D (struct kyrofb_info *)info->par;
+
+	if (var->bits_per_pixel !=3D 16 && var->bits_per_pixel !=3D 32) {
+		printk(KERN_WARNING "kyrofb: depth not supported: %u\n", var->bits_per_p=
ixel);
+		return -EINVAL;
+	}
+
+	switch (var->bits_per_pixel) {
+	case 16:
+		var->red.offset =3D 11;
+		var->red.length =3D 5;
+		var->green.offset =3D 5;
+		var->green.length =3D 6;
+		var->blue.length =3D 5;
+		break;
+	case 32:
+		var->transp.offset =3D 24;
+		var->red.offset =3D 16;
+		var->green.offset =3D 8;
+		var->blue.offset =3D 0;
+
+		var->red.length =3D 8;
+		var->green.length =3D 8;
+		var->blue.length =3D 8;
+		var->transp.length =3D 8;
+		break;
+	}
+
+	/* Height/Width of picture in mm */
+	var->height =3D var->width =3D -1;
+
+	/* Timing information. All values are in picoseconds */
+
+	/* par->PIXCLK is in 100Hz units. Convert to picoseconds -
+	 * ensuring we do not exceed 32 bit precision
+	 */
+	/*=20
+	 * XXX: Enabling this really screws over the pixclock value when we
+	 * read it back with fbset. As such, leaving this commented out appears
+	 * to do the right thing (at least for now) .. bearing in mind that we
+	 * have infact already done the KHZ2PICOS conversion in both the modedb
+	 * and kyro_var. -- PFM.
+	 */
+//	var->pixclock =3D 1000000000 / (par->PIXCLK / 10);
+
+	/* the header file claims we should use picoseconds
+	 * - nobody else does though, the all use pixels and lines
+	 * of h and v sizes. Both options here.
+	 */
+
+	/*=20
+	 * If we're being called by __fb_try_mode(), then we don't want to
+	 * override any of the var settings that we've already parsed
+	 * from our modedb. -- PFM.
+	 */
+	if ((var->activate & FB_ACTIVATE_MASK) =3D=3D FB_ACTIVATE_TEST)
+		return 0;
+
+	var->left_margin =3D par->HBP;
+	var->hsync_len =3D par->HST;
+	var->right_margin =3D par->HFP;
+
+	var->upper_margin =3D par->VBP;
+	var->vsync_len =3D par->VST;
+	var->lower_margin =3D par->VFP;
+
+	if (par->HSP =3D=3D 1)
+		var->sync |=3D FB_SYNC_HOR_HIGH_ACT;
+	if (par->VSP =3D=3D 1)
+		var->sync |=3D FB_SYNC_VERT_HIGH_ACT;
+=09
+	return 0;
+}
+
+static int kyrofb_set_par(struct fb_info *info)
+{
+	struct kyrofb_info *par =3D (struct kyrofb_info *)info->par;
+	unsigned long lineclock;
+	unsigned long frameclock;
+
+	/* Actual resolution */
+	par->XRES =3D info->var.xres;
+	par->YRES =3D info->var.yres;
+
+	/* pixel depth */
+	par->PIXDEPTH =3D info->var.bits_per_pixel;
+
+	/* Refresh rate */
+	/* time for a line in ns */
+	lineclock =3D (info->var.pixclock * (info->var.xres +
+				    info->var.right_margin +
+				    info->var.hsync_len +
+				    info->var.left_margin)) / 1000;
+
+
+	/* time for a frame in ns (precision in 32bpp) */
+	frameclock =3D lineclock * (info->var.yres +
+				  info->var.lower_margin +
+				  info->var.vsync_len +
+				  info->var.upper_margin);
+
+	/* Calculate refresh rate and horrizontal clocks */
+	par->VFREQ =3D (1000000000 + (frameclock / 2)) / frameclock;
+	par->HCLK =3D (1000000000 + (lineclock / 2)) / lineclock;
+	par->PIXCLK =3D ((1000000000 + (info->var.pixclock / 2))
+					/ info->var.pixclock) * 10;
+
+	/* calculate horizontal timings */
+	par->HFP =3D info->var.right_margin;
+	par->HST =3D info->var.hsync_len;
+	par->HBP =3D info->var.left_margin;
+	par->HTot =3D par->XRES + par->HBP + par->HST + par->HFP;
+
+	/* calculate vertical timings */
+	par->VFP =3D info->var.lower_margin;
+	par->VST =3D info->var.vsync_len;
+	par->VBP =3D info->var.upper_margin;
+	par->VTot =3D par->YRES + par->VBP + par->VST + par->VFP;
+
+	par->HSP =3D (info->var.sync & FB_SYNC_HOR_HIGH_ACT) ? 1 : 0;
+	par->VSP =3D (info->var.sync & FB_SYNC_VERT_HIGH_ACT) ? 1 : 0;
+
+	kyro_dev_video_mode_set(info);
+
+	/* length of a line in bytes    */
+	info->fix.line_length =3D get_line_length(par->XRES, par->PIXDEPTH);
+	info->fix.visual =3D FB_VISUAL_TRUECOLOR;
+
+	return 0;
+}
+
+static int kyrofb_setcolreg(u_int regno, u_int red, u_int green,
+			    u_int blue, u_int transp, struct fb_info *info)
+{
+	if (regno > 255)
+		return 1;	/* Invalid register */
+
+	if (regno < 16) {
+		switch (info->var.bits_per_pixel) {
+		case 16:
+			((u16*)(info->pseudo_palette))[regno] =3D
+			     (red   & 0xf800) |
+			    ((green & 0xfc00) >> 5) |
+			    ((blue  & 0xf800) >> 11);
+			break;
+		case 32:
+			red >>=3D 8; green >>=3D 8; blue >>=3D 8; transp >>=3D 8;
+			((u32*)(info->pseudo_palette))[regno] =3D
+			    (transp << 24) | (red << 16) | (green << 8) | blue;
+			break;
+		}
+	}
+
+	return 0;
+}
+
+int __init kyrofb_setup(char *options)
+{
+	char *this_opt;
+
+	if (!options || !*options)
+		return 0;
+
+	while ((this_opt =3D strsep(&options, ","))) {
+		if (!*this_opt)
+			continue;
+		if (strcmp(this_opt, "nopan") =3D=3D 0) {
+			nopan =3D 1;
+		} else if (strcmp(this_opt, "nowrap") =3D=3D 0) {
+			nowrap =3D 1;
+#ifdef CONFIG_MTRR
+		} else if (strcmp(this_opt, "nomtrr") =3D=3D 0) {
+			nomtrr =3D 1;
+#endif
+		} else {
+			mode_option =3D this_opt;
+		}
+	}
+
+	return 0;
+}
+
+/* -----------------------------------------------------------------------=
-- */
+
+static int kyrofb_ioctl(struct inode *inode, struct file *file,
+			unsigned int cmd, unsigned long arg,
+			struct fb_info *info)
+{
+	overlay_create ol_create;
+	overlay_viewport_set ol_viewport_set;
+
+	switch (cmd) {
+	case KYRO_IOCTL_OVERLAY_CREATE:
+		copy_from_user((void *) &ol_create, (void *) arg,
+			       sizeof(overlay_create));
+
+		if (kyro_dev_overlay_create(ol_create.ulWidth,
+					    ol_create.ulHeight, 0) < 0) {
+			printk(KERN_ERR "Kyro FB: failed to create overlay surface.\n");
+
+			return -EINVAL;
+		}
+		break;
+	case KYRO_IOCTL_OVERLAY_VIEWPORT_SET:
+		copy_from_user((void *) &ol_viewport_set, (void *) arg,
+			       sizeof(overlay_viewport_set));
+
+		if (kyro_dev_overlay_viewport_set(ol_viewport_set.xOrgin,
+						  ol_viewport_set.yOrgin,
+						  ol_viewport_set.xSize,
+						  ol_viewport_set.ySize) !=3D 0)=20
+		{
+			printk(KERN_ERR "Kyro FB: failed to create overlay viewport.\n");
+			return -EINVAL;
+		}
+		break;
+	case KYRO_IOCTL_SET_VIDEO_MODE:
+		{
+			printk(KERN_ERR "Kyro FB: KYRO_IOCTL_SET_VIDEO_MODE is"
+				"obsolete, use the appropriate fb_ioctl()"
+				"command instead.\n");
+			return -EINVAL;
+		}
+		break;
+	case KYRO_IOCTL_UVSTRIDE:
+		copy_to_user((void *)arg, (void *)&deviceInfo.ulOverlayUVStride, sizeof(=
unsigned long));
+		break;
+	case KYRO_IOCTL_STRIDE:
+		copy_to_user((void *)arg, (void *)&deviceInfo.ulOverlayStride, sizeof(un=
signed long));
+		break;
+	case KYRO_IOCTL_OVERLAY_OFFSET:
+		copy_to_user((void *)arg, (void *)&deviceInfo.ulOverlayOffset, sizeof(un=
signed long));
+		break;
+	}
+
+	return 0;
+}
+
+static struct pci_device_id kyrofb_pci_tbl[] __devinitdata =3D {
+	{ PCI_VENDOR_ID_ST, PCI_DEVICE_ID_STG4000,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ 0, }
+};
+
+MODULE_DEVICE_TABLE(pci, kyrofb_pci_tbl);
+
+static struct pci_driver kyrofb_pci_driver =3D {
+	.name		=3D "kyrofb",
+	.id_table	=3D kyrofb_pci_tbl,
+	.probe		=3D kyrofb_probe,
+	.remove		=3D __devexit_p(kyrofb_remove),
+};
+=20
+static struct fb_ops kyrofb_ops =3D {
+	.owner		=3D THIS_MODULE,
+	.fb_check_var	=3D kyrofb_check_var,
+	.fb_set_par	=3D kyrofb_set_par,
+	.fb_setcolreg	=3D kyrofb_setcolreg,
+	.fb_ioctl	=3D kyrofb_ioctl,
+	.fb_fillrect	=3D cfb_fillrect,
+	.fb_copyarea	=3D cfb_copyarea,
+	.fb_imageblit	=3D cfb_imageblit,
+	.fb_cursor	=3D soft_cursor,
+};
+
+static int __devinit kyrofb_probe(struct pci_dev *pdev,
+				  const struct pci_device_id *ent)
+{
+	struct fb_info *info;
+	unsigned long size;
+	int err;
+
+	if ((err =3D pci_enable_device(pdev))) {
+		printk(KERN_WARNING "kyrofb: Can't enable pdev: %d\n", err);
+		return err;
+	}
+
+	size =3D sizeof(struct fb_info) + sizeof(struct kyrofb_info) + 16 * sizeo=
f(u32);
+	info =3D kmalloc(size, GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	memset(info, 0, size);
+
+	currentpar =3D (struct kyrofb_info *)(info + 1);
+
+	kyro_fix.smem_start =3D pci_resource_start(pdev, 0);
+	kyro_fix.smem_len   =3D pci_resource_len(pdev, 0);
+	kyro_fix.mmio_start =3D pci_resource_start(pdev, 1);
+	kyro_fix.mmio_len   =3D pci_resource_len(pdev, 1);
+
+	currentpar->regbase =3D deviceInfo.pSTGReg =3D
+		ioremap_nocache(kyro_fix.mmio_start, kyro_fix.mmio_len);
+
+	info->screen_base =3D ioremap_nocache(kyro_fix.smem_start,
+					    kyro_fix.smem_len);
+
+#ifdef CONFIG_MTRR
+	if (!nomtrr)
+		currentpar->mtrr_handle =3D
+			mtrr_add(kyro_fix.smem_start,
+				 kyro_fix.smem_len,
+				 MTRR_TYPE_WRCOMB, 1);
+#endif
+
+	kyro_fix.ypanstep	=3D nopan ? 0 : 1;
+	kyro_fix.ywrapstep	=3D nowrap ? 0 : 1;
+
+	info->fbops		=3D &kyrofb_ops;
+	info->fix		=3D kyro_fix;
+	info->par		=3D currentpar;
+	info->pseudo_palette	=3D (void *)(currentpar + 1);
+	info->flags		=3D FBINFO_FLAG_DEFAULT;
+
+	SetCoreClockPLL(deviceInfo.pSTGReg, pdev);
+
+	deviceInfo.ulNextFreeVidMem =3D 0;
+	deviceInfo.ulOverlayOffset =3D 0;
+
+	/* This should give a reasonable default video mode */
+#ifndef MODULE
+	if (!fb_find_mode(&info->var, info, mode_option, kyro_modedb,
+			  NUM_TOTAL_MODES, &kyro_modedb[VMODE_1024_768_75], 32))
+#endif
+		info->var =3D kyro_var;
+
+	fb_alloc_cmap(&info->cmap, 256, 0);
+
+	kyrofb_set_par(info);
+	kyrofb_check_var(&info->var, info);
+
+	size =3D get_line_length(info->var.xres_virtual,
+			       info->var.bits_per_pixel);
+	size *=3D info->var.yres_virtual;
+
+	memset_io((unsigned long)info->screen_base, 0, size);
+
+	if (register_framebuffer(info) < 0)
+		goto out_unmap;
+
+	printk("fb%d: %s frame buffer device, at %dx%d@%d using %ldk/%ldk of VRAM=
\n",
+	       info->node, info->fix.id, info->var.xres,
+	       info->var.yres, info->var.bits_per_pixel, size >> 10,
+	       (unsigned long)info->fix.smem_len >> 10);
+
+	pci_set_drvdata(pdev, info);
+
+	return 0;
+
+out_unmap:
+	iounmap(currentpar->regbase);
+	iounmap(info->screen_base);
+	kfree(info);
+
+	return -EINVAL;
+}
+
+static void __devexit kyrofb_remove(struct pci_dev *pdev)
+{
+	struct fb_info *info =3D pci_get_drvdata(pdev);
+	struct kyrofb_info *par =3D (struct kyrofb_info *)info->par;
+
+	/* Reset the board */
+	StopVTG(deviceInfo.pSTGReg);
+	DisableRamdacOutput(deviceInfo.pSTGReg);
+
+	/* Sync up the PLL */
+	SetCoreClockPLL(deviceInfo.pSTGReg, pdev);
+
+	deviceInfo.ulNextFreeVidMem =3D 0;
+	deviceInfo.ulOverlayOffset =3D 0;
+
+	iounmap(info->screen_base);
+	iounmap(par->regbase);
+
+#ifdef CONFIG_MTRR
+	if (par->mtrr_handle)
+		mtrr_del(par->mtrr_handle,
+			 info->fix.smem_start,
+			 info->fix.smem_len);
+#endif
+
+	unregister_framebuffer(info);
+	pci_set_drvdata(pdev, NULL);
+	kfree(info);
+}
+
+int __init kyrofb_init(void)
+{
+	return pci_module_init(&kyrofb_pci_driver);
+}
+
+static void __exit kyrofb_exit(void)
+{
+	pci_unregister_driver(&kyrofb_pci_driver);
+}
+
+#ifdef MODULE
+module_init(kyrofb_init);
+#endif
+module_exit(kyrofb_exit);
+
+MODULE_LICENSE("GPL");
+
--- /dev/null	Fri Aug 30 19:31:37 2002
+++ fb--devel--2.6/include/video/kyro.h	Sun Jan 11 00:11:01 2004
@@ -0,0 +1,101 @@
+/*
+ *  linux/drivers/video/kyro/kryo.h
+ *
+ *  Copyright (C) 2002 STMicroelectronics
+ *  Copyright (C) 2004 Paul Mundt
+ *
+ * This file is subject to the terms and conditions of the GNU General Pub=
lic
+ * License.  See the file COPYING in the main directory of this archive
+ * for more details.
+ */
+
+#ifndef _KYRO_H
+#define _KYRO_H
+
+struct kyrofb_info {
+	void *regbase;
+
+	u32 HTot;	/* Hor Total Time    */
+	u32 HFP;	/* Hor Front Porch   */
+	u32 HST;	/* Hor Sync Time     */
+	u32 HBP;	/* Hor Back Porch    */
+	s32 HSP;		/* Hor Sync Polarity */
+	u32 VTot;	/* Ver Total Time    */
+	u32 VFP;	/* Ver Front Porch   */
+	u32 VST;	/* Ver Sync Time     */
+	u32 VBP;	/* Ver Back Porch    */
+	s32 VSP;		/* Ver Sync Polarity */
+	u32 XRES;	/* X Resolution      */
+	u32 YRES;	/* Y Resolution      */
+	u32 VFREQ;	/* Ver Frequency     */
+	u32 PIXCLK;	/* Pixel Clock       */
+	u32 HCLK;	/* Hor Clock         */
+
+	/* Usefull to hold depth here for Linux */
+	u8 PIXDEPTH;
+
+#ifdef CONFIG_MTRR
+	int mtrr_handle;
+#endif
+};
+
+extern int kyro_dev_init(void);
+extern void kyro_dev_reset(void);
+
+extern unsigned char *kyro_dev_physical_fb_ptr(void);
+extern unsigned char *kyro_dev_virtual_fb_ptr(void);
+extern void *kyro_dev_physical_regs_ptr(void);
+extern void *kyro_dev_virtual_regs_ptr(void);
+extern unsigned int kyro_dev_fb_size(void);
+extern unsigned int kyro_dev_regs_size(void);
+
+extern int kyro_dev_overlay_create(u32 width, u32 height, int bLinear);
+extern u32 kyro_dev_overlay_offset(void);
+extern int kyro_dev_overlay_viewport_set(u32 x, u32 y, u32 width, u32 heig=
ht);
+
+/*************************************************************************=
***/
+
+/*
+ * benedict.gaster@superh.com
+ * Added the follow IOCTLS for the creation of overlay services...
+ */
+
+#define KYRO_IOC_MAGIC 'k'
+
+#define KYRO_IOCTL_OVERLAY_CREATE       _IO(KYRO_IOC_MAGIC, 0)
+#define KYRO_IOCTL_OVERLAY_VIEWPORT_SET _IO(KYRO_IOC_MAGIC, 1)
+#define KYRO_IOCTL_SET_VIDEO_MODE       _IO(KYRO_IOC_MAGIC, 2)
+#define KYRO_IOCTL_UVSTRIDE             _IO(KYRO_IOC_MAGIC, 3)
+#define KYRO_IOCTL_OVERLAY_OFFSET       _IO(KYRO_IOC_MAGIC, 4)
+#define KYRO_IOCTL_STRIDE               _IO(KYRO_IOC_MAGIC, 5)
+
+/*
+ * The follow 3 structures are used to pass data from user space into the =
kernel
+ * for the creation of overlay surfaces and setting the video mode.
+ */
+
+typedef struct _OVERLAY_CREATE {
+	u32 ulWidth;
+	u32 ulHeight;
+	int bLinear;
+} overlay_create;
+
+typedef struct _OVERLAY_VIEWPORT_SET {
+	u32 xOrgin;
+	u32 yOrgin;
+	u32 xSize;
+	u32 ySize;
+} overlay_viewport_set;
+
+typedef struct _SET_VIDEO_MODE {
+	u32 ulWidth;
+	u32 ulHeight;
+	u32 ulScan;
+	u8 displayDepth;
+	int bLinear;
+} set_video_mode;
+
+/*************************************************************************=
***/
+
+
+#endif /* _KYRO_H */

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFABJxS1K+teJFxZ9wRAjq8AJ9Xh/KKCZ75hmf3kvZkXJz1X6y10ACfdpaq
Na4uZsyxCL6z/P/Xb/ArKa4=
=cFwh
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
