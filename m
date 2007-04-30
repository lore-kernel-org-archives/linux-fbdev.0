From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 7/12] viafb: Framebuffer driver for VIA
 UniChrome/Chrome9 HC (fwd)
Date: Mon, 30 Apr 2007 10:37:23 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704301037170.27246@anakin>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HiRNx-0006X7-Qr for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Apr 2007 01:37:29 -0700
Received: from astra.telenet-ops.be ([195.130.132.58])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HiRNw-0001ki-CJ
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Apr 2007 01:37:29 -0700
Received: from localhost (localhost.localdomain [127.0.0.1])
	by astra.telenet-ops.be (Postfix) with SMTP id 79D8A380DD
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 30 Apr 2007 10:37:27 +0200 (CEST)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by astra.telenet-ops.be (Postfix) with ESMTP id 5B2ED38115
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 30 Apr 2007 10:37:23 +0200 (CEST)
Received: from anakin.of.borg (geert@localhost [127.0.0.1])
	by anakin.of.borg (8.13.8/8.13.8/Debian-3) with ESMTP id l3U8bNRt020406
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 30 Apr 2007 10:37:23 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.13.8/8.13.8/Submit) with ESMTP id l3U8bNZ3020403
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 30 Apr 2007 10:37:23 +0200
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
Date: Mon, 30 Apr 2007 13:20:30 +0800
From: EddyFu@via.com.tw
To: linux-fbdev-devel-bounces@lists.sourceforge.net
Subject: [Linux-fbdev-devel] [PATCH 7/12] viafb: Framebuffer driver for VIA
    UniChrome/Chrome9 HC

Dear All, 
 
Here is the part 7/12 of viafb.
 
Best Regards,
Eddy Fu 
 
diff -Nur linux-2.6.21-rc7/drivers/video/via/tbl1622.h linux-2.6.21-rc7.viafb/drivers/video/via/tbl1622.h
--- linux-2.6.21-rc7/drivers/video/via/tbl1622.h 1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/tbl1622.h 2007-04-26 19:52:32.000000000 -0400
@@ -0,0 +1,1670 @@
+ /*
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
+ 
+#ifndef __TBL1622_H__
+#define __TBL1622_H__
+
+#include "share.h"
+
+/***************************/
+/* VT1622 TV Encoder Table */
+/***************************/
+
+typedef struct _vt1622_func_table {
+    int     tv_func_index;
+    u16     *tv_underscan;
+    u16     *tv_fitscan;
+    u16     *tv_overscan;
+} vt1622_func_table;
+
+struct vt1622_table {
+    int     tv_index;
+    vt1622_func_table   *tv_mode_ntsc;
+    vt1622_func_table   *tv_mode_pal;
+};
+
+
+/* Underscan table */
+static u16 VT1622_N640x480_VN[] = {
+                                                
+    0x0400, 0x0001, 0x0002, 0x0203, 0x0304,     /* TV.00-04 */
+    0x0005, 0x1006, 0x7E07, 0x9D08, 0x0D09,     /* Tv.05-09 */
+    0x600A, 0x170B, 0x520C, 0x450D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xD012, 0x3313,     /* TV.0F-13 */
+    0xBF14, 0x3A15, 0xF116, 0x9117, 0x2418,     /* TV.14-18 */
+    0x2519,                                     /* TV.19 */
+    0x031B, 0x001C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x051F, 0x1220, 0x0C21, 0x0422,     /* TV.1E-22 */
+    0x7423, 0x0024,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0xDC4A, 0x504B, 0x044C, 0x004D, 0x004E,     /* TV.4A-4E */
+    0x404F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0x0F50, 0x8151, 0x2352, 0x5753, 0x0254,     /* TV.50-54 */
+    0x0F55, 0x2956, 0x7357, 0x2358, 0x8659,     /* TV.55-59 */
+    0xC45A, 0xEA5B, 0xDF5C, 0x055D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x925E, 0xA15F, 0x0460, 0x0061, 0x0062,     /* TV.5E-62 */
+    0x7F63, 0x0364,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    784, 640, 640, 144, 656, 56,  600, 480, 480, 120, 488, 7
+};
+
+#define NUM_TOTAL_VT1622_REG ARRAY_SIZE(VT1622_N640x480_VN) -NUM_CRTC_TIMING
+
+static u16 VT1622_N800x600_VN[] = {
+                                                  
+    0x8400, 0x0001, 0x0002, 0x2403, 0x0304,     /* TV.00-04 */
+    0x0005, 0x1006, 0xDE07, 0xD408, 0x0E09,     /* TV.05-09 */
+    0x590A, 0x170B, 0x460C, 0x400D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xEA12, 0x0D13,     /* TV.0F-13 */
+    0x9814, 0x1C15, 0x9616, 0x5017, 0x5E18,     /* TV.14-18 */
+    0x1B19,                                     /* TV.19 */
+    0x031B, 0x011C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x851F, 0x0D20, 0x0A21, 0x0422,     /* TV.1E-22 */
+    0x7423, 0x0024,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0xE44A, 0x694B, 0x044C, 0x004D, 0x004E,     /* TV.4A-4E */
+    0x3F4F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0x2750, 0x2151, 0x3452, 0xED53, 0x0254,     /* TV.50-54 */
+    0x2755, 0xF556, 0x9D57, 0x2458, 0xB759,     /* TV.55-59 */
+    0x0D5A, 0x405B, 0x005C, 0x585D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0xB65E, 0x3B5F, 0x0560, 0x0061, 0x0162,     /* TV.5E-62 */
+    0xEF63, 0x0564,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1064,800, 800, 264, 840, 136, 750, 600, 600, 150, 606, 16
+};
+
+static u16 VT1622_N1024x768_VN[] = {
+                                                  
+    0x8400, 0x0001, 0x0002, 0x4403, 0x0304,     /* TV.00-04 */
+    0x0005, 0x1006, 0x8007, 0x1508, 0x0A09,     /* TV.05-09 */
+    0x580A, 0x170B, 0x5B0C, 0x400D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xE912, 0x1E13,     /* TV.0F-13 */
+    0x9D14, 0x1915, 0xD616, 0x6617, 0xEB18,     /* TV.14-18 */
+    0x1419,                                     /* TV.19 */
+    0x031B, 0x051C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x851F, 0x0A20, 0x0521, 0x0422,     /* TV.1E-22 */
+    0x7423, 0x0024,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0xDA4A, 0x504B, 0x044C, 0x004D, 0x004E,     /* TV.4A-4E */
+    0x3F4F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0x8750, 0xFF51, 0x3452, 0xB053, 0x0354,     /* TV.50-54 */
+    0x6F55, 0xDB56, 0xCD57, 0x3558, 0xF159,     /* TV.55-59 */
+    0x5E5A, 0xA55B, 0x7E5C, 0x5A5D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x335E, 0x265F, 0x0760, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x2763, 0x0864,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1160,1024,1024,136, 1040,56,  945, 768, 768, 177, 789, 6
+};
+
+static u16 VT1622_N848x480_VN[] = {
+                                                  
+    0x8400, 0x0001, 0x0002, 0x2403, 0x0304,     /* TV.00-04 */
+    0x0005, 0x1006, 0x4607, 0xCC08, 0x0E09,     /* TV.05-09 */
+    0x560A, 0x170B, 0x430C, 0x3E0D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xE812, 0x2913,     /* TV.0F-13 */
+    0x6714, 0x1915, 0x6316, 0xA817, 0x3C18,     /* TV.14-18 */
+    0x1D19,                                     /* TV.19 */
+    0x031B, 0x0B1C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x851F, 0x0E20, 0x0821, 0x0422,     /* TV.1E-22 */
+    0x7423, 0x0024,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0xDC4A, 0x504B, 0x004C, 0x004D, 0x004E,     /* TV.4A-4E */
+    0x404F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xAF50, 0x5151, 0x3452, 0x4453, 0x0254,     /* TV.50-54 */
+    0xE355, 0xC156, 0x9357, 0x2358, 0xAD59,     /* TV.55-59 */
+    0xFD5A, 0x2B5B, 0x7C5C, 0x175D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x6D5E, 0xCA5F, 0x0460, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x2F63, 0x0564,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1200,848, 848, 352, 872, 64,  581, 480, 480, 101, 496, 13
+};
+
+static u16 VT1622_N720x480_VN[] = {
+                                                  
+    0x0400, 0x0001, 0x0002, 0x2603, 0x0304,     /* TV.00-04 */
+    0x0005, 0x1006, 0x6D07, 0xC308, 0x0809,     /* TV.05-09 */
+    0x560A, 0x170B, 0x430C, 0x3E0D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0x0D12, 0x0713,     /* TV.0F-13 */
+    0x6014, 0x3415, 0x1816, 0x5517, 0x5518,     /* TV.14-18 */
+    0x1E19,                                     /* TV.19 */
+    0x031B, 0x031C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x851F, 0x0F20, 0x0821, 0x0422,     /* TV.1E-22 */
+    0x7423, 0x0024,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0xE44A, 0x694B, 0x044C, 0x004D, 0x004E,     /* TV.4A-4E */
+    0x404F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0x4750, 0xD151, 0x2352, 0x5753, 0x0254,     /* TV.50-54 */
+    0xBF55, 0xAF56, 0x8D57, 0x2358, 0xA459,     /* TV.55-59 */
+    0xF35A, 0x205B, 0x365C, 0x175D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x925E, 0x335F, 0x0460, 0x0061, 0x0062,     /* TV.5E-62 */
+    0xBF63, 0x0364,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    840, 720, 720, 120, 728, 48,  600, 480, 480, 120, 512, 7
+};
+
+static u16 VT1622_P640x480_VN[] = {
+                                                
+    0x0400, 0x0001, 0x0002, 0x8203, 0x0004,     /* TV.00-04 */
+    0x0005, 0x1006, 0x3E07, 0xA408, 0x3709,     /* TV.05-09 */
+    0x670A, 0x000B, 0x490C, 0x490D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xEC12, 0x2A13,     /* TV.0F-13 */
+    0xB814, 0x2915, 0x2D16, 0x7717, 0x6618,     /* TV.14-18 */ 
+    0x2D19,                                     /* TV.19 */
+    0x031B, 0x0A1C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x041F, 0x1220, 0x0C21, 0x0422,     /* TV.1E-22 */
+    0x7B23, 0x0024,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0xF94A, 0x504B, 0x044C, 0x004D, 0x004E,     /* TV.4A-4E */
+    0x454F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xE750, 0x8151, 0x2352, 0x5753, 0x0254,     /* TV.50-54 */
+    0x1F55, 0x3156, 0x7557, 0x2358, 0x8A59,     /* TV.55-59 */
+    0xC85A, 0xF05B, 0xFF5C, 0x055D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0xD75E, 0x8E5F, 0x0360, 0x7F61, 0xCF62,     /* TV.5E-62 */
+    0xBF63, 0x0364,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1000,640, 640, 360, 680, 72,  600, 480, 480, 120, 521, 5
+};
+
+static u16 VT1622_P800x600_VN[] = {
+                                                
+    0x8400, 0x0001, 0x0002, 0xA403, 0x0004,     /* TV.00-04 */
+    0x0005, 0x1906, 0x6607, 0xBF08, 0x1209,     /* TV.05-09 */
+    0x600A, 0x000B, 0x560C, 0x450D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xEC12, 0x1513,     /* TV.0F-13 */
+    0xFD14, 0x2815, 0xE416, 0x7D17, 0x7A18,     /* TV.14-18 */
+    0x2719,                                     /* TV.19 */
+    0x031B, 0x011C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x851F, 0x1020, 0x0C21, 0x0422,     /* TV.1E-22 */
+    0x7B23, 0x0024,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0xE74A, 0x454B, 0x044C, 0x004D, 0x004E,     /* TV.4A-4E */
+    0x444F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0x9750, 0x2151, 0x3352, 0xED53, 0x0254,     /* TV.50-54 */
+    0x9755, 0x8756, 0x8757, 0x2358, 0x9F59,     /* TV.55-59 */
+    0xE75A, 0x165B, 0xE75C, 0x165D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0xCC5E, 0xF35F, 0x0460, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x4F63, 0x0464,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    920, 800, 800, 120, 816, 64,  750, 600, 600, 150, 606, 16
+};
+
+static u16 VT1622_P1024x768_VN[] = {
+                                                
+    0x8400, 0x0001, 0x0002, 0x0C03, 0x0004,     /* TV.00-04 */
+    0x0005, 0x1006, 0xA007, 0x2A08, 0x3809,     /* TV.05-09 */
+    0x700A, 0x000B, 0x4E0C, 0x500D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xE412, 0x2313,     /* TV.0F-13 */
+    0xD114, 0x0C15, 0x7216, 0xC317, 0x8C18,     /* TV.14-18 */
+    0x1A19,                                     /* TV.19 */
+    0x031B, 0x071C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x851F, 0x0C20, 0x0C21, 0x0422,     /* TV.1E-22 */
+    0x7B23, 0x0024,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0xDD4A, 0x604B, 0x044C, 0x004D, 0x004E,     /* TV.4A-4E */
+    0x454F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xAF50, 0xFF51, 0x3452, 0xB553, 0x0354,     /* TV.50-54 */
+    0x5755, 0xA856, 0xC857, 0x3558, 0xEC59,     /* TV.55-59 */
+    0x4C5A, 0xCC5B, 0x675C, 0x5A5D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x145E, 0x5C5F, 0x0660, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x1F63, 0x0764,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1200,1024,1024,176, 1040,80,  950, 768, 768, 182, 802, 3
+};
+
+static u16 VT1622_P848x480_VN[] = {
+                                                
+    0x0400, 0x0001, 0x0002, 0xC203, 0x0004,     /* TV.00-04 */
+    0x0005, 0x1006, 0x4707, 0xE408, 0x0909,     /* TV.05-09 */
+    0x640A, 0x000B, 0x4F0C, 0x480D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xE712, 0x0513,     /* TV.0F-13 */
+    0x2C14, 0x1C15, 0x1816, 0x2817, 0x8718,     /* TV.14-18 */
+    0x1F19,                                     /* TV.19 */
+    0x031B, 0x091C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x841F, 0x0A20, 0x0C21, 0x0422,     /* TV.1E-22 */
+    0x7B23, 0x0024,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0xE74A, 0x454B, 0x044C, 0x004D, 0x004E,     /* TV.4A-4E */
+    0x434F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xAF50, 0x5151, 0x3452, 0x5753, 0x0254,     /* TV.50-54 */
+    0x7F55, 0x4F56, 0xA957, 0x3458, 0xD159,     /* TV.55-59 */
+    0x2B5A, 0x5D5B, 0xAA5C, 0x585D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0xD75E, 0x015F, 0x0360, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x7F63, 0x0464,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1200,848, 848, 352, 976, 56,  600, 480, 480, 120, 499, 11
+};
+
+static u16 VT1622_P720x576_VN[] = {
+                                                
+    0x0400, 0x0001, 0x0002, 0xA203, 0x0004,     /* TV.00-04 */
+    0x0005, 0x1006, 0x1E07, 0xAC08, 0x3809,     /* TV.05-09 */
+    0x670A, 0x000B, 0x570C, 0x490D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xF012, 0x0F13,     /* TV.0F-13 */
+    0xD114, 0x3815, 0x3216, 0x9817, 0x8318,     /* TV.14-18 */
+    0x2D19,                                     /* TV.19 */
+    0x031B, 0x021C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x841F, 0x1320, 0x0C21, 0x0422,     /* TV.1E-22 */
+    0x7B23, 0x4824,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0xE74A, 0x454B, 0x044C, 0x004D, 0x004E,     /* TV.4A-4E */
+    0x454F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xF750, 0xD151, 0x2252, 0xED53, 0x0254,     /* TV.50-54 */
+    0x1D55, 0x2956, 0x7557, 0x2358, 0x8859,     /* TV.55-59 */
+    0xC65A, 0xF05B, 0xFA5C, 0x0F5D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0xCC5E, 0x305F, 0x1460, 0x0061, 0x0062,     /* TV.5E-62 */
+    0x8F63, 0x0364,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    760, 720, 720, 40,  728, 16,   750, 576, 576, 174, 643, 29
+};
+
+
+/* Fit Industry TV Screen Mode */
+
+static u16 VT1622_N640x480_VF[] = {
+                                                
+    0x0400, 0x0001, 0x0002, 0x0203, 0x0304,     /* TV.00-04 */
+    0x0005, 0x1006, 0xA607, 0x8C08, 0x0709,     /* TV.05-09 */
+    0x600A, 0x170B, 0x520C, 0x450D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0x8812, 0x0D13,     /* TV.0F-13 */
+    0x5C14, 0x1C15, 0x4216, 0x8517, 0x2C18,     /* TV.14-18 */
+    0x2419,                                     /* TV.19 */
+    0x031B, 0x021C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x051F, 0x1220, 0x0C21, 0x0422,     /* TV.1E-22 */
+    0x7523, 0x0024,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0xC44A, 0x504B, 0x044C, 0x004D, 0x004E,     /* TV.4A-4E */
+    0x414F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0x4750, 0x8151, 0x2352, 0x3E53, 0x0254,     /* TV.50-54 */
+    0x2455, 0x6556, 0x7757, 0x2358, 0x8859,     /* TV.55-59 */
+    0xCB5A, 0x025B, 0x155C, 0x165D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x625E, 0x2E5F, 0x0460, 0x0061, 0x0062,     /* TV.5E-62 */
+    0x9763, 0x0364,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    840, 640, 640, 200, 672, 56,  575, 480, 480, 95,  499, 7
+};
+
+static u16 VT1622_N800x600_VF[] = {
+                                                
+    0x8400, 0x0001, 0x0002, 0x2403, 0x0304,     /*/ TV.00-04 */
+    0x0005, 0x1006, 0x5007, 0xA108, 0xFE09,     /*/ TV.05-09 */
+    0x630A, 0x170B, 0x460C, 0x470D, 0x0F0E,     /*/ TV.0A-0E */ 
+    0x000F, 0x0010, 0x0011, 0xED12, 0x1913,     /*/ TV.0F-13 */
+    0x4014, 0x1D15, 0xBE16, 0xFF17, 0x7F18,     /*/ TV.14-18 */
+    0x2019,                                     /*/ TV.19 */
+    0x031B, 0x091C, 0x801D,                     /*/ TV.1B-1D */
+    0x001E, 0x851F, 0x0D20, 0x0A21, 0x0422,     /*/ TV.1E-22 */
+    0x7523, 0x0024,                             /*/ TV.23-24 */
+
+                                                /*/ Filter registers */
+    0xE44A, 0x694B, 0x044C, 0x004D, 0x004E,     /*/ TV.4A-4E */
+    0x404F,                                     /*/ TV.4F */
+
+                                                /*/ Set Video Timing (TV Timing Regsiter ) */
+    0xAF50, 0x1F51, 0x3452, 0xD753, 0x0254,     /*/ TV.50-54 */
+    0x7F55, 0xA956, 0x8457, 0x2358, 0x9859,     /*/ TV.55-59 */
+    0xE35A, 0x1A5B, 0xB25C, 0x165D,             /*/ TV.5A-5D */
+                                                /*/ Set Video Timing (TV CRTC Regsiter ) */
+    0x8C5E, 0xB25F, 0x0560, 0x0061, 0x0162,     /*/ TV.5E-62 */
+    0x7F63, 0x0664,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1200,800, 800, 400, 864, 200, 728, 600, 600, 128, 656, 9
+};
+
+static u16 VT1622_N1024x768_VF[] = {
+                                                
+    0x8400, 0x0001, 0x0002, 0x0403, 0x0304,     /* TV.00-04 */
+    0x0005, 0x1006, 0x8E07, 0xE208, 0x0809,     /* TV.05-09 */
+    0x600A, 0x170B, 0x5C0C, 0x450D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xE812, 0x0D13,     /* TV.0F-13 */
+    0x9414, 0x1415, 0x3216, 0x8A17, 0x7C18,     /* TV.14-18 */
+    0x1619,                                     /* TV.19 */
+    0x031B, 0x011C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x851F, 0x0A20, 0x0521, 0x0422,     /* TV.1E-22 */
+    0x7423, 0x0024,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0xE44A, 0x504B, 0x044C, 0x004D, 0x004E,     /* TV.4A-4E */
+    0x404F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0x9750, 0xFF51, 0x3452, 0x9C53, 0x0354,     /* TV.50-54 */
+    0x0E55, 0xDE56, 0xBF57, 0x3558, 0xDD59,     /* TV.55-59 */
+    0x495A, 0x995B, 0xCE5C, 0x595D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x0C5E, 0x235F, 0x0760, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x1763, 0x0864,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1176,1024,1024,152, 1040,64,  925, 768, 768, 157, 779, 12
+};
+
+static u16 VT1622_N848x480_VF[] = {
+                                                
+    0x8400, 0x0001, 0x0002, 0x4403, 0x0304,     /* TV.00-04 */
+    0x0005, 0x1006, 0x8F07, 0xBE08, 0x0509,     /* TV.05-09 */
+    0x600A, 0x170B, 0x5C0C, 0x460D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xA712, 0x0D13,     /* TV.0F-13 */
+    0x6C14, 0x1C15, 0x8416, 0x8417, 0xF618,     /* TV.14-18 */
+    0x1A19,                                     /* TV.19 */
+    0x031B, 0x011C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x851F, 0x0D20, 0x0821, 0x0422,     /* TV.1E-22 */
+    0x7523, 0x0024,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0xDC4A, 0x504B, 0x004C, 0x004D, 0x004E,     /* TV.4A-4E */
+    0x404F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xEF50, 0x5151, 0x3352, 0x3653, 0x0254,     /* TV.50-54 */
+    0x3755, 0x3956, 0x9F57, 0x3458, 0xB759,     /* TV.55-59 */
+    0x125A, 0x575B, 0x2C5C, 0x585D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x525E, 0x1A5F, 0x0460, 0x0061, 0x0062,     /* TV.5E-62 */
+    0x3763, 0x0464,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1000,848, 848, 152, 856, 56,  567, 480, 480, 87,  485, 7
+};
+
+static u16 VT1622_N720x480_VF[] = {
+                                                
+    0x0400, 0x0001, 0x0002, 0x0203, 0x0304,     /* TV.00-04 */
+    0x0005, 0x1006, 0x6E07, 0xA008, 0x0F09,     /* TV.05-09 */
+    0x630A, 0x170B, 0x520C, 0x4A0D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0x8712, 0x0D13,     /* TV.0F-13 */
+    0x5C14, 0x1C15, 0x9A16, 0xF417, 0xA618,     /* TV.14-18 */
+    0x1F19,                                     /* TV.19 */
+    0x031B, 0x031C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x851F, 0x1120, 0x0821, 0x0422,     /* TV.1E-22 */
+    0x7523, 0x0024,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0xE44A, 0x694B, 0x044C, 0x004D, 0x004E,     /* TV.4A-4E */
+    0x404F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0x4750, 0xD151, 0x2352, 0x3E53, 0x0254,     /* TV.50-54 */
+    0x9755, 0xBF56, 0x8857, 0x2358, 0x9C59,     /* TV.55-59 */
+    0xE95A, 0x265B, 0xF55C, 0x165D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x625E, 0x175F, 0x0460, 0x0061, 0x0062,     /* TV.5E-62 */
+    0x9763, 0x0364,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    840, 720, 720, 120, 728, 48,  575, 480, 480, 95,  484, 15
+};
+
+static u16 VT1622_P640x480_VF[] = {
+                                                
+    0x0400, 0x0001, 0x0002, 0x8203, 0x0004,     /* TV.00-04 */
+    0x0005, 0x1006, 0x3E07, 0x9308, 0x3609,     /* Tv.05-09 */
+    0x740A, 0x000B, 0x480C, 0x540D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xE812, 0x2413,     /* TV.0F-13 */
+    0xFD14, 0x1C15, 0xBC16, 0x4617, 0x1E18,     /* TV.14-18 */
+    0x2D19,                                     /* TV.19 */
+    0x031B, 0x0A1C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x051F, 0x1520, 0x0C21, 0x0422,     /* TV.1E-22 */
+    0x7B23, 0x0024,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0xF94A, 0x504B, 0x044C, 0x004D, 0x004E,     /* TV.4A-4E */
+    0x484F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xE750, 0x8151, 0x2352, 0x3E53, 0x0254,     /* TV.50-54 */
+    0x2455, 0x5E56, 0x7657, 0x2358, 0x8959,     /* TV.55-59 */
+    0xC25A, 0x145B, 0x1C5C, 0x165D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0xAE5E, 0x3A5F, 0x0360, 0x0061, 0x0062,     /* TV.5E-62 */
+    0x9763, 0x0364,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1000,640, 640, 360, 680, 80,  575, 480, 480, 95,  501, 3
+};
+
+static u16 VT1622_P800x600_VF[] = {
+                                                
+    0x8400, 0x0001, 0x0002, 0xA003, 0x0004,     /* TV.00-04 */
+    0x0005, 0x1906, 0xA607, 0xBA08, 0x4709,     /* TV.05-09 */
+    0x720A, 0x000B, 0x570C, 0x510D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xE812, 0x2413,     /* TV.0F-13 */
+    0x3F14, 0x1D15, 0x6016, 0x9017, 0xC818,     /* TV.14-18 */
+    0x2319,                                     /* TV.19 */
+    0x031B, 0x031C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x851F, 0x1020, 0x0C21, 0x0422,     /* TV.1E-22 */
+    0x7B23, 0x0024,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0xE94A, 0x504B, 0x044C, 0x004D, 0x004E,     /* TV.4A-4E */
+    0x474F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xE750, 0x2151, 0x3352, 0xD453, 0x0254,     /* TV.50-54 */
+    0xF655, 0xFC56, 0x9557, 0x2358, 0xAE59,     /* TV.55-59 */
+    0xF55A, 0x595B, 0xB65C, 0x175D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0xA45E, 0x315F, 0x0460, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x8763, 0x0464,                             /* TV.63-64 */
+ 
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1000,800, 800, 200, 832, 80,  725, 600, 600, 125, 602, 1
+};
+
+static u16 VT1622_P1024x768_VF[] = {
+                                                
+    0x8400, 0x0001, 0x0002, 0xC403, 0x0004,     /* TV.00-04 */
+    0x0005, 0x1006, 0x9E07, 0xF808, 0x4309,     /* TV.05-09 */
+    0x5F0A, 0x000B, 0x4D0C, 0x430D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xE812, 0x2313,     /* TV.0F-13 */
+    0x9714, 0x1915, 0xB416, 0x7517, 0x4418,     /* TV.14-18 */
+    0x1B19,                                     /* TV.19 */
+    0x031B, 0x031C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x851F, 0x0920, 0x0C21, 0x0422,     /* TV.1E-22 */
+    0x7B23, 0x0024,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0xDD4A, 0x604B, 0x044C, 0x004D, 0x004E,     /* TV.4A-4E */ 
+    0x434F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xAF50, 0xFF51, 0x3452, 0x9C53, 0x0354,     /* TV.50-54 */
+    0x3355, 0xEA56, 0xC357, 0x3558, 0xE959,     /* TV.55-59 */
+    0x515A, 0x935B, 0x095C, 0x5A5D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0xEB5E, 0x165F, 0x0560, 0x0061, 0x0162,     /* TV.5E-62 */
+    0xEF63, 0x0664,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1200,1024,1024,176, 1040,72,  925, 768, 768, 157, 782, 13
+};
+
+static u16 VT1622_P848x480_VF[] = {
+                                                
+    0x8400, 0x0001, 0x0002, 0xC003, 0x0004,     /* TV.00-04 */
+    0x0005, 0x1006, 0x5707, 0xD108, 0x3E09,     /* TV.05-09 */
+    0x710A, 0x000B, 0x4E0C, 0x500D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xE512, 0x2A13,     /* TV.0F-13 */
+    0xFD14, 0x1415, 0x9316, 0x1317, 0xE618,     /* TV.14-18 */
+    0x2019,                                     /* TV.19 */
+    0x031B, 0x0B1C, 0x801D,                     /* TV.1B-1D */ 
+    0x001E, 0x841F, 0x0F20, 0x0C21, 0x0422,     /* TV.1E-22 */
+    0x7B23, 0x0024,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0xE74A, 0x454B, 0x044C, 0x004D, 0x004E,     /* TV.4A-4E */
+    0x464F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xAF50, 0x5151, 0x3452, 0x3E53, 0x0254,     /* TV.50-54 */
+    0x4F55, 0x3A56, 0xA257, 0x3458, 0xBE59,     /* TV.55-59 */
+    0x0B5A, 0x765B, 0x645C, 0x585D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0xAE5E, 0x1A5F, 0x0360, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x4F63, 0x0464,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1200,848, 848, 352, 856, 56,  575, 480, 480, 95,  495, 25
+};
+
+static u16 VT1622_P720x576_VF[] = {
+                                                
+    0x0400, 0x0001, 0x0002, 0xA603, 0x0004,     /* TV.00-04 */
+    0x0005, 0x1006, 0xDE07, 0xA308, 0x3609,     /* TV.05-09 */
+    0x6D0A, 0x000B, 0x570C, 0x4F0D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0x0512, 0x0713,     /* TV.0F-13 */
+    0x2114, 0x1015, 0xCB16, 0x8A17, 0x0918,     /* TV.14-18 */
+    0x2A19,                                     /* TV.19 */
+    0x031B, 0x021C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x841F, 0x1320, 0x0C21, 0x0422,     /* TV.1E-22 */
+    0x7B23, 0x4824,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0xE74A, 0x454B, 0x044C, 0x004D, 0x004E,     /* TV.4A-4E */
+    0x474F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xE750, 0xD151, 0x2352, 0xA253, 0x0254,     /* TV.50-54 */
+    0x5F55, 0x8556, 0x7E57, 0x2358, 0x9459,     /* TV.55-59 */
+    0xD05A, 0x275B, 0x8F5C, 0x165D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x525E, 0x7A5F, 0x0460, 0x0061, 0x0062,     /* TV.5E-62 */
+    0x3763, 0x0464,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1000,720, 720, 280, 776, 64,  675, 576, 576, 99,  602, 13
+};
+
+/* TV Overscan Table */
+
+static u16 VT1622_N640x480_VO[] = {
+                                                
+    0x0400, 0x0001, 0x0002, 0x0203, 0x0304,     /* TV.00-04 */
+    0x0005, 0x1006, 0x8F07, 0x6A08, 0x0009,     /* TV.05-09 */
+    0x6A0A, 0x170B, 0x520C, 0x500D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0x6812, 0x0D13,     /* TV.0F-13 */
+    0x5014, 0x1C15, 0x4516, 0x9917, 0x9918,     /* TV.14-18 */
+    0x2919,                                     /* TV.19 */
+    0x031B, 0x021C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x051F, 0x1220, 0x0C21, 0x0422,     /* TV.1E-22 */
+    0x7523, 0x0024,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0xC44A, 0x504B, 0x044C, 0x004D, 0x004E,     /* TV.4A-4E */
+    0x414F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0x1F50, 0x7F51, 0x2352, 0x0C53, 0x0254,     /* TV.50-54 */
+    0xBB55, 0x3256, 0x6757, 0x2258, 0x7659,     /* TV.55-59 */
+    0xB05A, 0xD25B, 0x2E5C, 0x055D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x005E, 0x8E5F, 0x0060, 0x0061, 0x0062,     /* TV.5E-62 */
+    0x1F63, 0x0364,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    800, 640, 640, 160, 656, 96,  525, 480, 480, 45,  495, 11
+};
+
+static u16 VT1622_N800x600_VO[] = {
+                                                
+    0x8400, 0x0001, 0x0002, 0x2403, 0x0304,     /* TV.00-04 */
+    0x0005, 0x1006, 0xA907, 0x8808, 0x0409,     /* TV.05-09 */
+    0x650A, 0x170B, 0x460C, 0x4C0D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xCA12, 0x0D13,     /* TV.0F-13 */
+    0x7C14, 0x1C15, 0xD116, 0x6217, 0x8C18,     /* TV.14-18 */
+    0x2119,                                     /* TV.19 */
+    0x031B, 0x031C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x841F, 0x0D20, 0x0A21, 0x0422,     /* TV.1E-22 */
+    0x7523, 0x0024,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0xE44A, 0x694B, 0x044C, 0x004D, 0x004E,     /* TV.4A-4E */
+    0x444F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xE750, 0x1F51, 0x3352, 0x8A53, 0x0254,     /* TV.50-54 */
+    0x6355, 0xB956, 0x8057, 0x2358, 0x9359,     /* TV.55-59 */
+    0xDC5A, 0x0B5B, 0x7D5C, 0x165D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0xF65E, 0x975F, 0x0460, 0x0061, 0x0162,     /* TV.5E-62 */
+    0xD763, 0x0464,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1000,800, 800, 200, 832, 96,  651, 600, 600, 51,  608, 12
+};
+
+static u16 VT1622_N1024x768_VO[] = {
+                                                
+    0x8400, 0x0001, 0x0002, 0x4403, 0x0304,     /* TV.00-04 */ 
+    0x0005, 0x1006, 0x5807, 0xC308, 0x0509,     /* TV.05-09 */
+    0x640A, 0x170B, 0x5C0C, 0x4D0D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xEA12, 0x0D13,     /* TV.0F-13 */
+    0xB014, 0x1C15, 0x8A16, 0xE817, 0xA218,     /* TV.14-18 */
+    0x1719,                                     /* TV.19 */
+    0x031B, 0x031C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x851F, 0x0A20, 0x0521, 0x0422,     /* TV.1E-22 */
+    0x7423, 0x0024,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0xE44A, 0x504B, 0x044C, 0x004D, 0x004E,     /* TV.4A-4E */
+    0x434F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0x5F50, 0xFF51, 0x3452, 0x3853, 0x0354,     /* TV.50-54 */
+    0xCF55, 0xDF56, 0xB657, 0x3458, 0xD259,     /* TV.55-59 */
+    0x395A, 0x815B, 0x405C, 0x595D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x495E, 0x225F, 0x0660, 0x0061, 0x0162,     /* TV.5E-62 */
+    0xDF63, 0x0664,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1120,1024,1024,96,  1040,40,  825, 768, 768, 57,  770, 6
+};
+
+static u16 VT1622_N848x480_VO[] = {
+                                                
+    0x8400, 0x0001, 0x0002, 0x4403, 0x0304,     /* TV.00-04 */
+    0x0005, 0x1006, 0x9607, 0xA708, 0x0809,     /* TV.05-09 */
+    0x5B0A, 0x170B, 0x460C, 0x400D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xE812, 0x3C13,     /* TV.0F-13 */
+    0x2D14, 0x2215, 0xA116, 0x6417, 0x9318,     /* TV.14-18 */
+    0x1B19,                                     /* TV.19 */
+    0x031B, 0x011C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x851F, 0x0D20, 0x0821, 0x0422,     /* TV.1E-22 */
+    0x7523, 0x0024,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0xDC4A, 0x504B, 0x004C, 0x004D, 0x004E,     /* TV.4A-4E */
+    0x404F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xEF50, 0x5151, 0x3352, 0x2553, 0x0254,     /* TV.50-54 */
+    0x1F55, 0x4D56, 0x9C57, 0x3458, 0xB559,     /* TV.55-59 */
+    0x0C5A, 0x3D5B, 0xF15C, 0x575D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x305E, 0x015F, 0x0460, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x1F63, 0x0464,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */ 
+    1008,848, 848, 160, 856, 72,  550, 480, 480, 70,  491, 5
+};
+
+static u16 VT1622_N720x480_VO[] = {
+                                                
+    0x0400, 0x0001, 0x0002, 0x0203, 0x0304,     /* TV.00-04 */
+    0x0005, 0x1006, 0x1807, 0x2808, 0x0909,     /* TV.05-09 */
+    0x5B0A, 0x170B, 0x460C, 0x410D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xEE12, 0x0D13,     /* TV.0F-13 */ 
+    0xA014, 0x3815, 0x1D16, 0x6617, 0x6618,     /* TV.14-18 */
+    0x2419,                                     /* TV.19 */
+    0x031B, 0x021C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x851F, 0x1120, 0x0821, 0x0422,     /* TV.1E-22 */
+    0x7523, 0x0024,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0xE44A, 0x694B, 0x044C, 0x004D, 0x004E,     /* TV.4A-4E */
+    0x404F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0x1F50, 0xCF51, 0x2352, 0x0C53, 0x0254,     /* TV.50-54 */
+    0x1F55, 0xCE56, 0x7657, 0x2358, 0x8859,     /* TV.55-59 */
+    0xC95A, 0xEF5B, 0xFF5C, 0x055D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x005E, 0x005F, 0x0060, 0x0061, 0x0062,     /* TV.5E-62 */
+    0x1F63, 0x0364,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    800, 720, 720, 80,  728, 32,  525, 480, 480, 45,  482, 1
+};
+
+static u16 VT1622_P640x480_VO[] = {
+                                                
+    0x0400, 0x0001, 0x0002, 0x8203, 0x0004,     /* TV.00-04 */
+    0x0005, 0x1006, 0xCA07, 0x7D08, 0x3109,     /* Tv.05-09 */
+    0x7A0A, 0x000B, 0x480C, 0x580D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0x4A12, 0x0713,     /* TV.0F-13 */
+    0x3714, 0x2415, 0xC016, 0xD917, 0x7118,     /* TV.14-18 */
+    0x3219,                                     /* TV.19 */
+    0x031B, 0x021C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x051F, 0x1520, 0x0C21, 0x0422,     /* TV.1E-22 */
+    0x7B23, 0x0024,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0xF94A, 0x7F4B, 0x234C, 0xF34D, 0x014E,     /* TV.4A-4E */
+    0xCF4F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xE750, 0x7F51, 0x2352, 0xF353, 0x0154,     /* TV.50-54 */
+    0xCF55, 0x3F56, 0x6957, 0x2258, 0x7A59,     /* TV.55-59 */
+    0xAD5A, 0xF85B, 0x765C, 0x055D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x335E, 0x705F, 0x0360, 0x0061, 0x0062,     /* TV.5E-62 */
+    0x1F63, 0x0364,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1000,640, 640, 360, 800, 120, 500, 480, 480, 20,  485, 6
+};
+
+static u16 VT1622_P800x600_VO[] = {
+                                                
+    0x8400, 0x0001, 0x0002, 0xA003, 0x0004,     /* TV.00-04 */
+    0x0005, 0x1906, 0x8007, 0xA608, 0x3609,     /* TV.05-09 */
+    0x770A, 0x000B, 0x570C, 0x540D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xED12, 0x1513,     /* TV.0F-13 */
+    0x1E14, 0x3115, 0x5016, 0x6317, 0xD518,     /* TV.14-18 */
+    0x2519,                                     /* TV.19 */
+    0x031B, 0x031C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x851F, 0x1020, 0x0C21, 0x0422,     /* TV.1E-22 */
+    0x7B23, 0x0024,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0xE94A, 0x504B, 0x044C, 0x004D, 0x004E,     /* TV.4A-4E */
+    0x474F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xE750, 0x1F51, 0x3352, 0x8953, 0x0254,     /* TV.50-54 */
+    0xBF55, 0x0056, 0x8D57, 0x3358, 0xA559,     /* TV.55-59 */
+    0xE85A, 0x475B, 0x4B5C, 0x175D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x295E, 0x285F, 0x0460, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x0F63, 0x0464,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1000,800, 800, 200, 872, 56,  650, 600, 600, 50,  608, 12
+};
+
+static u16 VT1622_P1024x768_VO[] = {
+                                                
+    0x8400, 0x0001, 0x0002, 0xC003, 0x0004,     /* TV.00-04 */
+    0x0005, 0x1006, 0x7107, 0xD108, 0x3809,     /* TV.05-09 */
+    0x770A, 0x000B, 0x4E0C, 0x520D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xC912, 0x0A13,     /* TV.0F-13 */
+    0x7914, 0x1C15, 0x3816, 0x0E17, 0x7B18,     /* TV.14-18 */
+    0x1D19,                                     /* TV.19 */
+    0x031B, 0x031C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x851F, 0x0C20, 0x0C21, 0x0422,     /* TV.1E-22 */
+    0x7B23, 0x0024,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0xDD4A, 0x604B, 0x044C, 0x004D, 0x004E,     /* TV.4A-4E */
+    0x474F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xAF50, 0xFF51, 0x3452, 0x3853, 0x0354,     /* TV.50-54 */
+    0xCF55, 0xE356, 0xB457, 0x3458, 0xD459,     /* TV.55-59 */
+    0x2B5A, 0xA05B, 0x5E5C, 0x595D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x485E, 0x205F, 0x0560, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x2F63, 0x0664,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1200,1024,1024,176, 1088,56,  825, 768, 768, 57,  771, 5
+};
+
+static u16 VT1622_P848x480_VO[] = {
+                                                
+    0x8400, 0x0001, 0x0002, 0xC003, 0x0004,     /* TV.00-04 */
+    0x0005, 0x1006, 0x4707, 0xA808, 0x3909,     /* TV.05-09 */
+    0x640A, 0x000B, 0x4E0C, 0x460D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xEA12, 0x1513,     /* TV.0F-13 */
+    0xF214, 0x2815, 0xEC16, 0xE517, 0x6418,     /* TV.14-18 */
+    0x2219,                                     /* TV.19 */
+    0x031B, 0x0B1C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x841F, 0x0F20, 0x0C21, 0x0422,     /* TV.1E-22 */
+    0x7B23, 0x0024,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0xE74A, 0x454B, 0x044C, 0x004D, 0x004E,     /* TV.4A-4E */
+    0x434F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xAF50, 0x4F51, 0x3452, 0x2553, 0x0254,     /* TV.50-54 */
+    0x1F55, 0x4F56, 0x9B57, 0x3458, 0xB759,     /* TV.55-59 */
+    0x0A5A, 0x3F5B, 0xF05C, 0x575D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x855E, 0x005F, 0x0360, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x1F63, 0x0464,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1200,848, 848, 352, 872, 176, 550, 480, 480, 70,  491, 5
+};
+
+static u16 VT1622_P720x576_VO[] = {
+                                                
+    0x0400, 0x0001, 0x0002, 0xA603, 0x0004,     /* TV.00-04 */
+    0x0005, 0x1006, 0x1007, 0x7D08, 0x3209,     /* TV.05-09 */
+    0x600A, 0x000B, 0x570C, 0x460D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xEC12, 0x1513,     /* TV.0F-13 */
+    0xDC14, 0x2815, 0x2D16, 0x7717, 0x6618,     /* TV.14-18 */
+    0x2D19,                                     /* TV.19 */
+    0x031B, 0x0A1C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x841F, 0x1320, 0x0C21, 0x0422,     /* TV.1E-22 */
+    0x7B23, 0x4824,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0xE74A, 0x454B, 0x044C, 0x004D, 0x004E,     /* TV.4A-4E */
+    0x454F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xE750, 0xCF51, 0x2352, 0x5753, 0x0254,     /* TV.50-54 */
+    0x1F55, 0x8056, 0x7557, 0x2358, 0x8959,     /* TV.55-59 */
+    0xC75A, 0xF15B, 0xFF5C, 0x055D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */ 
+    0xD75E, 0x805F, 0x0360, 0x0061, 0x0062,     /* TV.5E-62 */
+    0xBF63, 0x0364,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1000,720, 720, 280, 728, 48,  600, 576, 576, 24,  577, 3
+};
+
+/***********************************/
+/* VT1622 output RGB Table         */
+/***********************************/
+
+/* NTSC */
+
+static u16 VT1622_N640x480_RGB_VN[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N800x600_RGB_VN[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N1024x768_RGB_VN[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N848x480_RGB_VN[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N720x480_RGB_VN[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N640x480_RGB_VF[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N800x600_RGB_VF[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N1024x768_RGB_VF[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N848x480_RGB_VF[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N720x480_RGB_VF[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N640x480_RGB_VO[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N800x600_RGB_VO[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N1024x768_RGB_VO[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N848x480_RGB_VO[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N720x480_RGB_VO[] = {
+    0xFFFF                      /* End symbol */
+};
+
+/* PAL */
+
+static u16 VT1622_P640x480_RGB_VN[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P800x600_RGB_VN[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P1024x768_RGB_VN[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P848x480_RGB_VN[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P720x576_RGB_VN[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P640x480_RGB_VF[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P800x600_RGB_VF[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P1024x768_RGB_VF[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P848x480_RGB_VF[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P720x576_RGB_VF[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P640x480_RGB_VO[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P800x600_RGB_VO[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P1024x768_RGB_VO[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P848x480_RGB_VO[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P720x576_RGB_VO[] = {
+    0xFFFF                      /* End symbol */
+};
+
+/***********************************/
+/* VT1622 output YPBPR Table       */
+/***********************************/
+
+/* NTSC */
+
+static u16 VT1622_N640x480_YPBPR_VN[] = {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N800x600_YPBPR_VN[] = {
+    0x0302,                     /* output YPBPR type */
+    0x4365, 0x4A66, 0x4967,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N1024x768_YPBPR_VN[] = {
+    0x0302,                     /* output YPBPR type */
+    0x5865, 0x4B66, 0x4A67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N848x480_YPBPR_VN[] = {
+    0x0302,                     /* output YPBPR type */
+    0x4465, 0x4566, 0x4567,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+
+};
+
+static u16 VT1622_N720x480_YPBPR_VN[] = {
+    0x0302,                     /* output YPBPR type */
+    0x4265, 0x4966, 0x4867,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N640x480_YPBPR_VF[] = {
+    0x0302,                     /* output YPBPR type */
+    0x4F65, 0x4966, 0x4967,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N800x600_YPBPR_VF[] = {
+    0x0302,                     /* output YPBPR type */
+    0x4265, 0x4566, 0x4567,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N1024x768_YPBPR_VF[] = {
+    0x0302,                     /* output YPBPR type */
+    0x5765, 0x4566, 0x4567,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N848x480_YPBPR_VF[] = {
+    0x0302,                     /* output YPBPR type */
+    0x5865, 0x4566, 0x4567,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N720x480_YPBPR_VF[] = {
+    0x0302,                     /* output YPBPR type */
+    0x4D65, 0x4966, 0x4967,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N640x480_YPBPR_VO[] = {
+    0x0302,                     /* output YPBPR type */
+    0x4B65, 0x4866, 0x4867,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N800x600_YPBPR_VO[] = {
+    0x0302,                     /* output YPBPR type */
+    0x4265, 0x4566, 0x4567,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N1024x768_YPBPR_VO[] = {
+    0x0302,                     /* output YPBPR type */
+    0x5765, 0x4566, 0x4567,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N848x480_YPBPR_VO[] = {
+    0x0302,                     /* output YPBPR type */
+    0x5865, 0x4566, 0x4567,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N720x480_YPBPR_VO[] = {
+    0x0302,                     /* output YPBPR type */
+    0x4D65, 0x4966, 0x4967,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+/* PAL */
+
+static u16 VT1622_P640x480_YPBPR_VN[] = {
+    0x0302,                     /* output YPBPR type */
+    0x4265, 0x4966, 0x4967,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P800x600_YPBPR_VN[] = {
+    0x0302,                     /* output YPBPR type */
+    0x5865, 0x5E66, 0x5E67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P1024x768_YPBPR_VN[] = {
+    0x0302,                     /* output YPBPR type */
+    0x5165, 0x4966, 0x4967,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P848x480_YPBPR_VN[] = {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4966, 0x4967,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P720x576_YPBPR_VN[] = {
+    0x0302,                     /* output YPBPR type */
+    0x5965, 0x4D66, 0x4A67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P640x480_YPBPR_VF[] = {
+    0x0302,                     /* output YPBPR type */
+    0x4265, 0x4966, 0x4967,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P800x600_YPBPR_VF[] = {
+    0x0302,                     /* output YPBPR type */
+    0x5865, 0x4866, 0x4867,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P1024x768_YPBPR_VF[] = { 
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x6966, 0x6967,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P848x480_YPBPR_VF[] = {
+    0x0302,                     /* output YPBPR type */
+    0x4E65, 0x4966, 0x4967,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P720x576_YPBPR_VF[] = {
+    0x0302,                     /* output YPBPR type */
+    0x5865, 0x4866, 0x4967,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P640x480_YPBPR_VO[] = {
+    0x0302,                     /* output YPBPR type */
+    0x4265, 0x4966, 0x4967,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P800x600_YPBPR_VO[] = {
+    0x0302,                     /* output YPBPR type */
+    0x5865, 0x4866, 0x4867,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P1024x768_YPBPR_VO[] = {
+    0x0302,                     /* output YPBPR type */
+    0x5165, 0x4966, 0x4967,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P848x480_YPBPR_VO[] = {
+    0x0302,                     /* output YPBPR type */
+    0x4E65, 0x4966, 0x4967,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P720x576_YPBPR_VO[] = {
+    0x0302,                     /* output YPBPR type */
+    0x5865, 0x4866, 0x4967,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+/***********************************/
+/* VT1622 output SDTV_RGB Table    */
+/***********************************/
+
+/* NTSC */
+
+static u16 VT1622_N640x480_SDTV_RGB_VN[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N800x600_SDTV_RGB_VN[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N1024x768_SDTV_RGB_VN[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N848x480_SDTV_RGB_VN[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N720x480_SDTV_RGB_VN[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N640x480_SDTV_RGB_VF[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N800x600_SDTV_RGB_VF[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N1024x768_SDTV_RGB_VF[]={
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N848x480_SDTV_RGB_VF[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N720x480_SDTV_RGB_VF[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N640x480_SDTV_RGB_VO[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N800x600_SDTV_RGB_VO[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N1024x768_SDTV_RGB_VO[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N848x480_SDTV_RGB_VO[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N720x480_SDTV_RGB_VO[] = {
+    0xFFFF                      /* End symbol */
+};
+
+/* PAL */
+
+static u16 VT1622_P640x480_SDTV_RGB_VN[] = {
+    0xFFFF                      /* End symbol */
+
+};
+
+static u16 VT1622_P800x600_SDTV_RGB_VN[] = {
+    0xFFFF                      /* End symbol */
+
+};
+
+static u16 VT1622_P1024x768_SDTV_RGB_VN[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P848x480_SDTV_RGB_VN[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P720x576_SDTV_RGB_VN[] = {
+    0xFFFF                      /* End symbol */
+
+};
+
+static u16 VT1622_P640x480_SDTV_RGB_VF[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P800x600_SDTV_RGB_VF[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P1024x768_SDTV_RGB_VF[] = {
+    0xFFFF                      /* End symbol */
+
+};
+
+static u16 VT1622_P848x480_SDTV_RGB_VF[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P720x576_SDTV_RGB_VF[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P640x480_SDTV_RGB_VO[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P800x600_SDTV_RGB_VO[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P1024x768_SDTV_RGB_VO[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P848x480_SDTV_RGB_VO[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P720x576_SDTV_RGB_VO[] = {
+    0xFFFF                      /* End symbol */
+};
+
+/***********************************/
+/* VT1622 output SDTV_YPBPR Table  */
+/***********************************/
+
+/* NTSC */
+
+static u16 VT1622_N640x480_SDTV_YPBPR_VN[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N800x600_SDTV_YPBPR_VN[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N1024x768_SDTV_YPBPR_VN[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N848x480_SDTV_YPBPR_VN[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N720x480_SDTV_YPBPR_VN[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N640x480_SDTV_YPBPR_VF[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N800x600_SDTV_YPBPR_VF[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N1024x768_SDTV_YPBPR_VF[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N848x480_SDTV_YPBPR_VF[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N720x480_SDTV_YPBPR_VF[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N640x480_SDTV_YPBPR_VO[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N800x600_SDTV_YPBPR_VO[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N1024x768_SDTV_YPBPR_VO[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N848x480_SDTV_YPBPR_VO[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N720x480_SDTV_YPBPR_VO[] = {
+    0xFFFF                      /* End symbol */
+};
+
+/* PAL */
+
+static u16 VT1622_P640x480_SDTV_YPBPR_VN[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P800x600_SDTV_YPBPR_VN[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P1024x768_SDTV_YPBPR_VN[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P848x480_SDTV_YPBPR_VN[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P720x576_SDTV_YPBPR_VN[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P640x480_SDTV_YPBPR_VF[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P800x600_SDTV_YPBPR_VF[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P1024x768_SDTV_YPBPR_VF[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P848x480_SDTV_YPBPR_VF[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P720x576_SDTV_YPBPR_VF[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P640x480_SDTV_YPBPR_VO[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P800x600_SDTV_YPBPR_VO[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P1024x768_SDTV_YPBPR_VO[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P848x480_SDTV_YPBPR_VO[] = {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P720x576_SDTV_YPBPR_VO[] = {
+    0xFFFF                      /* End symbol */
+};
+
+/***********************************/
+/* VT1622 DeDotCrawl Table         */
+/***********************************/
+
+/* NTSC */
+
+static u16 VT1622_N640x480_DeDotCrawl_VN[] = {
+    0x0811,                     /* Enable DeDotCrawl (only update bit3 of TV.11h register) */
+    0xD516, 0x8D17,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N800x600_DeDotCrawl_VN[] = {
+    0x0811,                     /* Enable DeDotCrawl (only update bit3 of TV.11h register) */
+    0xA116, 0x5917,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N1024x768_DeDotCrawl_VN[] = {
+    0x0811,                     /* Enable DeDotCrawl (only update bit3 of TV.11h register) */
+    0x1116, 0xE217,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N848x480_DeDotCrawl_VN[] = {
+    0x0811,                     /* Enable DeDotCrawl (only update bit3 of TV.11h register) */
+    0x5B16, 0xA017,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N720x480_DeDotCrawl_VN[] = {
+    0x0811,                     /* Enable DeDotCrawl (only update bit3 of TV.11h register) */
+    0xC316, 0x4C17,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N640x480_DeDotCrawl_VF[] = {
+    0x0811,                     /* Enable DeDotCrawl (only update bit3 of TV.11h register) */
+    0x5016, 0x7B17,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N800x600_DeDotCrawl_VF[] = {
+    0x0811,                     /* Enable DeDotCrawl (only update bit3 of TV.11h register) */
+    0xD116, 0xF617,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N1024x768_DeDotCrawl_VF[] = {
+    0x0811,                     /* Enable DeDotCrawl (only update bit3 of TV.11h register) */
+    0x0616, 0x8417,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N848x480_DeDotCrawl_VF[] = {
+    0x0811,                     /* Enable DeDotCrawl (only update bit3 of TV.11h register) */
+    0x1C16, 0x7D17,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N720x480_DeDotCrawl_VF[] = {
+    0x0811,                     /* Enable DeDotCrawl (only update bit3 of TV.11h register) */
+    0xE816, 0xEB17,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N640x480_DeDotCrawl_VO[] = {
+    0x0811,                     /* Enable DeDotCrawl (only update bit3 of TV.11h register) */
+    0xD516, 0x8D17,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N800x600_DeDotCrawl_VO[] = {
+    0x0811,                     /* Enable DeDotCrawl (only update bit3 of TV.11h register) */
+    0x1416, 0xC717,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N1024x768_DeDotCrawl_VO[] = {
+    0x0811,                     /* Enable DeDotCrawl (only update bit3 of TV.11h register) */
+    0x6316, 0x3D17,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N848x480_DeDotCrawl_VO[] = {
+    0x0811,                     /* Enable DeDotCrawl (only update bit3 of TV.11h register) */
+    0x6716, 0x3017,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N720x480_DeDotCrawl_VO[] = {
+    0x0811,                     /* Enable DeDotCrawl (only update bit3 of TV.11h register) */
+    0x1E16, 0x5C17,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+
+static vt1622_func_table vt1622_ntsc_640x480_tbl[] = {
+    {TV_BASE_FUNC,         VT1622_N640x480_VN,            VT1622_N640x480_VF,            VT1622_N640x480_VO},
+    {TV_RGB_FUNC,          VT1622_N640x480_RGB_VN,        VT1622_N640x480_RGB_VF,        VT1622_N640x480_RGB_VO},
+    {TV_YPBPR_FUNC,        VT1622_N640x480_YPBPR_VN,      VT1622_N640x480_YPBPR_VF,      VT1622_N640x480_YPBPR_VO},
+    {TV_SDTV_RGB_FUNC,     VT1622_N640x480_SDTV_RGB_VN,   VT1622_N640x480_SDTV_RGB_VF,   VT1622_N640x480_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1622_N640x480_SDTV_YPBPR_VN, VT1622_N640x480_SDTV_YPBPR_VF, VT1622_N640x480_SDTV_YPBPR_VO},
+    {TV_DeDotCrawl_FUNC,   VT1622_N640x480_DeDotCrawl_VN, VT1622_N640x480_DeDotCrawl_VF, VT1622_N640x480_DeDotCrawl_VO}
+
+};
+
+static vt1622_func_table vt1622_ntsc_800x600_tbl[] = {
+    {TV_BASE_FUNC,         VT1622_N800x600_VN,            VT1622_N800x600_VF,            VT1622_N800x600_VO},
+    {TV_RGB_FUNC,          VT1622_N800x600_RGB_VN,        VT1622_N800x600_RGB_VF,        VT1622_N800x600_RGB_VO},
+    {TV_YPBPR_FUNC,        VT1622_N800x600_YPBPR_VN,      VT1622_N800x600_YPBPR_VF,      VT1622_N800x600_YPBPR_VO},
+    {TV_SDTV_RGB_FUNC,     VT1622_N800x600_SDTV_RGB_VN,   VT1622_N800x600_SDTV_RGB_VF,   VT1622_N800x600_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1622_N800x600_SDTV_YPBPR_VN, VT1622_N800x600_SDTV_YPBPR_VF, VT1622_N800x600_SDTV_YPBPR_VO},
+    {TV_DeDotCrawl_FUNC,   VT1622_N800x600_DeDotCrawl_VN, VT1622_N800x600_DeDotCrawl_VF, VT1622_N800x600_DeDotCrawl_VO}
+};
+
+static vt1622_func_table vt1622_ntsc_1024x768_tbl[]= {
+    {TV_BASE_FUNC,         VT1622_N1024x768_VN,            VT1622_N1024x768_VF,            VT1622_N1024x768_VO},
+    {TV_RGB_FUNC,          VT1622_N1024x768_RGB_VN,        VT1622_N1024x768_RGB_VF,        VT1622_N1024x768_RGB_VO},
+    {TV_YPBPR_FUNC,        VT1622_N1024x768_YPBPR_VN,      VT1622_N1024x768_YPBPR_VF,      VT1622_N1024x768_YPBPR_VO},
+    {TV_SDTV_RGB_FUNC,     VT1622_N1024x768_SDTV_RGB_VN,   VT1622_N1024x768_SDTV_RGB_VF,   VT1622_N1024x768_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1622_N1024x768_SDTV_YPBPR_VN, VT1622_N1024x768_SDTV_YPBPR_VF, VT1622_N1024x768_SDTV_YPBPR_VO},
+    {TV_DeDotCrawl_FUNC,   VT1622_N1024x768_DeDotCrawl_VN, VT1622_N1024x768_DeDotCrawl_VF, VT1622_N1024x768_DeDotCrawl_VO}
+};
+
+static vt1622_func_table vt1622_ntsc_848x480_tbl[] = {
+    {TV_BASE_FUNC,         VT1622_N848x480_VN,             VT1622_N848x480_VF,             VT1622_N848x480_VO},
+    {TV_RGB_FUNC,          VT1622_N848x480_RGB_VN,         VT1622_N848x480_RGB_VF,         VT1622_N848x480_RGB_VO},
+    {TV_YPBPR_FUNC,        VT1622_N848x480_YPBPR_VN,       VT1622_N848x480_YPBPR_VF,       VT1622_N848x480_YPBPR_VO},
+    {TV_SDTV_RGB_FUNC,     VT1622_N848x480_SDTV_RGB_VN,    VT1622_N848x480_SDTV_RGB_VF,    VT1622_N848x480_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1622_N848x480_SDTV_YPBPR_VN,  VT1622_N848x480_SDTV_YPBPR_VF,  VT1622_N848x480_SDTV_YPBPR_VO},
+    {TV_DeDotCrawl_FUNC,   VT1622_N848x480_DeDotCrawl_VN,  VT1622_N848x480_DeDotCrawl_VF,  VT1622_N848x480_DeDotCrawl_VO}
+};
+
+static vt1622_func_table vt1622_ntsc_720x480_tbl[] = {
+    {TV_BASE_FUNC,         VT1622_N720x480_VN,             VT1622_N720x480_VF,             VT1622_N720x480_VO},
+    {TV_RGB_FUNC,          VT1622_N720x480_RGB_VN,         VT1622_N720x480_RGB_VF,         VT1622_N720x480_RGB_VO},
+    {TV_YPBPR_FUNC,        VT1622_N720x480_YPBPR_VN,       VT1622_N720x480_YPBPR_VF,       VT1622_N720x480_YPBPR_VO},
+    {TV_SDTV_RGB_FUNC,     VT1622_N720x480_SDTV_RGB_VN,    VT1622_N720x480_SDTV_RGB_VF,    VT1622_N720x480_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1622_N720x480_SDTV_YPBPR_VN,  VT1622_N720x480_SDTV_YPBPR_VF,  VT1622_N720x480_SDTV_YPBPR_VO},
+    {TV_DeDotCrawl_FUNC,   VT1622_N720x480_DeDotCrawl_VN,  VT1622_N720x480_DeDotCrawl_VF,  VT1622_N720x480_DeDotCrawl_VO}
+};
+
+static vt1622_func_table vt1622_pal_640x480_tbl[] = {
+    {TV_BASE_FUNC,         VT1622_P640x480_VN,             VT1622_P640x480_VF,             VT1622_P640x480_VO},
+    {TV_RGB_FUNC,          VT1622_P640x480_RGB_VN,         VT1622_P640x480_RGB_VF,         VT1622_P640x480_RGB_VO},
+    {TV_YPBPR_FUNC,        VT1622_P640x480_YPBPR_VN,       VT1622_P640x480_YPBPR_VF,       VT1622_P640x480_YPBPR_VO},
+    {TV_SDTV_RGB_FUNC,     VT1622_P640x480_SDTV_RGB_VN,    VT1622_P640x480_SDTV_RGB_VF,    VT1622_P640x480_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1622_P640x480_SDTV_YPBPR_VN,  VT1622_P640x480_SDTV_YPBPR_VF,  VT1622_P640x480_SDTV_YPBPR_VO}
+};
+
+static vt1622_func_table vt1622_pal_800x600_tbl[] = {
+    {TV_BASE_FUNC,         VT1622_P800x600_VN,             VT1622_P800x600_VF,             VT1622_P800x600_VO},
+    {TV_RGB_FUNC,          VT1622_P800x600_RGB_VN,         VT1622_P800x600_RGB_VF,         VT1622_P800x600_RGB_VO},
+    {TV_YPBPR_FUNC,        VT1622_P800x600_YPBPR_VN,       VT1622_P800x600_YPBPR_VF,       VT1622_P800x600_YPBPR_VO},
+    {TV_SDTV_RGB_FUNC,     VT1622_P800x600_SDTV_RGB_VN,    VT1622_P800x600_SDTV_RGB_VF,    VT1622_P800x600_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1622_P800x600_SDTV_YPBPR_VN,  VT1622_P800x600_SDTV_YPBPR_VF,  VT1622_P800x600_SDTV_YPBPR_VO}
+};
+
+static vt1622_func_table vt1622_pal_1024x768_tbl[] = {
+    {TV_BASE_FUNC,         VT1622_P1024x768_VN,             VT1622_P1024x768_VF,             VT1622_P1024x768_VO},
+    {TV_RGB_FUNC,          VT1622_P1024x768_RGB_VN,         VT1622_P1024x768_RGB_VF,         VT1622_P1024x768_RGB_VO},
+    {TV_YPBPR_FUNC,        VT1622_P1024x768_YPBPR_VN,       VT1622_P1024x768_YPBPR_VF,       VT1622_P1024x768_YPBPR_VO},
+    {TV_SDTV_RGB_FUNC,     VT1622_P1024x768_SDTV_RGB_VN,    VT1622_P1024x768_SDTV_RGB_VF,    VT1622_P1024x768_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1622_P1024x768_SDTV_YPBPR_VN,  VT1622_P1024x768_SDTV_YPBPR_VF,  VT1622_P1024x768_SDTV_YPBPR_VO}
+};
+
+static vt1622_func_table vt1622_pal_848x480_tbl[] = {
+    {TV_BASE_FUNC,         VT1622_P848x480_VN,             VT1622_P848x480_VF,             VT1622_P848x480_VO},
+    {TV_RGB_FUNC,          VT1622_P848x480_RGB_VN,         VT1622_P848x480_RGB_VF,         VT1622_P848x480_RGB_VO},
+    {TV_YPBPR_FUNC,        VT1622_P848x480_YPBPR_VN,       VT1622_P848x480_YPBPR_VF,       VT1622_P848x480_YPBPR_VO},
+    {TV_SDTV_RGB_FUNC,     VT1622_P848x480_SDTV_RGB_VN,    VT1622_P848x480_SDTV_RGB_VF,    VT1622_P848x480_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1622_P848x480_SDTV_YPBPR_VN,  VT1622_P848x480_SDTV_YPBPR_VF,  VT1622_P848x480_SDTV_YPBPR_VO}
+};
+
+static vt1622_func_table vt1622_pal_720x576_tbl[] = {
+    {TV_BASE_FUNC,         VT1622_P720x576_VN,             VT1622_P720x576_VF,             VT1622_P720x576_VO},
+    {TV_RGB_FUNC,          VT1622_P720x576_RGB_VN,         VT1622_P720x576_RGB_VF,         VT1622_P720x576_RGB_VO},
+    {TV_YPBPR_FUNC,        VT1622_P720x576_YPBPR_VN,       VT1622_P720x576_YPBPR_VF,       VT1622_P720x576_YPBPR_VO},
+    {TV_SDTV_RGB_FUNC,     VT1622_P720x576_SDTV_RGB_VN,    VT1622_P720x576_SDTV_RGB_VF,    VT1622_P720x576_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1622_P720x576_SDTV_YPBPR_VN,  VT1622_P720x576_SDTV_YPBPR_VF,  VT1622_P720x576_SDTV_YPBPR_VO}
+};
+
+
+static struct vt1622_table vt1622_tbl[] = {
+    {VIA_RES_640X480,             vt1622_ntsc_640x480_tbl,    vt1622_pal_640x480_tbl},
+    {VIA_RES_800X600,             vt1622_ntsc_800x600_tbl,    vt1622_pal_800x600_tbl},
+    {VIA_RES_1024X768,            vt1622_ntsc_1024x768_tbl,   vt1622_pal_1024x768_tbl},
+    {VIA_RES_848X480,             vt1622_ntsc_848x480_tbl,    vt1622_pal_848x480_tbl},
+    {VIA_RES_720X480,             vt1622_ntsc_720x480_tbl,    vt1622_ntsc_720x480_tbl},
+    {VIA_RES_720X576,             vt1622_pal_720x576_tbl,     vt1622_pal_720x576_tbl}
+};
+
+#define NUM_TOTAL_VT1622_TABLE ARRAY_SIZE(vt1622_tbl)
+
+#endif /* __TBL1622_H__ */
diff -Nur linux-2.6.21-rc7/drivers/video/via/tbl1636.h linux-2.6.21-rc7.viafb/drivers/video/via/tbl1636.h
--- linux-2.6.21-rc7/drivers/video/via/tbl1636.h 1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/tbl1636.h 2007-04-26 19:52:32.000000000 -0400
@@ -0,0 +1,82 @@
+ /*
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
+
+#ifndef _TBL1636_H_
+#define _TBL1636_H_ 1
+
+#include "hw.h"
+
+
+struct IODATA COMMON_INIT_TBL_VT1636[] = {
+/*  Index, Mask, Value */
+    {0x10, 0xC0, 0x00},     /* Set panel power sequence timing */
+    {0x0B, 0xFF, 0x40},     /* T1: VDD on - Data on. Each increment is 1 ms. (50ms = 031h)*/
+    {0x0C, 0xFF, 0x31},     /* T2: Data on - Backlight on. Each increment is 2 ms. (210ms = 068h) */
+    {0x0D, 0xFF, 0x31},     /* T3: Backlight off - Data off. Each increment is 2 ms. (210ms = 068h) */
+    {0x0E, 0xFF, 0x68},     /* T4: Data off - VDD off. Each increment is 1 ms. (50ms = 031h) */
+    {0x0F, 0xFF, 0x68},     /* T5: VDD off - VDD on. Each increment is 100 ms. (500ms = 04h) */
+    {0x09, 0xA0, 0xA0},     /* LVDS output power up */
+    {0x10, 0x33, 0x13}      /* turn on back light */
+};
+
+
+struct IODATA DUAL_CHANNEL_ENABLE_TBL_VT1636[] = {
+/*  Index, Mask, Value */
+    {0x08,  0xF0, 0xE0}      /* Input Data Mode Select */
+};
+
+
+struct IODATA SINGLE_CHANNEL_ENABLE_TBL_VT1636[] = {
+/*  Index, Mask, Value */
+    {0x08,  0xF0, 0x00}      /* Input Data Mode Select */
+};
+
+
+struct IODATA DITHERING_ENABLE_TBL_VT1636[] = {
+/*  Index, Mask, Value */
+    {0x0A,  0x70, 0x50}
+};
+
+
+struct IODATA DITHERING_DISABLE_TBL_VT1636[] = {
+/*  Index, Mask, Value */
+    {0x0A,  0x70, 0x00}
+};
+
+
+struct IODATA VDD_ON_TBL_VT1636[] = {
+/*  Index, Mask, Value */
+    {0x10,  0x20, 0x20}
+};
+
+
+struct IODATA VDD_OFF_TBL_VT1636[] = {
+/*  Index, Mask, Value */
+    {0x10,  0x20, 0x00}
+};
+
+
+#endif  /* _VIA_TBL1636_H_ */
+
diff -Nur linux-2.6.21-rc7/drivers/video/via/tblDPASetting.h linux-2.6.21-rc7.viafb/drivers/video/via/tblDPASetting.h
--- linux-2.6.21-rc7/drivers/video/via/tblDPASetting.h 1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/tblDPASetting.h 2007-04-26 19:52:32.000000000 -0400
@@ -0,0 +1,107 @@
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
+struct VT1636_DPA_SETTING VT1636_DPA_SETTING_TBL_VT3324[] = {
+     /* Panel ID,       CLK_SEL_ST1[09],    CLK_SEL_ST2[08] */
+    {LCD_PANEL_ID0_640X480,      0x00,               0x00},          /* For 640x480   */
+    {LCD_PANEL_ID1_800X600,      0x00,               0x00},          /* For 800x600   */
+    {LCD_PANEL_ID2_1024X768,     0x00,               0x00},          /* For 1024x768  */
+    {LCD_PANEL_ID3_1280X768,     0x00,               0x00},          /* For 1280x768  */
+    {LCD_PANEL_ID4_1280X1024,    0x00,               0x00},          /* For 1280x1024 */
+    {LCD_PANEL_ID5_1400X1050,    0x00,               0x00},          /* For 1400x1050 */
+    {LCD_PANEL_ID6_1600X1200,    0x0B,               0x03}           /* For 1600x1200 */
+};
+
+struct GFX_DPA_SETTING GFX_DPA_SETTING_TBL_VT3324[] = {
+    /*  ClkRange,            DVP0, DVP0DataDriving,  DVP0ClockDriving, DVP1, DVP1Driving, DFPHigh,   DFPLow */
+    /*                       CR96, SR2A[5], SR1B[1], SR2A[4], SR1E[2], CR9B, SR65,        CR97,      CR99   */
+    {DPA_CLK_RANGE_30M,      0x00, 0x00,    0x00,    0x00,    0x00,    0x03, 0x00,        0x00,      0x00},  /* LCK/VCK < 30000000 will use this value */
+    {DPA_CLK_RANGE_30_50M,   0x00, 0x00,    0x00,    0x00,    0x00,    0x03, 0x00,        0x00,      0x00},  /* 30000000 < LCK/VCK < 50000000 will use this value */
+    {DPA_CLK_RANGE_50_70M,   0x00, 0x00,    0x00,    0x00,    0x00,    0x02, 0x00,        0x00,      0x00},  /* 50000000 < LCK/VCK < 70000000 will use this value */
+    {DPA_CLK_RANGE_70_100M,  0x00, 0x00,    0x00,    0x00,    0x00,    0x02, 0x00,        0x00,      0x00},  /* 70000000 < LCK/VCK < 100000000 will use this value */
+    {DPA_CLK_RANGE_100_150M, 0x00, 0x00,    0x00,    0x00,    0x00,    0x02, 0x00,        0x00,      0x00},  /* 100000000 < LCK/VCK < 15000000 will use this value */
+    {DPA_CLK_RANGE_150M,     0x00, 0x00,    0x00,    0x00,    0x00,    0x08, 0x0E,        0x00,      0x00},  /* 15000000 < LCK/VCK will use this value */
+};
+
+
+/* For VT3327: */
+struct VT1636_DPA_SETTING VT1636_DPA_SETTING_TBL_VT3327[] = {
+     /* Panel ID,       CLK_SEL_ST1[09],    CLK_SEL_ST2[08] */
+    {LCD_PANEL_ID0_640X480,      0x00,               0x00},          /* For 640x480   */
+    {LCD_PANEL_ID1_800X600,      0x00,               0x00},          /* For 800x600   */
+    {LCD_PANEL_ID2_1024X768,     0x00,               0x00},          /* For 1024x768  */
+    {LCD_PANEL_ID3_1280X768,     0x00,               0x00},          /* For 1280x768  */
+    {LCD_PANEL_ID4_1280X1024,    0x00,               0x00},          /* For 1280x1024 */
+    {LCD_PANEL_ID5_1400X1050,    0x00,               0x00},          /* For 1400x1050 */
+    {LCD_PANEL_ID6_1600X1200,    0x00,               0x00}           /* For 1600x1200 */
+};
+
+struct GFX_DPA_SETTING GFX_DPA_SETTING_TBL_VT3327[] = {
+    /*  ClkRange,            DVP0, DVP0DataDriving,  DVP0ClockDriving, DVP1, DVP1Driving, DFPHigh,   DFPLow */
+    /*                       CR96, SR2A[5], SR1B[1], SR2A[4], SR1E[2], CR9B, SR65,        CR97,      CR99   */
+    {DPA_CLK_RANGE_30M,      0x07, 0x00,    0x00,    0x00,    0x00,    0x03, 0x00,        0x08,      0x01},  /* LCK/VCK < 30000000 will use this value */
+    {DPA_CLK_RANGE_30_50M,   0x07, 0x00,    0x00,    0x00,    0x00,    0x03, 0x00,        0x08,      0x01},  /* 30000000 < LCK/VCK < 50000000 will use this value */
+    {DPA_CLK_RANGE_50_70M,   0x06, 0x00,    0x00,    0x00,    0x00,    0x03, 0x00,        0x08,      0x01},  /* 50000000 < LCK/VCK < 70000000 will use this value */
+    {DPA_CLK_RANGE_70_100M,  0x03, 0x00,    0x00,    0x00,    0x00,    0x03, 0x00,        0x08,      0x03},  /* 70000000 < LCK/VCK < 100000000 will use this value */
+    {DPA_CLK_RANGE_100_150M, 0x03, 0x00,    0x00,    0x00,    0x00,    0x03, 0x00,        0x01,      0x02},  /* 100000000 < LCK/VCK < 15000000 will use this value */
+    {DPA_CLK_RANGE_150M,     0x00, 0x20,    0x00,    0x10,    0x00,    0x03, 0x00,        0x0D,      0x03},  /* 15000000 < LCK/VCK will use this value */
+};
+
+
+/* For VT3364: */
+struct GFX_DPA_SETTING GFX_DPA_SETTING_TBL_VT3364[] = {
+    /*  ClkRange,            DVP0, DVP0DataDriving,  DVP0ClockDriving, DVP1, DVP1Driving, DFPHigh,   DFPLow */
+    /*                       CR96, SR2A[5], SR1B[1], SR2A[4], SR1E[2], CR9B, SR65,        CR97,      CR99   */
+    {DPA_CLK_RANGE_30M,      0x07, 0x00,    0x00,    0x00,    0x00,    0x03, 0x00,        0x00,      0x08},  /* LCK/VCK < 30000000 will use this value */
+    {DPA_CLK_RANGE_30_50M,   0x07, 0x00,    0x00,    0x00,    0x00,    0x03, 0x00,        0x00,      0x08},  /* 30000000 < LCK/VCK < 50000000 will use this value */
+    {DPA_CLK_RANGE_50_70M,   0x07, 0x00,    0x00,    0x00,    0x00,    0x03, 0x00,        0x00,      0x08},  /* 50000000 < LCK/VCK < 70000000 will use this value */
+    {DPA_CLK_RANGE_70_100M,  0x07, 0x00,    0x00,    0x00,    0x00,    0x03, 0x00,        0x00,      0x08},  /* 70000000 < LCK/VCK < 100000000 will use this value */
+    {DPA_CLK_RANGE_100_150M, 0x03, 0x00,    0x02,    0x00,    0x00,    0x03, 0x00,        0x00,      0x08},  /* 100000000 < LCK/VCK < 15000000 will use this value */
+    {DPA_CLK_RANGE_150M,     0x01, 0x00,    0x02,    0x10,    0x00,    0x03, 0x00,        0x00,      0x08},  /* 15000000 < LCK/VCK will use this value */
+};
+
+#endif
diff -Nur linux-2.6.21-rc7/drivers/video/via/viafbdev.h linux-2.6.21-rc7.viafb/drivers/video/via/viafbdev.h
--- linux-2.6.21-rc7/drivers/video/via/viafbdev.h 1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/viafbdev.h 2007-04-26 19:52:32.000000000 -0400
@@ -0,0 +1,109 @@
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
+#ifndef __VIAFBDEV_H__
+#define __VIAFBDEV_H__
+
+#include <linux/version.h>
+#include <linux/proc_fs.h>
+#define VERSION_MAJOR       2
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+#define VERSION_KERNEL      4   /* For kernel 2.4 */
+#else
+#define VERSION_KERNEL      6   /* For kernel 2.6 */
+#endif
+
+#define VERSION_OS          0   /* 0: for 32 bits OS, 1: for 64 bits OS */
+#define VERSION_MINOR       3
+
+struct viafb_par {
+    struct fb_var_screeninfo var;
+    int bpp;
+    int hres;
+    int vres;
+    int linelength;
+    int vclk;       /* in MHz */
+
+    int vtotal;
+    int vdispend;
+    int vsyncstart;
+    int vsyncend;
+    int vblankstart;
+    int vblankend;
+
+    int htotal;
+    int hdispend;
+    int hsyncstart;
+    int hsyncend;
+    int hblankstart;
+    int hblankend;
+
+    int accel;                  /* Acceleration Flags */
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,8)
+    void __iomem *fbmem_virt;   /* framebuffer virtual memory address */
+    void __iomem *io_virt;      /* iospace virtual memory address */
+    void __iomem *integrated_tv_map_base;   /* Integrated TV start address */
+#else
+    unsigned int fbmem_virt;    /* framebuffer virtual memory address */
+    unsigned int io_virt;       /* iospace virtual memory address */
+    unsigned int integrated_tv_map_base;    /* Integrated TV start address */
+#endif
+    unsigned int fbmem;         /* framebuffer physical memory address */
+    unsigned int memsize;       /* size of fbmem */
+    unsigned int io;            /* io space address */
+    unsigned long mmio_base;    /* mmio base address */
+    unsigned long mmio_len;     /* mmio base length */
+    u32 fbmem_free;             /* Free FB memory */
+    u32 fbmem_used;             /* Use FB memory size */
+    u32 cursor_start;           /* Cursor Start Address */
+    u32 VQ_start;               /* Virtual Queue Start Address */
+    u32 VQ_end;                 /* Virtual Queue End Address */
+    u32 iga_path;               /* For dual-fb, see hw.c:set_start_addr */
+#endif
+    u8 duoview;  /* Is working in duoview mode? */
+    struct proc_dir_entry *proc_entry; /* viafb proc entry */
+};
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+struct viafb_info {
+    struct fb_info_gen gen;
+    unsigned int fbmem_virt;    /* framebuffer virtual memory address */
+    unsigned int fbmem;         /* framebuffer physical memory address */
+    unsigned int memsize;       /* size of fbmem */
+    unsigned int io;            /* io space address */
+    unsigned int io_virt;       /* iospace virtual memory address */
+    unsigned long mmio_base;    /* mmio base address */
+    unsigned long mmio_len;     /* mmio base length */
+    struct viafb_par currentmode;
+    unsigned char eng_oper;     /* engine operation... */
+    unsigned int integrated_tv_map_base;    /* Integrated TV start address */
+};
+#endif
+#endif /* __VIAFBDEV_H__ */

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
