From: <EddyFu@via.com.tw>
Subject: [PATCH 2/5] viafb: Framebuffer driver for VIA
	UniChrome/Chrome9 HC
Date: Sat, 28 Apr 2007 10:42:37 +0800
Message-ID: <C80EF34A3D2E494DBAF9AC29C7AE4EB887D2E8@exchtp03.taipei.via.com.tw>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0124052011=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HhctY-0007BO-NX for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 27 Apr 2007 19:42:45 -0700
Received: from exchtp08.via.com.tw ([61.66.243.7])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HhctU-0005wD-7Q
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 27 Apr 2007 19:42:44 -0700
Content-class: urn:content-classes:message
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
To: 'linux-fbdev-devel@lists.sourceforge.net'

This is a multi-part message in MIME format.

--===============0124052011==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7893E.E1FC4847"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7893E.E1FC4847
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

diff -Nur linux-2.6.21-rc7/drivers/video/via/hwcfig.h =
linux-2.6.21-rc7.viafb/drivers/video/via/hwcfig.h
--- linux-2.6.21-rc7/drivers/video/via/hwcfig.h 1969-12-31 =
19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/hwcfig.h 2007-04-26 =
19:52:32.000000000 -0400
@@ -0,0 +1,399 @@
+ /*
+ * Copyright 1998-2007 VIA Technologies, Inc. All Rights Reserved.
+ * Copyright 2001-2007 S3 Graphics, Inc. All Rights Reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person =
obtaining a
+ * copy of this software and associated documentation files (the =
"Software"),
+ * to deal in the Software without restriction, including without =
limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sub =
license,
+ * and/or sell copies of the Software, and to permit persons to whom =
the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the
+ * next paragraph) shall be included in all copies or substantial =
portions
+ * of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, =
EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF =
MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT =
SHALL
+ * THE AUTHOR(S) OR COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, =
DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR =
OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE =
OR OTHER
+ * DEALINGS IN THE SOFTWARE.
+ */
+=20
+
+#ifndef __HWCFIG_H__
+#define __HWCFIG_H__
+
+#include <linux/ioport.h>
+#include <asm/io.h>
+
+#include "share.h"
+#include "hw.h"
+
+static struct pll_map pll_value[] =3D {
+    {CLK_25_175M,  CLE266_PLL_25_175M,  K800_PLL_25_175M,  =
CX700_25_175M},
+    {CLK_29_581M,  CLE266_PLL_29_581M,  K800_PLL_29_581M,  =
CX700_29_581M},
+    {CLK_26_880M,  CLE266_PLL_26_880M,  K800_PLL_26_880M,  =
CX700_26_880M},
+    {CLK_31_490M,  CLE266_PLL_31_490M,  K800_PLL_31_490M,  =
CX700_31_490M},
+    {CLK_31_500M,  CLE266_PLL_31_500M,  K800_PLL_31_500M,  =
CX700_31_500M},
+    {CLK_31_728M,  CLE266_PLL_31_728M,  K800_PLL_31_728M,  =
CX700_31_728M},
+    {CLK_32_668M,  CLE266_PLL_32_668M,  K800_PLL_32_668M,  =
CX700_32_668M},
+    {CLK_36_000M,  CLE266_PLL_36_000M,  K800_PLL_36_000M,  =
CX700_36_000M},
+    {CLK_40_000M,  CLE266_PLL_40_000M,  K800_PLL_40_000M,  =
CX700_40_000M},
+    {CLK_41_291M,  CLE266_PLL_41_291M,  K800_PLL_41_291M,  =
CX700_41_291M},
+    {CLK_43_163M,  CLE266_PLL_43_163M,  K800_PLL_43_163M,  =
CX700_43_163M},
+    {CLK_48_875M,  CLE266_PLL_48_875M,  K800_PLL_48_875M,  =
CX700_48_875M},
+    {CLK_49_500M,  CLE266_PLL_49_500M,  K800_PLL_49_500M,  =
CX700_49_500M},
+    {CLK_52_406M,  CLE266_PLL_52_406M,  K800_PLL_52_406M,  =
CX700_52_406M},
+    {CLK_56_250M,  CLE266_PLL_56_250M,  K800_PLL_56_250M,  =
CX700_56_250M},
+    {CLK_65_000M,  CLE266_PLL_65_000M,  K800_PLL_65_000M,  =
CX700_65_000M},
+    {CLK_68_179M,  CLE266_PLL_68_179M,  K800_PLL_68_179M,  =
CX700_68_179M},
+    {CLK_78_750M,  CLE266_PLL_78_750M,  K800_PLL_78_750M,  =
CX700_78_750M},
+    {CLK_80_136M,  CLE266_PLL_80_136M,  K800_PLL_80_136M,  =
CX700_80_136M},
+    {CLK_83_375M,  CLE266_PLL_83_375M,  K800_PLL_83_375M,  =
CX700_83_375M},
+    {CLK_83_950M,  CLE266_PLL_83_950M,  K800_PLL_83_950M,  =
CX700_83_950M},
+    {CLK_85_860M,  CLE266_PLL_85_860M,  K800_PLL_85_860M,  =
CX700_85_860M},
+    {CLK_94_500M,  CLE266_PLL_94_500M,  K800_PLL_94_500M,  =
CX700_94_500M},
+    {CLK_108_000M, CLE266_PLL_108_000M, K800_PLL_108_000M, =
CX700_108_000M},
+    {CLK_125_104M, CLE266_PLL_125_104M, K800_PLL_125_104M, =
CX700_125_104M},
+    {CLK_133_308M, CLE266_PLL_133_308M, K800_PLL_133_308M, =
CX700_133_308M},
+    {CLK_135_000M, CLE266_PLL_135_000M, K800_PLL_135_000M, =
CX700_135_000M},
+    {CLK_157_500M, CLE266_PLL_157_500M, K800_PLL_157_500M, =
CX700_157_500M},
+    {CLK_162_000M, CLE266_PLL_162_000M, K800_PLL_162_000M, =
CX700_162_000M},
+    {CLK_202_500M, CLE266_PLL_202_500M, K800_PLL_202_500M, =
CX700_202_500M},
+    {CLK_234_000M, CLE266_PLL_234_000M, K800_PLL_234_000M, =
CX700_234_000M},
+    {CLK_297_500M, CLE266_PLL_297_500M, K800_PLL_297_500M, =
CX700_297_500M},
+    {CLK_74_481M,  CLE266_PLL_74_481M,  K800_PLL_74_481M,  =
CX700_74_481M},
+    {CLK_172_798M, CLE266_PLL_172_798M, K800_PLL_172_798M, =
CX700_172_798M},
+    {CLK_122_614M, CLE266_PLL_122_614M, K800_PLL_122_614M, =
CX700_122_614M}
+   =20
+};
+
+#define NUM_TOTAL_PLL_TABLE ARRAY_SIZE(pll_value)
+
+static struct fifo_depth_select display_fifo_depth_reg=3D {
+    /* IGA1 FIFO Depth_Select */
+    {IGA1_FIFO_DEPTH_SELECT_REG_NUM, {{SR17,0,7}}},
+    /* IGA2 FIFO Depth_Select */
+    {IGA2_FIFO_DEPTH_SELECT_REG_NUM, {{CR68,4,7}, {CR94,7,7}, =
{CR95,7,7}}}
+};
+
+static struct fifo_threshold_select fifo_threshold_select_reg=3D {
+    /* IGA1 FIFO Threshold Select */
+    {IGA1_FIFO_THRESHOLD_REG_NUM, {{SR16,0,5},{SR16,7,7}}},
+    /* IGA2 FIFO Threshold Select */
+    {IGA2_FIFO_THRESHOLD_REG_NUM, {{CR68,0,3}, {CR95,4,6}}}
+};
+
+static struct fifo_high_threshold_select =
fifo_high_threshold_select_reg=3D {
+    /* IGA1 FIFO High Threshold Select */
+    {IGA1_FIFO_HIGH_THRESHOLD_REG_NUM, {{SR18,0,5},{SR18,7,7}}},
+    /* IGA2 FIFO High Threshold Select */
+    {IGA2_FIFO_HIGH_THRESHOLD_REG_NUM, {{CR92,0,3}, {CR95,0,2}}}
+};
+
+static struct display_queue_expire_num display_queue_expire_num_reg=3D =
{
+    /* IGA1 Display Queue Expire Num */
+    {IGA1_DISPLAY_QUEUE_EXPIRE_NUM_REG_NUM, {{SR22,0,4}}},
+    /* IGA2 Display Queue Expire Num */
+    {IGA2_DISPLAY_QUEUE_EXPIRE_NUM_REG_NUM, {{CR94,0,6}}}
+};
+
+/* Definition Offset Registers */
+static struct offset offset_reg =3D {
+    /* IGA1 Offset Register */
+    {IGA1_OFFSET_REG_NUM, {{CR13,0,7},{CR35,5,7}}},
+    /* IGA2 Offset Register */
+    {IGA2_OFFSET_REG_NUM, {{CR66,0,7},{CR67,0,1}}}
+};
+
+/* Definition Fetch Count Registers */
+static struct fetch_count fetch_count_reg =3D {
+    /* IGA1 Fetch Count Register */
+    {IGA1_FETCH_COUNT_REG_NUM, {{SR1C,0,7},{SR1D,0,1}}},
+    /* IGA2 Fetch Count Register */
+    {IGA2_FETCH_COUNT_REG_NUM, {{CR65,0,7},{CR67,2,3}}}
+};
+
+#define IGA1_STARTING_ADDR_REG_NUM      4           /* location: =
{CR0C,0,7},{CR0D,0,7},{CR34,0,7},{CR48,0,1} */
+#define IGA2_STARTING_ADDR_REG_NUM      3           /* location: =
{CR62,1,7},{CR63,0,7},{CR64,0,7} */
+
+static struct iga1_crtc_timing iga1_crtc_reg =3D {
+    /* IGA1 Horizontal Total */
+    {IGA1_HOR_TOTAL_REG_NUM, {{CR00,0,7}, {CR36,3,3}}},
+    /* IGA1 Horizontal Addressable Video */
+    {IGA1_HOR_ADDR_REG_NUM, {{CR01,0,7}}},
+    /* IGA1 Horizontal Blank Start */
+    {IGA1_HOR_BLANK_START_REG_NUM, {{CR02,0,7}}},
+    /* IGA1 Horizontal Blank End */
+    {IGA1_HOR_BLANK_END_REG_NUM, {{CR03,0,4}, {CR05,7,7}, {CR33,5,5}}},
+    /* IGA1 Horizontal Sync Start */
+    {IGA1_HOR_SYNC_START_REG_NUM, {{CR04,0,7}, {CR33,4,4}}},
+    /* IGA1 Horizontal Sync End */
+    {IGA1_HOR_SYNC_END_REG_NUM, {{CR05,0,4}}},
+    /* IGA1 Vertical Total */
+    {IGA1_VER_TOTAL_REG_NUM, {{CR06,0,7}, {CR07,0,0}, {CR07,5,5}, =
{CR35,0,0}}},
+    /* IGA1 Vertical Addressable Video */
+    {IGA1_VER_ADDR_REG_NUM, {{CR12,0,7}, {CR07,1,1}, {CR07,6,6}, =
{CR35,2,2}}},
+    /* IGA1 Vertical Blank Start */
+    {IGA1_VER_BLANK_START_REG_NUM, {{CR15,0,7}, {CR07,3,3}, {CR09,5,5}, =
{CR35,3,3}}},
+    /* IGA1 Vertical Blank End */
+    {IGA1_VER_BLANK_END_REG_NUM, {{CR16,0,7}}},
+    /* IGA1 Vertical Sync Start */
+    {IGA1_VER_SYNC_START_REG_NUM, {{CR10,0,7}, {CR07,2,2}, {CR07,7,7}, =
{CR35,1,1}}},
+    /* IGA1 Vertical Sync End */
+    {IGA1_VER_SYNC_END_REG_NUM, {{CR11,0,3}}}
+};
+
+static struct iga2_shadow_crtc_timing iga2_shadow_crtc_reg =3D {
+    /* IGA2 Shadow Horizontal Total */
+    {IGA2_SHADOW_HOR_TOTAL_REG_NUM, {{CR6D,0,7}, {CR71,3,3}}},
+    /* IGA2 Shadow Horizontal Blank End */
+    {IGA2_SHADOW_HOR_BLANK_END_REG_NUM, {{CR6E,0,7}}},
+    /* IGA2 Shadow Vertical Total */
+    {IGA2_SHADOW_VER_TOTAL_REG_NUM, {{CR6F,0,7}, {CR71,0,2}}},
+    /* IGA2 Shadow Vertical Addressable Video */
+    {IGA2_SHADOW_VER_ADDR_REG_NUM, {{CR70,0,7}, {CR71,4,6}}},
+    /* IGA2 Shadow Vertical Blank Start */
+    {IGA2_SHADOW_VER_BLANK_START_REG_NUM, {{CR72,0,7}, {CR74,4,6}}},
+    /* IGA2 Shadow Vertical Blank End */
+    {IGA2_SHADOW_VER_BLANK_END_REG_NUM, {{CR73,0,7}, {CR74,0,2}}},
+    /* IGA2 Shadow Vertical Sync Start */
+    {IGA2_SHADOW_VER_SYNC_START_REG_NUM, {{CR75,0,7}, {CR76,4,6}}},
+    /* IGA2 Shadow Vertical Sync End */
+    {IGA2_SHADOW_VER_SYNC_END_REG_NUM, {{CR76,0,3}}}
+};
+
+static struct iga2_crtc_timing iga2_crtc_reg =3D {
+    /* IGA2 Horizontal Total */
+    {IGA2_HOR_TOTAL_REG_NUM, {{CR50,0,7}, {CR55,0,3}}},
+    /* IGA2 Horizontal Addressable Video */
+    {IGA2_HOR_ADDR_REG_NUM, {{CR51,0,7}, {CR55,4,6}}},
+    /* IGA2 Horizontal Blank Start */
+    {IGA2_HOR_BLANK_START_REG_NUM, {{CR52,0,7}, {CR54,0,2}}},
+    /* IGA2 Horizontal Blank End */
+    {IGA2_HOR_BLANK_END_REG_NUM, {{CR53,0,7}, {CR54,3,5}, {CR5D,6,6}}},
+    /* IGA2 Horizontal Sync Start */
+    {IGA2_HOR_SYNC_START_REG_NUM, {{CR56,0,7}, {CR54,6,7}, {CR5C,7,7}, =
{CR5D,7,7}}},
+    /* IGA2 Horizontal Sync End */
+    {IGA2_HOR_SYNC_END_REG_NUM, {{CR57,0,7}, {CR5C,6,6}}},
+    /* IGA2 Vertical Total */
+    {IGA2_VER_TOTAL_REG_NUM, {{CR58,0,7}, {CR5D,0,2}}},
+    /* IGA2 Vertical Addressable Video */
+    {IGA2_VER_ADDR_REG_NUM, {{CR59,0,7}, {CR5D,3,5}}},
+    /* IGA2 Vertical Blank Start */
+    {IGA2_VER_BLANK_START_REG_NUM, {{CR5A,0,7}, {CR5C,0,2}}},
+    /* IGA2 Vertical Blank End */
+    {IGA2_VER_BLANK_END_REG_NUM, {{CR5B,0,7}, {CR5C,3,5}}},
+    /* IGA2 Vertical Sync Start */
+    {IGA2_VER_SYNC_START_REG_NUM, {{CR5E,0,7}, {CR5F,5,7}}},
+    /* IGA2 Vertical Sync End */
+    {IGA2_VER_SYNC_END_REG_NUM, {{CR5F,0,4}}}
+};
+
+static struct _lcd_scaling_factor lcd_scaling_factor =3D {
+    /* LCD Horizontal Scaling Factor Register */
+    {LCD_HOR_SCALING_FACTOR_REG_NUM, {{CR9F,0,1}, {CR77,0,7}, =
{CR79,4,5}}},
+    /* LCD Vertical Scaling Factor Register */
+    {LCD_VER_SCALING_FACTOR_REG_NUM, {{CR79,3,3}, {CR78,0,7}, =
{CR79,6,7}}}
+};
+static struct _lcd_scaling_factor lcd_scaling_factor_CLE =3D {
+    /* LCD Horizontal Scaling Factor Register */
+    {LCD_HOR_SCALING_FACTOR_REG_NUM_CLE, {{CR77,0,7}, {CR79,4,5}}},
+    /* LCD Vertical Scaling Factor Register */
+    {LCD_VER_SCALING_FACTOR_REG_NUM_CLE, {{CR78,0,7}, {CR79,6,7}}}
+};
+
+static struct rgbLUT palLUT_table[]=3D {
+    /* {R,G,B} */
+    /* Index 0x00~0x03 */
+    {0x00, 0x00, 0x00}, {0x00, 0x00, 0x2A}, {0x00, 0x2A, 0x00}, {0x00, =
0x2A, 0x2A},
+    /* Index 0x04~0x07 */
+    {0x2A, 0x00, 0x00}, {0x2A, 0x00, 0x2A}, {0x2A, 0x15, 0x00}, {0x2A, =
0x2A, 0x2A},
+    /* Index 0x08~0x0B */
+    {0x15, 0x15, 0x15}, {0x15, 0x15, 0x3F}, {0x15, 0x3F, 0x15}, {0x15, =
0x3F, 0x3F},
+    /* Index 0x0C~0x0F */
+    {0x3F, 0x15, 0x15}, {0x3F, 0x15, 0x3F}, {0x3F, 0x3F, 0x15}, {0x3F, =
0x3F, 0x3F},
+    /* Index 0x10~0x13 */
+    {0x00, 0x00, 0x00}, {0x05, 0x05, 0x05}, {0x08, 0x08, 0x08}, {0x0B, =
0x0B, 0x0B},
+    /* Index 0x14~0x17 */
+    {0x0E, 0x0E, 0x0E}, {0x11, 0x11, 0x11}, {0x14, 0x14, 0x14}, {0x18, =
0x18, 0x18},
+    /* Index 0x18~0x1B */
+    {0x1C, 0x1C, 0x1C}, {0x20, 0x20, 0x20}, {0x24, 0x24, 0x24}, {0x28, =
0x28, 0x28},
+    /* Index 0x1C~0x1F */
+    {0x2D, 0x2D, 0x2D}, {0x32, 0x32, 0x32}, {0x38, 0x38, 0x38}, {0x3F, =
0x3F, 0x3F},
+    /* Index 0x20~0x23 */
+    {0x00, 0x00, 0x3F}, {0x10, 0x00, 0x3F}, {0x1F, 0x00, 0x3F}, {0x2F, =
0x00, 0x3F},
+    /* Index 0x24~0x27 */
+    {0x3F, 0x00, 0x3F}, {0x3F, 0x00, 0x2F}, {0x3F, 0x00, 0x1F}, {0x3F, =
0x00, 0x10},
+    /* Index 0x28~0x2B */
+    {0x3F, 0x00, 0x00}, {0x3F, 0x10, 0x00}, {0x3F, 0x1F, 0x00}, {0x3F, =
0x2F, 0x00},
+    /* Index 0x2C~0x2F */
+    {0x3F, 0x3F, 0x00}, {0x2F, 0x3F, 0x00}, {0x1F, 0x3F, 0x00}, {0x10, =
0x3F, 0x00},
+    /* Index 0x30~0x33 */
+    {0x00, 0x3F, 0x00}, {0x00, 0x3F, 0x10}, {0x00, 0x3F, 0x1F}, {0x00, =
0x3F, 0x2F},
+    /* Index 0x34~0x37 */
+    {0x00, 0x3F, 0x3F}, {0x00, 0x2F, 0x3F}, {0x00, 0x1F, 0x3F}, {0x00, =
0x10, 0x3F},
+    /* Index 0x38~0x3B */
+    {0x1F, 0x1F, 0x3F}, {0x27, 0x1F, 0x3F}, {0x2F, 0x1F, 0x3F}, {0x37, =
0x1F, 0x3F},
+    /* Index 0x3C~0x3F */=20
+    {0x3F, 0x1F, 0x3F}, {0x3F, 0x1F, 0x37}, {0x3F, 0x1F, 0x2F}, {0x3F, =
0x1F, 0x27},
+    /* Index 0x40~0x43 */
+    {0x3F, 0x1F, 0x1F}, {0x3F, 0x27, 0x1F}, {0x3F, 0x2F, 0x1F}, {0x3F, =
0x3F, 0x1F},
+    /* Index 0x44~0x47 */
+    {0x3F, 0x3F, 0x1F}, {0x37, 0x3F, 0x1F}, {0x2F, 0x3F, 0x1F}, {0x27, =
0x3F, 0x1F},
+    /* Index 0x48~0x4B */
+    {0x1F, 0x3F, 0x1F}, {0x1F, 0x3F, 0x27}, {0x1F, 0x3F, 0x2F}, {0x1F, =
0x3F, 0x37},
+    /* Index 0x4C~0x4F */
+    {0x1F, 0x3F, 0x3F}, {0x1F, 0x37, 0x3F}, {0x1F, 0x2F, 0x3F}, {0x1F, =
0x27, 0x3F},
+    /* Index 0x50~0x53 */
+    {0x2D, 0x2D, 0x3F}, {0x31, 0x2D, 0x3F}, {0x36, 0x2D, 0x3F}, {0x3A, =
0x2D, 0x3F},
+    /* Index 0x54~0x57 */
+    {0x3F, 0x2D, 0x3F}, {0x3F, 0x2D, 0x3A}, {0x3F, 0x2D, 0x36}, {0x3F, =
0x2D, 0x31},
+    /* Index 0x58~0x5B */
+    {0x3F, 0x2D, 0x2D}, {0x3F, 0x31, 0x2D}, {0x3F, 0x36, 0x2D}, {0x3F, =
0x3A, 0x2D},
+    /* Index 0x5C~0x5F */
+    {0x3F, 0x3F, 0x2D}, {0x3A, 0x3F, 0x2D}, {0x36, 0x3F, 0x2D}, {0x31, =
0x3F, 0x2D},
+    /* Index 0x60~0x63 */
+    {0x2D, 0x3F, 0x2D}, {0x2D, 0x3F, 0x31}, {0x2D, 0x3F, 0x36}, {0x2D, =
0x3F, 0x3A},
+    /* Index 0x64~0x67 */
+    {0x2D, 0x3F, 0x3F}, {0x2D, 0x3A, 0x3F}, {0x2D, 0x36, 0x3F}, {0x2D, =
0x31, 0x3F},
+    /* Index 0x68~0x6B */
+    {0x00, 0x00, 0x1C}, {0x07, 0x00, 0x1C}, {0x0E, 0x00, 0x1C}, {0x15, =
0x00, 0x1C},
+    /* Index 0x6C~0x6F */
+    {0x1C, 0x00, 0x1C}, {0x1C, 0x00, 0x15}, {0x1C, 0x00, 0x0E}, {0x1C, =
0x00, 0x07},
+    /* Index 0x70~0x73 */
+    {0x1C, 0x00, 0x00}, {0x1C, 0x07, 0x00}, {0x1C, 0x0E, 0x00}, {0x1C, =
0x15, 0x00},
+    /* Index 0x74~0x77 */
+    {0x1C, 0x1C, 0x00}, {0x15, 0x1C, 0x00}, {0x0E, 0x1C, 0x00}, {0x07, =
0x1C, 0x00},
+    /* Index 0x78~0x7B */
+    {0x00, 0x1C, 0x00}, {0x00, 0x1C, 0x07}, {0x00, 0x1C, 0x0E}, {0x00, =
0x1C, 0x15},
+    /* Index 0x7C~0x7F */
+    {0x00, 0x1C, 0x1C}, {0x00, 0x15, 0x1C}, {0x00, 0x0E, 0x1C}, {0x00, =
0x07, 0x1C},
+    /* Index 0x80~0x83 */
+    {0x0E, 0x0E, 0x1C}, {0x11, 0x0E, 0x1C}, {0x15, 0x0E, 0x1C}, {0x18, =
0x0E, 0x1C},
+    /* Index 0x84~0x87 */
+    {0x1C, 0x0E, 0x1C}, {0x1C, 0x0E, 0x18}, {0x1C, 0x0E, 0x15}, {0x1C, =
0x0E, 0x11},
+    /* Index 0x88~0x8B */
+    {0x1C, 0x0E, 0x0E}, {0x1C, 0x11, 0x0E}, {0x1C, 0x15, 0x0E}, {0x1C, =
0x18, 0x0E},
+    /* Index 0x8C~0x8F */
+    {0x1C, 0x1C, 0x0E}, {0x18, 0x1C, 0x0E}, {0x15, 0x1C, 0x0E}, {0x11, =
0x1C, 0x0E},
+    /* Index 0x90~0x93 */
+    {0x0E, 0x1C, 0x0E}, {0x0E, 0x1C, 0x11}, {0x0E, 0x1C, 0x15}, {0x0E, =
0x1C, 0x18},
+    /* Index 0x94~0x97 */
+    {0x0E, 0x1C, 0x1C}, {0x0E, 0x18, 0x1C}, {0x0E, 0x15, 0x1C}, {0x0E, =
0x11, 0x1C},
+    /* Index 0x98~0x9B */
+    {0x14, 0x14, 0x1C}, {0x16, 0x14, 0x1C}, {0x18, 0x14, 0x1C}, {0x1A, =
0x14, 0x1C},
+    /* Index 0x9C~0x9F */
+    {0x1C, 0x14, 0x1C}, {0x1C, 0x14, 0x1A}, {0x1C, 0x14, 0x18}, {0x1C, =
0x14, 0x16},
+    /* Index 0xA0~0xA3 */
+    {0x1C, 0x14, 0x14}, {0x1C, 0x16, 0x14}, {0x1C, 0x18, 0x14}, {0x1C, =
0x1A, 0x14},
+    /* Index 0xA4~0xA7 */
+    {0x1C, 0x1C, 0x14}, {0x1A, 0x1C, 0x14}, {0x18, 0x1C, 0x14}, {0x16, =
0x1C, 0x14},
+    /* Index 0xA8~0xAB */
+    {0x14, 0x1C, 0x14}, {0x14, 0x1C, 0x16}, {0x14, 0x1C, 0x18}, {0x14, =
0x1C, 0x1A},
+    /* Index 0xAC~0xAF */
+    {0x14, 0x1C, 0x1C}, {0x14, 0x1A, 0x1C}, {0x14, 0x18, 0x1C}, {0x14, =
0x16, 0x1C},
+    /* Index 0xB0~0xB3 */
+    {0x00, 0x00, 0x10}, {0x04, 0x00, 0x10}, {0x08, 0x00, 0x10}, {0x0C, =
0x00, 0x10},
+    /* Index 0xB4~0xB7 */
+    {0x10, 0x00, 0x10}, {0x10, 0x00, 0x0C}, {0x10, 0x00, 0x08}, {0x10, =
0x00, 0x04},
+    /* Index 0xB8~0xBB */
+    {0x10, 0x00, 0x00}, {0x10, 0x04, 0x00}, {0x10, 0x08, 0x00}, {0x10, =
0x0C, 0x00},
+    /* Index 0xBC~0xBF */
+    {0x10, 0x10, 0x00}, {0x0C, 0x10, 0x00}, {0x08, 0x10, 0x00}, {0x04, =
0x10, 0x00},
+    /* Index 0xC0~0xC3 */
+    {0x00, 0x10, 0x00}, {0x00, 0x10, 0x04}, {0x00, 0x10, 0x08}, {0x00, =
0x10, 0x0C},
+    /* Index 0xC4~0xC7 */
+    {0x00, 0x10, 0x10}, {0x00, 0x0C, 0x10}, {0x00, 0x08, 0x10}, {0x00, =
0x04, 0x10},
+    /* Index 0xC8~0xCB */
+    {0x08, 0x08, 0x10}, {0x0A, 0x08, 0x10}, {0x0C, 0x08, 0x10}, {0x0E, =
0x08, 0x10},
+    /* Index 0xCC~0xCF */
+    {0x10, 0x08, 0x10}, {0x10, 0x08, 0x0E}, {0x10, 0x08, 0x0C}, {0x10, =
0x08, 0x0A},
+    /* Index 0xD0~0xD3 */
+    {0x10, 0x08, 0x08}, {0x10, 0x0A, 0x08}, {0x10, 0x0C, 0x08}, {0x10, =
0x0E, 0x08},
+    /* Index 0xD4~0xD7 */
+    {0x10, 0x10, 0x08}, {0x0E, 0x10, 0x08}, {0x0C, 0x10, 0x08}, {0x0A, =
0x10, 0x08},
+    /* Index 0xD8~0xDB */
+    {0x08, 0x10, 0x08}, {0x08, 0x10, 0x0A}, {0x08, 0x10, 0x0C}, {0x08, =
0x10, 0x0E},
+    /* Index 0xDC~0xDF */
+    {0x08, 0x10, 0x10}, {0x08, 0x0E, 0x10}, {0x08, 0x0C, 0x10}, {0x08, =
0x0A, 0x10},
+    /* Index 0xE0~0xE3 */
+    {0x0B, 0x0B, 0x10}, {0x0C, 0x0B, 0x10}, {0x0D, 0x0B, 0x10}, {0x0F, =
0x0B, 0x10},
+    /* Index 0xE4~0xE7 */
+    {0x10, 0x0B, 0x10}, {0x10, 0x0B, 0x0F}, {0x10, 0x0B, 0x0D}, {0x10, =
0x0B, 0x0C},
+    /* Index 0xE8~0xEB */
+    {0x10, 0x0B, 0x0B}, {0x10, 0x0C, 0x0B}, {0x10, 0x0D, 0x0B}, {0x10, =
0x0F, 0x0B},
+    /* Index 0xEC~0xEF */
+    {0x10, 0x10, 0x0B}, {0x0F, 0x10, 0x0B}, {0x0D, 0x10, 0x0B}, {0x0C, =
0x10, 0x0B},
+    /* Index 0xF0~0xF3 */
+    {0x0B, 0x10, 0x0B}, {0x0B, 0x10, 0x0C}, {0x0B, 0x10, 0x0D}, {0x0B, =
0x10, 0x0F},
+    /* Index 0xF4~0xF7 */
+    {0x0B, 0x10, 0x10}, {0x0B, 0x0F, 0x10}, {0x0B, 0x0D, 0x10}, {0x0B, =
0x0C, 0x10},
+    /* Index 0xF8~0xFB */
+    {0x00, 0x00, 0x00}, {0x00, 0x00, 0x00}, {0x00, 0x00, 0x00}, {0x00, =
0x00, 0x00},
+    /* Index 0xFC~0xFF */
+    {0x00, 0x00, 0x00}, {0x00, 0x00, 0x00}, {0x00, 0x00, 0x00}, {0x00, =
0x00, 0x00}
+};
+
+static u16 red256[] =3D {
+0x0   ,0x0   ,0x0   ,0x0   =
,0xa800,0xa800,0xa800,0xa800,0x5400,0x5400,0x5400,0x5400,0xfc00,0xfc00,0x=
fc00,0xfc00,
+0x0   =
,0x1400,0x2000,0x2c00,0x3800,0x4400,0x5000,0x6000,0x7000,0x8000,0x9000,0x=
a000,0xb400,0xc800,0xe000,0xfc00,
+0x0   =
,0x4000,0x7c00,0xbc00,0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0x=
fc00,0xfc00,0xbc00,0x7c00,0x4000,
+0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   =
,0x7c00,0x9c00,0xbc00,0xdc00,0xfc00,0xfc00,0xfc00,0xfc00,
+0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0xdc00,0xbc00,0x9c00,0x7c00,0x7c00,0x=
7c00,0x7c00,0x7c00,0x7c00,0x7c00,0x7c00,
+0xb400,0xc400,0xd800,0xe800,0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0x=
fc00,0xfc00,0xfc00,0xe800,0xd800,0xc400,
+0xb400,0xb400,0xb400,0xb400,0xb400,0xb400,0xb400,0xb400,0x0   =
,0x1c00,0x3800,0x5400,0x7000,0x7000,0x7000,0x7000,
+0x7000,0x7000,0x7000,0x7000,0x7000,0x5400,0x3800,0x1c00,0x0   ,0x0   =
,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,
+0x3800,0x4400,0x5400,0x6000,0x7000,0x7000,0x7000,0x7000,0x7000,0x7000,0x=
7000,0x7000,0x7000,0x6000,0x5400,0x4400,
+0x3800,0x3800,0x3800,0x3800,0x3800,0x3800,0x3800,0x3800,0x5000,0x5800,0x=
6000,0x6800,0x7000,0x7000,0x7000,0x7000,
+0x7000,0x7000,0x7000,0x7000,0x7000,0x6800,0x6000,0x5800,0x5000,0x5000,0x=
5000,0x5000,0x5000,0x5000,0x5000,0x5000,
+0x0   =
,0x1000,0x2000,0x3000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x=
4000,0x4000,0x3000,0x2000,0x1000,
+0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   =
,0x2000,0x2800,0x3000,0x3800,0x4000,0x4000,0x4000,0x4000,
+0x4000,0x4000,0x4000,0x4000,0x4000,0x3800,0x3000,0x2800,0x2000,0x2000,0x=
2000,0x2000,0x2000,0x2000,0x2000,0x2000,
+0x2c00,0x3000,0x3400,0x3c00,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x=
4000,0x4000,0x4000,0x3c00,0x3400,0x3000,
+0x2c00,0x2c00,0x2c00,0x2c00,0x2c00,0x2c00,0x2c00,0x2c00,0x0   ,0x0   =
,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0
+};
+static u16 green256[] =3D {
+0x0   ,0x0   ,0xa800,0xa800,0x0   ,0x0   =
,0x5400,0xa800,0x5400,0x5400,0xfc00,0xfc00,0x5400,0x5400,0xfc00,0xfc00,
+0x0   =
,0x1400,0x2000,0x2c00,0x3800,0x4400,0x5000,0x6000,0x7000,0x8000,0x9000,0x=
a000,0xb400,0xc800,0xe000,0xfc00,
+0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   =
,0x7c00,0xbc00,0xfc00,0xfc00,0xfc00,0xfc00,
+0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0xbc00,0x7c00,0x4000,0x7c00,0x7c00,0x=
7c00,0x7c00,0x7c00,0x7c00,0x7c00,0x7c00,
+0x7c00,0x9c00,0xbc00,0xdc00,0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0x=
fc00,0xfc00,0xfc00,0xdc00,0xbc00,0x9c00,
+0xb400,0xb400,0xb400,0xb400,0xb400,0xb400,0xb400,0xb400,0xb400,0xc400,0x=
d800,0xe800,0xfc00,0xfc00,0xfc00,0xfc00,
+0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0xe800,0xd800,0xc400,0x0   ,0x0   =
,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,
+0x0   =
,0x1c00,0x3800,0x5400,0x7000,0x7000,0x7000,0x7000,0x7000,0x7000,0x7000,0x=
7000,0x7000,0x5400,0x3800,0x1c00,
+0x3800,0x3800,0x3800,0x3800,0x3800,0x3800,0x3800,0x3800,0x3800,0x4400,0x=
5400,0x6000,0x7000,0x7000,0x7000,0x7000,
+0x7000,0x7000,0x7000,0x7000,0x7000,0x6000,0x5400,0x4400,0x5000,0x5000,0x=
5000,0x5000,0x5000,0x5000,0x5000,0x5000,
+0x5000,0x5800,0x6000,0x6800,0x7000,0x7000,0x7000,0x7000,0x7000,0x7000,0x=
7000,0x7000,0x7000,0x6800,0x6000,0x5800,
+0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   =
,0x1000,0x2000,0x3000,0x4000,0x4000,0x4000,0x4000,
+0x4000,0x4000,0x4000,0x4000,0x4000,0x3000,0x2000,0x1000,0x2000,0x2000,0x=
2000,0x2000,0x2000,0x2000,0x2000,0x2000,
+0x2000,0x2800,0x3000,0x3800,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x=
4000,0x4000,0x4000,0x3800,0x3000,0x2800,
+0x2c00,0x2c00,0x2c00,0x2c00,0x2c00,0x2c00,0x2c00,0x2c00,0x2c00,0x3000,0x=
3400,0x3c00,0x4000,0x4000,0x4000,0x4000,
+0x4000,0x4000,0x4000,0x4000,0x4000,0x3c00,0x3400,0x3000,0x0   ,0x0   =
,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0
+};
+static u16 blue256[] =3D {
+0x0   ,0xa800,0x0   ,0xa800,0x0   ,0xa800,0x0   =
,0xa800,0x5400,0xfc00,0x5400,0xfc00,0x5400,0xfc00,0x5400,0xfc00,
+0x0   =
,0x1400,0x2000,0x2c00,0x3800,0x4400,0x5000,0x6000,0x7000,0x8000,0x9000,0x=
a000,0xb400,0xc800,0xe000,0xfc00,
+0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0xbc00,0x7c00,0x4000,0x0   ,0x0   =
,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,
+0x0   =
,0x4000,0x7c00,0xbc00,0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0x=
fc00,0xfc00,0xdc00,0xbc00,0x9c00,
+0x7c00,0x7c00,0x7c00,0x7c00,0x7c00,0x7c00,0x7c00,0x7c00,0x7c00,0x9c00,0x=
bc00,0xdc00,0xfc00,0xfc00,0xfc00,0xfc00,
+0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0xe800,0xd800,0xc400,0xb400,0xb400,0x=
b400,0xb400,0xb400,0xb400,0xb400,0xb400,
+0xb400,0xc400,0xd800,0xe800,0xfc00,0xfc00,0xfc00,0xfc00,0x7000,0x7000,0x=
7000,0x7000,0x7000,0x5400,0x3800,0x1c00,
+0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   =
,0x1c00,0x3800,0x5400,0x7000,0x7000,0x7000,0x7000,
+0x7000,0x7000,0x7000,0x7000,0x7000,0x6000,0x5400,0x4400,0x3800,0x3800,0x=
3800,0x3800,0x3800,0x3800,0x3800,0x3800,
+0x3800,0x4400,0x5400,0x6000,0x7000,0x7000,0x7000,0x7000,0x7000,0x7000,0x=
7000,0x7000,0x7000,0x6800,0x6000,0x5800,
+0x5000,0x5000,0x5000,0x5000,0x5000,0x5000,0x5000,0x5000,0x5000,0x5800,0x=
6000,0x6800,0x7000,0x7000,0x7000,0x7000,
+0x4000,0x4000,0x4000,0x4000,0x4000,0x3000,0x2000,0x1000,0x0   ,0x0   =
,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,
+0x0   =
,0x1000,0x2000,0x3000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x=
4000,0x4000,0x3800,0x3000,0x2800,
+0x2000,0x2000,0x2000,0x2000,0x2000,0x2000,0x2000,0x2000,0x2000,0x2800,0x=
3000,0x3800,0x4000,0x4000,0x4000,0x4000,
+0x4000,0x4000,0x4000,0x4000,0x4000,0x3c00,0x3400,0x3000,0x2c00,0x2c00,0x=
2c00,0x2c00,0x2c00,0x2c00,0x2c00,0x2c00,
+0x2c00,0x3000,0x3400,0x3c00,0x4000,0x4000,0x4000,0x4000,0x0   ,0x0   =
,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0
+};
+#endif /* __HWCFIG_H__ */
+
+
+
+
diff -Nur linux-2.6.21-rc7/drivers/video/via/hw.h =
linux-2.6.21-rc7.viafb/drivers/video/via/hw.h
--- linux-2.6.21-rc7/drivers/video/via/hw.h 1969-12-31 =
19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/hw.h 2007-04-26 =
19:52:32.000000000 -0400
@@ -0,0 +1,749 @@
+ /*
+ * Copyright 1998-2007 VIA Technologies, Inc. All Rights Reserved.
+ * Copyright 2001-2007 S3 Graphics, Inc. All Rights Reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person =
obtaining a
+ * copy of this software and associated documentation files (the =
"Software"),
+ * to deal in the Software without restriction, including without =
limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sub =
license,
+ * and/or sell copies of the Software, and to permit persons to whom =
the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the
+ * next paragraph) shall be included in all copies or substantial =
portions
+ * of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, =
EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF =
MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT =
SHALL
+ * THE AUTHOR(S) OR COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, =
DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR =
OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE =
OR OTHER
+ * DEALINGS IN THE SOFTWARE.
+ */
+=20
+
+#ifndef __HW_H__
+#define __HW_H__
+
+#include <linux/ioport.h>
+#include <asm/io.h>
+
+#include "share.h"
+
+
+/***************************************************/
+/* Definition IGA1 Design Method of CRTC Registers */
+/***************************************************/
+#define IGA1_HOR_TOTAL_FORMULA(x)           ((x)/8)-5
+#define IGA1_HOR_ADDR_FORMULA(x)            ((x)/8)-1
+#define IGA1_HOR_BLANK_START_FORMULA(x)     ((x)/8)-1
+#define IGA1_HOR_BLANK_END_FORMULA(x,y)     ((x+y)/8)-1
+#define IGA1_HOR_SYNC_START_FORMULA(x)      ((x)/8)
+#define IGA1_HOR_SYNC_END_FORMULA(x,y)      ((x+y)/8)
+
+#define IGA1_VER_TOTAL_FORMULA(x)           (x)-2
+#define IGA1_VER_ADDR_FORMULA(x)            (x)-1
+#define IGA1_VER_BLANK_START_FORMULA(x)     (x)-1
+#define IGA1_VER_BLANK_END_FORMULA(x,y)     (x+y)-1
+#define IGA1_VER_SYNC_START_FORMULA(x)      (x)-1
+#define IGA1_VER_SYNC_END_FORMULA(x,y)      (x+y)-1
+
+/***************************************************/
+/* Definition IGA2 Design Method of CRTC Registers */
+/***************************************************/
+#define IGA2_HOR_TOTAL_FORMULA(x)           (x)-1
+#define IGA2_HOR_ADDR_FORMULA(x)            (x)-1
+#define IGA2_HOR_BLANK_START_FORMULA(x)     (x)-1
+#define IGA2_HOR_BLANK_END_FORMULA(x,y)     (x+y)-1
+#define IGA2_HOR_SYNC_START_FORMULA(x)      (x)-1
+#define IGA2_HOR_SYNC_END_FORMULA(x,y)      (x+y)-1
+
+#define IGA2_VER_TOTAL_FORMULA(x)           (x)-1
+#define IGA2_VER_ADDR_FORMULA(x)            (x)-1
+#define IGA2_VER_BLANK_START_FORMULA(x)     (x)-1
+#define IGA2_VER_BLANK_END_FORMULA(x,y)     (x+y)-1
+#define IGA2_VER_SYNC_START_FORMULA(x)      (x)-1
+#define IGA2_VER_SYNC_END_FORMULA(x,y)      (x+y)-1
+
+/**********************************************************/
+/* Definition IGA2 Design Method of CRTC Shadow Registers */
+/**********************************************************/
+#define IGA2_HOR_TOTAL_SHADOW_FORMULA(x)           (x/8)-5
+#define IGA2_HOR_BLANK_END_SHADOW_FORMULA(x,y)     ((x+y)/8)-1
+#define IGA2_VER_TOTAL_SHADOW_FORMULA(x)           (x)-2
+#define IGA2_VER_ADDR_SHADOW_FORMULA(x)            (x)-1
+#define IGA2_VER_BLANK_START_SHADOW_FORMULA(x)     (x)-1
+#define IGA2_VER_BLANK_END_SHADOW_FORMULA(x,y)     (x+y)-1
+#define IGA2_VER_SYNC_START_SHADOW_FORMULA(x)      (x)
+#define IGA2_VER_SYNC_END_SHADOW_FORMULA(x,y)      (x+y)
+
+/* Define Register Number for IGA1 CRTC Timing */
+#define IGA1_HOR_TOTAL_REG_NUM          2           /* location: =
{CR00,0,7},{CR36,3,3} */
+#define IGA1_HOR_ADDR_REG_NUM           1           /* location: =
{CR01,0,7} */
+#define IGA1_HOR_BLANK_START_REG_NUM    1           /* location: =
{CR02,0,7} */
+#define IGA1_HOR_BLANK_END_REG_NUM      3           /* location: =
{CR03,0,4},{CR05,7,7},{CR33,5,5} */
+#define IGA1_HOR_SYNC_START_REG_NUM     2           /* location: =
{CR04,0,7},{CR33,4,4} */
+#define IGA1_HOR_SYNC_END_REG_NUM       1           /* location: =
{CR05,0,4} */
+#define IGA1_VER_TOTAL_REG_NUM          4           /* location: =
{CR06,0,7},{CR07,0,0},{CR07,5,5},{CR35,0,0} */
+#define IGA1_VER_ADDR_REG_NUM           4           /* location: =
{CR12,0,7},{CR07,1,1},{CR07,6,6},{CR35,2,2} */
+#define IGA1_VER_BLANK_START_REG_NUM    4           /* location: =
{CR15,0,7},{CR07,3,3},{CR09,5,5},{CR35,3,3} */
+#define IGA1_VER_BLANK_END_REG_NUM      1           /* location: =
{CR16,0,7} */
+#define IGA1_VER_SYNC_START_REG_NUM     4           /* location: =
{CR10,0,7},{CR07,2,2},{CR07,7,7},{CR35,1,1} */
+#define IGA1_VER_SYNC_END_REG_NUM       1           /* location: =
{CR11,0,3} */
+
+/* Define Register Number for IGA2 Shadow CRTC Timing */
+#define IGA2_SHADOW_HOR_TOTAL_REG_NUM       2       /* location: =
{CR6D,0,7},{CR71,3,3} */
+#define IGA2_SHADOW_HOR_BLANK_END_REG_NUM   1       /* location: =
{CR6E,0,7} */
+#define IGA2_SHADOW_VER_TOTAL_REG_NUM       2       /* location: =
{CR6F,0,7},{CR71,0,2} */
+#define IGA2_SHADOW_VER_ADDR_REG_NUM        2       /* location: =
{CR70,0,7},{CR71,4,6} */
+#define IGA2_SHADOW_VER_BLANK_START_REG_NUM 2       /* location: =
{CR72,0,7},{CR74,4,6} */
+#define IGA2_SHADOW_VER_BLANK_END_REG_NUM   2       /* location: =
{CR73,0,7},{CR74,0,2} */
+#define IGA2_SHADOW_VER_SYNC_START_REG_NUM  2       /* location: =
{CR75,0,7},{CR76,4,6} */
+#define IGA2_SHADOW_VER_SYNC_END_REG_NUM    1       /* location: =
{CR76,0,3} */
+
+/* Define Register Number for IGA2 CRTC Timing */
+#define IGA2_HOR_TOTAL_REG_NUM          2           /* location: =
{CR50,0,7},{CR55,0,3} */
+#define IGA2_HOR_ADDR_REG_NUM           2           /* location: =
{CR51,0,7},{CR55,4,6} */
+#define IGA2_HOR_BLANK_START_REG_NUM    2           /* location: =
{CR52,0,7},{CR54,0,2} */
+#define IGA2_HOR_BLANK_END_REG_NUM      3           /* location: =
CLE266: {CR53,0,7},{CR54,3,5} =3D> CLE266's CR5D[6] is reserved, so it =
may have problem to set 1600x1200 on IGA2. */
+                                                    /*           =
Others: {CR53,0,7},{CR54,3,5},{CR5D,6,6} */
+#define IGA2_HOR_SYNC_START_REG_NUM     4           /* location: =
{CR56,0,7},{CR54,6,7},{CR5C,7,7} */
+                                                                        =
             /* VT3314 and Later: {CR56,0,7},{CR54,6,7},{CR5C,7,7}, =
{CR5D,7,7} */
+#define IGA2_HOR_SYNC_END_REG_NUM       2           /* location: =
{CR57,0,7},{CR5C,6,6} */
+#define IGA2_VER_TOTAL_REG_NUM          2           /* location: =
{CR58,0,7},{CR5D,0,2} */=20
+#define IGA2_VER_ADDR_REG_NUM           2           /* location: =
{CR59,0,7},{CR5D,3,5} */
+#define IGA2_VER_BLANK_START_REG_NUM    2           /* location: =
{CR5A,0,7},{CR5C,0,2} */
+#define IGA2_VER_BLANK_END_REG_NUM      2           /* location: =
{CR5E,0,7},{CR5C,3,5} */
+#define IGA2_VER_SYNC_START_REG_NUM     2           /* location: =
{CR5E,0,7},{CR5F,5,7} */
+#define IGA2_VER_SYNC_END_REG_NUM       1           /* location: =
{CR5F,0,4} */
+
+/* Define Offset and Fetch Count Register*/
+#define IGA1_OFFSET_REG_NUM             2                               =
  /* location: {CR13,0,7},{CR35,5,7} */
+#define IGA1_OFFSER_ALIGN_BYTE          8                               =
  /* 8 bytes alignment. */
+#define IGA1_OFFSET_FORMULA(x,y)        (x*y)/IGA1_OFFSER_ALIGN_BYTE    =
  /* x: H resolution, y: color depth */
+
+#define IGA1_FETCH_COUNT_REG_NUM        2                               =
  /* location: {SR1C,0,7},{SR1D,0,1} */
+#define IGA1_FETCH_COUNT_ALIGN_BYTE     16                              =
  /* 16 bytes alignment. */
+#define IGA1_FETCH_COUNT_PATCH_VALUE    4                               =
  /* x: H resolution, y: color depth */
+#define IGA1_FETCH_COUNT_FORMULA(x,y)   =
((x*y)/IGA1_FETCH_COUNT_ALIGN_BYTE)+ IGA1_FETCH_COUNT_PATCH_VALUE
+
+#define IGA2_OFFSET_REG_NUM             2           /* location: =
{CR66,0,7},{CR67,0,1} */
+#define IGA2_OFFSET_ALIGN_BYTE          8
+#define IGA2_OFFSET_FORMULA(x,y)        (x*y)/IGA2_OFFSET_ALIGN_BYTE    =
 /* x: H resolution, y: color depth */
+
+#define IGA2_FETCH_COUNT_REG_NUM        2           /* location: =
{CR65,0,7},{CR67,2,3} */
+#define IGA2_FETCH_COUNT_ALIGN_BYTE     16
+#define IGA2_FETCH_COUNT_PATCH_VALUE    0
+#define IGA2_FETCH_COUNT_FORMULA(x,y)   =
((x*y)/IGA2_FETCH_COUNT_ALIGN_BYTE)+ IGA2_FETCH_COUNT_PATCH_VALUE
+
+/* Staring Address */
+#define IGA1_STARTING_ADDR_REG_NUM      4           /* location: =
{CR0C,0,7},{CR0D,0,7},{CR34,0,7},{CR48,0,1} */
+#define IGA2_STARTING_ADDR_REG_NUM      3           /* location: =
{CR62,1,7},{CR63,0,7},{CR64,0,7} */
+
+/* Define Display OFFSET */
+/* These value are by HW suggested value */
+#define K800_IGA1_FIFO_MAX_DEPTH                384     /* location: =
{SR17,0,7} */
+#define K800_IGA1_FIFO_THRESHOLD                328     /* location: =
{SR16,0,5},{SR16,7,7} */
+#define K800_IGA1_FIFO_HIGH_THRESHOLD           296     /* location: =
{SR18,0,5},{SR18,7,7} */
+#define K800_IGA1_DISPLAY_QUEUE_EXPIRE_NUM      0       /* location: =
{SR22,0,4}. (128/4) =3D64, K800 must be set zero, */
+                                                        /* because HW =
only 5 bits */
+
+#define K800_IGA2_FIFO_MAX_DEPTH                384     /* location: =
{CR68,4,7},{CR94,7,7},{CR95,7,7} */
+#define K800_IGA2_FIFO_THRESHOLD                328     /* location: =
{CR68,0,3},{CR95,4,6} */
+#define K800_IGA2_FIFO_HIGH_THRESHOLD           296     /* location: =
{CR92,0,3},{CR95,0,2} */
+#define K800_IGA2_DISPLAY_QUEUE_EXPIRE_NUM      128     /* location: =
{CR94,0,6} */
+
+#define P880_IGA1_FIFO_MAX_DEPTH                192     /* location: =
{SR17,0,7} */
+#define P880_IGA1_FIFO_THRESHOLD                128     /* location: =
{SR16,0,5},{SR16,7,7} */
+#define P880_IGA1_FIFO_HIGH_THRESHOLD           64      /* location: =
{SR18,0,5},{SR18,7,7} */
+#define P880_IGA1_DISPLAY_QUEUE_EXPIRE_NUM      0       /* location: =
{SR22,0,4}. (128/4) =3D64, K800 must be set zero, */
+                                                        /* because HW =
only 5 bits */
+
+#define P880_IGA2_FIFO_MAX_DEPTH                96      /* location: =
{CR68,4,7},{CR94,7,7},{CR95,7,7} */
+#define P880_IGA2_FIFO_THRESHOLD                64      /* location: =
{CR68,0,3},{CR95,4,6} */
+#define P880_IGA2_FIFO_HIGH_THRESHOLD           32      /* location: =
{CR92,0,3},{CR95,0,2} */
+#define P880_IGA2_DISPLAY_QUEUE_EXPIRE_NUM      128     /* location: =
{CR94,0,6} */
+
+/* VT3314 chipset*/
+#define CN900_IGA1_FIFO_MAX_DEPTH               96 /* location: =
{SR17,0,7}*/
+#define CN900_IGA1_FIFO_THRESHOLD               80 /* location: =
{SR16,0,5},{SR16,7,7}*/
+#define CN900_IGA1_FIFO_HIGH_THRESHOLD          64  /* location: =
{SR18,0,5},{SR18,7,7}*/
+#define CN900_IGA1_DISPLAY_QUEUE_EXPIRE_NUM     0   /* location: =
{SR22,0,4}. (128/4) =3D64, P800 must be set zero, because HW only 5 =
bits*/
+
+#define CN900_IGA2_FIFO_MAX_DEPTH               96  /* location: =
{CR68,4,7},{CR94,7,7},{CR95,7,7}*/
+#define CN900_IGA2_FIFO_THRESHOLD               80  /* location: =
{CR68,0,3},{CR95,4,6}*/
+#define CN900_IGA2_FIFO_HIGH_THRESHOLD          32  /* location: =
{CR92,0,3},{CR95,0,2}*/
+#define CN900_IGA2_DISPLAY_QUEUE_EXPIRE_NUM     128 /* location: =
{CR94,0,6}*/
+
+/* For VT3324, these values are suggested by HW */
+#define CX700_IGA1_FIFO_MAX_DEPTH               192     /* location: =
{SR17,0,7}*/
+#define CX700_IGA1_FIFO_THRESHOLD               128     /* location: =
{SR16,0,5},{SR16,7,7}*/
+#define CX700_IGA1_FIFO_HIGH_THRESHOLD          128     /* location: =
{SR18,0,5},{SR18,7,7} */
+#define CX700_IGA1_DISPLAY_QUEUE_EXPIRE_NUM     124     /* location: =
{SR22,0,4} */
+
+#define CX700_IGA2_FIFO_MAX_DEPTH               96      /* location: =
{CR68,4,7},{CR94,7,7},{CR95,7,7}*/
+#define CX700_IGA2_FIFO_THRESHOLD               64      /* location: =
{CR68,0,3},{CR95,4,6}*/
+#define CX700_IGA2_FIFO_HIGH_THRESHOLD          32      /* location: =
{CR92,0,3},{CR95,0,2} */
+#define CX700_IGA2_DISPLAY_QUEUE_EXPIRE_NUM     128     /* location: =
{CR94,0,6}*/
+
+/* VT3336 chipset*/
+#define K8M890_IGA1_FIFO_MAX_DEPTH               360 /* location: =
{SR17,0,7}*/
+#define K8M890_IGA1_FIFO_THRESHOLD               328 /* location: =
{SR16,0,5},{SR16,7,7}*/
+#define K8M890_IGA1_FIFO_HIGH_THRESHOLD          296 /* location: =
{SR18,0,5},{SR18,7,7}*/
+#define K8M890_IGA1_DISPLAY_QUEUE_EXPIRE_NUM     124 /* location: =
{SR22,0,4}.*/
+
+#define K8M890_IGA2_FIFO_MAX_DEPTH               360 /* location: =
{CR68,4,7},{CR94,7,7},{CR95,7,7}*/
+#define K8M890_IGA2_FIFO_THRESHOLD               328 /* location: =
{CR68,0,3},{CR95,4,6}*/
+#define K8M890_IGA2_FIFO_HIGH_THRESHOLD          296 /* location: =
{CR92,0,3},{CR95,0,2}*/
+#define K8M890_IGA2_DISPLAY_QUEUE_EXPIRE_NUM     124 /* location: =
{CR94,0,6}*/
+
+/* VT3327 chipset*/
+#define P4M890_IGA1_FIFO_MAX_DEPTH               96  /* location: =
{SR17,0,7}*/
+#define P4M890_IGA1_FIFO_THRESHOLD               76  /* location: =
{SR16,0,5},{SR16,7,7}*/
+#define P4M890_IGA1_FIFO_HIGH_THRESHOLD          64  /* location: =
{SR18,0,5},{SR18,7,7}*/
+#define P4M890_IGA1_DISPLAY_QUEUE_EXPIRE_NUM     32  /* location: =
{SR22,0,4}. (32/4) =3D8*/
+
+#define P4M890_IGA2_FIFO_MAX_DEPTH               96  /* location: =
{CR68,4,7},{CR94,7,7},{CR95,7,7}*/
+#define P4M890_IGA2_FIFO_THRESHOLD               76  /* location: =
{CR68,0,3},{CR95,4,6}*/
+#define P4M890_IGA2_FIFO_HIGH_THRESHOLD          64  /* location: =
{CR92,0,3},{CR95,0,2}*/
+#define P4M890_IGA2_DISPLAY_QUEUE_EXPIRE_NUM     32  /* location: =
{CR94,0,6}*/
+
+/* VT3364 chipset*/
+#define P4M900_IGA1_FIFO_MAX_DEPTH               96     /* location: =
{SR17,0,7}*/
+#define P4M900_IGA1_FIFO_THRESHOLD               76     /* location: =
{SR16,0,5},{SR16,7,7}*/
+#define P4M900_IGA1_FIFO_HIGH_THRESHOLD          76     /* location: =
{SR18,0,5},{SR18,7,7}*/
+#define P4M900_IGA1_DISPLAY_QUEUE_EXPIRE_NUM     32     /* location: =
{SR22,0,4}.*/
+
+#define P4M900_IGA2_FIFO_MAX_DEPTH               96     /* location: =
{CR68,4,7},{CR94,7,7},{CR95,7,7}*/
+#define P4M900_IGA2_FIFO_THRESHOLD               76     /* location: =
{CR68,0,3},{CR95,4,6}*/
+#define P4M900_IGA2_FIFO_HIGH_THRESHOLD          76     /* location: =
{CR92,0,3},{CR95,0,2}*/
+#define P4M900_IGA2_DISPLAY_QUEUE_EXPIRE_NUM     32     /* location: =
{CR94,0,6}*/
+
+#define IGA1_FIFO_DEPTH_SELECT_REG_NUM          1
+#define IGA1_FIFO_THRESHOLD_REG_NUM             2
+#define IGA1_FIFO_HIGH_THRESHOLD_REG_NUM        2
+#define IGA1_DISPLAY_QUEUE_EXPIRE_NUM_REG_NUM   1
+
+#define IGA2_FIFO_DEPTH_SELECT_REG_NUM          3
+#define IGA2_FIFO_THRESHOLD_REG_NUM             2
+#define IGA2_FIFO_HIGH_THRESHOLD_REG_NUM        2
+#define IGA2_DISPLAY_QUEUE_EXPIRE_NUM_REG_NUM   1
+
+
+#define IGA1_FIFO_DEPTH_SELECT_FORMULA(x)                   (x/2)-1
+#define IGA1_FIFO_THRESHOLD_FORMULA(x)                      (x/4)
+#define IGA1_DISPLAY_QUEUE_EXPIRE_NUM_FORMULA(x)            (x/4)
+#define IGA1_FIFO_HIGH_THRESHOLD_FORMULA(x)                 (x/4)
+#define IGA2_FIFO_DEPTH_SELECT_FORMULA(x)                   ((x/2)/4)-1
+#define IGA2_FIFO_THRESHOLD_FORMULA(x)                      (x/4)
+#define IGA2_DISPLAY_QUEUE_EXPIRE_NUM_FORMULA(x)            (x/4)
+#define IGA2_FIFO_HIGH_THRESHOLD_FORMULA(x)                 (x/4)
+
+/***********************************************************************=
*/
+/*  LCD Timing                                                          =
*/
+/***********************************************************************=
*/
+#define LCD_POWER_SEQ_TD0               500000         /* 500 ms =3D =
500000 us */
+#define LCD_POWER_SEQ_TD1               50000          /* 50 ms =3D =
50000 us */
+#define LCD_POWER_SEQ_TD2               0              /* 0 us */
+#define LCD_POWER_SEQ_TD3               210000         /* 210 ms =3D =
210000 us */
+
+#define CLE266_POWER_SEQ_UNIT           71             /* 2^10 * =
(1/14.31818M) =3D 71.475 us (K400.revA) */
+#define K800_POWER_SEQ_UNIT             142            /* 2^11 * =
(1/14.31818M) =3D 142.95 us (K400.revB) */
+#define P880_POWER_SEQ_UNIT             572            /* 2^13 * =
(1/14.31818M) =3D 572.1 us */
+
+#define CLE266_POWER_SEQ_FORMULA(x)     (x)/CLE266_POWER_SEQ_UNIT
+#define K800_POWER_SEQ_FORMULA(x)       (x)/K800_POWER_SEQ_UNIT
+#define P880_POWER_SEQ_FORMULA(x)       (x)/P880_POWER_SEQ_UNIT
+
+
+#define LCD_POWER_SEQ_TD0_REG_NUM       2   /* location: =
{CR8B,0,7},{CR8F,0,3} */
+#define LCD_POWER_SEQ_TD1_REG_NUM       2   /* location: =
{CR8C,0,7},{CR8F,4,7} */
+#define LCD_POWER_SEQ_TD2_REG_NUM       2   /* location: =
{CR8D,0,7},{CR90,0,3} */
+#define LCD_POWER_SEQ_TD3_REG_NUM       2   /* location: =
{CR8E,0,7},{CR90,4,7} */
+
+
+/* LCD Scaling factor */
+/* x: indicate setting horizontal size */
+/* y: indicate panel horizontal size */
+
+#define CLE266_LCD_HOR_SCF_FORMULA(x,y)   (((x-1)*1024)/(y-1))    /* =
Horizontal scaling factor 10 bits (2^10) */
+#define CLE266_LCD_VER_SCF_FORMULA(x,y)   (((x-1)*1024)/(y-1))    /* =
Vertical scaling factor 10 bits (2^10) */
+#define K800_LCD_HOR_SCF_FORMULA(x,y)     (((x-1)*4096)/(y-1))    /* =
Horizontal scaling factor 10 bits (2^12) */
+#define K800_LCD_VER_SCF_FORMULA(x,y)     (((x-1)*2048)/(y-1))    /* =
Vertical scaling factor 10 bits (2^11) */
+
+#define LCD_HOR_SCALING_FACTOR_REG_NUM  3   /* location: =
{CR9F,0,1},{CR77,0,7},{CR79,4,5} */
+#define LCD_VER_SCALING_FACTOR_REG_NUM  3   /* location: =
{CR79,3,3},{CR78,0,7},{CR79,6,7} */
+#define LCD_HOR_SCALING_FACTOR_REG_NUM_CLE  2               /* =
location: {CR77,0,7},{CR79,4,5} */
+#define LCD_VER_SCALING_FACTOR_REG_NUM_CLE  2               /* =
location: {CR78,0,7},{CR79,6,7} */
+
+
+
+/************************************************/
+/*      Define IGA1 Display Timing              */
+/************************************************/
+struct io_register {
+    u8      io_addr;
+    u8      start_bit;
+    u8      end_bit;
+};
+
+
+/* IGA1 Horizontal Total */
+struct iga1_hor_total
+{
+    int     reg_num;
+    struct  io_register reg[IGA1_HOR_TOTAL_REG_NUM];
+};
+
+/* IGA1 Horizontal Addressable Video */
+struct iga1_hor_addr {
+    int     reg_num;
+    struct  io_register reg[IGA1_HOR_ADDR_REG_NUM];
+};
+
+/* IGA1 Horizontal Blank Start */
+struct iga1_hor_blank_start {
+    int     reg_num;
+    struct  io_register reg[IGA1_HOR_BLANK_START_REG_NUM];
+};
+
+/* IGA1 Horizontal Blank End */
+struct iga1_hor_blank_end {
+    int     reg_num;
+    struct  io_register reg[IGA1_HOR_BLANK_END_REG_NUM];
+};
+
+/* IGA1 Horizontal Sync Start */
+struct iga1_hor_sync_start {
+    int     reg_num;
+    struct  io_register reg[IGA1_HOR_SYNC_START_REG_NUM];
+};
+
+/* IGA1 Horizontal Sync End */
+struct iga1_hor_sync_end {
+    int     reg_num;
+    struct  io_register reg[IGA1_HOR_SYNC_END_REG_NUM];
+};
+
+/* IGA1 Vertical Total */
+struct iga1_ver_total {
+    int     reg_num;
+    struct  io_register reg[IGA1_VER_TOTAL_REG_NUM];
+};
+
+/* IGA1 Vertical Addressable Video */
+struct iga1_ver_addr {
+    int     reg_num;
+    struct  io_register reg[IGA1_VER_ADDR_REG_NUM];
+};
+
+/* IGA1 Vertical Blank Start */
+struct iga1_ver_blank_start {
+    int     reg_num;
+    struct  io_register reg[IGA1_VER_BLANK_START_REG_NUM];
+};
+
+/* IGA1 Vertical Blank End */
+struct iga1_ver_blank_end {
+    int     reg_num;
+    struct  io_register reg[IGA1_VER_BLANK_END_REG_NUM];
+};
+
+/* IGA1 Vertical Sync Start */
+struct iga1_ver_sync_start {
+    int     reg_num;
+    struct  io_register reg[IGA1_VER_SYNC_START_REG_NUM];
+};
+
+/* IGA1 Vertical Sync End */
+struct iga1_ver_sync_end {
+    int     reg_num;
+    struct  io_register reg[IGA1_VER_SYNC_END_REG_NUM];
+};
+
+/************************************************/
+/*      Define IGA2 Shadow Display Timing       */
+/************************************************/
+
+/* IGA2 Shadow Horizontal Total */
+struct iga2_shadow_hor_total
+{
+    int     reg_num;
+    struct  io_register reg[IGA2_SHADOW_HOR_TOTAL_REG_NUM];
+};
+
+/* IGA2 Shadow Horizontal Blank End */
+struct iga2_shadow_hor_blank_end {
+    int     reg_num;
+    struct  io_register reg[IGA2_SHADOW_HOR_BLANK_END_REG_NUM];
+};
+
+
+/* IGA2 Shadow Vertical Total */
+struct iga2_shadow_ver_total {
+    int     reg_num;
+    struct  io_register reg[IGA2_SHADOW_VER_TOTAL_REG_NUM];
+};
+
+/* IGA2 Shadow Vertical Addressable Video */
+struct iga2_shadow_ver_addr {
+    int     reg_num;
+    struct  io_register reg[IGA2_SHADOW_VER_ADDR_REG_NUM];
+};
+
+/* IGA2 Shadow Vertical Blank Start */
+struct iga2_shadow_ver_blank_start {
+    int     reg_num;
+    struct  io_register reg[IGA2_SHADOW_VER_BLANK_START_REG_NUM];
+};
+
+/* IGA2 Shadow Vertical Blank End */
+struct iga2_shadow_ver_blank_end {
+    int     reg_num;
+    struct  io_register reg[IGA2_SHADOW_VER_BLANK_END_REG_NUM];
+};
+
+/* IGA2 Shadow Vertical Sync Start */
+struct iga2_shadow_ver_sync_start {
+    int     reg_num;
+    struct  io_register reg[IGA2_SHADOW_VER_SYNC_START_REG_NUM];
+};
+
+/* IGA2 Shadow Vertical Sync End */
+struct iga2_shadow_ver_sync_end {
+    int     reg_num;
+    struct  io_register reg[IGA2_SHADOW_VER_SYNC_END_REG_NUM];
+};
+
+/************************************************/
+/*      Define IGA2 Display Timing              */
+/************************************************/
+
+/* IGA2 Horizontal Total */
+struct iga2_hor_total {
+    int     reg_num;
+    struct  io_register reg[IGA2_HOR_TOTAL_REG_NUM];
+};
+
+/* IGA2 Horizontal Addressable Video */
+struct iga2_hor_addr {
+    int     reg_num;
+    struct  io_register reg[IGA2_HOR_ADDR_REG_NUM];
+};
+
+/* IGA2 Horizontal Blank Start */
+struct iga2_hor_blank_start {
+    int     reg_num;
+    struct  io_register reg[IGA2_HOR_BLANK_START_REG_NUM];
+};
+
+/* IGA2 Horizontal Blank End */
+struct iga2_hor_blank_end {
+    int     reg_num;
+    struct  io_register reg[IGA2_HOR_BLANK_END_REG_NUM];
+};
+
+/* IGA2 Horizontal Sync Start */
+struct iga2_hor_sync_start {
+    int     reg_num;
+    struct  io_register reg[IGA2_HOR_SYNC_START_REG_NUM];
+};
+
+/* IGA2 Horizontal Sync End */
+struct iga2_hor_sync_end {
+    int     reg_num;
+    struct  io_register reg[IGA2_HOR_SYNC_END_REG_NUM];
+};
+
+/* IGA2 Vertical Total */
+struct iga2_ver_total {
+    int     reg_num;
+    struct  io_register reg[IGA2_VER_TOTAL_REG_NUM];
+};
+
+/* IGA2 Vertical Addressable Video */
+struct iga2_ver_addr {
+    int     reg_num;
+    struct  io_register reg[IGA2_VER_ADDR_REG_NUM];
+};
+
+/* IGA2 Vertical Blank Start */
+struct iga2_ver_blank_start {
+    int     reg_num;
+    struct  io_register reg[IGA2_VER_BLANK_START_REG_NUM];
+};
+
+/* IGA2 Vertical Blank End */
+struct iga2_ver_blank_end {
+    int     reg_num;
+    struct  io_register reg[IGA2_VER_BLANK_END_REG_NUM];
+};
+
+/* IGA2 Vertical Sync Start */
+struct iga2_ver_sync_start {
+    int     reg_num;
+    struct  io_register reg[IGA2_VER_SYNC_START_REG_NUM];
+};
+
+/* IGA2 Vertical Sync End */
+struct iga2_ver_sync_end {
+    int     reg_num;
+    struct  io_register reg[IGA2_VER_SYNC_END_REG_NUM];
+};
+
+/* IGA1 Offset Register */
+struct iga1_offset {
+    int     reg_num;
+    struct  io_register reg[IGA1_OFFSET_REG_NUM];
+};
+
+/* IGA2 Offset Register */
+struct iga2_offset {
+    int     reg_num;
+    struct  io_register reg[IGA2_OFFSET_REG_NUM];
+};
+
+struct offset{
+    struct iga1_offset            iga1_offset_reg;
+    struct iga2_offset            iga2_offset_reg;
+};
+
+/* IGA1 Fetch Count Register */
+struct iga1_fetch_count {
+    int     reg_num;
+    struct  io_register reg[IGA1_FETCH_COUNT_REG_NUM];
+};
+
+/* IGA2 Fetch Count Register */
+struct iga2_fetch_count {
+    int     reg_num;
+    struct  io_register reg[IGA2_FETCH_COUNT_REG_NUM];
+};
+
+struct fetch_count{
+    struct iga1_fetch_count       iga1_fetch_count_reg;
+    struct iga2_fetch_count       iga2_fetch_count_reg;
+};
+
+/* Starting Address Register */
+struct iga1_starting_addr {
+    int     reg_num;
+    struct  io_register reg[IGA1_STARTING_ADDR_REG_NUM];
+};
+
+struct iga2_starting_addr {
+    int     reg_num;
+    struct  io_register reg[IGA2_STARTING_ADDR_REG_NUM];
+};
+
+struct starting_addr {
+    struct iga1_starting_addr       iga1_starting_addr_reg;
+    struct iga2_starting_addr       iga2_starting_addr_reg;
+};
+
+/* LCD Power Sequence Timer */
+struct lcd_pwd_seq_td0{
+    int     reg_num;
+    struct  io_register reg[LCD_POWER_SEQ_TD0_REG_NUM];
+};
+
+struct lcd_pwd_seq_td1{
+    int     reg_num;
+    struct  io_register reg[LCD_POWER_SEQ_TD1_REG_NUM];
+};
+
+struct lcd_pwd_seq_td2{
+    int     reg_num;
+    struct  io_register reg[LCD_POWER_SEQ_TD2_REG_NUM];
+};
+
+struct lcd_pwd_seq_td3{
+    int     reg_num;
+    struct  io_register reg[LCD_POWER_SEQ_TD3_REG_NUM];
+};
+
+struct _lcd_pwd_seq_timer{
+    struct lcd_pwd_seq_td0       td0;
+    struct lcd_pwd_seq_td1       td1;
+    struct lcd_pwd_seq_td2       td2;
+    struct lcd_pwd_seq_td3       td3;
+};
+
+/* LCD Scaling Factor */
+struct _lcd_hor_scaling_factor{
+    int     reg_num;
+    struct  io_register reg[LCD_HOR_SCALING_FACTOR_REG_NUM];
+};
+
+struct _lcd_ver_scaling_factor{
+    int     reg_num;
+    struct  io_register reg[LCD_VER_SCALING_FACTOR_REG_NUM];
+};
+
+
+struct _lcd_scaling_factor{
+    struct _lcd_hor_scaling_factor  lcd_hor_scaling_factor;
+    struct _lcd_ver_scaling_factor  lcd_ver_scaling_factor;
+};
+
+struct pll_map {
+    u32     clk;
+    u32     cle266_pll;
+    u32     k800_pll;
+    u32     cx700_pll;
+};
+
+struct rgbLUT {
+    u8     red;
+    u8     green;
+    u8     blue;
+};
+
+struct lcd_pwd_seq_timer {
+    u16     td0;
+    u16     td1;
+    u16     td2;
+    u16     td3;
+};
+
+
+/* Display FIFO Relation Registers */
+struct iga1_fifo_depth_select {
+    int     reg_num;
+    struct  io_register reg[IGA1_FIFO_DEPTH_SELECT_REG_NUM];
+};
+
+struct iga1_fifo_threshold_select {
+    int     reg_num;
+    struct  io_register reg[IGA1_FIFO_THRESHOLD_REG_NUM];
+};
+
+struct iga1_fifo_high_threshold_select {
+    int     reg_num;
+    struct  io_register reg[IGA1_FIFO_HIGH_THRESHOLD_REG_NUM];
+};
+
+struct iga1_display_queue_expire_num {
+    int     reg_num;
+    struct  io_register reg[IGA1_DISPLAY_QUEUE_EXPIRE_NUM_REG_NUM];
+};
+
+struct iga2_fifo_depth_select {
+    int     reg_num;
+    struct  io_register reg[IGA2_FIFO_DEPTH_SELECT_REG_NUM];
+};
+
+struct iga2_fifo_threshold_select {
+    int     reg_num;
+    struct  io_register reg[IGA2_FIFO_THRESHOLD_REG_NUM];
+};
+
+struct iga2_fifo_high_threshold_select {
+    int     reg_num;
+    struct  io_register reg[IGA2_FIFO_HIGH_THRESHOLD_REG_NUM];
+};
+
+struct iga2_display_queue_expire_num {
+    int     reg_num;
+    struct  io_register reg[IGA2_DISPLAY_QUEUE_EXPIRE_NUM_REG_NUM];
+};
+
+struct fifo_depth_select {
+    struct  iga1_fifo_depth_select iga1_fifo_depth_select_reg;
+    struct  iga2_fifo_depth_select iga2_fifo_depth_select_reg;
+};
+
+struct fifo_threshold_select {
+    struct  iga1_fifo_threshold_select iga1_fifo_threshold_select_reg;
+    struct  iga2_fifo_threshold_select iga2_fifo_threshold_select_reg;
+};
+
+struct fifo_high_threshold_select {
+    struct  iga1_fifo_high_threshold_select =
iga1_fifo_high_threshold_select_reg;
+    struct  iga2_fifo_high_threshold_select =
iga2_fifo_high_threshold_select_reg;
+};
+
+struct display_queue_expire_num {
+    struct  iga1_display_queue_expire_num =
iga1_display_queue_expire_num_reg;
+    struct  iga2_display_queue_expire_num =
iga2_display_queue_expire_num_reg;
+};
+
+
+
+struct iga1_crtc_timing {
+    struct iga1_hor_total         hor_total;
+    struct iga1_hor_addr          hor_addr;
+    struct iga1_hor_blank_start   hor_blank_start;
+    struct iga1_hor_blank_end     hor_blank_end;
+    struct iga1_hor_sync_start    hor_sync_start;
+    struct iga1_hor_sync_end      hor_sync_end;
+    struct iga1_ver_total         ver_total;
+    struct iga1_ver_addr          ver_addr;
+    struct iga1_ver_blank_start   ver_blank_start;
+    struct iga1_ver_blank_end     ver_blank_end;
+    struct iga1_ver_sync_start    ver_sync_start;
+    struct iga1_ver_sync_end      ver_sync_end;
+};
+
+struct iga2_shadow_crtc_timing {
+    struct iga2_shadow_hor_total        hor_total_shadow;
+    struct iga2_shadow_hor_blank_end    hor_blank_end_shadow;
+    struct iga2_shadow_ver_total        ver_total_shadow;
+    struct iga2_shadow_ver_addr         ver_addr_shadow;
+    struct iga2_shadow_ver_blank_start  ver_blank_start_shadow;
+    struct iga2_shadow_ver_blank_end    ver_blank_end_shadow;
+    struct iga2_shadow_ver_sync_start   ver_sync_start_shadow;
+    struct iga2_shadow_ver_sync_end     ver_sync_end_shadow;
+};
+
+struct iga2_crtc_timing {
+    struct iga2_hor_total         hor_total;
+    struct iga2_hor_addr          hor_addr;
+    struct iga2_hor_blank_start   hor_blank_start;
+    struct iga2_hor_blank_end     hor_blank_end;
+    struct iga2_hor_sync_start    hor_sync_start;
+    struct iga2_hor_sync_end      hor_sync_end;
+    struct iga2_ver_total         ver_total;
+    struct iga2_ver_addr          ver_addr;
+    struct iga2_ver_blank_start   ver_blank_start;
+    struct iga2_ver_blank_end     ver_blank_end;
+    struct iga2_ver_sync_start    ver_sync_start;
+    struct iga2_ver_sync_end      ver_sync_end;
+};
+
+/* Copied from X driver code */
+/* used by get video memory size */
+/* device ID */
+#define CLE266              0x3123
+#define KM400               0x3205
+#define CN400_FUNCTION2     0x2259
+#define CN400_FUNCTION3     0x3259
+/* support VT3314 chipset */
+#define CN900_FUNCTION2     0x2314
+#define CN900_FUNCTION3     0x3208
+/* VT3324 chipset */
+#define CX700_FUNCTION2     0x2324
+#define CX700_FUNCTION3     0x3324
+/* VT3204 chipset*/
+#define KM800_FUNCTION3      0x3204
+/* VT3336 chipset*/
+#define KM890_FUNCTION3      0x3336
+/* VT3327 chipset*/
+#define P4M890_FUNCTION3     0x3327
+/* VT3293 chipset*/
+#define CN750_FUNCTION3     0x3208
+/* VT3364 chipset*/
+#define P4M900_FUNCTION3    0x3364
+
+typedef struct IODATA {
+    u8   Index;
+    u8   Mask;
+    u8   Data;
+}IODATA, *IODATAPTR;
+
+#endif /* __HW_H__ */
+
+
+
+
diff -Nur linux-2.6.21-rc7/drivers/video/via/iface.c =
linux-2.6.21-rc7.viafb/drivers/video/via/iface.c
--- linux-2.6.21-rc7/drivers/video/via/iface.c 1969-12-31 =
19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/iface.c 2007-04-26 =
19:52:32.000000000 -0400
@@ -0,0 +1,90 @@
+ /*
+ * Copyright 1998-2007 VIA Technologies, Inc. All Rights Reserved.
+ * Copyright 2001-2007 S3 Graphics, Inc. All Rights Reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person =
obtaining a
+ * copy of this software and associated documentation files (the =
"Software"),
+ * to deal in the Software without restriction, including without =
limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sub =
license,
+ * and/or sell copies of the Software, and to permit persons to whom =
the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the
+ * next paragraph) shall be included in all copies or substantial =
portions
+ * of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, =
EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF =
MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT =
SHALL
+ * THE AUTHOR(S) OR COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, =
DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR =
OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE =
OR OTHER
+ * DEALINGS IN THE SOFTWARE.
+ */
+=20
+
+#include <linux/ioport.h>
+#include <linux/pci.h>
+#include <asm/io.h>
+
+#include "iface.h"
+#include "debug.h"
+#include "share.h"
+
+/* Get frame buffer size from VGA BIOS */
+extern inline u8 read_reg(int io_port, u8 index);
+extern  int memsize;
+
+unsigned int get_memsize(void)
+{
+    unsigned int m;
+
+        /* If memory size provided by user */
+    if (memsize)
+        m =3D memsize * Mb;
+    else
+    {
+        m =3D (unsigned int) read_reg(VIASR, SR39);=20
+        m =3D m*(4*Mb);
+       =20
+        if((m < (16*Mb)) || (m > (64*Mb)))
+            m =3D 16*Mb;
+    }
+    DEBUG_MSG(KERN_INFO "framebuffer size =3D %d Mb\n", m/Mb);
+    return m;
+}
+
+/* Get Video Buffer Starting Physical Address(back door) */
+
+unsigned long get_videobuf_addr(void)
+{
+    struct pci_dev *pdev=3DNULL;
+    unsigned char  sys_mem;
+    unsigned char  video_mem;
+    unsigned long  sys_mem_size;
+    unsigned long  video_mem_size;
+    unsigned long  vmem_starting_adr =3D 0x0C000000; /* system memory =
=3D 256 MB, video memory 64 MB */
+
+    pdev =3D (struct pci_dev *)pci_find_device(VIA_K800_BRIDGE_VID, =
VIA_K800_BRIDGE_DID, NULL);
+    if (pdev !=3D NULL)
+    {
+        pci_read_config_byte(pdev, VIA_K800_SYSTEM_MEMORY_REG, =
&sys_mem);
+        pci_read_config_byte(pdev, VIA_K800_VIDEO_MEMORY_REG, =
&video_mem);
+        video_mem =3D (video_mem & 0x70) >> 4;
+        sys_mem_size =3D ((unsigned long)sys_mem) << 24;
+        if (video_mem !=3D 0)
+            video_mem_size =3D (1 << (video_mem)) *1024*1024;
+        else
+            video_mem_size =3D 0;
+
+        vmem_starting_adr =3D sys_mem_size - video_mem_size;
+
+    }
+
+    DEBUG_MSG(KERN_INFO "Video Memory Starting Address =3D %lx \n", =
vmem_starting_adr);
+    return vmem_starting_adr;
+}
+
+
+
+
diff -Nur linux-2.6.21-rc7/drivers/video/via/iface.h =
linux-2.6.21-rc7.viafb/drivers/video/via/iface.h
--- linux-2.6.21-rc7/drivers/video/via/iface.h 1969-12-31 =
19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/iface.h 2007-04-26 =
19:52:32.000000000 -0400
@@ -0,0 +1,15 @@
+#ifndef __IFACE_H__
+#define __IFACE_H__
+
+#define Kb  (1024)
+#define Mb  (Kb*Kb)
+
+#define VIA_K800_BRIDGE_VID         0x1106
+#define VIA_K800_BRIDGE_DID         0x3204
+
+#define VIA_K800_SYSTEM_MEMORY_REG  0x47
+#define VIA_K800_VIDEO_MEMORY_REG   0xA1
+
+#endif /* __IFACE_H__ */
+
+
diff -Nur linux-2.6.21-rc7/drivers/video/via/IntegratedTV.c =
linux-2.6.21-rc7.viafb/drivers/video/via/IntegratedTV.c
--- linux-2.6.21-rc7/drivers/video/via/IntegratedTV.c 1969-12-31 =
19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/IntegratedTV.c 2007-04-26 =
19:52:32.000000000 -0400
@@ -0,0 +1,1448 @@
+/*
+ * Copyright 1998-2007 VIA Technologies, Inc. All Rights Reserved.
+ * Copyright 2001-2007 S3 Graphics, Inc. All Rights Reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person =
obtaining a
+ * copy of this software and associated documentation files (the =
"Software"),
+ * to deal in the Software without restriction, including without =
limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sub =
license,
+ * and/or sell copies of the Software, and to permit persons to whom =
the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the
+ * next paragraph) shall be included in all copies or substantial =
portions
+ * of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, =
EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF =
MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT =
SHALL
+ * THE AUTHOR(S) OR COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, =
DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR =
OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE =
OR OTHER
+ * DEALINGS IN THE SOFTWARE.
+ */
+=20
+#include <linux/ioport.h>
+#include <asm/io.h>
+#include <linux/fb.h>
+
+#include "viafbdev.h"
+#include "tv.h"
+#include "share.h"
+#include "chip.h"
+#include "debug.h"
+#include "tblIntegratedTV.h"
+#include "IntegratedTV.h"
+#include "ioctl.h"
+
+extern struct tv_setting_information    tv_setting_info;
+extern struct chip_information          chip_info;
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+extern struct viafb_info    viafbinfo;
+#else
+extern struct viafb_par     parinfo;
+#endif
+
+extern inline void write_reg(u8 index, u16 io_port, u8 data);
+extern inline u8 read_reg(int io_port, u8 index);
+extern void write_reg_mask(u8 index, int io_port, u8 data, u8 mask);
+extern void enable_second_display_channel(void);
+extern void plus_vck_to_iga1_timing(unsigned long h_total);
+extern void delays(int count);
+extern void load_crtc_timing(struct display_timing device_timing, int =
set_iga);
+
+bool g_first_time_to_sense =3D TRUE;
+
+void enable_integrated_tv_shadow_reg(void)
+{
+    int i;
+
+    /* Enable integrated TV shadow register. */
+    /* Only for A0000 now, we may modify this if need other TV shadow =
memory. */
+    write_reg(SR52, VIASR, 0x01);
+
+    /* Wait data ready. */
+    for (i=3D0; i<10; i++)
+    {
+        if (read_reg(VIASR, SR52) & BIT0)
+        {
+            break;
+        }
+    }
+}
+
+
+void disable_integrated_tv_shadow_reg(void)
+{
+    write_reg(SR52, VIASR, 0x00);
+} =20
+
+
+void write_integrated_tv_reg8(unsigned char* mmio_base, u8 offset, u8 =
data)
+{
+    *(volatile u8 *)(mmio_base + offset) =3D data;
+    DEBUG_MSG(KERN_INFO "Write Integrated TV Reg (byte): Offset 0x%2x, =
Value 0x%2x!\n", offset, data);
+}
+
+
+void write_integrated_tv_reg32(unsigned char* mmio_base, u8 offset, u32 =
data)
+{
+    *(volatile u32 *)(mmio_base + offset) =3D data;
+    DEBUG_MSG(KERN_INFO "Write Integrated TV Reg: Offset 0x%2x, Value =
0x%8x!\n", offset, data);
+}
+
+
+void write_integrated_tv_reg_mask32(unsigned char* mmio_base, u8 =
offset, u32 mask, u32 data)
+{
+    u32 old_data, new_data;
+
+    old_data =3D *(volatile u32 *)(mmio_base + offset);
+    new_data =3D (data & mask) | (old_data & (~mask));
+    *(volatile u32 *)(mmio_base + offset) =3D new_data;
+
+    DEBUG_MSG(KERN_INFO "Write Integrated TV Reg Mask: Offset 0x%2x, =
Value 0x%8x!\n", offset, new_data);
+}
+
+
+u32 read_integrated_tv_reg32(unsigned char* mmio_base, u8 offset)
+{
+    u32 data;
+
+    data =3D *(volatile u32 *)(mmio_base + offset);
+
+    return data;
+}
+
+
+void write_integrated_tv_general_table(unsigned short =
*tv_reg_offset_table, unsigned long *tv_reg_table)
+{
+    int i =3D 0;
+    unsigned char* mmio_base;
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+    mmio_base =3D (unsigned char*)viafbinfo.integrated_tv_map_base;
+#else
+    mmio_base =3D (unsigned char*)parinfo.integrated_tv_map_base;
+#endif
+
+    while(tv_reg_offset_table[i] !=3D 0xFFFF)
+    {
+        write_integrated_tv_reg32(mmio_base, =
GET_LOW_BYTE(tv_reg_offset_table[i]), tv_reg_table[i]);
+        i++;
+    }
+}
+
+
+void write_integrated_tv_patch_table(u16 *tv_reg_table)
+{
+    int i =3D 0;
+    unsigned char* mmio_base;
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+    mmio_base =3D (unsigned char*)viafbinfo.integrated_tv_map_base;
+#else
+    mmio_base =3D (unsigned char*)parinfo.integrated_tv_map_base;
+#endif
+   =20
+    while(tv_reg_table[i] !=3D 0xFFFF)
+    {
+        write_integrated_tv_reg8(mmio_base, =
GET_LOW_BYTE(tv_reg_table[i]), GET_HIGH_BYTE(tv_reg_table[i]));
+        i++;
+    }
+}
+
+
+u32 access_integrated_tv_regs(int reg_id, u32 value, int cmd)
+{
+    u8 offset;
+    u32 mask, set_data, get_data, shift_bits, tmp1, tmp2;
+    unsigned char* mmio_base;
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+    mmio_base =3D (unsigned char*)viafbinfo.integrated_tv_map_base;
+#else
+    mmio_base =3D (unsigned char*)parinfo.integrated_tv_map_base;
+#endif
+
+    /* Note: It's better to call enable_integrated_tv_shadow_reg() to =
enable integrated TV shadow register */
+    /* before access the following registers, or it may fail to access =
them. */
+   =20
+    switch (reg_id)
+    {
+        case ITV_REG_ID_PK_ENABLE:
+        {
+            /* 00[0] */
+            offset =3D 0x00;
+            mask =3D 0x00000001;
+            shift_bits =3D 0;
+
+            break;
+        }
+
+        case ITV_REG_ID_SRC_SEL:
+        {
+            /* 00[18] */
+            offset =3D 0x00;
+            mask =3D 0x00040000;
+            shift_bits =3D 18;
+           =20
+            break;
+        }
+
+        case ITV_REG_ID_SW_RESET:
+        {
+            /* 00[20] */
+            offset =3D 0x00;
+            mask =3D 0x00100000;
+            shift_bits =3D 20;
+           =20
+            break;
+        }
+
+        case ITV_REG_ID_SYNC_BUF_MODE:
+        {
+            /* 00[30] */
+            offset =3D 0x00;
+            mask =3D 0x40000000;
+            shift_bits =3D 30;
+           =20
+            break;
+        }
+
+        case ITV_REG_ID_SD_ENABLE:
+        {
+            /* 00[31] */
+            offset =3D 0x00;
+            mask =3D 0x80000000;
+            shift_bits =3D 31;
+           =20
+            break;
+        }
+
+        case ITV_REG_ID_SRC_VSIZE:
+        {
+            /* 18[10:0] */
+            offset =3D 0x18;
+            mask =3D 0x000007FF;
+            shift_bits =3D 0;
+           =20
+            break;
+        }
+
+        case ITV_REG_ID_SRC_HSIZE:
+        {
+            /* 18[21:11] */
+            offset =3D 0x18;
+            mask =3D 0x003FF800;
+            shift_bits =3D 11;
+           =20
+            break;
+        }
+
+        case ITV_REG_ID_DE_FLK_THRESHOLD:
+        {
+            /* 20[31:27] + 20[15:11] */
+            offset =3D 0x20;
+               =20
+            if (cmd =3D=3D ITV_CMD_WRITE)
+            {
+                tmp1 =3D value & 0x1F;        /* bit4-bit0 */
+                tmp2 =3D (value >> 5) & 0x1F; /* bit9-bit5 */
+                set_data =3D (tmp2 << 27) | (tmp1 << 11);
+                write_integrated_tv_reg_mask32(mmio_base, offset, =
0xF800F800, set_data);
+               =20
+                return 0;  /* 0 means nothing, just for return. */
+            }
+            else
+            {
+                get_data =3D read_integrated_tv_reg32(mmio_base, =
offset);
+                tmp1 =3D (get_data & 0x0000F800) >> 11;   /* bit4-bit0 =
*/
+                tmp2 =3D (get_data & 0xF8000000) >> 27;   /* bit9-bit5 =
*/
+                get_data =3D (tmp2 << 5) | tmp1;
+
+                return get_data;
+            }
+        }
+       =20
+        case ITV_REG_ID_SCL_VFAC:
+        {
+            /* 24[12:0] */
+            offset =3D 0x24;
+            mask =3D 0x00001FFF;
+            shift_bits =3D 0;
+           =20
+            break;
+        }
+
+        case ITV_REG_ID_DE_FLK_NUM:
+        {
+            /* 24[13] */
+            offset =3D 0x24;
+            mask =3D 0x00002000;
+            shift_bits =3D 13;
+           =20
+            break;
+        }
+       =20
+        case ITV_REG_ID_DF_WT_SEL:
+        {
+            /* 24[14] */
+            offset =3D 0x24;
+            mask =3D 0x00004000;
+            shift_bits =3D 14;
+           =20
+            break;
+        }
+
+        case ITV_REG_ID_DF_TYPE:
+        {
+            /* 24[15] */
+            offset =3D 0x24;
+            mask =3D 0x00008000;
+            shift_bits =3D 15;
+           =20
+            break;
+        }
+       =20
+        case ITV_REG_ID_DE_FLICKER_ENABLE:
+        {
+            /* 24[29] */
+            offset =3D 0x24;
+            mask =3D 0x20000000;
+            shift_bits =3D 29;
+           =20
+            break;
+        }
+       =20
+        case ITV_REG_ID_SCL_HFAC:
+        {
+            /* 24[28:16] */
+            offset =3D 0x24;
+            mask =3D 0x1FFF0000;
+            shift_bits =3D 16;
+           =20
+            break;
+        }
+
+        case ITV_REG_ID_DST_VSIZE:
+        {
+            /* 28[10:0] */
+            offset =3D 0x28;
+            mask =3D 0x000007FF;
+            shift_bits =3D 0;
+           =20
+            break;
+        }
+
+        case ITV_REG_ID_DST_HSIZE:
+        {
+            /* 28[21:11] */
+            offset =3D 0x28;
+            mask =3D 0x003FF800;
+            shift_bits =3D 11;
+           =20
+            break;
+        }
+
+        case ITV_REG_ID_TV_ENABLE:
+        {
+            /* 38[0] */
+            offset =3D 0x38;
+            mask =3D 0x00000001;
+            shift_bits =3D 0;
+
+            break;
+        }
+
+        case ITV_REG_ID_OUTPUT_SEL:
+        {
+            /* 38[29:28] */
+            offset =3D 0x38;
+            mask =3D 0x30000000;
+            shift_bits =3D 28;
+
+            break;
+        }
+
+        case ITV_REG_ID_TV_SENSE:
+        {
+            /* 3C[15:14] */
+            offset =3D 0x3C;
+            mask =3D 0x0000C000;
+            shift_bits =3D 14;
+           =20
+            break;
+        }
+       =20
+        case ITV_REG_ID_TV_SENSE_DATA:
+        {
+            /* 3C[31:24] */
+            offset =3D 0x3C;
+            mask =3D 0xFF000000;
+            shift_bits =3D 24;
+           =20
+            break;
+        }
+       =20
+        case ITV_REG_ID_DST_HSD:
+        {
+            /* 48[30:21] */
+            offset =3D 0x48;
+            mask =3D 0x7FE00000;
+            shift_bits =3D 21;
+
+            break;
+        }
+
+        case ITV_REG_ID_DST_VSD:
+        {
+            /* 4C[31:23] */
+            offset =3D 0x4C;
+            mask =3D 0xFF800000;
+            shift_bits =3D 23;
+
+            break;
+        }
+
+        case ITV_REG_ID_SATURATION:
+        {
+            /* 50[8:0] + 50[24:16] */
+            offset =3D 0x50;
+               =20
+            if (cmd =3D=3D ITV_CMD_WRITE)
+            {
+                tmp1 =3D value & 0x1FF;        /* bit8-bit0 */
+                tmp2 =3D (value >> 9) & 0x1FF; /* bit24-bit16 */
+                set_data =3D ((tmp2 << 16) | (tmp1));
+                write_integrated_tv_reg_mask32(mmio_base, offset, =
0x01FF01FF, set_data);
+               =20
+                return 0;  /* 0 means nothing, just for return. */
+            }
+            else
+            {
+                get_data =3D read_integrated_tv_reg32(mmio_base, =
offset);
+                tmp1 =3D (get_data & 0x000001FF);   /* bit8-bit0 */
+                tmp2 =3D (get_data & 0x01FF0000) >> 16;   /* =
bit24-bit16 */
+                get_data =3D (tmp2 << 9) | tmp1;
+
+                return get_data;
+            }
+        }
+
+        case ITV_REG_ID_CONTRAST:
+        {
+            /* 54[8:0] */
+            offset =3D 0x54;
+            mask =3D 0x000001FF;
+            shift_bits =3D 0;
+            break;
+        }
+       =20
+        case ITV_REG_ID_BLACK_LEVEL:
+        {
+            /* 54[30:23] */
+            offset =3D 0x54;
+            mask =3D 0x7F800000;
+            shift_bits =3D 23;
+            break;
+        }
+
+        case ITV_REG_ID_HUE:
+        {
+            /* 60[10:0] */
+            offset =3D 0x60;
+            mask =3D 0x000007FF;
+            shift_bits =3D 0;
+            break;
+        }
+
+        case ITV_REG_ID_PRI_DAC_SEL:
+        {
+            /* 6C[12] */
+            offset =3D 0x6C;
+            mask =3D 0x00001000;
+            shift_bits =3D 12;
+           =20
+            break;
+        }
+
+        case ITV_REG_ID_TV_SENSE_STATUS:
+        {
+            /* E4[2] */
+            offset =3D 0xE4;
+            mask =3D 0x00000004;
+            shift_bits =3D 2;
+           =20
+            break;
+        }
+
+        case ITV_REG_ID_PBPR_BLANK_LEVEL:
+        {
+            /* E8[8:0] */
+            offset =3D 0xE8;
+            mask =3D 0x000000FF;
+            shift_bits =3D 0;=20
+            break;
+        }
+
+        case ITV_REG_ID_TV_SENSE_RGB_STATUS:
+        {
+            /* E8[30:28] */
+            offset =3D 0xE8;
+            mask =3D 0x70000000;
+            shift_bits =3D 28;
+           =20
+            break;
+        }
+       =20
+        default:
+        {
+            return 0;  /* 0 means nothing, just for return. */
+        }
+    }
+
+    if (cmd =3D=3D ITV_CMD_WRITE)
+    {
+        set_data =3D value << shift_bits;
+        write_integrated_tv_reg_mask32(mmio_base, offset, mask, =
set_data);
+       =20
+        return 0;  /* 0 means nothing, just for return. */
+    }
+    else
+    {
+        get_data =3D read_integrated_tv_reg32(mmio_base, offset);
+        get_data =3D (get_data & mask) >> shift_bits;
+
+        return get_data;
+    }
+}
+
+
+void set_integrated_tv_output_signal(void)
+{
+    u8  sr5e;
+   =20
+    /* HDTV only can use RGB or YPbPr output. */
+    if ((tv_setting_info.system =3D=3D TVTYPE_480P) || =
(tv_setting_info.system =3D=3D TVTYPE_576P) ||
+        (tv_setting_info.system =3D=3D TVTYPE_720P) || =
(tv_setting_info.system =3D=3D TVTYPE_1080I))
+       =20
+    {
+        if ((tv_setting_info.out_signal !=3D TV_OUTPUT_RGB) &&
+            (tv_setting_info.out_signal !=3D TV_OUTPUT_YPBPR))
+        {
+            tv_setting_info.out_signal =3D TV_OUTPUT_RGB;
+        }
+    }
+   =20
+    DEBUG_MSG(KERN_INFO "set_integrated_tv_output_signal: TVOutput =3D =
%d\n", tv_setting_info.out_signal);
+
+    /* We could separate Composite and S-Video by controlling DAC =
R/G/B. */
+    sr5e =3D read_reg(VIASR, SR5E) & 0xF1;    /* Turn on DAC R/G/B. */
+
+    switch (tv_setting_info.out_signal)
+    {
+        case TV_OUTPUT_COMPOSITE:       =20
+        {
+            access_integrated_tv_regs(ITV_REG_ID_OUTPUT_SEL, =
ITV_VALUE_OUTPUT_SC, ITV_CMD_WRITE);
+
+            /* Turn off DAC R and G, turn on DAC B. */
+            write_reg(SR5E, VIASR, sr5e | (BIT1+BIT2));
+            break;
+        }
+
+        case TV_OUTPUT_SVIDEO:
+        {
+            access_integrated_tv_regs(ITV_REG_ID_OUTPUT_SEL, =
ITV_VALUE_OUTPUT_SC, ITV_CMD_WRITE);
+
+            /* Turn on DAC R and G, turn off DAC B. */
+            write_reg(SR5E, VIASR, sr5e | BIT3);
+            break;
+        }
+
+        case TV_OUTPUT_COMPOSITE_SVIDEO:
+        {
+            access_integrated_tv_regs(ITV_REG_ID_OUTPUT_SEL, =
ITV_VALUE_OUTPUT_SC, ITV_CMD_WRITE);
+
+            /* Turn on DAC R/G/B. */
+            write_reg(SR5E, VIASR, sr5e);
+            break;
+        }
+       =20
+        case TV_OUTPUT_RGB:
+        {
+            access_integrated_tv_regs(ITV_REG_ID_OUTPUT_SEL, =
ITV_VALUE_OUTPUT_RGB, ITV_CMD_WRITE);
+
+            /* Turn on DAC R/G/B. */
+            write_reg(SR5E, VIASR, sr5e);
+            break;
+        }
+           =20
+        case TV_OUTPUT_YPBPR:
+        {
+            access_integrated_tv_regs(ITV_REG_ID_OUTPUT_SEL, =
ITV_VALUE_OUTPUT_YPbPr, ITV_CMD_WRITE);
+
+            /* Turn on DAC R/G/B. */
+            write_reg(SR5E, VIASR, sr5e);
+            break;
+        }
+           =20
+        default:
+        {
+            access_integrated_tv_regs(ITV_REG_ID_OUTPUT_SEL, =
ITV_VALUE_OUTPUT_SC, ITV_CMD_WRITE);
+
+            /* Turn off DAC R and G, turn on DAC B. */
+            write_reg(SR5E, VIASR, sr5e | (BIT1+BIT2));
+            break;
+        }
+    }
+}
+
+
+void write_gfx_crtc_timing_for_tv(unsigned long *tv_crtc_table)
+{
+    int i;
+    struct display_timing  tv_crtc_reg;
+   =20
+    for (i=3D0; i< NUM_CRTC_TIMING; i++)
+    {
+        switch(i)
+        {
+            case H_TOTAL_INDEX:
+                tv_crtc_reg.hor_total =3D tv_crtc_table[i];
+                DEBUG_MSG(KERN_INFO "H_Total: %d!\n", =
tv_crtc_reg.hor_total);
+                break;
+               =20
+            case H_ADDR_INDEX:
+                tv_crtc_reg.hor_addr =3D tv_crtc_table[i];
+                DEBUG_MSG(KERN_INFO "H_Addr: %d!\n", =
tv_crtc_reg.hor_addr);
+                break;
+               =20
+            case H_BLANK_START_INDEX:
+                tv_crtc_reg.hor_blank_start =3D tv_crtc_table[i];
+                DEBUG_MSG(KERN_INFO "H_Blank_Start: %d!\n", =
tv_crtc_reg.hor_blank_start);
+                break;
+               =20
+            case H_BLANK_END_INDEX:
+                tv_crtc_reg.hor_blank_end =3D tv_crtc_table[i];
+                DEBUG_MSG(KERN_INFO "H_Blank_End: %d!\n", =
tv_crtc_reg.hor_blank_end);
+                break;
+               =20
+            case H_SYNC_START_INDEX:
+                tv_crtc_reg.hor_sync_start =3D tv_crtc_table[i];
+                DEBUG_MSG(KERN_INFO "H_Sync_Start: %d!\n", =
tv_crtc_reg.hor_sync_start);
+                break;
+               =20
+            case H_SYNC_END_INDEX:
+                tv_crtc_reg.hor_sync_end =3D tv_crtc_table[i];
+                DEBUG_MSG(KERN_INFO "H_Sync_End: %d!\n", =
tv_crtc_reg.hor_sync_end);
+                break;
+               =20
+            case V_TOTAL_INDEX:
+                tv_crtc_reg.ver_total =3D tv_crtc_table[i];
+                break;
+               =20
+            case V_ADDR_INDEX:
+                tv_crtc_reg.ver_addr =3D tv_crtc_table[i];
+                break;
+               =20
+            case V_BLANK_START_INDEX:
+                tv_crtc_reg.ver_blank_start =3D tv_crtc_table[i];
+                break;
+               =20
+            case V_BLANK_END_INDEX:
+                tv_crtc_reg.ver_blank_end =3D tv_crtc_table[i];
+                break;
+               =20
+            case V_SYNC_START_INDEX:
+                tv_crtc_reg.ver_sync_start =3D tv_crtc_table[i];
+                break;
+               =20
+            case V_SYNC_END_INDEX:
+                tv_crtc_reg.ver_sync_end =3D tv_crtc_table[i];
+                break;
+               =20
+        }
+    }
+
+    load_crtc_timing(tv_crtc_reg, tv_setting_info.iga_path);
+}
+
+
+void update_scaling_factor(void)
+{
+    u32 dst_hsize, dst_vsize, src_hsize, src_vsize, scal_factor =3D 0;
+
+    dst_hsize =3D access_integrated_tv_regs(ITV_REG_ID_DST_HSIZE, 0, =
ITV_CMD_READ) + 1;
+    dst_vsize =3D access_integrated_tv_regs(ITV_REG_ID_DST_VSIZE, 0, =
ITV_CMD_READ) + 1;
+    src_hsize =3D access_integrated_tv_regs(ITV_REG_ID_SRC_HSIZE, 0, =
ITV_CMD_READ) + 1;
+    src_vsize =3D access_integrated_tv_regs(ITV_REG_ID_SRC_VSIZE, 0, =
ITV_CMD_READ) + 1;
+
+    if ((tv_setting_info.system =3D=3D TVTYPE_480P) ||
+        (tv_setting_info.system =3D=3D TVTYPE_576P) ||
+        (tv_setting_info.system =3D=3D TVTYPE_1080I))
+    {
+        scal_factor =3D (src_hsize * 2048) / dst_hsize;
+    }
+    else if (tv_setting_info.system =3D=3D TVTYPE_720P)
+    {
+        /* The two modes 720x480 and 720x576 have alignment issue =
(alignment to 4),=20
+           so the value of SRC_LINE_PITCH, DST_DQW_NUM and =
DST_LINE_PITCH
+           we set are greater than the desired ones, and this may cause =
the problem about=20
+           having garbage line on the right side, so we reduce the =
scaling factor to avoid
+           this problem. */
+        if (((src_hsize =3D=3D 720) && (src_vsize =3D=3D 480)) ||
+            ((src_hsize =3D=3D 720) && (src_vsize =3D=3D 576)))
+        {
+            scal_factor =3D ((src_hsize * 2048) / dst_hsize) - 3;
+        }
+        else
+        {
+            scal_factor =3D (src_hsize * 2048) / dst_hsize;
+        }
+    }
+    else
+    {
+        scal_factor =3D (src_hsize * 2048) / (dst_hsize * 2);
+    }
+   =20
+    access_integrated_tv_regs(ITV_REG_ID_SCL_HFAC, scal_factor, =
ITV_CMD_WRITE);
+
+    scal_factor =3D (src_vsize * 2048) / dst_vsize;
+    access_integrated_tv_regs(ITV_REG_ID_SCL_VFAC, scal_factor, =
ITV_CMD_WRITE);
+}
+
+
+void set_hdtv_patch_table(int mode_index)
+{
+    switch(tv_setting_info.system)
+    {
+        case TVTYPE_480P:
+            =
write_integrated_tv_patch_table(ITV_HDTV_PATCH_TABLE[mode_index].std_480p=
);
+            break;
+           =20
+        case TVTYPE_576P:
+            =
write_integrated_tv_patch_table(ITV_HDTV_PATCH_TABLE[mode_index].std_576p=
);
+            break;
+           =20
+        case TVTYPE_720P:
+            =
write_integrated_tv_patch_table(ITV_HDTV_PATCH_TABLE[mode_index].std_720p=
);
+            break;
+           =20
+        case TVTYPE_1080I:
+            =
write_integrated_tv_patch_table(ITV_HDTV_PATCH_TABLE[mode_index].std_1080=
i);
+            break;
+
+        default:
+            break;
+    }
+}
+
+
+void set_tv_output_patch_table(void)
+{
+    if (tv_setting_info.out_signal =3D=3D TV_OUTPUT_RGB)
+    {
+        if (tv_setting_info.system =3D=3D TVTYPE_NTSC)
+        {
+            write_integrated_tv_patch_table(ITV_PATCH_TABLE_RGB_NTSC);
+        }
+        else if (tv_setting_info.system =3D=3D TVTYPE_PAL)
+        {
+            write_integrated_tv_patch_table(ITV_PATCH_TABLE_RGB_PAL);
+        }
+    }
+    else if (tv_setting_info.out_signal =3D=3D TV_OUTPUT_YPBPR)
+    {
+        if (tv_setting_info.system =3D=3D TVTYPE_NTSC)
+        {
+            =
write_integrated_tv_patch_table(ITV_PATCH_TABLE_YPBPR_NTSC);
+        }
+        else if (tv_setting_info.system =3D=3D TVTYPE_PAL)
+        {
+            write_integrated_tv_patch_table(ITV_PATCH_TABLE_YPBPR_PAL);
+        }
+    }
+}
+
+void patch_for_macrovision(void)
+{=20
+    /* We should do this patch for this issue:  */
+    /* The H-sync cycle of VT3324A3 integrated TV disappeared when =
disable TV macrovision. */
+    if (CX700_REVISION_700M2 !=3D chip_info.gfx_chip_revision) /* =
Macrovision disable. */
+    {
+        switch (tv_setting_info.system)
+        {
+            case TVTYPE_NTSC:
+            case TVTYPE_480P:
+                access_integrated_tv_regs(ITV_REG_ID_PBPR_BLANK_LEVEL, =
0x6D, ITV_CMD_WRITE);
+                break;
+               =20
+            case TVTYPE_PAL:
+            case TVTYPE_576P:
+                access_integrated_tv_regs(ITV_REG_ID_PBPR_BLANK_LEVEL, =
0x71, ITV_CMD_WRITE);
+                break;
+
+            case TVTYPE_720P:
+            case TVTYPE_1080I:
+                access_integrated_tv_regs(ITV_REG_ID_PBPR_BLANK_LEVEL, =
0x72, ITV_CMD_WRITE);
+                break;
+        }       =20
+    }
+}
+
+
+void set_integrated_tv_mode(int tv_mode_index)
+{
+    int i, mode_index;
+    unsigned long  *tv_mode_table =3D NULL;
+    unsigned long  *tv_crtc_table =3D NULL;
+
+    DEBUG_MSG(KERN_INFO "set_integrated_tv_mode!\n");
+    DEBUG_MSG(KERN_INFO "TV Mode =3D %d.\n", tv_mode_index);
+    DEBUG_MSG(KERN_INFO "TV Type =3D %d\n", tv_setting_info.system);
+    DEBUG_MSG(KERN_INFO "TV Output =3D %d\n", =
tv_setting_info.out_signal);
+    DEBUG_MSG(KERN_INFO "TV IGA =3D %d\n", tv_setting_info.iga_path);   =
=20
+   =20
+    /* Try to get the suitable mode table. */
+    for (i=3D0; i<NUM_TOTAL_INTEGRATEDTV_MODE_TABLE; i++)
+    {
+        mode_index =3D i;
+
+        if (ITV_MODE_TABLE[i].mode_index =3D=3D tv_mode_index)
+        {
+            break;
+        }
+    }
+   =20
+    DEBUG_MSG(KERN_INFO "TV Mode Index to use is: %d.\n" , mode_index);
+
+    switch (tv_setting_info.system)
+    {
+        case TVTYPE_NTSC:
+        {
+            tv_mode_table =3D ITV_MODE_TABLE[mode_index].std_ntsc;
+            tv_crtc_table =3D ITV_CRTC_TABLE[mode_index].std_ntsc;
+            break;
+        }
+           =20
+        case TVTYPE_PAL:
+        {
+            tv_mode_table =3D ITV_MODE_TABLE[mode_index].std_pal;
+            tv_crtc_table =3D ITV_CRTC_TABLE[mode_index].std_pal;
+            break;
+        }
+
+        case TVTYPE_480P:
+        {
+            /* For 480P, we use NTSC's mode table, and then do some =
patches later. */
+            tv_mode_table =3D ITV_MODE_TABLE[mode_index].std_ntsc;
+            tv_crtc_table =3D ITV_CRTC_TABLE[mode_index].std_ntsc;
+            break;
+        }
+
+        case TVTYPE_576P:
+        {
+            /* For 576P, we use PAL's mode table, and then do some =
patches later. */
+            tv_mode_table =3D ITV_MODE_TABLE[mode_index].std_pal;
+            tv_crtc_table =3D ITV_CRTC_TABLE[mode_index].std_pal;
+            break;
+        }
+
+        case TVTYPE_720P:
+        {
+            tv_mode_table =3D ITV_MODE_TABLE[mode_index].std_720p;
+            tv_crtc_table =3D ITV_CRTC_TABLE[mode_index].std_720p;
+            break;
+        }
+
+        case TVTYPE_1080I:
+        {
+            tv_mode_table =3D ITV_MODE_TABLE[mode_index].std_1080i;
+            tv_crtc_table =3D ITV_CRTC_TABLE[mode_index].std_1080i;
+            break;
+        }
+
+        default:
+        {
+            tv_mode_table =3D ITV_MODE_TABLE[mode_index].std_ntsc;
+            tv_crtc_table =3D ITV_CRTC_TABLE[mode_index].std_ntsc;
+            break;
+        }
+    }
+  =20
+    enable_integrated_tv_shadow_reg();
+
+    /* Write TV Encoder Regsiters: */
+
+    /* Common settings by mode: */
+    write_integrated_tv_general_table(ITV_MODE_TABLE_OFFSET, =
tv_mode_table);
+   =20
+    /* Write GFX CRTC timing by TV mode. */
+    write_gfx_crtc_timing_for_tv(tv_crtc_table);
+
+    if (tv_setting_info.iga_path =3D=3D IGA2)
+    {
+        access_integrated_tv_regs(ITV_REG_ID_SRC_SEL, =
ITV_VALUE_SRC_FROM_IGA2, ITV_CMD_WRITE);
+       =20
+        write_reg_mask(CR6A, VIACR, 0, BIT2);
+
+        enable_second_display_channel();
+    }
+    else
+    {
+        access_integrated_tv_regs(ITV_REG_ID_SRC_SEL, =
ITV_VALUE_SRC_FROM_IGA1, ITV_CMD_WRITE);
+       =20
+        /* For the case: TV IGA1 horizontal total can't be divided by =
8. */
+        plus_vck_to_iga1_timing(tv_crtc_table[H_TOTAL_INDEX]);
+    }
+
+    /* Set TV output signal: */
+    set_integrated_tv_output_signal();
+
+    /* Patch for HDTV: */
+    set_hdtv_patch_table(mode_index);
+
+    /* We should modify some settings if use RGB/YPbPr output. */
+    set_tv_output_patch_table();
+
+    /* Update scaling factor: */
+    update_scaling_factor();
+
+    /* Ported from X to support A3*/
+    patch_for_macrovision();
+
+    disable_integrated_tv_shadow_reg();
+}
+
+
+void integrated_tv_sw_reset(void)
+{
+    enable_integrated_tv_shadow_reg();
+
+    access_integrated_tv_regs(ITV_REG_ID_SD_ENABLE, ITV_VALUE_DISABLE, =
ITV_CMD_WRITE);
+    access_integrated_tv_regs(ITV_REG_ID_SW_RESET, ITV_VALUE_ENABLE, =
ITV_CMD_WRITE);
+    access_integrated_tv_regs(ITV_REG_ID_SW_RESET, ITV_VALUE_DISABLE, =
ITV_CMD_WRITE);
+
+    delays(50000);  /* We should delay to wait IGA1's VSync. */
+   =20
+    access_integrated_tv_regs(ITV_REG_ID_SD_ENABLE, ITV_VALUE_ENABLE, =
ITV_CMD_WRITE);
+
+    disable_integrated_tv_shadow_reg();
+}
+
+
+void integrated_tv_enable(void)
+{
+    /* Turn on DPMS. */
+    write_reg_mask(CR36, VIACR, 0, BIT4+BIT5);
+
+    enable_integrated_tv_shadow_reg();
+
+    /* For the problem TV may crash when we repeat to switch TV type */
+    /* (NTSC->PAL->NTSC->PAL->...), to do the following sequence can =
help avoiding this problem. */
+    /* 1. Disable Sync Buffer Mode before set mode and disable TV. */
+    /* 2. Enable Sync Buffer Mode before enable TV. */   =20
+    /* Suggested by HW team. */
+
+    /* Enable Sync Buffer Mode: */
+    access_integrated_tv_regs(ITV_REG_ID_SYNC_BUF_MODE, =
ITV_VALUE_ENABLE, ITV_CMD_WRITE);
+  =20
+    /* Enable PK. */
+    access_integrated_tv_regs(ITV_REG_ID_PK_ENABLE, ITV_VALUE_ENABLE, =
ITV_CMD_WRITE);
+
+    /* Enable SD. */
+    access_integrated_tv_regs(ITV_REG_ID_SD_ENABLE, ITV_VALUE_ENABLE, =
ITV_CMD_WRITE);
+
+    /* Enable TV encoder. */
+    access_integrated_tv_regs(ITV_REG_ID_TV_ENABLE, ITV_VALUE_ENABLE, =
ITV_CMD_WRITE);
+
+    /* Change DAC usage. */
+    access_integrated_tv_regs(ITV_REG_ID_PRI_DAC_SEL, =
ITV_VALUE_DAC_FOR_TV, ITV_CMD_WRITE);
+
+    /* Disable SW Reset. */
+    access_integrated_tv_regs(ITV_REG_ID_SW_RESET, ITV_VALUE_DISABLE, =
ITV_CMD_WRITE);
+
+    disable_integrated_tv_shadow_reg();
+
+    integrated_tv_sw_reset();
+}
+
+
+void integrated_tv_disable(void)
+{
+    enable_integrated_tv_shadow_reg();
+
+    /* For the problem TV may crash when we repeat to switch TV type */
+    /* (NTSC->PAL->NTSC->PAL->...), to do the following sequence can =
help avoiding this problem. */
+    /* 1. Disable Sync Buffer Mode before set mode and disable TV. */
+    /* 2. Enable Sync Buffer Mode before enable TV. */   =20
+    /* Suggested by HW team. */
+
+    /* Enable SW Reset. */
+    access_integrated_tv_regs(ITV_REG_ID_SW_RESET, ITV_VALUE_ENABLE, =
ITV_CMD_WRITE);
+   =20
+    /* Disable Sync Buffer Mode: */
+    access_integrated_tv_regs(ITV_REG_ID_SYNC_BUF_MODE, =
ITV_VALUE_DISABLE, ITV_CMD_WRITE);
+
+    /* Disable PK. */
+    access_integrated_tv_regs(ITV_REG_ID_PK_ENABLE, ITV_VALUE_DISABLE, =
ITV_CMD_WRITE);
+
+    /* Disable SD. */
+    access_integrated_tv_regs(ITV_REG_ID_SD_ENABLE, ITV_VALUE_DISABLE, =
ITV_CMD_WRITE);
+
+    /* Disable TV encoder. */
+    access_integrated_tv_regs(ITV_REG_ID_TV_ENABLE, ITV_VALUE_DISABLE, =
ITV_CMD_WRITE);
+
+    /* Change DAC usage. */
+    access_integrated_tv_regs(ITV_REG_ID_PRI_DAC_SEL, =
ITV_VALUE_DAC_FOR_CRT, ITV_CMD_WRITE);
+
+    disable_integrated_tv_shadow_reg();
+}
+
+
+void get_integrated_tv_default_status(void)
+{
+    static int scale_value_initialized;
+    enable_integrated_tv_shadow_reg();
+
+    /* Size: */
+    /* The scaling factor level and default value here are not =
absolute, they can change by request. */
+    tv_setting_info.ScalHLevel =3D 21;
+    tv_setting_info.ScalVLevel =3D 15;
+    tv_setting_info.DefaultScalH =3D 10;
+    tv_setting_info.DefaultScalV =3D 7;
+    if(!scale_value_initialized) {
+        tv_setting_info.CurrentScalH =3D tv_setting_info.DefaultScalH;
+        tv_setting_info.CurrentScalV =3D tv_setting_info.DefaultScalV;
+        scale_value_initialized=3D1;
+    }
+    tv_setting_info.ScalDegreeH =3D 5;
+    tv_setting_info.ScalDegreeV =3D 5;
+
+    /* Positoin: */
+    /* The position level and default value here are not absolute, they =
can change by request. */
+    tv_setting_info.PositionHLevel =3D 17;
+    tv_setting_info.PositionVLevel =3D 13;
+    tv_setting_info.DefaultPositionH =3D 9;
+    tv_setting_info.DefaultPositionV =3D 7;
+    tv_setting_info.CurrentPositionH =3D =
tv_setting_info.DefaultPositionH;
+    tv_setting_info.CurrentPositionV =3D =
tv_setting_info.DefaultPositionV;
+
+    tv_setting_info.DefaultFFilter =3D 0;
+    tv_setting_info.FFilterLevel =3D 1;
+    tv_setting_info.CurrentFFilter =3D tv_setting_info.DefaultFFilter;
+
+    tv_setting_info.DefaultAFFilter =3D 0;
+    tv_setting_info.AFFilterLevel =3D 1023;
+   =20
+    /* Brightness: */
+    tv_setting_info.DefaultBrightness =3D =
access_integrated_tv_regs(ITV_REG_ID_BLACK_LEVEL, 0, ITV_CMD_READ);
+    tv_setting_info.BrightnessLevel =3D 255;  /* 8 bits. */
+    tv_setting_info.CurrentBrightness =3D =
tv_setting_info.DefaultBrightness;
+
+    /* Contrast: */
+    tv_setting_info.DefaultContrast=3D =
access_integrated_tv_regs(ITV_REG_ID_CONTRAST, 0, ITV_CMD_READ);
+    tv_setting_info.ContrastLevel =3D 512;  /* 9 bits. */
+    tv_setting_info.CurrentContrast=3D tv_setting_info.DefaultContrast;
+
+    /* Saturation: */
+    tv_setting_info.DefaultSaturation=3D =
access_integrated_tv_regs(ITV_REG_ID_SATURATION, 0, ITV_CMD_READ);
+    tv_setting_info.SaturationLevel =3D 0x3FFFF;  /* 9+9 bits. */
+    tv_setting_info.CurrentSaturation=3D =
tv_setting_info.DefaultSaturation;
+
+    /* Hue: */
+    tv_setting_info.DefaultTINT =3D =
access_integrated_tv_regs(ITV_REG_ID_HUE, 0, ITV_CMD_READ);
+    tv_setting_info.TINTLevel =3D 2047;       /* 11 bits. */
+    tv_setting_info.CurrentTINT =3D tv_setting_info.DefaultTINT;
+   =20
+    disable_integrated_tv_shadow_reg();
+}
+
+
+int get_integrated_tv_ffilter_status(int filter_type, int* =
filter_state)
+{
+    int value =3D 0;
+    int tmp_filter_state =3D 0;
+    int tmp_filter_type =3D0;
+   =20
+    enable_integrated_tv_shadow_reg();
+
+    /* check if filter is enable */
+    tmp_filter_state =3D =
access_integrated_tv_regs(ITV_REG_ID_DE_FLICKER_ENABLE, 0, =
ITV_CMD_READ);
+=20
+    /* get current filter type */
+    tmp_filter_type =3D =
access_integrated_tv_regs(ITV_REG_ID_DE_FLK_NUM, 0, ITV_CMD_READ);
+   =20
+    if (filter_type =3D=3D ITV_FILTER_TYPE_NORMAL)
+    {
+        if ((tmp_filter_state =3D=3D STATE_ON) && (tmp_filter_type =
=3D=3D ITV_VALUE_FLK_NUM_WHOLE_IMAGE))
+        {
+            *filter_state =3D STATE_ON;
+        }
+        else
+        {
+            *filter_state =3D STATE_OFF;
+        }
+        value =3D access_integrated_tv_regs(ITV_REG_ID_DF_WT_SEL, 0, =
ITV_CMD_READ);
+    }
+    else if (filter_type =3D=3D ITV_FILTER_TYPE_ADAPTIVE)
+    {
+        if ((tmp_filter_state =3D=3D STATE_ON) && (tmp_filter_type =
=3D=3D ITV_VALUE_FLK_NUM_ONE_POINT))
+        {
+            *filter_state =3D STATE_ON;
+        }
+        else
+        {
+            *filter_state =3D STATE_OFF;
+        }
+        value =3D =
access_integrated_tv_regs(ITV_REG_ID_DE_FLK_THRESHOLD, 0, ITV_CMD_READ);
+    }
+   =20
+    disable_integrated_tv_shadow_reg();
+
+    return value;
+}
+
+
+
+void get_integrated_tv_pos(u32* current_hpos, u32* current_vpos)
+{       =20
+    enable_integrated_tv_shadow_reg();
+
+    *current_hpos =3D access_integrated_tv_regs(ITV_REG_ID_DST_HSD, 0, =
ITV_CMD_READ);
+    *current_vpos =3D access_integrated_tv_regs(ITV_REG_ID_DST_VSD, 0, =
ITV_CMD_READ);
+
+    disable_integrated_tv_shadow_reg();
+}
+
+
+void set_integrated_tv_ffilter_status(int filter_type, int =
filter_on_off, u32 desired_value)
+{
+    enable_integrated_tv_shadow_reg();
+
+    if (filter_type =3D=3D ITV_FILTER_TYPE_NORMAL)
+    {
+        if (filter_on_off =3D=3D ITV_FILTER_ON)
+        {
+            /* Turn on FFilter: */
+            access_integrated_tv_regs(ITV_REG_ID_DE_FLICKER_ENABLE, =
ITV_VALUE_ENABLE, ITV_CMD_WRITE);
+            access_integrated_tv_regs(ITV_REG_ID_DF_TYPE, =
ITV_FILTER_TYPE_NORMAL, ITV_CMD_WRITE);
+
+            /* Set the weighting of FFilter : */
+            if (desired_value < 0)
+            {
+                desired_value =3D 0;
+            }
+
+            if (desired_value > tv_setting_info.FFilterLevel)
+            {
+                desired_value =3D tv_setting_info.FFilterLevel;
+            }
+
+            access_integrated_tv_regs(ITV_REG_ID_DF_WT_SEL, =
desired_value, ITV_CMD_WRITE);
+           =20
+            tv_setting_info.CurrentFFilter =3D desired_value;
+        }
+        else
+        {
+            /* Turn off FFilter: */
+            access_integrated_tv_regs(ITV_REG_ID_DE_FLICKER_ENABLE, =
ITV_VALUE_DISABLE, ITV_CMD_WRITE);
+        }
+    }
+    else if (filter_type =3D=3D ITV_FILTER_TYPE_ADAPTIVE)
+    {
+        if (filter_on_off =3D=3D ITV_FILTER_ON)
+        {
+            /* Turn on AFFilter: */
+            access_integrated_tv_regs(ITV_REG_ID_DE_FLICKER_ENABLE, =
ITV_VALUE_ENABLE, ITV_CMD_WRITE);
+            access_integrated_tv_regs(ITV_REG_ID_DE_FLK_NUM, =
ITV_VALUE_FLK_NUM_ONE_POINT, ITV_CMD_WRITE);
+
+            /* Set threshold of AFFilter : */
+            if (desired_value < 0)
+            {
+                desired_value =3D 0;
+            }
+           =20
+            if (desired_value > tv_setting_info.AFFilterLevel)
+            {
+                desired_value =3D tv_setting_info.AFFilterLevel;
+            }
+
+            access_integrated_tv_regs(ITV_REG_ID_DE_FLK_THRESHOLD, =
desired_value, ITV_CMD_WRITE);
+        }
+        else
+        {
+            /* Turn off AFFilter: */
+            access_integrated_tv_regs(ITV_REG_ID_DE_FLK_NUM, =
ITV_VALUE_FLK_NUM_WHOLE_IMAGE, ITV_CMD_WRITE);
+            access_integrated_tv_regs(ITV_REG_ID_DE_FLK_THRESHOLD, 0, =
ITV_CMD_WRITE);
+            access_integrated_tv_regs(ITV_REG_ID_DE_FLICKER_ENABLE, =
ITV_VALUE_DISABLE, ITV_CMD_WRITE);
+        }
+    }
+
+    disable_integrated_tv_shadow_reg();
+}
+
+
+void set_integrated_tv_hue(u32 desired_value)
+{
+    enable_integrated_tv_shadow_reg();
+    access_integrated_tv_regs(ITV_REG_ID_HUE, desired_value, =
ITV_CMD_WRITE);
+    tv_setting_info.CurrentTINT =3D desired_value;
+    disable_integrated_tv_shadow_reg();
+}
+
+
+void set_integrated_tv_brightness(u32 desired_value)
+{
+    enable_integrated_tv_shadow_reg();
+    access_integrated_tv_regs(ITV_REG_ID_BLACK_LEVEL, desired_value, =
ITV_CMD_WRITE);
+    tv_setting_info.CurrentBrightness =3D desired_value;
+    disable_integrated_tv_shadow_reg();
+}
+
+
+void set_integrated_tv_contrast(u32 desired_value)
+{
+    enable_integrated_tv_shadow_reg();
+    access_integrated_tv_regs(ITV_REG_ID_CONTRAST, desired_value, =
ITV_CMD_WRITE);
+    tv_setting_info.CurrentContrast =3D desired_value;
+    disable_integrated_tv_shadow_reg();
+}
+
+
+void set_integrated_tv_saturation(u32 desired_value)
+{
+    enable_integrated_tv_shadow_reg();
+    access_integrated_tv_regs(ITV_REG_ID_SATURATION, desired_value, =
ITV_CMD_WRITE);
+    tv_setting_info.CurrentSaturation =3D desired_value;
+    disable_integrated_tv_shadow_reg();
+}
+
+
+void set_integrated_tv_pos(u32 desired_hpos, u32 desired_vpos)
+{
+    u32 dst_hpos, dst_vpos;
+   =20
+    enable_integrated_tv_shadow_reg();
+
+    dst_hpos =3D access_integrated_tv_regs(ITV_REG_ID_DST_HSD, 0, =
ITV_CMD_READ);
+    dst_vpos =3D access_integrated_tv_regs(ITV_REG_ID_DST_VSD, 0, =
ITV_CMD_READ);
+
+    dst_hpos =3D dst_hpos + (desired_hpos - =
tv_setting_info.CurrentPositionH);
+    dst_vpos =3D dst_vpos - (desired_vpos - =
tv_setting_info.CurrentPositionV);
+
+    access_integrated_tv_regs(ITV_REG_ID_DST_HSD, dst_hpos, =
ITV_CMD_WRITE);
+    access_integrated_tv_regs(ITV_REG_ID_DST_VSD, dst_vpos, =
ITV_CMD_WRITE);
+
+    tv_setting_info.CurrentPositionH =3D desired_hpos;
+    tv_setting_info.CurrentPositionV =3D desired_vpos;
+
+    disable_integrated_tv_shadow_reg();
+}
+
+
+void set_integrated_tv_size(u32 desired_hsize, u32 desired_vsize)
+{=20
+    u32 dst_hsize, dst_vsize;
+    DEBUG_MSG("set integrated TV H:%d V:%d", desired_hsize, =
desired_vsize);
+   =20
+    enable_integrated_tv_shadow_reg();
+   =20
+    dst_hsize =3D access_integrated_tv_regs(ITV_REG_ID_DST_HSIZE, 0, =
ITV_CMD_READ);
+    dst_vsize =3D access_integrated_tv_regs(ITV_REG_ID_DST_VSIZE, 0, =
ITV_CMD_READ);
+
+    dst_hsize =3D dst_hsize + tv_setting_info.ScalDegreeH * =
(desired_hsize - tv_setting_info.CurrentScalH);
+    dst_vsize =3D dst_vsize + tv_setting_info.ScalDegreeV * =
(desired_vsize - tv_setting_info.CurrentScalV);
+
+    access_integrated_tv_regs(ITV_REG_ID_DST_HSIZE, dst_hsize, =
ITV_CMD_WRITE);
+    access_integrated_tv_regs(ITV_REG_ID_DST_VSIZE, dst_vsize, =
ITV_CMD_WRITE);
+
+    /* Update scaling factor: */
+    update_scaling_factor();
+   =20
+    tv_setting_info.CurrentScalH =3D desired_hsize;
+    tv_setting_info.CurrentScalV =3D desired_vsize;
+    disable_integrated_tv_shadow_reg();
+}
+
+
+int integrated_tv_sense(void)
+{
+    u8 cr30, cr37, cr43, rgb_dac_status;
+    u32 tv3f, rgb_status, tv_encoder_status, dac_status;
+    int sense_status;
+
+    enable_integrated_tv_shadow_reg();
+
+    if (g_first_time_to_sense)
+    {
+        /* Set TV mode (arbitrary) at least once before sense TV. */
+        write_integrated_tv_general_table(ITV_INIT_TABLE_OFFSET, =
ITV_INIT_TABLE_VALUE);
+        write_integrated_tv_general_table(ITV_MODE_TABLE_OFFSET, =
ITV_MODE_TABLE_NTSC_640x480);
+        g_first_time_to_sense =3D FALSE;
+    }
+
+    /* Saved for restore later: */
+    cr30 =3D read_reg(VIACR, CR30);
+    cr37 =3D read_reg(VIACR, CR37);
+    cr43 =3D read_reg(VIACR, CR43);
+    rgb_dac_status =3D read_reg(VIASR, SR5E);
+    tv3f =3D access_integrated_tv_regs(ITV_REG_ID_TV_SENSE_DATA, 0, =
ITV_CMD_READ);
+    tv_encoder_status =3D =
access_integrated_tv_regs(ITV_REG_ID_TV_ENABLE, 0, ITV_CMD_READ);
+    dac_status =3D access_integrated_tv_regs(ITV_REG_ID_PRI_DAC_SEL, 0, =
ITV_CMD_READ);
+
+    /* To sense TV, we should: */
+    /* 1. Set CR30[4:3]=3D01, CR37[2:0]=3D100, CR37[3]=3D0, =
CR43[5:4]=3D01 and TV.3F[7:0]=3D42h. */
+    /* 2. Enable TV DAC R/G/B. */
+    /* 3. Enable TV encoder. */
+    /* 4. Change primary DAC to TV. */
+    write_reg_mask(CR30, VIACR, BIT3, BIT4+BIT3);
+    write_reg_mask(CR37, VIACR, BIT2, BIT3+BIT2+BIT1+BIT0);
+    write_reg_mask(CR43, VIACR, BIT4, BIT5+BIT4);
+    write_reg_mask(SR5E, VIASR, 0, BIT3+BIT2+BIT1);
+    access_integrated_tv_regs(ITV_REG_ID_TV_SENSE_DATA, 0x42, =
ITV_CMD_WRITE);
+    access_integrated_tv_regs(ITV_REG_ID_TV_ENABLE, ITV_VALUE_ENABLE, =
ITV_CMD_WRITE);
+    access_integrated_tv_regs(ITV_REG_ID_PRI_DAC_SEL, =
ITV_VALUE_DAC_FOR_TV, ITV_CMD_WRITE);
+   =20
+    /* Start to sense: */
+    access_integrated_tv_regs(ITV_REG_ID_TV_SENSE, =
ITV_VALUE_MANUAL_SENSE, ITV_CMD_WRITE);
+    access_integrated_tv_regs(ITV_REG_ID_TV_SENSE, ITV_VALUE_NO_SENSE, =
ITV_CMD_WRITE);
+
+    /* Restore: */
+    access_integrated_tv_regs(ITV_REG_ID_PRI_DAC_SEL, dac_status, =
ITV_CMD_WRITE);
+    access_integrated_tv_regs(ITV_REG_ID_TV_ENABLE, tv_encoder_status, =
ITV_CMD_WRITE);
+    access_integrated_tv_regs(ITV_REG_ID_TV_SENSE_DATA, tv3f, =
ITV_CMD_WRITE);
+    write_reg(CR30, VIACR, cr30);
+    write_reg(CR37, VIACR, cr37);
+    write_reg(CR43, VIACR, cr43);
+    write_reg(SR5E, VIASR, rgb_dac_status);
+
+    /* Get sense result: */   =20
+    sense_status =3D =
access_integrated_tv_regs(ITV_REG_ID_TV_SENSE_STATUS, 0, ITV_CMD_READ);
+    rgb_status =3D =
access_integrated_tv_regs(ITV_REG_ID_TV_SENSE_RGB_STATUS, 0, =
ITV_CMD_READ);
+
+    /* Check connected TV output: */
+    if (!tv_setting_info.out_signal)
+    {
+        switch(rgb_status)
+        {
+            case ITV_VALUE_DAC_R | ITV_VALUE_DAC_G:
+            {
+                tv_setting_info.out_signal=3D TV_OUTPUT_SVIDEO;
+                break;
+            }
+
+            case ITV_VALUE_DAC_B:
+            {
+                tv_setting_info.out_signal =3D TV_OUTPUT_COMPOSITE;
+                break;
+            }
+
+            case ITV_VALUE_DAC_R | ITV_VALUE_DAC_G | ITV_VALUE_DAC_B:
+            {
+                tv_setting_info.out_signal =3D TV_OUTPUT_RGB;
+                break;
+            }
+
+            default:
+            {
+                tv_setting_info.out_signal =3D TV_OUTPUT_COMPOSITE;
+                break;
+            }
+        }
+    }
+
+    disable_integrated_tv_shadow_reg();
+
+    return sense_status;
+}
+
+
+int init_integrated_tv_regs(void)
+{
+    u32 mask =3D 0x1FFFFFF0;  /* [28:4] */
+    u32 buf_start_address;
+    u32 buffer_size =3D 0x80000;
+    u8  offset =3D 0;
+    unsigned char* mmio_base;
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+    buf_start_address =3D viafbinfo.memsize - =
INTEGRATED_TV_BUFFER_SIZE;
+   =20
+    viafbinfo.integrated_tv_map_base =3D (unsigned =
int)ioremap_nocache(viafbinfo.mmio_base  + VIA_MMIO_INTEGRATED_TV_BASE, =
VIA_MMIO_INTEGRATED_TV_SIZE);
+
+    if (!viafbinfo.integrated_tv_map_base)
+    {       =20
+        return FAIL;
+    }
+
+    mmio_base =3D (unsigned char*)viafbinfo.integrated_tv_map_base;
+#else
+    buf_start_address =3D parinfo.fbmem_free - =
INTEGRATED_TV_BUFFER_SIZE;
+    parinfo.fbmem_free =3D parinfo.fbmem_free - =
INTEGRATED_TV_BUFFER_SIZE;
+    parinfo.fbmem_used +=3D INTEGRATED_TV_BUFFER_SIZE;
+
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,8)
+    parinfo.integrated_tv_map_base =3D =
ioremap_nocache(parinfo.mmio_base + VIA_MMIO_INTEGRATED_TV_BASE, =
VIA_MMIO_INTEGRATED_TV_SIZE);
+#else
+    parinfo.integrated_tv_map_base =3D (unsigned =
int)ioremap_nocache(parinfo.mmio_base + VIA_MMIO_INTEGRATED_TV_BASE, =
VIA_MMIO_INTEGRATED_TV_SIZE);
+#endif
+
+    if (!parinfo.integrated_tv_map_base)
+    {       =20
+        return FAIL;
+    }
+
+    mmio_base =3D (unsigned char*)parinfo.integrated_tv_map_base;
+#endif
+
+    enable_integrated_tv_shadow_reg();
+
+    /* Clear all: */
+    while (offset < 0xF0)
+    {
+        write_integrated_tv_reg32(mmio_base, offset, 0);
+        offset =3D offset + 4;
+    }
+   =20
+    /* Write Source Buffer 0~3 Base Address: */
+    write_integrated_tv_reg_mask32(mmio_base, 0x04, mask, =
buf_start_address);
+
+    buf_start_address =3D buf_start_address + buffer_size;
+    write_integrated_tv_reg_mask32(mmio_base, 0x08, mask, =
buf_start_address);
+
+    buf_start_address =3D buf_start_address + buffer_size;
+    write_integrated_tv_reg_mask32(mmio_base, 0x0C, mask, =
buf_start_address);
+
+    buf_start_address =3D buf_start_address + buffer_size;
+    write_integrated_tv_reg_mask32(mmio_base, 0x10, mask, =
buf_start_address);
+   =20
+    /* Write Destination Even and Odd Buffer Base Address: */
+    buf_start_address =3D buf_start_address + buffer_size;
+    write_integrated_tv_reg_mask32(mmio_base, 0x2C, mask, =
buf_start_address);
+
+    buf_start_address =3D buf_start_address + buffer_size;
+    write_integrated_tv_reg_mask32(mmio_base, 0x30, mask, =
buf_start_address);
+
+    /* Other initialize: */
+    write_integrated_tv_general_table(ITV_INIT_TABLE_OFFSET, =
ITV_INIT_TABLE_VALUE);
+
+    disable_integrated_tv_shadow_reg();
+
+    return OK;
+}
+
+
+int integrated_tv_encoder_identify(void)
+{
+    if (chip_info.gfx_chip_name =3D=3D UNICHROME_CX700)
+    {
+        return OK;
+    }
+    else
+    {
+        return FAIL;
+    }
+}
+
diff -Nur linux-2.6.21-rc7/drivers/video/via/IntegratedTV.h =
linux-2.6.21-rc7.viafb/drivers/video/via/IntegratedTV.h
--- linux-2.6.21-rc7/drivers/video/via/IntegratedTV.h 1969-12-31 =
19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/IntegratedTV.h 2007-04-26 =
19:52:32.000000000 -0400
@@ -0,0 +1,107 @@
+/*
+ * Copyright 1998-2007 VIA Technologies, Inc. All Rights Reserved.
+ * Copyright 2001-2007 S3 Graphics, Inc. All Rights Reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person =
obtaining a
+ * copy of this software and associated documentation files (the =
"Software"),
+ * to deal in the Software without restriction, including without =
limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sub =
license,
+ * and/or sell copies of the Software, and to permit persons to whom =
the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the
+ * next paragraph) shall be included in all copies or substantial =
portions
+ * of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, =
EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF =
MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT =
SHALL
+ * THE AUTHOR(S) OR COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, =
DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR =
OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE =
OR OTHER
+ * DEALINGS IN THE SOFTWARE.
+ */
+
+#ifndef _INTEGRATEDTV_H_
+#define _INTEGRATEDTV_H_ 1
+
+
+/* Registers IDs: */
+/* The definition value has 4 bits: 2 bits IO address + 2 bits offset. =
*/
+/* ex. 0x0018 means bits 18 of IO Address 00, it is TV source =
selection. */
+#define ITV_REG_ID_PK_ENABLE            0x0000    /* PK enable. */
+#define ITV_REG_ID_SRC_SEL              0x0018    /* Source from IGA1 =
or IGA2. */
+#define ITV_REG_ID_SW_RESET             0x0020    /* SW reset. */
+#define ITV_REG_ID_SYNC_BUF_MODE        0x0030    /* Synchronous mode. =
*/
+#define ITV_REG_ID_SD_ENABLE            0x0031    /* Scaler and =
Deflicker enable. */
+#define ITV_REG_ID_SRC_VSIZE            0x1800    /* Source image =
vertical pixels. */
+#define ITV_REG_ID_SRC_HSIZE            0x1811    /* Source image =
horizontal pixels. */
+#define ITV_REG_ID_DE_FLK_THRESHOLD     0x2011    /* Adative flicker =
filter threshold. */
+#define ITV_REG_ID_SCL_VFAC             0x2400    /* Vertical scaling =
factor. */
+#define ITV_REG_ID_DE_FLK_NUM           0x2413    /* Adative flicker =
filter. */
+#define ITV_REG_ID_DF_WT_SEL            0x2414    /* De-flicker =
weighting selection. */
+#define ITV_REG_ID_DF_TYPE              0x2415    /* De-flicker type. =
*/
+#define ITV_REG_ID_SCL_HFAC             0x2416    /* Horizontal scaling =
factor. */
+#define ITV_REG_ID_DE_FLICKER_ENABLE    0x2429    /* De-flicker enable. =
*/
+#define ITV_REG_ID_DST_VSIZE            0x2800    /* Destination image =
vertical pixels. */
+#define ITV_REG_ID_DST_HSIZE            0x2811    /* Destination image =
horizontal pixels. */
+#define ITV_REG_ID_TV_ENABLE            0x3800    /* TV enable. */
+#define ITV_REG_ID_OUTPUT_SEL           0x3828    /* TV DAC output =
selection. */
+#define ITV_REG_ID_TV_SENSE             0x3C14    /* TV sense enable. =
*/
+#define ITV_REG_ID_TV_SENSE_DATA        0x3C24    /* TV sense data. */
+#define ITV_REG_ID_DST_HSD              0x4821    /* Destination image =
horizontal start display */
+#define ITV_REG_ID_DST_VSD              0x4C23    /* Destination image =
vertical start display */
+#define ITV_REG_ID_SATURATION           0x5000    /* Saturation =
adjustment. */
+#define ITV_REG_ID_CONTRAST             0x5400    /* Contrast =
adjustment. */
+#define ITV_REG_ID_BLACK_LEVEL          0x5423    /* Brightness =
adjustment. */
+#define ITV_REG_ID_HUE                  0x6000    /* Hue adjustment. */
+#define ITV_REG_ID_PRI_DAC_SEL          0x6C12    /* Primary DAC for =
CRT or TV. */
+#define ITV_REG_ID_TV_SENSE_STATUS      0xE402    /* TV sense status. =
*/
+#define ITV_REG_ID_PBPR_BLANK_LEVEL     0xE800    /* Blank Level for Pb =
and Pr. For VT3324 A3. */
+#define ITV_REG_ID_TV_SENSE_RGB_STATUS  0xE828    /* TV sense R/G/B =
status. */
+
+#define ITV_CMD_READ                0
+#define ITV_CMD_WRITE               1
+
+#define ITV_VALUE_DISABLE           0
+#define ITV_VALUE_ENABLE            1
+
+#define ITV_VALUE_SRC_FROM_IGA1     0
+#define ITV_VALUE_SRC_FROM_IGA2     1
+
+#define ITV_VALUE_DAC_FOR_CRT       0
+#define ITV_VALUE_DAC_FOR_TV        1
+
+#define ITV_VALUE_OUTPUT_SC         0x00    /* S-Video or Composite */
+#define ITV_VALUE_OUTPUT_RGB        0x02    /* RGB */
+#define ITV_VALUE_OUTPUT_YPbPr      0x03    /* YPbPr */
+
+#define ITV_VALUE_FLK_NUM_WHOLE_IMAGE   0
+#define ITV_VALUE_FLK_NUM_ONE_POINT     1
+
+#define ITV_VALUE_NO_SENSE          0x00
+#define ITV_VALUE_MANUAL_SENSE      0x02
+#define ITV_VALUE_AUTO_SENSE        0x03
+
+#define ITV_VALUE_TV_UNCONNECTED    0
+#define ITV_VALUE_TV_CONNECTED      1
+
+#define ITV_VALUE_DAC_R             4
+#define ITV_VALUE_DAC_G             2
+#define ITV_VALUE_DAC_B             1
+
+#define ITV_FILTER_TYPE_NORMAL      0
+#define ITV_FILTER_TYPE_IIR         1
+#define ITV_FILTER_TYPE_ADAPTIVE    2
+#define ITV_FILTER_TYPE_NONE        3
+
+#define ITV_FILTER_OFF              0
+#define ITV_FILTER_ON               1
+
+#define INTEGRATED_TV_BUFFER_SIZE   0x300000     /* bytes */ /* We =
reserve 3MB now. */
+
+#define VIA_MMIO_INTEGRATED_TV_BASE 0xC000
+#define VIA_MMIO_INTEGRATED_TV_SIZE 256
+
+#endif
+
diff -Nur linux-2.6.21-rc7/drivers/video/via/ioctl.c =
linux-2.6.21-rc7.viafb/drivers/video/via/ioctl.c
--- linux-2.6.21-rc7/drivers/video/via/ioctl.c 1969-12-31 =
19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/ioctl.c 2007-04-26 =
19:52:32.000000000 -0400
@@ -0,0 +1,213 @@
+/*
+ * Copyright 1998-2007 VIA Technologies, Inc. All Rights Reserved.
+ * Copyright 2001-2007 S3 Graphics, Inc. All Rights Reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person =
obtaining a
+ * copy of this software and associated documentation files (the =
"Software"),
+ * to deal in the Software without restriction, including without =
limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sub =
license,
+ * and/or sell copies of the Software, and to permit persons to whom =
the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the
+ * next paragraph) shall be included in all copies or substantial =
portions
+ * of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, =
EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF =
MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT =
SHALL
+ * THE AUTHOR(S) OR COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, =
DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR =
OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE =
OR OTHER
+ * DEALINGS IN THE SOFTWARE.
+ */
+
+#include <linux/fb.h>
+#include <asm/uaccess.h>
+
+#include "viafbdev.h"
+#include "chip.h"
+#include "debug.h"
+#include "ioctl.h"
+#include "share.h"
+
+extern int dvi_sense(void);
+extern int tv_sense(void);
+extern int tv_auto_sense(void);
+extern inline u8 read_reg(int io_port, u8 index);
+
+extern struct chip_information          chip_info;
+extern struct tv_setting_information    tv_setting_info;
+extern struct viafb_info                viafbinfo;
+extern int CRT_ON, TV_ON, DVI_ON, LCD_ON;
+extern int DeviceStatus;
+extern int HotPlug_TV;
+extern int refresh;
+
+int HotPlug_Xres =3D 640, HotPlug_Yres =3D 480, HotPlug_bpp =3D 32, =
HotPlug_refresh =3D 60, HotPlug_TVType =3D TVTYPE_NTSC;
+
+int ioctl_get_viafb_info(u_long arg)
+{
+    struct viafb_ioctl_info viainfo;
+
+    viainfo.viafb_id    =3D VIAID;
+    viainfo.vendor_id   =3D PCI_VIA_VENDOR_ID;
+
+    switch(chip_info.gfx_chip_name) {
+        case UNICHROME_CLE266:
+            viainfo.device_id =3D UNICHROME_CLE266_DID;
+            break;
+
+        case UNICHROME_K400:
+            viainfo.device_id =3D UNICHROME_K400_DID;
+            break;
+
+        case UNICHROME_K800:
+            viainfo.device_id =3D UNICHROME_K800_DID;
+            break;
+
+        case UNICHROME_P880:
+            viainfo.device_id =3D UNICHROME_P880_DID;
+            break;
+
+        case UNICHROME_CN900:
+            viainfo.device_id =3D UNICHROME_CN900_DID;
+            break;
+           =20
+        /* Add for VT3324. */
+        case UNICHROME_CX700:
+            viainfo.device_id =3D UNICHROME_CX700_DID;
+            break;
+
+        /* Add for VT3327 VT3336 VT3364 */
+        case UNICHROME_K8M890:
+            viainfo.device_id =3D UNICHROME_K8M890_DID;
+            break;
+
+        case UNICHROME_P4M890:
+            viainfo.device_id =3D UNICHROME_P4M890_DID;
+            break;
+
+        case UNICHROME_P4M900:
+            viainfo.device_id =3D UNICHROME_P4M900_DID;
+            break;
+    }
+   =20
+    viainfo.version =3D VERSION_MAJOR;
+    viainfo.revision =3D VERSION_MINOR;
+
+    if(copy_to_user((void __user *)arg, &viainfo, sizeof(viainfo))) {
+        return -EFAULT;
+    }
+
+    return 0;
+}
+
+/* Hot-Plug Priority: DVI > TV > CRT */
+int ioctl_hotplug(int hres, int vres, int bpp)
+{
+    int TVsense, DVIsense, status =3D 0;
+    u8  TVType =3D 0;
+
+    DEBUG_MSG(KERN_INFO "ioctl_hotplug!!\n");
+
+    if(chip_info.tmds_chip_info.tmds_chip_name !=3D =
NON_TMDS_TRANSMITTER) {
+        DVIsense =3D dvi_sense();
+
+        if(DVIsense) {
+            DEBUG_MSG(KERN_INFO "DVI Attached...\n");
+            if(DeviceStatus !=3D DVI_Device) {
+                DVI_ON =3D 1;
+                CRT_ON =3D TV_ON =3D LCD_ON =3D 0;
+
+                if(DeviceStatus =3D=3D TV_Device) {
+                    tv_setting_info.system =3D HotPlug_TVType;
+                }
+
+                DeviceStatus =3D DVI_Device;
+                return DeviceStatus;
+            }
+            status =3D 1;
+        }
+        else
+            DEBUG_MSG(KERN_INFO "DVI De-attached...\n");
+    }
+   =20
+    if((chip_info.tv_chip_info.tv_chip_name !=3D =
NON_TV_ENCODER)&&(status =3D=3D 0)) {
+        /* If TV not ON, using TV manual sense function. =20
+           If TV ON, using TV auto sense function.=20
+           This is avoid the display flick to use TV manual sense =
function when TV ON. */
+        if(DeviceStatus !=3D TV_Device) {
+            TVsense =3D tv_sense();
+        }
+        else {
+            TVsense =3D tv_auto_sense();
+        }
+
+        if(TVsense !=3D TV_OUTPUT_NONE) {
+            DEBUG_MSG(KERN_INFO "TV Attached: TVsense =3D %d\n", =
TVsense);
+   =20
+            if(DeviceStatus !=3D TV_Device) {
+                TV_ON =3D 1;
+                CRT_ON =3D DVI_ON =3D LCD_ON =3D 0;
+
+                HotPlug_TVType =3D tv_setting_info.system;
+
+                if((chip_info.gfx_chip_name =3D=3D UNICHROME_CLE266) && =
(chip_info.gfx_chip_revision =3D=3D CLE266_REVISION_AX)) {
+                    TVType =3D read_reg(VIACR, 0x3C) & 0x0F;
+                }
+                else {
+                    TVType =3D read_reg(VIACR, 0x4E) & 0x0F;
+                }
+
+                if(!TVType) {
+                    tv_setting_info.system =3D TVTYPE_NTSC;
+                }
+                else {
+                    tv_setting_info.system =3D TVTYPE_PAL;
+                }
+
+                tv_setting_info.out_signal =3D TVsense;
+
+                HotPlug_TV =3D 1;
+                DeviceStatus =3D TV_Device;
+                return DeviceStatus;
+            }
+            status =3D 1;
+        }
+        else {
+            DEBUG_MSG(KERN_INFO "TV De-attached...\n");
+            HotPlug_TV =3D 0;
+        }
+    }
+   =20
+    if((DeviceStatus !=3D CRT_Device)&&(status =3D=3D 0)) {
+        CRT_ON =3D 1;
+        TV_ON =3D DVI_ON =3D LCD_ON =3D 0;
+
+        if(DeviceStatus =3D=3D TV_Device) {
+            tv_setting_info.system =3D HotPlug_TVType;
+        }
+
+        DeviceStatus =3D CRT_Device;
+        return DeviceStatus;
+    }
+
+    return 0;
+}
+
+int ioctl_get_tv_type(u_long arg)
+{
+    u8          TVType =3D 0;
+    u32 __user  *argp =3D (u32 __user *)arg;
+
+    if((chip_info.gfx_chip_name =3D=3D UNICHROME_CLE266) && =
(chip_info.gfx_chip_revision =3D=3D CLE266_REVISION_AX)) {
+        TVType =3D read_reg(VIACR, 0x3C) & 0x0F;
+    }
+    else {
+        TVType =3D read_reg(VIACR, 0x4E) & 0x0F;
+    }
+
+    return put_user((u32)TVType, argp);
+}
+
diff -Nur linux-2.6.21-rc7/drivers/video/via/ioctl.h =
linux-2.6.21-rc7.viafb/drivers/video/via/ioctl.h
--- linux-2.6.21-rc7/drivers/video/via/ioctl.h 1969-12-31 =
19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/ioctl.h 2007-04-26 =
19:52:32.000000000 -0400
@@ -0,0 +1,264 @@
+/*
+ * Copyright 1998-2007 VIA Technologies, Inc. All Rights Reserved.
+ * Copyright 2001-2007 S3 Graphics, Inc. All Rights Reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person =
obtaining a
+ * copy of this software and associated documentation files (the =
"Software"),
+ * to deal in the Software without restriction, including without =
limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sub =
license,
+ * and/or sell copies of the Software, and to permit persons to whom =
the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the
+ * next paragraph) shall be included in all copies or substantial =
portions
+ * of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, =
EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF =
MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT =
SHALL
+ * THE AUTHOR(S) OR COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, =
DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR =
OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE =
OR OTHER
+ * DEALINGS IN THE SOFTWARE.
+ */
+
+#ifndef __IOCTL_H__
+#define __IOCTL_H__
+
+#ifndef __user
+#define __user
+#endif=20
+
+/* VIAFB IOCTL definition */
+#define VIAFB_GET_INFO_SIZE     0x56494101 /* 'VIA\01' */
+#define VIAFB_GET_INFO          0x56494102 /* 'VIA\02' */
+#define VIAFB_HOTPLUG           0x56494103 /* 'VIA\03' */
+#define VIAFB_SET_HOTPLUG_FLAG  0x56494104 /* 'VIA\04' */
+#define VIAFB_GET_RESOLUTION    0x56494105 /* 'VIA\05' */
+#define VIAFB_GET_TV_TYPE       0x56494106 /* 'VIA\06' */
+#define VIAFB_GET_SAMM_INFO       0x56494107 /* 'VIA\07' */
+#define VIAFB_TURN_ON_OUTPUT_DEVICE       0x56494108 /* 'VIA\08' */
+#define VIAFB_TURN_OFF_OUTPUT_DEVICE       0x56494109 /* 'VIA\09' */
+#define VIAFB_SET_DEVICE        0x5649410A=20
+#define VIAFB_GET_DEVICE        0x5649410B=20
+#define VIAFB_SET_TV_COLOR_DEFAULT  0x5649410C /* 'VIA\0C' */
+#define VIAFB_SET_TV_BRIGHTNESS     0x5649410D /* 'VIA\0D' */
+#define VIAFB_SET_TV_CONTRAST       0x5649410E /* 'VIA\0E' */
+#define VIAFB_SET_TV_SATURATION     0x5649410F /* 'VIA\0F' */
+#define VIAFB_SET_TV_TINT           0x56494110 /* 'VIA\10' */
+#define VIAFB_SET_TV_FFILTER        0x56494111 /* 'VIA\11' */
+#define VIAFB_GET_DRIVER_VERSION    0x56494112 /* 'VIA\12' */
+#define VIAFB_GET_CHIP_INFO   0x56494113 /* 'VIA\13' */
+#define VIAFB_SET_DEVICE_INFO               0x56494114 /* 'VIA\14' */
+#define VIAFB_GET_DEVICE_INFO               0x56494115 /* 'VIA\15' */
+#define VIAFB_SET_TV_POSITION               0x56494116=20
+#define VIAFB_SET_TV_SIZE                   0x56494117=20
+#define VIAFB_GET_DEVICE_SUPPORT            0x56494118=20
+#define VIAFB_GET_DEVICE_CONNECT            0x56494119=20
+#define VIAFB_GET_PANEL_SUPPORT_EXPAND      0x5649411A=20
+#define VIAFB_GET_TV_SUPPORT_SIGNAL         0x5649411B=20
+#define VIAFB_GET_TV_SUPPORT_STANDARD       0x5649411C=20
+#define VIAFB_GET_TV_MAX_SIZE               0x5649411D=20
+#define VIAFB_GET_TV_MAX_POSITION           0x5649411E=20
+#define VIAFB_GET_TV_SUPPORT_TUNING_ITEM    0x5649411F=20
+#define VIAFB_GET_TV_MAX_TUNING_VALUE       0x56494120=20
+#define VIAFB_GET_TV_SUPPORT_SETTING_ITEM   0x56494121=20
+#define VIAFB_GET_DRIVER_NAME               0x56494122=20
+#define VIAFB_GET_DEVICE_SUPPORT_STATE      0x56494123=20
+#define VIAFB_GET_GAMMA_LUT                 0x56494124=20
+#define VIAFB_SET_GAMMA_LUT                 0x56494125=20
+#define VIAFB_GET_GAMMA_SUPPORT_STATE       0x56494126=20
+#define VIAFB_SET_VIDEO_DEVICE              0x56494127=20
+#define VIAFB_GET_VIDEO_DEVICE              0x56494128=20
+#define VIAFB_SET_SECOND_MODE               0x56494129=20
+
+/* Re-define value to sync with xserver driver. (Bitwise) */
+#define None_Device 0x00
+#define CRT_Device  0x01
+#define LCD_Device  0x02
+#define TV_Device   0x04
+#define DVI_Device  0x08
+#define CRT2_Device 0x10
+#define HDTV_Device 0x20
+#define LCD2_Device 0x40
+
+/* Flags which are used to control operations of TV. (Bitwise) */
+#define OP_TV_SYSTEM                     0x0001
+#define OP_TV_LEVEL                      0x0002
+#define OP_TV_OUT_SIGNAL                 0x0004
+#define OP_TV_DEDOTCRAWL                 0x0008
+#define OP_TV_BRIGHTNESS                 0x0010  =20
+#define OP_TV_CONTRAST                   0x0020  =20
+#define OP_TV_SATURATION                 0x0040 =20
+#define OP_TV_TINT                       0x0080 =20
+#define OP_TV_POSITION                   0x0100
+#define OP_TV_SETTING_FFILTER            0x0200  =20
+#define OP_TV_TUNING_FFILTER             0x0400  =20
+#define OP_TV_SETTING_ADAPTIVE_FFILTER   0x0800
+#define OP_TV_TUNING_ADAPTIVE_FFILTER    0x1000
+
+
+
+/* Flags which are used to control operations of LCD. (Bitwise) */
+#define OP_LCD_CENTERING   0x01
+#define OP_LCD_PANEL_ID    0x02
+#define OP_LCD_MODE        0x03
+
+/* SAMM operation flag */
+#define OP_SAMM            0x80
+=20
+/* Define maximum value of tv/lcd items. */
+/* The setting value of tv/lcd must be smaller than corresponding =
maximum value */
+#define TV_STANDARD_MAXIMUM           0x20   =20
+#define TV_SIZE_LEVEL_MAXIMUM         0x02         =20
+#define TV_OUT_SIGNAL_MAXIMUM         0x100
+#define TV_FFILTER_MAXIMUM            3
+#define TV_BRIGHTNESS_MAXIMUM         255
+#define TV_CONTRAST_MAXIMUM           255
+#define TV_ADAPTIVE_FFILTER_MAXIMUM   255
+#define TV_SATURATION_MAXIMUM         65535
+#define TV_TINT_MAXIMUM               2047
+#define TV_HOR_POSITION_MAXIMUM       15
+#define TV_VER_POSITION_MAXIMUM       15
+#define LCD_PANEL_ID_MAXIMUM          19
+
+=20
+#define STATE_ON            0x1
+#define STATE_OFF           0x0
+#define STATE_DEFAULT       0xFFFF
+
+#define MAX_ACTIVE_DEV_NUM  2
+
+
+typedef struct{
+  unsigned short crt:1;
+  unsigned short dvi:1;
+  unsigned short tv:1;
+  unsigned short lcd:1;
+  unsigned short samm:1;
+  unsigned short primary_dev;
+
+  unsigned short lcd_dsp_cent:1;
+  unsigned char lcd_panel_id;
+  unsigned char lcd_mode:1;
+
+  unsigned char tv_out_sig;
+  unsigned short tv_level:2;
+  unsigned short tv_system;
+  unsigned short tv_dedotcrawl:1;
+  unsigned short xres,yres;
+  unsigned short xres1,yres1;
+  unsigned short refresh;
+  unsigned short bpp;
+  unsigned short refresh1;
+  unsigned short bpp1;
+  unsigned short sequence;
+ =20
+  unsigned short epia_dvi:1;
+  unsigned short lcd_dual_edge:1;
+  unsigned short bus_width;
+  unsigned short lcd2:1;
+} device_t;
+
+
+struct viafb_ioctl_info {
+    u32     viafb_id;               /* for identifying viafb */
+#define VIAID       0x56494146      /* Identify myself with 'VIAF' */
+    u16     vendor_id;
+    u16     device_id;
+    u8      version;
+    u8      revision;
+    u8      reserved[246];          /* for future use */
+};
+
+struct viafb_ioctl_mode {
+    u32     xres;
+    u32     yres;
+    u32     refresh;
+    u32     bpp;
+    u32     xres_sec;
+    u32     yres_sec;
+    u32     virtual_xres_sec;
+    u32     virtual_yres_sec;
+    u32     refresh_sec;
+    u32     bpp_sec;
+};
+struct viafb_ioctl_samm {
+    u32     samm_status;
+    u32     size_prim;=20
+    u32     size_sec;
+    u32     mem_base;
+    u32     offset_sec;=20
+};
+
+struct viafb_driver_version {
+    int     iMajorNum;
+    int     iKernelNum;
+    int     iOSNum;
+    int     iMinorNum;
+};
+
+/* This structure contains variable attributes of TV. */
+struct viafb_ioctl_tv_attribute {
+    unsigned int system;
+    unsigned int level;
+    unsigned int out_signal;
+    unsigned int dedotcrawl;=20
+    unsigned int ffilter;
+    unsigned int adaptive_ffilter;
+    unsigned int brightness;
+    unsigned int contrast;
+    unsigned int saturation;
+    unsigned int tint;
+    unsigned int horizontal_pos;
+    unsigned int vertical_pos;
+    unsigned int CurrentScalH;
+    unsigned int CurrentScalV;
+    unsigned int ScalHLevel;
+    unsigned int ScalVLevel;
+    unsigned int DefaultScalH;
+    unsigned int DefaultScalV;
+    unsigned int PositionHLevel;
+    unsigned int PositionVLevel;
+    unsigned int DefaultPositionH;
+    unsigned int DefaultPositionV;
+    unsigned int ffilter_state;    =20
+    unsigned int adaptive_ffilter_state;=20
+};
+
+/* This structure contains variable attributes of LCD. */
+struct viafb_ioctl_lcd_attribute {
+    unsigned int panel_id;
+    unsigned int display_center;
+    unsigned int lcd_mode;
+};
+
+/* This structure contains all setting information of devices. */
+struct viafb_ioctl_setting {
+    unsigned short device_flag;           /* Enable or disable active =
devices */
+    unsigned short device_status;         /* Indicate which device =
should be turn on or turn off. */
+    unsigned int   tv_operation_flag;     /* Indicate which TV's =
attribute can be changed. */
+    unsigned short lcd_operation_flag;    /* Indicate which LCD's =
attribute can be changed. */
+    unsigned short samm_status;           /* 1: SAMM ON  0: SAMM OFF */
+
+    unsigned short first_dev_hor_res;     /* horizontal resolution of =
first device */
+    unsigned short first_dev_ver_res;     /* vertical resolution of =
first device */
+    unsigned short second_dev_hor_res;    /* horizontal resolution of =
second device */
+    unsigned short second_dev_ver_res;    /* vertical resolution of =
second device */
+    unsigned short first_dev_refresh;     /* refresh rate of first =
device */
+    unsigned short first_dev_bpp;         /* bpp of first device */
+    unsigned short second_dev_refresh;    /* refresh rate of second =
device */
+    unsigned short second_dev_bpp;        /* bpp of second device */
+
+    unsigned int primary_device;          /* Indicate which device are =
primary display device. */
+    unsigned int video_device_status;     /* Indicate which device will =
show video. only valid in duoview mode */
+    struct viafb_ioctl_tv_attribute tv_attributes;
+    struct viafb_ioctl_lcd_attribute lcd_attributes;
+};
+
+typedef struct _POSITIONVALUE
+{
+    unsigned int dwX;
+    unsigned int dwY;
+}POSITIONVALUE;
+#endif /* __IOCTL_H__ */
diff -Nur linux-2.6.21-rc7/drivers/video/via/lcd.c =
linux-2.6.21-rc7.viafb/drivers/video/via/lcd.c
--- linux-2.6.21-rc7/drivers/video/via/lcd.c 1969-12-31 =
19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/lcd.c 2007-04-26 =
19:52:32.000000000 -0400
@@ -0,0 +1,1630 @@
+/*
+ * Copyright 1998-2007 VIA Technologies, Inc. All Rights Reserved.
+ * Copyright 2001-2007 S3 Graphics, Inc. All Rights Reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person =
obtaining a
+ * copy of this software and associated documentation files (the =
"Software"),
+ * to deal in the Software without restriction, including without =
limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sub =
license,
+ * and/or sell copies of the Software, and to permit persons to whom =
the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the
+ * next paragraph) shall be included in all copies or substantial =
portions
+ * of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, =
EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF =
MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT =
SHALL
+ * THE AUTHOR(S) OR COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, =
DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR =
OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE =
OR OTHER
+ * DEALINGS IN THE SOFTWARE.
+ */
+#include <linux/version.h>
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,18)
+#include <linux/config.h>
+#endif
+#include <linux/ioport.h>
+#include <asm/io.h>
+
+#include "debug.h"
+#include "lcd.h"
+#include "lcdtbl.h"
+#include "chip.h"
+#include "share.h"
+#include "hw.h"
+#include "viamode.h"
+#include "hwcfig.h"
+#include "via_i2c.h"
+
+/* extern function */
+extern int i2cWriteByte(u8 slave_addr, u8 index, u8 data);
+extern int i2cReadByte(u8 slave_addr, u8 index, u8 *pData);
+extern void set_output_path(int device, int set_iga, int =
output_interface);
+extern void fill_crtc_timing(struct crt_mode_table *crt_table, int =
mode_index, int bpp_byte, int set_iga);
+extern void write_reg_mask(u8 index, int io_port, u8 data, u8 mask);
+extern void load_reg(int timing_value, int load_reg_num, struct =
io_register *reg, int io_type);
+extern struct display_timing get_timing_value(struct crt_mode_table =
*crt_table, int mode_index);
+extern void load_offset_reg(int h_addr, int bpp_byte, int set_iga);
+extern void load_fetch_count_reg(int h_addr, int bpp_byte, int =
set_iga);
+extern void write_regx(struct io_reg RegTable[],int ItemNum);
+extern int get_mode_index(int hres, int vres,int flag);
+extern void delays(int count);
+extern inline void lock_crt(void);
+extern inline void unlock_crt(void);
+extern inline u8 read_reg(int io_port, u8 index);
+extern inline void write_reg(u8 index, u16 io_port, u8 data);
+extern int SearchModeSetting(int ModeInfoIndex);
+extern void load_FIFO_reg(int set_iga, int hor_active, int ver_active);
+extern u32 get_clk_value(int clk);
+extern void SetVCLK(u32 CLK, int set_iga);
+extern void load_crtc_timing(struct display_timing device_timing, int =
set_iga);
+extern void set_color_depth(int bpp_byte, int set_iga);
+extern bool lvds_identify_vt1636(void);
+extern void init_lvds_vt1636(struct lvds_setting_information =
*plvds_setting_info, struct lvds_chip_information *plvds_chip_info);
+void disable_lvds_vt1636(struct lvds_setting_information =
*plvds_setting_info, struct lvds_chip_information *plvds_chip_info);
+void enable_lvds_vt1636(struct lvds_setting_information =
*plvds_setting_info, struct lvds_chip_information *plvds_chip_info);
+extern void vt1636_patch_skew_on_vt3324(struct lvds_setting_information =
*plvds_setting_info, struct lvds_chip_information *plvds_chip_info);
+extern void vt1636_patch_skew_on_vt3327(struct lvds_setting_information =
*plvds_setting_info, struct lvds_chip_information *plvds_chip_info);
+extern void vt1636_patch_skew_on_vt3364(struct lvds_setting_information =
*plvds_setting_info, struct lvds_chip_information *plvds_chip_info);
+
+
+/* extern struct */
+extern struct chip_information              chip_info;
+extern struct lvds_setting_information      lvds_setting_info;
+extern struct lvds_setting_information      lvds_setting_info2;
+extern struct _lcd_scaling_factor           lcd_scaling_factor;
+extern struct iga1_crtc_timing              iga1_crtc_reg;
+extern struct iga1_shadow_crtc_timing       iga1_shadow_crtc_reg;
+extern struct iga2_crtc_timing              iga2_crtc_reg;
+
+extern int lcd_panel_id;
+
+extern int SAMM_ON, LCD2_ON, LCD_ON;
+extern int display_hardware_layout;
+
+int lvds_register_read(int index);
+int fp_id_to_vindex(int panel_id);
+void load_lcd_scaling(int set_hres, int set_vres, int panel_hres, int =
panel_vres);
+void load_lcd_k400_patch_tbl(int set_hres, int set_vres, int panel_id);
+void load_lcd_p880_patch_tbl(int set_hres, int set_vres, int panel_id);
+void load_lcd_patch_regs(int set_hres, int set_vres, int panel_id, int =
set_iga);
+void VIAPitchAlignmentPatchLCD(struct lvds_setting_information =
*plvds_setting_info, struct lvds_chip_information *plvds_chip_info);
+void lcd_disable(void);
+void lcd_enable(void);
+void LCDPowerSequenceOff(void);
+void LCDPowerSequenceOn(void);
+void fill_lcd_format(void);
+void init_lvds_output_interface(struct lvds_chip_information =
*plvds_chip_info, struct lvds_setting_information* plvds_setting_info);
+struct display_timing lcd_centering_timging(struct display_timing =
mode_crt_reg, struct display_timing panel_crt_reg);
+void load_crtc_shadow_timing(struct display_timing mode_timing, struct =
display_timing panel_timing);
+void load_scaling_factor_for_p4m900(int set_hres, int set_vres, int =
panel_hres, int panel_vres);
+
+
+
+int check_lvds_chip(int device_id_subaddr, int device_id)
+{
+    if (lvds_register_read(device_id_subaddr) =3D=3D device_id)
+        return(OK);
+    else
+        return(FAIL);
+}
+
+void init_lcd_size(void)
+{
+    DEBUG_MSG(KERN_INFO "init_lcd_size()\n");
+    DEBUG_MSG(KERN_INFO "lvds_setting_info.get_lcd_size_method %d\n", =
lvds_setting_info.get_lcd_size_method);
+
+    switch(lvds_setting_info.get_lcd_size_method) {
+        case GET_LCD_SIZE_BY_SYSTEM_BIOS:
+            break;
+        case GET_LCD_SZIE_BY_HW_STRAPPING:
+            break;
+        case GET_LCD_SIZE_BY_VGA_BIOS:
+            DEBUG_MSG(KERN_INFO "Get LCD Size method by VGA BIOS =
!!\n");    =20
+            lvds_setting_info.lcd_panel_size =3D  =
fp_id_to_vindex(lcd_panel_id);
+            DEBUG_MSG(KERN_INFO "LCD Panel_ID =3D %d\n", =
lvds_setting_info.lcd_panel_id);
+            DEBUG_MSG(KERN_INFO "LCD Panel Size =3D %d\n", =
lvds_setting_info.lcd_panel_size);     =20
+            break;
+        case GET_LCD_SIZE_BY_USER_SETTING:
+            DEBUG_MSG(KERN_INFO "Get LCD Size method by user setting =
!!\n");
+            lvds_setting_info.lcd_panel_size =3D =
fp_id_to_vindex(lcd_panel_id);
+            DEBUG_MSG(KERN_INFO "LCD Panel_ID =3D %d\n", =
lvds_setting_info.lcd_panel_id);
+            DEBUG_MSG(KERN_INFO "LCD Panel Size =3D %d\n", =
lvds_setting_info.lcd_panel_size);
+            break;
+        default:
+            DEBUG_MSG(KERN_INFO "init_lcd_size fail\n");
+            lvds_setting_info.lcd_panel_id =3D LCD_PANEL_ID1_800X600;
+            lvds_setting_info.lcd_panel_size =3D =
fp_id_to_vindex(LCD_PANEL_ID1_800X600);
+    }
+    lvds_setting_info2.lcd_panel_id =3D lvds_setting_info.lcd_panel_id;
+    lvds_setting_info2.lcd_panel_size =3D =
lvds_setting_info.lcd_panel_size;
+    lvds_setting_info2.lcd_panel_hres =3D =
lvds_setting_info.lcd_panel_hres;
+    lvds_setting_info2.lcd_panel_vres =3D =
lvds_setting_info.lcd_panel_vres;
+    lvds_setting_info2.LCDDualEdge =3D lvds_setting_info.LCDDualEdge;
+    lvds_setting_info2.LCDDithering =3D lvds_setting_info.LCDDithering;
+}
+
+bool lvds_identify_integratedlvds(void)
+{
+    if (display_hardware_layout =3D=3D HW_LAYOUT_LCD_EXTERNAL_LCD2)
+    {
+        /* Two dual channel LCD (Internal LVDS + External LVDS): */
+        /* If we have an external LVDS, such as VT1636, we should have =
its chip ID already. */
+        if (chip_info.lvds_chip_info.lvds_chip_name)
+        {
+            chip_info.lvds_chip_info2.lvds_chip_name =3D =
INTEGRATED_LVDS;
+            DEBUG_MSG(KERN_INFO "Support two dual channel LVDS! =
(Internal LVDS + External LVDS)\n");
+        }
+        else
+        {
+            chip_info.lvds_chip_info.lvds_chip_name =3D =
INTEGRATED_LVDS;
+            DEBUG_MSG(KERN_INFO "Not found external LVDS, so can't =
support two dual channel LVDS!\n");
+        }
+    }
+    else if (display_hardware_layout =3D=3D HW_LAYOUT_LCD1_LCD2)
+    {
+        /* Two single channel LCD (Internal LVDS + Internal LVDS): */
+        chip_info.lvds_chip_info.lvds_chip_name =3D INTEGRATED_LVDS;
+        chip_info.lvds_chip_info2.lvds_chip_name =3D INTEGRATED_LVDS;
+        DEBUG_MSG(KERN_INFO "Support two single channel LVDS! (Internal =
LVDS + Internal LVDS)\n");
+    }
+    else if (display_hardware_layout !=3D HW_LAYOUT_DVI_ONLY)
+    {
+        /* If we have found external LVDS, just use it, otherwise, we =
will use internal LVDS as default. */
+        if (!chip_info.lvds_chip_info.lvds_chip_name)
+        {
+            chip_info.lvds_chip_info.lvds_chip_name =3D =
INTEGRATED_LVDS;
+            DEBUG_MSG(KERN_INFO "Found Integrated LVDS!\n");
+        }
+    }
+    else
+    {
+        chip_info.lvds_chip_info.lvds_chip_name =3D =
NON_LVDS_TRANSMITTER;
+        DEBUG_MSG(KERN_INFO "Do not support LVDS!\n");
+        return FALSE;
+    }
+
+    return TRUE;
+}
+
+int lvds_trasmitter_identify(void)
+{
+    u8 tmp;
+    tmp =3D chip_info.tv_chip_info.tv_chip_on_slot;
+    chip_info.tv_chip_info.tv_chip_on_slot =3D TV_ON_AMR;
+    if(lvds_identify_vt1636())
+    {
+        chip_info.lvds_chip_info.i2c_port =3D TVI2CPORTINDEX;
+        DEBUG_MSG(KERN_INFO "Found VIA VT1636 LVDS on port i2c 0x31 =
\n");
+    }else
+    {
+        chip_info.tv_chip_info.tv_chip_on_slot =3D TV_ON_AGP;
+        if(lvds_identify_vt1636())
+        {
+            chip_info.lvds_chip_info.i2c_port =3D TVGPIOPORTINDEX;
+            DEBUG_MSG(KERN_INFO "Found VIA VT1636 LVDS on port gpio =
0x2c \n");
+        }
+    }
+    chip_info.tv_chip_info.tv_chip_on_slot =3D tmp;
+   =20
+    if (chip_info.gfx_chip_name =3D=3D UNICHROME_CX700)
+    {
+        lvds_identify_integratedlvds();
+    }
+
+     if(chip_info.lvds_chip_info.lvds_chip_name)
+    {
+        return TRUE;
+    }
+    /* Check for VT1631: */
+    chip_info.lvds_chip_info.lvds_chip_name =3D VT1631_LVDS;
+    chip_info.lvds_chip_info.lvds_chip_slave_addr =3D =
VT1631_LVDS_I2C_ADDR;
+
+    if (check_lvds_chip(VT1631_DEVICE_ID_REG, VT1631_DEVICE_ID)!=3D =
FAIL)
+    {
+        DEBUG_MSG(KERN_INFO "\n VT1631 LVDS ! \n");
+        DEBUG_MSG(KERN_INFO "\n %2d", =
chip_info.lvds_chip_info.lvds_chip_name);
+        DEBUG_MSG(KERN_INFO "\n %2d", =
chip_info.lvds_chip_info.lvds_chip_name);
+        return(OK);
+    }
+
+
+    chip_info.lvds_chip_info.lvds_chip_name =3D NON_LVDS_TRANSMITTER;
+    chip_info.lvds_chip_info.lvds_chip_slave_addr =3D =
VT1631_LVDS_I2C_ADDR;
+    return(FAIL);
+}
+
+int fp_id_to_vindex(int panel_id)
+{
+    DEBUG_MSG(KERN_INFO "fp_get_panel_id()\n");
+ =20
+    if(panel_id > 0x13)
+         lcd_panel_id =3D panel_id=3D read_reg(VIACR, CR3F) & 0x0F;
+ =20
+    switch(panel_id) {
+        case 0x0:
+            lvds_setting_info.lcd_panel_hres =3D 640;
+            lvds_setting_info.lcd_panel_vres =3D 480;
+            lvds_setting_info.lcd_panel_id =3D LCD_PANEL_ID0_640X480;
+            lvds_setting_info.LCDDualEdge =3D 0;
+            lvds_setting_info.LCDDithering =3D 1;
+            return(VIA_RES_640X480);
+            break;
+        case 0x1:
+            lvds_setting_info.lcd_panel_hres =3D 800;
+            lvds_setting_info.lcd_panel_vres =3D 600;
+            lvds_setting_info.lcd_panel_id =3D LCD_PANEL_ID1_800X600;
+            lvds_setting_info.LCDDualEdge =3D 0;
+            lvds_setting_info.LCDDithering =3D 1;
+            return(VIA_RES_800X600);
+            break;
+        case 0x2:
+            lvds_setting_info.lcd_panel_hres =3D 1024;
+            lvds_setting_info.lcd_panel_vres =3D 768;
+            lvds_setting_info.lcd_panel_id =3D LCD_PANEL_ID2_1024X768;
+            lvds_setting_info.LCDDualEdge =3D 0;
+            lvds_setting_info.LCDDithering =3D 1;
+            return(VIA_RES_1024X768);
+            break;
+        case 0x3:
+            lvds_setting_info.lcd_panel_hres =3D 1280;
+            lvds_setting_info.lcd_panel_vres =3D 768;
+            lvds_setting_info.lcd_panel_id =3D LCD_PANEL_ID3_1280X768;
+            lvds_setting_info.LCDDualEdge =3D 0;
+            lvds_setting_info.LCDDithering =3D 1;
+            return(VIA_RES_1280X768);
+            break;
+        case 0x4:
+            lvds_setting_info.lcd_panel_hres =3D 1280;
+            lvds_setting_info.lcd_panel_vres =3D 1024;
+            lvds_setting_info.lcd_panel_id =3D LCD_PANEL_ID4_1280X1024;
+            lvds_setting_info.LCDDualEdge =3D 1;
+            lvds_setting_info.LCDDithering =3D 1;
+            return(VIA_RES_1280X1024);
+            break;
+        case 0x5:
+            lvds_setting_info.lcd_panel_hres =3D 1400;
+            lvds_setting_info.lcd_panel_vres =3D 1050;
+            lvds_setting_info.lcd_panel_id =3D LCD_PANEL_ID5_1400X1050;
+            lvds_setting_info.LCDDualEdge =3D 1;
+            lvds_setting_info.LCDDithering =3D 1;
+            return(VIA_RES_1400X1050);
+            break;
+        case 0x6:
+            lvds_setting_info.lcd_panel_hres =3D 1600;
+            lvds_setting_info.lcd_panel_vres =3D 1200;
+            lvds_setting_info.lcd_panel_id =3D LCD_PANEL_ID6_1600X1200;
+            lvds_setting_info.LCDDualEdge =3D 1;
+            lvds_setting_info.LCDDithering =3D 1;
+            return(VIA_RES_1600X1200);
+            break;
+        case 0x9:
+            lvds_setting_info.lcd_panel_hres =3D 1024;
+            lvds_setting_info.lcd_panel_vres =3D 768;
+            lvds_setting_info.lcd_panel_id =3D LCD_PANEL_ID2_1024X768;
+            lvds_setting_info.LCDDualEdge =3D 1;
+            lvds_setting_info.LCDDithering =3D 1;
+            return(VIA_RES_1024X768);
+            break;
+        case 0xA:
+            lvds_setting_info.lcd_panel_hres =3D 1024;
+            lvds_setting_info.lcd_panel_vres =3D 768;
+            lvds_setting_info.lcd_panel_id =3D LCD_PANEL_ID2_1024X768;
+            lvds_setting_info.LCDDualEdge =3D 0;
+            lvds_setting_info.LCDDithering =3D 0;
+            return(VIA_RES_1024X768);
+            break;
+        case 0xB:
+            lvds_setting_info.lcd_panel_hres =3D 1024;
+            lvds_setting_info.lcd_panel_vres =3D 768;
+            lvds_setting_info.lcd_panel_id =3D LCD_PANEL_ID2_1024X768;
+            lvds_setting_info.LCDDualEdge =3D 1;
+            lvds_setting_info.LCDDithering =3D 0;
+            return(VIA_RES_1024X768);
+            break;
+        case 0xC:
+            lvds_setting_info.lcd_panel_hres =3D 1280;
+            lvds_setting_info.lcd_panel_vres =3D 768;
+            lvds_setting_info.lcd_panel_id =3D LCD_PANEL_ID3_1280X768;
+            lvds_setting_info.LCDDualEdge =3D 0;
+            lvds_setting_info.LCDDithering =3D 0;
+            return(VIA_RES_1280X768);
+            break;
+        case 0xD:
+            lvds_setting_info.lcd_panel_hres =3D 1280;
+            lvds_setting_info.lcd_panel_vres =3D 1024;
+            lvds_setting_info.lcd_panel_id =3D LCD_PANEL_ID4_1280X1024;
+            lvds_setting_info.LCDDualEdge =3D 1;
+            lvds_setting_info.LCDDithering =3D 0;
+            return(VIA_RES_1280X1024);
+            break;
+        case 0xE:
+            lvds_setting_info.lcd_panel_hres =3D 1400;
+            lvds_setting_info.lcd_panel_vres =3D 1050;
+            lvds_setting_info.lcd_panel_id =3D LCD_PANEL_ID5_1400X1050;
+            lvds_setting_info.LCDDualEdge =3D 1;
+            lvds_setting_info.LCDDithering =3D 0;
+            return(VIA_RES_1400X1050);
+            break;
+        case 0xF:
+            lvds_setting_info.lcd_panel_hres =3D 1600;
+            lvds_setting_info.lcd_panel_vres =3D 1200;
+            lvds_setting_info.lcd_panel_id =3D LCD_PANEL_ID6_1600X1200;
+            lvds_setting_info.LCDDualEdge =3D 1;
+            lvds_setting_info.LCDDithering =3D 0;
+            return(VIA_RES_1600X1200);
+            break;
+        case 0x10:
+            lvds_setting_info.lcd_panel_hres =3D 1366;
+            lvds_setting_info.lcd_panel_vres =3D 768;
+            lvds_setting_info.lcd_panel_id =3D LCD_PANEL_ID7_1366X768;
+            lvds_setting_info.LCDDualEdge =3D 0;
+            lvds_setting_info.LCDDithering =3D 0;
+            return(VIA_RES_1368X768);
+            break;
+        case 0x11:        =20
+             lvds_setting_info.lcd_panel_hres =3D 1024;
+             lvds_setting_info.lcd_panel_vres =3D 600;
+             lvds_setting_info.lcd_panel_id =3D LCD_PANEL_ID8_1024X600;
+             lvds_setting_info.LCDDualEdge =3D 0;
+             lvds_setting_info.LCDDithering =3D 1;  =20
+             return(VIA_RES_1024X600);
+             break;
+     case 0x12:  =20
+            lvds_setting_info.lcd_panel_hres =3D 1280;
+            lvds_setting_info.lcd_panel_vres =3D 768;
+            lvds_setting_info.lcd_panel_id =3D LCD_PANEL_ID3_1280X768;
+            lvds_setting_info.LCDDualEdge =3D 1;
+            lvds_setting_info.LCDDithering =3D 1;
+            return(VIA_RES_1280X768);
+            break;
+        case 0x13:  =20
+            lvds_setting_info.lcd_panel_hres =3D 1280;
+            lvds_setting_info.lcd_panel_vres =3D 800;
+            lvds_setting_info.lcd_panel_id =3D LCD_PANEL_ID9_1280X800;
+            lvds_setting_info.LCDDualEdge =3D 0;
+            lvds_setting_info.LCDDithering =3D 1;
+            return(VIA_RES_1280X800);
+            break;
+        default:
+            lvds_setting_info.lcd_panel_hres =3D 800;
+            lvds_setting_info.lcd_panel_vres =3D 600;
+            lvds_setting_info.lcd_panel_id =3D LCD_PANEL_ID1_800X600;
+            lvds_setting_info.LCDDualEdge =3D 0;
+            lvds_setting_info.LCDDithering =3D 1;
+            return(VIA_RES_800X600);
+    }
+}
+
+void lvds_register_write(int index, u8 data)
+{
+    u8  tmp;
+
+    tmp =3D chip_info.tv_chip_info.tv_chip_on_slot;
+
+    chip_info.tv_chip_info.tv_chip_on_slot =3D TV_ON_AGP;
+
+    i2cWriteByte(chip_info.lvds_chip_info.lvds_chip_slave_addr, index, =
data);
+
+    chip_info.tv_chip_info.tv_chip_on_slot =3D tmp;
+
+}
+
+int lvds_register_read(int index)
+{
+    u8 data;
+    int status;
+    u8  tmp;
+
+    tmp =3D chip_info.tv_chip_info.tv_chip_on_slot;
+
+    chip_info.tv_chip_info.tv_chip_on_slot =3D TV_ON_AGP;
+    status =3D =
i2cReadByte((u8)chip_info.lvds_chip_info.lvds_chip_slave_addr, =
(u8)index, &data);
+
+    chip_info.tv_chip_info.tv_chip_on_slot =3D tmp;
+    return(data);
+}
+
+void load_lcd_scaling(int set_hres, int set_vres, int panel_hres, int =
panel_vres)
+{
+    int reg_value =3D 0;
+    int load_reg_num;
+    struct io_register *reg =3D NULL;
+
+    DEBUG_MSG(KERN_INFO "load_lcd_scaling()!!\n");
+
+    /* LCD Scaling Enable */
+    write_reg_mask(CR79, VIACR, 0x07, BIT0+BIT1+BIT2);
+
+    /* Modified form X driver code.P4M900_A0's scaling register has a=20
+       little problem on reading it. So we use another method to access =
it. */
+    if (UNICHROME_P4M900 =3D=3D chip_info.gfx_chip_name)
+    {
+        load_scaling_factor_for_p4m900(set_hres, set_vres, panel_hres, =
panel_vres);
+        return;
+    }
+
+
+    /* Check if expansion for horizontal */
+    if(set_hres !=3D panel_hres)
+    {
+        /* Load Horizontal Scaling Factor */
+        switch(chip_info.gfx_chip_name)
+        {
+            case UNICHROME_CLE266:
+            case UNICHROME_K400:
+                reg_value =3D CLE266_LCD_HOR_SCF_FORMULA(set_hres, =
panel_hres);
+                load_reg_num =3D =
lcd_scaling_factor_CLE.lcd_hor_scaling_factor.reg_num;
+                reg =3D =
lcd_scaling_factor_CLE.lcd_hor_scaling_factor.reg;
+                load_reg(reg_value, load_reg_num, reg, VIACR);        =20
+                break;
+            case UNICHROME_K800:
+            case UNICHROME_P880:
+            case UNICHROME_CN900:           =20
+            case UNICHROME_CX700:
+            case UNICHROME_K8M890:
+            case UNICHROME_P4M890:
+                reg_value =3D K800_LCD_HOR_SCF_FORMULA(set_hres, =
panel_hres);
+                write_reg_mask(CRA2, VIACR, 0xC0, BIT7+BIT6);       /* =
Horizontal scaling enabled */
+                load_reg_num =3D =
lcd_scaling_factor.lcd_hor_scaling_factor.reg_num;
+                reg =3D lcd_scaling_factor.lcd_hor_scaling_factor.reg;
+                load_reg(reg_value, load_reg_num, reg, VIACR);
+                break;
+        }
+
+        DEBUG_MSG(KERN_INFO "Horizontal Scaling value =3D %d", =
reg_value);
+    }
+    else
+    {
+        write_reg_mask(CRA2, VIACR, 0x00, BIT7);      /* Horizontal =
scaling disabled */
+    }
+
+    /* Check if expansion for vertical */
+    if(set_vres !=3D panel_vres)
+    {
+        /* Load Vertical Scaling Factor */
+        switch(chip_info.gfx_chip_name)
+        {
+            case UNICHROME_CLE266:
+            case UNICHROME_K400:
+                reg_value =3D CLE266_LCD_VER_SCF_FORMULA(set_vres, =
panel_vres);
+                load_reg_num =3D =
lcd_scaling_factor_CLE.lcd_ver_scaling_factor.reg_num;
+                reg =3D =
lcd_scaling_factor_CLE.lcd_ver_scaling_factor.reg;
+                load_reg(reg_value, load_reg_num, reg, VIACR);=20
+                break;
+            case UNICHROME_K800:
+            case UNICHROME_P880:
+            case UNICHROME_CN900:    =20
+            case UNICHROME_CX700:
+            case UNICHROME_K8M890:
+            case UNICHROME_P4M890:
+                reg_value =3D K800_LCD_VER_SCF_FORMULA(set_vres, =
panel_vres);
+                write_reg_mask(CRA2, VIACR, 0x08, BIT3);       /* =
Vertical scaling enabled */
+                load_reg_num =3D =
lcd_scaling_factor.lcd_ver_scaling_factor.reg_num;
+                reg =3D lcd_scaling_factor.lcd_ver_scaling_factor.reg;
+                load_reg(reg_value, load_reg_num, reg, VIACR);
+                break;
+        }
+
+        DEBUG_MSG(KERN_INFO "Vertical Scaling value =3D %d", =
reg_value);
+    }
+    else
+    {
+        write_reg_mask(CRA2, VIACR, 0x00, BIT3);      /* Vertical =
scaling disabled */
+    }
+}
+
+void load_lcd_k400_patch_tbl(int set_hres, int set_vres, int panel_id)
+{
+    int vmode_index;
+    int reg_num=3D0;
+    struct io_reg *lcd_patch_reg=3DNULL;
+
+    if(lvds_setting_info.iga_path=3D=3DIGA2)
+        vmode_index =3D get_mode_index(set_hres, set_vres,1);
+    else
+        vmode_index =3D get_mode_index(set_hres, set_vres,0);
+    switch(panel_id) {
+        /* LCD 800x600 */
+        case LCD_PANEL_ID1_800X600:
+            switch(vmode_index) {
+                case VIA_RES_640X400:
+                case VIA_RES_640X480:
+                    reg_num =3D NUM_TOTAL_K400_LCD_RES_6X4_8X6;
+                    lcd_patch_reg =3D K400_LCD_RES_6X4_8X6;
+                    break;
+                case VIA_RES_720X480:
+                case VIA_RES_720X576:
+                    reg_num =3D NUM_TOTAL_K400_LCD_RES_7X4_8X6;
+                    lcd_patch_reg =3D K400_LCD_RES_7X4_8X6;
+                    break;
+            }
+        break;
+
+        /* LCD 1024x768 */
+        case LCD_PANEL_ID2_1024X768:
+            switch(vmode_index) {
+                case VIA_RES_640X400:
+                case VIA_RES_640X480:
+                    reg_num =3D NUM_TOTAL_K400_LCD_RES_6X4_10X7;
+                    lcd_patch_reg =3D K400_LCD_RES_6X4_10X7;
+                    break;
+                case VIA_RES_720X480:
+                case VIA_RES_720X576:
+                    reg_num =3D NUM_TOTAL_K400_LCD_RES_7X4_10X7;
+                    lcd_patch_reg =3D K400_LCD_RES_7X4_10X7;
+                    break;
+                case VIA_RES_800X600:
+                    reg_num =3D NUM_TOTAL_K400_LCD_RES_8X6_10X7;
+                    lcd_patch_reg =3D K400_LCD_RES_8X6_10X7;
+                    break;
+            }
+        break;
+
+        /* LCD 1280x1024 */
+        case LCD_PANEL_ID4_1280X1024:
+            switch(vmode_index) {
+                case VIA_RES_640X400:
+                case VIA_RES_640X480:
+                    reg_num =3D NUM_TOTAL_K400_LCD_RES_6X4_12X10;
+                    lcd_patch_reg =3D K400_LCD_RES_6X4_12X10;
+                    break;
+                case VIA_RES_720X480:
+                case VIA_RES_720X576:
+                    reg_num =3D NUM_TOTAL_K400_LCD_RES_7X4_12X10;
+                    lcd_patch_reg =3D K400_LCD_RES_7X4_12X10;
+                    break;
+                case VIA_RES_800X600:
+                    reg_num =3D NUM_TOTAL_K400_LCD_RES_8X6_12X10;
+                    lcd_patch_reg =3D K400_LCD_RES_8X6_12X10;
+                    break;
+                case VIA_RES_1024X768:
+                    reg_num =3D NUM_TOTAL_K400_LCD_RES_10X7_12X10;
+                    lcd_patch_reg =3D K400_LCD_RES_10X7_12X10;
+                    break;
+
+            }
+        break;
+
+        /* LCD 1400x1050 */
+        case LCD_PANEL_ID5_1400X1050:
+            switch(vmode_index)
+            {
+                case VIA_RES_640X480:
+                    reg_num =3D NUM_TOTAL_K400_LCD_RES_6X4_14X10;
+                    lcd_patch_reg =3D K400_LCD_RES_6X4_14X10;
+                    break;
+                case VIA_RES_800X600:
+                    reg_num =3D NUM_TOTAL_K400_LCD_RES_8X6_14X10;
+                    lcd_patch_reg =3D K400_LCD_RES_8X6_14X10;
+                    break;
+                case VIA_RES_1024X768:
+                    reg_num =3D NUM_TOTAL_K400_LCD_RES_10X7_14X10;
+                    lcd_patch_reg =3D K400_LCD_RES_10X7_14X10;
+                    break;
+                case VIA_RES_1280X768:
+                case VIA_RES_1280X960:
+                case VIA_RES_1280X1024:
+                    reg_num =3D NUM_TOTAL_K400_LCD_RES_12X10_14X10;
+                    lcd_patch_reg =3D K400_LCD_RES_12X10_14X10;
+                    break;
+            }
+            break;
+
+        /* LCD 1600x1200 */
+        case LCD_PANEL_ID6_1600X1200:
+            switch(vmode_index) {
+                case VIA_RES_640X400:
+                case VIA_RES_640X480:
+                    reg_num =3D NUM_TOTAL_K400_LCD_RES_6X4_16X12;
+                    lcd_patch_reg =3D K400_LCD_RES_6X4_16X12;
+                    break;
+                case VIA_RES_720X480:
+                case VIA_RES_720X576:
+                    reg_num =3D NUM_TOTAL_K400_LCD_RES_7X4_16X12;
+                    lcd_patch_reg =3D K400_LCD_RES_7X4_16X12;
+                    break;
+                case VIA_RES_800X600:
+                    reg_num =3D NUM_TOTAL_K400_LCD_RES_8X6_16X12;
+                    lcd_patch_reg =3D K400_LCD_RES_8X6_16X12;
+                    break;
+                case VIA_RES_1024X768:
+                    reg_num =3D NUM_TOTAL_K400_LCD_RES_10X7_16X12;
+                    lcd_patch_reg =3D K400_LCD_RES_10X7_16X12;
+                    break;
+                case VIA_RES_1280X768:
+                case VIA_RES_1280X960:
+                case VIA_RES_1280X1024:
+                    reg_num =3D NUM_TOTAL_K400_LCD_RES_12X10_16X12;
+                    lcd_patch_reg =3D K400_LCD_RES_12X10_16X12;
+                    break;
+            }
+        break;
+
+    }
+    if (reg_num !=3D 0)
+    {
+        /* H.W. Reset : ON */
+        write_reg_mask(CR17, VIACR, 0x00, BIT7);
+
+        write_regx(lcd_patch_reg, reg_num);
+
+        /* H.W. Reset : OFF */
+        write_reg_mask(CR17, VIACR, 0x80, BIT7);
+
+        /* Reset PLL */
+        write_reg_mask(SR40, VIASR, 0x02, BIT1);
+        write_reg_mask(SR40, VIASR, 0x00, BIT1);
+
+        /* Fire! */
+        outb(inb(VIARMisc) | (BIT2+BIT3), VIAWMisc);
+    }
+}
+
+void load_lcd_p880_patch_tbl(int set_hres, int set_vres, int panel_id)
+{
+    int vmode_index;
+    int reg_num=3D0;
+    struct io_reg *lcd_patch_reg=3DNULL;
+
+    if(lvds_setting_info.iga_path=3D=3DIGA2)
+        vmode_index =3D get_mode_index(set_hres, set_vres,1);
+    else
+        vmode_index =3D get_mode_index(set_hres, set_vres,0);
+
+    switch(panel_id) {
+        case LCD_PANEL_ID5_1400X1050:
+            switch(vmode_index)
+            {
+                case VIA_RES_640X480:
+                    reg_num =3D NUM_TOTAL_P880_LCD_RES_6X4_14X10;
+                    lcd_patch_reg =3D P880_LCD_RES_6X4_14X10;
+                    break;
+                case VIA_RES_800X600:
+                    reg_num =3D NUM_TOTAL_P880_LCD_RES_8X6_14X10;
+                    lcd_patch_reg =3D P880_LCD_RES_8X6_14X10;
+                    break;
+            }
+            break;
+        case LCD_PANEL_ID6_1600X1200:
+            switch(vmode_index) {
+                case VIA_RES_640X400:
+                case VIA_RES_640X480:
+                    reg_num =3D NUM_TOTAL_P880_LCD_RES_6X4_16X12;
+                    lcd_patch_reg =3D P880_LCD_RES_6X4_16X12;
+                    break;
+                case VIA_RES_720X480:
+                case VIA_RES_720X576:
+                    reg_num =3D NUM_TOTAL_P880_LCD_RES_7X4_16X12;
+                    lcd_patch_reg =3D P880_LCD_RES_7X4_16X12;
+                    break;
+                case VIA_RES_800X600:
+                    reg_num =3D NUM_TOTAL_P880_LCD_RES_8X6_16X12;
+                    lcd_patch_reg =3D P880_LCD_RES_8X6_16X12;
+                    break;
+                case VIA_RES_1024X768:
+                    reg_num =3D NUM_TOTAL_P880_LCD_RES_10X7_16X12;
+                    lcd_patch_reg =3D P880_LCD_RES_10X7_16X12;
+                    break;
+                case VIA_RES_1280X768:
+                case VIA_RES_1280X960:
+                case VIA_RES_1280X1024:
+                    reg_num =3D NUM_TOTAL_P880_LCD_RES_12X10_16X12;
+                    lcd_patch_reg =3D P880_LCD_RES_12X10_16X12;
+                    break;
+            }
+        break;
+
+     }
+    if (reg_num !=3D 0)
+    {
+        /* H.W. Reset : ON */
+        write_reg_mask(CR17, VIACR, 0x00, BIT7);
+
+        write_regx(lcd_patch_reg, reg_num);
+
+        /* H.W. Reset : OFF */
+        write_reg_mask(CR17, VIACR, 0x80, BIT7);
+
+        /* Reset PLL */
+        write_reg_mask(SR40, VIASR, 0x02, BIT1);
+        write_reg_mask(SR40, VIASR, 0x00, BIT1);
+
+        /* Fire! */
+        outb(inb(VIARMisc) | (BIT2+BIT3), VIAWMisc);
+    }
+}
+
+void load_lcd_patch_regs(int set_hres, int set_vres, int panel_id, int =
set_iga)
+{
+    int vmode_index;
+
+    if(lvds_setting_info.iga_path=3D=3DIGA2)
+        vmode_index =3D get_mode_index(set_hres, set_vres,1);
+    else
+        vmode_index =3D get_mode_index(set_hres, set_vres,0);
+
+    unlock_crt();
+
+    /* Patch for simultaneous & Expansion */
+    if((set_iga =3D=3D IGA1_IGA2) && (lvds_setting_info.display_method =
=3D=3D LCD_EXPANDSION))
+    {
+        switch(chip_info.gfx_chip_name) {
+            case UNICHROME_CLE266:
+            case UNICHROME_K400:
+                load_lcd_k400_patch_tbl(set_hres, set_vres, panel_id);
+                break;
+            case UNICHROME_K800:
+                break;
+            case UNICHROME_P880:
+            case UNICHROME_CN900:   =20
+            case UNICHROME_CX700:
+                load_lcd_p880_patch_tbl(set_hres, set_vres, panel_id);
+        }
+    }
+
+    lock_crt();
+}
+
+void VIAPitchAlignmentPatchLCD(struct lvds_setting_information =
*plvds_setting_info, struct lvds_chip_information *plvds_chip_info)
+{
+    unsigned char     cr13, cr35, cr65, cr66, cr67;
+    unsigned long     dwScreenPitch=3D 0;
+    unsigned long     dwPitch;
+
+    dwPitch =3D plvds_setting_info->h_active * (plvds_setting_info->bpp =
>> 3);
+    if (dwPitch & 0x1F)=20
+   {   /* Is 32 Byte Alignment ? */
+        dwScreenPitch =3D ((dwPitch + 31) & ~31) >> 3;
+        if ( plvds_setting_info->iga_path=3D=3DIGA2)
+        {
+            if(plvds_setting_info->bpp>8) {    =20
+            /* When 8bpp 720xX,848xX will not do 32Byte alignment. */
+                cr66 =3D (unsigned char)(dwScreenPitch & 0xFF);
+                write_reg(CR66, VIACR, cr66);
+                cr67 =3D read_reg(VIACR, CR67) & 0xFC;
+                cr67 |=3D (unsigned char)((dwScreenPitch & 0x300) >> =
8);
+                write_reg(CR67, VIACR, cr67);
+            }
+
+            /* Fetch Count */
+            cr67 =3D read_reg(VIACR, CR67) & 0xF3;
+            cr67 |=3D (unsigned char)((dwScreenPitch & 0x600) >> 7);
+            write_reg(CR67, VIACR, cr67);
+            cr65 =3D (unsigned char)((dwScreenPitch >> 1) & 0xFF);
+            cr65 +=3D 2;
+            write_reg(CR65, VIACR, cr65);
+        }
+        else
+        {
+            if(plvds_setting_info->bpp>8) {    =20
+            /* When 8bpp 720xX,848xX will not do 32Byte alignment. */
+                cr13 =3D (unsigned char)(dwScreenPitch & 0xFF);
+                write_reg(CR13, VIACR, cr13);
+                cr35 =3D read_reg(VIACR, CR35) & 0x1F;
+                cr35 |=3D (unsigned char)((dwScreenPitch & 0x700) >> =
3);
+                write_reg(CR35, VIACR, cr35);
+            }
+        }
+    }
+}
+void lcd_patch_skew_dvp0(struct lvds_setting_information =
*plvds_setting_info, struct lvds_chip_information *plvds_chip_info)
+{
+    if(VT1636_LVDS =3D=3D plvds_chip_info->lvds_chip_name)
+    {
+        switch(chip_info.gfx_chip_name)
+        {
+            case UNICHROME_P4M900:
+                vt1636_patch_skew_on_vt3364(plvds_setting_info, =
plvds_chip_info);
+                break;
+            case UNICHROME_P4M890:
+                vt1636_patch_skew_on_vt3327(plvds_setting_info, =
plvds_chip_info);
+                break;
+        }
+    }
+}
+void lcd_patch_skew_dvp1(struct lvds_setting_information =
*plvds_setting_info, struct lvds_chip_information *plvds_chip_info)
+{
+    if(VT1636_LVDS =3D=3D plvds_chip_info->lvds_chip_name)
+    {
+        switch(chip_info.gfx_chip_name)
+        {
+            case UNICHROME_CX700:
+                vt1636_patch_skew_on_vt3324(plvds_setting_info, =
plvds_chip_info);
+                break;
+        }
+    }
+}
+void lcd_patch_skew(struct lvds_setting_information =
*plvds_setting_info, struct lvds_chip_information *plvds_chip_info)
+{
+    DEBUG_MSG(KERN_INFO "lcd_patch_skew\n");
+    switch (plvds_chip_info->output_interface)
+    {
+        case INTERFACE_DVP0:
+            lcd_patch_skew_dvp0(plvds_setting_info, plvds_chip_info);
+            break;
+        case INTERFACE_DVP1:
+            lcd_patch_skew_dvp1(plvds_setting_info, plvds_chip_info);
+            break;
+        case INTERFACE_DFP_LOW:
+            if (UNICHROME_P4M900 =3D=3D chip_info.gfx_chip_name)
+            {
+                write_reg_mask(CR99, VIACR, 0x08, BIT0+BIT1+BIT2+BIT3);
+            }
+            break;
+    }
+}
+
+/* LCD Set Mode */
+void lcd_set_mode(struct crt_mode_table *mode_crt_table, struct =
lvds_setting_information *plvds_setting_info, struct =
lvds_chip_information *plvds_chip_info)
+{
+    int video_index =3D plvds_setting_info->lcd_panel_size;
+    int set_iga =3D plvds_setting_info->iga_path;
+    int mode_bpp =3D plvds_setting_info->bpp;
+    int load_reg_num=3D0;
+    int reg_value=3D0;
+    int set_hres, set_vres;
+    int panel_hres, panel_vres;
+    u32 pll_D_N;
+    int offset;
+    struct io_register      *reg =3D NULL;
+    struct display_timing   mode_crt_reg, panel_crt_reg;
+    struct crt_mode_table   *panel_crt_table;
+    struct VideoModeTable   *vmode_tbl;
+
+    DEBUG_MSG(KERN_INFO "LCD_Set_Mode!, expansion:%d\n", =
plvds_setting_info->display_method);
+
+    mode_crt_reg =3D mode_crt_table->crtc;                        /* =
Get mode table */
+
+    vmode_tbl =3D &CLE266Modes[SearchModeSetting(video_index)];   /* =
Get panel table */
+    panel_crt_table =3D vmode_tbl->crtc;
+    panel_crt_reg =3D panel_crt_table->crtc;
+
+    set_hres =3D plvds_setting_info->h_active;
+    set_vres =3D plvds_setting_info->v_active;
+    panel_hres =3D plvds_setting_info->lcd_panel_hres;
+    panel_vres =3D plvds_setting_info->lcd_panel_vres;
+    if(VT1636_LVDS =3D=3D plvds_chip_info->lvds_chip_name)
+    {
+        init_lvds_vt1636(plvds_setting_info, plvds_chip_info);
+    }
+    plvds_setting_info->vclk =3D panel_crt_table->clk;
+    if (set_iga =3D=3D IGA1)
+    {
+        /* IGA1 doesn't have LCD scaling, so set it as centering. */
+        load_crtc_timing(lcd_centering_timging(mode_crt_reg, =
panel_crt_reg), IGA1);
+    }
+    else
+    {
+        /* Expansion */
+        if ((plvds_setting_info->display_method =3D=3D LCD_EXPANDSION) =
&
+            ((set_hres !=3D panel_hres ) || (set_vres !=3D =
panel_vres)))
+        {
+            /* expansion timing IGA2 always loaded panel set timing */
+            load_crtc_timing(panel_crt_reg, IGA2);
+            load_lcd_scaling(set_hres, set_vres, panel_hres, =
panel_vres);
+        }
+        else /* Centering */
+        {
+            /* centering timing IGA2 always loaded panel and mode =
releative timing */
+            load_crtc_timing(lcd_centering_timging(mode_crt_reg, =
panel_crt_reg), IGA2);
+            write_reg_mask(CR79, VIACR, 0x00, BIT0+BIT1+BIT2);          =
/* LCD scaling disabled */
+        }
+    }
+
+    if (set_iga =3D=3D IGA1_IGA2)
+    {
+        load_crtc_shadow_timing(mode_crt_reg, panel_crt_reg);       /* =
Fill shadow registers */
+
+        switch(plvds_setting_info->lcd_panel_id)
+        {
+            case LCD_PANEL_ID0_640X480:
+                offset =3D 80;
+                break;
+            case LCD_PANEL_ID1_800X600:
+                offset =3D 110;
+                break;
+            case LCD_PANEL_ID2_1024X768:
+                offset =3D 150;
+                break;
+            case LCD_PANEL_ID3_1280X768:
+            case LCD_PANEL_ID4_1280X1024:
+            case LCD_PANEL_ID5_1400X1050:
+                offset =3D 190;
+                break;
+            case LCD_PANEL_ID6_1600X1200:
+                offset =3D 250;
+                break;
+            case LCD_PANEL_ID7_1366X768:
+                offset =3D 212;
+                break;
+            default:
+                offset =3D 140;
+                break;
+        }
+
+        /* Offset for simultaneous */
+        reg_value =3D offset;
+        load_reg_num =3D offset_reg.iga2_offset_reg.reg_num;
+        reg =3D offset_reg.iga2_offset_reg.reg;
+        load_reg(reg_value, load_reg_num, reg, VIACR);
+
+        load_fetch_count_reg(set_hres, 4, IGA2);                        =
/* Fetch count for simultaneous*/
+    }
+    else  /* SAMM */
+    {
+        load_offset_reg(set_hres, mode_bpp/8, set_iga);                 =
   /* Offset for IGA2 only */
+        load_fetch_count_reg(set_hres, mode_bpp/8, set_iga);            =
   /* Fetch count for IGA2 only */
+
+        if((chip_info.gfx_chip_name !=3D UNICHROME_CLE266) && =
(chip_info.gfx_chip_name !=3D UNICHROME_K400))
+            load_FIFO_reg(set_iga, set_hres, set_vres);
+
+        set_color_depth(mode_bpp/8, set_iga);       =20
+    }
+
+    fill_lcd_format();
+
+    pll_D_N =3D get_clk_value(panel_crt_table[0].clk);
+    DEBUG_MSG(KERN_INFO "PLL=3D0x%x", pll_D_N);
+    SetVCLK(pll_D_N, set_iga);
+
+    set_output_path(DEVICE_LCD, set_iga, =
plvds_chip_info->output_interface);
+    lcd_patch_skew(plvds_setting_info, plvds_chip_info);
+
+    /* If K8M800, enable LCD Prefetch Mode. */
+    if((chip_info.gfx_chip_name =3D=3D UNICHROME_K800) || =
(UNICHROME_K8M890 =3D=3D chip_info.gfx_chip_name))
+    {
+        write_reg_mask(CR6A, VIACR, 0x01, BIT0);
+    }
+
+    load_lcd_patch_regs(set_hres, set_vres, =
plvds_setting_info->lcd_panel_id, set_iga);
+
+    /* Patch for non 32bit alignment mode */
+    VIAPitchAlignmentPatchLCD(plvds_setting_info, plvds_chip_info);
+}
+
+void integrated_lvds_disable(struct lvds_setting_information =
*plvds_setting_info, struct lvds_chip_information *plvds_chip_info)
+{
+    bool turn_off_first_powersequence =3D FALSE;
+    bool turn_off_second_powersequence =3D FALSE;
+   if(INTERFACE_LVDS0LVDS1 =3D=3D plvds_chip_info->output_interface)
+    {
+        turn_off_first_powersequence =3D TRUE;
+    }
+    if(INTERFACE_LVDS0 =3D=3D plvds_chip_info->output_interface)
+    {
+        turn_off_first_powersequence =3D TRUE;
+    }
+    if(INTERFACE_LVDS1 =3D=3D plvds_chip_info->output_interface)
+    {
+        turn_off_second_powersequence =3D TRUE;
+    }
+    if (turn_off_second_powersequence)
+    {
+        /* Use second power sequence control: */
+
+        /* Turn off power sequence. */
+        write_reg_mask(CRD4, VIACR, 0, BIT1);
+
+        /* Turn off back light. */
+        write_reg_mask(CRD3, VIACR, 0xC0, BIT6+BIT7);
+    }
+    if(turn_off_first_powersequence)
+    {
+        /* Use first power sequence control: */
+
+        /* Turn off power sequence. */
+        write_reg_mask(CR6A, VIACR, 0, BIT3);
+
+        /* Turn off back light. */
+        write_reg_mask(CR91, VIACR, 0xC0, BIT6+BIT7);
+    }
+
+    /* Turn DFP High/Low Pad off. */
+    write_reg_mask(SR2A, VIASR, 0, BIT0+BIT1+BIT2+BIT3);
+
+    /* Power off LVDS channel. */
+    switch (plvds_chip_info->output_interface)
+    {
+        case INTERFACE_LVDS0:
+        {
+            write_reg_mask(CRD2, VIACR, 0x80, BIT7);
+            break;
+        }
+
+        case INTERFACE_LVDS1:
+        {
+            write_reg_mask(CRD2, VIACR, 0x40, BIT6);
+            break;
+        }
+
+        case INTERFACE_LVDS0LVDS1:
+        {
+            write_reg_mask(CRD2, VIACR, 0xC0, BIT6+BIT7);
+            break;
+        }
+    }
+}
+
+void integrated_lvds_enable(struct lvds_setting_information =
*plvds_setting_info, struct lvds_chip_information *plvds_chip_info)
+{
+    bool turn_on_first_powersequence =3D FALSE;
+    bool turn_on_second_powersequence =3D FALSE;
+    DEBUG_MSG(KERN_INFO "integrated_lvds_enable, out_interface:%d\n", =
plvds_chip_info->output_interface);
+    /* Panel mode for VT3324 integrated LVDS. */
+    if (plvds_setting_info->lcd_mode =3D=3D LCD_SPWG)
+    {           =20
+     write_reg_mask(CRD2, VIACR, 0x00, BIT0+BIT1);
+    }
+    else /* lcd_mode =3D=3D OPEN LDI */
+    {
+     write_reg_mask(CRD2, VIACR, 0x03, BIT0+BIT1);
+    }
+    if(INTERFACE_LVDS0LVDS1 =3D=3D plvds_chip_info->output_interface)
+    {
+        turn_on_first_powersequence =3D TRUE;
+    }
+    if(INTERFACE_LVDS0 =3D=3D plvds_chip_info->output_interface)
+    {
+        turn_on_first_powersequence =3D TRUE;
+    }
+    if(INTERFACE_LVDS1 =3D=3D plvds_chip_info->output_interface)
+    {
+        turn_on_second_powersequence =3D TRUE;
+    }
+   =20
+    if (turn_on_second_powersequence)
+    {
+        /* Use second power sequence control: */
+       =20
+        /* Use hardware control power sequence. */
+        write_reg_mask(CRD3, VIACR, 0, BIT0);
+
+        /* Turn on back light. */
+        write_reg_mask(CRD3, VIACR, 0, BIT6+BIT7);
+
+        /* Turn on hardware power sequence. */
+        write_reg_mask(CRD4, VIACR, 0x02, BIT1);
+    }
+    if(turn_on_first_powersequence)
+    {
+        /* Use first power sequence control: */
+       =20
+        /* Use hardware control power sequence. */
+        write_reg_mask(CR91, VIACR, 0, BIT0);
+
+        /* Turn on back light. */
+        write_reg_mask(CR91, VIACR, 0, BIT6+BIT7);
+
+        /* Turn on hardware power sequence. */
+        write_reg_mask(CR6A, VIACR, 0x08, BIT3);
+    }
+   =20
+    /* Turn DFP High/Low pad on. */
+    write_reg_mask(SR2A, VIASR, 0x0F, BIT0+BIT1+BIT2+BIT3);
+
+    /* Power on LVDS channel. */
+    switch (plvds_chip_info->output_interface)
+    {
+        case INTERFACE_LVDS0:
+        {
+            write_reg_mask(CRD2, VIACR, 0, BIT7);
+            break;
+        }
+
+        case INTERFACE_LVDS1:
+        {
+            write_reg_mask(CRD2, VIACR, 0, BIT6);
+            break;
+        }
+
+        case INTERFACE_LVDS0LVDS1:
+        {
+            write_reg_mask(CRD2, VIACR, 0, BIT6+BIT7);
+            break;
+        }
+    }
+}
+
+void lcd_disable(void)
+{
+
+    if (chip_info.gfx_chip_name =3D=3D UNICHROME_CLE266)
+    {
+        LCDPowerSequenceOff();
+        write_reg_mask(SR1E, VIASR, 0x00, 0x30);        /* DI1 pad off  =
           */
+    }
+    else if(chip_info.gfx_chip_name =3D=3D UNICHROME_CX700)
+    {
+        if (LCD2_ON && (INTEGRATED_LVDS =3D=3D =
chip_info.lvds_chip_info2.lvds_chip_name))
+        {
+            integrated_lvds_disable(&lvds_setting_info2, =
&chip_info.lvds_chip_info2);
+        }
+        if (INTEGRATED_LVDS =3D=3D =
chip_info.lvds_chip_info.lvds_chip_name)
+        {
+            integrated_lvds_disable(&lvds_setting_info, =
&chip_info.lvds_chip_info);
+        }
+        if (VT1636_LVDS =3D=3D chip_info.lvds_chip_info.lvds_chip_name)
+        {
+            disable_lvds_vt1636(&lvds_setting_info, =
&chip_info.lvds_chip_info);
+        }
+    }
+    else if(VT1636_LVDS =3D=3D chip_info.lvds_chip_info.lvds_chip_name)
+    {
+        disable_lvds_vt1636(&lvds_setting_info, =
&chip_info.lvds_chip_info);
+    }
+    else
+    {
+        write_reg_mask(SR2A, VIASR, 0x00, 0x0F);        /* DFP-HL pad =
off          */
+        write_reg_mask(SR3D, VIASR, 0x00, 0x20);        /* Backlight =
off           */
+        write_reg_mask(CR91, VIACR, 0x80, 0x80);        /* 24 bit DI =
data paht off */
+        write_reg_mask(CR6B, VIACR, 0x00, 0x08);        /* Simultaneout =
disabled   */
+    }
+
+    write_reg_mask(CR79, VIACR, 0x00, 0x01);            /* Disable =
expansion bit   */
+    write_reg_mask(SR16, VIASR, 0x00, 0x40);            /* CRT path set =
to IGA1    */
+    write_reg_mask(CR6B, VIACR, 0x00, 0x08);            /* Simultaneout =
disabled   */
+    write_reg_mask(CR6A, VIACR, 0x00, 0x80);            /* IGA2 path =
disabled      */
+
+}
+
+void lcd_enable(void)
+{
+    if (chip_info.gfx_chip_name =3D=3D UNICHROME_CLE266)
+    {
+        write_reg_mask(SR1E, VIASR, 0x30, 0x30);        /* DI1 pad on   =
           */
+        LCDPowerSequenceOn();
+    }
+    else if(chip_info.gfx_chip_name =3D=3D UNICHROME_CX700)
+    {
+        if (LCD2_ON && (INTEGRATED_LVDS =3D=3D =
chip_info.lvds_chip_info2.lvds_chip_name))
+        {
+            integrated_lvds_enable(&lvds_setting_info2, =
&chip_info.lvds_chip_info2);
+        }
+        if (INTEGRATED_LVDS =3D=3D =
chip_info.lvds_chip_info.lvds_chip_name)
+        {
+            integrated_lvds_enable(&lvds_setting_info, =
&chip_info.lvds_chip_info);
+        }
+        if (VT1636_LVDS =3D=3D chip_info.lvds_chip_info.lvds_chip_name)
+        {
+            enable_lvds_vt1636(&lvds_setting_info, =
&chip_info.lvds_chip_info);
+        }
+    }
+    else if(VT1636_LVDS =3D=3D chip_info.lvds_chip_info.lvds_chip_name)
+    {
+        enable_lvds_vt1636(&lvds_setting_info, =
&chip_info.lvds_chip_info);
+    }
+    else
+    {
+        write_reg_mask(SR2A, VIASR, 0x0F, 0x0F);        /* DFP-HL pad =
on           */
+        write_reg_mask(SR3D, VIASR, 0x20, 0x20);        /* Backlight on =
           */
+        write_reg_mask(CR91, VIACR, 0x00, 0x80);        /* 24 bit DI =
data paht on  */
+       =20
+        /* Set data source selection bit by iga path */
+        if (lvds_setting_info.iga_path =3D=3D IGA1)
+        {
+            write_reg_mask(CR97, VIACR, 0x00, 0x10);    /* DFP-H set to =
IGA1       */
+            write_reg_mask(CR99, VIACR, 0x00, 0x10);    /* DFP-L set to =
IGA1       */
+        }
+        else
+        {
+            write_reg_mask(CR97, VIACR, 0x10, 0x10);    /* DFP-H set to =
IGA2       */
+            write_reg_mask(CR99, VIACR, 0x10, 0x10);    /* DFP-L set to =
IGA2       */
+        }
+       =20
+        write_reg_mask(CR6A, VIACR, 0x48, 0x48);        /* LCD enabled  =
           */
+    }
+
+    if ((lvds_setting_info.iga_path =3D=3D =
IGA1)||(lvds_setting_info.iga_path =3D=3D IGA1_IGA2))
+    {
+        write_reg_mask(SR16, VIASR, 0x40, 0x40);        /* CRT path set =
to IGA2    */
+        write_reg_mask(CR6A, VIACR, 0x00, 0x80);        /* IGA2 path =
disabled      */
+    }
+    else    /* IGA2 */
+    {
+        write_reg_mask(CR6A, VIACR, 0x80, 0x80);        /* IGA2 path =
enabled       */
+    }
+
+}
+
+void LCDPowerSequenceOff(void)
+{
+    int  i, mask, data;
+
+    /* Software control power sequence */
+    write_reg_mask(CR91, VIACR, 0x11, 0x11);
+
+    for (i =3D 0; i < 3; i++)
+    {
+        mask =3D PowerSequenceOff[0][i];
+        data =3D PowerSequenceOff[1][i] & mask;
+        write_reg_mask(CR91, VIACR, (u8)data, (u8)mask);
+        delays(PowerSequenceOff[2][i]);
+    }
+
+    /* Disable LCD */
+    write_reg_mask(CR6A, VIACR, 0x00, 0x08);
+}
+
+void LCDPowerSequenceOn(void)
+{
+    int  i, mask, data;
+
+    /* Software control power sequence */
+    write_reg_mask(CR91, VIACR, 0x11, 0x11);
+
+    /* Enable LCD */
+    write_reg_mask(CR6A, VIACR, 0x08, 0x08);
+
+    for (i =3D 0; i < 3; i++)
+    {
+         mask =3D PowerSequenceOn[0][i];
+         data =3D PowerSequenceOn[1][i] & mask;
+         write_reg_mask(CR91, VIACR, (u8)data, (u8)mask);
+         delays(PowerSequenceOn[2][i]);
+     }
+
+     delays(1);
+}
+
+void fill_lcd_format(void)
+{
+    u8  bdithering =3D 0, bdual =3D 0;
+
+    if(lvds_setting_info.LCDDualEdge)
+    {
+        bdual =3D BIT4;
+    }
+    if(lvds_setting_info.LCDDithering)
+    {
+        bdithering =3D BIT0;
+    }
+
+    write_reg_mask(CR88, VIACR, (bdithering | bdual), BIT4+BIT0);   /* =
Dual & Dithering */
+}
+
+void check_diport_of_integrated_lvds(struct lvds_chip_information =
*plvds_chip_info, struct lvds_setting_information* plvds_setting_info)
+{
+    /* Determine LCD DI Port by hardware layout. */
+    switch (display_hardware_layout)
+    {
+        case HW_LAYOUT_LCD_ONLY:
+        {
+            if (plvds_setting_info->LCDDualEdge)
+            {
+                plvds_chip_info->output_interface =3D =
INTERFACE_LVDS0LVDS1;
+            }
+            else
+            {
+                plvds_chip_info->output_interface =3D INTERFACE_LVDS0;
+            }
+           =20
+            break;
+        }
+
+        case HW_LAYOUT_DVI_ONLY:
+        {
+            plvds_chip_info->output_interface =3D INTERFACE_NONE;       =
    =20
+            break;
+        }
+
+        case HW_LAYOUT_LCD1_LCD2:
+        case HW_LAYOUT_LCD_EXTERNAL_LCD2:
+        {
+            plvds_chip_info->output_interface =3D INTERFACE_LVDS0LVDS1; =
          =20
+            break;
+        }
+
+        case HW_LAYOUT_LCD_DVI:
+        {
+            plvds_chip_info->output_interface =3D INTERFACE_LVDS1;
+            break;
+        }
+
+        default:
+        {
+            plvds_chip_info->output_interface =3D INTERFACE_LVDS1;
+            break;
+        }
+    }
+
+    DEBUG_MSG(KERN_INFO "Display Hardware Layout: 0x%x, LCD DI Port: =
0x%x\n", display_hardware_layout, plvds_chip_info->output_interface);
+}
+
+void init_lvds_output_interface(struct lvds_chip_information =
*plvds_chip_info, struct lvds_setting_information* plvds_setting_info)
+{
+    if(INTERFACE_NONE !=3D plvds_chip_info->output_interface)
+    {
+        /* Do nothing, lcd port is specified by module parameter */
+        return;
+    }
+    switch(plvds_chip_info->lvds_chip_name)
+    {
+
+        case  VT1636_LVDS:
+            switch(chip_info.gfx_chip_name)
+            {
+                case UNICHROME_CX700:
+                    plvds_chip_info->output_interface =3D =
INTERFACE_DVP1;
+                    break;
+                case UNICHROME_CN900:
+                    plvds_chip_info->output_interface =3D =
INTERFACE_DFP_LOW;
+                    break;
+                default:
+                    plvds_chip_info->output_interface =3D =
INTERFACE_DVP0;
+                    break;
+            }
+            break;
+           =20
+        /* Add for VT3324 integrated LVDS. */
+        case INTEGRATED_LVDS:
+            check_diport_of_integrated_lvds(plvds_chip_info, =
plvds_setting_info);
+            break;
+           =20
+        default:
+            switch(chip_info.gfx_chip_name)
+            {
+                /* Modified from X driver. For the case VT1637 (PCIE =
LVDS Transmitter)=20
+                   on VT3336/VT3327, we should use DFP Low to enable =
LCD.=20
+                   FixMe!! We should find a better method to do this. =
*/
+                case UNICHROME_K8M890:
+                case UNICHROME_P4M900:
+                case UNICHROME_P4M890:
+                    plvds_chip_info->output_interface =3D =
INTERFACE_DFP_LOW;
+                    break;
+                default:
+                    plvds_chip_info->output_interface =3D =
INTERFACE_DFP;
+                    break;
+            }
+            break;
+    }
+}
+
+struct display_timing lcd_centering_timging(struct display_timing =
mode_crt_reg, struct display_timing panel_crt_reg)
+{
+    struct display_timing crt_reg;
+
+    crt_reg.hor_total =3D panel_crt_reg.hor_total;
+    crt_reg.hor_addr =3D mode_crt_reg.hor_addr;
+    crt_reg.hor_blank_start =3D (panel_crt_reg.hor_addr - =
mode_crt_reg.hor_addr)/2 + crt_reg.hor_addr;
+    crt_reg.hor_blank_end =3D panel_crt_reg.hor_blank_end;
+    crt_reg.hor_sync_start =3D (panel_crt_reg.hor_sync_start - =
panel_crt_reg.hor_blank_start) + crt_reg.hor_blank_start;
+    crt_reg.hor_sync_end =3D panel_crt_reg.hor_sync_end;
+
+    crt_reg.ver_total =3D panel_crt_reg.ver_total;
+    crt_reg.ver_addr =3D mode_crt_reg.ver_addr;
+    crt_reg.ver_blank_start =3D (panel_crt_reg.ver_addr - =
mode_crt_reg.ver_addr)/2 + crt_reg.ver_addr;
+    crt_reg.ver_blank_end =3D panel_crt_reg.ver_blank_end;
+    crt_reg.ver_sync_start =3D (panel_crt_reg.ver_sync_start - =
panel_crt_reg.ver_blank_start) + crt_reg.ver_blank_start;
+    crt_reg.ver_sync_end =3D panel_crt_reg.ver_sync_end;
+
+    return crt_reg;
+}
+
+void load_crtc_shadow_timing(struct display_timing mode_timing, struct =
display_timing panel_timing)
+{
+    struct io_register  *reg =3D NULL;
+    int                 i;
+    int                 load_reg_Num =3D 0;
+    int                 reg_value =3D 0;
+
+    if(lvds_setting_info.display_method =3D=3D LCD_EXPANDSION)      /* =
Expansion */
+    {
+       for(i=3D12;i<20;i++)
+       {
+          switch(i)
+          {
+           case H_TOTAL_SHADOW_INDEX:
+                reg_value =3D =
IGA2_HOR_TOTAL_SHADOW_FORMULA(panel_timing.hor_total);
+                load_reg_Num =3D =
iga2_shadow_crtc_reg.hor_total_shadow.reg_num;
+                reg =3D iga2_shadow_crtc_reg.hor_total_shadow.reg;
+                break;
+           case H_BLANK_END_SHADOW_INDEX:
+                reg_value =3D =
IGA2_HOR_BLANK_END_SHADOW_FORMULA(panel_timing.hor_blank_start, =
panel_timing.hor_blank_end);
+                load_reg_Num =3D =
iga2_shadow_crtc_reg.hor_blank_end_shadow.reg_num;
+                reg =3D iga2_shadow_crtc_reg.hor_blank_end_shadow.reg;
+                break;
+           case V_TOTAL_SHADOW_INDEX:
+                reg_value =3D =
IGA2_VER_TOTAL_SHADOW_FORMULA(panel_timing.ver_total);
+                load_reg_Num =3D =
iga2_shadow_crtc_reg.ver_total_shadow.reg_num;
+                reg =3D iga2_shadow_crtc_reg.ver_total_shadow.reg;
+                break;
+           case V_ADDR_SHADOW_INDEX:
+                reg_value =3D =
IGA2_VER_ADDR_SHADOW_FORMULA(panel_timing.ver_addr);
+                load_reg_Num =3D =
iga2_shadow_crtc_reg.ver_addr_shadow.reg_num;
+                reg =3D iga2_shadow_crtc_reg.ver_addr_shadow.reg;
+                break;
+           case V_BLANK_SATRT_SHADOW_INDEX:
+                reg_value =3D =
IGA2_VER_BLANK_START_SHADOW_FORMULA(panel_timing.ver_blank_start);
+                load_reg_Num =3D =
iga2_shadow_crtc_reg.ver_blank_start_shadow.reg_num;
+                reg =3D =
iga2_shadow_crtc_reg.ver_blank_start_shadow.reg;
+                break;
+           case V_BLANK_END_SHADOW_INDEX:
+                reg_value =3D =
IGA2_VER_BLANK_END_SHADOW_FORMULA(panel_timing.ver_blank_start, =
panel_timing.ver_blank_end);
+                load_reg_Num =3D =
iga2_shadow_crtc_reg.ver_blank_end_shadow.reg_num;
+                reg =3D iga2_shadow_crtc_reg.ver_blank_end_shadow.reg;
+                break;
+           case V_SYNC_SATRT_SHADOW_INDEX:
+                reg_value =3D =
IGA2_VER_SYNC_START_SHADOW_FORMULA(panel_timing.ver_sync_start);
+                load_reg_Num =3D =
iga2_shadow_crtc_reg.ver_sync_start_shadow.reg_num;
+                reg =3D iga2_shadow_crtc_reg.ver_sync_start_shadow.reg;
+                break;
+           case V_SYNC_END_SHADOW_INDEX:
+                reg_value =3D =
IGA2_VER_SYNC_END_SHADOW_FORMULA(panel_timing.ver_sync_start, =
panel_timing.ver_sync_end);
+                load_reg_Num =3D =
iga2_shadow_crtc_reg.ver_sync_end_shadow.reg_num;
+                reg =3D iga2_shadow_crtc_reg.ver_sync_end_shadow.reg;
+                break;
+          }
+          load_reg(reg_value, load_reg_Num, reg, VIACR);
+       }
+    }
+    else    /* Centering */
+    {
+       for(i=3D12;i<20;i++)
+       {
+          switch(i)
+          {
+           case H_TOTAL_SHADOW_INDEX:
+                reg_value =3D =
IGA2_HOR_TOTAL_SHADOW_FORMULA(panel_timing.hor_total);
+                load_reg_Num =3D =
iga2_shadow_crtc_reg.hor_total_shadow.reg_num;
+                reg =3D iga2_shadow_crtc_reg.hor_total_shadow.reg;
+                break;
+           case H_BLANK_END_SHADOW_INDEX:
+                reg_value =3D =
IGA2_HOR_BLANK_END_SHADOW_FORMULA(panel_timing.hor_blank_start, =
panel_timing.hor_blank_end);
+                load_reg_Num =3D =
iga2_shadow_crtc_reg.hor_blank_end_shadow.reg_num;
+                reg =3D iga2_shadow_crtc_reg.hor_blank_end_shadow.reg;
+                break;
+           case V_TOTAL_SHADOW_INDEX:
+                reg_value =3D =
IGA2_VER_TOTAL_SHADOW_FORMULA(panel_timing.ver_total);
+                load_reg_Num =3D =
iga2_shadow_crtc_reg.ver_total_shadow.reg_num;
+                reg =3D iga2_shadow_crtc_reg.ver_total_shadow.reg;
+                break;
+           case V_ADDR_SHADOW_INDEX:
+                reg_value =3D =
IGA2_VER_ADDR_SHADOW_FORMULA(mode_timing.ver_addr);
+                load_reg_Num =3D =
iga2_shadow_crtc_reg.ver_addr_shadow.reg_num;
+                reg =3D iga2_shadow_crtc_reg.ver_addr_shadow.reg;
+                break;
+           case V_BLANK_SATRT_SHADOW_INDEX:
+                reg_value =3D =
IGA2_VER_BLANK_START_SHADOW_FORMULA(mode_timing.ver_blank_start);
+                load_reg_Num =3D =
iga2_shadow_crtc_reg.ver_blank_start_shadow.reg_num;
+                reg =3D =
iga2_shadow_crtc_reg.ver_blank_start_shadow.reg;
+                break;
+           case V_BLANK_END_SHADOW_INDEX:
+                reg_value =3D =
IGA2_VER_BLANK_END_SHADOW_FORMULA(panel_timing.ver_blank_start, =
panel_timing.ver_blank_end);
+                load_reg_Num =3D =
iga2_shadow_crtc_reg.ver_blank_end_shadow.reg_num;
+                reg =3D iga2_shadow_crtc_reg.ver_blank_end_shadow.reg;
+                break;
+           case V_SYNC_SATRT_SHADOW_INDEX:
+                reg_value =3D =
IGA2_VER_SYNC_START_SHADOW_FORMULA((panel_timing.ver_sync_start - =
panel_timing.ver_blank_start) + (panel_timing.ver_addr - =
mode_timing.ver_addr)/2 + mode_timing.ver_addr);
+                load_reg_Num =3D =
iga2_shadow_crtc_reg.ver_sync_start_shadow.reg_num;
+                reg =3D iga2_shadow_crtc_reg.ver_sync_start_shadow.reg;
+                break;
+           case V_SYNC_END_SHADOW_INDEX:
+                reg_value =3D =
IGA2_VER_SYNC_END_SHADOW_FORMULA((panel_timing.ver_sync_start - =
panel_timing.ver_blank_start) + (panel_timing.ver_addr - =
mode_timing.ver_addr)/2 + mode_timing.ver_addr, =
panel_timing.ver_sync_end);
+                load_reg_Num =3D =
iga2_shadow_crtc_reg.ver_sync_end_shadow.reg_num;
+                reg =3D iga2_shadow_crtc_reg.ver_sync_end_shadow.reg;
+                break;
+          }
+          load_reg(reg_value, load_reg_Num, reg, VIACR);
+       }
+    }
+}
+
+
+=20
+/*    Purpose:
+ *        To know if current chip are mobile.
+ *    Parameter:
+ *        mobile: a pointer to a boolean value which is used to =
received the mobile status.=20
+ */
+bool lcd_get_mobile_state(bool* mobile)
+{
+    unsigned char *romptr, *tableptr;  =20
+    u8 core_base;
+    unsigned char* biosptr;
+    u32 romaddr =3D 0x000C0000; /* Rom address */
+    u16 start_pattern =3D (u16)NULL;
+   =20
+    biosptr=3Dioremap(romaddr,0x10000);
+   =20
+    memcpy(&start_pattern, biosptr, 2);
+    if (start_pattern =3D=3D 0xAA55) /* Compare pattern */
+    {
+        /* Get the start of Table */
+        romptr =3D biosptr + 0x1B; /* 0x1B means BIOS offset position =
*/
+        tableptr =3D biosptr + *((u16 *)romptr);
+
+        /* Get the start of biosver structure */
+        romptr =3D tableptr + 18; /* 18 means BIOS version position. */
+        romptr =3D biosptr + *((u16 *)romptr);
+
+        /* The offset should be 44, but the actual image is less three =
char. */
+        romptr +=3D 41;
+
+        core_base =3D *romptr++;       =20
+   =20
+        if (core_base & 0x8)
+        {
+            *mobile =3D FALSE;           =20
+        }
+        else
+        {
+            *mobile =3D TRUE;           =20
+        }
+       =20
+        iounmap(biosptr); /* release memory */
+       =20
+        return TRUE;   =20
+    }
+    else
+    {
+        iounmap(biosptr);
+        return FALSE;
+    }
+}
+
+/* Modified form X driver code to support P4M900 */
+void load_scaling_factor_for_p4m900(int set_hres, int set_vres, int =
panel_hres, int panel_vres)
+{
+    int     h_scaling_factor;
+    int     v_scaling_factor;
+    u8   cra2 =3D 0;
+    u8   cr77 =3D 0;
+    u8   cr78 =3D 0;
+    u8   cr79 =3D 0;
+    u8   cr9f =3D 0;
+        /* Check if expansion for horizontal */
+    if(set_hres < panel_hres)
+    {
+        /* Load Horizontal Scaling Factor */
+   =20
+        /* For VIA_K8M800 or later chipsets. */
+        h_scaling_factor =3D K800_LCD_HOR_SCF_FORMULA(set_hres, =
panel_hres);
+        cr9f =3D h_scaling_factor & 0x0003; /* HSCaleFactor[1:0] at =
CR9F[1:0] */       =20
+        cr77 =3D (h_scaling_factor & 0x03FC)>>2; /* HSCaleFactor[9:2] =
at CR77[7:0] */       =20
+        cr79 =3D (h_scaling_factor & 0x0C00)>>10; /* =
HSCaleFactor[11:10] at CR79[5:4] */
+        cr79 <<=3D 4;
+       =20
+        /* Horizontal scaling enabled */
+        cra2 =3D 0xC0;
+       =20
+        DEBUG_MSG(KERN_INFO "Horizontal Scaling value =3D %d\n", =
h_scaling_factor);
+    }
+    else
+    {
+        /* Horizontal scaling disabled */
+        cra2 =3D 0x00;       =20
+    }
+
+   =20
+    /* Check if expansion for vertical */
+    if(set_vres < panel_vres)
+    {
+        /* Load Vertical Scaling Factor */
+       =20
+        /* For VIA_K8M800 or later chipsets. */
+        v_scaling_factor =3D K800_LCD_VER_SCF_FORMULA(set_vres, =
panel_vres);
+       =20
+        /* Vertical scaling enabled */
+        cra2 |=3D 0x08;
+        cr79 |=3D ((v_scaling_factor & 0x0001)<<3); /* VSCaleFactor[0] =
at CR79[3] */               =20
+        cr78 |=3D (v_scaling_factor & 0x01FE) >> 1; /* =
VSCaleFactor[8:1] at CR78[7:0] */       =20
+        cr79 |=3D ((v_scaling_factor & 0x0600) >> 9) << 6; /* =
VSCaleFactor[10:9] at CR79[7:6] */
+       =20
+        DEBUG_MSG(KERN_INFO "Vertical Scaling value =3D %d\n", =
v_scaling_factor);
+    }
+    else
+    {
+        /* Vertical scaling disabled */
+        cra2 |=3D 0x00;     =20
+    }
+
+    write_reg_mask(CRA2, VIACR, cra2, BIT3+BIT6+BIT7);
+    write_reg_mask(CR77, VIACR, cr77, 0xFF);
+    write_reg_mask(CR78, VIACR, cr78, 0xFF);
+    write_reg_mask(CR79, VIACR, cr79, 0xF8);
+    write_reg_mask(CR9F, VIACR, cr9f, BIT0+BIT1);
+}
+
diff -Nur linux-2.6.21-rc7/drivers/video/via/lcd.h =
linux-2.6.21-rc7.viafb/drivers/video/via/lcd.h
--- linux-2.6.21-rc7/drivers/video/via/lcd.h 1969-12-31 =
19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/lcd.h 2007-04-26 =
19:52:32.000000000 -0400
@@ -0,0 +1,57 @@
+ /*
+ * Copyright 1998-2007 VIA Technologies, Inc. All Rights Reserved.
+ * Copyright 2001-2007 S3 Graphics, Inc. All Rights Reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person =
obtaining a
+ * copy of this software and associated documentation files (the =
"Software"),
+ * to deal in the Software without restriction, including without =
limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sub =
license,
+ * and/or sell copies of the Software, and to permit persons to whom =
the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the
+ * next paragraph) shall be included in all copies or substantial =
portions
+ * of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, =
EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF =
MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT =
SHALL
+ * THE AUTHOR(S) OR COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, =
DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR =
OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE =
OR OTHER
+ * DEALINGS IN THE SOFTWARE.
+ */
+=20
+
+#ifndef __LCD_H__
+#define __LCD_H__
+
+/* Definition TMDS Device ID register */
+#define     VT1631_DEVICE_ID_REG        0x02
+#define     VT1631_DEVICE_ID            0x92
+
+
+#define     VT3271_DEVICE_ID_REG        0x02
+#define     VT3271_DEVICE_ID            0x71
+
+
+#define     GET_LCD_SIZE_BY_SYSTEM_BIOS     0x01
+#define     GET_LCD_SIZE_BY_VGA_BIOS        0x02
+#define     GET_LCD_SZIE_BY_HW_STRAPPING    0x03
+#define     GET_LCD_SIZE_BY_USER_SETTING    0x04
+
+
+
+/* Definition DVI Panel ID */
+#define     LCD_PANEL_ID0_640X480       0x00        /* Resolution: =
640x480,   Channel: single, Dithering: Enable */
+#define     LCD_PANEL_ID1_800X600       0x01        /* Resolution: =
800x600,   Channel: single, Dithering: Enable */
+#define     LCD_PANEL_ID2_1024X768      0x02        /* Resolution: =
1024x768,  Channel: single, Dithering: Enable */
+#define     LCD_PANEL_ID3_1280X768      0x03        /* Resolution: =
1280x768,  Channel: single, Dithering: Enable */
+#define     LCD_PANEL_ID4_1280X1024     0x04        /* Resolution: =
1280x1024, Channel: dual,   Dithering: Enable */
+#define     LCD_PANEL_ID5_1400X1050     0x05        /* Resolution: =
1400x1050, Channel: dual,   Dithering: Enable */
+#define     LCD_PANEL_ID6_1600X1200     0x06        /* Resolution: =
1600x1200, Channel: dual,   Dithering: Enable */
+#define     LCD_PANEL_ID7_1366X768      0x07        /* Resolution: =
1366x768,  Channel: single, Dithering: Disable */
+#define     LCD_PANEL_ID8_1024X600      0x08        /* Resolution: =
1024x600,  Channel: single, Dithering: Enable */ =20
+#define     LCD_PANEL_ID9_1280X800      0x09        /* Resolution: =
1280x800,  Channel: single, Dithering: Enable */ =20
+
+#endif /* __LCD_H__ */
diff -Nur linux-2.6.21-rc7/drivers/video/via/lcdtbl.h =
linux-2.6.21-rc7.viafb/drivers/video/via/lcdtbl.h
--- linux-2.6.21-rc7/drivers/video/via/lcdtbl.h 1969-12-31 =
19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/lcdtbl.h 2007-04-26 =
19:52:32.000000000 -0400
@@ -0,0 +1,303 @@
+ /*
+ * Copyright 1998-2007 VIA Technologies, Inc. All Rights Reserved.
+ * Copyright 2001-2007 S3 Graphics, Inc. All Rights Reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person =
obtaining a
+ * copy of this software and associated documentation files (the =
"Software"),
+ * to deal in the Software without restriction, including without =
limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sub =
license,
+ * and/or sell copies of the Software, and to permit persons to whom =
the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the
+ * next paragraph) shall be included in all copies or substantial =
portions
+ * of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, =
EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF =
MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT =
SHALL
+ * THE AUTHOR(S) OR COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, =
DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR =
OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE =
OR OTHER
+ * DEALINGS IN THE SOFTWARE.
+ */
+=20
+
+#ifndef __LCDTBL_H__
+#define __LCDTBL_H__
+
+#include "share.h"
+
+/* CLE266 Software Power Sequence */
+/* {Mask}, {Data}, {Delay} */
+int PowerSequenceOn[3][3] =3D {{0x10, 0x08, 0x06}, {0x10, 0x08, 0x06}, =
{0x19, 0x1FE, 0x01}};
+int PowerSequenceOff[3][3] =3D {{0x06, 0x08, 0x10}, {0x00, 0x00, 0x00}, =
{0xD2, 0x19, 0x01}};
+
+/* ++++++ P880 ++++++ */
+/*   Panel 1600x1200   */
+struct io_reg P880_LCD_RES_6X4_16X12[]  =3D {
+  {VIACR,CR50,0xFF,0x73},{VIACR,CR55,0x0F,0x08},                       =
/* IGA2 Horizontal Total            */
+  =
{VIACR,CR53,0xFF,0x73},{VIACR,CR54,0x38,0x00},{VIACR,CR5D,0x40,0x40},/* =
IGA2 Horizontal Blank End        */
+  {VIACR,CR6D,0xFF,0x5A},{VIACR,CR71,0x08,0x00},                       =
/* IGA2 Horizontal Total Shadow     */
+  {VIACR,CR6E,0xFF,0x5E},                                              =
/* IGA2 Horizontal Blank End Shadow */
+  {VIACR,CR66,0xFF,0xD6},{VIACR,CR67,0x03,0x00},                       =
/* IGA2 Offset                      */
+  {VIASR,SR44,0xFF,0x7D},{VIASR,SR45,0xFF,0x8C},{VIASR,SR46,0xFF,0x02} =
/* VCLK                             */
+};
+#define NUM_TOTAL_P880_LCD_RES_6X4_16X12 =
ARRAY_SIZE(P880_LCD_RES_6X4_16X12)
+
+struct io_reg P880_LCD_RES_7X4_16X12[]  =3D {
+  {VIACR,CR50,0xFF,0x67},{VIACR,CR55,0x0F,0x08},                       =
/* IGA2 Horizontal Total            */
+  =
{VIACR,CR53,0xFF,0x67},{VIACR,CR54,0x38,0x00},{VIACR,CR5D,0x40,0x40},/* =
IGA2 Horizontal Blank End        */
+  {VIACR,CR6D,0xFF,0x74},{VIACR,CR71,0x08,0x00},                       =
/* IGA2 Horizontal Total Shadow     */
+  {VIACR,CR6E,0xFF,0x78},                                              =
/* IGA2 Horizontal Blank End Shadow */=20
+  {VIACR,CR66,0xFF,0xF5},{VIACR,CR67,0x03,0x00},                       =
/* IGA2 Offset                      */
+  {VIASR,SR44,0xFF,0x78},{VIASR,SR45,0xFF,0x8C},{VIASR,SR46,0xFF,0x01} =
/* VCLK                             */
+};
+#define NUM_TOTAL_P880_LCD_RES_7X4_16X12 =
ARRAY_SIZE(P880_LCD_RES_7X4_16X12)
+
+struct io_reg P880_LCD_RES_8X6_16X12[]  =3D {
+  {VIACR,CR50,0xFF,0x65},{VIACR,CR55,0x0F,0x08},                       =
/* IGA2 Horizontal Total            */
+  =
{VIACR,CR53,0xFF,0x65},{VIACR,CR54,0x38,0x00},{VIACR,CR5D,0x40,0x40},/* =
IGA2 Horizontal Blank End        */
+  {VIACR,CR6D,0xFF,0x7F},{VIACR,CR71,0x08,0x00},                       =
/* IGA2 Horizontal Total Shadow     */
+  {VIACR,CR6E,0xFF,0x83},                                              =
/* IGA2 Horizontal Blank End Shadow */
+  {VIACR,CR66,0xFF,0xE1},{VIACR,CR67,0x03,0x00},                       =
/* IGA2 Offset                      */
+  {VIASR,SR44,0xFF,0x6D},{VIASR,SR45,0xFF,0x88},{VIASR,SR46,0xFF,0x03} =
/* VCLK                             */
+};
+#define NUM_TOTAL_P880_LCD_RES_8X6_16X12 =
ARRAY_SIZE(P880_LCD_RES_8X6_16X12)
+
+struct io_reg P880_LCD_RES_10X7_16X12[]  =3D {
+  {VIACR,CR50,0xFF,0x65},{VIACR,CR55,0x0F,0x08},                       =
/* IGA2 Horizontal Total            */
+  =
{VIACR,CR53,0xFF,0x65},{VIACR,CR54,0x38,0x00},{VIACR,CR5D,0x40,0x40},/* =
IGA2 Horizontal Blank End        */
+  {VIACR,CR6D,0xFF,0xAB},{VIACR,CR71,0x08,0x00},                       =
/* IGA2 Horizontal Total Shadow     */
+  {VIACR,CR6E,0xFF,0xAF},                                              =
/* IGA2 Horizontal Blank End Shadow */
+  {VIACR,CR66,0xFF,0xF0},{VIACR,CR67,0x03,0x00},                       =
/* IGA2 Offset                      */
+  {VIASR,SR44,0xFF,0x92},{VIASR,SR45,0xFF,0x88},{VIASR,SR46,0xFF,0x03} =
/* VCLK                             */
+};
+#define NUM_TOTAL_P880_LCD_RES_10X7_16X12 =
ARRAY_SIZE(P880_LCD_RES_10X7_16X12)
+
+struct io_reg P880_LCD_RES_12X10_16X12[]  =3D {
+  {VIACR,CR50,0xFF,0x7D},{VIACR,CR55,0x0F,0x08},                       =
/* IGA2 Horizontal Total            */
+  =
{VIACR,CR53,0xFF,0x7D},{VIACR,CR54,0x38,0x00},{VIACR,CR5D,0x40,0x40},/* =
IGA2 Horizontal Blank End        */
+  {VIACR,CR6D,0xFF,0xD0},{VIACR,CR71,0x08,0x00},                       =
/* IGA2 Horizontal Total Shadow     */
+  {VIACR,CR6E,0xFF,0xD4},                                              =
/* IGA2 Horizontal Blank End Shadow */
+  {VIACR,CR66,0xFF,0xFA},{VIACR,CR67,0x03,0x00},                       =
/* IGA2 Offset                      */
+  {VIASR,SR44,0xFF,0xF6},{VIASR,SR45,0xFF,0x88},{VIASR,SR46,0xFF,0x05} =
/* VCLK                             */
+};
+#define NUM_TOTAL_P880_LCD_RES_12X10_16X12 =
ARRAY_SIZE(P880_LCD_RES_12X10_16X12)
+
+/*   Panel 1400x1050   */
+static struct io_reg P880_LCD_RES_6X4_14X10[]    =3D {                  =
  /* 640x480                          */
+  {VIACR,CR50,0xFF,0x9D},{VIACR,CR55,0x0F,0x56},                        =
/* IGA2 Horizontal Total            */
+  {VIACR,CR53,0xFF,0x9D},{VIACR,CR54,0x38,0x75},{VIACR,CR5D,0x40,0x24}, =
/* IGA2 Horizontal Blank End        */
+  {VIACR,CR6D,0xFF,0x5F},{VIACR,CR71,0x08,0x44},                        =
/* IGA2 Horizontal Total Shadow     */
+  {VIACR,CR6E,0xFF,0x63},                                               =
/* IGA2 Horizontal Blank End Shadow */
+  {VIACR,CR66,0xFF,0xB4},{VIACR,CR67,0x03,0x00},                        =
/* IGA2 Offset                      */
+  {VIASR,SR44,0xFF,0xC6},{VIASR,SR45,0xFF,0x8C},{VIASR,SR46,0xFF,0x05}  =
/* VCLK                             */
+};
+#define NUM_TOTAL_P880_LCD_RES_6X4_14X10 =
ARRAY_SIZE(P880_LCD_RES_6X4_14X10)
+
+static struct io_reg P880_LCD_RES_8X6_14X10[]    =3D {                  =
  /* 800x600                          */
+  {VIACR,CR50,0xFF,0x9D},{VIACR,CR55,0x0F,0x56},                        =
/* IGA2 Horizontal Total            */
+  {VIACR,CR53,0xFF,0x9D},{VIACR,CR54,0x38,0x75},{VIACR,CR5D,0x40,0x24}, =
/* IGA2 Horizontal Blank End        */
+  {VIACR,CR6D,0xFF,0x7F},{VIACR,CR71,0x08,0x44},                        =
/* IGA2 Horizontal Total Shadow     */
+  {VIACR,CR6E,0xFF,0x83},                                               =
/* IGA2 Horizontal Blank End Shadow */
+  {VIACR,CR66,0xFF,0xBE},{VIACR,CR67,0x03,0x00},                        =
/* IGA2 Offset                      */
+  {VIASR,SR44,0xFF,0x06},{VIASR,SR45,0xFF,0x8D},{VIASR,SR46,0xFF,0x05}  =
/* VCLK                             */
+};
+#define NUM_TOTAL_P880_LCD_RES_8X6_14X10 =
ARRAY_SIZE(P880_LCD_RES_8X6_14X10)
+
+
+/* ++++++ K400 ++++++ */
+/*   Panel 1600x1200   */
+struct io_reg K400_LCD_RES_6X4_16X12[]  =3D {
+  {VIACR,CR50,0xFF,0x73},{VIACR,CR55,0x0F,0x08},                        =
 /* IGA2 Horizontal Total            */
+  {VIACR,CR53,0xFF,0x73},{VIACR,CR54,0x38,0x00},{VIACR,CR5D,0x40,0x40}, =
 /* IGA2 Horizontal Blank End        */
+  {VIACR,CR6D,0xFF,0x5A},{VIACR,CR71,0x08,0x00},                        =
 /* IGA2 Horizontal Total Shadow     */
+  {VIACR,CR6E,0xFF,0x5E},                                               =
 /* IGA2 Horizontal Blank End Shadow */
+  {VIACR,CR66,0xFF,0xDA},{VIACR,CR67,0x03,0x00},                        =
 /* IGA2 Offset                      */
+  {VIASR,SR46,0xFF,0xC4},{VIASR,SR47,0xFF,0x7F}                         =
 /* VCLK                             */
+};
+#define NUM_TOTAL_K400_LCD_RES_6X4_16X12 =
ARRAY_SIZE(K400_LCD_RES_6X4_16X12)
+
+struct io_reg K400_LCD_RES_7X4_16X12[]  =3D {
+  {VIACR,CR50,0xFF,0x67},{VIACR,CR55,0x0F,0x08},                        =
 /* IGA2 Horizontal Total            */
+  {VIACR,CR53,0xFF,0x67},{VIACR,CR54,0x38,0x00},{VIACR,CR5D,0x40,0x40}, =
 /* IGA2 Horizontal Blank End        */
+  {VIACR,CR6D,0xFF,0x74},{VIACR,CR71,0x08,0x00},                        =
 /* IGA2 Horizontal Total Shadow     */
+  {VIACR,CR6E,0xFF,0x78},                                               =
 /* IGA2 Horizontal Blank End Shadow */
+  {VIACR,CR66,0xFF,0xF5},{VIACR,CR67,0x03,0x00},                        =
 /* IGA2 Offset                      */
+  {VIASR,SR46,0xFF,0x46},{VIASR,SR47,0xFF,0x3D}                         =
 /* VCLK                             */
+};
+#define NUM_TOTAL_K400_LCD_RES_7X4_16X12 =
ARRAY_SIZE(K400_LCD_RES_7X4_16X12)
+
+struct io_reg K400_LCD_RES_8X6_16X12[]  =3D {
+  {VIACR,CR50,0xFF,0x65},{VIACR,CR55,0x0F,0x08},                        =
 /* IGA2 Horizontal Total            */
+  {VIACR,CR53,0xFF,0x65},{VIACR,CR54,0x38,0x00},{VIACR,CR5D,0x40,0x40}, =
 /* IGA2 Horizontal Blank End        */=20
+  {VIACR,CR6D,0xFF,0x7F},{VIACR,CR71,0x08,0x00},                        =
 /* IGA2 Horizontal Total Shadow     */
+  {VIACR,CR6E,0xFF,0x83},                                               =
 /* IGA2 Horizontal Blank End Shadow */
+  {VIACR,CR66,0xFF,0xE1},{VIACR,CR67,0x03,0x00},                        =
 /* IGA2 Offset                      */
+  {VIASR,SR46,0xFF,0x85},{VIASR,SR47,0xFF,0x6F}                         =
 /* VCLK                             */
+};
+#define NUM_TOTAL_K400_LCD_RES_8X6_16X12 =
ARRAY_SIZE(K400_LCD_RES_8X6_16X12)
+
+struct io_reg K400_LCD_RES_10X7_16X12[]  =3D {
+  {VIACR,CR50,0xFF,0x65},{VIACR,CR55,0x0F,0x08},                        =
 /* IGA2 Horizontal Total            */
+  {VIACR,CR53,0xFF,0x65},{VIACR,CR54,0x38,0x00},{VIACR,CR5D,0x40,0x40}, =
 /* IGA2 Horizontal Blank End        */=20
+  {VIACR,CR6D,0xFF,0xAB},{VIACR,CR71,0x08,0x00},                        =
 /* IGA2 Horizontal Total Shadow     */
+  {VIACR,CR6E,0xFF,0xAF},                                               =
 /* IGA2 Horizontal Blank End Shadow */
+  {VIACR,CR66,0xFF,0xF0},{VIACR,CR67,0x03,0x00},                        =
 /* IGA2 Offset                      */
+  {VIASR,SR46,0xFF,0x45},{VIASR,SR47,0xFF,0x4A}                         =
 /* VCLK                             */
+};
+#define NUM_TOTAL_K400_LCD_RES_10X7_16X12 =
ARRAY_SIZE(K400_LCD_RES_10X7_16X12)
+
+struct io_reg K400_LCD_RES_12X10_16X12[]  =3D {
+  {VIACR,CR50,0xFF,0x7D},{VIACR,CR55,0x0F,0x08},                        =
 /* IGA2 Horizontal Total            */
+  {VIACR,CR53,0xFF,0x7D},{VIACR,CR54,0x38,0x00},{VIACR,CR5D,0x40,0x40}, =
 /* IGA2 Horizontal Blank End        */
+  {VIACR,CR6D,0xFF,0xD0},{VIACR,CR71,0x08,0x00},                        =
 /* IGA2 Horizontal Total Shadow     */
+  {VIACR,CR6E,0xFF,0xD4},                                               =
 /* IGA2 Horizontal Blank End Shadow */
+  {VIACR,CR66,0xFF,0xFA},{VIACR,CR67,0x03,0x00},                        =
 /* IGA2 Offset                      */
+  {VIASR,SR46,0xFF,0x47},{VIASR,SR47,0xFF,0x7C}                         =
 /* VCLK                             */
+};
+#define NUM_TOTAL_K400_LCD_RES_12X10_16X12 =
ARRAY_SIZE(K400_LCD_RES_12X10_16X12)
+
+/*   Panel 1400x1050   */
+static struct io_reg K400_LCD_RES_6X4_14X10[]  =3D {                    =
  /* 640x400                          */
+  {VIACR,CR50,0xFF,0x9D},{VIACR,CR55,0x0F,0x56},                        =
/* IGA2 Horizontal Total            */
+  {VIACR,CR53,0xFF,0x9D},{VIACR,CR54,0x38,0x75},{VIACR,CR5D,0x40,0x24}, =
/* IGA2 Horizontal Blank End        */
+  {VIACR,CR6D,0xFF,0x5F},{VIACR,CR71,0x08,0x44},                        =
/* IGA2 Horizontal Total Shadow     */
+  {VIACR,CR6E,0xFF,0x63},                                               =
/* IGA2 Horizontal Blank End Shadow */
+  {VIACR,CR66,0xFF,0xB4},{VIACR,CR67,0x03,0x00},                        =
/* IGA2 Offset                      */
+  {VIASR,SR46,0xFF,0x07},{VIASR,SR47,0xFF,0x19}    /* VCLK        */
+};
+#define NUM_TOTAL_K400_LCD_RES_6X4_14X10 =
ARRAY_SIZE(K400_LCD_RES_6X4_14X10)
+
+static struct io_reg K400_LCD_RES_8X6_14X10[]  =3D {                    =
  /* 800x600                          */
+  {VIACR,CR50,0xFF,0x9D},{VIACR,CR55,0x0F,0x56},                        =
/* IGA2 Horizontal Total            */
+  {VIACR,CR53,0xFF,0x9D},{VIACR,CR54,0x38,0x75},{VIACR,CR5D,0x40,0x24}, =
/* IGA2 Horizontal Blank End        */
+  {VIACR,CR6D,0xFF,0x7F},{VIACR,CR71,0x08,0x44},                        =
/* IGA2 Horizontal Total Shadow     */
+  {VIACR,CR6E,0xFF,0x83},                                               =
/* IGA2 Horizontal Blank End Shadow */
+  {VIACR,CR66,0xFF,0xBE},{VIACR,CR67,0x03,0x00},                        =
/* IGA2 Offset                      */
+  {VIASR,SR46,0xFF,0x07},{VIASR,SR47,0xFF,0x21}                         =
/* VCLK                             */
+};
+#define NUM_TOTAL_K400_LCD_RES_8X6_14X10 =
ARRAY_SIZE(K400_LCD_RES_8X6_14X10)
+
+static struct io_reg K400_LCD_RES_10X7_14X10[]  =3D {                   =
  /* 1024x768                         */
+  {VIACR,CR50,0xFF,0x9D},{VIACR,CR55,0x0F,0x56},                        =
/* IGA2 Horizontal Total            */
+  {VIACR,CR53,0xFF,0x9D},{VIACR,CR54,0x38,0x75},{VIACR,CR5D,0x40,0x24}, =
/* IGA2 Horizontal Blank End        */
+  {VIACR,CR6D,0xFF,0xA3},{VIACR,CR71,0x08,0x44},                        =
/* IGA2 Horizontal Total Shadow     */
+  {VIACR,CR6E,0xFF,0xA7},                                               =
/* IGA2 Horizontal Blank End Shadow */
+  {VIACR,CR66,0xFF,0xC3},{VIACR,CR67,0x03,0x04},                        =
/* IGA2 Offset                      */
+  {VIASR,SR46,0xFF,0x05},{VIASR,SR47,0xFF,0x1E}                         =
/* VCLK                             */
+};
+#define NUM_TOTAL_K400_LCD_RES_10X7_14X10 =
ARRAY_SIZE(K400_LCD_RES_10X7_14X10)
+
+static struct io_reg K400_LCD_RES_12X10_14X10[]  =3D {                  =
  /* 1280x768, 1280x960, 1280x1024    */
+  {VIACR,CR50,0xFF,0x97},{VIACR,CR55,0x0F,0x56},                        =
/* IGA2 Horizontal Total            */
+  {VIACR,CR53,0xFF,0x97},{VIACR,CR54,0x38,0x75},{VIACR,CR5D,0x40,0x24}, =
/* IGA2 Horizontal Blank End        */
+  {VIACR,CR6D,0xFF,0xCE},{VIACR,CR71,0x08,0x44},                        =
/* IGA2 Horizontal Total Shadow     */
+  {VIACR,CR6E,0xFF,0xD2},                                               =
/* IGA2 Horizontal Blank End Shadow */
+  {VIACR,CR66,0xFF,0xC9},{VIACR,CR67,0x03,0x04},                        =
/* IGA2 Offset                      */
+  {VIASR,SR46,0xFF,0x84},{VIASR,SR47,0xFF,0x79}                         =
/* VCLK                             */
+};
+#define NUM_TOTAL_K400_LCD_RES_12X10_14X10 =
ARRAY_SIZE(K400_LCD_RES_12X10_14X10)
+
+
+/* ++++++ K400 ++++++ */
+/*   Panel 1280x1024   */
+struct io_reg K400_LCD_RES_6X4_12X10[]  =3D {
+  {VIACR,CR50,0xFF,0x9D},{VIACR,CR55,0x0F,0x46},                        =
 /* IGA2 Horizontal Total            */
+  {VIACR,CR53,0xFF,0x9D},{VIACR,CR54,0x38,0x74},{VIACR,CR5D,0x40,0x1C}, =
 /* IGA2 Horizontal Blank End        */
+  {VIACR,CR6D,0xFF,0x5F},{VIACR,CR71,0x08,0x34},                        =
 /* IGA2 Horizontal Total Shadow     */=20
+  {VIACR,CR6E,0xFF,0x63},                                               =
 /* IGA2 Horizontal Blank End Shadow */
+  {VIACR,CR66,0xFF,0xAA},{VIACR,CR67,0x03,0x00},                        =
 /* IGA2 Offset                      */
+  {VIASR,SR46,0xFF,0x07},{VIASR,SR47,0xFF,0x19}                         =
 /* VCLK                             */
+};
+#define NUM_TOTAL_K400_LCD_RES_6X4_12X10 =
ARRAY_SIZE(K400_LCD_RES_6X4_12X10)
+
+struct io_reg K400_LCD_RES_7X4_12X10[]  =3D {
+  {VIACR,CR50,0xFF,0x9D},{VIACR,CR55,0x0F,0x46},                        =
 /* IGA2 Horizontal Total            */
+  {VIACR,CR53,0xFF,0x9D},{VIACR,CR54,0x38,0x74},{VIACR,CR5D,0x40,0x1C}, =
 /* IGA2 Horizontal Blank End        */
+  {VIACR,CR6D,0xFF,0x68},{VIACR,CR71,0x08,0x34},                        =
 /* IGA2 Horizontal Total Shadow     */
+  {VIACR,CR6E,0xFF,0x6C},                                               =
 /* IGA2 Horizontal Blank End Shadow */
+  {VIACR,CR66,0xFF,0xA8},{VIACR,CR67,0x03,0x00},                        =
 /* IGA2 Offset                      */
+  {VIASR,SR46,0xFF,0x87},{VIASR,SR47,0xFF,0xED}                         =
 /* VCLK                             */
+};
+#define NUM_TOTAL_K400_LCD_RES_7X4_12X10 =
ARRAY_SIZE(K400_LCD_RES_7X4_12X10)
+
+struct io_reg K400_LCD_RES_8X6_12X10[]  =3D {
+  {VIACR,CR50,0xFF,0x9D},{VIACR,CR55,0x0F,0x46},                        =
 /* IGA2 Horizontal Total            */
+  {VIACR,CR53,0xFF,0x9D},{VIACR,CR54,0x38,0x74},{VIACR,CR5D,0x40,0x1C}, =
 /* IGA2 Horizontal Blank End        */
+  {VIACR,CR6D,0xFF,0x7F},{VIACR,CR71,0x08,0x34},                        =
 /* IGA2 Horizontal Total Shadow     */
+  {VIACR,CR6E,0xFF,0x83},                                               =
 /* IGA2 Horizontal Blank End Shadow */
+  {VIACR,CR66,0xFF,0xBE},{VIACR,CR67,0x03,0x00},                        =
 /* IGA2 Offset                      */
+  {VIASR,SR46,0xFF,0x07},{VIASR,SR47,0xFF,0x21}                         =
 /* VCLK                             */
+};
+#define NUM_TOTAL_K400_LCD_RES_8X6_12X10 =
ARRAY_SIZE(K400_LCD_RES_8X6_12X10)
+
+struct io_reg K400_LCD_RES_10X7_12X10[]  =3D {
+  {VIACR,CR50,0xFF,0x9D},{VIACR,CR55,0x0F,0x46},                        =
 /* IGA2 Horizontal Total            */
+  {VIACR,CR53,0xFF,0x9D},{VIACR,CR54,0x38,0x74},{VIACR,CR5D,0x40,0x1C}, =
 /* IGA2 Horizontal Blank End        */=20
+  {VIACR,CR6D,0xFF,0xA3},{VIACR,CR71,0x08,0x34},                        =
 /* IGA2 Horizontal Total Shadow     */
+  {VIACR,CR6E,0xFF,0xA7},                                               =
 /* IGA2 Horizontal Blank End Shadow */
+  {VIACR,CR66,0xFF,0xBE},{VIACR,CR67,0x03,0x04},                        =
 /* IGA2 Offset                      */
+  {VIASR,SR46,0xFF,0x05},{VIASR,SR47,0xFF,0x1E}                         =
 /* VCLK                             */
+};
+#define NUM_TOTAL_K400_LCD_RES_10X7_12X10 =
ARRAY_SIZE(K400_LCD_RES_10X7_12X10)
+
+
+/* ++++++ K400 ++++++ */
+/*   Panel 1024x768    */
+struct io_reg K400_LCD_RES_6X4_10X7[]  =3D {
+  {VIACR,CR50,0xFF,0x47},{VIACR,CR55,0x0F,0x35},                        =
 /* IGA2 Horizontal Total      */
+  {VIACR,CR53,0xFF,0x47},{VIACR,CR54,0x38,0x2B},{VIACR,CR5D,0x40,0x13}, =
 /* IGA2 Horizontal Blank End        */
+  {VIACR,CR6D,0xFF,0x60},{VIACR,CR71,0x08,0x23},                        =
 /* IGA2 Horizontal Total Shadow     */
+  {VIACR,CR6E,0xFF,0x64},                                               =
 /* IGA2 Horizontal Blank End Shadow */
+  {VIACR,CR66,0xFF,0x8C},{VIACR,CR67,0x03,0x00},                        =
 /* IGA2 Offset                      */
+  {VIASR,SR46,0xFF,0x87},{VIASR,SR47,0xFF,0x4C}                         =
 /* VCLK                             */
+};
+
+#define NUM_TOTAL_K400_LCD_RES_6X4_10X7 =
ARRAY_SIZE(K400_LCD_RES_6X4_10X7)
+
+struct io_reg K400_LCD_RES_7X4_10X7[]  =3D {
+  {VIACR,CR50,0xFF,0x3B},{VIACR,CR55,0x0F,0x35},                        =
 /* IGA2 Horizontal Total            */=20
+  {VIACR,CR53,0xFF,0x3B},{VIACR,CR54,0x38,0x2B},{VIACR,CR5D,0x40,0x13}, =
 /* IGA2 Horizontal Blank End        */
+  {VIACR,CR6D,0xFF,0x71},{VIACR,CR71,0x08,0x23},                        =
 /* IGA2 Horizontal Total Shadow     */
+  {VIACR,CR6E,0xFF,0x75},                                               =
 /* IGA2 Horizontal Blank End Shadow */
+  {VIACR,CR66,0xFF,0x96},{VIACR,CR67,0x03,0x00},                        =
 /* IGA2 Offset                      */
+  {VIASR,SR46,0xFF,0x05},{VIASR,SR47,0xFF,0x10}                         =
 /* VCLK                             */
+};
+
+#define NUM_TOTAL_K400_LCD_RES_7X4_10X7 =
ARRAY_SIZE(K400_LCD_RES_7X4_10X7)
+
+struct io_reg K400_LCD_RES_8X6_10X7[]  =3D {
+  {VIACR,CR50,0xFF,0x37},{VIACR,CR55,0x0F,0x35},                        =
 /* IGA2 Horizontal Total            */
+  {VIACR,CR53,0xFF,0x37},{VIACR,CR54,0x38,0x2B},{VIACR,CR5D,0x40,0x13}, =
 /* IGA2 Horizontal Blank End        */
+  {VIACR,CR6D,0xFF,0x7E},{VIACR,CR71,0x08,0x23},                        =
 /* IGA2 Horizontal Total Shadow     */
+  {VIACR,CR6E,0xFF,0x82},                                               =
 /* IGA2 Horizontal Blank End Shadow */
+  {VIACR,CR66,0xFF,0x8C},{VIACR,CR67,0x03,0x00},                        =
 /* IGA2 Offset                      */
+  {VIASR,SR46,0xFF,0x84},{VIASR,SR47,0xFF,0xB9}                         =
 /* VCLK        */=20
+};
+#define NUM_TOTAL_K400_LCD_RES_8X6_10X7 =
ARRAY_SIZE(K400_LCD_RES_8X6_10X7)
+
+/* ++++++ K400 ++++++ */
+/*   Panel 800x600     */
+struct io_reg K400_LCD_RES_6X4_8X6[]  =3D {
+  {VIACR,CR50,0xFF,0x1A},{VIACR,CR55,0x0F,0x34},                        =
 /* IGA2 Horizontal Total            */=20
+  {VIACR,CR53,0xFF,0x1A},{VIACR,CR54,0x38,0xE3},{VIACR,CR5D,0x40,0x12}, =
 /* IGA2 Horizontal Blank End        */
+  {VIACR,CR6D,0xFF,0x5F},{VIACR,CR71,0x08,0x22},                        =
 /* IGA2 Horizontal Total Shadow     */
+  {VIACR,CR6E,0xFF,0x63},                                               =
 /* IGA2 Horizontal Blank End Shadow */
+  {VIACR,CR66,0xFF,0x6E},{VIACR,CR67,0x03,0x00},                        =
 /* IGA2 Offset                      */
+  {VIASR,SR46,0xFF,0x86},{VIASR,SR47,0xFF,0xB3}                         =
 /* VCLK                             */
+};
+#define NUM_TOTAL_K400_LCD_RES_6X4_8X6 ARRAY_SIZE(K400_LCD_RES_6X4_8X6)
+
+struct io_reg K400_LCD_RES_7X4_8X6[]  =3D {
+  {VIACR,CR50,0xFF,0x1F},{VIACR,CR55,0x0F,0x34},                        =
 /* IGA2 Horizontal Total            */
+  {VIACR,CR53,0xFF,0x1F},{VIACR,CR54,0x38,0xE3},{VIACR,CR5D,0x40,0x12}, =
 /* IGA2 Horizontal Blank End        */
+  {VIACR,CR6D,0xFF,0x7F},{VIACR,CR71,0x08,0x22},                        =
 /* IGA2 Horizontal Total Shadow     */
+  {VIACR,CR6E,0xFF,0x83},                                               =
 /* IGA2 Horizontal Blank End Shadow */
+  {VIACR,CR66,0xFF,0x78},{VIACR,CR67,0x03,0x00},                        =
 /* IGA2 Offset                      */
+  {VIASR,SR46,0xFF,0xC4},{VIASR,SR47,0xFF,0x59}                         =
 /* VCLK                             */
+};
+#define NUM_TOTAL_K400_LCD_RES_7X4_8X6 ARRAY_SIZE(K400_LCD_RES_7X4_8X6)
+
+#endif /* __LCDTBL_H__ */
diff -Nur linux-2.6.21-rc7/drivers/video/via/Makefile =
linux-2.6.21-rc7.viafb/drivers/video/via/Makefile
--- linux-2.6.21-rc7/drivers/video/via/Makefile 1969-12-31 =
19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/Makefile 2007-04-26 =
19:52:32.000000000 -0400
@@ -0,0 +1,7 @@
+#
+# Makefile for the VIA framebuffer driver (for Linux Kernel 2.6)
+#
+                                                                        =
       =20
+obj-$(CONFIG_FB_VIA) +=3D viafb.o
+
+viafb-objs :=3D viafbdev.o hw.o iface.o tv.o via_i2c.o vt1622.o =
vt1622a.o dvi.o lcd.o vt1625.o ioctl.o accel.o via_utility.o =
IntegratedTV.o vt1636.o
diff -Nur linux-2.6.21-rc7/drivers/video/via/share.h =
linux-2.6.21-rc7.viafb/drivers/video/via/share.h
--- linux-2.6.21-rc7/drivers/video/via/share.h 1969-12-31 =
19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/share.h 2007-04-26 =
19:58:40.000000000 -0400
@@ -0,0 +1,771 @@
+/*
+ * Copyright 1998-2007 VIA Technologies, Inc. All Rights Reserved.
+ * Copyright 2001-2007 S3 Graphics, Inc. All Rights Reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person =
obtaining a
+ * copy of this software and associated documentation files (the =
"Software"),
+ * to deal in the Software without restriction, including without =
limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sub =
license,
+ * and/or sell copies of the Software, and to permit persons to whom =
the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the
+ * next paragraph) shall be included in all copies or substantial =
portions
+ * of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, =
EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF =
MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT =
SHALL
+ * THE AUTHOR(S) OR COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, =
DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR =
OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE =
OR OTHER
+ * DEALINGS IN THE SOFTWARE.
+ */
+
+#ifndef __SHARE_H__
+#define __SHARE_H__
+
+#include <linux/version.h>
+
+/* Define Return Value */
+#define FAIL        -1
+#define OK          1
+
+/* Define Boolean Value */
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,19)
+#ifndef bool
+typedef int bool;
+#endif
+#endif
+
+#ifndef TRUE
+#define TRUE 1
+#endif
+
+#ifndef FALSE
+#define FALSE 0
+#endif
+
+#ifndef NULL
+#define NULL 0
+#endif
+
+/* Define Bit Field */
+#define BIT0    0x01
+#define BIT1    0x02
+#define BIT2    0x04
+#define BIT3    0x08
+#define BIT4    0x10
+#define BIT5    0x20
+#define BIT6    0x40
+#define BIT7    0x80
+
+/* Video Memory Size */
+#define VIDEO_MEMORY_SIZE_16M    0x1000000
+
+/* Definition Mode Index */
+#define     VIA_RES_640X480                 0
+#define     VIA_RES_800X600                 1
+#define     VIA_RES_1024X768                2
+#define     VIA_RES_1152X864                3
+#define     VIA_RES_1280X1024               4
+#define     VIA_RES_1600X1200               5
+#define     VIA_RES_1440X1050               6
+#define     VIA_RES_1280X768                7
+#define     VIA_RES_1280X960                8
+#define     VIA_RES_1920X1440               9
+#define     VIA_RES_848X480                 10
+#define     VIA_RES_1400X1050               11
+#define     VIA_RES_720X480                 12
+#define     VIA_RES_720X576                 13
+#define     VIA_RES_1024X512                14
+#define     VIA_RES_856X480                 15
+#define     VIA_RES_1024X576                16
+#define     VIA_RES_640X400                 17
+#define     VIA_RES_1280X720                18
+#define     VIA_RES_1920X1080               19
+#define     VIA_RES_800X480                 20
+#define     VIA_RES_1368X768                21
+#define     VIA_RES_1024X600                22
+#define     VIA_RES_1280X800                23
+#define     VIA_RES_INVALID                 255
+
+
+/* standard VGA IO port */
+#define VIARMisc    0x3CC
+#define VIAWMisc    0x3C2
+#define VIAStatus   0x3DA
+#define VIACR       0x3D4
+#define VIASR       0x3C4
+#define VIAGR       0x3CE
+#define VIAAR       0x3C0
+
+#define StdCR       0x19
+#define StdSR       0x04
+#define StdGR       0x09
+#define StdAR       0x14
+
+#define PatchCR     11
+
+/* Display path */
+#define IGA1        1
+#define IGA2        2
+#define IGA1_IGA2   3
+
+/* Define Color Depth  */
+#define MODE_8BPP       1
+#define MODE_16BPP      2
+#define MODE_32BPP      4
+
+#define GR20    0x20
+#define GR21    0x21
+#define GR22    0x22
+
+
+/* Sequencer Registers */
+#define SR01    0x01
+#define SR10    0x10
+#define SR12    0x12
+#define SR15    0x15
+#define SR16    0x16
+#define SR17    0x17
+#define SR18    0x18
+#define SR1B    0x1B
+#define SR1A    0x1A
+#define SR1C    0x1C
+#define SR1D    0x1D
+#define SR1E    0x1E
+#define SR1F    0x1F
+#define SR20    0x20
+#define SR21    0x21
+#define SR22    0x22
+#define SR2A    0x2A
+#define SR2D    0x2D
+#define SR2E    0x2E
+
+#define SR30    0x30
+#define SR39    0x39
+#define SR3D    0x3D
+#define SR3E    0x3E
+#define SR3F    0x3F
+#define SR40    0x40
+#define SR43    0x43
+#define SR44    0x44
+#define SR45    0x45
+#define SR46    0x46
+#define SR47    0x47
+#define SR48    0x48
+#define SR49    0x49
+#define SR4A    0x4A
+#define SR4B    0x4B
+#define SR4C    0x4C
+#define SR52    0x52
+#define SR5E    0x5E
+#define SR65    0x65
+
+
+/* CRT Controller Registers */
+#define CR00    0x00
+#define CR01    0x01
+#define CR02    0x02
+#define CR03    0x03
+#define CR04    0x04
+#define CR05    0x05
+#define CR06    0x06
+#define CR07    0x07
+#define CR08    0x08
+#define CR09    0x09
+#define CR0A    0x0A
+#define CR0B    0x0B
+#define CR0C    0x0C
+#define CR0D    0x0D
+#define CR0E    0x0E
+#define CR0F    0x0F
+#define CR10    0x10
+#define CR11    0x11
+#define CR12    0x12
+#define CR13    0x13
+#define CR14    0x14
+#define CR15    0x15
+#define CR16    0x16
+#define CR17    0x17
+#define CR18    0x18
+
+/* Extend CRT Controller Registers */
+#define CR30    0x30
+#define CR31    0x31
+#define CR32    0x32
+#define CR33    0x33
+#define CR34    0x34
+#define CR35    0x35
+#define CR36    0x36
+#define CR37    0x37
+#define CR38    0x38
+#define CR39    0x39
+#define CR3A    0x3A
+#define CR3B    0x3B
+#define CR3C    0x3C
+#define CR3D    0x3D
+#define CR3E    0x3E
+#define CR3F    0x3F
+#define CR40    0x40
+#define CR41    0x41
+#define CR42    0x42
+#define CR43    0x43
+#define CR44    0x44
+#define CR45    0x45
+#define CR46    0x46
+#define CR47    0x47
+#define CR48    0x48
+#define CR49    0x49
+#define CR4A    0x4A
+#define CR4B    0x4B
+#define CR4C    0x4C
+#define CR4D    0x4D
+#define CR4E    0x4E
+#define CR4F    0x4F
+#define CR50    0x50
+#define CR51    0x51
+#define CR52    0x52
+#define CR53    0x53
+#define CR54    0x54
+#define CR55    0x55
+#define CR56    0x56
+#define CR57    0x57
+#define CR58    0x58
+#define CR59    0x59
+#define CR5A    0x5A
+#define CR5B    0x5B
+#define CR5C    0x5C
+#define CR5D    0x5D
+#define CR5E    0x5E
+#define CR5F    0x5F
+#define CR60    0x60
+#define CR61    0x61
+#define CR62    0x62
+#define CR63    0x63
+#define CR64    0x64
+#define CR65    0x65
+#define CR66    0x66
+#define CR67    0x67
+#define CR68    0x68
+#define CR69    0x69
+#define CR6A    0x6A
+#define CR6B    0x6B
+#define CR6C    0x6C
+#define CR6D    0x6D
+#define CR6E    0x6E
+#define CR6F    0x6F
+#define CR70    0x70
+#define CR71    0x71
+#define CR72    0x72
+#define CR73    0x73
+#define CR74    0x74
+#define CR75    0x75
+#define CR76    0x76
+#define CR77    0x77
+#define CR78    0x78
+#define CR79    0x79
+#define CR7A    0x7A
+#define CR7B    0x7B
+#define CR7C    0x7C
+#define CR7D    0x7D
+#define CR7E    0x7E
+#define CR7F    0x7F
+#define CR80    0x80
+#define CR81    0x81
+#define CR82    0x82
+#define CR83    0x83
+#define CR84    0x84
+#define CR85    0x85
+#define CR86    0x86
+#define CR87    0x87
+#define CR88    0x88
+#define CR89    0x89
+#define CR8A    0x8A
+#define CR8B    0x8B
+#define CR8C    0x8C
+#define CR8D    0x8D
+#define CR8E    0x8E
+#define CR8F    0x8F
+#define CR90    0x90
+#define CR91    0x91
+#define CR92    0x92
+#define CR93    0x93
+#define CR94    0x94
+#define CR95    0x95
+#define CR96    0x96
+#define CR97    0x97
+#define CR98    0x98
+#define CR99    0x99
+#define CR9A    0x9A
+#define CR9B    0x9B
+#define CR9C    0x9C
+#define CR9D    0x9D
+#define CR9E    0x9E
+#define CR9F    0x9F
+#define CRA0    0xA0
+#define CRA1    0xA1
+#define CRA2    0xA2
+#define CRA3    0xA3
+#define CRD2    0xD2
+#define CRD3    0xD3
+#define CRD4    0xD4
+
+/* LUT Table*/
+#define LUT_DATA             0x3C9        /* DACDATA */
+#define LUT_INDEX_READ       0x3C7        /* DACRX */
+#define LUT_INDEX_WRITE      0x3C8        /* DACWX */
+#define DACMASK              0x3C6
+
+/* Definition Device */
+#define DEVICE_CRT  0x01
+#define DEVICE_TV   0x02
+#define DEVICE_DVI  0x03
+#define DEVICE_LCD  0x04
+
+/* Device output interface */
+#define INTERFACE_NONE          0x00
+#define INTERFACE_ANALOG_RGB    0x01
+#define INTERFACE_DVP0          0x02
+#define INTERFACE_DVP1          0x03
+#define INTERFACE_DFP_HIGH      0x04
+#define INTERFACE_DFP_LOW       0x05
+#define INTERFACE_DFP           0x06
+#define INTERFACE_LVDS0         0x07
+#define INTERFACE_LVDS1         0x08
+#define INTERFACE_LVDS0LVDS1    0x09
+#define INTERFACE_TMDS          0x0A
+
+/* Hardware layout for internal LVDS/TMDS. */
+#define HW_LAYOUT_LCD_ONLY      0x01
+#define HW_LAYOUT_DVI_ONLY      0x02
+#define HW_LAYOUT_LCD_DVI       0x03
+#define HW_LAYOUT_LCD1_LCD2     0x04
+#define HW_LAYOUT_LCD_EXTERNAL_LCD2 0x10
+
+/* Definition Refresh Rate */
+#define REFRESH_60      60
+#define REFRESH_75      75
+#define REFRESH_85      85
+#define REFRESH_100     100
+#define REFRESH_120     120
+
+/* Definition Sync Polarity */
+#define NEGATIVE        1
+#define POSITIVE        0
+
+/* 640x480@60 Sync Polarity (VESA Mode) */
+#define M640X480_R60_HSP        NEGATIVE           =20
+#define M640X480_R60_VSP        NEGATIVE
+
+/* 640x480@75 Sync Polarity (VESA Mode) */
+#define M640X480_R75_HSP        NEGATIVE
+#define M640X480_R75_VSP        NEGATIVE
+
+/* 640x480@85 Sync Polarity (VESA Mode) */
+#define M640X480_R85_HSP        NEGATIVE
+#define M640X480_R85_VSP        NEGATIVE
+
+/* 640x480@100 Sync Polarity (GTF Mode) */
+#define M640X480_R100_HSP       NEGATIVE
+#define M640X480_R100_VSP       POSITIVE
+
+/* 640x480@120 Sync Polarity (GTF Mode) */
+#define M640X480_R120_HSP       NEGATIVE
+#define M640X480_R120_VSP       POSITIVE
+
+/* 720x480@60 Sync Polarity  (GTF Mode) */
+#define M720X480_R60_HSP        NEGATIVE           =20
+#define M720X480_R60_VSP        POSITIVE
+
+/* 720x576@60 Sync Polarity  (GTF Mode) */
+#define M720X576_R60_HSP        NEGATIVE           =20
+#define M720X576_R60_VSP        POSITIVE
+
+/* 800x600@60 Sync Polarity (VESA Mode) */
+#define M800X600_R60_HSP        POSITIVE           =20
+#define M800X600_R60_VSP        POSITIVE
+
+/* 800x600@75 Sync Polarity (VESA Mode) */
+#define M800X600_R75_HSP        POSITIVE           =20
+#define M800X600_R75_VSP        POSITIVE
+
+/* 800x600@85 Sync Polarity (VESA Mode) */
+#define M800X600_R85_HSP        POSITIVE           =20
+#define M800X600_R85_VSP        POSITIVE
+
+/* 800x600@100 Sync Polarity (GTF Mode) */
+#define M800X600_R100_HSP       NEGATIVE           =20
+#define M800X600_R100_VSP       POSITIVE
+
+/* 800x600@120 Sync Polarity (GTF Mode) */
+#define M800X600_R120_HSP       NEGATIVE           =20
+#define M800X600_R120_VSP       POSITIVE
+
+/* 800x480@60 Sync Polarity  (GTF Mode) */
+#define M800X480_R60_HSP        NEGATIVE           =20
+#define M800X480_R60_VSP        POSITIVE
+
+/* 848x480@60 Sync Polarity  (GTF Mode) */
+#define M848X480_R60_HSP        NEGATIVE           =20
+#define M848X480_R60_VSP        POSITIVE
+
+/* 852x480@60 Sync Polarity  (GTF Mode) */
+#define M852X480_R60_HSP        NEGATIVE           =20
+#define M852X480_R60_VSP        POSITIVE
+
+/* 1024x512@60 Sync Polarity (GTF Mode) */
+#define M1024X512_R60_HSP       NEGATIVE           =20
+#define M1024X512_R60_VSP       POSITIVE
+
+/* 1024x600@60 Sync Polarity (GTF Mode) */
+#define M1024X600_R60_HSP       NEGATIVE           =20
+#define M1024X600_R60_VSP       POSITIVE
+
+
+/* 1024x768@60 Sync Polarity (VESA Mode) */=20
+#define M1024X768_R60_HSP       NEGATIVE           =20
+#define M1024X768_R60_VSP       NEGATIVE
+
+/* 1024x768@75 Sync Polarity (VESA Mode) */
+#define M1024X768_R75_HSP       POSITIVE           =20
+#define M1024X768_R75_VSP       POSITIVE
+
+/* 1024x768@85 Sync Polarity (VESA Mode) */=20
+#define M1024X768_R85_HSP       POSITIVE           =20
+#define M1024X768_R85_VSP       POSITIVE
+
+/* 1024x768@100 Sync Polarity (GTF Mode) */
+#define M1024X768_R100_HSP      NEGATIVE           =20
+#define M1024X768_R100_VSP      POSITIVE
+
+/* 1152x864@75 Sync Polarity (VESA Mode) */
+#define M1152X864_R75_HSP       POSITIVE           =20
+#define M1152X864_R75_VSP       POSITIVE
+
+/* 1280x720@60 Sync Polarity  (GTF Mode) */
+#define M1280X720_R60_HSP       NEGATIVE           =20
+#define M1280X720_R60_VSP       POSITIVE
+
+/* 1280x768@60 Sync Polarity  (GTF Mode) */
+#define M1280X768_R60_HSP       NEGATIVE           =20
+#define M1280X768_R60_VSP       POSITIVE
+
+/* 1280x800@60 Sync Polarity  (GTF Mode) */
+#define M1280X800_R60_HSP       NEGATIVE
+#define M1280X800_R60_VSP       POSITIVE
+
+/* 1280x960@60 Sync Polarity (VESA Mode) */
+#define M1280X960_R60_HSP       POSITIVE           =20
+#define M1280X960_R60_VSP       POSITIVE
+
+/* 1280x1024@60 Sync Polarity (VESA Mode) */
+#define M1280X1024_R60_HSP      POSITIVE                  =20
+#define M1280X1024_R60_VSP      POSITIVE
+
+/* 1368x768@60 Sync Polarity (VESA Mode) */
+#define M1368X768_R60_HSP       NEGATIVE
+#define M1368X768_R60_VSP       POSITIVE
+
+/* 1280x1024@75 Sync Polarity (VESA Mode) */
+#define M1280X1024_R75_HSP      POSITIVE                  =20
+#define M1280X1024_R75_VSP      POSITIVE=20
+
+/* 1280x1024@85 Sync Polarity (VESA Mode) */
+#define M1280X1024_R85_HSP      POSITIVE                  =20
+#define M1280X1024_R85_VSP      POSITIVE
+
+/* 1440x1050@60 Sync Polarity (GTF Mode) */
+#define M1440X1050_R60_HSP      NEGATIVE                  =20
+#define M1440X1050_R60_VSP      POSITIVE =20
+
+/* 1600x1200@60 Sync Polarity (VESA Mode) */
+#define M1600X1200_R60_HSP      POSITIVE                 =20
+#define M1600X1200_R60_VSP      POSITIVE      =20
+
+/* 1600x1200@75 Sync Polarity (VESA Mode) */   =20
+#define M1600X1200_R75_HSP      POSITIVE                 =20
+#define M1600X1200_R75_VSP      POSITIVE     =20
+
+/* 1920x1080@60 Sync Polarity (GTF Mode) */
+#define M1920X1080_R60_HSP      NEGATIVE           =20
+#define M1920X1080_R60_VSP      POSITIVE
+
+/* 1920x1440@60 Sync Polarity (VESA Mode) */
+#define M1920X1440_R60_HSP      NEGATIVE           =20
+#define M1920X1440_R60_VSP      POSITIVE=20
+
+/* 1920x1440@75 Sync Polarity (VESA Mode) */
+#define M1920X1440_R75_HSP      NEGATIVE           =20
+#define M1920X1440_R75_VSP      POSITIVE
+
+#if 0
+/* 1400x1050@60 Sync Polarity (VESA Mode) */
+#define M1400X1050_R60_HSP      NEGATIVE
+#define M1400X1050_R60_VSP      NEGATIVE
+#endif
+
+/* 1400x1050@60 Sync Polarity (GTF Mode) */
+#define M1400X1050_R60_HSP      NEGATIVE
+#define M1400X1050_R60_VSP      POSITIVE
+
+
+/* define PLL index: */
+#define CLK_25_175M     25175000
+#define CLK_26_880M     26880000
+#define CLK_29_581M     29581000
+#define CLK_31_490M     31490000
+#define CLK_31_500M     31500000
+#define CLK_31_728M     31728000
+#define CLK_32_668M     32688000
+#define CLK_36_000M     36000000
+#define CLK_40_000M     40000000
+#define CLK_41_291M     41291000
+#define CLK_43_163M     43163000
+/* #define CLK_46_996M     46996000 */
+#define CLK_48_875M     48875000
+#define CLK_49_500M     49500000
+#define CLK_52_406M     52406000
+#define CLK_56_250M     56250000
+#define CLK_65_000M     65000000
+#define CLK_68_179M     68179000
+#define CLK_78_750M     78750000
+#define CLK_80_136M     80136000
+#define CLK_83_375M     83375000
+#define CLK_83_950M     83950000
+#define CLK_85_860M     85860000
+#define CLK_94_500M     94500000
+#define CLK_108_000M    108000000
+#define CLK_125_104M    125104000
+#define CLK_133_308M    133308000
+#define CLK_135_000M    135000000
+/* #define CLK_148_500M    148500000 */
+#define CLK_157_500M    157500000
+#define CLK_162_000M    162000000
+#define CLK_202_500M    202500000
+#define CLK_234_000M    234000000
+#define CLK_297_500M    297500000
+#define CLK_74_481M     74481000
+#define CLK_172_798M    172798000
+#define CLK_122_614M    122614000
+
+
+/* CLE266 PLL value */
+#define CLE266_PLL_25_175M     0x0000C763
+#define CLE266_PLL_26_880M     0x0000440F
+#define CLE266_PLL_29_581M     0x00008421
+#define CLE266_PLL_31_490M     0x00004721
+#define CLE266_PLL_31_500M     0x0000C3B5
+#define CLE266_PLL_31_728M     0x0000471F
+#define CLE266_PLL_32_668M     0x0000C449
+#define CLE266_PLL_36_000M     0x0000C5E5
+#define CLE266_PLL_40_000M     0x0000C459
+#define CLE266_PLL_41_291M     0x00004417
+#define CLE266_PLL_43_163M     0x0000C579
+/* #define CLE266_PLL_46_996M     0x0000C4E9 */
+#define CLE266_PLL_48_875M     0x00001D63
+#define CLE266_PLL_49_500M     0x00008653
+#define CLE266_PLL_52_406M     0x0000C475
+#define CLE266_PLL_56_250M     0x000047B7
+#define CLE266_PLL_65_000M     0x000086ED
+#define CLE266_PLL_68_179M     0x00000413
+#define CLE266_PLL_78_750M     0x00004321
+#define CLE266_PLL_80_136M     0x0000051C
+#define CLE266_PLL_83_375M     0x0000C25D
+#define CLE266_PLL_83_950M     0x00000729
+#define CLE266_PLL_85_860M     0x00004754
+#define CLE266_PLL_94_500M     0x00000521
+#define CLE266_PLL_108_000M    0x00008479
+#define CLE266_PLL_125_104M    0x000006B5
+#define CLE266_PLL_133_308M    0x0000465F
+#define CLE266_PLL_135_000M    0x0000455E
+/* #define CLE266_PLL_148_500M    0x0000 */
+#define CLE266_PLL_157_500M    0x000005B7
+#define CLE266_PLL_162_000M    0x00004571
+#define CLE266_PLL_202_500M    0x00000763
+#define CLE266_PLL_234_000M    0x00000662
+#define CLE266_PLL_297_500M    0x000005E6
+#define CLE266_PLL_74_481M     0x0000051A
+#define CLE266_PLL_172_798M    0x00004579
+#define CLE266_PLL_122_614M    0x0000073C
+
+/*  K800 PLL value */
+#define K800_PLL_25_175M     0x00539001
+#define K800_PLL_26_880M     0x001C8C80
+#define K800_PLL_29_581M     0x00409080
+#define K800_PLL_31_490M     0x006F9001
+#define K800_PLL_31_500M     0x008B9002
+#define K800_PLL_31_728M     0x00AF9003
+#define K800_PLL_32_668M     0x00909002
+#define K800_PLL_36_000M     0x009F9002
+#define K800_PLL_40_000M     0x00578C02
+#define K800_PLL_41_291M     0x00438C01
+#define K800_PLL_43_163M     0x00778C03
+/* #define K800_PLL_46_996M     0x00000000 */
+#define K800_PLL_48_875M     0x00508C81
+#define K800_PLL_49_500M     0x00518C01
+#define K800_PLL_52_406M     0x00738C02
+#define K800_PLL_56_250M     0x007C8C02
+#define K800_PLL_65_000M     0x006B8C01
+#define K800_PLL_68_179M     0x00708C01
+#define K800_PLL_78_750M     0x00408801
+#define K800_PLL_80_136M     0x00428801
+#define K800_PLL_83_375M     0x005B0882
+#define K800_PLL_83_950M     0x00738803
+#define K800_PLL_85_860M     0x00768883
+#define K800_PLL_94_500M     0x00828803
+#define K800_PLL_108_000M    0x00778882
+#define K800_PLL_125_104M    0x00688801
+#define K800_PLL_133_308M    0x005D8801
+#define K800_PLL_135_000M    0x001A4081
+/* #define K800_PLL_148_500M    0x0000 */
+#define K800_PLL_157_500M    0x00142080
+#define K800_PLL_162_000M    0x006F8483
+#define K800_PLL_202_500M    0x00538481
+#define K800_PLL_234_000M    0x00608401
+#define K800_PLL_297_500M    0x00A48402
+#define K800_PLL_74_481M     0x007B8C81
+#define K800_PLL_172_798M    0x00778483
+#define K800_PLL_122_614M    0x00878882
+
+/* PLL for VT3324 */
+#define CX700_25_175M     0x008B1003
+#define CX700_26_719M     0x00931003
+#define CX700_26_880M     0x00941003
+#define CX700_29_581M     0x00A49003
+#define CX700_31_490M     0x00AE1003
+#define CX700_31_500M     0x00AE1003
+#define CX700_31_728M     0x00AF1003
+#define CX700_32_668M     0x00B51003
+#define CX700_36_000M     0x00C81003
+#define CX700_40_000M     0x006E0C03
+#define CX700_41_291M     0x00710C03
+#define CX700_43_163M     0x00770C03
+#define CX700_48_875M     0x00508C81
+#define CX700_49_500M     0x00880C03
+#define CX700_52_406M     0x00730C02
+#define CX700_56_250M     0x009B0C03
+#define CX700_65_000M     0x006B0C01
+#define CX700_68_179M     0x00BC0C03
+#define CX700_74_481M     0x00CE0C03
+#define CX700_78_750M     0x006C0803
+#define CX700_80_136M     0x006E0803
+#define CX700_83_375M     0x005B0882
+#define CX700_83_950M     0x00730803
+#define CX700_85_860M     0x00760803
+#define CX700_94_500M     0x00820803
+#define CX700_108_000M    0x00950803
+#define CX700_125_104M    0x00AD0803
+#define CX700_133_308M    0x00930802
+#define CX700_135_000M    0x00950802
+#define CX700_157_500M    0x006C0403
+#define CX700_162_000M    0x006F0403
+#define CX700_172_798M    0x00770403
+#define CX700_202_500M    0x008C0403
+#define CX700_234_000M    0x00600401
+#define CX700_297_500M    0x00CE0403
+#define CX700_122_614M    0x00870802
+
+/* Definition CRTC Timing Index */
+#define H_TOTAL_INDEX               0
+#define H_ADDR_INDEX                1
+#define H_BLANK_START_INDEX         2
+#define H_BLANK_END_INDEX           3
+#define H_SYNC_START_INDEX          4
+#define H_SYNC_END_INDEX            5
+#define V_TOTAL_INDEX               6
+#define V_ADDR_INDEX                7
+#define V_BLANK_START_INDEX         8
+#define V_BLANK_END_INDEX           9
+#define V_SYNC_START_INDEX          10
+#define V_SYNC_END_INDEX            11
+#define H_TOTAL_SHADOW_INDEX        12
+#define H_BLANK_END_SHADOW_INDEX    13
+#define V_TOTAL_SHADOW_INDEX        14
+#define V_ADDR_SHADOW_INDEX         15
+#define V_BLANK_SATRT_SHADOW_INDEX  16
+#define V_BLANK_END_SHADOW_INDEX    17
+#define V_SYNC_SATRT_SHADOW_INDEX   18
+#define V_SYNC_END_SHADOW_INDEX     19
+
+/* Definition Video Mode Pixel Clock (picoseconds) */
+#define RES_640X480_60HZ_PIXCLOCK    39722
+#define RES_640X480_75HZ_PIXCLOCK    31747
+#define RES_640X480_85HZ_PIXCLOCK    27777
+#define RES_640X480_100HZ_PIXCLOCK   23168
+#define RES_640X480_120HZ_PIXCLOCK   19081
+#define RES_720X480_60HZ_PIXCLOCK    37020
+#define RES_720X576_60HZ_PIXCLOCK    30611
+#define RES_800X600_60HZ_PIXCLOCK    25000
+#define RES_800X600_75HZ_PIXCLOCK    20203
+#define RES_800X600_85HZ_PIXCLOCK    17777
+#define RES_800X600_100HZ_PIXCLOCK   14815
+#define RES_800X600_120HZ_PIXCLOCK   11912
+#define RES_800X480_60HZ_PIXCLOCK    33805
+#define RES_848X480_60HZ_PIXCLOCK    31756
+#define RES_856X480_60HZ_PIXCLOCK    31518
+#define RES_1024X512_60HZ_PIXCLOCK   24218
+#define RES_1024X600_60HZ_PIXCLOCK   20460
+#define RES_1024X768_60HZ_PIXCLOCK   15385
+#define RES_1024X768_75HZ_PIXCLOCK   12699
+#define RES_1024X768_85HZ_PIXCLOCK   10582
+#define RES_1024X768_100HZ_PIXCLOCK  9091
+#define RES_1152X864_70HZ_PIXCLOCK   10000
+#define RES_1152X864_75HZ_PIXCLOCK   9091
+#define RES_1280X768_60HZ_PIXCLOCK   12480
+#define RES_1280X800_60HZ_PIXCLOCK   11994
+#define RES_1280X960_60HZ_PIXCLOCK   9259
+#define RES_1280X1024_60HZ_PIXCLOCK  9260
+#define RES_1280X1024_75HZ_PIXCLOCK  7408
+#define RES_1280X768_85HZ_PIXCLOCK   6349
+#define RES_1440X1050_60HZ_PIXCLOCK  7993
+#define RES_1600X1200_60HZ_PIXCLOCK  6411
+#define RES_1600X1200_75HZ_PIXCLOCK  4938
+#define RES_1280X720_60HZ_PIXCLOCK   13426
+#define RES_1920X1080_60HZ_PIXCLOCK  5787
+#define RES_1400X1050_60HZ_PIXCLOCK  8156
+#define RES_1368X768_60HZ_PIXCLOCK   11647
+
+/*  LCD display method */
+#define     LCD_EXPANDSION              0x00
+#define     LCD_CENTERING               0x01
+
+/*  LCD mode */
+#define     LCD_OPENLDI               0x00
+#define     LCD_SPWG                  0x01
+
+
+/* Define display timing */
+struct display_timing {
+    u16     hor_total;
+    u16     hor_addr;
+    u16     hor_blank_start;
+    u16     hor_blank_end;
+    u16     hor_sync_start;
+    u16     hor_sync_end;
+    u16     ver_total;
+    u16     ver_addr;
+    u16     ver_blank_start;
+    u16     ver_blank_end;
+    u16     ver_sync_start;
+    u16     ver_sync_end;
+};
+
+struct crt_mode_table {
+  int                               refresh_rate;
+  unsigned long                     clk;
+  int                               h_sync_polarity;
+  int                               v_sync_polarity;
+  struct display_timing             crtc;
+};
+
+struct io_reg{
+  int   port;
+  u8    index;
+  u8    mask;
+  u8    value;
+};
+
+#endif /* __SHARE_H__ */
+


------_=_NextPart_001_01C7893E.E1FC4847
Content-Type: text/html;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

<HTML dir=3Dltr><HEAD>=0A=
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dunicode">=0A=
<META content=3D"MSHTML 6.00.2900.3059" name=3DGENERATOR></HEAD>=0A=
<BODY>=0A=
<DIV><FONT face=3D=B7s=B2=D3=A9=FA=C5=E9 color=3D#000000 size=3D2>diff =
-Nur linux-2.6.21-rc7/drivers/video/via/hwcfig.h =
linux-2.6.21-rc7.viafb/drivers/video/via/hwcfig.h<BR>--- =
linux-2.6.21-rc7/drivers/video/via/hwcfig.h&nbsp;1969-12-31 =
19:00:00.000000000 -0500<BR>+++ =
linux-2.6.21-rc7.viafb/drivers/video/via/hwcfig.h&nbsp;2007-04-26 =
19:52:32.000000000 -0400<BR>@@ -0,0 +1,399 @@<BR>+ /*<BR>+ * Copyright =
1998-2007 VIA Technologies, Inc. All Rights Reserved.<BR>+ * Copyright =
2001-2007 S3 Graphics, Inc. All Rights Reserved.<BR>+ *<BR>+ * =
Permission is hereby granted, free of charge, to any person obtaining =
a<BR>+ * copy of this software and associated documentation files (the =
"Software"),<BR>+ * to deal in the Software without restriction, =
including without limitation<BR>+ * the rights to use, copy, modify, =
merge, publish, distribute, sub license,<BR>+ * and/or sell copies of =
the Software, and to permit persons to whom the<BR>+ * Software is =
furnished to do so, subject to the following conditions:<BR>+ *<BR>+ * =
The above copyright notice and this permission notice (including =
the<BR>+ * next paragraph) shall be included in all copies or =
substantial portions<BR>+ * of the Software.<BR>+ *<BR>+ * THE SOFTWARE =
IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR<BR>+ * =
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF =
MERCHANTABILITY,<BR>+ * FITNESS FOR A PARTICULAR PURPOSE AND =
NON-INFRINGEMENT. IN NO EVENT SHALL<BR>+ * THE AUTHOR(S) OR COPYRIGHT =
HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR<BR>+ * OTHER LIABILITY, =
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,<BR>+ * ARISING =
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER<BR>+ =
* DEALINGS IN THE SOFTWARE.<BR>+ */<BR>+ <BR>+<BR>+#ifndef =
__HWCFIG_H__<BR>+#define __HWCFIG_H__<BR>+<BR>+#include =
&lt;linux/ioport.h&gt;<BR>+#include &lt;asm/io.h&gt;<BR>+<BR>+#include =
"share.h"<BR>+#include "hw.h"<BR>+<BR>+static struct pll_map pll_value[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; {CLK_25_175M,&nbsp; =
CLE266_PLL_25_175M,&nbsp; K800_PLL_25_175M,&nbsp; =
CX700_25_175M},<BR>+&nbsp;&nbsp;&nbsp; {CLK_29_581M,&nbsp; =
CLE266_PLL_29_581M,&nbsp; K800_PLL_29_581M,&nbsp; =
CX700_29_581M},<BR>+&nbsp;&nbsp;&nbsp; {CLK_26_880M,&nbsp; =
CLE266_PLL_26_880M,&nbsp; K800_PLL_26_880M,&nbsp; =
CX700_26_880M},<BR>+&nbsp;&nbsp;&nbsp; {CLK_31_490M,&nbsp; =
CLE266_PLL_31_490M,&nbsp; K800_PLL_31_490M,&nbsp; =
CX700_31_490M},<BR>+&nbsp;&nbsp;&nbsp; {CLK_31_500M,&nbsp; =
CLE266_PLL_31_500M,&nbsp; K800_PLL_31_500M,&nbsp; =
CX700_31_500M},<BR>+&nbsp;&nbsp;&nbsp; {CLK_31_728M,&nbsp; =
CLE266_PLL_31_728M,&nbsp; K800_PLL_31_728M,&nbsp; =
CX700_31_728M},<BR>+&nbsp;&nbsp;&nbsp; {CLK_32_668M,&nbsp; =
CLE266_PLL_32_668M,&nbsp; K800_PLL_32_668M,&nbsp; =
CX700_32_668M},<BR>+&nbsp;&nbsp;&nbsp; {CLK_36_000M,&nbsp; =
CLE266_PLL_36_000M,&nbsp; K800_PLL_36_000M,&nbsp; =
CX700_36_000M},<BR>+&nbsp;&nbsp;&nbsp; {CLK_40_000M,&nbsp; =
CLE266_PLL_40_000M,&nbsp; K800_PLL_40_000M,&nbsp; =
CX700_40_000M},<BR>+&nbsp;&nbsp;&nbsp; {CLK_41_291M,&nbsp; =
CLE266_PLL_41_291M,&nbsp; K800_PLL_41_291M,&nbsp; =
CX700_41_291M},<BR>+&nbsp;&nbsp;&nbsp; {CLK_43_163M,&nbsp; =
CLE266_PLL_43_163M,&nbsp; K800_PLL_43_163M,&nbsp; =
CX700_43_163M},<BR>+&nbsp;&nbsp;&nbsp; {CLK_48_875M,&nbsp; =
CLE266_PLL_48_875M,&nbsp; K800_PLL_48_875M,&nbsp; =
CX700_48_875M},<BR>+&nbsp;&nbsp;&nbsp; {CLK_49_500M,&nbsp; =
CLE266_PLL_49_500M,&nbsp; K800_PLL_49_500M,&nbsp; =
CX700_49_500M},<BR>+&nbsp;&nbsp;&nbsp; {CLK_52_406M,&nbsp; =
CLE266_PLL_52_406M,&nbsp; K800_PLL_52_406M,&nbsp; =
CX700_52_406M},<BR>+&nbsp;&nbsp;&nbsp; {CLK_56_250M,&nbsp; =
CLE266_PLL_56_250M,&nbsp; K800_PLL_56_250M,&nbsp; =
CX700_56_250M},<BR>+&nbsp;&nbsp;&nbsp; {CLK_65_000M,&nbsp; =
CLE266_PLL_65_000M,&nbsp; K800_PLL_65_000M,&nbsp; =
CX700_65_000M},<BR>+&nbsp;&nbsp;&nbsp; {CLK_68_179M,&nbsp; =
CLE266_PLL_68_179M,&nbsp; K800_PLL_68_179M,&nbsp; =
CX700_68_179M},<BR>+&nbsp;&nbsp;&nbsp; {CLK_78_750M,&nbsp; =
CLE266_PLL_78_750M,&nbsp; K800_PLL_78_750M,&nbsp; =
CX700_78_750M},<BR>+&nbsp;&nbsp;&nbsp; {CLK_80_136M,&nbsp; =
CLE266_PLL_80_136M,&nbsp; K800_PLL_80_136M,&nbsp; =
CX700_80_136M},<BR>+&nbsp;&nbsp;&nbsp; {CLK_83_375M,&nbsp; =
CLE266_PLL_83_375M,&nbsp; K800_PLL_83_375M,&nbsp; =
CX700_83_375M},<BR>+&nbsp;&nbsp;&nbsp; {CLK_83_950M,&nbsp; =
CLE266_PLL_83_950M,&nbsp; K800_PLL_83_950M,&nbsp; =
CX700_83_950M},<BR>+&nbsp;&nbsp;&nbsp; {CLK_85_860M,&nbsp; =
CLE266_PLL_85_860M,&nbsp; K800_PLL_85_860M,&nbsp; =
CX700_85_860M},<BR>+&nbsp;&nbsp;&nbsp; {CLK_94_500M,&nbsp; =
CLE266_PLL_94_500M,&nbsp; K800_PLL_94_500M,&nbsp; =
CX700_94_500M},<BR>+&nbsp;&nbsp;&nbsp; {CLK_108_000M, =
CLE266_PLL_108_000M, K800_PLL_108_000M, =
CX700_108_000M},<BR>+&nbsp;&nbsp;&nbsp; {CLK_125_104M, =
CLE266_PLL_125_104M, K800_PLL_125_104M, =
CX700_125_104M},<BR>+&nbsp;&nbsp;&nbsp; {CLK_133_308M, =
CLE266_PLL_133_308M, K800_PLL_133_308M, =
CX700_133_308M},<BR>+&nbsp;&nbsp;&nbsp; {CLK_135_000M, =
CLE266_PLL_135_000M, K800_PLL_135_000M, =
CX700_135_000M},<BR>+&nbsp;&nbsp;&nbsp; {CLK_157_500M, =
CLE266_PLL_157_500M, K800_PLL_157_500M, =
CX700_157_500M},<BR>+&nbsp;&nbsp;&nbsp; {CLK_162_000M, =
CLE266_PLL_162_000M, K800_PLL_162_000M, =
CX700_162_000M},<BR>+&nbsp;&nbsp;&nbsp; {CLK_202_500M, =
CLE266_PLL_202_500M, K800_PLL_202_500M, =
CX700_202_500M},<BR>+&nbsp;&nbsp;&nbsp; {CLK_234_000M, =
CLE266_PLL_234_000M, K800_PLL_234_000M, =
CX700_234_000M},<BR>+&nbsp;&nbsp;&nbsp; {CLK_297_500M, =
CLE266_PLL_297_500M, K800_PLL_297_500M, =
CX700_297_500M},<BR>+&nbsp;&nbsp;&nbsp; {CLK_74_481M,&nbsp; =
CLE266_PLL_74_481M,&nbsp; K800_PLL_74_481M,&nbsp; =
CX700_74_481M},<BR>+&nbsp;&nbsp;&nbsp; {CLK_172_798M, =
CLE266_PLL_172_798M, K800_PLL_172_798M, =
CX700_172_798M},<BR>+&nbsp;&nbsp;&nbsp; {CLK_122_614M, =
CLE266_PLL_122_614M, K800_PLL_122_614M, =
CX700_122_614M}<BR>+&nbsp;&nbsp;&nbsp; <BR>+};<BR>+<BR>+#define =
NUM_TOTAL_PLL_TABLE ARRAY_SIZE(pll_value)<BR>+<BR>+static struct =
fifo_depth_select display_fifo_depth_reg=3D {<BR>+&nbsp;&nbsp;&nbsp; /* =
IGA1 FIFO Depth_Select */<BR>+&nbsp;&nbsp;&nbsp; =
{IGA1_FIFO_DEPTH_SELECT_REG_NUM, {{SR17,0,7}}},<BR>+&nbsp;&nbsp;&nbsp; =
/* IGA2 FIFO Depth_Select */<BR>+&nbsp;&nbsp;&nbsp; =
{IGA2_FIFO_DEPTH_SELECT_REG_NUM, {{CR68,4,7}, {CR94,7,7}, =
{CR95,7,7}}}<BR>+};<BR>+<BR>+static struct fifo_threshold_select =
fifo_threshold_select_reg=3D {<BR>+&nbsp;&nbsp;&nbsp; /* IGA1 FIFO =
Threshold Select */<BR>+&nbsp;&nbsp;&nbsp; {IGA1_FIFO_THRESHOLD_REG_NUM, =
{{SR16,0,5},{SR16,7,7}}},<BR>+&nbsp;&nbsp;&nbsp; /* IGA2 FIFO Threshold =
Select */<BR>+&nbsp;&nbsp;&nbsp; {IGA2_FIFO_THRESHOLD_REG_NUM, =
{{CR68,0,3}, {CR95,4,6}}}<BR>+};<BR>+<BR>+static struct =
fifo_high_threshold_select fifo_high_threshold_select_reg=3D =
{<BR>+&nbsp;&nbsp;&nbsp; /* IGA1 FIFO High Threshold Select =
*/<BR>+&nbsp;&nbsp;&nbsp; {IGA1_FIFO_HIGH_THRESHOLD_REG_NUM, =
{{SR18,0,5},{SR18,7,7}}},<BR>+&nbsp;&nbsp;&nbsp; /* IGA2 FIFO High =
Threshold Select */<BR>+&nbsp;&nbsp;&nbsp; =
{IGA2_FIFO_HIGH_THRESHOLD_REG_NUM, {{CR92,0,3}, =
{CR95,0,2}}}<BR>+};<BR>+<BR>+static struct display_queue_expire_num =
display_queue_expire_num_reg=3D {<BR>+&nbsp;&nbsp;&nbsp; /* IGA1 Display =
Queue Expire Num */<BR>+&nbsp;&nbsp;&nbsp; =
{IGA1_DISPLAY_QUEUE_EXPIRE_NUM_REG_NUM, =
{{SR22,0,4}}},<BR>+&nbsp;&nbsp;&nbsp; /* IGA2 Display Queue Expire Num =
*/<BR>+&nbsp;&nbsp;&nbsp; {IGA2_DISPLAY_QUEUE_EXPIRE_NUM_REG_NUM, =
{{CR94,0,6}}}<BR>+};<BR>+<BR>+/* Definition Offset Registers =
*/<BR>+static struct offset offset_reg =3D {<BR>+&nbsp;&nbsp;&nbsp; /* =
IGA1 Offset Register */<BR>+&nbsp;&nbsp;&nbsp; {IGA1_OFFSET_REG_NUM, =
{{CR13,0,7},{CR35,5,7}}},<BR>+&nbsp;&nbsp;&nbsp; /* IGA2 Offset Register =
*/<BR>+&nbsp;&nbsp;&nbsp; {IGA2_OFFSET_REG_NUM, =
{{CR66,0,7},{CR67,0,1}}}<BR>+};<BR>+<BR>+/* Definition Fetch Count =
Registers */<BR>+static struct fetch_count fetch_count_reg =3D =
{<BR>+&nbsp;&nbsp;&nbsp; /* IGA1 Fetch Count Register =
*/<BR>+&nbsp;&nbsp;&nbsp; {IGA1_FETCH_COUNT_REG_NUM, =
{{SR1C,0,7},{SR1D,0,1}}},<BR>+&nbsp;&nbsp;&nbsp; /* IGA2 Fetch Count =
Register */<BR>+&nbsp;&nbsp;&nbsp; {IGA2_FETCH_COUNT_REG_NUM, =
{{CR65,0,7},{CR67,2,3}}}<BR>+};<BR>+<BR>+#define =
IGA1_STARTING_ADDR_REG_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
location: {CR0C,0,7},{CR0D,0,7},{CR34,0,7},{CR48,0,1} */<BR>+#define =
IGA2_STARTING_ADDR_REG_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
location: {CR62,1,7},{CR63,0,7},{CR64,0,7} */<BR>+<BR>+static struct =
iga1_crtc_timing iga1_crtc_reg =3D {<BR>+&nbsp;&nbsp;&nbsp; /* IGA1 =
Horizontal Total */<BR>+&nbsp;&nbsp;&nbsp; {IGA1_HOR_TOTAL_REG_NUM, =
{{CR00,0,7}, {CR36,3,3}}},<BR>+&nbsp;&nbsp;&nbsp; /* IGA1 Horizontal =
Addressable Video */<BR>+&nbsp;&nbsp;&nbsp; {IGA1_HOR_ADDR_REG_NUM, =
{{CR01,0,7}}},<BR>+&nbsp;&nbsp;&nbsp; /* IGA1 Horizontal Blank Start =
*/<BR>+&nbsp;&nbsp;&nbsp; {IGA1_HOR_BLANK_START_REG_NUM, =
{{CR02,0,7}}},<BR>+&nbsp;&nbsp;&nbsp; /* IGA1 Horizontal Blank End =
*/<BR>+&nbsp;&nbsp;&nbsp; {IGA1_HOR_BLANK_END_REG_NUM, {{CR03,0,4}, =
{CR05,7,7}, {CR33,5,5}}},<BR>+&nbsp;&nbsp;&nbsp; /* IGA1 Horizontal Sync =
Start */<BR>+&nbsp;&nbsp;&nbsp; {IGA1_HOR_SYNC_START_REG_NUM, =
{{CR04,0,7}, {CR33,4,4}}},<BR>+&nbsp;&nbsp;&nbsp; /* IGA1 Horizontal =
Sync End */<BR>+&nbsp;&nbsp;&nbsp; {IGA1_HOR_SYNC_END_REG_NUM, =
{{CR05,0,4}}},<BR>+&nbsp;&nbsp;&nbsp; /* IGA1 Vertical Total =
*/<BR>+&nbsp;&nbsp;&nbsp; {IGA1_VER_TOTAL_REG_NUM, {{CR06,0,7}, =
{CR07,0,0}, {CR07,5,5}, {CR35,0,0}}},<BR>+&nbsp;&nbsp;&nbsp; /* IGA1 =
Vertical Addressable Video */<BR>+&nbsp;&nbsp;&nbsp; =
{IGA1_VER_ADDR_REG_NUM, {{CR12,0,7}, {CR07,1,1}, {CR07,6,6}, =
{CR35,2,2}}},<BR>+&nbsp;&nbsp;&nbsp; /* IGA1 Vertical Blank Start =
*/<BR>+&nbsp;&nbsp;&nbsp; {IGA1_VER_BLANK_START_REG_NUM, {{CR15,0,7}, =
{CR07,3,3}, {CR09,5,5}, {CR35,3,3}}},<BR>+&nbsp;&nbsp;&nbsp; /* IGA1 =
Vertical Blank End */<BR>+&nbsp;&nbsp;&nbsp; =
{IGA1_VER_BLANK_END_REG_NUM, {{CR16,0,7}}},<BR>+&nbsp;&nbsp;&nbsp; /* =
IGA1 Vertical Sync Start */<BR>+&nbsp;&nbsp;&nbsp; =
{IGA1_VER_SYNC_START_REG_NUM, {{CR10,0,7}, {CR07,2,2}, {CR07,7,7}, =
{CR35,1,1}}},<BR>+&nbsp;&nbsp;&nbsp; /* IGA1 Vertical Sync End =
*/<BR>+&nbsp;&nbsp;&nbsp; {IGA1_VER_SYNC_END_REG_NUM, =
{{CR11,0,3}}}<BR>+};<BR>+<BR>+static struct iga2_shadow_crtc_timing =
iga2_shadow_crtc_reg =3D {<BR>+&nbsp;&nbsp;&nbsp; /* IGA2 Shadow =
Horizontal Total */<BR>+&nbsp;&nbsp;&nbsp; =
{IGA2_SHADOW_HOR_TOTAL_REG_NUM, {{CR6D,0,7}, =
{CR71,3,3}}},<BR>+&nbsp;&nbsp;&nbsp; /* IGA2 Shadow Horizontal Blank End =
*/<BR>+&nbsp;&nbsp;&nbsp; {IGA2_SHADOW_HOR_BLANK_END_REG_NUM, =
{{CR6E,0,7}}},<BR>+&nbsp;&nbsp;&nbsp; /* IGA2 Shadow Vertical Total =
*/<BR>+&nbsp;&nbsp;&nbsp; {IGA2_SHADOW_VER_TOTAL_REG_NUM, {{CR6F,0,7}, =
{CR71,0,2}}},<BR>+&nbsp;&nbsp;&nbsp; /* IGA2 Shadow Vertical Addressable =
Video */<BR>+&nbsp;&nbsp;&nbsp; {IGA2_SHADOW_VER_ADDR_REG_NUM, =
{{CR70,0,7}, {CR71,4,6}}},<BR>+&nbsp;&nbsp;&nbsp; /* IGA2 Shadow =
Vertical Blank Start */<BR>+&nbsp;&nbsp;&nbsp; =
{IGA2_SHADOW_VER_BLANK_START_REG_NUM, {{CR72,0,7}, =
{CR74,4,6}}},<BR>+&nbsp;&nbsp;&nbsp; /* IGA2 Shadow Vertical Blank End =
*/<BR>+&nbsp;&nbsp;&nbsp; {IGA2_SHADOW_VER_BLANK_END_REG_NUM, =
{{CR73,0,7}, {CR74,0,2}}},<BR>+&nbsp;&nbsp;&nbsp; /* IGA2 Shadow =
Vertical Sync Start */<BR>+&nbsp;&nbsp;&nbsp; =
{IGA2_SHADOW_VER_SYNC_START_REG_NUM, {{CR75,0,7}, =
{CR76,4,6}}},<BR>+&nbsp;&nbsp;&nbsp; /* IGA2 Shadow Vertical Sync End =
*/<BR>+&nbsp;&nbsp;&nbsp; {IGA2_SHADOW_VER_SYNC_END_REG_NUM, =
{{CR76,0,3}}}<BR>+};<BR>+<BR>+static struct iga2_crtc_timing =
iga2_crtc_reg =3D {<BR>+&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal Total =
*/<BR>+&nbsp;&nbsp;&nbsp; {IGA2_HOR_TOTAL_REG_NUM, {{CR50,0,7}, =
{CR55,0,3}}},<BR>+&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal Addressable =
Video */<BR>+&nbsp;&nbsp;&nbsp; {IGA2_HOR_ADDR_REG_NUM, {{CR51,0,7}, =
{CR55,4,6}}},<BR>+&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal Blank Start =
*/<BR>+&nbsp;&nbsp;&nbsp; {IGA2_HOR_BLANK_START_REG_NUM, {{CR52,0,7}, =
{CR54,0,2}}},<BR>+&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal Blank End =
*/<BR>+&nbsp;&nbsp;&nbsp; {IGA2_HOR_BLANK_END_REG_NUM, {{CR53,0,7}, =
{CR54,3,5}, {CR5D,6,6}}},<BR>+&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal Sync =
Start */<BR>+&nbsp;&nbsp;&nbsp; {IGA2_HOR_SYNC_START_REG_NUM, =
{{CR56,0,7}, {CR54,6,7}, {CR5C,7,7}, =
{CR5D,7,7}}},<BR>+&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal Sync End =
*/<BR>+&nbsp;&nbsp;&nbsp; {IGA2_HOR_SYNC_END_REG_NUM, {{CR57,0,7}, =
{CR5C,6,6}}},<BR>+&nbsp;&nbsp;&nbsp; /* IGA2 Vertical Total =
*/<BR>+&nbsp;&nbsp;&nbsp; {IGA2_VER_TOTAL_REG_NUM, {{CR58,0,7}, =
{CR5D,0,2}}},<BR>+&nbsp;&nbsp;&nbsp; /* IGA2 Vertical Addressable Video =
*/<BR>+&nbsp;&nbsp;&nbsp; {IGA2_VER_ADDR_REG_NUM, {{CR59,0,7}, =
{CR5D,3,5}}},<BR>+&nbsp;&nbsp;&nbsp; /* IGA2 Vertical Blank Start =
*/<BR>+&nbsp;&nbsp;&nbsp; {IGA2_VER_BLANK_START_REG_NUM, {{CR5A,0,7}, =
{CR5C,0,2}}},<BR>+&nbsp;&nbsp;&nbsp; /* IGA2 Vertical Blank End =
*/<BR>+&nbsp;&nbsp;&nbsp; {IGA2_VER_BLANK_END_REG_NUM, {{CR5B,0,7}, =
{CR5C,3,5}}},<BR>+&nbsp;&nbsp;&nbsp; /* IGA2 Vertical Sync Start =
*/<BR>+&nbsp;&nbsp;&nbsp; {IGA2_VER_SYNC_START_REG_NUM, {{CR5E,0,7}, =
{CR5F,5,7}}},<BR>+&nbsp;&nbsp;&nbsp; /* IGA2 Vertical Sync End =
*/<BR>+&nbsp;&nbsp;&nbsp; {IGA2_VER_SYNC_END_REG_NUM, =
{{CR5F,0,4}}}<BR>+};<BR>+<BR>+static struct _lcd_scaling_factor =
lcd_scaling_factor =3D {<BR>+&nbsp;&nbsp;&nbsp; /* LCD Horizontal =
Scaling Factor Register */<BR>+&nbsp;&nbsp;&nbsp; =
{LCD_HOR_SCALING_FACTOR_REG_NUM, {{CR9F,0,1}, {CR77,0,7}, =
{CR79,4,5}}},<BR>+&nbsp;&nbsp;&nbsp; /* LCD Vertical Scaling Factor =
Register */<BR>+&nbsp;&nbsp;&nbsp; {LCD_VER_SCALING_FACTOR_REG_NUM, =
{{CR79,3,3}, {CR78,0,7}, {CR79,6,7}}}<BR>+};<BR>+static struct =
_lcd_scaling_factor lcd_scaling_factor_CLE =3D {<BR>+&nbsp;&nbsp;&nbsp; =
/* LCD Horizontal Scaling Factor Register */<BR>+&nbsp;&nbsp;&nbsp; =
{LCD_HOR_SCALING_FACTOR_REG_NUM_CLE, {{CR77,0,7}, =
{CR79,4,5}}},<BR>+&nbsp;&nbsp;&nbsp; /* LCD Vertical Scaling Factor =
Register */<BR>+&nbsp;&nbsp;&nbsp; {LCD_VER_SCALING_FACTOR_REG_NUM_CLE, =
{{CR78,0,7}, {CR79,6,7}}}<BR>+};<BR>+<BR>+static struct rgbLUT =
palLUT_table[]=3D {<BR>+&nbsp;&nbsp;&nbsp; /* {R,G,B} =
*/<BR>+&nbsp;&nbsp;&nbsp; /* Index 0x00~0x03 */<BR>+&nbsp;&nbsp;&nbsp; =
{0x00, 0x00, 0x00}, {0x00, 0x00, 0x2A}, {0x00, 0x2A, 0x00}, {0x00, 0x2A, =
0x2A},<BR>+&nbsp;&nbsp;&nbsp; /* Index 0x04~0x07 =
*/<BR>+&nbsp;&nbsp;&nbsp; {0x2A, 0x00, 0x00}, {0x2A, 0x00, 0x2A}, {0x2A, =
0x15, 0x00}, {0x2A, 0x2A, 0x2A},<BR>+&nbsp;&nbsp;&nbsp; /* Index =
0x08~0x0B */<BR>+&nbsp;&nbsp;&nbsp; {0x15, 0x15, 0x15}, {0x15, 0x15, =
0x3F}, {0x15, 0x3F, 0x15}, {0x15, 0x3F, 0x3F},<BR>+&nbsp;&nbsp;&nbsp; /* =
Index 0x0C~0x0F */<BR>+&nbsp;&nbsp;&nbsp; {0x3F, 0x15, 0x15}, {0x3F, =
0x15, 0x3F}, {0x3F, 0x3F, 0x15}, {0x3F, 0x3F, =
0x3F},<BR>+&nbsp;&nbsp;&nbsp; /* Index 0x10~0x13 =
*/<BR>+&nbsp;&nbsp;&nbsp; {0x00, 0x00, 0x00}, {0x05, 0x05, 0x05}, {0x08, =
0x08, 0x08}, {0x0B, 0x0B, 0x0B},<BR>+&nbsp;&nbsp;&nbsp; /* Index =
0x14~0x17 */<BR>+&nbsp;&nbsp;&nbsp; {0x0E, 0x0E, 0x0E}, {0x11, 0x11, =
0x11}, {0x14, 0x14, 0x14}, {0x18, 0x18, 0x18},<BR>+&nbsp;&nbsp;&nbsp; /* =
Index 0x18~0x1B */<BR>+&nbsp;&nbsp;&nbsp; {0x1C, 0x1C, 0x1C}, {0x20, =
0x20, 0x20}, {0x24, 0x24, 0x24}, {0x28, 0x28, =
0x28},<BR>+&nbsp;&nbsp;&nbsp; /* Index 0x1C~0x1F =
*/<BR>+&nbsp;&nbsp;&nbsp; {0x2D, 0x2D, 0x2D}, {0x32, 0x32, 0x32}, {0x38, =
0x38, 0x38}, {0x3F, 0x3F, 0x3F},<BR>+&nbsp;&nbsp;&nbsp; /* Index =
0x20~0x23 */<BR>+&nbsp;&nbsp;&nbsp; {0x00, 0x00, 0x3F}, {0x10, 0x00, =
0x3F}, {0x1F, 0x00, 0x3F}, {0x2F, 0x00, 0x3F},<BR>+&nbsp;&nbsp;&nbsp; /* =
Index 0x24~0x27 */<BR>+&nbsp;&nbsp;&nbsp; {0x3F, 0x00, 0x3F}, {0x3F, =
0x00, 0x2F}, {0x3F, 0x00, 0x1F}, {0x3F, 0x00, =
0x10},<BR>+&nbsp;&nbsp;&nbsp; /* Index 0x28~0x2B =
*/<BR>+&nbsp;&nbsp;&nbsp; {0x3F, 0x00, 0x00}, {0x3F, 0x10, 0x00}, {0x3F, =
0x1F, 0x00}, {0x3F, 0x2F, 0x00},<BR>+&nbsp;&nbsp;&nbsp; /* Index =
0x2C~0x2F */<BR>+&nbsp;&nbsp;&nbsp; {0x3F, 0x3F, 0x00}, {0x2F, 0x3F, =
0x00}, {0x1F, 0x3F, 0x00}, {0x10, 0x3F, 0x00},<BR>+&nbsp;&nbsp;&nbsp; /* =
Index 0x30~0x33 */<BR>+&nbsp;&nbsp;&nbsp; {0x00, 0x3F, 0x00}, {0x00, =
0x3F, 0x10}, {0x00, 0x3F, 0x1F}, {0x00, 0x3F, =
0x2F},<BR>+&nbsp;&nbsp;&nbsp; /* Index 0x34~0x37 =
*/<BR>+&nbsp;&nbsp;&nbsp; {0x00, 0x3F, 0x3F}, {0x00, 0x2F, 0x3F}, {0x00, =
0x1F, 0x3F}, {0x00, 0x10, 0x3F},<BR>+&nbsp;&nbsp;&nbsp; /* Index =
0x38~0x3B */<BR>+&nbsp;&nbsp;&nbsp; {0x1F, 0x1F, 0x3F}, {0x27, 0x1F, =
0x3F}, {0x2F, 0x1F, 0x3F}, {0x37, 0x1F, 0x3F},<BR>+&nbsp;&nbsp;&nbsp; /* =
Index 0x3C~0x3F */ <BR>+&nbsp;&nbsp;&nbsp; {0x3F, 0x1F, 0x3F}, {0x3F, =
0x1F, 0x37}, {0x3F, 0x1F, 0x2F}, {0x3F, 0x1F, =
0x27},<BR>+&nbsp;&nbsp;&nbsp; /* Index 0x40~0x43 =
*/<BR>+&nbsp;&nbsp;&nbsp; {0x3F, 0x1F, 0x1F}, {0x3F, 0x27, 0x1F}, {0x3F, =
0x2F, 0x1F}, {0x3F, 0x3F, 0x1F},<BR>+&nbsp;&nbsp;&nbsp; /* Index =
0x44~0x47 */<BR>+&nbsp;&nbsp;&nbsp; {0x3F, 0x3F, 0x1F}, {0x37, 0x3F, =
0x1F}, {0x2F, 0x3F, 0x1F}, {0x27, 0x3F, 0x1F},<BR>+&nbsp;&nbsp;&nbsp; /* =
Index 0x48~0x4B */<BR>+&nbsp;&nbsp;&nbsp; {0x1F, 0x3F, 0x1F}, {0x1F, =
0x3F, 0x27}, {0x1F, 0x3F, 0x2F}, {0x1F, 0x3F, =
0x37},<BR>+&nbsp;&nbsp;&nbsp; /* Index 0x4C~0x4F =
*/<BR>+&nbsp;&nbsp;&nbsp; {0x1F, 0x3F, 0x3F}, {0x1F, 0x37, 0x3F}, {0x1F, =
0x2F, 0x3F}, {0x1F, 0x27, 0x3F},<BR>+&nbsp;&nbsp;&nbsp; /* Index =
0x50~0x53 */<BR>+&nbsp;&nbsp;&nbsp; {0x2D, 0x2D, 0x3F}, {0x31, 0x2D, =
0x3F}, {0x36, 0x2D, 0x3F}, {0x3A, 0x2D, 0x3F},<BR>+&nbsp;&nbsp;&nbsp; /* =
Index 0x54~0x57 */<BR>+&nbsp;&nbsp;&nbsp; {0x3F, 0x2D, 0x3F}, {0x3F, =
0x2D, 0x3A}, {0x3F, 0x2D, 0x36}, {0x3F, 0x2D, =
0x31},<BR>+&nbsp;&nbsp;&nbsp; /* Index 0x58~0x5B =
*/<BR>+&nbsp;&nbsp;&nbsp; {0x3F, 0x2D, 0x2D}, {0x3F, 0x31, 0x2D}, {0x3F, =
0x36, 0x2D}, {0x3F, 0x3A, 0x2D},<BR>+&nbsp;&nbsp;&nbsp; /* Index =
0x5C~0x5F */<BR>+&nbsp;&nbsp;&nbsp; {0x3F, 0x3F, 0x2D}, {0x3A, 0x3F, =
0x2D}, {0x36, 0x3F, 0x2D}, {0x31, 0x3F, 0x2D},<BR>+&nbsp;&nbsp;&nbsp; /* =
Index 0x60~0x63 */<BR>+&nbsp;&nbsp;&nbsp; {0x2D, 0x3F, 0x2D}, {0x2D, =
0x3F, 0x31}, {0x2D, 0x3F, 0x36}, {0x2D, 0x3F, =
0x3A},<BR>+&nbsp;&nbsp;&nbsp; /* Index 0x64~0x67 =
*/<BR>+&nbsp;&nbsp;&nbsp; {0x2D, 0x3F, 0x3F}, {0x2D, 0x3A, 0x3F}, {0x2D, =
0x36, 0x3F}, {0x2D, 0x31, 0x3F},<BR>+&nbsp;&nbsp;&nbsp; /* Index =
0x68~0x6B */<BR>+&nbsp;&nbsp;&nbsp; {0x00, 0x00, 0x1C}, {0x07, 0x00, =
0x1C}, {0x0E, 0x00, 0x1C}, {0x15, 0x00, 0x1C},<BR>+&nbsp;&nbsp;&nbsp; /* =
Index 0x6C~0x6F */<BR>+&nbsp;&nbsp;&nbsp; {0x1C, 0x00, 0x1C}, {0x1C, =
0x00, 0x15}, {0x1C, 0x00, 0x0E}, {0x1C, 0x00, =
0x07},<BR>+&nbsp;&nbsp;&nbsp; /* Index 0x70~0x73 =
*/<BR>+&nbsp;&nbsp;&nbsp; {0x1C, 0x00, 0x00}, {0x1C, 0x07, 0x00}, {0x1C, =
0x0E, 0x00}, {0x1C, 0x15, 0x00},<BR>+&nbsp;&nbsp;&nbsp; /* Index =
0x74~0x77 */<BR>+&nbsp;&nbsp;&nbsp; {0x1C, 0x1C, 0x00}, {0x15, 0x1C, =
0x00}, {0x0E, 0x1C, 0x00}, {0x07, 0x1C, 0x00},<BR>+&nbsp;&nbsp;&nbsp; /* =
Index 0x78~0x7B */<BR>+&nbsp;&nbsp;&nbsp; {0x00, 0x1C, 0x00}, {0x00, =
0x1C, 0x07}, {0x00, 0x1C, 0x0E}, {0x00, 0x1C, =
0x15},<BR>+&nbsp;&nbsp;&nbsp; /* Index 0x7C~0x7F =
*/<BR>+&nbsp;&nbsp;&nbsp; {0x00, 0x1C, 0x1C}, {0x00, 0x15, 0x1C}, {0x00, =
0x0E, 0x1C}, {0x00, 0x07, 0x1C},<BR>+&nbsp;&nbsp;&nbsp; /* Index =
0x80~0x83 */<BR>+&nbsp;&nbsp;&nbsp; {0x0E, 0x0E, 0x1C}, {0x11, 0x0E, =
0x1C}, {0x15, 0x0E, 0x1C}, {0x18, 0x0E, 0x1C},<BR>+&nbsp;&nbsp;&nbsp; /* =
Index 0x84~0x87 */<BR>+&nbsp;&nbsp;&nbsp; {0x1C, 0x0E, 0x1C}, {0x1C, =
0x0E, 0x18}, {0x1C, 0x0E, 0x15}, {0x1C, 0x0E, =
0x11},<BR>+&nbsp;&nbsp;&nbsp; /* Index 0x88~0x8B =
*/<BR>+&nbsp;&nbsp;&nbsp; {0x1C, 0x0E, 0x0E}, {0x1C, 0x11, 0x0E}, {0x1C, =
0x15, 0x0E}, {0x1C, 0x18, 0x0E},<BR>+&nbsp;&nbsp;&nbsp; /* Index =
0x8C~0x8F */<BR>+&nbsp;&nbsp;&nbsp; {0x1C, 0x1C, 0x0E}, {0x18, 0x1C, =
0x0E}, {0x15, 0x1C, 0x0E}, {0x11, 0x1C, 0x0E},<BR>+&nbsp;&nbsp;&nbsp; /* =
Index 0x90~0x93 */<BR>+&nbsp;&nbsp;&nbsp; {0x0E, 0x1C, 0x0E}, {0x0E, =
0x1C, 0x11}, {0x0E, 0x1C, 0x15}, {0x0E, 0x1C, =
0x18},<BR>+&nbsp;&nbsp;&nbsp; /* Index 0x94~0x97 =
*/<BR>+&nbsp;&nbsp;&nbsp; {0x0E, 0x1C, 0x1C}, {0x0E, 0x18, 0x1C}, {0x0E, =
0x15, 0x1C}, {0x0E, 0x11, 0x1C},<BR>+&nbsp;&nbsp;&nbsp; /* Index =
0x98~0x9B */<BR>+&nbsp;&nbsp;&nbsp; {0x14, 0x14, 0x1C}, {0x16, 0x14, =
0x1C}, {0x18, 0x14, 0x1C}, {0x1A, 0x14, 0x1C},<BR>+&nbsp;&nbsp;&nbsp; /* =
Index 0x9C~0x9F */<BR>+&nbsp;&nbsp;&nbsp; {0x1C, 0x14, 0x1C}, {0x1C, =
0x14, 0x1A}, {0x1C, 0x14, 0x18}, {0x1C, 0x14, =
0x16},<BR>+&nbsp;&nbsp;&nbsp; /* Index 0xA0~0xA3 =
*/<BR>+&nbsp;&nbsp;&nbsp; {0x1C, 0x14, 0x14}, {0x1C, 0x16, 0x14}, {0x1C, =
0x18, 0x14}, {0x1C, 0x1A, 0x14},<BR>+&nbsp;&nbsp;&nbsp; /* Index =
0xA4~0xA7 */<BR>+&nbsp;&nbsp;&nbsp; {0x1C, 0x1C, 0x14}, {0x1A, 0x1C, =
0x14}, {0x18, 0x1C, 0x14}, {0x16, 0x1C, 0x14},<BR>+&nbsp;&nbsp;&nbsp; /* =
Index 0xA8~0xAB */<BR>+&nbsp;&nbsp;&nbsp; {0x14, 0x1C, 0x14}, {0x14, =
0x1C, 0x16}, {0x14, 0x1C, 0x18}, {0x14, 0x1C, =
0x1A},<BR>+&nbsp;&nbsp;&nbsp; /* Index 0xAC~0xAF =
*/<BR>+&nbsp;&nbsp;&nbsp; {0x14, 0x1C, 0x1C}, {0x14, 0x1A, 0x1C}, {0x14, =
0x18, 0x1C}, {0x14, 0x16, 0x1C},<BR>+&nbsp;&nbsp;&nbsp; /* Index =
0xB0~0xB3 */<BR>+&nbsp;&nbsp;&nbsp; {0x00, 0x00, 0x10}, {0x04, 0x00, =
0x10}, {0x08, 0x00, 0x10}, {0x0C, 0x00, 0x10},<BR>+&nbsp;&nbsp;&nbsp; /* =
Index 0xB4~0xB7 */<BR>+&nbsp;&nbsp;&nbsp; {0x10, 0x00, 0x10}, {0x10, =
0x00, 0x0C}, {0x10, 0x00, 0x08}, {0x10, 0x00, =
0x04},<BR>+&nbsp;&nbsp;&nbsp; /* Index 0xB8~0xBB =
*/<BR>+&nbsp;&nbsp;&nbsp; {0x10, 0x00, 0x00}, {0x10, 0x04, 0x00}, {0x10, =
0x08, 0x00}, {0x10, 0x0C, 0x00},<BR>+&nbsp;&nbsp;&nbsp; /* Index =
0xBC~0xBF */<BR>+&nbsp;&nbsp;&nbsp; {0x10, 0x10, 0x00}, {0x0C, 0x10, =
0x00}, {0x08, 0x10, 0x00}, {0x04, 0x10, 0x00},<BR>+&nbsp;&nbsp;&nbsp; /* =
Index 0xC0~0xC3 */<BR>+&nbsp;&nbsp;&nbsp; {0x00, 0x10, 0x00}, {0x00, =
0x10, 0x04}, {0x00, 0x10, 0x08}, {0x00, 0x10, =
0x0C},<BR>+&nbsp;&nbsp;&nbsp; /* Index 0xC4~0xC7 =
*/<BR>+&nbsp;&nbsp;&nbsp; {0x00, 0x10, 0x10}, {0x00, 0x0C, 0x10}, {0x00, =
0x08, 0x10}, {0x00, 0x04, 0x10},<BR>+&nbsp;&nbsp;&nbsp; /* Index =
0xC8~0xCB */<BR>+&nbsp;&nbsp;&nbsp; {0x08, 0x08, 0x10}, {0x0A, 0x08, =
0x10}, {0x0C, 0x08, 0x10}, {0x0E, 0x08, 0x10},<BR>+&nbsp;&nbsp;&nbsp; /* =
Index 0xCC~0xCF */<BR>+&nbsp;&nbsp;&nbsp; {0x10, 0x08, 0x10}, {0x10, =
0x08, 0x0E}, {0x10, 0x08, 0x0C}, {0x10, 0x08, =
0x0A},<BR>+&nbsp;&nbsp;&nbsp; /* Index 0xD0~0xD3 =
*/<BR>+&nbsp;&nbsp;&nbsp; {0x10, 0x08, 0x08}, {0x10, 0x0A, 0x08}, {0x10, =
0x0C, 0x08}, {0x10, 0x0E, 0x08},<BR>+&nbsp;&nbsp;&nbsp; /* Index =
0xD4~0xD7 */<BR>+&nbsp;&nbsp;&nbsp; {0x10, 0x10, 0x08}, {0x0E, 0x10, =
0x08}, {0x0C, 0x10, 0x08}, {0x0A, 0x10, 0x08},<BR>+&nbsp;&nbsp;&nbsp; /* =
Index 0xD8~0xDB */<BR>+&nbsp;&nbsp;&nbsp; {0x08, 0x10, 0x08}, {0x08, =
0x10, 0x0A}, {0x08, 0x10, 0x0C}, {0x08, 0x10, =
0x0E},<BR>+&nbsp;&nbsp;&nbsp; /* Index 0xDC~0xDF =
*/<BR>+&nbsp;&nbsp;&nbsp; {0x08, 0x10, 0x10}, {0x08, 0x0E, 0x10}, {0x08, =
0x0C, 0x10}, {0x08, 0x0A, 0x10},<BR>+&nbsp;&nbsp;&nbsp; /* Index =
0xE0~0xE3 */<BR>+&nbsp;&nbsp;&nbsp; {0x0B, 0x0B, 0x10}, {0x0C, 0x0B, =
0x10}, {0x0D, 0x0B, 0x10}, {0x0F, 0x0B, 0x10},<BR>+&nbsp;&nbsp;&nbsp; /* =
Index 0xE4~0xE7 */<BR>+&nbsp;&nbsp;&nbsp; {0x10, 0x0B, 0x10}, {0x10, =
0x0B, 0x0F}, {0x10, 0x0B, 0x0D}, {0x10, 0x0B, =
0x0C},<BR>+&nbsp;&nbsp;&nbsp; /* Index 0xE8~0xEB =
*/<BR>+&nbsp;&nbsp;&nbsp; {0x10, 0x0B, 0x0B}, {0x10, 0x0C, 0x0B}, {0x10, =
0x0D, 0x0B}, {0x10, 0x0F, 0x0B},<BR>+&nbsp;&nbsp;&nbsp; /* Index =
0xEC~0xEF */<BR>+&nbsp;&nbsp;&nbsp; {0x10, 0x10, 0x0B}, {0x0F, 0x10, =
0x0B}, {0x0D, 0x10, 0x0B}, {0x0C, 0x10, 0x0B},<BR>+&nbsp;&nbsp;&nbsp; /* =
Index 0xF0~0xF3 */<BR>+&nbsp;&nbsp;&nbsp; {0x0B, 0x10, 0x0B}, {0x0B, =
0x10, 0x0C}, {0x0B, 0x10, 0x0D}, {0x0B, 0x10, =
0x0F},<BR>+&nbsp;&nbsp;&nbsp; /* Index 0xF4~0xF7 =
*/<BR>+&nbsp;&nbsp;&nbsp; {0x0B, 0x10, 0x10}, {0x0B, 0x0F, 0x10}, {0x0B, =
0x0D, 0x10}, {0x0B, 0x0C, 0x10},<BR>+&nbsp;&nbsp;&nbsp; /* Index =
0xF8~0xFB */<BR>+&nbsp;&nbsp;&nbsp; {0x00, 0x00, 0x00}, {0x00, 0x00, =
0x00}, {0x00, 0x00, 0x00}, {0x00, 0x00, 0x00},<BR>+&nbsp;&nbsp;&nbsp; /* =
Index 0xFC~0xFF */<BR>+&nbsp;&nbsp;&nbsp; {0x00, 0x00, 0x00}, {0x00, =
0x00, 0x00}, {0x00, 0x00, 0x00}, {0x00, 0x00, =
0x00}<BR>+};<BR>+<BR>+static u16 red256[] =3D {<BR>+0x0&nbsp;&nbsp; =
,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; =
,0xa800,0xa800,0xa800,0xa800,0x5400,0x5400,0x5400,0x5400,0xfc00,0xfc00,0x=
fc00,0xfc00,<BR>+0x0&nbsp;&nbsp; =
,0x1400,0x2000,0x2c00,0x3800,0x4400,0x5000,0x6000,0x7000,0x8000,0x9000,0x=
a000,0xb400,0xc800,0xe000,0xfc00,<BR>+0x0&nbsp;&nbsp; =
,0x4000,0x7c00,0xbc00,0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0x=
fc00,0xfc00,0xbc00,0x7c00,0x4000,<BR>+0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; =
,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; =
,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; =
,0x7c00,0x9c00,0xbc00,0xdc00,0xfc00,0xfc00,0xfc00,0xfc00,<BR>+0xfc00,0xfc=
00,0xfc00,0xfc00,0xfc00,0xdc00,0xbc00,0x9c00,0x7c00,0x7c00,0x7c00,0x7c00,=
0x7c00,0x7c00,0x7c00,0x7c00,<BR>+0xb400,0xc400,0xd800,0xe800,0xfc00,0xfc0=
0,0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0xe800,0xd800,0xc400,<=
BR>+0xb400,0xb400,0xb400,0xb400,0xb400,0xb400,0xb400,0xb400,0x0&nbsp;&nbs=
p; =
,0x1c00,0x3800,0x5400,0x7000,0x7000,0x7000,0x7000,<BR>+0x7000,0x7000,0x70=
00,0x7000,0x7000,0x5400,0x3800,0x1c00,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; =
,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; =
,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; =
,<BR>+0x3800,0x4400,0x5400,0x6000,0x7000,0x7000,0x7000,0x7000,0x7000,0x70=
00,0x7000,0x7000,0x7000,0x6000,0x5400,0x4400,<BR>+0x3800,0x3800,0x3800,0x=
3800,0x3800,0x3800,0x3800,0x3800,0x5000,0x5800,0x6000,0x6800,0x7000,0x700=
0,0x7000,0x7000,<BR>+0x7000,0x7000,0x7000,0x7000,0x7000,0x6800,0x6000,0x5=
800,0x5000,0x5000,0x5000,0x5000,0x5000,0x5000,0x5000,0x5000,<BR>+0x0&nbsp=
;&nbsp; =
,0x1000,0x2000,0x3000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x=
4000,0x4000,0x3000,0x2000,0x1000,<BR>+0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; =
,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; =
,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; =
,0x2000,0x2800,0x3000,0x3800,0x4000,0x4000,0x4000,0x4000,<BR>+0x4000,0x40=
00,0x4000,0x4000,0x4000,0x3800,0x3000,0x2800,0x2000,0x2000,0x2000,0x2000,=
0x2000,0x2000,0x2000,0x2000,<BR>+0x2c00,0x3000,0x3400,0x3c00,0x4000,0x400=
0,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x3c00,0x3400,0x3000,<=
BR>+0x2c00,0x2c00,0x2c00,0x2c00,0x2c00,0x2c00,0x2c00,0x2c00,0x0&nbsp;&nbs=
p; ,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; =
,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; ,0x0<BR>+};<BR>+static u16 green256[] =
=3D {<BR>+0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; =
,0xa800,0xa800,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; =
,0x5400,0xa800,0x5400,0x5400,0xfc00,0xfc00,0x5400,0x5400,0xfc00,0xfc00,<B=
R>+0x0&nbsp;&nbsp; =
,0x1400,0x2000,0x2c00,0x3800,0x4400,0x5000,0x6000,0x7000,0x8000,0x9000,0x=
a000,0xb400,0xc800,0xe000,0xfc00,<BR>+0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; =
,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; =
,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; =
,0x7c00,0xbc00,0xfc00,0xfc00,0xfc00,0xfc00,<BR>+0xfc00,0xfc00,0xfc00,0xfc=
00,0xfc00,0xbc00,0x7c00,0x4000,0x7c00,0x7c00,0x7c00,0x7c00,0x7c00,0x7c00,=
0x7c00,0x7c00,<BR>+0x7c00,0x9c00,0xbc00,0xdc00,0xfc00,0xfc00,0xfc00,0xfc0=
0,0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0xdc00,0xbc00,0x9c00,<BR>+0xb400,0xb=
400,0xb400,0xb400,0xb400,0xb400,0xb400,0xb400,0xb400,0xc400,0xd800,0xe800=
,0xfc00,0xfc00,0xfc00,0xfc00,<BR>+0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0xe8=
00,0xd800,0xc400,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; =
,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; =
,0x0&nbsp;&nbsp; ,<BR>+0x0&nbsp;&nbsp; =
,0x1c00,0x3800,0x5400,0x7000,0x7000,0x7000,0x7000,0x7000,0x7000,0x7000,0x=
7000,0x7000,0x5400,0x3800,0x1c00,<BR>+0x3800,0x3800,0x3800,0x3800,0x3800,=
0x3800,0x3800,0x3800,0x3800,0x4400,0x5400,0x6000,0x7000,0x7000,0x7000,0x7=
000,<BR>+0x7000,0x7000,0x7000,0x7000,0x7000,0x6000,0x5400,0x4400,0x5000,0=
x5000,0x5000,0x5000,0x5000,0x5000,0x5000,0x5000,<BR>+0x5000,0x5800,0x6000=
,0x6800,0x7000,0x7000,0x7000,0x7000,0x7000,0x7000,0x7000,0x7000,0x7000,0x=
6800,0x6000,0x5800,<BR>+0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; =
,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; =
,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; =
,0x1000,0x2000,0x3000,0x4000,0x4000,0x4000,0x4000,<BR>+0x4000,0x4000,0x40=
00,0x4000,0x4000,0x3000,0x2000,0x1000,0x2000,0x2000,0x2000,0x2000,0x2000,=
0x2000,0x2000,0x2000,<BR>+0x2000,0x2800,0x3000,0x3800,0x4000,0x4000,0x400=
0,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x3800,0x3000,0x2800,<BR>+0x2=
c00,0x2c00,0x2c00,0x2c00,0x2c00,0x2c00,0x2c00,0x2c00,0x2c00,0x3000,0x3400=
,0x3c00,0x4000,0x4000,0x4000,0x4000,<BR>+0x4000,0x4000,0x4000,0x4000,0x40=
00,0x3c00,0x3400,0x3000,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; =
,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; =
,0x0&nbsp;&nbsp; ,0x0<BR>+};<BR>+static u16 blue256[] =3D =
{<BR>+0x0&nbsp;&nbsp; ,0xa800,0x0&nbsp;&nbsp; ,0xa800,0x0&nbsp;&nbsp; =
,0xa800,0x0&nbsp;&nbsp; =
,0xa800,0x5400,0xfc00,0x5400,0xfc00,0x5400,0xfc00,0x5400,0xfc00,<BR>+0x0&=
nbsp;&nbsp; =
,0x1400,0x2000,0x2c00,0x3800,0x4400,0x5000,0x6000,0x7000,0x8000,0x9000,0x=
a000,0xb400,0xc800,0xe000,0xfc00,<BR>+0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,=
0xbc00,0x7c00,0x4000,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; =
,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; =
,0x0&nbsp;&nbsp; ,<BR>+0x0&nbsp;&nbsp; =
,0x4000,0x7c00,0xbc00,0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0x=
fc00,0xfc00,0xdc00,0xbc00,0x9c00,<BR>+0x7c00,0x7c00,0x7c00,0x7c00,0x7c00,=
0x7c00,0x7c00,0x7c00,0x7c00,0x9c00,0xbc00,0xdc00,0xfc00,0xfc00,0xfc00,0xf=
c00,<BR>+0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0xe800,0xd800,0xc400,0xb400,0=
xb400,0xb400,0xb400,0xb400,0xb400,0xb400,0xb400,<BR>+0xb400,0xc400,0xd800=
,0xe800,0xfc00,0xfc00,0xfc00,0xfc00,0x7000,0x7000,0x7000,0x7000,0x7000,0x=
5400,0x3800,0x1c00,<BR>+0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; =
,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; =
,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; =
,0x1c00,0x3800,0x5400,0x7000,0x7000,0x7000,0x7000,<BR>+0x7000,0x7000,0x70=
00,0x7000,0x7000,0x6000,0x5400,0x4400,0x3800,0x3800,0x3800,0x3800,0x3800,=
0x3800,0x3800,0x3800,<BR>+0x3800,0x4400,0x5400,0x6000,0x7000,0x7000,0x700=
0,0x7000,0x7000,0x7000,0x7000,0x7000,0x7000,0x6800,0x6000,0x5800,<BR>+0x5=
000,0x5000,0x5000,0x5000,0x5000,0x5000,0x5000,0x5000,0x5000,0x5800,0x6000=
,0x6800,0x7000,0x7000,0x7000,0x7000,<BR>+0x4000,0x4000,0x4000,0x4000,0x40=
00,0x3000,0x2000,0x1000,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; =
,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; =
,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; ,<BR>+0x0&nbsp;&nbsp; =
,0x1000,0x2000,0x3000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x=
4000,0x4000,0x3800,0x3000,0x2800,<BR>+0x2000,0x2000,0x2000,0x2000,0x2000,=
0x2000,0x2000,0x2000,0x2000,0x2800,0x3000,0x3800,0x4000,0x4000,0x4000,0x4=
000,<BR>+0x4000,0x4000,0x4000,0x4000,0x4000,0x3c00,0x3400,0x3000,0x2c00,0=
x2c00,0x2c00,0x2c00,0x2c00,0x2c00,0x2c00,0x2c00,<BR>+0x2c00,0x3000,0x3400=
,0x3c00,0x4000,0x4000,0x4000,0x4000,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; =
,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; ,0x0&nbsp;&nbsp; =
,0x0&nbsp;&nbsp; ,0x0<BR>+};<BR>+#endif /* __HWCFIG_H__ =
*/<BR>+<BR>+<BR>+<BR>+<BR>diff -Nur =
linux-2.6.21-rc7/drivers/video/via/hw.h =
linux-2.6.21-rc7.viafb/drivers/video/via/hw.h<BR>--- =
linux-2.6.21-rc7/drivers/video/via/hw.h&nbsp;1969-12-31 =
19:00:00.000000000 -0500<BR>+++ =
linux-2.6.21-rc7.viafb/drivers/video/via/hw.h&nbsp;2007-04-26 =
19:52:32.000000000 -0400<BR>@@ -0,0 +1,749 @@<BR>+ /*<BR>+ * Copyright =
1998-2007 VIA Technologies, Inc. All Rights Reserved.<BR>+ * Copyright =
2001-2007 S3 Graphics, Inc. All Rights Reserved.<BR>+ *<BR>+ * =
Permission is hereby granted, free of charge, to any person obtaining =
a<BR>+ * copy of this software and associated documentation files (the =
"Software"),<BR>+ * to deal in the Software without restriction, =
including without limitation<BR>+ * the rights to use, copy, modify, =
merge, publish, distribute, sub license,<BR>+ * and/or sell copies of =
the Software, and to permit persons to whom the<BR>+ * Software is =
furnished to do so, subject to the following conditions:<BR>+ *<BR>+ * =
The above copyright notice and this permission notice (including =
the<BR>+ * next paragraph) shall be included in all copies or =
substantial portions<BR>+ * of the Software.<BR>+ *<BR>+ * THE SOFTWARE =
IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR<BR>+ * =
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF =
MERCHANTABILITY,<BR>+ * FITNESS FOR A PARTICULAR PURPOSE AND =
NON-INFRINGEMENT. IN NO EVENT SHALL<BR>+ * THE AUTHOR(S) OR COPYRIGHT =
HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR<BR>+ * OTHER LIABILITY, =
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,<BR>+ * ARISING =
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER<BR>+ =
* DEALINGS IN THE SOFTWARE.<BR>+ */<BR>+ <BR>+<BR>+#ifndef =
__HW_H__<BR>+#define __HW_H__<BR>+<BR>+#include =
&lt;linux/ioport.h&gt;<BR>+#include &lt;asm/io.h&gt;<BR>+<BR>+#include =
"share.h"<BR>+<BR>+<BR>+/************************************************=
***/<BR>+/* Definition IGA1 Design Method of CRTC Registers =
*/<BR>+/***************************************************/<BR>+#define =
IGA1_HOR_TOTAL_FORMULA(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; ((x)/8)-5<BR>+#define =
IGA1_HOR_ADDR_FORMULA(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; ((x)/8)-1<BR>+#define =
IGA1_HOR_BLANK_START_FORMULA(x)&nbsp;&nbsp;&nbsp;&nbsp; =
((x)/8)-1<BR>+#define =
IGA1_HOR_BLANK_END_FORMULA(x,y)&nbsp;&nbsp;&nbsp;&nbsp; =
((x+y)/8)-1<BR>+#define =
IGA1_HOR_SYNC_START_FORMULA(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
((x)/8)<BR>+#define =
IGA1_HOR_SYNC_END_FORMULA(x,y)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
((x+y)/8)<BR>+<BR>+#define =
IGA1_VER_TOTAL_FORMULA(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; (x)-2<BR>+#define =
IGA1_VER_ADDR_FORMULA(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; (x)-1<BR>+#define =
IGA1_VER_BLANK_START_FORMULA(x)&nbsp;&nbsp;&nbsp;&nbsp; =
(x)-1<BR>+#define =
IGA1_VER_BLANK_END_FORMULA(x,y)&nbsp;&nbsp;&nbsp;&nbsp; =
(x+y)-1<BR>+#define =
IGA1_VER_SYNC_START_FORMULA(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
(x)-1<BR>+#define =
IGA1_VER_SYNC_END_FORMULA(x,y)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
(x+y)-1<BR>+<BR>+/***************************************************/<BR=
>+/* Definition IGA2 Design Method of CRTC Registers =
*/<BR>+/***************************************************/<BR>+#define =
IGA2_HOR_TOTAL_FORMULA(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; (x)-1<BR>+#define =
IGA2_HOR_ADDR_FORMULA(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; (x)-1<BR>+#define =
IGA2_HOR_BLANK_START_FORMULA(x)&nbsp;&nbsp;&nbsp;&nbsp; =
(x)-1<BR>+#define =
IGA2_HOR_BLANK_END_FORMULA(x,y)&nbsp;&nbsp;&nbsp;&nbsp; =
(x+y)-1<BR>+#define =
IGA2_HOR_SYNC_START_FORMULA(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
(x)-1<BR>+#define =
IGA2_HOR_SYNC_END_FORMULA(x,y)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
(x+y)-1<BR>+<BR>+#define =
IGA2_VER_TOTAL_FORMULA(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; (x)-1<BR>+#define =
IGA2_VER_ADDR_FORMULA(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; (x)-1<BR>+#define =
IGA2_VER_BLANK_START_FORMULA(x)&nbsp;&nbsp;&nbsp;&nbsp; =
(x)-1<BR>+#define =
IGA2_VER_BLANK_END_FORMULA(x,y)&nbsp;&nbsp;&nbsp;&nbsp; =
(x+y)-1<BR>+#define =
IGA2_VER_SYNC_START_FORMULA(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
(x)-1<BR>+#define =
IGA2_VER_SYNC_END_FORMULA(x,y)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
(x+y)-1<BR>+<BR>+/*******************************************************=
***/<BR>+/* Definition IGA2 Design Method of CRTC Shadow Registers =
*/<BR>+/**********************************************************/<BR>+#=
define =
IGA2_HOR_TOTAL_SHADOW_FORMULA(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; (x/8)-5<BR>+#define =
IGA2_HOR_BLANK_END_SHADOW_FORMULA(x,y)&nbsp;&nbsp;&nbsp;&nbsp; =
((x+y)/8)-1<BR>+#define =
IGA2_VER_TOTAL_SHADOW_FORMULA(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; (x)-2<BR>+#define =
IGA2_VER_ADDR_SHADOW_FORMULA(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; (x)-1<BR>+#define =
IGA2_VER_BLANK_START_SHADOW_FORMULA(x)&nbsp;&nbsp;&nbsp;&nbsp; =
(x)-1<BR>+#define =
IGA2_VER_BLANK_END_SHADOW_FORMULA(x,y)&nbsp;&nbsp;&nbsp;&nbsp; =
(x+y)-1<BR>+#define =
IGA2_VER_SYNC_START_SHADOW_FORMULA(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
(x)<BR>+#define =
IGA2_VER_SYNC_END_SHADOW_FORMULA(x,y)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
(x+y)<BR>+<BR>+/* Define Register Number for IGA1 CRTC Timing =
*/<BR>+#define =
IGA1_HOR_TOTAL_REG_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
location: {CR00,0,7},{CR36,3,3} */<BR>+#define =
IGA1_HOR_ADDR_REG_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* location: {CR01,0,7} */<BR>+#define =
IGA1_HOR_BLANK_START_REG_NUM&nbsp;&nbsp;&nbsp; =
1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
location: {CR02,0,7} */<BR>+#define =
IGA1_HOR_BLANK_END_REG_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
location: {CR03,0,4},{CR05,7,7},{CR33,5,5} */<BR>+#define =
IGA1_HOR_SYNC_START_REG_NUM&nbsp;&nbsp;&nbsp;&nbsp; =
2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
location: {CR04,0,7},{CR33,4,4} */<BR>+#define =
IGA1_HOR_SYNC_END_REG_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
location: {CR05,0,4} */<BR>+#define =
IGA1_VER_TOTAL_REG_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
location: {CR06,0,7},{CR07,0,0},{CR07,5,5},{CR35,0,0} */<BR>+#define =
IGA1_VER_ADDR_REG_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* location: {CR12,0,7},{CR07,1,1},{CR07,6,6},{CR35,2,2} */<BR>+#define =
IGA1_VER_BLANK_START_REG_NUM&nbsp;&nbsp;&nbsp; =
4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
location: {CR15,0,7},{CR07,3,3},{CR09,5,5},{CR35,3,3} */<BR>+#define =
IGA1_VER_BLANK_END_REG_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
location: {CR16,0,7} */<BR>+#define =
IGA1_VER_SYNC_START_REG_NUM&nbsp;&nbsp;&nbsp;&nbsp; =
4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
location: {CR10,0,7},{CR07,2,2},{CR07,7,7},{CR35,1,1} */<BR>+#define =
IGA1_VER_SYNC_END_REG_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
location: {CR11,0,3} */<BR>+<BR>+/* Define Register Number for IGA2 =
Shadow CRTC Timing */<BR>+#define =
IGA2_SHADOW_HOR_TOTAL_REG_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* location: {CR6D,0,7},{CR71,3,3} =
*/<BR>+#define IGA2_SHADOW_HOR_BLANK_END_REG_NUM&nbsp;&nbsp; =
1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* location: {CR6E,0,7} =
*/<BR>+#define =
IGA2_SHADOW_VER_TOTAL_REG_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* location: {CR6F,0,7},{CR71,0,2} =
*/<BR>+#define =
IGA2_SHADOW_VER_ADDR_REG_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* location: {CR70,0,7},{CR71,4,6} =
*/<BR>+#define IGA2_SHADOW_VER_BLANK_START_REG_NUM =
2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* location: {CR72,0,7},{CR74,4,6} =
*/<BR>+#define IGA2_SHADOW_VER_BLANK_END_REG_NUM&nbsp;&nbsp; =
2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* location: {CR73,0,7},{CR74,0,2} =
*/<BR>+#define IGA2_SHADOW_VER_SYNC_START_REG_NUM&nbsp; =
2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* location: {CR75,0,7},{CR76,4,6} =
*/<BR>+#define IGA2_SHADOW_VER_SYNC_END_REG_NUM&nbsp;&nbsp;&nbsp; =
1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* location: {CR76,0,3} =
*/<BR>+<BR>+/* Define Register Number for IGA2 CRTC Timing =
*/<BR>+#define =
IGA2_HOR_TOTAL_REG_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
location: {CR50,0,7},{CR55,0,3} */<BR>+#define =
IGA2_HOR_ADDR_REG_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* location: {CR51,0,7},{CR55,4,6} */<BR>+#define =
IGA2_HOR_BLANK_START_REG_NUM&nbsp;&nbsp;&nbsp; =
2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
location: {CR52,0,7},{CR54,0,2} */<BR>+#define =
IGA2_HOR_BLANK_END_REG_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
location: CLE266: {CR53,0,7},{CR54,3,5} =3D&gt; CLE266's CR5D[6] is =
reserved, so it may have problem to set 1600x1200 on IGA2. =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; =
/*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Others: =
{CR53,0,7},{CR54,3,5},{CR5D,6,6} */<BR>+#define =
IGA2_HOR_SYNC_START_REG_NUM&nbsp;&nbsp;&nbsp;&nbsp; =
4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
location: {CR56,0,7},{CR54,6,7},{CR5C,7,7} =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 /* VT3314 and Later: {CR56,0,7},{CR54,6,7},{CR5C,7,7}, {CR5D,7,7} =
*/<BR>+#define =
IGA2_HOR_SYNC_END_REG_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
location: {CR57,0,7},{CR5C,6,6} */<BR>+#define =
IGA2_VER_TOTAL_REG_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
location: {CR58,0,7},{CR5D,0,2} */ <BR>+#define =
IGA2_VER_ADDR_REG_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* location: {CR59,0,7},{CR5D,3,5} */<BR>+#define =
IGA2_VER_BLANK_START_REG_NUM&nbsp;&nbsp;&nbsp; =
2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
location: {CR5A,0,7},{CR5C,0,2} */<BR>+#define =
IGA2_VER_BLANK_END_REG_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
location: {CR5E,0,7},{CR5C,3,5} */<BR>+#define =
IGA2_VER_SYNC_START_REG_NUM&nbsp;&nbsp;&nbsp;&nbsp; =
2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
location: {CR5E,0,7},{CR5F,5,7} */<BR>+#define =
IGA2_VER_SYNC_END_REG_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
location: {CR5F,0,4} */<BR>+<BR>+/* Define Offset and Fetch Count =
Register*/<BR>+#define =
IGA1_OFFSET_REG_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; =
2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* location: =
{CR13,0,7},{CR35,5,7} */<BR>+#define =
IGA1_OFFSER_ALIGN_BYTE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; =
8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 8 bytes alignment. =
*/<BR>+#define =
IGA1_OFFSET_FORMULA(x,y)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
(x*y)/IGA1_OFFSER_ALIGN_BYTE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* x: H =
resolution, y: color depth */<BR>+<BR>+#define =
IGA1_FETCH_COUNT_REG_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* location: =
{SR1C,0,7},{SR1D,0,1} */<BR>+#define =
IGA1_FETCH_COUNT_ALIGN_BYTE&nbsp;&nbsp;&nbsp;&nbsp; =
16&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 16 bytes alignment. =
*/<BR>+#define IGA1_FETCH_COUNT_PATCH_VALUE&nbsp;&nbsp;&nbsp; =
4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* x: H resolution, y: =
color depth */<BR>+#define IGA1_FETCH_COUNT_FORMULA(x,y)&nbsp;&nbsp; =
((x*y)/IGA1_FETCH_COUNT_ALIGN_BYTE)+ =
IGA1_FETCH_COUNT_PATCH_VALUE<BR>+<BR>+#define =
IGA2_OFFSET_REG_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; =
2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
location: {CR66,0,7},{CR67,0,1} */<BR>+#define =
IGA2_OFFSET_ALIGN_BYTE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 8<BR>+#define =
IGA2_OFFSET_FORMULA(x,y)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
(x*y)/IGA2_OFFSET_ALIGN_BYTE&nbsp;&nbsp;&nbsp;&nbsp; /* x: H resolution, =
y: color depth */<BR>+<BR>+#define =
IGA2_FETCH_COUNT_REG_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
location: {CR65,0,7},{CR67,2,3} */<BR>+#define =
IGA2_FETCH_COUNT_ALIGN_BYTE&nbsp;&nbsp;&nbsp;&nbsp; 16<BR>+#define =
IGA2_FETCH_COUNT_PATCH_VALUE&nbsp;&nbsp;&nbsp; 0<BR>+#define =
IGA2_FETCH_COUNT_FORMULA(x,y)&nbsp;&nbsp; =
((x*y)/IGA2_FETCH_COUNT_ALIGN_BYTE)+ =
IGA2_FETCH_COUNT_PATCH_VALUE<BR>+<BR>+/* Staring Address */<BR>+#define =
IGA1_STARTING_ADDR_REG_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
location: {CR0C,0,7},{CR0D,0,7},{CR34,0,7},{CR48,0,1} */<BR>+#define =
IGA2_STARTING_ADDR_REG_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
location: {CR62,1,7},{CR63,0,7},{CR64,0,7} */<BR>+<BR>+/* Define Display =
OFFSET */<BR>+/* These value are by HW suggested value */<BR>+#define =
K800_IGA1_FIFO_MAX_DEPTH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 384&nbsp;&nbsp;&nbsp;&nbsp; /* =
location: {SR17,0,7} */<BR>+#define =
K800_IGA1_FIFO_THRESHOLD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 328&nbsp;&nbsp;&nbsp;&nbsp; /* =
location: {SR16,0,5},{SR16,7,7} */<BR>+#define =
K800_IGA1_FIFO_HIGH_THRESHOLD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; 296&nbsp;&nbsp;&nbsp;&nbsp; /* location: =
{SR18,0,5},{SR18,7,7} */<BR>+#define =
K800_IGA1_DISPLAY_QUEUE_EXPIRE_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* location: {SR22,0,4}. (128/4) =
=3D64, K800 must be set zero, =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* because HW only 5 bits =
*/<BR>+<BR>+#define =
K800_IGA2_FIFO_MAX_DEPTH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 384&nbsp;&nbsp;&nbsp;&nbsp; /* =
location: {CR68,4,7},{CR94,7,7},{CR95,7,7} */<BR>+#define =
K800_IGA2_FIFO_THRESHOLD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 328&nbsp;&nbsp;&nbsp;&nbsp; /* =
location: {CR68,0,3},{CR95,4,6} */<BR>+#define =
K800_IGA2_FIFO_HIGH_THRESHOLD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; 296&nbsp;&nbsp;&nbsp;&nbsp; /* location: =
{CR92,0,3},{CR95,0,2} */<BR>+#define =
K800_IGA2_DISPLAY_QUEUE_EXPIRE_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
128&nbsp;&nbsp;&nbsp;&nbsp; /* location: {CR94,0,6} */<BR>+<BR>+#define =
P880_IGA1_FIFO_MAX_DEPTH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 192&nbsp;&nbsp;&nbsp;&nbsp; /* =
location: {SR17,0,7} */<BR>+#define =
P880_IGA1_FIFO_THRESHOLD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 128&nbsp;&nbsp;&nbsp;&nbsp; /* =
location: {SR16,0,5},{SR16,7,7} */<BR>+#define =
P880_IGA1_FIFO_HIGH_THRESHOLD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; 64&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* location: =
{SR18,0,5},{SR18,7,7} */<BR>+#define =
P880_IGA1_DISPLAY_QUEUE_EXPIRE_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* location: {SR22,0,4}. (128/4) =
=3D64, K800 must be set zero, =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* because HW only 5 bits =
*/<BR>+<BR>+#define =
P880_IGA2_FIFO_MAX_DEPTH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
96&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* location: =
{CR68,4,7},{CR94,7,7},{CR95,7,7} */<BR>+#define =
P880_IGA2_FIFO_THRESHOLD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
64&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* location: {CR68,0,3},{CR95,4,6} =
*/<BR>+#define =
P880_IGA2_FIFO_HIGH_THRESHOLD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; 32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* location: =
{CR92,0,3},{CR95,0,2} */<BR>+#define =
P880_IGA2_DISPLAY_QUEUE_EXPIRE_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
128&nbsp;&nbsp;&nbsp;&nbsp; /* location: {CR94,0,6} */<BR>+<BR>+/* =
VT3314 chipset*/<BR>+#define =
CN900_IGA1_FIFO_MAX_DEPTH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96 /* location: =
{SR17,0,7}*/<BR>+#define =
CN900_IGA1_FIFO_THRESHOLD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 80 /* location: =
{SR16,0,5},{SR16,7,7}*/<BR>+#define =
CN900_IGA1_FIFO_HIGH_THRESHOLD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; 64&nbsp; /* location: {SR18,0,5},{SR18,7,7}*/<BR>+#define =
CN900_IGA1_DISPLAY_QUEUE_EXPIRE_NUM&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp; /* location: {SR22,0,4}. (128/4) =3D64, P800 must be set =
zero, because HW only 5 bits*/<BR>+<BR>+#define =
CN900_IGA2_FIFO_MAX_DEPTH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96&nbsp; /* location: =
{CR68,4,7},{CR94,7,7},{CR95,7,7}*/<BR>+#define =
CN900_IGA2_FIFO_THRESHOLD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 80&nbsp; /* location: =
{CR68,0,3},{CR95,4,6}*/<BR>+#define =
CN900_IGA2_FIFO_HIGH_THRESHOLD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; 32&nbsp; /* location: {CR92,0,3},{CR95,0,2}*/<BR>+#define =
CN900_IGA2_DISPLAY_QUEUE_EXPIRE_NUM&nbsp;&nbsp;&nbsp;&nbsp; 128 /* =
location: {CR94,0,6}*/<BR>+<BR>+/* For VT3324, these values are =
suggested by HW */<BR>+#define =
CX700_IGA1_FIFO_MAX_DEPTH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 192&nbsp;&nbsp;&nbsp;&nbsp; /* =
location: {SR17,0,7}*/<BR>+#define =
CX700_IGA1_FIFO_THRESHOLD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 128&nbsp;&nbsp;&nbsp;&nbsp; /* =
location: {SR16,0,5},{SR16,7,7}*/<BR>+#define =
CX700_IGA1_FIFO_HIGH_THRESHOLD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; 128&nbsp;&nbsp;&nbsp;&nbsp; /* location: =
{SR18,0,5},{SR18,7,7} */<BR>+#define =
CX700_IGA1_DISPLAY_QUEUE_EXPIRE_NUM&nbsp;&nbsp;&nbsp;&nbsp; =
124&nbsp;&nbsp;&nbsp;&nbsp; /* location: {SR22,0,4} */<BR>+<BR>+#define =
CX700_IGA2_FIFO_MAX_DEPTH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
location: {CR68,4,7},{CR94,7,7},{CR95,7,7}*/<BR>+#define =
CX700_IGA2_FIFO_THRESHOLD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 64&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
location: {CR68,0,3},{CR95,4,6}*/<BR>+#define =
CX700_IGA2_FIFO_HIGH_THRESHOLD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; 32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* location: =
{CR92,0,3},{CR95,0,2} */<BR>+#define =
CX700_IGA2_DISPLAY_QUEUE_EXPIRE_NUM&nbsp;&nbsp;&nbsp;&nbsp; =
128&nbsp;&nbsp;&nbsp;&nbsp; /* location: {CR94,0,6}*/<BR>+<BR>+/* VT3336 =
chipset*/<BR>+#define =
K8M890_IGA1_FIFO_MAX_DEPTH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 360 /* location: =
{SR17,0,7}*/<BR>+#define =
K8M890_IGA1_FIFO_THRESHOLD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 328 /* location: =
{SR16,0,5},{SR16,7,7}*/<BR>+#define =
K8M890_IGA1_FIFO_HIGH_THRESHOLD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; 296 /* location: {SR18,0,5},{SR18,7,7}*/<BR>+#define =
K8M890_IGA1_DISPLAY_QUEUE_EXPIRE_NUM&nbsp;&nbsp;&nbsp;&nbsp; 124 /* =
location: {SR22,0,4}.*/<BR>+<BR>+#define =
K8M890_IGA2_FIFO_MAX_DEPTH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 360 /* location: =
{CR68,4,7},{CR94,7,7},{CR95,7,7}*/<BR>+#define =
K8M890_IGA2_FIFO_THRESHOLD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 328 /* location: =
{CR68,0,3},{CR95,4,6}*/<BR>+#define =
K8M890_IGA2_FIFO_HIGH_THRESHOLD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; 296 /* location: {CR92,0,3},{CR95,0,2}*/<BR>+#define =
K8M890_IGA2_DISPLAY_QUEUE_EXPIRE_NUM&nbsp;&nbsp;&nbsp;&nbsp; 124 /* =
location: {CR94,0,6}*/<BR>+<BR>+/* VT3327 chipset*/<BR>+#define =
P4M890_IGA1_FIFO_MAX_DEPTH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96&nbsp; /* location: =
{SR17,0,7}*/<BR>+#define =
P4M890_IGA1_FIFO_THRESHOLD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 76&nbsp; /* location: =
{SR16,0,5},{SR16,7,7}*/<BR>+#define =
P4M890_IGA1_FIFO_HIGH_THRESHOLD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; 64&nbsp; /* location: {SR18,0,5},{SR18,7,7}*/<BR>+#define =
P4M890_IGA1_DISPLAY_QUEUE_EXPIRE_NUM&nbsp;&nbsp;&nbsp;&nbsp; 32&nbsp; /* =
location: {SR22,0,4}. (32/4) =3D8*/<BR>+<BR>+#define =
P4M890_IGA2_FIFO_MAX_DEPTH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96&nbsp; /* location: =
{CR68,4,7},{CR94,7,7},{CR95,7,7}*/<BR>+#define =
P4M890_IGA2_FIFO_THRESHOLD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 76&nbsp; /* location: =
{CR68,0,3},{CR95,4,6}*/<BR>+#define =
P4M890_IGA2_FIFO_HIGH_THRESHOLD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; 64&nbsp; /* location: {CR92,0,3},{CR95,0,2}*/<BR>+#define =
P4M890_IGA2_DISPLAY_QUEUE_EXPIRE_NUM&nbsp;&nbsp;&nbsp;&nbsp; 32&nbsp; /* =
location: {CR94,0,6}*/<BR>+<BR>+/* VT3364 chipset*/<BR>+#define =
P4M900_IGA1_FIFO_MAX_DEPTH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96&nbsp;&nbsp;&nbsp;&nbsp; /* =
location: {SR17,0,7}*/<BR>+#define =
P4M900_IGA1_FIFO_THRESHOLD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 76&nbsp;&nbsp;&nbsp;&nbsp; /* =
location: {SR16,0,5},{SR16,7,7}*/<BR>+#define =
P4M900_IGA1_FIFO_HIGH_THRESHOLD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; 76&nbsp;&nbsp;&nbsp;&nbsp; /* location: =
{SR18,0,5},{SR18,7,7}*/<BR>+#define =
P4M900_IGA1_DISPLAY_QUEUE_EXPIRE_NUM&nbsp;&nbsp;&nbsp;&nbsp; =
32&nbsp;&nbsp;&nbsp;&nbsp; /* location: {SR22,0,4}.*/<BR>+<BR>+#define =
P4M900_IGA2_FIFO_MAX_DEPTH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96&nbsp;&nbsp;&nbsp;&nbsp; /* =
location: {CR68,4,7},{CR94,7,7},{CR95,7,7}*/<BR>+#define =
P4M900_IGA2_FIFO_THRESHOLD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 76&nbsp;&nbsp;&nbsp;&nbsp; /* =
location: {CR68,0,3},{CR95,4,6}*/<BR>+#define =
P4M900_IGA2_FIFO_HIGH_THRESHOLD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; 76&nbsp;&nbsp;&nbsp;&nbsp; /* location: =
{CR92,0,3},{CR95,0,2}*/<BR>+#define =
P4M900_IGA2_DISPLAY_QUEUE_EXPIRE_NUM&nbsp;&nbsp;&nbsp;&nbsp; =
32&nbsp;&nbsp;&nbsp;&nbsp; /* location: {CR94,0,6}*/<BR>+<BR>+#define =
IGA1_FIFO_DEPTH_SELECT_REG_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; 1<BR>+#define =
IGA1_FIFO_THRESHOLD_REG_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; 2<BR>+#define =
IGA1_FIFO_HIGH_THRESHOLD_REG_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 2<BR>+#define IGA1_DISPLAY_QUEUE_EXPIRE_NUM_REG_NUM&nbsp;&nbsp; =
1<BR>+<BR>+#define =
IGA2_FIFO_DEPTH_SELECT_REG_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; 3<BR>+#define =
IGA2_FIFO_THRESHOLD_REG_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; 2<BR>+#define =
IGA2_FIFO_HIGH_THRESHOLD_REG_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 2<BR>+#define IGA2_DISPLAY_QUEUE_EXPIRE_NUM_REG_NUM&nbsp;&nbsp; =
1<BR>+<BR>+<BR>+#define =
IGA1_FIFO_DEPTH_SELECT_FORMULA(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
(x/2)-1<BR>+#define =
IGA1_FIFO_THRESHOLD_FORMULA(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (x/4)<BR>+#define =
IGA1_DISPLAY_QUEUE_EXPIRE_NUM_FORMULA(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (x/4)<BR>+#define =
IGA1_FIFO_HIGH_THRESHOLD_FORMULA(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
(x/4)<BR>+#define =
IGA2_FIFO_DEPTH_SELECT_FORMULA(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
((x/2)/4)-1<BR>+#define =
IGA2_FIFO_THRESHOLD_FORMULA(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (x/4)<BR>+#define =
IGA2_DISPLAY_QUEUE_EXPIRE_NUM_FORMULA(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (x/4)<BR>+#define =
IGA2_FIFO_HIGH_THRESHOLD_FORMULA(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
(x/4)<BR>+<BR>+/*********************************************************=
***************/<BR>+/*&nbsp; LCD =
Timing&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+/*****************************************************************=
*******/<BR>+#define =
LCD_POWER_SEQ_TD0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =
500000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 500 ms =3D =
500000 us */<BR>+#define =
LCD_POWER_SEQ_TD1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =
50000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 50 ms =3D =
50000 us */<BR>+#define =
LCD_POWER_SEQ_TD2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* 0 us */<BR>+#define =
LCD_POWER_SEQ_TD3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =
210000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 210 ms =3D =
210000 us */<BR>+<BR>+#define =
CLE266_POWER_SEQ_UNIT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; =
71&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; /* 2^10 * (1/14.31818M) =3D 71.475 us (K400.revA) */<BR>+#define =
K800_POWER_SEQ_UNIT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; =
142&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
2^11 * (1/14.31818M) =3D 142.95 us (K400.revB) */<BR>+#define =
P880_POWER_SEQ_UNIT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; =
572&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
2^13 * (1/14.31818M) =3D 572.1 us */<BR>+<BR>+#define =
CLE266_POWER_SEQ_FORMULA(x)&nbsp;&nbsp;&nbsp;&nbsp; =
(x)/CLE266_POWER_SEQ_UNIT<BR>+#define =
K800_POWER_SEQ_FORMULA(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
(x)/K800_POWER_SEQ_UNIT<BR>+#define =
P880_POWER_SEQ_FORMULA(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
(x)/P880_POWER_SEQ_UNIT<BR>+<BR>+<BR>+#define =
LCD_POWER_SEQ_TD0_REG_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
2&nbsp;&nbsp; /* location: {CR8B,0,7},{CR8F,0,3} */<BR>+#define =
LCD_POWER_SEQ_TD1_REG_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
2&nbsp;&nbsp; /* location: {CR8C,0,7},{CR8F,4,7} */<BR>+#define =
LCD_POWER_SEQ_TD2_REG_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
2&nbsp;&nbsp; /* location: {CR8D,0,7},{CR90,0,3} */<BR>+#define =
LCD_POWER_SEQ_TD3_REG_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
2&nbsp;&nbsp; /* location: {CR8E,0,7},{CR90,4,7} */<BR>+<BR>+<BR>+/* LCD =
Scaling factor */<BR>+/* x: indicate setting horizontal size */<BR>+/* =
y: indicate panel horizontal size */<BR>+<BR>+#define =
CLE266_LCD_HOR_SCF_FORMULA(x,y)&nbsp;&nbsp; =
(((x-1)*1024)/(y-1))&nbsp;&nbsp;&nbsp; /* Horizontal scaling factor 10 =
bits (2^10) */<BR>+#define CLE266_LCD_VER_SCF_FORMULA(x,y)&nbsp;&nbsp; =
(((x-1)*1024)/(y-1))&nbsp;&nbsp;&nbsp; /* Vertical scaling factor 10 =
bits (2^10) */<BR>+#define =
K800_LCD_HOR_SCF_FORMULA(x,y)&nbsp;&nbsp;&nbsp;&nbsp; =
(((x-1)*4096)/(y-1))&nbsp;&nbsp;&nbsp; /* Horizontal scaling factor 10 =
bits (2^12) */<BR>+#define =
K800_LCD_VER_SCF_FORMULA(x,y)&nbsp;&nbsp;&nbsp;&nbsp; =
(((x-1)*2048)/(y-1))&nbsp;&nbsp;&nbsp; /* Vertical scaling factor 10 =
bits (2^11) */<BR>+<BR>+#define LCD_HOR_SCALING_FACTOR_REG_NUM&nbsp; =
3&nbsp;&nbsp; /* location: {CR9F,0,1},{CR77,0,7},{CR79,4,5} =
*/<BR>+#define LCD_VER_SCALING_FACTOR_REG_NUM&nbsp; 3&nbsp;&nbsp; /* =
location: {CR79,3,3},{CR78,0,7},{CR79,6,7} */<BR>+#define =
LCD_HOR_SCALING_FACTOR_REG_NUM_CLE&nbsp; =
2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; /* location: {CR77,0,7},{CR79,4,5} */<BR>+#define =
LCD_VER_SCALING_FACTOR_REG_NUM_CLE&nbsp; =
2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; /* location: {CR78,0,7},{CR79,6,7} =
*/<BR>+<BR>+<BR>+<BR>+/************************************************/<=
BR>+/*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Define IGA1 Display =
Timing&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; =
*/<BR>+/************************************************/<BR>+struct =
io_register {<BR>+&nbsp;&nbsp;&nbsp; u8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
io_addr;<BR>+&nbsp;&nbsp;&nbsp; u8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
start_bit;<BR>+&nbsp;&nbsp;&nbsp; u8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
end_bit;<BR>+};<BR>+<BR>+<BR>+/* IGA1 Horizontal Total */<BR>+struct =
iga1_hor_total<BR>+{<BR>+&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp; =
reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; io_register =
reg[IGA1_HOR_TOTAL_REG_NUM];<BR>+};<BR>+<BR>+/* IGA1 Horizontal =
Addressable Video */<BR>+struct iga1_hor_addr {<BR>+&nbsp;&nbsp;&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp; reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; =
io_register reg[IGA1_HOR_ADDR_REG_NUM];<BR>+};<BR>+<BR>+/* IGA1 =
Horizontal Blank Start */<BR>+struct iga1_hor_blank_start =
{<BR>+&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp; =
reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; io_register =
reg[IGA1_HOR_BLANK_START_REG_NUM];<BR>+};<BR>+<BR>+/* IGA1 Horizontal =
Blank End */<BR>+struct iga1_hor_blank_end {<BR>+&nbsp;&nbsp;&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp; reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; =
io_register reg[IGA1_HOR_BLANK_END_REG_NUM];<BR>+};<BR>+<BR>+/* IGA1 =
Horizontal Sync Start */<BR>+struct iga1_hor_sync_start =
{<BR>+&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp; =
reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; io_register =
reg[IGA1_HOR_SYNC_START_REG_NUM];<BR>+};<BR>+<BR>+/* IGA1 Horizontal =
Sync End */<BR>+struct iga1_hor_sync_end {<BR>+&nbsp;&nbsp;&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp; reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; =
io_register reg[IGA1_HOR_SYNC_END_REG_NUM];<BR>+};<BR>+<BR>+/* IGA1 =
Vertical Total */<BR>+struct iga1_ver_total {<BR>+&nbsp;&nbsp;&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp; reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; =
io_register reg[IGA1_VER_TOTAL_REG_NUM];<BR>+};<BR>+<BR>+/* IGA1 =
Vertical Addressable Video */<BR>+struct iga1_ver_addr =
{<BR>+&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp; =
reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; io_register =
reg[IGA1_VER_ADDR_REG_NUM];<BR>+};<BR>+<BR>+/* IGA1 Vertical Blank Start =
*/<BR>+struct iga1_ver_blank_start {<BR>+&nbsp;&nbsp;&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp; reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; =
io_register reg[IGA1_VER_BLANK_START_REG_NUM];<BR>+};<BR>+<BR>+/* IGA1 =
Vertical Blank End */<BR>+struct iga1_ver_blank_end =
{<BR>+&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp; =
reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; io_register =
reg[IGA1_VER_BLANK_END_REG_NUM];<BR>+};<BR>+<BR>+/* IGA1 Vertical Sync =
Start */<BR>+struct iga1_ver_sync_start {<BR>+&nbsp;&nbsp;&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp; reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; =
io_register reg[IGA1_VER_SYNC_START_REG_NUM];<BR>+};<BR>+<BR>+/* IGA1 =
Vertical Sync End */<BR>+struct iga1_ver_sync_end =
{<BR>+&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp; =
reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; io_register =
reg[IGA1_VER_SYNC_END_REG_NUM];<BR>+};<BR>+<BR>+/************************=
************************/<BR>+/*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Define =
IGA2 Shadow Display Timing&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+/************************************************/<BR>+<BR>+/* =
IGA2 Shadow Horizontal Total */<BR>+struct =
iga2_shadow_hor_total<BR>+{<BR>+&nbsp;&nbsp;&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp; reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; =
io_register reg[IGA2_SHADOW_HOR_TOTAL_REG_NUM];<BR>+};<BR>+<BR>+/* IGA2 =
Shadow Horizontal Blank End */<BR>+struct iga2_shadow_hor_blank_end =
{<BR>+&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp; =
reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; io_register =
reg[IGA2_SHADOW_HOR_BLANK_END_REG_NUM];<BR>+};<BR>+<BR>+<BR>+/* IGA2 =
Shadow Vertical Total */<BR>+struct iga2_shadow_ver_total =
{<BR>+&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp; =
reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; io_register =
reg[IGA2_SHADOW_VER_TOTAL_REG_NUM];<BR>+};<BR>+<BR>+/* IGA2 Shadow =
Vertical Addressable Video */<BR>+struct iga2_shadow_ver_addr =
{<BR>+&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp; =
reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; io_register =
reg[IGA2_SHADOW_VER_ADDR_REG_NUM];<BR>+};<BR>+<BR>+/* IGA2 Shadow =
Vertical Blank Start */<BR>+struct iga2_shadow_ver_blank_start =
{<BR>+&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp; =
reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; io_register =
reg[IGA2_SHADOW_VER_BLANK_START_REG_NUM];<BR>+};<BR>+<BR>+/* IGA2 Shadow =
Vertical Blank End */<BR>+struct iga2_shadow_ver_blank_end =
{<BR>+&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp; =
reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; io_register =
reg[IGA2_SHADOW_VER_BLANK_END_REG_NUM];<BR>+};<BR>+<BR>+/* IGA2 Shadow =
Vertical Sync Start */<BR>+struct iga2_shadow_ver_sync_start =
{<BR>+&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp; =
reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; io_register =
reg[IGA2_SHADOW_VER_SYNC_START_REG_NUM];<BR>+};<BR>+<BR>+/* IGA2 Shadow =
Vertical Sync End */<BR>+struct iga2_shadow_ver_sync_end =
{<BR>+&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp; =
reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; io_register =
reg[IGA2_SHADOW_VER_SYNC_END_REG_NUM];<BR>+};<BR>+<BR>+/*****************=
*******************************/<BR>+/*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Define IGA2 Display =
Timing&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; =
*/<BR>+/************************************************/<BR>+<BR>+/* =
IGA2 Horizontal Total */<BR>+struct iga2_hor_total =
{<BR>+&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp; =
reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; io_register =
reg[IGA2_HOR_TOTAL_REG_NUM];<BR>+};<BR>+<BR>+/* IGA2 Horizontal =
Addressable Video */<BR>+struct iga2_hor_addr {<BR>+&nbsp;&nbsp;&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp; reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; =
io_register reg[IGA2_HOR_ADDR_REG_NUM];<BR>+};<BR>+<BR>+/* IGA2 =
Horizontal Blank Start */<BR>+struct iga2_hor_blank_start =
{<BR>+&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp; =
reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; io_register =
reg[IGA2_HOR_BLANK_START_REG_NUM];<BR>+};<BR>+<BR>+/* IGA2 Horizontal =
Blank End */<BR>+struct iga2_hor_blank_end {<BR>+&nbsp;&nbsp;&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp; reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; =
io_register reg[IGA2_HOR_BLANK_END_REG_NUM];<BR>+};<BR>+<BR>+/* IGA2 =
Horizontal Sync Start */<BR>+struct iga2_hor_sync_start =
{<BR>+&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp; =
reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; io_register =
reg[IGA2_HOR_SYNC_START_REG_NUM];<BR>+};<BR>+<BR>+/* IGA2 Horizontal =
Sync End */<BR>+struct iga2_hor_sync_end {<BR>+&nbsp;&nbsp;&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp; reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; =
io_register reg[IGA2_HOR_SYNC_END_REG_NUM];<BR>+};<BR>+<BR>+/* IGA2 =
Vertical Total */<BR>+struct iga2_ver_total {<BR>+&nbsp;&nbsp;&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp; reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; =
io_register reg[IGA2_VER_TOTAL_REG_NUM];<BR>+};<BR>+<BR>+/* IGA2 =
Vertical Addressable Video */<BR>+struct iga2_ver_addr =
{<BR>+&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp; =
reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; io_register =
reg[IGA2_VER_ADDR_REG_NUM];<BR>+};<BR>+<BR>+/* IGA2 Vertical Blank Start =
*/<BR>+struct iga2_ver_blank_start {<BR>+&nbsp;&nbsp;&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp; reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; =
io_register reg[IGA2_VER_BLANK_START_REG_NUM];<BR>+};<BR>+<BR>+/* IGA2 =
Vertical Blank End */<BR>+struct iga2_ver_blank_end =
{<BR>+&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp; =
reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; io_register =
reg[IGA2_VER_BLANK_END_REG_NUM];<BR>+};<BR>+<BR>+/* IGA2 Vertical Sync =
Start */<BR>+struct iga2_ver_sync_start {<BR>+&nbsp;&nbsp;&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp; reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; =
io_register reg[IGA2_VER_SYNC_START_REG_NUM];<BR>+};<BR>+<BR>+/* IGA2 =
Vertical Sync End */<BR>+struct iga2_ver_sync_end =
{<BR>+&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp; =
reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; io_register =
reg[IGA2_VER_SYNC_END_REG_NUM];<BR>+};<BR>+<BR>+/* IGA1 Offset Register =
*/<BR>+struct iga1_offset {<BR>+&nbsp;&nbsp;&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp; reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; =
io_register reg[IGA1_OFFSET_REG_NUM];<BR>+};<BR>+<BR>+/* IGA2 Offset =
Register */<BR>+struct iga2_offset {<BR>+&nbsp;&nbsp;&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp; reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; =
io_register reg[IGA2_OFFSET_REG_NUM];<BR>+};<BR>+<BR>+struct =
offset{<BR>+&nbsp;&nbsp;&nbsp; struct =
iga1_offset&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; iga1_offset_reg;<BR>+&nbsp;&nbsp;&nbsp; struct =
iga2_offset&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; iga2_offset_reg;<BR>+};<BR>+<BR>+/* IGA1 Fetch Count Register =
*/<BR>+struct iga1_fetch_count {<BR>+&nbsp;&nbsp;&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp; reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; =
io_register reg[IGA1_FETCH_COUNT_REG_NUM];<BR>+};<BR>+<BR>+/* IGA2 Fetch =
Count Register */<BR>+struct iga2_fetch_count {<BR>+&nbsp;&nbsp;&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp; reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; =
io_register reg[IGA2_FETCH_COUNT_REG_NUM];<BR>+};<BR>+<BR>+struct =
fetch_count{<BR>+&nbsp;&nbsp;&nbsp; struct =
iga1_fetch_count&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
iga1_fetch_count_reg;<BR>+&nbsp;&nbsp;&nbsp; struct =
iga2_fetch_count&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
iga2_fetch_count_reg;<BR>+};<BR>+<BR>+/* Starting Address Register =
*/<BR>+struct iga1_starting_addr {<BR>+&nbsp;&nbsp;&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp; reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; =
io_register reg[IGA1_STARTING_ADDR_REG_NUM];<BR>+};<BR>+<BR>+struct =
iga2_starting_addr {<BR>+&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp; =
reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; io_register =
reg[IGA2_STARTING_ADDR_REG_NUM];<BR>+};<BR>+<BR>+struct starting_addr =
{<BR>+&nbsp;&nbsp;&nbsp; struct =
iga1_starting_addr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
iga1_starting_addr_reg;<BR>+&nbsp;&nbsp;&nbsp; struct =
iga2_starting_addr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
iga2_starting_addr_reg;<BR>+};<BR>+<BR>+/* LCD Power Sequence Timer =
*/<BR>+struct lcd_pwd_seq_td0{<BR>+&nbsp;&nbsp;&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp; reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; =
io_register reg[LCD_POWER_SEQ_TD0_REG_NUM];<BR>+};<BR>+<BR>+struct =
lcd_pwd_seq_td1{<BR>+&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp; =
reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; io_register =
reg[LCD_POWER_SEQ_TD1_REG_NUM];<BR>+};<BR>+<BR>+struct =
lcd_pwd_seq_td2{<BR>+&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp; =
reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; io_register =
reg[LCD_POWER_SEQ_TD2_REG_NUM];<BR>+};<BR>+<BR>+struct =
lcd_pwd_seq_td3{<BR>+&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp; =
reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; io_register =
reg[LCD_POWER_SEQ_TD3_REG_NUM];<BR>+};<BR>+<BR>+struct =
_lcd_pwd_seq_timer{<BR>+&nbsp;&nbsp;&nbsp; struct =
lcd_pwd_seq_td0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
td0;<BR>+&nbsp;&nbsp;&nbsp; struct =
lcd_pwd_seq_td1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
td1;<BR>+&nbsp;&nbsp;&nbsp; struct =
lcd_pwd_seq_td2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
td2;<BR>+&nbsp;&nbsp;&nbsp; struct =
lcd_pwd_seq_td3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
td3;<BR>+};<BR>+<BR>+/* LCD Scaling Factor */<BR>+struct =
_lcd_hor_scaling_factor{<BR>+&nbsp;&nbsp;&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp; reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; =
io_register reg[LCD_HOR_SCALING_FACTOR_REG_NUM];<BR>+};<BR>+<BR>+struct =
_lcd_ver_scaling_factor{<BR>+&nbsp;&nbsp;&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp; reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; =
io_register =
reg[LCD_VER_SCALING_FACTOR_REG_NUM];<BR>+};<BR>+<BR>+<BR>+struct =
_lcd_scaling_factor{<BR>+&nbsp;&nbsp;&nbsp; struct =
_lcd_hor_scaling_factor&nbsp; =
lcd_hor_scaling_factor;<BR>+&nbsp;&nbsp;&nbsp; struct =
_lcd_ver_scaling_factor&nbsp; =
lcd_ver_scaling_factor;<BR>+};<BR>+<BR>+struct pll_map =
{<BR>+&nbsp;&nbsp;&nbsp; u32&nbsp;&nbsp;&nbsp;&nbsp; =
clk;<BR>+&nbsp;&nbsp;&nbsp; u32&nbsp;&nbsp;&nbsp;&nbsp; =
cle266_pll;<BR>+&nbsp;&nbsp;&nbsp; u32&nbsp;&nbsp;&nbsp;&nbsp; =
k800_pll;<BR>+&nbsp;&nbsp;&nbsp; u32&nbsp;&nbsp;&nbsp;&nbsp; =
cx700_pll;<BR>+};<BR>+<BR>+struct rgbLUT {<BR>+&nbsp;&nbsp;&nbsp; =
u8&nbsp;&nbsp;&nbsp;&nbsp; red;<BR>+&nbsp;&nbsp;&nbsp; =
u8&nbsp;&nbsp;&nbsp;&nbsp; green;<BR>+&nbsp;&nbsp;&nbsp; =
u8&nbsp;&nbsp;&nbsp;&nbsp; blue;<BR>+};<BR>+<BR>+struct =
lcd_pwd_seq_timer {<BR>+&nbsp;&nbsp;&nbsp; u16&nbsp;&nbsp;&nbsp;&nbsp; =
td0;<BR>+&nbsp;&nbsp;&nbsp; u16&nbsp;&nbsp;&nbsp;&nbsp; =
td1;<BR>+&nbsp;&nbsp;&nbsp; u16&nbsp;&nbsp;&nbsp;&nbsp; =
td2;<BR>+&nbsp;&nbsp;&nbsp; u16&nbsp;&nbsp;&nbsp;&nbsp; =
td3;<BR>+};<BR>+<BR>+<BR>+/* Display FIFO Relation Registers =
*/<BR>+struct iga1_fifo_depth_select {<BR>+&nbsp;&nbsp;&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp; reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; =
io_register reg[IGA1_FIFO_DEPTH_SELECT_REG_NUM];<BR>+};<BR>+<BR>+struct =
iga1_fifo_threshold_select {<BR>+&nbsp;&nbsp;&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp; reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; =
io_register reg[IGA1_FIFO_THRESHOLD_REG_NUM];<BR>+};<BR>+<BR>+struct =
iga1_fifo_high_threshold_select {<BR>+&nbsp;&nbsp;&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp; reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; =
io_register =
reg[IGA1_FIFO_HIGH_THRESHOLD_REG_NUM];<BR>+};<BR>+<BR>+struct =
iga1_display_queue_expire_num {<BR>+&nbsp;&nbsp;&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp; reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; =
io_register =
reg[IGA1_DISPLAY_QUEUE_EXPIRE_NUM_REG_NUM];<BR>+};<BR>+<BR>+struct =
iga2_fifo_depth_select {<BR>+&nbsp;&nbsp;&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp; reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; =
io_register reg[IGA2_FIFO_DEPTH_SELECT_REG_NUM];<BR>+};<BR>+<BR>+struct =
iga2_fifo_threshold_select {<BR>+&nbsp;&nbsp;&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp; reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; =
io_register reg[IGA2_FIFO_THRESHOLD_REG_NUM];<BR>+};<BR>+<BR>+struct =
iga2_fifo_high_threshold_select {<BR>+&nbsp;&nbsp;&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp; reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; =
io_register =
reg[IGA2_FIFO_HIGH_THRESHOLD_REG_NUM];<BR>+};<BR>+<BR>+struct =
iga2_display_queue_expire_num {<BR>+&nbsp;&nbsp;&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp; reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; =
io_register =
reg[IGA2_DISPLAY_QUEUE_EXPIRE_NUM_REG_NUM];<BR>+};<BR>+<BR>+struct =
fifo_depth_select {<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; =
iga1_fifo_depth_select =
iga1_fifo_depth_select_reg;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; =
iga2_fifo_depth_select =
iga2_fifo_depth_select_reg;<BR>+};<BR>+<BR>+struct fifo_threshold_select =
{<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; iga1_fifo_threshold_select =
iga1_fifo_threshold_select_reg;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; =
iga2_fifo_threshold_select =
iga2_fifo_threshold_select_reg;<BR>+};<BR>+<BR>+struct =
fifo_high_threshold_select {<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; =
iga1_fifo_high_threshold_select =
iga1_fifo_high_threshold_select_reg;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; =
iga2_fifo_high_threshold_select =
iga2_fifo_high_threshold_select_reg;<BR>+};<BR>+<BR>+struct =
display_queue_expire_num {<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; =
iga1_display_queue_expire_num =
iga1_display_queue_expire_num_reg;<BR>+&nbsp;&nbsp;&nbsp; struct&nbsp; =
iga2_display_queue_expire_num =
iga2_display_queue_expire_num_reg;<BR>+};<BR>+<BR>+<BR>+<BR>+struct =
iga1_crtc_timing {<BR>+&nbsp;&nbsp;&nbsp; struct =
iga1_hor_total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
hor_total;<BR>+&nbsp;&nbsp;&nbsp; struct =
iga1_hor_addr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
hor_addr;<BR>+&nbsp;&nbsp;&nbsp; struct iga1_hor_blank_start&nbsp;&nbsp; =
hor_blank_start;<BR>+&nbsp;&nbsp;&nbsp; struct =
iga1_hor_blank_end&nbsp;&nbsp;&nbsp;&nbsp; =
hor_blank_end;<BR>+&nbsp;&nbsp;&nbsp; struct =
iga1_hor_sync_start&nbsp;&nbsp;&nbsp; =
hor_sync_start;<BR>+&nbsp;&nbsp;&nbsp; struct =
iga1_hor_sync_end&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
hor_sync_end;<BR>+&nbsp;&nbsp;&nbsp; struct =
iga1_ver_total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
ver_total;<BR>+&nbsp;&nbsp;&nbsp; struct =
iga1_ver_addr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
ver_addr;<BR>+&nbsp;&nbsp;&nbsp; struct iga1_ver_blank_start&nbsp;&nbsp; =
ver_blank_start;<BR>+&nbsp;&nbsp;&nbsp; struct =
iga1_ver_blank_end&nbsp;&nbsp;&nbsp;&nbsp; =
ver_blank_end;<BR>+&nbsp;&nbsp;&nbsp; struct =
iga1_ver_sync_start&nbsp;&nbsp;&nbsp; =
ver_sync_start;<BR>+&nbsp;&nbsp;&nbsp; struct =
iga1_ver_sync_end&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
ver_sync_end;<BR>+};<BR>+<BR>+struct iga2_shadow_crtc_timing =
{<BR>+&nbsp;&nbsp;&nbsp; struct =
iga2_shadow_hor_total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
hor_total_shadow;<BR>+&nbsp;&nbsp;&nbsp; struct =
iga2_shadow_hor_blank_end&nbsp;&nbsp;&nbsp; =
hor_blank_end_shadow;<BR>+&nbsp;&nbsp;&nbsp; struct =
iga2_shadow_ver_total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
ver_total_shadow;<BR>+&nbsp;&nbsp;&nbsp; struct =
iga2_shadow_ver_addr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
ver_addr_shadow;<BR>+&nbsp;&nbsp;&nbsp; struct =
iga2_shadow_ver_blank_start&nbsp; =
ver_blank_start_shadow;<BR>+&nbsp;&nbsp;&nbsp; struct =
iga2_shadow_ver_blank_end&nbsp;&nbsp;&nbsp; =
ver_blank_end_shadow;<BR>+&nbsp;&nbsp;&nbsp; struct =
iga2_shadow_ver_sync_start&nbsp;&nbsp; =
ver_sync_start_shadow;<BR>+&nbsp;&nbsp;&nbsp; struct =
iga2_shadow_ver_sync_end&nbsp;&nbsp;&nbsp;&nbsp; =
ver_sync_end_shadow;<BR>+};<BR>+<BR>+struct iga2_crtc_timing =
{<BR>+&nbsp;&nbsp;&nbsp; struct =
iga2_hor_total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
hor_total;<BR>+&nbsp;&nbsp;&nbsp; struct =
iga2_hor_addr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
hor_addr;<BR>+&nbsp;&nbsp;&nbsp; struct iga2_hor_blank_start&nbsp;&nbsp; =
hor_blank_start;<BR>+&nbsp;&nbsp;&nbsp; struct =
iga2_hor_blank_end&nbsp;&nbsp;&nbsp;&nbsp; =
hor_blank_end;<BR>+&nbsp;&nbsp;&nbsp; struct =
iga2_hor_sync_start&nbsp;&nbsp;&nbsp; =
hor_sync_start;<BR>+&nbsp;&nbsp;&nbsp; struct =
iga2_hor_sync_end&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
hor_sync_end;<BR>+&nbsp;&nbsp;&nbsp; struct =
iga2_ver_total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
ver_total;<BR>+&nbsp;&nbsp;&nbsp; struct =
iga2_ver_addr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
ver_addr;<BR>+&nbsp;&nbsp;&nbsp; struct iga2_ver_blank_start&nbsp;&nbsp; =
ver_blank_start;<BR>+&nbsp;&nbsp;&nbsp; struct =
iga2_ver_blank_end&nbsp;&nbsp;&nbsp;&nbsp; =
ver_blank_end;<BR>+&nbsp;&nbsp;&nbsp; struct =
iga2_ver_sync_start&nbsp;&nbsp;&nbsp; =
ver_sync_start;<BR>+&nbsp;&nbsp;&nbsp; struct =
iga2_ver_sync_end&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
ver_sync_end;<BR>+};<BR>+<BR>+/* Copied from X driver code */<BR>+/* =
used by get video memory size */<BR>+/* device ID */<BR>+#define =
CLE266&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; 0x3123<BR>+#define =
KM400&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; 0x3205<BR>+#define =
CN400_FUNCTION2&nbsp;&nbsp;&nbsp;&nbsp; 0x2259<BR>+#define =
CN400_FUNCTION3&nbsp;&nbsp;&nbsp;&nbsp; 0x3259<BR>+/* support VT3314 =
chipset */<BR>+#define CN900_FUNCTION2&nbsp;&nbsp;&nbsp;&nbsp; =
0x2314<BR>+#define CN900_FUNCTION3&nbsp;&nbsp;&nbsp;&nbsp; 0x3208<BR>+/* =
VT3324 chipset */<BR>+#define CX700_FUNCTION2&nbsp;&nbsp;&nbsp;&nbsp; =
0x2324<BR>+#define CX700_FUNCTION3&nbsp;&nbsp;&nbsp;&nbsp; 0x3324<BR>+/* =
VT3204 chipset*/<BR>+#define =
KM800_FUNCTION3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x3204<BR>+/* VT3336 =
chipset*/<BR>+#define KM890_FUNCTION3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x3336<BR>+/* VT3327 chipset*/<BR>+#define =
P4M890_FUNCTION3&nbsp;&nbsp;&nbsp;&nbsp; 0x3327<BR>+/* VT3293 =
chipset*/<BR>+#define CN750_FUNCTION3&nbsp;&nbsp;&nbsp;&nbsp; =
0x3208<BR>+/* VT3364 chipset*/<BR>+#define =
P4M900_FUNCTION3&nbsp;&nbsp;&nbsp; 0x3364<BR>+<BR>+typedef struct IODATA =
{<BR>+&nbsp;&nbsp;&nbsp; u8&nbsp;&nbsp; Index;<BR>+&nbsp;&nbsp;&nbsp; =
u8&nbsp;&nbsp; Mask;<BR>+&nbsp;&nbsp;&nbsp; u8&nbsp;&nbsp; =
Data;<BR>+}IODATA, *IODATAPTR;<BR>+<BR>+#endif /* __HW_H__ =
*/<BR>+<BR>+<BR>+<BR>+<BR>diff -Nur =
linux-2.6.21-rc7/drivers/video/via/iface.c =
linux-2.6.21-rc7.viafb/drivers/video/via/iface.c<BR>--- =
linux-2.6.21-rc7/drivers/video/via/iface.c&nbsp;1969-12-31 =
19:00:00.000000000 -0500<BR>+++ =
linux-2.6.21-rc7.viafb/drivers/video/via/iface.c&nbsp;2007-04-26 =
19:52:32.000000000 -0400<BR>@@ -0,0 +1,90 @@<BR>+ /*<BR>+ * Copyright =
1998-2007 VIA Technologies, Inc. All Rights Reserved.<BR>+ * Copyright =
2001-2007 S3 Graphics, Inc. All Rights Reserved.<BR>+ *<BR>+ * =
Permission is hereby granted, free of charge, to any person obtaining =
a<BR>+ * copy of this software and associated documentation files (the =
"Software"),<BR>+ * to deal in the Software without restriction, =
including without limitation<BR>+ * the rights to use, copy, modify, =
merge, publish, distribute, sub license,<BR>+ * and/or sell copies of =
the Software, and to permit persons to whom the<BR>+ * Software is =
furnished to do so, subject to the following conditions:<BR>+ *<BR>+ * =
The above copyright notice and this permission notice (including =
the<BR>+ * next paragraph) shall be included in all copies or =
substantial portions<BR>+ * of the Software.<BR>+ *<BR>+ * THE SOFTWARE =
IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR<BR>+ * =
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF =
MERCHANTABILITY,<BR>+ * FITNESS FOR A PARTICULAR PURPOSE AND =
NON-INFRINGEMENT. IN NO EVENT SHALL<BR>+ * THE AUTHOR(S) OR COPYRIGHT =
HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR<BR>+ * OTHER LIABILITY, =
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,<BR>+ * ARISING =
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER<BR>+ =
* DEALINGS IN THE SOFTWARE.<BR>+ */<BR>+ <BR>+<BR>+#include =
&lt;linux/ioport.h&gt;<BR>+#include &lt;linux/pci.h&gt;<BR>+#include =
&lt;asm/io.h&gt;<BR>+<BR>+#include "iface.h"<BR>+#include =
"debug.h"<BR>+#include "share.h"<BR>+<BR>+/* Get frame buffer size from =
VGA BIOS */<BR>+extern inline u8 read_reg(int io_port, u8 =
index);<BR>+extern&nbsp; int memsize;<BR>+<BR>+unsigned int =
get_memsize(void)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; unsigned int =
m;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If memory size =
provided by user */<BR>+&nbsp;&nbsp;&nbsp; if =
(memsize)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m =3D memsize * =
Mb;<BR>+&nbsp;&nbsp;&nbsp; else<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m =3D (unsigned int) =
read_reg(VIASR, SR39); <BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m =
=3D m*(4*Mb);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if((m &lt; (16*Mb)) || =
(m &gt; =
(64*Mb)))<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; m =3D 16*Mb;<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; =
DEBUG_MSG(KERN_INFO "framebuffer size =3D %d Mb\n", =
m/Mb);<BR>+&nbsp;&nbsp;&nbsp; return m;<BR>+}<BR>+<BR>+/* Get Video =
Buffer Starting Physical Address(back door) */<BR>+<BR>+unsigned long =
get_videobuf_addr(void)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; struct pci_dev =
*pdev=3DNULL;<BR>+&nbsp;&nbsp;&nbsp; unsigned char&nbsp; =
sys_mem;<BR>+&nbsp;&nbsp;&nbsp; unsigned char&nbsp; =
video_mem;<BR>+&nbsp;&nbsp;&nbsp; unsigned long&nbsp; =
sys_mem_size;<BR>+&nbsp;&nbsp;&nbsp; unsigned long&nbsp; =
video_mem_size;<BR>+&nbsp;&nbsp;&nbsp; unsigned long&nbsp; =
vmem_starting_adr =3D 0x0C000000; /* system memory =3D 256 MB, video =
memory 64 MB */<BR>+<BR>+&nbsp;&nbsp;&nbsp; pdev =3D (struct pci_dev =
*)pci_find_device(VIA_K800_BRIDGE_VID, VIA_K800_BRIDGE_DID, =
NULL);<BR>+&nbsp;&nbsp;&nbsp; if (pdev !=3D NULL)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
pci_read_config_byte(pdev, VIA_K800_SYSTEM_MEMORY_REG, =
&amp;sys_mem);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
pci_read_config_byte(pdev, VIA_K800_VIDEO_MEMORY_REG, =
&amp;video_mem);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
video_mem =3D (video_mem &amp; 0x70) &gt;&gt; =
4;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sys_mem_size =3D =
((unsigned long)sys_mem) &lt;&lt; =
24;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (video_mem !=3D =
0)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 video_mem_size =3D (1 &lt;&lt; (video_mem)) =
*1024*1024;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
else<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; video_mem_size =3D =
0;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vmem_starting_adr =
=3D sys_mem_size - video_mem_size;<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp; DEBUG_MSG(KERN_INFO "Video Memory Starting =
Address =3D %lx \n", vmem_starting_adr);<BR>+&nbsp;&nbsp;&nbsp; return =
vmem_starting_adr;<BR>+}<BR>+<BR>+<BR>+<BR>+<BR>diff -Nur =
linux-2.6.21-rc7/drivers/video/via/iface.h =
linux-2.6.21-rc7.viafb/drivers/video/via/iface.h<BR>--- =
linux-2.6.21-rc7/drivers/video/via/iface.h&nbsp;1969-12-31 =
19:00:00.000000000 -0500<BR>+++ =
linux-2.6.21-rc7.viafb/drivers/video/via/iface.h&nbsp;2007-04-26 =
19:52:32.000000000 -0400<BR>@@ -0,0 +1,15 @@<BR>+#ifndef =
__IFACE_H__<BR>+#define __IFACE_H__<BR>+<BR>+#define Kb&nbsp; =
(1024)<BR>+#define Mb&nbsp; (Kb*Kb)<BR>+<BR>+#define =
VIA_K800_BRIDGE_VID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x1106<BR>+#define =
VIA_K800_BRIDGE_DID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x3204<BR>+<BR>+#define VIA_K800_SYSTEM_MEMORY_REG&nbsp; =
0x47<BR>+#define VIA_K800_VIDEO_MEMORY_REG&nbsp;&nbsp; =
0xA1<BR>+<BR>+#endif /* __IFACE_H__ */<BR>+<BR>+<BR>diff -Nur =
linux-2.6.21-rc7/drivers/video/via/IntegratedTV.c =
linux-2.6.21-rc7.viafb/drivers/video/via/IntegratedTV.c<BR>--- =
linux-2.6.21-rc7/drivers/video/via/IntegratedTV.c&nbsp;1969-12-31 =
19:00:00.000000000 -0500<BR>+++ =
linux-2.6.21-rc7.viafb/drivers/video/via/IntegratedTV.c&nbsp;2007-04-26 =
19:52:32.000000000 -0400<BR>@@ -0,0 +1,1448 @@<BR>+/*<BR>+ * Copyright =
1998-2007 VIA Technologies, Inc. All Rights Reserved.<BR>+ * Copyright =
2001-2007 S3 Graphics, Inc. All Rights Reserved.<BR>+ *<BR>+ * =
Permission is hereby granted, free of charge, to any person obtaining =
a<BR>+ * copy of this software and associated documentation files (the =
"Software"),<BR>+ * to deal in the Software without restriction, =
including without limitation<BR>+ * the rights to use, copy, modify, =
merge, publish, distribute, sub license,<BR>+ * and/or sell copies of =
the Software, and to permit persons to whom the<BR>+ * Software is =
furnished to do so, subject to the following conditions:<BR>+ *<BR>+ * =
The above copyright notice and this permission notice (including =
the<BR>+ * next paragraph) shall be included in all copies or =
substantial portions<BR>+ * of the Software.<BR>+ *<BR>+ * THE SOFTWARE =
IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR<BR>+ * =
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF =
MERCHANTABILITY,<BR>+ * FITNESS FOR A PARTICULAR PURPOSE AND =
NON-INFRINGEMENT. IN NO EVENT SHALL<BR>+ * THE AUTHOR(S) OR COPYRIGHT =
HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR<BR>+ * OTHER LIABILITY, =
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,<BR>+ * ARISING =
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER<BR>+ =
* DEALINGS IN THE SOFTWARE.<BR>+ */<BR>+ <BR>+#include =
&lt;linux/ioport.h&gt;<BR>+#include &lt;asm/io.h&gt;<BR>+#include =
&lt;linux/fb.h&gt;<BR>+<BR>+#include "viafbdev.h"<BR>+#include =
"tv.h"<BR>+#include "share.h"<BR>+#include "chip.h"<BR>+#include =
"debug.h"<BR>+#include "tblIntegratedTV.h"<BR>+#include =
"IntegratedTV.h"<BR>+#include "ioctl.h"<BR>+<BR>+extern struct =
tv_setting_information&nbsp;&nbsp;&nbsp; tv_setting_info;<BR>+extern =
struct =
chip_information&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
chip_info;<BR>+<BR>+#if LINUX_VERSION_CODE &lt; =
KERNEL_VERSION(2,5,0)<BR>+extern struct viafb_info&nbsp;&nbsp;&nbsp; =
viafbinfo;<BR>+#else<BR>+extern struct viafb_par&nbsp;&nbsp;&nbsp;&nbsp; =
parinfo;<BR>+#endif<BR>+<BR>+extern inline void write_reg(u8 index, u16 =
io_port, u8 data);<BR>+extern inline u8 read_reg(int io_port, u8 =
index);<BR>+extern void write_reg_mask(u8 index, int io_port, u8 data, =
u8 mask);<BR>+extern void =
enable_second_display_channel(void);<BR>+extern void =
plus_vck_to_iga1_timing(unsigned long h_total);<BR>+extern void =
delays(int count);<BR>+extern void load_crtc_timing(struct =
display_timing device_timing, int set_iga);<BR>+<BR>+bool =
g_first_time_to_sense =3D TRUE;<BR>+<BR>+void =
enable_integrated_tv_shadow_reg(void)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; int =
i;<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Enable integrated TV shadow register. =
*/<BR>+&nbsp;&nbsp;&nbsp; /* Only for A0000 now, we may modify this if =
need other TV shadow memory. */<BR>+&nbsp;&nbsp;&nbsp; write_reg(SR52, =
VIASR, 0x01);<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Wait data ready. =
*/<BR>+&nbsp;&nbsp;&nbsp; for (i=3D0; i&lt;10; =
i++)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (read_reg(VIASR, =
SR52) &amp; BIT0)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; }<BR>+}<BR>+<BR>+<BR>+void =
disable_integrated_tv_shadow_reg(void)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; =
write_reg(SR52, VIASR, 0x00);<BR>+}&nbsp; <BR>+<BR>+<BR>+void =
write_integrated_tv_reg8(unsigned char* mmio_base, u8 offset, u8 =
data)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; *(volatile u8 *)(mmio_base + offset) =
=3D data;<BR>+&nbsp;&nbsp;&nbsp; DEBUG_MSG(KERN_INFO "Write Integrated =
TV Reg (byte): Offset 0x%2x, Value 0x%2x!\n", offset, =
data);<BR>+}<BR>+<BR>+<BR>+void write_integrated_tv_reg32(unsigned char* =
mmio_base, u8 offset, u32 data)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; *(volatile =
u32 *)(mmio_base + offset) =3D data;<BR>+&nbsp;&nbsp;&nbsp; =
DEBUG_MSG(KERN_INFO "Write Integrated TV Reg: Offset 0x%2x, Value =
0x%8x!\n", offset, data);<BR>+}<BR>+<BR>+<BR>+void =
write_integrated_tv_reg_mask32(unsigned char* mmio_base, u8 offset, u32 =
mask, u32 data)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; u32 old_data, =
new_data;<BR>+<BR>+&nbsp;&nbsp;&nbsp; old_data =3D *(volatile u32 =
*)(mmio_base + offset);<BR>+&nbsp;&nbsp;&nbsp; new_data =3D (data &amp; =
mask) | (old_data &amp; (~mask));<BR>+&nbsp;&nbsp;&nbsp; *(volatile u32 =
*)(mmio_base + offset) =3D new_data;<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
DEBUG_MSG(KERN_INFO "Write Integrated TV Reg Mask: Offset 0x%2x, Value =
0x%8x!\n", offset, new_data);<BR>+}<BR>+<BR>+<BR>+u32 =
read_integrated_tv_reg32(unsigned char* mmio_base, u8 =
offset)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; u32 =
data;<BR>+<BR>+&nbsp;&nbsp;&nbsp; data =3D *(volatile u32 *)(mmio_base + =
offset);<BR>+<BR>+&nbsp;&nbsp;&nbsp; return =
data;<BR>+}<BR>+<BR>+<BR>+void =
write_integrated_tv_general_table(unsigned short *tv_reg_offset_table, =
unsigned long *tv_reg_table)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; int i =3D =
0;<BR>+&nbsp;&nbsp;&nbsp; unsigned char* mmio_base;<BR>+<BR>+#if =
LINUX_VERSION_CODE &lt; KERNEL_VERSION(2,5,0)<BR>+&nbsp;&nbsp;&nbsp; =
mmio_base =3D (unsigned =
char*)viafbinfo.integrated_tv_map_base;<BR>+#else<BR>+&nbsp;&nbsp;&nbsp; =
mmio_base =3D (unsigned =
char*)parinfo.integrated_tv_map_base;<BR>+#endif<BR>+<BR>+&nbsp;&nbsp;&nb=
sp; while(tv_reg_offset_table[i] !=3D 0xFFFF)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_integrated_tv_reg32(mmio_base, =
GET_LOW_BYTE(tv_reg_offset_table[i]), =
tv_reg_table[i]);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
i++;<BR>+&nbsp;&nbsp;&nbsp; }<BR>+}<BR>+<BR>+<BR>+void =
write_integrated_tv_patch_table(u16 =
*tv_reg_table)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; int i =3D =
0;<BR>+&nbsp;&nbsp;&nbsp; unsigned char* mmio_base;<BR>+<BR>+#if =
LINUX_VERSION_CODE &lt; KERNEL_VERSION(2,5,0)<BR>+&nbsp;&nbsp;&nbsp; =
mmio_base =3D (unsigned =
char*)viafbinfo.integrated_tv_map_base;<BR>+#else<BR>+&nbsp;&nbsp;&nbsp; =
mmio_base =3D (unsigned =
char*)parinfo.integrated_tv_map_base;<BR>+#endif<BR>+&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; while(tv_reg_table[i] !=3D =
0xFFFF)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_integrated_tv_reg8(mmio_base, GET_LOW_BYTE(tv_reg_table[i]), =
GET_HIGH_BYTE(tv_reg_table[i]));<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; i++;<BR>+&nbsp;&nbsp;&nbsp; }<BR>+}<BR>+<BR>+<BR>+u32 =
access_integrated_tv_regs(int reg_id, u32 value, int =
cmd)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; u8 offset;<BR>+&nbsp;&nbsp;&nbsp; u32 =
mask, set_data, get_data, shift_bits, tmp1, tmp2;<BR>+&nbsp;&nbsp;&nbsp; =
unsigned char* mmio_base;<BR>+<BR>+#if LINUX_VERSION_CODE &lt; =
KERNEL_VERSION(2,5,0)<BR>+&nbsp;&nbsp;&nbsp; mmio_base =3D (unsigned =
char*)viafbinfo.integrated_tv_map_base;<BR>+#else<BR>+&nbsp;&nbsp;&nbsp; =
mmio_base =3D (unsigned =
char*)parinfo.integrated_tv_map_base;<BR>+#endif<BR>+<BR>+&nbsp;&nbsp;&nb=
sp; /* Note: It's better to call enable_integrated_tv_shadow_reg() to =
enable integrated TV shadow register */<BR>+&nbsp;&nbsp;&nbsp; /* before =
access the following registers, or it may fail to access them. =
*/<BR>+&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; switch =
(reg_id)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
ITV_REG_ID_PK_ENABLE:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* 00[0] =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 offset =3D =
0x00;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mask =3D =
0x00000001;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; shift_bits =3D =
0;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
ITV_REG_ID_SRC_SEL:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* 00[18] =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 offset =3D =
0x00;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mask =3D =
0x00040000;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; shift_bits =3D =
18;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
ITV_REG_ID_SW_RESET:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* 00[20] =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 offset =3D =
0x00;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mask =3D =
0x00100000;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; shift_bits =3D =
20;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
ITV_REG_ID_SYNC_BUF_MODE:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* 00[30] =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 offset =3D =
0x00;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mask =3D =
0x40000000;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; shift_bits =3D =
30;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
ITV_REG_ID_SD_ENABLE:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* 00[31] =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 offset =3D =
0x00;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mask =3D =
0x80000000;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; shift_bits =3D =
31;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
ITV_REG_ID_SRC_VSIZE:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* 18[10:0] =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 offset =3D =
0x18;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mask =3D =
0x000007FF;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; shift_bits =3D =
0;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 <BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
ITV_REG_ID_SRC_HSIZE:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* 18[21:11] =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 offset =3D =
0x18;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mask =3D =
0x003FF800;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; shift_bits =3D =
11;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
ITV_REG_ID_DE_FLK_THRESHOLD:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* 20[31:27] + 20[15:11] =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 offset =3D =
0x20;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
if (cmd =3D=3D =
ITV_CMD_WRITE)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; tmp1 =3D value &amp; =
0x1F;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* bit4-bit0 =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; tmp2 =3D (value &gt;&gt; 5) &amp; 0x1F; /* =
bit9-bit5 =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; set_data =3D (tmp2 &lt;&lt; 27) | (tmp1 =
&lt;&lt; =
11);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; write_integrated_tv_reg_mask32(mmio_base, =
offset, 0xF800F800, =
set_data);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; return 0;&nbsp; /* 0 means nothing, just for =
return. =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
else<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; get_data =3D read_integrated_tv_reg32(mmio_base, =
offset);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp1 =3D (get_data &amp; 0x0000F800) =
&gt;&gt; 11;&nbsp;&nbsp; /* bit4-bit0 =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; tmp2 =3D (get_data &amp; 0xF8000000) &gt;&gt; =
27;&nbsp;&nbsp; /* bit9-bit5 =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; get_data =3D (tmp2 &lt;&lt; 5) | =
tmp1;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
get_data;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
ITV_REG_ID_SCL_VFAC:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* 24[12:0] =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 offset =3D =
0x24;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mask =3D =
0x00001FFF;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; shift_bits =3D =
0;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 <BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
ITV_REG_ID_DE_FLK_NUM:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* 24[13] =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 offset =3D =
0x24;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mask =3D =
0x00002000;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; shift_bits =3D =
13;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
ITV_REG_ID_DF_WT_SEL:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* 24[14] =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 offset =3D =
0x24;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mask =3D =
0x00004000;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; shift_bits =3D =
14;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
ITV_REG_ID_DF_TYPE:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* 24[15] =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 offset =3D =
0x24;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mask =3D =
0x00008000;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; shift_bits =3D =
15;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
ITV_REG_ID_DE_FLICKER_ENABLE:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* 24[29] =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 offset =3D =
0x24;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mask =3D =
0x20000000;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; shift_bits =3D =
29;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
ITV_REG_ID_SCL_HFAC:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* 24[28:16] =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 offset =3D =
0x24;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mask =3D =
0x1FFF0000;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; shift_bits =3D =
16;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
ITV_REG_ID_DST_VSIZE:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* 28[10:0] =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 offset =3D =
0x28;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mask =3D =
0x000007FF;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; shift_bits =3D =
0;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 <BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
ITV_REG_ID_DST_HSIZE:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* 28[21:11] =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 offset =3D =
0x28;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mask =3D =
0x003FF800;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; shift_bits =3D =
11;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
ITV_REG_ID_TV_ENABLE:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* 38[0] =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 offset =3D =
0x38;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mask =3D =
0x00000001;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; shift_bits =3D =
0;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
ITV_REG_ID_OUTPUT_SEL:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* 38[29:28] =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 offset =3D =
0x38;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mask =3D =
0x30000000;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; shift_bits =3D =
28;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
ITV_REG_ID_TV_SENSE:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* 3C[15:14] =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 offset =3D =
0x3C;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mask =3D =
0x0000C000;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; shift_bits =3D =
14;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
ITV_REG_ID_TV_SENSE_DATA:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* 3C[31:24] =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 offset =3D =
0x3C;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mask =3D =
0xFF000000;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; shift_bits =3D =
24;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
ITV_REG_ID_DST_HSD:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* 48[30:21] =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 offset =3D =
0x48;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mask =3D =
0x7FE00000;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; shift_bits =3D =
21;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
ITV_REG_ID_DST_VSD:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* 4C[31:23] =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 offset =3D =
0x4C;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mask =3D =
0xFF800000;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; shift_bits =3D =
23;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
ITV_REG_ID_SATURATION:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* 50[8:0] + 50[24:16] =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 offset =3D =
0x50;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
if (cmd =3D=3D =
ITV_CMD_WRITE)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; tmp1 =3D value &amp; =
0x1FF;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* bit8-bit0 =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; tmp2 =3D (value &gt;&gt; 9) &amp; 0x1FF; /* =
bit24-bit16 =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; set_data =3D ((tmp2 &lt;&lt; 16) | =
(tmp1));<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_integrated_tv_reg_mask32(mmio_base, =
offset, 0x01FF01FF, =
set_data);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; return 0;&nbsp; /* 0 means nothing, just for =
return. =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
else<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; get_data =3D read_integrated_tv_reg32(mmio_base, =
offset);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp1 =3D (get_data &amp; =
0x000001FF);&nbsp;&nbsp; /* bit8-bit0 =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; tmp2 =3D (get_data &amp; 0x01FF0000) &gt;&gt; =
16;&nbsp;&nbsp; /* bit24-bit16 =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; get_data =3D (tmp2 &lt;&lt; 9) | =
tmp1;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
get_data;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
ITV_REG_ID_CONTRAST:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* 54[8:0] =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 offset =3D =
0x54;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mask =3D =
0x000001FF;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; shift_bits =3D =
0;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
ITV_REG_ID_BLACK_LEVEL:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* 54[30:23] =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 offset =3D =
0x54;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mask =3D =
0x7F800000;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; shift_bits =3D =
23;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
ITV_REG_ID_HUE:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* 60[10:0] =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 offset =3D =
0x60;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mask =3D =
0x000007FF;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; shift_bits =3D =
0;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
ITV_REG_ID_PRI_DAC_SEL:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* 6C[12] =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 offset =3D =
0x6C;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mask =3D =
0x00001000;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; shift_bits =3D =
12;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
ITV_REG_ID_TV_SENSE_STATUS:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* E4[2] =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 offset =3D =
0xE4;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mask =3D =
0x00000004;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; shift_bits =3D =
2;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 <BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
ITV_REG_ID_PBPR_BLANK_LEVEL:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* E8[8:0] =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 offset =3D =
0xE8;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mask =3D =
0x000000FF;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; shift_bits =3D 0; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
ITV_REG_ID_TV_SENSE_RGB_STATUS:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* E8[30:28] =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 offset =3D =
0xE8;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mask =3D =
0x70000000;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; shift_bits =3D =
28;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
default:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return 0;&nbsp; /* 0 means nothing, just for return. =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; }<BR>+<BR>+&nbsp;&nbsp;&nbsp; if (cmd =3D=3D =
ITV_CMD_WRITE)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_data =3D value =
&lt;&lt; shift_bits;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_integrated_tv_reg_mask32(mmio_base, offset, mask, =
set_data);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;&nbsp; /* 0 =
means nothing, just for return. */<BR>+&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; else<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; get_data =3D =
read_integrated_tv_reg32(mmio_base, =
offset);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; get_data =3D =
(get_data &amp; mask) &gt;&gt; =
shift_bits;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
get_data;<BR>+&nbsp;&nbsp;&nbsp; }<BR>+}<BR>+<BR>+<BR>+void =
set_integrated_tv_output_signal(void)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; =
u8&nbsp; sr5e;<BR>+&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; /* HDTV =
only can use RGB or YPbPr output. */<BR>+&nbsp;&nbsp;&nbsp; if =
((tv_setting_info.system =3D=3D TVTYPE_480P) || (tv_setting_info.system =
=3D=3D TVTYPE_576P) ||<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
(tv_setting_info.system =3D=3D TVTYPE_720P) || (tv_setting_info.system =
=3D=3D TVTYPE_1080I))<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; {<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
if ((tv_setting_info.out_signal !=3D TV_OUTPUT_RGB) =
&amp;&amp;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; (tv_setting_info.out_signal !=3D =
TV_OUTPUT_YPBPR))<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_setting_info.out_signal =3D =
TV_OUTPUT_RGB;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; DEBUG_MSG(KERN_INFO =
"set_integrated_tv_output_signal: TVOutput =3D %d\n", =
tv_setting_info.out_signal);<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* We could =
separate Composite and S-Video by controlling DAC R/G/B. =
*/<BR>+&nbsp;&nbsp;&nbsp; sr5e =3D read_reg(VIASR, SR5E) &amp; =
0xF1;&nbsp;&nbsp;&nbsp; /* Turn on DAC R/G/B. =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; switch =
(tv_setting_info.out_signal)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
TV_OUTPUT_COMPOSITE:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
access_integrated_tv_regs(ITV_REG_ID_OUTPUT_SEL, ITV_VALUE_OUTPUT_SC, =
ITV_CMD_WRITE);<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; /* Turn off DAC R and G, turn on DAC B. =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 write_reg(SR5E, VIASR, sr5e | =
(BIT1+BIT2));<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
TV_OUTPUT_SVIDEO:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
access_integrated_tv_regs(ITV_REG_ID_OUTPUT_SEL, ITV_VALUE_OUTPUT_SC, =
ITV_CMD_WRITE);<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; /* Turn on DAC R and G, turn off DAC B. =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 write_reg(SR5E, VIASR, sr5e | =
BIT3);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
TV_OUTPUT_COMPOSITE_SVIDEO:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
access_integrated_tv_regs(ITV_REG_ID_OUTPUT_SEL, ITV_VALUE_OUTPUT_SC, =
ITV_CMD_WRITE);<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; /* Turn on DAC R/G/B. =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 write_reg(SR5E, VIASR, =
sr5e);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
TV_OUTPUT_RGB:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
access_integrated_tv_regs(ITV_REG_ID_OUTPUT_SEL, ITV_VALUE_OUTPUT_RGB, =
ITV_CMD_WRITE);<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; /* Turn on DAC R/G/B. =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 write_reg(SR5E, VIASR, =
sr5e);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
TV_OUTPUT_YPBPR:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
access_integrated_tv_regs(ITV_REG_ID_OUTPUT_SEL, ITV_VALUE_OUTPUT_YPbPr, =
ITV_CMD_WRITE);<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; /* Turn on DAC R/G/B. =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 write_reg(SR5E, VIASR, =
sr5e);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
default:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
access_integrated_tv_regs(ITV_REG_ID_OUTPUT_SEL, ITV_VALUE_OUTPUT_SC, =
ITV_CMD_WRITE);<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; /* Turn off DAC R and G, turn on DAC B. =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 write_reg(SR5E, VIASR, sr5e | =
(BIT1+BIT2));<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; }<BR>+}<BR>+<BR>+<BR>+void =
write_gfx_crtc_timing_for_tv(unsigned long =
*tv_crtc_table)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; int =
i;<BR>+&nbsp;&nbsp;&nbsp; struct display_timing&nbsp; =
tv_crtc_reg;<BR>+&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; for (i=3D0; =
i&lt; NUM_CRTC_TIMING; i++)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
switch(i)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
H_TOTAL_INDEX:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tv_crtc_reg.hor_total =3D =
tv_crtc_table[i];<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DEBUG_MSG(KERN_INFO "H_Total: =
%d!\n", =
tv_crtc_reg.hor_total);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
H_ADDR_INDEX:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tv_crtc_reg.hor_addr =3D =
tv_crtc_table[i];<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DEBUG_MSG(KERN_INFO "H_Addr: =
%d!\n", =
tv_crtc_reg.hor_addr);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
H_BLANK_START_INDEX:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tv_crtc_reg.hor_blank_start =
=3D =
tv_crtc_table[i];<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DEBUG_MSG(KERN_INFO =
"H_Blank_Start: %d!\n", =
tv_crtc_reg.hor_blank_start);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
H_BLANK_END_INDEX:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tv_crtc_reg.hor_blank_end =3D =
tv_crtc_table[i];<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DEBUG_MSG(KERN_INFO =
"H_Blank_End: %d!\n", =
tv_crtc_reg.hor_blank_end);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
H_SYNC_START_INDEX:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tv_crtc_reg.hor_sync_start =3D =
tv_crtc_table[i];<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DEBUG_MSG(KERN_INFO =
"H_Sync_Start: %d!\n", =
tv_crtc_reg.hor_sync_start);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
H_SYNC_END_INDEX:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tv_crtc_reg.hor_sync_end =3D =
tv_crtc_table[i];<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DEBUG_MSG(KERN_INFO "H_Sync_End: =
%d!\n", =
tv_crtc_reg.hor_sync_end);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
V_TOTAL_INDEX:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tv_crtc_reg.ver_total =3D =
tv_crtc_table[i];<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
V_ADDR_INDEX:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tv_crtc_reg.ver_addr =3D =
tv_crtc_table[i];<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
V_BLANK_START_INDEX:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tv_crtc_reg.ver_blank_start =
=3D =
tv_crtc_table[i];<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
V_BLANK_END_INDEX:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tv_crtc_reg.ver_blank_end =3D =
tv_crtc_table[i];<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
V_SYNC_START_INDEX:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tv_crtc_reg.ver_sync_start =3D =
tv_crtc_table[i];<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
V_SYNC_END_INDEX:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tv_crtc_reg.ver_sync_end =3D =
tv_crtc_table[i];<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp; load_crtc_timing(tv_crtc_reg, =
tv_setting_info.iga_path);<BR>+}<BR>+<BR>+<BR>+void =
update_scaling_factor(void)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; u32 dst_hsize, =
dst_vsize, src_hsize, src_vsize, scal_factor =3D =
0;<BR>+<BR>+&nbsp;&nbsp;&nbsp; dst_hsize =3D =
access_integrated_tv_regs(ITV_REG_ID_DST_HSIZE, 0, ITV_CMD_READ) + =
1;<BR>+&nbsp;&nbsp;&nbsp; dst_vsize =3D =
access_integrated_tv_regs(ITV_REG_ID_DST_VSIZE, 0, ITV_CMD_READ) + =
1;<BR>+&nbsp;&nbsp;&nbsp; src_hsize =3D =
access_integrated_tv_regs(ITV_REG_ID_SRC_HSIZE, 0, ITV_CMD_READ) + =
1;<BR>+&nbsp;&nbsp;&nbsp; src_vsize =3D =
access_integrated_tv_regs(ITV_REG_ID_SRC_VSIZE, 0, ITV_CMD_READ) + =
1;<BR>+<BR>+&nbsp;&nbsp;&nbsp; if ((tv_setting_info.system =3D=3D =
TVTYPE_480P) ||<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
(tv_setting_info.system =3D=3D TVTYPE_576P) =
||<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
(tv_setting_info.system =3D=3D TVTYPE_1080I))<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scal_factor =3D =
(src_hsize * 2048) / dst_hsize;<BR>+&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; else if (tv_setting_info.system =3D=3D =
TVTYPE_720P)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* The two modes =
720x480 and 720x576 have alignment issue (alignment to 4), =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; so the =
value of SRC_LINE_PITCH, DST_DQW_NUM and =
DST_LINE_PITCH<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; we set are greater than the desired ones, and this may cause the =
problem about =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; having =
garbage line on the right side, so we reduce the scaling factor to =
avoid<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
this problem. */<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(((src_hsize =3D=3D 720) &amp;&amp; (src_vsize =3D=3D 480)) =
||<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 ((src_hsize =3D=3D 720) &amp;&amp; (src_vsize =3D=3D =
576)))<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
scal_factor =3D ((src_hsize * 2048) / dst_hsize) - =
3;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
else<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
scal_factor =3D (src_hsize * 2048) / =
dst_hsize;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; =
else<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scal_factor =3D =
(src_hsize * 2048) / (dst_hsize * 2);<BR>+&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; =
access_integrated_tv_regs(ITV_REG_ID_SCL_HFAC, scal_factor, =
ITV_CMD_WRITE);<BR>+<BR>+&nbsp;&nbsp;&nbsp; scal_factor =3D (src_vsize * =
2048) / dst_vsize;<BR>+&nbsp;&nbsp;&nbsp; =
access_integrated_tv_regs(ITV_REG_ID_SCL_VFAC, scal_factor, =
ITV_CMD_WRITE);<BR>+}<BR>+<BR>+<BR>+void set_hdtv_patch_table(int =
mode_index)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; =
switch(tv_setting_info.system)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
TVTYPE_480P:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; =
write_integrated_tv_patch_table(ITV_HDTV_PATCH_TABLE[mode_index].std_480p=
);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; <BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
TVTYPE_576P:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; =
write_integrated_tv_patch_table(ITV_HDTV_PATCH_TABLE[mode_index].std_576p=
);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; <BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
TVTYPE_720P:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; =
write_integrated_tv_patch_table(ITV_HDTV_PATCH_TABLE[mode_index].std_720p=
);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; <BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
TVTYPE_1080I:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; =
write_integrated_tv_patch_table(ITV_HDTV_PATCH_TABLE[mode_index].std_1080=
i);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
default:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; break;<BR>+&nbsp;&nbsp;&nbsp; }<BR>+}<BR>+<BR>+<BR>+void =
set_tv_output_patch_table(void)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; if =
(tv_setting_info.out_signal =3D=3D TV_OUTPUT_RGB)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(tv_setting_info.system =3D=3D =
TVTYPE_NTSC)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_integrated_tv_patch_table(ITV_PATCH_TABLE_RGB_NTSC);<BR>+&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if =
(tv_setting_info.system =3D=3D =
TVTYPE_PAL)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_integrated_tv_patch_table(ITV_PATCH_TABLE_RGB_PAL);<BR>+&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; else if (tv_setting_info.out_signal =3D=3D =
TV_OUTPUT_YPBPR)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(tv_setting_info.system =3D=3D =
TVTYPE_NTSC)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_integrated_tv_patch_table(ITV_PATCH_TABLE_YPBPR_NTSC);<BR>+&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if =
(tv_setting_info.system =3D=3D =
TVTYPE_PAL)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_integrated_tv_patch_table(ITV_PATCH_TABLE_YPBPR_PAL);<BR>+&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; =
}<BR>+}<BR>+<BR>+void patch_for_macrovision(void)<BR>+{ =
<BR>+&nbsp;&nbsp;&nbsp; /* We should do this patch for this issue:&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; /* The H-sync cycle of VT3324A3 integrated TV =
disappeared when disable TV macrovision. */<BR>+&nbsp;&nbsp;&nbsp; if =
(CX700_REVISION_700M2 !=3D chip_info.gfx_chip_revision) /* Macrovision =
disable. */<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch =
(tv_setting_info.system)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
TVTYPE_NTSC:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case =
TVTYPE_480P:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
access_integrated_tv_regs(ITV_REG_ID_PBPR_BLANK_LEVEL, 0x6D, =
ITV_CMD_WRITE);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
TVTYPE_PAL:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; case =
TVTYPE_576P:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
access_integrated_tv_regs(ITV_REG_ID_PBPR_BLANK_LEVEL, 0x71, =
ITV_CMD_WRITE);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; case =
TVTYPE_720P:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case =
TVTYPE_1080I:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
access_integrated_tv_regs(ITV_REG_ID_PBPR_BLANK_LEVEL, 0x72, =
ITV_CMD_WRITE);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; =
}<BR>+}<BR>+<BR>+<BR>+void set_integrated_tv_mode(int =
tv_mode_index)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; int i, =
mode_index;<BR>+&nbsp;&nbsp;&nbsp; unsigned long&nbsp; *tv_mode_table =
=3D NULL;<BR>+&nbsp;&nbsp;&nbsp; unsigned long&nbsp; *tv_crtc_table =3D =
NULL;<BR>+<BR>+&nbsp;&nbsp;&nbsp; DEBUG_MSG(KERN_INFO =
"set_integrated_tv_mode!\n");<BR>+&nbsp;&nbsp;&nbsp; DEBUG_MSG(KERN_INFO =
"TV Mode =3D %d.\n", tv_mode_index);<BR>+&nbsp;&nbsp;&nbsp; =
DEBUG_MSG(KERN_INFO "TV Type =3D %d\n", =
tv_setting_info.system);<BR>+&nbsp;&nbsp;&nbsp; DEBUG_MSG(KERN_INFO "TV =
Output =3D %d\n", tv_setting_info.out_signal);<BR>+&nbsp;&nbsp;&nbsp; =
DEBUG_MSG(KERN_INFO "TV IGA =3D %d\n", =
tv_setting_info.iga_path);&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; /* Try to get the suitable mode table. =
*/<BR>+&nbsp;&nbsp;&nbsp; for (i=3D0; =
i&lt;NUM_TOTAL_INTEGRATEDTV_MODE_TABLE; i++)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mode_index =3D =
i;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(ITV_MODE_TABLE[i].mode_index =3D=3D =
tv_mode_index)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; DEBUG_MSG(KERN_INFO "TV Mode Index to use is: =
%d.\n" , mode_index);<BR>+<BR>+&nbsp;&nbsp;&nbsp; switch =
(tv_setting_info.system)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
TVTYPE_NTSC:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_mode_table =3D =
ITV_MODE_TABLE[mode_index].std_ntsc;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tv_crtc_table =3D =
ITV_CRTC_TABLE[mode_index].std_ntsc;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
TVTYPE_PAL:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_mode_table =3D =
ITV_MODE_TABLE[mode_index].std_pal;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tv_crtc_table =3D =
ITV_CRTC_TABLE[mode_index].std_pal;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
TVTYPE_480P:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* For 480P, we use NTSC's mode table, and then do some patches later. =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 tv_mode_table =3D =
ITV_MODE_TABLE[mode_index].std_ntsc;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tv_crtc_table =3D =
ITV_CRTC_TABLE[mode_index].std_ntsc;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
TVTYPE_576P:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* For 576P, we use PAL's mode table, and then do some patches later. =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 tv_mode_table =3D =
ITV_MODE_TABLE[mode_index].std_pal;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tv_crtc_table =3D =
ITV_CRTC_TABLE[mode_index].std_pal;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
TVTYPE_720P:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_mode_table =3D =
ITV_MODE_TABLE[mode_index].std_720p;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tv_crtc_table =3D =
ITV_CRTC_TABLE[mode_index].std_720p;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
TVTYPE_1080I:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_mode_table =3D =
ITV_MODE_TABLE[mode_index].std_1080i;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tv_crtc_table =3D =
ITV_CRTC_TABLE[mode_index].std_1080i;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
default:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_mode_table =3D =
ITV_MODE_TABLE[mode_index].std_ntsc;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tv_crtc_table =3D =
ITV_CRTC_TABLE[mode_index].std_ntsc;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; =
enable_integrated_tv_shadow_reg();<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Write =
TV Encoder Regsiters: */<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Common settings =
by mode: */<BR>+&nbsp;&nbsp;&nbsp; =
write_integrated_tv_general_table(ITV_MODE_TABLE_OFFSET, =
tv_mode_table);<BR>+&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; /* Write =
GFX CRTC timing by TV mode. */<BR>+&nbsp;&nbsp;&nbsp; =
write_gfx_crtc_timing_for_tv(tv_crtc_table);<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
if (tv_setting_info.iga_path =3D=3D IGA2)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
access_integrated_tv_regs(ITV_REG_ID_SRC_SEL, ITV_VALUE_SRC_FROM_IGA2, =
ITV_CMD_WRITE);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg_mask(CR6A, =
VIACR, 0, BIT2);<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
enable_second_display_channel();<BR>+&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; else<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
access_integrated_tv_regs(ITV_REG_ID_SRC_SEL, ITV_VALUE_SRC_FROM_IGA1, =
ITV_CMD_WRITE);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For the case: TV IGA1 =
horizontal total can't be divided by 8. =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
plus_vck_to_iga1_timing(tv_crtc_table[H_TOTAL_INDEX]);<BR>+&nbsp;&nbsp;&n=
bsp; }<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Set TV output signal: =
*/<BR>+&nbsp;&nbsp;&nbsp; =
set_integrated_tv_output_signal();<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Patch =
for HDTV: */<BR>+&nbsp;&nbsp;&nbsp; =
set_hdtv_patch_table(mode_index);<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* We =
should modify some settings if use RGB/YPbPr output. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
set_tv_output_patch_table();<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Update =
scaling factor: */<BR>+&nbsp;&nbsp;&nbsp; =
update_scaling_factor();<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Ported from X to =
support A3*/<BR>+&nbsp;&nbsp;&nbsp; =
patch_for_macrovision();<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
disable_integrated_tv_shadow_reg();<BR>+}<BR>+<BR>+<BR>+void =
integrated_tv_sw_reset(void)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; =
enable_integrated_tv_shadow_reg();<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
access_integrated_tv_regs(ITV_REG_ID_SD_ENABLE, ITV_VALUE_DISABLE, =
ITV_CMD_WRITE);<BR>+&nbsp;&nbsp;&nbsp; =
access_integrated_tv_regs(ITV_REG_ID_SW_RESET, ITV_VALUE_ENABLE, =
ITV_CMD_WRITE);<BR>+&nbsp;&nbsp;&nbsp; =
access_integrated_tv_regs(ITV_REG_ID_SW_RESET, ITV_VALUE_DISABLE, =
ITV_CMD_WRITE);<BR>+<BR>+&nbsp;&nbsp;&nbsp; delays(50000);&nbsp; /* We =
should delay to wait IGA1's VSync. */<BR>+&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; access_integrated_tv_regs(ITV_REG_ID_SD_ENABLE, =
ITV_VALUE_ENABLE, ITV_CMD_WRITE);<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
disable_integrated_tv_shadow_reg();<BR>+}<BR>+<BR>+<BR>+void =
integrated_tv_enable(void)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; /* Turn on DPMS. =
*/<BR>+&nbsp;&nbsp;&nbsp; write_reg_mask(CR36, VIACR, 0, =
BIT4+BIT5);<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
enable_integrated_tv_shadow_reg();<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* For =
the problem TV may crash when we repeat to switch TV type =
*/<BR>+&nbsp;&nbsp;&nbsp; /* (NTSC-&gt;PAL-&gt;NTSC-&gt;PAL-&gt;...), to =
do the following sequence can help avoiding this problem. =
*/<BR>+&nbsp;&nbsp;&nbsp; /* 1. Disable Sync Buffer Mode before set mode =
and disable TV. */<BR>+&nbsp;&nbsp;&nbsp; /* 2. Enable Sync Buffer Mode =
before enable TV. */&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; /* =
Suggested by HW team. */<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Enable Sync =
Buffer Mode: */<BR>+&nbsp;&nbsp;&nbsp; =
access_integrated_tv_regs(ITV_REG_ID_SYNC_BUF_MODE, ITV_VALUE_ENABLE, =
ITV_CMD_WRITE);<BR>+&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; /* Enable PK. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
access_integrated_tv_regs(ITV_REG_ID_PK_ENABLE, ITV_VALUE_ENABLE, =
ITV_CMD_WRITE);<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Enable SD. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
access_integrated_tv_regs(ITV_REG_ID_SD_ENABLE, ITV_VALUE_ENABLE, =
ITV_CMD_WRITE);<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Enable TV encoder. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
access_integrated_tv_regs(ITV_REG_ID_TV_ENABLE, ITV_VALUE_ENABLE, =
ITV_CMD_WRITE);<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Change DAC usage. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
access_integrated_tv_regs(ITV_REG_ID_PRI_DAC_SEL, ITV_VALUE_DAC_FOR_TV, =
ITV_CMD_WRITE);<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Disable SW Reset. =
*/<BR>+&nbsp;&nbsp;&nbsp; access_integrated_tv_regs(ITV_REG_ID_SW_RESET, =
ITV_VALUE_DISABLE, ITV_CMD_WRITE);<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
disable_integrated_tv_shadow_reg();<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
integrated_tv_sw_reset();<BR>+}<BR>+<BR>+<BR>+void =
integrated_tv_disable(void)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; =
enable_integrated_tv_shadow_reg();<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* For =
the problem TV may crash when we repeat to switch TV type =
*/<BR>+&nbsp;&nbsp;&nbsp; /* (NTSC-&gt;PAL-&gt;NTSC-&gt;PAL-&gt;...), to =
do the following sequence can help avoiding this problem. =
*/<BR>+&nbsp;&nbsp;&nbsp; /* 1. Disable Sync Buffer Mode before set mode =
and disable TV. */<BR>+&nbsp;&nbsp;&nbsp; /* 2. Enable Sync Buffer Mode =
before enable TV. */&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; /* =
Suggested by HW team. */<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Enable SW Reset. =
*/<BR>+&nbsp;&nbsp;&nbsp; access_integrated_tv_regs(ITV_REG_ID_SW_RESET, =
ITV_VALUE_ENABLE, ITV_CMD_WRITE);<BR>+&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; /* Disable Sync Buffer Mode: =
*/<BR>+&nbsp;&nbsp;&nbsp; =
access_integrated_tv_regs(ITV_REG_ID_SYNC_BUF_MODE, ITV_VALUE_DISABLE, =
ITV_CMD_WRITE);<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Disable PK. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
access_integrated_tv_regs(ITV_REG_ID_PK_ENABLE, ITV_VALUE_DISABLE, =
ITV_CMD_WRITE);<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Disable SD. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
access_integrated_tv_regs(ITV_REG_ID_SD_ENABLE, ITV_VALUE_DISABLE, =
ITV_CMD_WRITE);<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Disable TV encoder. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
access_integrated_tv_regs(ITV_REG_ID_TV_ENABLE, ITV_VALUE_DISABLE, =
ITV_CMD_WRITE);<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Change DAC usage. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
access_integrated_tv_regs(ITV_REG_ID_PRI_DAC_SEL, ITV_VALUE_DAC_FOR_CRT, =
ITV_CMD_WRITE);<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
disable_integrated_tv_shadow_reg();<BR>+}<BR>+<BR>+<BR>+void =
get_integrated_tv_default_status(void)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; =
static int scale_value_initialized;<BR>+&nbsp;&nbsp;&nbsp; =
enable_integrated_tv_shadow_reg();<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Size: =
*/<BR>+&nbsp;&nbsp;&nbsp; /* The scaling factor level and default value =
here are not absolute, they can change by request. =
*/<BR>+&nbsp;&nbsp;&nbsp; tv_setting_info.ScalHLevel =3D =
21;<BR>+&nbsp;&nbsp;&nbsp; tv_setting_info.ScalVLevel =3D =
15;<BR>+&nbsp;&nbsp;&nbsp; tv_setting_info.DefaultScalH =3D =
10;<BR>+&nbsp;&nbsp;&nbsp; tv_setting_info.DefaultScalV =3D =
7;<BR>+&nbsp;&nbsp;&nbsp; if(!scale_value_initialized) =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_setting_info.CurrentScalH =3D =
tv_setting_info.DefaultScalH;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; tv_setting_info.CurrentScalV =3D =
tv_setting_info.DefaultScalV;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; scale_value_initialized=3D1;<BR>+&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; tv_setting_info.ScalDegreeH =3D =
5;<BR>+&nbsp;&nbsp;&nbsp; tv_setting_info.ScalDegreeV =3D =
5;<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Positoin: */<BR>+&nbsp;&nbsp;&nbsp; /* =
The position level and default value here are not absolute, they can =
change by request. */<BR>+&nbsp;&nbsp;&nbsp; =
tv_setting_info.PositionHLevel =3D 17;<BR>+&nbsp;&nbsp;&nbsp; =
tv_setting_info.PositionVLevel =3D 13;<BR>+&nbsp;&nbsp;&nbsp; =
tv_setting_info.DefaultPositionH =3D 9;<BR>+&nbsp;&nbsp;&nbsp; =
tv_setting_info.DefaultPositionV =3D 7;<BR>+&nbsp;&nbsp;&nbsp; =
tv_setting_info.CurrentPositionH =3D =
tv_setting_info.DefaultPositionH;<BR>+&nbsp;&nbsp;&nbsp; =
tv_setting_info.CurrentPositionV =3D =
tv_setting_info.DefaultPositionV;<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
tv_setting_info.DefaultFFilter =3D 0;<BR>+&nbsp;&nbsp;&nbsp; =
tv_setting_info.FFilterLevel =3D 1;<BR>+&nbsp;&nbsp;&nbsp; =
tv_setting_info.CurrentFFilter =3D =
tv_setting_info.DefaultFFilter;<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
tv_setting_info.DefaultAFFilter =3D 0;<BR>+&nbsp;&nbsp;&nbsp; =
tv_setting_info.AFFilterLevel =3D 1023;<BR>+&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; /* Brightness: */<BR>+&nbsp;&nbsp;&nbsp; =
tv_setting_info.DefaultBrightness =3D =
access_integrated_tv_regs(ITV_REG_ID_BLACK_LEVEL, 0, =
ITV_CMD_READ);<BR>+&nbsp;&nbsp;&nbsp; tv_setting_info.BrightnessLevel =
=3D 255;&nbsp; /* 8 bits. */<BR>+&nbsp;&nbsp;&nbsp; =
tv_setting_info.CurrentBrightness =3D =
tv_setting_info.DefaultBrightness;<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* =
Contrast: */<BR>+&nbsp;&nbsp;&nbsp; tv_setting_info.DefaultContrast=3D =
access_integrated_tv_regs(ITV_REG_ID_CONTRAST, 0, =
ITV_CMD_READ);<BR>+&nbsp;&nbsp;&nbsp; tv_setting_info.ContrastLevel =3D =
512;&nbsp; /* 9 bits. */<BR>+&nbsp;&nbsp;&nbsp; =
tv_setting_info.CurrentContrast=3D =
tv_setting_info.DefaultContrast;<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* =
Saturation: */<BR>+&nbsp;&nbsp;&nbsp; =
tv_setting_info.DefaultSaturation=3D =
access_integrated_tv_regs(ITV_REG_ID_SATURATION, 0, =
ITV_CMD_READ);<BR>+&nbsp;&nbsp;&nbsp; tv_setting_info.SaturationLevel =
=3D 0x3FFFF;&nbsp; /* 9+9 bits. */<BR>+&nbsp;&nbsp;&nbsp; =
tv_setting_info.CurrentSaturation=3D =
tv_setting_info.DefaultSaturation;<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Hue: =
*/<BR>+&nbsp;&nbsp;&nbsp; tv_setting_info.DefaultTINT =3D =
access_integrated_tv_regs(ITV_REG_ID_HUE, 0, =
ITV_CMD_READ);<BR>+&nbsp;&nbsp;&nbsp; tv_setting_info.TINTLevel =3D =
2047;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 11 bits. =
*/<BR>+&nbsp;&nbsp;&nbsp; tv_setting_info.CurrentTINT =3D =
tv_setting_info.DefaultTINT;<BR>+&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; =
disable_integrated_tv_shadow_reg();<BR>+}<BR>+<BR>+<BR>+int =
get_integrated_tv_ffilter_status(int filter_type, int* =
filter_state)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; int value =3D =
0;<BR>+&nbsp;&nbsp;&nbsp; int tmp_filter_state =3D =
0;<BR>+&nbsp;&nbsp;&nbsp; int tmp_filter_type =
=3D0;<BR>+&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; =
enable_integrated_tv_shadow_reg();<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* check =
if filter is enable */<BR>+&nbsp;&nbsp;&nbsp; tmp_filter_state =3D =
access_integrated_tv_regs(ITV_REG_ID_DE_FLICKER_ENABLE, 0, =
ITV_CMD_READ);<BR>+ <BR>+&nbsp;&nbsp;&nbsp; /* get current filter type =
*/<BR>+&nbsp;&nbsp;&nbsp; tmp_filter_type =3D =
access_integrated_tv_regs(ITV_REG_ID_DE_FLK_NUM, 0, =
ITV_CMD_READ);<BR>+&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; if =
(filter_type =3D=3D ITV_FILTER_TYPE_NORMAL)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((tmp_filter_state =
=3D=3D STATE_ON) &amp;&amp; (tmp_filter_type =3D=3D =
ITV_VALUE_FLK_NUM_WHOLE_IMAGE))<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*filter_state =3D =
STATE_ON;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
else<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*filter_state =3D =
STATE_OFF;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value =3D =
access_integrated_tv_regs(ITV_REG_ID_DF_WT_SEL, 0, =
ITV_CMD_READ);<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; else if =
(filter_type =3D=3D ITV_FILTER_TYPE_ADAPTIVE)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((tmp_filter_state =
=3D=3D STATE_ON) &amp;&amp; (tmp_filter_type =3D=3D =
ITV_VALUE_FLK_NUM_ONE_POINT))<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*filter_state =3D =
STATE_ON;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
else<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*filter_state =3D =
STATE_OFF;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value =3D =
access_integrated_tv_regs(ITV_REG_ID_DE_FLK_THRESHOLD, 0, =
ITV_CMD_READ);<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; =
disable_integrated_tv_shadow_reg();<BR>+<BR>+&nbsp;&nbsp;&nbsp; return =
value;<BR>+}<BR>+<BR>+<BR>+<BR>+void get_integrated_tv_pos(u32* =
current_hpos, u32* =
current_vpos)<BR>+{&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; =
enable_integrated_tv_shadow_reg();<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
*current_hpos =3D access_integrated_tv_regs(ITV_REG_ID_DST_HSD, 0, =
ITV_CMD_READ);<BR>+&nbsp;&nbsp;&nbsp; *current_vpos =3D =
access_integrated_tv_regs(ITV_REG_ID_DST_VSD, 0, =
ITV_CMD_READ);<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
disable_integrated_tv_shadow_reg();<BR>+}<BR>+<BR>+<BR>+void =
set_integrated_tv_ffilter_status(int filter_type, int filter_on_off, u32 =
desired_value)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; =
enable_integrated_tv_shadow_reg();<BR>+<BR>+&nbsp;&nbsp;&nbsp; if =
(filter_type =3D=3D ITV_FILTER_TYPE_NORMAL)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (filter_on_off =
=3D=3D ITV_FILTER_ON)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Turn on FFilter: =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 access_integrated_tv_regs(ITV_REG_ID_DE_FLICKER_ENABLE, =
ITV_VALUE_ENABLE, =
ITV_CMD_WRITE);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; access_integrated_tv_regs(ITV_REG_ID_DF_TYPE, =
ITV_FILTER_TYPE_NORMAL, =
ITV_CMD_WRITE);<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; /* Set the weighting of FFilter : =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 if (desired_value &lt; =
0)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; desired_value =3D =
0;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; if (desired_value &gt; =
tv_setting_info.FFilterLevel)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; desired_value =3D =
tv_setting_info.FFilterLevel;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; access_integrated_tv_regs(ITV_REG_ID_DF_WT_SEL, desired_value, =
ITV_CMD_WRITE);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_setting_info.CurrentFFilter =3D =
desired_value;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
else<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Turn off FFilter: =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 access_integrated_tv_regs(ITV_REG_ID_DE_FLICKER_ENABLE, =
ITV_VALUE_DISABLE, =
ITV_CMD_WRITE);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; else if (filter_type =
=3D=3D ITV_FILTER_TYPE_ADAPTIVE)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (filter_on_off =
=3D=3D ITV_FILTER_ON)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Turn on AFFilter: =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 access_integrated_tv_regs(ITV_REG_ID_DE_FLICKER_ENABLE, =
ITV_VALUE_ENABLE, =
ITV_CMD_WRITE);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; access_integrated_tv_regs(ITV_REG_ID_DE_FLK_NUM, =
ITV_VALUE_FLK_NUM_ONE_POINT, =
ITV_CMD_WRITE);<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; /* Set threshold of AFFilter : =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 if (desired_value &lt; =
0)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; desired_value =3D =
0;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
if (desired_value &gt; =
tv_setting_info.AFFilterLevel)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; desired_value =3D =
tv_setting_info.AFFilterLevel;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; access_integrated_tv_regs(ITV_REG_ID_DE_FLK_THRESHOLD, =
desired_value, =
ITV_CMD_WRITE);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
else<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Turn off AFFilter: =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 access_integrated_tv_regs(ITV_REG_ID_DE_FLK_NUM, =
ITV_VALUE_FLK_NUM_WHOLE_IMAGE, =
ITV_CMD_WRITE);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; access_integrated_tv_regs(ITV_REG_ID_DE_FLK_THRESHOLD, 0, =
ITV_CMD_WRITE);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; access_integrated_tv_regs(ITV_REG_ID_DE_FLICKER_ENABLE, =
ITV_VALUE_DISABLE, =
ITV_CMD_WRITE);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; }<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
disable_integrated_tv_shadow_reg();<BR>+}<BR>+<BR>+<BR>+void =
set_integrated_tv_hue(u32 desired_value)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; =
enable_integrated_tv_shadow_reg();<BR>+&nbsp;&nbsp;&nbsp; =
access_integrated_tv_regs(ITV_REG_ID_HUE, desired_value, =
ITV_CMD_WRITE);<BR>+&nbsp;&nbsp;&nbsp; tv_setting_info.CurrentTINT =3D =
desired_value;<BR>+&nbsp;&nbsp;&nbsp; =
disable_integrated_tv_shadow_reg();<BR>+}<BR>+<BR>+<BR>+void =
set_integrated_tv_brightness(u32 =
desired_value)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; =
enable_integrated_tv_shadow_reg();<BR>+&nbsp;&nbsp;&nbsp; =
access_integrated_tv_regs(ITV_REG_ID_BLACK_LEVEL, desired_value, =
ITV_CMD_WRITE);<BR>+&nbsp;&nbsp;&nbsp; tv_setting_info.CurrentBrightness =
=3D desired_value;<BR>+&nbsp;&nbsp;&nbsp; =
disable_integrated_tv_shadow_reg();<BR>+}<BR>+<BR>+<BR>+void =
set_integrated_tv_contrast(u32 =
desired_value)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; =
enable_integrated_tv_shadow_reg();<BR>+&nbsp;&nbsp;&nbsp; =
access_integrated_tv_regs(ITV_REG_ID_CONTRAST, desired_value, =
ITV_CMD_WRITE);<BR>+&nbsp;&nbsp;&nbsp; tv_setting_info.CurrentContrast =
=3D desired_value;<BR>+&nbsp;&nbsp;&nbsp; =
disable_integrated_tv_shadow_reg();<BR>+}<BR>+<BR>+<BR>+void =
set_integrated_tv_saturation(u32 =
desired_value)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; =
enable_integrated_tv_shadow_reg();<BR>+&nbsp;&nbsp;&nbsp; =
access_integrated_tv_regs(ITV_REG_ID_SATURATION, desired_value, =
ITV_CMD_WRITE);<BR>+&nbsp;&nbsp;&nbsp; tv_setting_info.CurrentSaturation =
=3D desired_value;<BR>+&nbsp;&nbsp;&nbsp; =
disable_integrated_tv_shadow_reg();<BR>+}<BR>+<BR>+<BR>+void =
set_integrated_tv_pos(u32 desired_hpos, u32 =
desired_vpos)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; u32 dst_hpos, =
dst_vpos;<BR>+&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; =
enable_integrated_tv_shadow_reg();<BR>+<BR>+&nbsp;&nbsp;&nbsp; dst_hpos =
=3D access_integrated_tv_regs(ITV_REG_ID_DST_HSD, 0, =
ITV_CMD_READ);<BR>+&nbsp;&nbsp;&nbsp; dst_vpos =3D =
access_integrated_tv_regs(ITV_REG_ID_DST_VSD, 0, =
ITV_CMD_READ);<BR>+<BR>+&nbsp;&nbsp;&nbsp; dst_hpos =3D dst_hpos + =
(desired_hpos - =
tv_setting_info.CurrentPositionH);<BR>+&nbsp;&nbsp;&nbsp; dst_vpos =3D =
dst_vpos - (desired_vpos - =
tv_setting_info.CurrentPositionV);<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
access_integrated_tv_regs(ITV_REG_ID_DST_HSD, dst_hpos, =
ITV_CMD_WRITE);<BR>+&nbsp;&nbsp;&nbsp; =
access_integrated_tv_regs(ITV_REG_ID_DST_VSD, dst_vpos, =
ITV_CMD_WRITE);<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
tv_setting_info.CurrentPositionH =3D =
desired_hpos;<BR>+&nbsp;&nbsp;&nbsp; tv_setting_info.CurrentPositionV =
=3D desired_vpos;<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
disable_integrated_tv_shadow_reg();<BR>+}<BR>+<BR>+<BR>+void =
set_integrated_tv_size(u32 desired_hsize, u32 desired_vsize)<BR>+{ =
<BR>+&nbsp;&nbsp;&nbsp; u32 dst_hsize, dst_vsize;<BR>+&nbsp;&nbsp;&nbsp; =
DEBUG_MSG("set integrated TV H:%d V:%d", desired_hsize, =
desired_vsize);<BR>+&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; =
enable_integrated_tv_shadow_reg();<BR>+&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; dst_hsize =3D =
access_integrated_tv_regs(ITV_REG_ID_DST_HSIZE, 0, =
ITV_CMD_READ);<BR>+&nbsp;&nbsp;&nbsp; dst_vsize =3D =
access_integrated_tv_regs(ITV_REG_ID_DST_VSIZE, 0, =
ITV_CMD_READ);<BR>+<BR>+&nbsp;&nbsp;&nbsp; dst_hsize =3D dst_hsize + =
tv_setting_info.ScalDegreeH * (desired_hsize - =
tv_setting_info.CurrentScalH);<BR>+&nbsp;&nbsp;&nbsp; dst_vsize =3D =
dst_vsize + tv_setting_info.ScalDegreeV * (desired_vsize - =
tv_setting_info.CurrentScalV);<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
access_integrated_tv_regs(ITV_REG_ID_DST_HSIZE, dst_hsize, =
ITV_CMD_WRITE);<BR>+&nbsp;&nbsp;&nbsp; =
access_integrated_tv_regs(ITV_REG_ID_DST_VSIZE, dst_vsize, =
ITV_CMD_WRITE);<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Update scaling factor: =
*/<BR>+&nbsp;&nbsp;&nbsp; =
update_scaling_factor();<BR>+&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; =
tv_setting_info.CurrentScalH =3D desired_hsize;<BR>+&nbsp;&nbsp;&nbsp; =
tv_setting_info.CurrentScalV =3D desired_vsize;<BR>+&nbsp;&nbsp;&nbsp; =
disable_integrated_tv_shadow_reg();<BR>+}<BR>+<BR>+<BR>+int =
integrated_tv_sense(void)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; u8 cr30, cr37, =
cr43, rgb_dac_status;<BR>+&nbsp;&nbsp;&nbsp; u32 tv3f, rgb_status, =
tv_encoder_status, dac_status;<BR>+&nbsp;&nbsp;&nbsp; int =
sense_status;<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
enable_integrated_tv_shadow_reg();<BR>+<BR>+&nbsp;&nbsp;&nbsp; if =
(g_first_time_to_sense)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set TV mode =
(arbitrary) at least once before sense TV. =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_integrated_tv_general_table(ITV_INIT_TABLE_OFFSET, =
ITV_INIT_TABLE_VALUE);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_integrated_tv_general_table(ITV_MODE_TABLE_OFFSET, =
ITV_MODE_TABLE_NTSC_640x480);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; g_first_time_to_sense =3D FALSE;<BR>+&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Saved for restore later: =
*/<BR>+&nbsp;&nbsp;&nbsp; cr30 =3D read_reg(VIACR, =
CR30);<BR>+&nbsp;&nbsp;&nbsp; cr37 =3D read_reg(VIACR, =
CR37);<BR>+&nbsp;&nbsp;&nbsp; cr43 =3D read_reg(VIACR, =
CR43);<BR>+&nbsp;&nbsp;&nbsp; rgb_dac_status =3D read_reg(VIASR, =
SR5E);<BR>+&nbsp;&nbsp;&nbsp; tv3f =3D =
access_integrated_tv_regs(ITV_REG_ID_TV_SENSE_DATA, 0, =
ITV_CMD_READ);<BR>+&nbsp;&nbsp;&nbsp; tv_encoder_status =3D =
access_integrated_tv_regs(ITV_REG_ID_TV_ENABLE, 0, =
ITV_CMD_READ);<BR>+&nbsp;&nbsp;&nbsp; dac_status =3D =
access_integrated_tv_regs(ITV_REG_ID_PRI_DAC_SEL, 0, =
ITV_CMD_READ);<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* To sense TV, we should: =
*/<BR>+&nbsp;&nbsp;&nbsp; /* 1. Set CR30[4:3]=3D01, CR37[2:0]=3D100, =
CR37[3]=3D0, CR43[5:4]=3D01 and TV.3F[7:0]=3D42h. =
*/<BR>+&nbsp;&nbsp;&nbsp; /* 2. Enable TV DAC R/G/B. =
*/<BR>+&nbsp;&nbsp;&nbsp; /* 3. Enable TV encoder. =
*/<BR>+&nbsp;&nbsp;&nbsp; /* 4. Change primary DAC to TV. =
*/<BR>+&nbsp;&nbsp;&nbsp; write_reg_mask(CR30, VIACR, BIT3, =
BIT4+BIT3);<BR>+&nbsp;&nbsp;&nbsp; write_reg_mask(CR37, VIACR, BIT2, =
BIT3+BIT2+BIT1+BIT0);<BR>+&nbsp;&nbsp;&nbsp; write_reg_mask(CR43, VIACR, =
BIT4, BIT5+BIT4);<BR>+&nbsp;&nbsp;&nbsp; write_reg_mask(SR5E, VIASR, 0, =
BIT3+BIT2+BIT1);<BR>+&nbsp;&nbsp;&nbsp; =
access_integrated_tv_regs(ITV_REG_ID_TV_SENSE_DATA, 0x42, =
ITV_CMD_WRITE);<BR>+&nbsp;&nbsp;&nbsp; =
access_integrated_tv_regs(ITV_REG_ID_TV_ENABLE, ITV_VALUE_ENABLE, =
ITV_CMD_WRITE);<BR>+&nbsp;&nbsp;&nbsp; =
access_integrated_tv_regs(ITV_REG_ID_PRI_DAC_SEL, ITV_VALUE_DAC_FOR_TV, =
ITV_CMD_WRITE);<BR>+&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; /* Start =
to sense: */<BR>+&nbsp;&nbsp;&nbsp; =
access_integrated_tv_regs(ITV_REG_ID_TV_SENSE, ITV_VALUE_MANUAL_SENSE, =
ITV_CMD_WRITE);<BR>+&nbsp;&nbsp;&nbsp; =
access_integrated_tv_regs(ITV_REG_ID_TV_SENSE, ITV_VALUE_NO_SENSE, =
ITV_CMD_WRITE);<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Restore: =
*/<BR>+&nbsp;&nbsp;&nbsp; =
access_integrated_tv_regs(ITV_REG_ID_PRI_DAC_SEL, dac_status, =
ITV_CMD_WRITE);<BR>+&nbsp;&nbsp;&nbsp; =
access_integrated_tv_regs(ITV_REG_ID_TV_ENABLE, tv_encoder_status, =
ITV_CMD_WRITE);<BR>+&nbsp;&nbsp;&nbsp; =
access_integrated_tv_regs(ITV_REG_ID_TV_SENSE_DATA, tv3f, =
ITV_CMD_WRITE);<BR>+&nbsp;&nbsp;&nbsp; write_reg(CR30, VIACR, =
cr30);<BR>+&nbsp;&nbsp;&nbsp; write_reg(CR37, VIACR, =
cr37);<BR>+&nbsp;&nbsp;&nbsp; write_reg(CR43, VIACR, =
cr43);<BR>+&nbsp;&nbsp;&nbsp; write_reg(SR5E, VIASR, =
rgb_dac_status);<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Get sense result: =
*/&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; sense_status =3D =
access_integrated_tv_regs(ITV_REG_ID_TV_SENSE_STATUS, 0, =
ITV_CMD_READ);<BR>+&nbsp;&nbsp;&nbsp; rgb_status =3D =
access_integrated_tv_regs(ITV_REG_ID_TV_SENSE_RGB_STATUS, 0, =
ITV_CMD_READ);<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Check connected TV output: =
*/<BR>+&nbsp;&nbsp;&nbsp; if =
(!tv_setting_info.out_signal)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
switch(rgb_status)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case ITV_VALUE_DAC_R | =
ITV_VALUE_DAC_G:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; tv_setting_info.out_signal=3D =
TV_OUTPUT_SVIDEO;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; case =
ITV_VALUE_DAC_B:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; tv_setting_info.out_signal =3D =
TV_OUTPUT_COMPOSITE;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; case ITV_VALUE_DAC_R | ITV_VALUE_DAC_G | =
ITV_VALUE_DAC_B:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; tv_setting_info.out_signal =3D =
TV_OUTPUT_RGB;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; =
default:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; tv_setting_info.out_signal =3D =
TV_OUTPUT_COMPOSITE;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; }<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; }<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
disable_integrated_tv_shadow_reg();<BR>+<BR>+&nbsp;&nbsp;&nbsp; return =
sense_status;<BR>+}<BR>+<BR>+<BR>+int =
init_integrated_tv_regs(void)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; u32 mask =3D =
0x1FFFFFF0;&nbsp; /* [28:4] */<BR>+&nbsp;&nbsp;&nbsp; u32 =
buf_start_address;<BR>+&nbsp;&nbsp;&nbsp; u32 buffer_size =3D =
0x80000;<BR>+&nbsp;&nbsp;&nbsp; u8&nbsp; offset =3D =
0;<BR>+&nbsp;&nbsp;&nbsp; unsigned char* mmio_base;<BR>+<BR>+#if =
LINUX_VERSION_CODE &lt; KERNEL_VERSION(2,5,0)<BR>+&nbsp;&nbsp;&nbsp; =
buf_start_address =3D viafbinfo.memsize - =
INTEGRATED_TV_BUFFER_SIZE;<BR>+&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; viafbinfo.integrated_tv_map_base =3D (unsigned =
int)ioremap_nocache(viafbinfo.mmio_base&nbsp; + =
VIA_MMIO_INTEGRATED_TV_BASE, =
VIA_MMIO_INTEGRATED_TV_SIZE);<BR>+<BR>+&nbsp;&nbsp;&nbsp; if =
(!viafbinfo.integrated_tv_map_base)<BR>+&nbsp;&nbsp;&nbsp; =
{&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
FAIL;<BR>+&nbsp;&nbsp;&nbsp; }<BR>+<BR>+&nbsp;&nbsp;&nbsp; mmio_base =3D =
(unsigned =
char*)viafbinfo.integrated_tv_map_base;<BR>+#else<BR>+&nbsp;&nbsp;&nbsp; =
buf_start_address =3D parinfo.fbmem_free - =
INTEGRATED_TV_BUFFER_SIZE;<BR>+&nbsp;&nbsp;&nbsp; parinfo.fbmem_free =3D =
parinfo.fbmem_free - INTEGRATED_TV_BUFFER_SIZE;<BR>+&nbsp;&nbsp;&nbsp; =
parinfo.fbmem_used +=3D INTEGRATED_TV_BUFFER_SIZE;<BR>+<BR>+#if =
LINUX_VERSION_CODE &gt; KERNEL_VERSION(2,6,8)<BR>+&nbsp;&nbsp;&nbsp; =
parinfo.integrated_tv_map_base =3D ioremap_nocache(parinfo.mmio_base + =
VIA_MMIO_INTEGRATED_TV_BASE, =
VIA_MMIO_INTEGRATED_TV_SIZE);<BR>+#else<BR>+&nbsp;&nbsp;&nbsp; =
parinfo.integrated_tv_map_base =3D (unsigned =
int)ioremap_nocache(parinfo.mmio_base + VIA_MMIO_INTEGRATED_TV_BASE, =
VIA_MMIO_INTEGRATED_TV_SIZE);<BR>+#endif<BR>+<BR>+&nbsp;&nbsp;&nbsp; if =
(!parinfo.integrated_tv_map_base)<BR>+&nbsp;&nbsp;&nbsp; =
{&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
FAIL;<BR>+&nbsp;&nbsp;&nbsp; }<BR>+<BR>+&nbsp;&nbsp;&nbsp; mmio_base =3D =
(unsigned =
char*)parinfo.integrated_tv_map_base;<BR>+#endif<BR>+<BR>+&nbsp;&nbsp;&nb=
sp; enable_integrated_tv_shadow_reg();<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* =
Clear all: */<BR>+&nbsp;&nbsp;&nbsp; while (offset &lt; =
0xF0)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_integrated_tv_reg32(mmio_base, offset, =
0);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset =3D offset + =
4;<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; /* Write Source Buffer 0~3 Base Address: =
*/<BR>+&nbsp;&nbsp;&nbsp; write_integrated_tv_reg_mask32(mmio_base, =
0x04, mask, buf_start_address);<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
buf_start_address =3D buf_start_address + =
buffer_size;<BR>+&nbsp;&nbsp;&nbsp; =
write_integrated_tv_reg_mask32(mmio_base, 0x08, mask, =
buf_start_address);<BR>+<BR>+&nbsp;&nbsp;&nbsp; buf_start_address =3D =
buf_start_address + buffer_size;<BR>+&nbsp;&nbsp;&nbsp; =
write_integrated_tv_reg_mask32(mmio_base, 0x0C, mask, =
buf_start_address);<BR>+<BR>+&nbsp;&nbsp;&nbsp; buf_start_address =3D =
buf_start_address + buffer_size;<BR>+&nbsp;&nbsp;&nbsp; =
write_integrated_tv_reg_mask32(mmio_base, 0x10, mask, =
buf_start_address);<BR>+&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; /* =
Write Destination Even and Odd Buffer Base Address: =
*/<BR>+&nbsp;&nbsp;&nbsp; buf_start_address =3D buf_start_address + =
buffer_size;<BR>+&nbsp;&nbsp;&nbsp; =
write_integrated_tv_reg_mask32(mmio_base, 0x2C, mask, =
buf_start_address);<BR>+<BR>+&nbsp;&nbsp;&nbsp; buf_start_address =3D =
buf_start_address + buffer_size;<BR>+&nbsp;&nbsp;&nbsp; =
write_integrated_tv_reg_mask32(mmio_base, 0x30, mask, =
buf_start_address);<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Other initialize: =
*/<BR>+&nbsp;&nbsp;&nbsp; =
write_integrated_tv_general_table(ITV_INIT_TABLE_OFFSET, =
ITV_INIT_TABLE_VALUE);<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
disable_integrated_tv_shadow_reg();<BR>+<BR>+&nbsp;&nbsp;&nbsp; return =
OK;<BR>+}<BR>+<BR>+<BR>+int =
integrated_tv_encoder_identify(void)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; if =
(chip_info.gfx_chip_name =3D=3D UNICHROME_CX700)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
OK;<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; =
else<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
FAIL;<BR>+&nbsp;&nbsp;&nbsp; }<BR>+}<BR>+<BR>diff -Nur =
linux-2.6.21-rc7/drivers/video/via/IntegratedTV.h =
linux-2.6.21-rc7.viafb/drivers/video/via/IntegratedTV.h<BR>--- =
linux-2.6.21-rc7/drivers/video/via/IntegratedTV.h&nbsp;1969-12-31 =
19:00:00.000000000 -0500<BR>+++ =
linux-2.6.21-rc7.viafb/drivers/video/via/IntegratedTV.h&nbsp;2007-04-26 =
19:52:32.000000000 -0400<BR>@@ -0,0 +1,107 @@<BR>+/*<BR>+ * Copyright =
1998-2007 VIA Technologies, Inc. All Rights Reserved.<BR>+ * Copyright =
2001-2007 S3 Graphics, Inc. All Rights Reserved.<BR>+ *<BR>+ * =
Permission is hereby granted, free of charge, to any person obtaining =
a<BR>+ * copy of this software and associated documentation files (the =
"Software"),<BR>+ * to deal in the Software without restriction, =
including without limitation<BR>+ * the rights to use, copy, modify, =
merge, publish, distribute, sub license,<BR>+ * and/or sell copies of =
the Software, and to permit persons to whom the<BR>+ * Software is =
furnished to do so, subject to the following conditions:<BR>+ *<BR>+ * =
The above copyright notice and this permission notice (including =
the<BR>+ * next paragraph) shall be included in all copies or =
substantial portions<BR>+ * of the Software.<BR>+ *<BR>+ * THE SOFTWARE =
IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR<BR>+ * =
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF =
MERCHANTABILITY,<BR>+ * FITNESS FOR A PARTICULAR PURPOSE AND =
NON-INFRINGEMENT. IN NO EVENT SHALL<BR>+ * THE AUTHOR(S) OR COPYRIGHT =
HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR<BR>+ * OTHER LIABILITY, =
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,<BR>+ * ARISING =
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER<BR>+ =
* DEALINGS IN THE SOFTWARE.<BR>+ */<BR>+<BR>+#ifndef =
_INTEGRATEDTV_H_<BR>+#define _INTEGRATEDTV_H_ 1<BR>+<BR>+<BR>+/* =
Registers IDs: */<BR>+/* The definition value has 4 bits: 2 bits IO =
address + 2 bits offset. */<BR>+/* ex. 0x0018 means bits 18 of IO =
Address 00, it is TV source selection. */<BR>+#define =
ITV_REG_ID_PK_ENABLE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0000&nbsp;&nbsp;&nbsp; /* PK enable. */<BR>+#define =
ITV_REG_ID_SRC_SEL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; 0x0018&nbsp;&nbsp;&nbsp; /* Source from IGA1 or =
IGA2. */<BR>+#define =
ITV_REG_ID_SW_RESET&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 0x0020&nbsp;&nbsp;&nbsp; /* SW reset. */<BR>+#define =
ITV_REG_ID_SYNC_BUF_MODE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x0030&nbsp;&nbsp;&nbsp; /* Synchronous mode. */<BR>+#define =
ITV_REG_ID_SD_ENABLE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0031&nbsp;&nbsp;&nbsp; /* Scaler and Deflicker enable. =
*/<BR>+#define =
ITV_REG_ID_SRC_VSIZE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x1800&nbsp;&nbsp;&nbsp; /* Source image vertical pixels. =
*/<BR>+#define =
ITV_REG_ID_SRC_HSIZE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x1811&nbsp;&nbsp;&nbsp; /* Source image horizontal =
pixels. */<BR>+#define =
ITV_REG_ID_DE_FLK_THRESHOLD&nbsp;&nbsp;&nbsp;&nbsp; =
0x2011&nbsp;&nbsp;&nbsp; /* Adative flicker filter threshold. =
*/<BR>+#define =
ITV_REG_ID_SCL_VFAC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 0x2400&nbsp;&nbsp;&nbsp; /* Vertical scaling factor. =
*/<BR>+#define =
ITV_REG_ID_DE_FLK_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 0x2413&nbsp;&nbsp;&nbsp; /* Adative flicker filter. =
*/<BR>+#define =
ITV_REG_ID_DF_WT_SEL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x2414&nbsp;&nbsp;&nbsp; /* De-flicker weighting =
selection. */<BR>+#define =
ITV_REG_ID_DF_TYPE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; 0x2415&nbsp;&nbsp;&nbsp; /* De-flicker type. =
*/<BR>+#define =
ITV_REG_ID_SCL_HFAC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 0x2416&nbsp;&nbsp;&nbsp; /* Horizontal scaling =
factor. */<BR>+#define ITV_REG_ID_DE_FLICKER_ENABLE&nbsp;&nbsp;&nbsp; =
0x2429&nbsp;&nbsp;&nbsp; /* De-flicker enable. */<BR>+#define =
ITV_REG_ID_DST_VSIZE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x2800&nbsp;&nbsp;&nbsp; /* Destination image vertical =
pixels. */<BR>+#define =
ITV_REG_ID_DST_HSIZE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x2811&nbsp;&nbsp;&nbsp; /* Destination image horizontal =
pixels. */<BR>+#define =
ITV_REG_ID_TV_ENABLE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x3800&nbsp;&nbsp;&nbsp; /* TV enable. */<BR>+#define =
ITV_REG_ID_OUTPUT_SEL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 0x3828&nbsp;&nbsp;&nbsp; /* TV DAC output selection. =
*/<BR>+#define =
ITV_REG_ID_TV_SENSE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 0x3C14&nbsp;&nbsp;&nbsp; /* TV sense enable. =
*/<BR>+#define =
ITV_REG_ID_TV_SENSE_DATA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x3C24&nbsp;&nbsp;&nbsp; /* TV sense data. */<BR>+#define =
ITV_REG_ID_DST_HSD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; 0x4821&nbsp;&nbsp;&nbsp; /* Destination image =
horizontal start display */<BR>+#define =
ITV_REG_ID_DST_VSD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; 0x4C23&nbsp;&nbsp;&nbsp; /* Destination image =
vertical start display */<BR>+#define =
ITV_REG_ID_SATURATION&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 0x5000&nbsp;&nbsp;&nbsp; /* Saturation adjustment. =
*/<BR>+#define =
ITV_REG_ID_CONTRAST&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 0x5400&nbsp;&nbsp;&nbsp; /* Contrast adjustment. =
*/<BR>+#define =
ITV_REG_ID_BLACK_LEVEL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 0x5423&nbsp;&nbsp;&nbsp; /* Brightness adjustment. */<BR>+#define =
ITV_REG_ID_HUE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x6000&nbsp;&nbsp;&nbsp; /* =
Hue adjustment. */<BR>+#define =
ITV_REG_ID_PRI_DAC_SEL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 0x6C12&nbsp;&nbsp;&nbsp; /* Primary DAC for CRT or TV. =
*/<BR>+#define ITV_REG_ID_TV_SENSE_STATUS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0xE402&nbsp;&nbsp;&nbsp; /* TV sense status. */<BR>+#define =
ITV_REG_ID_PBPR_BLANK_LEVEL&nbsp;&nbsp;&nbsp;&nbsp; =
0xE800&nbsp;&nbsp;&nbsp; /* Blank Level for Pb and Pr. For VT3324 A3. =
*/<BR>+#define ITV_REG_ID_TV_SENSE_RGB_STATUS&nbsp; =
0xE828&nbsp;&nbsp;&nbsp; /* TV sense R/G/B status. */<BR>+<BR>+#define =
ITV_CMD_READ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<BR>+#define =
ITV_CMD_WRITE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 1<BR>+<BR>+#define =
ITV_VALUE_DISABLE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 0<BR>+#define =
ITV_VALUE_ENABLE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 1<BR>+<BR>+#define =
ITV_VALUE_SRC_FROM_IGA1&nbsp;&nbsp;&nbsp;&nbsp; 0<BR>+#define =
ITV_VALUE_SRC_FROM_IGA2&nbsp;&nbsp;&nbsp;&nbsp; 1<BR>+<BR>+#define =
ITV_VALUE_DAC_FOR_CRT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<BR>+#define =
ITV_VALUE_DAC_FOR_TV&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1<BR>+<BR>+#define =
ITV_VALUE_OUTPUT_SC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00&nbsp;&nbsp;&nbsp; /* S-Video or Composite */<BR>+#define =
ITV_VALUE_OUTPUT_RGB&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x02&nbsp;&nbsp;&nbsp; /* RGB */<BR>+#define =
ITV_VALUE_OUTPUT_YPbPr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x03&nbsp;&nbsp;&nbsp; /* YPbPr */<BR>+<BR>+#define =
ITV_VALUE_FLK_NUM_WHOLE_IMAGE&nbsp;&nbsp; 0<BR>+#define =
ITV_VALUE_FLK_NUM_ONE_POINT&nbsp;&nbsp;&nbsp;&nbsp; 1<BR>+<BR>+#define =
ITV_VALUE_NO_SENSE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00<BR>+#define ITV_VALUE_MANUAL_SENSE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x02<BR>+#define =
ITV_VALUE_AUTO_SENSE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x03<BR>+<BR>+#define ITV_VALUE_TV_UNCONNECTED&nbsp;&nbsp;&nbsp; =
0<BR>+#define ITV_VALUE_TV_CONNECTED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1<BR>+<BR>+#define =
ITV_VALUE_DAC_R&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 4<BR>+#define =
ITV_VALUE_DAC_G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 2<BR>+#define =
ITV_VALUE_DAC_B&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 1<BR>+<BR>+#define =
ITV_FILTER_TYPE_NORMAL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<BR>+#define =
ITV_FILTER_TYPE_IIR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1<BR>+#define ITV_FILTER_TYPE_ADAPTIVE&nbsp;&nbsp;&nbsp; 2<BR>+#define =
ITV_FILTER_TYPE_NONE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
3<BR>+<BR>+#define =
ITV_FILTER_OFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 0<BR>+#define =
ITV_FILTER_ON&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 1<BR>+<BR>+#define =
INTEGRATED_TV_BUFFER_SIZE&nbsp;&nbsp; 0x300000&nbsp;&nbsp;&nbsp;&nbsp; =
/* bytes */ /* We reserve 3MB now. */<BR>+<BR>+#define =
VIA_MMIO_INTEGRATED_TV_BASE 0xC000<BR>+#define =
VIA_MMIO_INTEGRATED_TV_SIZE 256<BR>+<BR>+#endif<BR>+<BR>diff -Nur =
linux-2.6.21-rc7/drivers/video/via/ioctl.c =
linux-2.6.21-rc7.viafb/drivers/video/via/ioctl.c<BR>--- =
linux-2.6.21-rc7/drivers/video/via/ioctl.c&nbsp;1969-12-31 =
19:00:00.000000000 -0500<BR>+++ =
linux-2.6.21-rc7.viafb/drivers/video/via/ioctl.c&nbsp;2007-04-26 =
19:52:32.000000000 -0400<BR>@@ -0,0 +1,213 @@<BR>+/*<BR>+ * Copyright =
1998-2007 VIA Technologies, Inc. All Rights Reserved.<BR>+ * Copyright =
2001-2007 S3 Graphics, Inc. All Rights Reserved.<BR>+ *<BR>+ * =
Permission is hereby granted, free of charge, to any person obtaining =
a<BR>+ * copy of this software and associated documentation files (the =
"Software"),<BR>+ * to deal in the Software without restriction, =
including without limitation<BR>+ * the rights to use, copy, modify, =
merge, publish, distribute, sub license,<BR>+ * and/or sell copies of =
the Software, and to permit persons to whom the<BR>+ * Software is =
furnished to do so, subject to the following conditions:<BR>+ *<BR>+ * =
The above copyright notice and this permission notice (including =
the<BR>+ * next paragraph) shall be included in all copies or =
substantial portions<BR>+ * of the Software.<BR>+ *<BR>+ * THE SOFTWARE =
IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR<BR>+ * =
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF =
MERCHANTABILITY,<BR>+ * FITNESS FOR A PARTICULAR PURPOSE AND =
NON-INFRINGEMENT. IN NO EVENT SHALL<BR>+ * THE AUTHOR(S) OR COPYRIGHT =
HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR<BR>+ * OTHER LIABILITY, =
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,<BR>+ * ARISING =
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER<BR>+ =
* DEALINGS IN THE SOFTWARE.<BR>+ */<BR>+<BR>+#include =
&lt;linux/fb.h&gt;<BR>+#include &lt;asm/uaccess.h&gt;<BR>+<BR>+#include =
"viafbdev.h"<BR>+#include "chip.h"<BR>+#include "debug.h"<BR>+#include =
"ioctl.h"<BR>+#include "share.h"<BR>+<BR>+extern int =
dvi_sense(void);<BR>+extern int tv_sense(void);<BR>+extern int =
tv_auto_sense(void);<BR>+extern inline u8 read_reg(int io_port, u8 =
index);<BR>+<BR>+extern struct =
chip_information&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
chip_info;<BR>+extern struct tv_setting_information&nbsp;&nbsp;&nbsp; =
tv_setting_info;<BR>+extern struct =
viafb_info&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; viafbinfo;<BR>+extern int CRT_ON, TV_ON, =
DVI_ON, LCD_ON;<BR>+extern int DeviceStatus;<BR>+extern int =
HotPlug_TV;<BR>+extern int refresh;<BR>+<BR>+int HotPlug_Xres =3D 640, =
HotPlug_Yres =3D 480, HotPlug_bpp =3D 32, HotPlug_refresh =3D 60, =
HotPlug_TVType =3D TVTYPE_NTSC;<BR>+<BR>+int ioctl_get_viafb_info(u_long =
arg)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; struct viafb_ioctl_info =
viainfo;<BR>+<BR>+&nbsp;&nbsp;&nbsp; viainfo.viafb_id&nbsp;&nbsp;&nbsp; =
=3D VIAID;<BR>+&nbsp;&nbsp;&nbsp; viainfo.vendor_id&nbsp;&nbsp; =3D =
PCI_VIA_VENDOR_ID;<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
switch(chip_info.gfx_chip_name) =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
UNICHROME_CLE266:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; viainfo.device_id =3D =
UNICHROME_CLE266_DID;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; =
break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
UNICHROME_K400:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; viainfo.device_id =3D =
UNICHROME_K400_DID;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; =
break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
UNICHROME_K800:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; viainfo.device_id =3D =
UNICHROME_K800_DID;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; =
break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
UNICHROME_P880:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; viainfo.device_id =3D =
UNICHROME_P880_DID;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; =
break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
UNICHROME_CN900:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; viainfo.device_id =3D =
UNICHROME_CN900_DID;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; <BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Add for VT3324. =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
UNICHROME_CX700:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; viainfo.device_id =3D =
UNICHROME_CX700_DID;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; =
break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Add for =
VT3327 VT3336 VT3364 */<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
UNICHROME_K8M890:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; viainfo.device_id =3D =
UNICHROME_K8M890_DID;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; =
break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
UNICHROME_P4M890:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; viainfo.device_id =3D =
UNICHROME_P4M890_DID;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; =
break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
UNICHROME_P4M900:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; viainfo.device_id =3D =
UNICHROME_P4M900_DID;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<BR>+&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; viainfo.version =3D =
VERSION_MAJOR;<BR>+&nbsp;&nbsp;&nbsp; viainfo.revision =3D =
VERSION_MINOR;<BR>+<BR>+&nbsp;&nbsp;&nbsp; if(copy_to_user((void __user =
*)arg, &amp;viainfo, sizeof(viainfo))) =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
-EFAULT;<BR>+&nbsp;&nbsp;&nbsp; }<BR>+<BR>+&nbsp;&nbsp;&nbsp; return =
0;<BR>+}<BR>+<BR>+/* Hot-Plug Priority: DVI &gt; TV &gt; CRT */<BR>+int =
ioctl_hotplug(int hres, int vres, int bpp)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; =
int TVsense, DVIsense, status =3D 0;<BR>+&nbsp;&nbsp;&nbsp; u8&nbsp; =
TVType =3D 0;<BR>+<BR>+&nbsp;&nbsp;&nbsp; DEBUG_MSG(KERN_INFO =
"ioctl_hotplug!!\n");<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
if(chip_info.tmds_chip_info.tmds_chip_name !=3D NON_TMDS_TRANSMITTER) =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DVIsense =3D =
dvi_sense();<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
if(DVIsense) =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
DEBUG_MSG(KERN_INFO "DVI =
Attached...\n");<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if(DeviceStatus !=3D DVI_Device) =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; DVI_ON =3D =
1;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; CRT_ON =3D TV_ON =3D LCD_ON =3D =
0;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(DeviceStatus =3D=3D TV_Device) =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tv_setting_info.system =
=3D =
HotPlug_TVType;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; DeviceStatus =3D =
DVI_Device;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
DeviceStatus;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
status =3D 1;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
else<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; DEBUG_MSG(KERN_INFO "DVI De-attached...\n");<BR>+&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; =
if((chip_info.tv_chip_info.tv_chip_name !=3D =
NON_TV_ENCODER)&amp;&amp;(status =3D=3D 0)) =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If TV not ON, using =
TV manual sense function.&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; If TV =
ON, using TV auto sense function. =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; This =
is avoid the display flick to use TV manual sense function when TV ON. =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(DeviceStatus !=3D =
TV_Device) =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TVsense =3D tv_sense();<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TVsense =3D =
tv_auto_sense();<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(TVsense !=3D =
TV_OUTPUT_NONE) =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
DEBUG_MSG(KERN_INFO "TV Attached: TVsense =3D %d\n", =
TVsense);<BR>+&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
if(DeviceStatus !=3D TV_Device) =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; TV_ON =3D =
1;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; CRT_ON =3D DVI_ON =3D LCD_ON =3D =
0;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HotPlug_TVType =3D =
tv_setting_info.system;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
if((chip_info.gfx_chip_name =3D=3D UNICHROME_CLE266) &amp;&amp; =
(chip_info.gfx_chip_revision =3D=3D CLE266_REVISION_AX)) =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TVType =3D =
read_reg(VIACR, 0x3C) &amp; =
0x0F;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; else =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TVType =3D =
read_reg(VIACR, 0x4E) &amp; =
0x0F;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; if(!TVType) =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tv_setting_info.system =
=3D =
TVTYPE_NTSC;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; else =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tv_setting_info.system =
=3D =
TVTYPE_PAL;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; tv_setting_info.out_signal =3D =
TVsense;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HotPlug_TV =3D =
1;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; DeviceStatus =3D =
TV_Device;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
DeviceStatus;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
status =3D 1;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
DEBUG_MSG(KERN_INFO "TV =
De-attached...\n");<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; HotPlug_TV =3D =
0;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; if((DeviceStatus !=3D =
CRT_Device)&amp;&amp;(status =3D=3D 0)) =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CRT_ON =3D =
1;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TV_ON =3D DVI_ON =3D =
LCD_ON =3D 0;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
if(DeviceStatus =3D=3D TV_Device) =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_setting_info.system =3D =
HotPlug_TVType;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DeviceStatus =3D =
CRT_Device;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
DeviceStatus;<BR>+&nbsp;&nbsp;&nbsp; }<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
return 0;<BR>+}<BR>+<BR>+int ioctl_get_tv_type(u_long =
arg)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; =
u8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TVType =3D =
0;<BR>+&nbsp;&nbsp;&nbsp; u32 __user&nbsp; *argp =3D (u32 __user =
*)arg;<BR>+<BR>+&nbsp;&nbsp;&nbsp; if((chip_info.gfx_chip_name =3D=3D =
UNICHROME_CLE266) &amp;&amp; (chip_info.gfx_chip_revision =3D=3D =
CLE266_REVISION_AX)) {<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TVType =3D read_reg(VIACR, 0x3C) &amp; 0x0F;<BR>+&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; else =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TVType =3D =
read_reg(VIACR, 0x4E) &amp; 0x0F;<BR>+&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp; return put_user((u32)TVType, =
argp);<BR>+}<BR>+<BR>diff -Nur =
linux-2.6.21-rc7/drivers/video/via/ioctl.h =
linux-2.6.21-rc7.viafb/drivers/video/via/ioctl.h<BR>--- =
linux-2.6.21-rc7/drivers/video/via/ioctl.h&nbsp;1969-12-31 =
19:00:00.000000000 -0500<BR>+++ =
linux-2.6.21-rc7.viafb/drivers/video/via/ioctl.h&nbsp;2007-04-26 =
19:52:32.000000000 -0400<BR>@@ -0,0 +1,264 @@<BR>+/*<BR>+ * Copyright =
1998-2007 VIA Technologies, Inc. All Rights Reserved.<BR>+ * Copyright =
2001-2007 S3 Graphics, Inc. All Rights Reserved.<BR>+ *<BR>+ * =
Permission is hereby granted, free of charge, to any person obtaining =
a<BR>+ * copy of this software and associated documentation files (the =
"Software"),<BR>+ * to deal in the Software without restriction, =
including without limitation<BR>+ * the rights to use, copy, modify, =
merge, publish, distribute, sub license,<BR>+ * and/or sell copies of =
the Software, and to permit persons to whom the<BR>+ * Software is =
furnished to do so, subject to the following conditions:<BR>+ *<BR>+ * =
The above copyright notice and this permission notice (including =
the<BR>+ * next paragraph) shall be included in all copies or =
substantial portions<BR>+ * of the Software.<BR>+ *<BR>+ * THE SOFTWARE =
IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR<BR>+ * =
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF =
MERCHANTABILITY,<BR>+ * FITNESS FOR A PARTICULAR PURPOSE AND =
NON-INFRINGEMENT. IN NO EVENT SHALL<BR>+ * THE AUTHOR(S) OR COPYRIGHT =
HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR<BR>+ * OTHER LIABILITY, =
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,<BR>+ * ARISING =
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER<BR>+ =
* DEALINGS IN THE SOFTWARE.<BR>+ */<BR>+<BR>+#ifndef =
__IOCTL_H__<BR>+#define __IOCTL_H__<BR>+<BR>+#ifndef __user<BR>+#define =
__user<BR>+#endif&nbsp;<BR>+<BR>+/* VIAFB IOCTL definition =
*/<BR>+#define VIAFB_GET_INFO_SIZE&nbsp;&nbsp;&nbsp;&nbsp; 0x56494101 /* =
'VIA\01' */<BR>+#define =
VIAFB_GET_INFO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x56494102 /* 'VIA\02' */<BR>+#define =
VIAFB_HOTPLUG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 0x56494103 /* 'VIA\03' */<BR>+#define VIAFB_SET_HOTPLUG_FLAG&nbsp; =
0x56494104 /* 'VIA\04' */<BR>+#define =
VIAFB_GET_RESOLUTION&nbsp;&nbsp;&nbsp; 0x56494105 /* 'VIA\05' =
*/<BR>+#define VIAFB_GET_TV_TYPE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x56494106 /* 'VIA\06' */<BR>+#define =
VIAFB_GET_SAMM_INFO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x56494107 /* =
'VIA\07' */<BR>+#define =
VIAFB_TURN_ON_OUTPUT_DEVICE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x56494108 /* 'VIA\08' */<BR>+#define =
VIAFB_TURN_OFF_OUTPUT_DEVICE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x56494109 /* 'VIA\09' */<BR>+#define =
VIAFB_SET_DEVICE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x5649410A =
<BR>+#define VIAFB_GET_DEVICE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x5649410B <BR>+#define VIAFB_SET_TV_COLOR_DEFAULT&nbsp; 0x5649410C /* =
'VIA\0C' */<BR>+#define VIAFB_SET_TV_BRIGHTNESS&nbsp;&nbsp;&nbsp;&nbsp; =
0x5649410D /* 'VIA\0D' */<BR>+#define =
VIAFB_SET_TV_CONTRAST&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x5649410E /* =
'VIA\0E' */<BR>+#define VIAFB_SET_TV_SATURATION&nbsp;&nbsp;&nbsp;&nbsp; =
0x5649410F /* 'VIA\0F' */<BR>+#define =
VIAFB_SET_TV_TINT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 0x56494110 /* 'VIA\10' */<BR>+#define =
VIAFB_SET_TV_FFILTER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x56494111 /* 'VIA\11' */<BR>+#define =
VIAFB_GET_DRIVER_VERSION&nbsp;&nbsp;&nbsp; 0x56494112 /* 'VIA\12' =
*/<BR>+#define VIAFB_GET_CHIP_INFO&nbsp;&nbsp; 0x56494113 /* 'VIA\13' =
*/<BR>+#define =
VIAFB_SET_DEVICE_INFO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x56494114 /* 'VIA\14' */<BR>+#define =
VIAFB_GET_DEVICE_INFO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x56494115 /* 'VIA\15' */<BR>+#define =
VIAFB_SET_TV_POSITION&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x56494116 <BR>+#define =
VIAFB_SET_TV_SIZE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x56494117 =
<BR>+#define =
VIAFB_GET_DEVICE_SUPPORT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; 0x56494118 <BR>+#define =
VIAFB_GET_DEVICE_CONNECT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; 0x56494119 <BR>+#define =
VIAFB_GET_PANEL_SUPPORT_EXPAND&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x5649411A =
<BR>+#define =
VIAFB_GET_TV_SUPPORT_SIGNAL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 0x5649411B <BR>+#define =
VIAFB_GET_TV_SUPPORT_STANDARD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x5649411C <BR>+#define =
VIAFB_GET_TV_MAX_SIZE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x5649411D <BR>+#define =
VIAFB_GET_TV_MAX_POSITION&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; 0x5649411E <BR>+#define =
VIAFB_GET_TV_SUPPORT_TUNING_ITEM&nbsp;&nbsp;&nbsp; 0x5649411F =
<BR>+#define =
VIAFB_GET_TV_MAX_TUNING_VALUE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x56494120 <BR>+#define VIAFB_GET_TV_SUPPORT_SETTING_ITEM&nbsp;&nbsp; =
0x56494121 <BR>+#define =
VIAFB_GET_DRIVER_NAME&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x56494122 <BR>+#define =
VIAFB_GET_DEVICE_SUPPORT_STATE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x56494123 =
<BR>+#define =
VIAFB_GET_GAMMA_LUT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x56494124 <BR>+#define =
VIAFB_SET_GAMMA_LUT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x56494125 <BR>+#define =
VIAFB_GET_GAMMA_SUPPORT_STATE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x56494126 <BR>+#define =
VIAFB_SET_VIDEO_DEVICE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; 0x56494127 <BR>+#define =
VIAFB_GET_VIDEO_DEVICE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; 0x56494128 <BR>+#define =
VIAFB_SET_SECOND_MODE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x56494129 <BR>+<BR>+/* Re-define value =
to sync with xserver driver. (Bitwise) */<BR>+#define None_Device =
0x00<BR>+#define CRT_Device&nbsp; 0x01<BR>+#define LCD_Device&nbsp; =
0x02<BR>+#define TV_Device&nbsp;&nbsp; 0x04<BR>+#define DVI_Device&nbsp; =
0x08<BR>+#define CRT2_Device 0x10<BR>+#define HDTV_Device =
0x20<BR>+#define LCD2_Device 0x40<BR>+<BR>+/* Flags which are used to =
control operations of TV. (Bitwise) */<BR>+#define =
OP_TV_SYSTEM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x0001<BR>+#define =
OP_TV_LEVEL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x0002<BR>+#define =
OP_TV_OUT_SIGNAL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0004<BR>+#define =
OP_TV_DEDOTCRAWL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0008<BR>+#define =
OP_TV_BRIGHTNESS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0010&nbsp;&nbsp; <BR>+#define =
OP_TV_CONTRAST&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0020&nbsp;&nbsp; =
<BR>+#define =
OP_TV_SATURATION&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0040&nbsp; <BR>+#define =
OP_TV_TINT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x0080&nbsp; <BR>+#define =
OP_TV_POSITION&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0100<BR>+#define =
OP_TV_SETTING_FFILTER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 0x0200&nbsp;&nbsp; <BR>+#define =
OP_TV_TUNING_FFILTER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 0x0400&nbsp;&nbsp; <BR>+#define =
OP_TV_SETTING_ADAPTIVE_FFILTER&nbsp;&nbsp; 0x0800<BR>+#define =
OP_TV_TUNING_ADAPTIVE_FFILTER&nbsp;&nbsp;&nbsp; =
0x1000<BR>+<BR>+<BR>+<BR>+/* Flags which are used to control operations =
of LCD. (Bitwise) */<BR>+#define OP_LCD_CENTERING&nbsp;&nbsp; =
0x01<BR>+#define OP_LCD_PANEL_ID&nbsp;&nbsp;&nbsp; 0x02<BR>+#define =
OP_LCD_MODE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x03<BR>+<BR>+/* =
SAMM operation flag */<BR>+#define =
OP_SAMM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 0x80<BR>+ <BR>+/* Define maximum value of tv/lcd items. */<BR>+/* The =
setting value of tv/lcd must be smaller than corresponding maximum value =
*/<BR>+#define =
TV_STANDARD_MAXIMUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; 0x20&nbsp;&nbsp;&nbsp; <BR>+#define =
TV_SIZE_LEVEL_MAXIMUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x02&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>+#define =
TV_OUT_SIGNAL_MAXIMUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x100<BR>+#define =
TV_FFILTER_MAXIMUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; 3<BR>+#define =
TV_BRIGHTNESS_MAXIMUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
255<BR>+#define =
TV_CONTRAST_MAXIMUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; 255<BR>+#define TV_ADAPTIVE_FFILTER_MAXIMUM&nbsp;&nbsp; =
255<BR>+#define =
TV_SATURATION_MAXIMUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
65535<BR>+#define =
TV_TINT_MAXIMUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; 2047<BR>+#define =
TV_HOR_POSITION_MAXIMUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
15<BR>+#define =
TV_VER_POSITION_MAXIMUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
15<BR>+#define =
LCD_PANEL_ID_MAXIMUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 19<BR>+<BR>+ <BR>+#define =
STATE_ON&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 0x1<BR>+#define =
STATE_OFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x0<BR>+#define STATE_DEFAULT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0xFFFF<BR>+<BR>+#define MAX_ACTIVE_DEV_NUM&nbsp; 2<BR>+<BR>+<BR>+typedef =
struct{<BR>+&nbsp; unsigned short crt:1;<BR>+&nbsp; unsigned short =
dvi:1;<BR>+&nbsp; unsigned short tv:1;<BR>+&nbsp; unsigned short =
lcd:1;<BR>+&nbsp; unsigned short samm:1;<BR>+&nbsp; unsigned short =
primary_dev;<BR>+<BR>+&nbsp; unsigned short lcd_dsp_cent:1;<BR>+&nbsp; =
unsigned char lcd_panel_id;<BR>+&nbsp; unsigned char =
lcd_mode:1;<BR>+<BR>+&nbsp; unsigned char tv_out_sig;<BR>+&nbsp; =
unsigned short tv_level:2;<BR>+&nbsp; unsigned short =
tv_system;<BR>+&nbsp; unsigned short tv_dedotcrawl:1;<BR>+&nbsp; =
unsigned short xres,yres;<BR>+&nbsp; unsigned short =
xres1,yres1;<BR>+&nbsp; unsigned short refresh;<BR>+&nbsp; unsigned =
short bpp;<BR>+&nbsp; unsigned short refresh1;<BR>+&nbsp; unsigned short =
bpp1;<BR>+&nbsp; unsigned short sequence;<BR>+&nbsp; <BR>+&nbsp; =
unsigned short epia_dvi:1;<BR>+&nbsp; unsigned short =
lcd_dual_edge:1;<BR>+&nbsp; unsigned short bus_width;<BR>+&nbsp; =
unsigned short lcd2:1;<BR>+} device_t;<BR>+<BR>+<BR>+struct =
viafb_ioctl_info {<BR>+&nbsp;&nbsp;&nbsp; u32&nbsp;&nbsp;&nbsp;&nbsp; =
viafb_id;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; /* for identifying viafb */<BR>+#define =
VIAID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x56494146&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Identify myself with 'VIAF' =
*/<BR>+&nbsp;&nbsp;&nbsp; u16&nbsp;&nbsp;&nbsp;&nbsp; =
vendor_id;<BR>+&nbsp;&nbsp;&nbsp; u16&nbsp;&nbsp;&nbsp;&nbsp; =
device_id;<BR>+&nbsp;&nbsp;&nbsp; u8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
version;<BR>+&nbsp;&nbsp;&nbsp; u8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
revision;<BR>+&nbsp;&nbsp;&nbsp; u8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
reserved[246];&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
for future use */<BR>+};<BR>+<BR>+struct viafb_ioctl_mode =
{<BR>+&nbsp;&nbsp;&nbsp; u32&nbsp;&nbsp;&nbsp;&nbsp; =
xres;<BR>+&nbsp;&nbsp;&nbsp; u32&nbsp;&nbsp;&nbsp;&nbsp; =
yres;<BR>+&nbsp;&nbsp;&nbsp; u32&nbsp;&nbsp;&nbsp;&nbsp; =
refresh;<BR>+&nbsp;&nbsp;&nbsp; u32&nbsp;&nbsp;&nbsp;&nbsp; =
bpp;<BR>+&nbsp;&nbsp;&nbsp; u32&nbsp;&nbsp;&nbsp;&nbsp; =
xres_sec;<BR>+&nbsp;&nbsp;&nbsp; u32&nbsp;&nbsp;&nbsp;&nbsp; =
yres_sec;<BR>+&nbsp;&nbsp;&nbsp; u32&nbsp;&nbsp;&nbsp;&nbsp; =
virtual_xres_sec;<BR>+&nbsp;&nbsp;&nbsp; u32&nbsp;&nbsp;&nbsp;&nbsp; =
virtual_yres_sec;<BR>+&nbsp;&nbsp;&nbsp; u32&nbsp;&nbsp;&nbsp;&nbsp; =
refresh_sec;<BR>+&nbsp;&nbsp;&nbsp; u32&nbsp;&nbsp;&nbsp;&nbsp; =
bpp_sec;<BR>+};<BR>+struct viafb_ioctl_samm {<BR>+&nbsp;&nbsp;&nbsp; =
u32&nbsp;&nbsp;&nbsp;&nbsp; samm_status;<BR>+&nbsp;&nbsp;&nbsp; =
u32&nbsp;&nbsp;&nbsp;&nbsp; size_prim; <BR>+&nbsp;&nbsp;&nbsp; =
u32&nbsp;&nbsp;&nbsp;&nbsp; size_sec;<BR>+&nbsp;&nbsp;&nbsp; =
u32&nbsp;&nbsp;&nbsp;&nbsp; mem_base;<BR>+&nbsp;&nbsp;&nbsp; =
u32&nbsp;&nbsp;&nbsp;&nbsp; offset_sec; <BR>+};<BR>+<BR>+struct =
viafb_driver_version {<BR>+&nbsp;&nbsp;&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp; iMajorNum;<BR>+&nbsp;&nbsp;&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp; iKernelNum;<BR>+&nbsp;&nbsp;&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp; iOSNum;<BR>+&nbsp;&nbsp;&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp; iMinorNum;<BR>+};<BR>+<BR>+/* This structure =
contains variable attributes of TV. */<BR>+struct =
viafb_ioctl_tv_attribute {<BR>+&nbsp;&nbsp;&nbsp; unsigned int =
system;<BR>+&nbsp;&nbsp;&nbsp; unsigned int =
level;<BR>+&nbsp;&nbsp;&nbsp; unsigned int =
out_signal;<BR>+&nbsp;&nbsp;&nbsp; unsigned int =
dedotcrawl;&nbsp;<BR>+&nbsp;&nbsp;&nbsp; unsigned int =
ffilter;<BR>+&nbsp;&nbsp;&nbsp; unsigned int =
adaptive_ffilter;<BR>+&nbsp;&nbsp;&nbsp; unsigned int =
brightness;<BR>+&nbsp;&nbsp;&nbsp; unsigned int =
contrast;<BR>+&nbsp;&nbsp;&nbsp; unsigned int =
saturation;<BR>+&nbsp;&nbsp;&nbsp; unsigned int =
tint;<BR>+&nbsp;&nbsp;&nbsp; unsigned int =
horizontal_pos;<BR>+&nbsp;&nbsp;&nbsp; unsigned int =
vertical_pos;<BR>+&nbsp;&nbsp;&nbsp; unsigned int =
CurrentScalH;<BR>+&nbsp;&nbsp;&nbsp; unsigned int =
CurrentScalV;<BR>+&nbsp;&nbsp;&nbsp; unsigned int =
ScalHLevel;<BR>+&nbsp;&nbsp;&nbsp; unsigned int =
ScalVLevel;<BR>+&nbsp;&nbsp;&nbsp; unsigned int =
DefaultScalH;<BR>+&nbsp;&nbsp;&nbsp; unsigned int =
DefaultScalV;<BR>+&nbsp;&nbsp;&nbsp; unsigned int =
PositionHLevel;<BR>+&nbsp;&nbsp;&nbsp; unsigned int =
PositionVLevel;<BR>+&nbsp;&nbsp;&nbsp; unsigned int =
DefaultPositionH;<BR>+&nbsp;&nbsp;&nbsp; unsigned int =
DefaultPositionV;<BR>+&nbsp;&nbsp;&nbsp; unsigned int =
ffilter_state;&nbsp;&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; unsigned =
int adaptive_ffilter_state; <BR>+};<BR>+<BR>+/* This structure contains =
variable attributes of LCD. */<BR>+struct viafb_ioctl_lcd_attribute =
{<BR>+&nbsp;&nbsp;&nbsp; unsigned int panel_id;<BR>+&nbsp;&nbsp;&nbsp; =
unsigned int display_center;<BR>+&nbsp;&nbsp;&nbsp; unsigned int =
lcd_mode;<BR>+};<BR>+<BR>+/* This structure contains all setting =
information of devices. */<BR>+struct viafb_ioctl_setting =
{<BR>+&nbsp;&nbsp;&nbsp; unsigned short =
device_flag;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Enable or disable active devices */<BR>+&nbsp;&nbsp;&nbsp; unsigned =
short device_status;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
Indicate which device should be turn on or turn off. =
*/<BR>+&nbsp;&nbsp;&nbsp; unsigned int&nbsp;&nbsp; =
tv_operation_flag;&nbsp;&nbsp;&nbsp;&nbsp; /* Indicate which TV's =
attribute can be changed. */<BR>+&nbsp;&nbsp;&nbsp; unsigned short =
lcd_operation_flag;&nbsp;&nbsp;&nbsp; /* Indicate which LCD's attribute =
can be changed. */<BR>+&nbsp;&nbsp;&nbsp; unsigned short =
samm_status;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* 1: SAMM ON&nbsp; 0: SAMM OFF */<BR>+<BR>+&nbsp;&nbsp;&nbsp; unsigned =
short first_dev_hor_res;&nbsp;&nbsp;&nbsp;&nbsp; /* horizontal =
resolution of first device */<BR>+&nbsp;&nbsp;&nbsp; unsigned short =
first_dev_ver_res;&nbsp;&nbsp;&nbsp;&nbsp; /* vertical resolution of =
first device */<BR>+&nbsp;&nbsp;&nbsp; unsigned short =
second_dev_hor_res;&nbsp;&nbsp;&nbsp; /* horizontal resolution of second =
device */<BR>+&nbsp;&nbsp;&nbsp; unsigned short =
second_dev_ver_res;&nbsp;&nbsp;&nbsp; /* vertical resolution of second =
device */<BR>+&nbsp;&nbsp;&nbsp; unsigned short =
first_dev_refresh;&nbsp;&nbsp;&nbsp;&nbsp; /* refresh rate of first =
device */<BR>+&nbsp;&nbsp;&nbsp; unsigned short =
first_dev_bpp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* bpp of =
first device */<BR>+&nbsp;&nbsp;&nbsp; unsigned short =
second_dev_refresh;&nbsp;&nbsp;&nbsp; /* refresh rate of second device =
*/<BR>+&nbsp;&nbsp;&nbsp; unsigned short =
second_dev_bpp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* bpp of =
second device */<BR>+<BR>+&nbsp;&nbsp;&nbsp; unsigned int =
primary_device;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
Indicate which device are primary display device. =
*/<BR>+&nbsp;&nbsp;&nbsp; unsigned int =
video_device_status;&nbsp;&nbsp;&nbsp;&nbsp; /* Indicate which device =
will show video. only valid in duoview mode */<BR>+&nbsp;&nbsp;&nbsp; =
struct viafb_ioctl_tv_attribute tv_attributes;<BR>+&nbsp;&nbsp;&nbsp; =
struct viafb_ioctl_lcd_attribute lcd_attributes;<BR>+};<BR>+<BR>+typedef =
struct _POSITIONVALUE<BR>+{<BR>+&nbsp;&nbsp;&nbsp; unsigned =
int&nbsp;dwX;<BR>+&nbsp;&nbsp;&nbsp; unsigned =
int&nbsp;dwY;<BR>+}POSITIONVALUE;<BR>+#endif /* __IOCTL_H__ */<BR>diff =
-Nur linux-2.6.21-rc7/drivers/video/via/lcd.c =
linux-2.6.21-rc7.viafb/drivers/video/via/lcd.c<BR>--- =
linux-2.6.21-rc7/drivers/video/via/lcd.c&nbsp;1969-12-31 =
19:00:00.000000000 -0500<BR>+++ =
linux-2.6.21-rc7.viafb/drivers/video/via/lcd.c&nbsp;2007-04-26 =
19:52:32.000000000 -0400<BR>@@ -0,0 +1,1630 @@<BR>+/*<BR>+ * Copyright =
1998-2007 VIA Technologies, Inc. All Rights Reserved.<BR>+ * Copyright =
2001-2007 S3 Graphics, Inc. All Rights Reserved.<BR>+ *<BR>+ * =
Permission is hereby granted, free of charge, to any person obtaining =
a<BR>+ * copy of this software and associated documentation files (the =
"Software"),<BR>+ * to deal in the Software without restriction, =
including without limitation<BR>+ * the rights to use, copy, modify, =
merge, publish, distribute, sub license,<BR>+ * and/or sell copies of =
the Software, and to permit persons to whom the<BR>+ * Software is =
furnished to do so, subject to the following conditions:<BR>+ *<BR>+ * =
The above copyright notice and this permission notice (including =
the<BR>+ * next paragraph) shall be included in all copies or =
substantial portions<BR>+ * of the Software.<BR>+ *<BR>+ * THE SOFTWARE =
IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR<BR>+ * =
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF =
MERCHANTABILITY,<BR>+ * FITNESS FOR A PARTICULAR PURPOSE AND =
NON-INFRINGEMENT. IN NO EVENT SHALL<BR>+ * THE AUTHOR(S) OR COPYRIGHT =
HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR<BR>+ * OTHER LIABILITY, =
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,<BR>+ * ARISING =
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER<BR>+ =
* DEALINGS IN THE SOFTWARE.<BR>+ */<BR>+#include =
&lt;linux/version.h&gt;<BR>+#if LINUX_VERSION_CODE &lt; =
KERNEL_VERSION(2,6,18)<BR>+#include =
&lt;linux/config.h&gt;<BR>+#endif<BR>+#include =
&lt;linux/ioport.h&gt;<BR>+#include &lt;asm/io.h&gt;<BR>+<BR>+#include =
"debug.h"<BR>+#include "lcd.h"<BR>+#include "lcdtbl.h"<BR>+#include =
"chip.h"<BR>+#include "share.h"<BR>+#include "hw.h"<BR>+#include =
"viamode.h"<BR>+#include "hwcfig.h"<BR>+#include "via_i2c.h"<BR>+<BR>+/* =
extern function */<BR>+extern int i2cWriteByte(u8 slave_addr, u8 index, =
u8 data);<BR>+extern int i2cReadByte(u8 slave_addr, u8 index, u8 =
*pData);<BR>+extern void set_output_path(int device, int set_iga, int =
output_interface);<BR>+extern void fill_crtc_timing(struct =
crt_mode_table *crt_table, int mode_index, int bpp_byte, int =
set_iga);<BR>+extern void write_reg_mask(u8 index, int io_port, u8 data, =
u8 mask);<BR>+extern void load_reg(int timing_value, int load_reg_num, =
struct io_register *reg, int io_type);<BR>+extern struct display_timing =
get_timing_value(struct crt_mode_table *crt_table, int =
mode_index);<BR>+extern void load_offset_reg(int h_addr, int bpp_byte, =
int set_iga);<BR>+extern void load_fetch_count_reg(int h_addr, int =
bpp_byte, int set_iga);<BR>+extern void write_regx(struct io_reg =
RegTable[],int ItemNum);<BR>+extern int get_mode_index(int hres, int =
vres,int flag);<BR>+extern void delays(int count);<BR>+extern inline =
void lock_crt(void);<BR>+extern inline void unlock_crt(void);<BR>+extern =
inline u8 read_reg(int io_port, u8 index);<BR>+extern inline void =
write_reg(u8 index, u16 io_port, u8 data);<BR>+extern int =
SearchModeSetting(int ModeInfoIndex);<BR>+extern void load_FIFO_reg(int =
set_iga, int hor_active, int ver_active);<BR>+extern u32 =
get_clk_value(int clk);<BR>+extern void SetVCLK(u32 CLK, int =
set_iga);<BR>+extern void load_crtc_timing(struct display_timing =
device_timing, int set_iga);<BR>+extern void set_color_depth(int =
bpp_byte, int set_iga);<BR>+extern bool =
lvds_identify_vt1636(void);<BR>+extern void init_lvds_vt1636(struct =
lvds_setting_information *plvds_setting_info, struct =
lvds_chip_information *plvds_chip_info);<BR>+void =
disable_lvds_vt1636(struct lvds_setting_information *plvds_setting_info, =
struct lvds_chip_information *plvds_chip_info);<BR>+void =
enable_lvds_vt1636(struct lvds_setting_information *plvds_setting_info, =
struct lvds_chip_information *plvds_chip_info);<BR>+extern void =
vt1636_patch_skew_on_vt3324(struct lvds_setting_information =
*plvds_setting_info, struct lvds_chip_information =
*plvds_chip_info);<BR>+extern void vt1636_patch_skew_on_vt3327(struct =
lvds_setting_information *plvds_setting_info, struct =
lvds_chip_information *plvds_chip_info);<BR>+extern void =
vt1636_patch_skew_on_vt3364(struct lvds_setting_information =
*plvds_setting_info, struct lvds_chip_information =
*plvds_chip_info);<BR>+<BR>+<BR>+/* extern struct */<BR>+extern struct =
chip_information&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; chip_info;<BR>+extern struct =
lvds_setting_information&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
lvds_setting_info;<BR>+extern struct =
lvds_setting_information&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
lvds_setting_info2;<BR>+extern struct =
_lcd_scaling_factor&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; lcd_scaling_factor;<BR>+extern struct =
iga1_crtc_timing&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; iga1_crtc_reg;<BR>+extern struct =
iga1_shadow_crtc_timing&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
iga1_shadow_crtc_reg;<BR>+extern struct =
iga2_crtc_timing&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; iga2_crtc_reg;<BR>+<BR>+extern int =
lcd_panel_id;<BR>+<BR>+extern int SAMM_ON, LCD2_ON, LCD_ON;<BR>+extern =
int display_hardware_layout;<BR>+<BR>+int lvds_register_read(int =
index);<BR>+int fp_id_to_vindex(int panel_id);<BR>+void =
load_lcd_scaling(int set_hres, int set_vres, int panel_hres, int =
panel_vres);<BR>+void load_lcd_k400_patch_tbl(int set_hres, int =
set_vres, int panel_id);<BR>+void load_lcd_p880_patch_tbl(int set_hres, =
int set_vres, int panel_id);<BR>+void load_lcd_patch_regs(int set_hres, =
int set_vres, int panel_id, int set_iga);<BR>+void =
VIAPitchAlignmentPatchLCD(struct lvds_setting_information =
*plvds_setting_info, struct lvds_chip_information =
*plvds_chip_info);<BR>+void lcd_disable(void);<BR>+void =
lcd_enable(void);<BR>+void LCDPowerSequenceOff(void);<BR>+void =
LCDPowerSequenceOn(void);<BR>+void fill_lcd_format(void);<BR>+void =
init_lvds_output_interface(struct lvds_chip_information =
*plvds_chip_info, struct lvds_setting_information* =
plvds_setting_info);<BR>+struct display_timing =
lcd_centering_timging(struct display_timing mode_crt_reg, struct =
display_timing panel_crt_reg);<BR>+void load_crtc_shadow_timing(struct =
display_timing mode_timing, struct display_timing =
panel_timing);<BR>+void load_scaling_factor_for_p4m900(int set_hres, int =
set_vres, int panel_hres, int panel_vres);<BR>+<BR>+<BR>+<BR>+int =
check_lvds_chip(int device_id_subaddr, int =
device_id)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; if =
(lvds_register_read(device_id_subaddr) =3D=3D =
device_id)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return(OK);<BR>+&nbsp;&nbsp;&nbsp; =
else<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return(FAIL);<BR>+}<BR>+<BR>+void =
init_lcd_size(void)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; DEBUG_MSG(KERN_INFO =
"init_lcd_size()\n");<BR>+&nbsp;&nbsp;&nbsp; DEBUG_MSG(KERN_INFO =
"lvds_setting_info.get_lcd_size_method %d\n", =
lvds_setting_info.get_lcd_size_method);<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
switch(lvds_setting_info.get_lcd_size_method) =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
GET_LCD_SIZE_BY_SYSTEM_BIOS:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
GET_LCD_SZIE_BY_HW_STRAPPING:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
GET_LCD_SIZE_BY_VGA_BIOS:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; DEBUG_MSG(KERN_INFO "Get LCD Size method by VGA =
BIOS !!\n");&nbsp;&nbsp;&nbsp; =
&nbsp;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; lvds_setting_info.lcd_panel_size =3D&nbsp; =
fp_id_to_vindex(lcd_panel_id);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; DEBUG_MSG(KERN_INFO "LCD Panel_ID =3D =
%d\n", =
lvds_setting_info.lcd_panel_id);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DEBUG_MSG(KERN_INFO "LCD Panel Size =3D =
%d\n", lvds_setting_info.lcd_panel_size);&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
GET_LCD_SIZE_BY_USER_SETTING:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; DEBUG_MSG(KERN_INFO "Get LCD Size method by =
user setting =
!!\n");<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; lvds_setting_info.lcd_panel_size =3D =
fp_id_to_vindex(lcd_panel_id);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; DEBUG_MSG(KERN_INFO "LCD Panel_ID =3D =
%d\n", =
lvds_setting_info.lcd_panel_id);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DEBUG_MSG(KERN_INFO "LCD Panel Size =3D =
%d\n", =
lvds_setting_info.lcd_panel_size);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
default:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; DEBUG_MSG(KERN_INFO "init_lcd_size =
fail\n");<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; lvds_setting_info.lcd_panel_id =3D =
LCD_PANEL_ID1_800X600;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; lvds_setting_info.lcd_panel_size =3D =
fp_id_to_vindex(LCD_PANEL_ID1_800X600);<BR>+&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; lvds_setting_info2.lcd_panel_id =3D =
lvds_setting_info.lcd_panel_id;<BR>+&nbsp;&nbsp;&nbsp; =
lvds_setting_info2.lcd_panel_size =3D =
lvds_setting_info.lcd_panel_size;<BR>+&nbsp;&nbsp;&nbsp; =
lvds_setting_info2.lcd_panel_hres =3D =
lvds_setting_info.lcd_panel_hres;<BR>+&nbsp;&nbsp;&nbsp; =
lvds_setting_info2.lcd_panel_vres =3D =
lvds_setting_info.lcd_panel_vres;<BR>+&nbsp;&nbsp;&nbsp; =
lvds_setting_info2.LCDDualEdge =3D =
lvds_setting_info.LCDDualEdge;<BR>+&nbsp;&nbsp;&nbsp; =
lvds_setting_info2.LCDDithering =3D =
lvds_setting_info.LCDDithering;<BR>+}<BR>+<BR>+bool =
lvds_identify_integratedlvds(void)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; if =
(display_hardware_layout =3D=3D =
HW_LAYOUT_LCD_EXTERNAL_LCD2)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Two dual channel LCD =
(Internal LVDS + External LVDS): =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If we have an =
external LVDS, such as VT1636, we should have its chip ID already. =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(chip_info.lvds_chip_info.lvds_chip_name)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
chip_info.lvds_chip_info2.lvds_chip_name =3D =
INTEGRATED_LVDS;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; DEBUG_MSG(KERN_INFO "Support two dual channel LVDS! =
(Internal LVDS + External =
LVDS)\n");<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
else<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
chip_info.lvds_chip_info.lvds_chip_name =3D =
INTEGRATED_LVDS;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; DEBUG_MSG(KERN_INFO "Not found external LVDS, so can't =
support two dual channel =
LVDS!\n");<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; else if =
(display_hardware_layout =3D=3D =
HW_LAYOUT_LCD1_LCD2)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Two single channel =
LCD (Internal LVDS + Internal LVDS): =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
chip_info.lvds_chip_info.lvds_chip_name =3D =
INTEGRATED_LVDS;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
chip_info.lvds_chip_info2.lvds_chip_name =3D =
INTEGRATED_LVDS;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
DEBUG_MSG(KERN_INFO "Support two single channel LVDS! (Internal LVDS + =
Internal LVDS)\n");<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; else =
if (display_hardware_layout !=3D =
HW_LAYOUT_DVI_ONLY)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If we have found =
external LVDS, just use it, otherwise, we will use internal LVDS as =
default. */<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(!chip_info.lvds_chip_info.lvds_chip_name)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
chip_info.lvds_chip_info.lvds_chip_name =3D =
INTEGRATED_LVDS;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; DEBUG_MSG(KERN_INFO "Found Integrated =
LVDS!\n");<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; =
else<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
chip_info.lvds_chip_info.lvds_chip_name =3D =
NON_LVDS_TRANSMITTER;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
DEBUG_MSG(KERN_INFO "Do not support =
LVDS!\n");<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
FALSE;<BR>+&nbsp;&nbsp;&nbsp; }<BR>+<BR>+&nbsp;&nbsp;&nbsp; return =
TRUE;<BR>+}<BR>+<BR>+int =
lvds_trasmitter_identify(void)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; u8 =
tmp;<BR>+&nbsp;&nbsp;&nbsp; tmp =3D =
chip_info.tv_chip_info.tv_chip_on_slot;<BR>+&nbsp;&nbsp;&nbsp; =
chip_info.tv_chip_info.tv_chip_on_slot =3D =
TV_ON_AMR;<BR>+&nbsp;&nbsp;&nbsp; =
if(lvds_identify_vt1636())<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
chip_info.lvds_chip_info.i2c_port =3D =
TVI2CPORTINDEX;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
DEBUG_MSG(KERN_INFO "Found VIA VT1636 LVDS on port i2c 0x31 =
\n");<BR>+&nbsp;&nbsp;&nbsp; }else<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
chip_info.tv_chip_info.tv_chip_on_slot =3D =
TV_ON_AGP;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
if(lvds_identify_vt1636())<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
chip_info.lvds_chip_info.i2c_port =3D =
TVGPIOPORTINDEX;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; DEBUG_MSG(KERN_INFO "Found VIA VT1636 LVDS on port gpio =
0x2c \n");<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; =
chip_info.tv_chip_info.tv_chip_on_slot =3D tmp;<BR>+&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; if (chip_info.gfx_chip_name =3D=3D =
UNICHROME_CX700)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
lvds_identify_integratedlvds();<BR>+&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp; =
if(chip_info.lvds_chip_info.lvds_chip_name)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
TRUE;<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; /* Check for =
VT1631: */<BR>+&nbsp;&nbsp;&nbsp; =
chip_info.lvds_chip_info.lvds_chip_name =3D =
VT1631_LVDS;<BR>+&nbsp;&nbsp;&nbsp; =
chip_info.lvds_chip_info.lvds_chip_slave_addr =3D =
VT1631_LVDS_I2C_ADDR;<BR>+<BR>+&nbsp;&nbsp;&nbsp; if =
(check_lvds_chip(VT1631_DEVICE_ID_REG, VT1631_DEVICE_ID)!=3D =
FAIL)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DEBUG_MSG(KERN_INFO "\n =
VT1631 LVDS ! \n");<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
DEBUG_MSG(KERN_INFO "\n %2d", =
chip_info.lvds_chip_info.lvds_chip_name);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; DEBUG_MSG(KERN_INFO "\n %2d", =
chip_info.lvds_chip_info.lvds_chip_name);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return(OK);<BR>+&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
chip_info.lvds_chip_info.lvds_chip_name =3D =
NON_LVDS_TRANSMITTER;<BR>+&nbsp;&nbsp;&nbsp; =
chip_info.lvds_chip_info.lvds_chip_slave_addr =3D =
VT1631_LVDS_I2C_ADDR;<BR>+&nbsp;&nbsp;&nbsp; =
return(FAIL);<BR>+}<BR>+<BR>+int fp_id_to_vindex(int =
panel_id)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; DEBUG_MSG(KERN_INFO =
"fp_get_panel_id()\n");<BR>+&nbsp; <BR>+&nbsp;&nbsp;&nbsp; if(panel_id =
&gt; 0x13)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
lcd_panel_id =3D panel_id=3D read_reg(VIACR, CR3F) &amp; =
0x0F;<BR>+&nbsp; <BR>+&nbsp;&nbsp;&nbsp; switch(panel_id) =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
0x0:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; lvds_setting_info.lcd_panel_hres =3D =
640;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; lvds_setting_info.lcd_panel_vres =3D =
480;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; lvds_setting_info.lcd_panel_id =3D =
LCD_PANEL_ID0_640X480;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; lvds_setting_info.LCDDualEdge =3D =
0;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 lvds_setting_info.LCDDithering =3D =
1;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =
return(VIA_RES_640X480);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
0x1:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; lvds_setting_info.lcd_panel_hres =3D =
800;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; lvds_setting_info.lcd_panel_vres =3D =
600;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; lvds_setting_info.lcd_panel_id =3D =
LCD_PANEL_ID1_800X600;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; lvds_setting_info.LCDDualEdge =3D =
0;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 lvds_setting_info.LCDDithering =3D =
1;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =
return(VIA_RES_800X600);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
0x2:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; lvds_setting_info.lcd_panel_hres =3D =
1024;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; lvds_setting_info.lcd_panel_vres =3D =
768;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; lvds_setting_info.lcd_panel_id =3D =
LCD_PANEL_ID2_1024X768;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; lvds_setting_info.LCDDualEdge =3D =
0;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 lvds_setting_info.LCDDithering =3D =
1;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =
return(VIA_RES_1024X768);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
0x3:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; lvds_setting_info.lcd_panel_hres =3D =
1280;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; lvds_setting_info.lcd_panel_vres =3D =
768;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; lvds_setting_info.lcd_panel_id =3D =
LCD_PANEL_ID3_1280X768;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; lvds_setting_info.LCDDualEdge =3D =
0;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 lvds_setting_info.LCDDithering =3D =
1;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =
return(VIA_RES_1280X768);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
0x4:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; lvds_setting_info.lcd_panel_hres =3D =
1280;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; lvds_setting_info.lcd_panel_vres =3D =
1024;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; lvds_setting_info.lcd_panel_id =3D =
LCD_PANEL_ID4_1280X1024;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; lvds_setting_info.LCDDualEdge =3D =
1;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 lvds_setting_info.LCDDithering =3D =
1;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =
return(VIA_RES_1280X1024);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
0x5:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; lvds_setting_info.lcd_panel_hres =3D =
1400;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; lvds_setting_info.lcd_panel_vres =3D =
1050;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; lvds_setting_info.lcd_panel_id =3D =
LCD_PANEL_ID5_1400X1050;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; lvds_setting_info.LCDDualEdge =3D =
1;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 lvds_setting_info.LCDDithering =3D =
1;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =
return(VIA_RES_1400X1050);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
0x6:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; lvds_setting_info.lcd_panel_hres =3D =
1600;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; lvds_setting_info.lcd_panel_vres =3D =
1200;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; lvds_setting_info.lcd_panel_id =3D =
LCD_PANEL_ID6_1600X1200;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; lvds_setting_info.LCDDualEdge =3D =
1;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 lvds_setting_info.LCDDithering =3D =
1;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =
return(VIA_RES_1600X1200);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
0x9:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; lvds_setting_info.lcd_panel_hres =3D =
1024;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; lvds_setting_info.lcd_panel_vres =3D =
768;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; lvds_setting_info.lcd_panel_id =3D =
LCD_PANEL_ID2_1024X768;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; lvds_setting_info.LCDDualEdge =3D =
1;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 lvds_setting_info.LCDDithering =3D =
1;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =
return(VIA_RES_1024X768);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
0xA:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; lvds_setting_info.lcd_panel_hres =3D =
1024;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; lvds_setting_info.lcd_panel_vres =3D =
768;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; lvds_setting_info.lcd_panel_id =3D =
LCD_PANEL_ID2_1024X768;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; lvds_setting_info.LCDDualEdge =3D =
0;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 lvds_setting_info.LCDDithering =3D =
0;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =
return(VIA_RES_1024X768);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
0xB:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; lvds_setting_info.lcd_panel_hres =3D =
1024;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; lvds_setting_info.lcd_panel_vres =3D =
768;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; lvds_setting_info.lcd_panel_id =3D =
LCD_PANEL_ID2_1024X768;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; lvds_setting_info.LCDDualEdge =3D =
1;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 lvds_setting_info.LCDDithering =3D =
0;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =
return(VIA_RES_1024X768);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
0xC:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; lvds_setting_info.lcd_panel_hres =3D =
1280;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; lvds_setting_info.lcd_panel_vres =3D =
768;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; lvds_setting_info.lcd_panel_id =3D =
LCD_PANEL_ID3_1280X768;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; lvds_setting_info.LCDDualEdge =3D =
0;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 lvds_setting_info.LCDDithering =3D =
0;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =
return(VIA_RES_1280X768);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
0xD:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; lvds_setting_info.lcd_panel_hres =3D =
1280;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; lvds_setting_info.lcd_panel_vres =3D =
1024;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; lvds_setting_info.lcd_panel_id =3D =
LCD_PANEL_ID4_1280X1024;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; lvds_setting_info.LCDDualEdge =3D =
1;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 lvds_setting_info.LCDDithering =3D =
0;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =
return(VIA_RES_1280X1024);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
0xE:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; lvds_setting_info.lcd_panel_hres =3D =
1400;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; lvds_setting_info.lcd_panel_vres =3D =
1050;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; lvds_setting_info.lcd_panel_id =3D =
LCD_PANEL_ID5_1400X1050;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; lvds_setting_info.LCDDualEdge =3D =
1;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 lvds_setting_info.LCDDithering =3D =
0;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =
return(VIA_RES_1400X1050);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
0xF:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; lvds_setting_info.lcd_panel_hres =3D =
1600;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; lvds_setting_info.lcd_panel_vres =3D =
1200;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; lvds_setting_info.lcd_panel_id =3D =
LCD_PANEL_ID6_1600X1200;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; lvds_setting_info.LCDDualEdge =3D =
1;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 lvds_setting_info.LCDDithering =3D =
0;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =
return(VIA_RES_1600X1200);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
0x10:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; lvds_setting_info.lcd_panel_hres =3D =
1366;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; lvds_setting_info.lcd_panel_vres =3D =
768;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; lvds_setting_info.lcd_panel_id =3D =
LCD_PANEL_ID7_1366X768;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; lvds_setting_info.LCDDualEdge =3D =
0;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 lvds_setting_info.LCDDithering =3D =
0;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =
return(VIA_RES_1368X768);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
0x11:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; lvds_setting_info.lcd_panel_hres =3D =
1024;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; lvds_setting_info.lcd_panel_vres =3D =
600;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; lvds_setting_info.lcd_panel_id =3D =
LCD_PANEL_ID8_1024X600;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; lvds_setting_info.LCDDualEdge =3D =
0;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; lvds_setting_info.LCDDithering =3D 1;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; =
return(VIA_RES_1024X600);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp; case =
0x12:&nbsp;&nbsp;&nbsp;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; lvds_setting_info.lcd_panel_hres =3D =
1280;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; lvds_setting_info.lcd_panel_vres =3D =
768;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; lvds_setting_info.lcd_panel_id =3D =
LCD_PANEL_ID3_1280X768;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; lvds_setting_info.LCDDualEdge =3D =
1;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 lvds_setting_info.LCDDithering =3D =
1;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =
return(VIA_RES_1280X768);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
0x13:&nbsp;&nbsp;&nbsp;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; lvds_setting_info.lcd_panel_hres =3D =
1280;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; lvds_setting_info.lcd_panel_vres =3D =
800;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; lvds_setting_info.lcd_panel_id =3D =
LCD_PANEL_ID9_1280X800;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; lvds_setting_info.LCDDualEdge =3D =
0;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 lvds_setting_info.LCDDithering =3D =
1;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =
return(VIA_RES_1280X800);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
default:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; lvds_setting_info.lcd_panel_hres =3D =
800;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; lvds_setting_info.lcd_panel_vres =3D =
600;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; lvds_setting_info.lcd_panel_id =3D =
LCD_PANEL_ID1_800X600;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; lvds_setting_info.LCDDualEdge =3D =
0;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 lvds_setting_info.LCDDithering =3D =
1;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 return(VIA_RES_800X600);<BR>+&nbsp;&nbsp;&nbsp; }<BR>+}<BR>+<BR>+void =
lvds_register_write(int index, u8 data)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; =
u8&nbsp; tmp;<BR>+<BR>+&nbsp;&nbsp;&nbsp; tmp =3D =
chip_info.tv_chip_info.tv_chip_on_slot;<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
chip_info.tv_chip_info.tv_chip_on_slot =3D =
TV_ON_AGP;<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
i2cWriteByte(chip_info.lvds_chip_info.lvds_chip_slave_addr, index, =
data);<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
chip_info.tv_chip_info.tv_chip_on_slot =3D tmp;<BR>+<BR>+}<BR>+<BR>+int =
lvds_register_read(int index)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; u8 =
data;<BR>+&nbsp;&nbsp;&nbsp; int status;<BR>+&nbsp;&nbsp;&nbsp; u8&nbsp; =
tmp;<BR>+<BR>+&nbsp;&nbsp;&nbsp; tmp =3D =
chip_info.tv_chip_info.tv_chip_on_slot;<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
chip_info.tv_chip_info.tv_chip_on_slot =3D =
TV_ON_AGP;<BR>+&nbsp;&nbsp;&nbsp; status =3D =
i2cReadByte((u8)chip_info.lvds_chip_info.lvds_chip_slave_addr, =
(u8)index, &amp;data);<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
chip_info.tv_chip_info.tv_chip_on_slot =3D tmp;<BR>+&nbsp;&nbsp;&nbsp; =
return(data);<BR>+}<BR>+<BR>+void load_lcd_scaling(int set_hres, int =
set_vres, int panel_hres, int panel_vres)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; =
int reg_value =3D 0;<BR>+&nbsp;&nbsp;&nbsp; int =
load_reg_num;<BR>+&nbsp;&nbsp;&nbsp; struct io_register *reg =3D =
NULL;<BR>+<BR>+&nbsp;&nbsp;&nbsp; DEBUG_MSG(KERN_INFO =
"load_lcd_scaling()!!\n");<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* LCD Scaling =
Enable */<BR>+&nbsp;&nbsp;&nbsp; write_reg_mask(CR79, VIACR, 0x07, =
BIT0+BIT1+BIT2);<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Modified form X driver =
code.P4M900_A0's scaling register has a =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; little problem on reading it. =
So we use another method to access it. */<BR>+&nbsp;&nbsp;&nbsp; if =
(UNICHROME_P4M900 =3D=3D chip_info.gfx_chip_name)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
load_scaling_factor_for_p4m900(set_hres, set_vres, panel_hres, =
panel_vres);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return;<BR>+&nbsp;&nbsp;&nbsp; }<BR>+<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* =
Check if expansion for horizontal */<BR>+&nbsp;&nbsp;&nbsp; if(set_hres =
!=3D panel_hres)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Load Horizontal =
Scaling Factor */<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
switch(chip_info.gfx_chip_name)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
UNICHROME_CLE266:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; case =
UNICHROME_K400:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_value =3D =
CLE266_LCD_HOR_SCF_FORMULA(set_hres, =
panel_hres);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; load_reg_num =3D =
lcd_scaling_factor_CLE.lcd_hor_scaling_factor.reg_num;<BR>+&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; reg =3D =
lcd_scaling_factor_CLE.lcd_hor_scaling_factor.reg;<BR>+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
load_reg(reg_value, load_reg_num, reg, VIACR);&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; case =
UNICHROME_K800:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; case =
UNICHROME_P880:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; case =
UNICHROME_CN900:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
UNICHROME_CX700:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; case =
UNICHROME_K8M890:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; case =
UNICHROME_P4M890:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_value =3D =
K800_LCD_HOR_SCF_FORMULA(set_hres, =
panel_hres);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg_mask(CRA2, VIACR, 0xC0, =
BIT7+BIT6);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Horizontal scaling =
enabled =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; load_reg_num =3D =
lcd_scaling_factor.lcd_hor_scaling_factor.reg_num;<BR>+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
reg =3D =
lcd_scaling_factor.lcd_hor_scaling_factor.reg;<BR>+&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
load_reg(reg_value, load_reg_num, reg, =
VIACR);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
DEBUG_MSG(KERN_INFO "Horizontal Scaling value =3D %d", =
reg_value);<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; =
else<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg_mask(CRA2, =
VIACR, 0x00, BIT7);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Horizontal scaling =
disabled */<BR>+&nbsp;&nbsp;&nbsp; }<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* =
Check if expansion for vertical */<BR>+&nbsp;&nbsp;&nbsp; if(set_vres =
!=3D panel_vres)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Load Vertical =
Scaling Factor */<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
switch(chip_info.gfx_chip_name)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
UNICHROME_CLE266:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; case =
UNICHROME_K400:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_value =3D =
CLE266_LCD_VER_SCF_FORMULA(set_vres, =
panel_vres);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; load_reg_num =3D =
lcd_scaling_factor_CLE.lcd_ver_scaling_factor.reg_num;<BR>+&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; reg =3D =
lcd_scaling_factor_CLE.lcd_ver_scaling_factor.reg;<BR>+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
load_reg(reg_value, load_reg_num, reg, VIACR); =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; case =
UNICHROME_K800:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; case =
UNICHROME_P880:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; case =
UNICHROME_CN900:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>+&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
UNICHROME_CX700:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; case =
UNICHROME_K8M890:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; case =
UNICHROME_P4M890:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_value =3D =
K800_LCD_VER_SCF_FORMULA(set_vres, =
panel_vres);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg_mask(CRA2, VIACR, 0x08, =
BIT3);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Vertical scaling enabled =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; load_reg_num =3D =
lcd_scaling_factor.lcd_ver_scaling_factor.reg_num;<BR>+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
reg =3D =
lcd_scaling_factor.lcd_ver_scaling_factor.reg;<BR>+&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
load_reg(reg_value, load_reg_num, reg, =
VIACR);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
DEBUG_MSG(KERN_INFO "Vertical Scaling value =3D %d", =
reg_value);<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; =
else<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg_mask(CRA2, =
VIACR, 0x00, BIT3);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Vertical scaling =
disabled */<BR>+&nbsp;&nbsp;&nbsp; }<BR>+}<BR>+<BR>+void =
load_lcd_k400_patch_tbl(int set_hres, int set_vres, int =
panel_id)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; int =
vmode_index;<BR>+&nbsp;&nbsp;&nbsp; int =
reg_num=3D0;<BR>+&nbsp;&nbsp;&nbsp; struct io_reg =
*lcd_patch_reg=3DNULL;<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
if(lvds_setting_info.iga_path=3D=3DIGA2)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vmode_index =3D get_mode_index(set_hres, =
set_vres,1);<BR>+&nbsp;&nbsp;&nbsp; =
else<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vmode_index =3D =
get_mode_index(set_hres, set_vres,0);<BR>+&nbsp;&nbsp;&nbsp; =
switch(panel_id) {<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* LCD =
800x600 */<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
LCD_PANEL_ID1_800X600:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; switch(vmode_index) =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; case =
VIA_RES_640X400:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VIA_RES_640X480:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_num =
=3D =
NUM_TOTAL_K400_LCD_RES_6X4_8X6;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; lcd_patch_reg =3D =
K400_LCD_RES_6X4_8X6;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VIA_RES_720X480:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VIA_RES_720X576:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_num =
=3D =
NUM_TOTAL_K400_LCD_RES_7X4_8X6;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; lcd_patch_reg =3D =
K400_LCD_RES_7X4_8X6;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; }<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* LCD =
1024x768 */<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
LCD_PANEL_ID2_1024X768:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; switch(vmode_index) =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; case =
VIA_RES_640X400:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VIA_RES_640X480:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_num =
=3D =
NUM_TOTAL_K400_LCD_RES_6X4_10X7;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; lcd_patch_reg =3D =
K400_LCD_RES_6X4_10X7;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VIA_RES_720X480:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VIA_RES_720X576:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_num =
=3D =
NUM_TOTAL_K400_LCD_RES_7X4_10X7;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; lcd_patch_reg =3D =
K400_LCD_RES_7X4_10X7;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VIA_RES_800X600:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_num =
=3D =
NUM_TOTAL_K400_LCD_RES_8X6_10X7;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; lcd_patch_reg =3D =
K400_LCD_RES_8X6_10X7;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; }<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* LCD =
1280x1024 */<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
LCD_PANEL_ID4_1280X1024:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; switch(vmode_index) =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; case =
VIA_RES_640X400:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VIA_RES_640X480:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_num =
=3D =
NUM_TOTAL_K400_LCD_RES_6X4_12X10;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; lcd_patch_reg =3D =
K400_LCD_RES_6X4_12X10;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VIA_RES_720X480:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VIA_RES_720X576:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_num =
=3D =
NUM_TOTAL_K400_LCD_RES_7X4_12X10;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; lcd_patch_reg =3D =
K400_LCD_RES_7X4_12X10;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VIA_RES_800X600:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_num =
=3D =
NUM_TOTAL_K400_LCD_RES_8X6_12X10;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; lcd_patch_reg =3D =
K400_LCD_RES_8X6_12X10;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VIA_RES_1024X768:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_num =
=3D =
NUM_TOTAL_K400_LCD_RES_10X7_12X10;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; lcd_patch_reg =3D =
K400_LCD_RES_10X7_12X10;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* LCD =
1400x1050 */<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
LCD_PANEL_ID5_1400X1050:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =
switch(vmode_index)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; case =
VIA_RES_640X480:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_num =
=3D =
NUM_TOTAL_K400_LCD_RES_6X4_14X10;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; lcd_patch_reg =3D =
K400_LCD_RES_6X4_14X10;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VIA_RES_800X600:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_num =
=3D =
NUM_TOTAL_K400_LCD_RES_8X6_14X10;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; lcd_patch_reg =3D =
K400_LCD_RES_8X6_14X10;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VIA_RES_1024X768:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_num =
=3D =
NUM_TOTAL_K400_LCD_RES_10X7_14X10;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; lcd_patch_reg =3D =
K400_LCD_RES_10X7_14X10;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VIA_RES_1280X768:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VIA_RES_1280X960:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VIA_RES_1280X1024:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_num =
=3D =
NUM_TOTAL_K400_LCD_RES_12X10_14X10;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; lcd_patch_reg =3D =
K400_LCD_RES_12X10_14X10;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* LCD =
1600x1200 */<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
LCD_PANEL_ID6_1600X1200:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; switch(vmode_index) =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; case =
VIA_RES_640X400:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VIA_RES_640X480:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_num =
=3D =
NUM_TOTAL_K400_LCD_RES_6X4_16X12;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; lcd_patch_reg =3D =
K400_LCD_RES_6X4_16X12;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VIA_RES_720X480:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VIA_RES_720X576:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_num =
=3D =
NUM_TOTAL_K400_LCD_RES_7X4_16X12;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; lcd_patch_reg =3D =
K400_LCD_RES_7X4_16X12;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VIA_RES_800X600:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_num =
=3D =
NUM_TOTAL_K400_LCD_RES_8X6_16X12;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; lcd_patch_reg =3D =
K400_LCD_RES_8X6_16X12;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VIA_RES_1024X768:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_num =
=3D =
NUM_TOTAL_K400_LCD_RES_10X7_16X12;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; lcd_patch_reg =3D =
K400_LCD_RES_10X7_16X12;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VIA_RES_1280X768:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VIA_RES_1280X960:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VIA_RES_1280X1024:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_num =
=3D =
NUM_TOTAL_K400_LCD_RES_12X10_16X12;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; lcd_patch_reg =3D =
K400_LCD_RES_12X10_16X12;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; }<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; if (reg_num =
!=3D 0)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* H.W. Reset : ON =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg_mask(CR17, =
VIACR, 0x00, BIT7);<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_regx(lcd_patch_reg, =
reg_num);<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* H.W. =
Reset : OFF */<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_reg_mask(CR17, VIACR, 0x80, =
BIT7);<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Reset PLL =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg_mask(SR40, =
VIASR, 0x02, BIT1);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_reg_mask(SR40, VIASR, 0x00, =
BIT1);<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Fire! =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; outb(inb(VIARMisc) | =
(BIT2+BIT3), VIAWMisc);<BR>+&nbsp;&nbsp;&nbsp; }<BR>+}<BR>+<BR>+void =
load_lcd_p880_patch_tbl(int set_hres, int set_vres, int =
panel_id)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; int =
vmode_index;<BR>+&nbsp;&nbsp;&nbsp; int =
reg_num=3D0;<BR>+&nbsp;&nbsp;&nbsp; struct io_reg =
*lcd_patch_reg=3DNULL;<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
if(lvds_setting_info.iga_path=3D=3DIGA2)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vmode_index =3D get_mode_index(set_hres, =
set_vres,1);<BR>+&nbsp;&nbsp;&nbsp; =
else<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vmode_index =3D =
get_mode_index(set_hres, set_vres,0);<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
switch(panel_id) {<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
LCD_PANEL_ID5_1400X1050:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =
switch(vmode_index)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; case =
VIA_RES_640X480:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_num =
=3D =
NUM_TOTAL_P880_LCD_RES_6X4_14X10;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; lcd_patch_reg =3D =
P880_LCD_RES_6X4_14X10;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VIA_RES_800X600:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_num =
=3D =
NUM_TOTAL_P880_LCD_RES_8X6_14X10;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; lcd_patch_reg =3D =
P880_LCD_RES_8X6_14X10;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
LCD_PANEL_ID6_1600X1200:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; switch(vmode_index) =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; case =
VIA_RES_640X400:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VIA_RES_640X480:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_num =
=3D =
NUM_TOTAL_P880_LCD_RES_6X4_16X12;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; lcd_patch_reg =3D =
P880_LCD_RES_6X4_16X12;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VIA_RES_720X480:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VIA_RES_720X576:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_num =
=3D =
NUM_TOTAL_P880_LCD_RES_7X4_16X12;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; lcd_patch_reg =3D =
P880_LCD_RES_7X4_16X12;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VIA_RES_800X600:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_num =
=3D =
NUM_TOTAL_P880_LCD_RES_8X6_16X12;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; lcd_patch_reg =3D =
P880_LCD_RES_8X6_16X12;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VIA_RES_1024X768:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_num =
=3D =
NUM_TOTAL_P880_LCD_RES_10X7_16X12;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; lcd_patch_reg =3D =
P880_LCD_RES_10X7_16X12;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VIA_RES_1280X768:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VIA_RES_1280X960:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VIA_RES_1280X1024:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_num =
=3D =
NUM_TOTAL_P880_LCD_RES_12X10_16X12;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; lcd_patch_reg =3D =
P880_LCD_RES_12X10_16X12;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; }<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; if =
(reg_num !=3D 0)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* H.W. Reset : ON =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg_mask(CR17, =
VIACR, 0x00, BIT7);<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_regx(lcd_patch_reg, =
reg_num);<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* H.W. =
Reset : OFF */<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_reg_mask(CR17, VIACR, 0x80, =
BIT7);<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Reset PLL =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg_mask(SR40, =
VIASR, 0x02, BIT1);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_reg_mask(SR40, VIASR, 0x00, =
BIT1);<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Fire! =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; outb(inb(VIARMisc) | =
(BIT2+BIT3), VIAWMisc);<BR>+&nbsp;&nbsp;&nbsp; }<BR>+}<BR>+<BR>+void =
load_lcd_patch_regs(int set_hres, int set_vres, int panel_id, int =
set_iga)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; int =
vmode_index;<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
if(lvds_setting_info.iga_path=3D=3DIGA2)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vmode_index =3D get_mode_index(set_hres, =
set_vres,1);<BR>+&nbsp;&nbsp;&nbsp; =
else<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vmode_index =3D =
get_mode_index(set_hres, set_vres,0);<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
unlock_crt();<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Patch for simultaneous =
&amp; Expansion */<BR>+&nbsp;&nbsp;&nbsp; if((set_iga =3D=3D IGA1_IGA2) =
&amp;&amp; (lvds_setting_info.display_method =3D=3D =
LCD_EXPANDSION))<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
switch(chip_info.gfx_chip_name) =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
UNICHROME_CLE266:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; case =
UNICHROME_K400:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; load_lcd_k400_patch_tbl(set_hres, =
set_vres, =
panel_id);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; case =
UNICHROME_K800:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; case =
UNICHROME_P880:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; case =
UNICHROME_CN900:&nbsp;&nbsp;&nbsp;&nbsp;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
UNICHROME_CX700:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; load_lcd_p880_patch_tbl(set_hres, =
set_vres, panel_id);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; }<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
lock_crt();<BR>+}<BR>+<BR>+void VIAPitchAlignmentPatchLCD(struct =
lvds_setting_information *plvds_setting_info, struct =
lvds_chip_information *plvds_chip_info)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; =
unsigned char&nbsp;&nbsp;&nbsp;&nbsp; cr13, cr35, cr65, cr66, =
cr67;<BR>+&nbsp;&nbsp;&nbsp; unsigned long&nbsp;&nbsp;&nbsp;&nbsp; =
dwScreenPitch=3D 0;<BR>+&nbsp;&nbsp;&nbsp; unsigned =
long&nbsp;&nbsp;&nbsp;&nbsp; dwPitch;<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
dwPitch =3D plvds_setting_info-&gt;h_active * =
(plvds_setting_info-&gt;bpp &gt;&gt; 3);<BR>+&nbsp;&nbsp;&nbsp; if =
(dwPitch &amp; 0x1F) <BR>+&nbsp;&nbsp; {&nbsp;&nbsp; /* Is 32 Byte =
Alignment ? */<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
dwScreenPitch =3D ((dwPitch + 31) &amp; ~31) &gt;&gt; =
3;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ( =
plvds_setting_info-&gt;iga_path=3D=3DIGA2)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
if(plvds_setting_info-&gt;bpp&gt;8) {&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* When 8bpp 720xX,848xX will not do 32Byte alignment. =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; cr66 =3D (unsigned char)(dwScreenPitch &amp; =
0xFF);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg(CR66, VIACR, =
cr66);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; cr67 =3D read_reg(VIACR, CR67) &amp; =
0xFC;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; cr67 |=3D (unsigned char)((dwScreenPitch =
&amp; 0x300) &gt;&gt; =
8);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; write_reg(CR67, VIACR, =
cr67);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* Fetch Count =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 cr67 =3D read_reg(VIACR, CR67) &amp; =
0xF3;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; cr67 |=3D (unsigned char)((dwScreenPitch &amp; 0x600) &gt;&gt; =
7);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; write_reg(CR67, VIACR, =
cr67);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; cr65 =3D (unsigned char)((dwScreenPitch &gt;&gt; 1) &amp; =
0xFF);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; cr65 +=3D =
2;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 write_reg(CR65, VIACR, =
cr65);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
else<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
if(plvds_setting_info-&gt;bpp&gt;8) {&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* When 8bpp 720xX,848xX will not do 32Byte alignment. =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; cr13 =3D (unsigned char)(dwScreenPitch &amp; =
0xFF);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg(CR13, VIACR, =
cr13);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; cr35 =3D read_reg(VIACR, CR35) &amp; =
0x1F;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; cr35 |=3D (unsigned char)((dwScreenPitch =
&amp; 0x700) &gt;&gt; =
3);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; write_reg(CR35, VIACR, =
cr35);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; }<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; }<BR>+}<BR>+void lcd_patch_skew_dvp0(struct =
lvds_setting_information *plvds_setting_info, struct =
lvds_chip_information *plvds_chip_info)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; =
if(VT1636_LVDS =3D=3D =
plvds_chip_info-&gt;lvds_chip_name)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
switch(chip_info.gfx_chip_name)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
UNICHROME_P4M900:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
vt1636_patch_skew_on_vt3364(plvds_setting_info, =
plvds_chip_info);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; case =
UNICHROME_P4M890:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
vt1636_patch_skew_on_vt3327(plvds_setting_info, =
plvds_chip_info);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; }<BR>+}<BR>+void lcd_patch_skew_dvp1(struct =
lvds_setting_information *plvds_setting_info, struct =
lvds_chip_information *plvds_chip_info)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; =
if(VT1636_LVDS =3D=3D =
plvds_chip_info-&gt;lvds_chip_name)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
switch(chip_info.gfx_chip_name)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
UNICHROME_CX700:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
vt1636_patch_skew_on_vt3324(plvds_setting_info, =
plvds_chip_info);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; }<BR>+}<BR>+void lcd_patch_skew(struct =
lvds_setting_information *plvds_setting_info, struct =
lvds_chip_information *plvds_chip_info)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; =
DEBUG_MSG(KERN_INFO "lcd_patch_skew\n");<BR>+&nbsp;&nbsp;&nbsp; switch =
(plvds_chip_info-&gt;output_interface)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
INTERFACE_DVP0:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; lcd_patch_skew_dvp0(plvds_setting_info, =
plvds_chip_info);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
INTERFACE_DVP1:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; lcd_patch_skew_dvp1(plvds_setting_info, =
plvds_chip_info);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
INTERFACE_DFP_LOW:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; if (UNICHROME_P4M900 =3D=3D =
chip_info.gfx_chip_name)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; write_reg_mask(CR99, VIACR, 0x08, =
BIT0+BIT1+BIT2+BIT3);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp; }<BR>+}<BR>+<BR>+/* LCD Set Mode =
*/<BR>+void lcd_set_mode(struct crt_mode_table *mode_crt_table, struct =
lvds_setting_information *plvds_setting_info, struct =
lvds_chip_information *plvds_chip_info)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; int =
video_index =3D =
plvds_setting_info-&gt;lcd_panel_size;<BR>+&nbsp;&nbsp;&nbsp; int =
set_iga =3D plvds_setting_info-&gt;iga_path;<BR>+&nbsp;&nbsp;&nbsp; int =
mode_bpp =3D plvds_setting_info-&gt;bpp;<BR>+&nbsp;&nbsp;&nbsp; int =
load_reg_num=3D0;<BR>+&nbsp;&nbsp;&nbsp; int =
reg_value=3D0;<BR>+&nbsp;&nbsp;&nbsp; int set_hres, =
set_vres;<BR>+&nbsp;&nbsp;&nbsp; int panel_hres, =
panel_vres;<BR>+&nbsp;&nbsp;&nbsp; u32 pll_D_N;<BR>+&nbsp;&nbsp;&nbsp; =
int offset;<BR>+&nbsp;&nbsp;&nbsp; struct =
io_register&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *reg =3D =
NULL;<BR>+&nbsp;&nbsp;&nbsp; struct display_timing&nbsp;&nbsp; =
mode_crt_reg, panel_crt_reg;<BR>+&nbsp;&nbsp;&nbsp; struct =
crt_mode_table&nbsp;&nbsp; *panel_crt_table;<BR>+&nbsp;&nbsp;&nbsp; =
struct VideoModeTable&nbsp;&nbsp; =
*vmode_tbl;<BR>+<BR>+&nbsp;&nbsp;&nbsp; DEBUG_MSG(KERN_INFO =
"LCD_Set_Mode!, expansion:%d\n", =
plvds_setting_info-&gt;display_method);<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
mode_crt_reg =3D =
mode_crt_table-&gt;crtc;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; /* Get mode table */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
vmode_tbl =3D =
&amp;CLE266Modes[SearchModeSetting(video_index)];&nbsp;&nbsp; /* Get =
panel table */<BR>+&nbsp;&nbsp;&nbsp; panel_crt_table =3D =
vmode_tbl-&gt;crtc;<BR>+&nbsp;&nbsp;&nbsp; panel_crt_reg =3D =
panel_crt_table-&gt;crtc;<BR>+<BR>+&nbsp;&nbsp;&nbsp; set_hres =3D =
plvds_setting_info-&gt;h_active;<BR>+&nbsp;&nbsp;&nbsp; set_vres =3D =
plvds_setting_info-&gt;v_active;<BR>+&nbsp;&nbsp;&nbsp; panel_hres =3D =
plvds_setting_info-&gt;lcd_panel_hres;<BR>+&nbsp;&nbsp;&nbsp; panel_vres =
=3D plvds_setting_info-&gt;lcd_panel_vres;<BR>+&nbsp;&nbsp;&nbsp; =
if(VT1636_LVDS =3D=3D =
plvds_chip_info-&gt;lvds_chip_name)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
init_lvds_vt1636(plvds_setting_info, =
plvds_chip_info);<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; =
plvds_setting_info-&gt;vclk =3D =
panel_crt_table-&gt;clk;<BR>+&nbsp;&nbsp;&nbsp; if (set_iga =3D=3D =
IGA1)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA1 doesn't have =
LCD scaling, so set it as centering. =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
load_crtc_timing(lcd_centering_timging(mode_crt_reg, panel_crt_reg), =
IGA1);<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; =
else<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Expansion =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
((plvds_setting_info-&gt;display_method =3D=3D LCD_EXPANDSION) =
&amp;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ((set_hres !=3D panel_hres ) || (set_vres !=3D =
panel_vres)))<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* expansion timing IGA2 always loaded panel set timing =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 load_crtc_timing(panel_crt_reg, =
IGA2);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; load_lcd_scaling(set_hres, set_vres, panel_hres, =
panel_vres);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else /* Centering =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* centering timing IGA2 always loaded panel and mode releative timing =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 load_crtc_timing(lcd_centering_timging(mode_crt_reg, panel_crt_reg), =
IGA2);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; write_reg_mask(CR79, VIACR, 0x00, =
BIT0+BIT1+BIT2);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* LCD scaling disabled =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; }<BR>+<BR>+&nbsp;&nbsp;&nbsp; if (set_iga =
=3D=3D IGA1_IGA2)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
load_crtc_shadow_timing(mode_crt_reg, =
panel_crt_reg);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Fill shadow =
registers */<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
switch(plvds_setting_info-&gt;lcd_panel_id)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
LCD_PANEL_ID0_640X480:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset =3D =
80;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; case =
LCD_PANEL_ID1_800X600:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset =3D =
110;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; case =
LCD_PANEL_ID2_1024X768:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset =3D =
150;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; case =
LCD_PANEL_ID3_1280X768:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case =
LCD_PANEL_ID4_1280X1024:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; case =
LCD_PANEL_ID5_1400X1050:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset =3D =
190;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; case =
LCD_PANEL_ID6_1600X1200:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset =3D =
250;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; case =
LCD_PANEL_ID7_1366X768:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset =3D =
212;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; =
default:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset =3D =
140;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Offset for =
simultaneous */<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_value =
=3D offset;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; load_reg_num =
=3D =
offset_reg.iga2_offset_reg.reg_num;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; reg =3D =
offset_reg.iga2_offset_reg.reg;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; load_reg(reg_value, load_reg_num, reg, =
VIACR);<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
load_fetch_count_reg(set_hres, 4, =
IGA2);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Fetch count for simultaneous*/<BR>+&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; else&nbsp; /* SAMM */<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
load_offset_reg(set_hres, mode_bpp/8, =
set_iga);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Offset for IGA2 =
only */<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
load_fetch_count_reg(set_hres, mode_bpp/8, =
set_iga);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; /* Fetch count for IGA2 only =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
if((chip_info.gfx_chip_name !=3D UNICHROME_CLE266) &amp;&amp; =
(chip_info.gfx_chip_name !=3D =
UNICHROME_K400))<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; load_FIFO_reg(set_iga, set_hres, =
set_vres);<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
set_color_depth(mode_bpp/8, =
set_iga);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; }<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
fill_lcd_format();<BR>+<BR>+&nbsp;&nbsp;&nbsp; pll_D_N =3D =
get_clk_value(panel_crt_table[0].clk);<BR>+&nbsp;&nbsp;&nbsp; =
DEBUG_MSG(KERN_INFO "PLL=3D0x%x", pll_D_N);<BR>+&nbsp;&nbsp;&nbsp; =
SetVCLK(pll_D_N, set_iga);<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
set_output_path(DEVICE_LCD, set_iga, =
plvds_chip_info-&gt;output_interface);<BR>+&nbsp;&nbsp;&nbsp; =
lcd_patch_skew(plvds_setting_info, =
plvds_chip_info);<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* If K8M800, enable LCD =
Prefetch Mode. */<BR>+&nbsp;&nbsp;&nbsp; if((chip_info.gfx_chip_name =
=3D=3D UNICHROME_K800) || (UNICHROME_K8M890 =3D=3D =
chip_info.gfx_chip_name))<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg_mask(CR6A, =
VIACR, 0x01, BIT0);<BR>+&nbsp;&nbsp;&nbsp; }<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
load_lcd_patch_regs(set_hres, set_vres, =
plvds_setting_info-&gt;lcd_panel_id, =
set_iga);<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Patch for non 32bit alignment =
mode */<BR>+&nbsp;&nbsp;&nbsp; =
VIAPitchAlignmentPatchLCD(plvds_setting_info, =
plvds_chip_info);<BR>+}<BR>+<BR>+void integrated_lvds_disable(struct =
lvds_setting_information *plvds_setting_info, struct =
lvds_chip_information *plvds_chip_info)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; =
bool turn_off_first_powersequence =3D FALSE;<BR>+&nbsp;&nbsp;&nbsp; bool =
turn_off_second_powersequence =3D FALSE;<BR>+&nbsp;&nbsp; =
if(INTERFACE_LVDS0LVDS1 =3D=3D =
plvds_chip_info-&gt;output_interface)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
turn_off_first_powersequence =3D TRUE;<BR>+&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; if(INTERFACE_LVDS0 =3D=3D =
plvds_chip_info-&gt;output_interface)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
turn_off_first_powersequence =3D TRUE;<BR>+&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; if(INTERFACE_LVDS1 =3D=3D =
plvds_chip_info-&gt;output_interface)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
turn_off_second_powersequence =3D TRUE;<BR>+&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; if =
(turn_off_second_powersequence)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Use second power =
sequence control: */<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Turn off power sequence. =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg_mask(CRD4, =
VIACR, 0, BIT1);<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
Turn off back light. */<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_reg_mask(CRD3, VIACR, 0xC0, BIT6+BIT7);<BR>+&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; =
if(turn_off_first_powersequence)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Use first power =
sequence control: */<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Turn off power sequence. =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg_mask(CR6A, =
VIACR, 0, BIT3);<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
Turn off back light. */<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_reg_mask(CR91, VIACR, 0xC0, BIT6+BIT7);<BR>+&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Turn DFP High/Low Pad off. =
*/<BR>+&nbsp;&nbsp;&nbsp; write_reg_mask(SR2A, VIASR, 0, =
BIT0+BIT1+BIT2+BIT3);<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Power off LVDS =
channel. */<BR>+&nbsp;&nbsp;&nbsp; switch =
(plvds_chip_info-&gt;output_interface)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
INTERFACE_LVDS0:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_reg_mask(CRD2, VIACR, 0x80, =
BIT7);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
INTERFACE_LVDS1:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_reg_mask(CRD2, VIACR, 0x40, =
BIT6);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
INTERFACE_LVDS0LVDS1:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_reg_mask(CRD2, VIACR, 0xC0, =
BIT6+BIT7);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; }<BR>+}<BR>+<BR>+void =
integrated_lvds_enable(struct lvds_setting_information =
*plvds_setting_info, struct lvds_chip_information =
*plvds_chip_info)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; bool =
turn_on_first_powersequence =3D FALSE;<BR>+&nbsp;&nbsp;&nbsp; bool =
turn_on_second_powersequence =3D FALSE;<BR>+&nbsp;&nbsp;&nbsp; =
DEBUG_MSG(KERN_INFO "integrated_lvds_enable, out_interface:%d\n", =
plvds_chip_info-&gt;output_interface);<BR>+&nbsp;&nbsp;&nbsp; /* Panel =
mode for VT3324 integrated LVDS. */<BR>+&nbsp;&nbsp;&nbsp; if =
(plvds_setting_info-&gt;lcd_mode =3D=3D LCD_SPWG)<BR>+&nbsp;&nbsp;&nbsp; =
{&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; &nbsp;write_reg_mask(CRD2, VIACR, 0x00, =
BIT0+BIT1);<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; else /* =
lcd_mode =3D=3D OPEN LDI */<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp; &nbsp;write_reg_mask(CRD2, VIACR, 0x03, =
BIT0+BIT1);<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; =
if(INTERFACE_LVDS0LVDS1 =3D=3D =
plvds_chip_info-&gt;output_interface)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
turn_on_first_powersequence =3D TRUE;<BR>+&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; if(INTERFACE_LVDS0 =3D=3D =
plvds_chip_info-&gt;output_interface)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
turn_on_first_powersequence =3D TRUE;<BR>+&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; if(INTERFACE_LVDS1 =3D=3D =
plvds_chip_info-&gt;output_interface)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
turn_on_second_powersequence =3D TRUE;<BR>+&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; if =
(turn_on_second_powersequence)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Use second power =
sequence control: */<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Use hardware control =
power sequence. */<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_reg_mask(CRD3, VIACR, 0, =
BIT0);<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Turn on =
back light. */<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_reg_mask(CRD3, VIACR, 0, =
BIT6+BIT7);<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Turn =
on hardware power sequence. =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg_mask(CRD4, =
VIACR, 0x02, BIT1);<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; =
if(turn_on_first_powersequence)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Use first power =
sequence control: */<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Use hardware control =
power sequence. */<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_reg_mask(CR91, VIACR, 0, =
BIT0);<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Turn on =
back light. */<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_reg_mask(CR91, VIACR, 0, =
BIT6+BIT7);<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Turn =
on hardware power sequence. =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg_mask(CR6A, =
VIACR, 0x08, BIT3);<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; /* Turn DFP High/Low pad on. =
*/<BR>+&nbsp;&nbsp;&nbsp; write_reg_mask(SR2A, VIASR, 0x0F, =
BIT0+BIT1+BIT2+BIT3);<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Power on LVDS =
channel. */<BR>+&nbsp;&nbsp;&nbsp; switch =
(plvds_chip_info-&gt;output_interface)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
INTERFACE_LVDS0:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_reg_mask(CRD2, VIACR, 0, =
BIT7);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
INTERFACE_LVDS1:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_reg_mask(CRD2, VIACR, 0, =
BIT6);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
INTERFACE_LVDS0LVDS1:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_reg_mask(CRD2, VIACR, 0, =
BIT6+BIT7);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; }<BR>+}<BR>+<BR>+void =
lcd_disable(void)<BR>+{<BR>+<BR>+&nbsp;&nbsp;&nbsp; if =
(chip_info.gfx_chip_name =3D=3D UNICHROME_CLE266)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
LCDPowerSequenceOff();<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_reg_mask(SR1E, VIASR, 0x00, =
0x30);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* DI1 pad =
off&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; */<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; else =
if(chip_info.gfx_chip_name =3D=3D =
UNICHROME_CX700)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (LCD2_ON &amp;&amp; =
(INTEGRATED_LVDS =3D=3D =
chip_info.lvds_chip_info2.lvds_chip_name))<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
integrated_lvds_disable(&amp;lvds_setting_info2, =
&amp;chip_info.lvds_chip_info2);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; }<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(INTEGRATED_LVDS =3D=3D =
chip_info.lvds_chip_info.lvds_chip_name)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
integrated_lvds_disable(&amp;lvds_setting_info, =
&amp;chip_info.lvds_chip_info);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; }<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (VT1636_LVDS =
=3D=3D =
chip_info.lvds_chip_info.lvds_chip_name)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
disable_lvds_vt1636(&amp;lvds_setting_info, =
&amp;chip_info.lvds_chip_info);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; }<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; else =
if(VT1636_LVDS =3D=3D =
chip_info.lvds_chip_info.lvds_chip_name)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
disable_lvds_vt1636(&amp;lvds_setting_info, =
&amp;chip_info.lvds_chip_info);<BR>+&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; else<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg_mask(SR2A, =
VIASR, 0x00, 0x0F);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* DFP-HL =
pad off&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg_mask(SR3D, =
VIASR, 0x00, 0x20);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
Backlight =
off&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg_mask(CR91, =
VIACR, 0x80, 0x80);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 24 bit =
DI data paht off */<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_reg_mask(CR6B, VIACR, 0x00, =
0x08);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Simultaneout =
disabled&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp; write_reg_mask(CR79, VIACR, 0x00, =
0x01);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Disable expansion bit&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
write_reg_mask(SR16, VIASR, 0x00, =
0x40);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* CRT path set to IGA1&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
write_reg_mask(CR6B, VIACR, 0x00, =
0x08);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Simultaneout disabled&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
write_reg_mask(CR6A, VIACR, 0x00, =
0x80);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* IGA2 path disabled&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+<BR>+}<BR>+<BR>+void =
lcd_enable(void)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; if =
(chip_info.gfx_chip_name =3D=3D UNICHROME_CLE266)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg_mask(SR1E, =
VIASR, 0x30, 0x30);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* DI1 pad =
on&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
LCDPowerSequenceOn();<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; =
else if(chip_info.gfx_chip_name =3D=3D =
UNICHROME_CX700)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (LCD2_ON &amp;&amp; =
(INTEGRATED_LVDS =3D=3D =
chip_info.lvds_chip_info2.lvds_chip_name))<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
integrated_lvds_enable(&amp;lvds_setting_info2, =
&amp;chip_info.lvds_chip_info2);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; }<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(INTEGRATED_LVDS =3D=3D =
chip_info.lvds_chip_info.lvds_chip_name)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
integrated_lvds_enable(&amp;lvds_setting_info, =
&amp;chip_info.lvds_chip_info);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; }<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (VT1636_LVDS =
=3D=3D =
chip_info.lvds_chip_info.lvds_chip_name)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
enable_lvds_vt1636(&amp;lvds_setting_info, =
&amp;chip_info.lvds_chip_info);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; }<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; else =
if(VT1636_LVDS =3D=3D =
chip_info.lvds_chip_info.lvds_chip_name)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
enable_lvds_vt1636(&amp;lvds_setting_info, =
&amp;chip_info.lvds_chip_info);<BR>+&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; else<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg_mask(SR2A, =
VIASR, 0x0F, 0x0F);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* DFP-HL =
pad on&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg_mask(SR3D, =
VIASR, 0x20, 0x20);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
Backlight =
on&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg_mask(CR91, =
VIACR, 0x00, 0x80);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 24 bit =
DI data paht on&nbsp; */<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set data source =
selection bit by iga path =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(lvds_setting_info.iga_path =3D=3D =
IGA1)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_reg_mask(CR97, VIACR, 0x00, 0x10);&nbsp;&nbsp;&nbsp; /* DFP-H set =
to IGA1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 write_reg_mask(CR99, VIACR, 0x00, 0x10);&nbsp;&nbsp;&nbsp; /* DFP-L set =
to IGA1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
else<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_reg_mask(CR97, VIACR, 0x10, 0x10);&nbsp;&nbsp;&nbsp; /* DFP-H set =
to IGA2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 write_reg_mask(CR99, VIACR, 0x10, 0x10);&nbsp;&nbsp;&nbsp; /* DFP-L set =
to IGA2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg_mask(CR6A, =
VIACR, 0x48, 0x48);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* LCD =
enabled&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; }<BR>+<BR>+&nbsp;&nbsp;&nbsp; if =
((lvds_setting_info.iga_path =3D=3D IGA1)||(lvds_setting_info.iga_path =
=3D=3D IGA1_IGA2))<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg_mask(SR16, =
VIASR, 0x40, 0x40);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* CRT =
path set to IGA2&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg_mask(CR6A, =
VIACR, 0x00, 0x80);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 =
path disabled&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; else&nbsp;&nbsp;&nbsp; /* IGA2 =
*/<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg_mask(CR6A, =
VIACR, 0x80, 0x80);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 =
path enabled&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; }<BR>+<BR>+}<BR>+<BR>+void =
LCDPowerSequenceOff(void)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; int&nbsp; i, =
mask, data;<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Software control power =
sequence */<BR>+&nbsp;&nbsp;&nbsp; write_reg_mask(CR91, VIACR, 0x11, =
0x11);<BR>+<BR>+&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; 3; =
i++)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mask =3D =
PowerSequenceOff[0][i];<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
data =3D PowerSequenceOff[1][i] &amp; =
mask;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_reg_mask(CR91, VIACR, (u8)data, =
(u8)mask);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
delays(PowerSequenceOff[2][i]);<BR>+&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Disable LCD */<BR>+&nbsp;&nbsp;&nbsp; =
write_reg_mask(CR6A, VIACR, 0x00, 0x08);<BR>+}<BR>+<BR>+void =
LCDPowerSequenceOn(void)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; int&nbsp; i, mask, =
data;<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Software control power sequence =
*/<BR>+&nbsp;&nbsp;&nbsp; write_reg_mask(CR91, VIACR, 0x11, =
0x11);<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Enable LCD =
*/<BR>+&nbsp;&nbsp;&nbsp; write_reg_mask(CR6A, VIACR, 0x08, =
0x08);<BR>+<BR>+&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; 3; =
i++)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mask =3D =
PowerSequenceOn[0][i];<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; data =3D PowerSequenceOn[1][i] &amp; =
mask;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_reg_mask(CR91, VIACR, (u8)data, =
(u8)mask);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
delays(PowerSequenceOn[2][i]);<BR>+&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp; delays(1);<BR>+}<BR>+<BR>+void =
fill_lcd_format(void)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; u8&nbsp; bdithering =
=3D 0, bdual =3D 0;<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
if(lvds_setting_info.LCDDualEdge)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bdual =3D =
BIT4;<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; =
if(lvds_setting_info.LCDDithering)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bdithering =3D =
BIT0;<BR>+&nbsp;&nbsp;&nbsp; }<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
write_reg_mask(CR88, VIACR, (bdithering | bdual), =
BIT4+BIT0);&nbsp;&nbsp; /* Dual &amp; Dithering */<BR>+}<BR>+<BR>+void =
check_diport_of_integrated_lvds(struct lvds_chip_information =
*plvds_chip_info, struct lvds_setting_information* =
plvds_setting_info)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; /* Determine LCD DI =
Port by hardware layout. */<BR>+&nbsp;&nbsp;&nbsp; switch =
(display_hardware_layout)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
HW_LAYOUT_LCD_ONLY:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
if =
(plvds_setting_info-&gt;LCDDualEdge)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; plvds_chip_info-&gt;output_interface =3D =
INTERFACE_LVDS0LVDS1;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
else<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; plvds_chip_info-&gt;output_interface =3D =
INTERFACE_LVDS0;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
HW_LAYOUT_DVI_ONLY:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
plvds_chip_info-&gt;output_interface =3D =
INTERFACE_NONE;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
HW_LAYOUT_LCD1_LCD2:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
HW_LAYOUT_LCD_EXTERNAL_LCD2:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
plvds_chip_info-&gt;output_interface =3D =
INTERFACE_LVDS0LVDS1;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
HW_LAYOUT_LCD_DVI:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
plvds_chip_info-&gt;output_interface =3D =
INTERFACE_LVDS1;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
default:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
plvds_chip_info-&gt;output_interface =3D =
INTERFACE_LVDS1;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; }<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
DEBUG_MSG(KERN_INFO "Display Hardware Layout: 0x%x, LCD DI Port: =
0x%x\n", display_hardware_layout, =
plvds_chip_info-&gt;output_interface);<BR>+}<BR>+<BR>+void =
init_lvds_output_interface(struct lvds_chip_information =
*plvds_chip_info, struct lvds_setting_information* =
plvds_setting_info)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; if(INTERFACE_NONE !=3D =
plvds_chip_info-&gt;output_interface)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Do nothing, lcd port =
is specified by module parameter =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return;<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; =
switch(plvds_chip_info-&gt;lvds_chip_name)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case&nbsp; =
VT1636_LVDS:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; =
switch(chip_info.gfx_chip_name)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; case =
UNICHROME_CX700:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
plvds_chip_info-&gt;output_interface =3D =
INTERFACE_DVP1;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
UNICHROME_CN900:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
plvds_chip_info-&gt;output_interface =3D =
INTERFACE_DFP_LOW;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =
default:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
plvds_chip_info-&gt;output_interface =3D =
INTERFACE_DVP0;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; <BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Add for VT3324 =
integrated LVDS. */<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
INTEGRATED_LVDS:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; check_diport_of_integrated_lvds(plvds_chip_info, =
plvds_setting_info);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; <BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
default:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; =
switch(chip_info.gfx_chip_name)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; /* Modified from X driver. For the case VT1637 =
(PCIE LVDS Transmitter) =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; on VT3336/VT3327, we should use =
DFP Low to enable LCD. =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FixMe!! We should find a better =
method to do this. =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; case =
UNICHROME_K8M890:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
UNICHROME_P4M900:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
UNICHROME_P4M890:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
plvds_chip_info-&gt;output_interface =3D =
INTERFACE_DFP_LOW;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =
default:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
plvds_chip_info-&gt;output_interface =3D =
INTERFACE_DFP;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp; }<BR>+}<BR>+<BR>+struct display_timing =
lcd_centering_timging(struct display_timing mode_crt_reg, struct =
display_timing panel_crt_reg)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; struct =
display_timing crt_reg;<BR>+<BR>+&nbsp;&nbsp;&nbsp; crt_reg.hor_total =
=3D panel_crt_reg.hor_total;<BR>+&nbsp;&nbsp;&nbsp; crt_reg.hor_addr =3D =
mode_crt_reg.hor_addr;<BR>+&nbsp;&nbsp;&nbsp; crt_reg.hor_blank_start =
=3D (panel_crt_reg.hor_addr - mode_crt_reg.hor_addr)/2 + =
crt_reg.hor_addr;<BR>+&nbsp;&nbsp;&nbsp; crt_reg.hor_blank_end =3D =
panel_crt_reg.hor_blank_end;<BR>+&nbsp;&nbsp;&nbsp; =
crt_reg.hor_sync_start =3D (panel_crt_reg.hor_sync_start - =
panel_crt_reg.hor_blank_start) + =
crt_reg.hor_blank_start;<BR>+&nbsp;&nbsp;&nbsp; crt_reg.hor_sync_end =3D =
panel_crt_reg.hor_sync_end;<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
crt_reg.ver_total =3D panel_crt_reg.ver_total;<BR>+&nbsp;&nbsp;&nbsp; =
crt_reg.ver_addr =3D mode_crt_reg.ver_addr;<BR>+&nbsp;&nbsp;&nbsp; =
crt_reg.ver_blank_start =3D (panel_crt_reg.ver_addr - =
mode_crt_reg.ver_addr)/2 + crt_reg.ver_addr;<BR>+&nbsp;&nbsp;&nbsp; =
crt_reg.ver_blank_end =3D =
panel_crt_reg.ver_blank_end;<BR>+&nbsp;&nbsp;&nbsp; =
crt_reg.ver_sync_start =3D (panel_crt_reg.ver_sync_start - =
panel_crt_reg.ver_blank_start) + =
crt_reg.ver_blank_start;<BR>+&nbsp;&nbsp;&nbsp; crt_reg.ver_sync_end =3D =
panel_crt_reg.ver_sync_end;<BR>+<BR>+&nbsp;&nbsp;&nbsp; return =
crt_reg;<BR>+}<BR>+<BR>+void load_crtc_shadow_timing(struct =
display_timing mode_timing, struct display_timing =
panel_timing)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; struct io_register&nbsp; *reg =
=3D NULL;<BR>+&nbsp;&nbsp;&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; i;<BR>+&nbsp;&nbsp;&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; load_reg_Num =3D 0;<BR>+&nbsp;&nbsp;&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; reg_value =3D 0;<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
if(lvds_setting_info.display_method =3D=3D =
LCD_EXPANDSION)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Expansion =
*/<BR>+&nbsp;&nbsp;&nbsp; {<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
for(i=3D12;i&lt;20;i++)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
switch(i)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
H_TOTAL_SHADOW_INDEX:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_value =3D =
IGA2_HOR_TOTAL_SHADOW_FORMULA(panel_timing.hor_total);<BR>+&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; load_reg_Num =3D =
iga2_shadow_crtc_reg.hor_total_shadow.reg_num;<BR>+&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =
=3D =
iga2_shadow_crtc_reg.hor_total_shadow.reg;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
H_BLANK_END_SHADOW_INDEX:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_value =3D =
IGA2_HOR_BLANK_END_SHADOW_FORMULA(panel_timing.hor_blank_start, =
panel_timing.hor_blank_end);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; load_reg_Num =3D =
iga2_shadow_crtc_reg.hor_blank_end_shadow.reg_num;<BR>+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
reg =3D =
iga2_shadow_crtc_reg.hor_blank_end_shadow.reg;<BR>+&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
V_TOTAL_SHADOW_INDEX:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_value =3D =
IGA2_VER_TOTAL_SHADOW_FORMULA(panel_timing.ver_total);<BR>+&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; load_reg_Num =3D =
iga2_shadow_crtc_reg.ver_total_shadow.reg_num;<BR>+&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =
=3D =
iga2_shadow_crtc_reg.ver_total_shadow.reg;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
V_ADDR_SHADOW_INDEX:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_value =3D =
IGA2_VER_ADDR_SHADOW_FORMULA(panel_timing.ver_addr);<BR>+&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; load_reg_Num =3D =
iga2_shadow_crtc_reg.ver_addr_shadow.reg_num;<BR>+&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =
=3D =
iga2_shadow_crtc_reg.ver_addr_shadow.reg;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
V_BLANK_SATRT_SHADOW_INDEX:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_value =3D =
IGA2_VER_BLANK_START_SHADOW_FORMULA(panel_timing.ver_blank_start);<BR>+&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; load_reg_Num =3D =
iga2_shadow_crtc_reg.ver_blank_start_shadow.reg_num;<BR>+&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; reg =3D =
iga2_shadow_crtc_reg.ver_blank_start_shadow.reg;<BR>+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
V_BLANK_END_SHADOW_INDEX:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_value =3D =
IGA2_VER_BLANK_END_SHADOW_FORMULA(panel_timing.ver_blank_start, =
panel_timing.ver_blank_end);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; load_reg_Num =3D =
iga2_shadow_crtc_reg.ver_blank_end_shadow.reg_num;<BR>+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
reg =3D =
iga2_shadow_crtc_reg.ver_blank_end_shadow.reg;<BR>+&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
V_SYNC_SATRT_SHADOW_INDEX:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_value =3D =
IGA2_VER_SYNC_START_SHADOW_FORMULA(panel_timing.ver_sync_start);<BR>+&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; load_reg_Num =3D =
iga2_shadow_crtc_reg.ver_sync_start_shadow.reg_num;<BR>+&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 reg =3D =
iga2_shadow_crtc_reg.ver_sync_start_shadow.reg;<BR>+&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
V_SYNC_END_SHADOW_INDEX:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_value =3D =
IGA2_VER_SYNC_END_SHADOW_FORMULA(panel_timing.ver_sync_start, =
panel_timing.ver_sync_end);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; load_reg_Num =3D =
iga2_shadow_crtc_reg.ver_sync_end_shadow.reg_num;<BR>+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
reg =3D =
iga2_shadow_crtc_reg.ver_sync_end_shadow.reg;<BR>+&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
load_reg(reg_value, load_reg_Num, reg, =
VIACR);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; else&nbsp;&nbsp;&nbsp; =
/* Centering */<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
for(i=3D12;i&lt;20;i++)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
switch(i)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
H_TOTAL_SHADOW_INDEX:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_value =3D =
IGA2_HOR_TOTAL_SHADOW_FORMULA(panel_timing.hor_total);<BR>+&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; load_reg_Num =3D =
iga2_shadow_crtc_reg.hor_total_shadow.reg_num;<BR>+&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =
=3D =
iga2_shadow_crtc_reg.hor_total_shadow.reg;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
H_BLANK_END_SHADOW_INDEX:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_value =3D =
IGA2_HOR_BLANK_END_SHADOW_FORMULA(panel_timing.hor_blank_start, =
panel_timing.hor_blank_end);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; load_reg_Num =3D =
iga2_shadow_crtc_reg.hor_blank_end_shadow.reg_num;<BR>+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
reg =3D =
iga2_shadow_crtc_reg.hor_blank_end_shadow.reg;<BR>+&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
V_TOTAL_SHADOW_INDEX:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_value =3D =
IGA2_VER_TOTAL_SHADOW_FORMULA(panel_timing.ver_total);<BR>+&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; load_reg_Num =3D =
iga2_shadow_crtc_reg.ver_total_shadow.reg_num;<BR>+&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =
=3D =
iga2_shadow_crtc_reg.ver_total_shadow.reg;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
V_ADDR_SHADOW_INDEX:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_value =3D =
IGA2_VER_ADDR_SHADOW_FORMULA(mode_timing.ver_addr);<BR>+&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 load_reg_Num =3D =
iga2_shadow_crtc_reg.ver_addr_shadow.reg_num;<BR>+&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =
=3D =
iga2_shadow_crtc_reg.ver_addr_shadow.reg;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
V_BLANK_SATRT_SHADOW_INDEX:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_value =3D =
IGA2_VER_BLANK_START_SHADOW_FORMULA(mode_timing.ver_blank_start);<BR>+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; load_reg_Num =3D =
iga2_shadow_crtc_reg.ver_blank_start_shadow.reg_num;<BR>+&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; reg =3D =
iga2_shadow_crtc_reg.ver_blank_start_shadow.reg;<BR>+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
V_BLANK_END_SHADOW_INDEX:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_value =3D =
IGA2_VER_BLANK_END_SHADOW_FORMULA(panel_timing.ver_blank_start, =
panel_timing.ver_blank_end);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; load_reg_Num =3D =
iga2_shadow_crtc_reg.ver_blank_end_shadow.reg_num;<BR>+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
reg =3D =
iga2_shadow_crtc_reg.ver_blank_end_shadow.reg;<BR>+&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
V_SYNC_SATRT_SHADOW_INDEX:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_value =3D =
IGA2_VER_SYNC_START_SHADOW_FORMULA((panel_timing.ver_sync_start - =
panel_timing.ver_blank_start) + (panel_timing.ver_addr - =
mode_timing.ver_addr)/2 + =
mode_timing.ver_addr);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; load_reg_Num =3D =
iga2_shadow_crtc_reg.ver_sync_start_shadow.reg_num;<BR>+&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 reg =3D =
iga2_shadow_crtc_reg.ver_sync_start_shadow.reg;<BR>+&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
V_SYNC_END_SHADOW_INDEX:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_value =3D =
IGA2_VER_SYNC_END_SHADOW_FORMULA((panel_timing.ver_sync_start - =
panel_timing.ver_blank_start) + (panel_timing.ver_addr - =
mode_timing.ver_addr)/2 + mode_timing.ver_addr, =
panel_timing.ver_sync_end);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; load_reg_Num =3D =
iga2_shadow_crtc_reg.ver_sync_end_shadow.reg_num;<BR>+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
reg =3D =
iga2_shadow_crtc_reg.ver_sync_end_shadow.reg;<BR>+&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
load_reg(reg_value, load_reg_Num, reg, =
VIACR);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; }<BR>+}<BR>+<BR>+<BR>+ =
<BR>+/*&nbsp;&nbsp;&nbsp; Purpose:<BR>+ =
*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; To know if current chip are =
mobile.<BR>+ *&nbsp;&nbsp;&nbsp; Parameter:<BR>+ =
*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mobile: a pointer to a =
boolean value which is used to received the mobile status. <BR>+ =
*/<BR>+bool lcd_get_mobile_state(bool* =
mobile)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; unsigned char *romptr, =
*tableptr;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; u8 =
core_base;<BR>+&nbsp;&nbsp;&nbsp; unsigned char* =
biosptr;<BR>+&nbsp;&nbsp;&nbsp; u32 romaddr =3D 0x000C0000; /* Rom =
address */<BR>+&nbsp;&nbsp;&nbsp; u16 start_pattern =3D =
(u16)NULL;<BR>+&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; =
biosptr=3Dioremap(romaddr,0x10000);<BR>+&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; memcpy(&amp;start_pattern, biosptr, =
2);<BR>+&nbsp;&nbsp;&nbsp; if (start_pattern =3D=3D 0xAA55) /* Compare =
pattern */<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Get the start of =
Table */<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; romptr =3D =
biosptr + 0x1B; /* 0x1B means BIOS offset position =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tableptr =3D biosptr + =
*((u16 *)romptr);<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
Get the start of biosver structure =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; romptr =3D tableptr + =
18; /* 18 means BIOS version position. =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; romptr =3D biosptr + =
*((u16 *)romptr);<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
The offset should be 44, but the actual image is less three char. =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; romptr +=3D =
41;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; core_base =3D =
*romptr++;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
if (core_base &amp; 0x8)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*mobile =3D =
FALSE;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
else<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*mobile =3D =
TRUE;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iounmap(biosptr); /* =
release memory */<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
TRUE;&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; =
else<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
iounmap(biosptr);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
FALSE;<BR>+&nbsp;&nbsp;&nbsp; }<BR>+}<BR>+<BR>+/* Modified form X driver =
code to support P4M900 */<BR>+void load_scaling_factor_for_p4m900(int =
set_hres, int set_vres, int panel_hres, int =
panel_vres)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp; =
h_scaling_factor;<BR>+&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp; =
v_scaling_factor;<BR>+&nbsp;&nbsp;&nbsp; u8&nbsp;&nbsp; cra2 =3D =
0;<BR>+&nbsp;&nbsp;&nbsp; u8&nbsp;&nbsp; cr77 =3D =
0;<BR>+&nbsp;&nbsp;&nbsp; u8&nbsp;&nbsp; cr78 =3D =
0;<BR>+&nbsp;&nbsp;&nbsp; u8&nbsp;&nbsp; cr79 =3D =
0;<BR>+&nbsp;&nbsp;&nbsp; u8&nbsp;&nbsp; cr9f =3D =
0;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Check if expansion =
for horizontal */<BR>+&nbsp;&nbsp;&nbsp; if(set_hres &lt; =
panel_hres)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Load Horizontal =
Scaling Factor */<BR>+&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For VIA_K8M800 or =
later chipsets. */<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
h_scaling_factor =3D K800_LCD_HOR_SCF_FORMULA(set_hres, =
panel_hres);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cr9f =3D =
h_scaling_factor &amp; 0x0003; /* HSCaleFactor[1:0] at CR9F[1:0] =
*/&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cr77 =3D =
(h_scaling_factor &amp; 0x03FC)&gt;&gt;2; /* HSCaleFactor[9:2] at =
CR77[7:0] */&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cr79 =3D =
(h_scaling_factor &amp; 0x0C00)&gt;&gt;10; /* HSCaleFactor[11:10] at =
CR79[5:4] */<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cr79 =
&lt;&lt;=3D 4;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Horizontal scaling =
enabled */<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cra2 =3D =
0xC0;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DEBUG_MSG(KERN_INFO =
"Horizontal Scaling value =3D %d\n", =
h_scaling_factor);<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; =
else<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Horizontal scaling =
disabled */<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cra2 =3D =
0x00;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; /* Check if =
expansion for vertical */<BR>+&nbsp;&nbsp;&nbsp; if(set_vres &lt; =
panel_vres)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Load Vertical =
Scaling Factor */<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For VIA_K8M800 or =
later chipsets. */<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
v_scaling_factor =3D K800_LCD_VER_SCF_FORMULA(set_vres, =
panel_vres);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Vertical scaling =
enabled */<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cra2 |=3D =
0x08;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cr79 |=3D =
((v_scaling_factor &amp; 0x0001)&lt;&lt;3); /* VSCaleFactor[0] at =
CR79[3] =
*/&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cr78 =
|=3D (v_scaling_factor &amp; 0x01FE) &gt;&gt; 1; /* VSCaleFactor[8:1] at =
CR78[7:0] */&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cr79 |=3D =
((v_scaling_factor &amp; 0x0600) &gt;&gt; 9) &lt;&lt; 6; /* =
VSCaleFactor[10:9] at CR79[7:6] =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DEBUG_MSG(KERN_INFO =
"Vertical Scaling value =3D %d\n", =
v_scaling_factor);<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; =
else<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Vertical scaling =
disabled */<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cra2 |=3D =
0x00;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp; write_reg_mask(CRA2, VIACR, cra2, =
BIT3+BIT6+BIT7);<BR>+&nbsp;&nbsp;&nbsp; write_reg_mask(CR77, VIACR, =
cr77, 0xFF);<BR>+&nbsp;&nbsp;&nbsp; write_reg_mask(CR78, VIACR, cr78, =
0xFF);<BR>+&nbsp;&nbsp;&nbsp; write_reg_mask(CR79, VIACR, cr79, =
0xF8);<BR>+&nbsp;&nbsp;&nbsp; write_reg_mask(CR9F, VIACR, cr9f, =
BIT0+BIT1);<BR>+}<BR>+<BR>diff -Nur =
linux-2.6.21-rc7/drivers/video/via/lcd.h =
linux-2.6.21-rc7.viafb/drivers/video/via/lcd.h<BR>--- =
linux-2.6.21-rc7/drivers/video/via/lcd.h&nbsp;1969-12-31 =
19:00:00.000000000 -0500<BR>+++ =
linux-2.6.21-rc7.viafb/drivers/video/via/lcd.h&nbsp;2007-04-26 =
19:52:32.000000000 -0400<BR>@@ -0,0 +1,57 @@<BR>+ /*<BR>+ * Copyright =
1998-2007 VIA Technologies, Inc. All Rights Reserved.<BR>+ * Copyright =
2001-2007 S3 Graphics, Inc. All Rights Reserved.<BR>+ *<BR>+ * =
Permission is hereby granted, free of charge, to any person obtaining =
a<BR>+ * copy of this software and associated documentation files (the =
"Software"),<BR>+ * to deal in the Software without restriction, =
including without limitation<BR>+ * the rights to use, copy, modify, =
merge, publish, distribute, sub license,<BR>+ * and/or sell copies of =
the Software, and to permit persons to whom the<BR>+ * Software is =
furnished to do so, subject to the following conditions:<BR>+ *<BR>+ * =
The above copyright notice and this permission notice (including =
the<BR>+ * next paragraph) shall be included in all copies or =
substantial portions<BR>+ * of the Software.<BR>+ *<BR>+ * THE SOFTWARE =
IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR<BR>+ * =
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF =
MERCHANTABILITY,<BR>+ * FITNESS FOR A PARTICULAR PURPOSE AND =
NON-INFRINGEMENT. IN NO EVENT SHALL<BR>+ * THE AUTHOR(S) OR COPYRIGHT =
HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR<BR>+ * OTHER LIABILITY, =
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,<BR>+ * ARISING =
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER<BR>+ =
* DEALINGS IN THE SOFTWARE.<BR>+ */<BR>+ <BR>+<BR>+#ifndef =
__LCD_H__<BR>+#define __LCD_H__<BR>+<BR>+/* Definition TMDS Device ID =
register */<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VT1631_DEVICE_ID_REG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x02<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VT1631_DEVICE_ID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 0x92<BR>+<BR>+<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VT3271_DEVICE_ID_REG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x02<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VT3271_DEVICE_ID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 0x71<BR>+<BR>+<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
GET_LCD_SIZE_BY_SYSTEM_BIOS&nbsp;&nbsp;&nbsp;&nbsp; =
0x01<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
GET_LCD_SIZE_BY_VGA_BIOS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x02<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
GET_LCD_SZIE_BY_HW_STRAPPING&nbsp;&nbsp;&nbsp; =
0x03<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
GET_LCD_SIZE_BY_USER_SETTING&nbsp;&nbsp;&nbsp; =
0x04<BR>+<BR>+<BR>+<BR>+/* Definition DVI Panel ID =
*/<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
LCD_PANEL_ID0_640X480&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Resolution: =
640x480,&nbsp;&nbsp; Channel: single, Dithering: Enable =
*/<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
LCD_PANEL_ID1_800X600&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x01&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Resolution: =
800x600,&nbsp;&nbsp; Channel: single, Dithering: Enable =
*/<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
LCD_PANEL_ID2_1024X768&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x02&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Resolution: =
1024x768,&nbsp; Channel: single, Dithering: Enable =
*/<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
LCD_PANEL_ID3_1280X768&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x03&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Resolution: =
1280x768,&nbsp; Channel: single, Dithering: Enable =
*/<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
LCD_PANEL_ID4_1280X1024&nbsp;&nbsp;&nbsp;&nbsp; =
0x04&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Resolution: 1280x1024, =
Channel: dual,&nbsp;&nbsp; Dithering: Enable =
*/<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
LCD_PANEL_ID5_1400X1050&nbsp;&nbsp;&nbsp;&nbsp; =
0x05&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Resolution: 1400x1050, =
Channel: dual,&nbsp;&nbsp; Dithering: Enable =
*/<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
LCD_PANEL_ID6_1600X1200&nbsp;&nbsp;&nbsp;&nbsp; =
0x06&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Resolution: 1600x1200, =
Channel: dual,&nbsp;&nbsp; Dithering: Enable =
*/<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
LCD_PANEL_ID7_1366X768&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x07&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Resolution: =
1366x768,&nbsp; Channel: single, Dithering: Disable =
*/<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
LCD_PANEL_ID8_1024X600&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x08&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Resolution: =
1024x600,&nbsp; Channel: single, Dithering: Enable */&nbsp; =
<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
LCD_PANEL_ID9_1280X800&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x09&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Resolution: =
1280x800,&nbsp; Channel: single, Dithering: Enable */&nbsp; =
<BR>+<BR>+#endif /* __LCD_H__ */<BR>diff -Nur =
linux-2.6.21-rc7/drivers/video/via/lcdtbl.h =
linux-2.6.21-rc7.viafb/drivers/video/via/lcdtbl.h<BR>--- =
linux-2.6.21-rc7/drivers/video/via/lcdtbl.h&nbsp;1969-12-31 =
19:00:00.000000000 -0500<BR>+++ =
linux-2.6.21-rc7.viafb/drivers/video/via/lcdtbl.h&nbsp;2007-04-26 =
19:52:32.000000000 -0400<BR>@@ -0,0 +1,303 @@<BR>+ /*<BR>+ * Copyright =
1998-2007 VIA Technologies, Inc. All Rights Reserved.<BR>+ * Copyright =
2001-2007 S3 Graphics, Inc. All Rights Reserved.<BR>+ *<BR>+ * =
Permission is hereby granted, free of charge, to any person obtaining =
a<BR>+ * copy of this software and associated documentation files (the =
"Software"),<BR>+ * to deal in the Software without restriction, =
including without limitation<BR>+ * the rights to use, copy, modify, =
merge, publish, distribute, sub license,<BR>+ * and/or sell copies of =
the Software, and to permit persons to whom the<BR>+ * Software is =
furnished to do so, subject to the following conditions:<BR>+ *<BR>+ * =
The above copyright notice and this permission notice (including =
the<BR>+ * next paragraph) shall be included in all copies or =
substantial portions<BR>+ * of the Software.<BR>+ *<BR>+ * THE SOFTWARE =
IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR<BR>+ * =
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF =
MERCHANTABILITY,<BR>+ * FITNESS FOR A PARTICULAR PURPOSE AND =
NON-INFRINGEMENT. IN NO EVENT SHALL<BR>+ * THE AUTHOR(S) OR COPYRIGHT =
HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR<BR>+ * OTHER LIABILITY, =
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,<BR>+ * ARISING =
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER<BR>+ =
* DEALINGS IN THE SOFTWARE.<BR>+ */<BR>+ <BR>+<BR>+#ifndef =
__LCDTBL_H__<BR>+#define __LCDTBL_H__<BR>+<BR>+#include =
"share.h"<BR>+<BR>+/* CLE266 Software Power Sequence */<BR>+/* {Mask}, =
{Data}, {Delay} */<BR>+int PowerSequenceOn[3][3] =3D {{0x10, 0x08, =
0x06}, {0x10, 0x08, 0x06}, {0x19, 0x1FE, 0x01}};<BR>+int =
PowerSequenceOff[3][3] =3D {{0x06, 0x08, 0x10}, {0x00, 0x00, 0x00}, =
{0xD2, 0x19, 0x01}};<BR>+<BR>+/* ++++++ P880 ++++++ =
*/<BR>+/*&nbsp;&nbsp; Panel 1600x1200&nbsp;&nbsp; */<BR>+struct io_reg =
P880_LCD_RES_6X4_16X12[]&nbsp; =3D {<BR>+&nbsp; =
{VIACR,CR50,0xFF,0x73},{VIACR,CR55,0x0F,0x08},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal =
Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIACR,CR53,0xFF,0x73},{VIACR,CR54,0x38,0x00},{VIACR,CR5D,0x40,0x40},/* =
IGA2 Horizontal Blank End&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIACR,CR6D,0xFF,0x5A},{VIACR,CR71,0x08,0x00},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal Total =
Shadow&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp; =
{VIACR,CR6E,0xFF,0x5E},&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; /* IGA2 Horizontal Blank End Shadow */<BR>+&nbsp; =
{VIACR,CR66,0xFF,0xD6},{VIACR,CR67,0x03,0x00},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 =
Offset&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIASR,SR44,0xFF,0x7D},{VIASR,SR45,0xFF,0x8C},{VIASR,SR46,0xFF,0x02} /* =
VCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+};<BR>+#define =
NUM_TOTAL_P880_LCD_RES_6X4_16X12 =
ARRAY_SIZE(P880_LCD_RES_6X4_16X12)<BR>+<BR>+struct io_reg =
P880_LCD_RES_7X4_16X12[]&nbsp; =3D {<BR>+&nbsp; =
{VIACR,CR50,0xFF,0x67},{VIACR,CR55,0x0F,0x08},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal =
Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIACR,CR53,0xFF,0x67},{VIACR,CR54,0x38,0x00},{VIACR,CR5D,0x40,0x40},/* =
IGA2 Horizontal Blank End&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIACR,CR6D,0xFF,0x74},{VIACR,CR71,0x08,0x00},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal Total =
Shadow&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp; =
{VIACR,CR6E,0xFF,0x78},&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; /* IGA2 Horizontal Blank End Shadow */ <BR>+&nbsp; =
{VIACR,CR66,0xFF,0xF5},{VIACR,CR67,0x03,0x00},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 =
Offset&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIASR,SR44,0xFF,0x78},{VIASR,SR45,0xFF,0x8C},{VIASR,SR46,0xFF,0x01} /* =
VCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+};<BR>+#define =
NUM_TOTAL_P880_LCD_RES_7X4_16X12 =
ARRAY_SIZE(P880_LCD_RES_7X4_16X12)<BR>+<BR>+struct io_reg =
P880_LCD_RES_8X6_16X12[]&nbsp; =3D {<BR>+&nbsp; =
{VIACR,CR50,0xFF,0x65},{VIACR,CR55,0x0F,0x08},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal =
Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIACR,CR53,0xFF,0x65},{VIACR,CR54,0x38,0x00},{VIACR,CR5D,0x40,0x40},/* =
IGA2 Horizontal Blank End&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIACR,CR6D,0xFF,0x7F},{VIACR,CR71,0x08,0x00},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal Total =
Shadow&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp; =
{VIACR,CR6E,0xFF,0x83},&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; /* IGA2 Horizontal Blank End Shadow */<BR>+&nbsp; =
{VIACR,CR66,0xFF,0xE1},{VIACR,CR67,0x03,0x00},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 =
Offset&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIASR,SR44,0xFF,0x6D},{VIASR,SR45,0xFF,0x88},{VIASR,SR46,0xFF,0x03} /* =
VCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+};<BR>+#define =
NUM_TOTAL_P880_LCD_RES_8X6_16X12 =
ARRAY_SIZE(P880_LCD_RES_8X6_16X12)<BR>+<BR>+struct io_reg =
P880_LCD_RES_10X7_16X12[]&nbsp; =3D {<BR>+&nbsp; =
{VIACR,CR50,0xFF,0x65},{VIACR,CR55,0x0F,0x08},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal =
Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIACR,CR53,0xFF,0x65},{VIACR,CR54,0x38,0x00},{VIACR,CR5D,0x40,0x40},/* =
IGA2 Horizontal Blank End&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIACR,CR6D,0xFF,0xAB},{VIACR,CR71,0x08,0x00},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal Total =
Shadow&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp; =
{VIACR,CR6E,0xFF,0xAF},&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; /* IGA2 Horizontal Blank End Shadow */<BR>+&nbsp; =
{VIACR,CR66,0xFF,0xF0},{VIACR,CR67,0x03,0x00},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 =
Offset&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIASR,SR44,0xFF,0x92},{VIASR,SR45,0xFF,0x88},{VIASR,SR46,0xFF,0x03} /* =
VCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+};<BR>+#define =
NUM_TOTAL_P880_LCD_RES_10X7_16X12 =
ARRAY_SIZE(P880_LCD_RES_10X7_16X12)<BR>+<BR>+struct io_reg =
P880_LCD_RES_12X10_16X12[]&nbsp; =3D {<BR>+&nbsp; =
{VIACR,CR50,0xFF,0x7D},{VIACR,CR55,0x0F,0x08},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal =
Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIACR,CR53,0xFF,0x7D},{VIACR,CR54,0x38,0x00},{VIACR,CR5D,0x40,0x40},/* =
IGA2 Horizontal Blank End&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIACR,CR6D,0xFF,0xD0},{VIACR,CR71,0x08,0x00},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal Total =
Shadow&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp; =
{VIACR,CR6E,0xFF,0xD4},&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; /* IGA2 Horizontal Blank End Shadow */<BR>+&nbsp; =
{VIACR,CR66,0xFF,0xFA},{VIACR,CR67,0x03,0x00},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 =
Offset&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIASR,SR44,0xFF,0xF6},{VIASR,SR45,0xFF,0x88},{VIASR,SR46,0xFF,0x05} /* =
VCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+};<BR>+#define =
NUM_TOTAL_P880_LCD_RES_12X10_16X12 =
ARRAY_SIZE(P880_LCD_RES_12X10_16X12)<BR>+<BR>+/*&nbsp;&nbsp; Panel =
1400x1050&nbsp;&nbsp; */<BR>+static struct io_reg =
P880_LCD_RES_6X4_14X10[]&nbsp;&nbsp;&nbsp; =3D =
{&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
640x480&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; */<BR>+&nbsp; =
{VIACR,CR50,0xFF,0x9D},{VIACR,CR55,0x0F,0x56},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal =
Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIACR,CR53,0xFF,0x9D},{VIACR,CR54,0x38,0x75},{VIACR,CR5D,0x40,0x24}, /* =
IGA2 Horizontal Blank End&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIACR,CR6D,0xFF,0x5F},{VIACR,CR71,0x08,0x44},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal Total =
Shadow&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp; =
{VIACR,CR6E,0xFF,0x63},&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* IGA2 Horizontal Blank End Shadow */<BR>+&nbsp; =
{VIACR,CR66,0xFF,0xB4},{VIACR,CR67,0x03,0x00},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 =
Offset&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIASR,SR44,0xFF,0xC6},{VIASR,SR45,0xFF,0x8C},{VIASR,SR46,0xFF,0x05}&nbsp=
; /* =
VCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+};<BR>+#define =
NUM_TOTAL_P880_LCD_RES_6X4_14X10 =
ARRAY_SIZE(P880_LCD_RES_6X4_14X10)<BR>+<BR>+static struct io_reg =
P880_LCD_RES_8X6_14X10[]&nbsp;&nbsp;&nbsp; =3D =
{&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
800x600&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; */<BR>+&nbsp; =
{VIACR,CR50,0xFF,0x9D},{VIACR,CR55,0x0F,0x56},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal =
Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIACR,CR53,0xFF,0x9D},{VIACR,CR54,0x38,0x75},{VIACR,CR5D,0x40,0x24}, /* =
IGA2 Horizontal Blank End&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIACR,CR6D,0xFF,0x7F},{VIACR,CR71,0x08,0x44},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal Total =
Shadow&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp; =
{VIACR,CR6E,0xFF,0x83},&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* IGA2 Horizontal Blank End Shadow */<BR>+&nbsp; =
{VIACR,CR66,0xFF,0xBE},{VIACR,CR67,0x03,0x00},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 =
Offset&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIASR,SR44,0xFF,0x06},{VIASR,SR45,0xFF,0x8D},{VIASR,SR46,0xFF,0x05}&nbsp=
; /* =
VCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+};<BR>+#define =
NUM_TOTAL_P880_LCD_RES_8X6_14X10 =
ARRAY_SIZE(P880_LCD_RES_8X6_14X10)<BR>+<BR>+<BR>+/* ++++++ K400 ++++++ =
*/<BR>+/*&nbsp;&nbsp; Panel 1600x1200&nbsp;&nbsp; */<BR>+struct io_reg =
K400_LCD_RES_6X4_16X12[]&nbsp; =3D {<BR>+&nbsp; =
{VIACR,CR50,0xFF,0x73},{VIACR,CR55,0x0F,0x08},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal =
Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIACR,CR53,0xFF,0x73},{VIACR,CR54,0x38,0x00},{VIACR,CR5D,0x40,0x40},&nbs=
p; /* IGA2 Horizontal Blank =
End&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp; =
{VIACR,CR6D,0xFF,0x5A},{VIACR,CR71,0x08,0x00},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal Total =
Shadow&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp; =
{VIACR,CR6E,0xFF,0x5E},&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; /* IGA2 Horizontal Blank End Shadow */<BR>+&nbsp; =
{VIACR,CR66,0xFF,0xDA},{VIACR,CR67,0x03,0x00},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 =
Offset&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIASR,SR46,0xFF,0xC4},{VIASR,SR47,0xFF,0x7F}&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
VCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+};<BR>+#define =
NUM_TOTAL_K400_LCD_RES_6X4_16X12 =
ARRAY_SIZE(K400_LCD_RES_6X4_16X12)<BR>+<BR>+struct io_reg =
K400_LCD_RES_7X4_16X12[]&nbsp; =3D {<BR>+&nbsp; =
{VIACR,CR50,0xFF,0x67},{VIACR,CR55,0x0F,0x08},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal =
Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIACR,CR53,0xFF,0x67},{VIACR,CR54,0x38,0x00},{VIACR,CR5D,0x40,0x40},&nbs=
p; /* IGA2 Horizontal Blank =
End&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp; =
{VIACR,CR6D,0xFF,0x74},{VIACR,CR71,0x08,0x00},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal Total =
Shadow&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp; =
{VIACR,CR6E,0xFF,0x78},&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; /* IGA2 Horizontal Blank End Shadow */<BR>+&nbsp; =
{VIACR,CR66,0xFF,0xF5},{VIACR,CR67,0x03,0x00},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 =
Offset&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIASR,SR46,0xFF,0x46},{VIASR,SR47,0xFF,0x3D}&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
VCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+};<BR>+#define =
NUM_TOTAL_K400_LCD_RES_7X4_16X12 =
ARRAY_SIZE(K400_LCD_RES_7X4_16X12)<BR>+<BR>+struct io_reg =
K400_LCD_RES_8X6_16X12[]&nbsp; =3D {<BR>+&nbsp; =
{VIACR,CR50,0xFF,0x65},{VIACR,CR55,0x0F,0x08},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal =
Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIACR,CR53,0xFF,0x65},{VIACR,CR54,0x38,0x00},{VIACR,CR5D,0x40,0x40},&nbs=
p; /* IGA2 Horizontal Blank =
End&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */ <BR>+&nbsp; =
{VIACR,CR6D,0xFF,0x7F},{VIACR,CR71,0x08,0x00},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal Total =
Shadow&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp; =
{VIACR,CR6E,0xFF,0x83},&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; /* IGA2 Horizontal Blank End Shadow */<BR>+&nbsp; =
{VIACR,CR66,0xFF,0xE1},{VIACR,CR67,0x03,0x00},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 =
Offset&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIASR,SR46,0xFF,0x85},{VIASR,SR47,0xFF,0x6F}&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
VCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+};<BR>+#define =
NUM_TOTAL_K400_LCD_RES_8X6_16X12 =
ARRAY_SIZE(K400_LCD_RES_8X6_16X12)<BR>+<BR>+struct io_reg =
K400_LCD_RES_10X7_16X12[]&nbsp; =3D {<BR>+&nbsp; =
{VIACR,CR50,0xFF,0x65},{VIACR,CR55,0x0F,0x08},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal =
Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIACR,CR53,0xFF,0x65},{VIACR,CR54,0x38,0x00},{VIACR,CR5D,0x40,0x40},&nbs=
p; /* IGA2 Horizontal Blank =
End&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */ <BR>+&nbsp; =
{VIACR,CR6D,0xFF,0xAB},{VIACR,CR71,0x08,0x00},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal Total =
Shadow&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp; =
{VIACR,CR6E,0xFF,0xAF},&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; /* IGA2 Horizontal Blank End Shadow */<BR>+&nbsp; =
{VIACR,CR66,0xFF,0xF0},{VIACR,CR67,0x03,0x00},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 =
Offset&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIASR,SR46,0xFF,0x45},{VIASR,SR47,0xFF,0x4A}&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
VCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+};<BR>+#define =
NUM_TOTAL_K400_LCD_RES_10X7_16X12 =
ARRAY_SIZE(K400_LCD_RES_10X7_16X12)<BR>+<BR>+struct io_reg =
K400_LCD_RES_12X10_16X12[]&nbsp; =3D {<BR>+&nbsp; =
{VIACR,CR50,0xFF,0x7D},{VIACR,CR55,0x0F,0x08},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal =
Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIACR,CR53,0xFF,0x7D},{VIACR,CR54,0x38,0x00},{VIACR,CR5D,0x40,0x40},&nbs=
p; /* IGA2 Horizontal Blank =
End&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp; =
{VIACR,CR6D,0xFF,0xD0},{VIACR,CR71,0x08,0x00},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal Total =
Shadow&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp; =
{VIACR,CR6E,0xFF,0xD4},&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; /* IGA2 Horizontal Blank End Shadow */<BR>+&nbsp; =
{VIACR,CR66,0xFF,0xFA},{VIACR,CR67,0x03,0x00},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 =
Offset&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIASR,SR46,0xFF,0x47},{VIASR,SR47,0xFF,0x7C}&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
VCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+};<BR>+#define =
NUM_TOTAL_K400_LCD_RES_12X10_16X12 =
ARRAY_SIZE(K400_LCD_RES_12X10_16X12)<BR>+<BR>+/*&nbsp;&nbsp; Panel =
1400x1050&nbsp;&nbsp; */<BR>+static struct io_reg =
K400_LCD_RES_6X4_14X10[]&nbsp; =3D =
{&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
640x400&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; */<BR>+&nbsp; =
{VIACR,CR50,0xFF,0x9D},{VIACR,CR55,0x0F,0x56},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal =
Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIACR,CR53,0xFF,0x9D},{VIACR,CR54,0x38,0x75},{VIACR,CR5D,0x40,0x24}, /* =
IGA2 Horizontal Blank End&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIACR,CR6D,0xFF,0x5F},{VIACR,CR71,0x08,0x44},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal Total =
Shadow&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp; =
{VIACR,CR6E,0xFF,0x63},&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* IGA2 Horizontal Blank End Shadow */<BR>+&nbsp; =
{VIACR,CR66,0xFF,0xB4},{VIACR,CR67,0x03,0x00},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 =
Offset&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; {VIASR,SR46,0xFF,0x07},{VIASR,SR47,0xFF,0x19} =
&nbsp;&nbsp;&nbsp;/* VCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+};<BR>+#define NUM_TOTAL_K400_LCD_RES_6X4_14X10 =
ARRAY_SIZE(K400_LCD_RES_6X4_14X10)<BR>+<BR>+static struct io_reg =
K400_LCD_RES_8X6_14X10[]&nbsp; =3D =
{&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
800x600&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; */<BR>+&nbsp; =
{VIACR,CR50,0xFF,0x9D},{VIACR,CR55,0x0F,0x56},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal =
Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIACR,CR53,0xFF,0x9D},{VIACR,CR54,0x38,0x75},{VIACR,CR5D,0x40,0x24}, /* =
IGA2 Horizontal Blank End&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIACR,CR6D,0xFF,0x7F},{VIACR,CR71,0x08,0x44},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal Total =
Shadow&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp; =
{VIACR,CR6E,0xFF,0x83},&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* IGA2 Horizontal Blank End Shadow */<BR>+&nbsp; =
{VIACR,CR66,0xFF,0xBE},{VIACR,CR67,0x03,0x00},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 =
Offset&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIASR,SR46,0xFF,0x07},{VIASR,SR47,0xFF,0x21}&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
VCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+};<BR>+#define =
NUM_TOTAL_K400_LCD_RES_8X6_14X10 =
ARRAY_SIZE(K400_LCD_RES_8X6_14X10)<BR>+<BR>+static struct io_reg =
K400_LCD_RES_10X7_14X10[]&nbsp; =3D =
{&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
1024x768&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; */<BR>+&nbsp; =
{VIACR,CR50,0xFF,0x9D},{VIACR,CR55,0x0F,0x56},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal =
Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIACR,CR53,0xFF,0x9D},{VIACR,CR54,0x38,0x75},{VIACR,CR5D,0x40,0x24}, /* =
IGA2 Horizontal Blank End&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIACR,CR6D,0xFF,0xA3},{VIACR,CR71,0x08,0x44},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal Total =
Shadow&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp; =
{VIACR,CR6E,0xFF,0xA7},&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* IGA2 Horizontal Blank End Shadow */<BR>+&nbsp; =
{VIACR,CR66,0xFF,0xC3},{VIACR,CR67,0x03,0x04},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 =
Offset&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIASR,SR46,0xFF,0x05},{VIASR,SR47,0xFF,0x1E}&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
VCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+};<BR>+#define =
NUM_TOTAL_K400_LCD_RES_10X7_14X10 =
ARRAY_SIZE(K400_LCD_RES_10X7_14X10)<BR>+<BR>+static struct io_reg =
K400_LCD_RES_12X10_14X10[]&nbsp; =3D =
{&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 1280x768, 1280x960, =
1280x1024&nbsp;&nbsp;&nbsp; */<BR>+&nbsp; =
{VIACR,CR50,0xFF,0x97},{VIACR,CR55,0x0F,0x56},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal =
Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIACR,CR53,0xFF,0x97},{VIACR,CR54,0x38,0x75},{VIACR,CR5D,0x40,0x24}, /* =
IGA2 Horizontal Blank End&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIACR,CR6D,0xFF,0xCE},{VIACR,CR71,0x08,0x44},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal Total =
Shadow&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp; =
{VIACR,CR6E,0xFF,0xD2},&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* IGA2 Horizontal Blank End Shadow */<BR>+&nbsp; =
{VIACR,CR66,0xFF,0xC9},{VIACR,CR67,0x03,0x04},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 =
Offset&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIASR,SR46,0xFF,0x84},{VIASR,SR47,0xFF,0x79}&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
VCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+};<BR>+#define =
NUM_TOTAL_K400_LCD_RES_12X10_14X10 =
ARRAY_SIZE(K400_LCD_RES_12X10_14X10)<BR>+<BR>+<BR>+/* ++++++ K400 ++++++ =
*/<BR>+/*&nbsp;&nbsp; Panel 1280x1024&nbsp;&nbsp; */<BR>+struct io_reg =
K400_LCD_RES_6X4_12X10[]&nbsp; =3D {<BR>+&nbsp; =
{VIACR,CR50,0xFF,0x9D},{VIACR,CR55,0x0F,0x46},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal =
Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIACR,CR53,0xFF,0x9D},{VIACR,CR54,0x38,0x74},{VIACR,CR5D,0x40,0x1C},&nbs=
p; /* IGA2 Horizontal Blank =
End&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp; =
{VIACR,CR6D,0xFF,0x5F},{VIACR,CR71,0x08,0x34},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal Total =
Shadow&nbsp;&nbsp;&nbsp;&nbsp; */ <BR>+&nbsp; =
{VIACR,CR6E,0xFF,0x63},&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; /* IGA2 Horizontal Blank End Shadow */<BR>+&nbsp; =
{VIACR,CR66,0xFF,0xAA},{VIACR,CR67,0x03,0x00},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 =
Offset&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIASR,SR46,0xFF,0x07},{VIASR,SR47,0xFF,0x19}&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
VCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+};<BR>+#define =
NUM_TOTAL_K400_LCD_RES_6X4_12X10 =
ARRAY_SIZE(K400_LCD_RES_6X4_12X10)<BR>+<BR>+struct io_reg =
K400_LCD_RES_7X4_12X10[]&nbsp; =3D {<BR>+&nbsp; =
{VIACR,CR50,0xFF,0x9D},{VIACR,CR55,0x0F,0x46},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal =
Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIACR,CR53,0xFF,0x9D},{VIACR,CR54,0x38,0x74},{VIACR,CR5D,0x40,0x1C},&nbs=
p; /* IGA2 Horizontal Blank =
End&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp; =
{VIACR,CR6D,0xFF,0x68},{VIACR,CR71,0x08,0x34},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal Total =
Shadow&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp; =
{VIACR,CR6E,0xFF,0x6C},&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; /* IGA2 Horizontal Blank End Shadow */<BR>+&nbsp; =
{VIACR,CR66,0xFF,0xA8},{VIACR,CR67,0x03,0x00},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 =
Offset&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIASR,SR46,0xFF,0x87},{VIASR,SR47,0xFF,0xED}&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
VCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+};<BR>+#define =
NUM_TOTAL_K400_LCD_RES_7X4_12X10 =
ARRAY_SIZE(K400_LCD_RES_7X4_12X10)<BR>+<BR>+struct io_reg =
K400_LCD_RES_8X6_12X10[]&nbsp; =3D {<BR>+&nbsp; =
{VIACR,CR50,0xFF,0x9D},{VIACR,CR55,0x0F,0x46},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal =
Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIACR,CR53,0xFF,0x9D},{VIACR,CR54,0x38,0x74},{VIACR,CR5D,0x40,0x1C},&nbs=
p; /* IGA2 Horizontal Blank =
End&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp; =
{VIACR,CR6D,0xFF,0x7F},{VIACR,CR71,0x08,0x34},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal Total =
Shadow&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp; =
{VIACR,CR6E,0xFF,0x83},&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; /* IGA2 Horizontal Blank End Shadow */<BR>+&nbsp; =
{VIACR,CR66,0xFF,0xBE},{VIACR,CR67,0x03,0x00},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 =
Offset&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIASR,SR46,0xFF,0x07},{VIASR,SR47,0xFF,0x21}&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
VCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+};<BR>+#define =
NUM_TOTAL_K400_LCD_RES_8X6_12X10 =
ARRAY_SIZE(K400_LCD_RES_8X6_12X10)<BR>+<BR>+struct io_reg =
K400_LCD_RES_10X7_12X10[]&nbsp; =3D {<BR>+&nbsp; =
{VIACR,CR50,0xFF,0x9D},{VIACR,CR55,0x0F,0x46},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal =
Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIACR,CR53,0xFF,0x9D},{VIACR,CR54,0x38,0x74},{VIACR,CR5D,0x40,0x1C},&nbs=
p; /* IGA2 Horizontal Blank =
End&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */ <BR>+&nbsp; =
{VIACR,CR6D,0xFF,0xA3},{VIACR,CR71,0x08,0x34},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal Total =
Shadow&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp; =
{VIACR,CR6E,0xFF,0xA7},&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; /* IGA2 Horizontal Blank End Shadow */<BR>+&nbsp; =
{VIACR,CR66,0xFF,0xBE},{VIACR,CR67,0x03,0x04},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 =
Offset&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIASR,SR46,0xFF,0x05},{VIASR,SR47,0xFF,0x1E}&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
VCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+};<BR>+#define =
NUM_TOTAL_K400_LCD_RES_10X7_12X10 =
ARRAY_SIZE(K400_LCD_RES_10X7_12X10)<BR>+<BR>+<BR>+/* ++++++ K400 ++++++ =
*/<BR>+/*&nbsp;&nbsp; Panel 1024x768&nbsp;&nbsp;&nbsp; */<BR>+struct =
io_reg K400_LCD_RES_6X4_10X7[]&nbsp; =3D {<BR>+&nbsp; =
{VIACR,CR50,0xFF,0x47},{VIACR,CR55,0x0F,0x35},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal =
Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp; =
{VIACR,CR53,0xFF,0x47},{VIACR,CR54,0x38,0x2B},{VIACR,CR5D,0x40,0x13},&nbs=
p; /* IGA2 Horizontal Blank =
End&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp; =
{VIACR,CR6D,0xFF,0x60},{VIACR,CR71,0x08,0x23},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal Total =
Shadow&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp; =
{VIACR,CR6E,0xFF,0x64},&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; /* IGA2 Horizontal Blank End Shadow */<BR>+&nbsp; =
{VIACR,CR66,0xFF,0x8C},{VIACR,CR67,0x03,0x00},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 =
Offset&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIASR,SR46,0xFF,0x87},{VIASR,SR47,0xFF,0x4C}&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
VCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+};<BR>+<BR>+#define =
NUM_TOTAL_K400_LCD_RES_6X4_10X7 =
ARRAY_SIZE(K400_LCD_RES_6X4_10X7)<BR>+<BR>+struct io_reg =
K400_LCD_RES_7X4_10X7[]&nbsp; =3D {<BR>+&nbsp; =
{VIACR,CR50,0xFF,0x3B},{VIACR,CR55,0x0F,0x35},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal =
Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/ <BR>+&nbsp; =
{VIACR,CR53,0xFF,0x3B},{VIACR,CR54,0x38,0x2B},{VIACR,CR5D,0x40,0x13},&nbs=
p; /* IGA2 Horizontal Blank =
End&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp; =
{VIACR,CR6D,0xFF,0x71},{VIACR,CR71,0x08,0x23},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal Total =
Shadow&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp; =
{VIACR,CR6E,0xFF,0x75},&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; /* IGA2 Horizontal Blank End Shadow */<BR>+&nbsp; =
{VIACR,CR66,0xFF,0x96},{VIACR,CR67,0x03,0x00},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 =
Offset&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIASR,SR46,0xFF,0x05},{VIASR,SR47,0xFF,0x10}&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
VCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+};<BR>+<BR>+#define =
NUM_TOTAL_K400_LCD_RES_7X4_10X7 =
ARRAY_SIZE(K400_LCD_RES_7X4_10X7)<BR>+<BR>+struct io_reg =
K400_LCD_RES_8X6_10X7[]&nbsp; =3D {<BR>+&nbsp; =
{VIACR,CR50,0xFF,0x37},{VIACR,CR55,0x0F,0x35},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal =
Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIACR,CR53,0xFF,0x37},{VIACR,CR54,0x38,0x2B},{VIACR,CR5D,0x40,0x13},&nbs=
p; /* IGA2 Horizontal Blank =
End&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp; =
{VIACR,CR6D,0xFF,0x7E},{VIACR,CR71,0x08,0x23},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal Total =
Shadow&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp; =
{VIACR,CR6E,0xFF,0x82},&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; /* IGA2 Horizontal Blank End Shadow */<BR>+&nbsp; =
{VIACR,CR66,0xFF,0x8C},{VIACR,CR67,0x03,0x00},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 =
Offset&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIASR,SR46,0xFF,0x84},{VIASR,SR47,0xFF,0xB9}&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
VCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/&nbsp;<BR>+};<BR>+#define NUM_TOTAL_K400_LCD_RES_8X6_10X7 =
ARRAY_SIZE(K400_LCD_RES_8X6_10X7)<BR>+<BR>+/* ++++++ K400 ++++++ =
*/<BR>+/*&nbsp;&nbsp; Panel 800x600&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+struct io_reg K400_LCD_RES_6X4_8X6[]&nbsp; =3D {<BR>+&nbsp; =
{VIACR,CR50,0xFF,0x1A},{VIACR,CR55,0x0F,0x34},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal =
Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/ <BR>+&nbsp; =
{VIACR,CR53,0xFF,0x1A},{VIACR,CR54,0x38,0xE3},{VIACR,CR5D,0x40,0x12},&nbs=
p; /* IGA2 Horizontal Blank =
End&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp; =
{VIACR,CR6D,0xFF,0x5F},{VIACR,CR71,0x08,0x22},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal Total =
Shadow&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp; =
{VIACR,CR6E,0xFF,0x63},&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; /* IGA2 Horizontal Blank End Shadow */<BR>+&nbsp; =
{VIACR,CR66,0xFF,0x6E},{VIACR,CR67,0x03,0x00},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 =
Offset&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIASR,SR46,0xFF,0x86},{VIASR,SR47,0xFF,0xB3}&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
VCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+};<BR>+#define =
NUM_TOTAL_K400_LCD_RES_6X4_8X6 =
ARRAY_SIZE(K400_LCD_RES_6X4_8X6)<BR>+<BR>+struct io_reg =
K400_LCD_RES_7X4_8X6[]&nbsp; =3D {<BR>+&nbsp; =
{VIACR,CR50,0xFF,0x1F},{VIACR,CR55,0x0F,0x34},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal =
Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIACR,CR53,0xFF,0x1F},{VIACR,CR54,0x38,0xE3},{VIACR,CR5D,0x40,0x12},&nbs=
p; /* IGA2 Horizontal Blank =
End&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp; =
{VIACR,CR6D,0xFF,0x7F},{VIACR,CR71,0x08,0x22},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 Horizontal Total =
Shadow&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp; =
{VIACR,CR6E,0xFF,0x83},&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; /* IGA2 Horizontal Blank End Shadow */<BR>+&nbsp; =
{VIACR,CR66,0xFF,0x78},{VIACR,CR67,0x03,0x00},&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IGA2 =
Offset&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp; =
{VIASR,SR46,0xFF,0xC4},{VIASR,SR47,0xFF,0x59}&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
VCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+};<BR>+#define =
NUM_TOTAL_K400_LCD_RES_7X4_8X6 =
ARRAY_SIZE(K400_LCD_RES_7X4_8X6)<BR>+<BR>+#endif /* __LCDTBL_H__ =
*/<BR>diff -Nur linux-2.6.21-rc7/drivers/video/via/Makefile =
linux-2.6.21-rc7.viafb/drivers/video/via/Makefile<BR>--- =
linux-2.6.21-rc7/drivers/video/via/Makefile&nbsp;1969-12-31 =
19:00:00.000000000 -0500<BR>+++ =
linux-2.6.21-rc7.viafb/drivers/video/via/Makefile&nbsp;2007-04-26 =
19:52:32.000000000 -0400<BR>@@ -0,0 +1,7 @@<BR>+#<BR>+# Makefile for the =
VIA framebuffer driver (for Linux Kernel =
2.6)<BR>+#<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+obj-$(CONFIG_FB_VIA) +=3D viafb.o<BR>+<BR>+viafb-objs :=3D =
viafbdev.o hw.o iface.o tv.o via_i2c.o vt1622.o vt1622a.o dvi.o lcd.o =
vt1625.o ioctl.o accel.o via_utility.o IntegratedTV.o vt1636.o<BR>diff =
-Nur linux-2.6.21-rc7/drivers/video/via/share.h =
linux-2.6.21-rc7.viafb/drivers/video/via/share.h<BR>--- =
linux-2.6.21-rc7/drivers/video/via/share.h&nbsp;1969-12-31 =
19:00:00.000000000 -0500<BR>+++ =
linux-2.6.21-rc7.viafb/drivers/video/via/share.h&nbsp;2007-04-26 =
19:58:40.000000000 -0400<BR>@@ -0,0 +1,771 @@<BR>+/*<BR>+ * Copyright =
1998-2007 VIA Technologies, Inc. All Rights Reserved.<BR>+ * Copyright =
2001-2007 S3 Graphics, Inc. All Rights Reserved.<BR>+ *<BR>+ * =
Permission is hereby granted, free of charge, to any person obtaining =
a<BR>+ * copy of this software and associated documentation files (the =
"Software"),<BR>+ * to deal in the Software without restriction, =
including without limitation<BR>+ * the rights to use, copy, modify, =
merge, publish, distribute, sub license,<BR>+ * and/or sell copies of =
the Software, and to permit persons to whom the<BR>+ * Software is =
furnished to do so, subject to the following conditions:<BR>+ *<BR>+ * =
The above copyright notice and this permission notice (including =
the<BR>+ * next paragraph) shall be included in all copies or =
substantial portions<BR>+ * of the Software.<BR>+ *<BR>+ * THE SOFTWARE =
IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR<BR>+ * =
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF =
MERCHANTABILITY,<BR>+ * FITNESS FOR A PARTICULAR PURPOSE AND =
NON-INFRINGEMENT. IN NO EVENT SHALL<BR>+ * THE AUTHOR(S) OR COPYRIGHT =
HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR<BR>+ * OTHER LIABILITY, =
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,<BR>+ * ARISING =
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER<BR>+ =
* DEALINGS IN THE SOFTWARE.<BR>+ */<BR>+<BR>+#ifndef =
__SHARE_H__<BR>+#define __SHARE_H__<BR>+<BR>+#include =
&lt;linux/version.h&gt;<BR>+<BR>+/* Define Return Value */<BR>+#define =
FAIL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -1<BR>+#define =
OK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<BR>+<BR>+/* =
Define Boolean Value */<BR>+#if LINUX_VERSION_CODE &lt; =
KERNEL_VERSION(2,6,19)<BR>+#ifndef bool<BR>+typedef int =
bool;<BR>+#endif<BR>+#endif<BR>+<BR>+#ifndef TRUE<BR>+#define TRUE =
1<BR>+#endif<BR>+<BR>+#ifndef FALSE<BR>+#define FALSE =
0<BR>+#endif<BR>+<BR>+#ifndef NULL<BR>+#define NULL =
0<BR>+#endif<BR>+<BR>+/* Define Bit Field */<BR>+#define =
BIT0&nbsp;&nbsp;&nbsp; 0x01<BR>+#define BIT1&nbsp;&nbsp;&nbsp; =
0x02<BR>+#define BIT2&nbsp;&nbsp;&nbsp; 0x04<BR>+#define =
BIT3&nbsp;&nbsp;&nbsp; 0x08<BR>+#define BIT4&nbsp;&nbsp;&nbsp; =
0x10<BR>+#define BIT5&nbsp;&nbsp;&nbsp; 0x20<BR>+#define =
BIT6&nbsp;&nbsp;&nbsp; 0x40<BR>+#define BIT7&nbsp;&nbsp;&nbsp; =
0x80<BR>+<BR>+/* Video Memory Size */<BR>+#define =
VIDEO_MEMORY_SIZE_16M&nbsp;&nbsp;&nbsp; 0x1000000<BR>+<BR>+/* Definition =
Mode Index */<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VIA_RES_640X480&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VIA_RES_800X600&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VIA_RES_1024X768&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VIA_RES_1152X864&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VIA_RES_1280X1024&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 4<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VIA_RES_1600X1200&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 5<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VIA_RES_1440X1050&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 6<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VIA_RES_1280X768&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VIA_RES_1280X960&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VIA_RES_1920X1440&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 9<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VIA_RES_848X480&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
10<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VIA_RES_1400X1050&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 11<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VIA_RES_720X480&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
12<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VIA_RES_720X576&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
13<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VIA_RES_1024X512&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 14<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VIA_RES_856X480&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
15<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VIA_RES_1024X576&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 16<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VIA_RES_640X400&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
17<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VIA_RES_1280X720&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 18<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VIA_RES_1920X1080&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 19<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VIA_RES_800X480&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
20<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VIA_RES_1368X768&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 21<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VIA_RES_1024X600&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 22<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VIA_RES_1280X800&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 23<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VIA_RES_INVALID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 255<BR>+<BR>+<BR>+/* standard VGA =
IO port */<BR>+#define VIARMisc&nbsp;&nbsp;&nbsp; 0x3CC<BR>+#define =
VIAWMisc&nbsp;&nbsp;&nbsp; 0x3C2<BR>+#define VIAStatus&nbsp;&nbsp; =
0x3DA<BR>+#define VIACR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x3D4<BR>+#define VIASR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x3C4<BR>+#define VIAGR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x3CE<BR>+#define VIAAR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x3C0<BR>+<BR>+#define StdCR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x19<BR>+#define StdSR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x04<BR>+#define StdGR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x09<BR>+#define StdAR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x14<BR>+<BR>+#define PatchCR&nbsp;&nbsp;&nbsp;&nbsp; 11<BR>+<BR>+/* =
Display path */<BR>+#define =
IGA1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<BR>+#define =
IGA2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<BR>+#define =
IGA1_IGA2&nbsp;&nbsp; 3<BR>+<BR>+/* Define Color Depth&nbsp; =
*/<BR>+#define MODE_8BPP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1<BR>+#define MODE_16BPP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<BR>+#define =
MODE_32BPP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4<BR>+<BR>+#define =
GR20&nbsp;&nbsp;&nbsp; 0x20<BR>+#define GR21&nbsp;&nbsp;&nbsp; =
0x21<BR>+#define GR22&nbsp;&nbsp;&nbsp; 0x22<BR>+<BR>+<BR>+/* Sequencer =
Registers */<BR>+#define SR01&nbsp;&nbsp;&nbsp; 0x01<BR>+#define =
SR10&nbsp;&nbsp;&nbsp; 0x10<BR>+#define SR12&nbsp;&nbsp;&nbsp; =
0x12<BR>+#define SR15&nbsp;&nbsp;&nbsp; 0x15<BR>+#define =
SR16&nbsp;&nbsp;&nbsp; 0x16<BR>+#define SR17&nbsp;&nbsp;&nbsp; =
0x17<BR>+#define SR18&nbsp;&nbsp;&nbsp; 0x18<BR>+#define =
SR1B&nbsp;&nbsp;&nbsp; 0x1B<BR>+#define SR1A&nbsp;&nbsp;&nbsp; =
0x1A<BR>+#define SR1C&nbsp;&nbsp;&nbsp; 0x1C<BR>+#define =
SR1D&nbsp;&nbsp;&nbsp; 0x1D<BR>+#define SR1E&nbsp;&nbsp;&nbsp; =
0x1E<BR>+#define SR1F&nbsp;&nbsp;&nbsp; 0x1F<BR>+#define =
SR20&nbsp;&nbsp;&nbsp; 0x20<BR>+#define SR21&nbsp;&nbsp;&nbsp; =
0x21<BR>+#define SR22&nbsp;&nbsp;&nbsp; 0x22<BR>+#define =
SR2A&nbsp;&nbsp;&nbsp; 0x2A<BR>+#define SR2D&nbsp;&nbsp;&nbsp; =
0x2D<BR>+#define SR2E&nbsp;&nbsp;&nbsp; 0x2E<BR>+<BR>+#define =
SR30&nbsp;&nbsp;&nbsp; 0x30<BR>+#define SR39&nbsp;&nbsp;&nbsp; =
0x39<BR>+#define SR3D&nbsp;&nbsp;&nbsp; 0x3D<BR>+#define =
SR3E&nbsp;&nbsp;&nbsp; 0x3E<BR>+#define SR3F&nbsp;&nbsp;&nbsp; =
0x3F<BR>+#define SR40&nbsp;&nbsp;&nbsp; 0x40<BR>+#define =
SR43&nbsp;&nbsp;&nbsp; 0x43<BR>+#define SR44&nbsp;&nbsp;&nbsp; =
0x44<BR>+#define SR45&nbsp;&nbsp;&nbsp; 0x45<BR>+#define =
SR46&nbsp;&nbsp;&nbsp; 0x46<BR>+#define SR47&nbsp;&nbsp;&nbsp; =
0x47<BR>+#define SR48&nbsp;&nbsp;&nbsp; 0x48<BR>+#define =
SR49&nbsp;&nbsp;&nbsp; 0x49<BR>+#define SR4A&nbsp;&nbsp;&nbsp; =
0x4A<BR>+#define SR4B&nbsp;&nbsp;&nbsp; 0x4B<BR>+#define =
SR4C&nbsp;&nbsp;&nbsp; 0x4C<BR>+#define SR52&nbsp;&nbsp;&nbsp; =
0x52<BR>+#define SR5E&nbsp;&nbsp;&nbsp; 0x5E<BR>+#define =
SR65&nbsp;&nbsp;&nbsp; 0x65<BR>+<BR>+<BR>+/* CRT Controller Registers =
*/<BR>+#define CR00&nbsp;&nbsp;&nbsp; 0x00<BR>+#define =
CR01&nbsp;&nbsp;&nbsp; 0x01<BR>+#define CR02&nbsp;&nbsp;&nbsp; =
0x02<BR>+#define CR03&nbsp;&nbsp;&nbsp; 0x03<BR>+#define =
CR04&nbsp;&nbsp;&nbsp; 0x04<BR>+#define CR05&nbsp;&nbsp;&nbsp; =
0x05<BR>+#define CR06&nbsp;&nbsp;&nbsp; 0x06<BR>+#define =
CR07&nbsp;&nbsp;&nbsp; 0x07<BR>+#define CR08&nbsp;&nbsp;&nbsp; =
0x08<BR>+#define CR09&nbsp;&nbsp;&nbsp; 0x09<BR>+#define =
CR0A&nbsp;&nbsp;&nbsp; 0x0A<BR>+#define CR0B&nbsp;&nbsp;&nbsp; =
0x0B<BR>+#define CR0C&nbsp;&nbsp;&nbsp; 0x0C<BR>+#define =
CR0D&nbsp;&nbsp;&nbsp; 0x0D<BR>+#define CR0E&nbsp;&nbsp;&nbsp; =
0x0E<BR>+#define CR0F&nbsp;&nbsp;&nbsp; 0x0F<BR>+#define =
CR10&nbsp;&nbsp;&nbsp; 0x10<BR>+#define CR11&nbsp;&nbsp;&nbsp; =
0x11<BR>+#define CR12&nbsp;&nbsp;&nbsp; 0x12<BR>+#define =
CR13&nbsp;&nbsp;&nbsp; 0x13<BR>+#define CR14&nbsp;&nbsp;&nbsp; =
0x14<BR>+#define CR15&nbsp;&nbsp;&nbsp; 0x15<BR>+#define =
CR16&nbsp;&nbsp;&nbsp; 0x16<BR>+#define CR17&nbsp;&nbsp;&nbsp; =
0x17<BR>+#define CR18&nbsp;&nbsp;&nbsp; 0x18<BR>+<BR>+/* Extend CRT =
Controller Registers */<BR>+#define CR30&nbsp;&nbsp;&nbsp; =
0x30<BR>+#define CR31&nbsp;&nbsp;&nbsp; 0x31<BR>+#define =
CR32&nbsp;&nbsp;&nbsp; 0x32<BR>+#define CR33&nbsp;&nbsp;&nbsp; =
0x33<BR>+#define CR34&nbsp;&nbsp;&nbsp; 0x34<BR>+#define =
CR35&nbsp;&nbsp;&nbsp; 0x35<BR>+#define CR36&nbsp;&nbsp;&nbsp; =
0x36<BR>+#define CR37&nbsp;&nbsp;&nbsp; 0x37<BR>+#define =
CR38&nbsp;&nbsp;&nbsp; 0x38<BR>+#define CR39&nbsp;&nbsp;&nbsp; =
0x39<BR>+#define CR3A&nbsp;&nbsp;&nbsp; 0x3A<BR>+#define =
CR3B&nbsp;&nbsp;&nbsp; 0x3B<BR>+#define CR3C&nbsp;&nbsp;&nbsp; =
0x3C<BR>+#define CR3D&nbsp;&nbsp;&nbsp; 0x3D<BR>+#define =
CR3E&nbsp;&nbsp;&nbsp; 0x3E<BR>+#define CR3F&nbsp;&nbsp;&nbsp; =
0x3F<BR>+#define CR40&nbsp;&nbsp;&nbsp; 0x40<BR>+#define =
CR41&nbsp;&nbsp;&nbsp; 0x41<BR>+#define CR42&nbsp;&nbsp;&nbsp; =
0x42<BR>+#define CR43&nbsp;&nbsp;&nbsp; 0x43<BR>+#define =
CR44&nbsp;&nbsp;&nbsp; 0x44<BR>+#define CR45&nbsp;&nbsp;&nbsp; =
0x45<BR>+#define CR46&nbsp;&nbsp;&nbsp; 0x46<BR>+#define =
CR47&nbsp;&nbsp;&nbsp; 0x47<BR>+#define CR48&nbsp;&nbsp;&nbsp; =
0x48<BR>+#define CR49&nbsp;&nbsp;&nbsp; 0x49<BR>+#define =
CR4A&nbsp;&nbsp;&nbsp; 0x4A<BR>+#define CR4B&nbsp;&nbsp;&nbsp; =
0x4B<BR>+#define CR4C&nbsp;&nbsp;&nbsp; 0x4C<BR>+#define =
CR4D&nbsp;&nbsp;&nbsp; 0x4D<BR>+#define CR4E&nbsp;&nbsp;&nbsp; =
0x4E<BR>+#define CR4F&nbsp;&nbsp;&nbsp; 0x4F<BR>+#define =
CR50&nbsp;&nbsp;&nbsp; 0x50<BR>+#define CR51&nbsp;&nbsp;&nbsp; =
0x51<BR>+#define CR52&nbsp;&nbsp;&nbsp; 0x52<BR>+#define =
CR53&nbsp;&nbsp;&nbsp; 0x53<BR>+#define CR54&nbsp;&nbsp;&nbsp; =
0x54<BR>+#define CR55&nbsp;&nbsp;&nbsp; 0x55<BR>+#define =
CR56&nbsp;&nbsp;&nbsp; 0x56<BR>+#define CR57&nbsp;&nbsp;&nbsp; =
0x57<BR>+#define CR58&nbsp;&nbsp;&nbsp; 0x58<BR>+#define =
CR59&nbsp;&nbsp;&nbsp; 0x59<BR>+#define CR5A&nbsp;&nbsp;&nbsp; =
0x5A<BR>+#define CR5B&nbsp;&nbsp;&nbsp; 0x5B<BR>+#define =
CR5C&nbsp;&nbsp;&nbsp; 0x5C<BR>+#define CR5D&nbsp;&nbsp;&nbsp; =
0x5D<BR>+#define CR5E&nbsp;&nbsp;&nbsp; 0x5E<BR>+#define =
CR5F&nbsp;&nbsp;&nbsp; 0x5F<BR>+#define CR60&nbsp;&nbsp;&nbsp; =
0x60<BR>+#define CR61&nbsp;&nbsp;&nbsp; 0x61<BR>+#define =
CR62&nbsp;&nbsp;&nbsp; 0x62<BR>+#define CR63&nbsp;&nbsp;&nbsp; =
0x63<BR>+#define CR64&nbsp;&nbsp;&nbsp; 0x64<BR>+#define =
CR65&nbsp;&nbsp;&nbsp; 0x65<BR>+#define CR66&nbsp;&nbsp;&nbsp; =
0x66<BR>+#define CR67&nbsp;&nbsp;&nbsp; 0x67<BR>+#define =
CR68&nbsp;&nbsp;&nbsp; 0x68<BR>+#define CR69&nbsp;&nbsp;&nbsp; =
0x69<BR>+#define CR6A&nbsp;&nbsp;&nbsp; 0x6A<BR>+#define =
CR6B&nbsp;&nbsp;&nbsp; 0x6B<BR>+#define CR6C&nbsp;&nbsp;&nbsp; =
0x6C<BR>+#define CR6D&nbsp;&nbsp;&nbsp; 0x6D<BR>+#define =
CR6E&nbsp;&nbsp;&nbsp; 0x6E<BR>+#define CR6F&nbsp;&nbsp;&nbsp; =
0x6F<BR>+#define CR70&nbsp;&nbsp;&nbsp; 0x70<BR>+#define =
CR71&nbsp;&nbsp;&nbsp; 0x71<BR>+#define CR72&nbsp;&nbsp;&nbsp; =
0x72<BR>+#define CR73&nbsp;&nbsp;&nbsp; 0x73<BR>+#define =
CR74&nbsp;&nbsp;&nbsp; 0x74<BR>+#define CR75&nbsp;&nbsp;&nbsp; =
0x75<BR>+#define CR76&nbsp;&nbsp;&nbsp; 0x76<BR>+#define =
CR77&nbsp;&nbsp;&nbsp; 0x77<BR>+#define CR78&nbsp;&nbsp;&nbsp; =
0x78<BR>+#define CR79&nbsp;&nbsp;&nbsp; 0x79<BR>+#define =
CR7A&nbsp;&nbsp;&nbsp; 0x7A<BR>+#define CR7B&nbsp;&nbsp;&nbsp; =
0x7B<BR>+#define CR7C&nbsp;&nbsp;&nbsp; 0x7C<BR>+#define =
CR7D&nbsp;&nbsp;&nbsp; 0x7D<BR>+#define CR7E&nbsp;&nbsp;&nbsp; =
0x7E<BR>+#define CR7F&nbsp;&nbsp;&nbsp; 0x7F<BR>+#define =
CR80&nbsp;&nbsp;&nbsp; 0x80<BR>+#define CR81&nbsp;&nbsp;&nbsp; =
0x81<BR>+#define CR82&nbsp;&nbsp;&nbsp; 0x82<BR>+#define =
CR83&nbsp;&nbsp;&nbsp; 0x83<BR>+#define CR84&nbsp;&nbsp;&nbsp; =
0x84<BR>+#define CR85&nbsp;&nbsp;&nbsp; 0x85<BR>+#define =
CR86&nbsp;&nbsp;&nbsp; 0x86<BR>+#define CR87&nbsp;&nbsp;&nbsp; =
0x87<BR>+#define CR88&nbsp;&nbsp;&nbsp; 0x88<BR>+#define =
CR89&nbsp;&nbsp;&nbsp; 0x89<BR>+#define CR8A&nbsp;&nbsp;&nbsp; =
0x8A<BR>+#define CR8B&nbsp;&nbsp;&nbsp; 0x8B<BR>+#define =
CR8C&nbsp;&nbsp;&nbsp; 0x8C<BR>+#define CR8D&nbsp;&nbsp;&nbsp; =
0x8D<BR>+#define CR8E&nbsp;&nbsp;&nbsp; 0x8E<BR>+#define =
CR8F&nbsp;&nbsp;&nbsp; 0x8F<BR>+#define CR90&nbsp;&nbsp;&nbsp; =
0x90<BR>+#define CR91&nbsp;&nbsp;&nbsp; 0x91<BR>+#define =
CR92&nbsp;&nbsp;&nbsp; 0x92<BR>+#define CR93&nbsp;&nbsp;&nbsp; =
0x93<BR>+#define CR94&nbsp;&nbsp;&nbsp; 0x94<BR>+#define =
CR95&nbsp;&nbsp;&nbsp; 0x95<BR>+#define CR96&nbsp;&nbsp;&nbsp; =
0x96<BR>+#define CR97&nbsp;&nbsp;&nbsp; 0x97<BR>+#define =
CR98&nbsp;&nbsp;&nbsp; 0x98<BR>+#define CR99&nbsp;&nbsp;&nbsp; =
0x99<BR>+#define CR9A&nbsp;&nbsp;&nbsp; 0x9A<BR>+#define =
CR9B&nbsp;&nbsp;&nbsp; 0x9B<BR>+#define CR9C&nbsp;&nbsp;&nbsp; =
0x9C<BR>+#define CR9D&nbsp;&nbsp;&nbsp; 0x9D<BR>+#define =
CR9E&nbsp;&nbsp;&nbsp; 0x9E<BR>+#define CR9F&nbsp;&nbsp;&nbsp; =
0x9F<BR>+#define CRA0&nbsp;&nbsp;&nbsp; 0xA0<BR>+#define =
CRA1&nbsp;&nbsp;&nbsp; 0xA1<BR>+#define CRA2&nbsp;&nbsp;&nbsp; =
0xA2<BR>+#define CRA3&nbsp;&nbsp;&nbsp; 0xA3<BR>+#define =
CRD2&nbsp;&nbsp;&nbsp; 0xD2<BR>+#define CRD3&nbsp;&nbsp;&nbsp; =
0xD3<BR>+#define CRD4&nbsp;&nbsp;&nbsp; 0xD4<BR>+<BR>+/* LUT =
Table*/<BR>+#define =
LUT_DATA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; 0x3C9&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* DACDATA =
*/<BR>+#define LUT_INDEX_READ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x3C7&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* DACRX */<BR>+#define =
LUT_INDEX_WRITE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x3C8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* DACWX */<BR>+#define =
DACMASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; 0x3C6<BR>+<BR>+/* Definition Device */<BR>+#define =
DEVICE_CRT&nbsp; 0x01<BR>+#define DEVICE_TV&nbsp;&nbsp; 0x02<BR>+#define =
DEVICE_DVI&nbsp; 0x03<BR>+#define DEVICE_LCD&nbsp; 0x04<BR>+<BR>+/* =
Device output interface */<BR>+#define =
INTERFACE_NONE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00<BR>+#define INTERFACE_ANALOG_RGB&nbsp;&nbsp;&nbsp; 0x01<BR>+#define =
INTERFACE_DVP0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x02<BR>+#define =
INTERFACE_DVP1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x03<BR>+#define INTERFACE_DFP_HIGH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x04<BR>+#define INTERFACE_DFP_LOW&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x05<BR>+#define =
INTERFACE_DFP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 0x06<BR>+#define =
INTERFACE_LVDS0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x07<BR>+#define =
INTERFACE_LVDS1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x08<BR>+#define INTERFACE_LVDS0LVDS1&nbsp;&nbsp;&nbsp; 0x09<BR>+#define =
INTERFACE_TMDS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x0A<BR>+<BR>+/* Hardware layout for internal LVDS/TMDS. */<BR>+#define =
HW_LAYOUT_LCD_ONLY&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x01<BR>+#define =
HW_LAYOUT_DVI_ONLY&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x02<BR>+#define =
HW_LAYOUT_LCD_DVI&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x03<BR>+#define =
HW_LAYOUT_LCD1_LCD2&nbsp;&nbsp;&nbsp;&nbsp; 0x04<BR>+#define =
HW_LAYOUT_LCD_EXTERNAL_LCD2 0x10<BR>+<BR>+/* Definition Refresh Rate =
*/<BR>+#define REFRESH_60&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 60<BR>+#define =
REFRESH_75&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 75<BR>+#define =
REFRESH_85&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 85<BR>+#define =
REFRESH_100&nbsp;&nbsp;&nbsp;&nbsp; 100<BR>+#define =
REFRESH_120&nbsp;&nbsp;&nbsp;&nbsp; 120<BR>+<BR>+/* Definition Sync =
Polarity */<BR>+#define =
NEGATIVE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<BR>+#define =
POSITIVE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<BR>+<BR>+/* <A =
href=3D"mailto:640x480@60">640x480@60</A> Sync Polarity (VESA Mode) =
*/<BR>+#define =
M640X480_R60_HSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
NEGATIVE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; <BR>+#define =
M640X480_R60_VSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
NEGATIVE<BR>+<BR>+/* <A href=3D"mailto:640x480@75">640x480@75</A> Sync =
Polarity (VESA Mode) */<BR>+#define =
M640X480_R75_HSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
NEGATIVE<BR>+#define =
M640X480_R75_VSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
NEGATIVE<BR>+<BR>+/* <A href=3D"mailto:640x480@85">640x480@85</A> Sync =
Polarity (VESA Mode) */<BR>+#define =
M640X480_R85_HSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
NEGATIVE<BR>+#define =
M640X480_R85_VSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
NEGATIVE<BR>+<BR>+/* <A href=3D"mailto:640x480@100">640x480@100</A> Sync =
Polarity (GTF Mode) */<BR>+#define =
M640X480_R100_HSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
NEGATIVE<BR>+#define =
M640X480_R100_VSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
POSITIVE<BR>+<BR>+/* <A href=3D"mailto:640x480@120">640x480@120</A> Sync =
Polarity (GTF Mode) */<BR>+#define =
M640X480_R120_HSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
NEGATIVE<BR>+#define =
M640X480_R120_VSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
POSITIVE<BR>+<BR>+/* <A href=3D"mailto:720x480@60">720x480@60</A> Sync =
Polarity&nbsp; (GTF Mode) */<BR>+#define =
M720X480_R60_HSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
NEGATIVE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; <BR>+#define =
M720X480_R60_VSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
POSITIVE<BR>+<BR>+/* <A href=3D"mailto:720x576@60">720x576@60</A> Sync =
Polarity&nbsp; (GTF Mode) */<BR>+#define =
M720X576_R60_HSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
NEGATIVE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; <BR>+#define =
M720X576_R60_VSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
POSITIVE<BR>+<BR>+/* <A href=3D"mailto:800x600@60">800x600@60</A> Sync =
Polarity (VESA Mode) */<BR>+#define =
M800X600_R60_HSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
POSITIVE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; <BR>+#define =
M800X600_R60_VSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
POSITIVE<BR>+<BR>+/* <A href=3D"mailto:800x600@75">800x600@75</A> Sync =
Polarity (VESA Mode) */<BR>+#define =
M800X600_R75_HSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
POSITIVE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; <BR>+#define =
M800X600_R75_VSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
POSITIVE<BR>+<BR>+/* <A href=3D"mailto:800x600@85">800x600@85</A> Sync =
Polarity (VESA Mode) */<BR>+#define =
M800X600_R85_HSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
POSITIVE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; <BR>+#define =
M800X600_R85_VSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
POSITIVE<BR>+<BR>+/* <A href=3D"mailto:800x600@100">800x600@100</A> Sync =
Polarity (GTF Mode) */<BR>+#define =
M800X600_R100_HSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
NEGATIVE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; <BR>+#define M800X600_R100_VSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
POSITIVE<BR>+<BR>+/* <A href=3D"mailto:800x600@120">800x600@120</A> Sync =
Polarity (GTF Mode) */<BR>+#define =
M800X600_R120_HSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
NEGATIVE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; <BR>+#define M800X600_R120_VSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
POSITIVE<BR>+<BR>+/* <A href=3D"mailto:800x480@60">800x480@60</A> Sync =
Polarity&nbsp; (GTF Mode) */<BR>+#define =
M800X480_R60_HSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
NEGATIVE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; <BR>+#define =
M800X480_R60_VSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
POSITIVE<BR>+<BR>+/* <A href=3D"mailto:848x480@60">848x480@60</A> Sync =
Polarity&nbsp; (GTF Mode) */<BR>+#define =
M848X480_R60_HSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
NEGATIVE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; <BR>+#define =
M848X480_R60_VSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
POSITIVE<BR>+<BR>+/* <A href=3D"mailto:852x480@60">852x480@60</A> Sync =
Polarity&nbsp; (GTF Mode) */<BR>+#define =
M852X480_R60_HSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
NEGATIVE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; <BR>+#define =
M852X480_R60_VSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
POSITIVE<BR>+<BR>+/* <A href=3D"mailto:1024x512@60">1024x512@60</A> Sync =
Polarity (GTF Mode) */<BR>+#define =
M1024X512_R60_HSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
NEGATIVE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; <BR>+#define M1024X512_R60_VSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
POSITIVE<BR>+<BR>+/* <A href=3D"mailto:1024x600@60">1024x600@60</A> Sync =
Polarity (GTF Mode) */<BR>+#define =
M1024X600_R60_HSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
NEGATIVE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; <BR>+#define M1024X600_R60_VSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
POSITIVE<BR>+<BR>+<BR>+/* <A href=3D"mailto:1024x768@60">1024x768@60</A> =
Sync Polarity (VESA Mode) */ <BR>+#define =
M1024X768_R60_HSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
NEGATIVE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; <BR>+#define M1024X768_R60_VSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
NEGATIVE<BR>+<BR>+/* <A href=3D"mailto:1024x768@75">1024x768@75</A> Sync =
Polarity (VESA Mode) */<BR>+#define =
M1024X768_R75_HSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
POSITIVE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; <BR>+#define M1024X768_R75_VSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
POSITIVE<BR>+<BR>+/* <A href=3D"mailto:1024x768@85">1024x768@85</A> Sync =
Polarity (VESA Mode) */ <BR>+#define =
M1024X768_R85_HSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
POSITIVE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; <BR>+#define M1024X768_R85_VSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
POSITIVE<BR>+<BR>+/* <A href=3D"mailto:1024x768@100">1024x768@100</A> =
Sync Polarity (GTF Mode) */<BR>+#define =
M1024X768_R100_HSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
NEGATIVE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; <BR>+#define M1024X768_R100_VSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
POSITIVE<BR>+<BR>+/* <A href=3D"mailto:1152x864@75">1152x864@75</A> Sync =
Polarity (VESA Mode) */<BR>+#define =
M1152X864_R75_HSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
POSITIVE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; <BR>+#define M1152X864_R75_VSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
POSITIVE<BR>+<BR>+/* <A href=3D"mailto:1280x720@60">1280x720@60</A> Sync =
Polarity&nbsp; (GTF Mode) */<BR>+#define =
M1280X720_R60_HSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
NEGATIVE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; <BR>+#define M1280X720_R60_VSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
POSITIVE<BR>+<BR>+/* <A href=3D"mailto:1280x768@60">1280x768@60</A> Sync =
Polarity&nbsp; (GTF Mode) */<BR>+#define =
M1280X768_R60_HSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
NEGATIVE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; <BR>+#define M1280X768_R60_VSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
POSITIVE<BR>+<BR>+/* <A href=3D"mailto:1280x800@60">1280x800@60</A> Sync =
Polarity&nbsp; (GTF Mode) */<BR>+#define =
M1280X800_R60_HSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
NEGATIVE<BR>+#define =
M1280X800_R60_VSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
POSITIVE<BR>+<BR>+/* <A href=3D"mailto:1280x960@60">1280x960@60</A> Sync =
Polarity (VESA Mode) */<BR>+#define =
M1280X960_R60_HSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
POSITIVE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; <BR>+#define M1280X960_R60_VSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
POSITIVE<BR>+<BR>+/* <A href=3D"mailto:1280x1024@60">1280x1024@60</A> =
Sync Polarity (VESA Mode) */<BR>+#define =
M1280X1024_R60_HSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
POSITIVE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>+#define =
M1280X1024_R60_VSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; POSITIVE<BR>+<BR>+/* <A =
href=3D"mailto:1368x768@60">1368x768@60</A> Sync Polarity (VESA Mode) =
*/<BR>+#define M1368X768_R60_HSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
NEGATIVE<BR>+#define =
M1368X768_R60_VSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
POSITIVE<BR>+<BR>+/* <A href=3D"mailto:1280x1024@75">1280x1024@75</A> =
Sync Polarity (VESA Mode) */<BR>+#define =
M1280X1024_R75_HSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
POSITIVE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>+#define =
M1280X1024_R75_VSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; POSITIVE <BR>+<BR>+/* =
<A href=3D"mailto:1280x1024@85">1280x1024@85</A> Sync Polarity (VESA =
Mode) */<BR>+#define M1280X1024_R85_HSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
POSITIVE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>+#define =
M1280X1024_R85_VSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; POSITIVE<BR>+<BR>+/* <A =
href=3D"mailto:1440x1050@60">1440x1050@60</A> Sync Polarity (GTF Mode) =
*/<BR>+#define M1440X1050_R60_HSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
NEGATIVE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>+#define =
M1440X1050_R60_VSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; POSITIVE&nbsp; =
<BR>+<BR>+/* <A href=3D"mailto:1600x1200@60">1600x1200@60</A> Sync =
Polarity (VESA Mode) */<BR>+#define =
M1600X1200_R60_HSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
POSITIVE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>+#define =
M1600X1200_R60_VSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
POSITIVE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>+<BR>+/* <A =
href=3D"mailto:1600x1200@75">1600x1200@75</A> Sync Polarity (VESA Mode) =
*/&nbsp;&nbsp;&nbsp; <BR>+#define =
M1600X1200_R75_HSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
POSITIVE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>+#define =
M1600X1200_R75_VSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
POSITIVE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>+<BR>+/* <A =
href=3D"mailto:1920x1080@60">1920x1080@60</A> Sync Polarity (GTF Mode) =
*/<BR>+#define M1920X1080_R60_HSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
NEGATIVE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; <BR>+#define M1920X1080_R60_VSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
POSITIVE<BR>+<BR>+/* <A href=3D"mailto:1920x1440@60">1920x1440@60</A> =
Sync Polarity (VESA Mode) */<BR>+#define =
M1920X1440_R60_HSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
NEGATIVE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; <BR>+#define M1920X1440_R60_VSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; POSITIVE =
<BR>+<BR>+/* <A href=3D"mailto:1920x1440@75">1920x1440@75</A> Sync =
Polarity (VESA Mode) */<BR>+#define =
M1920X1440_R75_HSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
NEGATIVE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; <BR>+#define M1920X1440_R75_VSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
POSITIVE<BR>+<BR>+#if 0<BR>+/* <A =
href=3D"mailto:1400x1050@60">1400x1050@60</A> Sync Polarity (VESA Mode) =
*/<BR>+#define M1400X1050_R60_HSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
NEGATIVE<BR>+#define M1400X1050_R60_VSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
NEGATIVE<BR>+#endif<BR>+<BR>+/* <A =
href=3D"mailto:1400x1050@60">1400x1050@60</A> Sync Polarity (GTF Mode) =
*/<BR>+#define M1400X1050_R60_HSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
NEGATIVE<BR>+#define M1400X1050_R60_VSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
POSITIVE<BR>+<BR>+<BR>+/* define PLL index: */<BR>+#define =
CLK_25_175M&nbsp;&nbsp;&nbsp;&nbsp; 25175000<BR>+#define =
CLK_26_880M&nbsp;&nbsp;&nbsp;&nbsp; 26880000<BR>+#define =
CLK_29_581M&nbsp;&nbsp;&nbsp;&nbsp; 29581000<BR>+#define =
CLK_31_490M&nbsp;&nbsp;&nbsp;&nbsp; 31490000<BR>+#define =
CLK_31_500M&nbsp;&nbsp;&nbsp;&nbsp; 31500000<BR>+#define =
CLK_31_728M&nbsp;&nbsp;&nbsp;&nbsp; 31728000<BR>+#define =
CLK_32_668M&nbsp;&nbsp;&nbsp;&nbsp; 32688000<BR>+#define =
CLK_36_000M&nbsp;&nbsp;&nbsp;&nbsp; 36000000<BR>+#define =
CLK_40_000M&nbsp;&nbsp;&nbsp;&nbsp; 40000000<BR>+#define =
CLK_41_291M&nbsp;&nbsp;&nbsp;&nbsp; 41291000<BR>+#define =
CLK_43_163M&nbsp;&nbsp;&nbsp;&nbsp; 43163000<BR>+/* #define =
CLK_46_996M&nbsp;&nbsp;&nbsp;&nbsp; 46996000 */<BR>+#define =
CLK_48_875M&nbsp;&nbsp;&nbsp;&nbsp; 48875000<BR>+#define =
CLK_49_500M&nbsp;&nbsp;&nbsp;&nbsp; 49500000<BR>+#define =
CLK_52_406M&nbsp;&nbsp;&nbsp;&nbsp; 52406000<BR>+#define =
CLK_56_250M&nbsp;&nbsp;&nbsp;&nbsp; 56250000<BR>+#define =
CLK_65_000M&nbsp;&nbsp;&nbsp;&nbsp; 65000000<BR>+#define =
CLK_68_179M&nbsp;&nbsp;&nbsp;&nbsp; 68179000<BR>+#define =
CLK_78_750M&nbsp;&nbsp;&nbsp;&nbsp; 78750000<BR>+#define =
CLK_80_136M&nbsp;&nbsp;&nbsp;&nbsp; 80136000<BR>+#define =
CLK_83_375M&nbsp;&nbsp;&nbsp;&nbsp; 83375000<BR>+#define =
CLK_83_950M&nbsp;&nbsp;&nbsp;&nbsp; 83950000<BR>+#define =
CLK_85_860M&nbsp;&nbsp;&nbsp;&nbsp; 85860000<BR>+#define =
CLK_94_500M&nbsp;&nbsp;&nbsp;&nbsp; 94500000<BR>+#define =
CLK_108_000M&nbsp;&nbsp;&nbsp; 108000000<BR>+#define =
CLK_125_104M&nbsp;&nbsp;&nbsp; 125104000<BR>+#define =
CLK_133_308M&nbsp;&nbsp;&nbsp; 133308000<BR>+#define =
CLK_135_000M&nbsp;&nbsp;&nbsp; 135000000<BR>+/* #define =
CLK_148_500M&nbsp;&nbsp;&nbsp; 148500000 */<BR>+#define =
CLK_157_500M&nbsp;&nbsp;&nbsp; 157500000<BR>+#define =
CLK_162_000M&nbsp;&nbsp;&nbsp; 162000000<BR>+#define =
CLK_202_500M&nbsp;&nbsp;&nbsp; 202500000<BR>+#define =
CLK_234_000M&nbsp;&nbsp;&nbsp; 234000000<BR>+#define =
CLK_297_500M&nbsp;&nbsp;&nbsp; 297500000<BR>+#define =
CLK_74_481M&nbsp;&nbsp;&nbsp;&nbsp; 74481000<BR>+#define =
CLK_172_798M&nbsp;&nbsp;&nbsp; 172798000<BR>+#define =
CLK_122_614M&nbsp;&nbsp;&nbsp; 122614000<BR>+<BR>+<BR>+/* CLE266 PLL =
value */<BR>+#define CLE266_PLL_25_175M&nbsp;&nbsp;&nbsp;&nbsp; =
0x0000C763<BR>+#define CLE266_PLL_26_880M&nbsp;&nbsp;&nbsp;&nbsp; =
0x0000440F<BR>+#define CLE266_PLL_29_581M&nbsp;&nbsp;&nbsp;&nbsp; =
0x00008421<BR>+#define CLE266_PLL_31_490M&nbsp;&nbsp;&nbsp;&nbsp; =
0x00004721<BR>+#define CLE266_PLL_31_500M&nbsp;&nbsp;&nbsp;&nbsp; =
0x0000C3B5<BR>+#define CLE266_PLL_31_728M&nbsp;&nbsp;&nbsp;&nbsp; =
0x0000471F<BR>+#define CLE266_PLL_32_668M&nbsp;&nbsp;&nbsp;&nbsp; =
0x0000C449<BR>+#define CLE266_PLL_36_000M&nbsp;&nbsp;&nbsp;&nbsp; =
0x0000C5E5<BR>+#define CLE266_PLL_40_000M&nbsp;&nbsp;&nbsp;&nbsp; =
0x0000C459<BR>+#define CLE266_PLL_41_291M&nbsp;&nbsp;&nbsp;&nbsp; =
0x00004417<BR>+#define CLE266_PLL_43_163M&nbsp;&nbsp;&nbsp;&nbsp; =
0x0000C579<BR>+/* #define CLE266_PLL_46_996M&nbsp;&nbsp;&nbsp;&nbsp; =
0x0000C4E9 */<BR>+#define CLE266_PLL_48_875M&nbsp;&nbsp;&nbsp;&nbsp; =
0x00001D63<BR>+#define CLE266_PLL_49_500M&nbsp;&nbsp;&nbsp;&nbsp; =
0x00008653<BR>+#define CLE266_PLL_52_406M&nbsp;&nbsp;&nbsp;&nbsp; =
0x0000C475<BR>+#define CLE266_PLL_56_250M&nbsp;&nbsp;&nbsp;&nbsp; =
0x000047B7<BR>+#define CLE266_PLL_65_000M&nbsp;&nbsp;&nbsp;&nbsp; =
0x000086ED<BR>+#define CLE266_PLL_68_179M&nbsp;&nbsp;&nbsp;&nbsp; =
0x00000413<BR>+#define CLE266_PLL_78_750M&nbsp;&nbsp;&nbsp;&nbsp; =
0x00004321<BR>+#define CLE266_PLL_80_136M&nbsp;&nbsp;&nbsp;&nbsp; =
0x0000051C<BR>+#define CLE266_PLL_83_375M&nbsp;&nbsp;&nbsp;&nbsp; =
0x0000C25D<BR>+#define CLE266_PLL_83_950M&nbsp;&nbsp;&nbsp;&nbsp; =
0x00000729<BR>+#define CLE266_PLL_85_860M&nbsp;&nbsp;&nbsp;&nbsp; =
0x00004754<BR>+#define CLE266_PLL_94_500M&nbsp;&nbsp;&nbsp;&nbsp; =
0x00000521<BR>+#define CLE266_PLL_108_000M&nbsp;&nbsp;&nbsp; =
0x00008479<BR>+#define CLE266_PLL_125_104M&nbsp;&nbsp;&nbsp; =
0x000006B5<BR>+#define CLE266_PLL_133_308M&nbsp;&nbsp;&nbsp; =
0x0000465F<BR>+#define CLE266_PLL_135_000M&nbsp;&nbsp;&nbsp; =
0x0000455E<BR>+/* #define CLE266_PLL_148_500M&nbsp;&nbsp;&nbsp; 0x0000 =
*/<BR>+#define CLE266_PLL_157_500M&nbsp;&nbsp;&nbsp; =
0x000005B7<BR>+#define CLE266_PLL_162_000M&nbsp;&nbsp;&nbsp; =
0x00004571<BR>+#define CLE266_PLL_202_500M&nbsp;&nbsp;&nbsp; =
0x00000763<BR>+#define CLE266_PLL_234_000M&nbsp;&nbsp;&nbsp; =
0x00000662<BR>+#define CLE266_PLL_297_500M&nbsp;&nbsp;&nbsp; =
0x000005E6<BR>+#define CLE266_PLL_74_481M&nbsp;&nbsp;&nbsp;&nbsp; =
0x0000051A<BR>+#define CLE266_PLL_172_798M&nbsp;&nbsp;&nbsp; =
0x00004579<BR>+#define CLE266_PLL_122_614M&nbsp;&nbsp;&nbsp; =
0x0000073C<BR>+<BR>+/*&nbsp; K800 PLL value */<BR>+#define =
K800_PLL_25_175M&nbsp;&nbsp;&nbsp;&nbsp; 0x00539001<BR>+#define =
K800_PLL_26_880M&nbsp;&nbsp;&nbsp;&nbsp; 0x001C8C80<BR>+#define =
K800_PLL_29_581M&nbsp;&nbsp;&nbsp;&nbsp; 0x00409080<BR>+#define =
K800_PLL_31_490M&nbsp;&nbsp;&nbsp;&nbsp; 0x006F9001<BR>+#define =
K800_PLL_31_500M&nbsp;&nbsp;&nbsp;&nbsp; 0x008B9002<BR>+#define =
K800_PLL_31_728M&nbsp;&nbsp;&nbsp;&nbsp; 0x00AF9003<BR>+#define =
K800_PLL_32_668M&nbsp;&nbsp;&nbsp;&nbsp; 0x00909002<BR>+#define =
K800_PLL_36_000M&nbsp;&nbsp;&nbsp;&nbsp; 0x009F9002<BR>+#define =
K800_PLL_40_000M&nbsp;&nbsp;&nbsp;&nbsp; 0x00578C02<BR>+#define =
K800_PLL_41_291M&nbsp;&nbsp;&nbsp;&nbsp; 0x00438C01<BR>+#define =
K800_PLL_43_163M&nbsp;&nbsp;&nbsp;&nbsp; 0x00778C03<BR>+/* #define =
K800_PLL_46_996M&nbsp;&nbsp;&nbsp;&nbsp; 0x00000000 */<BR>+#define =
K800_PLL_48_875M&nbsp;&nbsp;&nbsp;&nbsp; 0x00508C81<BR>+#define =
K800_PLL_49_500M&nbsp;&nbsp;&nbsp;&nbsp; 0x00518C01<BR>+#define =
K800_PLL_52_406M&nbsp;&nbsp;&nbsp;&nbsp; 0x00738C02<BR>+#define =
K800_PLL_56_250M&nbsp;&nbsp;&nbsp;&nbsp; 0x007C8C02<BR>+#define =
K800_PLL_65_000M&nbsp;&nbsp;&nbsp;&nbsp; 0x006B8C01<BR>+#define =
K800_PLL_68_179M&nbsp;&nbsp;&nbsp;&nbsp; 0x00708C01<BR>+#define =
K800_PLL_78_750M&nbsp;&nbsp;&nbsp;&nbsp; 0x00408801<BR>+#define =
K800_PLL_80_136M&nbsp;&nbsp;&nbsp;&nbsp; 0x00428801<BR>+#define =
K800_PLL_83_375M&nbsp;&nbsp;&nbsp;&nbsp; 0x005B0882<BR>+#define =
K800_PLL_83_950M&nbsp;&nbsp;&nbsp;&nbsp; 0x00738803<BR>+#define =
K800_PLL_85_860M&nbsp;&nbsp;&nbsp;&nbsp; 0x00768883<BR>+#define =
K800_PLL_94_500M&nbsp;&nbsp;&nbsp;&nbsp; 0x00828803<BR>+#define =
K800_PLL_108_000M&nbsp;&nbsp;&nbsp; 0x00778882<BR>+#define =
K800_PLL_125_104M&nbsp;&nbsp;&nbsp; 0x00688801<BR>+#define =
K800_PLL_133_308M&nbsp;&nbsp;&nbsp; 0x005D8801<BR>+#define =
K800_PLL_135_000M&nbsp;&nbsp;&nbsp; 0x001A4081<BR>+/* #define =
K800_PLL_148_500M&nbsp;&nbsp;&nbsp; 0x0000 */<BR>+#define =
K800_PLL_157_500M&nbsp;&nbsp;&nbsp; 0x00142080<BR>+#define =
K800_PLL_162_000M&nbsp;&nbsp;&nbsp; 0x006F8483<BR>+#define =
K800_PLL_202_500M&nbsp;&nbsp;&nbsp; 0x00538481<BR>+#define =
K800_PLL_234_000M&nbsp;&nbsp;&nbsp; 0x00608401<BR>+#define =
K800_PLL_297_500M&nbsp;&nbsp;&nbsp; 0x00A48402<BR>+#define =
K800_PLL_74_481M&nbsp;&nbsp;&nbsp;&nbsp; 0x007B8C81<BR>+#define =
K800_PLL_172_798M&nbsp;&nbsp;&nbsp; 0x00778483<BR>+#define =
K800_PLL_122_614M&nbsp;&nbsp;&nbsp; 0x00878882<BR>+<BR>+/* PLL for =
VT3324 */<BR>+#define CX700_25_175M&nbsp;&nbsp;&nbsp;&nbsp; =
0x008B1003<BR>+#define CX700_26_719M&nbsp;&nbsp;&nbsp;&nbsp; =
0x00931003<BR>+#define CX700_26_880M&nbsp;&nbsp;&nbsp;&nbsp; =
0x00941003<BR>+#define CX700_29_581M&nbsp;&nbsp;&nbsp;&nbsp; =
0x00A49003<BR>+#define CX700_31_490M&nbsp;&nbsp;&nbsp;&nbsp; =
0x00AE1003<BR>+#define CX700_31_500M&nbsp;&nbsp;&nbsp;&nbsp; =
0x00AE1003<BR>+#define CX700_31_728M&nbsp;&nbsp;&nbsp;&nbsp; =
0x00AF1003<BR>+#define CX700_32_668M&nbsp;&nbsp;&nbsp;&nbsp; =
0x00B51003<BR>+#define CX700_36_000M&nbsp;&nbsp;&nbsp;&nbsp; =
0x00C81003<BR>+#define CX700_40_000M&nbsp;&nbsp;&nbsp;&nbsp; =
0x006E0C03<BR>+#define CX700_41_291M&nbsp;&nbsp;&nbsp;&nbsp; =
0x00710C03<BR>+#define CX700_43_163M&nbsp;&nbsp;&nbsp;&nbsp; =
0x00770C03<BR>+#define CX700_48_875M&nbsp;&nbsp;&nbsp;&nbsp; =
0x00508C81<BR>+#define CX700_49_500M&nbsp;&nbsp;&nbsp;&nbsp; =
0x00880C03<BR>+#define CX700_52_406M&nbsp;&nbsp;&nbsp;&nbsp; =
0x00730C02<BR>+#define CX700_56_250M&nbsp;&nbsp;&nbsp;&nbsp; =
0x009B0C03<BR>+#define CX700_65_000M&nbsp;&nbsp;&nbsp;&nbsp; =
0x006B0C01<BR>+#define CX700_68_179M&nbsp;&nbsp;&nbsp;&nbsp; =
0x00BC0C03<BR>+#define CX700_74_481M&nbsp;&nbsp;&nbsp;&nbsp; =
0x00CE0C03<BR>+#define CX700_78_750M&nbsp;&nbsp;&nbsp;&nbsp; =
0x006C0803<BR>+#define CX700_80_136M&nbsp;&nbsp;&nbsp;&nbsp; =
0x006E0803<BR>+#define CX700_83_375M&nbsp;&nbsp;&nbsp;&nbsp; =
0x005B0882<BR>+#define CX700_83_950M&nbsp;&nbsp;&nbsp;&nbsp; =
0x00730803<BR>+#define CX700_85_860M&nbsp;&nbsp;&nbsp;&nbsp; =
0x00760803<BR>+#define CX700_94_500M&nbsp;&nbsp;&nbsp;&nbsp; =
0x00820803<BR>+#define CX700_108_000M&nbsp;&nbsp;&nbsp; =
0x00950803<BR>+#define CX700_125_104M&nbsp;&nbsp;&nbsp; =
0x00AD0803<BR>+#define CX700_133_308M&nbsp;&nbsp;&nbsp; =
0x00930802<BR>+#define CX700_135_000M&nbsp;&nbsp;&nbsp; =
0x00950802<BR>+#define CX700_157_500M&nbsp;&nbsp;&nbsp; =
0x006C0403<BR>+#define CX700_162_000M&nbsp;&nbsp;&nbsp; =
0x006F0403<BR>+#define CX700_172_798M&nbsp;&nbsp;&nbsp; =
0x00770403<BR>+#define CX700_202_500M&nbsp;&nbsp;&nbsp; =
0x008C0403<BR>+#define CX700_234_000M&nbsp;&nbsp;&nbsp; =
0x00600401<BR>+#define CX700_297_500M&nbsp;&nbsp;&nbsp; =
0x00CE0403<BR>+#define CX700_122_614M&nbsp;&nbsp;&nbsp; =
0x00870802<BR>+<BR>+/* Definition CRTC Timing Index */<BR>+#define =
H_TOTAL_INDEX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 0<BR>+#define =
H_ADDR_INDEX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<BR>+#define =
H_BLANK_START_INDEX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
2<BR>+#define =
H_BLANK_END_INDEX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 3<BR>+#define =
H_SYNC_START_INDEX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
4<BR>+#define =
H_SYNC_END_INDEX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 5<BR>+#define =
V_TOTAL_INDEX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 6<BR>+#define =
V_ADDR_INDEX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7<BR>+#define =
V_BLANK_START_INDEX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
8<BR>+#define =
V_BLANK_END_INDEX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 9<BR>+#define =
V_SYNC_START_INDEX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
10<BR>+#define =
V_SYNC_END_INDEX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 11<BR>+#define =
H_TOTAL_SHADOW_INDEX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
12<BR>+#define H_BLANK_END_SHADOW_INDEX&nbsp;&nbsp;&nbsp; 13<BR>+#define =
V_TOTAL_SHADOW_INDEX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
14<BR>+#define =
V_ADDR_SHADOW_INDEX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
15<BR>+#define V_BLANK_SATRT_SHADOW_INDEX&nbsp; 16<BR>+#define =
V_BLANK_END_SHADOW_INDEX&nbsp;&nbsp;&nbsp; 17<BR>+#define =
V_SYNC_SATRT_SHADOW_INDEX&nbsp;&nbsp; 18<BR>+#define =
V_SYNC_END_SHADOW_INDEX&nbsp;&nbsp;&nbsp;&nbsp; 19<BR>+<BR>+/* =
Definition Video Mode Pixel Clock (picoseconds) */<BR>+#define =
RES_640X480_60HZ_PIXCLOCK&nbsp;&nbsp;&nbsp; 39722<BR>+#define =
RES_640X480_75HZ_PIXCLOCK&nbsp;&nbsp;&nbsp; 31747<BR>+#define =
RES_640X480_85HZ_PIXCLOCK&nbsp;&nbsp;&nbsp; 27777<BR>+#define =
RES_640X480_100HZ_PIXCLOCK&nbsp;&nbsp; 23168<BR>+#define =
RES_640X480_120HZ_PIXCLOCK&nbsp;&nbsp; 19081<BR>+#define =
RES_720X480_60HZ_PIXCLOCK&nbsp;&nbsp;&nbsp; 37020<BR>+#define =
RES_720X576_60HZ_PIXCLOCK&nbsp;&nbsp;&nbsp; 30611<BR>+#define =
RES_800X600_60HZ_PIXCLOCK&nbsp;&nbsp;&nbsp; 25000<BR>+#define =
RES_800X600_75HZ_PIXCLOCK&nbsp;&nbsp;&nbsp; 20203<BR>+#define =
RES_800X600_85HZ_PIXCLOCK&nbsp;&nbsp;&nbsp; 17777<BR>+#define =
RES_800X600_100HZ_PIXCLOCK&nbsp;&nbsp; 14815<BR>+#define =
RES_800X600_120HZ_PIXCLOCK&nbsp;&nbsp; 11912<BR>+#define =
RES_800X480_60HZ_PIXCLOCK&nbsp;&nbsp;&nbsp; 33805<BR>+#define =
RES_848X480_60HZ_PIXCLOCK&nbsp;&nbsp;&nbsp; 31756<BR>+#define =
RES_856X480_60HZ_PIXCLOCK&nbsp;&nbsp;&nbsp; 31518<BR>+#define =
RES_1024X512_60HZ_PIXCLOCK&nbsp;&nbsp; 24218<BR>+#define =
RES_1024X600_60HZ_PIXCLOCK&nbsp;&nbsp; 20460<BR>+#define =
RES_1024X768_60HZ_PIXCLOCK&nbsp;&nbsp; 15385<BR>+#define =
RES_1024X768_75HZ_PIXCLOCK&nbsp;&nbsp; 12699<BR>+#define =
RES_1024X768_85HZ_PIXCLOCK&nbsp;&nbsp; 10582<BR>+#define =
RES_1024X768_100HZ_PIXCLOCK&nbsp; 9091<BR>+#define =
RES_1152X864_70HZ_PIXCLOCK&nbsp;&nbsp; 10000<BR>+#define =
RES_1152X864_75HZ_PIXCLOCK&nbsp;&nbsp; 9091<BR>+#define =
RES_1280X768_60HZ_PIXCLOCK&nbsp;&nbsp; 12480<BR>+#define =
RES_1280X800_60HZ_PIXCLOCK&nbsp;&nbsp; 11994<BR>+#define =
RES_1280X960_60HZ_PIXCLOCK&nbsp;&nbsp; 9259<BR>+#define =
RES_1280X1024_60HZ_PIXCLOCK&nbsp; 9260<BR>+#define =
RES_1280X1024_75HZ_PIXCLOCK&nbsp; 7408<BR>+#define =
RES_1280X768_85HZ_PIXCLOCK&nbsp;&nbsp; 6349<BR>+#define =
RES_1440X1050_60HZ_PIXCLOCK&nbsp; 7993<BR>+#define =
RES_1600X1200_60HZ_PIXCLOCK&nbsp; 6411<BR>+#define =
RES_1600X1200_75HZ_PIXCLOCK&nbsp; 4938<BR>+#define =
RES_1280X720_60HZ_PIXCLOCK&nbsp;&nbsp; 13426<BR>+#define =
RES_1920X1080_60HZ_PIXCLOCK&nbsp; 5787<BR>+#define =
RES_1400X1050_60HZ_PIXCLOCK&nbsp; 8156<BR>+#define =
RES_1368X768_60HZ_PIXCLOCK&nbsp;&nbsp; 11647<BR>+<BR>+/*&nbsp; LCD =
display method */<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
LCD_EXPANDSION&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 0x00<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
LCD_CENTERING&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 0x01<BR>+<BR>+/*&nbsp; LCD mode =
*/<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
LCD_OPENLDI&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; 0x00<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
LCD_SPWG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x01<BR>+<BR>+<BR>+/* Define =
display timing */<BR>+struct display_timing {<BR>+&nbsp;&nbsp;&nbsp; =
u16&nbsp;&nbsp;&nbsp;&nbsp; hor_total;<BR>+&nbsp;&nbsp;&nbsp; =
u16&nbsp;&nbsp;&nbsp;&nbsp; hor_addr;<BR>+&nbsp;&nbsp;&nbsp; =
u16&nbsp;&nbsp;&nbsp;&nbsp; hor_blank_start;<BR>+&nbsp;&nbsp;&nbsp; =
u16&nbsp;&nbsp;&nbsp;&nbsp; hor_blank_end;<BR>+&nbsp;&nbsp;&nbsp; =
u16&nbsp;&nbsp;&nbsp;&nbsp; hor_sync_start;<BR>+&nbsp;&nbsp;&nbsp; =
u16&nbsp;&nbsp;&nbsp;&nbsp; hor_sync_end;<BR>+&nbsp;&nbsp;&nbsp; =
u16&nbsp;&nbsp;&nbsp;&nbsp; ver_total;<BR>+&nbsp;&nbsp;&nbsp; =
u16&nbsp;&nbsp;&nbsp;&nbsp; ver_addr;<BR>+&nbsp;&nbsp;&nbsp; =
u16&nbsp;&nbsp;&nbsp;&nbsp; ver_blank_start;<BR>+&nbsp;&nbsp;&nbsp; =
u16&nbsp;&nbsp;&nbsp;&nbsp; ver_blank_end;<BR>+&nbsp;&nbsp;&nbsp; =
u16&nbsp;&nbsp;&nbsp;&nbsp; ver_sync_start;<BR>+&nbsp;&nbsp;&nbsp; =
u16&nbsp;&nbsp;&nbsp;&nbsp; ver_sync_end;<BR>+};<BR>+<BR>+struct =
crt_mode_table {<BR>+&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; refresh_rate;<BR>+&nbsp; unsigned =
long&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk;<BR>+&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; h_sync_polarity;<BR>+&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v_sync_polarity;<BR>+&nbsp; struct =
display_timing&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; crtc;<BR>+};<BR>+<BR>+struct io_reg{<BR>+&nbsp; =
int&nbsp;&nbsp; port;<BR>+&nbsp; u8&nbsp;&nbsp;&nbsp; index;<BR>+&nbsp; =
u8&nbsp;&nbsp;&nbsp; mask;<BR>+&nbsp; u8&nbsp;&nbsp;&nbsp; =
value;<BR>+};<BR>+<BR>+#endif /* __SHARE_H__ =
*/<BR>+<BR></FONT></DIV></BODY></HTML>
------_=_NextPart_001_01C7893E.E1FC4847--


--===============0124052011==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0124052011==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0124052011==--
