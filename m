From: <EddyFu@via.com.tw>
Subject: [PATCH 4/5] viafb: Framebuffer driver for VIA
	UniChrome/Chrome9 HC
Date: Sat, 28 Apr 2007 10:44:49 +0800
Message-ID: <C80EF34A3D2E494DBAF9AC29C7AE4EB887D2EA@exchtp03.taipei.via.com.tw>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0652120504=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hhcvh-0007MY-5Y for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 27 Apr 2007 19:44:58 -0700
Received: from exchtp08.via.com.tw ([61.66.243.7])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hhcvb-00009H-MP
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 27 Apr 2007 19:44:57 -0700
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

--===============0652120504==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7893F.30ABE19E"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7893F.30ABE19E
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

diff -Nur linux-2.6.21-rc7/drivers/video/via/tbl1636.h =
linux-2.6.21-rc7.viafb/drivers/video/via/tbl1636.h
--- linux-2.6.21-rc7/drivers/video/via/tbl1636.h 1969-12-31 =
19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/tbl1636.h 2007-04-26 =
19:52:32.000000000 -0400
@@ -0,0 +1,82 @@
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
+#ifndef _TBL1636_H_
+#define _TBL1636_H_ 1
+
+#include "hw.h"
+
+
+struct IODATA COMMON_INIT_TBL_VT1636[] =3D {
+/*  Index, Mask, Value */
+    {0x10, 0xC0, 0x00},     /* Set panel power sequence timing */
+    {0x0B, 0xFF, 0x40},     /* T1: VDD on - Data on. Each increment is =
1 ms. (50ms =3D 031h)*/
+    {0x0C, 0xFF, 0x31},     /* T2: Data on - Backlight on. Each =
increment is 2 ms. (210ms =3D 068h) */
+    {0x0D, 0xFF, 0x31},     /* T3: Backlight off - Data off. Each =
increment is 2 ms. (210ms =3D 068h) */
+    {0x0E, 0xFF, 0x68},     /* T4: Data off - VDD off. Each increment =
is 1 ms. (50ms =3D 031h) */
+    {0x0F, 0xFF, 0x68},     /* T5: VDD off - VDD on. Each increment is =
100 ms. (500ms =3D 04h) */
+    {0x09, 0xA0, 0xA0},     /* LVDS output power up */
+    {0x10, 0x33, 0x13}      /* turn on back light */
+};
+
+
+struct IODATA DUAL_CHANNEL_ENABLE_TBL_VT1636[] =3D {
+/*  Index, Mask, Value */
+    {0x08,  0xF0, 0xE0}      /* Input Data Mode Select */
+};
+
+
+struct IODATA SINGLE_CHANNEL_ENABLE_TBL_VT1636[] =3D {
+/*  Index, Mask, Value */
+    {0x08,  0xF0, 0x00}      /* Input Data Mode Select */
+};
+
+
+struct IODATA DITHERING_ENABLE_TBL_VT1636[] =3D {
+/*  Index, Mask, Value */
+    {0x0A,  0x70, 0x50}
+};
+
+
+struct IODATA DITHERING_DISABLE_TBL_VT1636[] =3D {
+/*  Index, Mask, Value */
+    {0x0A,  0x70, 0x00}
+};
+
+
+struct IODATA VDD_ON_TBL_VT1636[] =3D {
+/*  Index, Mask, Value */
+    {0x10,  0x20, 0x20}
+};
+
+
+struct IODATA VDD_OFF_TBL_VT1636[] =3D {
+/*  Index, Mask, Value */
+    {0x10,  0x20, 0x00}
+};
+
+
+#endif  /* _VIA_TBL1636_H_ */
+
diff -Nur linux-2.6.21-rc7/drivers/video/via/tblDPASetting.h =
linux-2.6.21-rc7.viafb/drivers/video/via/tblDPASetting.h
--- linux-2.6.21-rc7/drivers/video/via/tblDPASetting.h 1969-12-31 =
19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/tblDPASetting.h 2007-04-26 =
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
+#ifndef _TBLDPASETTING_H_
+#define _TBLDPASETTING_H_ 1
+#include "lcd.h"
+
+#define DPA_CLK_30M       30000000
+#define DPA_CLK_50M       50000000
+#define DPA_CLK_70M       70000000
+#define DPA_CLK_100M      100000000
+#define DPA_CLK_150M      150000000
+
+
+typedef enum _DPA_CLK_RANGE {
+    DPA_CLK_RANGE_30M,
+    DPA_CLK_RANGE_30_50M,
+    DPA_CLK_RANGE_50_70M,
+    DPA_CLK_RANGE_70_100M,
+    DPA_CLK_RANGE_100_150M,
+    DPA_CLK_RANGE_150M,
+} DPA_CLK_RANGE;
+
+
+/* For VT3324: */
+struct VT1636_DPA_SETTING VT1636_DPA_SETTING_TBL_VT3324[] =3D {
+     /* Panel ID,       CLK_SEL_ST1[09],    CLK_SEL_ST2[08] */
+    {LCD_PANEL_ID0_640X480,      0x00,               0x00},          /* =
For 640x480   */
+    {LCD_PANEL_ID1_800X600,      0x00,               0x00},          /* =
For 800x600   */
+    {LCD_PANEL_ID2_1024X768,     0x00,               0x00},          /* =
For 1024x768  */
+    {LCD_PANEL_ID3_1280X768,     0x00,               0x00},          /* =
For 1280x768  */
+    {LCD_PANEL_ID4_1280X1024,    0x00,               0x00},          /* =
For 1280x1024 */
+    {LCD_PANEL_ID5_1400X1050,    0x00,               0x00},          /* =
For 1400x1050 */
+    {LCD_PANEL_ID6_1600X1200,    0x0B,               0x03}           /* =
For 1600x1200 */
+};
+
+struct GFX_DPA_SETTING GFX_DPA_SETTING_TBL_VT3324[] =3D {
+    /*  ClkRange,            DVP0, DVP0DataDriving,  DVP0ClockDriving, =
DVP1, DVP1Driving, DFPHigh,   DFPLow */
+    /*                       CR96, SR2A[5], SR1B[1], SR2A[4], SR1E[2], =
CR9B, SR65,        CR97,      CR99   */
+    {DPA_CLK_RANGE_30M,      0x00, 0x00,    0x00,    0x00,    0x00,    =
0x03, 0x00,        0x00,      0x00},  /* LCK/VCK < 30000000 will use =
this value */
+    {DPA_CLK_RANGE_30_50M,   0x00, 0x00,    0x00,    0x00,    0x00,    =
0x03, 0x00,        0x00,      0x00},  /* 30000000 < LCK/VCK < 50000000 =
will use this value */
+    {DPA_CLK_RANGE_50_70M,   0x00, 0x00,    0x00,    0x00,    0x00,    =
0x02, 0x00,        0x00,      0x00},  /* 50000000 < LCK/VCK < 70000000 =
will use this value */
+    {DPA_CLK_RANGE_70_100M,  0x00, 0x00,    0x00,    0x00,    0x00,    =
0x02, 0x00,        0x00,      0x00},  /* 70000000 < LCK/VCK < 100000000 =
will use this value */
+    {DPA_CLK_RANGE_100_150M, 0x00, 0x00,    0x00,    0x00,    0x00,    =
0x02, 0x00,        0x00,      0x00},  /* 100000000 < LCK/VCK < 15000000 =
will use this value */
+    {DPA_CLK_RANGE_150M,     0x00, 0x00,    0x00,    0x00,    0x00,    =
0x08, 0x0E,        0x00,      0x00},  /* 15000000 < LCK/VCK will use =
this value */
+};
+
+
+/* For VT3327: */
+struct VT1636_DPA_SETTING VT1636_DPA_SETTING_TBL_VT3327[] =3D {
+     /* Panel ID,       CLK_SEL_ST1[09],    CLK_SEL_ST2[08] */
+    {LCD_PANEL_ID0_640X480,      0x00,               0x00},          /* =
For 640x480   */
+    {LCD_PANEL_ID1_800X600,      0x00,               0x00},          /* =
For 800x600   */
+    {LCD_PANEL_ID2_1024X768,     0x00,               0x00},          /* =
For 1024x768  */
+    {LCD_PANEL_ID3_1280X768,     0x00,               0x00},          /* =
For 1280x768  */
+    {LCD_PANEL_ID4_1280X1024,    0x00,               0x00},          /* =
For 1280x1024 */
+    {LCD_PANEL_ID5_1400X1050,    0x00,               0x00},          /* =
For 1400x1050 */
+    {LCD_PANEL_ID6_1600X1200,    0x00,               0x00}           /* =
For 1600x1200 */
+};
+
+struct GFX_DPA_SETTING GFX_DPA_SETTING_TBL_VT3327[] =3D {
+    /*  ClkRange,            DVP0, DVP0DataDriving,  DVP0ClockDriving, =
DVP1, DVP1Driving, DFPHigh,   DFPLow */
+    /*                       CR96, SR2A[5], SR1B[1], SR2A[4], SR1E[2], =
CR9B, SR65,        CR97,      CR99   */
+    {DPA_CLK_RANGE_30M,      0x07, 0x00,    0x00,    0x00,    0x00,    =
0x03, 0x00,        0x08,      0x01},  /* LCK/VCK < 30000000 will use =
this value */
+    {DPA_CLK_RANGE_30_50M,   0x07, 0x00,    0x00,    0x00,    0x00,    =
0x03, 0x00,        0x08,      0x01},  /* 30000000 < LCK/VCK < 50000000 =
will use this value */
+    {DPA_CLK_RANGE_50_70M,   0x06, 0x00,    0x00,    0x00,    0x00,    =
0x03, 0x00,        0x08,      0x01},  /* 50000000 < LCK/VCK < 70000000 =
will use this value */
+    {DPA_CLK_RANGE_70_100M,  0x03, 0x00,    0x00,    0x00,    0x00,    =
0x03, 0x00,        0x08,      0x03},  /* 70000000 < LCK/VCK < 100000000 =
will use this value */
+    {DPA_CLK_RANGE_100_150M, 0x03, 0x00,    0x00,    0x00,    0x00,    =
0x03, 0x00,        0x01,      0x02},  /* 100000000 < LCK/VCK < 15000000 =
will use this value */
+    {DPA_CLK_RANGE_150M,     0x00, 0x20,    0x00,    0x10,    0x00,    =
0x03, 0x00,        0x0D,      0x03},  /* 15000000 < LCK/VCK will use =
this value */
+};
+
+
+/* For VT3364: */
+struct GFX_DPA_SETTING GFX_DPA_SETTING_TBL_VT3364[] =3D {
+    /*  ClkRange,            DVP0, DVP0DataDriving,  DVP0ClockDriving, =
DVP1, DVP1Driving, DFPHigh,   DFPLow */
+    /*                       CR96, SR2A[5], SR1B[1], SR2A[4], SR1E[2], =
CR9B, SR65,        CR97,      CR99   */
+    {DPA_CLK_RANGE_30M,      0x07, 0x00,    0x00,    0x00,    0x00,    =
0x03, 0x00,        0x00,      0x08},  /* LCK/VCK < 30000000 will use =
this value */
+    {DPA_CLK_RANGE_30_50M,   0x07, 0x00,    0x00,    0x00,    0x00,    =
0x03, 0x00,        0x00,      0x08},  /* 30000000 < LCK/VCK < 50000000 =
will use this value */
+    {DPA_CLK_RANGE_50_70M,   0x07, 0x00,    0x00,    0x00,    0x00,    =
0x03, 0x00,        0x00,      0x08},  /* 50000000 < LCK/VCK < 70000000 =
will use this value */
+    {DPA_CLK_RANGE_70_100M,  0x07, 0x00,    0x00,    0x00,    0x00,    =
0x03, 0x00,        0x00,      0x08},  /* 70000000 < LCK/VCK < 100000000 =
will use this value */
+    {DPA_CLK_RANGE_100_150M, 0x03, 0x00,    0x02,    0x00,    0x00,    =
0x03, 0x00,        0x00,      0x08},  /* 100000000 < LCK/VCK < 15000000 =
will use this value */
+    {DPA_CLK_RANGE_150M,     0x01, 0x00,    0x02,    0x10,    0x00,    =
0x03, 0x00,        0x00,      0x08},  /* 15000000 < LCK/VCK will use =
this value */
+};
+
+#endif
+
diff -Nur linux-2.6.21-rc7/drivers/video/via/tblIntegratedTV.h =
linux-2.6.21-rc7.viafb/drivers/video/via/tblIntegratedTV.h
--- linux-2.6.21-rc7/drivers/video/via/tblIntegratedTV.h 1969-12-31 =
19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/tblIntegratedTV.h =
2007-04-26 19:52:32.000000000 -0400
@@ -0,0 +1,1208 @@
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
+#ifndef _TBLINTEGRATEDTV_H_
+#define _TBLINTEGRATEDTV_H_ 1
+
+#define INTEGRATED_TVCLK_27MHZ     0x01865884
+#define INTEGRATED_TVCLK_54MHZ     0x00C65884
+#define INTEGRATED_TVCLK_74_25MHZ  0x01043084
+#define INTEGRATED_TVCLK_148_5MHZ  0x00843084
+
+
+/***************************/
+/*  Integrated TV Table    */
+/***************************/
+
+struct integrated_tv_mode_table {
+    int              mode_index;
+    unsigned long    *std_ntsc;
+    unsigned long    *std_pal;
+    unsigned long    *std_720p;
+    unsigned long    *std_1080i;
+};
+
+struct integrated_tv_hdtv_patch_table {
+    int             mode_index;
+    unsigned short  *std_480p;
+    unsigned short  *std_576p;
+    unsigned short  *std_720p;
+    unsigned short  *std_1080i;
+};
+
+unsigned short ITV_INIT_TABLE_OFFSET[] =3D {
+    0x0000,
+    0x001C,
+    0x00DC,
+    0xFFFF  /*End*/
+};
+=20
+unsigned long ITV_INIT_TABLE_VALUE[] =3D {
+    0x40412000,     /* 00-03 */
+    0x40000000,     /* 1C-1F */
+
+    /* TVCLK PLL. */
+    0xA0000000,     /* DC-DF */
+};
+
+unsigned short ITV_MODE_TABLE_OFFSET[] =3D {
+    0x0014,
+    0x0018,
+    0x0020,
+    0x0024,
+    0x0028,
+    0x0034,
+    0x0038,
+    0x003C,
+    0x0040,
+    0x0044,
+    0x0048,
+    0x004C,
+    0x0050,
+    0x0054,
+    0x0058,
+    0x005C,
+    0x0060,
+    0x00E0,
+    0xFFFF  /*End*/
+};
+
+/***********************************************************************=
***************/
+/************************************* NTSC =
*******************************************/
+/***********************************************************************=
***************/
+unsigned long ITV_MODE_TABLE_NTSC_640x480[] =3D {
+    /* Src Buffer Line Pitch. */   =20
+    0x00770500,                 /* 14-17 */
+
+    /* Src Image Size and Position. */
+    0x09D3F9DF,                 /* 18-1B */
+    0x027F01DF,                 /* 20-23 */
+
+    /* Scaling Factor and De-Flicker. */
+    0x63EB48FA,                 /* 24-27 */       =20
+
+    /* Dst Image Size. */
+    0x141461AA,                 /* 28-2B */
+
+    /* Dst Buffer Line Pitch & DQWord. */
+    0x008E0500,                 /* 34-37 */
+
+    /* Encoder Control. */
+    0xC000A214,                 /* 38-3B */
+   =20
+    /* Encoder CRTC. */
+    0x427F06B3,                 /* 3C-3F */
+    0x00F400B1,                 /* 40-43 */
+    0x06910100,                 /* 44-47 */
+    0x01000000,                 /* 48-4B */
+    0x088680C0,                 /* 4C-4F */
+    0x488F08C8,                 /* 50-53 */
+   =20
+    /* Luma Data */
+    0x0A9AA886,                 /* 54-57 */
+
+    /* FSCI */
+    0x21F07C16,                 /* 58-5B */
+
+    /* Burst and Sync Shape */
+    0x00F01010,                 /* 5C-5F */
+
+    /* Hue and Sub-Carrier */
+    0x00000000,                 /* 60-63 */
+
+    /* TVCLK PLL */
+    INTEGRATED_TVCLK_27MHZ      /* E0-E3 */
+};
+
+unsigned long ITV_CRTC_TABLE_NTSC_640x480[] =3D {
+    858,    /* H_Total */
+    640,    /* H_Display_End */
+    640,    /* H_Blanking_Start */
+    218,    /* H_Blanking_End */
+    688,    /* H_Sync_Start */
+    56,     /* H_Sync_End */
+    525,    /* V_Total */
+    480,    /* V_Display_End */
+    480,    /* V_Blanking_Start */
+    45,     /* V_Blanking_End */
+    488,    /* V_Sync_Start */
+    7       /* V_Sync_End */
+};
+
+
+unsigned long ITV_MODE_TABLE_NTSC_720x480[] =3D {
+    /* Src Buffer Line Pitch. */   =20
+    0x007705C0,                 /* 14-17 */
+
+    /* Src Image Size and Position. */
+    0x09D679DF,                 /* 18-1B */
+    0x02CF01DF,                 /* 20-23 */
+
+    /* Scaling Factor and De-Flicker. */
+    0x646C4903,                 /* 24-27 */       =20
+
+    /* Dst Image Size. */
+    0x169451A9,                 /* 28-2B */
+
+    /* Dst Buffer Line Pitch & DQWord. */
+    0x008E05C0,                 /* 34-37 */
+
+    /* Encoder Control. */
+    0xC000A214,                 /* 38-3B */
+   =20
+    /* Encoder CRTC. */
+    0x427F06B3,                 /* 3C-3F */
+    0x00F400B1,                 /* 40-43 */
+    0x06910100,                 /* 44-47 */
+    0x01A00000,                 /* 48-4B */
+    0x088680C0,                 /* 4C-4F */
+    0x488F08C8,                 /* 50-53 */
+   =20
+    /* Luma Data */
+    0x0A9AA886,                 /* 54-57 */
+
+    /* FSCI */
+    0x21F07C16,                 /* 58-5B */
+
+    /* Burst and Sync Shape */
+    0x00F01010,                 /* 5C-5F */
+
+    /* Hue and Sub-Carrier */
+    0x00000000,                 /* 60-63 */
+
+    /* TVCLK PLL */
+    INTEGRATED_TVCLK_27MHZ      /* E0-E3 */
+};
+
+unsigned long ITV_CRTC_TABLE_NTSC_720x480[] =3D {
+    858,    /* H_Total */
+    720,    /* H_Display_End */
+    720,    /* H_Blanking_Start */
+    138,    /* H_Blanking_End */
+    736,    /* H_Sync_Start */
+    72,     /* H_Sync_End */
+    525,    /* V_Total */
+    480,    /* V_Display_End */
+    480,    /* V_Blanking_Start */
+    45,     /* V_Blanking_End */
+    481,    /* V_Sync_Start */
+    3       /* V_Sync_End */
+};
+
+
+unsigned long ITV_MODE_TABLE_NTSC_800x600[] =3D {
+    /* Src Buffer Line Pitch. */   =20
+    0x00770640,                 /* 14-17 */
+
+    /* Src Image Size and Position. */
+    0x09D8FA57,                 /* 18-1B */
+    0x031F0257,                 /* 20-23 */
+
+    /* Scaling Factor and De-Flicker. */
+    0x64E84B3D,                 /* 24-27 */       =20
+
+    /* Dst Image Size. */
+    0x191459AA,                 /* 28-2B */
+
+    /* Dst Buffer Line Pitch & DQWord. */
+    0x008E0640,                 /* 34-37 */
+
+    /* Encoder Control. */
+    0xC000A214,                 /* 38-3B */
+   =20
+    /* Encoder CRTC. */
+    0x427F06B3,                 /* 3C-3F */
+    0x00F400B1,                 /* 40-43 */
+    0x06910100,                 /* 44-47 */
+    0x01000000,                 /* 48-4B */
+    0x088680C0,                 /* 4C-4F */
+    0x488F08C8,                 /* 50-53 */
+
+    /* Luma Data */
+    0x0A9AA886,                 /* 54-57 */
+   =20
+    /* FSCI */
+    0x21F07C16,                 /* 58-5B */
+
+    /* Burst and Sync Shape */
+    0x00F01010,                 /* 5C-5F */
+
+    /* Hue and Sub-Carrier */
+    0x00000000,                 /* 60-63 */
+
+    /* TVCLK PLL */
+    INTEGRATED_TVCLK_54MHZ      /* E0-E3 */
+};
+
+unsigned long ITV_CRTC_TABLE_NTSC_800x600[] =3D {
+    1092,   /* H_Total */
+    800,    /* H_Display_End */
+    800,    /* H_Blanking_Start */
+    292,    /* H_Blanking_End */
+    840,    /* H_Sync_Start */
+    136,    /* H_Sync_End */
+    825,    /* V_Total */
+    600,    /* V_Display_End */
+    600,    /* V_Blanking_Start */
+    225,    /* V_Blanking_End */
+    606,    /* V_Sync_Start */
+    15      /* V_Sync_End */
+};
+
+
+unsigned long ITV_MODE_TABLE_NTSC_1024x768[] =3D {
+    /* Src Buffer Line Pitch. */   =20
+    0x00770800,                 /* 14-17 */
+
+    /* Src Image Size and Position. */
+    0x09DFFAFF,                 /* 18-1B */
+    0x03FF02FF,                 /* 20-23 */
+
+    /* Scaling Factor and De-Flicker. */
+    0x66454E58,                 /* 24-27 */       =20
+
+    /* Dst Image Size. */
+    0x201461AA,                 /* 28-2B */
+
+    /* Dst Buffer Line Pitch & DQWord. */
+    0x008E0800,                 /* 34-37 */
+
+    /* Encoder Control. */
+    0xC000A214,                 /* 38-3B */
+   =20
+    /* Encoder CRTC. */
+    0x427F06B3,                 /* 3C-3F */
+    0x00F400B1,                 /* 40-43 */
+    0x06910100,                 /* 44-47 */
+    0x01000000,                 /* 48-4B */
+    0x088680C0,                 /* 4C-4F */
+    0x488F08C8,                 /* 50-53 */
+
+    /* Luma Data */
+    0x0A9AA886,                 /* 54-57 */
+   =20
+    /* FSCI */
+    0x21F07C16,                 /* 58-5B */
+
+    /* Burst and Sync Shape */
+    0x00F01010,                 /* 5C-5F */
+
+    /* Hue and Sub-Carrier */
+    0x00000000,                 /* 60-63 */
+
+    /* TVCLK PLL */
+    INTEGRATED_TVCLK_54MHZ      /* E0-E3 */
+};
+
+unsigned long ITV_CRTC_TABLE_NTSC_1024x768[] =3D {
+    1092,   /* H_Total */
+    1024,   /* H_Display_End */
+    1024,   /* H_Blanking_Start */
+    68,     /* H_Blanking_End */
+    1032,   /* H_Sync_Start */
+    52,     /* H_Sync_End */
+    825,    /* V_Total */
+    768,    /* V_Display_End */
+    768,    /* V_Blanking_Start */
+    57,     /* V_Blanking_End */
+    800,    /* V_Sync_Start */
+    6       /* V_Sync_End */
+};
+       =20
+/***********************************************************************=
***************/
+/************************************* PAL =
********************************************/
+/***********************************************************************=
***************/
+
+unsigned long ITV_MODE_TABLE_PAL_640x480[] =3D {
+    /* Src Buffer Line Pitch. */   =20
+    0x00770500,                 /* 14-17 */
+
+    /* Src Image Size and Position. */
+    0x09D3F9DF,                 /* 18-1B */
+    0x227F01DF,                 /* 20-23 */
+
+    /* Scaling Factor and De-Flicker. */
+    0x6405478E,                 /* 24-27 */       =20
+
+    /* Dst Image Size. */
+    0x1413D9FA,                 /* 28-2B */
+
+    /* Dst Buffer Line Pitch & DQWord. */
+    0x008E0500,                 /* 34-37 */
+
+    /* Encoder Control. */
+    0xC048A214,                 /* 38-3B */
+   =20
+    /* Encoder CRTC. */
+    0x427F06BF,                 /* 3C-3F */
+    0x00EF00B2,                 /* 40-43 */
+    0x06990120,                 /* 44-47 */
+    0x01200010,                 /* 48-4B */
+    0x0A0680C0,                 /* 4C-4F */
+    0x489608D3,                 /* 50-53 */
+   =20
+    /* Luma Data */
+    0x001C0090,                 /* 54-57 */
+
+    /* FSCI */
+    0x2A08D01C,                 /* 58-5B */
+
+    /* Burst and Sync Shape */
+    0x01081011,                 /* 5C-5F */
+
+    /* Hue and Sub-Carrier */
+    0x00120000,                 /* 60-63 */
+
+    /* TVCLK PLL */
+    INTEGRATED_TVCLK_27MHZ      /* E0-E3 */
+};
+
+unsigned long ITV_CRTC_TABLE_PAL_640x480[] =3D {
+    864,    /* H_Total */
+    640,    /* H_Display_End */
+    640,    /* H_Blanking_Start */
+    224,    /* H_Blanking_End */
+    704,    /* H_Sync_Start */
+    56,     /* H_Sync_End */
+    625,    /* V_Total */
+    480,    /* V_Display_End */
+    480,    /* V_Blanking_Start */
+    145,    /* V_Blanking_End */
+    500,    /* V_Sync_Start */
+    6       /* V_Sync_End */
+};
+
+
+unsigned long ITV_MODE_TABLE_PAL_720x576[] =3D {
+    /* Src Buffer Line Pitch. */   =20
+    0x007705C0,                 /* 14-17 */
+
+    /* Src Image Size and Position. */
+    0x09D67A3F,                 /* 18-1B */
+    0x22CF023F,                 /* 20-23 */
+
+    /* Scaling Factor and De-Flicker. */
+    0x64834916,                 /* 24-27 */       =20
+
+    /* Dst Image Size. */
+    0x1693E9FA,                 /* 28-2B */
+
+    /* Dst Buffer Line Pitch & DQWord. */
+    0x008E05C0,                 /* 34-37 */
+
+    /* Encoder Control. */
+    0xC048A214,                 /* 38-3B */
+   =20
+    /* Encoder CRTC. */
+    0x427F06BF,                 /* 3C-3F */
+    0x00EF00B2,                 /* 40-43 */
+    0x06990120,                 /* 44-47 */
+    0x01200010,                 /* 48-4B */
+    0x0A0680C0,                 /* 4C-4F */
+    0x489608D3,                 /* 50-53 */
+   =20
+    /* Luma Data */
+    0x001C0090,                 /* 54-57 */
+
+    /* FSCI */
+    0x2A08D01C,                 /* 58-5B */
+
+    /* Burst and Sync Shape */
+    0x01081011,                 /* 5C-5F */
+
+    /* Hue and Sub-Carrier */
+    0x00120000,                 /* 60-63 */
+
+    /* TVCLK PLL */
+    INTEGRATED_TVCLK_27MHZ      /* E0-E3 */
+};
+
+unsigned long ITV_CRTC_TABLE_PAL_720x576[] =3D {
+    864,    /* H_Total */
+    720,    /* H_Display_End */
+    720,    /* H_Blanking_Start */
+    144,    /* H_Blanking_End */
+    760,    /* H_Sync_Start */
+    40,     /* H_Sync_End */
+    625,    /* V_Total */
+    576,    /* V_Display_End */
+    576,    /* V_Blanking_Start */
+    49,    /* V_Blanking_End */
+    577,    /* V_Sync_Start */
+    3       /* V_Sync_End */
+};
+
+
+unsigned long ITV_MODE_TABLE_PAL_800x600[] =3D {
+    /* Src Buffer Line Pitch. */   =20
+    0x00770640,                 /* 14-17 */
+
+    /* Src Image Size and Position. */
+    0x09D8FA57,                 /* 18-1B */
+    0x231F0257,                 /* 20-23 */
+
+    /* Scaling Factor and De-Flicker. */
+    0x6503497A,                 /* 24-27 */       =20
+
+    /* Dst Image Size. */
+    0x1913E9F9,                 /* 28-2B */
+
+    /* Dst Buffer Line Pitch & DQWord. */
+    0x008E0640,                 /* 34-37 */
+
+    /* Encoder Control. */
+    0xC048A214,                 /* 38-3B */
+   =20
+    /* Encoder CRTC. */
+    0x427F06BF,                 /* 3C-3F */
+    0x00EF00B2,                 /* 40-43 */
+    0x06990120,                 /* 44-47 */
+    0x01200010,                 /* 48-4B */
+    0x0A0680C0,                 /* 4C-4F */
+    0x489608D3,                 /* 50-53 */
+   =20
+    /* Luma Data */
+    0x001C0090,                 /* 54-57 */
+
+    /* FSCI */
+    0x2A08D01C,                 /* 58-5B */
+
+    /* Burst and Sync Shape */
+    0x01081011,                 /* 5C-5F */
+
+    /* Hue and Sub-Carrier */
+    0x00120000,                 /* 60-63 */
+
+    /* TVCLK PLL */
+    INTEGRATED_TVCLK_54MHZ      /* E0-E3 */
+};
+
+unsigned long ITV_CRTC_TABLE_PAL_800x600[] =3D {
+    1350,   /* H_Total */
+    800,    /* H_Display_End */
+    800,    /* H_Blanking_Start */
+    550,    /* H_Blanking_End */
+    816,    /* H_Sync_Start */
+    64,     /* H_Sync_End */
+    800,    /* V_Total */
+    600,    /* V_Display_End */
+    600,    /* V_Blanking_Start */
+    200,    /* V_Blanking_End */
+    606,    /* V_Sync_Start */
+    15      /* V_Sync_End */
+};
+
+
+unsigned long ITV_MODE_TABLE_PAL_1024x768[] =3D {
+    /* Src Buffer Line Pitch. */   =20
+    0x00770800,                 /* 14-17 */
+
+    /* Src Image Size and Position. */
+    0x09DFFAFF,                 /* 18-1B */
+    0x13FF02FF,                 /* 20-23 */
+
+    /* Scaling Factor and De-Flicker. */
+    0x66704C2A,                 /* 24-27 */       =20
+
+    /* Dst Image Size. */
+    0x2013D9F8,                 /* 28-2B */
+
+    /* Dst Buffer Line Pitch & DQWord. */
+    0x008E0800,                 /* 34-37 */
+
+    /* Encoder Control. */
+    0xC048A214,                 /* 38-3B */
+   =20
+    /* Encoder CRTC. */
+    0x427F06BF,                 /* 3C-3F */
+    0x00EF00B2,                 /* 40-43 */
+    0x06990120,                 /* 44-47 */
+    0x01200010,                 /* 48-4B */
+    0x0A0680C0,                 /* 4C-4F */
+    0x489608D3,                 /* 50-53 */
+   =20
+    /* Luma Data */
+    0x001C0090,                 /* 54-57 */
+
+    /* FSCI */
+    0x2A08D01C,                 /* 58-5B */
+
+    /* Burst and Sync Shape */
+    0x01081011,                 /* 5C-5F */
+
+    /* Hue and Sub-Carrier */
+    0x00120000,                 /* 60-63 */
+
+    /* TVCLK PLL */
+    INTEGRATED_TVCLK_54MHZ      /* E0-E3 */
+};
+
+unsigned long ITV_CRTC_TABLE_PAL_1024x768[] =3D {
+    1200,   /* H_Total */
+    1024,   /* H_Display_End */
+    1024,   /* H_Blanking_Start */
+    176,    /* H_Blanking_End */
+    1048,   /* H_Sync_Start */
+    16,     /* H_Sync_End */
+    900,    /* V_Total */
+    768,    /* V_Display_End */
+    768,    /* V_Blanking_Start */
+    132,    /* V_Blanking_End */
+    800,    /* V_Sync_Start */
+    6       /* V_Sync_End */
+};
+
+/***********************************************************************=
***************/
+/************************************* HDTV: 720P =
*************************************/
+/***********************************************************************=
***************/
+unsigned long ITV_MODE_TABLE_720P_1280x720[] =3D {
+    /* Src Buffer Line Pitch. */   =20
+    0x00770A00,                 /* 14-17 */
+
+    /* Src Image Size and Position. */
+    0x09E7FACF,                 /* 18-1B */
+    0x24FF02CF,                 /* 20-23 */
+
+    /* Scaling Factor and De-Flicker. */
+    0x045A27FF,                 /* 24-27 */       =20
+
+    /* Dst Image Size. */
+    0x2827FACF,                 /* 28-2B */
+
+    /* Dst Buffer Line Pitch & DQWord. */
+    0x00770A00,                 /* 34-37 */
+
+    /* Encoder Control. */
+    0xC0E0A214,                 /* 38-3B */
+
+    /* Encoder CRTC. */
+    0x42280671,                 /* 3C-3F */
+    0x00000000,                 /* 40-43 */
+    0x062C0117,                 /* 44-47 */
+    0x000C592C,                 /* 48-4B */
+    0x0608527D,                 /* 4C-4F */
+    0x48CD18CD,                 /* 50-53 */
+
+    /* Luma Data */
+    0x009CA891,                 /* 54-57 */
+
+    /* FSCI */
+    0x21F02016,                 /* 58-5B */
+
+    /* Burst and Sync Shape */
+    0x00F0102F,                 /* 5C-5F */
+
+    /* Hue and Sub-Carrier */
+    0x00000000,                 /* 60-63 */
+
+    /* TVCLK PLL */
+    INTEGRATED_TVCLK_74_25MHZ   /* E0-E3 */
+};
+
+unsigned long ITV_CRTC_TABLE_720P_1280x720[] =3D {
+    1650,   /* H_Total          */
+    1280,   /* H_Display_End    */
+    1280,   /* H_Blanking_Start */
+    370,    /* H_Blanking_End   */
+    1296,   /* H_Sync_Start     */
+    48,     /* H_Sync_End       */
+    750,    /* V_Total          */
+    720,    /* V_Display_End    */
+    720,    /* V_Blanking_Start */
+    30,     /* V_Blanking_End   */
+    721,    /* V_Sync_Start     */
+    5       /* V_Sync_End       */
+};
+
+unsigned long ITV_CRTC_TABLE_720P_640x480[] =3D {
+    900,    /* H_Total          */
+    640,    /* H_Display_End    */
+    640,    /* H_Blanking_Start */
+    260,    /* H_Blanking_End   */
+    656,    /* H_Sync_Start     */
+    72,     /* H_Sync_End       */
+    500,    /* V_Total          */
+    480,    /* V_Display_End    */
+    480,    /* V_Blanking_Start */
+    20,     /* V_Blanking_End   */
+    481,    /* V_Sync_Start     */
+    2       /* V_Sync_End       */
+};
+
+unsigned long ITV_CRTC_TABLE_720P_720x480[] =3D {
+    900,    /* H_Total          */
+    720,    /* H_Display_End    */
+    720,    /* H_Blanking_Start */
+    180,    /* H_Blanking_End   */
+    736,    /* H_Sync_Start     */
+    72,     /* H_Sync_End       */
+    500,    /* V_Total          */
+    480,    /* V_Display_End    */
+    480,    /* V_Blanking_Start */
+    20,     /* V_Blanking_End   */
+    481,    /* V_Sync_Start     */
+    3       /* V_Sync_End       */
+};
+
+unsigned long ITV_CRTC_TABLE_720P_720x576[] =3D {
+    1440,   /* H_Total          */
+    720,    /* H_Display_End    */
+    720,    /* H_Blanking_Start */
+    720,    /* H_Blanking_End   */
+    736,    /* H_Sync_Start     */
+    80,     /* H_Sync_End       */
+    625,    /* V_Total          */
+    576,    /* V_Display_End    */
+    576,    /* V_Blanking_Start */
+    49,     /* V_Blanking_End   */
+    577,    /* V_Sync_Start     */
+    3       /* V_Sync_End       */
+};
+
+unsigned long ITV_CRTC_TABLE_720P_800x600[] =3D {
+    1440,   /* H_Total          */
+    800,    /* H_Display_End    */
+    800,    /* H_Blanking_Start */
+    640,    /* H_Blanking_End   */
+    840,    /* H_Sync_Start     */
+    136,    /* H_Sync_End       */
+    625,    /* V_Total          */
+    600,    /* V_Display_End    */
+    600,    /* V_Blanking_Start */
+    25,     /* V_Blanking_End   */
+    606,    /* V_Sync_Start     */
+    15      /* V_Sync_End       */
+};
+
+unsigned long ITV_CRTC_TABLE_720P_1024x768[] =3D {
+    1250,   /* H_Total          */
+    1024,   /* H_Display_End    */
+    1024,   /* H_Blanking_Start */
+     226,   /* H_Blanking_End   */
+    1064,   /* H_Sync_Start     */
+     120,   /* H_Sync_End       */
+     880,   /* V_Total          */
+     768,   /* V_Display_End    */
+     768,   /* V_Blanking_Start */
+     112,   /* V_Blanking_End   */
+     774,   /* V_Sync_Start     */
+       3    /* V_Sync_End       */
+};
+
+/***********************************************************************=
***************/
+/************************************* HDTV: 1080I =
*************************************/
+/***********************************************************************=
***************/
+unsigned long ITV_MODE_TABLE_1080I_1920x1080[] =3D {
+    /* Src Buffer Line Pitch. */   =20
+    0x00770F00,                 /* 14-17 */
+
+    /* Src Image Size and Position. */
+    0x09FBFC37,                 /* 18-1B */
+    0x277F0437,                 /* 20-23 */
+
+    /* Scaling Factor and De-Flicker. */
+    0x68002803,                 /* 24-27 */       =20
+
+    /* Dst Image Size. */
+    0x3C3BFC37,                 /* 28-2B */
+
+    /* Dst Buffer Line Pitch & DQWord. */
+    0x00770F00,                 /* 34-37 */
+
+    /* Encoder Control. */
+    0xC0D0A214,                 /* 38-3B */
+
+    /* Encoder CRTC. */
+    0x422C0897,                 /* 3C-3F */
+    0x00000000,                 /* 40-43 */
+    0x087100EC,                 /* 44-47 */
+    0x000840B0,                 /* 48-4B */
+    0x0506B1E2,                 /* 4C-4F */
+    0x48B208F7,                 /* 50-53 */
+
+    /* Luma Data */
+    0x00A0A0A5,                 /* 54-57 */
+
+    /* FSCI */
+    0x21F02016,                 /* 58-5B */
+
+    /* Burst and Sync Shape */
+    0x01281010,                 /* 5C-5F */
+
+    /* Hue and Sub-Carrier */
+    0x00000000,                 /* 60-63 */
+   =20
+    /* TVCLK PLL */
+    INTEGRATED_TVCLK_148_5MHZ   /* E0-E3 */
+};
+
+unsigned long ITV_CRTC_TABLE_1080I_1920x1080[] =3D {
+    2200,   /* H_Total          */=20
+    1920,   /* H_Display_End    */
+    1920,   /* H_Blanking_Start */
+    280,    /* H_Blanking_End   */
+    1960,   /* H_Sync_Start     */
+    104,    /* H_Sync_End       */
+    1125,   /* V_Total          */
+    1080,   /* V_Display_End    */
+    1080,   /* V_Blanking_Start */
+    45,     /* V_Blanking_End   */
+    1083,   /* V_Sync_Start     */
+    4       /* V_Sync_End       */
+};
+
+unsigned long ITV_CRTC_TABLE_1080I_640x480[] =3D {
+    900,    /* H_Total          */
+    640,    /* H_Display_End    */
+    640,    /* H_Blanking_Start */
+    260,    /* H_Blanking_End   */
+    656,    /* H_Sync_Start     */
+    72,     /* H_Sync_End       */
+    500,    /* V_Total          */
+    480,    /* V_Display_End    */
+    480,    /* V_Blanking_Start */
+    20,     /* V_Blanking_End   */
+    481,    /* V_Sync_Start     */
+    2       /* V_Sync_End       */
+};
+
+unsigned long ITV_CRTC_TABLE_1080I_720x480[] =3D {
+    900,    /* H_Total          */
+    720,    /* H_Display_End    */
+    720,    /* H_Blanking_Start */
+    180,    /* H_Blanking_End   */
+    736,    /* H_Sync_Start     */
+    96,     /* H_Sync_End       */
+    500,    /* V_Total          */
+    480,    /* V_Display_End    */
+    480,    /* V_Blanking_Start */
+    20,     /* V_Blanking_End   */
+    485,    /* V_Sync_Start     */
+    6       /* V_Sync_End       */
+};
+
+unsigned long ITV_CRTC_TABLE_1080I_720x576[] =3D {
+    1440,   /* H_Total          */
+    720,    /* H_Display_End    */
+    720,    /* H_Blanking_Start */
+    720,    /* H_Blanking_End   */
+    736,    /* H_Sync_Start     */
+    96,     /* H_Sync_End       */
+    625,    /* V_Total          */
+    576,    /* V_Display_End    */
+    576,    /* V_Blanking_Start */
+    49,     /* V_Blanking_End   */
+    577,    /* V_Sync_Start     */
+    2       /* V_Sync_End       */
+};
+
+unsigned long ITV_CRTC_TABLE_1080I_800x600[] =3D {
+    1440,   /* H_Total          */=20
+    800,    /* H_Display_End    */
+    800,    /* H_Blanking_Start */
+    640,    /* H_Blanking_End   */
+    824,    /* H_Sync_Start     */
+    56,     /* H_Sync_End       */
+    625,    /* V_Total          */
+    600,    /* V_Display_End    */
+    600,    /* V_Blanking_Start */
+    25,     /* V_Blanking_End   */
+    605,    /* V_Sync_Start     */
+    6       /* V_Sync_End       */
+};
+
+unsigned long ITV_CRTC_TABLE_1080I_1024x768[] =3D {
+    1250,   /* H_Total          */=20
+    1024,   /* H_Display_End    */
+    1024,   /* H_Blanking_Start */
+    226,    /* H_Blanking_End   */
+    1032,   /* H_Sync_Start     */
+    64,     /* H_Sync_End       */
+    792,    /* V_Total          */
+    768,    /* V_Display_End    */
+    768,    /* V_Blanking_Start */
+    24,     /* V_Blanking_End   */
+    770,    /* V_Sync_Start     */
+    3       /* V_Sync_End       */
+};
+
+unsigned long ITV_NULL_TABLE[] =3D {
+    0xFFFF
+};
+
+
+struct integrated_tv_mode_table ITV_MODE_TABLE[] =3D {
+    {VIA_RES_640X480,   ITV_MODE_TABLE_NTSC_640x480,  =
ITV_MODE_TABLE_PAL_640x480,  ITV_MODE_TABLE_720P_1280x720, =
ITV_MODE_TABLE_1080I_1920x1080},
+    {VIA_RES_720X480,   ITV_MODE_TABLE_NTSC_720x480,  =
ITV_MODE_TABLE_NTSC_720x480, ITV_MODE_TABLE_720P_1280x720, =
ITV_MODE_TABLE_1080I_1920x1080},
+    {VIA_RES_720X576,   ITV_MODE_TABLE_PAL_720x576,   =
ITV_MODE_TABLE_PAL_720x576,  ITV_MODE_TABLE_720P_1280x720, =
ITV_MODE_TABLE_1080I_1920x1080},
+    {VIA_RES_800X600,   ITV_MODE_TABLE_NTSC_800x600,  =
ITV_MODE_TABLE_PAL_800x600,  ITV_MODE_TABLE_720P_1280x720, =
ITV_MODE_TABLE_1080I_1920x1080},
+    {VIA_RES_1024X768,  ITV_MODE_TABLE_NTSC_1024x768, =
ITV_MODE_TABLE_PAL_1024x768, ITV_MODE_TABLE_720P_1280x720, =
ITV_MODE_TABLE_1080I_1920x1080},
+    {VIA_RES_1280X720,  ITV_NULL_TABLE,               ITV_NULL_TABLE,   =
           ITV_MODE_TABLE_720P_1280x720, ITV_NULL_TABLE},
+    {VIA_RES_1920X1080, ITV_NULL_TABLE,               ITV_NULL_TABLE,   =
           ITV_NULL_TABLE,               ITV_MODE_TABLE_1080I_1920x1080}
+};
+
+
+struct integrated_tv_mode_table ITV_CRTC_TABLE[] =3D {
+    {VIA_RES_640X480,   ITV_CRTC_TABLE_NTSC_640x480,  =
ITV_CRTC_TABLE_PAL_640x480,  ITV_CRTC_TABLE_720P_640x480,  =
ITV_CRTC_TABLE_1080I_640x480},
+    {VIA_RES_720X480,   ITV_CRTC_TABLE_NTSC_720x480,  =
ITV_CRTC_TABLE_NTSC_720x480, ITV_CRTC_TABLE_720P_720x480,  =
ITV_CRTC_TABLE_1080I_720x480},
+    {VIA_RES_720X576,   ITV_CRTC_TABLE_PAL_720x576,   =
ITV_CRTC_TABLE_PAL_720x576,  ITV_CRTC_TABLE_720P_720x576,  =
ITV_CRTC_TABLE_1080I_720x576},
+    {VIA_RES_800X600,   ITV_CRTC_TABLE_NTSC_800x600,  =
ITV_CRTC_TABLE_PAL_800x600,  ITV_CRTC_TABLE_720P_800x600,  =
ITV_CRTC_TABLE_1080I_800x600},
+    {VIA_RES_1024X768,  ITV_CRTC_TABLE_NTSC_1024x768, =
ITV_CRTC_TABLE_PAL_1024x768, ITV_CRTC_TABLE_720P_1024x768, =
ITV_CRTC_TABLE_1080I_1024x768},
+    {VIA_RES_1280X720,  ITV_NULL_TABLE,               ITV_NULL_TABLE,   =
           ITV_CRTC_TABLE_720P_1280x720, ITV_NULL_TABLE},
+    {VIA_RES_1920X1080, ITV_NULL_TABLE,               ITV_NULL_TABLE,   =
           ITV_NULL_TABLE,               ITV_CRTC_TABLE_1080I_1920x1080}
+};
+
+
+#define NUM_TOTAL_INTEGRATEDTV_MODE_TABLE ARRAY_SIZE(ITV_MODE_TABLE)
+
+/***********************************************************************=
***************/
+/********************************** Patch Table for RGB =
*******************************/
+/***********************************************************************=
***************/
+unsigned short ITV_PATCH_TABLE_RGB_NTSC[] =3D {
+    0xE342,     /* BST_ED   */
+    0x8D46,     /* VID_ED   */
+    0x404A,     /* HSD      */
+    0x7F50,     /* VR_GAIN  */
+    0x1851,     /* SC_ON_VR */
+    0x7C52,     /* UB_GAIN  */
+    0x5853,     /* SC_ON_UB */
+    0x7254,     /* YG_GAIN  */
+    0x165C,     /* SYNC_SP  */
+    0x285E,     /* BRST_AMP */
+    0x015F,     /* BRST_AMP */
+    0xffff
+};
+
+unsigned short ITV_PATCH_TABLE_RGB_PAL[] =3D {
+    0xF442,     /* BST_ED       */
+    0x1E44,     /* VID_ST       */
+    0x004A,     /* HSD          */
+    0x9C50,     /* VR_GAIN      */
+    0x9852,     /* UB_GAIN      */
+    0xA554,     /* YG_GAIN      */
+    0xA055,     /* Blank Level  */
+    0x285E,     /* BRST_AMP     */
+    0xffff
+};
+
+
+/***********************************************************************=
***************/
+/******************************** Patch Table for YPbPr =
*******************************/
+/***********************************************************************=
***************/
+unsigned short ITV_PATCH_TABLE_YPBPR_NTSC[] =3D {
+    0xE342,     /* BST_ED       */
+    0x8D46,     /* VID_ED       */
+    0x404A,     /* HSD          */
+    0x9750,     /* VR_GAIN      */
+    0x9952,     /* UB_GAIN      */
+    0x8B54,     /* YG_GAIN      */
+    0x0057,     /* Blank Level  */
+    0x285E,     /* BRST_AMP     */
+    0x015F,     /* BRST_AMP     */
+    0x76E8,
+    0xffff
+};
+
+unsigned short ITV_PATCH_TABLE_YPBPR_PAL[] =3D {
+    0xF442,     /* BST_ED       */
+    0x1E44,     /* VID_ST       */
+    0x9C46,     /* VID_ED       */
+    0x004A,     /* HSD          */
+    0x9C50,     /* VR_GAIN      */
+    0x9852,     /* UB_GAIN      */
+    0x285E,     /* BRST_AMP     */
+    0xffff
+};
+
+
+
+/***********************************************************************=
***************/
+/******************************** Patch Table for 480P =
********************************/
+/***********************************************************************=
***************/
+unsigned short ITV_PATCH_TABLE_480P_640x480[] =3D {
+    0xC424, 0x0825, 0xE526, 0x0327,     /* Scaling Factor            */
+    0xB528, 0x0129, 0x292A,             /* DST H/V size              */
+    0x803A,                             /* TV's Standard             */
+    0x0040, 0x0042,                     /* BST_ST, BST_ED            */
+    0xFE44, 0x0045, 0x8F46,             /* VID_ST, VID_ED            */
+    0x404A,                             /* HSD                       */
+    0xCC4C, 0x814D, 0x0F4F,             /* HP, VP, VSD               */
+    0x6B50, 0x6B52,                     /* Chroma Ctrl               */
+    0x9054, 0xA055, 0x1C56, 0x0057,     /* Luma Ctrl                 */
+    0x175C, 0x005D, 0x005E, 0x005F,     /* Burst and Sync Shape Ctrl */
+    0x83E2,
+    0xFFFF
+};
+
+unsigned short ITV_PATCH_TABLE_480P_720x480[] =3D {
+    0xC424, 0x0825, 0x6226, 0x0427,     /* Scaling Factor            */
+    0xB528, 0x0129, 0xA92A,             /* DST H/V size              */
+    0x803A,                             /* TV's Standard             */
+    0x0040, 0x0042,                     /* BST_ST, BST_ED            */
+    0xFE44, 0x0045, 0x8F46,             /* VID_ST, VID_ED            */
+    0x404A,                             /* HSD                       */
+    0xA74C, 0x814D, 0x0F4F,             /* HP, VP, VSD               */
+    0x6B50, 0x6B52,                     /* Chroma Ctrl               */
+    0x9054, 0xA055, 0x1C56, 0x0057,     /* Luma Ctrl                 */
+    0x175C, 0x005D, 0x005E, 0x005F,     /* Burst and Sync Shape Ctrl */
+    0x83E2,
+    0xFFFF
+};
+
+unsigned short ITV_PATCH_TABLE_480P_800x600[] =3D {
+    0xF624, 0x0A25, 0xDF26, 0x0427,     /* Scaling Factor            */
+    0xB528, 0x0129, 0x292A,             /* DST H/V size              */
+    0x8436,                             /* DST_BUF_LINE              */
+    0x803A,                             /* TV's Standard             */
+    0x0040, 0x0042,                     /* BST_ST, BST_ED            */
+    0xFE44, 0x0045, 0x8F46,             /* VID_ST, VID_ED            */
+    0x404A,                             /* HSD                       */
+    0xA04C, 0x814D, 0x0F4F,             /* HP, VP, VSD               */
+    0x6B50, 0x6B52,                     /* Chroma Ctrl               */
+    0x9054, 0xA055, 0x1C56, 0x0057,     /* Luma Ctrl                 */
+    0x175C, 0x005D, 0x005E, 0x005F,     /* Burst and Sync Shape Ctrl */
+    0xC3E2,
+    0xFFFF
+};
+
+unsigned short ITV_PATCH_TABLE_480P_1024x768[] =3D {
+    0x0A24, 0x4126, 0x0627,             /* Scaling Factor            */
+    0xB528, 0xE129, 0x282A,             /* DST H/V size              */
+    0x803A,                             /* TV's Standard             */
+    0x0040, 0x0042,                     /* BST_ST, BST_ED            */
+    0xFE44, 0x0045, 0x8F46,             /* VID_ST, VID_ED            */
+    0x404A,                             /* HSD                       */
+    0xD44C, 0x814D, 0x0F4F,             /* HP, VP, VSD               */
+    0x6B50, 0x6B52,                     /* Chroma Ctrl               */
+    0x9054, 0xA055, 0x1C56, 0x0057,     /* Luma Ctrl                 */
+    0x175C, 0x005D, 0x005E, 0x005F,     /* Burst and Sync Shape Ctrl */
+    0xC3E2,
+    0xFFFF
+};
+
+
+/***********************************************************************=
***************/
+/******************************** Patch Table for 576P =
********************************/
+/***********************************************************************=
***************/
+unsigned short ITV_PATCH_TABLE_576P_640x480[] =3D {
+    0x6924, 0xF726, 0x0327,             /* Scaling Factor            */
+    0x0528, 0x3A29, 0x282A,             /* DST H/V size              */
+    0x883A,                             /* TV's Standard             */
+    0xF442,                             /* BST_ST, BST_ED            */
+    0x2144, 0x9C46,                     /* VID_ST, VID_ED            */
+    0x0048,                             /* BRD_ST                    */
+    0x104C, 0x824D, 0x124F,             /* HP, VP, VSD               */
+    0x9050, 0x9052,                     /* Chroma Ctrl               */
+    0x8F54, 0xA055,                     /* Luma Ctrl                 */
+    0x105C, 0x005E, 0x005F,             /* Burst and Sync Shape Ctrl */
+    0x83E2,
+    0xFFFF
+};
+
+unsigned short ITV_PATCH_TABLE_576P_720x576[] =3D {
+    0xE524, 0x0825, 0x7826, 0x0427,     /* Scaling Factor            */
+    0x0528, 0x3A29, 0xA82A,             /* DST H/V size              */
+    0x883A,                             /* TV's Standard             */
+    0xF442,                             /* BST_ST, BST_ED            */
+    0x2144, 0x9C46,                     /* VID_ST, VID_ED            */
+    0x0048,                             /* BRD_ST                    */
+    0x104C, 0x824D, 0x124F,             /* HP, VP, VSD               */
+    0x9050, 0x9052,                     /* Chroma Ctrl               */
+    0x8F54, 0xA055,                     /* Luma Ctrl                 */
+    0x105C, 0x005E, 0x005F,             /* Burst and Sync Shape Ctrl */
+    0x83E2,
+    0xFFFF
+};
+
+unsigned short ITV_PATCH_TABLE_576P_800x600[] =3D {
+    0x4424, 0xF726, 0x0427,             /* Scaling Factor            */
+    0x0528, 0x3A29, 0x282A,             /* DST H/V size              */
+    0x0F36, 0x0137,                     /* DST_BUF_LINE              */
+    0x883A,                             /* TV's Standard             */
+    0xF442,                             /* BST_ST, BST_ED            */
+    0x2144, 0x9C46,                     /* VID_ST, VID_ED            */
+    0x0048,                             /* BRD_ST                    */
+    0xA04C, 0x814D, 0x124F,             /* HP, VP, VSD               */
+    0x9050, 0x9052,                     /* Chroma Ctrl               */
+    0x8F54, 0xA055,                     /* Luma Ctrl                 */
+    0x105C, 0x005E, 0x005F,             /* Burst and Sync Shape Ctrl */
+    0xC3E2,
+    0xFFFF
+};
+
+unsigned short ITV_PATCH_TABLE_576P_1024x768[] =3D {
+    0xEA24, 0x0B25, 0x5D26, 0x0627,     /* Scaling Factor            */
+    0x0328, 0x3A29, 0x282A,             /* DST H/V size              */
+    0x883A,                             /* TV's Standard             */
+    0x0040, 0x0042,                     /* BST_ST, BST_ED            */
+    0x2144, 0x9C46,                     /* VID_ST, VID_ED            */
+    0x0048,                             /* BRD_ST                    */
+    0x204C, 0x824D, 0x124F,             /* HP, VP, VSD               */
+    0x9050, 0x9052,                     /* Chroma Ctrl               */
+    0x9054, 0xA055,                     /* Luma Ctrl                 */
+    0x105C, 0x005E, 0x005F,             /* Burst and Sync Shape Ctrl */
+    0xC3E2,
+    0xFFFF
+};
+
+/***********************************************************************=
***************/
+/******************************** Patch Table for 720P =
********************************/
+/***********************************************************************=
***************/
+unsigned short ITV_PATCH_TABLE_720P_640x480[] =3D {
+    0x0515, 0xDF18, 0xF919,
+    0xD31A, 0xDF20, 0x0121,
+    0x7F22, 0x2223,
+    0x5424, 0x0525,
+    0x5826,
+    0xCA29, 0x142B,
+    0x0535,
+    0x4C4A, 0x8A4C,
+    0x00DC,
+    0xC4E2,
+    0x02E3,
+    0xFFFF
+};
+
+unsigned short ITV_PATCH_TABLE_720P_720x480[] =3D {
+    0xC014, 0x0515, 0xDF18,
+    0x7919, 0xD61A, 0xDF20,
+    0x0121, 0xCF22, 0x2223,
+    0x5524, 0x0525, 0x8726,
+    0x0427, 0x272A, 0x172B,
+    0xC034, 0x0535, 0x7C4C,
+    0xC4E2, 0x02E3,
+    0xFFFF
+};
+
+unsigned short ITV_PATCH_TABLE_720P_720x576[] =3D {
+    0xC014, 0x0515, 0x3F18,
+    0x7A19, 0xD61A, 0x3F20,
+    0xCF22, 0x2223,
+    0x6524, 0x0625, 0x8826,
+    0x0427, 0x272A, 0x172B,
+    0xC034, 0x0535,       =20
+    0x64E2,
+    0xFFFF
+};
+
+unsigned short ITV_PATCH_TABLE_720P_800x600[] =3D {
+    0x4014, 0x0615, 0x8F16,
+    0x5718, 0xD81A, 0x0A1B,
+    0x5720, 0x1F22, 0x2323,
+    0xAE24, 0x0625, 0x0726,
+    0x0527, 0x192B,
+    0x4034, 0x0635, 0xF036, 0x074C,
+    0x64E2,
+    0xFFFF
+};
+
+unsigned short ITV_PATCH_TABLE_720P_1024x768[] =3D {
+    0x0815, 0x8F16,
+    0xFF18, 0xDF1A, 0x0A1B,
+    0xFF20, 0x2323,
+    0x8724, 0x2825, 0x0926,
+    0x0727, 0x202B,
+    0x0835, 0xF036, 0x074C,
+    0x00DC,=20
+    0x21E0, 0x0CE1, 0x24E2, 0x01E3, /* 66MHZ */
+    0xFFFF
+};
+
+/***********************************************************************=
***************/
+/******************************** Patch Table for 1080I =
********************************/
+/***********************************************************************=
***************/
+unsigned short ITV_PATCH_TABLE_1080I_640x480[] =3D {
+    0x0515, 0xDF18, 0xF919,
+    0xD31A, 0xDF20, 0x0121,
+    0x2223, 0x8E24, 0x2325,
+    0xAB26, 0x6227, 0x142B,
+    0x0535, 0x0936, 0x0137,
+    0xEB4C,
+    0xC4E2, 0x02E3,
+    0xFFFF
+};
+
+unsigned short ITV_PATCH_TABLE_1080I_720x480[] =3D {
+    0xC014, 0x0515, 0xDF18,
+    0x7919, 0xD61A, 0xDF20,
+    0x0121, 0xCF22, 0x2223,
+    0x8E24, 0x2325, 0x0226,
+    0x6327, 0x172B,=20
+    0xC034, 0x0535,=20
+    0xC4E2, 0x02E3,
+    0xFFFF
+};
+
+unsigned short ITV_PATCH_TABLE_1080I_720x576[] =3D {
+    0xC014, 0x0515, 0x3F18,
+    0x7A19, 0xD61A, 0x3F20,
+    0x0221, 0xCF22, 0x2223,
+    0x4524, 0x2425, 0x0226,
+    0x6327, 0x172B,
+    0xC034, 0x0535,        =20
+    0x64E2, 0x01E3,
+    0xFFFF
+};
+
+unsigned short ITV_PATCH_TABLE_1080I_800x600[] =3D {
+    0x4014, 0x0615, 0xFA19,
+    0x5718, 0xD81A, 0x0221,
+    0x5720, 0x1F22, 0x2323,
+    0x7324, 0x2425, 0x5626,
+    0x6327, 0x192B,=20
+    0x4034, 0x0635,
+    0x0936, 0x0137, 0xEB4C,
+    0x64E2, 0x01E3,
+    0xFFFF
+};
+
+unsigned short ITV_PATCH_TABLE_1080I_1024x768[] =3D {
+    0x0815, 0xFF18, 0xFA19,
+    0xDF1A, 0x0221,
+    0xFF20, 0xFF22, 0x2323,
+    0xB224, 0x2525, 0x4626,
+    0x6427, 0x202B,       =20
+    0x0835,                       =20
+    0x44E2, 0x01E3,
+    0xFFFF
+};
+
+
+unsigned short ITV_PATCH_TABLE_NULL[] =3D {
+    0xFFFF
+};
+
+struct integrated_tv_hdtv_patch_table ITV_HDTV_PATCH_TABLE[] =3D {
+    {VIA_RES_640X480,   ITV_PATCH_TABLE_480P_640x480,  =
ITV_PATCH_TABLE_576P_640x480,  ITV_PATCH_TABLE_720P_640x480, =
ITV_PATCH_TABLE_1080I_640x480},
+    {VIA_RES_720X480,   ITV_PATCH_TABLE_480P_720x480,  =
ITV_PATCH_TABLE_480P_720x480,  ITV_PATCH_TABLE_720P_720x480, =
ITV_PATCH_TABLE_1080I_720x480},
+    {VIA_RES_720X576,   ITV_PATCH_TABLE_576P_720x576,  =
ITV_PATCH_TABLE_576P_720x576,  ITV_PATCH_TABLE_720P_720x576, =
ITV_PATCH_TABLE_1080I_720x576},
+    {VIA_RES_800X600,   ITV_PATCH_TABLE_480P_800x600,  =
ITV_PATCH_TABLE_576P_800x600,  ITV_PATCH_TABLE_720P_800x600, =
ITV_PATCH_TABLE_1080I_800x600},
+    {VIA_RES_1024X768,  ITV_PATCH_TABLE_480P_1024x768, =
ITV_PATCH_TABLE_576P_1024x768, ITV_PATCH_TABLE_720P_1024x768, =
ITV_PATCH_TABLE_1080I_1024x768},
+    {VIA_RES_1280X720,  ITV_PATCH_TABLE_NULL,          =
ITV_PATCH_TABLE_NULL,          ITV_PATCH_TABLE_NULL,         =
ITV_PATCH_TABLE_NULL},
+    {VIA_RES_1920X1080, ITV_PATCH_TABLE_NULL,          =
ITV_PATCH_TABLE_NULL,          ITV_PATCH_TABLE_NULL,         =
ITV_PATCH_TABLE_NULL}
+
+};
+
+
+#endif
diff -Nur linux-2.6.21-rc7/drivers/video/via/tv.c =
linux-2.6.21-rc7.viafb/drivers/video/via/tv.c
--- linux-2.6.21-rc7/drivers/video/via/tv.c 1969-12-31 =
19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/tv.c 2007-04-26 =
19:52:32.000000000 -0400
@@ -0,0 +1,1567 @@
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
+#include "tv.h"
+#include "chip.h"
+#include "share.h"
+#include "debug.h"
+#include "ioctl.h"
+#include "IntegratedTV.h"
+
+/* TV Encoder Extern Function */
+extern void vt1622_tv_disable(void);
+extern void vt1622_tv_enable(void);
+extern void load_vt1622_regs(int TVModeIndex);
+extern int  vt1622_tv_encoder_identify(void);
+extern int vt1622_sense(void);
+extern int vt1622_auto_sense(void);
+
+extern void vt1622a_tv_disable(void);
+extern void vt1622a_tv_enable(void);
+extern void load_vt1622a_regs(int TVModeIndex);
+extern int  vt1622a_tv_encoder_identify(void);
+extern int vt1622a_sense(void);
+extern int vt1622a_auto_sense(void);
+
+extern void vt1625_tv_disable(void);
+extern void vt1625_tv_enable(void);
+extern void load_vt1625_regs(int TVModeIndex);
+extern int  vt1625_tv_encoder_identify(void);
+extern int vt1625_sense(void);
+extern int vt1625_auto_sense(void);
+extern void init_tv_vt1625(void);
+
+extern int integrated_tv_encoder_identify(void);
+extern void integrated_tv_enable(void);
+extern void integrated_tv_disable(void);
+extern void set_integrated_tv_mode(int tv_mode_index);
+extern void get_integrated_tv_default_status(void);
+extern int get_integrated_tv_ffilter_status(int filter_type, int* =
filter_state);
+extern void get_integrated_tv_pos(u32* current_hpos, u32* =
current_vpos);
+extern void set_integrated_tv_ffilter_status(int filter_type, int =
filter_on_off, u32 desired_value);
+extern void set_integrated_tv_hue(u32 desired_value);
+extern void set_integrated_tv_brightness(u32 desired_value);
+extern void set_integrated_tv_pos(u32 desired_hpos, u32 desired_vpos);
+extern void set_integrated_tv_size(u32 desired_hsize, u32 =
desired_vsize);
+extern int integrated_tv_sense(void);
+
+
+extern void SetVCLK(u32 CLK, int set_iga);
+extern inline void write_reg(u8 index, u16 io_port, u8 data);
+extern void write_reg_mask(u8 index, int io_port, u8 data, u8 mask);
+extern int i2cWriteByte(u8 bSlaveAddress, u8 bIndex, u8 bData);
+extern int i2cReadByte(u8 bSlaveAddress, u8 bIndex, u8 *pbData);
+extern void set_output_path(int device, int set_iga, int =
output_interface);
+extern inline u8 read_reg(int io_port, u8 index);
+extern void load_FIFO_reg(int set_iga, int hor_active, int ver_active);
+extern void set_color_depth(int bpp_byte, int set_iga);
+extern void set_integrated_tv_contrast(u32 desired_value);
+extern void set_integrated_tv_saturation(u32 desired_value);
+
+bool  is_tv_mode(struct tv_chip_information* ptv_chip_info, struct =
tv_setting_information* ptv_setting_info,
+                             int video_index);
+bool is_vt1625_mode(struct tv_chip_information* ptv_chip_info, struct =
tv_setting_information* ptv_setting_info,
+                             int video_index);
+
+/* extern struct */
+extern struct chip_information      chip_info;
+extern struct tv_setting_information    tv_setting_info;
+
+extern int HotPlug_TV;
+
+extern long tv_ffilter;
+extern long tv_brightness;
+extern long tv_contrast;
+extern long tv_saturation;
+extern long tv_tint;
+extern long tv_pos_hor_current;
+extern long tv_pos_ver_current;
+
+int tv_encoder_identify(void)
+{
+    chip_info.tv_chip_info.tv_chip_name =3D VT1622;
+    chip_info.tv_chip_info.tv_chip_slave_addr =3D VT1622_TV_I2C_ADDR;
+
+    if (vt1622_tv_encoder_identify()!=3D FAIL)
+    {
+        DEBUG_MSG(KERN_INFO "\n VT1622 VT1622 ! \n");
+        DEBUG_MSG(KERN_INFO "\n %2d", =
chip_info.tv_chip_info.tv_chip_name);
+        DEBUG_MSG(KERN_INFO "\n %2d", =
chip_info.tv_chip_info.tv_chip_name);
+        return(OK);
+    }
+
+    chip_info.tv_chip_info.tv_chip_name =3D VT1622A;
+    chip_info.tv_chip_info.tv_chip_slave_addr =3D VT1622A_TV_I2C_ADDR;
+
+    if (vt1622a_tv_encoder_identify()!=3D FAIL)
+    {
+        DEBUG_MSG(KERN_INFO "\n VT1622A VT1622A ! \n");
+        DEBUG_MSG(KERN_INFO "\n %2d", =
chip_info.tv_chip_info.tv_chip_name);
+        DEBUG_MSG(KERN_INFO "\n %2d", =
chip_info.tv_chip_info.tv_chip_name);
+        return(OK);
+    }
+
+    chip_info.tv_chip_info.tv_chip_name =3D VT1625;
+    chip_info.tv_chip_info.tv_chip_slave_addr =3D VT1625_TV_I2C_ADDR;
+
+    if (vt1625_tv_encoder_identify()!=3D FAIL)
+    {
+        DEBUG_MSG(KERN_INFO "\n VT1625 VT1625 ! \n");
+        DEBUG_MSG(KERN_INFO "\n %2d", =
chip_info.tv_chip_info.tv_chip_name);
+        DEBUG_MSG(KERN_INFO "\n %2d", =
chip_info.tv_chip_info.tv_chip_name);
+        return(OK);
+    }
+
+    /* Check for VT3324 integrated TV. */
+    chip_info.tv_chip_info.tv_chip_name =3D INTEGRATED_TV;
+
+    if (integrated_tv_encoder_identify() !=3D FAIL)
+    {
+        chip_info.tv_chip_info.output_interface =3D INTERFACE_NONE;
+        DEBUG_MSG(KERN_INFO "\n Found Integrated TV ! \n");
+        return OK;
+    }   =20
+
+   =20
+
+    chip_info.tv_chip_info.tv_chip_name =3D NON_TV_ENCODER;
+    chip_info.tv_chip_info.tv_chip_slave_addr =3D NON_TV_ENCODER;
+    return(FAIL);
+}
+
+void tv_disable(void)
+{
+    /* Disable HW Reset */
+    outb(0x6b,VIACR);
+    outb(0,VIACR+1);      /* clear CR6B=3D0 */
+    outb(0x6c,VIACR);
+    outb(0,VIACR+1);      /* clear CR6C=3D0 */
+
+    switch(chip_info.tv_chip_info.tv_chip_name)
+    {
+        case VT1622:
+            vt1622_tv_disable();
+            break;
+
+        case VT1622A:
+            vt1622a_tv_disable();
+            break;
+
+        case VT1625:
+            vt1625_tv_disable();
+            break;
+
+        case INTEGRATED_TV:
+            integrated_tv_disable();
+            break;
+               =20
+    }
+}
+
+void tv_load_timing_init(void)
+{
+    switch(chip_info.tv_chip_info.tv_chip_name)
+    {
+        case VT1622:
+            break;
+
+        case VT1622A:
+            break;
+
+        case VT1625:
+            init_tv_vt1625();
+            break;
+           =20
+    }
+}
+
+void VIAPitchAlignmentPatch(void)
+{
+    unsigned char      cr13, cr35, cr65, cr66, cr67;
+    unsigned long     dwScreenPitch=3D 0;
+    unsigned long     dwPitch;
+
+    dwPitch =3D tv_setting_info.h_active * (tv_setting_info.bpp >> 3);
+    dwPitch =3D tv_setting_info.h_active *(tv_setting_info.bpp>> 3);
+    if (dwPitch & 0x1F)=20
+   {   /* Is 32 Byte Alignment ? */
+        dwScreenPitch =3D ((dwPitch + 31) & ~31) >> 3;
+        if ( tv_setting_info.iga_path=3D=3DIGA2)
+        {
+            if(tv_setting_info.bpp>8) {    =20
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
+            if(tv_setting_info.bpp>8) {    =20
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
+void tv_load_timing(int TVModeIndex)
+{
+    unsigned char cr65, cr66, cr67;
+    unsigned char  cr13, cr35, sr1c, sr1d;
+    int                   countWidthByQWord, offsetWidthByQWord;
+
+    switch(chip_info.tv_chip_info.tv_chip_name)
+    {
+        case VT1622:
+            load_vt1622_regs(TVModeIndex);
+            break;
+
+        case VT1622A:
+            load_vt1622a_regs(TVModeIndex);
+            break;
+
+        case VT1625:
+            load_vt1625_regs(TVModeIndex);
+            break;
+
+        case INTEGRATED_TV:
+            set_integrated_tv_mode(TVModeIndex);
+            break;
+
+    }
+
+    /* Set Quadword offset,counter of primary and secondary screen.Fix =
colorkey  =20
+       problem when using CRT+TV SAMM state. Not consider using virtual =
desktop */
+    offsetWidthByQWord =3D =
(tv_setting_info.h_active*(tv_setting_info.bpp>> 3)) >> 3;
+    countWidthByQWord =3D (tv_setting_info.h_active =
*(tv_setting_info.bpp>> 3)) >> 3;
+
+    if(tv_setting_info.iga_path=3D=3DIGA2)
+    { =20
+        cr67 =3D read_reg(VIACR, CR67) & 0xFC;
+        cr66 =3D offsetWidthByQWord & 0xFF;
+        cr67 |=3D (offsetWidthByQWord & 0x300) >> 8;
+
+        write_reg(CR66, VIACR, cr66);
+        write_reg(CR67, VIACR, cr67);
+
+        cr67 =3D read_reg(VIACR, CR67) & 0xF3;
+
+        cr67 |=3D (countWidthByQWord & 0x600) >> 7;
+        cr65 =3D (countWidthByQWord >> 1) & 0xff;
+
+        write_reg(CR65, VIACR, cr65);
+        write_reg(CR67, VIACR, cr67);
+
+        /* We also should set FIFO related registers if TV use IGA2, or =
TV display may incorrect.*/
+        if((chip_info.gfx_chip_name !=3D UNICHROME_CLE266) && =
(chip_info.gfx_chip_name !=3D UNICHROME_K400)) { /* Because =
load_FIFO_reg() will load incorrect regs for CLE266&K400 */
+            load_FIFO_reg(IGA2, tv_setting_info.h_active, =
tv_setting_info.v_active);
+        }
+
+        set_color_depth(tv_setting_info.bpp >> 3, IGA2);
+ =20
+        /* Patch for non 32bit alignment mode */
+        VIAPitchAlignmentPatch();
+    } =20
+    else
+    {
+        cr35 =3D read_reg(VIACR, CR35) & 0x1F;
+        cr13 =3D offsetWidthByQWord & 0xFF;
+        cr35 |=3D (offsetWidthByQWord & 0x700) >> 3;        /* bit 7:5: =
offset 10:8 */
+
+        sr1d =3D read_reg(VIASR, SR1D);
+
+        /* Patch for non 32bit alignment mode */
+        VIAPitchAlignmentPatch();
+
+        /* Enable Refresh to avoid data lose when enter screen saver */
+        /* Refresh disable & 128-bit alignment */
+        sr1d =3D (sr1d & 0xFC) | (countWidthByQWord >> 9);
+        sr1c =3D ((countWidthByQWord >> 1) + 1) & 0xFF;
+        /* sr1d =3D ((sr1d & 0xFC) | (widthByQWord >> 8)) | 0x80; */
+        /* sr1c =3D widthByQWord & 0xFF; */
+
+        write_reg(CR13, VIACR, cr13);
+        write_reg(CR35, VIACR, cr35);
+        write_reg(SR1C, VIASR, sr1c);
+        write_reg(SR1D, VIASR, sr1d);
+    } =20
+}
+
+void tv_load_timing_modify(void)
+{
+     switch(chip_info.tv_chip_info.tv_chip_name) {
+        case VT1622:
+                break;
+        case VT1622A:
+                break;
+        case VT1625:
+                break;
+
+    }
+}
+
+void tv_patch(int tv_mode_index)
+{
+    switch(chip_info.tv_chip_info.tv_chip_name)
+    {
+        case VT1622A:
+        case VT1623:
+            switch(chip_info.gfx_chip_name)
+            {
+                case UNICHROME_K800:
+                    tv_patch_skew_K800();
+                    break;
+                default:
+                    break;
+            }
+            break;
+
+        case VT1625:
+            switch(tv_setting_info.out_signal)
+            {
+                case TV_OUTPUT_SVIDEO:
+                case TV_OUTPUT_COMPOSITE_SVIDEO:
+                    /* Set TV.65h =3D 51h, SVideo Luma Value. */
+                    tv_register_write(0x65, 0x51);
+                    break;
+                default:
+                    break;
+            }
+
+            switch(chip_info.gfx_chip_name)
+            {
+                case UNICHROME_P880:
+                    tv_patch_skew_p880(tv_mode_index);
+                    break;
+                   =20
+                case UNICHROME_CN900:
+                    tv_patch_skew_cn900(tv_mode_index);
+                    break;
+
+                case UNICHROME_CX700:
+                    tv_patch_skew_cx700(tv_mode_index);
+                    break;
+
+                /* Add to support VT3327 VT3336 VT3364 */
+                case UNICHROME_K8M890:
+                    tv_patch_skew_k8m890(tv_mode_index);
+                    break;
+                   =20
+                case UNICHROME_P4M890:
+                    tv_patch_skew_p4m890(tv_mode_index);
+                    break;
+
+                case UNICHROME_P4M900:
+                     tv_patch_skew_p4m900(tv_mode_index);
+                    break;
+                   =20
+                default:
+                    break;
+            }
+           =20
+            break;
+
+        default:
+            break;
+    }
+}
+
+void tv_enable(void)
+{
+    switch(tv_setting_info.iga_path)
+    {
+        case IGA1:
+            set_output_path(DEVICE_TV, IGA1, =
chip_info.tv_chip_info.output_interface);
+            break;
+
+        case IGA2:
+            set_output_path(DEVICE_TV, IGA2, =
chip_info.tv_chip_info.output_interface);
+            break;
+
+        case IGA1_IGA2:
+            break;
+    }
+
+
+    switch(chip_info.tv_chip_info.tv_chip_name)
+    {
+        case VT1622:
+            vt1622_tv_enable();
+            break;
+
+        case VT1622A:
+            vt1622a_tv_enable();
+            break;
+
+        case VT1625:
+            vt1625_tv_enable();
+            break;
+
+        case INTEGRATED_TV:
+            integrated_tv_enable();
+            break;
+
+     }
+
+    /* For hot-plug issue:
+       If switch to TV, it would use TV auto-sense function to sense =
TV. */
+    if(HotPlug_TV =3D=3D 1)
+    {
+        if(chip_info.tv_chip_info.tv_chip_name =3D=3D VT1625)
+        {
+            tv_register_write(0x1C, tv_register_read(0x1C) | BIT6);
+            tv_register_write(0x0E, 0x00);
+        }
+        else
+        {
+            tv_register_write(0x0E, 0x40);
+        }
+    }
+
+}
+
+void tv_register_write(int index, u8 data)
+{
+    i2cWriteByte(chip_info.tv_chip_info.tv_chip_slave_addr, index, =
data);
+}
+
+int tv_register_read(int index)
+{
+    u8 data =3D 0; /* Fix me:should need another parameter to indicate =
whether read is successful */
+    int status;
+
+    status =3D i2cReadByte(chip_info.tv_chip_info.tv_chip_slave_addr, =
index, &data);
+    return(data);
+}
+
+void load_tv_output_signal(u16 *tv_func_reg)
+{
+    int i=3D0;
+
+    while(tv_func_reg[i]!=3D 0xFFFF)
+    {
+        =
tv_register_write(GET_LOW_BYTE(tv_func_reg[i]),GET_HIGH_BYTE(tv_func_reg[=
i]));
+        i++;
+    }
+
+}
+
+void write_tv_patch_table(u16 *tv_func_reg)
+{
+    int i=3D0;
+
+    while(tv_func_reg[i]!=3D 0xFFFF)
+    {
+        =
tv_register_write(GET_LOW_BYTE(tv_func_reg[i]),GET_HIGH_BYTE(tv_func_reg[=
i]));
+        i++;
+    }
+}
+
+bool is_tv_mode(struct tv_chip_information* ptv_chip_info, struct =
tv_setting_information* ptv_setting_info,
+                             int video_index)
+{
+    bool re =3D FALSE;
+    switch(ptv_chip_info->tv_chip_name)
+    {
+        case VT1621:
+            if(VIA_RES_640X480  =3D=3D video_index || VIA_RES_800X600 =
=3D=3D video_index)
+            {
+                WARN_MSG(KERN_WARNING "The specified tv mode is not =
valid for currently used  tv encoder\n");
+                re =3D TRUE;
+            }
+            break;
+        case VT1622:
+        case VT1622A:
+        case VT1623:
+            if (VIA_RES_640X480 =3D=3D video_index ||VIA_RES_800X600 =
=3D=3D video_index ||
+                VIA_RES_1024X768 =3D=3D video_index || VIA_RES_720X480 =
=3D=3D video_index ||
+                VIA_RES_720X576=3D=3D video_index || VIA_RES_848X480 =
=3D=3D video_index)
+            {
+                WARN_MSG(KERN_WARNING "The specified tv mode is not =
valid for currently used  tv encoder\n");
+                re =3D TRUE;
+            }
+            break;
+        case VT1625:          =20
+            re =3D is_vt1625_mode(ptv_chip_info, ptv_setting_info, =
video_index);
+            break;
+        case INTEGRATED_TV:
+            if(CX700_REVISION_700 =3D=3D chip_info.gfx_chip_revision)
+            {
+                switch(ptv_setting_info->system)
+                {
+                    case TVTYPE_480P:
+                    case TVTYPE_576P:
+                    case TVTYPE_720P:
+                    case TVTYPE_1080I:
+                        WARN_MSG(KERN_WARNING "HDTV is not supported =
for currently used  tv encoder\n");
+                        re =3D FALSE;
+                        return re;
+                        break;
+                    default:
+                        break;
+                }
+            }
+            if (VIA_RES_640X480 =3D=3D video_index ||VIA_RES_800X600 =
=3D=3D video_index ||
+                VIA_RES_1024X768 =3D=3D video_index || VIA_RES_720X480 =
=3D=3D video_index ||
+                VIA_RES_720X576=3D=3D video_index || VIA_RES_1280X720 =
=3D=3D video_index ||
+                VIA_RES_1920X1080 =3D=3D video_index)
+            {
+                WARN_MSG(KERN_WARNING "The specified tv mode is not =
valid for currently used  tv encoder\n");
+                re =3D TRUE;
+            }
+            break;
+    }
+    return re;
+}
+/* TV Set Mode */
+void tv_set_mode(int video_index)
+{
+    if(is_tv_mode(&chip_info.tv_chip_info, &tv_setting_info, =
video_index))
+    {
+        tv_encoder_identify();
+        tv_disable();
+        tv_load_timing_init();
+        tv_load_timing(video_index);
+        tv_load_timing_modify();
+        tv_patch(video_index);
+        tv_enable();
+        tv_set_color();
+    }
+    else
+    {
+        WARN_MSG(KERN_WARNING "TV will not be enabled\n");
+    }
+}
+
+/* Sense function only support VIA TV encoder */
+int tv_sense(void)
+{
+    int ret;
+
+    DEBUG_MSG(KERN_INFO "tv_sense!!\n");
+
+    switch(chip_info.tv_chip_info.tv_chip_name)
+    {
+        case VT1622:
+            ret =3D vt1622_sense();
+            break;
+
+        case VT1622A:
+            ret =3D vt1622a_sense();
+            break;
+
+        case VT1625:
+            ret =3D vt1625_sense();
+            break;
+
+        /* Add for VT3324 Integrated TV. */
+        case INTEGRATED_TV:
+            ret =3D integrated_tv_sense();
+            break;
+           =20
+        default:
+            ret =3D TV_OUTPUT_NONE;
+            break;
+    }
+
+    return ret;
+}
+
+/* Auto sense function only support VIA TV encoder */
+int tv_auto_sense(void)
+{
+    int ret;
+
+    DEBUG_MSG(KERN_INFO "tv_auto_sense!!\n");
+
+    switch(chip_info.tv_chip_info.tv_chip_name) {
+        case VT1622:
+            ret =3D vt1622_auto_sense();
+            break;
+        case VT1622A:
+            ret =3D vt1622a_auto_sense();
+            break;
+        case VT1625:
+            ret =3D vt1625_auto_sense();
+            break;
+        default:
+            ret =3D TV_OUTPUT_NONE;
+            break;
+     }
+
+    return ret;
+}
+
+void tv_patch_skew_K800(void)
+{
+    switch(chip_info.tv_chip_info.output_interface)
+    {
+        case INTERFACE_DVP0:
+            write_reg_mask(CR96, VIACR, 0x07, BIT0+BIT1+BIT2);
+            break;
+        case INTERFACE_DVP1:
+            write_reg_mask(CR9B, VIACR, 0x07, BIT0+BIT1+BIT2);
+            break;
+        case INTERFACE_DFP_HIGH:
+            write_reg_mask(CR97, VIACR, 0x07, BIT0+BIT1+BIT2);
+            break;
+        case INTERFACE_DFP_LOW:
+            write_reg_mask(CR99, VIACR, 0x07, BIT0+BIT1+BIT2);
+            break;
+    }
+}
+
+/* For VT3314 */
+void tv_patch_skew_cn900(int tv_mode_index)
+{
+    u8 data;
+   =20
+    switch(chip_info.tv_chip_info.output_interface)
+    {
+        case INTERFACE_DVP0:
+            /* Reset clock and data driving first: */
+            write_reg_mask(SR2A, VIASR, 0, BIT4+BIT5);
+            write_reg_mask(SR1E, VIASR, 0, BIT2);
+            write_reg_mask(SR1B, VIASR, 0, BIT1);
+           =20
+            /* For TV display incorrect color */
+            /* with VT5907A (VT1625-AMR) on VN800.*/           =20
+            if (tv_setting_info.system =3D=3D TVTYPE_PAL)
+            {
+                /* It still has a little bit problem in this mode. */
+                if ((tv_mode_index =3D=3D VIA_RES_1024X768) && =
(tv_setting_info.level =3D=3D TV_SIZE_OVER_SCAN))
+                {
+                    /* Adjust clock driving: */
+                    write_reg_mask(SR2A, VIASR, BIT4, BIT4);
+                    write_reg_mask(SR1E, VIASR, BIT2, BIT2);
+                }               =20
+            }
+            else if (tv_setting_info.system =3D=3D TVTYPE_576P)
+            {
+                /* It still has a little bit problem in this mode. */
+                if ((tv_mode_index =3D=3D VIA_RES_1024X768) && =
(tv_setting_info.level =3D=3D TV_SIZE_OVER_SCAN))
+                {
+                    /* Adjust clock driving: */
+                    write_reg_mask(SR2A, VIASR, BIT4, BIT4);
+                    write_reg_mask(SR1E, VIASR, BIT2, BIT2);
+                }               =20
+            }
+            else if (tv_setting_info.system =3D=3D TVTYPE_720P)
+            {
+                if ((tv_mode_index =3D=3D VIA_RES_1024X768) && =
(tv_setting_info.level =3D=3D TV_SIZE_NORMAL_SCAN))
+                {
+                    /* Adjust data driving: */
+                    write_reg_mask(SR2A, VIASR, BIT5, BIT5);
+                    write_reg_mask(SR1B, VIASR, BIT1, BIT1);
+                   =20
+                    write_reg_mask(CR96, VIACR, 0x07, =
BIT0+BIT1+BIT2+BIT3);
+                   =20
+                    data =3D tv_register_read(0x05);
+                    data =3D (data & 0xE0) | 0x1E;
+                    tv_register_write(0x05, data);
+                }
+            }
+            else if (tv_setting_info.system =3D=3D TVTYPE_1080I)
+            {
+                if ((tv_mode_index =3D=3D VIA_RES_1024X768) && =
(tv_setting_info.level =3D=3D TV_SIZE_NORMAL_SCAN))
+                {
+                    /* Adjust clock driving: */
+                    write_reg_mask(SR2A, VIASR, BIT4, BIT4);
+                    write_reg_mask(SR1E, VIASR, BIT2, BIT2);
+                   =20
+                    /* Adjust data driving: */
+                    write_reg_mask(SR2A, VIASR, BIT5, BIT5);
+                    write_reg_mask(SR1B, VIASR, BIT1, BIT1);
+
+                   =20
+                    write_reg_mask(CR96, VIACR, 0x07, =
BIT0+BIT1+BIT2+BIT3);
+                   =20
+                    data =3D tv_register_read(0x05);
+                    data =3D (data & 0xF0) | 0x09;
+                    tv_register_write(0x05, data);
+                }
+                else if ((tv_mode_index =3D=3D VIA_RES_1024X768) && =
(tv_setting_info.level =3D=3D TV_SIZE_OVER_SCAN))
+                {
+                    /* Adjust clock driving: */
+                    write_reg_mask(SR2A, VIASR, BIT4, BIT4);
+                    write_reg_mask(SR1E, VIASR, BIT2, BIT2);
+                }
+                else if(tv_mode_index =3D=3D VIA_RES_1920X1080)
+                {
+                    /* For both normal scan and over scan */
+                    /* It still has a little bit problem in this mode. =
*/
+                   =20
+                    /* Adjust clock driving: */
+                    write_reg_mask(SR2A, VIASR, BIT4, BIT4);
+                    write_reg_mask(SR1E, VIASR, BIT2, BIT2);
+                   =20
+                    /* Adjust data driving: */
+                    write_reg_mask(SR2A, VIASR, 0, BIT5);
+                    write_reg_mask(SR1B, VIASR, BIT1, BIT1);
+                   =20
+                    data =3D tv_register_read(0x05);
+                    data =3D (data & 0xF0);
+                    tv_register_write(0x05, data);
+                }
+            }           =20
+           =20
+            break;
+
+        case INTERFACE_DVP1:
+            break;
+
+        case INTERFACE_DFP_HIGH:
+            break;
+
+        case INTERFACE_DFP_LOW:
+            break;
+    }
+}=20
+
+/* For VT3324 */
+void tv_patch_skew_cx700(int tv_mode_index)
+{
+    switch(chip_info.tv_chip_info.output_interface)
+    {
+        case INTERFACE_DVP0:
+            /* For TV display incorrect color */
+            /* with VT5907A (VT1625-AMR) on CX700.*/           =20
+            if (tv_setting_info.system =3D=3D TVTYPE_720P)
+            {
+                if ((tv_mode_index =3D=3D VIA_RES_1024X768) && =
(tv_setting_info.level =3D=3D TV_SIZE_NORMAL_SCAN))
+                {
+                    write_reg_mask(CR96, VIACR, 0x0F, =
BIT0+BIT1+BIT2+BIT3);
+                }
+            }
+
+            break;
+
+        case INTERFACE_DVP1:
+            if (tv_setting_info.system =3D=3D TVTYPE_720P)
+            {
+                if ((tv_mode_index =3D=3D VIA_RES_1024X768) && =
(tv_setting_info.level =3D=3D TV_SIZE_NORMAL_SCAN))
+                {
+                    write_reg_mask(CR9B, VIACR, 0x02, BIT0+BIT1);
+                }
+            }else if (tv_setting_info.system =3D=3D TVTYPE_1080I)
+            {
+                if ((tv_mode_index =3D=3D VIA_RES_1024X768) && =
(tv_setting_info.level =3D=3D TV_SIZE_NORMAL_SCAN))
+                {
+                    write_reg_mask(CR9B, VIACR, 0x02, BIT0+BIT1);
+                }
+            }
+            break;
+    }
+}=20
+
+/* For VT3259 */
+void tv_patch_skew_p880(int tv_mode_index)
+{
+    u8 data;
+   =20
+    switch(chip_info.tv_chip_info.output_interface)
+    {
+        case INTERFACE_DVP0:
+            /* Reset clock and data driving first: */
+            write_reg_mask(SR2A, VIASR, 0, BIT4+BIT5);
+            write_reg_mask(SR1E, VIASR, 0, BIT2);
+            write_reg_mask(SR1B, VIASR, 0, BIT1);
+
+            /* For TV display incorrect color */
+            /* with VT5907A (VT1625-AMR) on CN400.*/
+            if (tv_setting_info.system =3D=3D TVTYPE_PAL)
+            {
+                if ((tv_mode_index =3D=3D VIA_RES_1024X768) && =
(tv_setting_info.level =3D=3D TV_SIZE_OVER_SCAN))
+                {
+                    /* Adjust clock driving: */
+                    write_reg_mask(SR1E, VIASR, BIT2, BIT2);
+                }
+            }
+            else if (tv_setting_info.system =3D=3D TVTYPE_576P)
+            {
+                if ((tv_mode_index =3D=3D VIA_RES_1024X768) && =
(tv_setting_info.level =3D=3D TV_SIZE_OVER_SCAN))
+                {
+                    /* Adjust clock driving: */
+                    write_reg_mask(SR2A, VIASR, BIT4, BIT4);
+                }
+            }
+            else if (tv_setting_info.system =3D=3D TVTYPE_720P)
+            {
+                if ((tv_mode_index =3D=3D VIA_RES_1024X768) && =
(tv_setting_info.level =3D=3D TV_SIZE_NORMAL_SCAN))
+                {
+                    write_reg_mask(CR96, VIACR, BIT3, =
BIT0+BIT1+BIT2+BIT3);
+                   =20
+                    data =3D tv_register_read(0x05);
+                    data =3D (data & 0xF0) | 0x0E;
+                    tv_register_write(0x05, data);
+                }
+            }
+            else if (tv_setting_info.system =3D=3D TVTYPE_1080I)
+            {
+                if ((tv_mode_index =3D=3D VIA_RES_1024X768) && =
(tv_setting_info.level =3D=3D TV_SIZE_OVER_SCAN))
+                {
+                    /* Adjust clock driving: */
+                    write_reg_mask(SR1E, VIASR, BIT2, BIT2);
+                }
+            }
+           =20
+            break;
+
+        case INTERFACE_DVP1:
+            break;
+
+        case INTERFACE_DFP_HIGH:
+            break;
+
+        case INTERFACE_DFP_LOW:
+            break;
+    }
+}
+
+/* Add for support VT3327 VT3336 VT3364.
+ * Modified from X driver's code.
+ */
+void tv_patch_skew_k8m890(int tv_mode_index)
+{
+    switch(chip_info.tv_chip_info.output_interface)
+    {
+        case INTERFACE_DVP0:
+            /* Fix TV display incorrect color when set 1080i TV mode */
+            /* with VT5907A (VT1625-AMR) on VT3336. */
+            if (tv_setting_info.system =3D=3D TVTYPE_1080I)
+            {
+                if (tv_mode_index =3D=3D VIA_RES_1024X768)
+                {
+                    write_reg_mask(CR96, VIACR, 0x04, BIT0+BIT1+BIT2);
+                }
+                else if(tv_mode_index =3D=3D VIA_RES_1920X1080)
+                {
+                    write_reg_mask(CR96, VIACR, 0x00, BIT0+BIT1+BIT2);
+                }
+            }
+           =20
+            break;
+        case INTERFACE_DVP1:
+            break;
+        case INTERFACE_DFP_HIGH:
+            break;
+        case INTERFACE_DFP_LOW:
+            break;
+    }
+}
+
+
+void tv_patch_skew_p4m890(int tv_mode_index)
+{
+
+    switch(chip_info.tv_chip_info.output_interface)
+    {
+        case INTERFACE_DVP0:
+            /* For TV display incorrect color */
+            /* with VT5907A (VT1625-AMR) on P4M890.*/           =20
+            if (tv_setting_info.system =3D=3D TVTYPE_1080I)
+            {
+                if (tv_mode_index =3D=3D VIA_RES_1024X768)
+                {
+                    write_reg_mask(CR96, VIACR, 0x04, BIT0+BIT1+BIT2);
+                }
+            }
+           =20
+            /* For TV display incorrect color */
+            /* VT1625-AMR on P4M890.*/  =20
+            if (tv_setting_info.system =3D=3D TVTYPE_720P)
+            {
+                if (tv_mode_index =3D=3D VIA_RES_1024X768)
+                {
+                    write_reg_mask(CR96, VIACR, 0x07, BIT0+BIT1+BIT2);
+                }
+            }
+
+            break;
+    }
+}=20
+
+void tv_patch_skew_p4m900(int tv_mode_index)
+{
+
+    switch(chip_info.tv_chip_info.output_interface)
+    {
+        case INTERFACE_DVP0:
+            /* For TV display incorrect color */
+            /* with VT5907A (VT1625-AMR) on P4M900.*/           =20
+            if (tv_setting_info.system =3D=3D TVTYPE_1080I)
+            {
+                if (tv_mode_index =3D=3D VIA_RES_1024X768)
+                {
+                    write_reg_mask(CR96, VIACR, 0x04, BIT0+BIT1+BIT2);
+                }
+            }
+
+            if (tv_setting_info.system =3D=3D TVTYPE_720P)
+            {
+                if (tv_mode_index =3D=3D VIA_RES_1024X768)
+                {
+                    write_reg_mask(CR96, VIACR, 0x04, BIT0+BIT1+BIT2);
+                }
+            }
+            break;
+    }
+}=20
+
+
+void tv_set_color()
+{
+    /* Get TV color default, current value and level*/
+    switch(chip_info.tv_chip_info.tv_chip_name) {
+        case VT1622:
+        case VT1622A:
+        case VT1623:
+        case VT1625:
+            tv_setting_info.DefaultFFilter =3D tv_register_read(0x03) & =
0x03;
+            tv_setting_info.CurrentFFilter =3D =
tv_setting_info.DefaultFFilter;
+            if (chip_info.tv_chip_info.tv_chip_name =3D=3D VT1625)
+                tv_setting_info.FFilterLevel =3D 3;
+            else
+                tv_setting_info.FFilterLevel =3D 2;
+
+            tv_setting_info.DefaultBrightness =3D =
tv_register_read(0x0B);
+            tv_setting_info.CurrentBrightness =3D =
tv_setting_info.DefaultBrightness;
+            tv_setting_info.BrightnessLevel =3D 255;
+            if (tv_setting_info.out_signal =3D=3D TV_OUTPUT_RGB) {
+                tv_setting_info.DefaultContrast =3D =
tv_register_read(0x65);
+                tv_setting_info.CurrentContrast =3D =
tv_setting_info.DefaultContrast;
+                tv_setting_info.ContrastLevel =3D 250;
+                tv_setting_info.DefaultSaturation =3D =
(tv_register_read(0x66) << 8) + tv_register_read(0x67);
+                tv_setting_info.CurrentSaturation =3D =
tv_setting_info.DefaultSaturation;
+                tv_setting_info.SaturationLevel =3D 65535;
+                tv_setting_info.DefaultTINT =3D 0;
+                tv_setting_info.CurrentTINT =3D =
tv_setting_info.DefaultTINT;
+                tv_setting_info.TINTLevel =3D 0;
+            } else if (tv_setting_info.out_signal =3D=3D =
TV_OUTPUT_YPBPR) {
+                tv_setting_info.DefaultContrast =3D =
tv_register_read(0x65);
+                tv_setting_info.CurrentContrast =3D =
tv_setting_info.DefaultContrast;
+                tv_setting_info.ContrastLevel =3D 255;
+                tv_setting_info.DefaultSaturation =3D =
(tv_register_read(0x66) << 8) + tv_register_read(0x67);
+                tv_setting_info.CurrentSaturation =3D =
tv_setting_info.DefaultSaturation;
+                tv_setting_info.SaturationLevel =3D 65535;
+                tv_setting_info.DefaultTINT =3D 0;
+                tv_setting_info.CurrentTINT =3D =
tv_setting_info.DefaultTINT;
+                tv_setting_info.TINTLevel =3D 0;
+            } else {
+                tv_setting_info.DefaultContrast =3D =
tv_register_read(0x0C);
+                tv_setting_info.CurrentContrast =3D =
tv_setting_info.DefaultContrast;
+                tv_setting_info.ContrastLevel =3D 255;
+                tv_setting_info.DefaultSaturation =3D =
(tv_register_read(0x0D) << 8) + tv_register_read(0x0A);
+                tv_setting_info.CurrentSaturation =3D =
tv_setting_info.DefaultSaturation;
+                tv_setting_info.SaturationLevel =3D 65535;
+                tv_setting_info.DefaultTINT =3D tv_register_read(0x10) =
+ ((tv_register_read(0x11) & 0x07) << 8);
+                tv_setting_info.CurrentTINT =3D =
tv_setting_info.DefaultTINT;
+                tv_setting_info.TINTLevel =3D 2047;
+            }
+            break;
+
+        /* Add for VT3324 Integrated TV. */
+        case INTEGRATED_TV:
+            get_integrated_tv_default_status();
+            break;
+           =20
+        default:
+            break;
+     }
+
+    /* Set to user parameter*/
+    if(tv_ffilter !=3D 0)
+        tv_set_ffilter(STATE_ON, tv_ffilter);
+    if(tv_brightness !=3D 0)
+        tv_set_brightness(tv_brightness);
+    if(tv_contrast!=3D 0)
+        tv_set_contrast(tv_contrast);
+    if(tv_saturation !=3D 0)
+        tv_set_saturation(tv_saturation);
+    if(tv_tint !=3D 0)
+        tv_set_tint(tv_tint);
+}
+
+/* Set TV Brightness function only support VIA TV encoder */
+void tv_set_brightness(u32 value)
+{
+    DEBUG_MSG(KERN_INFO "tv_set_brightness!!\n");
+
+    switch(chip_info.tv_chip_info.tv_chip_name) {
+        case VT1622:
+        case VT1622A:
+        case VT1623:
+        case VT1625:
+            tv_register_write(0x0B, (u8) value);
+            tv_setting_info.CurrentBrightness =3D value;
+            break;
+
+        /* Add for VT3324 Integrated TV. */
+        case INTEGRATED_TV:
+            set_integrated_tv_brightness(value);
+            break;
+           =20
+        default:
+            break;
+     }
+}
+
+/* Set TV Contrast function only support VIA TV encoder */
+void tv_set_contrast(u32 value)
+{
+    u32 tmp;
+
+    DEBUG_MSG(KERN_INFO "tv_set_contrast!!\n");
+
+    switch(chip_info.tv_chip_info.tv_chip_name) {
+        case VT1622:
+        case VT1622A:
+        case VT1623:
+        case VT1625:
+            tmp =3D (value - tv_setting_info.CurrentContrast);
+            if (tv_setting_info.out_signal =3D=3D TV_OUTPUT_RGB) {
+                tv_register_write(0x65, (u8)(tv_register_read(0x65) + =
tmp));
+                tv_register_write(0x66, (u8)(tv_register_read(0x66) + =
tmp));
+                tv_register_write(0x67, (u8)(tv_register_read(0x67) + =
tmp));
+            } else if (tv_setting_info.out_signal =3D=3D =
TV_OUTPUT_YPBPR) {
+                tv_register_write(0x65, (u8)(tv_register_read(0x65) + =
tmp));
+            } else {
+                tv_register_write(0x0C, (u8)(tv_register_read(0x0C) + =
tmp));
+                tv_register_write(0x65, (u8)(value));  /* for VT1625 =
S-Video output */
+            }
+            tv_setting_info.CurrentContrast =3D value;
+            break;
+           =20
+        case INTEGRATED_TV:
+            set_integrated_tv_contrast(value);
+            break;
+     }
+}
+
+/* Set TV Saturation function only support VIA TV encoder */
+void tv_set_saturation(u32 value)
+{
+    DEBUG_MSG(KERN_INFO "tv_set_saturation!!\n");
+
+    switch(chip_info.tv_chip_info.tv_chip_name) {
+        case VT1622:
+        case VT1622A:
+        case VT1623:
+        case VT1625:
+            tv_register_write(0x66, (u8)((value >> 8) & 0xFF));
+            tv_register_write(0x67, (u8)(value & 0xFF));
+            tv_register_write(0x0D, (u8)((value >> 8) & 0xFF));
+            tv_register_write(0x0A, (u8)(value & 0xFF));
+            tv_setting_info.CurrentSaturation =3D value;
+            break;
+
+        case INTEGRATED_TV:
+            set_integrated_tv_saturation(value);
+            break;
+     }
+}
+
+/* Set TV TINT function only support VIA TV encoder */
+void tv_set_tint(u32 value)
+{
+    DEBUG_MSG(KERN_INFO "tv_set_tint!!\n");
+
+    if ((tv_setting_info.out_signal =3D=3D TV_OUTPUT_RGB) ||
+        (tv_setting_info.out_signal =3D=3D TV_OUTPUT_YPBPR))
+    {
+        return;
+    }
+
+    switch(chip_info.tv_chip_info.tv_chip_name)
+    {
+        case VT1622:
+        case VT1622A:
+        case VT1623:
+        case VT1625:           =20
+            tv_register_write(0x10, (u8)(value & 0xFF));
+            tv_register_write(0x11, (u8)((tv_register_read(0x11) & =
~0x07) | (u8)((value >> 8) & 0xFF)));
+            tv_setting_info.CurrentTINT =3D value;
+            break;
+
+        /* Add for VT3324 Integrated TV. */
+        case INTEGRATED_TV:
+            set_integrated_tv_hue(value);
+            break;
+           =20
+        default:
+            break;
+     }
+}
+
+/* Set TV Flicker Filter function only support VIA TV encoder */
+void tv_set_ffilter(u32 state, u32 value)
+{
+    DEBUG_MSG(KERN_INFO "tv_set_ffilter!!\n");
+   =20
+    switch(chip_info.tv_chip_info.tv_chip_name)
+    {
+        case VT1622:
+        case VT1622A:
+        case VT1623:
+        case VT1625:
+            if (state =3D=3D STATE_ON)
+            {
+                if ((value < 0) || (value > 3))
+                    break;
+               =20
+                if ((value =3D=3D 3) && =
(chip_info.tv_chip_info.tv_chip_name !=3D VT1625))
+                    break;
+           =20
+                /* Turn off adaptive ffilter. Adaptive ffilter is =
exclusive with ffilter */
+                tv_register_write(0x62, (u8)(tv_register_read(0x62) & =
~0x03));                                          =20
+
+                /* Tuning the value of flicker filter. */
+                if (value)
+                {
+                    tv_register_write(0x03, =
(u8)((tv_register_read(0x03) & ~0x03) | (u8)(value)));
+                    tv_setting_info.CurrentFFilter =3D value;
+                }
+                else /* value should be more than 0. */
+                {
+                    tv_register_write(0x03, =
(u8)((tv_register_read(0x03) & ~0x03) | (u8)(value+1)));
+                    tv_setting_info.CurrentFFilter =3D value+1;
+                }
+            }
+            else /* turn off */
+            {
+                tv_register_write(0x03, (u8)((tv_register_read(0x03) & =
~0x03)));
+                tv_setting_info.CurrentFFilter =3D STATE_OFF;
+            }
+          =20
+            break;
+
+        /* Add for VT3324 Integrated TV. */
+        case INTEGRATED_TV:
+            if (state =3D=3D STATE_ON)
+            {
+                =
set_integrated_tv_ffilter_status(ITV_FILTER_TYPE_NORMAL, ITV_FILTER_ON, =
value);
+            }
+            else
+            {
+                =
set_integrated_tv_ffilter_status(ITV_FILTER_TYPE_NORMAL, ITV_FILTER_OFF, =
value);
+            }
+            break;
+           =20
+        default:
+            break;
+     }
+}
+
+
+
+/*=20
+ *  Purpose:
+ *      Set status of TV Adaptive Flicker Filter and its degree.=20
+ *      Currently, it only support VIA TV encoder.
+ *  Parameter:
+ *      status: ON/OFF tv adaptive flicker filter function.
+ *      value: Degree of adaptive flicker filter.
+ */
+void tv_set_adaptive_ffilter(u32 status,u32 value)
+{
+    /* Adaptive FFilter ON */
+    if (status =3D=3D STATE_ON)
+    {
+        switch(chip_info.tv_chip_info.tv_chip_name)
+        {
+            case VT1622:
+            case VT1622A:
+            case VT1623:=20
+                /* Turn off normal flicker filter before turn on =
adaptive ffilter */
+                tv_set_ffilter(STATE_OFF, 0);
+
+                /* Turn on adaptive flicker filter before change the =
value of deflicker threshold. */
+                tv_register_write(0x62, (u8)((tv_register_read(0x62) & =
~0x03)| 0x01));
+               =20
+                /* Apply the value to deflicker threshold. */           =
 =20
+                tv_register_write(0x61, (u8)value);
+               =20
+                /* Change adaptive ffilter state */
+                tv_setting_info.AdaptiveFFilterOn =3D TRUE;
+               =20
+                break;
+           =20
+            case VT1625:
+                /* Turn off normal flicker filter before turn on =
adaptive ffilter */
+                tv_set_ffilter(STATE_OFF, 0);
+               =20
+                /* VT1625 only use 62[7:2] to control ffilter threshold =
*/
+                if ((value > 0) && (value < 64))
+                {
+                    /* Turn on adaptive flicker filter and assign value =
*/
+                    tv_register_write(0x62, (u8)(value<<2) | 0x01);
+                }
+
+                /* Change adaptive ffilter state */
+                tv_setting_info.AdaptiveFFilterOn =3D TRUE;
+               =20
+                break;
+
+            /* Add for VT3324 Integrated TV. */
+            case INTEGRATED_TV:
+                =
set_integrated_tv_ffilter_status(ITV_FILTER_TYPE_ADAPTIVE, =
ITV_FILTER_ON, value);
+                break;
+        }
+    }
+    else  /* Adaptive FFilter OFF */
+    {
+        switch(chip_info.tv_chip_info.tv_chip_name)
+        {
+            case VT1622:
+            case VT1622A:
+            case VT1623:
+            case VT1625:
+                /* Turn off adaptive flicker filter and assign value */
+                tv_register_write(0x62, (u8)(tv_register_read(0x62) & =
~0x03));
+                tv_setting_info.AdaptiveFFilterOn =3D FALSE;
+                break;
+
+            /* Add for VT3324 Integrated TV. */
+            case INTEGRATED_TV:
+                =
set_integrated_tv_ffilter_status(ITV_FILTER_TYPE_ADAPTIVE, =
ITV_FILTER_OFF, 0);
+                break;
+        }
+    }
+}
+
+
+
+/*
+*   Purpose:
+*       Get flicker filter value
+*   Parameter:
+*       ffilter_type: which type of flicker filter we want to get.
+*       ffilter_state: this can be used to receive the current ffilter =
state.
+*   Return:
+*       the value of flicker filter.
+*  =20
+*/
+int tv_get_ffilter(int ffilter_type, int* ffilter_state)
+{
+    int ffilter_value =3D 0;
+    int tmp_ffilter_state =3D 0;
+   =20
+    switch(chip_info.tv_chip_info.tv_chip_name)
+    {
+        case VT1622:
+        case VT1622A:
+        case VT1623:
+        case VT1625:
+            if (ffilter_type =3D=3D TV_FFILTER_TYPE_NORMAL)
+            {
+                ffilter_value =3D (tv_register_read(0x03) & 0x03);
+
+                /* flicker filter use 03[1:0]. */
+                if (ffilter_value > 0)
+                {
+                    *ffilter_state =3D STATE_ON;
+                }
+                else
+                {
+                    *ffilter_state =3D STATE_OFF;
+                }
+            }
+           =20
+            if (ffilter_type =3D=3D TV_FFILTER_TYPE_ADAPTIVE)
+            {
+                if (chip_info.tv_chip_info.tv_chip_name =3D=3D VT1625)
+                {
+                    /* VT1625 use 62[7:2] to save the value of =
deflicker threshold. */
+                    ffilter_value =3D (tv_register_read(0x62) & =
~0x03)>>2;
+                    tmp_ffilter_state=3D tv_register_read(0x62) & 0x03;
+                }
+                else
+                {
+                    ffilter_value =3D tv_register_read(0x61);
+                    tmp_ffilter_state=3D tv_register_read(0x62) & 0x03;
+                }
+
+                if (tmp_ffilter_state > 0)
+                {
+                    *ffilter_state =3D STATE_ON;
+                }
+                else
+                {
+                    *ffilter_state =3D STATE_OFF;
+                }
+            }
+            break;                      =20
+
+        /* Add for VT3324 Integrated TV. */
+        case INTEGRATED_TV:
+            if (ffilter_type =3D=3D TV_FFILTER_TYPE_NORMAL)
+            {
+                ffilter_value =3D =
get_integrated_tv_ffilter_status(ITV_FILTER_TYPE_NORMAL, ffilter_state);
+            }           =20
+            else if (ffilter_type =3D=3D TV_FFILTER_TYPE_ADAPTIVE)
+            {
+                ffilter_value =3D =
get_integrated_tv_ffilter_status(ITV_FILTER_TYPE_ADAPTIVE, =
ffilter_state);
+            }
+            break;
+    }
+   =20
+    return ffilter_value;
+}
+
+
+
+/*=20
+ *   Purpose:
+ *       Set position of TV's screen.
+ *   Parameter:
+ *       HPos: Horizontal position of screen.
+ *       VPos: Verticle position of screen.
+ */
+void tv_set_position(u32 HPos, u32 VPos)
+{
+    /* Registers of horizontal position : TV06[3:0] + TV08[7:0]
+       Registers of Vertical position: TV1C[3:1] + TV09[7:0] */
+    int new_hor_pos;
+    int new_ver_pos;
+    unsigned char high_bytes;
+    unsigned char low_bytes;
+   =20
+    if (chip_info.tv_chip_info.tv_chip_name =3D=3D INTEGRATED_TV)
+    {
+        /* Add for VT3324 Integrated TV. */
+        set_integrated_tv_pos(HPos, VPos);
+    }
+    else /* VIA's TV encoder */
+    {=20
+        /* First to get current postion */
+        tv_get_position(&new_hor_pos, &new_ver_pos);
+
+        switch(chip_info.tv_chip_info.tv_chip_name)
+        {
+            case VT1622:
+            case VT1622A:
+            case VT1623:
+                /* Origin position of vt1623 is at down-left corner
+                   New position is current position + shift */
+                new_hor_pos +=3D HPos - =
tv_setting_info.CurrentPositionH;
+                new_ver_pos +=3D VPos - =
tv_setting_info.CurrentPositionV;
+           =20
+                /* Write new value of horizontal position to register. =
*/
+                high_bytes =3D ((new_hor_pos >> 8) & 0x0F) | =
tv_register_read(0x06);
+                low_bytes =3D new_hor_pos & 0xFF;
+                tv_register_write(0x06, high_bytes);
+                tv_register_write(0x08, low_bytes);
+       =20
+                /* Write new value of vertical position to register. */
+                high_bytes =3D (((new_ver_pos >> 8) & 0x07) << 1) | =
tv_register_read(0x1C);
+                low_bytes =3D new_ver_pos & 0xFF;
+                tv_register_write(0x1C, high_bytes);
+                tv_register_write(0x09, low_bytes);
+                break;
+
+            case VT1625:
+                /* Origin position of vt1625 is at down-right corner
+                   New position is current position + shift */
+                new_hor_pos -=3D HPos - =
tv_setting_info.CurrentPositionH;
+                new_ver_pos +=3D VPos - =
tv_setting_info.CurrentPositionV;
+
+                /* Write new value of horizontal position to register. =
*/
+                high_bytes =3D ((new_hor_pos >> 8) & 0x0F) | =
tv_register_read(0x06);
+                low_bytes =3D new_hor_pos & 0xFF;
+                tv_register_write(0x06, high_bytes);
+                tv_register_write(0x08, low_bytes);
+       =20
+                /* Write new value of vertical position to register. */
+                high_bytes =3D (((new_ver_pos >> 8) & 0x07) << 1) | =
tv_register_read(0x1C);
+                low_bytes =3D new_ver_pos & 0xFF;
+                tv_register_write(0x1C, high_bytes);
+                tv_register_write(0x09, low_bytes);
+                break;
+
+       =20
+        }
+   =20
+        /* Save the value of current position */
+        tv_setting_info.CurrentPositionH =3D HPos;
+        tv_setting_info.CurrentPositionV =3D VPos;
+    }
+}
+
+
+
+/*=20
+*   Purpose:
+*       Get position of TV's screen.
+*   Parameter:
+*       HPos: Horizontal position of screen.
+*       VPos: Verticle position of screen.
+*/
+void tv_get_position(u32* HPos, u32* VPos)
+{
+    if (chip_info.tv_chip_info.tv_chip_name =3D=3D INTEGRATED_TV)
+    {
+        get_integrated_tv_pos(HPos, VPos);
+    }
+    else
+    {
+        *HPos =3D (((tv_register_read(0x06)&0x0F)<<8) | =
tv_register_read(0x08)) & 0x0FFF;
+        *VPos =3D (((tv_register_read(0x1C)&0x0E)<<7) | =
tv_register_read(0x09)) & 0x0FFF;
+    }
+
+}
+
+/* Set TV Flicker Filter function only support VIA TV encoder */
+void tv_set_size(u32 HPos, u32 VPos)
+{
+=20
+    DEBUG_MSG(KERN_INFO "tv_set_size\n");   =20
+    DEBUG_MSG(KERN_INFO "tv_set_size: pSetViewSizeValue->dwX=3D%d\n", =
HPos);=20
+    DEBUG_MSG(KERN_INFO "tv_set_size: pSetViewSizeValue->dwY=3D%d\n", =
VPos);    =20
+
+    /* Add for VT3324 Integrated TV. */
+    if (chip_info.tv_chip_info.tv_chip_name =3D=3D INTEGRATED_TV)
+    {
+        set_integrated_tv_size(HPos, VPos);
+        return;
+    }
+
+    tv_setting_info.CurrentScalH=3DHPos-1;
+    tv_setting_info.CurrentScalV=3DVPos-1;=20
+
+    switch (chip_info.tv_chip_info.tv_chip_name)
+    {
+        case VT1621:
+        case VT1622:
+        case VT1622A:
+        case VT1623:    =20
+            tv_setting_info.level =3D VPos - 1;
+            break;
+=20
+        case VT1625:    =20
+            if (VPos =3D=3D 2)
+                tv_setting_info.level =3D 2;
+            else
+                tv_setting_info.level =3D VPos - 1;
+            break;
+           =20
+
+        default:
+            tv_setting_info.CurrentPositionH =3D 0;
+            tv_setting_info.CurrentPositionV =3D 0;
+            break;
+    }
+
+    DEBUG_MSG(KERN_INFO "tv_set_size:After set size, =
tv_setting_info.level=3D%d\n", tv_setting_info.level);    =20
+}
+
+/* Add this function to control TV clock source by case. */
+void set_tv_clock_source(void)
+{
+    if (chip_info.tv_chip_info.tv_chip_name =3D=3D INTEGRATED_TV)
+    {
+        /* From TVPLL. */
+        if (tv_setting_info.iga_path =3D=3D IGA1)
+        {
+            write_reg(CR6C, VIACR, 0x50);
+        }
+        else
+        {
+            write_reg(CR6C, VIACR, 0x05);
+        }
+    }
+    else
+    {
+        /* External TV: */
+        if ((chip_info.gfx_chip_name =3D=3D UNICHROME_CLE266) &&=20
+            (chip_info.gfx_chip_revision =3D=3D CLE266_REVISION_AX))
+        {
+            write_reg_mask(CR6C, VIACR, 0x01, BIT0);
+        }
+        else if (chip_info.gfx_chip_name =3D=3D UNICHROME_CX700)
+        {
+            /* From DVP0 TV clock. */
+            if (tv_setting_info.iga_path =3D=3D IGA1)
+            {
+                write_reg(CR6C, VIACR, 0xb0);
+            }
+            else
+            {
+                write_reg(CR6C, VIACR, 0x0b);
+            }
+        }
+        else
+        {
+            write_reg_mask(CR6C, VIACR, BIT5+BIT0, BIT5+BIT0);
+        }
+    }
+}
+/*check_macrovision_enabled: to check if MV is enabled=20
+*                          according to TV encoder's registers 0x0F and =
0x30
+*                          Currently only support VT1622 and VT1623 =
VT1625
+*                          AlZhang[2006.04.24]
+*/
+int check_macrovision_enabled(void)
+{
+    u8 tv_r0f =3D 0,tv_r30 =3D 0;
+    switch(chip_info.tv_chip_info.tv_chip_name)
+    {
+
+    case VT1622:
+    case VT1622A:
+    case VT1623:
+    case VT1625:
+        tv_r0f =3D (u8)tv_register_read(0x0f);
+        tv_r30 =3D (u8)tv_register_read(0x30);
+       =20
+        break;
+    default:
+        break;
+
+    }
+    if((tv_r0f&0x80) && (tv_r30&0x30))
+        return TRUE;
+    else
+        return FALSE;
+}
+
diff -Nur linux-2.6.21-rc7/drivers/video/via/tv.h =
linux-2.6.21-rc7.viafb/drivers/video/via/tv.h
--- linux-2.6.21-rc7/drivers/video/via/tv.h 1969-12-31 =
19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/tv.h 2007-04-26 =
19:52:32.000000000 -0400
@@ -0,0 +1,163 @@
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
+#ifndef __TV_H__
+#define __TV_H__
+
+#include <linux/ioport.h>
+#include <asm/io.h>
+
+/* Definition TV System */
+#define     TVTYPE_NONE     0x00
+#define     TVTYPE_NTSC     0x01
+#define     TVTYPE_PAL      0x02
+#define     TVTYPE_480P     0x04
+#define     TVTYPE_576P     0x08
+#define     TVTYPE_720P     0x10
+#define     TVTYPE_1080I    0x20
+
+/* Definition TV Level */
+#define     TV_SIZE_NORMAL_SCAN                    0
+#define     TV_SIZE_FIT_SCAN                       1
+#define     TV_SIZE_OVER_SCAN                      2
+
+/* Definition TV Ouput Signal */
+#define     TV_OUTPUT_NONE                      0x00
+#define     TV_OUTPUT_COMPOSITE                 0x01
+#define     TV_OUTPUT_SVIDEO                    0x02
+#define     TV_OUTPUT_RGB                       0x04
+#define     TV_OUTPUT_YPBPR                     0x08
+#define     TV_OUTPUT_COMPOSITE_SVIDEO          0x10
+#define     TV_OUTPUT_RGB_COMPOSITE             0x20
+#define     TV_OUTPUT_YPBPR_COMPOSITE           0x40
+#define     TV_OUTPUT_RGB_COMPOSITE_SVIDEO      0x80
+#define     TV_OUTPUT_YPBPR_COMPOSITE_SVIDEO   0x100
+
+
+
+/* Define TV Function Index */
+#define TV_BASE_FUNC                0
+#define TV_RGB_FUNC                 1
+#define TV_YPBPR_FUNC               2
+#define TV_SDTV_RGB_FUNC            3
+#define TV_SDTV_YPBPR_FUNC          4
+#define TV_DeDotCrawl_FUNC          5
+
+
+
+#define NUM_CRTC_TIMING         12
+
+/* TV Table Relative Definition */
+#define     VT1622A_REG_NUM             75
+#define     FS454_REG_NUM               82
+#define     SAA7108A_REG_NUM            67
+#define     CH7019_REG_NUM              24
+#define     GFX_IGA1_CRT_NUM            14              /* number of =
setting CRTC's registers on IGA1 in TV table */
+#define     GFX_IGA2_CRT_NUM            16              /* number of =
setting CRTC's registers on IGA2 in TV table */
+
+/* define TV DeDotCrawl Register */
+#define     VT1622_DEDOTCRAWL_REG       0x11
+#define     VT1622A_DEDOTCRAWL_REG      0x11
+#define     VT1625_DEDOTCRAWL_REG       0x11
+
+/* define TV Version register */
+#define     VT1622_VERSION_REG          0x1B
+#define     VT1622_VERSION              0x03
+
+#define     VT1622A_VERSION_REG         0x1B
+#define     VT1622A_VERSION             0x10
+
+#define     VT1625_VERSION_REG          0x1B
+#define     VT1625_VERSION              0x50
+
+
+/* Define TV DAC */
+#define     VT1622_DAC_REG              0x0E
+#define     VT1622_DAC_A                BIT3
+#define     VT1622_DAC_B                BIT2
+#define     VT1622_DAC_C                BIT1
+#define     VT1622_DAC_D                BIT0
+
+#define     VT1622A_DAC_REG             0x0E
+#define     VT1622A_DAC_A               BIT3
+#define     VT1622A_DAC_B               BIT2
+#define     VT1622A_DAC_C               BIT1
+#define     VT1622A_DAC_D               BIT0
+
+#define     VT1625_DAC_REG              0x0E
+#define     VT1625_DAC_A                BIT5
+#define     VT1625_DAC_B                BIT4
+#define     VT1625_DAC_C                BIT3
+#define     VT1625_DAC_D                BIT2
+#define     VT1625_DAC_E                BIT1
+#define     VT1625_DAC_F                BIT0
+
+
+
+
+/* TV MACRO */
+#define     GET_HIGH_BYTE(x)       (unsigned char)((x) >> 8)
+#define     GET_LOW_BYTE(x)        (unsigned char)((x) & 0x00FF)
+
+/* We divide shift range into 11 partitions, so 6 is the center =
position. */
+#define TV_POS_DEFAULT_HOR_VALUE    6
+#define TV_POS_DEFAULT_VER_VALUE    6
+
+/* Definition TV Flicker Filter Type */
+#define TV_FFILTER_TYPE_NORMAL      0
+#define TV_FFILTER_TYPE_ADAPTIVE    1
+
+
+/* TV Common Function */
+int  tv_encoder_identify(void);
+void tv_disable(void);
+void tv_load_timing_init(void);
+void tv_load_timing(int TVModeIndex);
+void tv_load_timing_modify(void);
+void tv_patch(int tv_mode_index);
+void tv_enable(void);
+void tv_register_write(int, u8);
+int tv_register_read(int);
+void tv_patch_skew_K800(void);
+void tv_patch_skew_cn900(int tv_mode_index);
+void tv_patch_skew_cx700(int tv_mode_index);
+void tv_patch_skew_p880(int tv_mode_index);
+void tv_set_color(void);
+void tv_set_brightness(u32 value);
+void tv_set_contrast(u32 value);
+void tv_set_saturation(u32 value);
+void tv_set_tint(u32 value);
+void tv_set_ffilter(u32 state, u32 value);
+void tv_set_adaptive_ffilter(u32 status, u32 value);
+int tv_get_ffilter(int ffilter_type, int* ffilter_state);=20
+void tv_set_position(u32 HPos, u32 VPos);
+void tv_get_position(u32* HPos, u32* VPos);
+void tv_set_size(u32 HPos, u32 VPos);
+void set_tv_clock_source(void);
+void tv_patch_skew_p4m900(int tv_mode_index);
+void tv_patch_skew_k8m890(int tv_mode_index);
+void tv_patch_skew_p4m890(int tv_mode_index);
+
+#endif /* __TV_H__ */
+
diff -Nur linux-2.6.21-rc7/drivers/video/via/via_i2c.c =
linux-2.6.21-rc7.viafb/drivers/video/via/via_i2c.c
--- linux-2.6.21-rc7/drivers/video/via/via_i2c.c 1969-12-31 =
19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/via_i2c.c 2007-04-26 =
19:52:32.000000000 -0400
@@ -0,0 +1,478 @@
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
+#include <asm/io.h>
+
+#include "chip.h"
+#include "debug.h"
+#include "via_i2c.h"
+#include "share.h"
+
+extern inline void write_reg(u8 index, u16 io_port, u8 data);
+extern inline u8 read_reg(int io_port, u8 index);
+
+extern struct chip_information          chip_info;
+extern struct tv_setting_information    tv_setting_info;
+
+/* i2c delay for microsecond */
+void delays(int count)
+{
+    volatile u8 data;
+    while (count--)
+    {
+        /* delay 1 us */
+        data =3D inb(DELAYPORT);
+        data =3D inb(DELAYPORT);
+        data =3D inb(DELAYPORT);
+        data =3D inb(DELAYPORT);
+        data =3D inb(DELAYPORT);
+    }
+
+}
+
+
+/*  Write I2C BUS SDA And SCL */
+void i2cWriteSdaScl(u8 sda, u8 scl)
+{
+    u8      data;
+    u16     port_addr;
+
+
+    if (chip_info.tv_chip_info.tv_chip_on_slot =3D=3D TV_ON_AMR)
+    {
+
+        data =3D ((scl << 1) | sda) << 4;
+        data =3D data | BIT0;                             /* enable I2C =
port */
+
+        port_addr =3D TVI2CPORT;
+        write_reg(TVI2CPORTINDEX, port_addr, data); /* Write Register =
Value */
+    }
+    else
+    {
+        if (chip_info.tv_chip_info.tv_chip_on_slot =3D=3D TV_ON_AGP)
+        {
+            data =3D ((scl << 1) | sda) << 4;
+            data =3D data | (BIT6+BIT7);                      /* enable =
GPIO write port */
+            port_addr =3D TVGPIOPORT;
+            write_reg (TVGPIOPORTINDEX, port_addr, data);   /* Write =
Register Value */
+
+        }
+    }
+}
+
+void i2cWriteScl(u8 scl)
+{
+    u8      data;
+    u16     port_addr;
+
+
+    if (chip_info.tv_chip_info.tv_chip_on_slot =3D=3D TV_ON_AMR)
+    {
+
+        data =3D (scl << 1)<< 4;
+        data =3D data | BIT0;                             /* enable I2C =
port */
+
+        port_addr =3D TVI2CPORT;
+        write_reg(TVI2CPORTINDEX, port_addr, data); /* Write Register =
Value */
+    }
+    else
+    {
+        if (chip_info.tv_chip_info.tv_chip_on_slot =3D=3D TV_ON_AGP)
+        {
+            data =3D (scl << 1) << 4;
+
+            data =3D data & 0xBF;                     /* enable GPIO =
write clock */
+            port_addr =3D TVGPIOPORT;
+            write_reg (TVGPIOPORTINDEX, port_addr, data);   /* Write =
Register Value */
+        }
+    }
+}
+
+void i2cReadSdaScl(u8 *pSda, u8 *pScl)
+{
+    u8      data;
+    u16     port_addr;
+
+    if (chip_info.tv_chip_info.tv_chip_on_slot =3D=3D TV_ON_AMR)
+    {
+        port_addr =3D TVI2CPORT;
+        data =3D read_reg(port_addr, TVI2CPORTINDEX);
+        *pSda =3D (data >> 2) & BIT0;     /* get sda */
+        *pScl =3D (data >> 3) & BIT0;     /* get scl */
+    }
+    else
+    {
+        if (chip_info.tv_chip_info.tv_chip_on_slot =3D=3D TV_ON_AGP)
+        {
+            port_addr =3D TVGPIOPORT;
+            data =3D  read_reg(port_addr, TVGPIOPORTINDEX);
+            *pSda =3D (data >> 2) & BIT0;     /* get sda */
+            *pScl =3D (data >> 3) & BIT0;     /* get scl */
+        }
+    }
+}
+
+
+void i2cWriteSdaSclDelay(u8 sda, u8 scl)
+{
+    i2cWriteSdaScl(sda, scl);
+    delays(16);                 /* Wait 16 uS */
+}
+
+void i2cStartSignal(void)
+{
+    i2cWriteSdaSclDelay(1,1);
+    i2cWriteSdaSclDelay(0,1);
+    i2cWriteSdaSclDelay(0,0);
+}
+
+void i2cStopSignal(void)
+{
+    u8      data;
+    u16     port_addr;
+
+    i2cWriteSdaSclDelay(0,0);
+    i2cWriteSdaSclDelay(0,1);
+    i2cWriteSdaSclDelay(1,1);
+
+    if (chip_info.tv_chip_info.tv_chip_on_slot =3D=3D TV_ON_AGP)
+    {
+        data =3D 0x3c;                                    /* disable =
GPIO write port */
+        port_addr =3D TVGPIOPORT;
+        write_reg (TVGPIOPORTINDEX, port_addr, data);   /* Write =
Register Value */
+    }
+    delays(2);
+
+}
+
+void disableSdaGPIO(void)
+{
+    u8      data;
+    u16     port_addr;
+
+    if (chip_info.tv_chip_info.tv_chip_on_slot =3D=3D TV_ON_AGP)
+    {
+            port_addr =3D TVGPIOPORT;
+            data =3D read_reg(port_addr, TVGPIOPORTINDEX);
+            data =3D data & (~BIT6);                      /* disable =
GPIO write port */
+            write_reg (TVGPIOPORTINDEX, port_addr, data);   /* Write =
Register Value */
+    }
+}
+
+void enableSdaGPIO(void)
+{
+    u8  data;
+    u16 port_addr;
+
+    if (chip_info.tv_chip_info.tv_chip_on_slot =3D=3D TV_ON_AGP)
+    {
+            port_addr =3D TVGPIOPORT;
+            data =3D read_reg(port_addr, TVGPIOPORTINDEX);
+            data =3D data | (BIT6);                           /* =
disable GPIO write port */
+            write_reg (TVGPIOPORTINDEX, port_addr, data);   /* Write =
Register Value */
+    }
+}
+
+void writeSclGPIO(u8 scl)
+{
+    u8      data;
+    u16     port_addr;
+
+    if (chip_info.tv_chip_info.tv_chip_on_slot =3D=3D TV_ON_AGP)
+    {
+        port_addr =3D TVGPIOPORT;
+        data =3D read_reg(port_addr, TVGPIOPORTINDEX);
+        data =3D data & (~BIT5);
+        data =3D (data | (scl<<5)) & (~BIT6);             /* write data =
to clock */
+
+        write_reg (TVGPIOPORTINDEX, port_addr, data);       /* Write =
Register Value */
+    }
+}
+
+void writeSdaGPIO(u8 sda)
+{
+    u8      data;
+    u16     port_addr;
+
+    if (chip_info.tv_chip_info.tv_chip_on_slot =3D=3D TV_ON_AGP)
+    {
+        port_addr =3D TVGPIOPORT;
+        data =3D read_reg(port_addr, TVGPIOPORTINDEX);
+
+        data =3D data & (~BIT4);
+        data =3D (data | (sda<<4)) & (~BIT7);             /* write data =
to clock */
+        write_reg (TVGPIOPORTINDEX, port_addr, data);       /* Write =
Register Value */
+    }
+}
+
+void enableGPIO(void)
+{
+    u8  data;
+    u16 port_addr;
+
+    if (chip_info.tv_chip_info.tv_chip_on_slot =3D=3D TV_ON_AGP)
+    {
+        port_addr =3D TVGPIOPORT;
+        data =3D read_reg(port_addr, TVGPIOPORTINDEX);
+        data =3D data | (BIT4+BIT5+BIT6+BIT7);                /* enable =
GPIO write port */
+        write_reg (TVGPIOPORTINDEX, port_addr, data);       /* Write =
Register Value */
+    }
+}
+
+void releaseGPIO(void)
+{
+    u8      data;
+    u16     port_addr;
+
+    if (chip_info.tv_chip_info.tv_chip_on_slot =3D=3D TV_ON_AGP)
+    {
+        port_addr =3D TVGPIOPORT;
+        port_addr =3D port_addr + 1;
+
+        data =3D read_reg(port_addr, TVGPIOPORTINDEX);
+        data =3D data & 0x3c;                         /* disable GPIO =
write port */=20
+        port_addr =3D TVGPIOPORT;
+        write_reg (TVGPIOPORTINDEX, port_addr, data);   /* Write =
Register Value */
+    }
+}
+
+int i2CWaitForSlave(void)
+{
+    int time_out =3D 20000;
+    u8 sda, scl;
+
+    while (time_out--)
+    {
+        i2cReadSdaScl(&sda, &scl);
+        if (scl)
+        return (OK);            /* Successful stall */
+        delays(1);              /* wait 1 uS */
+    }
+    return (FAIL);              /* Slave fail */
+}
+
+int i2cOutByte(u8 data)
+{
+    u8 sda, scl;
+    u8 out_byte;
+    int bit_count =3D 8;
+    int status;
+
+    out_byte =3D data;
+    while (bit_count--)
+    {
+        sda =3D (out_byte >> 7) & 1;      /* Load MSB */
+        out_byte =3D out_byte << 1;       /* next bit. */
+        i2cWriteSdaSclDelay(sda, 0);
+        i2cWriteSdaSclDelay(sda, 1);
+
+        status =3D i2CWaitForSlave();
+        if (status =3D=3D FAIL)
+        {
+            return (status);
+        }
+
+        i2cWriteSdaSclDelay(sda, 0);
+
+    }
+
+    if ((chip_info.tv_chip_info.tv_chip_on_slot =3D=3D TV_ON_AGP))
+    {
+
+        writeSclGPIO(0);
+        disableSdaGPIO();
+        delays(2);
+        writeSclGPIO(1);
+        delays(2);
+        i2cReadSdaScl(&sda, &scl);
+        writeSclGPIO(0);
+        delays(2);
+        if (sda =3D=3D 0)
+        {
+            status =3D OK;
+        }
+        else
+        {
+            status =3D FAIL;
+        }
+
+    }
+    else
+    {
+        i2cWriteSdaSclDelay(1,0);
+        i2cWriteSdaSclDelay(1,1);
+        status =3D i2CWaitForSlave();
+        if (status =3D=3D FAIL)
+        {
+            return (status);
+        }
+
+        i2cReadSdaScl(&sda, &scl);
+        if (sda =3D=3D 0)
+        {
+            i2cWriteSdaSclDelay(1,0);
+            status =3D OK;
+        }
+        else
+        {
+
+            i2cWriteSdaSclDelay(1,0);
+            status =3D FAIL;
+        }
+    }
+    return (status);
+}
+
+int i2cInputByte(u8 *pInByte, int ack)
+{
+
+    int     bit_count =3D 8;
+    u8      sda, scl;
+    u8      data =3D 0;
+    int     status;
+
+
+    disableSdaGPIO();
+
+    while (bit_count--)
+    {
+        if ((chip_info.tv_chip_info.tv_chip_on_slot =3D=3D TV_ON_AGP))
+        {
+
+            writeSclGPIO(1);
+            delays(2);
+            status =3D i2CWaitForSlave();
+            if (status =3D=3D FAIL)
+                return (FAIL);
+            i2cReadSdaScl(&sda, &scl);
+            data =3D data << 1;
+            data |=3D sda;
+            writeSclGPIO(0);
+            delays(2);
+
+        }
+        else
+        {
+            i2cWriteSdaSclDelay(1,1);
+            status =3D i2CWaitForSlave();
+            if (status =3D=3D FAIL)
+                return(FAIL);
+            i2cReadSdaScl(&sda, &scl);
+            data =3D data << 1;
+            data |=3D sda;
+            i2cWriteSdaSclDelay(1, 0);
+        }
+    }
+    *pInByte =3D data;
+
+    if (ack)
+    {
+        i2cWriteSdaSclDelay(0, 0);
+        i2cWriteSdaSclDelay(0, 1);
+        status =3D i2CWaitForSlave();
+    if (status =3D=3D FAIL)
+        return(status);
+        i2cWriteSdaSclDelay(0, 0);
+    }
+    else
+    {
+        i2cWriteSdaSclDelay(1, 0);
+        i2cWriteSdaSclDelay(1, 1);
+        status =3D i2CWaitForSlave();
+        if (status =3D=3D FAIL)
+            return(status);
+    }
+    i2cWriteSdaSclDelay(1, 0);
+
+    return(OK);
+}
+
+int i2cReadByte(u8 slave_addr, u8 index, u8 *pData)
+{
+
+    int     status;
+
+    i2cStartSignal();
+
+    status =3D i2cOutByte(slave_addr);
+    if (status =3D=3D FAIL)
+    {
+        i2cStopSignal();
+        return(FAIL);
+    }
+    status =3D i2cOutByte(index);
+
+    if (status =3D=3D FAIL)
+    {
+        i2cStopSignal();
+        return (FAIL);
+    }
+
+    i2cStartSignal();
+    status =3D i2cOutByte(slave_addr | BIT0);
+    if (status =3D=3D FAIL)
+    {
+        i2cStopSignal();
+        return (FAIL);
+    }
+    status =3D i2cInputByte(pData, 0);
+    if (status =3D=3D FAIL)
+    {
+        i2cStopSignal();
+        return (FAIL);
+    }
+
+    i2cStopSignal();
+    return(OK);
+}
+
+int i2cWriteByte(u8 slave_addr, u8 index, u8 data)
+{
+
+    int     status;
+
+    i2cStartSignal();
+    status =3D i2cOutByte(slave_addr);
+    if (status =3D=3D FAIL)
+    {
+        i2cStopSignal();
+        return(FAIL);
+    }
+    status =3D i2cOutByte(index);
+    if (status =3D=3D FAIL)
+    {
+        i2cStopSignal();
+        return(FAIL);
+    }
+    status =3D i2cOutByte(data);
+    if (status =3D=3D FAIL)
+    {
+        i2cStopSignal();
+        return(FAIL);
+    }
+    i2cStopSignal();
+    return(OK);
+}
diff -Nur linux-2.6.21-rc7/drivers/video/via/via_i2c.h =
linux-2.6.21-rc7.viafb/drivers/video/via/via_i2c.h
--- linux-2.6.21-rc7/drivers/video/via/via_i2c.h 1969-12-31 =
19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/via_i2c.h 2007-04-26 =
19:52:32.000000000 -0400
@@ -0,0 +1,38 @@
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
+#ifndef __VIA_I2C_H__
+#define __VIA_I2C_H__
+
+#define TVI2CPORT           0x3c4
+#define TVI2CPORTINDEX      0x31
+#define TVGPIOPORT          0x3C4
+#define TVGPIOPORTINDEX     0x2C
+#define I2C_BUS             1
+#define GPIO_BUS            2
+#define DELAYPORT           0x3C3
+
+#endif /* __VIA_I2C_H__ */
+
diff -Nur linux-2.6.21-rc7/drivers/video/via/viamode.h =
linux-2.6.21-rc7.viafb/drivers/video/via/viamode.h
--- linux-2.6.21-rc7/drivers/video/via/viamode.h 1969-12-31 =
19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/viamode.h 2007-04-26 =
19:52:32.000000000 -0400
@@ -0,0 +1,351 @@
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
+#ifndef __VIAMODE_H__
+#define __VIAMODE_H__
+
+#include "share.h"
+
+
+struct VPITTable {
+  unsigned char  Misc;
+  unsigned char  SR[StdSR];
+  unsigned char  GR[StdGR];
+  unsigned char  AR[StdAR];
+};
+
+struct VideoModeTable {
+  int                               ModeIndex;
+  struct crt_mode_table             *crtc;
+  int                               mode_array;
+};
+
+struct patch_table {
+  int           mode_index;
+  int           table_length;
+  struct io_reg *io_reg_table;
+};
+
+struct res_map_refresh {
+  int       hres;
+  int       vres;
+  int       pixclock;
+  int       vmode_refresh;
+};
+
+
+/********************/
+/* Mode Table       */
+/********************/
+
+/* 640x480 */
+static struct crt_mode_table CRTM640x480[] =3D {
+  /* r_rate,vclk,hsp,vsp */
+  /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+  {REFRESH_60, CLK_25_175M ,M640X480_R60_HSP, M640X480_R60_VSP,\
+  {800, 640, 648, 144, 656, 96,  525, 480, 480, 45,  490, 2}},
+  {REFRESH_75, CLK_31_500M ,M640X480_R75_HSP, M640X480_R75_VSP,\
+  {840, 640, 640, 200, 656, 64,  500, 480, 480, 20,  481, 3}},
+  {REFRESH_85, CLK_36_000M ,M640X480_R85_HSP, M640X480_R85_VSP,\
+  {832, 640, 640, 192, 696, 56,  509, 480, 480, 29,  481, 3}},
+  {REFRESH_100,CLK_43_163M ,M640X480_R100_HSP, M640X480_R100_VSP,\
+  {848, 640, 640, 208, 680, 64,  509, 480, 480, 29,  481, 3}}, /* GTF =
*/
+  {REFRESH_120,CLK_52_406M ,M640X480_R120_HSP, M640X480_R120_VSP,\
+  {848, 640, 640, 208, 680, 64,  515, 480, 480, 35,  481, 3}}  /* GTF =
*/
+};
+
+/* 720x480 (GTF) */
+static struct crt_mode_table CRTM720x480[] =3D {
+  /* r_rate,vclk,hsp,vsp */    =20
+  /* HT, HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+  {REFRESH_60,CLK_26_880M ,M720X480_R60_HSP, M720X480_R60_VSP,\
+  {896, 720, 720, 176, 736, 72,  497, 480, 480, 17,  481, 3}}
+
+};
+
+/* 720x576 (GTF) */
+static struct crt_mode_table CRTM720x576[] =3D {
+  /* r_rate,vclk,hsp,vsp */
+  /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+  {REFRESH_60,CLK_32_668M ,M720X576_R60_HSP, M720X576_R60_VSP,\
+  {912, 720, 720, 192, 744, 72,  597, 576, 576, 21,  577, 3}}
+};
+
+/* 800x480 (GTF) */
+static struct crt_mode_table CRTM800x480[] =3D {
+  /* r_rate,vclk,hsp,vsp */
+  /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+  {REFRESH_60,CLK_29_581M ,M800X480_R60_HSP,M800X480_R60_VSP,\
+  {992, 800, 800, 192, 816, 80,  497, 480, 480, 17,  481, 3}}
+};
+/* 800x600 */
+static struct crt_mode_table CRTM800x600[] =3D {
+  /* r_rate,vclk,hsp,vsp */    =20
+  /* HT,   HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+  {REFRESH_60, CLK_40_000M ,M800X600_R60_HSP, M800X600_R60_VSP,\
+  {1056, 800, 800, 256, 840, 128, 628, 600, 600, 28,  601, 4}},
+  {REFRESH_75, CLK_49_500M ,M800X600_R75_HSP, M800X600_R75_VSP,\
+  {1056, 800, 800, 256, 816, 80,  625, 600, 600, 25,  601, 3}},
+  {REFRESH_85, CLK_56_250M ,M800X600_R85_HSP, M800X600_R85_VSP,\
+  {1048, 800, 800, 248, 832, 64,  631, 600, 600, 31,  601, 3}},
+  {REFRESH_100,CLK_68_179M ,M800X600_R100_HSP, M800X600_R100_VSP,\
+  {1072, 800, 800, 272, 848, 88,  636, 600, 600, 36,  601, 3}},
+  {REFRESH_120,CLK_83_950M ,M800X600_R120_HSP, M800X600_R120_VSP,\
+  {1088, 800, 800, 288, 856, 88,  643, 600, 600, 43,  601, 3}}
+};
+/* 848x480 (GTF) */
+static struct crt_mode_table CRTM848x480[] =3D {
+  /* r_rate,vclk,hsp,vsp */    =20
+  /* HT,   HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+  {REFRESH_60,CLK_31_490M ,M848X480_R60_HSP, M848X480_R60_VSP,\
+  {1056, 848, 848, 208, 864, 88,  497, 480, 480, 17,  481, 3}}
+};
+
+/* 856x480 (GTF) convert to 852x480 */
+static struct crt_mode_table CRTM852x480[] =3D {
+  /* r_rate,vclk,hsp,vsp */   =20
+  /* HT,   HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+  {REFRESH_60,CLK_31_728M ,M852X480_R60_HSP, M852X480_R60_VSP,\
+  {1064, 856, 856, 208, 872, 88,  497, 480, 480, 17,  481, 3}}
+
+};
+
+/* 1024x512 (GTF) */
+static struct crt_mode_table CRTM1024x512[] =3D {
+  /* r_rate,vclk,hsp,vsp */   =20
+  /* HT,   HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+  {REFRESH_60,CLK_41_291M ,M1024X512_R60_HSP, M1024X512_R60_VSP,\
+  {1296, 1024,1024,272, 1056,104, 531, 512, 512, 19,  513, 3}}
+
+};
+
+/* 1024x576 (GTF) */
+/*static struct crt_mode_table CRTM1024x576[] =3D {
+  //r_rate,vclk,     HT,   HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, =
VSS, VSE
+  { 60,CLK_46_996M ,{1312, 1024,1024,288, 1064,104, 597, 576, 576, 21,  =
577, 3}}
+
+};*/
+
+/* 1024x768 */
+static struct crt_mode_table CRTM1024x768[] =3D {
+  /* r_rate,vclk,hsp,vsp */
+  /* HT,  HA,   HBS,  HBE, HSS,  HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+  {REFRESH_60,CLK_65_000M ,M1024X768_R60_HSP, M1024X768_R60_VSP,\
+  {1344, 1024, 1024, 320, 1048, 136, 806, 768, 768, 38,  771, 6}},
+  {REFRESH_75,CLK_78_750M ,M1024X768_R75_HSP, M1024X768_R75_VSP,\
+  {1312, 1024, 1024, 288, 1040, 96,  800, 768, 768, 32,  769, 3}},
+  {REFRESH_85,CLK_94_500M ,M1024X768_R85_HSP, M1024X768_R85_VSP,\
+  {1376, 1024, 1024, 352, 1072, 96,  808, 768, 768, 40,  769, 3}},
+  {REFRESH_100,CLK_133_308M,M1024X768_R100_HSP, M1024X768_R100_VSP,\
+  {1392, 1024, 1024, 368, 1096, 112, 814, 768, 768, 46,  769, 3}} //GTF
+};
+
+/* 1152x864 */
+static struct crt_mode_table CRTM1152x864[] =3D {
+  /* r_rate,vclk,hsp,vsp */     =20
+  /* HT,  HA,   HBS,  HBE, HSS,  HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+  {REFRESH_75,CLK_108_000M ,M1152X864_R75_HSP, M1152X864_R75_VSP,\
+  {1600, 1152,1152, 448, 1216, 128, 900, 864, 864, 36,  865, 3}}
+
+};
+
+/* 1280x720 (GTF) */
+static struct crt_mode_table CRTM1280x720[] =3D {
+  /* r_rate,vclk,hsp,vsp */
+  /* HT,  HA,   HBS,  HBE, HSS,  HSE, VT,  VA,  VBS, VBE, VSS, VSE */   =
  =20
+  {REFRESH_60,CLK_74_481M ,M1280X720_R60_HSP, M1280X720_R60_VSP,\
+  {1664,1280, 1280, 384, 1336, 136, 746, 720, 720, 26,  721, 3}}
+};
+
+/* 1280x768 (GTF) */
+static struct crt_mode_table CRTM1280x768[] =3D {
+  /* r_rate,vclk,hsp,vsp */    =20
+  /* HT,  HA,   HBS,  HBE, HSS,  HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+  {REFRESH_60,CLK_80_136M ,M1280X768_R60_HSP, M1280X768_R60_VSP,\
+  {1680,1280, 1280, 400, 1344, 136, 795, 768, 768, 27,  769, 3}}
+};
+
+/*1280x960 */
+static struct crt_mode_table CRTM1280x960[] =3D {
+  /* r_rate,vclk,hsp,vsp */=20
+  /* HT,  HA,   HBS,  HBE, HSS,  HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+  {REFRESH_60,CLK_108_000M ,M1280X960_R60_HSP, M1280X960_R60_VSP,\
+  {1800,1280, 1280, 520, 1376, 112, 1000,960, 960, 40,  961, 3}} =20
+};
+
+/* 1280x1024 */
+static struct crt_mode_table CRTM1280x1024[] =3D {
+  /* r_rate,vclk,,hsp,vsp */
+  /* HT,  HA,   HBS,  HBE, HSS,  HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+  {REFRESH_60,CLK_108_000M ,M1280X1024_R60_HSP, M1280X1024_R60_VSP,\
+  {1688,1280, 1280, 408, 1328, 112, 1066,1024,1024,42,  1025,3}},
+  {REFRESH_75,CLK_135_000M ,M1280X1024_R75_HSP, M1280X1024_R75_VSP,\
+  {1688,1280, 1280, 408, 1296, 144, 1066,1024,1024,42,  1025,3}},
+  {REFRESH_85,CLK_157_500M ,M1280X1024_R85_HSP, M1280X1024_R85_VSP,\
+  {1728,1280, 1280, 448, 1344, 160, 1072,1024,1024,48,  1025,3}}
+};
+
+/* 1368x768 (GTF) */
+static struct crt_mode_table CRTM1368x768[] =3D {
+  /* r_rate,  vclk, hsp, vsp */
+  /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+  {REFRESH_60, CLK_85_860M, M1368X768_R60_HSP, M1368X768_R60_VSP,\
+  {1800,1368, 1368, 432, 1440, 144, 795, 768, 768, 27,  769, 3}}
+};
+
+/* 1368x768 (GTF) */
+/*static struct crt_mode_table CRTM1368x768[] =3D {
+  //r_rate,vclk,     HT,  HA,   HBS,  HBE, HSS,  HSE, VT,  VA,  VBS, =
VBE, VSS, VSE=20
+  { 60,CLK_85_860M ,{1800,1368, 1368, 432, 1440, 144, 795, 768, 768, =
27,  769, 3}}
+};*/
+
+/* 1440x1050 (GTF) */
+static struct crt_mode_table CRTM1440x1050[] =3D {
+  /* r_rate,vclk,hsp,vsp */      =20
+  /* HT,  HA,   HBS,  HBE, HSS,  HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+  {REFRESH_60 ,CLK_125_104M ,M1440X1050_R60_HSP, M1440X1050_R60_VSP,\
+  {1936,1440, 1440, 496, 1536, 152, 1077,1040,1040,37,  1041,3}}
+};
+
+/* 1600x1200 */
+static struct crt_mode_table CRTM1600x1200[] =3D {
+  /* r_rate,vclk,hsp,vsp */
+  /* HT,  HA,   HBS,  HBE, HSS,  HSE, VT,  VA,  VBS, VBE, VSS, VSE */   =
  =20
+  {REFRESH_60 ,CLK_162_000M ,M1600X1200_R60_HSP, M1600X1200_R60_VSP,\
+  {2160,1600, 1600, 560, 1664, 192, 1250,1200,1200,50,  1201,3}},
+  {REFRESH_75 ,CLK_202_500M ,M1600X1200_R75_HSP, M1600X1200_R75_VSP,\
+  {2160,1600, 1600, 560, 1664, 192, 1250,1200,1200,50,  1201,3}}
+
+};
+
+/* 1920x1080 (GTF) */
+static struct crt_mode_table CRTM1920x1080[] =3D {
+  /* r_rate,vclk,hsp,vsp */
+  /* HT,  HA,   HBS,  HBE, HSS,  HSE, VT,  VA,  VBS, VBE, VSS, VSE */   =
                        =20
+  {REFRESH_60,CLK_172_798M ,M1920X1080_R60_HSP, M1920X1080_R60_VSP,\
+  {2576,1920, 1920, 656, 2040, 208, 1118,1080,1080,38, 1081, 3}}
+};
+
+/* 1920x1440 */
+static struct crt_mode_table CRTM1920x1440[] =3D {
+  /* r_rate,vclk,hsp,vsp */
+  /* HT,  HA,   HBS,  HBE, HSS,  HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+  {REFRESH_60,CLK_234_000M ,M1920X1440_R60_HSP, M1920X1440_R60_VSP,\
+  {2600,1920, 1920, 680, 2048, 208, 1500,1440,1440,60,  1441,3}},
+  {REFRESH_75,CLK_297_500M ,M1920X1440_R75_HSP, M1920X1440_R75_VSP,\
+  {2640,1920, 1920, 720, 2064, 224, 1500,1440,1440,60,  1441,3}}
+};
+
+#if 0
+/* 1400x1050 (VESA) */
+static struct crt_mode_table CRTM1400x1050[] =3D {
+  /* r_rate,          vclk,              hsp,             vsp   */
+  /* HT,  HA,  HBS, HBE, HSS, HSE,    VT,  VA,  VBS, VBE,  VSS, VSE */
+  {REFRESH_60,CLK_108_000M, M1400X1050_R60_HSP, M1400X1050_R60_VSP,
+  {1688,1400, 1400, 288, 1448, 112, 1066,1050, 1050,  16, 1051, 3}}
+};
+#endif
+
+/* 1400x1050 (GTF) */
+static struct crt_mode_table CRTM1400x1050[] =3D {
+  /* r_rate,          vclk,              hsp,             vsp   */
+  /* HT,  HA,  HBS, HBE,  HSS, HSE,   VT,  VA,  VBS, VBE,  VSS, VSE */
+  {REFRESH_60,CLK_122_614M, M1400X1050_R60_HSP, M1400X1050_R60_VSP,
+  {1880,1400, 1400, 480, 1488, 152, 1087,1050, 1050,  37, 1051, 3}}
+};
+
+static struct VideoModeTable CLE266Modes[] =3D {
+   /* Display : 640x480 */
+   { VIA_RES_640X480,  CRTM640x480, ARRAY_SIZE(CRTM640x480)},
+
+   /* Display : 720x480 (GTF) */
+   { VIA_RES_720X480,  CRTM720x480, ARRAY_SIZE(CRTM720x480)},
+
+   /* Display : 720x576 (GTF) */
+   { VIA_RES_720X576,  CRTM720x576, ARRAY_SIZE(CRTM720x576)},
+
+   /* Display : 800x600 */
+   { VIA_RES_800X600,  CRTM800x600, ARRAY_SIZE(CRTM800x600)},
+
+   /* Display : 800x480 (GTF) */
+   { VIA_RES_800X480,  CRTM800x480, ARRAY_SIZE(CRTM800x480)},
+
+   /* Display : 848x480 (GTF) */
+   { VIA_RES_848X480,  CRTM848x480, ARRAY_SIZE(CRTM848x480)},
+
+   /* Display : 852x480 (GTF) */
+   { VIA_RES_856X480,  CRTM852x480, ARRAY_SIZE(CRTM852x480)},
+
+   /* Display : 1024x512 (GTF) */
+   { VIA_RES_1024X512, CRTM1024x512, ARRAY_SIZE(CRTM1024x512)},
+
+    /* Display : 1024x576 (GTF) */
+   /*{ VIA_RES_1024X576, CRTM1024x576, ARRAY_SIZE(CRTM1024x576)},*/
+
+   /* Display : 1024x768 */
+   { VIA_RES_1024X768, CRTM1024x768, ARRAY_SIZE(CRTM1024x768)},
+
+   /* Display : 1152x864 */
+   { VIA_RES_1152X864, CRTM1152x864, ARRAY_SIZE(CRTM1152x864)},
+
+   /* Display : 1280x768 (GTF) */
+   { VIA_RES_1280X768, CRTM1280x768, ARRAY_SIZE(CRTM1280x768)},
+
+   /* Display : 1280x800 (GTF) */
+   /*{ M1280x800, CRTM1280x800, ARRAY_SIZE(CRTM1280x800)},*/=20
+
+   /* Display : 1280x960 */
+   { VIA_RES_1280X960, CRTM1280x960, ARRAY_SIZE(CRTM1280x960)},
+
+   /* Display : 1280x1024 */
+   { VIA_RES_1280X1024, CRTM1280x1024,ARRAY_SIZE(CRTM1280x1024)},
+
+   /* Display : 1368x768 (GTF) */
+   /*{ M1368x768,CRTM1368x768,ARRAY_SIZE(CRTM1368x768)},*/=20
+   /* Display : 1368x768 (GTF) */
+   { VIA_RES_1368X768,CRTM1368x768,ARRAY_SIZE(CRTM1368x768)},
+
+   /* Display : 1440x1050 (GTF) */
+   { VIA_RES_1440X1050, CRTM1440x1050, ARRAY_SIZE(CRTM1440x1050)},
+
+   /* Display : 1600x1200 */
+   { VIA_RES_1600X1200, CRTM1600x1200, ARRAY_SIZE(CRTM1600x1200)},
+
+   /* Display : 1920x1440 */
+   { VIA_RES_1920X1440, CRTM1920x1440, ARRAY_SIZE(CRTM1920x1440)},
+
+   /* Display : 1280x720 */
+   { VIA_RES_1280X720, CRTM1280x720, ARRAY_SIZE(CRTM1280x720)},
+
+   /* Display : 1920x1080 */
+   { VIA_RES_1920X1080, CRTM1920x1080, ARRAY_SIZE(CRTM1920x1080)},
+
+   /* Display : 1400x1050 */
+   { VIA_RES_1400X1050, CRTM1400x1050, ARRAY_SIZE(CRTM1400x1050)}
+};
+
+#define NUM_TOTAL_MODETABLE ARRAY_SIZE(CLE266Modes)
+
+
+#endif /* __VIAMODE_H__ */

=20

------_=_NextPart_001_01C7893F.30ABE19E
Content-Type: text/html;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

<HTML dir=3Dltr><HEAD>=0A=
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dunicode">=0A=
<META content=3D"MSHTML 6.00.2900.3059" name=3DGENERATOR></HEAD>=0A=
<BODY><FONT face=3D=B7s=B2=D3=A9=FA=C5=E9 size=3D2>diff -Nur =
linux-2.6.21-rc7/drivers/video/via/tbl1636.h =
linux-2.6.21-rc7.viafb/drivers/video/via/tbl1636.h<BR>--- =
linux-2.6.21-rc7/drivers/video/via/tbl1636.h&nbsp;1969-12-31 =
19:00:00.000000000 -0500<BR>+++ =
linux-2.6.21-rc7.viafb/drivers/video/via/tbl1636.h&nbsp;2007-04-26 =
19:52:32.000000000 -0400<BR>@@ -0,0 +1,82 @@<BR>+ /*<BR>+ * Copyright =
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
_TBL1636_H_<BR>+#define _TBL1636_H_ 1<BR>+<BR>+#include =
"hw.h"<BR>+<BR>+<BR>+struct IODATA COMMON_INIT_TBL_VT1636[] =3D =
{<BR>+/*&nbsp; Index, Mask, Value */<BR>+&nbsp;&nbsp;&nbsp; {0x10, 0xC0, =
0x00},&nbsp;&nbsp;&nbsp;&nbsp; /* Set panel power sequence timing =
*/<BR>+&nbsp;&nbsp;&nbsp; {0x0B, 0xFF, 0x40},&nbsp;&nbsp;&nbsp;&nbsp; /* =
T1: VDD on - Data on. Each increment is 1 ms. (50ms =3D =
031h)*/<BR>+&nbsp;&nbsp;&nbsp; {0x0C, 0xFF, =
0x31},&nbsp;&nbsp;&nbsp;&nbsp; /* T2: Data on - Backlight on. Each =
increment is 2 ms. (210ms =3D 068h) */<BR>+&nbsp;&nbsp;&nbsp; {0x0D, =
0xFF, 0x31},&nbsp;&nbsp;&nbsp;&nbsp; /* T3: Backlight off - Data off. =
Each increment is 2 ms. (210ms =3D 068h) */<BR>+&nbsp;&nbsp;&nbsp; =
{0x0E, 0xFF, 0x68},&nbsp;&nbsp;&nbsp;&nbsp; /* T4: Data off - VDD off. =
Each increment is 1 ms. (50ms =3D 031h) */<BR>+&nbsp;&nbsp;&nbsp; {0x0F, =
0xFF, 0x68},&nbsp;&nbsp;&nbsp;&nbsp; /* T5: VDD off - VDD on. Each =
increment is 100 ms. (500ms =3D 04h) */<BR>+&nbsp;&nbsp;&nbsp; {0x09, =
0xA0, 0xA0},&nbsp;&nbsp;&nbsp;&nbsp; /* LVDS output power up =
*/<BR>+&nbsp;&nbsp;&nbsp; {0x10, 0x33, =
0x13}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* turn on back light =
*/<BR>+};<BR>+<BR>+<BR>+struct IODATA DUAL_CHANNEL_ENABLE_TBL_VT1636[] =
=3D {<BR>+/*&nbsp; Index, Mask, Value */<BR>+&nbsp;&nbsp;&nbsp; =
{0x08,&nbsp; 0xF0, 0xE0}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Input Data =
Mode Select */<BR>+};<BR>+<BR>+<BR>+struct IODATA =
SINGLE_CHANNEL_ENABLE_TBL_VT1636[] =3D {<BR>+/*&nbsp; Index, Mask, Value =
*/<BR>+&nbsp;&nbsp;&nbsp; {0x08,&nbsp; 0xF0, =
0x00}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Input Data Mode Select =
*/<BR>+};<BR>+<BR>+<BR>+struct IODATA DITHERING_ENABLE_TBL_VT1636[] =3D =
{<BR>+/*&nbsp; Index, Mask, Value */<BR>+&nbsp;&nbsp;&nbsp; {0x0A,&nbsp; =
0x70, 0x50}<BR>+};<BR>+<BR>+<BR>+struct IODATA =
DITHERING_DISABLE_TBL_VT1636[] =3D {<BR>+/*&nbsp; Index, Mask, Value =
*/<BR>+&nbsp;&nbsp;&nbsp; {0x0A,&nbsp; 0x70, =
0x00}<BR>+};<BR>+<BR>+<BR>+struct IODATA VDD_ON_TBL_VT1636[] =3D =
{<BR>+/*&nbsp; Index, Mask, Value */<BR>+&nbsp;&nbsp;&nbsp; {0x10,&nbsp; =
0x20, 0x20}<BR>+};<BR>+<BR>+<BR>+struct IODATA VDD_OFF_TBL_VT1636[] =3D =
{<BR>+/*&nbsp; Index, Mask, Value */<BR>+&nbsp;&nbsp;&nbsp; {0x10,&nbsp; =
0x20, 0x00}<BR>+};<BR>+<BR>+<BR>+#endif&nbsp; /* _VIA_TBL1636_H_ =
*/<BR>+<BR>diff -Nur linux-2.6.21-rc7/drivers/video/via/tblDPASetting.h =
linux-2.6.21-rc7.viafb/drivers/video/via/tblDPASetting.h<BR>--- =
linux-2.6.21-rc7/drivers/video/via/tblDPASetting.h&nbsp;1969-12-31 =
19:00:00.000000000 -0500<BR>+++ =
linux-2.6.21-rc7.viafb/drivers/video/via/tblDPASetting.h&nbsp;2007-04-26 =
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
_TBLDPASETTING_H_<BR>+#define _TBLDPASETTING_H_ 1<BR>+#include =
"lcd.h"<BR>+<BR>+#define DPA_CLK_30M&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
30000000<BR>+#define DPA_CLK_50M&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
50000000<BR>+#define DPA_CLK_70M&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
70000000<BR>+#define DPA_CLK_100M&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
100000000<BR>+#define DPA_CLK_150M&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
150000000<BR>+<BR>+<BR>+typedef enum _DPA_CLK_RANGE =
{<BR>+&nbsp;&nbsp;&nbsp; DPA_CLK_RANGE_30M,<BR>+&nbsp;&nbsp;&nbsp; =
DPA_CLK_RANGE_30_50M,<BR>+&nbsp;&nbsp;&nbsp; =
DPA_CLK_RANGE_50_70M,<BR>+&nbsp;&nbsp;&nbsp; =
DPA_CLK_RANGE_70_100M,<BR>+&nbsp;&nbsp;&nbsp; =
DPA_CLK_RANGE_100_150M,<BR>+&nbsp;&nbsp;&nbsp; DPA_CLK_RANGE_150M,<BR>+} =
DPA_CLK_RANGE;<BR>+<BR>+<BR>+/* For VT3324: */<BR>+struct =
VT1636_DPA_SETTING VT1636_DPA_SETTING_TBL_VT3324[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp; /* Panel =
ID,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
CLK_SEL_ST1[09],&nbsp;&nbsp;&nbsp; CLK_SEL_ST2[08] =
*/<BR>+&nbsp;&nbsp;&nbsp; =
{LCD_PANEL_ID0_640X480,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; =
0x00},&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For =
640x480&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
{LCD_PANEL_ID1_800X600,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; =
0x00},&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For =
800x600&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
{LCD_PANEL_ID2_1024X768,&nbsp;&nbsp;&nbsp;&nbsp; =
0x00,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; =
0x00},&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For =
1024x768&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
{LCD_PANEL_ID3_1280X768,&nbsp;&nbsp;&nbsp;&nbsp; =
0x00,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; =
0x00},&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For =
1280x768&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
{LCD_PANEL_ID4_1280X1024,&nbsp;&nbsp;&nbsp; =
0x00,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; =
0x00},&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For =
1280x1024 */<BR>+&nbsp;&nbsp;&nbsp; =
{LCD_PANEL_ID5_1400X1050,&nbsp;&nbsp;&nbsp; =
0x00,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; =
0x00},&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For =
1400x1050 */<BR>+&nbsp;&nbsp;&nbsp; =
{LCD_PANEL_ID6_1600X1200,&nbsp;&nbsp;&nbsp; =
0x0B,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; =
0x03}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For =
1600x1200 */<BR>+};<BR>+<BR>+struct GFX_DPA_SETTING =
GFX_DPA_SETTING_TBL_VT3324[] =3D {<BR>+&nbsp;&nbsp;&nbsp; /*&nbsp; =
ClkRange,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; DVP0, DVP0DataDriving,&nbsp; DVP0ClockDriving, DVP1, DVP1Driving, =
DFPHigh,&nbsp;&nbsp; DFPLow */<BR>+&nbsp;&nbsp;&nbsp; =
/*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CR96, =
SR2A[5], SR1B[1], SR2A[4], SR1E[2], CR9B, =
SR65,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
CR97,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CR99&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
{DPA_CLK_RANGE_30M,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00, =
0x00,&nbsp;&nbsp;&nbsp; 0x00,&nbsp;&nbsp;&nbsp; 0x00,&nbsp;&nbsp;&nbsp; =
0x00,&nbsp;&nbsp;&nbsp; 0x03, =
0x00,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00},&nbsp; /* LCK/VCK &lt; =
30000000 will use this value */<BR>+&nbsp;&nbsp;&nbsp; =
{DPA_CLK_RANGE_30_50M,&nbsp;&nbsp; 0x00, 0x00,&nbsp;&nbsp;&nbsp; =
0x00,&nbsp;&nbsp;&nbsp; 0x00,&nbsp;&nbsp;&nbsp; 0x00,&nbsp;&nbsp;&nbsp; =
0x03, 0x00,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00},&nbsp; /* 30000000 &lt; =
LCK/VCK &lt; 50000000 will use this value */<BR>+&nbsp;&nbsp;&nbsp; =
{DPA_CLK_RANGE_50_70M,&nbsp;&nbsp; 0x00, 0x00,&nbsp;&nbsp;&nbsp; =
0x00,&nbsp;&nbsp;&nbsp; 0x00,&nbsp;&nbsp;&nbsp; 0x00,&nbsp;&nbsp;&nbsp; =
0x02, 0x00,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00},&nbsp; /* 50000000 &lt; =
LCK/VCK &lt; 70000000 will use this value */<BR>+&nbsp;&nbsp;&nbsp; =
{DPA_CLK_RANGE_70_100M,&nbsp; 0x00, 0x00,&nbsp;&nbsp;&nbsp; =
0x00,&nbsp;&nbsp;&nbsp; 0x00,&nbsp;&nbsp;&nbsp; 0x00,&nbsp;&nbsp;&nbsp; =
0x02, 0x00,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00},&nbsp; /* 70000000 &lt; =
LCK/VCK &lt; 100000000 will use this value */<BR>+&nbsp;&nbsp;&nbsp; =
{DPA_CLK_RANGE_100_150M, 0x00, 0x00,&nbsp;&nbsp;&nbsp; =
0x00,&nbsp;&nbsp;&nbsp; 0x00,&nbsp;&nbsp;&nbsp; 0x00,&nbsp;&nbsp;&nbsp; =
0x02, 0x00,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00},&nbsp; /* 100000000 &lt; =
LCK/VCK &lt; 15000000 will use this value */<BR>+&nbsp;&nbsp;&nbsp; =
{DPA_CLK_RANGE_150M,&nbsp;&nbsp;&nbsp;&nbsp; 0x00, =
0x00,&nbsp;&nbsp;&nbsp; 0x00,&nbsp;&nbsp;&nbsp; 0x00,&nbsp;&nbsp;&nbsp; =
0x00,&nbsp;&nbsp;&nbsp; 0x08, =
0x0E,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00},&nbsp; /* 15000000 &lt; =
LCK/VCK will use this value */<BR>+};<BR>+<BR>+<BR>+/* For VT3327: =
*/<BR>+struct VT1636_DPA_SETTING VT1636_DPA_SETTING_TBL_VT3327[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp; /* Panel =
ID,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
CLK_SEL_ST1[09],&nbsp;&nbsp;&nbsp; CLK_SEL_ST2[08] =
*/<BR>+&nbsp;&nbsp;&nbsp; =
{LCD_PANEL_ID0_640X480,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; =
0x00},&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For =
640x480&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
{LCD_PANEL_ID1_800X600,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; =
0x00},&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For =
800x600&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
{LCD_PANEL_ID2_1024X768,&nbsp;&nbsp;&nbsp;&nbsp; =
0x00,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; =
0x00},&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For =
1024x768&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
{LCD_PANEL_ID3_1280X768,&nbsp;&nbsp;&nbsp;&nbsp; =
0x00,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; =
0x00},&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For =
1280x768&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
{LCD_PANEL_ID4_1280X1024,&nbsp;&nbsp;&nbsp; =
0x00,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; =
0x00},&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For =
1280x1024 */<BR>+&nbsp;&nbsp;&nbsp; =
{LCD_PANEL_ID5_1400X1050,&nbsp;&nbsp;&nbsp; =
0x00,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; =
0x00},&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For =
1400x1050 */<BR>+&nbsp;&nbsp;&nbsp; =
{LCD_PANEL_ID6_1600X1200,&nbsp;&nbsp;&nbsp; =
0x00,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; =
0x00}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For =
1600x1200 */<BR>+};<BR>+<BR>+struct GFX_DPA_SETTING =
GFX_DPA_SETTING_TBL_VT3327[] =3D {<BR>+&nbsp;&nbsp;&nbsp; /*&nbsp; =
ClkRange,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; DVP0, DVP0DataDriving,&nbsp; DVP0ClockDriving, DVP1, DVP1Driving, =
DFPHigh,&nbsp;&nbsp; DFPLow */<BR>+&nbsp;&nbsp;&nbsp; =
/*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CR96, =
SR2A[5], SR1B[1], SR2A[4], SR1E[2], CR9B, =
SR65,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
CR97,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CR99&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
{DPA_CLK_RANGE_30M,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x07, =
0x00,&nbsp;&nbsp;&nbsp; 0x00,&nbsp;&nbsp;&nbsp; 0x00,&nbsp;&nbsp;&nbsp; =
0x00,&nbsp;&nbsp;&nbsp; 0x03, =
0x00,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x08,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x01},&nbsp; /* LCK/VCK &lt; =
30000000 will use this value */<BR>+&nbsp;&nbsp;&nbsp; =
{DPA_CLK_RANGE_30_50M,&nbsp;&nbsp; 0x07, 0x00,&nbsp;&nbsp;&nbsp; =
0x00,&nbsp;&nbsp;&nbsp; 0x00,&nbsp;&nbsp;&nbsp; 0x00,&nbsp;&nbsp;&nbsp; =
0x03, 0x00,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x08,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x01},&nbsp; /* 30000000 &lt; =
LCK/VCK &lt; 50000000 will use this value */<BR>+&nbsp;&nbsp;&nbsp; =
{DPA_CLK_RANGE_50_70M,&nbsp;&nbsp; 0x06, 0x00,&nbsp;&nbsp;&nbsp; =
0x00,&nbsp;&nbsp;&nbsp; 0x00,&nbsp;&nbsp;&nbsp; 0x00,&nbsp;&nbsp;&nbsp; =
0x03, 0x00,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x08,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x01},&nbsp; /* 50000000 &lt; =
LCK/VCK &lt; 70000000 will use this value */<BR>+&nbsp;&nbsp;&nbsp; =
{DPA_CLK_RANGE_70_100M,&nbsp; 0x03, 0x00,&nbsp;&nbsp;&nbsp; =
0x00,&nbsp;&nbsp;&nbsp; 0x00,&nbsp;&nbsp;&nbsp; 0x00,&nbsp;&nbsp;&nbsp; =
0x03, 0x00,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x08,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x03},&nbsp; /* 70000000 &lt; =
LCK/VCK &lt; 100000000 will use this value */<BR>+&nbsp;&nbsp;&nbsp; =
{DPA_CLK_RANGE_100_150M, 0x03, 0x00,&nbsp;&nbsp;&nbsp; =
0x00,&nbsp;&nbsp;&nbsp; 0x00,&nbsp;&nbsp;&nbsp; 0x00,&nbsp;&nbsp;&nbsp; =
0x03, 0x00,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x01,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x02},&nbsp; /* 100000000 &lt; =
LCK/VCK &lt; 15000000 will use this value */<BR>+&nbsp;&nbsp;&nbsp; =
{DPA_CLK_RANGE_150M,&nbsp;&nbsp;&nbsp;&nbsp; 0x00, =
0x20,&nbsp;&nbsp;&nbsp; 0x00,&nbsp;&nbsp;&nbsp; 0x10,&nbsp;&nbsp;&nbsp; =
0x00,&nbsp;&nbsp;&nbsp; 0x03, =
0x00,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x0D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x03},&nbsp; /* 15000000 &lt; =
LCK/VCK will use this value */<BR>+};<BR>+<BR>+<BR>+/* For VT3364: =
*/<BR>+struct GFX_DPA_SETTING GFX_DPA_SETTING_TBL_VT3364[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; /*&nbsp; =
ClkRange,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; DVP0, DVP0DataDriving,&nbsp; DVP0ClockDriving, DVP1, DVP1Driving, =
DFPHigh,&nbsp;&nbsp; DFPLow */<BR>+&nbsp;&nbsp;&nbsp; =
/*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CR96, =
SR2A[5], SR1B[1], SR2A[4], SR1E[2], CR9B, =
SR65,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
CR97,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CR99&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
{DPA_CLK_RANGE_30M,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x07, =
0x00,&nbsp;&nbsp;&nbsp; 0x00,&nbsp;&nbsp;&nbsp; 0x00,&nbsp;&nbsp;&nbsp; =
0x00,&nbsp;&nbsp;&nbsp; 0x03, =
0x00,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x08},&nbsp; /* LCK/VCK &lt; =
30000000 will use this value */<BR>+&nbsp;&nbsp;&nbsp; =
{DPA_CLK_RANGE_30_50M,&nbsp;&nbsp; 0x07, 0x00,&nbsp;&nbsp;&nbsp; =
0x00,&nbsp;&nbsp;&nbsp; 0x00,&nbsp;&nbsp;&nbsp; 0x00,&nbsp;&nbsp;&nbsp; =
0x03, 0x00,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x08},&nbsp; /* 30000000 &lt; =
LCK/VCK &lt; 50000000 will use this value */<BR>+&nbsp;&nbsp;&nbsp; =
{DPA_CLK_RANGE_50_70M,&nbsp;&nbsp; 0x07, 0x00,&nbsp;&nbsp;&nbsp; =
0x00,&nbsp;&nbsp;&nbsp; 0x00,&nbsp;&nbsp;&nbsp; 0x00,&nbsp;&nbsp;&nbsp; =
0x03, 0x00,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x08},&nbsp; /* 50000000 &lt; =
LCK/VCK &lt; 70000000 will use this value */<BR>+&nbsp;&nbsp;&nbsp; =
{DPA_CLK_RANGE_70_100M,&nbsp; 0x07, 0x00,&nbsp;&nbsp;&nbsp; =
0x00,&nbsp;&nbsp;&nbsp; 0x00,&nbsp;&nbsp;&nbsp; 0x00,&nbsp;&nbsp;&nbsp; =
0x03, 0x00,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x08},&nbsp; /* 70000000 &lt; =
LCK/VCK &lt; 100000000 will use this value */<BR>+&nbsp;&nbsp;&nbsp; =
{DPA_CLK_RANGE_100_150M, 0x03, 0x00,&nbsp;&nbsp;&nbsp; =
0x02,&nbsp;&nbsp;&nbsp; 0x00,&nbsp;&nbsp;&nbsp; 0x00,&nbsp;&nbsp;&nbsp; =
0x03, 0x00,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x08},&nbsp; /* 100000000 &lt; =
LCK/VCK &lt; 15000000 will use this value */<BR>+&nbsp;&nbsp;&nbsp; =
{DPA_CLK_RANGE_150M,&nbsp;&nbsp;&nbsp;&nbsp; 0x01, =
0x00,&nbsp;&nbsp;&nbsp; 0x02,&nbsp;&nbsp;&nbsp; 0x10,&nbsp;&nbsp;&nbsp; =
0x00,&nbsp;&nbsp;&nbsp; 0x03, =
0x00,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x08},&nbsp; /* 15000000 &lt; =
LCK/VCK will use this value */<BR>+};<BR>+<BR>+#endif<BR>+<BR>diff -Nur =
linux-2.6.21-rc7/drivers/video/via/tblIntegratedTV.h =
linux-2.6.21-rc7.viafb/drivers/video/via/tblIntegratedTV.h<BR>--- =
linux-2.6.21-rc7/drivers/video/via/tblIntegratedTV.h&nbsp;1969-12-31 =
19:00:00.000000000 -0500<BR>+++ =
linux-2.6.21-rc7.viafb/drivers/video/via/tblIntegratedTV.h&nbsp;2007-04-2=
6 19:52:32.000000000 -0400<BR>@@ -0,0 +1,1208 @@<BR>+/*<BR>+ * Copyright =
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
_TBLINTEGRATEDTV_H_<BR>+#define _TBLINTEGRATEDTV_H_ 1<BR>+<BR>+#define =
INTEGRATED_TVCLK_27MHZ&nbsp;&nbsp;&nbsp;&nbsp; 0x01865884<BR>+#define =
INTEGRATED_TVCLK_54MHZ&nbsp;&nbsp;&nbsp;&nbsp; 0x00C65884<BR>+#define =
INTEGRATED_TVCLK_74_25MHZ&nbsp; 0x01043084<BR>+#define =
INTEGRATED_TVCLK_148_5MHZ&nbsp; =
0x00843084<BR>+<BR>+<BR>+/***************************/<BR>+/*&nbsp; =
Integrated TV Table&nbsp;&nbsp;&nbsp; =
*/<BR>+/***************************/<BR>+<BR>+struct =
integrated_tv_mode_table {<BR>+&nbsp;&nbsp;&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; mode_index;<BR>+&nbsp;&nbsp;&nbsp; unsigned =
long&nbsp;&nbsp;&nbsp; *std_ntsc;<BR>+&nbsp;&nbsp;&nbsp; unsigned =
long&nbsp;&nbsp;&nbsp; *std_pal;<BR>+&nbsp;&nbsp;&nbsp; unsigned =
long&nbsp;&nbsp;&nbsp; *std_720p;<BR>+&nbsp;&nbsp;&nbsp; unsigned =
long&nbsp;&nbsp;&nbsp; *std_1080i;<BR>+};<BR>+<BR>+struct =
integrated_tv_hdtv_patch_table {<BR>+&nbsp;&nbsp;&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; mode_index;<BR>+&nbsp;&nbsp;&nbsp; unsigned short&nbsp; =
*std_480p;<BR>+&nbsp;&nbsp;&nbsp; unsigned short&nbsp; =
*std_576p;<BR>+&nbsp;&nbsp;&nbsp; unsigned short&nbsp; =
*std_720p;<BR>+&nbsp;&nbsp;&nbsp; unsigned short&nbsp; =
*std_1080i;<BR>+};<BR>+<BR>+unsigned short ITV_INIT_TABLE_OFFSET[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 0x0000,<BR>+&nbsp;&nbsp;&nbsp; =
0x001C,<BR>+&nbsp;&nbsp;&nbsp; 0x00DC,<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp; /*End*/<BR>+};<BR>+ <BR>+unsigned long =
ITV_INIT_TABLE_VALUE[] =3D {<BR>+&nbsp;&nbsp;&nbsp; =
0x40412000,&nbsp;&nbsp;&nbsp;&nbsp; /* 00-03 */<BR>+&nbsp;&nbsp;&nbsp; =
0x40000000,&nbsp;&nbsp;&nbsp;&nbsp; /* 1C-1F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* TVCLK PLL. */<BR>+&nbsp;&nbsp;&nbsp; =
0xA0000000,&nbsp;&nbsp;&nbsp;&nbsp; /* DC-DF */<BR>+};<BR>+<BR>+unsigned =
short ITV_MODE_TABLE_OFFSET[] =3D {<BR>+&nbsp;&nbsp;&nbsp; =
0x0014,<BR>+&nbsp;&nbsp;&nbsp; 0x0018,<BR>+&nbsp;&nbsp;&nbsp; =
0x0020,<BR>+&nbsp;&nbsp;&nbsp; 0x0024,<BR>+&nbsp;&nbsp;&nbsp; =
0x0028,<BR>+&nbsp;&nbsp;&nbsp; 0x0034,<BR>+&nbsp;&nbsp;&nbsp; =
0x0038,<BR>+&nbsp;&nbsp;&nbsp; 0x003C,<BR>+&nbsp;&nbsp;&nbsp; =
0x0040,<BR>+&nbsp;&nbsp;&nbsp; 0x0044,<BR>+&nbsp;&nbsp;&nbsp; =
0x0048,<BR>+&nbsp;&nbsp;&nbsp; 0x004C,<BR>+&nbsp;&nbsp;&nbsp; =
0x0050,<BR>+&nbsp;&nbsp;&nbsp; 0x0054,<BR>+&nbsp;&nbsp;&nbsp; =
0x0058,<BR>+&nbsp;&nbsp;&nbsp; 0x005C,<BR>+&nbsp;&nbsp;&nbsp; =
0x0060,<BR>+&nbsp;&nbsp;&nbsp; 0x00E0,<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp; =
/*End*/<BR>+};<BR>+<BR>+/************************************************=
**************************************/<BR>+/****************************=
********* NTSC =
*******************************************/<BR>+/***********************=
***************************************************************/<BR>+unsi=
gned long ITV_MODE_TABLE_NTSC_640x480[] =3D {<BR>+&nbsp;&nbsp;&nbsp; /* =
Src Buffer Line Pitch. */&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; =
0x00770500,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 14-17 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Src Image Size and Position. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x09D3F9DF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 18-1B */<BR>+&nbsp;&nbsp;&nbsp; =
0x027F01DF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 20-23 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Scaling Factor and De-Flicker. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x63EB48FA,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 24-27 =
*/&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Dst Image Size. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x141461AA,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 28-2B =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Dst Buffer Line Pitch &amp; DQWord. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x008E0500,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 34-37 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Encoder Control. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xC000A214,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 38-3B */<BR>+&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; /* Encoder CRTC. */<BR>+&nbsp;&nbsp;&nbsp; =
0x427F06B3,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 3C-3F */<BR>+&nbsp;&nbsp;&nbsp; =
0x00F400B1,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 40-43 */<BR>+&nbsp;&nbsp;&nbsp; =
0x06910100,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 44-47 */<BR>+&nbsp;&nbsp;&nbsp; =
0x01000000,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 48-4B */<BR>+&nbsp;&nbsp;&nbsp; =
0x088680C0,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 4C-4F */<BR>+&nbsp;&nbsp;&nbsp; =
0x488F08C8,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 50-53 */<BR>+&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; /* Luma Data */<BR>+&nbsp;&nbsp;&nbsp; =
0x0A9AA886,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 54-57 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0x21F07C16,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 58-5B =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Burst and Sync Shape =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x00F01010,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 5C-5F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Hue and Sub-Carrier =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x00000000,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 60-63 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* TVCLK PLL */<BR>+&nbsp;&nbsp;&nbsp; =
INTEGRATED_TVCLK_27MHZ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* E0-E3 =
*/<BR>+};<BR>+<BR>+unsigned long ITV_CRTC_TABLE_NTSC_640x480[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 858,&nbsp;&nbsp;&nbsp; /* H_Total =
*/<BR>+&nbsp;&nbsp;&nbsp; 640,&nbsp;&nbsp;&nbsp; /* H_Display_End =
*/<BR>+&nbsp;&nbsp;&nbsp; 640,&nbsp;&nbsp;&nbsp; /* H_Blanking_Start =
*/<BR>+&nbsp;&nbsp;&nbsp; 218,&nbsp;&nbsp;&nbsp; /* H_Blanking_End =
*/<BR>+&nbsp;&nbsp;&nbsp; 688,&nbsp;&nbsp;&nbsp; /* H_Sync_Start =
*/<BR>+&nbsp;&nbsp;&nbsp; 56,&nbsp;&nbsp;&nbsp;&nbsp; /* H_Sync_End =
*/<BR>+&nbsp;&nbsp;&nbsp; 525,&nbsp;&nbsp;&nbsp; /* V_Total =
*/<BR>+&nbsp;&nbsp;&nbsp; 480,&nbsp;&nbsp;&nbsp; /* V_Display_End =
*/<BR>+&nbsp;&nbsp;&nbsp; 480,&nbsp;&nbsp;&nbsp; /* V_Blanking_Start =
*/<BR>+&nbsp;&nbsp;&nbsp; 45,&nbsp;&nbsp;&nbsp;&nbsp; /* V_Blanking_End =
*/<BR>+&nbsp;&nbsp;&nbsp; 488,&nbsp;&nbsp;&nbsp; /* V_Sync_Start =
*/<BR>+&nbsp;&nbsp;&nbsp; 7&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
V_Sync_End */<BR>+};<BR>+<BR>+<BR>+unsigned long =
ITV_MODE_TABLE_NTSC_720x480[] =3D {<BR>+&nbsp;&nbsp;&nbsp; /* Src Buffer =
Line Pitch. */&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; =
0x007705C0,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 14-17 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Src Image Size and Position. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x09D679DF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 18-1B */<BR>+&nbsp;&nbsp;&nbsp; =
0x02CF01DF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 20-23 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Scaling Factor and De-Flicker. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x646C4903,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 24-27 =
*/&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Dst Image Size. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x169451A9,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 28-2B =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Dst Buffer Line Pitch &amp; DQWord. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x008E05C0,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 34-37 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Encoder Control. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xC000A214,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 38-3B */<BR>+&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; /* Encoder CRTC. */<BR>+&nbsp;&nbsp;&nbsp; =
0x427F06B3,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 3C-3F */<BR>+&nbsp;&nbsp;&nbsp; =
0x00F400B1,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 40-43 */<BR>+&nbsp;&nbsp;&nbsp; =
0x06910100,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 44-47 */<BR>+&nbsp;&nbsp;&nbsp; =
0x01A00000,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 48-4B */<BR>+&nbsp;&nbsp;&nbsp; =
0x088680C0,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 4C-4F */<BR>+&nbsp;&nbsp;&nbsp; =
0x488F08C8,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 50-53 */<BR>+&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; /* Luma Data */<BR>+&nbsp;&nbsp;&nbsp; =
0x0A9AA886,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 54-57 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0x21F07C16,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 58-5B =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Burst and Sync Shape =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x00F01010,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 5C-5F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Hue and Sub-Carrier =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x00000000,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 60-63 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* TVCLK PLL */<BR>+&nbsp;&nbsp;&nbsp; =
INTEGRATED_TVCLK_27MHZ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* E0-E3 =
*/<BR>+};<BR>+<BR>+unsigned long ITV_CRTC_TABLE_NTSC_720x480[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 858,&nbsp;&nbsp;&nbsp; /* H_Total =
*/<BR>+&nbsp;&nbsp;&nbsp; 720,&nbsp;&nbsp;&nbsp; /* H_Display_End =
*/<BR>+&nbsp;&nbsp;&nbsp; 720,&nbsp;&nbsp;&nbsp; /* H_Blanking_Start =
*/<BR>+&nbsp;&nbsp;&nbsp; 138,&nbsp;&nbsp;&nbsp; /* H_Blanking_End =
*/<BR>+&nbsp;&nbsp;&nbsp; 736,&nbsp;&nbsp;&nbsp; /* H_Sync_Start =
*/<BR>+&nbsp;&nbsp;&nbsp; 72,&nbsp;&nbsp;&nbsp;&nbsp; /* H_Sync_End =
*/<BR>+&nbsp;&nbsp;&nbsp; 525,&nbsp;&nbsp;&nbsp; /* V_Total =
*/<BR>+&nbsp;&nbsp;&nbsp; 480,&nbsp;&nbsp;&nbsp; /* V_Display_End =
*/<BR>+&nbsp;&nbsp;&nbsp; 480,&nbsp;&nbsp;&nbsp; /* V_Blanking_Start =
*/<BR>+&nbsp;&nbsp;&nbsp; 45,&nbsp;&nbsp;&nbsp;&nbsp; /* V_Blanking_End =
*/<BR>+&nbsp;&nbsp;&nbsp; 481,&nbsp;&nbsp;&nbsp; /* V_Sync_Start =
*/<BR>+&nbsp;&nbsp;&nbsp; 3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
V_Sync_End */<BR>+};<BR>+<BR>+<BR>+unsigned long =
ITV_MODE_TABLE_NTSC_800x600[] =3D {<BR>+&nbsp;&nbsp;&nbsp; /* Src Buffer =
Line Pitch. */&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; =
0x00770640,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 14-17 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Src Image Size and Position. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x09D8FA57,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 18-1B */<BR>+&nbsp;&nbsp;&nbsp; =
0x031F0257,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 20-23 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Scaling Factor and De-Flicker. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x64E84B3D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 24-27 =
*/&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Dst Image Size. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x191459AA,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 28-2B =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Dst Buffer Line Pitch &amp; DQWord. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x008E0640,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 34-37 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Encoder Control. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xC000A214,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 38-3B */<BR>+&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; /* Encoder CRTC. */<BR>+&nbsp;&nbsp;&nbsp; =
0x427F06B3,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 3C-3F */<BR>+&nbsp;&nbsp;&nbsp; =
0x00F400B1,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 40-43 */<BR>+&nbsp;&nbsp;&nbsp; =
0x06910100,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 44-47 */<BR>+&nbsp;&nbsp;&nbsp; =
0x01000000,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 48-4B */<BR>+&nbsp;&nbsp;&nbsp; =
0x088680C0,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 4C-4F */<BR>+&nbsp;&nbsp;&nbsp; =
0x488F08C8,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 50-53 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Luma Data */<BR>+&nbsp;&nbsp;&nbsp; =
0x0A9AA886,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 54-57 */<BR>+&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; /* FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0x21F07C16,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 58-5B =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Burst and Sync Shape =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x00F01010,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 5C-5F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Hue and Sub-Carrier =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x00000000,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 60-63 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* TVCLK PLL */<BR>+&nbsp;&nbsp;&nbsp; =
INTEGRATED_TVCLK_54MHZ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* E0-E3 =
*/<BR>+};<BR>+<BR>+unsigned long ITV_CRTC_TABLE_NTSC_800x600[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 1092,&nbsp;&nbsp; /* H_Total =
*/<BR>+&nbsp;&nbsp;&nbsp; 800,&nbsp;&nbsp;&nbsp; /* H_Display_End =
*/<BR>+&nbsp;&nbsp;&nbsp; 800,&nbsp;&nbsp;&nbsp; /* H_Blanking_Start =
*/<BR>+&nbsp;&nbsp;&nbsp; 292,&nbsp;&nbsp;&nbsp; /* H_Blanking_End =
*/<BR>+&nbsp;&nbsp;&nbsp; 840,&nbsp;&nbsp;&nbsp; /* H_Sync_Start =
*/<BR>+&nbsp;&nbsp;&nbsp; 136,&nbsp;&nbsp;&nbsp; /* H_Sync_End =
*/<BR>+&nbsp;&nbsp;&nbsp; 825,&nbsp;&nbsp;&nbsp; /* V_Total =
*/<BR>+&nbsp;&nbsp;&nbsp; 600,&nbsp;&nbsp;&nbsp; /* V_Display_End =
*/<BR>+&nbsp;&nbsp;&nbsp; 600,&nbsp;&nbsp;&nbsp; /* V_Blanking_Start =
*/<BR>+&nbsp;&nbsp;&nbsp; 225,&nbsp;&nbsp;&nbsp; /* V_Blanking_End =
*/<BR>+&nbsp;&nbsp;&nbsp; 606,&nbsp;&nbsp;&nbsp; /* V_Sync_Start =
*/<BR>+&nbsp;&nbsp;&nbsp; 15&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* V_Sync_End =
*/<BR>+};<BR>+<BR>+<BR>+unsigned long ITV_MODE_TABLE_NTSC_1024x768[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; /* Src Buffer Line Pitch. */&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; =
0x00770800,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 14-17 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Src Image Size and Position. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x09DFFAFF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 18-1B */<BR>+&nbsp;&nbsp;&nbsp; =
0x03FF02FF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 20-23 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Scaling Factor and De-Flicker. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x66454E58,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 24-27 =
*/&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Dst Image Size. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x201461AA,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 28-2B =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Dst Buffer Line Pitch &amp; DQWord. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x008E0800,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 34-37 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Encoder Control. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xC000A214,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 38-3B */<BR>+&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; /* Encoder CRTC. */<BR>+&nbsp;&nbsp;&nbsp; =
0x427F06B3,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 3C-3F */<BR>+&nbsp;&nbsp;&nbsp; =
0x00F400B1,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 40-43 */<BR>+&nbsp;&nbsp;&nbsp; =
0x06910100,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 44-47 */<BR>+&nbsp;&nbsp;&nbsp; =
0x01000000,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 48-4B */<BR>+&nbsp;&nbsp;&nbsp; =
0x088680C0,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 4C-4F */<BR>+&nbsp;&nbsp;&nbsp; =
0x488F08C8,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 50-53 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Luma Data */<BR>+&nbsp;&nbsp;&nbsp; =
0x0A9AA886,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 54-57 */<BR>+&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; /* FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0x21F07C16,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 58-5B =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Burst and Sync Shape =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x00F01010,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 5C-5F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Hue and Sub-Carrier =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x00000000,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 60-63 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* TVCLK PLL */<BR>+&nbsp;&nbsp;&nbsp; =
INTEGRATED_TVCLK_54MHZ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* E0-E3 =
*/<BR>+};<BR>+<BR>+unsigned long ITV_CRTC_TABLE_NTSC_1024x768[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 1092,&nbsp;&nbsp; /* H_Total =
*/<BR>+&nbsp;&nbsp;&nbsp; 1024,&nbsp;&nbsp; /* H_Display_End =
*/<BR>+&nbsp;&nbsp;&nbsp; 1024,&nbsp;&nbsp; /* H_Blanking_Start =
*/<BR>+&nbsp;&nbsp;&nbsp; 68,&nbsp;&nbsp;&nbsp;&nbsp; /* H_Blanking_End =
*/<BR>+&nbsp;&nbsp;&nbsp; 1032,&nbsp;&nbsp; /* H_Sync_Start =
*/<BR>+&nbsp;&nbsp;&nbsp; 52,&nbsp;&nbsp;&nbsp;&nbsp; /* H_Sync_End =
*/<BR>+&nbsp;&nbsp;&nbsp; 825,&nbsp;&nbsp;&nbsp; /* V_Total =
*/<BR>+&nbsp;&nbsp;&nbsp; 768,&nbsp;&nbsp;&nbsp; /* V_Display_End =
*/<BR>+&nbsp;&nbsp;&nbsp; 768,&nbsp;&nbsp;&nbsp; /* V_Blanking_Start =
*/<BR>+&nbsp;&nbsp;&nbsp; 57,&nbsp;&nbsp;&nbsp;&nbsp; /* V_Blanking_End =
*/<BR>+&nbsp;&nbsp;&nbsp; 800,&nbsp;&nbsp;&nbsp; /* V_Sync_Start =
*/<BR>+&nbsp;&nbsp;&nbsp; 6&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
V_Sync_End */<BR>+};<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+/*******************************************************************=
*******************/<BR>+/************************************* PAL =
********************************************/<BR>+/**********************=
****************************************************************/<BR>+<BR=
>+unsigned long ITV_MODE_TABLE_PAL_640x480[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; /* Src Buffer Line Pitch. */&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; =
0x00770500,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 14-17 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Src Image Size and Position. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x09D3F9DF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 18-1B */<BR>+&nbsp;&nbsp;&nbsp; =
0x227F01DF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 20-23 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Scaling Factor and De-Flicker. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x6405478E,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 24-27 =
*/&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Dst Image Size. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x1413D9FA,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 28-2B =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Dst Buffer Line Pitch &amp; DQWord. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x008E0500,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 34-37 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Encoder Control. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xC048A214,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 38-3B */<BR>+&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; /* Encoder CRTC. */<BR>+&nbsp;&nbsp;&nbsp; =
0x427F06BF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 3C-3F */<BR>+&nbsp;&nbsp;&nbsp; =
0x00EF00B2,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 40-43 */<BR>+&nbsp;&nbsp;&nbsp; =
0x06990120,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 44-47 */<BR>+&nbsp;&nbsp;&nbsp; =
0x01200010,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 48-4B */<BR>+&nbsp;&nbsp;&nbsp; =
0x0A0680C0,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 4C-4F */<BR>+&nbsp;&nbsp;&nbsp; =
0x489608D3,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 50-53 */<BR>+&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; /* Luma Data */<BR>+&nbsp;&nbsp;&nbsp; =
0x001C0090,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 54-57 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0x2A08D01C,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 58-5B =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Burst and Sync Shape =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x01081011,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 5C-5F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Hue and Sub-Carrier =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x00120000,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 60-63 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* TVCLK PLL */<BR>+&nbsp;&nbsp;&nbsp; =
INTEGRATED_TVCLK_27MHZ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* E0-E3 =
*/<BR>+};<BR>+<BR>+unsigned long ITV_CRTC_TABLE_PAL_640x480[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 864,&nbsp;&nbsp;&nbsp; /* H_Total =
*/<BR>+&nbsp;&nbsp;&nbsp; 640,&nbsp;&nbsp;&nbsp; /* H_Display_End =
*/<BR>+&nbsp;&nbsp;&nbsp; 640,&nbsp;&nbsp;&nbsp; /* H_Blanking_Start =
*/<BR>+&nbsp;&nbsp;&nbsp; 224,&nbsp;&nbsp;&nbsp; /* H_Blanking_End =
*/<BR>+&nbsp;&nbsp;&nbsp; 704,&nbsp;&nbsp;&nbsp; /* H_Sync_Start =
*/<BR>+&nbsp;&nbsp;&nbsp; 56,&nbsp;&nbsp;&nbsp;&nbsp; /* H_Sync_End =
*/<BR>+&nbsp;&nbsp;&nbsp; 625,&nbsp;&nbsp;&nbsp; /* V_Total =
*/<BR>+&nbsp;&nbsp;&nbsp; 480,&nbsp;&nbsp;&nbsp; /* V_Display_End =
*/<BR>+&nbsp;&nbsp;&nbsp; 480,&nbsp;&nbsp;&nbsp; /* V_Blanking_Start =
*/<BR>+&nbsp;&nbsp;&nbsp; 145,&nbsp;&nbsp;&nbsp; /* V_Blanking_End =
*/<BR>+&nbsp;&nbsp;&nbsp; 500,&nbsp;&nbsp;&nbsp; /* V_Sync_Start =
*/<BR>+&nbsp;&nbsp;&nbsp; 6&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
V_Sync_End */<BR>+};<BR>+<BR>+<BR>+unsigned long =
ITV_MODE_TABLE_PAL_720x576[] =3D {<BR>+&nbsp;&nbsp;&nbsp; /* Src Buffer =
Line Pitch. */&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; =
0x007705C0,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 14-17 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Src Image Size and Position. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x09D67A3F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 18-1B */<BR>+&nbsp;&nbsp;&nbsp; =
0x22CF023F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 20-23 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Scaling Factor and De-Flicker. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x64834916,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 24-27 =
*/&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Dst Image Size. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x1693E9FA,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 28-2B =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Dst Buffer Line Pitch &amp; DQWord. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x008E05C0,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 34-37 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Encoder Control. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xC048A214,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 38-3B */<BR>+&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; /* Encoder CRTC. */<BR>+&nbsp;&nbsp;&nbsp; =
0x427F06BF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 3C-3F */<BR>+&nbsp;&nbsp;&nbsp; =
0x00EF00B2,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 40-43 */<BR>+&nbsp;&nbsp;&nbsp; =
0x06990120,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 44-47 */<BR>+&nbsp;&nbsp;&nbsp; =
0x01200010,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 48-4B */<BR>+&nbsp;&nbsp;&nbsp; =
0x0A0680C0,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 4C-4F */<BR>+&nbsp;&nbsp;&nbsp; =
0x489608D3,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 50-53 */<BR>+&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; /* Luma Data */<BR>+&nbsp;&nbsp;&nbsp; =
0x001C0090,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 54-57 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0x2A08D01C,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 58-5B =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Burst and Sync Shape =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x01081011,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 5C-5F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Hue and Sub-Carrier =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x00120000,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 60-63 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* TVCLK PLL */<BR>+&nbsp;&nbsp;&nbsp; =
INTEGRATED_TVCLK_27MHZ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* E0-E3 =
*/<BR>+};<BR>+<BR>+unsigned long ITV_CRTC_TABLE_PAL_720x576[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 864,&nbsp;&nbsp;&nbsp; /* H_Total =
*/<BR>+&nbsp;&nbsp;&nbsp; 720,&nbsp;&nbsp;&nbsp; /* H_Display_End =
*/<BR>+&nbsp;&nbsp;&nbsp; 720,&nbsp;&nbsp;&nbsp; /* H_Blanking_Start =
*/<BR>+&nbsp;&nbsp;&nbsp; 144,&nbsp;&nbsp;&nbsp; /* H_Blanking_End =
*/<BR>+&nbsp;&nbsp;&nbsp; 760,&nbsp;&nbsp;&nbsp; /* H_Sync_Start =
*/<BR>+&nbsp;&nbsp;&nbsp; 40,&nbsp;&nbsp;&nbsp;&nbsp; /* H_Sync_End =
*/<BR>+&nbsp;&nbsp;&nbsp; 625,&nbsp;&nbsp;&nbsp; /* V_Total =
*/<BR>+&nbsp;&nbsp;&nbsp; 576,&nbsp;&nbsp;&nbsp; /* V_Display_End =
*/<BR>+&nbsp;&nbsp;&nbsp; 576,&nbsp;&nbsp;&nbsp; /* V_Blanking_Start =
*/<BR>+&nbsp;&nbsp;&nbsp; 49,&nbsp;&nbsp;&nbsp; /* V_Blanking_End =
*/<BR>+&nbsp;&nbsp;&nbsp; 577,&nbsp;&nbsp;&nbsp; /* V_Sync_Start =
*/<BR>+&nbsp;&nbsp;&nbsp; 3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
V_Sync_End */<BR>+};<BR>+<BR>+<BR>+unsigned long =
ITV_MODE_TABLE_PAL_800x600[] =3D {<BR>+&nbsp;&nbsp;&nbsp; /* Src Buffer =
Line Pitch. */&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; =
0x00770640,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 14-17 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Src Image Size and Position. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x09D8FA57,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 18-1B */<BR>+&nbsp;&nbsp;&nbsp; =
0x231F0257,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 20-23 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Scaling Factor and De-Flicker. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x6503497A,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 24-27 =
*/&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Dst Image Size. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x1913E9F9,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 28-2B =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Dst Buffer Line Pitch &amp; DQWord. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x008E0640,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 34-37 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Encoder Control. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xC048A214,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 38-3B */<BR>+&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; /* Encoder CRTC. */<BR>+&nbsp;&nbsp;&nbsp; =
0x427F06BF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 3C-3F */<BR>+&nbsp;&nbsp;&nbsp; =
0x00EF00B2,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 40-43 */<BR>+&nbsp;&nbsp;&nbsp; =
0x06990120,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 44-47 */<BR>+&nbsp;&nbsp;&nbsp; =
0x01200010,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 48-4B */<BR>+&nbsp;&nbsp;&nbsp; =
0x0A0680C0,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 4C-4F */<BR>+&nbsp;&nbsp;&nbsp; =
0x489608D3,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 50-53 */<BR>+&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; /* Luma Data */<BR>+&nbsp;&nbsp;&nbsp; =
0x001C0090,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 54-57 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0x2A08D01C,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 58-5B =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Burst and Sync Shape =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x01081011,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 5C-5F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Hue and Sub-Carrier =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x00120000,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 60-63 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* TVCLK PLL */<BR>+&nbsp;&nbsp;&nbsp; =
INTEGRATED_TVCLK_54MHZ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* E0-E3 =
*/<BR>+};<BR>+<BR>+unsigned long ITV_CRTC_TABLE_PAL_800x600[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 1350,&nbsp;&nbsp; /* H_Total =
*/<BR>+&nbsp;&nbsp;&nbsp; 800,&nbsp;&nbsp;&nbsp; /* H_Display_End =
*/<BR>+&nbsp;&nbsp;&nbsp; 800,&nbsp;&nbsp;&nbsp; /* H_Blanking_Start =
*/<BR>+&nbsp;&nbsp;&nbsp; 550,&nbsp;&nbsp;&nbsp; /* H_Blanking_End =
*/<BR>+&nbsp;&nbsp;&nbsp; 816,&nbsp;&nbsp;&nbsp; /* H_Sync_Start =
*/<BR>+&nbsp;&nbsp;&nbsp; 64,&nbsp;&nbsp;&nbsp;&nbsp; /* H_Sync_End =
*/<BR>+&nbsp;&nbsp;&nbsp; 800,&nbsp;&nbsp;&nbsp; /* V_Total =
*/<BR>+&nbsp;&nbsp;&nbsp; 600,&nbsp;&nbsp;&nbsp; /* V_Display_End =
*/<BR>+&nbsp;&nbsp;&nbsp; 600,&nbsp;&nbsp;&nbsp; /* V_Blanking_Start =
*/<BR>+&nbsp;&nbsp;&nbsp; 200,&nbsp;&nbsp;&nbsp; /* V_Blanking_End =
*/<BR>+&nbsp;&nbsp;&nbsp; 606,&nbsp;&nbsp;&nbsp; /* V_Sync_Start =
*/<BR>+&nbsp;&nbsp;&nbsp; 15&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* V_Sync_End =
*/<BR>+};<BR>+<BR>+<BR>+unsigned long ITV_MODE_TABLE_PAL_1024x768[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; /* Src Buffer Line Pitch. */&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; =
0x00770800,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 14-17 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Src Image Size and Position. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x09DFFAFF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 18-1B */<BR>+&nbsp;&nbsp;&nbsp; =
0x13FF02FF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 20-23 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Scaling Factor and De-Flicker. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x66704C2A,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 24-27 =
*/&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Dst Image Size. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x2013D9F8,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 28-2B =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Dst Buffer Line Pitch &amp; DQWord. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x008E0800,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 34-37 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Encoder Control. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xC048A214,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 38-3B */<BR>+&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; /* Encoder CRTC. */<BR>+&nbsp;&nbsp;&nbsp; =
0x427F06BF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 3C-3F */<BR>+&nbsp;&nbsp;&nbsp; =
0x00EF00B2,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 40-43 */<BR>+&nbsp;&nbsp;&nbsp; =
0x06990120,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 44-47 */<BR>+&nbsp;&nbsp;&nbsp; =
0x01200010,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 48-4B */<BR>+&nbsp;&nbsp;&nbsp; =
0x0A0680C0,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 4C-4F */<BR>+&nbsp;&nbsp;&nbsp; =
0x489608D3,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 50-53 */<BR>+&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; /* Luma Data */<BR>+&nbsp;&nbsp;&nbsp; =
0x001C0090,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 54-57 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0x2A08D01C,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 58-5B =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Burst and Sync Shape =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x01081011,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 5C-5F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Hue and Sub-Carrier =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x00120000,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 60-63 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* TVCLK PLL */<BR>+&nbsp;&nbsp;&nbsp; =
INTEGRATED_TVCLK_54MHZ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* E0-E3 =
*/<BR>+};<BR>+<BR>+unsigned long ITV_CRTC_TABLE_PAL_1024x768[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 1200,&nbsp;&nbsp; /* H_Total =
*/<BR>+&nbsp;&nbsp;&nbsp; 1024,&nbsp;&nbsp; /* H_Display_End =
*/<BR>+&nbsp;&nbsp;&nbsp; 1024,&nbsp;&nbsp; /* H_Blanking_Start =
*/<BR>+&nbsp;&nbsp;&nbsp; 176,&nbsp;&nbsp;&nbsp; /* H_Blanking_End =
*/<BR>+&nbsp;&nbsp;&nbsp; 1048,&nbsp;&nbsp; /* H_Sync_Start =
*/<BR>+&nbsp;&nbsp;&nbsp; 16,&nbsp;&nbsp;&nbsp;&nbsp; /* H_Sync_End =
*/<BR>+&nbsp;&nbsp;&nbsp; 900,&nbsp;&nbsp;&nbsp; /* V_Total =
*/<BR>+&nbsp;&nbsp;&nbsp; 768,&nbsp;&nbsp;&nbsp; /* V_Display_End =
*/<BR>+&nbsp;&nbsp;&nbsp; 768,&nbsp;&nbsp;&nbsp; /* V_Blanking_Start =
*/<BR>+&nbsp;&nbsp;&nbsp; 132,&nbsp;&nbsp;&nbsp; /* V_Blanking_End =
*/<BR>+&nbsp;&nbsp;&nbsp; 800,&nbsp;&nbsp;&nbsp; /* V_Sync_Start =
*/<BR>+&nbsp;&nbsp;&nbsp; 6&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
V_Sync_End =
*/<BR>+};<BR>+<BR>+/*****************************************************=
*********************************/<BR>+/*********************************=
**** HDTV: 720P =
*************************************/<BR>+/*****************************=
*********************************************************/<BR>+unsigned =
long ITV_MODE_TABLE_720P_1280x720[] =3D {<BR>+&nbsp;&nbsp;&nbsp; /* Src =
Buffer Line Pitch. */&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; =
0x00770A00,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 14-17 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Src Image Size and Position. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x09E7FACF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 18-1B */<BR>+&nbsp;&nbsp;&nbsp; =
0x24FF02CF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 20-23 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Scaling Factor and De-Flicker. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x045A27FF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 24-27 =
*/&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Dst Image Size. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x2827FACF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 28-2B =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Dst Buffer Line Pitch &amp; DQWord. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x00770A00,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 34-37 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Encoder Control. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xC0E0A214,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 38-3B =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Encoder CRTC. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x42280671,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 3C-3F */<BR>+&nbsp;&nbsp;&nbsp; =
0x00000000,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 40-43 */<BR>+&nbsp;&nbsp;&nbsp; =
0x062C0117,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 44-47 */<BR>+&nbsp;&nbsp;&nbsp; =
0x000C592C,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 48-4B */<BR>+&nbsp;&nbsp;&nbsp; =
0x0608527D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 4C-4F */<BR>+&nbsp;&nbsp;&nbsp; =
0x48CD18CD,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 50-53 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Luma Data */<BR>+&nbsp;&nbsp;&nbsp; =
0x009CA891,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 54-57 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0x21F02016,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 58-5B =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Burst and Sync Shape =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x00F0102F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 5C-5F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Hue and Sub-Carrier =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x00000000,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 60-63 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* TVCLK PLL */<BR>+&nbsp;&nbsp;&nbsp; =
INTEGRATED_TVCLK_74_25MHZ&nbsp;&nbsp; /* E0-E3 =
*/<BR>+};<BR>+<BR>+unsigned long ITV_CRTC_TABLE_720P_1280x720[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 1650,&nbsp;&nbsp; /* =
H_Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 1280,&nbsp;&nbsp; /* =
H_Display_End&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
1280,&nbsp;&nbsp; /* H_Blanking_Start */<BR>+&nbsp;&nbsp;&nbsp; =
370,&nbsp;&nbsp;&nbsp; /* H_Blanking_End&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 1296,&nbsp;&nbsp; /* =
H_Sync_Start&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
48,&nbsp;&nbsp;&nbsp;&nbsp; /* =
H_Sync_End&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
750,&nbsp;&nbsp;&nbsp; /* =
V_Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 720,&nbsp;&nbsp;&nbsp; /* =
V_Display_End&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
720,&nbsp;&nbsp;&nbsp; /* V_Blanking_Start */<BR>+&nbsp;&nbsp;&nbsp; =
30,&nbsp;&nbsp;&nbsp;&nbsp; /* V_Blanking_End&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 721,&nbsp;&nbsp;&nbsp; /* =
V_Sync_Start&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
V_Sync_End&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+};<BR>+<BR>+unsigned long ITV_CRTC_TABLE_720P_640x480[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 900,&nbsp;&nbsp;&nbsp; /* =
H_Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 640,&nbsp;&nbsp;&nbsp; /* =
H_Display_End&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
640,&nbsp;&nbsp;&nbsp; /* H_Blanking_Start */<BR>+&nbsp;&nbsp;&nbsp; =
260,&nbsp;&nbsp;&nbsp; /* H_Blanking_End&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 656,&nbsp;&nbsp;&nbsp; /* =
H_Sync_Start&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
72,&nbsp;&nbsp;&nbsp;&nbsp; /* =
H_Sync_End&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
500,&nbsp;&nbsp;&nbsp; /* =
V_Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 480,&nbsp;&nbsp;&nbsp; /* =
V_Display_End&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
480,&nbsp;&nbsp;&nbsp; /* V_Blanking_Start */<BR>+&nbsp;&nbsp;&nbsp; =
20,&nbsp;&nbsp;&nbsp;&nbsp; /* V_Blanking_End&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 481,&nbsp;&nbsp;&nbsp; /* =
V_Sync_Start&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
V_Sync_End&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+};<BR>+<BR>+unsigned long ITV_CRTC_TABLE_720P_720x480[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 900,&nbsp;&nbsp;&nbsp; /* =
H_Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 720,&nbsp;&nbsp;&nbsp; /* =
H_Display_End&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
720,&nbsp;&nbsp;&nbsp; /* H_Blanking_Start */<BR>+&nbsp;&nbsp;&nbsp; =
180,&nbsp;&nbsp;&nbsp; /* H_Blanking_End&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 736,&nbsp;&nbsp;&nbsp; /* =
H_Sync_Start&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
72,&nbsp;&nbsp;&nbsp;&nbsp; /* =
H_Sync_End&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
500,&nbsp;&nbsp;&nbsp; /* =
V_Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 480,&nbsp;&nbsp;&nbsp; /* =
V_Display_End&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
480,&nbsp;&nbsp;&nbsp; /* V_Blanking_Start */<BR>+&nbsp;&nbsp;&nbsp; =
20,&nbsp;&nbsp;&nbsp;&nbsp; /* V_Blanking_End&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 481,&nbsp;&nbsp;&nbsp; /* =
V_Sync_Start&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
V_Sync_End&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+};<BR>+<BR>+unsigned long ITV_CRTC_TABLE_720P_720x576[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 1440,&nbsp;&nbsp; /* =
H_Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 720,&nbsp;&nbsp;&nbsp; /* =
H_Display_End&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
720,&nbsp;&nbsp;&nbsp; /* H_Blanking_Start */<BR>+&nbsp;&nbsp;&nbsp; =
720,&nbsp;&nbsp;&nbsp; /* H_Blanking_End&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 736,&nbsp;&nbsp;&nbsp; /* =
H_Sync_Start&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
80,&nbsp;&nbsp;&nbsp;&nbsp; /* =
H_Sync_End&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
625,&nbsp;&nbsp;&nbsp; /* =
V_Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 576,&nbsp;&nbsp;&nbsp; /* =
V_Display_End&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
576,&nbsp;&nbsp;&nbsp; /* V_Blanking_Start */<BR>+&nbsp;&nbsp;&nbsp; =
49,&nbsp;&nbsp;&nbsp;&nbsp; /* V_Blanking_End&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 577,&nbsp;&nbsp;&nbsp; /* =
V_Sync_Start&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
V_Sync_End&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+};<BR>+<BR>+unsigned long ITV_CRTC_TABLE_720P_800x600[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 1440,&nbsp;&nbsp; /* =
H_Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 800,&nbsp;&nbsp;&nbsp; /* =
H_Display_End&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
800,&nbsp;&nbsp;&nbsp; /* H_Blanking_Start */<BR>+&nbsp;&nbsp;&nbsp; =
640,&nbsp;&nbsp;&nbsp; /* H_Blanking_End&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 840,&nbsp;&nbsp;&nbsp; /* =
H_Sync_Start&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
136,&nbsp;&nbsp;&nbsp; /* H_Sync_End&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 625,&nbsp;&nbsp;&nbsp; /* =
V_Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 600,&nbsp;&nbsp;&nbsp; /* =
V_Display_End&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
600,&nbsp;&nbsp;&nbsp; /* V_Blanking_Start */<BR>+&nbsp;&nbsp;&nbsp; =
25,&nbsp;&nbsp;&nbsp;&nbsp; /* V_Blanking_End&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 606,&nbsp;&nbsp;&nbsp; /* =
V_Sync_Start&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
15&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
V_Sync_End&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+};<BR>+<BR>+unsigned long ITV_CRTC_TABLE_720P_1024x768[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 1250,&nbsp;&nbsp; /* =
H_Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 1024,&nbsp;&nbsp; /* =
H_Display_End&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
1024,&nbsp;&nbsp; /* H_Blanking_Start */<BR>+&nbsp;&nbsp;&nbsp;&nbsp; =
226,&nbsp;&nbsp; /* H_Blanking_End&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
1064,&nbsp;&nbsp; /* H_Sync_Start&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp; 120,&nbsp;&nbsp; /* =
H_Sync_End&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp; 880,&nbsp;&nbsp; /* =
V_Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp; 768,&nbsp;&nbsp; /* =
V_Display_End&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp;&nbsp; =
768,&nbsp;&nbsp; /* V_Blanking_Start */<BR>+&nbsp;&nbsp;&nbsp;&nbsp; =
112,&nbsp;&nbsp; /* V_Blanking_End&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp; 774,&nbsp;&nbsp; /* =
V_Sync_Start&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3&nbsp;&nbsp;&nbsp; /* =
V_Sync_End&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+};<BR>+<BR>+/*****************************************************=
*********************************/<BR>+/*********************************=
**** HDTV: 1080I =
*************************************/<BR>+/*****************************=
*********************************************************/<BR>+unsigned =
long ITV_MODE_TABLE_1080I_1920x1080[] =3D {<BR>+&nbsp;&nbsp;&nbsp; /* =
Src Buffer Line Pitch. */&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; =
0x00770F00,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 14-17 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Src Image Size and Position. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x09FBFC37,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 18-1B */<BR>+&nbsp;&nbsp;&nbsp; =
0x277F0437,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 20-23 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Scaling Factor and De-Flicker. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x68002803,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 24-27 =
*/&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Dst Image Size. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x3C3BFC37,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 28-2B =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Dst Buffer Line Pitch &amp; DQWord. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x00770F00,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 34-37 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Encoder Control. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xC0D0A214,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 38-3B =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Encoder CRTC. =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x422C0897,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 3C-3F */<BR>+&nbsp;&nbsp;&nbsp; =
0x00000000,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 40-43 */<BR>+&nbsp;&nbsp;&nbsp; =
0x087100EC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 44-47 */<BR>+&nbsp;&nbsp;&nbsp; =
0x000840B0,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 48-4B */<BR>+&nbsp;&nbsp;&nbsp; =
0x0506B1E2,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 4C-4F */<BR>+&nbsp;&nbsp;&nbsp; =
0x48B208F7,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 50-53 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Luma Data */<BR>+&nbsp;&nbsp;&nbsp; =
0x00A0A0A5,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 54-57 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0x21F02016,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 58-5B =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Burst and Sync Shape =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x01281010,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 5C-5F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Hue and Sub-Carrier =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x00000000,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 60-63 */<BR>+&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; /* TVCLK PLL */<BR>+&nbsp;&nbsp;&nbsp; =
INTEGRATED_TVCLK_148_5MHZ&nbsp;&nbsp; /* E0-E3 =
*/<BR>+};<BR>+<BR>+unsigned long ITV_CRTC_TABLE_1080I_1920x1080[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 2200,&nbsp;&nbsp; /* =
H_Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */ =
<BR>+&nbsp;&nbsp;&nbsp; 1920,&nbsp;&nbsp; /* =
H_Display_End&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
1920,&nbsp;&nbsp; /* H_Blanking_Start */<BR>+&nbsp;&nbsp;&nbsp; =
280,&nbsp;&nbsp;&nbsp; /* H_Blanking_End&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 1960,&nbsp;&nbsp; /* =
H_Sync_Start&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
104,&nbsp;&nbsp;&nbsp; /* H_Sync_End&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 1125,&nbsp;&nbsp; /* =
V_Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 1080,&nbsp;&nbsp; /* =
V_Display_End&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
1080,&nbsp;&nbsp; /* V_Blanking_Start */<BR>+&nbsp;&nbsp;&nbsp; =
45,&nbsp;&nbsp;&nbsp;&nbsp; /* V_Blanking_End&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 1083,&nbsp;&nbsp; /* =
V_Sync_Start&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
V_Sync_End&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+};<BR>+<BR>+unsigned long ITV_CRTC_TABLE_1080I_640x480[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 900,&nbsp;&nbsp;&nbsp; /* =
H_Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 640,&nbsp;&nbsp;&nbsp; /* =
H_Display_End&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
640,&nbsp;&nbsp;&nbsp; /* H_Blanking_Start */<BR>+&nbsp;&nbsp;&nbsp; =
260,&nbsp;&nbsp;&nbsp; /* H_Blanking_End&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 656,&nbsp;&nbsp;&nbsp; /* =
H_Sync_Start&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
72,&nbsp;&nbsp;&nbsp;&nbsp; /* =
H_Sync_End&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
500,&nbsp;&nbsp;&nbsp; /* =
V_Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 480,&nbsp;&nbsp;&nbsp; /* =
V_Display_End&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
480,&nbsp;&nbsp;&nbsp; /* V_Blanking_Start */<BR>+&nbsp;&nbsp;&nbsp; =
20,&nbsp;&nbsp;&nbsp;&nbsp; /* V_Blanking_End&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 481,&nbsp;&nbsp;&nbsp; /* =
V_Sync_Start&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
V_Sync_End&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+};<BR>+<BR>+unsigned long ITV_CRTC_TABLE_1080I_720x480[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 900,&nbsp;&nbsp;&nbsp; /* =
H_Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 720,&nbsp;&nbsp;&nbsp; /* =
H_Display_End&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
720,&nbsp;&nbsp;&nbsp; /* H_Blanking_Start */<BR>+&nbsp;&nbsp;&nbsp; =
180,&nbsp;&nbsp;&nbsp; /* H_Blanking_End&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 736,&nbsp;&nbsp;&nbsp; /* =
H_Sync_Start&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
96,&nbsp;&nbsp;&nbsp;&nbsp; /* =
H_Sync_End&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
500,&nbsp;&nbsp;&nbsp; /* =
V_Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 480,&nbsp;&nbsp;&nbsp; /* =
V_Display_End&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
480,&nbsp;&nbsp;&nbsp; /* V_Blanking_Start */<BR>+&nbsp;&nbsp;&nbsp; =
20,&nbsp;&nbsp;&nbsp;&nbsp; /* V_Blanking_End&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 485,&nbsp;&nbsp;&nbsp; /* =
V_Sync_Start&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
6&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
V_Sync_End&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+};<BR>+<BR>+unsigned long ITV_CRTC_TABLE_1080I_720x576[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 1440,&nbsp;&nbsp; /* =
H_Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 720,&nbsp;&nbsp;&nbsp; /* =
H_Display_End&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
720,&nbsp;&nbsp;&nbsp; /* H_Blanking_Start */<BR>+&nbsp;&nbsp;&nbsp; =
720,&nbsp;&nbsp;&nbsp; /* H_Blanking_End&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 736,&nbsp;&nbsp;&nbsp; /* =
H_Sync_Start&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
96,&nbsp;&nbsp;&nbsp;&nbsp; /* =
H_Sync_End&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
625,&nbsp;&nbsp;&nbsp; /* =
V_Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 576,&nbsp;&nbsp;&nbsp; /* =
V_Display_End&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
576,&nbsp;&nbsp;&nbsp; /* V_Blanking_Start */<BR>+&nbsp;&nbsp;&nbsp; =
49,&nbsp;&nbsp;&nbsp;&nbsp; /* V_Blanking_End&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 577,&nbsp;&nbsp;&nbsp; /* =
V_Sync_Start&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
V_Sync_End&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+};<BR>+<BR>+unsigned long ITV_CRTC_TABLE_1080I_800x600[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 1440,&nbsp;&nbsp; /* =
H_Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */ =
<BR>+&nbsp;&nbsp;&nbsp; 800,&nbsp;&nbsp;&nbsp; /* =
H_Display_End&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
800,&nbsp;&nbsp;&nbsp; /* H_Blanking_Start */<BR>+&nbsp;&nbsp;&nbsp; =
640,&nbsp;&nbsp;&nbsp; /* H_Blanking_End&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 824,&nbsp;&nbsp;&nbsp; /* =
H_Sync_Start&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
56,&nbsp;&nbsp;&nbsp;&nbsp; /* =
H_Sync_End&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
625,&nbsp;&nbsp;&nbsp; /* =
V_Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 600,&nbsp;&nbsp;&nbsp; /* =
V_Display_End&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
600,&nbsp;&nbsp;&nbsp; /* V_Blanking_Start */<BR>+&nbsp;&nbsp;&nbsp; =
25,&nbsp;&nbsp;&nbsp;&nbsp; /* V_Blanking_End&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 605,&nbsp;&nbsp;&nbsp; /* =
V_Sync_Start&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
6&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
V_Sync_End&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+};<BR>+<BR>+unsigned long ITV_CRTC_TABLE_1080I_1024x768[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 1250,&nbsp;&nbsp; /* =
H_Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */ =
<BR>+&nbsp;&nbsp;&nbsp; 1024,&nbsp;&nbsp; /* =
H_Display_End&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
1024,&nbsp;&nbsp; /* H_Blanking_Start */<BR>+&nbsp;&nbsp;&nbsp; =
226,&nbsp;&nbsp;&nbsp; /* H_Blanking_End&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 1032,&nbsp;&nbsp; /* =
H_Sync_Start&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
64,&nbsp;&nbsp;&nbsp;&nbsp; /* =
H_Sync_End&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
792,&nbsp;&nbsp;&nbsp; /* =
V_Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 768,&nbsp;&nbsp;&nbsp; /* =
V_Display_End&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
768,&nbsp;&nbsp;&nbsp; /* V_Blanking_Start */<BR>+&nbsp;&nbsp;&nbsp; =
24,&nbsp;&nbsp;&nbsp;&nbsp; /* V_Blanking_End&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 770,&nbsp;&nbsp;&nbsp; /* =
V_Sync_Start&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
V_Sync_End&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+};<BR>+<BR>+unsigned long ITV_NULL_TABLE[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 0xFFFF<BR>+};<BR>+<BR>+<BR>+struct =
integrated_tv_mode_table ITV_MODE_TABLE[] =3D {<BR>+&nbsp;&nbsp;&nbsp; =
{VIA_RES_640X480,&nbsp;&nbsp; ITV_MODE_TABLE_NTSC_640x480,&nbsp; =
ITV_MODE_TABLE_PAL_640x480,&nbsp; ITV_MODE_TABLE_720P_1280x720, =
ITV_MODE_TABLE_1080I_1920x1080},<BR>+&nbsp;&nbsp;&nbsp; =
{VIA_RES_720X480,&nbsp;&nbsp; ITV_MODE_TABLE_NTSC_720x480,&nbsp; =
ITV_MODE_TABLE_NTSC_720x480, ITV_MODE_TABLE_720P_1280x720, =
ITV_MODE_TABLE_1080I_1920x1080},<BR>+&nbsp;&nbsp;&nbsp; =
{VIA_RES_720X576,&nbsp;&nbsp; ITV_MODE_TABLE_PAL_720x576,&nbsp;&nbsp; =
ITV_MODE_TABLE_PAL_720x576,&nbsp; ITV_MODE_TABLE_720P_1280x720, =
ITV_MODE_TABLE_1080I_1920x1080},<BR>+&nbsp;&nbsp;&nbsp; =
{VIA_RES_800X600,&nbsp;&nbsp; ITV_MODE_TABLE_NTSC_800x600,&nbsp; =
ITV_MODE_TABLE_PAL_800x600,&nbsp; ITV_MODE_TABLE_720P_1280x720, =
ITV_MODE_TABLE_1080I_1920x1080},<BR>+&nbsp;&nbsp;&nbsp; =
{VIA_RES_1024X768,&nbsp; ITV_MODE_TABLE_NTSC_1024x768, =
ITV_MODE_TABLE_PAL_1024x768, ITV_MODE_TABLE_720P_1280x720, =
ITV_MODE_TABLE_1080I_1920x1080},<BR>+&nbsp;&nbsp;&nbsp; =
{VIA_RES_1280X720,&nbsp; =
ITV_NULL_TABLE,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; =
ITV_NULL_TABLE,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; ITV_MODE_TABLE_720P_1280x720, =
ITV_NULL_TABLE},<BR>+&nbsp;&nbsp;&nbsp; {VIA_RES_1920X1080, =
ITV_NULL_TABLE,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; =
ITV_NULL_TABLE,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; =
ITV_NULL_TABLE,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; =
ITV_MODE_TABLE_1080I_1920x1080}<BR>+};<BR>+<BR>+<BR>+struct =
integrated_tv_mode_table ITV_CRTC_TABLE[] =3D {<BR>+&nbsp;&nbsp;&nbsp; =
{VIA_RES_640X480,&nbsp;&nbsp; ITV_CRTC_TABLE_NTSC_640x480,&nbsp; =
ITV_CRTC_TABLE_PAL_640x480,&nbsp; ITV_CRTC_TABLE_720P_640x480,&nbsp; =
ITV_CRTC_TABLE_1080I_640x480},<BR>+&nbsp;&nbsp;&nbsp; =
{VIA_RES_720X480,&nbsp;&nbsp; ITV_CRTC_TABLE_NTSC_720x480,&nbsp; =
ITV_CRTC_TABLE_NTSC_720x480, ITV_CRTC_TABLE_720P_720x480,&nbsp; =
ITV_CRTC_TABLE_1080I_720x480},<BR>+&nbsp;&nbsp;&nbsp; =
{VIA_RES_720X576,&nbsp;&nbsp; ITV_CRTC_TABLE_PAL_720x576,&nbsp;&nbsp; =
ITV_CRTC_TABLE_PAL_720x576,&nbsp; ITV_CRTC_TABLE_720P_720x576,&nbsp; =
ITV_CRTC_TABLE_1080I_720x576},<BR>+&nbsp;&nbsp;&nbsp; =
{VIA_RES_800X600,&nbsp;&nbsp; ITV_CRTC_TABLE_NTSC_800x600,&nbsp; =
ITV_CRTC_TABLE_PAL_800x600,&nbsp; ITV_CRTC_TABLE_720P_800x600,&nbsp; =
ITV_CRTC_TABLE_1080I_800x600},<BR>+&nbsp;&nbsp;&nbsp; =
{VIA_RES_1024X768,&nbsp; ITV_CRTC_TABLE_NTSC_1024x768, =
ITV_CRTC_TABLE_PAL_1024x768, ITV_CRTC_TABLE_720P_1024x768, =
ITV_CRTC_TABLE_1080I_1024x768},<BR>+&nbsp;&nbsp;&nbsp; =
{VIA_RES_1280X720,&nbsp; =
ITV_NULL_TABLE,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; =
ITV_NULL_TABLE,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; ITV_CRTC_TABLE_720P_1280x720, =
ITV_NULL_TABLE},<BR>+&nbsp;&nbsp;&nbsp; {VIA_RES_1920X1080, =
ITV_NULL_TABLE,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; =
ITV_NULL_TABLE,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; =
ITV_NULL_TABLE,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; =
ITV_CRTC_TABLE_1080I_1920x1080}<BR>+};<BR>+<BR>+<BR>+#define =
NUM_TOTAL_INTEGRATEDTV_MODE_TABLE =
ARRAY_SIZE(ITV_MODE_TABLE)<BR>+<BR>+/************************************=
**************************************************/<BR>+/****************=
****************** Patch Table for RGB =
*******************************/<BR>+/***********************************=
***************************************************/<BR>+unsigned short =
ITV_PATCH_TABLE_RGB_NTSC[] =3D {<BR>+&nbsp;&nbsp;&nbsp; =
0xE342,&nbsp;&nbsp;&nbsp;&nbsp; /* BST_ED&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x8D46,&nbsp;&nbsp;&nbsp;&nbsp; /* =
VID_ED&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x404A,&nbsp;&nbsp;&nbsp;&nbsp; /* HSD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x7F50,&nbsp;&nbsp;&nbsp;&nbsp; /* =
VR_GAIN&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x1851,&nbsp;&nbsp;&nbsp;&nbsp; =
/* SC_ON_VR */<BR>+&nbsp;&nbsp;&nbsp; 0x7C52,&nbsp;&nbsp;&nbsp;&nbsp; /* =
UB_GAIN&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x5853,&nbsp;&nbsp;&nbsp;&nbsp; =
/* SC_ON_UB */<BR>+&nbsp;&nbsp;&nbsp; 0x7254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
YG_GAIN&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x165C,&nbsp;&nbsp;&nbsp;&nbsp; =
/* SYNC_SP&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x285E,&nbsp;&nbsp;&nbsp;&nbsp; /* BRST_AMP */<BR>+&nbsp;&nbsp;&nbsp; =
0x015F,&nbsp;&nbsp;&nbsp;&nbsp; /* BRST_AMP */<BR>+&nbsp;&nbsp;&nbsp; =
0xffff<BR>+};<BR>+<BR>+unsigned short ITV_PATCH_TABLE_RGB_PAL[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 0xF442,&nbsp;&nbsp;&nbsp;&nbsp; /* =
BST_ED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x1E44,&nbsp;&nbsp;&nbsp;&nbsp; /* =
VID_ST&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x004A,&nbsp;&nbsp;&nbsp;&nbsp; /* =
HSD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x9C50,&nbsp;&nbsp;&nbsp;&nbsp; /* =
VR_GAIN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x9852,&nbsp;&nbsp;&nbsp;&nbsp; /* UB_GAIN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0xA554,&nbsp;&nbsp;&nbsp;&nbsp; /* =
YG_GAIN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0xA055,&nbsp;&nbsp;&nbsp;&nbsp; /* Blank Level&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x285E,&nbsp;&nbsp;&nbsp;&nbsp; /* =
BRST_AMP&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0xffff<BR>+};<BR>+<BR>+<BR>+/********************************************=
******************************************/<BR>+/************************=
******** Patch Table for YPbPr =
*******************************/<BR>+/***********************************=
***************************************************/<BR>+unsigned short =
ITV_PATCH_TABLE_YPBPR_NTSC[] =3D {<BR>+&nbsp;&nbsp;&nbsp; =
0xE342,&nbsp;&nbsp;&nbsp;&nbsp; /* =
BST_ED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x8D46,&nbsp;&nbsp;&nbsp;&nbsp; /* =
VID_ED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x404A,&nbsp;&nbsp;&nbsp;&nbsp; /* =
HSD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x9750,&nbsp;&nbsp;&nbsp;&nbsp; /* =
VR_GAIN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x9952,&nbsp;&nbsp;&nbsp;&nbsp; /* UB_GAIN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x8B54,&nbsp;&nbsp;&nbsp;&nbsp; /* =
YG_GAIN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x0057,&nbsp;&nbsp;&nbsp;&nbsp; /* Blank Level&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x285E,&nbsp;&nbsp;&nbsp;&nbsp; /* =
BRST_AMP&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x015F,&nbsp;&nbsp;&nbsp;&nbsp; /* BRST_AMP&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x76E8,<BR>+&nbsp;&nbsp;&nbsp; =
0xffff<BR>+};<BR>+<BR>+unsigned short ITV_PATCH_TABLE_YPBPR_PAL[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 0xF442,&nbsp;&nbsp;&nbsp;&nbsp; /* =
BST_ED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x1E44,&nbsp;&nbsp;&nbsp;&nbsp; /* =
VID_ST&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x9C46,&nbsp;&nbsp;&nbsp;&nbsp; /* =
VID_ED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x004A,&nbsp;&nbsp;&nbsp;&nbsp; /* =
HSD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x9C50,&nbsp;&nbsp;&nbsp;&nbsp; /* =
VR_GAIN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x9852,&nbsp;&nbsp;&nbsp;&nbsp; /* UB_GAIN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x285E,&nbsp;&nbsp;&nbsp;&nbsp; /* =
BRST_AMP&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0xffff<BR>+};<BR>+<BR>+<BR>+<BR>+/***************************************=
***********************************************/<BR>+/*******************=
************* Patch Table for 480P =
********************************/<BR>+/**********************************=
****************************************************/<BR>+unsigned short =
ITV_PATCH_TABLE_480P_640x480[] =3D {<BR>+&nbsp;&nbsp;&nbsp; 0xC424, =
0x0825, 0xE526, 0x0327,&nbsp;&nbsp;&nbsp;&nbsp; /* Scaling =
Factor&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0xB528, 0x0129, =
0x292A,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* DST H/V =
size&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x803A,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV's =
Standard&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x0040, =
0x0042,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* BST_ST, =
BST_ED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0xFE44, 0x0045, =
0x8F46,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* VID_ST, =
VID_ED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x404A,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
HSD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0xCC4C, 0x814D, =
0x0F4F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* HP, VP, =
VSD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x6B50, =
0x6B52,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Chroma =
Ctrl&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x9054, 0xA055, 0x1C56, =
0x0057,&nbsp;&nbsp;&nbsp;&nbsp; /* Luma =
Ctrl&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x175C, 0x005D, =
0x005E, 0x005F,&nbsp;&nbsp;&nbsp;&nbsp; /* Burst and Sync Shape Ctrl =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x83E2,<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF<BR>+};<BR>+<BR>+unsigned short ITV_PATCH_TABLE_480P_720x480[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 0xC424, 0x0825, 0x6226, =
0x0427,&nbsp;&nbsp;&nbsp;&nbsp; /* Scaling =
Factor&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0xB528, 0x0129, =
0xA92A,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* DST H/V =
size&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x803A,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV's =
Standard&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x0040, =
0x0042,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* BST_ST, =
BST_ED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0xFE44, 0x0045, =
0x8F46,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* VID_ST, =
VID_ED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x404A,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
HSD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0xA74C, 0x814D, =
0x0F4F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* HP, VP, =
VSD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x6B50, =
0x6B52,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Chroma =
Ctrl&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x9054, 0xA055, 0x1C56, =
0x0057,&nbsp;&nbsp;&nbsp;&nbsp; /* Luma =
Ctrl&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x175C, 0x005D, =
0x005E, 0x005F,&nbsp;&nbsp;&nbsp;&nbsp; /* Burst and Sync Shape Ctrl =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x83E2,<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF<BR>+};<BR>+<BR>+unsigned short ITV_PATCH_TABLE_480P_800x600[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 0xF624, 0x0A25, 0xDF26, =
0x0427,&nbsp;&nbsp;&nbsp;&nbsp; /* Scaling =
Factor&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0xB528, 0x0129, =
0x292A,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* DST H/V =
size&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x8436,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
DST_BUF_LINE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x803A,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV's =
Standard&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x0040, =
0x0042,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* BST_ST, =
BST_ED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0xFE44, 0x0045, =
0x8F46,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* VID_ST, =
VID_ED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x404A,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
HSD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0xA04C, 0x814D, =
0x0F4F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* HP, VP, =
VSD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x6B50, =
0x6B52,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Chroma =
Ctrl&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x9054, 0xA055, 0x1C56, =
0x0057,&nbsp;&nbsp;&nbsp;&nbsp; /* Luma =
Ctrl&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x175C, 0x005D, =
0x005E, 0x005F,&nbsp;&nbsp;&nbsp;&nbsp; /* Burst and Sync Shape Ctrl =
*/<BR>+&nbsp;&nbsp;&nbsp; 0xC3E2,<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF<BR>+};<BR>+<BR>+unsigned short ITV_PATCH_TABLE_480P_1024x768[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; 0x0A24, 0x4126, =
0x0627,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* Scaling =
Factor&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0xB528, 0xE129, =
0x282A,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* DST H/V =
size&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x803A,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV's =
Standard&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x0040, =
0x0042,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* BST_ST, =
BST_ED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0xFE44, 0x0045, =
0x8F46,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* VID_ST, =
VID_ED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x404A,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
HSD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0xD44C, 0x814D, =
0x0F4F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* HP, VP, =
VSD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x6B50, =
0x6B52,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Chroma =
Ctrl&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x9054, 0xA055, 0x1C56, =
0x0057,&nbsp;&nbsp;&nbsp;&nbsp; /* Luma =
Ctrl&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x175C, 0x005D, =
0x005E, 0x005F,&nbsp;&nbsp;&nbsp;&nbsp; /* Burst and Sync Shape Ctrl =
*/<BR>+&nbsp;&nbsp;&nbsp; 0xC3E2,<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF<BR>+};<BR>+<BR>+<BR>+/********************************************=
******************************************/<BR>+/************************=
******** Patch Table for 576P =
********************************/<BR>+/**********************************=
****************************************************/<BR>+unsigned short =
ITV_PATCH_TABLE_576P_640x480[] =3D {<BR>+&nbsp;&nbsp;&nbsp; 0x6924, =
0xF726, =
0x0327,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* Scaling =
Factor&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0528, 0x3A29, =
0x282A,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* DST H/V =
size&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x883A,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV's =
Standard&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0xF442,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* BST_ST, =
BST_ED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x2144, =
0x9C46,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* VID_ST, =
VID_ED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x0048,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
BRD_ST&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x104C, 0x824D, =
0x124F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* HP, VP, =
VSD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x9050, =
0x9052,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Chroma =
Ctrl&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x8F54, =
0xA055,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Luma =
Ctrl&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x105C, 0x005E, =
0x005F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* Burst and Sync Shape Ctrl */<BR>+&nbsp;&nbsp;&nbsp; =
0x83E2,<BR>+&nbsp;&nbsp;&nbsp; 0xFFFF<BR>+};<BR>+<BR>+unsigned short =
ITV_PATCH_TABLE_576P_720x576[] =3D {<BR>+&nbsp;&nbsp;&nbsp; 0xE524, =
0x0825, 0x7826, 0x0427,&nbsp;&nbsp;&nbsp;&nbsp; /* Scaling =
Factor&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0528, 0x3A29, =
0xA82A,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* DST H/V =
size&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x883A,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV's =
Standard&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0xF442,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* BST_ST, =
BST_ED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x2144, =
0x9C46,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* VID_ST, =
VID_ED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x0048,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
BRD_ST&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x104C, 0x824D, =
0x124F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* HP, VP, =
VSD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x9050, =
0x9052,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Chroma =
Ctrl&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x8F54, =
0xA055,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Luma =
Ctrl&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x105C, 0x005E, =
0x005F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* Burst and Sync Shape Ctrl */<BR>+&nbsp;&nbsp;&nbsp; =
0x83E2,<BR>+&nbsp;&nbsp;&nbsp; 0xFFFF<BR>+};<BR>+<BR>+unsigned short =
ITV_PATCH_TABLE_576P_800x600[] =3D {<BR>+&nbsp;&nbsp;&nbsp; 0x4424, =
0xF726, =
0x0427,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* Scaling =
Factor&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0528, 0x3A29, =
0x282A,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* DST H/V =
size&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x0F36, =
0x0137,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
DST_BUF_LINE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x883A,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV's =
Standard&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0xF442,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* BST_ST, =
BST_ED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x2144, =
0x9C46,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* VID_ST, =
VID_ED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x0048,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
BRD_ST&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0xA04C, 0x814D, =
0x124F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* HP, VP, =
VSD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x9050, =
0x9052,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Chroma =
Ctrl&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x8F54, =
0xA055,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Luma =
Ctrl&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x105C, 0x005E, =
0x005F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* Burst and Sync Shape Ctrl */<BR>+&nbsp;&nbsp;&nbsp; =
0xC3E2,<BR>+&nbsp;&nbsp;&nbsp; 0xFFFF<BR>+};<BR>+<BR>+unsigned short =
ITV_PATCH_TABLE_576P_1024x768[] =3D {<BR>+&nbsp;&nbsp;&nbsp; 0xEA24, =
0x0B25, 0x5D26, 0x0627,&nbsp;&nbsp;&nbsp;&nbsp; /* Scaling =
Factor&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0328, 0x3A29, =
0x282A,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* DST H/V =
size&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x883A,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV's =
Standard&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x0040, =
0x0042,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* BST_ST, =
BST_ED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x2144, =
0x9C46,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* VID_ST, =
VID_ED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x0048,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
BRD_ST&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x204C, 0x824D, =
0x124F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* HP, VP, =
VSD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x9050, =
0x9052,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Chroma =
Ctrl&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x9054, =
0xA055,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Luma =
Ctrl&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x105C, 0x005E, =
0x005F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* Burst and Sync Shape Ctrl */<BR>+&nbsp;&nbsp;&nbsp; =
0xC3E2,<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF<BR>+};<BR>+<BR>+/*************************************************=
*************************************/<BR>+/*****************************=
*** Patch Table for 720P =
********************************/<BR>+/**********************************=
****************************************************/<BR>+unsigned short =
ITV_PATCH_TABLE_720P_640x480[] =3D {<BR>+&nbsp;&nbsp;&nbsp; 0x0515, =
0xDF18, 0xF919,<BR>+&nbsp;&nbsp;&nbsp; 0xD31A, 0xDF20, =
0x0121,<BR>+&nbsp;&nbsp;&nbsp; 0x7F22, 0x2223,<BR>+&nbsp;&nbsp;&nbsp; =
0x5424, 0x0525,<BR>+&nbsp;&nbsp;&nbsp; 0x5826,<BR>+&nbsp;&nbsp;&nbsp; =
0xCA29, 0x142B,<BR>+&nbsp;&nbsp;&nbsp; 0x0535,<BR>+&nbsp;&nbsp;&nbsp; =
0x4C4A, 0x8A4C,<BR>+&nbsp;&nbsp;&nbsp; 0x00DC,<BR>+&nbsp;&nbsp;&nbsp; =
0xC4E2,<BR>+&nbsp;&nbsp;&nbsp; 0x02E3,<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF<BR>+};<BR>+<BR>+unsigned short ITV_PATCH_TABLE_720P_720x480[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 0xC014, 0x0515, 0xDF18,<BR>+&nbsp;&nbsp;&nbsp; =
0x7919, 0xD61A, 0xDF20,<BR>+&nbsp;&nbsp;&nbsp; 0x0121, 0xCF22, =
0x2223,<BR>+&nbsp;&nbsp;&nbsp; 0x5524, 0x0525, =
0x8726,<BR>+&nbsp;&nbsp;&nbsp; 0x0427, 0x272A, =
0x172B,<BR>+&nbsp;&nbsp;&nbsp; 0xC034, 0x0535, =
0x7C4C,<BR>+&nbsp;&nbsp;&nbsp; 0xC4E2, 0x02E3,<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF<BR>+};<BR>+<BR>+unsigned short ITV_PATCH_TABLE_720P_720x576[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 0xC014, 0x0515, 0x3F18,<BR>+&nbsp;&nbsp;&nbsp; =
0x7A19, 0xD61A, 0x3F20,<BR>+&nbsp;&nbsp;&nbsp; 0xCF22, =
0x2223,<BR>+&nbsp;&nbsp;&nbsp; 0x6524, 0x0625, =
0x8826,<BR>+&nbsp;&nbsp;&nbsp; 0x0427, 0x272A, =
0x172B,<BR>+&nbsp;&nbsp;&nbsp; 0xC034, =
0x0535,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x64E2,<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF<BR>+};<BR>+<BR>+unsigned short ITV_PATCH_TABLE_720P_800x600[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 0x4014, 0x0615, 0x8F16,<BR>+&nbsp;&nbsp;&nbsp; =
0x5718, 0xD81A, 0x0A1B,<BR>+&nbsp;&nbsp;&nbsp; 0x5720, 0x1F22, =
0x2323,<BR>+&nbsp;&nbsp;&nbsp; 0xAE24, 0x0625, =
0x0726,<BR>+&nbsp;&nbsp;&nbsp; 0x0527, 0x192B,<BR>+&nbsp;&nbsp;&nbsp; =
0x4034, 0x0635, 0xF036, 0x074C,<BR>+&nbsp;&nbsp;&nbsp; =
0x64E2,<BR>+&nbsp;&nbsp;&nbsp; 0xFFFF<BR>+};<BR>+<BR>+unsigned short =
ITV_PATCH_TABLE_720P_1024x768[] =3D {<BR>+&nbsp;&nbsp;&nbsp; 0x0815, =
0x8F16,<BR>+&nbsp;&nbsp;&nbsp; 0xFF18, 0xDF1A, =
0x0A1B,<BR>+&nbsp;&nbsp;&nbsp; 0xFF20, 0x2323,<BR>+&nbsp;&nbsp;&nbsp; =
0x8724, 0x2825, 0x0926,<BR>+&nbsp;&nbsp;&nbsp; 0x0727, =
0x202B,<BR>+&nbsp;&nbsp;&nbsp; 0x0835, 0xF036, =
0x074C,<BR>+&nbsp;&nbsp;&nbsp; 0x00DC, <BR>+&nbsp;&nbsp;&nbsp; 0x21E0, =
0x0CE1, 0x24E2, 0x01E3, /* 66MHZ */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF<BR>+};<BR>+<BR>+/*************************************************=
*************************************/<BR>+/*****************************=
*** Patch Table for 1080I =
********************************/<BR>+/**********************************=
****************************************************/<BR>+unsigned short =
ITV_PATCH_TABLE_1080I_640x480[] =3D {<BR>+&nbsp;&nbsp;&nbsp; 0x0515, =
0xDF18, 0xF919,<BR>+&nbsp;&nbsp;&nbsp; 0xD31A, 0xDF20, =
0x0121,<BR>+&nbsp;&nbsp;&nbsp; 0x2223, 0x8E24, =
0x2325,<BR>+&nbsp;&nbsp;&nbsp; 0xAB26, 0x6227, =
0x142B,<BR>+&nbsp;&nbsp;&nbsp; 0x0535, 0x0936, =
0x0137,<BR>+&nbsp;&nbsp;&nbsp; 0xEB4C,<BR>+&nbsp;&nbsp;&nbsp; 0xC4E2, =
0x02E3,<BR>+&nbsp;&nbsp;&nbsp; 0xFFFF<BR>+};<BR>+<BR>+unsigned short =
ITV_PATCH_TABLE_1080I_720x480[] =3D {<BR>+&nbsp;&nbsp;&nbsp; 0xC014, =
0x0515, 0xDF18,<BR>+&nbsp;&nbsp;&nbsp; 0x7919, 0xD61A, =
0xDF20,<BR>+&nbsp;&nbsp;&nbsp; 0x0121, 0xCF22, =
0x2223,<BR>+&nbsp;&nbsp;&nbsp; 0x8E24, 0x2325, =
0x0226,<BR>+&nbsp;&nbsp;&nbsp; 0x6327, 0x172B, <BR>+&nbsp;&nbsp;&nbsp; =
0xC034, 0x0535, <BR>+&nbsp;&nbsp;&nbsp; 0xC4E2, =
0x02E3,<BR>+&nbsp;&nbsp;&nbsp; 0xFFFF<BR>+};<BR>+<BR>+unsigned short =
ITV_PATCH_TABLE_1080I_720x576[] =3D {<BR>+&nbsp;&nbsp;&nbsp; 0xC014, =
0x0515, 0x3F18,<BR>+&nbsp;&nbsp;&nbsp; 0x7A19, 0xD61A, =
0x3F20,<BR>+&nbsp;&nbsp;&nbsp; 0x0221, 0xCF22, =
0x2223,<BR>+&nbsp;&nbsp;&nbsp; 0x4524, 0x2425, =
0x0226,<BR>+&nbsp;&nbsp;&nbsp; 0x6327, 0x172B,<BR>+&nbsp;&nbsp;&nbsp; =
0xC034, 0x0535,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x64E2, 0x01E3,<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF<BR>+};<BR>+<BR>+unsigned short ITV_PATCH_TABLE_1080I_800x600[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; 0x4014, 0x0615, =
0xFA19,<BR>+&nbsp;&nbsp;&nbsp; 0x5718, 0xD81A, =
0x0221,<BR>+&nbsp;&nbsp;&nbsp; 0x5720, 0x1F22, =
0x2323,<BR>+&nbsp;&nbsp;&nbsp; 0x7324, 0x2425, =
0x5626,<BR>+&nbsp;&nbsp;&nbsp; 0x6327, 0x192B, <BR>+&nbsp;&nbsp;&nbsp; =
0x4034, 0x0635,<BR>+&nbsp;&nbsp;&nbsp; 0x0936, 0x0137, =
0xEB4C,<BR>+&nbsp;&nbsp;&nbsp; 0x64E2, 0x01E3,<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF<BR>+};<BR>+<BR>+unsigned short ITV_PATCH_TABLE_1080I_1024x768[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; 0x0815, 0xFF18, =
0xFA19,<BR>+&nbsp;&nbsp;&nbsp; 0xDF1A, 0x0221,<BR>+&nbsp;&nbsp;&nbsp; =
0xFF20, 0xFF22, 0x2323,<BR>+&nbsp;&nbsp;&nbsp; 0xB224, 0x2525, =
0x4626,<BR>+&nbsp;&nbsp;&nbsp; 0x6427, =
0x202B,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; =
0x0835,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x44E2, 0x01E3,<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF<BR>+};<BR>+<BR>+<BR>+unsigned short ITV_PATCH_TABLE_NULL[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 0xFFFF<BR>+};<BR>+<BR>+struct =
integrated_tv_hdtv_patch_table ITV_HDTV_PATCH_TABLE[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; {VIA_RES_640X480,&nbsp;&nbsp; =
ITV_PATCH_TABLE_480P_640x480,&nbsp; ITV_PATCH_TABLE_576P_640x480,&nbsp; =
ITV_PATCH_TABLE_720P_640x480, =
ITV_PATCH_TABLE_1080I_640x480},<BR>+&nbsp;&nbsp;&nbsp; =
{VIA_RES_720X480,&nbsp;&nbsp; ITV_PATCH_TABLE_480P_720x480,&nbsp; =
ITV_PATCH_TABLE_480P_720x480,&nbsp; ITV_PATCH_TABLE_720P_720x480, =
ITV_PATCH_TABLE_1080I_720x480},<BR>+&nbsp;&nbsp;&nbsp; =
{VIA_RES_720X576,&nbsp;&nbsp; ITV_PATCH_TABLE_576P_720x576,&nbsp; =
ITV_PATCH_TABLE_576P_720x576,&nbsp; ITV_PATCH_TABLE_720P_720x576, =
ITV_PATCH_TABLE_1080I_720x576},<BR>+&nbsp;&nbsp;&nbsp; =
{VIA_RES_800X600,&nbsp;&nbsp; ITV_PATCH_TABLE_480P_800x600,&nbsp; =
ITV_PATCH_TABLE_576P_800x600,&nbsp; ITV_PATCH_TABLE_720P_800x600, =
ITV_PATCH_TABLE_1080I_800x600},<BR>+&nbsp;&nbsp;&nbsp; =
{VIA_RES_1024X768,&nbsp; ITV_PATCH_TABLE_480P_1024x768, =
ITV_PATCH_TABLE_576P_1024x768, ITV_PATCH_TABLE_720P_1024x768, =
ITV_PATCH_TABLE_1080I_1024x768},<BR>+&nbsp;&nbsp;&nbsp; =
{VIA_RES_1280X720,&nbsp; =
ITV_PATCH_TABLE_NULL,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; =
ITV_PATCH_TABLE_NULL,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; ITV_PATCH_TABLE_NULL,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
ITV_PATCH_TABLE_NULL},<BR>+&nbsp;&nbsp;&nbsp; {VIA_RES_1920X1080, =
ITV_PATCH_TABLE_NULL,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; =
ITV_PATCH_TABLE_NULL,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; ITV_PATCH_TABLE_NULL,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
ITV_PATCH_TABLE_NULL}<BR>+<BR>+};<BR>+<BR>+<BR>+#endif<BR>diff -Nur =
linux-2.6.21-rc7/drivers/video/via/tv.c =
linux-2.6.21-rc7.viafb/drivers/video/via/tv.c<BR>--- =
linux-2.6.21-rc7/drivers/video/via/tv.c&nbsp;1969-12-31 =
19:00:00.000000000 -0500<BR>+++ =
linux-2.6.21-rc7.viafb/drivers/video/via/tv.c&nbsp;2007-04-26 =
19:52:32.000000000 -0400<BR>@@ -0,0 +1,1567 @@<BR>+/*<BR>+ * Copyright =
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
"tv.h"<BR>+#include "chip.h"<BR>+#include "share.h"<BR>+#include =
"debug.h"<BR>+#include "ioctl.h"<BR>+#include =
"IntegratedTV.h"<BR>+<BR>+/* TV Encoder Extern Function */<BR>+extern =
void vt1622_tv_disable(void);<BR>+extern void =
vt1622_tv_enable(void);<BR>+extern void load_vt1622_regs(int =
TVModeIndex);<BR>+extern int&nbsp; =
vt1622_tv_encoder_identify(void);<BR>+extern int =
vt1622_sense(void);<BR>+extern int =
vt1622_auto_sense(void);<BR>+<BR>+extern void =
vt1622a_tv_disable(void);<BR>+extern void =
vt1622a_tv_enable(void);<BR>+extern void load_vt1622a_regs(int =
TVModeIndex);<BR>+extern int&nbsp; =
vt1622a_tv_encoder_identify(void);<BR>+extern int =
vt1622a_sense(void);<BR>+extern int =
vt1622a_auto_sense(void);<BR>+<BR>+extern void =
vt1625_tv_disable(void);<BR>+extern void =
vt1625_tv_enable(void);<BR>+extern void load_vt1625_regs(int =
TVModeIndex);<BR>+extern int&nbsp; =
vt1625_tv_encoder_identify(void);<BR>+extern int =
vt1625_sense(void);<BR>+extern int vt1625_auto_sense(void);<BR>+extern =
void init_tv_vt1625(void);<BR>+<BR>+extern int =
integrated_tv_encoder_identify(void);<BR>+extern void =
integrated_tv_enable(void);<BR>+extern void =
integrated_tv_disable(void);<BR>+extern void set_integrated_tv_mode(int =
tv_mode_index);<BR>+extern void =
get_integrated_tv_default_status(void);<BR>+extern int =
get_integrated_tv_ffilter_status(int filter_type, int* =
filter_state);<BR>+extern void get_integrated_tv_pos(u32* current_hpos, =
u32* current_vpos);<BR>+extern void set_integrated_tv_ffilter_status(int =
filter_type, int filter_on_off, u32 desired_value);<BR>+extern void =
set_integrated_tv_hue(u32 desired_value);<BR>+extern void =
set_integrated_tv_brightness(u32 desired_value);<BR>+extern void =
set_integrated_tv_pos(u32 desired_hpos, u32 desired_vpos);<BR>+extern =
void set_integrated_tv_size(u32 desired_hsize, u32 =
desired_vsize);<BR>+extern int =
integrated_tv_sense(void);<BR>+<BR>+<BR>+extern void SetVCLK(u32 CLK, =
int set_iga);<BR>+extern inline void write_reg(u8 index, u16 io_port, u8 =
data);<BR>+extern void write_reg_mask(u8 index, int io_port, u8 data, u8 =
mask);<BR>+extern int i2cWriteByte(u8 bSlaveAddress, u8 bIndex, u8 =
bData);<BR>+extern int i2cReadByte(u8 bSlaveAddress, u8 bIndex, u8 =
*pbData);<BR>+extern void set_output_path(int device, int set_iga, int =
output_interface);<BR>+extern inline u8 read_reg(int io_port, u8 =
index);<BR>+extern void load_FIFO_reg(int set_iga, int hor_active, int =
ver_active);<BR>+extern void set_color_depth(int bpp_byte, int =
set_iga);<BR>+extern void set_integrated_tv_contrast(u32 =
desired_value);<BR>+extern void set_integrated_tv_saturation(u32 =
desired_value);<BR>+<BR>+bool&nbsp; is_tv_mode(struct =
tv_chip_information* ptv_chip_info, struct tv_setting_information* =
ptv_setting_info,<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int video_index);<BR>+bool =
is_vt1625_mode(struct tv_chip_information* ptv_chip_info, struct =
tv_setting_information* =
ptv_setting_info,<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int =
video_index);<BR>+<BR>+/* extern struct */<BR>+extern struct =
chip_information&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chip_info;<BR>+extern =
struct tv_setting_information&nbsp;&nbsp;&nbsp; =
tv_setting_info;<BR>+<BR>+extern int HotPlug_TV;<BR>+<BR>+extern long =
tv_ffilter;<BR>+extern long tv_brightness;<BR>+extern long =
tv_contrast;<BR>+extern long tv_saturation;<BR>+extern long =
tv_tint;<BR>+extern long tv_pos_hor_current;<BR>+extern long =
tv_pos_ver_current;<BR>+<BR>+int =
tv_encoder_identify(void)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; =
chip_info.tv_chip_info.tv_chip_name =3D VT1622;<BR>+&nbsp;&nbsp;&nbsp; =
chip_info.tv_chip_info.tv_chip_slave_addr =3D =
VT1622_TV_I2C_ADDR;<BR>+<BR>+&nbsp;&nbsp;&nbsp; if =
(vt1622_tv_encoder_identify()!=3D FAIL)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DEBUG_MSG(KERN_INFO "\n =
VT1622 VT1622 ! \n");<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
DEBUG_MSG(KERN_INFO "\n %2d", =
chip_info.tv_chip_info.tv_chip_name);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; DEBUG_MSG(KERN_INFO "\n %2d", =
chip_info.tv_chip_info.tv_chip_name);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; return(OK);<BR>+&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp; chip_info.tv_chip_info.tv_chip_name =3D =
VT1622A;<BR>+&nbsp;&nbsp;&nbsp; =
chip_info.tv_chip_info.tv_chip_slave_addr =3D =
VT1622A_TV_I2C_ADDR;<BR>+<BR>+&nbsp;&nbsp;&nbsp; if =
(vt1622a_tv_encoder_identify()!=3D FAIL)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DEBUG_MSG(KERN_INFO "\n =
VT1622A VT1622A ! \n");<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
DEBUG_MSG(KERN_INFO "\n %2d", =
chip_info.tv_chip_info.tv_chip_name);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; DEBUG_MSG(KERN_INFO "\n %2d", =
chip_info.tv_chip_info.tv_chip_name);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; return(OK);<BR>+&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp; chip_info.tv_chip_info.tv_chip_name =3D =
VT1625;<BR>+&nbsp;&nbsp;&nbsp; chip_info.tv_chip_info.tv_chip_slave_addr =
=3D VT1625_TV_I2C_ADDR;<BR>+<BR>+&nbsp;&nbsp;&nbsp; if =
(vt1625_tv_encoder_identify()!=3D FAIL)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DEBUG_MSG(KERN_INFO "\n =
VT1625 VT1625 ! \n");<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
DEBUG_MSG(KERN_INFO "\n %2d", =
chip_info.tv_chip_info.tv_chip_name);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; DEBUG_MSG(KERN_INFO "\n %2d", =
chip_info.tv_chip_info.tv_chip_name);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; return(OK);<BR>+&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Check for VT3324 integrated TV. =
*/<BR>+&nbsp;&nbsp;&nbsp; chip_info.tv_chip_info.tv_chip_name =3D =
INTEGRATED_TV;<BR>+<BR>+&nbsp;&nbsp;&nbsp; if =
(integrated_tv_encoder_identify() !=3D FAIL)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
chip_info.tv_chip_info.output_interface =3D =
INTERFACE_NONE;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
DEBUG_MSG(KERN_INFO "\n Found Integrated TV ! =
\n");<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
OK;<BR>+&nbsp;&nbsp;&nbsp; }&nbsp;&nbsp;&nbsp; =
<BR>+<BR>+&nbsp;&nbsp;&nbsp; <BR>+<BR>+&nbsp;&nbsp;&nbsp; =
chip_info.tv_chip_info.tv_chip_name =3D =
NON_TV_ENCODER;<BR>+&nbsp;&nbsp;&nbsp; =
chip_info.tv_chip_info.tv_chip_slave_addr =3D =
NON_TV_ENCODER;<BR>+&nbsp;&nbsp;&nbsp; return(FAIL);<BR>+}<BR>+<BR>+void =
tv_disable(void)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; /* Disable HW Reset =
*/<BR>+&nbsp;&nbsp;&nbsp; outb(0x6b,VIACR);<BR>+&nbsp;&nbsp;&nbsp; =
outb(0,VIACR+1);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* clear CR6B=3D0 =
*/<BR>+&nbsp;&nbsp;&nbsp; outb(0x6c,VIACR);<BR>+&nbsp;&nbsp;&nbsp; =
outb(0,VIACR+1);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* clear CR6C=3D0 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
switch(chip_info.tv_chip_info.tv_chip_name)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1622:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; =
vt1622_tv_disable();<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; =
break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1622A:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; =
vt1622a_tv_disable();<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; =
break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1625:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; =
vt1625_tv_disable();<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; =
break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
INTEGRATED_TV:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; =
integrated_tv_disable();<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; =
}<BR>+}<BR>+<BR>+void =
tv_load_timing_init(void)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; =
switch(chip_info.tv_chip_info.tv_chip_name)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1622:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1622A:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1625:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; =
init_tv_vt1625();<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; <BR>+&nbsp;&nbsp;&nbsp; }<BR>+}<BR>+<BR>+void =
VIAPitchAlignmentPatch(void)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; unsigned =
char&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cr13, cr35, cr65, cr66, =
cr67;<BR>+&nbsp;&nbsp;&nbsp; unsigned long&nbsp;&nbsp;&nbsp;&nbsp; =
dwScreenPitch=3D 0;<BR>+&nbsp;&nbsp;&nbsp; unsigned =
long&nbsp;&nbsp;&nbsp;&nbsp; dwPitch;<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
dwPitch =3D tv_setting_info.h_active * (tv_setting_info.bpp &gt;&gt; =
3);<BR>+&nbsp;&nbsp;&nbsp; dwPitch =3D tv_setting_info.h_active =
*(tv_setting_info.bpp&gt;&gt; 3);<BR>+&nbsp;&nbsp;&nbsp; if (dwPitch =
&amp; 0x1F) <BR>+&nbsp;&nbsp; {&nbsp;&nbsp; /* Is 32 Byte Alignment ? =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dwScreenPitch =3D =
((dwPitch + 31) &amp; ~31) &gt;&gt; =
3;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ( =
tv_setting_info.iga_path=3D=3DIGA2)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
if(tv_setting_info.bpp&gt;8) {&nbsp;&nbsp;&nbsp;&nbsp; =
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
if(tv_setting_info.bpp&gt;8) {&nbsp;&nbsp;&nbsp;&nbsp; =
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
}<BR>+&nbsp;&nbsp;&nbsp; }<BR>+}<BR>+void tv_load_timing(int =
TVModeIndex)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; unsigned char&nbsp;cr65, cr66, =
cr67;<BR>+&nbsp;&nbsp;&nbsp; unsigned char&nbsp; cr13, cr35, sr1c, =
sr1d;<BR>+&nbsp;&nbsp;&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; countWidthByQWord, =
offsetWidthByQWord;<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
switch(chip_info.tv_chip_info.tv_chip_name)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1622:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; =
load_vt1622_regs(TVModeIndex);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1622A:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; =
load_vt1622a_regs(TVModeIndex);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1625:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; =
load_vt1625_regs(TVModeIndex);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
INTEGRATED_TV:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; =
set_integrated_tv_mode(TVModeIndex);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Set Quadword offset,counter of primary =
and secondary screen.Fix colorkey&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; problem when using CRT+TV SAMM =
state. Not consider using virtual desktop */<BR>+&nbsp;&nbsp;&nbsp; =
offsetWidthByQWord =3D =
(tv_setting_info.h_active*(tv_setting_info.bpp&gt;&gt; 3)) &gt;&gt; =
3;<BR>+&nbsp;&nbsp;&nbsp; countWidthByQWord =3D =
(tv_setting_info.h_active *(tv_setting_info.bpp&gt;&gt; 3)) &gt;&gt; =
3;<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
if(tv_setting_info.iga_path=3D=3DIGA2)<BR>+&nbsp;&nbsp;&nbsp; {&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cr67 =3D read_reg(VIACR, =
CR67) &amp; 0xFC;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cr66 =
=3D offsetWidthByQWord &amp; =
0xFF;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cr67 |=3D =
(offsetWidthByQWord &amp; 0x300) &gt;&gt; =
8;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg(CR66, =
VIACR, cr66);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_reg(CR67, VIACR, =
cr67);<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cr67 =3D =
read_reg(VIACR, CR67) &amp; =
0xF3;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cr67 |=3D =
(countWidthByQWord &amp; 0x600) &gt;&gt; =
7;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cr65 =3D =
(countWidthByQWord &gt;&gt; 1) &amp; =
0xff;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_reg(CR65, VIACR, =
cr65);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg(CR67, =
VIACR, cr67);<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* We =
also should set FIFO related registers if TV use IGA2, or TV display may =
incorrect.*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
if((chip_info.gfx_chip_name !=3D UNICHROME_CLE266) &amp;&amp; =
(chip_info.gfx_chip_name !=3D UNICHROME_K400)) { /* Because =
load_FIFO_reg() will load incorrect regs for CLE266&amp;K400 =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 load_FIFO_reg(IGA2, tv_setting_info.h_active, =
tv_setting_info.v_active);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 }<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
set_color_depth(tv_setting_info.bpp &gt;&gt; 3, IGA2);<BR>+&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Patch for non 32bit =
alignment mode */<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VIAPitchAlignmentPatch();<BR>+&nbsp;&nbsp;&nbsp; }&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; else<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cr35 =3D =
read_reg(VIACR, CR35) &amp; =
0x1F;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cr13 =3D =
offsetWidthByQWord &amp; =
0xFF;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cr35 |=3D =
(offsetWidthByQWord &amp; 0x700) &gt;&gt; =
3;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* bit 7:5: offset 10:8 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sr1d =3D =
read_reg(VIASR, =
SR1D);<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Patch for =
non 32bit alignment mode =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VIAPitchAlignmentPatch();<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* Enable Refresh to avoid data lose when enter screen saver =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Refresh disable =
&amp; 128-bit alignment =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sr1d =3D (sr1d &amp; =
0xFC) | (countWidthByQWord &gt;&gt; =
9);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sr1c =3D =
((countWidthByQWord &gt;&gt; 1) + 1) &amp; =
0xFF;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* sr1d =3D ((sr1d =
&amp; 0xFC) | (widthByQWord &gt;&gt; 8)) | 0x80; =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* sr1c =3D =
widthByQWord &amp; 0xFF; =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg(CR13, =
VIACR, cr13);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_reg(CR35, VIACR, =
cr35);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg(SR1C, =
VIASR, sr1c);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_reg(SR1D, VIASR, sr1d);<BR>+&nbsp;&nbsp;&nbsp; }&nbsp; =
<BR>+}<BR>+<BR>+void =
tv_load_timing_modify(void)<BR>+{<BR>+&nbsp;&nbsp;&nbsp;&nbsp; =
switch(chip_info.tv_chip_info.tv_chip_name) =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1622:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1622A:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1625:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
}<BR>+}<BR>+<BR>+void tv_patch(int =
tv_mode_index)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; =
switch(chip_info.tv_chip_info.tv_chip_name)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1622A:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1623:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; =
switch(chip_info.gfx_chip_name)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; case =
UNICHROME_K800:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_patch_skew_K800();<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =
default:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1625:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; =
switch(tv_setting_info.out_signal)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; case =
TV_OUTPUT_SVIDEO:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
TV_OUTPUT_COMPOSITE_SVIDEO:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 /* Set TV.65h =3D 51h, SVideo Luma Value. =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tv_register_write(0x65, =
0x51);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =
default:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; =
switch(chip_info.gfx_chip_name)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; case =
UNICHROME_P880:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_patch_skew_p880(tv_mode_index);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; case =
UNICHROME_CN900:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_patch_skew_cn900(tv_mode_index);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; =
break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
UNICHROME_CX700:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_patch_skew_cx700(tv_mode_index);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; =
break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Add to support VT3327 VT3336 VT3364 =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; case =
UNICHROME_K8M890:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_patch_skew_k8m890(tv_mode_index);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; case =
UNICHROME_P4M890:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_patch_skew_p4m890(tv_mode_index);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; =
break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
UNICHROME_P4M900:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_patch_skew_p4m900(tv_mode_index);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =
default:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
default:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; break;<BR>+&nbsp;&nbsp;&nbsp; }<BR>+}<BR>+<BR>+void =
tv_enable(void)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; =
switch(tv_setting_info.iga_path)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
IGA1:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; set_output_path(DEVICE_TV, IGA1, =
chip_info.tv_chip_info.output_interface);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
IGA2:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; set_output_path(DEVICE_TV, IGA2, =
chip_info.tv_chip_info.output_interface);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
IGA1_IGA2:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; break;<BR>+&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
switch(chip_info.tv_chip_info.tv_chip_name)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1622:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; =
vt1622_tv_enable();<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; =
break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1622A:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; =
vt1622a_tv_enable();<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; =
break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1625:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; =
vt1625_tv_enable();<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; =
break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
INTEGRATED_TV:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; =
integrated_tv_enable();<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* For hot-plug =
issue:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; If switch to TV, it =
would use TV auto-sense function to sense TV. */<BR>+&nbsp;&nbsp;&nbsp; =
if(HotPlug_TV =3D=3D 1)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
if(chip_info.tv_chip_info.tv_chip_name =3D=3D =
VT1625)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_register_write(0x1C, tv_register_read(0x1C) | =
BIT6);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; tv_register_write(0x0E, =
0x00);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
else<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_register_write(0x0E, =
0x40);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; }<BR>+<BR>+}<BR>+<BR>+void =
tv_register_write(int index, u8 data)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; =
i2cWriteByte(chip_info.tv_chip_info.tv_chip_slave_addr, index, =
data);<BR>+}<BR>+<BR>+int tv_register_read(int =
index)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; u8 data =3D 0; /* Fix me:should need =
another parameter to indicate whether read is successful =
*/<BR>+&nbsp;&nbsp;&nbsp; int status;<BR>+<BR>+&nbsp;&nbsp;&nbsp; status =
=3D i2cReadByte(chip_info.tv_chip_info.tv_chip_slave_addr, index, =
&amp;data);<BR>+&nbsp;&nbsp;&nbsp; return(data);<BR>+}<BR>+<BR>+void =
load_tv_output_signal(u16 *tv_func_reg)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; int =
i=3D0;<BR>+<BR>+&nbsp;&nbsp;&nbsp; while(tv_func_reg[i]!=3D =
0xFFFF)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_register_write(GET_LOW_BYTE(tv_func_reg[i]),GET_HIGH_BYTE(tv_func_reg[=
i]));<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
i++;<BR>+&nbsp;&nbsp;&nbsp; }<BR>+<BR>+}<BR>+<BR>+void =
write_tv_patch_table(u16 *tv_func_reg)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; int =
i=3D0;<BR>+<BR>+&nbsp;&nbsp;&nbsp; while(tv_func_reg[i]!=3D =
0xFFFF)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_register_write(GET_LOW_BYTE(tv_func_reg[i]),GET_HIGH_BYTE(tv_func_reg[=
i]));<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
i++;<BR>+&nbsp;&nbsp;&nbsp; }<BR>+}<BR>+<BR>+bool is_tv_mode(struct =
tv_chip_information* ptv_chip_info, struct tv_setting_information* =
ptv_setting_info,<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int =
video_index)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; bool re =3D =
FALSE;<BR>+&nbsp;&nbsp;&nbsp; =
switch(ptv_chip_info-&gt;tv_chip_name)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1621:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; if(VIA_RES_640X480&nbsp; =3D=3D video_index || VIA_RES_800X600 =
=3D=3D =
video_index)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; WARN_MSG(KERN_WARNING "The specified tv mode is =
not valid for currently used&nbsp; tv =
encoder\n");<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; re =3D =
TRUE;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1622:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1622A:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1623:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; if (VIA_RES_640X480 =3D=3D video_index ||VIA_RES_800X600 =3D=3D =
video_index =
||<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; VIA_RES_1024X768 =3D=3D video_index || =
VIA_RES_720X480 =3D=3D video_index =
||<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; VIA_RES_720X576=3D=3D video_index || =
VIA_RES_848X480 =3D=3D =
video_index)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; WARN_MSG(KERN_WARNING "The specified tv mode is =
not valid for currently used&nbsp; tv =
encoder\n");<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; re =3D =
TRUE;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1625:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
re =3D is_vt1625_mode(ptv_chip_info, ptv_setting_info, =
video_index);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
INTEGRATED_TV:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; if(CX700_REVISION_700 =3D=3D =
chip_info.gfx_chip_revision)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; =
switch(ptv_setting_info-&gt;system)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
TVTYPE_480P:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
TVTYPE_576P:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
TVTYPE_720P:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
TVTYPE_1080I:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WARN_MSG(KERN_WARNING "HDTV is not supported for currently =
used&nbsp; tv =
encoder\n");<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; re =3D =
FALSE;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return =
re;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
default:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
if (VIA_RES_640X480 =3D=3D video_index ||VIA_RES_800X600 =3D=3D =
video_index =
||<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; VIA_RES_1024X768 =3D=3D video_index || =
VIA_RES_720X480 =3D=3D video_index =
||<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; VIA_RES_720X576=3D=3D video_index || =
VIA_RES_1280X720 =3D=3D video_index =
||<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; VIA_RES_1920X1080 =3D=3D =
video_index)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; WARN_MSG(KERN_WARNING "The specified tv mode is =
not valid for currently used&nbsp; tv =
encoder\n");<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; re =3D =
TRUE;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; return =
re;<BR>+}<BR>+/* TV Set Mode */<BR>+void tv_set_mode(int =
video_index)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; =
if(is_tv_mode(&amp;chip_info.tv_chip_info, &amp;tv_setting_info, =
video_index))<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_encoder_identify();<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_disable();<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_load_timing_init();<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_load_timing(video_index);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; =
tv_load_timing_modify();<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_patch(video_index);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_enable();<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_set_color();<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; =
else<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_MSG(KERN_WARNING =
"TV will not be enabled\n");<BR>+&nbsp;&nbsp;&nbsp; }<BR>+}<BR>+<BR>+/* =
Sense function only support VIA TV encoder */<BR>+int =
tv_sense(void)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; int =
ret;<BR>+<BR>+&nbsp;&nbsp;&nbsp; DEBUG_MSG(KERN_INFO =
"tv_sense!!\n");<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
switch(chip_info.tv_chip_info.tv_chip_name)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1622:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; ret =3D =
vt1622_sense();<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
VT1622A:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; ret =3D =
vt1622a_sense();<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; =
break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1625:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; ret =3D =
vt1625_sense();<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Add for VT3324 Integrated TV. =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
INTEGRATED_TV:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; ret =3D =
integrated_tv_sense();<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; <BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
default:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; ret =3D =
TV_OUTPUT_NONE;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; break;<BR>+&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp; return ret;<BR>+}<BR>+<BR>+/* Auto sense =
function only support VIA TV encoder */<BR>+int =
tv_auto_sense(void)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; int =
ret;<BR>+<BR>+&nbsp;&nbsp;&nbsp; DEBUG_MSG(KERN_INFO =
"tv_auto_sense!!\n");<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
switch(chip_info.tv_chip_info.tv_chip_name) =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1622:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; ret =3D =
vt1622_auto_sense();<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
VT1622A:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; ret =3D =
vt1622a_auto_sense();<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1625:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; ret =3D =
vt1625_auto_sense();<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
default:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; ret =3D =
TV_OUTPUT_NONE;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp; return ret;<BR>+}<BR>+<BR>+void =
tv_patch_skew_K800(void)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; =
switch(chip_info.tv_chip_info.output_interface)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
INTERFACE_DVP0:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; write_reg_mask(CR96, VIACR, 0x07, =
BIT0+BIT1+BIT2);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
INTERFACE_DVP1:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; write_reg_mask(CR9B, VIACR, 0x07, =
BIT0+BIT1+BIT2);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
INTERFACE_DFP_HIGH:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; write_reg_mask(CR97, VIACR, 0x07, =
BIT0+BIT1+BIT2);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
INTERFACE_DFP_LOW:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; write_reg_mask(CR99, VIACR, 0x07, =
BIT0+BIT1+BIT2);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<BR>+&nbsp;&nbsp;&nbsp; }<BR>+}<BR>+<BR>+/* For =
VT3314 */<BR>+void tv_patch_skew_cn900(int =
tv_mode_index)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; u8 =
data;<BR>+&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; =
switch(chip_info.tv_chip_info.output_interface)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
INTERFACE_DVP0:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; /* Reset clock and data driving first: =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 write_reg_mask(SR2A, VIASR, 0, =
BIT4+BIT5);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; write_reg_mask(SR1E, VIASR, 0, =
BIT2);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; write_reg_mask(SR1B, VIASR, 0, =
BIT1);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* For TV display incorrect color =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 /* with VT5907A (VT1625-AMR) on =
VN800.*/&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
if (tv_setting_info.system =3D=3D =
TVTYPE_PAL)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; /* It still has a little bit problem in this =
mode. =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if ((tv_mode_index =3D=3D VIA_RES_1024X768) =
&amp;&amp; (tv_setting_info.level =3D=3D =
TV_SIZE_OVER_SCAN))<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Adjust clock driving: =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg_mask(SR2A, =
VIASR, BIT4, =
BIT4);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_reg_mask(SR1E, VIASR, BIT2, =
BIT2);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
else if (tv_setting_info.system =3D=3D =
TVTYPE_576P)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; /* It still has a little bit problem in this =
mode. =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if ((tv_mode_index =3D=3D VIA_RES_1024X768) =
&amp;&amp; (tv_setting_info.level =3D=3D =
TV_SIZE_OVER_SCAN))<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Adjust clock driving: =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg_mask(SR2A, =
VIASR, BIT4, =
BIT4);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_reg_mask(SR1E, VIASR, BIT2, =
BIT2);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
else if (tv_setting_info.system =3D=3D =
TVTYPE_720P)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if ((tv_mode_index =3D=3D VIA_RES_1024X768) =
&amp;&amp; (tv_setting_info.level =3D=3D =
TV_SIZE_NORMAL_SCAN))<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Adjust data driving: =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg_mask(SR2A, =
VIASR, BIT5, =
BIT5);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_reg_mask(SR1B, VIASR, BIT1, =
BIT1);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg_mask(CR96, =
VIACR, 0x07, =
BIT0+BIT1+BIT2+BIT3);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D =
tv_register_read(0x05);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
data =3D (data &amp; 0xE0) | =
0x1E;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_register_write(0x05, =
data);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
else if (tv_setting_info.system =3D=3D =
TVTYPE_1080I)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if ((tv_mode_index =3D=3D VIA_RES_1024X768) =
&amp;&amp; (tv_setting_info.level =3D=3D =
TV_SIZE_NORMAL_SCAN))<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Adjust clock driving: =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg_mask(SR2A, =
VIASR, BIT4, =
BIT4);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_reg_mask(SR1E, VIASR, BIT2, =
BIT2);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Adjust data driving: =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg_mask(SR2A, =
VIASR, BIT5, =
BIT5);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_reg_mask(SR1B, VIASR, BIT1, =
BIT1);<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg_mask(CR96, =
VIACR, 0x07, =
BIT0+BIT1+BIT2+BIT3);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D =
tv_register_read(0x05);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
data =3D (data &amp; 0xF0) | =
0x09;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_register_write(0x05, =
data);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; else if ((tv_mode_index =3D=3D VIA_RES_1024X768) =
&amp;&amp; (tv_setting_info.level =3D=3D =
TV_SIZE_OVER_SCAN))<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Adjust clock driving: =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg_mask(SR2A, =
VIASR, BIT4, =
BIT4);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_reg_mask(SR1E, VIASR, BIT2, =
BIT2);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; else if(tv_mode_index =3D=3D =
VIA_RES_1920X1080)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For both normal scan =
and over scan =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* It still has a =
little bit problem in this mode. =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Adjust clock driving: =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg_mask(SR2A, =
VIASR, BIT4, =
BIT4);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_reg_mask(SR1E, VIASR, BIT2, =
BIT2);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Adjust data driving: =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg_mask(SR2A, =
VIASR, 0, =
BIT5);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_reg_mask(SR1B, VIASR, BIT1, =
BIT1);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D =
tv_register_read(0x05);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
data =3D (data &amp; =
0xF0);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_register_write(0x05, =
data);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
INTERFACE_DVP1:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
INTERFACE_DFP_HIGH:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; =
break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
INTERFACE_DFP_LOW:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; break;<BR>+&nbsp;&nbsp;&nbsp; }<BR>+}&nbsp;<BR>+<BR>+/* =
For VT3324 */<BR>+void tv_patch_skew_cx700(int =
tv_mode_index)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; =
switch(chip_info.tv_chip_info.output_interface)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
INTERFACE_DVP0:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; /* For TV display incorrect color =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 /* with VT5907A (VT1625-AMR) on =
CX700.*/&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
if (tv_setting_info.system =3D=3D =
TVTYPE_720P)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if ((tv_mode_index =3D=3D VIA_RES_1024X768) =
&amp;&amp; (tv_setting_info.level =3D=3D =
TV_SIZE_NORMAL_SCAN))<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg_mask(CR96, =
VIACR, 0x0F, =
BIT0+BIT1+BIT2+BIT3);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
INTERFACE_DVP1:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; if (tv_setting_info.system =3D=3D =
TVTYPE_720P)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if ((tv_mode_index =3D=3D VIA_RES_1024X768) =
&amp;&amp; (tv_setting_info.level =3D=3D =
TV_SIZE_NORMAL_SCAN))<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg_mask(CR9B, =
VIACR, 0x02, =
BIT0+BIT1);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}else if (tv_setting_info.system =3D=3D =
TVTYPE_1080I)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if ((tv_mode_index =3D=3D VIA_RES_1024X768) =
&amp;&amp; (tv_setting_info.level =3D=3D =
TV_SIZE_NORMAL_SCAN))<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg_mask(CR9B, =
VIACR, 0x02, =
BIT0+BIT1);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp; }<BR>+}&nbsp;<BR>+<BR>+/* For VT3259 =
*/<BR>+void tv_patch_skew_p880(int =
tv_mode_index)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; u8 =
data;<BR>+&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; =
switch(chip_info.tv_chip_info.output_interface)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
INTERFACE_DVP0:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; /* Reset clock and data driving first: =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 write_reg_mask(SR2A, VIASR, 0, =
BIT4+BIT5);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; write_reg_mask(SR1E, VIASR, 0, =
BIT2);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; write_reg_mask(SR1B, VIASR, 0, =
BIT1);<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; /* For TV display incorrect color =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 /* with VT5907A (VT1625-AMR) on =
CN400.*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (tv_setting_info.system =3D=3D =
TVTYPE_PAL)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if ((tv_mode_index =3D=3D VIA_RES_1024X768) =
&amp;&amp; (tv_setting_info.level =3D=3D =
TV_SIZE_OVER_SCAN))<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Adjust clock driving: =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg_mask(SR1E, =
VIASR, BIT2, =
BIT2);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
else if (tv_setting_info.system =3D=3D =
TVTYPE_576P)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if ((tv_mode_index =3D=3D VIA_RES_1024X768) =
&amp;&amp; (tv_setting_info.level =3D=3D =
TV_SIZE_OVER_SCAN))<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Adjust clock driving: =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg_mask(SR2A, =
VIASR, BIT4, =
BIT4);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
else if (tv_setting_info.system =3D=3D =
TVTYPE_720P)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if ((tv_mode_index =3D=3D VIA_RES_1024X768) =
&amp;&amp; (tv_setting_info.level =3D=3D =
TV_SIZE_NORMAL_SCAN))<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg_mask(CR96, =
VIACR, BIT3, =
BIT0+BIT1+BIT2+BIT3);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D =
tv_register_read(0x05);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
data =3D (data &amp; 0xF0) | =
0x0E;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_register_write(0x05, =
data);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
else if (tv_setting_info.system =3D=3D =
TVTYPE_1080I)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if ((tv_mode_index =3D=3D VIA_RES_1024X768) =
&amp;&amp; (tv_setting_info.level =3D=3D =
TV_SIZE_OVER_SCAN))<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Adjust clock driving: =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg_mask(SR1E, =
VIASR, BIT2, =
BIT2);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
INTERFACE_DVP1:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
INTERFACE_DFP_HIGH:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; =
break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
INTERFACE_DFP_LOW:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; break;<BR>+&nbsp;&nbsp;&nbsp; }<BR>+}<BR>+<BR>+/* Add =
for support VT3327 VT3336 VT3364.<BR>+ * Modified from X driver's =
code.<BR>+ */<BR>+void tv_patch_skew_k8m890(int =
tv_mode_index)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; =
switch(chip_info.tv_chip_info.output_interface)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
INTERFACE_DVP0:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; /* Fix TV display incorrect color when set 1080i TV mode =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 /* with VT5907A (VT1625-AMR) on VT3336. =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 if (tv_setting_info.system =3D=3D =
TVTYPE_1080I)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if (tv_mode_index =3D=3D =
VIA_RES_1024X768)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg_mask(CR96, =
VIACR, 0x04, =
BIT0+BIT1+BIT2);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; else if(tv_mode_index =3D=3D =
VIA_RES_1920X1080)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg_mask(CR96, =
VIACR, 0x00, =
BIT0+BIT1+BIT2);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
INTERFACE_DVP1:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
INTERFACE_DFP_HIGH:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
INTERFACE_DFP_LOW:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; break;<BR>+&nbsp;&nbsp;&nbsp; =
}<BR>+}<BR>+<BR>+<BR>+void tv_patch_skew_p4m890(int =
tv_mode_index)<BR>+{<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
switch(chip_info.tv_chip_info.output_interface)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
INTERFACE_DVP0:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; /* For TV display incorrect color =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 /* with VT5907A (VT1625-AMR) on =
P4M890.*/&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
if (tv_setting_info.system =3D=3D =
TVTYPE_1080I)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if (tv_mode_index =3D=3D =
VIA_RES_1024X768)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg_mask(CR96, =
VIACR, 0x04, =
BIT0+BIT1+BIT2);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* For TV display incorrect color =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 /* VT1625-AMR on P4M890.*/&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
if (tv_setting_info.system =3D=3D =
TVTYPE_720P)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if (tv_mode_index =3D=3D =
VIA_RES_1024X768)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg_mask(CR96, =
VIACR, 0x07, =
BIT0+BIT1+BIT2);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; break;<BR>+&nbsp;&nbsp;&nbsp; }<BR>+}&nbsp;<BR>+<BR>+void =
tv_patch_skew_p4m900(int =
tv_mode_index)<BR>+{<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
switch(chip_info.tv_chip_info.output_interface)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
INTERFACE_DVP0:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; /* For TV display incorrect color =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 /* with VT5907A (VT1625-AMR) on =
P4M900.*/&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
if (tv_setting_info.system =3D=3D =
TVTYPE_1080I)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if (tv_mode_index =3D=3D =
VIA_RES_1024X768)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg_mask(CR96, =
VIACR, 0x04, =
BIT0+BIT1+BIT2);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; if (tv_setting_info.system =3D=3D =
TVTYPE_720P)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if (tv_mode_index =3D=3D =
VIA_RES_1024X768)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg_mask(CR96, =
VIACR, 0x04, =
BIT0+BIT1+BIT2);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp; }<BR>+}&nbsp;<BR>+<BR>+<BR>+void =
tv_set_color()<BR>+{<BR>+&nbsp;&nbsp;&nbsp; /* Get TV color default, =
current value and level*/<BR>+&nbsp;&nbsp;&nbsp; =
switch(chip_info.tv_chip_info.tv_chip_name) =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1622:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1622A:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1623:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1625:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; tv_setting_info.DefaultFFilter =3D tv_register_read(0x03) &amp; =
0x03;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; tv_setting_info.CurrentFFilter =3D =
tv_setting_info.DefaultFFilter;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (chip_info.tv_chip_info.tv_chip_name =
=3D=3D =
VT1625)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tv_setting_info.FFilterLevel =3D =
3;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =
else<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; tv_setting_info.FFilterLevel =3D =
2;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; tv_setting_info.DefaultBrightness =3D =
tv_register_read(0x0B);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tv_setting_info.CurrentBrightness =3D =
tv_setting_info.DefaultBrightness;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tv_setting_info.BrightnessLevel =3D =
255;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; if (tv_setting_info.out_signal =3D=3D TV_OUTPUT_RGB) =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; tv_setting_info.DefaultContrast =3D =
tv_register_read(0x65);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_setting_info.CurrentContrast =3D =
tv_setting_info.DefaultContrast;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_setting_info.ContrastLevel =3D =
250;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; tv_setting_info.DefaultSaturation =3D =
(tv_register_read(0x66) &lt;&lt; 8) + =
tv_register_read(0x67);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_setting_info.CurrentSaturation =3D =
tv_setting_info.DefaultSaturation;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_setting_info.SaturationLevel =3D =
65535;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; tv_setting_info.DefaultTINT =3D =
0;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; tv_setting_info.CurrentTINT =3D =
tv_setting_info.DefaultTINT;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_setting_info.TINTLevel =3D =
0;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 } else if (tv_setting_info.out_signal =3D=3D TV_OUTPUT_YPBPR) =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; tv_setting_info.DefaultContrast =3D =
tv_register_read(0x65);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_setting_info.CurrentContrast =3D =
tv_setting_info.DefaultContrast;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_setting_info.ContrastLevel =3D =
255;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; tv_setting_info.DefaultSaturation =3D =
(tv_register_read(0x66) &lt;&lt; 8) + =
tv_register_read(0x67);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_setting_info.CurrentSaturation =3D =
tv_setting_info.DefaultSaturation;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_setting_info.SaturationLevel =3D =
65535;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; tv_setting_info.DefaultTINT =3D =
0;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; tv_setting_info.CurrentTINT =3D =
tv_setting_info.DefaultTINT;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_setting_info.TINTLevel =3D =
0;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 } else =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; tv_setting_info.DefaultContrast =3D =
tv_register_read(0x0C);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_setting_info.CurrentContrast =3D =
tv_setting_info.DefaultContrast;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_setting_info.ContrastLevel =3D =
255;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; tv_setting_info.DefaultSaturation =3D =
(tv_register_read(0x0D) &lt;&lt; 8) + =
tv_register_read(0x0A);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_setting_info.CurrentSaturation =3D =
tv_setting_info.DefaultSaturation;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_setting_info.SaturationLevel =3D =
65535;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; tv_setting_info.DefaultTINT =3D =
tv_register_read(0x10) + ((tv_register_read(0x11) &amp; 0x07) &lt;&lt; =
8);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; tv_setting_info.CurrentTINT =3D =
tv_setting_info.DefaultTINT;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_setting_info.TINTLevel =3D =
2047;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Add for =
VT3324 Integrated TV. */<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
INTEGRATED_TV:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; =
get_integrated_tv_default_status();<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; <BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
default:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp; }<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* Set to user parameter*/<BR>+&nbsp;&nbsp;&nbsp; if(tv_ffilter !=3D =
0)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_set_ffilter(STATE_ON, tv_ffilter);<BR>+&nbsp;&nbsp;&nbsp; =
if(tv_brightness !=3D 0)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_set_brightness(tv_brightness);<BR>+&nbsp;&nbsp;&nbsp; =
if(tv_contrast!=3D 0)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_set_contrast(tv_contrast);<BR>+&nbsp;&nbsp;&nbsp; if(tv_saturation =
!=3D 0)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_set_saturation(tv_saturation);<BR>+&nbsp;&nbsp;&nbsp; if(tv_tint !=3D =
0)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_set_tint(tv_tint);<BR>+}<BR>+<BR>+/* Set TV Brightness function only =
support VIA TV encoder */<BR>+void tv_set_brightness(u32 =
value)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; DEBUG_MSG(KERN_INFO =
"tv_set_brightness!!\n");<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
switch(chip_info.tv_chip_info.tv_chip_name) =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1622:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1622A:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1623:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1625:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; tv_register_write(0x0B, (u8) =
value);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; tv_setting_info.CurrentBrightness =3D =
value;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Add =
for VT3324 Integrated TV. =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
INTEGRATED_TV:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; =
set_integrated_tv_brightness(value);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; <BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
default:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp; }<BR>+}<BR>+<BR>+/* Set TV =
Contrast function only support VIA TV encoder */<BR>+void =
tv_set_contrast(u32 value)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; u32 =
tmp;<BR>+<BR>+&nbsp;&nbsp;&nbsp; DEBUG_MSG(KERN_INFO =
"tv_set_contrast!!\n");<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
switch(chip_info.tv_chip_info.tv_chip_name) =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1622:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1622A:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1623:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1625:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; tmp =3D (value - =
tv_setting_info.CurrentContrast);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (tv_setting_info.out_signal =3D=3D =
TV_OUTPUT_RGB) =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; tv_register_write(0x65, =
(u8)(tv_register_read(0x65) + =
tmp));<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; tv_register_write(0x66, =
(u8)(tv_register_read(0x66) + =
tmp));<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; tv_register_write(0x67, =
(u8)(tv_register_read(0x67) + =
tmp));<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; } else if (tv_setting_info.out_signal =3D=3D TV_OUTPUT_YPBPR) =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; tv_register_write(0x65, =
(u8)(tv_register_read(0x65) + =
tmp));<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; } else =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; tv_register_write(0x0C, =
(u8)(tv_register_read(0x0C) + =
tmp));<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; tv_register_write(0x65, (u8)(value));&nbsp; =
/* for VT1625 S-Video output =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_setting_info.CurrentContrast =3D =
value;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; <BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
INTEGRATED_TV:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; =
set_integrated_tv_contrast(value);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+}<BR>+<BR>+/* Set TV Saturation function only support VIA TV =
encoder */<BR>+void tv_set_saturation(u32 =
value)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; DEBUG_MSG(KERN_INFO =
"tv_set_saturation!!\n");<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
switch(chip_info.tv_chip_info.tv_chip_name) =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1622:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1622A:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1623:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1625:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; tv_register_write(0x66, (u8)((value &gt;&gt; 8) &amp; =
0xFF));<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; tv_register_write(0x67, (u8)(value &amp; =
0xFF));<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; tv_register_write(0x0D, (u8)((value &gt;&gt; 8) &amp; =
0xFF));<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; tv_register_write(0x0A, (u8)(value &amp; =
0xFF));<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; tv_setting_info.CurrentSaturation =3D =
value;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
INTEGRATED_TV:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; =
set_integrated_tv_saturation(value);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+}<BR>+<BR>+/* Set TV TINT function only support VIA TV encoder =
*/<BR>+void tv_set_tint(u32 value)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; =
DEBUG_MSG(KERN_INFO "tv_set_tint!!\n");<BR>+<BR>+&nbsp;&nbsp;&nbsp; if =
((tv_setting_info.out_signal =3D=3D TV_OUTPUT_RGB) =
||<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
(tv_setting_info.out_signal =3D=3D =
TV_OUTPUT_YPBPR))<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return;<BR>+&nbsp;&nbsp;&nbsp; }<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
switch(chip_info.tv_chip_info.tv_chip_name)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1622:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1622A:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1623:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1625:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 <BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_register_write(0x10, (u8)(value &amp; =
0xFF));<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; tv_register_write(0x11, (u8)((tv_register_read(0x11) &amp; ~0x07) =
| (u8)((value &gt;&gt; 8) &amp; =
0xFF)));<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; tv_setting_info.CurrentTINT =3D =
value;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Add =
for VT3324 Integrated TV. =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
INTEGRATED_TV:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; =
set_integrated_tv_hue(value);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; <BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
default:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp; }<BR>+}<BR>+<BR>+/* Set TV =
Flicker Filter function only support VIA TV encoder */<BR>+void =
tv_set_ffilter(u32 state, u32 value)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; =
DEBUG_MSG(KERN_INFO "tv_set_ffilter!!\n");<BR>+&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; =
switch(chip_info.tv_chip_info.tv_chip_name)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1622:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1622A:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1623:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1625:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; if (state =3D=3D =
STATE_ON)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if ((value &lt; 0) || (value &gt; =
3))<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; if ((value =3D=3D 3) &amp;&amp; =
(chip_info.tv_chip_info.tv_chip_name !=3D =
VT1625))<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; /* Turn off adaptive ffilter. Adaptive ffilter is =
exclusive with ffilter =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; tv_register_write(0x62, =
(u8)(tv_register_read(0x62) &amp; =
~0x03));&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; /* Tuning the value of flicker filter. =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if =
(value)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tv_register_write(0x03, =
(u8)((tv_register_read(0x03) &amp; ~0x03) | =
(u8)(value)));<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_setting_info.CurrentFFilter =3D =
value;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; else /* value should be more than 0. =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tv_register_write(0x03, =
(u8)((tv_register_read(0x03) &amp; ~0x03) | =
(u8)(value+1)));<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_setting_info.CurrentFFilter =3D =
value+1;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
else /* turn off =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; tv_register_write(0x03, =
(u8)((tv_register_read(0x03) &amp; =
~0x03)));<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tv_setting_info.CurrentFFilter =3D =
STATE_OFF;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Add for =
VT3324 Integrated TV. */<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
INTEGRATED_TV:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; if (state =3D=3D =
STATE_ON)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; =
set_integrated_tv_ffilter_status(ITV_FILTER_TYPE_NORMAL, ITV_FILTER_ON, =
value);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
else<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; =
set_integrated_tv_ffilter_status(ITV_FILTER_TYPE_NORMAL, ITV_FILTER_OFF, =
value);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; <BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
default:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp; }<BR>+}<BR>+<BR>+<BR>+<BR>+/* =
<BR>+ *&nbsp; Purpose:<BR>+ *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Set status =
of TV Adaptive Flicker Filter and its degree. <BR>+ =
*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Currently, it only support VIA TV =
encoder.<BR>+ *&nbsp; Parameter:<BR>+ *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
status: ON/OFF tv adaptive flicker filter function.<BR>+ =
*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value: Degree of adaptive flicker =
filter.<BR>+ */<BR>+void tv_set_adaptive_ffilter(u32 status,u32 =
value)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; /* Adaptive FFilter ON =
*/<BR>+&nbsp;&nbsp;&nbsp; if (status =3D=3D =
STATE_ON)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
switch(chip_info.tv_chip_info.tv_chip_name)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
VT1622:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; case =
VT1622A:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; case VT1623: =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; /* Turn off normal flicker filter before turn on =
adaptive ffilter =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; tv_set_ffilter(STATE_OFF, =
0);<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Turn on adaptive flicker filter before =
change the value of deflicker threshold. =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; tv_register_write(0x62, =
(u8)((tv_register_read(0x62) &amp; ~0x03)| =
0x01));<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; /* Apply the value to deflicker threshold. =
*/&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; tv_register_write(0x61, =
(u8)value);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; /* Change adaptive ffilter state =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; tv_setting_info.AdaptiveFFilterOn =3D =
TRUE;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
VT1625:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Turn off normal flicker filter before =
turn on adaptive ffilter =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; tv_set_ffilter(STATE_OFF, =
0);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; /* VT1625 only use 62[7:2] to control ffilter =
threshold =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if ((value &gt; 0) &amp;&amp; (value &lt; =
64))<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Turn on adaptive =
flicker filter and assign value =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tv_register_write(0x62, =
(u8)(value&lt;&lt;2) | =
0x01);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Change adaptive ffilter state =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; tv_setting_info.AdaptiveFFilterOn =3D =
TRUE;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; /* Add for VT3324 Integrated TV. =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 case =
INTEGRATED_TV:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
set_integrated_tv_ffilter_status(ITV_FILTER_TYPE_ADAPTIVE, =
ITV_FILTER_ON, =
value);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; else&nbsp; /* Adaptive =
FFilter OFF */<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
switch(chip_info.tv_chip_info.tv_chip_name)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
VT1622:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; case =
VT1622A:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; case =
VT1623:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; case =
VT1625:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Turn off adaptive flicker filter and =
assign value =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; tv_register_write(0x62, =
(u8)(tv_register_read(0x62) &amp; =
~0x03));<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tv_setting_info.AdaptiveFFilterOn =3D =
FALSE;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; /* Add for VT3324 Integrated TV. =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 case =
INTEGRATED_TV:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
set_integrated_tv_ffilter_status(ITV_FILTER_TYPE_ADAPTIVE, =
ITV_FILTER_OFF, =
0);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; }<BR>+}<BR>+<BR>+<BR>+<BR>+/*<BR>+*&nbsp;&nbsp; =
Purpose:<BR>+*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Get flicker filter =
value<BR>+*&nbsp;&nbsp; =
Parameter:<BR>+*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ffilter_type: which =
type of flicker filter we want to =
get.<BR>+*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ffilter_state: this can =
be used to receive the current ffilter state.<BR>+*&nbsp;&nbsp; =
Return:<BR>+*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the value of flicker =
filter.<BR>+*&nbsp;&nbsp; <BR>+*/<BR>+int tv_get_ffilter(int =
ffilter_type, int* ffilter_state)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; int =
ffilter_value =3D 0;<BR>+&nbsp;&nbsp;&nbsp; int tmp_ffilter_state =3D =
0;<BR>+&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; =
switch(chip_info.tv_chip_info.tv_chip_name)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1622:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1622A:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1623:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1625:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; if (ffilter_type =3D=3D =
TV_FFILTER_TYPE_NORMAL)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; ffilter_value =3D (tv_register_read(0x03) &amp; =
0x03);<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* flicker filter use 03[1:0]. =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (ffilter_value &gt; =
0)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *ffilter_state =3D =
STATE_ON;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; =
else<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *ffilter_state =3D =
STATE_OFF;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
if (ffilter_type =3D=3D =
TV_FFILTER_TYPE_ADAPTIVE)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if (chip_info.tv_chip_info.tv_chip_name =3D=3D =
VT1625)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* VT1625 use 62[7:2] to =
save the value of deflicker threshold. =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ffilter_value =3D =
(tv_register_read(0x62) &amp; =
~0x03)&gt;&gt;2;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tmp_ffilter_state=3D tv_register_read(0x62) &amp; =
0x03;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; =
else<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ffilter_value =3D =
tv_register_read(0x61);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tmp_ffilter_state=3D tv_register_read(0x62) &amp; =
0x03;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; if (tmp_ffilter_state &gt; =
0)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *ffilter_state =3D =
STATE_ON;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; =
else<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *ffilter_state =3D =
STATE_OFF;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Add for VT3324 =
Integrated TV. */<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
INTEGRATED_TV:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; if (ffilter_type =3D=3D =
TV_FFILTER_TYPE_NORMAL)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; ffilter_value =3D =
get_integrated_tv_ffilter_status(ITV_FILTER_TYPE_NORMAL, =
ffilter_state);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; =
}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
else if (ffilter_type =3D=3D =
TV_FFILTER_TYPE_ADAPTIVE)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; ffilter_value =3D =
get_integrated_tv_ffilter_status(ITV_FILTER_TYPE_ADAPTIVE, =
ffilter_state);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; return =
ffilter_value;<BR>+}<BR>+<BR>+<BR>+<BR>+/* <BR>+ *&nbsp;&nbsp; =
Purpose:<BR>+ *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Set position of TV's =
screen.<BR>+ *&nbsp;&nbsp; Parameter:<BR>+ =
*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HPos: Horizontal position of =
screen.<BR>+ *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VPos: Verticle =
position of screen.<BR>+ */<BR>+void tv_set_position(u32 HPos, u32 =
VPos)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; /* Registers of horizontal position : =
TV06[3:0] + TV08[7:0]<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Registers =
of Vertical position: TV1C[3:1] + TV09[7:0] */<BR>+&nbsp;&nbsp;&nbsp; =
int new_hor_pos;<BR>+&nbsp;&nbsp;&nbsp; int =
new_ver_pos;<BR>+&nbsp;&nbsp;&nbsp; unsigned char =
high_bytes;<BR>+&nbsp;&nbsp;&nbsp; unsigned char =
low_bytes;<BR>+&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; if =
(chip_info.tv_chip_info.tv_chip_name =3D=3D =
INTEGRATED_TV)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Add for VT3324 =
Integrated TV. */<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
set_integrated_tv_pos(HPos, VPos);<BR>+&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; else /* VIA's TV encoder =
*/<BR>+&nbsp;&nbsp;&nbsp; { =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* First to get current =
postion */<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_get_position(&amp;new_hor_pos, =
&amp;new_ver_pos);<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
switch(chip_info.tv_chip_info.tv_chip_name)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case =
VT1622:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; case =
VT1622A:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; case =
VT1623:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Origin position of vt1623 is at =
down-left =
corner<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; New position is current =
position + shift =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; new_hor_pos +=3D HPos - =
tv_setting_info.CurrentPositionH;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new_ver_pos +=3D =
VPos - =
tv_setting_info.CurrentPositionV;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; /* Write new value of horizontal position to =
register. =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; high_bytes =3D ((new_hor_pos &gt;&gt; 8) &amp; =
0x0F) | =
tv_register_read(0x06);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; low_bytes =3D new_hor_pos =
&amp; =
0xFF;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; tv_register_write(0x06, =
high_bytes);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tv_register_write(0x08, =
low_bytes);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; /* Write new value of vertical position to =
register. =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; high_bytes =3D (((new_ver_pos &gt;&gt; 8) &amp; =
0x07) &lt;&lt; 1) | =
tv_register_read(0x1C);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; low_bytes =3D new_ver_pos =
&amp; =
0xFF;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; tv_register_write(0x1C, =
high_bytes);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tv_register_write(0x09, =
low_bytes);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; case =
VT1625:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Origin position of vt1625 is at =
down-right =
corner<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; New position is current =
position + shift =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; new_hor_pos -=3D HPos - =
tv_setting_info.CurrentPositionH;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new_ver_pos +=3D =
VPos - =
tv_setting_info.CurrentPositionV;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Write =
new value of horizontal position to register. =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; high_bytes =3D ((new_hor_pos &gt;&gt; 8) &amp; =
0x0F) | =
tv_register_read(0x06);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; low_bytes =3D new_hor_pos =
&amp; =
0xFF;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; tv_register_write(0x06, =
high_bytes);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tv_register_write(0x08, =
low_bytes);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; /* Write new value of vertical position to =
register. =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; high_bytes =3D (((new_ver_pos &gt;&gt; 8) &amp; =
0x07) &lt;&lt; 1) | =
tv_register_read(0x1C);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; low_bytes =3D new_ver_pos =
&amp; =
0xFF;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; tv_register_write(0x1C, =
high_bytes);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tv_register_write(0x09, =
low_bytes);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Save the value of =
current position */<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_setting_info.CurrentPositionH =3D =
HPos;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tv_setting_info.CurrentPositionV =3D VPos;<BR>+&nbsp;&nbsp;&nbsp; =
}<BR>+}<BR>+<BR>+<BR>+<BR>+/* <BR>+*&nbsp;&nbsp; =
Purpose:<BR>+*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Get position of TV's =
screen.<BR>+*&nbsp;&nbsp; =
Parameter:<BR>+*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HPos: Horizontal =
position of screen.<BR>+*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VPos: =
Verticle position of screen.<BR>+*/<BR>+void tv_get_position(u32* HPos, =
u32* VPos)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; if =
(chip_info.tv_chip_info.tv_chip_name =3D=3D =
INTEGRATED_TV)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
get_integrated_tv_pos(HPos, VPos);<BR>+&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; else<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *HPos =3D =
(((tv_register_read(0x06)&amp;0x0F)&lt;&lt;8) | tv_register_read(0x08)) =
&amp; 0x0FFF;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *VPos =3D =
(((tv_register_read(0x1C)&amp;0x0E)&lt;&lt;7) | tv_register_read(0x09)) =
&amp; 0x0FFF;<BR>+&nbsp;&nbsp;&nbsp; }<BR>+<BR>+}<BR>+<BR>+/* Set TV =
Flicker Filter function only support VIA TV encoder */<BR>+void =
tv_set_size(u32 HPos, u32 VPos)<BR>+{<BR>+&nbsp;<BR>+&nbsp;&nbsp;&nbsp; =
DEBUG_MSG(KERN_INFO "tv_set_size\n"); &nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; DEBUG_MSG(KERN_INFO "tv_set_size: =
pSetViewSizeValue-&gt;dwX=3D%d\n", HPos); <BR>+&nbsp;&nbsp;&nbsp; =
DEBUG_MSG(KERN_INFO "tv_set_size: pSetViewSizeValue-&gt;dwY=3D%d\n", =
VPos);&nbsp;&nbsp; &nbsp; <BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Add for VT3324 =
Integrated TV. */<BR>+&nbsp;&nbsp;&nbsp; if =
(chip_info.tv_chip_info.tv_chip_name =3D=3D =
INTEGRATED_TV)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
set_integrated_tv_size(HPos, =
VPos);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return;<BR>+&nbsp;&nbsp;&nbsp; }<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
tv_setting_info.CurrentScalH=3DHPos-1;<BR>+&nbsp;&nbsp;&nbsp; =
tv_setting_info.CurrentScalV=3DVPos-1;&nbsp;<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
switch (chip_info.tv_chip_info.tv_chip_name)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1621:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1622:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1622A:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1623:&nbsp;&nbsp;&nbsp; =
&nbsp;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; tv_setting_info.level =3D VPos - =
1;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 break;<BR>+ <BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
VT1625:&nbsp;&nbsp;&nbsp; =
&nbsp;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; if (VPos =3D=3D =
2)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; tv_setting_info.level =3D =
2;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =
else<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; tv_setting_info.level =3D VPos - =
1;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =
break;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; <BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
default:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; tv_setting_info.CurrentPositionH =3D =
0;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 tv_setting_info.CurrentPositionV =3D =
0;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 break;<BR>+&nbsp;&nbsp;&nbsp; }<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
DEBUG_MSG(KERN_INFO "tv_set_size:After set size, =
tv_setting_info.level=3D%d\n", tv_setting_info.level);&nbsp;&nbsp; =
&nbsp; <BR>+}<BR>+<BR>+/* Add this function to control TV clock source =
by case. */<BR>+void =
set_tv_clock_source(void)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; if =
(chip_info.tv_chip_info.tv_chip_name =3D=3D =
INTEGRATED_TV)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* From TVPLL. =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(tv_setting_info.iga_path =3D=3D =
IGA1)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_reg(CR6C, VIACR, =
0x50);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
else<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_reg(CR6C, VIACR, =
0x05);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; =
else<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* External TV: =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
((chip_info.gfx_chip_name =3D=3D UNICHROME_CLE266) &amp;&amp; =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
(chip_info.gfx_chip_revision =3D=3D =
CLE266_REVISION_AX))<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_reg_mask(CR6C, VIACR, 0x01, =
BIT0);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if =
(chip_info.gfx_chip_name =3D=3D =
UNICHROME_CX700)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* From DVP0 TV clock. =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 if (tv_setting_info.iga_path =3D=3D =
IGA1)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; write_reg(CR6C, VIACR, =
0xb0);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
else<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; write_reg(CR6C, VIACR, =
0x0b);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; }<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
else<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_reg_mask(CR6C, VIACR, BIT5+BIT0, =
BIT5+BIT0);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; }<BR>+}<BR>+/*check_macrovision_enabled: to =
check if MV is enabled =
<BR>+*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; according to TV encoder's registers 0x0F and =
0x30<BR>+*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; Currently only support VT1622 and VT1623 =
VT1625<BR>+*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; AlZhang[2006.04.24]<BR>+*/<BR>+int =
check_macrovision_enabled(void)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; u8 tv_r0f =
=3D 0,tv_r30 =3D 0;<BR>+&nbsp;&nbsp;&nbsp; =
switch(chip_info.tv_chip_info.tv_chip_name)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+<BR>+&nbsp;&nbsp;&nbsp; case VT1622:<BR>+&nbsp;&nbsp;&nbsp; case =
VT1622A:<BR>+&nbsp;&nbsp;&nbsp; case VT1623:<BR>+&nbsp;&nbsp;&nbsp; case =
VT1625:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tv_r0f =3D =
(u8)tv_register_read(0x0f);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; tv_r30 =3D =
(u8)tv_register_read(0x30);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; <BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+&nbsp;&nbsp;&nbsp; =
default:<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>+<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; =
if((tv_r0f&amp;0x80) &amp;&amp; =
(tv_r30&amp;0x30))<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
TRUE;<BR>+&nbsp;&nbsp;&nbsp; =
else<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
FALSE;<BR>+}<BR>+<BR>diff -Nur linux-2.6.21-rc7/drivers/video/via/tv.h =
linux-2.6.21-rc7.viafb/drivers/video/via/tv.h<BR>--- =
linux-2.6.21-rc7/drivers/video/via/tv.h&nbsp;1969-12-31 =
19:00:00.000000000 -0500<BR>+++ =
linux-2.6.21-rc7.viafb/drivers/video/via/tv.h&nbsp;2007-04-26 =
19:52:32.000000000 -0400<BR>@@ -0,0 +1,163 @@<BR>+/*<BR>+ * Copyright =
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
__TV_H__<BR>+#define __TV_H__<BR>+<BR>+#include =
&lt;linux/ioport.h&gt;<BR>+#include &lt;asm/io.h&gt;<BR>+<BR>+/* =
Definition TV System */<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
TVTYPE_NONE&nbsp;&nbsp;&nbsp;&nbsp; =
0x00<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
TVTYPE_NTSC&nbsp;&nbsp;&nbsp;&nbsp; =
0x01<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
TVTYPE_PAL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x02<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
TVTYPE_480P&nbsp;&nbsp;&nbsp;&nbsp; =
0x04<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
TVTYPE_576P&nbsp;&nbsp;&nbsp;&nbsp; =
0x08<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
TVTYPE_720P&nbsp;&nbsp;&nbsp;&nbsp; =
0x10<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; TVTYPE_1080I&nbsp;&nbsp;&nbsp; =
0x20<BR>+<BR>+/* Definition TV Level =
*/<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
TV_SIZE_NORMAL_SCAN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
TV_SIZE_FIT_SCAN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 1<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
TV_SIZE_OVER_SCAN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
2<BR>+<BR>+/* Definition TV Ouput Signal =
*/<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUTPUT_NONE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUTPUT_COMPOSITE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x01<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUTPUT_SVIDEO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x02<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUTPUT_RGB&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x04<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUTPUT_YPBPR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x08<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUTPUT_COMPOSITE_SVIDEO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; 0x10<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUTPUT_RGB_COMPOSITE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; 0x20<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUTPUT_YPBPR_COMPOSITE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; 0x40<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUTPUT_RGB_COMPOSITE_SVIDEO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x80<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUTPUT_YPBPR_COMPOSITE_SVIDEO&nbsp;&nbsp; 0x100<BR>+<BR>+<BR>+<BR>+/* =
Define TV Function Index */<BR>+#define =
TV_BASE_FUNC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<BR>+#define =
TV_RGB_FUNC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<BR>+#define =
TV_YPBPR_FUNC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 2<BR>+#define =
TV_SDTV_RGB_FUNC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 3<BR>+#define =
TV_SDTV_YPBPR_FUNC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
4<BR>+#define =
TV_DeDotCrawl_FUNC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
5<BR>+<BR>+<BR>+<BR>+#define =
NUM_CRTC_TIMING&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
12<BR>+<BR>+/* TV Table Relative Definition =
*/<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_REG_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 75<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
FS454_REG_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 82<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
SAA7108A_REG_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 67<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
CH7019_REG_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 24<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
GFX_IGA1_CRT_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; =
14&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* number of setting CRTC's registers on IGA1 in TV table =
*/<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
GFX_IGA2_CRT_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; =
16&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* number of setting CRTC's registers on IGA2 in TV table =
*/<BR>+<BR>+/* define TV DeDotCrawl Register =
*/<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_DEDOTCRAWL_REG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x11<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_DEDOTCRAWL_REG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x11<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_DEDOTCRAWL_REG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x11<BR>+<BR>+/* define TV Version register =
*/<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_VERSION_REG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x1B<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_VERSION&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 0x03<BR>+<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_VERSION_REG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x1B<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_VERSION&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 0x10<BR>+<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_VERSION_REG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x1B<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_VERSION&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 0x50<BR>+<BR>+<BR>+/* Define TV DAC =
*/<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_DAC_REG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 0x0E<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_DAC_A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BIT3<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_DAC_B&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BIT2<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_DAC_C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BIT1<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_DAC_D&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
BIT0<BR>+<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_DAC_REG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 0x0E<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_DAC_A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; BIT3<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_DAC_B&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; BIT2<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_DAC_C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; BIT1<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_DAC_D&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; BIT0<BR>+<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_DAC_REG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 0x0E<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_DAC_A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BIT5<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_DAC_B&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BIT4<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_DAC_C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BIT3<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_DAC_D&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BIT2<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_DAC_E&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BIT1<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_DAC_F&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BIT0<BR>+<BR>+<BR>+<BR>+<BR>+/* TV MACRO =
*/<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
GET_HIGH_BYTE(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (unsigned char)((x) =
&gt;&gt; 8)<BR>+#define&nbsp;&nbsp;&nbsp;&nbsp; =
GET_LOW_BYTE(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (unsigned =
char)((x) &amp; 0x00FF)<BR>+<BR>+/* We divide shift range into 11 =
partitions, so 6 is the center position. */<BR>+#define =
TV_POS_DEFAULT_HOR_VALUE&nbsp;&nbsp;&nbsp; 6<BR>+#define =
TV_POS_DEFAULT_VER_VALUE&nbsp;&nbsp;&nbsp; 6<BR>+<BR>+/* Definition TV =
Flicker Filter Type */<BR>+#define =
TV_FFILTER_TYPE_NORMAL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<BR>+#define =
TV_FFILTER_TYPE_ADAPTIVE&nbsp;&nbsp;&nbsp; 1<BR>+<BR>+<BR>+/* TV Common =
Function */<BR>+int&nbsp; tv_encoder_identify(void);<BR>+void =
tv_disable(void);<BR>+void tv_load_timing_init(void);<BR>+void =
tv_load_timing(int TVModeIndex);<BR>+void =
tv_load_timing_modify(void);<BR>+void tv_patch(int =
tv_mode_index);<BR>+void tv_enable(void);<BR>+void =
tv_register_write(int, u8);<BR>+int tv_register_read(int);<BR>+void =
tv_patch_skew_K800(void);<BR>+void tv_patch_skew_cn900(int =
tv_mode_index);<BR>+void tv_patch_skew_cx700(int =
tv_mode_index);<BR>+void tv_patch_skew_p880(int tv_mode_index);<BR>+void =
tv_set_color(void);<BR>+void tv_set_brightness(u32 value);<BR>+void =
tv_set_contrast(u32 value);<BR>+void tv_set_saturation(u32 =
value);<BR>+void tv_set_tint(u32 value);<BR>+void tv_set_ffilter(u32 =
state, u32 value);<BR>+void tv_set_adaptive_ffilter(u32 status, u32 =
value);<BR>+int tv_get_ffilter(int ffilter_type, int* ffilter_state); =
<BR>+void tv_set_position(u32 HPos, u32 VPos);<BR>+void =
tv_get_position(u32* HPos, u32* VPos);<BR>+void tv_set_size(u32 HPos, =
u32 VPos);<BR>+void set_tv_clock_source(void);<BR>+void =
tv_patch_skew_p4m900(int tv_mode_index);<BR>+void =
tv_patch_skew_k8m890(int tv_mode_index);<BR>+void =
tv_patch_skew_p4m890(int tv_mode_index);<BR>+<BR>+#endif /* __TV_H__ =
*/<BR>+<BR>diff -Nur linux-2.6.21-rc7/drivers/video/via/via_i2c.c =
linux-2.6.21-rc7.viafb/drivers/video/via/via_i2c.c<BR>--- =
linux-2.6.21-rc7/drivers/video/via/via_i2c.c&nbsp;1969-12-31 =
19:00:00.000000000 -0500<BR>+++ =
linux-2.6.21-rc7.viafb/drivers/video/via/via_i2c.c&nbsp;2007-04-26 =
19:52:32.000000000 -0400<BR>@@ -0,0 +1,478 @@<BR>+ /*<BR>+ * Copyright =
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
&lt;linux/ioport.h&gt;<BR>+#include &lt;asm/io.h&gt;<BR>+<BR>+#include =
"chip.h"<BR>+#include "debug.h"<BR>+#include "via_i2c.h"<BR>+#include =
"share.h"<BR>+<BR>+extern inline void write_reg(u8 index, u16 io_port, =
u8 data);<BR>+extern inline u8 read_reg(int io_port, u8 =
index);<BR>+<BR>+extern struct =
chip_information&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
chip_info;<BR>+extern struct tv_setting_information&nbsp;&nbsp;&nbsp; =
tv_setting_info;<BR>+<BR>+/* i2c delay for microsecond */<BR>+void =
delays(int count)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; volatile u8 =
data;<BR>+&nbsp;&nbsp;&nbsp; while (count--)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* delay 1 us =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D =
inb(DELAYPORT);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D =
inb(DELAYPORT);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D =
inb(DELAYPORT);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D =
inb(DELAYPORT);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D =
inb(DELAYPORT);<BR>+&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+}<BR>+<BR>+<BR>+/*&nbsp; Write I2C BUS SDA And SCL =
*/<BR>+void i2cWriteSdaScl(u8 sda, u8 scl)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; =
u8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data;<BR>+&nbsp;&nbsp;&nbsp; =
u16&nbsp;&nbsp;&nbsp;&nbsp; port_addr;<BR>+<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
if (chip_info.tv_chip_info.tv_chip_on_slot =3D=3D =
TV_ON_AMR)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D ((scl =
&lt;&lt; 1) | sda) &lt;&lt; =
4;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D data | =
BIT0;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; /* enable I2C port =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; port_addr =3D =
TVI2CPORT;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_reg(TVI2CPORTINDEX, port_addr, data); /* Write Register Value =
*/<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; =
else<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(chip_info.tv_chip_info.tv_chip_on_slot =3D=3D =
TV_ON_AGP)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
data =3D ((scl &lt;&lt; 1) | sda) &lt;&lt; =
4;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 data =3D data | =
(BIT6+BIT7);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
enable GPIO write port =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 port_addr =3D =
TVGPIOPORT;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; write_reg (TVGPIOPORTINDEX, port_addr, data);&nbsp;&nbsp; /* =
Write Register Value =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; }<BR>+}<BR>+<BR>+void i2cWriteScl(u8 =
scl)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; u8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
data;<BR>+&nbsp;&nbsp;&nbsp; u16&nbsp;&nbsp;&nbsp;&nbsp; =
port_addr;<BR>+<BR>+<BR>+&nbsp;&nbsp;&nbsp; if =
(chip_info.tv_chip_info.tv_chip_on_slot =3D=3D =
TV_ON_AMR)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D (scl =
&lt;&lt; 1)&lt;&lt; 4;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
data =3D data | =
BIT0;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; /* enable I2C port =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; port_addr =3D =
TVI2CPORT;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
write_reg(TVI2CPORTINDEX, port_addr, data); /* Write Register Value =
*/<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; =
else<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(chip_info.tv_chip_info.tv_chip_on_slot =3D=3D =
TV_ON_AGP)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
data =3D (scl &lt;&lt; 1) &lt;&lt; =
4;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; data =3D data &amp; =
0xBF;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* enable GPIO =
write clock =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 port_addr =3D =
TVGPIOPORT;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; write_reg (TVGPIOPORTINDEX, port_addr, data);&nbsp;&nbsp; /* =
Write Register Value */<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; }<BR>+}<BR>+<BR>+void i2cReadSdaScl(u8 *pSda, =
u8 *pScl)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; u8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
data;<BR>+&nbsp;&nbsp;&nbsp; u16&nbsp;&nbsp;&nbsp;&nbsp; =
port_addr;<BR>+<BR>+&nbsp;&nbsp;&nbsp; if =
(chip_info.tv_chip_info.tv_chip_on_slot =3D=3D =
TV_ON_AMR)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; port_addr =3D =
TVI2CPORT;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D =
read_reg(port_addr, =
TVI2CPORTINDEX);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *pSda =
=3D (data &gt;&gt; 2) &amp; BIT0;&nbsp;&nbsp;&nbsp;&nbsp; /* get sda =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *pScl =3D (data =
&gt;&gt; 3) &amp; BIT0;&nbsp;&nbsp;&nbsp;&nbsp; /* get scl =
*/<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; =
else<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(chip_info.tv_chip_info.tv_chip_on_slot =3D=3D =
TV_ON_AGP)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
port_addr =3D =
TVGPIOPORT;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; data =3D&nbsp; read_reg(port_addr, =
TVGPIOPORTINDEX);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; *pSda =3D (data &gt;&gt; 2) &amp; =
BIT0;&nbsp;&nbsp;&nbsp;&nbsp; /* get sda =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 *pScl =3D (data &gt;&gt; 3) &amp; BIT0;&nbsp;&nbsp;&nbsp;&nbsp; /* get =
scl */<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; }<BR>+}<BR>+<BR>+<BR>+void =
i2cWriteSdaSclDelay(u8 sda, u8 scl)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; =
i2cWriteSdaScl(sda, scl);<BR>+&nbsp;&nbsp;&nbsp; =
delays(16);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Wait 16 uS */<BR>+}<BR>+<BR>+void =
i2cStartSignal(void)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; =
i2cWriteSdaSclDelay(1,1);<BR>+&nbsp;&nbsp;&nbsp; =
i2cWriteSdaSclDelay(0,1);<BR>+&nbsp;&nbsp;&nbsp; =
i2cWriteSdaSclDelay(0,0);<BR>+}<BR>+<BR>+void =
i2cStopSignal(void)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; =
u8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data;<BR>+&nbsp;&nbsp;&nbsp; =
u16&nbsp;&nbsp;&nbsp;&nbsp; port_addr;<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
i2cWriteSdaSclDelay(0,0);<BR>+&nbsp;&nbsp;&nbsp; =
i2cWriteSdaSclDelay(0,1);<BR>+&nbsp;&nbsp;&nbsp; =
i2cWriteSdaSclDelay(1,1);<BR>+<BR>+&nbsp;&nbsp;&nbsp; if =
(chip_info.tv_chip_info.tv_chip_on_slot =3D=3D =
TV_ON_AGP)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D =
0x3c;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
disable GPIO write port =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; port_addr =3D =
TVGPIOPORT;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg =
(TVGPIOPORTINDEX, port_addr, data);&nbsp;&nbsp; /* Write Register Value =
*/<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; =
delays(2);<BR>+<BR>+}<BR>+<BR>+void =
disableSdaGPIO(void)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; =
u8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data;<BR>+&nbsp;&nbsp;&nbsp; =
u16&nbsp;&nbsp;&nbsp;&nbsp; port_addr;<BR>+<BR>+&nbsp;&nbsp;&nbsp; if =
(chip_info.tv_chip_info.tv_chip_on_slot =3D=3D =
TV_ON_AGP)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
port_addr =3D =
TVGPIOPORT;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; data =3D read_reg(port_addr, =
TVGPIOPORTINDEX);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; data =3D data &amp; =
(~BIT6);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* disable =
GPIO write port =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 write_reg (TVGPIOPORTINDEX, port_addr, data);&nbsp;&nbsp; /* Write =
Register Value */<BR>+&nbsp;&nbsp;&nbsp; }<BR>+}<BR>+<BR>+void =
enableSdaGPIO(void)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; u8&nbsp; =
data;<BR>+&nbsp;&nbsp;&nbsp; u16 port_addr;<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
if (chip_info.tv_chip_info.tv_chip_on_slot =3D=3D =
TV_ON_AGP)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
port_addr =3D =
TVGPIOPORT;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; data =3D read_reg(port_addr, =
TVGPIOPORTINDEX);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; data =3D data | =
(BIT6);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; /* disable GPIO write port =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 write_reg (TVGPIOPORTINDEX, port_addr, data);&nbsp;&nbsp; /* Write =
Register Value */<BR>+&nbsp;&nbsp;&nbsp; }<BR>+}<BR>+<BR>+void =
writeSclGPIO(u8 scl)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; =
u8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data;<BR>+&nbsp;&nbsp;&nbsp; =
u16&nbsp;&nbsp;&nbsp;&nbsp; port_addr;<BR>+<BR>+&nbsp;&nbsp;&nbsp; if =
(chip_info.tv_chip_info.tv_chip_on_slot =3D=3D =
TV_ON_AGP)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; port_addr =3D =
TVGPIOPORT;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D =
read_reg(port_addr, =
TVGPIOPORTINDEX);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =
=3D data &amp; (~BIT5);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
data =3D (data | (scl&lt;&lt;5)) &amp; =
(~BIT6);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* write data to clock =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg =
(TVGPIOPORTINDEX, port_addr, data);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Write Register Value */<BR>+&nbsp;&nbsp;&nbsp; }<BR>+}<BR>+<BR>+void =
writeSdaGPIO(u8 sda)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; =
u8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data;<BR>+&nbsp;&nbsp;&nbsp; =
u16&nbsp;&nbsp;&nbsp;&nbsp; port_addr;<BR>+<BR>+&nbsp;&nbsp;&nbsp; if =
(chip_info.tv_chip_info.tv_chip_on_slot =3D=3D =
TV_ON_AGP)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; port_addr =3D =
TVGPIOPORT;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D =
read_reg(port_addr, =
TVGPIOPORTINDEX);<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
data =3D data &amp; =
(~BIT4);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D (data | =
(sda&lt;&lt;4)) &amp; =
(~BIT7);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* write data to clock =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg =
(TVGPIOPORTINDEX, port_addr, data);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Write Register Value */<BR>+&nbsp;&nbsp;&nbsp; }<BR>+}<BR>+<BR>+void =
enableGPIO(void)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; u8&nbsp; =
data;<BR>+&nbsp;&nbsp;&nbsp; u16 port_addr;<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
if (chip_info.tv_chip_info.tv_chip_on_slot =3D=3D =
TV_ON_AGP)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; port_addr =3D =
TVGPIOPORT;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D =
read_reg(port_addr, =
TVGPIOPORTINDEX);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =
=3D data | =
(BIT4+BIT5+BIT6+BIT7);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* enable GPIO write port =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg =
(TVGPIOPORTINDEX, port_addr, data);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Write Register Value */<BR>+&nbsp;&nbsp;&nbsp; }<BR>+}<BR>+<BR>+void =
releaseGPIO(void)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; =
u8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data;<BR>+&nbsp;&nbsp;&nbsp; =
u16&nbsp;&nbsp;&nbsp;&nbsp; port_addr;<BR>+<BR>+&nbsp;&nbsp;&nbsp; if =
(chip_info.tv_chip_info.tv_chip_on_slot =3D=3D =
TV_ON_AGP)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; port_addr =3D =
TVGPIOPORT;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; port_addr =3D =
port_addr + 1;<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =
=3D read_reg(port_addr, =
TVGPIOPORTINDEX);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =
=3D data &amp; =
0x3c;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* disable GPIO write port */ =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; port_addr =3D =
TVGPIOPORT;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_reg =
(TVGPIOPORTINDEX, port_addr, data);&nbsp;&nbsp; /* Write Register Value =
*/<BR>+&nbsp;&nbsp;&nbsp; }<BR>+}<BR>+<BR>+int =
i2CWaitForSlave(void)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; int time_out =3D =
20000;<BR>+&nbsp;&nbsp;&nbsp; u8 sda, scl;<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
while (time_out--)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2cReadSdaScl(&amp;sda, =
&amp;scl);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(scl)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
(OK);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Successful stall */<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
delays(1);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; /* wait 1 uS */<BR>+&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; return =
(FAIL);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; /* Slave fail */<BR>+}<BR>+<BR>+int i2cOutByte(u8 =
data)<BR>+{<BR>+&nbsp;&nbsp;&nbsp; u8 sda, scl;<BR>+&nbsp;&nbsp;&nbsp; =
u8 out_byte;<BR>+&nbsp;&nbsp;&nbsp; int bit_count =3D =
8;<BR>+&nbsp;&nbsp;&nbsp; int status;<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
out_byte =3D data;<BR>+&nbsp;&nbsp;&nbsp; while =
(bit_count--)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sda =3D (out_byte =
&gt;&gt; 7) &amp; 1;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Load MSB =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; out_byte =3D out_byte =
&lt;&lt; 1;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* next bit. =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
i2cWriteSdaSclDelay(sda, =
0);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
i2cWriteSdaSclDelay(sda, =
1);<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status =3D =
i2CWaitForSlave();<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(status =3D=3D FAIL)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return (status);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
i2cWriteSdaSclDelay(sda, 0);<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp; if =
((chip_info.tv_chip_info.tv_chip_on_slot =3D=3D =
TV_ON_AGP))<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
writeSclGPIO(0);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
disableSdaGPIO();<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
delays(2);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
writeSclGPIO(1);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
delays(2);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
i2cReadSdaScl(&amp;sda, =
&amp;scl);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
writeSclGPIO(0);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
delays(2);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (sda =3D=3D =
0)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
status =3D OK;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
else<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
status =3D FAIL;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; =
else<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
i2cWriteSdaSclDelay(1,0);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
i2cWriteSdaSclDelay(1,1);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
status =3D =
i2CWaitForSlave();<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(status =3D=3D FAIL)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return (status);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
i2cReadSdaScl(&amp;sda, =
&amp;scl);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (sda =3D=3D =
0)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
i2cWriteSdaSclDelay(1,0);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; status =3D =
OK;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
else<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; =
i2cWriteSdaSclDelay(1,0);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; status =3D =
FAIL;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; return =
(status);<BR>+}<BR>+<BR>+int i2cInputByte(u8 *pInByte, int =
ack)<BR>+{<BR>+<BR>+&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp; =
bit_count =3D 8;<BR>+&nbsp;&nbsp;&nbsp; u8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
sda, scl;<BR>+&nbsp;&nbsp;&nbsp; u8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =
=3D 0;<BR>+&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp; =
status;<BR>+<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
disableSdaGPIO();<BR>+<BR>+&nbsp;&nbsp;&nbsp; while =
(bit_count--)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
((chip_info.tv_chip_info.tv_chip_on_slot =3D=3D =
TV_ON_AGP))<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; =
writeSclGPIO(1);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; =
delays(2);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; status =3D =
i2CWaitForSlave();<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; if (status =3D=3D =
FAIL)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return =
(FAIL);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; i2cReadSdaScl(&amp;sda, =
&amp;scl);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; data =3D data &lt;&lt; =
1;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 data |=3D =
sda;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; =
writeSclGPIO(0);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; =
delays(2);<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
else<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
i2cWriteSdaSclDelay(1,1);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; status =3D =
i2CWaitForSlave();<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; if (status =3D=3D =
FAIL)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; =
return(FAIL);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; i2cReadSdaScl(&amp;sda, =
&amp;scl);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; data =3D data &lt;&lt; =
1;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 data |=3D =
sda;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; i2cWriteSdaSclDelay(1, =
0);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; *pInByte =3D =
data;<BR>+<BR>+&nbsp;&nbsp;&nbsp; if (ack)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2cWriteSdaSclDelay(0, =
0);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
i2cWriteSdaSclDelay(0, =
1);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status =3D =
i2CWaitForSlave();<BR>+&nbsp;&nbsp;&nbsp; if (status =3D=3D =
FAIL)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return(status);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
i2cWriteSdaSclDelay(0, 0);<BR>+&nbsp;&nbsp;&nbsp; =
}<BR>+&nbsp;&nbsp;&nbsp; else<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2cWriteSdaSclDelay(1, =
0);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
i2cWriteSdaSclDelay(1, =
1);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status =3D =
i2CWaitForSlave();<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(status =3D=3D =
FAIL)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return(status);<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; =
i2cWriteSdaSclDelay(1, 0);<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
return(OK);<BR>+}<BR>+<BR>+int i2cReadByte(u8 slave_addr, u8 index, u8 =
*pData)<BR>+{<BR>+<BR>+&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp; =
status;<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
i2cStartSignal();<BR>+<BR>+&nbsp;&nbsp;&nbsp; status =3D =
i2cOutByte(slave_addr);<BR>+&nbsp;&nbsp;&nbsp; if (status =3D=3D =
FAIL)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
i2cStopSignal();<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return(FAIL);<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; status =3D =
i2cOutByte(index);<BR>+<BR>+&nbsp;&nbsp;&nbsp; if (status =3D=3D =
FAIL)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
i2cStopSignal();<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
(FAIL);<BR>+&nbsp;&nbsp;&nbsp; }<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
i2cStartSignal();<BR>+&nbsp;&nbsp;&nbsp; status =3D =
i2cOutByte(slave_addr | BIT0);<BR>+&nbsp;&nbsp;&nbsp; if (status =3D=3D =
FAIL)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
i2cStopSignal();<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
(FAIL);<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; status =3D =
i2cInputByte(pData, 0);<BR>+&nbsp;&nbsp;&nbsp; if (status =3D=3D =
FAIL)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
i2cStopSignal();<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
(FAIL);<BR>+&nbsp;&nbsp;&nbsp; }<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
i2cStopSignal();<BR>+&nbsp;&nbsp;&nbsp; return(OK);<BR>+}<BR>+<BR>+int =
i2cWriteByte(u8 slave_addr, u8 index, u8 =
data)<BR>+{<BR>+<BR>+&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp; =
status;<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
i2cStartSignal();<BR>+&nbsp;&nbsp;&nbsp; status =3D =
i2cOutByte(slave_addr);<BR>+&nbsp;&nbsp;&nbsp; if (status =3D=3D =
FAIL)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
i2cStopSignal();<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return(FAIL);<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; status =3D =
i2cOutByte(index);<BR>+&nbsp;&nbsp;&nbsp; if (status =3D=3D =
FAIL)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
i2cStopSignal();<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return(FAIL);<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; status =3D =
i2cOutByte(data);<BR>+&nbsp;&nbsp;&nbsp; if (status =3D=3D =
FAIL)<BR>+&nbsp;&nbsp;&nbsp; =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
i2cStopSignal();<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return(FAIL);<BR>+&nbsp;&nbsp;&nbsp; }<BR>+&nbsp;&nbsp;&nbsp; =
i2cStopSignal();<BR>+&nbsp;&nbsp;&nbsp; return(OK);<BR>+}<BR>diff -Nur =
linux-2.6.21-rc7/drivers/video/via/via_i2c.h =
linux-2.6.21-rc7.viafb/drivers/video/via/via_i2c.h<BR>--- =
linux-2.6.21-rc7/drivers/video/via/via_i2c.h&nbsp;1969-12-31 =
19:00:00.000000000 -0500<BR>+++ =
linux-2.6.21-rc7.viafb/drivers/video/via/via_i2c.h&nbsp;2007-04-26 =
19:52:32.000000000 -0400<BR>@@ -0,0 +1,38 @@<BR>+ /*<BR>+ * Copyright =
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
__VIA_I2C_H__<BR>+#define __VIA_I2C_H__<BR>+<BR>+#define =
TVI2CPORT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x3c4<BR>+#define TVI2CPORTINDEX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x31<BR>+#define =
TVGPIOPORT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x3C4<BR>+#define TVGPIOPORTINDEX&nbsp;&nbsp;&nbsp;&nbsp; =
0x2C<BR>+#define =
I2C_BUS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; 1<BR>+#define =
GPIO_BUS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 2<BR>+#define =
DELAYPORT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x3C3<BR>+<BR>+#endif /* __VIA_I2C_H__ */<BR>+<BR>diff -Nur =
linux-2.6.21-rc7/drivers/video/via/viamode.h =
linux-2.6.21-rc7.viafb/drivers/video/via/viamode.h<BR>--- =
linux-2.6.21-rc7/drivers/video/via/viamode.h&nbsp;1969-12-31 =
19:00:00.000000000 -0500<BR>+++ =
linux-2.6.21-rc7.viafb/drivers/video/via/viamode.h&nbsp;2007-04-26 =
19:52:32.000000000 -0400<BR>@@ -0,0 +1,351 @@<BR>+/*<BR>+ * Copyright =
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
__VIAMODE_H__<BR>+#define __VIAMODE_H__<BR>+<BR>+#include =
"share.h"<BR>+<BR>+<BR>+struct VPITTable {<BR>+&nbsp; unsigned =
char&nbsp; Misc;<BR>+&nbsp; unsigned char&nbsp; SR[StdSR];<BR>+&nbsp; =
unsigned char&nbsp; GR[StdGR];<BR>+&nbsp; unsigned char&nbsp; =
AR[StdAR];<BR>+};<BR>+<BR>+struct VideoModeTable {<BR>+&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ModeIndex;<BR>+&nbsp; struct =
crt_mode_table&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; *crtc;<BR>+&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mode_array;<BR>+};<BR>+<BR>+struct =
patch_table {<BR>+&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
mode_index;<BR>+&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
table_length;<BR>+&nbsp; struct io_reg =
*io_reg_table;<BR>+};<BR>+<BR>+struct res_map_refresh {<BR>+&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hres;<BR>+&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vres;<BR>+&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pixclock;<BR>+&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
vmode_refresh;<BR>+};<BR>+<BR>+<BR>+/********************/<BR>+/* Mode =
Table&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+/********************/<BR>+<BR>+/* 640x480 */<BR>+static struct =
crt_mode_table CRTM640x480[] =3D {<BR>+&nbsp; /* r_rate,vclk,hsp,vsp =
*/<BR>+&nbsp; /* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; =
VA,&nbsp; VBS, VBE, VSS, VSE */<BR>+&nbsp; {REFRESH_60, CLK_25_175M =
,M640X480_R60_HSP, M640X480_R60_VSP,\<BR>+&nbsp; {800, 640, 648, 144, =
656, 96,&nbsp; 525, 480, 480, 45,&nbsp; 490, 2}},<BR>+&nbsp; =
{REFRESH_75, CLK_31_500M ,M640X480_R75_HSP, =
M640X480_R75_VSP,\<BR>+&nbsp; {840, 640, 640, 200, 656, 64,&nbsp; 500, =
480, 480, 20,&nbsp; 481, 3}},<BR>+&nbsp; {REFRESH_85, CLK_36_000M =
,M640X480_R85_HSP, M640X480_R85_VSP,\<BR>+&nbsp; {832, 640, 640, 192, =
696, 56,&nbsp; 509, 480, 480, 29,&nbsp; 481, 3}},<BR>+&nbsp; =
{REFRESH_100,CLK_43_163M ,M640X480_R100_HSP, =
M640X480_R100_VSP,\<BR>+&nbsp; {848, 640, 640, 208, 680, 64,&nbsp; 509, =
480, 480, 29,&nbsp; 481, 3}}, /* GTF */<BR>+&nbsp; =
{REFRESH_120,CLK_52_406M ,M640X480_R120_HSP, =
M640X480_R120_VSP,\<BR>+&nbsp; {848, 640, 640, 208, 680, 64,&nbsp; 515, =
480, 480, 35,&nbsp; 481, 3}}&nbsp; /* GTF */<BR>+};<BR>+<BR>+/* 720x480 =
(GTF) */<BR>+static struct crt_mode_table CRTM720x480[] =3D {<BR>+&nbsp; =
/* r_rate,vclk,hsp,vsp */&nbsp;&nbsp;&nbsp;&nbsp; <BR>+&nbsp; /* HT, =
HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, VSS, VSE =
*/<BR>+&nbsp; {REFRESH_60,CLK_26_880M ,M720X480_R60_HSP, =
M720X480_R60_VSP,\<BR>+&nbsp; {896, 720, 720, 176, 736, 72,&nbsp; 497, =
480, 480, 17,&nbsp; 481, 3}}<BR>+<BR>+};<BR>+<BR>+/* 720x576 (GTF) =
*/<BR>+static struct crt_mode_table CRTM720x576[] =3D {<BR>+&nbsp; /* =
r_rate,vclk,hsp,vsp */<BR>+&nbsp; /* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, =
HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, VSS, VSE */<BR>+&nbsp; =
{REFRESH_60,CLK_32_668M ,M720X576_R60_HSP, M720X576_R60_VSP,\<BR>+&nbsp; =
{912, 720, 720, 192, 744, 72,&nbsp; 597, 576, 576, 21,&nbsp; 577, =
3}}<BR>+};<BR>+<BR>+/* 800x480 (GTF) */<BR>+static struct crt_mode_table =
CRTM800x480[] =3D {<BR>+&nbsp; /* r_rate,vclk,hsp,vsp */<BR>+&nbsp; /* =
HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp; {REFRESH_60,CLK_29_581M =
,M800X480_R60_HSP,M800X480_R60_VSP,\<BR>+&nbsp; {992, 800, 800, 192, =
816, 80,&nbsp; 497, 480, 480, 17,&nbsp; 481, 3}}<BR>+};<BR>+/* 800x600 =
*/<BR>+static struct crt_mode_table CRTM800x600[] =3D {<BR>+&nbsp; /* =
r_rate,vclk,hsp,vsp */&nbsp;&nbsp;&nbsp;&nbsp; <BR>+&nbsp; /* =
HT,&nbsp;&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, =
VBE, VSS, VSE */<BR>+&nbsp; {REFRESH_60, CLK_40_000M ,M800X600_R60_HSP, =
M800X600_R60_VSP,\<BR>+&nbsp; {1056, 800, 800, 256, 840, 128, 628, 600, =
600, 28,&nbsp; 601, 4}},<BR>+&nbsp; {REFRESH_75, CLK_49_500M =
,M800X600_R75_HSP, M800X600_R75_VSP,\<BR>+&nbsp; {1056, 800, 800, 256, =
816, 80,&nbsp; 625, 600, 600, 25,&nbsp; 601, 3}},<BR>+&nbsp; =
{REFRESH_85, CLK_56_250M ,M800X600_R85_HSP, =
M800X600_R85_VSP,\<BR>+&nbsp; {1048, 800, 800, 248, 832, 64,&nbsp; 631, =
600, 600, 31,&nbsp; 601, 3}},<BR>+&nbsp; {REFRESH_100,CLK_68_179M =
,M800X600_R100_HSP, M800X600_R100_VSP,\<BR>+&nbsp; {1072, 800, 800, 272, =
848, 88,&nbsp; 636, 600, 600, 36,&nbsp; 601, 3}},<BR>+&nbsp; =
{REFRESH_120,CLK_83_950M ,M800X600_R120_HSP, =
M800X600_R120_VSP,\<BR>+&nbsp; {1088, 800, 800, 288, 856, 88,&nbsp; 643, =
600, 600, 43,&nbsp; 601, 3}}<BR>+};<BR>+/* 848x480 (GTF) */<BR>+static =
struct crt_mode_table CRTM848x480[] =3D {<BR>+&nbsp; /* =
r_rate,vclk,hsp,vsp */&nbsp;&nbsp;&nbsp;&nbsp; <BR>+&nbsp; /* =
HT,&nbsp;&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, =
VBE, VSS, VSE */<BR>+&nbsp; {REFRESH_60,CLK_31_490M ,M848X480_R60_HSP, =
M848X480_R60_VSP,\<BR>+&nbsp; {1056, 848, 848, 208, 864, 88,&nbsp; 497, =
480, 480, 17,&nbsp; 481, 3}}<BR>+};<BR>+<BR>+/* 856x480 (GTF) convert to =
852x480 */<BR>+static struct crt_mode_table CRTM852x480[] =3D =
{<BR>+&nbsp; /* r_rate,vclk,hsp,vsp */&nbsp;&nbsp;&nbsp; <BR>+&nbsp; /* =
HT,&nbsp;&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, =
VBE, VSS, VSE */<BR>+&nbsp; {REFRESH_60,CLK_31_728M ,M852X480_R60_HSP, =
M852X480_R60_VSP,\<BR>+&nbsp; {1064, 856, 856, 208, 872, 88,&nbsp; 497, =
480, 480, 17,&nbsp; 481, 3}}<BR>+<BR>+};<BR>+<BR>+/* 1024x512 (GTF) =
*/<BR>+static struct crt_mode_table CRTM1024x512[] =3D {<BR>+&nbsp; /* =
r_rate,vclk,hsp,vsp */&nbsp;&nbsp;&nbsp; <BR>+&nbsp; /* HT,&nbsp;&nbsp; =
HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, VSS, VSE =
*/<BR>+&nbsp; {REFRESH_60,CLK_41_291M ,M1024X512_R60_HSP, =
M1024X512_R60_VSP,\<BR>+&nbsp; {1296, 1024,1024,272, 1056,104, 531, 512, =
512, 19,&nbsp; 513, 3}}<BR>+<BR>+};<BR>+<BR>+/* 1024x576 (GTF) =
*/<BR>+/*static struct crt_mode_table CRTM1024x576[] =3D {<BR>+&nbsp; =
//r_rate,vclk,&nbsp;&nbsp;&nbsp;&nbsp; HT,&nbsp;&nbsp; HA,&nbsp; HBS, =
HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, VSS, VSE<BR>+&nbsp; { =
60,CLK_46_996M ,{1312, 1024,1024,288, 1064,104, 597, 576, 576, 21,&nbsp; =
577, 3}}<BR>+<BR>+};*/<BR>+<BR>+/* 1024x768 */<BR>+static struct =
crt_mode_table CRTM1024x768[] =3D {<BR>+&nbsp; /* r_rate,vclk,hsp,vsp =
*/<BR>+&nbsp; /* HT,&nbsp; HA,&nbsp;&nbsp; HBS,&nbsp; HBE, HSS,&nbsp; =
HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, VSS, VSE */<BR>+&nbsp; =
{REFRESH_60,CLK_65_000M ,M1024X768_R60_HSP, =
M1024X768_R60_VSP,\<BR>+&nbsp; {1344, 1024, 1024, 320, 1048, 136, 806, =
768, 768, 38,&nbsp; 771, 6}},<BR>+&nbsp; {REFRESH_75,CLK_78_750M =
,M1024X768_R75_HSP, M1024X768_R75_VSP,\<BR>+&nbsp; {1312, 1024, 1024, =
288, 1040, 96,&nbsp; 800, 768, 768, 32,&nbsp; 769, 3}},<BR>+&nbsp; =
{REFRESH_85,CLK_94_500M ,M1024X768_R85_HSP, =
M1024X768_R85_VSP,\<BR>+&nbsp; {1376, 1024, 1024, 352, 1072, 96,&nbsp; =
808, 768, 768, 40,&nbsp; 769, 3}},<BR>+&nbsp; =
{REFRESH_100,CLK_133_308M,M1024X768_R100_HSP, =
M1024X768_R100_VSP,\<BR>+&nbsp; {1392, 1024, 1024, 368, 1096, 112, 814, =
768, 768, 46,&nbsp; 769, 3}} //GTF<BR>+};<BR>+<BR>+/* 1152x864 =
*/<BR>+static struct crt_mode_table CRTM1152x864[] =3D {<BR>+&nbsp; /* =
r_rate,vclk,hsp,vsp */&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>+&nbsp; /* =
HT,&nbsp; HA,&nbsp;&nbsp; HBS,&nbsp; HBE, HSS,&nbsp; HSE, VT,&nbsp; =
VA,&nbsp; VBS, VBE, VSS, VSE */<BR>+&nbsp; {REFRESH_75,CLK_108_000M =
,M1152X864_R75_HSP, M1152X864_R75_VSP,\<BR>+&nbsp; {1600, 1152,1152, =
448, 1216, 128, 900, 864, 864, 36,&nbsp; 865, =
3}}<BR>+<BR>+};<BR>+<BR>+/* 1280x720 (GTF) */<BR>+static struct =
crt_mode_table CRTM1280x720[] =3D {<BR>+&nbsp; /* r_rate,vclk,hsp,vsp =
*/<BR>+&nbsp; /* HT,&nbsp; HA,&nbsp;&nbsp; HBS,&nbsp; HBE, HSS,&nbsp; =
HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, VSS, VSE =
*/&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>+&nbsp; {REFRESH_60,CLK_74_481M =
,M1280X720_R60_HSP, M1280X720_R60_VSP,\<BR>+&nbsp; {1664,1280, 1280, =
384, 1336, 136, 746, 720, 720, 26,&nbsp; 721, 3}}<BR>+};<BR>+<BR>+/* =
1280x768 (GTF) */<BR>+static struct crt_mode_table CRTM1280x768[] =3D =
{<BR>+&nbsp; /* r_rate,vclk,hsp,vsp */&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp; /* HT,&nbsp; HA,&nbsp;&nbsp; HBS,&nbsp; HBE, HSS,&nbsp; HSE, =
VT,&nbsp; VA,&nbsp; VBS, VBE, VSS, VSE */<BR>+&nbsp; =
{REFRESH_60,CLK_80_136M ,M1280X768_R60_HSP, =
M1280X768_R60_VSP,\<BR>+&nbsp; {1680,1280, 1280, 400, 1344, 136, 795, =
768, 768, 27,&nbsp; 769, 3}}<BR>+};<BR>+<BR>+/*1280x960 */<BR>+static =
struct crt_mode_table CRTM1280x960[] =3D {<BR>+&nbsp; /* =
r_rate,vclk,hsp,vsp */ <BR>+&nbsp; /* HT,&nbsp; HA,&nbsp;&nbsp; =
HBS,&nbsp; HBE, HSS,&nbsp; HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, VSS, VSE =
*/<BR>+&nbsp; {REFRESH_60,CLK_108_000M ,M1280X960_R60_HSP, =
M1280X960_R60_VSP,\<BR>+&nbsp; {1800,1280, 1280, 520, 1376, 112, =
1000,960, 960, 40,&nbsp; 961, 3}}&nbsp; <BR>+};<BR>+<BR>+/* 1280x1024 =
*/<BR>+static struct crt_mode_table CRTM1280x1024[] =3D {<BR>+&nbsp; /* =
r_rate,vclk,,hsp,vsp */<BR>+&nbsp; /* HT,&nbsp; HA,&nbsp;&nbsp; =
HBS,&nbsp; HBE, HSS,&nbsp; HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, VSS, VSE =
*/<BR>+&nbsp; {REFRESH_60,CLK_108_000M ,M1280X1024_R60_HSP, =
M1280X1024_R60_VSP,\<BR>+&nbsp; {1688,1280, 1280, 408, 1328, 112, =
1066,1024,1024,42,&nbsp; 1025,3}},<BR>+&nbsp; {REFRESH_75,CLK_135_000M =
,M1280X1024_R75_HSP, M1280X1024_R75_VSP,\<BR>+&nbsp; {1688,1280, 1280, =
408, 1296, 144, 1066,1024,1024,42,&nbsp; 1025,3}},<BR>+&nbsp; =
{REFRESH_85,CLK_157_500M ,M1280X1024_R85_HSP, =
M1280X1024_R85_VSP,\<BR>+&nbsp; {1728,1280, 1280, 448, 1344, 160, =
1072,1024,1024,48,&nbsp; 1025,3}}<BR>+};<BR>+<BR>+/* 1368x768 (GTF) =
*/<BR>+static struct crt_mode_table CRTM1368x768[] =3D {<BR>+&nbsp; /* =
r_rate,&nbsp; vclk, hsp, vsp */<BR>+&nbsp; /* HT,&nbsp; HA,&nbsp; HBS, =
HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, VSS, VSE */<BR>+&nbsp; =
{REFRESH_60, CLK_85_860M, M1368X768_R60_HSP, =
M1368X768_R60_VSP,\<BR>+&nbsp; {1800,1368, 1368, 432, 1440, 144, 795, =
768, 768, 27,&nbsp; 769, 3}}<BR>+};<BR>+<BR>+/* 1368x768 (GTF) =
*/<BR>+/*static struct crt_mode_table CRTM1368x768[] =3D {<BR>+&nbsp; =
//r_rate,vclk,&nbsp;&nbsp;&nbsp;&nbsp; HT,&nbsp; HA,&nbsp;&nbsp; =
HBS,&nbsp; HBE, HSS,&nbsp; HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, VSS, VSE =
<BR>+&nbsp; { 60,CLK_85_860M ,{1800,1368, 1368, 432, 1440, 144, 795, =
768, 768, 27,&nbsp; 769, 3}}<BR>+};*/<BR>+<BR>+/* 1440x1050 (GTF) =
*/<BR>+static struct crt_mode_table CRTM1440x1050[] =3D {<BR>+&nbsp; /* =
r_rate,vclk,hsp,vsp */&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>+&nbsp; =
/* HT,&nbsp; HA,&nbsp;&nbsp; HBS,&nbsp; HBE, HSS,&nbsp; HSE, VT,&nbsp; =
VA,&nbsp; VBS, VBE, VSS, VSE */<BR>+&nbsp; {REFRESH_60 ,CLK_125_104M =
,M1440X1050_R60_HSP, M1440X1050_R60_VSP,\<BR>+&nbsp; {1936,1440, 1440, =
496, 1536, 152, 1077,1040,1040,37,&nbsp; 1041,3}}<BR>+};<BR>+<BR>+/* =
1600x1200 */<BR>+static struct crt_mode_table CRTM1600x1200[] =3D =
{<BR>+&nbsp; /* r_rate,vclk,hsp,vsp */<BR>+&nbsp; /* HT,&nbsp; =
HA,&nbsp;&nbsp; HBS,&nbsp; HBE, HSS,&nbsp; HSE, VT,&nbsp; VA,&nbsp; VBS, =
VBE, VSS, VSE */&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>+&nbsp; {REFRESH_60 =
,CLK_162_000M ,M1600X1200_R60_HSP, M1600X1200_R60_VSP,\<BR>+&nbsp; =
{2160,1600, 1600, 560, 1664, 192, 1250,1200,1200,50,&nbsp; =
1201,3}},<BR>+&nbsp; {REFRESH_75 ,CLK_202_500M ,M1600X1200_R75_HSP, =
M1600X1200_R75_VSP,\<BR>+&nbsp; {2160,1600, 1600, 560, 1664, 192, =
1250,1200,1200,50,&nbsp; 1201,3}}<BR>+<BR>+};<BR>+<BR>+/* 1920x1080 =
(GTF) */<BR>+static struct crt_mode_table CRTM1920x1080[] =3D =
{<BR>+&nbsp; /* r_rate,vclk,hsp,vsp */<BR>+&nbsp; /* HT,&nbsp; =
HA,&nbsp;&nbsp; HBS,&nbsp; HBE, HSS,&nbsp; HSE, VT,&nbsp; VA,&nbsp; VBS, =
VBE, VSS, VSE =
*/&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; <BR>+&nbsp; {REFRESH_60,CLK_172_798M =
,M1920X1080_R60_HSP, M1920X1080_R60_VSP,\<BR>+&nbsp; {2576,1920, 1920, =
656, 2040, 208, 1118,1080,1080,38, 1081, 3}}<BR>+};<BR>+<BR>+/* =
1920x1440 */<BR>+static struct crt_mode_table CRTM1920x1440[] =3D =
{<BR>+&nbsp; /* r_rate,vclk,hsp,vsp */<BR>+&nbsp; /* HT,&nbsp; =
HA,&nbsp;&nbsp; HBS,&nbsp; HBE, HSS,&nbsp; HSE, VT,&nbsp; VA,&nbsp; VBS, =
VBE, VSS, VSE */<BR>+&nbsp; {REFRESH_60,CLK_234_000M =
,M1920X1440_R60_HSP, M1920X1440_R60_VSP,\<BR>+&nbsp; {2600,1920, 1920, =
680, 2048, 208, 1500,1440,1440,60,&nbsp; 1441,3}},<BR>+&nbsp; =
{REFRESH_75,CLK_297_500M ,M1920X1440_R75_HSP, =
M1920X1440_R75_VSP,\<BR>+&nbsp; {2640,1920, 1920, 720, 2064, 224, =
1500,1440,1440,60,&nbsp; 1441,3}}<BR>+};<BR>+<BR>+#if 0<BR>+/* 1400x1050 =
(VESA) */<BR>+static struct crt_mode_table CRTM1400x1050[] =3D =
{<BR>+&nbsp; /* =
r_rate,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
vclk,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; =
hsp,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; vsp&nbsp;&nbsp; */<BR>+&nbsp; /* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, =
HSE,&nbsp;&nbsp;&nbsp; VT,&nbsp; VA,&nbsp; VBS, VBE,&nbsp; VSS, VSE =
*/<BR>+&nbsp; {REFRESH_60,CLK_108_000M, M1400X1050_R60_HSP, =
M1400X1050_R60_VSP,<BR>+&nbsp; {1688,1400, 1400, 288, 1448, 112, =
1066,1050, 1050,&nbsp; 16, 1051, 3}}<BR>+};<BR>+#endif<BR>+<BR>+/* =
1400x1050 (GTF) */<BR>+static struct crt_mode_table CRTM1400x1050[] =3D =
{<BR>+&nbsp; /* =
r_rate,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
vclk,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; =
hsp,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; vsp&nbsp;&nbsp; */<BR>+&nbsp; /* HT,&nbsp; HA,&nbsp; HBS, HBE,&nbsp; =
HSS, HSE,&nbsp;&nbsp; VT,&nbsp; VA,&nbsp; VBS, VBE,&nbsp; VSS, VSE =
*/<BR>+&nbsp; {REFRESH_60,CLK_122_614M, M1400X1050_R60_HSP, =
M1400X1050_R60_VSP,<BR>+&nbsp; {1880,1400, 1400, 480, 1488, 152, =
1087,1050, 1050,&nbsp; 37, 1051, 3}}<BR>+};<BR>+<BR>+static struct =
VideoModeTable CLE266Modes[] =3D {<BR>+&nbsp;&nbsp; /* Display : 640x480 =
*/<BR>+&nbsp;&nbsp; { VIA_RES_640X480,&nbsp; CRTM640x480, =
ARRAY_SIZE(CRTM640x480)},<BR>+<BR>+&nbsp;&nbsp; /* Display : 720x480 =
(GTF) */<BR>+&nbsp;&nbsp; { VIA_RES_720X480,&nbsp; CRTM720x480, =
ARRAY_SIZE(CRTM720x480)},<BR>+<BR>+&nbsp;&nbsp; /* Display : 720x576 =
(GTF) */<BR>+&nbsp;&nbsp; { VIA_RES_720X576,&nbsp; CRTM720x576, =
ARRAY_SIZE(CRTM720x576)},<BR>+<BR>+&nbsp;&nbsp; /* Display : 800x600 =
*/<BR>+&nbsp;&nbsp; { VIA_RES_800X600,&nbsp; CRTM800x600, =
ARRAY_SIZE(CRTM800x600)},<BR>+<BR>+&nbsp;&nbsp; /* Display : 800x480 =
(GTF) */<BR>+&nbsp;&nbsp; { VIA_RES_800X480,&nbsp; CRTM800x480, =
ARRAY_SIZE(CRTM800x480)},<BR>+<BR>+&nbsp;&nbsp; /* Display : 848x480 =
(GTF) */<BR>+&nbsp;&nbsp; { VIA_RES_848X480,&nbsp; CRTM848x480, =
ARRAY_SIZE(CRTM848x480)},<BR>+<BR>+&nbsp;&nbsp; /* Display : 852x480 =
(GTF) */<BR>+&nbsp;&nbsp; { VIA_RES_856X480,&nbsp; CRTM852x480, =
ARRAY_SIZE(CRTM852x480)},<BR>+<BR>+&nbsp;&nbsp; /* Display : 1024x512 =
(GTF) */<BR>+&nbsp;&nbsp; { VIA_RES_1024X512, CRTM1024x512, =
ARRAY_SIZE(CRTM1024x512)},<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* Display : =
1024x576 (GTF) */<BR>+&nbsp;&nbsp; /*{ VIA_RES_1024X576, CRTM1024x576, =
ARRAY_SIZE(CRTM1024x576)},*/<BR>+<BR>+&nbsp;&nbsp; /* Display : 1024x768 =
*/<BR>+&nbsp;&nbsp; { VIA_RES_1024X768, CRTM1024x768, =
ARRAY_SIZE(CRTM1024x768)},<BR>+<BR>+&nbsp;&nbsp; /* Display : 1152x864 =
*/<BR>+&nbsp;&nbsp; { VIA_RES_1152X864, CRTM1152x864, =
ARRAY_SIZE(CRTM1152x864)},<BR>+<BR>+&nbsp;&nbsp; /* Display : 1280x768 =
(GTF) */<BR>+&nbsp;&nbsp; { VIA_RES_1280X768, CRTM1280x768, =
ARRAY_SIZE(CRTM1280x768)},<BR>+<BR>+&nbsp;&nbsp; /* Display : 1280x800 =
(GTF) */<BR>+&nbsp;&nbsp; /*{ M1280x800, CRTM1280x800, =
ARRAY_SIZE(CRTM1280x800)},*/ <BR>+<BR>+&nbsp;&nbsp; /* Display : =
1280x960 */<BR>+&nbsp;&nbsp; { VIA_RES_1280X960, CRTM1280x960, =
ARRAY_SIZE(CRTM1280x960)},<BR>+<BR>+&nbsp;&nbsp; /* Display : 1280x1024 =
*/<BR>+&nbsp;&nbsp; { VIA_RES_1280X1024, =
CRTM1280x1024,ARRAY_SIZE(CRTM1280x1024)},<BR>+<BR>+&nbsp;&nbsp; /* =
Display : 1368x768 (GTF) */<BR>+&nbsp;&nbsp; /*{ =
M1368x768,CRTM1368x768,ARRAY_SIZE(CRTM1368x768)},*/ <BR>+&nbsp;&nbsp; /* =
Display : 1368x768 (GTF) */<BR>+&nbsp;&nbsp; { =
VIA_RES_1368X768,CRTM1368x768,ARRAY_SIZE(CRTM1368x768)},<BR>+<BR>+&nbsp;&=
nbsp; /* Display : 1440x1050 (GTF) */<BR>+&nbsp;&nbsp; { =
VIA_RES_1440X1050, CRTM1440x1050, =
ARRAY_SIZE(CRTM1440x1050)},<BR>+<BR>+&nbsp;&nbsp; /* Display : 1600x1200 =
*/<BR>+&nbsp;&nbsp; { VIA_RES_1600X1200, CRTM1600x1200, =
ARRAY_SIZE(CRTM1600x1200)},<BR>+<BR>+&nbsp;&nbsp; /* Display : 1920x1440 =
*/<BR>+&nbsp;&nbsp; { VIA_RES_1920X1440, CRTM1920x1440, =
ARRAY_SIZE(CRTM1920x1440)},<BR>+<BR>+&nbsp;&nbsp; /* Display : 1280x720 =
*/<BR>+&nbsp;&nbsp; { VIA_RES_1280X720, CRTM1280x720, =
ARRAY_SIZE(CRTM1280x720)},<BR>+<BR>+&nbsp;&nbsp; /* Display : 1920x1080 =
*/<BR>+&nbsp;&nbsp; { VIA_RES_1920X1080, CRTM1920x1080, =
ARRAY_SIZE(CRTM1920x1080)},<BR>+<BR>+&nbsp;&nbsp; /* Display : 1400x1050 =
*/<BR>+&nbsp;&nbsp; { VIA_RES_1400X1050, CRTM1400x1050, =
ARRAY_SIZE(CRTM1400x1050)}<BR>+};<BR>+<BR>+#define NUM_TOTAL_MODETABLE =
ARRAY_SIZE(CLE266Modes)<BR>+<BR>+<BR>+#endif /* __VIAMODE_H__ =
*/<BR></FONT>=0A=
<DIV><FONT face=3D=B7s=B2=D3=A9=FA=C5=E9 color=3D#000000 =
size=3D2></FONT>&nbsp;</DIV></BODY></HTML>
------_=_NextPart_001_01C7893F.30ABE19E--


--===============0652120504==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0652120504==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0652120504==--
