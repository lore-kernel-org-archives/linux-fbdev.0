From: <JosephChan@via.com.tw>
Subject: [Patch 3/13 v3] viafb: fix for the malformed
	patch issue
Date: Tue, 12 Aug 2008 08:53:59 +0800
Message-ID: <C80EF34A3D2E494DBAF9AC29C7AE4EB8078F4A01@exchtp03.taipei.via.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1553492607=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KSi9E-00055r-1S for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 11 Aug 2008 17:54:04 -0700
Received: from mailtp.via.com.tw ([61.66.243.2])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KSi9D-0002mt-9A
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 11 Aug 2008 17:54:04 -0700
Content-class: urn:content-classes:message
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
To: JosephChan@via.com.tw, krzysztof.h1@poczta.fm
Cc: geert@linux-m68k.org, akpm@linux-foundation.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--===============1553492607==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8FC15.E8E03D9E"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8FC15.E8E03D9E
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Correct the malformed issue for v2's patch which .
2D and HW cursor stuff of viafb driver.

Signed-off-by: Joseph Chan <josephchan@via.com.tw>

diff -Nurp a/drivers/video/via/accel.c b/drivers/video/via/accel.c
--- a/drivers/video/via/accel.c 1970-01-01 08:00:00.000000000 +0800
+++ b/drivers/video/via/accel.c 2008-07-22 02:07:29.000000000 +0800
@@ -0,0 +1,244 @@
+/*
+ * Copyright 1998-2008 VIA Technologies, Inc. All Rights Reserved.
+ * Copyright 2001-2008 S3 Graphics, Inc. All Rights Reserved.
+
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public
+ * License as published by the Free Software Foundation;
+ * either version 2, or (at your option) any later version.
+
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTIES OR REPRESENTATIONS; without even
+ * the implied warranty of MERCHANTABILITY or FITNESS FOR
+ * A PARTICULAR PURPOSE.See the GNU General Public License
+ * for more details.
+
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc.,
+ * 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+#include "global.h"
+
+void viafb_init_accel(void)
+{
+       viaparinfo->fbmem_free -=3D CURSOR_SIZE;
+       viaparinfo->cursor_start =3D viaparinfo->fbmem_free;
+       viaparinfo->fbmem_used +=3D CURSOR_SIZE;
+
+       /* Reverse 8*1024 memory space for cursor image */
+       viaparinfo->fbmem_free -=3D (CURSOR_SIZE + VQ_SIZE);
+       viaparinfo->VQ_start =3D viaparinfo->fbmem_free;
+       viaparinfo->VQ_end =3D viaparinfo->VQ_start + VQ_SIZE - 1;
+       viaparinfo->fbmem_used +=3D (CURSOR_SIZE + VQ_SIZE);
+}
+
+void viafb_init_2d_engine(void)
+{
+       u32 dwVQStartAddr, dwVQEndAddr;
+       u32 dwVQLen, dwVQStartL, dwVQEndL, dwVQStartEndH;
+
+       /* init 2D engine regs to reset 2D engine */
+       MMIO_OUT32(VIA_REG_GEMODE, 0x0);
+       MMIO_OUT32(VIA_REG_SRCPOS, 0x0);
+       MMIO_OUT32(VIA_REG_DSTPOS, 0x0);
+       MMIO_OUT32(VIA_REG_DIMENSION, 0x0);
+       MMIO_OUT32(VIA_REG_PATADDR, 0x0);
+       MMIO_OUT32(VIA_REG_FGCOLOR, 0x0);
+       MMIO_OUT32(VIA_REG_BGCOLOR, 0x0);
+       MMIO_OUT32(VIA_REG_CLIPTL, 0x0);
+       MMIO_OUT32(VIA_REG_CLIPBR, 0x0);
+       MMIO_OUT32(VIA_REG_OFFSET, 0x0);
+       MMIO_OUT32(VIA_REG_KEYCONTROL, 0x0);
+       MMIO_OUT32(VIA_REG_SRCBASE, 0x0);
+       MMIO_OUT32(VIA_REG_DSTBASE, 0x0);
+       MMIO_OUT32(VIA_REG_PITCH, 0x0);
+       MMIO_OUT32(VIA_REG_MONOPAT1, 0x0);
+
+       /* Init AGP and VQ regs */
+       switch (viaparinfo->chip_info->gfx_chip_name) {
+       case UNICHROME_K8M890:
+       case UNICHROME_P4M900:
+               MMIO_OUT32(VIA_REG_CR_TRANSET, 0x00100000);
+               MMIO_OUT32(VIA_REG_CR_TRANSPACE, 0x680A0000);
+               MMIO_OUT32(VIA_REG_CR_TRANSPACE, 0x02000000);
+               break;
+
+       default:
+               MMIO_OUT32(VIA_REG_TRANSET, 0x00100000);
+               MMIO_OUT32(VIA_REG_TRANSPACE, 0x00000000);
+               MMIO_OUT32(VIA_REG_TRANSPACE, 0x00333004);
+               MMIO_OUT32(VIA_REG_TRANSPACE, 0x60000000);
+               MMIO_OUT32(VIA_REG_TRANSPACE, 0x61000000);
+               MMIO_OUT32(VIA_REG_TRANSPACE, 0x62000000);
+               MMIO_OUT32(VIA_REG_TRANSPACE, 0x63000000);
+               MMIO_OUT32(VIA_REG_TRANSPACE, 0x64000000);
+               MMIO_OUT32(VIA_REG_TRANSPACE, 0x7D000000);
+
+               MMIO_OUT32(VIA_REG_TRANSET, 0xFE020000);
+               MMIO_OUT32(VIA_REG_TRANSPACE, 0x00000000);
+               break;
+       }
+       if (viaparinfo->VQ_start !=3D 0) {
+               /* Enable VQ */
+               dwVQStartAddr =3D viaparinfo->VQ_start;
+               dwVQEndAddr =3D viaparinfo->VQ_end;
+
+               dwVQStartL =3D 0x50000000 | (dwVQStartAddr & 0xFFFFFF);
+               dwVQEndL =3D 0x51000000 | (dwVQEndAddr & 0xFFFFFF);
+               dwVQStartEndH =3D 0x52000000 |
+                       ((dwVQStartAddr & 0xFF000000) >> 24) |
+                       ((dwVQEndAddr & 0xFF000000) >> 16);
+               dwVQLen =3D 0x53000000 | (VQ_SIZE >> 3);
+               switch (viaparinfo->chip_info->gfx_chip_name) {
+               case UNICHROME_K8M890:
+               case UNICHROME_P4M900:
+                       dwVQStartL |=3D 0x20000000;
+                       dwVQEndL |=3D 0x20000000;
+                       dwVQStartEndH |=3D 0x20000000;
+                       dwVQLen |=3D 0x20000000;
+                       break;
+               default:
+                       break;
+               }
+
+               switch (viaparinfo->chip_info->gfx_chip_name) {
+               case UNICHROME_K8M890:
+               case UNICHROME_P4M900:
+                       MMIO_OUT32(VIA_REG_CR_TRANSET, 0x00100000);
+                       MMIO_OUT32(VIA_REG_CR_TRANSPACE, dwVQStartEndH);
+                       MMIO_OUT32(VIA_REG_CR_TRANSPACE, dwVQStartL);
+                       MMIO_OUT32(VIA_REG_CR_TRANSPACE, dwVQEndL);
+                       MMIO_OUT32(VIA_REG_CR_TRANSPACE, dwVQLen);
+                       MMIO_OUT32(VIA_REG_CR_TRANSPACE, 0x74301001);
+                       MMIO_OUT32(VIA_REG_CR_TRANSPACE, 0x00000000);
+                       break;
+               default:
+                       MMIO_OUT32(VIA_REG_TRANSET, 0x00FE0000);
+                       MMIO_OUT32(VIA_REG_TRANSPACE, 0x080003FE);
+                       MMIO_OUT32(VIA_REG_TRANSPACE, 0x0A00027C);
+                       MMIO_OUT32(VIA_REG_TRANSPACE, 0x0B000260);
+                       MMIO_OUT32(VIA_REG_TRANSPACE, 0x0C000274);
+                       MMIO_OUT32(VIA_REG_TRANSPACE, 0x0D000264);
+                       MMIO_OUT32(VIA_REG_TRANSPACE, 0x0E000000);
+                       MMIO_OUT32(VIA_REG_TRANSPACE, 0x0F000020);
+                       MMIO_OUT32(VIA_REG_TRANSPACE, 0x1000027E);
+                       MMIO_OUT32(VIA_REG_TRANSPACE, 0x110002FE);
+                       MMIO_OUT32(VIA_REG_TRANSPACE, 0x200F0060);
+
+                       MMIO_OUT32(VIA_REG_TRANSPACE, 0x00000006);
+                       MMIO_OUT32(VIA_REG_TRANSPACE, 0x40008C0F);
+                       MMIO_OUT32(VIA_REG_TRANSPACE, 0x44000000);
+                       MMIO_OUT32(VIA_REG_TRANSPACE, 0x45080C04);
+                       MMIO_OUT32(VIA_REG_TRANSPACE, 0x46800408);
+
+                       MMIO_OUT32(VIA_REG_TRANSPACE, dwVQStartEndH);
+                       MMIO_OUT32(VIA_REG_TRANSPACE, dwVQStartL);
+                       MMIO_OUT32(VIA_REG_TRANSPACE, dwVQEndL);
+                       MMIO_OUT32(VIA_REG_TRANSPACE, dwVQLen);
+                       break;
+               }
+       } else {
+               /* Disable VQ */
+               switch (viaparinfo->chip_info->gfx_chip_name) {
+               case UNICHROME_K8M890:
+               case UNICHROME_P4M900:
+                       MMIO_OUT32(VIA_REG_CR_TRANSET, 0x00100000);
+                       MMIO_OUT32(VIA_REG_CR_TRANSPACE, 0x74301000);
+                       break;
+               default:
+                       MMIO_OUT32(VIA_REG_TRANSET, 0x00FE0000);
+                       MMIO_OUT32(VIA_REG_TRANSPACE, 0x00000004);
+                       MMIO_OUT32(VIA_REG_TRANSPACE, 0x40008C0F);
+                       MMIO_OUT32(VIA_REG_TRANSPACE, 0x44000000);
+                       MMIO_OUT32(VIA_REG_TRANSPACE, 0x45080C04);
+                       MMIO_OUT32(VIA_REG_TRANSPACE, 0x46800408);
+                       break;
+               }
+       }
+
+       viafb_set_2d_color_depth(viaparinfo->bpp);
+
+       MMIO_OUT32(VIA_REG_SRCBASE, 0x0);
+       MMIO_OUT32(VIA_REG_DSTBASE, 0x0);
+
+       MMIO_OUT32(VIA_REG_PITCH,
+                  VIA_PITCH_ENABLE |
+                  (((viaparinfo->hres *
+                     viaparinfo->bpp >> 3) >> 3) | (((viaparinfo->hres =
*
+                                                  viaparinfo->
+                                                  bpp >> 3) >> 3) << =
16)));
+}
+
+void viafb_set_2d_color_depth(int bpp)
+{
+       u32 dwGEMode;
+
+       dwGEMode =3D MMIO_IN32(0x04) & 0xFFFFFCFF;
+
+       switch (bpp) {
+       case 16:
+               dwGEMode |=3D VIA_GEM_16bpp;
+               break;
+       case 32:
+               dwGEMode |=3D VIA_GEM_32bpp;
+               break;
+       default:
+               dwGEMode |=3D VIA_GEM_8bpp;
+               break;
+       }
+
+       /* Set BPP and Pitch */
+       MMIO_OUT32(VIA_REG_GEMODE, dwGEMode);
+}
+
+void viafb_hw_cursor_init(void)
+{
+       /* Set Cursor Image Base Address */
+       MMIO_OUT32(VIA_REG_CURSOR_MODE, viaparinfo->cursor_start);
+       MMIO_OUT32(VIA_REG_CURSOR_POS, 0x0);
+       MMIO_OUT32(VIA_REG_CURSOR_ORG, 0x0);
+       MMIO_OUT32(VIA_REG_CURSOR_BG, 0x0);
+       MMIO_OUT32(VIA_REG_CURSOR_FG, 0x0);
+}
+
+void viafb_show_hw_cursor(struct fb_info *info, int Status)
+{
+       u32 temp;
+       u32 iga_path =3D ((struct viafb_par *)(info->par))->iga_path;
+
+       temp =3D MMIO_IN32(VIA_REG_CURSOR_MODE);
+       switch (Status) {
+       case HW_Cursor_ON:
+               temp |=3D 0x1;
+               break;
+       case HW_Cursor_OFF:
+               temp &=3D 0xFFFFFFFE;
+               break;
+       }
+       switch (iga_path) {
+       case IGA2:
+               temp |=3D 0x80000000;
+               break;
+       case IGA1:
+       default:
+               temp &=3D 0x7FFFFFFF;
+       }
+       MMIO_OUT32(VIA_REG_CURSOR_MODE, temp);
+}
+
+int viafb_wait_engine_idle(void)
+{
+       int loop =3D 0;
+
+       while (!(MMIO_IN32(VIA_REG_STATUS) & VIA_VR_QUEUE_BUSY)
+              && (loop++ < MAXLOOP))
+              cpu_relax();
+
+       while ((MMIO_IN32(VIA_REG_STATUS) &
+               (VIA_CMD_RGTR_BUSY | VIA_2D_ENG_BUSY | VIA_3D_ENG_BUSY)) =
&&
+              (loop++ < MAXLOOP))
+              cpu_relax();
+
+       return loop >=3D MAXLOOP;
+}
diff -Nurp a/drivers/video/via/accel.h b/drivers/video/via/accel.h
--- a/drivers/video/via/accel.h 1970-01-01 08:00:00.000000000 +0800
+++ b/drivers/video/via/accel.h 2008-07-22 02:07:29.000000000 +0800
@@ -0,0 +1,181 @@
+/*
+ * Copyright 1998-2008 VIA Technologies, Inc. All Rights Reserved.
+ * Copyright 2001-2008 S3 Graphics, Inc. All Rights Reserved.
+
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public
+ * License as published by the Free Software Foundation;
+ * either version 2, or (at your option) any later version.
+
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTIES OR REPRESENTATIONS; without even
+ * the implied warranty of MERCHANTABILITY or FITNESS FOR
+ * A PARTICULAR PURPOSE.See the GNU General Public License
+ * for more details.
+
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc.,
+ * 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#ifndef __ACCEL_H__
+#define __ACCEL_H__
+
+#define FB_ACCEL_VIA_UNICHROME  50
+
+/* MMIO Base Address Definition */
+#define MMIO_VGABASE                0x8000
+#define MMIO_CR_READ                (MMIO_VGABASE + 0x3D4)
+#define MMIO_CR_WRITE               (MMIO_VGABASE + 0x3D5)
+#define MMIO_SR_READ                (MMIO_VGABASE + 0x3C4)
+#define MMIO_SR_WRITE               (MMIO_VGABASE + 0x3C5)
+
+#define VIA_MMIO 1
+
+#if VIA_MMIO
+#define MMIO_OUT32(reg, val) writel(val, viaparinfo->io_virt + reg)
+#define MMIO_IN32(reg)      readl(viaparinfo->io_virt + reg)
+
+#else
+#define MMIO_OUT32(reg, val) outl(val, reg)
+#define MMIO_IN32(reg)      inl(reg)
+#endif
+
+/* HW Cursor Status Define */
+#define HW_Cursor_ON    0
+#define HW_Cursor_OFF   1
+
+#define CURSOR_SIZE     (8 * 1024)
+#define VQ_SIZE         (256 * 1024)
+
+#define VIA_MMIO_BLTBASE        0x200000
+#define VIA_MMIO_BLTSIZE        0x200000
+
+/* Defines for 2D registers */
+#define VIA_REG_GECMD           0x000
+#define VIA_REG_GEMODE          0x004
+#define VIA_REG_SRCPOS          0x008
+#define VIA_REG_DSTPOS          0x00C
+/* width and height */
+#define VIA_REG_DIMENSION       0x010
+#define VIA_REG_PATADDR         0x014
+#define VIA_REG_FGCOLOR         0x018
+#define VIA_REG_BGCOLOR         0x01C
+/* top and left of clipping */
+#define VIA_REG_CLIPTL          0x020
+/* bottom and right of clipping */
+#define VIA_REG_CLIPBR          0x024
+#define VIA_REG_OFFSET          0x028
+/* color key control */
+#define VIA_REG_KEYCONTROL      0x02C
+#define VIA_REG_SRCBASE         0x030
+#define VIA_REG_DSTBASE         0x034
+/* pitch of src and dst */
+#define VIA_REG_PITCH           0x038
+#define VIA_REG_MONOPAT0        0x03C
+#define VIA_REG_MONOPAT1        0x040
+/* from 0x100 to 0x1ff */
+#define VIA_REG_COLORPAT        0x100
+
+/* VIA_REG_PITCH(0x38): Pitch Setting */
+#define VIA_PITCH_ENABLE        0x80000000
+
+/* defines for VIA HW cursor registers */
+#define VIA_REG_CURSOR_MODE     0x2D0
+#define VIA_REG_CURSOR_POS      0x2D4
+#define VIA_REG_CURSOR_ORG      0x2D8
+#define VIA_REG_CURSOR_BG       0x2DC
+#define VIA_REG_CURSOR_FG       0x2E0
+
+/* VIA_REG_GEMODE(0x04): GE mode */
+#define VIA_GEM_8bpp            0x00000000
+#define VIA_GEM_16bpp           0x00000100
+#define VIA_GEM_32bpp           0x00000300
+
+/* VIA_REG_GECMD(0x00): 2D Engine Command  */
+#define VIA_GEC_NOOP            0x00000000
+#define VIA_GEC_BLT             0x00000001
+#define VIA_GEC_LINE            0x00000005
+
+/* Rotate Command */
+#define VIA_GEC_ROT             0x00000008
+
+#define VIA_GEC_SRC_XY          0x00000000
+#define VIA_GEC_SRC_LINEAR      0x00000010
+#define VIA_GEC_DST_XY          0x00000000
+#define VIA_GEC_DST_LINRAT      0x00000020
+
+#define VIA_GEC_SRC_FB          0x00000000
+#define VIA_GEC_SRC_SYS         0x00000040
+#define VIA_GEC_DST_FB          0x00000000
+#define VIA_GEC_DST_SYS         0x00000080
+
+/* source is mono */
+#define VIA_GEC_SRC_MONO        0x00000100
+/* pattern is mono */
+#define VIA_GEC_PAT_MONO        0x00000200
+/* mono src is opaque */
+#define VIA_GEC_MSRC_OPAQUE     0x00000000
+/* mono src is transparent */
+#define VIA_GEC_MSRC_TRANS      0x00000400
+/* pattern is in frame buffer */
+#define VIA_GEC_PAT_FB          0x00000000
+/* pattern is from reg setting */
+#define VIA_GEC_PAT_REG         0x00000800
+
+#define VIA_GEC_CLIP_DISABLE    0x00000000
+#define VIA_GEC_CLIP_ENABLE     0x00001000
+
+#define VIA_GEC_FIXCOLOR_PAT    0x00002000
+
+#define VIA_GEC_INCX            0x00000000
+#define VIA_GEC_DECY            0x00004000
+#define VIA_GEC_INCY            0x00000000
+#define VIA_GEC_DECX            0x00008000
+/* mono pattern is opaque */
+#define VIA_GEC_MPAT_OPAQUE     0x00000000
+/* mono pattern is transparent */
+#define VIA_GEC_MPAT_TRANS      0x00010000
+
+#define VIA_GEC_MONO_UNPACK     0x00000000
+#define VIA_GEC_MONO_PACK       0x00020000
+#define VIA_GEC_MONO_DWORD      0x00000000
+#define VIA_GEC_MONO_WORD       0x00040000
+#define VIA_GEC_MONO_BYTE       0x00080000
+
+#define VIA_GEC_LASTPIXEL_ON    0x00000000
+#define VIA_GEC_LASTPIXEL_OFF   0x00100000
+#define VIA_GEC_X_MAJOR         0x00000000
+#define VIA_GEC_Y_MAJOR         0x00200000
+#define VIA_GEC_QUICK_START     0x00800000
+
+/* defines for VIA 3D registers */
+#define VIA_REG_STATUS          0x400
+#define VIA_REG_CR_TRANSET      0x41C
+#define VIA_REG_CR_TRANSPACE   0x420
+#define VIA_REG_TRANSET         0x43C
+#define VIA_REG_TRANSPACE       0x440
+
+/* VIA_REG_STATUS(0x400): Engine Status */
+
+/* Command Regulator is busy */
+#define VIA_CMD_RGTR_BUSY       0x00000080
+/* 2D Engine is busy */
+#define VIA_2D_ENG_BUSY         0x00000002
+/* 3D Engine is busy */
+#define VIA_3D_ENG_BUSY         0x00000001
+/* Virtual Queue is busy */
+#define VIA_VR_QUEUE_BUSY       0x00020000
+
+#define MAXLOOP                 0xFFFFFF
+
+void viafb_init_accel(void);
+void viafb_init_2d_engine(void);
+void set_2d_color_depth(int);
+void viafb_hw_cursor_init(void);
+void viafb_show_hw_cursor(struct fb_info *info, int Status);
+int viafb_wait_engine_idle(void);
+void viafb_set_2d_color_depth(int bpp);
+
+#endif /* __ACCEL_H__ */=20


------_=_NextPart_001_01C8FC15.E8E03D9E
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<HTML><HEAD><TITLE>[Patch 3/13 v3] viafb: accel.c, accel.h</TITLE>=0A=
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dunicode">=0A=
<META content=3D"MSHTML 6.00.2900.5512" name=3DGENERATOR></HEAD>=0A=
<BODY>=0A=
<P><FONT size=3D2>Correct the malformed issue for v2's patch which =
.<BR>2D and HW cursor stuff of viafb driver.<BR><BR>Signed-off-by: =
Joseph Chan &lt;josephchan@via.com.tw&gt;<BR><BR>diff -Nurp =
a/drivers/video/via/accel.c b/drivers/video/via/accel.c<BR>--- =
a/drivers/video/via/accel.c 1970-01-01 08:00:00.000000000 +0800<BR>+++ =
b/drivers/video/via/accel.c 2008-07-22 02:07:29.000000000 +0800<BR>@@ =
-0,0 +1,244 @@<BR>+/*<BR>+ * Copyright 1998-2008 VIA Technologies, Inc. =
All Rights Reserved.<BR>+ * Copyright 2001-2008 S3 Graphics, Inc. All =
Rights Reserved.<BR>+<BR>+ * This program is free software; you can =
redistribute it and/or<BR>+ * modify it under the terms of the GNU =
General Public<BR>+ * License as published by the Free Software =
Foundation;<BR>+ * either version 2, or (at your option) any later =
version.<BR>+<BR>+ * This program is distributed in the hope that it =
will be useful,<BR>+ * but WITHOUT ANY WARRANTIES OR REPRESENTATIONS; =
without even<BR>+ * the implied warranty of MERCHANTABILITY or FITNESS =
FOR<BR>+ * A PARTICULAR PURPOSE.See the GNU General Public License<BR>+ =
* for more details.<BR>+<BR>+ * You should have received a copy of the =
GNU General Public License<BR>+ * along with this program; if not, write =
to the Free Software<BR>+ * Foundation, Inc.,<BR>+ * 59 Temple Place - =
Suite 330, Boston, MA 02111-1307, USA.<BR>+ */<BR>+#include =
"global.h"<BR>+<BR>+void =
viafb_init_accel(void)<BR>+{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
viaparinfo-&gt;fbmem_free -=3D =
CURSOR_SIZE;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
viaparinfo-&gt;cursor_start =3D =
viaparinfo-&gt;fbmem_free;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
viaparinfo-&gt;fbmem_used +=3D =
CURSOR_SIZE;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Reverse =
8*1024 memory space for cursor image =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; viaparinfo-&gt;fbmem_free =
-=3D (CURSOR_SIZE + VQ_SIZE);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
viaparinfo-&gt;VQ_start =3D =
viaparinfo-&gt;fbmem_free;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
viaparinfo-&gt;VQ_end =3D viaparinfo-&gt;VQ_start + VQ_SIZE - =
1;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; viaparinfo-&gt;fbmem_used =
+=3D (CURSOR_SIZE + VQ_SIZE);<BR>+}<BR>+<BR>+void =
viafb_init_2d_engine(void)<BR>+{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 u32 dwVQStartAddr, =
dwVQEndAddr;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 dwVQLen, =
dwVQStartL, dwVQEndL, =
dwVQStartEndH;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* init 2D =
engine regs to reset 2D engine =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMIO_OUT32(VIA_REG_GEMODE, =
0x0);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MMIO_OUT32(VIA_REG_SRCPOS, =
0x0);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MMIO_OUT32(VIA_REG_DSTPOS, =
0x0);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MMIO_OUT32(VIA_REG_DIMENSION, =
0x0);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MMIO_OUT32(VIA_REG_PATADDR, =
0x0);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MMIO_OUT32(VIA_REG_FGCOLOR, =
0x0);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MMIO_OUT32(VIA_REG_BGCOLOR, =
0x0);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MMIO_OUT32(VIA_REG_CLIPTL, =
0x0);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MMIO_OUT32(VIA_REG_CLIPBR, =
0x0);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MMIO_OUT32(VIA_REG_OFFSET, =
0x0);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MMIO_OUT32(VIA_REG_KEYCONTROL, =
0x0);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MMIO_OUT32(VIA_REG_SRCBASE, =
0x0);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MMIO_OUT32(VIA_REG_DSTBASE, =
0x0);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMIO_OUT32(VIA_REG_PITCH, =
0x0);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MMIO_OUT32(VIA_REG_MONOPAT1, =
0x0);<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Init AGP and VQ =
regs */<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch =
(viaparinfo-&gt;chip_info-&gt;gfx_chip_name) =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
UNICHROME_K8M890:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
UNICHROME_P4M900:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MMIO_OUT32(VIA_REG_CR_TRANSET, =
0x00100000);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MMIO_OUT32(VIA_REG_CR_TRANSPACE, =
0x680A0000);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MMIO_OUT32(VIA_REG_CR_TRANSPACE, =
0x02000000);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
default:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMIO_OUT32(VIA_REG_TRANSET, =
0x00100000);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMIO_OUT32(VIA_REG_TRANSPACE, =
0x00000000);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMIO_OUT32(VIA_REG_TRANSPACE, =
0x00333004);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMIO_OUT32(VIA_REG_TRANSPACE, =
0x60000000);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMIO_OUT32(VIA_REG_TRANSPACE, =
0x61000000);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMIO_OUT32(VIA_REG_TRANSPACE, =
0x62000000);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMIO_OUT32(VIA_REG_TRANSPACE, =
0x63000000);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMIO_OUT32(VIA_REG_TRANSPACE, =
0x64000000);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMIO_OUT32(VIA_REG_TRANSPACE, =
0x7D000000);<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMIO_OUT32(VIA_REG_TRANSET, =
0xFE020000);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMIO_OUT32(VIA_REG_TRANSPACE, =
0x00000000);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (viaparinfo-&gt;VQ_start =
!=3D 0) {<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Enable VQ =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dwVQStartAddr =3D =
viaparinfo-&gt;VQ_start;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dwVQEndAddr =3D =
viaparinfo-&gt;VQ_end;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dwVQStartL =3D 0x50000000 | =
(dwVQStartAddr &amp; 0xFFFFFF);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dwVQEndL =3D 0x51000000 | =
(dwVQEndAddr &amp; 0xFFFFFF);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dwVQStartEndH =3D 0x52000000 =
|<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((dwVQStartAddr &amp; =
0xFF000000) &gt;&gt; 24) |<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((dwVQEndAddr &amp; =
0xFF000000) &gt;&gt; 16);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dwVQLen =3D 0x53000000 | =
(VQ_SIZE &gt;&gt; 3);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch =
(viaparinfo-&gt;chip_info-&gt;gfx_chip_name) =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
UNICHROME_K8M890:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
UNICHROME_P4M900:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dwVQStartL |=3D =
0x20000000;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dwVQEndL |=3D =
0x20000000;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dwVQStartEndH |=3D =
0x20000000;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dwVQLen |=3D =
0x20000000;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
default:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch =
(viaparinfo-&gt;chip_info-&gt;gfx_chip_name) =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
UNICHROME_K8M890:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
UNICHROME_P4M900:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MMIO_OUT32(VIA_REG_CR_TRANSET, =
0x00100000);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MMIO_OUT32(VIA_REG_CR_TRANSPACE, =
dwVQStartEndH);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MMIO_OUT32(VIA_REG_CR_TRANSPACE, =
dwVQStartL);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MMIO_OUT32(VIA_REG_CR_TRANSPACE, =
dwVQEndL);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MMIO_OUT32(VIA_REG_CR_TRANSPACE, =
dwVQLen);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MMIO_OUT32(VIA_REG_CR_TRANSPACE, =
0x74301001);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MMIO_OUT32(VIA_REG_CR_TRANSPACE, =
0x00000000);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
default:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMIO_OUT32(VIA_REG_TRANSET, =
0x00FE0000);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMIO_OUT32(VIA_REG_TRANSPACE, =
0x080003FE);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMIO_OUT32(VIA_REG_TRANSPACE, =
0x0A00027C);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMIO_OUT32(VIA_REG_TRANSPACE, =
0x0B000260);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMIO_OUT32(VIA_REG_TRANSPACE, =
0x0C000274);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMIO_OUT32(VIA_REG_TRANSPACE, =
0x0D000264);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMIO_OUT32(VIA_REG_TRANSPACE, =
0x0E000000);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMIO_OUT32(VIA_REG_TRANSPACE, =
0x0F000020);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMIO_OUT32(VIA_REG_TRANSPACE, =
0x1000027E);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMIO_OUT32(VIA_REG_TRANSPACE, =
0x110002FE);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMIO_OUT32(VIA_REG_TRANSPACE, =
0x200F0060);<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMIO_OUT32(VIA_REG_TRANSPACE, =
0x00000006);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMIO_OUT32(VIA_REG_TRANSPACE, =
0x40008C0F);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMIO_OUT32(VIA_REG_TRANSPACE, =
0x44000000);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMIO_OUT32(VIA_REG_TRANSPACE, =
0x45080C04);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMIO_OUT32(VIA_REG_TRANSPACE, =
0x46800408);<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMIO_OUT32(VIA_REG_TRANSPACE, =
dwVQStartEndH);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMIO_OUT32(VIA_REG_TRANSPACE, =
dwVQStartL);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMIO_OUT32(VIA_REG_TRANSPACE, =
dwVQEndL);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMIO_OUT32(VIA_REG_TRANSPACE, =
dwVQLen);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Disable VQ =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch =
(viaparinfo-&gt;chip_info-&gt;gfx_chip_name) =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
UNICHROME_K8M890:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
UNICHROME_P4M900:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MMIO_OUT32(VIA_REG_CR_TRANSET, =
0x00100000);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MMIO_OUT32(VIA_REG_CR_TRANSPACE, =
0x74301000);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
default:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMIO_OUT32(VIA_REG_TRANSET, =
0x00FE0000);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMIO_OUT32(VIA_REG_TRANSPACE, =
0x00000004);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMIO_OUT32(VIA_REG_TRANSPACE, =
0x40008C0F);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMIO_OUT32(VIA_REG_TRANSPACE, =
0x44000000);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMIO_OUT32(VIA_REG_TRANSPACE, =
0x45080C04);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMIO_OUT32(VIA_REG_TRANSPACE, =
0x46800408);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
viafb_set_2d_color_depth(viaparinfo-&gt;bpp);<BR>+<BR>+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; MMIO_OUT32(VIA_REG_SRCBASE, =
0x0);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MMIO_OUT32(VIA_REG_DSTBASE, =
0x0);<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MMIO_OUT32(VIA_REG_PITCH,<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; VIA_PITCH_ENABLE =
|<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; =
(((viaparinfo-&gt;hres *<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; viaparinfo-&gt;bpp &gt;&gt; 3) &gt;&gt; =
3) | (((viaparinfo-&gt;hres *<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; =
viaparinfo-&gt;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; bpp &gt;&gt; 3) =
&gt;&gt; 3) &lt;&lt; 16)));<BR>+}<BR>+<BR>+void =
viafb_set_2d_color_depth(int =
bpp)<BR>+{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 =
dwGEMode;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dwGEMode =3D =
MMIO_IN32(0x04) &amp; =
0xFFFFFCFF;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (bpp) =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
16:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dwGEMode |=3D =
VIA_GEM_16bpp;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
32:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dwGEMode |=3D =
VIA_GEM_32bpp;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
default:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dwGEMode |=3D =
VIA_GEM_8bpp;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set BPP and Pitch =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMIO_OUT32(VIA_REG_GEMODE, =
dwGEMode);<BR>+}<BR>+<BR>+void =
viafb_hw_cursor_init(void)<BR>+{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 /* Set Cursor Image Base Address =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MMIO_OUT32(VIA_REG_CURSOR_MODE, =
viaparinfo-&gt;cursor_start);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MMIO_OUT32(VIA_REG_CURSOR_POS, =
0x0);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MMIO_OUT32(VIA_REG_CURSOR_ORG, =
0x0);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MMIO_OUT32(VIA_REG_CURSOR_BG, =
0x0);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MMIO_OUT32(VIA_REG_CURSOR_FG, 0x0);<BR>+}<BR>+<BR>+void =
viafb_show_hw_cursor(struct fb_info *info, int =
Status)<BR>+{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 =
temp;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 iga_path =3D ((struct =
viafb_par =
*)(info-&gt;par))-&gt;iga_path;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; temp =3D =
MMIO_IN32(VIA_REG_CURSOR_MODE);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
switch (Status) {<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
HW_Cursor_ON:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp |=3D =
0x1;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
HW_Cursor_OFF:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp &amp;=3D =
0xFFFFFFFE;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (iga_path) =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
IGA2:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp |=3D =
0x80000000;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
IGA1:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
default:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp &amp;=3D =
0x7FFFFFFF;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MMIO_OUT32(VIA_REG_CURSOR_MODE, temp);<BR>+}<BR>+<BR>+int =
viafb_wait_engine_idle(void)<BR>+{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; int loop =3D 0;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while =
(!(MMIO_IN32(VIA_REG_STATUS) &amp; =
VIA_VR_QUEUE_BUSY)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;&amp; (loop++ &lt; =
MAXLOOP))<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
cpu_relax();<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while =
((MMIO_IN32(VIA_REG_STATUS) =
&amp;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (VIA_CMD_RGTR_BUSY | =
VIA_2D_ENG_BUSY | VIA_3D_ENG_BUSY)) =
&amp;&amp;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (loop++ &lt; =
MAXLOOP))<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
cpu_relax();<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return loop =
&gt;=3D MAXLOOP;<BR>+}<BR>diff -Nurp a/drivers/video/via/accel.h =
b/drivers/video/via/accel.h<BR>--- a/drivers/video/via/accel.h =
1970-01-01 08:00:00.000000000 +0800<BR>+++ b/drivers/video/via/accel.h =
2008-07-22 02:07:29.000000000 +0800<BR>@@ -0,0 +1,181 @@<BR>+/*<BR>+ * =
Copyright 1998-2008 VIA Technologies, Inc. All Rights Reserved.<BR>+ * =
Copyright 2001-2008 S3 Graphics, Inc. All Rights Reserved.<BR>+<BR>+ * =
This program is free software; you can redistribute it and/or<BR>+ * =
modify it under the terms of the GNU General Public<BR>+ * License as =
published by the Free Software Foundation;<BR>+ * either version 2, or =
(at your option) any later version.<BR>+<BR>+ * This program is =
distributed in the hope that it will be useful,<BR>+ * but WITHOUT ANY =
WARRANTIES OR REPRESENTATIONS; without even<BR>+ * the implied warranty =
of MERCHANTABILITY or FITNESS FOR<BR>+ * A PARTICULAR PURPOSE.See the =
GNU General Public License<BR>+ * for more details.<BR>+<BR>+ * You =
should have received a copy of the GNU General Public License<BR>+ * =
along with this program; if not, write to the Free Software<BR>+ * =
Foundation, Inc.,<BR>+ * 59 Temple Place - Suite 330, Boston, MA =
02111-1307, USA.<BR>+ */<BR>+<BR>+#ifndef __ACCEL_H__<BR>+#define =
__ACCEL_H__<BR>+<BR>+#define FB_ACCEL_VIA_UNICHROME&nbsp; 50<BR>+<BR>+/* =
MMIO Base Address Definition */<BR>+#define =
MMIO_VGABASE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8000<BR>+#define =
MMIO_CR_READ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (MMIO_VGABASE + 0x3D4)<BR>+#define =
MMIO_CR_WRITE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; (MMIO_VGABASE + 0x3D5)<BR>+#define =
MMIO_SR_READ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (MMIO_VGABASE + 0x3C4)<BR>+#define =
MMIO_SR_WRITE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; (MMIO_VGABASE + 0x3C5)<BR>+<BR>+#define =
VIA_MMIO 1<BR>+<BR>+#if VIA_MMIO<BR>+#define MMIO_OUT32(reg, val) =
writel(val, viaparinfo-&gt;io_virt + reg)<BR>+#define =
MMIO_IN32(reg)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
readl(viaparinfo-&gt;io_virt + reg)<BR>+<BR>+#else<BR>+#define =
MMIO_OUT32(reg, val) outl(val, reg)<BR>+#define =
MMIO_IN32(reg)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
inl(reg)<BR>+#endif<BR>+<BR>+/* HW Cursor Status Define */<BR>+#define =
HW_Cursor_ON&nbsp;&nbsp;&nbsp; 0<BR>+#define HW_Cursor_OFF&nbsp;&nbsp; =
1<BR>+<BR>+#define CURSOR_SIZE&nbsp;&nbsp;&nbsp;&nbsp; (8 * =
1024)<BR>+#define =
VQ_SIZE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (256 * =
1024)<BR>+<BR>+#define =
VIA_MMIO_BLTBASE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x200000<BR>+#define =
VIA_MMIO_BLTSIZE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x200000<BR>+<BR>+/* Defines for 2D registers */<BR>+#define =
VIA_REG_GECMD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 0x000<BR>+#define =
VIA_REG_GEMODE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x004<BR>+#define =
VIA_REG_SRCPOS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x008<BR>+#define =
VIA_REG_DSTPOS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00C<BR>+/* width and height */<BR>+#define =
VIA_REG_DIMENSION&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x010<BR>+#define =
VIA_REG_PATADDR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x014<BR>+#define =
VIA_REG_FGCOLOR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x018<BR>+#define =
VIA_REG_BGCOLOR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x01C<BR>+/* top and left of clipping */<BR>+#define =
VIA_REG_CLIPTL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x020<BR>+/* bottom and right of clipping */<BR>+#define =
VIA_REG_CLIPBR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x024<BR>+#define =
VIA_REG_OFFSET&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x028<BR>+/* color key control */<BR>+#define =
VIA_REG_KEYCONTROL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x02C<BR>+#define =
VIA_REG_SRCBASE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x030<BR>+#define =
VIA_REG_DSTBASE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x034<BR>+/* pitch of src and dst */<BR>+#define =
VIA_REG_PITCH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 0x038<BR>+#define =
VIA_REG_MONOPAT0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x03C<BR>+#define =
VIA_REG_MONOPAT1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x040<BR>+/* =
from 0x100 to 0x1ff */<BR>+#define =
VIA_REG_COLORPAT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x100<BR>+<BR>+/* VIA_REG_PITCH(0x38): Pitch Setting */<BR>+#define =
VIA_PITCH_ENABLE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x80000000<BR>+<BR>+/* defines for VIA HW cursor registers =
*/<BR>+#define VIA_REG_CURSOR_MODE&nbsp;&nbsp;&nbsp;&nbsp; =
0x2D0<BR>+#define VIA_REG_CURSOR_POS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x2D4<BR>+#define VIA_REG_CURSOR_ORG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x2D8<BR>+#define VIA_REG_CURSOR_BG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x2DC<BR>+#define VIA_REG_CURSOR_FG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x2E0<BR>+<BR>+/* VIA_REG_GEMODE(0x04): GE mode */<BR>+#define =
VIA_GEM_8bpp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; 0x00000000<BR>+#define =
VIA_GEM_16bpp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 0x00000100<BR>+#define =
VIA_GEM_32bpp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 0x00000300<BR>+<BR>+/* VIA_REG_GECMD(0x00): 2D Engine Command&nbsp; =
*/<BR>+#define =
VIA_GEC_NOOP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; 0x00000000<BR>+#define =
VIA_GEC_BLT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 0x00000001<BR>+#define =
VIA_GEC_LINE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; 0x00000005<BR>+<BR>+/* Rotate Command */<BR>+#define =
VIA_GEC_ROT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 0x00000008<BR>+<BR>+#define =
VIA_GEC_SRC_XY&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00000000<BR>+#define VIA_GEC_SRC_LINEAR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00000010<BR>+#define =
VIA_GEC_DST_XY&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00000000<BR>+#define VIA_GEC_DST_LINRAT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00000020<BR>+<BR>+#define =
VIA_GEC_SRC_FB&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00000000<BR>+#define =
VIA_GEC_SRC_SYS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00000040<BR>+#define =
VIA_GEC_DST_FB&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00000000<BR>+#define =
VIA_GEC_DST_SYS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00000080<BR>+<BR>+/* source is mono */<BR>+#define =
VIA_GEC_SRC_MONO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00000100<BR>+/* pattern is mono */<BR>+#define =
VIA_GEC_PAT_MONO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00000200<BR>+/* mono src is opaque */<BR>+#define =
VIA_GEC_MSRC_OPAQUE&nbsp;&nbsp;&nbsp;&nbsp; 0x00000000<BR>+/* mono src =
is transparent */<BR>+#define =
VIA_GEC_MSRC_TRANS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000400<BR>+/* =
pattern is in frame buffer */<BR>+#define =
VIA_GEC_PAT_FB&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00000000<BR>+/* pattern is from reg setting */<BR>+#define =
VIA_GEC_PAT_REG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00000800<BR>+<BR>+#define VIA_GEC_CLIP_DISABLE&nbsp;&nbsp;&nbsp; =
0x00000000<BR>+#define VIA_GEC_CLIP_ENABLE&nbsp;&nbsp;&nbsp;&nbsp; =
0x00001000<BR>+<BR>+#define VIA_GEC_FIXCOLOR_PAT&nbsp;&nbsp;&nbsp; =
0x00002000<BR>+<BR>+#define =
VIA_GEC_INCX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; 0x00000000<BR>+#define =
VIA_GEC_DECY&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; 0x00004000<BR>+#define =
VIA_GEC_INCY&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; 0x00000000<BR>+#define =
VIA_GEC_DECX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; 0x00008000<BR>+/* mono pattern is opaque */<BR>+#define =
VIA_GEC_MPAT_OPAQUE&nbsp;&nbsp;&nbsp;&nbsp; 0x00000000<BR>+/* mono =
pattern is transparent */<BR>+#define =
VIA_GEC_MPAT_TRANS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00010000<BR>+<BR>+#define VIA_GEC_MONO_UNPACK&nbsp;&nbsp;&nbsp;&nbsp; =
0x00000000<BR>+#define =
VIA_GEC_MONO_PACK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00020000<BR>+#define VIA_GEC_MONO_DWORD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00000000<BR>+#define =
VIA_GEC_MONO_WORD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00040000<BR>+#define =
VIA_GEC_MONO_BYTE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00080000<BR>+<BR>+#define VIA_GEC_LASTPIXEL_ON&nbsp;&nbsp;&nbsp; =
0x00000000<BR>+#define VIA_GEC_LASTPIXEL_OFF&nbsp;&nbsp; =
0x00100000<BR>+#define =
VIA_GEC_X_MAJOR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00000000<BR>+#define =
VIA_GEC_Y_MAJOR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00200000<BR>+#define VIA_GEC_QUICK_START&nbsp;&nbsp;&nbsp;&nbsp; =
0x00800000<BR>+<BR>+/* defines for VIA 3D registers */<BR>+#define =
VIA_REG_STATUS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x400<BR>+#define VIA_REG_CR_TRANSET&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x41C<BR>+#define VIA_REG_CR_TRANSPACE&nbsp;&nbsp; 0x420<BR>+#define =
VIA_REG_TRANSET&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x43C<BR>+#define VIA_REG_TRANSPACE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x440<BR>+<BR>+/* VIA_REG_STATUS(0x400): Engine Status */<BR>+<BR>+/* =
Command Regulator is busy */<BR>+#define =
VIA_CMD_RGTR_BUSY&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000080<BR>+/* =
2D Engine is busy */<BR>+#define =
VIA_2D_ENG_BUSY&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00000002<BR>+/* 3D Engine is busy */<BR>+#define =
VIA_3D_ENG_BUSY&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00000001<BR>+/* Virtual Queue is busy */<BR>+#define =
VIA_VR_QUEUE_BUSY&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00020000<BR>+<BR>+#define =
MAXLOOP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xFFFFFF<BR>+<BR>+void =
viafb_init_accel(void);<BR>+void viafb_init_2d_engine(void);<BR>+void =
set_2d_color_depth(int);<BR>+void viafb_hw_cursor_init(void);<BR>+void =
viafb_show_hw_cursor(struct fb_info *info, int Status);<BR>+int =
viafb_wait_engine_idle(void);<BR>+void viafb_set_2d_color_depth(int =
bpp);<BR>+<BR>+#endif /* __ACCEL_H__ */</FONT> </P></BODY></HTML>
------_=_NextPart_001_01C8FC15.E8E03D9E--


--===============1553492607==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============1553492607==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1553492607==--
