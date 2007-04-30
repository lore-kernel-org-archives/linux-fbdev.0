From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 9/12] viafb: Framebuffer driver for VIA
 UniChrome/Chrome9 HC (fwd)
Date: Mon, 30 Apr 2007 10:37:42 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704301037370.27246@anakin>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HiROG-0006Xe-MM for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Apr 2007 01:37:48 -0700
Received: from adicia.telenet-ops.be ([195.130.132.56])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HiROF-0001xT-Jg
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Apr 2007 01:37:48 -0700
Received: from localhost (localhost.localdomain [127.0.0.1])
	by adicia.telenet-ops.be (Postfix) with SMTP id 760A02300CF
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 30 Apr 2007 10:37:46 +0200 (CEST)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by adicia.telenet-ops.be (Postfix) with ESMTP id 334ED2300DC
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 30 Apr 2007 10:37:43 +0200 (CEST)
Received: from anakin.of.borg (geert@localhost [127.0.0.1])
	by anakin.of.borg (8.13.8/8.13.8/Debian-3) with ESMTP id l3U8bh7S020431
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 30 Apr 2007 10:37:43 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.13.8/8.13.8/Submit) with ESMTP id l3U8bgnB020428
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 30 Apr 2007 10:37:43 +0200
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

---------- Forwarded message ----------
Date: Mon, 30 Apr 2007 13:20:40 +0800
From: EddyFu@via.com.tw
To: linux-fbdev-devel-bounces@lists.sourceforge.net
Subject: [Linux-fbdev-devel] [PATCH 9/12] viafb: Framebuffer driver for VIA
    UniChrome/Chrome9 HC

Dear All, 
 
Here is the part 9/12 of viafb.
 
Best Regards,
Eddy Fu 
 
diff -Nur linux-2.6.21-rc7/drivers/video/via/tv.h linux-2.6.21-rc7.viafb/drivers/video/via/tv.h
--- linux-2.6.21-rc7/drivers/video/via/tv.h 1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/tv.h 2007-04-26 19:52:32.000000000 -0400
@@ -0,0 +1,163 @@
+/*
+ * Copyright 1998-2007 VIA Technologies, Inc. All Rights Reserved.
+ * Copyright 2001-2007 S3 Graphics, Inc. All Rights Reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sub license,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the
+ * next paragraph) shall be included in all copies or substantial portions
+ * of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHOR(S) OR COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
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
+#define     GFX_IGA1_CRT_NUM            14              /* number of setting CRTC's registers on IGA1 in TV table */
+#define     GFX_IGA2_CRT_NUM            16              /* number of setting CRTC's registers on IGA2 in TV table */
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
+/* We divide shift range into 11 partitions, so 6 is the center position. */
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
+int tv_get_ffilter(int ffilter_type, int* ffilter_state); 
+void tv_set_position(u32 HPos, u32 VPos);
+void tv_get_position(u32* HPos, u32* VPos);
+void tv_set_size(u32 HPos, u32 VPos);
+void set_tv_clock_source(void);
+void tv_patch_skew_p4m900(int tv_mode_index);
+void tv_patch_skew_k8m890(int tv_mode_index);
+void tv_patch_skew_p4m890(int tv_mode_index);
+
+#endif /* __TV_H__ */
diff -Nur linux-2.6.21-rc7/drivers/video/via/tblIntegratedTV.h linux-2.6.21-rc7.viafb/drivers/video/via/tblIntegratedTV.h
--- linux-2.6.21-rc7/drivers/video/via/tblIntegratedTV.h 1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/tblIntegratedTV.h 2007-04-26 19:52:32.000000000 -0400
@@ -0,0 +1,1208 @@
+/*
+ * Copyright 1998-2007 VIA Technologies, Inc. All Rights Reserved.
+ * Copyright 2001-2007 S3 Graphics, Inc. All Rights Reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sub license,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the
+ * next paragraph) shall be included in all copies or substantial portions
+ * of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHOR(S) OR COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
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
+unsigned short ITV_INIT_TABLE_OFFSET[] = {
+    0x0000,
+    0x001C,
+    0x00DC,
+    0xFFFF  /*End*/
+};
+ 
+unsigned long ITV_INIT_TABLE_VALUE[] = {
+    0x40412000,     /* 00-03 */
+    0x40000000,     /* 1C-1F */
+
+    /* TVCLK PLL. */
+    0xA0000000,     /* DC-DF */
+};
+
+unsigned short ITV_MODE_TABLE_OFFSET[] = {
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
+/**************************************************************************************/
+/************************************* NTSC *******************************************/
+/**************************************************************************************/
+unsigned long ITV_MODE_TABLE_NTSC_640x480[] = {
+    /* Src Buffer Line Pitch. */    
+    0x00770500,                 /* 14-17 */
+
+    /* Src Image Size and Position. */
+    0x09D3F9DF,                 /* 18-1B */
+    0x027F01DF,                 /* 20-23 */
+
+    /* Scaling Factor and De-Flicker. */
+    0x63EB48FA,                 /* 24-27 */        
+
+    /* Dst Image Size. */
+    0x141461AA,                 /* 28-2B */
+
+    /* Dst Buffer Line Pitch & DQWord. */
+    0x008E0500,                 /* 34-37 */
+
+    /* Encoder Control. */
+    0xC000A214,                 /* 38-3B */
+    
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
+unsigned long ITV_CRTC_TABLE_NTSC_640x480[] = {
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
+unsigned long ITV_MODE_TABLE_NTSC_720x480[] = {
+    /* Src Buffer Line Pitch. */    
+    0x007705C0,                 /* 14-17 */
+
+    /* Src Image Size and Position. */
+    0x09D679DF,                 /* 18-1B */
+    0x02CF01DF,                 /* 20-23 */
+
+    /* Scaling Factor and De-Flicker. */
+    0x646C4903,                 /* 24-27 */        
+
+    /* Dst Image Size. */
+    0x169451A9,                 /* 28-2B */
+
+    /* Dst Buffer Line Pitch & DQWord. */
+    0x008E05C0,                 /* 34-37 */
+
+    /* Encoder Control. */
+    0xC000A214,                 /* 38-3B */
+    
+    /* Encoder CRTC. */
+    0x427F06B3,                 /* 3C-3F */
+    0x00F400B1,                 /* 40-43 */
+    0x06910100,                 /* 44-47 */
+    0x01A00000,                 /* 48-4B */
+    0x088680C0,                 /* 4C-4F */
+    0x488F08C8,                 /* 50-53 */
+    
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
+unsigned long ITV_CRTC_TABLE_NTSC_720x480[] = {
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
+unsigned long ITV_MODE_TABLE_NTSC_800x600[] = {
+    /* Src Buffer Line Pitch. */    
+    0x00770640,                 /* 14-17 */
+
+    /* Src Image Size and Position. */
+    0x09D8FA57,                 /* 18-1B */
+    0x031F0257,                 /* 20-23 */
+
+    /* Scaling Factor and De-Flicker. */
+    0x64E84B3D,                 /* 24-27 */        
+
+    /* Dst Image Size. */
+    0x191459AA,                 /* 28-2B */
+
+    /* Dst Buffer Line Pitch & DQWord. */
+    0x008E0640,                 /* 34-37 */
+
+    /* Encoder Control. */
+    0xC000A214,                 /* 38-3B */
+    
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
+    INTEGRATED_TVCLK_54MHZ      /* E0-E3 */
+};
+
+unsigned long ITV_CRTC_TABLE_NTSC_800x600[] = {
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
+unsigned long ITV_MODE_TABLE_NTSC_1024x768[] = {
+    /* Src Buffer Line Pitch. */    
+    0x00770800,                 /* 14-17 */
+
+    /* Src Image Size and Position. */
+    0x09DFFAFF,                 /* 18-1B */
+    0x03FF02FF,                 /* 20-23 */
+
+    /* Scaling Factor and De-Flicker. */
+    0x66454E58,                 /* 24-27 */        
+
+    /* Dst Image Size. */
+    0x201461AA,                 /* 28-2B */
+
+    /* Dst Buffer Line Pitch & DQWord. */
+    0x008E0800,                 /* 34-37 */
+
+    /* Encoder Control. */
+    0xC000A214,                 /* 38-3B */
+    
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
+    INTEGRATED_TVCLK_54MHZ      /* E0-E3 */
+};
+
+unsigned long ITV_CRTC_TABLE_NTSC_1024x768[] = {
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
+        
+/**************************************************************************************/
+/************************************* PAL ********************************************/
+/**************************************************************************************/
+
+unsigned long ITV_MODE_TABLE_PAL_640x480[] = {
+    /* Src Buffer Line Pitch. */    
+    0x00770500,                 /* 14-17 */
+
+    /* Src Image Size and Position. */
+    0x09D3F9DF,                 /* 18-1B */
+    0x227F01DF,                 /* 20-23 */
+
+    /* Scaling Factor and De-Flicker. */
+    0x6405478E,                 /* 24-27 */        
+
+    /* Dst Image Size. */
+    0x1413D9FA,                 /* 28-2B */
+
+    /* Dst Buffer Line Pitch & DQWord. */
+    0x008E0500,                 /* 34-37 */
+
+    /* Encoder Control. */
+    0xC048A214,                 /* 38-3B */
+    
+    /* Encoder CRTC. */
+    0x427F06BF,                 /* 3C-3F */
+    0x00EF00B2,                 /* 40-43 */
+    0x06990120,                 /* 44-47 */
+    0x01200010,                 /* 48-4B */
+    0x0A0680C0,                 /* 4C-4F */
+    0x489608D3,                 /* 50-53 */
+    
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
+unsigned long ITV_CRTC_TABLE_PAL_640x480[] = {
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
+unsigned long ITV_MODE_TABLE_PAL_720x576[] = {
+    /* Src Buffer Line Pitch. */    
+    0x007705C0,                 /* 14-17 */
+
+    /* Src Image Size and Position. */
+    0x09D67A3F,                 /* 18-1B */
+    0x22CF023F,                 /* 20-23 */
+
+    /* Scaling Factor and De-Flicker. */
+    0x64834916,                 /* 24-27 */        
+
+    /* Dst Image Size. */
+    0x1693E9FA,                 /* 28-2B */
+
+    /* Dst Buffer Line Pitch & DQWord. */
+    0x008E05C0,                 /* 34-37 */
+
+    /* Encoder Control. */
+    0xC048A214,                 /* 38-3B */
+    
+    /* Encoder CRTC. */
+    0x427F06BF,                 /* 3C-3F */
+    0x00EF00B2,                 /* 40-43 */
+    0x06990120,                 /* 44-47 */
+    0x01200010,                 /* 48-4B */
+    0x0A0680C0,                 /* 4C-4F */
+    0x489608D3,                 /* 50-53 */
+    
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
+unsigned long ITV_CRTC_TABLE_PAL_720x576[] = {
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
+unsigned long ITV_MODE_TABLE_PAL_800x600[] = {
+    /* Src Buffer Line Pitch. */    
+    0x00770640,                 /* 14-17 */
+
+    /* Src Image Size and Position. */
+    0x09D8FA57,                 /* 18-1B */
+    0x231F0257,                 /* 20-23 */
+
+    /* Scaling Factor and De-Flicker. */
+    0x6503497A,                 /* 24-27 */        
+
+    /* Dst Image Size. */
+    0x1913E9F9,                 /* 28-2B */
+
+    /* Dst Buffer Line Pitch & DQWord. */
+    0x008E0640,                 /* 34-37 */
+
+    /* Encoder Control. */
+    0xC048A214,                 /* 38-3B */
+    
+    /* Encoder CRTC. */
+    0x427F06BF,                 /* 3C-3F */
+    0x00EF00B2,                 /* 40-43 */
+    0x06990120,                 /* 44-47 */
+    0x01200010,                 /* 48-4B */
+    0x0A0680C0,                 /* 4C-4F */
+    0x489608D3,                 /* 50-53 */
+    
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
+unsigned long ITV_CRTC_TABLE_PAL_800x600[] = {
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
+unsigned long ITV_MODE_TABLE_PAL_1024x768[] = {
+    /* Src Buffer Line Pitch. */    
+    0x00770800,                 /* 14-17 */
+
+    /* Src Image Size and Position. */
+    0x09DFFAFF,                 /* 18-1B */
+    0x13FF02FF,                 /* 20-23 */
+
+    /* Scaling Factor and De-Flicker. */
+    0x66704C2A,                 /* 24-27 */        
+
+    /* Dst Image Size. */
+    0x2013D9F8,                 /* 28-2B */
+
+    /* Dst Buffer Line Pitch & DQWord. */
+    0x008E0800,                 /* 34-37 */
+
+    /* Encoder Control. */
+    0xC048A214,                 /* 38-3B */
+    
+    /* Encoder CRTC. */
+    0x427F06BF,                 /* 3C-3F */
+    0x00EF00B2,                 /* 40-43 */
+    0x06990120,                 /* 44-47 */
+    0x01200010,                 /* 48-4B */
+    0x0A0680C0,                 /* 4C-4F */
+    0x489608D3,                 /* 50-53 */
+    
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
+unsigned long ITV_CRTC_TABLE_PAL_1024x768[] = {
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
+/**************************************************************************************/
+/************************************* HDTV: 720P *************************************/
+/**************************************************************************************/
+unsigned long ITV_MODE_TABLE_720P_1280x720[] = {
+    /* Src Buffer Line Pitch. */    
+    0x00770A00,                 /* 14-17 */
+
+    /* Src Image Size and Position. */
+    0x09E7FACF,                 /* 18-1B */
+    0x24FF02CF,                 /* 20-23 */
+
+    /* Scaling Factor and De-Flicker. */
+    0x045A27FF,                 /* 24-27 */        
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
+unsigned long ITV_CRTC_TABLE_720P_1280x720[] = {
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
+unsigned long ITV_CRTC_TABLE_720P_640x480[] = {
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
+unsigned long ITV_CRTC_TABLE_720P_720x480[] = {
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
+unsigned long ITV_CRTC_TABLE_720P_720x576[] = {
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
+unsigned long ITV_CRTC_TABLE_720P_800x600[] = {
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
+unsigned long ITV_CRTC_TABLE_720P_1024x768[] = {
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
+/**************************************************************************************/
+/************************************* HDTV: 1080I *************************************/
+/**************************************************************************************/
+unsigned long ITV_MODE_TABLE_1080I_1920x1080[] = {
+    /* Src Buffer Line Pitch. */    
+    0x00770F00,                 /* 14-17 */
+
+    /* Src Image Size and Position. */
+    0x09FBFC37,                 /* 18-1B */
+    0x277F0437,                 /* 20-23 */
+
+    /* Scaling Factor and De-Flicker. */
+    0x68002803,                 /* 24-27 */        
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
+    
+    /* TVCLK PLL */
+    INTEGRATED_TVCLK_148_5MHZ   /* E0-E3 */
+};
+
+unsigned long ITV_CRTC_TABLE_1080I_1920x1080[] = {
+    2200,   /* H_Total          */ 
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
+unsigned long ITV_CRTC_TABLE_1080I_640x480[] = {
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
+unsigned long ITV_CRTC_TABLE_1080I_720x480[] = {
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
+unsigned long ITV_CRTC_TABLE_1080I_720x576[] = {
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
+unsigned long ITV_CRTC_TABLE_1080I_800x600[] = {
+    1440,   /* H_Total          */ 
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
+unsigned long ITV_CRTC_TABLE_1080I_1024x768[] = {
+    1250,   /* H_Total          */ 
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
+unsigned long ITV_NULL_TABLE[] = {
+    0xFFFF
+};
+
+
+struct integrated_tv_mode_table ITV_MODE_TABLE[] = {
+    {VIA_RES_640X480,   ITV_MODE_TABLE_NTSC_640x480,  ITV_MODE_TABLE_PAL_640x480,  ITV_MODE_TABLE_720P_1280x720, ITV_MODE_TABLE_1080I_1920x1080},
+    {VIA_RES_720X480,   ITV_MODE_TABLE_NTSC_720x480,  ITV_MODE_TABLE_NTSC_720x480, ITV_MODE_TABLE_720P_1280x720, ITV_MODE_TABLE_1080I_1920x1080},
+    {VIA_RES_720X576,   ITV_MODE_TABLE_PAL_720x576,   ITV_MODE_TABLE_PAL_720x576,  ITV_MODE_TABLE_720P_1280x720, ITV_MODE_TABLE_1080I_1920x1080},
+    {VIA_RES_800X600,   ITV_MODE_TABLE_NTSC_800x600,  ITV_MODE_TABLE_PAL_800x600,  ITV_MODE_TABLE_720P_1280x720, ITV_MODE_TABLE_1080I_1920x1080},
+    {VIA_RES_1024X768,  ITV_MODE_TABLE_NTSC_1024x768, ITV_MODE_TABLE_PAL_1024x768, ITV_MODE_TABLE_720P_1280x720, ITV_MODE_TABLE_1080I_1920x1080},
+    {VIA_RES_1280X720,  ITV_NULL_TABLE,               ITV_NULL_TABLE,              ITV_MODE_TABLE_720P_1280x720, ITV_NULL_TABLE},
+    {VIA_RES_1920X1080, ITV_NULL_TABLE,               ITV_NULL_TABLE,              ITV_NULL_TABLE,               ITV_MODE_TABLE_1080I_1920x1080}
+};
+
+
+struct integrated_tv_mode_table ITV_CRTC_TABLE[] = {
+    {VIA_RES_640X480,   ITV_CRTC_TABLE_NTSC_640x480,  ITV_CRTC_TABLE_PAL_640x480,  ITV_CRTC_TABLE_720P_640x480,  ITV_CRTC_TABLE_1080I_640x480},
+    {VIA_RES_720X480,   ITV_CRTC_TABLE_NTSC_720x480,  ITV_CRTC_TABLE_NTSC_720x480, ITV_CRTC_TABLE_720P_720x480,  ITV_CRTC_TABLE_1080I_720x480},
+    {VIA_RES_720X576,   ITV_CRTC_TABLE_PAL_720x576,   ITV_CRTC_TABLE_PAL_720x576,  ITV_CRTC_TABLE_720P_720x576,  ITV_CRTC_TABLE_1080I_720x576},
+    {VIA_RES_800X600,   ITV_CRTC_TABLE_NTSC_800x600,  ITV_CRTC_TABLE_PAL_800x600,  ITV_CRTC_TABLE_720P_800x600,  ITV_CRTC_TABLE_1080I_800x600},
+    {VIA_RES_1024X768,  ITV_CRTC_TABLE_NTSC_1024x768, ITV_CRTC_TABLE_PAL_1024x768, ITV_CRTC_TABLE_720P_1024x768, ITV_CRTC_TABLE_1080I_1024x768},
+    {VIA_RES_1280X720,  ITV_NULL_TABLE,               ITV_NULL_TABLE,              ITV_CRTC_TABLE_720P_1280x720, ITV_NULL_TABLE},
+    {VIA_RES_1920X1080, ITV_NULL_TABLE,               ITV_NULL_TABLE,              ITV_NULL_TABLE,               ITV_CRTC_TABLE_1080I_1920x1080}
+};
+
+
+#define NUM_TOTAL_INTEGRATEDTV_MODE_TABLE ARRAY_SIZE(ITV_MODE_TABLE)
+
+/**************************************************************************************/
+/********************************** Patch Table for RGB *******************************/
+/**************************************************************************************/
+unsigned short ITV_PATCH_TABLE_RGB_NTSC[] = {
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
+unsigned short ITV_PATCH_TABLE_RGB_PAL[] = {
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
+/**************************************************************************************/
+/******************************** Patch Table for YPbPr *******************************/
+/**************************************************************************************/
+unsigned short ITV_PATCH_TABLE_YPBPR_NTSC[] = {
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
+unsigned short ITV_PATCH_TABLE_YPBPR_PAL[] = {
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
+/**************************************************************************************/
+/******************************** Patch Table for 480P ********************************/
+/**************************************************************************************/
+unsigned short ITV_PATCH_TABLE_480P_640x480[] = {
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
+unsigned short ITV_PATCH_TABLE_480P_720x480[] = {
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
+unsigned short ITV_PATCH_TABLE_480P_800x600[] = {
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
+unsigned short ITV_PATCH_TABLE_480P_1024x768[] = {
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
+/**************************************************************************************/
+/******************************** Patch Table for 576P ********************************/
+/**************************************************************************************/
+unsigned short ITV_PATCH_TABLE_576P_640x480[] = {
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
+unsigned short ITV_PATCH_TABLE_576P_720x576[] = {
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
+unsigned short ITV_PATCH_TABLE_576P_800x600[] = {
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
+unsigned short ITV_PATCH_TABLE_576P_1024x768[] = {
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
+/**************************************************************************************/
+/******************************** Patch Table for 720P ********************************/
+/**************************************************************************************/
+unsigned short ITV_PATCH_TABLE_720P_640x480[] = {
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
+unsigned short ITV_PATCH_TABLE_720P_720x480[] = {
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
+unsigned short ITV_PATCH_TABLE_720P_720x576[] = {
+    0xC014, 0x0515, 0x3F18,
+    0x7A19, 0xD61A, 0x3F20,
+    0xCF22, 0x2223,
+    0x6524, 0x0625, 0x8826,
+    0x0427, 0x272A, 0x172B,
+    0xC034, 0x0535,        
+    0x64E2,
+    0xFFFF
+};
+
+unsigned short ITV_PATCH_TABLE_720P_800x600[] = {
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
+unsigned short ITV_PATCH_TABLE_720P_1024x768[] = {
+    0x0815, 0x8F16,
+    0xFF18, 0xDF1A, 0x0A1B,
+    0xFF20, 0x2323,
+    0x8724, 0x2825, 0x0926,
+    0x0727, 0x202B,
+    0x0835, 0xF036, 0x074C,
+    0x00DC, 
+    0x21E0, 0x0CE1, 0x24E2, 0x01E3, /* 66MHZ */
+    0xFFFF
+};
+
+/**************************************************************************************/
+/******************************** Patch Table for 1080I ********************************/
+/**************************************************************************************/
+unsigned short ITV_PATCH_TABLE_1080I_640x480[] = {
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
+unsigned short ITV_PATCH_TABLE_1080I_720x480[] = {
+    0xC014, 0x0515, 0xDF18,
+    0x7919, 0xD61A, 0xDF20,
+    0x0121, 0xCF22, 0x2223,
+    0x8E24, 0x2325, 0x0226,
+    0x6327, 0x172B, 
+    0xC034, 0x0535, 
+    0xC4E2, 0x02E3,
+    0xFFFF
+};
+
+unsigned short ITV_PATCH_TABLE_1080I_720x576[] = {
+    0xC014, 0x0515, 0x3F18,
+    0x7A19, 0xD61A, 0x3F20,
+    0x0221, 0xCF22, 0x2223,
+    0x4524, 0x2425, 0x0226,
+    0x6327, 0x172B,
+    0xC034, 0x0535,         
+    0x64E2, 0x01E3,
+    0xFFFF
+};
+
+unsigned short ITV_PATCH_TABLE_1080I_800x600[] = {
+    0x4014, 0x0615, 0xFA19,
+    0x5718, 0xD81A, 0x0221,
+    0x5720, 0x1F22, 0x2323,
+    0x7324, 0x2425, 0x5626,
+    0x6327, 0x192B, 
+    0x4034, 0x0635,
+    0x0936, 0x0137, 0xEB4C,
+    0x64E2, 0x01E3,
+    0xFFFF
+};
+
+unsigned short ITV_PATCH_TABLE_1080I_1024x768[] = {
+    0x0815, 0xFF18, 0xFA19,
+    0xDF1A, 0x0221,
+    0xFF20, 0xFF22, 0x2323,
+    0xB224, 0x2525, 0x4626,
+    0x6427, 0x202B,        
+    0x0835,                        
+    0x44E2, 0x01E3,
+    0xFFFF
+};
+
+
+unsigned short ITV_PATCH_TABLE_NULL[] = {
+    0xFFFF
+};
+
+struct integrated_tv_hdtv_patch_table ITV_HDTV_PATCH_TABLE[] = {
+    {VIA_RES_640X480,   ITV_PATCH_TABLE_480P_640x480,  ITV_PATCH_TABLE_576P_640x480,  ITV_PATCH_TABLE_720P_640x480, ITV_PATCH_TABLE_1080I_640x480},
+    {VIA_RES_720X480,   ITV_PATCH_TABLE_480P_720x480,  ITV_PATCH_TABLE_480P_720x480,  ITV_PATCH_TABLE_720P_720x480, ITV_PATCH_TABLE_1080I_720x480},
+    {VIA_RES_720X576,   ITV_PATCH_TABLE_576P_720x576,  ITV_PATCH_TABLE_576P_720x576,  ITV_PATCH_TABLE_720P_720x576, ITV_PATCH_TABLE_1080I_720x576},
+    {VIA_RES_800X600,   ITV_PATCH_TABLE_480P_800x600,  ITV_PATCH_TABLE_576P_800x600,  ITV_PATCH_TABLE_720P_800x600, ITV_PATCH_TABLE_1080I_800x600},
+    {VIA_RES_1024X768,  ITV_PATCH_TABLE_480P_1024x768, ITV_PATCH_TABLE_576P_1024x768, ITV_PATCH_TABLE_720P_1024x768, ITV_PATCH_TABLE_1080I_1024x768},
+    {VIA_RES_1280X720,  ITV_PATCH_TABLE_NULL,          ITV_PATCH_TABLE_NULL,          ITV_PATCH_TABLE_NULL,         ITV_PATCH_TABLE_NULL},
+    {VIA_RES_1920X1080, ITV_PATCH_TABLE_NULL,          ITV_PATCH_TABLE_NULL,          ITV_PATCH_TABLE_NULL,         ITV_PATCH_TABLE_NULL}
+
+};
+
+
+#endif
diff -Nur linux-2.6.21-rc7/drivers/video/via/vt1636.c linux-2.6.21-rc7.viafb/drivers/video/via/vt1636.c
--- linux-2.6.21-rc7/drivers/video/via/vt1636.c 1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/vt1636.c 2007-04-26 19:52:32.000000000 -0400
@@ -0,0 +1,327 @@
+/*
+ * Copyright 1998-2007 VIA Technologies, Inc. All Rights Reserved.
+ * Copyright 2001-2007 S3 Graphics, Inc. All Rights Reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sub license,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the
+ * next paragraph) shall be included in all copies or substantial portions
+ * of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHOR(S) OR COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+ * DEALINGS IN THE SOFTWARE.
+ */
+#include "hw.h"
+#include "tbl1636.h"
+#include "vt1636.h"
+#include "tblDPASetting.h"
+#include "chip.h"
+#include "via_i2c.h"
+#include "debug.h"
+
+/* Extern Functions Prototypes Declaration */
+extern int i2cWriteByte(u8 slave_addr, u8 index, u8 data);
+extern int i2cReadByte(u8 slave_addr, u8 index, u8 *pData);
+extern void write_reg_mask(u8 index, int io_port, u8 data, u8 mask);
+extern void set_dpa_gfx(int output_interface, GFXDPASETTINGPTR p_gfx_dpa_setting);
+extern struct chip_information      chip_info;
+
+
+u8 gpio_i2c_read_lvds(struct lvds_setting_information *plvds_setting_info, struct lvds_chip_information *plvds_chip_info, u8 index)
+{
+    u8 data;
+    int tmp;
+    tmp = chip_info.tv_chip_info.tv_chip_on_slot;
+    switch(plvds_chip_info->i2c_port)
+    {
+        case TVI2CPORTINDEX:
+            chip_info.tv_chip_info.tv_chip_on_slot = TV_ON_AMR;
+            break;
+        case TVGPIOPORTINDEX:
+        default:
+            chip_info.tv_chip_info.tv_chip_on_slot = TV_ON_AGP;
+            break;
+    }
+    i2cReadByte(plvds_chip_info->lvds_chip_slave_addr, index, &data);
+    chip_info.tv_chip_info.tv_chip_on_slot = tmp;
+    return data;
+}
+
+void gpio_i2c_write_mask_lvds(struct lvds_setting_information *plvds_setting_info, struct lvds_chip_information *plvds_chip_info, IODATA io_data)
+{
+    int index, data, tmp;
+    tmp = chip_info.tv_chip_info.tv_chip_on_slot;
+    switch(plvds_chip_info->i2c_port)
+    {
+        case TVI2CPORTINDEX:
+            chip_info.tv_chip_info.tv_chip_on_slot = TV_ON_AMR;
+            break;
+        case TVGPIOPORTINDEX:
+        default:
+            chip_info.tv_chip_info.tv_chip_on_slot = TV_ON_AGP;
+            break;
+    }
+
+    index = io_data.Index;
+    data = gpio_i2c_read_lvds(plvds_setting_info, plvds_chip_info, index);
+    data = (data & (~io_data.Mask)) | io_data.Data;
+
+    i2cWriteByte(plvds_chip_info->lvds_chip_slave_addr, index, data);
+    chip_info.tv_chip_info.tv_chip_on_slot = tmp;
+}
+
+void init_lvds_vt1636(struct lvds_setting_information *plvds_setting_info, struct lvds_chip_information *plvds_chip_info)
+{
+    int reg_num, i;
+
+    /* Common settings: */
+    reg_num = ARRAY_SIZE(COMMON_INIT_TBL_VT1636);
+
+    for (i = 0; i < reg_num; i++)
+    {
+        gpio_i2c_write_mask_lvds(plvds_setting_info, plvds_chip_info, COMMON_INIT_TBL_VT1636[i]);
+    }
+
+    /* Input Data Mode Select */
+    if (plvds_setting_info->LCDDualEdge)
+    {
+        gpio_i2c_write_mask_lvds(plvds_setting_info, plvds_chip_info, DUAL_CHANNEL_ENABLE_TBL_VT1636[0]);
+    }
+    else
+    {
+        gpio_i2c_write_mask_lvds(plvds_setting_info, plvds_chip_info, SINGLE_CHANNEL_ENABLE_TBL_VT1636[0]);
+    }
+
+    if (plvds_setting_info->LCDDithering)
+    {
+        gpio_i2c_write_mask_lvds(plvds_setting_info, plvds_chip_info, DITHERING_ENABLE_TBL_VT1636[0]);
+    }
+    else
+    {
+        gpio_i2c_write_mask_lvds(plvds_setting_info, plvds_chip_info, DITHERING_DISABLE_TBL_VT1636[0]);
+    }
+}
+
+void enable_lvds_vt1636(struct lvds_setting_information *plvds_setting_info, struct lvds_chip_information *plvds_chip_info)
+{
+    
+    gpio_i2c_write_mask_lvds(plvds_setting_info, plvds_chip_info, VDD_ON_TBL_VT1636[0]);
+
+    /* Pad on: */
+    switch (plvds_chip_info->output_interface)
+    {
+        case INTERFACE_DVP0:
+        {
+            write_reg_mask(SR1E, VIASR, 0xC0, 0xC0);
+            break;
+        }
+        
+        case INTERFACE_DVP1:
+        {
+            write_reg_mask(SR1E, VIASR, 0x30, 0x30);
+            break;
+        }
+
+        case INTERFACE_DFP_LOW:
+        {
+            write_reg_mask(SR2A, VIASR, 0x03, 0x03);
+            break;
+        }
+
+        case INTERFACE_DFP_HIGH:
+        {
+            write_reg_mask(SR2A, VIASR, 0x03, 0x0C);
+            break;
+        }
+    }
+}
+
+void disable_lvds_vt1636(struct lvds_setting_information *plvds_setting_info, struct lvds_chip_information *plvds_chip_info)
+{
+    
+    gpio_i2c_write_mask_lvds(plvds_setting_info, plvds_chip_info, VDD_OFF_TBL_VT1636[0]);
+
+    /* Pad off: */
+    switch (plvds_chip_info->output_interface)
+    {
+        case INTERFACE_DVP0:
+        {
+            write_reg_mask(SR1E, VIASR, 0x00, 0xC0);
+            break;
+        }
+
+        case INTERFACE_DVP1:
+        {
+            write_reg_mask(SR1E, VIASR, 0x00, 0x30);
+            break;
+        }
+
+        case INTERFACE_DFP_LOW:
+        {
+            write_reg_mask(SR2A, VIASR, 0x00, 0x03);
+            break;
+        }
+
+        case INTERFACE_DFP_HIGH:
+        {
+            write_reg_mask(SR2A, VIASR, 0x00, 0x0C);
+            break;
+        }
+    }
+}
+
+bool lvds_identify_vt1636(void)
+{
+    u8 Buffer[2];
+
+    DEBUG_MSG(KERN_INFO "lvds_identify_vt1636.\n");
+    
+    /* Sense VT1636 LVDS Transmiter */
+    chip_info.lvds_chip_info.lvds_chip_slave_addr = VT1636_LVDS_I2C_ADDR ;
+    
+    /* Check vendor ID first: */
+    i2cReadByte((u8)chip_info.lvds_chip_info.lvds_chip_slave_addr, 0x00, &Buffer[0]);
+    i2cReadByte((u8)chip_info.lvds_chip_info.lvds_chip_slave_addr, 0x01, &Buffer[1]);
+
+    if (!((Buffer[0] == 0x06) && (Buffer[1] == 0x11)))
+    {      
+        return FALSE;
+    }
+
+    /* Check Chip ID: */
+    i2cReadByte((u8)chip_info.lvds_chip_info.lvds_chip_slave_addr, 0x02, &Buffer[0]);
+    i2cReadByte((u8)chip_info.lvds_chip_info.lvds_chip_slave_addr, 0x03, &Buffer[1]);
+    if ((Buffer[0] == 0x45) && (Buffer[1] == 0x33))
+    {
+        chip_info.lvds_chip_info.lvds_chip_name = VT1636_LVDS;
+        return TRUE;
+    }
+    
+    return FALSE;
+}
+
+int get_clk_range_index(u32 Clk)
+{
+    if (Clk < DPA_CLK_30M)
+    {
+        return DPA_CLK_RANGE_30M;
+    }
+    else if ((DPA_CLK_30M < Clk) && (Clk < DPA_CLK_50M))
+    {
+        return DPA_CLK_RANGE_30_50M;
+    }
+    else if ((DPA_CLK_50M < Clk) && (Clk < DPA_CLK_70M))
+    {
+        return DPA_CLK_RANGE_50_70M;
+    }
+    else if ((DPA_CLK_70M < Clk) && (Clk < DPA_CLK_100M))
+    {
+        return DPA_CLK_RANGE_70_100M;
+    }
+    else if ((DPA_CLK_100M < Clk) && (Clk < DPA_CLK_150M))
+    {
+        return DPA_CLK_RANGE_100_150M;
+    }
+    else
+    {
+        return DPA_CLK_RANGE_150M;
+    }
+}
+
+int get_lvds_dpa_setting_index(int panel_size_id, VT1636DPASETTINGPTR p_vt1636_dpasetting_tbl, int tbl_size)
+{
+    int i;
+
+    for (i = 0; i < tbl_size; i++)
+    {
+        if (panel_size_id == p_vt1636_dpasetting_tbl->PanelSizeID)
+        {
+            return i;
+        }
+
+        p_vt1636_dpasetting_tbl++;
+    }
+
+    return 0;
+}
+
+void set_dpa_vt1636(struct lvds_setting_information *plvds_setting_info, struct lvds_chip_information *plvds_chip_info, VT1636DPASETTINGPTR p_vt1636_dpa_setting)
+{
+    IODATA io_data;
+
+    io_data.Index = 0x09;
+    io_data.Mask = 0x1F;
+    io_data.Data = p_vt1636_dpa_setting->CLK_SEL_ST1;
+    gpio_i2c_write_mask_lvds(plvds_setting_info, plvds_chip_info, io_data);
+
+    io_data.Index = 0x08;
+    io_data.Mask = 0x0F;
+    io_data.Data = p_vt1636_dpa_setting->CLK_SEL_ST2;
+    gpio_i2c_write_mask_lvds(plvds_setting_info, plvds_chip_info, io_data);
+}
+
+void vt1636_patch_skew_on_vt3324(struct lvds_setting_information *plvds_setting_info, struct lvds_chip_information *plvds_chip_info)
+{
+    int index, size;
+
+    DEBUG_MSG(KERN_INFO "vt1636_patch_skew_on_vt3324.\n");
+    
+    /* Graphics DPA settings: */
+    index = get_clk_range_index(plvds_setting_info->vclk);
+    set_dpa_gfx(plvds_chip_info->output_interface, &GFX_DPA_SETTING_TBL_VT3324[index]);
+
+    /* LVDS Transmitter DPA settings: */
+    size = ARRAY_SIZE(VT1636_DPA_SETTING_TBL_VT3324);
+    index = get_lvds_dpa_setting_index(plvds_setting_info->lcd_panel_id, VT1636_DPA_SETTING_TBL_VT3324, size);
+    set_dpa_vt1636(plvds_setting_info, plvds_chip_info, &VT1636_DPA_SETTING_TBL_VT3324[index]);
+}
+
+void vt1636_patch_skew_on_vt3327(struct lvds_setting_information *plvds_setting_info, struct lvds_chip_information *plvds_chip_info)
+{
+    int index, size;
+
+    DEBUG_MSG(KERN_INFO "vt1636_patch_skew_on_vt3327.\n");
+    
+    /* Graphics DPA settings: */
+    index = get_clk_range_index(plvds_setting_info->vclk);
+    set_dpa_gfx(plvds_chip_info->output_interface, &GFX_DPA_SETTING_TBL_VT3327[index]);
+
+    /* LVDS Transmitter DPA settings: */
+    size = ARRAY_SIZE(VT1636_DPA_SETTING_TBL_VT3327);
+    index = get_lvds_dpa_setting_index(plvds_setting_info->lcd_panel_id, VT1636_DPA_SETTING_TBL_VT3327, size);
+    set_dpa_vt1636(plvds_setting_info, plvds_chip_info, &VT1636_DPA_SETTING_TBL_VT3327[index]);
+}
+
+void vt1636_patch_skew_on_vt3364(struct lvds_setting_information *plvds_setting_info, struct lvds_chip_information *plvds_chip_info)
+{
+    int index;
+
+    DEBUG_MSG(KERN_INFO "vt1636_patch_skew_on_vt3364.\n");
+    
+    /* Graphics DPA settings: */
+    index = get_clk_range_index(plvds_setting_info->vclk);
+    set_dpa_gfx(plvds_chip_info->output_interface, &GFX_DPA_SETTING_TBL_VT3364[index]);
+}
diff -Nur linux-2.6.21-rc7/drivers/video/via/viamode.h linux-2.6.21-rc7.viafb/drivers/video/via/viamode.h
--- linux-2.6.21-rc7/drivers/video/via/viamode.h 1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/viamode.h 2007-04-26 19:52:32.000000000 -0400
@@ -0,0 +1,351 @@
+/*
+ * Copyright 1998-2007 VIA Technologies, Inc. All Rights Reserved.
+ * Copyright 2001-2007 S3 Graphics, Inc. All Rights Reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sub license,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the
+ * next paragraph) shall be included in all copies or substantial portions
+ * of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHOR(S) OR COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
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
+static struct crt_mode_table CRTM640x480[] = {
+  /* r_rate,vclk,hsp,vsp */
+  /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+  {REFRESH_60, CLK_25_175M ,M640X480_R60_HSP, M640X480_R60_VSP,\
+  {800, 640, 648, 144, 656, 96,  525, 480, 480, 45,  490, 2}},
+  {REFRESH_75, CLK_31_500M ,M640X480_R75_HSP, M640X480_R75_VSP,\
+  {840, 640, 640, 200, 656, 64,  500, 480, 480, 20,  481, 3}},
+  {REFRESH_85, CLK_36_000M ,M640X480_R85_HSP, M640X480_R85_VSP,\
+  {832, 640, 640, 192, 696, 56,  509, 480, 480, 29,  481, 3}},
+  {REFRESH_100,CLK_43_163M ,M640X480_R100_HSP, M640X480_R100_VSP,\
+  {848, 640, 640, 208, 680, 64,  509, 480, 480, 29,  481, 3}}, /* GTF */
+  {REFRESH_120,CLK_52_406M ,M640X480_R120_HSP, M640X480_R120_VSP,\
+  {848, 640, 640, 208, 680, 64,  515, 480, 480, 35,  481, 3}}  /* GTF */
+};
+
+/* 720x480 (GTF) */
+static struct crt_mode_table CRTM720x480[] = {
+  /* r_rate,vclk,hsp,vsp */     
+  /* HT, HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+  {REFRESH_60,CLK_26_880M ,M720X480_R60_HSP, M720X480_R60_VSP,\
+  {896, 720, 720, 176, 736, 72,  497, 480, 480, 17,  481, 3}}
+
+};
+
+/* 720x576 (GTF) */
+static struct crt_mode_table CRTM720x576[] = {
+  /* r_rate,vclk,hsp,vsp */
+  /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+  {REFRESH_60,CLK_32_668M ,M720X576_R60_HSP, M720X576_R60_VSP,\
+  {912, 720, 720, 192, 744, 72,  597, 576, 576, 21,  577, 3}}
+};
+
+/* 800x480 (GTF) */
+static struct crt_mode_table CRTM800x480[] = {
+  /* r_rate,vclk,hsp,vsp */
+  /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+  {REFRESH_60,CLK_29_581M ,M800X480_R60_HSP,M800X480_R60_VSP,\
+  {992, 800, 800, 192, 816, 80,  497, 480, 480, 17,  481, 3}}
+};
+/* 800x600 */
+static struct crt_mode_table CRTM800x600[] = {
+  /* r_rate,vclk,hsp,vsp */     
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
+static struct crt_mode_table CRTM848x480[] = {
+  /* r_rate,vclk,hsp,vsp */     
+  /* HT,   HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+  {REFRESH_60,CLK_31_490M ,M848X480_R60_HSP, M848X480_R60_VSP,\
+  {1056, 848, 848, 208, 864, 88,  497, 480, 480, 17,  481, 3}}
+};
+
+/* 856x480 (GTF) convert to 852x480 */
+static struct crt_mode_table CRTM852x480[] = {
+  /* r_rate,vclk,hsp,vsp */    
+  /* HT,   HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+  {REFRESH_60,CLK_31_728M ,M852X480_R60_HSP, M852X480_R60_VSP,\
+  {1064, 856, 856, 208, 872, 88,  497, 480, 480, 17,  481, 3}}
+
+};
+
+/* 1024x512 (GTF) */
+static struct crt_mode_table CRTM1024x512[] = {
+  /* r_rate,vclk,hsp,vsp */    
+  /* HT,   HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+  {REFRESH_60,CLK_41_291M ,M1024X512_R60_HSP, M1024X512_R60_VSP,\
+  {1296, 1024,1024,272, 1056,104, 531, 512, 512, 19,  513, 3}}
+
+};
+
+/* 1024x576 (GTF) */
+/*static struct crt_mode_table CRTM1024x576[] = {
+  //r_rate,vclk,     HT,   HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE
+  { 60,CLK_46_996M ,{1312, 1024,1024,288, 1064,104, 597, 576, 576, 21,  577, 3}}
+
+};*/
+
+/* 1024x768 */
+static struct crt_mode_table CRTM1024x768[] = {
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
+static struct crt_mode_table CRTM1152x864[] = {
+  /* r_rate,vclk,hsp,vsp */      
+  /* HT,  HA,   HBS,  HBE, HSS,  HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+  {REFRESH_75,CLK_108_000M ,M1152X864_R75_HSP, M1152X864_R75_VSP,\
+  {1600, 1152,1152, 448, 1216, 128, 900, 864, 864, 36,  865, 3}}
+
+};
+
+/* 1280x720 (GTF) */
+static struct crt_mode_table CRTM1280x720[] = {
+  /* r_rate,vclk,hsp,vsp */
+  /* HT,  HA,   HBS,  HBE, HSS,  HSE, VT,  VA,  VBS, VBE, VSS, VSE */      
+  {REFRESH_60,CLK_74_481M ,M1280X720_R60_HSP, M1280X720_R60_VSP,\
+  {1664,1280, 1280, 384, 1336, 136, 746, 720, 720, 26,  721, 3}}
+};
+
+/* 1280x768 (GTF) */
+static struct crt_mode_table CRTM1280x768[] = {
+  /* r_rate,vclk,hsp,vsp */     
+  /* HT,  HA,   HBS,  HBE, HSS,  HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+  {REFRESH_60,CLK_80_136M ,M1280X768_R60_HSP, M1280X768_R60_VSP,\
+  {1680,1280, 1280, 400, 1344, 136, 795, 768, 768, 27,  769, 3}}
+};
+
+/*1280x960 */
+static struct crt_mode_table CRTM1280x960[] = {
+  /* r_rate,vclk,hsp,vsp */ 
+  /* HT,  HA,   HBS,  HBE, HSS,  HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+  {REFRESH_60,CLK_108_000M ,M1280X960_R60_HSP, M1280X960_R60_VSP,\
+  {1800,1280, 1280, 520, 1376, 112, 1000,960, 960, 40,  961, 3}}  
+};
+
+/* 1280x1024 */
+static struct crt_mode_table CRTM1280x1024[] = {
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
+static struct crt_mode_table CRTM1368x768[] = {
+  /* r_rate,  vclk, hsp, vsp */
+  /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+  {REFRESH_60, CLK_85_860M, M1368X768_R60_HSP, M1368X768_R60_VSP,\
+  {1800,1368, 1368, 432, 1440, 144, 795, 768, 768, 27,  769, 3}}
+};
+
+/* 1368x768 (GTF) */
+/*static struct crt_mode_table CRTM1368x768[] = {
+  //r_rate,vclk,     HT,  HA,   HBS,  HBE, HSS,  HSE, VT,  VA,  VBS, VBE, VSS, VSE 
+  { 60,CLK_85_860M ,{1800,1368, 1368, 432, 1440, 144, 795, 768, 768, 27,  769, 3}}
+};*/
+
+/* 1440x1050 (GTF) */
+static struct crt_mode_table CRTM1440x1050[] = {
+  /* r_rate,vclk,hsp,vsp */       
+  /* HT,  HA,   HBS,  HBE, HSS,  HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+  {REFRESH_60 ,CLK_125_104M ,M1440X1050_R60_HSP, M1440X1050_R60_VSP,\
+  {1936,1440, 1440, 496, 1536, 152, 1077,1040,1040,37,  1041,3}}
+};
+
+/* 1600x1200 */
+static struct crt_mode_table CRTM1600x1200[] = {
+  /* r_rate,vclk,hsp,vsp */
+  /* HT,  HA,   HBS,  HBE, HSS,  HSE, VT,  VA,  VBS, VBE, VSS, VSE */      
+  {REFRESH_60 ,CLK_162_000M ,M1600X1200_R60_HSP, M1600X1200_R60_VSP,\
+  {2160,1600, 1600, 560, 1664, 192, 1250,1200,1200,50,  1201,3}},
+  {REFRESH_75 ,CLK_202_500M ,M1600X1200_R75_HSP, M1600X1200_R75_VSP,\
+  {2160,1600, 1600, 560, 1664, 192, 1250,1200,1200,50,  1201,3}}
+
+};
+
+/* 1920x1080 (GTF) */
+static struct crt_mode_table CRTM1920x1080[] = {
+  /* r_rate,vclk,hsp,vsp */
+  /* HT,  HA,   HBS,  HBE, HSS,  HSE, VT,  VA,  VBS, VBE, VSS, VSE */                            
+  {REFRESH_60,CLK_172_798M ,M1920X1080_R60_HSP, M1920X1080_R60_VSP,\
+  {2576,1920, 1920, 656, 2040, 208, 1118,1080,1080,38, 1081, 3}}
+};
+
+/* 1920x1440 */
+static struct crt_mode_table CRTM1920x1440[] = {
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
+static struct crt_mode_table CRTM1400x1050[] = {
+  /* r_rate,          vclk,              hsp,             vsp   */
+  /* HT,  HA,  HBS, HBE, HSS, HSE,    VT,  VA,  VBS, VBE,  VSS, VSE */
+  {REFRESH_60,CLK_108_000M, M1400X1050_R60_HSP, M1400X1050_R60_VSP,
+  {1688,1400, 1400, 288, 1448, 112, 1066,1050, 1050,  16, 1051, 3}}
+};
+#endif
+
+/* 1400x1050 (GTF) */
+static struct crt_mode_table CRTM1400x1050[] = {
+  /* r_rate,          vclk,              hsp,             vsp   */
+  /* HT,  HA,  HBS, HBE,  HSS, HSE,   VT,  VA,  VBS, VBE,  VSS, VSE */
+  {REFRESH_60,CLK_122_614M, M1400X1050_R60_HSP, M1400X1050_R60_VSP,
+  {1880,1400, 1400, 480, 1488, 152, 1087,1050, 1050,  37, 1051, 3}}
+};
+
+static struct VideoModeTable CLE266Modes[] = {
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
+   /*{ M1280x800, CRTM1280x800, ARRAY_SIZE(CRTM1280x800)},*/ 
+
+   /* Display : 1280x960 */
+   { VIA_RES_1280X960, CRTM1280x960, ARRAY_SIZE(CRTM1280x960)},
+
+   /* Display : 1280x1024 */
+   { VIA_RES_1280X1024, CRTM1280x1024,ARRAY_SIZE(CRTM1280x1024)},
+
+   /* Display : 1368x768 (GTF) */
+   /*{ M1368x768,CRTM1368x768,ARRAY_SIZE(CRTM1368x768)},*/ 
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

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
