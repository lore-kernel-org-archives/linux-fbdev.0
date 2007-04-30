From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 8/12] viafb: Framebuffer driver for VIA
 UniChrome/Chrome9 HC (fwd)
Date: Mon, 30 Apr 2007 10:37:32 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704301037260.27246@anakin>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HiRO8-0006XT-Gr for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Apr 2007 01:37:43 -0700
Received: from europa.telenet-ops.be ([195.130.137.75])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HiRO7-0001qp-2I
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Apr 2007 01:37:40 -0700
Received: from localhost (localhost.localdomain [127.0.0.1])
	by europa.telenet-ops.be (Postfix) with SMTP id 278A341A3
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 30 Apr 2007 10:37:38 +0200 (CEST)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by europa.telenet-ops.be (Postfix) with ESMTP id 08B88417B
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 30 Apr 2007 10:37:33 +0200 (CEST)
Received: from anakin.of.borg (geert@localhost [127.0.0.1])
	by anakin.of.borg (8.13.8/8.13.8/Debian-3) with ESMTP id l3U8bWH4020418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 30 Apr 2007 10:37:32 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.13.8/8.13.8/Submit) with ESMTP id l3U8bWPu020415
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 30 Apr 2007 10:37:32 +0200
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
Date: Mon, 30 Apr 2007 13:20:36 +0800
From: EddyFu@via.com.tw
To: linux-fbdev-devel-bounces@lists.sourceforge.net
Subject: [Linux-fbdev-devel] [PATCH 8/12] viafb: Framebuffer driver for VIA
    UniChrome/Chrome9 HC

Dear All, 
 
Here is the part 8/12 of viafb.
 
Best Regards,
Eddy Fu 
 
diff -Nur linux-2.6.21-rc7/drivers/video/via/tbl1625.h linux-2.6.21-rc7.viafb/drivers/video/via/tbl1625.h
--- linux-2.6.21-rc7/drivers/video/via/tbl1625.h 1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/tbl1625.h 2007-04-26 19:52:32.000000000 -0400
@@ -0,0 +1,2006 @@
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
+#ifndef __TBL1625_H__
+#define __TBL1625_H__
+
+#include "share.h"
+
+/***************************/
+/* VT1625 TV Encoder Table */
+/***************************/
+typedef struct _vt1625_func_table {
+    int     tv_func_index;
+    u16     *tv_underscan;
+    u16     *tv_fitscan;
+    u16     *tv_overscan;
+} vt1625_func_table;
+
+struct vt1625_table {
+    int     tv_index;
+    vt1625_func_table   *tv_mode_ntsc;
+    vt1625_func_table   *tv_mode_pal;
+    vt1625_func_table   *tv_mode_720p;
+    vt1625_func_table   *tv_mode_1080i;
+};
+
+
+/* Underscan table */
+static u16 VT1625_N640x480_VN[] = {
+                                                
+    0x0300, 0x0001, 0x1002, 0x1F03, 0x0004,     /* TV.00-04 */
+    0x0005, 0x0006, 0x2907, 0x4008, 0x0B09,     /* Tv.05-09 */
+    0x7B0A, 0x150B, 0x500C, 0x570D, 0x000E,     /* TV.0A-0E */
+    0x9E0F, 0x0010, 0x8011, 0xFA12, 0x2113,     /* TV.0F-13 */
+    0xE014, 0x6815, 0xD616, 0x7B17, 0xF018,     /* TV.14-18 */
+    0x2119,                                     /* TV.19 */
+    0x501B, 0x011C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x101F, 0x1C20, 0x2A21, 0xCB22,     /* TV.1E-22 */
+    0x7723, 0x0024,                             /* TV.23-24 */
+
+
+                                                /* Filter registers */
+    0xC54A, 0x00F4B, 0x004C, 0x014D, 0x104E,     /* TV.4A-4E */
+    0x4A4F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0x0F50, 0x8151, 0x2352, 0x5753, 0x2254,     /* TV.50-54 */
+    0x5955, 0x8156, 0x7F57, 0x2358, 0x9159,     /* TV.55-59 */
+    0xD25A, 0x135B, 0x7C5C, 0x165D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x495E, 0x005F, 0x9260, 0x2061, 0xFF62,     /* TV.5E-62 */
+    0x7F63, 0x0364, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA, HBS, HBE, HSS, HSE,  VT,  VA, VBS, VBE, VSS, VSE */
+    784, 640, 640, 144, 688, 56,  600, 480, 480, 120, 488, 7
+};
+
+#define NUM_TOTAL_VT1625_REG ARRAY_SIZE(VT1625_N640x480_VN) -NUM_CRTC_TIMING
+
+static u16 VT1625_N800x600_VN[] = {
+
+    0x0300, 0x0001, 0x1002, 0x9003, 0x0004,     /* TV.00-04 */
+    0x0005, 0x0006, 0x5807, 0x4508, 0x0909,     /* TV.05-09 */
+    0x7B0A, 0x150B, 0x500C, 0x570D, 0x000E,     /* TV.0A-0E */
+    0x9E0F, 0x0010, 0x8011, 0xED12, 0x2113,     /* TV.0F-13 */
+    0xBE14, 0x3415, 0xD616, 0x7B17, 0xF018,     /* TV.14-18 */
+    0x2119,                                     /* TV.19 */
+    0x501B, 0x011C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x101F, 0x1C20, 0x0A21, 0xC922,     /* TV.1E-22 */
+    0x7723, 0x0024,                             /* TV.23-24 */
+
+
+                                                /* Filter registers */
+    0xC54A, 0x0F4B, 0x004C, 0x014D, 0x104E,     /* TV.4A-4E */
+    0x4A4F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0x2750, 0x2251, 0x3452, 0xED53, 0x2254,     /* TV.50-54 */
+    0x5955, 0x7B56, 0x7F57, 0x2358, 0x8C59,     /* TV.55-59 */
+    0xD25A, 0x135B, 0x7A5C, 0x165D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0xDB5E, 0x1A5F, 0xB660, 0xAA61, 0xFF62,     /* TV.5E-62 */
+    0xEF63, 0x0564, 0x5165,                     /* TV.63-65 */
+
+    /* HT,   HA, HBS, HBE, HSS, HSE,  VT,  VA, VBS, VBE, VSS, VSE */
+    1064, 800, 800, 264, 840, 136, 750, 600, 600, 150, 606, 15
+};
+
+static u16 VT1625_N1024x768_VN[] = {
+                                                
+    0x0300, 0x0001, 0x1002, 0x9A03, 0x0004,     /* TV.00-04 */
+    0x0005, 0x0006, 0x1107, 0x7A08, 0x0C09,     /* TV.05-09 */
+    0x7B0A, 0x150B, 0x500C, 0x570D, 0x000E,     /* TV.0A-0E */
+    0x9E0F, 0x0010, 0x8011, 0x2812, 0x0D13,     /* TV.0F-13 */
+    0x2814, 0x1415, 0xB416, 0x8317, 0x0F18,     /* TV.14-18 */
+    0x1619,                                     /* TV.19 */
+    0x501B, 0x011C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x001F, 0x1220, 0xFF21, 0xA522,     /* TV.1E-22 */
+    0x7723, 0x0C24,                             /* TV.23-24 */
+
+
+                                                /* Filter registers */
+    0xC54A, 0x0F4B, 0x004C, 0x014D, 0x104E,     /* TV.4A-4E */
+    0x4A4F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0x5F50, 0x0251, 0x4452, 0xDD53, 0x0354,     /* TV.50-54 */
+    0x2755, 0xA456, 0xC357, 0x3558, 0xE259,     /* TV.55-59 */
+    0x475A, 0xA05B, 0xFF5C, 0x595D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x5F5E, 0xCC5F, 0xF160, 0x2861, 0xFF62,     /* TV.5E-62 */
+    0x3F63, 0x0864, 0x5165,                     /* TV.63-65 */
+
+  /*  HT,   HA,  HBS, HBE, HSS, HSE, VT,  VA, VBS, VBE, VSS, VSE */
+    1120, 1024, 1024, 96, 1080, 24, 990, 768, 768, 222, 800, 6
+};
+
+static u16 VT1625_N720x480_VN[] = {
+                                               
+    0x0300, 0x0001, 0x1002, 0x1F03, 0x0004,     /* TV.00-04 */
+    0x0005, 0x0006, 0x2A07, 0x4108, 0x0A09,     /* TV.05-09 */
+    0x7B0A, 0x150B, 0x500C, 0x570D, 0x000E,     /* TV.0A-0E */
+    0xB70F, 0x0010, 0x8011, 0xAB12, 0x2713,     /* TV.0F-13 */
+    0x7014, 0x2C15, 0xD616, 0x7B17, 0xF018,     /* TV.14-18 */
+    0x2119,                                     /* TV.19 */
+    0x501B, 0x011C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x101F, 0x1C20, 0x0821, 0xCB22,     /* TV.1E-22 */
+    0x7723, 0x0224,                             /* TV.23-24 */
+
+
+                                                /* Filter registers */
+    0xC54A, 0x0F4B, 0x004C, 0x014D, 0x104E,     /* TV.4A-4E */
+    0x4A4F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0x0F50, 0xCF51, 0x2352, 0x5753, 0x2254,     /* TV.50-54 */
+    0x5955, 0x8356, 0x7F57, 0x2358, 0x9159,     /* TV.55-59 */
+    0xD25A, 0x135B, 0x7A5C, 0x165D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x495E, 0xF15F, 0x9260, 0xA861, 0xFF62,     /* TV.5E-62 */
+    0x7F63, 0x0364, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA, HBS, HBE, HSS, HSE,  VT,  VA, VBS, VBE, VSS, VSE */
+    784, 720, 720, 64,  728,  16, 600, 480, 480, 120, 490, 6
+};
+
+static u16 VT1625_P640x480_VN[] = {
+                                                
+    0x0300, 0x0001, 0x1002, 0x1F03, 0x0304,     /* TV.00-04 */
+    0x0005, 0x0006, 0xF207, 0x4208, 0x0A09,     /* TV.05-09 */
+    0x880A, 0x000B, 0x550C, 0x5E0D, 0x000E,     /* TV.0A-0E */
+    0xB00F, 0x0010, 0x8011, 0x0A12, 0x0913,     /* TV.0F-13 */
+    0x1914, 0x2815, 0xCB16, 0x8A17, 0x0918,     /* TV.14-18 */
+    0x2A19,                                     /* TV.19 */
+    0x501B, 0x011C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x101F, 0x1720, 0x1C21, 0x3522,     /* TV.1E-22 */
+    0x7D23, 0x0224,                             /* TV.23-24 */
+
+
+                                                /* Filter registers */
+    0xC54A, 0x0F4B, 0x004C, 0x014D, 0x104E,     /* TV.4A-4E */
+    0x514F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xE750, 0x8151, 0x2352, 0x5753, 0x2254,     /* TV.50-54 */
+    0x5F55, 0x6F56, 0x7F57, 0x2358, 0x9459,     /* TV.55-59 */
+    0xD05A, 0x1C5B, 0x8F5C, 0x165D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0xE15E, 0x385F, 0x7A60, 0x2861, 0xFF62,     /* TV.5E-62 */
+    0xBF63, 0x0364, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA, HBS, HBE, HSS, HSE,  VT,  VA, VBS, VBE, VSS, VSE */
+    1000, 640, 640, 360, 704, 56,  600, 480, 480, 120, 500, 6
+};
+
+static u16 VT1625_P800x600_VN[] = {
+                                                   
+    0x0300, 0x0001, 0x1002, 0x9003, 0x0304,     /* TV.00-04 */
+    0x0005, 0x0006, 0x2807, 0x4108, 0x0F09,     /* TV.05-09 */
+    0x880A, 0x000B, 0x550C, 0x5E0D, 0x000E,     /* TV.0A-0E */
+    0x9E0F, 0x0010, 0x8011, 0x1212, 0x0413,     /* TV.0F-13 */
+    0x1714, 0x4815, 0xCB16, 0x8A17, 0x0918,     /* TV.14-18 */
+    0x2A19,                                     /* TV.19 */
+    0x501B, 0x011C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x101F, 0x1720, 0x1C21, 0x3122,     /* TV.1E-22 */
+    0x7D23, 0x0224,                             /* TV.23-24 */
+
+
+                                                /* Filter registers */
+    0xC54A, 0x0F4B, 0x004C, 0x014D, 0x104E,     /* TV.4A-4E */
+    0x514F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0x9750, 0x2251, 0x3352, 0xED53, 0x2254,     /* TV.50-54 */
+    0x5F55, 0x7356, 0x7F57, 0x2358, 0x9459,     /* TV.55-59 */
+    0xD05A, 0x275B, 0x8F5C, 0x165D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x995E, 0x385F, 0x9960, 0xAA61, 0xFF62,     /* TV.5E-62 */
+    0x4F63, 0x0464, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA, HBS, HBE, HSS, HSE,  VT,  VA, VBS, VBE, VSS, VSE */
+    920, 800, 800, 120, 816, 64,  750, 600, 600, 150, 606, 16
+};
+
+static u16 VT1625_P1024x768_VN[] = {
+                                                
+    0x0300, 0x0001, 0x1002, 0x9A03, 0x0304,     /* TV.00-04 */
+    0x0005, 0x0006, 0x8907, 0x6408, 0x0D09,     /* TV.05-09 */
+    0x880A, 0x000B, 0x550C, 0x5E0D, 0x000E,     /* TV.0A-0E */
+    0x9E0F, 0x0010, 0x8011, 0x2D12, 0x0813,     /* TV.0F-13 */
+    0x2714, 0x2415, 0x8716, 0x5C17, 0x0618,     /* TV.14-18 */
+    0x1C19,                                     /* TV.19 */
+    0x501B, 0x011C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x001F, 0x1D20, 0x1C21, 0x8922,     /* TV.1E-22 */
+    0x7D23, 0x0224,                             /* TV.23-24 */
+
+
+                                                /* Filter registers */
+    0xC54A, 0x0F4B, 0x004C, 0x014D, 0x104E,     /* TV.4A-4E */
+    0x514F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xAF50, 0x0251, 0x4452, 0xCE53, 0x0354,     /* TV.50-54 */
+    0x0F55, 0xA456, 0xBE57, 0x3558, 0xDC59,     /* TV.55-59 */
+    0x3E5A, 0xB55B, 0xDB5C, 0x595D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0xAE5E, 0xCD5F, 0xC760, 0x2861, 0xFF62,     /* TV.5E-62 */
+    0x4F63, 0x0764, 0x5165,                     /* TV.63-65 */
+
+    /*  HT,   HA,  HBS, HBE,  HSS, HSE, VT,  VA, VBS, VBE, VSS, VSE */
+    1200, 1024, 1024, 176, 1048, 16, 975, 768, 768, 107, 800, 6
+};
+
+static u16 VT1625_P720x576_VN[] = {
+                                               
+    0x0300, 0x0001, 0x1002, 0x1F03, 0x0304,     /* TV.00-04 */
+    0x0005, 0x0006, 0xC907, 0x4C08, 0x1009,     /* TV.05-09 */
+    0x7C0A, 0x000B, 0x560C, 0x570D, 0x030E,     /* TV.0A-0E */
+    0xBF0F, 0x0010, 0x8011, 0x0912, 0x0813,     /* TV.0F-13 */
+    0x1714, 0x2415, 0xCB16, 0x8A17, 0x0918,     /* TV.14-18 */
+    0x2A19,                                     /* TV.19 */
+    0x501B, 0x011C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x101F, 0x1420, 0x0C21, 0x3222,     /* TV.1E-22 */
+    0x7E23, 0x0024,                             /* TV.23-24 */
+
+
+                                                /* Filter registers */
+    0xC54A, 0x0F4B, 0x004C, 0x014D, 0x004E,     /* TV.4A-4E */
+    0x4B4F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xE750, 0xD251, 0x2352, 0xB153, 0x2254,     /* TV.50-54 */
+    0x5F55, 0x6156, 0x7F57, 0x2358, 0x9059,     /* TV.55-59 */
+    0xCD5A, 0x355B, 0x835C, 0x165D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x4F5E, 0x765F, 0x8D60, 0xA961, 0xFF62,     /* TV.5E-62 */
+    0x4F63, 0x0464, 0x5165,                     /* TV.63-65 */
+
+    /* HT,   HA, HBS, HBE, HSS, HSE, VT,  VA, VBS, VBE, VSS, VSE */
+    1000, 720, 720, 280, 760, 40, 690, 576, 576, 114, 577, 3
+};
+
+
+/* Fit Industry TV Screen Mode */
+static u16 VT1625_N640x480_VF[] = {
+                                                
+    0x0300, 0x0001, 0x1002, 0x1F03, 0x0004,     /* TV.00-04 */
+    0x0005, 0x0006, 0x5807, 0x3708, 0x0B09,     /* TV.05-09 */
+    0x7B0A, 0x150B, 0x500C, 0x570D, 0x070E,     /* TV.0A-0E */
+    0xB00F, 0x0010, 0x8011, 0xF612, 0x2713,     /* TV.0F-13 */
+    0xCD14, 0x5815, 0xD616, 0x7B17, 0xF018,     /* TV.14-18 */
+    0x2119,                                     /* TV.19 */
+    0x501B, 0x011C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x101F, 0x1C20, 0x2A21, 0xCB22,     /* TV.1E-22 */
+    0x7723, 0x0024,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0xC54A, 0x0F4B, 0x004C, 0x014D, 0x104E,     /* TV.4A-4E */
+    0x4A4F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xED50, 0x8151, 0x2252, 0x3D53, 0x2254,     /* TV.50-54 */
+    0x5955, 0x9156, 0x7F57, 0x2358, 0x9059,     /* TV.55-59 */
+    0xD35A, 0x135B, 0x7A5C, 0x165D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0xF25E, 0xCE5F, 0x8B60, 0x2761, 0xFF62,     /* TV.5E-62 */
+    0x3363, 0x0364, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    750, 640, 640, 110, 648, 16,  574, 480, 480, 94,  490, 6
+};
+
+static u16 VT1625_N800x600_VF[] = {
+                                                  
+    0x0300, 0x0001, 0x1002, 0x9003, 0x0004,     /* TV.00-04 */
+    0x0005, 0x0006, 0x8707, 0x3708, 0xFE09,     /* TV.05-09 */
+    0x7B0A, 0x150B, 0x500C, 0x570D, 0x000E,     /* TV.0A-0E */
+    0xB70F, 0x0010, 0x8011, 0x2912, 0x0B13,     /* TV.0F-13 */
+    0x3014, 0x2415, 0xD616, 0x7B17, 0xF018,     /* TV.14-18 */
+    0x2119,                                     /* TV.19 */
+    0x501B, 0x011C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x101F, 0x1C20, 0x2A21, 0xC822,     /* TV.1E-22 */
+    0x7723, 0x0024,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0xC54A, 0x0F4B, 0x004C, 0x014D, 0x104E,     /* TV.4A-4E */
+    0x4A4F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xAF50, 0x2351, 0x3452, 0xD753, 0x2254,     /* TV.50-54 */
+    0x5955, 0x9156, 0x7F57, 0x2358, 0x9059,     /* TV.55-59 */
+    0xD25A, 0x135B, 0x7A5C, 0x165D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x7E5E, 0xC55F, 0xB160, 0xA961, 0xFF62,     /* TV.5E-62 */
+    0x7F63, 0x0664, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1200,800, 800, 400, 848, 216, 728, 600, 600, 128, 656, 9
+};
+
+static u16 VT1625_N1024x768_VF[] = {
+                                                  
+    0x0300, 0x0001, 0x1002, 0x9A03, 0x0004,     /* TV.00-04 */
+    0x0005, 0x0006, 0x9707, 0x4008, 0x1009,     /* TV.05-09 */
+    0x7B0A, 0x150B, 0x500C, 0x570D, 0x000E,     /* TV.0A-0E */
+    0xB00F, 0x0010, 0x8011, 0xF612, 0x2713,     /* TV.0F-13 */
+    0x0C14, 0x2D15, 0x6D16, 0x0717, 0x2A18,     /* TV.14-18 */
+    0x1B19,                                     /* TV.19 */
+    0x501B, 0x031C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x0C1F, 0x1620, 0xFF21, 0x1B22,     /* TV.1E-22 */
+    0x7723, 0x0024,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0xC54A, 0x0F4B, 0x004C, 0x014D, 0x104E,     /* TV.4A-4E */
+    0x4A4F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xAF50, 0x0351, 0x4452, 0xA953, 0x0354,     /* TV.50-54 */
+    0x2F55, 0x3B56, 0x9F57, 0x3458, 0xB659,     /* TV.55-59 */
+    0x095A, 0x545B, 0x1D5C, 0x585D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0xB15E, 0xEC5F, 0xE460, 0xA961, 0xFF62,     /* TV.5E-62 */
+    0x5F63, 0x0864, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1200,1024,1024,176, 1032,16,  938, 768, 768, 170, 777, 9
+};
+
+static u16 VT1625_N720x480_VF[] = {
+                                                  
+    0x0300, 0x0001, 0x1002, 0x1F03, 0x0004,     /* TV.00-04 */
+    0x0005, 0x0006, 0x4107, 0x3B08, 0x0B09,     /* TV.05-09 */
+    0x7B0A, 0x150B, 0x500C, 0x570D, 0x000E,     /* TV.0A-0E */
+    0xB70F, 0x0010, 0x8011, 0xCD12, 0x2113,     /* TV.0F-13 */
+    0x7314, 0x3415, 0xD616, 0x7B17, 0xF018,     /* TV.14-18 */
+    0x2119,                                     /* TV.19 */
+    0x501B, 0x031C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x101F, 0x1C20, 0x0821, 0xCA22,     /* TV.1E-22 */
+    0x7723, 0x0224,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0xC54A, 0x0F4B, 0x004C, 0x014D, 0x104E,     /* TV.4A-4E */
+    0x4A4F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0x4750, 0xCF51, 0x2352, 0x3E53, 0x2254,     /* TV.50-54 */
+    0x5955, 0x8B56, 0x7F57, 0x2358, 0x9159,     /* TV.55-59 */
+    0xD25A, 0x135B, 0x7A5C, 0x165D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x305E, 0xD45F, 0x8C60, 0x2861, 0xFF62,     /* TV.5E-62 */
+    0x9763, 0x0364, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    840, 720, 720, 120, 728, 48,  575, 480, 480, 95,  484, 15
+};
+
+static u16 VT1625_P640x480_VF[] = {
+                                                  
+    0x0300, 0x0001, 0x1002, 0x1F03, 0x0304,     /* TV.00-04 */
+    0x0005, 0x0006, 0x5207, 0x3A08, 0x0509,     /* Tv.05-09 */
+    0x880A, 0x000B, 0x550C, 0x5E0D, 0x000E,     /* TV.0A-0E */
+    0xB70F, 0x0010, 0x8011, 0xCC12, 0x2413,     /* TV.0F-13 */
+    0x7314, 0x3015, 0xCB16, 0x8A17, 0x0918,     /* TV.14-18 */
+    0x2A19,                                     /* TV.19 */
+    0x501B, 0x011C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x101F, 0x1720, 0x1C21, 0x3522,     /* TV.1E-22 */
+    0x7D23, 0x0024,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0xC54A, 0x0F4B, 0x004C, 0x014D, 0x104E,     /* TV.4A-4E */
+    0x514F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xE750, 0x8151, 0x2352, 0x3E53, 0x2254,     /* TV.50-54 */
+    0x5F55, 0x8056, 0x7F57, 0x2358, 0x9459,     /* TV.55-59 */
+    0xD15A, 0x275B, 0x8F5C, 0x165D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0xC25E, 0x005F, 0x7560, 0x2061, 0xFF62,     /* TV.5E-62 */
+    0x9763, 0x0364, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1000,640, 640, 360, 840, 80,  575, 480, 480, 95,  501, 3
+};
+
+static u16 VT1625_P800x600_VF[] = {
+                                                  
+    0x0300, 0x0001, 0x1002, 0x9003, 0x0304,     /* TV.00-04 */
+    0x0005, 0x0006, 0x4807, 0x3708, 0x1309,     /* TV.05-09 */
+    0x880A, 0x000B, 0x550C, 0x5E0D, 0x000E,     /* TV.0A-0E */
+    0xB00F, 0x0010, 0x8011, 0xE912, 0x3013,     /* TV.0F-13 */
+    0x9114, 0x2415, 0xCB16, 0x8A17, 0x0918,     /* TV.14-18 */
+    0x2A19,                                     /* TV.19 */
+    0x501B, 0x011C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x101F, 0x1720, 0x1C21, 0x3222,     /* TV.1E-22 */
+    0x7D23, 0x0224,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0xC54A, 0x0F4B, 0x004C, 0x014D, 0x104E,     /* TV.4A-4E */
+    0x514F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xE750, 0x2151, 0x3352, 0xD453, 0x2254,     /* TV.50-54 */
+    0x5F55, 0x8756, 0x7F57, 0x2358, 0x9459,     /* TV.55-59 */
+    0xD15A, 0x275B, 0x8F5C, 0x165D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x7A5E, 0xE85F, 0x9460, 0xA961, 0xFF62,     /* TV.5E-62 */
+    0x8763, 0x0464, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1000,800, 800, 200, 848, 80,  725, 600, 600, 125, 602, 1
+};
+
+static u16 VT1625_P1024x768_VF[] = {
+                                                
+    0x0300, 0x0001, 0x1002, 0x9A03, 0x0304,     /* TV.00-04 */
+    0x0005, 0x0006, 0x9807, 0x4008, 0x0F09,     /* TV.05-09 */
+    0x880A, 0x000B, 0x550C, 0x5E0D, 0x000E,     /* TV.0A-0E */
+    0xB50F, 0x0010, 0x8011, 0xF812, 0x2413,     /* TV.0F-13 */
+    0x0314, 0x3915, 0x7A16, 0xE017, 0x0E18,     /* TV.14-18 */
+    0x2319,                                     /* TV.19 */
+    0x501B, 0x011C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x101F, 0x1D20, 0x1C21, 0xBA22,     /* TV.1E-22 */
+    0x7D23, 0x0024,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0xC54A, 0x0F4B, 0x004C, 0x014D, 0x104E,     /* TV.4A-4E */
+    0x514F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xAF50, 0x0251, 0x4452, 0x9C53, 0x0354,     /* TV.50-54 */
+    0x0B55, 0x0756, 0x9857, 0x3458, 0xB259,     /* TV.55-59 */
+    0xFB5A, 0x4E5B, 0xF55C, 0x175D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x705E, 0x945F, 0xBD60, 0xAA61, 0xFF62,     /* TV.5E-62 */
+    0xEF63, 0x0664, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1200,1024,1024,176, 1032,16,  925, 768, 768, 157, 778, 6
+};
+
+static u16 VT1625_P720x576_VF[] = {
+                                                  
+    0x0300, 0x0001, 0x1002, 0x1F03, 0x0304,     /* TV.00-04 */
+    0x0005, 0x1006, 0x0307, 0x3908, 0x0609,     /* TV.05-09 */
+    0x880A, 0x000B, 0x550C, 0x5E0D, 0x000E,     /* TV.0A-0E */
+    0xB00F, 0x0010, 0x8011, 0x6912, 0x1813,     /* TV.0F-13 */
+    0x4314, 0x2415, 0xCB16, 0x8A17, 0x0918,     /* TV.14-18 */
+    0x2A19,                                     /* TV.19 */
+    0x501B, 0x011C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x101F, 0x1720, 0x0C21, 0x3222,     /* TV.1E-22 */
+    0x7D23, 0x0224,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0xC54A, 0x0F4B, 0x004C, 0x014D, 0x104E,     /* TV.4A-4E */
+    0x514F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xE750, 0xCF51, 0x2352, 0x9D53, 0x2254,     /* TV.50-54 */
+    0x5F55, 0x8356, 0x7E57, 0x2358, 0x9459,     /* TV.55-59 */
+    0xD05A, 0x275B, 0x8F5C, 0x165D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x375E, 0xF35F, 0x8960, 0x2861, 0xFF62,     /* TV.5E-62 */
+    0x2F63, 0x0464, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1000, 720, 720, 280, 736, 16,  670, 576, 576, 94,  586, 6
+};
+
+/* TV Overscan Table */
+
+static u16 VT1625_N640x480_VO[] = {
+                                               
+    0x0300, 0x0001, 0x1002, 0x1F03, 0x0004,     /* TV.00-04 */
+    0x0005, 0x0006, 0x9207, 0x2A08, 0x0109,     /* TV.05-09 */
+    0x7B0A, 0x150B, 0x500C, 0x570D, 0x3F0E,     /* TV.0A-0E */
+    0xB00F, 0x0010, 0x8011, 0xAD12, 0x2113,     /* TV.0F-13 */
+    0x6514, 0x3415, 0x3916, 0x2317, 0x0A18,     /* TV.14-18 */
+    0x2419,                                     /* TV.19 */
+    0x501B, 0x031C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x141F, 0x1C20, 0x2A21, 0xDB22,     /* TV.1E-22 */
+    0x7723, 0x0024,                             /* TV.23-24 */
+
+
+                                                /* Filter registers */
+    0xC54A, 0x0F4B, 0x004C, 0x014D, 0x104E,     /* TV.4A-4E */
+    0x4A4F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0x2750, 0x8251, 0x2352, 0x0C53, 0x0254,     /* TV.50-54 */
+    0x2755, 0x8056, 0x7757, 0x2358, 0x8359,     /* TV.55-59 */
+    0xC35A, 0xFB5B, 0x115C, 0x065D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x005E, 0x005F, 0x8060, 0x2061, 0xFF62,     /* TV.5E-62 */
+    0x2763, 0x0364, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA, HBS, HBE, HSS, HSE, VT,  VA, VBS, VBE,VSS, VSE */
+    808, 640, 640, 168, 688, 24, 525, 480, 480, 45, 490, 6
+};
+
+static u16 VT1625_N800x600_VO[] = {
+                                                
+    0x0300, 0x0001, 0x1002, 0x9003, 0x0004,     /* TV.00-04 */
+    0x0005, 0x1006, 0x0107, 0x1E08, 0x0309,     /* TV.05-09 */
+    0x7B0A, 0x150B, 0x500C, 0x570D, 0x000E,     /* TV.0A-0E */
+    0xB00F, 0x0010, 0x8011, 0xED12, 0x2113,     /* TV.0F-13 */
+    0xBC14, 0x3415, 0xD616, 0x7B17, 0xF018,     /* TV.14-18 */
+    0x2119,                                     /* TV.19 */
+    0x501B, 0x031C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x101F, 0x1C20, 0x2A21, 0xCA22,     /* TV.1E-22 */
+    0x7723, 0x0024,                             /* TV.23-24 */
+
+
+                                                /* Filter registers */
+    0xC54A, 0x0F4B, 0x004C, 0x014D, 0x104E,     /* TV.4A-4E */
+    0x4A4F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xAF50, 0x2251, 0x3452, 0x9153, 0x2254,     /* TV.50-54 */
+    0x5955, 0xC656, 0x7F57, 0x2358, 0x9059,     /* TV.55-59 */
+    0xD25A, 0xEE5B, 0x7A5C, 0x065D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x6D5E, 0x065F, 0xA060, 0x2961, 0xFF62,     /* TV.5E-62 */
+    0xDF63, 0x0564, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA, HBS, HBE, HSS, HSE, VT,  VA, VBS, VBE, VSS, VSE */
+    1200, 800, 800, 400, 880, 66, 658, 600, 600,  58, 610, 6
+};
+
+static u16 VT1625_N1024x768_VO[] = {
+                                               
+    0x0300, 0x0001, 0x1002, 0x9A03, 0x0004,     /* TV.00-04 */
+    0x0005, 0x0006, 0x4807, 0x2308, 0x0509,     /* TV.05-09 */
+    0x7B0A, 0x150B, 0x500C, 0x570D, 0x000E,     /* TV.0A-0E */
+    0xB00F, 0x0010, 0x8011, 0x2A12, 0x0D13,     /* TV.0F-13 */
+    0x2814, 0x1815, 0xA116, 0x6417, 0x9318,     /* TV.14-18 */
+    0x1B19,                                     /* TV.19 */
+    0x501B, 0x051C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x0C1F, 0x1720, 0xFF21, 0x3722,     /* TV.1E-22 */
+    0x7723, 0x0024,                             /* TV.23-24 */
+
+
+                                                /* Filter registers */
+    0xC54A, 0x0F4B, 0x004C, 0x014D, 0x104E,     /* TV.4A-4E */
+    0x4A4F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0x5F50, 0x0351, 0x4452, 0x3853, 0x0354,     /* TV.50-54 */
+    0x1F55, 0x6056, 0x9C57, 0x3458, 0xB359,     /* TV.55-59 */
+    0x045A, 0x2D5B, 0x005C, 0x585D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x245E, 0x7F5F, 0xC960, 0x2961, 0xFF62,     /* TV.5E-62 */
+    0xDF63, 0x0664, 0x5165,                     /* TV.63-65 */
+
+    /* HT,   HA,  HBS, HBE, HSS, HSE, VT,  VA, VBS, VBE, VSS, VSE */
+    1120, 1024, 1024, 96, 1032, 16, 825, 768, 768, 57,  777, 9
+};
+
+static u16 VT1625_N720x480_VO[] = {
+                                                
+    0x0300, 0x0001, 0x1002, 0x1F03, 0x0004,     /* TV.00-04 */
+    0x0005, 0x0006, 0x0207, 0x1008, 0x0009,     /* TV.05-09 */
+    0x7B0A, 0x150B, 0x500C, 0x570D, 0x3F0E,     /* TV.0A-0E */
+    0xB70F, 0x0010, 0x8011, 0xAD12, 0x2113,     /* TV.0F-13 */
+    0x6414, 0x3415, 0xD616, 0x7B17, 0xF018,     /* TV.14-18 */
+    0x2119,                                     /* TV.19 */
+    0x501B, 0x011C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x101F, 0x1C20, 0x0821, 0x0E22,     /* TV.1E-22 */
+    0x7723, 0x0224,                             /* TV.23-24 */
+
+
+                                                /* Filter registers */
+    0xC54A, 0x0F4B, 0x004C, 0x014D, 0x104E,     /* TV.4A-4E */
+    0x4A4F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0x1F50, 0xD251, 0x2352, 0x0C53, 0x2254,     /* TV.50-54 */
+    0x5955, 0xC056, 0x7E57, 0x2358, 0x8C59,     /* TV.55-59 */
+    0xD05A, 0xF65B, 0x7C5C, 0x065D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x005E, 0x345F, 0x8060, 0x2861, 0xFF62,     /* TV.5E-62 */
+    0x1F63, 0x0364, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA, HBS, HBE, HSS, HSE, VT,  VA, VBS, VBE, VSS, VSE */
+    800, 720, 720, 80,  760, 40, 525, 480, 480, 45,  482, 3
+};
+
+static u16 VT1625_P640x480_VO[] = {
+                                                
+    0x0300, 0x0001, 0x1002, 0x1F03, 0x0304,     /* TV.00-04 */
+    0x0005, 0x0306, 0x4307, 0x5F08, 0x3109,     /* Tv.05-09 */
+    0x880A, 0x000B, 0x550C, 0x5E0D, 0x000E,     /* TV.0A-0E */
+    0xB70F, 0x0010, 0x8011, 0x0D12, 0x0913,     /* TV.0F-13 */
+    0x1A14, 0x3015, 0xCB16, 0x8A17, 0x0918,     /* TV.14-18 */
+    0x2A19,                                     /* TV.19 */
+    0x501B, 0x031C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x101F, 0x1720, 0x1C21, 0x2D22,     /* TV.1E-22 */
+    0x7D23, 0x0224,                             /* TV.23-24 */
+
+
+                                                /* Filter registers */
+    0xC54A, 0x0F4B, 0x004C, 0x014D, 0x104E,     /* TV.4A-4E */
+    0x514F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xE750, 0x8751, 0x2352, 0x0753, 0x2254,     /* TV.50-54 */
+    0x5F55, 0xDF56, 0x7F57, 0x2358, 0x9459,     /* TV.55-59 */
+    0xD15A, 0x135B, 0x9E5C, 0x165D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x7F5E, 0x3A5F, 0x6A60, 0x2761, 0xFF62,     /* TV.5E-62 */
+    0x3F63, 0x0364, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE,  VT,  VA, VBS, VBE, VSS, VSE */
+    1000, 640, 640, 360, 816, 112, 520, 480, 480, 40,  490, 6
+};
+
+static u16 VT1625_P800x600_VO[] = {
+                                                
+    0x0300, 0x0001, 0x1002, 0x9003, 0x0304,     /* TV.00-04 */
+    0x0005, 0x0006, 0x4607, 0x0008, 0x3209,     /* TV.05-09 */
+    0x880A, 0x000B, 0x550C, 0x5E0D, 0x000E,     /* TV.0A-0E */
+    0xB70F, 0x0010, 0x8011, 0x6C12, 0x1213,     /* TV.0F-13 */
+    0x4114, 0x3015, 0xCB16, 0x8A17, 0x0918,     /* TV.14-18 */
+    0x2A19,                                     /* TV.19 */
+    0x501B, 0x031C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x101F, 0x1720, 0x1C21, 0x3422,     /* TV.1E-22 */
+    0x7D23, 0x0224,                             /* TV.23-24 */
+
+
+                                                /* Filter registers */
+    0xC54A, 0x0F4B, 0x004C, 0x014D, 0x104E,     /* TV.4A-4E */
+    0x514F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xE750, 0x8751, 0x3352, 0x8953, 0x2254,     /* TV.50-54 */
+    0x5F55, 0xE056, 0x7F57, 0x2358, 0x9459,     /* TV.55-59 */
+    0xD15A, 0x055B, 0x855C, 0x165D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x1E5E, 0x1F5F, 0x8560, 0xA961, 0xFF62,     /* TV.5E-62 */
+    0x0F63, 0x0464, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA, VBS, VBE, VSS, VSE */
+    1000, 800, 800, 200, 872, 56, 650, 600, 600, 50,  608, 12
+};
+
+static u16 VT1625_P1024x768_VO[] = {
+                                                
+    0x0300, 0x0001, 0x1002, 0x9A03, 0x0304,     /* TV.00-04 */
+    0x0005, 0x1006, 0xCF07, 0x1E08, 0x3709,     /* TV.05-09 */
+    0x880A, 0x000B, 0x550C, 0x5E0D, 0x000E,     /* TV.0A-0E */
+    0xB00F, 0x0010, 0x8011, 0xE412, 0x3613,     /* TV.0F-13 */
+    0xA714, 0x1015, 0xCB16, 0x8A17, 0x0918,     /* TV.14-18 */
+    0x2A19,                                     /* TV.19 */
+    0x501B, 0x031C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x101F, 0x1D20, 0x1C21, 0xEE22,     /* TV.1E-22 */
+    0x7D23, 0x0224,                             /* TV.23-24 */
+
+
+                                                /* Filter registers */
+    0xC54A, 0x0F4B, 0x004C, 0x014D, 0x104E,     /* TV.4A-4E */
+    0x514F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xCF50, 0x0351, 0x4752, 0x4253, 0x2354,     /* TV.50-54 */
+    0x5F55, 0xBF56, 0x7F57, 0x2358, 0x9359,     /* TV.55-59 */
+    0xD05A, 0x085B, 0xF05C, 0x165D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x025E, 0xAB5F, 0xAB60, 0xAB61, 0xFF62,     /* TV.5E-62 */
+    0x6F63, 0x0A64, 0x5165,                     /* TV.63-65 */
+
+    /* HT,   HA,  HBS,  HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    2000, 1024, 1024, 976, 1504, 32, 835, 768, 768, 67,  778, 6
+};
+
+static u16 VT1625_P720x576_VO[] = {
+                                                
+    0x0300, 0x0001, 0x1002, 0x1F03, 0x0304,     /* TV.00-04 */
+    0x0005, 0x0006, 0x3907, 0x1908, 0x0109,     /* TV.05-09 */
+    0x880A, 0x000B, 0x550C, 0x5E0D, 0x000E,     /* TV.0A-0E */
+    0x9E0F, 0x0010, 0x8011, 0x0412, 0x0813,     /* TV.0F-13 */
+    0x0814, 0x1015, 0xCB16, 0x8A17, 0x0918,     /* TV.14-18 */
+    0x2A19,                                     /* TV.19 */
+    0x501B, 0x011C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x101F, 0x1720, 0x0C21, 0x3222,     /* TV.1E-22 */
+    0x7D23, 0x0224,                             /* TV.23-24 */
+
+
+                                                /* Filter registers */
+    0xC54A, 0x0F4B, 0x004C, 0x014D, 0x104E,     /* TV.4A-4E */
+    0x514F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0x5F50, 0xCF51, 0x2352, 0x7053, 0x2254,     /* TV.50-54 */
+    0x5F55, 0xD056, 0x7F57, 0x2358, 0x9259,     /* TV.55-59 */
+    0xCE5A, 0x0C5B, 0x8E5C, 0x165D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x005E, 0x005F, 0x8060, 0x2061, 0xFF62,     /* TV.5E-62 */
+    0x5F63, 0x0364, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    864, 720, 720, 144, 760, 40,  625, 576, 576, 49,  578, 3
+};
+
+/***********************************/
+/* VT1625 output RGB Table         */
+/***********************************/
+
+static u16 TV_OUT_RGB[] = {
+    0x1202,                     /* SYNC on G */
+    0x7E23,                     /* Blank Level */
+    0x854A, 0x0A4B,             /* DAC Selection */
+    0x004E,                     /* YUV Delay Control */
+    0x5565, 0x3766, 0x5C67,     /* adjust SDTV_RGB Amplitude factor */
+    0xffff
+};
+
+static u16 HDTV_OUT_RGB[] = {
+    0x1202,                     /* output SDTV_RGB type */
+    0x854A, 0x0A4B,             /* DAC Selection */
+    0x5565, 0x3966, 0x6667,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF
+};
+
+/***********************************/
+/* VT1625 output YPBPR Table       */
+/***********************************/
+
+static u16 TV_OUT_YPBPR[] = {
+    0x7E23, 0x004E,
+    0x5565, 0x5466, 0x5667,
+    0xFFFF                      /* End symbol */
+};
+
+unsigned short HDTV_OUT_YPBPR[] = {
+    0x5565, 0x5666, 0x5567,     /* adjust YPbPr Amplitude factor */
+    0xFFFF
+};
+
+/***********************************/
+/* VT1625 output SDTV_RGB Table    */
+/***********************************/
+
+/* NTSC */
+
+static u16 VT1625_N640x480_SDTV_RGB_VN[] = {
+    0x4003,                          /* Filter Selection                 */
+    0x1004,                          /* Output Mode                      */
+    0x2807,                          /* Start Active Video               */
+    0x4708, 0x1509,                  /* adjust TV's Position             */
+    0x000B,                          /* Blanking Level set to zero       */
+    0x001C,
+    0x8351, 0x8356,                  /* TV Timing                        */
+    0x0062,                          /* Adaptive Deflicker Disable       */
+    0xFFFF                           /* End symbol                       */
+};
+
+static u16 VT1625_N800x600_SDTV_RGB_VN[] = {
+    0xC003,                          /* Filter Selection                 */
+    0x1004,                          /* Output Mode                      */
+    0x5607,                          /* Start Active Video               */
+    0x4B08, 0x1409,                  /* adjust TV's Position             */
+    0x000B,                          /* Blanking Level set to zero       */
+    0x001C,
+    0x011F,                          /* Filter Switch                    */
+    0x2F20,                          /* TV Sync step                     */
+    0x2551, 0x7D56,                  /* TV Timing                        */
+    0x0062,                          /* Adaptive Deflicker Disable       */
+    0xFFFF                           /* End symbol                       */
+};
+
+static u16 VT1625_N1024x768_SDTV_RGB_VN[] = {
+    0xC003,                          /* Filter Selection                 */
+    0x1004,                          /* Output Mode                      */
+    0x0F07,                          /* Start Active Video               */
+    0x8008, 0x1409,                  /* adjust TV's Position             */
+    0x000B,                          /* Blanking Level set to zero       */
+    0x001C,
+    0x011F,                          /* Filter Switch                    */
+    0x2520,                          /* TV Sync step                     */
+    0x0451, 0xA756,                  /* TV Timing                        */
+    0x0062,                          /* Adaptive Deflicker Disable       */
+    0xFFFF                           /* End symbol                       */
+};
+
+static u16 VT1625_N720x480_SDTV_RGB_VN[] = {
+    0x4003,                          /* Filter Selection                 */
+    0x1004,                          /* Output Mode                      */
+    0x1409,                          /* adjust TV's Position             */
+    0x000B,                          /* Blanking Level set to zero       */
+    0x001C,
+    0x011F,                          /* Filter Switch                    */
+    0x2F20,                          /* TV Sync step                     */
+    0x0062,                          /* Adaptive Deflicker Disable       */
+    0xFFFF                           /* End symbol                       */
+};
+
+static u16 VT1625_N640x480_SDTV_RGB_VF[] = {
+    0x4003,                          /* Filter Selection                 */
+    0x1004,                          /* Output Mode                      */
+    0x5607,                          /* Start Active Video               */
+    0x3808,                          /* adjust TV's Position             */
+    0x000B,                          /* Blanking Level set to zero       */
+    0x011F,                          /* Filter Switch                    */
+    0x8451,                          /* TV Timing                        */
+    0x0254, 0x3355, 0x7956, 0x7957,  /* TV Timing                        */
+    0x8559, 0xCA5A, 0x075B,          /* TV Timing                        */
+    0x325C, 0x165D, 0xF25E, 0x225F,  /* TV Timing                        */
+    0x8B60, 0x2861,                  /* Scaling                          */
+    0x0062,                          /* Adaptive Deflicker Disable       */
+    0xFFFF                           /* End symbol                       */
+};
+
+static u16 VT1625_N800x600_SDTV_RGB_VF[] = {
+    0xC003,                          /* Filter Selection                 */
+    0x1004,                          /* Output Mode                      */
+    0x8607,                          /* Start Active Video               */
+    0x3F08, 0xFC09,                  /* adjust TV's Position             */
+    0x000B,                          /* Blanking Level set to zero       */
+    0x021C,
+    0x2F20,                          /* TV Sync step                     */
+    0x0062,                          /* Adaptive Deflicker Disable       */
+    0xFFFF                           /* End symbol                       */
+};
+
+static u16 VT1625_N1024x768_SDTV_RGB_VF[]={
+    0xC003,                          /* Filter Selection                 */
+    0x1004,                          /* Output Mode                      */
+    0x9607,                          /* Start Active Video               */
+    0x4608, 0x0D09,                  /* adjust TV's Position             */
+    0x000B,                          /* Blanking Level set to zero       */
+    0x001C,
+    0x011F,                          /* Filter Switch                    */
+    0x2520,                          /* TV Sync step                     */
+    0x0551, 0x3D56,                  /* TV Timing                        */
+    0x0062,                          /* Adaptive Deflicker Disable       */
+    0xFFFF                           /* End symbol                       */
+};
+
+static u16 VT1625_N720x480_SDTV_RGB_VF[] = {
+    0x4003,                          /* Filter Selection                 */
+    0x1004,                          /* Output Mode                      */
+    0x4308, 0x0709,                  /* adjust TV's Position             */
+    0x000B,                          /* Blanking Level set to zero       */
+    0x001C,
+    0x011F,                          /* Filter Switch                    */
+    0x2F20,                          /* TV Sync step                     */
+    0x0062,                          /* Adaptive Deflicker Disable       */
+    0xFFFF                           /* End symbol                       */
+};
+
+static u16 VT1625_N640x480_SDTV_RGB_VO[] = {
+    0x4003,                          /* Filter Selection                 */
+    0x1004,                          /* Output Mode                      */
+    0x8407,                          /* Start Active Video               */
+    0x1D08,                          /* adjust TV's Position             */
+    0x000B,                          /* Blanking Level set to zero       */
+    0x041C, 
+    0x011F,                          /* Filter Switch                    */
+    0x8351,                          /* TV Timing                        */
+    0x0254, 0x1B55, 0x8356, 0x7557,  /* TV Timing                        */
+    0x8159, 0xC45A, 0x005B,          /* TV Timing                        */
+    0x045C, 0x005F,                  /* TV Timing                        */
+    0x2061,                          /* Scaling                          */
+    0x0062,                          /* Adaptive Deflicker Disable       */
+    0xFFFF                           /* End symbol                       */
+};
+
+static u16 VT1625_N800x600_SDTV_RGB_VO[] = {
+    0xC003,                          /* Filter Selection                 */
+    0x1004,                          /* Output Mode                      */
+    0x0006, 0xFB07,                  /* Start Active Video               */
+    0x2208, 0x0409,                  /* adjust TV's Position             */
+    0x000B,                          /* Blanking Level set to zero       */
+    0x041C,
+    0x011F,                          /* Filter Switch                    */
+    0x2920,                          /* TV Sync step                     */
+    0x2751, 0xCB56, 0xEB5B,          /* TV Timing                        */
+    0x0062,                          /* Adaptive Deflicker Disable       */
+    0xFFFF                           /* End symbol                       */
+};
+
+static u16 VT1625_N1024x768_SDTV_RGB_VO[] = {
+    0xC003,                          /* Filter Selection                 */
+    0x1004,                          /* Output Mode                      */
+    0x4707,                          /* Start Active Video               */
+    0x2908, 0x0009,                  /* adjust TV's Position             */
+    0x000B,                          /* Blanking Level set to zero       */
+    0x041C, 
+    0x011F,                          /* Filter Switch                    */
+    0x2820,                          /* TV Sync step                     */
+    0x0551, 0x6156,                  /* TV Timing                        */
+    0x0062,                          /* Adaptive Deflicker Disable       */
+    0xFFFF                           /* End symbol                       */
+};
+
+static u16 VT1625_N720x480_SDTV_RGB_VO[] = {
+    0x4003,                          /* Filter Selection                 */
+    0x1004,                          /* Output Mode                      */
+    0x2008, 0x0009,                  /* adjust TV's Position             */
+    0x000B,                          /* Blanking Level set to zero       */
+    0x001C,
+    0x011F,                          /* Filter Switch                    */
+    0x2F20,                          /* TV Sync step                     */
+    0x0062,                          /* Adaptive Deflicker Disable       */
+    0xFFFF                           /* End symbol                       */
+};
+
+
+/* PAL */
+
+static u16 VT1625_P640x480_SDTV_RGB_VN[] = {
+    0x4003,                          /* Filter Selection                 */
+    0x1304,                          /* Output Mode                      */
+    0xF007,                          /* Start Active Video               */
+    0x4E08, 0x1409,                  /* adjust TV's Position             */
+    0x001C, 
+    0x011F,                          /* Filter Switch                    */
+    0x1C20,                          /* TV Sync step                     */
+    0x8351, 0x7156,                  /* TV Timing                        */
+    0x0062,                          /* Adaptive Deflicker Disable       */
+    0xFFFF                           /* End symbol                       */
+};
+
+static u16 VT1625_P800x600_SDTV_RGB_VN[] = {
+    0x4003,                          /* Filter Selection                 */
+    0x1304,                          /* Output Mode                      */
+    0x2607,                          /* Start Active Video               */
+    0x4A08, 0x1909,                  /* adjust TV's Position             */
+    0x001C,
+    0x011F,                          /* Filter Switch                    */
+    0x1C20,                          /* TV Sync step                     */
+    0x2551, 0x7556,                  /* TV Timing                        */
+    0x0062,                          /* Adaptive Deflicker Disable       */
+    0xFFFF                           /* End symbol                       */
+};
+
+static u16 VT1625_P1024x768_SDTV_RGB_VN[] = {
+    0xC003,                          /* Filter Selection                 */
+    0x1304,                          /* Output Mode                      */
+    0x8707,                          /* Start Active Video               */
+    0x6C08, 0x1909,                  /* adjust TV's Position             */
+    0x001C, 
+    0x011F,                          /* Filter Switch                    */
+    0x1C20,                          /* TV Sync step                     */
+    0x0451, 0xA556,                  /* TV Timing                        */
+    0x0062,                          /* Adaptive Deflicker Disable       */
+    0xFFFF                           /* End symbol                       */
+};
+
+static u16 VT1625_P720x576_SDTV_RGB_VN[] = {
+    0x4003,                          /* Filter Selection                 */
+    0x1304,                          /* Output Mode                      */
+    0x4D08, 0x1B09,                  /* adjust TV's Position             */
+    0x001C,
+    0x011F,                          /* Filter Switch                    */
+    0x1C20,                          /* TV Sync step                     */
+    0x0062,                          /* Adaptive Deflicker Disable       */
+    0xFFFF                           /* End symbol                       */
+};
+
+static u16 VT1625_P640x480_SDTV_RGB_VF[] = {
+    0x4003,                          /* Filter Selection                 */
+    0x1304,                          /* Output Mode                      */
+    0x5007, 0x4308, 0x0A09,          /* adjust TV's Position             */
+    0x001C,
+    0x011F,                          /* Filter Switch                    */
+    0x1C20,                          /* TV Sync step                     */
+    0x8351, 0x8356,                  /* TV Timing                        */
+    0x0062,                          /* Adaptive Deflicker Disable       */
+    0xFFFF                           /* End symbol                       */
+};
+
+static u16 VT1625_P800x600_SDTV_RGB_VF[] = {
+    0xC003,                          /* Filter Selection                 */
+    0x1304,                          /* Output Mode                      */
+    0x4607,                          /* Start Active Video               */
+    0x4108, 0x2409,                  /* adjust TV's Position             */
+    0x0810,                          /* Hue Adjustment                   */
+    0x001C,
+    0x011F,                          /* Filter Switch                    */
+    0x1C20,                          /* TV Sync step                     */
+    0x2451, 0x8956,                  /* TV Timing                        */
+    0x0062,                          /* Adaptive Deflicker Disable       */
+    0xFFFF                           /* End symbol                       */
+};
+
+static u16 VT1625_P1024x768_SDTV_RGB_VF[] = {
+    0xC003,                          /* Filter Selection                 */
+    0x1304,                          /* Output Mode                      */
+    0x9507,                          /* Start Active Video               */
+    0x4B08, 0x1A09,                  /* adjust TV's Position             */
+    0x001C,
+    0x001F,                          /* Filter Switch                    */
+    0x0451, 0x0956,                  /* TV Timing                        */
+    0x0062,                          /* Adaptive Deflicker Disable       */
+    0xFFFF                           /* End symbol                       */
+
+};
+
+static u16 VT1625_P720x576_SDTV_RGB_VF[] = {
+    0x4003,                          /* Filter Selection                 */
+    0x1304,                          /* Output Mode                      */
+    0x4308, 0x0D09,                  /* adjust TV's Position             */
+    0x001C,
+    0x011F,                          /* Filter Switch                    */
+    0x1C20,                          /* TV Sync step                     */
+    0x0062,                          /* Adaptive Deflicker Disable       */
+    0xFFFF                           /* End symbol                       */
+};
+
+static u16 VT1625_P640x480_SDTV_RGB_VO[] = {
+    0x4003,                          /* Filter Selection                 */
+    0x1304,                          /* Output Mode                      */
+    0x4807,                          /* Start Active Video               */
+    0x6409,                          /* adjust TV's Position             */
+    0x041C,   
+    0x011F,                          /* Filter Switch                    */
+    0x0254, 0xFF55, 0x9C56, 0x7057,  /* TV Timing                        */
+    0x2258, 0x8359, 0xB95A, 0xD35B,  /* TV Timing                        */
+    0xD45C, 0x055D, 0x7E5E, 0x005F,  /* TV Timing                        */
+    0x2061,                          /* Scaling                          */
+    0x0062,                          /* Adaptive Deflicker Disable       */
+    0xFFFF                           /* End symbol                       */
+};
+
+static u16 VT1625_P800x600_SDTV_RGB_VO[] = {
+    0xC003,                          /* Filter Selection                 */
+    0x1304,                          /* Output Mode                      */
+    0x6509,                          /* adjust TV's Position             */
+    0x041C, 
+    0x011F,                          /* Filter Switch                    */
+    0x1C20,                          /* TV Sync step                     */
+    0x0062,                          /* Adaptive Deflicker Disable       */
+    0xFFFF                           /* End symbol                       */
+};
+
+static u16 VT1625_P1024x768_SDTV_RGB_VO[] = {
+    0xC003,                          /* Filter Selection                 */
+    0x1304,                          /* Output Mode                      */
+    0xCC07,                          /* Start Active Video               */
+    0x2408, 0x6E09,                  /* adjust TV's Position             */
+    0x041C,
+    0x011F,                          /* Filter Switch                    */
+    0x0651, 0xC156,                  /* TV Timing                        */
+    0x0062,                          /* Adaptive Deflicker Disable       */
+    0xFFFF                           /* End symbol                       */
+};
+
+static u16 VT1625_P720x576_SDTV_RGB_VO[] = {
+    0x4003,                          /* Filter Selection                 */
+    0x1304,                          /* Output Mode                      */
+    0x0309,                          /* adjust TV's Position             */
+    0x001C,
+    0x011F,                          /* Filter Switch                    */
+    0x1C20,                          /* TV Sync step                     */
+    0x0062,                          /* Adaptive Deflicker Disable       */
+    0xFFFF                           /* End symbol                       */
+};
+
+/***********************************/
+/* VT1625 DeDotCrawl Table         */
+/***********************************/
+
+/* NTSC */
+
+static u16 VT1625_N640x480_DeDotCrawl_VN[] = {
+    0xBE16, 0x8717,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1625_N800x600_DeDotCrawl_VN[] = {
+    0x1216, 0x4917,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1625_N1024x768_DeDotCrawl_VN[] = {
+    0x1816, 0x6117,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1625_N720x480_DeDotCrawl_VN[] = {
+    0xC316, 0x4C17,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1625_N640x480_DeDotCrawl_VF[] = {
+    0x5016, 0x7B17,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1625_N800x600_DeDotCrawl_VF[] = {
+    0xD116, 0xF617,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1625_N1024x768_DeDotCrawl_VF[] = {
+    0x0616, 0x8417,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1625_N720x480_DeDotCrawl_VF[] = {
+    0xE816, 0xEB17,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1625_N640x480_DeDotCrawl_VO[] = {
+    0xE516, 0xA017,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1625_N800x600_DeDotCrawl_VO[] = {
+    0xA116, 0x5917,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1625_N1024x768_DeDotCrawl_VO[] = {
+    0x1116, 0xE217,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1625_N720x480_DeDotCrawl_VO[] = {
+    0x1E16, 0x5C17,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1625_NULL_FUNC[] = {
+    0xFFFF
+};
+
+static vt1625_func_table vt1625_ntsc_640x480_tbl[] = {
+    {TV_BASE_FUNC,         VT1625_N640x480_VN,             VT1625_N640x480_VF,             VT1625_N640x480_VO},
+    {TV_RGB_FUNC,          TV_OUT_RGB,                     TV_OUT_RGB,                     TV_OUT_RGB},
+    {TV_YPBPR_FUNC,        TV_OUT_YPBPR,                   TV_OUT_YPBPR,                   TV_OUT_YPBPR},
+    {TV_SDTV_RGB_FUNC,     VT1625_N640x480_SDTV_RGB_VN,    VT1625_N640x480_SDTV_RGB_VF,    VT1625_N640x480_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1625_N640x480_SDTV_RGB_VN,    VT1625_N640x480_SDTV_RGB_VF,    VT1625_N640x480_SDTV_RGB_VO},
+    {TV_DeDotCrawl_FUNC,   VT1625_N640x480_DeDotCrawl_VN,  VT1625_N640x480_DeDotCrawl_VF,  VT1625_N640x480_DeDotCrawl_VO}
+};
+
+static vt1625_func_table vt1625_ntsc_800x600_tbl[] = {
+    {TV_BASE_FUNC,         VT1625_N800x600_VN,             VT1625_N800x600_VF,             VT1625_N800x600_VO},
+    {TV_RGB_FUNC,          TV_OUT_RGB,                     TV_OUT_RGB,                     TV_OUT_RGB},
+    {TV_YPBPR_FUNC,        TV_OUT_YPBPR,                   TV_OUT_YPBPR,                   TV_OUT_YPBPR},
+    {TV_SDTV_RGB_FUNC,     VT1625_N800x600_SDTV_RGB_VN,    VT1625_N800x600_SDTV_RGB_VF,    VT1625_N800x600_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1625_N800x600_SDTV_RGB_VN,    VT1625_N800x600_SDTV_RGB_VF,    VT1625_N800x600_SDTV_RGB_VO},
+    {TV_DeDotCrawl_FUNC,   VT1625_N800x600_DeDotCrawl_VN,  VT1625_N800x600_DeDotCrawl_VF,  VT1625_N800x600_DeDotCrawl_VO}
+};
+
+static vt1625_func_table vt1625_ntsc_1024x768_tbl[]= {
+    {TV_BASE_FUNC,         VT1625_N1024x768_VN,            VT1625_N1024x768_VF,            VT1625_N1024x768_VO},
+    {TV_RGB_FUNC,          TV_OUT_RGB,                     TV_OUT_RGB,                     TV_OUT_RGB},
+    {TV_YPBPR_FUNC,        TV_OUT_YPBPR,                   TV_OUT_YPBPR,                   TV_OUT_YPBPR},
+    {TV_SDTV_RGB_FUNC,     VT1625_N1024x768_SDTV_RGB_VN,   VT1625_N1024x768_SDTV_RGB_VF,   VT1625_N1024x768_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1625_N1024x768_SDTV_RGB_VN,   VT1625_N1024x768_SDTV_RGB_VF,   VT1625_N1024x768_SDTV_RGB_VO},
+    {TV_DeDotCrawl_FUNC,   VT1625_N1024x768_DeDotCrawl_VN, VT1625_N1024x768_DeDotCrawl_VF, VT1625_N1024x768_DeDotCrawl_VO}
+};
+
+static vt1625_func_table vt1625_ntsc_720x480_tbl[] = {
+    {TV_BASE_FUNC,         VT1625_N720x480_VN,             VT1625_N720x480_VF,             VT1625_N720x480_VO},
+    {TV_RGB_FUNC,          TV_OUT_RGB,                     TV_OUT_RGB,                     TV_OUT_RGB},
+    {TV_YPBPR_FUNC,        TV_OUT_YPBPR,                   TV_OUT_YPBPR,                   TV_OUT_YPBPR},
+    {TV_SDTV_RGB_FUNC,     VT1625_N720x480_SDTV_RGB_VN,    VT1625_N720x480_SDTV_RGB_VF,    VT1625_N720x480_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1625_N720x480_SDTV_RGB_VN,    VT1625_N720x480_SDTV_RGB_VF,    VT1625_N720x480_SDTV_RGB_VO},
+    {TV_DeDotCrawl_FUNC,   VT1625_N720x480_DeDotCrawl_VN,  VT1625_N720x480_DeDotCrawl_VF,  VT1625_N720x480_DeDotCrawl_VO}
+};
+
+static vt1625_func_table vt1625_pal_640x480_tbl[] = {
+    {TV_BASE_FUNC,         VT1625_P640x480_VN,             VT1625_P640x480_VF,             VT1625_P640x480_VO},
+    {TV_RGB_FUNC,          TV_OUT_RGB,                     TV_OUT_RGB,                     TV_OUT_RGB},
+    {TV_YPBPR_FUNC,        TV_OUT_YPBPR,                   TV_OUT_YPBPR,                   TV_OUT_YPBPR},
+    {TV_SDTV_RGB_FUNC,     VT1625_P640x480_SDTV_RGB_VN,    VT1625_P640x480_SDTV_RGB_VF,    VT1625_P640x480_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1625_P640x480_SDTV_RGB_VN,    VT1625_P640x480_SDTV_RGB_VF,    VT1625_P640x480_SDTV_RGB_VO}
+};
+
+static vt1625_func_table vt1625_pal_800x600_tbl[] = {
+    {TV_BASE_FUNC,         VT1625_P800x600_VN,             VT1625_P800x600_VF,             VT1625_P800x600_VO},
+    {TV_RGB_FUNC,          TV_OUT_RGB,                     TV_OUT_RGB,                     TV_OUT_RGB},
+    {TV_YPBPR_FUNC,        TV_OUT_YPBPR,                   TV_OUT_YPBPR,                   TV_OUT_YPBPR},
+    {TV_SDTV_RGB_FUNC,     VT1625_P800x600_SDTV_RGB_VN,    VT1625_P800x600_SDTV_RGB_VF,    VT1625_P800x600_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1625_P800x600_SDTV_RGB_VN,    VT1625_P800x600_SDTV_RGB_VF,    VT1625_P800x600_SDTV_RGB_VO}
+};
+
+static vt1625_func_table vt1625_pal_1024x768_tbl[] = {
+    {TV_BASE_FUNC,         VT1625_P1024x768_VN,            VT1625_P1024x768_VF,            VT1625_P1024x768_VO},
+    {TV_RGB_FUNC,          TV_OUT_RGB,                     TV_OUT_RGB,                     TV_OUT_RGB},
+    {TV_YPBPR_FUNC,        TV_OUT_YPBPR,                   TV_OUT_YPBPR,                   TV_OUT_YPBPR},
+    {TV_SDTV_RGB_FUNC,     VT1625_P1024x768_SDTV_RGB_VN,   VT1625_P1024x768_SDTV_RGB_VF,   VT1625_P1024x768_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1625_P1024x768_SDTV_RGB_VN,   VT1625_P1024x768_SDTV_RGB_VF,   VT1625_P1024x768_SDTV_RGB_VO}
+};
+
+static vt1625_func_table vt1625_pal_720x576_tbl[] = {
+    {TV_BASE_FUNC,         VT1625_P720x576_VN,             VT1625_P720x576_VF,             VT1625_P720x576_VO},
+    {TV_RGB_FUNC,          TV_OUT_RGB,                     TV_OUT_RGB,                     TV_OUT_RGB},
+    {TV_YPBPR_FUNC,        TV_OUT_YPBPR,                   TV_OUT_YPBPR,                   TV_OUT_YPBPR},
+    {TV_SDTV_RGB_FUNC,     VT1625_P720x576_SDTV_RGB_VN,    VT1625_P720x576_SDTV_RGB_VF,    VT1625_P720x576_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1625_P720x576_SDTV_RGB_VN,    VT1625_P720x576_SDTV_RGB_VF,    VT1625_P720x576_SDTV_RGB_VO}
+};
+
+
+/* 720P Under Scan */
+static u16 VT1625_HDTV_720P_640x480_VN[] = {
+                                                 
+    0x0300, 0x0001, 0x1002, 0x4003, 0x9404,     /* TV.00-04 */
+    0x0005, 0x0006, 0x5007, 0x5608, 0x2209,     /* TV.05-09 */
+    0x000A, 0x000B, 0x000C, 0x000D, 0x000E,     /* TV.0A-0E */
+    0xB00F, 0x0010, 0x8011, 0xAC12, 0x1913,     /* TV.0F-13 */
+    0x6D14, 0x3015, 0x0016, 0x0017, 0x0018,     /* TV.14-18 */
+    0x0019,                                     /* TV.19 */
+    0x501B, 0x001C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x031F, 0x4220, 0x0021, 0x0022,     /* TV.1E-22 */
+    0x7823, 0x0024,                             /* TV.23-24 */
+
+
+                                                /* Filter registers */
+    0xC54A, 0x0F4B, 0x004C, 0x014D, 0x004E,     /* TV.4A-4E */
+    0x004F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xAF50, 0x8251, 0x2452, 0x2053, 0x1254,     /* TV.50-54 */
+    0x6755, 0x6B56, 0x2A57, 0x2358, 0x9E59,     /* TV.55-59 */
+    0x455A, 0xA05B, 0x455C, 0x435D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x035E, 0x4B5F, 0x5D60, 0x2861, 0x0062,     /* TV.5E-62 */
+    0x6763, 0x1364, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA, HBS, HBE, HSS, HSE,  VT,  VA, VBS, VBE, VSS, VSE */
+    1200, 640, 640, 560, 1040, 80,  545, 480, 480, 65, 481, 2
+};
+
+static u16 VT1625_HDTV_720P_800x600_VN[] = {
+                                                  
+    0x0300, 0x0001, 0x1002, 0x4003, 0x9404,     /* TV.00-04 */
+    0x0005, 0x0006, 0x2807, 0x6508, 0x1109,     /* TV.05-09 */
+    0x000A, 0x000B, 0x000C, 0x000D, 0x000E,     /* TV.0A-0E */
+    0xB00F, 0x0010, 0x8011, 0xA912, 0x1913,     /* TV.0F-13 */
+    0x6614, 0x2415, 0x0016, 0x0017, 0x0018,     /* TV.14-18 */
+    0x0019,                                     /* TV.19 */
+    0x501B, 0x011C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x031F, 0x4220, 0x0021, 0x0022,     /* TV.1E-22 */
+    0x7823, 0x0024,                             /* TV.23-24 */
+
+
+                                                /* Filter registers */
+    0xC54A, 0x0F4B, 0x004C, 0x014D, 0x004E,     /* TV.4A-4E */
+    0x004F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xAF50, 0x2351, 0x3452, 0xA753, 0x1254,     /* TV.50-54 */
+    0x3F55, 0x0756, 0x3457, 0x3458, 0xC559,     /* TV.55-59 */
+    0x115A, 0xC85B, 0x145C, 0x045D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x0D5E, 0x4C5F, 0x7460, 0x2861, 0x0062,     /* TV.5E-62 */
+    0x3F63, 0x2464, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA, HBS, HBE, HSS, HSE,  VT,  VA, VBS, VBE, VSS, VSE */
+    1200, 800, 800, 400, 1120, 40, 680, 600, 600, 80, 610, 6
+};
+
+static u16 VT1625_HDTV_720P_1024x768_VN[] = {
+                                                 
+    0x8300, 0x0001, 0x1002, 0x4003, 0x9404,     /* TV.00-04 */
+    0x1F05, 0x1006, 0x9307, 0x8008, 0x1E09,     /* TV.05-09 */
+    0x000A, 0x000B, 0x000C, 0x000D, 0x000E,     /* TV.0A-0E */
+    0x9E0F, 0x0010, 0x8011, 0x6612, 0x1913,     /* TV.0F-13 */
+    0x5814, 0x1015, 0x0016, 0x0017, 0x0018,     /* TV.14-18 */
+    0x0019,                                     /* TV.19 */
+    0x501B, 0x001C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x031F, 0x2520, 0x0021, 0x0022,     /* TV.1E-22 */
+    0x7E23, 0x0024,                             /* TV.23-24 */
+
+
+                                                /* Filter registers */
+    0xC54A, 0x0F4B, 0x004C, 0x014D, 0x004E,     /* TV.4A-4E */
+    0x004F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0x0750, 0x0251, 0x4752, 0x6F53, 0x1354,     /* TV.50-54 */
+    0x7F55, 0xE356, 0x4457, 0x3558, 0x0059,     /* TV.55-59 */
+    0x435A, 0x035B, 0x475C, 0xD55D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x2F5E, 0x395F, 0x9660, 0x2861, 0x0062,     /* TV.5E-62 */
+    0x3F63, 0x2864, 0x5165,                     /* TV.63-65 */
+
+    /* HT,   HA,  HBS, HBE,  HSS, HSE,  VT,  VA, VBS, VBE, VSS, VSE */
+    1800, 1024, 1024, 776, 1360,  40, 880, 768, 768, 112, 770, 8
+};
+
+static u16 VT1625_HDTV_720P_720x480_VN[] = {
+                                                
+    0x0300, 0x0001, 0x1002, 0x4003, 0x9404,     /* TV.00-04 */
+    0x0005, 0x0006, 0x0807, 0x6408, 0x2409,     /* TV.05-09 */
+    0x000A, 0x000B, 0x000C, 0x000D, 0x000E,     /* TV.0A-0E */
+    0xB00F, 0x0010, 0x8011, 0xEB12, 0x3213,     /* TV.0F-13 */
+    0xE714, 0x3815, 0x0016, 0x0017, 0x0018,     /* TV.14-18 */
+    0x0019,                                     /* TV.19 */
+    0x501B, 0x011C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x031F, 0x4220, 0x0021, 0x0022,     /* TV.1E-22 */
+    0x7823, 0x0024,                             /* TV.23-24 */
+
+
+                                                /* Filter registers */
+    0xC54A, 0x0F4B, 0x004C, 0x014D, 0x004E,     /* TV.4A-4E */
+    0x004F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0x3750, 0xD251, 0x2452, 0x2553, 0x1254,     /* TV.50-54 */
+    0xEF55, 0xC756, 0x3057, 0x2358, 0xB759,     /* TV.55-59 */
+    0xC75A, 0xB95B, 0xC75C, 0x435D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0xDD5E, 0x205F, 0x5D60, 0x2861, 0x0062,     /* TV.5E-62 */
+    0x1763, 0x1364, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA, HBS, HBE, HSS, HSE,  VT,  VA, VBS, VBE, VSS, VSE */
+    1080, 720, 720, 360, 1040, 32,  550, 480, 480, 70, 482, 2
+};
+
+static u16 VT1625_HDTV_720P_720x576_VN[] = {
+                                                
+    0x0300, 0x0001, 0x1002, 0x4003, 0x9404,     /* TV.00-04 */
+    0x0005, 0x0006, 0x0E07, 0x4408, 0x0409,     /* TV.05-09 */
+    0x000A, 0x000B, 0x000C, 0x000D, 0x000E,     /* TV.0A-0E */
+    0x9E0F, 0x0010, 0x8011, 0x8812, 0x1E13,     /* TV.0F-13 */
+    0x6114, 0x2815, 0x0016, 0x0017, 0x0018,     /* TV.14-18 */
+    0x0019,                                     /* TV.19 */
+    0x501B, 0x001C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x031F, 0x2520, 0x0021, 0x0022,     /* TV.1E-22 */
+    0x7E23, 0x0024,                             /* TV.23-24 */
+
+
+                                                /* Filter registers */
+    0xC54A, 0x0F4B, 0x004C, 0x014D, 0x004E,     /* TV.4A-4E */
+    0x004F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xC950, 0xD151, 0x2352, 0x5753, 0x1254,     /* TV.50-54 */
+    0xC955, 0xD156, 0x3057, 0x2358, 0xB259,     /* TV.55-59 */
+    0xA35A, 0xB75B, 0x895C, 0x435D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x665E, 0x005F, 0x6660, 0x2061, 0x0062,     /* TV.5E-62 */
+    0x0763, 0x1364, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA, HBS, HBE, HSS, HSE,  VT,  VA, VBS, VBE, VSS, VSE */
+    970, 720, 720, 250, 928,  28, 600, 576, 576,  24, 577, 3
+};
+
+static u16 VT1625_HDTV_720P_1280x720_VN[] = {
+                                                
+    0x8300, 0x0001, 0x1002, 0x4003, 0x9404,     /* TV.00-04 */
+    0x0005, 0x1006, 0x3307, 0x4A08, 0x0109,     /* TV.05-09 */
+    0x000A, 0x000B, 0x000C, 0x000D, 0x000E,     /* TV.0A-0E */
+    0xB00F, 0x0010, 0x8011, 0xA512, 0x1E13,     /* TV.0F-13 */
+    0x6714, 0x1415, 0x0016, 0x0017, 0x0018,     /* TV.14-18 */
+    0x0019,                                     /* TV.19 */
+    0x501B, 0x001C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x031F, 0x4220, 0x0021, 0x0022,     /* TV.1E-22 */
+    0x7823, 0x0024,                             /* TV.23-24 */
+
+
+                                                /* Filter registers */
+    0xC54A, 0x0F4B, 0x004C, 0x014D, 0x004E,     /* TV.4A-4E */
+    0x004F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0x6F50, 0xFF51, 0x4652, 0xED53, 0x1254,     /* TV.50-54 */
+    0x6F55, 0xFF56, 0x5057, 0x4658, 0x2E59,     /* TV.55-59 */
+    0x275A, 0x275B, 0x275C, 0x965D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x005E, 0x005F, 0x8060, 0x2861, 0x0062,     /* TV.5E-62 */
+    0x6F63, 0x3664, 0x5165,                     /* TV.63-65 */
+
+    /* HT,   HA,  HBS, HBE,  HSS, HSE, VT,  VA, VBS, VBE,VSS, VSE */
+    1648, 1280, 1280, 368, 1296, 48, 750, 720, 720, 30, 720, 5
+};
+
+/* 1080I Under Scan */
+static u16 VT1625_HDTV_1080I_640x480_VN[] = {
+                                                /* Non-Macrovision Registers */
+    0x0300, 0x0001, 0x1002, 0x4F03, 0x8604,     /* TV.00-04 */
+    0x0005, 0x0006, 0x2A07, 0x3908, 0x1209,     /* TV.05-09 */
+    0x000A, 0x000B, 0x000C, 0x000D, 0x000E,     /* TV.0A-0E */
+    0x9E0F, 0x0010, 0x8011, 0x8812, 0x1913,     /* TV.0F-13 */
+    0x6314, 0x2415, 0x0016, 0x0017, 0x0018,     /* TV.14-18 */
+    0x0019,                                     /* TV.19 */
+    0x501B, 0x001C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x031F, 0x2520, 0x0021, 0x0022,     /* TV.1E-22 */
+    0x7E23, 0x0024,                             /* TV.23-24 */
+
+
+                                                /* Filter registers */
+    0xC54A, 0x0F4B, 0x004C, 0x014D, 0x004E,     /* TV.4A-4E */
+    0x004F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0x9F50, 0x8251, 0x2552, 0x2553, 0x1254,     /* TV.50-54 */
+    0x1755, 0x7356, 0x4057, 0x2358, 0x7E59,     /* TV.55-59 */
+    0xF85A, 0xA95B, 0x105C, 0x065D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x935E, 0x2A5F, 0x3E60, 0x2861, 0xFF62,     /* TV.5E-62 */
+    0xBF63, 0x1264, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA, HBS, HBE,  HSS, HSE,  VT,  VA, VBS, VBE, VSS, VSE */
+    1440, 640, 640, 800, 1360, 40,  550, 480, 480, 70,  485, 6
+};
+
+static u16 VT1625_HDTV_1080I_800x600_VN[] = {
+                                                /* Non-Macrovision Registers */
+    0x0300, 0x0001, 0x1002, 0x4F03, 0x8604,     /* TV.00-04 */
+    0x2005, 0x0006, 0x7A07, 0x8608, 0x1B09,     /* TV.05-09 */
+    0x000A, 0x000B, 0x000C, 0x000D, 0x000E,     /* TV.0A-0E */
+    0x9E0F, 0x0010, 0x8011, 0x6612, 0x1413,     /* TV.0F-13 */
+    0x4514, 0x1415, 0x0016, 0x0017, 0x0018,     /* TV.14-18 */
+    0x0019,                                     /* TV.19 */
+    0x501B, 0x001C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x031F, 0x2520, 0x0021, 0x0022,     /* TV.1E-22 */
+    0x7E23, 0x0024,                             /* TV.23-24 */
+
+
+                                                /* Filter registers */
+    0xC54A, 0x0F4B, 0x004C, 0x014D, 0x004E,     /* TV.4A-4E */
+    0x004F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0x0750, 0x2251, 0x3752, 0xB153, 0x1254,     /* TV.50-54 */
+    0x2F55, 0xAD56, 0x4A57, 0x5758, 0x9259,     /* TV.55-59 */
+    0x735A, 0xC55B, 0x0B5C, 0x475D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x815E, 0xD15F, 0x4E60, 0x2861, 0xFF62,     /* TV.5E-62 */
+    0x4F63, 0x1464, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA, HBS, HBE,  HSS, HSE, VT,  VA, VBS, VBE, VSS, VSE */
+    1800, 800, 800, 1000, 1600, 80, 690, 600, 600, 90, 605, 6
+};
+
+static u16 VT1625_HDTV_1080I_1024x768_VN[] = {
+    0x0300, 0x0001, 0x1002, 0x4F03, 0x8604,     /* TV.00-04 */
+    0x3A05, 0x0006, 0x0207, 0xA008, 0x0609,     /* TV.05-09 */
+    0x000A, 0x000B, 0x000C, 0x000D, 0x000E,     /* TV.0A-0E */
+    0x9E0F, 0x0010, 0x8011, 0xE612, 0x2813,     /* TV.0F-13 */
+    0xB114, 0x1415, 0x0016, 0x0017, 0x0018,     /* TV.14-18 */
+    0x0019,                                     /* TV.19 */
+    0x501B, 0x001C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x031F, 0x2520, 0x0021, 0x0022,     /* TV.1E-22 */
+    0x7E23, 0x0024,                             /* TV.23-24 */
+
+
+                                                /* Filter registers */
+    0xC54A, 0x0F4B, 0x004C, 0x014D, 0x004E,     /* TV.4A-4E */
+    0x004F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0x0750, 0x0251, 0x4752, 0x7453, 0x1354,     /* TV.50-54 */
+    0x3755, 0x4956, 0x5E57, 0x7958, 0xBC59,     /* TV.55-59 */
+    0x6C5A, 0xFD5B, 0x085C, 0x095D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0xB15E, 0xC95F, 0x6460, 0x2861, 0xFF62,     /* TV.5E-62 */
+    0x8763, 0x2564, 0x5165,                     /* TV.63-65 */
+
+  /*  HT,   HA,  HBS,  HBE,  HSS, HSE,  VT,  VA, VBS, VBE, VSS, VSE */
+    1800, 1024, 1024, 776, 1720, 80,  885, 768, 768, 117, 800, 5
+};
+
+static u16 VT1625_HDTV_1080I_720x480_VN[] = {
+                                                /* Non-Macrovision Registers */
+    0x0300, 0x0001, 0x1002, 0x4F03, 0x8604,     /* TV.00-04 */
+    0x0005, 0x0006, 0x4207, 0x3F08, 0x4809,     /* TV.05-09 */
+    0x000A, 0x000B, 0x000C, 0x000D, 0x000E,     /* TV.0A-0E */
+    0x9E0F, 0x0010, 0x8011, 0x0612, 0x0A13,     /* TV.0F-13 */
+    0x2114, 0x1815, 0x0016, 0x0017, 0x0018,     /* TV.14-18 */
+    0x0019,                                     /* TV.19 */
+    0x501B, 0x041C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x031F, 0x2520, 0x0021, 0x0022,     /* TV.1E-22 */
+    0x7E23, 0x0024,                             /* TV.23-24 */
+
+
+                                                /* Filter registers */
+    0xC54A, 0x0F4B, 0x004C, 0x014D, 0x004E,     /* TV.4A-4E */
+    0x004F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0x0750, 0xD251, 0x2752, 0x2553, 0x1254,     /* TV.50-54 */
+    0x6F55, 0xBB56, 0x4657, 0x2358, 0x8D59,     /* TV.55-59 */
+    0x4C5A, 0xBC5B, 0xBC5C, 0x465D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x935E, 0x3D5F, 0x3E60, 0x2861, 0xFF62,     /* TV.5E-62 */
+    0x6F63, 0x1364, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA, HBS,  HBE,  HSS, HSE,  VT,  VA, VBS, VBE, VSS, VSE */
+    1800, 720, 720, 1016, 1680,  56, 550, 480, 480,  70, 485, 6
+};
+
+static u16 VT1625_HDTV_1080I_720x576_VN[] = {
+                                                /* Non-Macrovision Registers */
+    0x0300, 0x0001, 0x1002, 0x4A03, 0x8604,     /* TV.00-04 */
+    0x0005, 0x0006, 0x1A07, 0x3908, 0x0209,     /* TV.05-09 */
+    0x000A, 0x000B, 0x000C, 0x000D, 0x000E,     /* TV.0A-0E */
+    0x9E0F, 0x0010, 0x8011, 0xED12, 0x1913,     /* TV.0F-13 */
+    0xB614, 0x3815, 0x0016, 0x0017, 0x0018,     /* TV.14-18 */
+    0x0019,                                     /* TV.19 */
+    0x501B, 0x001C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x031F, 0x2520, 0x0021, 0x0022,     /* TV.1E-22 */
+    0x7E23, 0x0024, 0x5165,                     /* TV.23-24 */
+
+
+                                                /* Filter registers */
+    0xC54A, 0x0F4B, 0x004C, 0x014D, 0x004E,     /* TV.4A-4E */
+    0x004F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0x1750, 0xCF51, 0x2652, 0x5753, 0x1254,     /* TV.50-54 */
+    0x7F55, 0xCF56, 0x4857, 0x2358, 0x8F59,     /* TV.55-59 */
+    0x5C5A, 0xF05B, 0x935C, 0x465D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x445E, 0x005F, 0x4460, 0x2061, 0xFF62,     /* TV.5E-62 */
+    0x3F63, 0x1364,                             /* TV.63-65 */
+
+    /* HT,  HA, HBS, HBE,  HSS, HSE, VT,  VA, VBS, VBE, VSS, VSE */
+    1560, 720, 720, 840, 1520, 16, 600, 576, 576,  24, 577, 2
+};
+
+static u16 VT1625_HDTV_1080I_1920x1080_VN[] = {
+                                                /* Non-Macrovision Registeris */
+    0x8300, 0x0001, 0x1002, 0x4A03, 0x8604,     /* TV.00-04 */
+    0x3905, 0x0006, 0x8B07, 0x3D08, 0x3209,     /* TV.05-09 */
+    0x000A, 0x000B, 0x000C, 0x000D, 0x000E,     /* TV.0A-0E */
+    0x9E0F, 0x0010, 0x8011, 0x4A12, 0x0813,     /* TV.0F-13 */
+    0x3714, 0x1415, 0x0016, 0x0017, 0x0018,     /* TV.14-18 */
+    0x0019,                                     /* TV.19 */
+    0x501B, 0x041C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x031F, 0x2520, 0x0021, 0x0022,     /* TV.1E-22 */
+    0x7E23, 0x0024,                             /* TV.23-24 */
+
+
+                                                /* Filter registers */
+    0xC54A, 0x0F4B, 0x004C, 0x014D, 0x004E,     /* TV.4A-4E */
+    0x004F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0x9750, 0x7F51, 0x7852, 0x6453, 0x1454,     /* TV.50-54 */
+    0x9755, 0x7F56, 0x5957, 0x7858, 0xB059,     /* TV.55-59 */
+    0x1A5A, 0xEC5B, 0xFA5C, 0x085D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x005E, 0x005F, 0x8060, 0x2061, 0xFF62,     /* TV.5E-62 */
+    0x9763, 0x2864, 0x5165,                     /* TV.63-65 */
+
+    /* HT,   HA,  HBS, HBE,  HSS, HSE,   VT,   VA,  VBS, VBE,  VSS, VSE */
+    2200, 1920, 1920, 280, 1960, 104, 1125, 1080, 1080,  45, 1083, 4
+};
+
+
+/* 720P Over Scan */
+static u16 VT1625_HDTV_720P_640x480_VO[] = {
+                                                /* Non-Macrovision Registers */
+    0x0300, 0x0001, 0x1002, 0x4003, 0x9404,     /* TV.00-04 */
+    0x0005, 0x0006, 0x0007, 0x3808, 0x0409,     /* TV.05-09 */
+    0x000A, 0x000B, 0x000C, 0x000D, 0x000E,     /* TV.0A-0E */
+    0xB00F, 0x0010, 0x8011, 0x2C12, 0x0A13,     /* TV.0F-13 */
+    0x2914, 0x3C15, 0x0016, 0x0017, 0x0018,     /* TV.14-18 */
+    0x0019,                                     /* TV.19 */
+    0x501B, 0x001C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x031F, 0x2520, 0x0021, 0x0022,     /* TV.1E-22 */
+    0x7E23, 0x0024,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0xC54A, 0x0F4B, 0x004C, 0x014D, 0x004E,     /* TV.4A-4E */
+    0x004F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xD750, 0x8351, 0x2352, 0xF353, 0x1154,     /* TV.50-54 */
+    0x3355, 0x7B56, 0x2857, 0x2358, 0x9559,     /* TV.55-59 */
+    0x135A, 0x895B, 0x135C, 0x435D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x555E, 0x165F, 0x5560, 0x2861, 0x0062,     /* TV.5E-62 */
+    0x8F63, 0x1264, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    984, 640, 640, 344, 920, 64,  500, 480, 480, 20, 481, 2
+};
+
+static u16 VT1625_HDTV_720P_800x600_VO[] = {
+                                                /* Non-Macrovision Registers */
+    0x0300, 0x0001, 0x1002, 0x4003, 0x9404,     /* TV.00-04 */
+    0x0005, 0x0006, 0x1007, 0x3908, 0x0209,     /* TV.05-09 */
+    0x000A, 0x000B, 0x000C, 0x000D, 0x000E,     /* TV.0A-0E */
+    0xB00F, 0x0010, 0x8011, 0x4F12, 0x0A13,     /* TV.0F-13 */
+    0x3F14, 0x4815, 0x0016, 0x0017, 0x0018,     /* TV.14-18 */
+    0x0019,                                     /* TV.19 */
+    0x501B, 0x001C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x001F, 0x2520, 0x0021, 0x0022,     /* TV.1E-22 */
+    0x7E23, 0x0024,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0xC54A, 0x0F4B, 0x004C, 0x014D, 0x004E,     /* TV.4A-4E */
+    0x004F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xEF50, 0x1F51, 0x3352, 0x7053, 0x1254,     /* TV.50-54 */
+    0xEF55, 0x1F56, 0x3057, 0x3358, 0xB759,     /* TV.55-59 */
+    0xC75A, 0x9B5B, 0xC75C, 0x435D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0xAA5E, 0x005F, 0x6A60, 0x2061, 0x0062,     /* TV.5E-62 */
+    0x4763, 0x1364, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1008, 800, 800, 208, 936, 56, 625, 600, 600, 25, 603, 2
+};
+
+static u16 VT1625_HDTV_720P_1024x768_VO[] = {
+                                                /* Non-Macrovision Registers */
+    0x0300, 0x0001, 0x1002, 0x4003, 0x9404,     /* TV.00-04 */
+    0x0005, 0x0006, 0x0307, 0x3508, 0xEE09,     /* TV.05-09 */
+    0x000A, 0x000B, 0x000C, 0x000D, 0x000E,     /* TV.0A-0E */
+    0xB80F, 0x0010, 0x8011, 0x6812, 0x1913,     /* TV.0F-13 */
+    0x5414, 0x1C15, 0x0016, 0x0017, 0x0018,     /* TV.14-18 */
+    0x0019,                                     /* TV.19 */
+    0x501B, 0x041C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x031F, 0x1C20, 0x0021, 0x0022,     /* TV.1E-22 */
+    0x7E23, 0x0024,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0xC54A, 0x0F4B, 0x004C, 0x014D, 0x004E,     /* TV.4A-4E */
+    0x004F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0x3750, 0x0851, 0x4452, 0x1F53, 0x0354,     /* TV.50-54 */
+    0xEF55, 0x1756, 0x3557, 0x3358, 0xB959,     /* TV.55-59 */
+    0xC75A, 0xAA5B, 0xB95C, 0x435D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x885E, 0x7B5F, 0x8860, 0xAA61, 0x0062,     /* TV.5E-62 */
+    0x7F63, 0x1464, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1080, 1024, 1024, 56, 1040, 32,  800, 768, 768, 32, 770, 13
+};
+
+static u16 VT1625_HDTV_720P_720x480_VO[] = {
+                                                /* Non-Macrovision Registers */
+    0x0300, 0x0001, 0x1002, 0x4003, 0x9404,     /* TV.00-04 */
+    0x0005, 0x0006, 0x0007, 0x3108, 0x0309,     /* TV.05-09 */
+    0x000A, 0x000B, 0x000C, 0x000D, 0x000E,     /* TV.0A-0E */
+    0xB00F, 0x0010, 0x8011, 0x2812, 0x0F13,     /* TV.0F-13 */
+    0x2E14, 0x2815, 0x0016, 0x0017, 0x0018,     /* TV.14-18 */
+    0x0019,                                     /* TV.19 */
+    0x501B, 0x001C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x031F, 0x2520, 0x0021, 0x0022,     /* TV.1E-22 */
+    0x7E23, 0x0024,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0xC54A, 0x0F4B, 0x004C, 0x014D, 0x004E,     /* TV.4A-4E */
+    0x004F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0x4F50, 0xD351, 0x2452, 0xF353, 0x1154,     /* TV.50-54 */
+    0x9755, 0xD156, 0x2C57, 0x2358, 0xA759,     /* TV.55-59 */
+    0x725A, 0x995B, 0x735C, 0x435D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x555E, 0x005F, 0x5560, 0x0061, 0x0062,     /* TV.5E-62 */
+    0xDF63, 0x1264, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1104, 720, 720, 384, 1040, 64,  500, 480, 480, 20, 482, 2
+};
+
+static u16 VT1625_HDTV_720P_1280x720_VO[] = {
+                                                /* Non-Macrovision Registers */
+    0x8300, 0x0001, 0x1002, 0x4003, 0x9404,     /* TV.00-04 */
+    0x0005, 0x0006, 0xFF07, 0x5308, 0x0009,     /* TV.05-09 */
+    0x000A, 0x000B, 0x000C, 0x000D, 0x000E,     /* TV.0A-0E */
+    0x9E0F, 0x0010, 0x8011, 0x8912, 0x1013,     /* TV.0F-13 */
+    0x6314, 0x2415, 0x0016, 0x0017, 0x0018,     /* TV.14-18 */
+    0x0019,                                     /* TV.19 */
+    0x501B, 0x001C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x031F, 0x2520, 0x0021, 0x0022,     /* TV.1E-22 */
+    0x7E23, 0x0024,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0xC54A, 0x0F4B, 0x004C, 0x014D, 0x004E,     /* TV.4A-4E */
+    0x004F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0x7150, 0xFF51, 0x4652, 0xED53, 0x1254,     /* TV.50-54 */
+    0x7155, 0xFF56, 0x5057, 0x4658, 0x3059,     /* TV.55-59 */
+    0x305A, 0x1C5B, 0x475C, 0x965D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x005E, 0x005F, 0x8060, 0x2861, 0x0062,     /* TV.5E-62 */
+    0x7163, 0x3664, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1650, 1280, 1280, 370, 1328, 72,  750, 720, 720, 30, 723, 4
+};
+
+
+/* 1080I Over Scan */
+static u16 VT1625_HDTV_1080I_640x480_VO[] = {
+                                                /* Non-Macrovision Registers */
+    0x0300, 0x0001, 0x1002, 0x4F03, 0x8604,     /* TV.00-04 */
+    0x0005, 0x0006, 0x0A07, 0x1708, 0x0209,     /* TV.05-09 */
+    0x000A, 0x000B, 0x000C, 0x000D, 0x000E,     /* TV.0A-0E */
+    0xB00F, 0x0010, 0x8011, 0xEC12, 0x3213,     /* TV.0F-13 */
+    0x1114, 0x3515, 0x0016, 0x0017, 0x0018,     /* TV.14-18 */
+    0x0019,                                     /* TV.19 */
+    0x501B, 0x001C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x031F, 0x2520, 0x0021, 0x0022,     /* TV.1E-22 */
+    0x7E23, 0x0024,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0xC54A, 0x0F4B, 0x004C, 0x014D, 0x004E,     /* TV.4A-4E */
+    0x004F,                                     /* TV.4F */
+ 
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xE750, 0x8351, 0x2552, 0xF353, 0x1154,     /* TV.50-54 */
+    0xD755, 0x7B56, 0x3A57, 0x2258, 0x7459,     /* TV.55-59 */
+    0xBA5A, 0x8E5B, 0x925C, 0x055D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0xE35E, 0x105F, 0x3860, 0x2861, 0xFF62,     /* TV.5E-62 */
+    0x9F63, 0x1264, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1512, 640, 640, 872, 1440, 64,  500, 480, 480, 20, 481, 2
+};
+
+static u16 VT1625_HDTV_1080I_800x600_VO[] = {
+                                                /* Non-Macrovision Registers */
+    0x0300, 0x0001, 0x1002, 0x4F03, 0x8604,     /* TV.00-04 */
+    0x0005, 0x0006, 0x1207, 0x1508, 0x0309,     /* TV.05-09 */
+    0x000A, 0x000B, 0x000C, 0x000D, 0x000E,     /* TV.0A-0E */
+    0xB00F, 0x0010, 0x8011, 0x0812, 0x0513,     /* TV.0F-13 */
+    0x1514, 0x2015, 0x0016, 0x0017, 0x0018,     /* TV.14-18 */
+    0x0019,                                     /* TV.19 */
+    0x501B, 0x001C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x031F, 0x2520, 0x0021, 0x0022,     /* TV.1E-22 */
+    0x7E23, 0x0024,                             /* TV.23-24 */
+ 
+                                                /* Filter registers */
+    0xC54A, 0x0F4B, 0x004C, 0x014D, 0x004E,     /* TV.4A-4E */
+    0x004F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xE750, 0x2151, 0x3552, 0x7053, 0x1254,     /* TV.50-54 */
+    0x4755, 0xDD56, 0x4357, 0x2358, 0x8559,     /* TV.55-59 */
+    0x245A, 0xA35B, 0x6E5C, 0x465D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x1C5E, 0xBD5F, 0x4760, 0x2861, 0xFF62,     /* TV.5E-62 */
+    0x4763, 0x1364, 0x5165,                     /* TV.63-65 */
+
+  /*HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1512, 800, 800, 712, 1440, 56,  625, 600, 600, 25, 600, 2
+};
+
+static u16 VT1625_HDTV_1080I_1024x768_VO[] = {
+                                                /* Non-Macrovision Registers */
+    0x0300, 0x0001, 0x1002, 0x4503, 0x8604,     /* TV.00-04 */
+    0x0005, 0x0006, 0x2007, 0x1D08, 0x3109,     /* TV.05-09 */
+    0x000A, 0x000B, 0x000C, 0x000D, 0x000E,     /* TV.0A-0E */
+    0xB80F, 0x0010, 0x8011, 0xE812, 0x1913,     /* TV.0F-13 */
+    0x8514, 0x1C15, 0x0016, 0x0017, 0x0018,     /* TV.14-18 */
+    0x0019,                                     /* TV.19 */
+    0x501B, 0x041C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x031F, 0x1C20, 0x0021, 0x0022,     /* TV.1E-22 */
+    0x7E23, 0x0024,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0xC54A, 0x0F4B, 0x004C, 0x014D, 0x004E,     /* TV.4A-4E */
+    0x004F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xAD50, 0x0151, 0x4652, 0x1F53, 0x1354,     /* TV.50-54 */
+    0x2755, 0x9F56, 0x5557, 0x3458, 0xAA59,     /* TV.55-59 */
+    0xFD5A, 0xD95B, 0x195C, 0x485D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x055E, 0xD75F, 0x5B60, 0x2861, 0xFF62,     /* TV.5E-62 */
+    0xBF63, 0x1464, 0x5165,                     /* TV.63-65 */
+
+  /*HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1710, 1024, 1024, 56, 1584, 96,  800, 768, 768, 32, 770, 13
+};
+
+static u16 VT1625_HDTV_1080I_720x480_VO[] = {
+                                                /* Non-Macrovision Registers */
+    0x0300, 0x0001, 0x1002, 0x4F03, 0x8604,     /* TV.00-04 */
+    0x0005, 0x0006, 0x0007, 0x1A08, 0x2B09,     /* TV.05-09 */
+    0x000A, 0x000B, 0x000C, 0x000D, 0x000E,     /* TV.0A-0E */
+    0xB00F, 0x0010, 0x8011, 0xE812, 0x3213,     /* TV.0F-13 */
+    0xCF14, 0x2415, 0x0016, 0x0017, 0x0018,     /* TV.14-18 */
+    0x0019,                                     /* TV.19 */
+    0x501B, 0x041C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x031F, 0x2520, 0x0021, 0x0022,     /* TV.1E-22 */
+    0x7E23, 0x0024,                             /* TV.23-24 */
+ 
+                                                /* Filter registers */
+    0xC54A, 0x0F4B, 0x004C, 0x014D, 0x004E,     /* TV.4A-4E */
+    0x004F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0x7750, 0xD351, 0x2652, 0xF353, 0x1154,     /* TV.50-54 */
+    0x3B55, 0xD156, 0x4257, 0x2358, 0x8459,     /* TV.55-59 */
+    0x1A5A, 0xA25B, 0x565C, 0x465D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0xE35E, 0x005F, 0x3860, 0x2861, 0xFF62,     /* TV.5E-62 */
+    0xDF63, 0x1264, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1656, 720, 720, 936, 1584, 72,  500, 480, 480, 20, 485, 6
+};
+
+static u16 VT1625_HDTV_1080I_1920x1080_VO[] = {
+                                                /* Non-Macrovision Registers */
+    0x8300, 0x0001, 0x1002, 0x4A03, 0x8604,     /* TV.00-04 */
+    0x3905, 0x0006, 0x8B07, 0x3D08, 0x3209,     /* TV.05-09 */
+    0x000A, 0x000B, 0x000C, 0x000D, 0x000E,     /* TV.0A-0E */
+    0x9E0F, 0x0010, 0x8011, 0x4A12, 0x0813,     /* TV.0F-13 */
+    0x3714, 0x1415, 0x0016, 0x0017, 0x0018,     /* TV.14-18 */
+    0x0019,                                     /* TV.19 */
+    0x501B, 0x041C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x031F, 0x2520, 0x0021, 0x0022,     /* TV.1E-22 */
+    0x7E23, 0x0024,                             /* TV.23-24 */
+ 
+                                                /* Filter registers */
+    0xC54A, 0x0F4B, 0x004C, 0x014D, 0x004E,     /* TV.4A-4E */
+    0x004F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0x9750, 0x7F51, 0x7852, 0x6453, 0x1454,     /* TV.50-54 */
+    0x9755, 0x7F56, 0x5957, 0x7858, 0xB059,     /* TV.55-59 */
+    0x1A5A, 0xEC5B, 0xFA5C, 0x085D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x005E, 0x005F, 0x8060, 0x2061, 0xFF62,     /* TV.5E-62 */
+    0x9763, 0x2864, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    2200, 1920, 1920, 280, 1960, 104,  1125, 1080, 1080, 45, 1083, 4
+};
+
+
+vt1625_func_table VT1625_HDTV_720P_640x480_tbl[] = {
+    {TV_BASE_FUNC,         VT1625_HDTV_720P_640x480_VN,     VT1625_NULL_FUNC,   VT1625_HDTV_720P_640x480_VO},
+    {TV_RGB_FUNC,          HDTV_OUT_RGB,                    VT1625_NULL_FUNC,   HDTV_OUT_RGB},
+    {TV_YPBPR_FUNC,        HDTV_OUT_YPBPR,                  VT1625_NULL_FUNC,   HDTV_OUT_YPBPR},
+    {TV_SDTV_RGB_FUNC,     VT1625_NULL_FUNC,                VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_SDTV_YPBPR_FUNC,   VT1625_NULL_FUNC,                VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_DeDotCrawl_FUNC,   VT1625_NULL_FUNC,                VT1625_NULL_FUNC,   VT1625_NULL_FUNC}
+};
+
+vt1625_func_table VT1625_HDTV_720P_800x600_tbl[] = {
+    {TV_BASE_FUNC,         VT1625_HDTV_720P_800x600_VN,     VT1625_NULL_FUNC,   VT1625_HDTV_720P_800x600_VO},
+    {TV_RGB_FUNC,          HDTV_OUT_RGB,                    VT1625_NULL_FUNC,   HDTV_OUT_RGB},
+    {TV_YPBPR_FUNC,        HDTV_OUT_YPBPR,                  VT1625_NULL_FUNC,   HDTV_OUT_YPBPR},
+    {TV_SDTV_RGB_FUNC,     VT1625_NULL_FUNC,                VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_SDTV_YPBPR_FUNC,   VT1625_NULL_FUNC,                VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_DeDotCrawl_FUNC,   VT1625_NULL_FUNC,                VT1625_NULL_FUNC,   VT1625_NULL_FUNC}
+};
+
+vt1625_func_table VT1625_HDTV_720P_1024x768_tbl[] = {
+    {TV_BASE_FUNC,         VT1625_HDTV_720P_1024x768_VN,    VT1625_NULL_FUNC,   VT1625_HDTV_720P_1024x768_VO},
+    {TV_RGB_FUNC,          HDTV_OUT_RGB,                    VT1625_NULL_FUNC,   HDTV_OUT_RGB},
+    {TV_YPBPR_FUNC,        HDTV_OUT_YPBPR,                  VT1625_NULL_FUNC,   HDTV_OUT_YPBPR},
+    {TV_SDTV_RGB_FUNC,     VT1625_NULL_FUNC,                VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_SDTV_YPBPR_FUNC,   VT1625_NULL_FUNC,                VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_DeDotCrawl_FUNC,   VT1625_NULL_FUNC,                VT1625_NULL_FUNC,   VT1625_NULL_FUNC}
+};
+
+vt1625_func_table VT1625_HDTV_720P_720x480_tbl[] = {
+    {TV_BASE_FUNC,         VT1625_HDTV_720P_720x480_VN,     VT1625_NULL_FUNC,   VT1625_HDTV_720P_720x480_VO},
+    {TV_RGB_FUNC,          HDTV_OUT_RGB,                    VT1625_NULL_FUNC,   HDTV_OUT_RGB},
+    {TV_YPBPR_FUNC,        HDTV_OUT_YPBPR,                  VT1625_NULL_FUNC,   HDTV_OUT_YPBPR},
+    {TV_SDTV_RGB_FUNC,     VT1625_NULL_FUNC,                VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_SDTV_YPBPR_FUNC,   VT1625_NULL_FUNC,                VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_DeDotCrawl_FUNC,   VT1625_NULL_FUNC,                VT1625_NULL_FUNC,   VT1625_NULL_FUNC}
+};
+
+vt1625_func_table VT1625_HDTV_720P_720x576_tbl[] = {
+    {TV_BASE_FUNC,         VT1625_HDTV_720P_720x576_VN,     VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_RGB_FUNC,          HDTV_OUT_RGB,                    VT1625_NULL_FUNC,   HDTV_OUT_RGB},
+    {TV_YPBPR_FUNC,        HDTV_OUT_YPBPR,                  VT1625_NULL_FUNC,   HDTV_OUT_YPBPR},
+    {TV_SDTV_RGB_FUNC,     VT1625_NULL_FUNC,                VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_SDTV_YPBPR_FUNC,   VT1625_NULL_FUNC,                VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_DeDotCrawl_FUNC,   VT1625_NULL_FUNC,                VT1625_NULL_FUNC,   VT1625_NULL_FUNC}
+};
+
+vt1625_func_table VT1625_HDTV_720P_1280x720_tbl[] = {
+    {TV_BASE_FUNC,         VT1625_HDTV_720P_1280x720_VN,    VT1625_NULL_FUNC,   VT1625_HDTV_720P_1280x720_VO},
+    {TV_RGB_FUNC,          HDTV_OUT_RGB,                    VT1625_NULL_FUNC,   HDTV_OUT_RGB},
+    {TV_YPBPR_FUNC,        HDTV_OUT_YPBPR,                  VT1625_NULL_FUNC,   HDTV_OUT_YPBPR},
+    {TV_SDTV_RGB_FUNC,     VT1625_NULL_FUNC,                VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_SDTV_YPBPR_FUNC,   VT1625_NULL_FUNC,                VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_DeDotCrawl_FUNC,   VT1625_NULL_FUNC,                VT1625_NULL_FUNC,   VT1625_NULL_FUNC}
+};
+
+vt1625_func_table VT1625_HDTV_1080I_640x480_tbl[] = {
+    {TV_BASE_FUNC,         VT1625_HDTV_1080I_640x480_VN,    VT1625_NULL_FUNC,   VT1625_HDTV_1080I_640x480_VO},
+    {TV_RGB_FUNC,          HDTV_OUT_RGB,                    VT1625_NULL_FUNC,   HDTV_OUT_RGB},
+    {TV_YPBPR_FUNC,        HDTV_OUT_YPBPR,                  VT1625_NULL_FUNC,   HDTV_OUT_YPBPR},
+    {TV_SDTV_RGB_FUNC,     VT1625_NULL_FUNC,                VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_SDTV_YPBPR_FUNC,   VT1625_NULL_FUNC,                VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_DeDotCrawl_FUNC,   VT1625_NULL_FUNC,                VT1625_NULL_FUNC,   VT1625_NULL_FUNC}
+};
+
+vt1625_func_table VT1625_HDTV_1080I_800x600_tbl[] = {
+    {TV_BASE_FUNC,         VT1625_HDTV_1080I_800x600_VN,    VT1625_NULL_FUNC,   VT1625_HDTV_1080I_800x600_VO},
+    {TV_RGB_FUNC,          HDTV_OUT_RGB,                    VT1625_NULL_FUNC,   HDTV_OUT_RGB},
+    {TV_YPBPR_FUNC,        HDTV_OUT_YPBPR,                  VT1625_NULL_FUNC,   HDTV_OUT_YPBPR},
+    {TV_SDTV_RGB_FUNC,     VT1625_NULL_FUNC,                VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_SDTV_YPBPR_FUNC,   VT1625_NULL_FUNC,                VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_DeDotCrawl_FUNC,   VT1625_NULL_FUNC,                VT1625_NULL_FUNC,   VT1625_NULL_FUNC}
+};
+
+vt1625_func_table VT1625_HDTV_1080I_1024x768_tbl[] = {
+    {TV_BASE_FUNC,         VT1625_HDTV_1080I_1024x768_VN,   VT1625_NULL_FUNC,   VT1625_HDTV_1080I_1024x768_VO},
+    {TV_RGB_FUNC,          HDTV_OUT_RGB,                    VT1625_NULL_FUNC,   HDTV_OUT_RGB},
+    {TV_YPBPR_FUNC,        HDTV_OUT_YPBPR,                  VT1625_NULL_FUNC,   HDTV_OUT_YPBPR},
+    {TV_SDTV_RGB_FUNC,     VT1625_NULL_FUNC,                VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_SDTV_YPBPR_FUNC,   VT1625_NULL_FUNC,                VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_DeDotCrawl_FUNC,   VT1625_NULL_FUNC,                VT1625_NULL_FUNC,   VT1625_NULL_FUNC}
+};
+
+vt1625_func_table VT1625_HDTV_1080I_720x480_tbl[] = {
+    {TV_BASE_FUNC,         VT1625_HDTV_1080I_720x480_VN,    VT1625_NULL_FUNC,   VT1625_HDTV_1080I_720x480_VO},
+    {TV_RGB_FUNC,          HDTV_OUT_RGB,                    VT1625_NULL_FUNC,   HDTV_OUT_RGB},
+    {TV_YPBPR_FUNC,        HDTV_OUT_YPBPR,                  VT1625_NULL_FUNC,   HDTV_OUT_YPBPR},
+    {TV_SDTV_RGB_FUNC,     VT1625_NULL_FUNC,                VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_SDTV_YPBPR_FUNC,   VT1625_NULL_FUNC,                VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_DeDotCrawl_FUNC,   VT1625_NULL_FUNC,                VT1625_NULL_FUNC,   VT1625_NULL_FUNC}
+};
+
+vt1625_func_table VT1625_HDTV_1080I_720x576_tbl[] = {
+    {TV_BASE_FUNC,         VT1625_HDTV_1080I_720x576_VN,    VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_RGB_FUNC,          HDTV_OUT_RGB,                    VT1625_NULL_FUNC,   HDTV_OUT_RGB},
+    {TV_YPBPR_FUNC,        HDTV_OUT_YPBPR,                  VT1625_NULL_FUNC,   HDTV_OUT_YPBPR},
+    {TV_SDTV_RGB_FUNC,     VT1625_NULL_FUNC,                VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_SDTV_YPBPR_FUNC,   VT1625_NULL_FUNC,                VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_DeDotCrawl_FUNC,   VT1625_NULL_FUNC,                VT1625_NULL_FUNC,   VT1625_NULL_FUNC}
+};
+
+vt1625_func_table VT1625_HDTV_1080I_1920x1080_tbl[] = {
+    {TV_BASE_FUNC,         VT1625_HDTV_1080I_1920x1080_VN,  VT1625_NULL_FUNC,   VT1625_HDTV_1080I_1920x1080_VO},
+    {TV_RGB_FUNC,          HDTV_OUT_RGB,                    VT1625_NULL_FUNC,   HDTV_OUT_RGB},
+    {TV_YPBPR_FUNC,        HDTV_OUT_YPBPR,                  VT1625_NULL_FUNC,   HDTV_OUT_YPBPR},
+    {TV_SDTV_RGB_FUNC,     VT1625_NULL_FUNC,                VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_SDTV_YPBPR_FUNC,   VT1625_NULL_FUNC,                VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_DeDotCrawl_FUNC,   VT1625_NULL_FUNC,                VT1625_NULL_FUNC,   VT1625_NULL_FUNC}
+};
+
+vt1625_func_table VT1625_NULL_TBL[] = {
+    {0xFFFF,   VT1625_NULL_FUNC,   VT1625_NULL_FUNC,   VT1625_NULL_FUNC}
+};
+
+static struct vt1625_table vt1625_tbl[] = {
+    {VIA_RES_640X480,   vt1625_ntsc_640x480_tbl,  vt1625_pal_640x480_tbl,  VT1625_HDTV_720P_640x480_tbl,  VT1625_HDTV_1080I_640x480_tbl  },
+    {VIA_RES_800X600,   vt1625_ntsc_800x600_tbl,  vt1625_pal_800x600_tbl,  VT1625_HDTV_720P_800x600_tbl,  VT1625_HDTV_1080I_800x600_tbl  },
+    {VIA_RES_1024X768,  vt1625_ntsc_1024x768_tbl, vt1625_pal_1024x768_tbl, VT1625_HDTV_720P_1024x768_tbl, VT1625_HDTV_1080I_1024x768_tbl },
+    {VIA_RES_720X480,   vt1625_ntsc_720x480_tbl,  vt1625_ntsc_720x480_tbl, VT1625_HDTV_720P_720x480_tbl,  VT1625_HDTV_1080I_720x480_tbl  },
+    {VIA_RES_720X576,   vt1625_pal_720x576_tbl,   vt1625_pal_720x576_tbl,  VT1625_HDTV_720P_720x576_tbl,  VT1625_HDTV_1080I_720x576_tbl  },
+    {VIA_RES_1280X720,  VT1625_NULL_TBL,          VT1625_NULL_TBL,         VT1625_HDTV_720P_1280x720_tbl, VT1625_NULL_TBL                },
+    {VIA_RES_1920X1080, VT1625_NULL_TBL,          VT1625_NULL_TBL,         VT1625_NULL_TBL,               VT1625_HDTV_1080I_1920x1080_tbl}
+};
+
+#define NUM_TOTAL_VT1625_TABLE ARRAY_SIZE(vt1625_tbl)
+
+#define IS_VT1625_NULL_TBL(tbl) tbl[0].tv_func_index == 0xFFFF ? TRUE : FALSE
+#define IS_VT1625_NULL_FUNC(func) func[0] == 0xFFFF ? TRUE : FALSE
+
+static u16 VT1625_CGMS_TBL[] = {
+    0x006b, 0x006c, 0x006d, 0x006e, 0x006f, /* TV 0x6b-0x6f */
+    0x0070, 0x0071, 0x0072, 0x0073              /* TV0x70-0x73 */
+};
+#define NUM_TOTAL_VT1625_CGMS_TBL ARRAY_SIZE(VT1625_CGMS_TBL)
+
+#endif /* __TBL1625_H__ */

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
