From: <EddyFu@via.com.tw>
Subject: [PATCH 3/5] viafb: Framebuffer driver for VIA
	UniChrome/Chrome9 HC
Date: Sat, 28 Apr 2007 10:43:50 +0800
Message-ID: <C80EF34A3D2E494DBAF9AC29C7AE4EB887D2E9@exchtp03.taipei.via.com.tw>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0653840958=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hhcuo-0007Hw-04 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 27 Apr 2007 19:44:02 -0700
Received: from exchtp08.via.com.tw ([61.66.243.7])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hhcug-0008P3-I6
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 27 Apr 2007 19:44:01 -0700
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

--===============0653840958==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7893F.0D39D82C"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7893F.0D39D82C
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

diff -Nur linux-2.6.21-rc7/drivers/video/via/tbl1622a.h =
linux-2.6.21-rc7.viafb/drivers/video/via/tbl1622a.h
--- linux-2.6.21-rc7/drivers/video/via/tbl1622a.h 1969-12-31 =
19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/tbl1622a.h 2007-04-26 =
19:52:32.000000000 -0400
@@ -0,0 +1,2039 @@
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
+#ifndef __TBL1622A_H__
+#define __TBL1622A_H__
+
+#include "share.h"
+
+/***************************/
+/* VT1622A TV Encoder Table*/
+/***************************/
+typedef struct _vt1622a_func_table {
+    int     tv_func_index;
+    u16     *tv_underscan;
+    u16     *tv_fitscan;
+    u16     *tv_overscan;
+} vt1622a_func_table;
+
+struct vt1622a_table {
+    int     tv_index;
+    vt1622a_func_table   *tv_mode_ntsc;
+    vt1622a_func_table   *tv_mode_pal;
+};
+
+
+/* Underscan table */
+static u16 VT1622A_N640x480_VN[] =3D {
+                                               =20
+    0x0400, 0x0001, 0x0002, 0x0603, 0x0304,     /* TV.00-04 */
+    0x0005, 0x2006, 0x2707, 0x9A08, 0x0C09,     /* Tv.05-09 */
+    0x550A, 0x000B, 0x520C, 0x3B0D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xF812, 0x3E13,     /* TV.0F-13 */
+    0x8114, 0x5615, 0xF116, 0x9117, 0x2418,     /* TV.14-18 */
+    0x2519,                                     /* TV.19 */
+    0x101B, 0x001C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x111F, 0x1520, 0x0C21, 0x5F22,     /* TV.1E-22 */
+    0x7523, 0x0824,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x3B4F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0x0F50, 0x7F51, 0x2352, 0x5753, 0x0254,     /* TV.50-54 */
+    0x0F55, 0x2756, 0x7357, 0x6358, 0x8659,     /* TV.55-59 */
+    0xC45A, 0xDD5B, 0xD35C, 0x055D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x925E, 0xA45F, 0x0460, 0x0061, 0x0062,     /* TV.5E-62 */
+    0x7F63, 0x0364,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    784, 640, 640, 144, 688, 56,  600, 480, 480, 120, 488, 7
+};
+
+#define NUM_TOTAL_VT1622A_REG ARRAY_SIZE(VT1622A_N640x480_VN) =
-NUM_CRTC_TIMING
+
+static u16 VT1622A_N800x600_VN[] =3D {
+                                               =20
+    0x8400, 0x0001, 0x0002, 0x0403, 0x0304,     /* TV.00-04 */
+    0x0005, 0x2006, 0x5707, 0xD408, 0x0909,     /* TV.05-09 */
+    0x520A, 0x000B, 0x510C, 0x3B0D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0x6A12, 0x0D13,     /* TV.0F-13 */
+    0x4C14, 0x1C15, 0x9616, 0x5017, 0x5E18,     /* TV.14-18 */
+    0x1B19,                                     /* TV.19 */
+    0x101B, 0x011C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x441F, 0x1020, 0x0A21, 0x9C22,     /* TV.1E-22 */
+    0x7523, 0x0424,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x3A4F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0x2750, 0x1F51, 0x3452, 0xED53, 0x0254,     /* TV.50-54 */
+    0x2755, 0xF556, 0x9D57, 0x6458, 0xB759,     /* TV.55-59 */
+    0x0D5A, 0x215B, 0xF15C, 0x575D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0xB65E, 0x3B5F, 0x0560, 0x0061, 0x0162,     /* TV.5E-62 */
+    0xEF63, 0x0564,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1064,800, 800, 264, 840, 136, 750, 600, 600, 150, 606, 16
+};
+
+static u16 VT1622A_N1024x768_VN[] =3D {
+                                               =20
+    0x8400, 0x0001, 0x0002, 0x0403, 0x0304,     /* TV.00-04 */
+    0x0005, 0x2006, 0x4707, 0x1208, 0x0809,     /* TV.05-09 */
+    0x500A, 0x000B, 0x500C, 0x3A0D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xEF12, 0x3713,     /* TV.0F-13 */
+    0x7714, 0x2A15, 0xD616, 0x6617, 0xEB18,     /* TV.14-18 */
+    0x1419,                                     /* TV.19 */
+    0x101B, 0x051C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x771F, 0x0D20, 0x0521, 0xEF22,     /* TV.1E-22 */
+    0x7323, 0x0C24,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x394F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0x8750, 0xFF51, 0x3452, 0xB053, 0x0354,     /* TV.50-54 */
+    0x6F55, 0xDC56, 0xCD57, 0x3558, 0xF159,     /* TV.55-59 */
+    0x5E5A, 0x9A5B, 0x705C, 0x5A5D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x335E, 0x265F, 0x0760, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x2763, 0x0864,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1160,1024,1024,136, 1040,56,  945, 768, 768, 177, 789, 6
+};
+
+static u16 VT1622A_N848x480_VN[] =3D {
+                                               =20
+    0x8400, 0x0001, 0x0002, 0x0403, 0x0304,     /* TV.00-04 */
+    0x0005, 0x2006, 0xa707, 0xc108, 0x0709,     /* TV.05-09 */
+    0x500A, 0x000B, 0x500C, 0x390D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xF012, 0x2913,     /* TV.0F-13 */
+    0x6714, 0x3115, 0x6316, 0xA817, 0x3C18,     /* TV.14-18 */
+    0x1D19,                                     /* TV.19 */
+    0x101B, 0x031C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x331F, 0x1120, 0x0821, 0x4722,     /* TV.1E-22 */
+    0x7323, 0x0C24,                             /* TV.23-24 */
+=20
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x394F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xAF50, 0x4F51, 0x3452, 0x4453, 0x0254,     /* TV.50-54 */
+    0xE355, 0xBF56, 0x9357, 0x6358, 0xAD59,     /* TV.55-59 */
+    0xFD5A, 0x1B5B, 0x6F5C, 0x175D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x6D5E, 0xD45F, 0x0460, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x2F63, 0x0564,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1200,848, 848, 352, 968, 64,  581, 480, 480, 101, 496, 13
+};
+
+static u16 VT1622A_N720x480_VN[] =3D {
+                                               =20
+    0x0400, 0x0001, 0x0002, 0x0603, 0x0304,     /* TV.00-04 */
+    0x0005, 0x2006, 0x3F07, 0xB608, 0x0709,     /* TV.05-09 */
+    0x520A, 0x000B, 0x510C, 0x3A0D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xED12, 0x3113,     /* TV.0F-13 */
+    0x5014, 0x3515, 0x1816, 0x5517, 0x5518,     /* TV.14-18 */
+    0x1E19,                                     /* TV.19 */
+    0x101B, 0x031C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x331F, 0x1220, 0x0821, 0x5722,     /* TV.1E-22 */
+    0x7523, 0x0024,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x3A4F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0x4750, 0xCF51, 0x2352, 0x5753, 0x0254,     /* TV.50-54 */
+    0xBF55, 0xAD56, 0x8D57, 0x6358, 0xA459,     /* TV.55-59 */
+    0xF35A, 0x1E5B, 0x285C, 0x175D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x925E, 0x335F, 0x0460, 0x0061, 0x0062,     /* TV.5E-62 */
+    0xBF63, 0x0364,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    840, 720, 720, 120, 728, 48,  600, 480, 480, 120, 512, 7
+};
+
+static u16 VT1622A_P640x480_VN[] =3D {
+                                               =20
+    0x0400, 0x0001, 0x0002, 0x0603, 0x0004,     /* TV.00-04 */
+    0x0005, 0x2006, 0xBF07, 0x9F08, 0x3709,     /* TV.05-09 */
+    0x5D0A, 0x000B, 0x4F0C, 0x420D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xAC12, 0x1513,     /* TV.0F-13 */
+    0x6E14, 0x2815, 0x2D16, 0x7717, 0x6618,     /* TV.14-18 */
+    0x2D19,                                     /* TV.19 */
+    0x101B, 0x021C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x991F, 0x1720, 0x0C21, 0x3122,     /* TV.1E-22 */
+    0x7A23, 0x0424,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x434F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xE750, 0x7F51, 0x2352, 0x5753, 0x0254,     /* TV.50-54 */
+    0x1F55, 0x2F56, 0x7557, 0x6358, 0x8A59,     /* TV.55-59 */
+    0xC85A, 0xDB5B, 0xF55C, 0x055D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0xD75E, 0x8E5F, 0x0360, 0x7F61, 0xCF62,     /* TV.5E-62 */
+    0xBF63, 0x0364,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1000,640, 640, 360, 736, 72,  600, 480, 480, 120, 521, 5
+};
+
+static u16 VT1622A_P800x600_VN[] =3D {
+                                               =20
+    0x8400, 0x0001, 0x0002, 0x0403, 0x0004,     /* TV.00-04 */=20
+    0x0005, 0x2006, 0x2707, 0xB808, 0x0D09,     /* TV.05-09 */
+    0x5C0A, 0x000B, 0x4E0C, 0x400D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xEC12, 0x2A13,     /* TV.0F-13 */
+    0xFD14, 0x2815, 0xE416, 0x7D17, 0x7A18,     /* TV.14-18 */
+    0x2719,                                     /* TV.19 */
+    0x101B, 0x011C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0xAA1F, 0x1320, 0x0C21, 0x9F22,     /* TV.1E-22 */
+    0x7923, 0x0C24,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x414F,                                     /* TV.4F */
+=20
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0x9750, 0x1F51, 0x3352, 0xED53, 0x0254,     /* TV.50-54 */
+    0x9755, 0x8756, 0x8757, 0x6358, 0x9F59,     /* TV.55-59 */
+    0xE75A, 0xF35B, 0xE15C, 0x065D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0xCC5E, 0xF35F, 0x0460, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x4F63, 0x0464,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    920, 800, 800, 120, 816, 64,  750, 600, 600, 150, 606, 16
+};
+
+static u16 VT1622A_P1024x768_VN[] =3D {
+                                               =20
+    0x8400, 0x0001, 0x0002, 0x0403, 0x0004,     /* TV.00-04 */
+    0x0005, 0x2006, 0x5707, 0x2508, 0x4009,     /* TV.05-09 */
+    0x5A0A, 0x000B, 0x4D0C, 0x400D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xE812, 0x2313,     /* TV.0F-13 */
+    0xD114, 0x1815, 0x7216, 0xC317, 0x8C18,     /* TV.14-18 */
+    0x1A19,                                     /* TV.19 */
+    0x101B, 0x071C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0xFF1F, 0x0F20, 0x0C21, 0x8722,     /* TV.1E-22 */
+    0x7923, 0x0024,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x404F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xAF50, 0xFF51, 0x3452, 0xB553, 0x0354,     /* TV.50-54 */
+    0x5755, 0xA856, 0xC857, 0x3558, 0xEC59,     /* TV.55-59 */
+    0x4C5A, 0x9A5B, 0x415C, 0x5A5D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x145E, 0x5C5F, 0x0660, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x1F63, 0x0764,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1200,1024,1024,176, 1040,80,  950, 768, 768, 182, 802, 3
+};
+
+static u16 VT1622A_P848x480_VN[] =3D {
+                                               =20
+    0x0400, 0x0001, 0x0002, 0x0603, 0x0004,     /* TV.00-04 */
+    0x0005, 0x2006, 0xa707, 0xE608, 0x0609,     /* TV.05-09 */=20
+    0x5C0A, 0x000B, 0x4E0C, 0x410D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xE612, 0x2313,     /* TV.0F-13 */
+    0x8414, 0x1815, 0x1816, 0x2817, 0x8718,     /* TV.14-18 */
+    0x1F19,                                     /* TV.19 */
+    0x101B, 0x011C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0xCC1F, 0x0F20, 0x0C21, 0x6022,     /* TV.1E-22 */
+    0x7923, 0x0024,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x404F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xAF50, 0x4F51, 0x3452, 0x5753, 0x0254,     /* TV.50-54 */
+    0x7F55, 0x3156, 0xA957, 0x7458, 0xD159,     /* TV.55-59 */
+    0x2B5A, 0x415B, 0xA55C, 0x585D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0xD75E, 0x265F, 0x0360, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x7F63, 0x0464,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1200,848, 848, 352, 976, 56,  600, 480, 480, 120, 499, 11
+};
+
+static u16 VT1622A_P720x576_VN[] =3D {
+                                               =20
+    0x0400, 0x0001, 0x0002, 0x0603, 0x0004,     /* TV.00-04 */
+    0x0005, 0x2006, 0x4907, 0xCC08, 0x0609,     /* TV.05-09 */
+    0x5C0A, 0x000B, 0x4D0C, 0x410D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xF012, 0x2413,     /* TV.0F-13 */
+    0x3F14, 0x3915, 0x6016, 0x9017, 0xC818,     /* TV.14-18 */
+    0x2319,                                     /* TV.19 */
+    0x101B, 0x011C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0xBB1F, 0x1420, 0x0C21, 0xD922,     /* TV.1E-22 */
+    0x7923, 0x0024,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x414F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xE750, 0xCF51, 0x2352, 0xD453, 0x0254,     /* TV.50-54 */
+    0xF655, 0xCF56, 0x9557, 0x6358, 0xAE59,     /* TV.55-59 */
+    0xF55A, 0x1C5B, 0x965C, 0x175D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0xA45E, 0x005F, 0x0460, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x8763, 0x0464,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1000,720, 720, 280, 840, 96,  725, 576, 576, 149, 602, 9
+};
+
+
+/* Fit Industry TV Screen Mode */
+
+static u16 VT1622A_N640x480_VF[] =3D {
+                                               =20
+    0x0400, 0x0001, 0x0002, 0x0603, 0x0304,     /* TV.00-04 */
+    0x0005, 0x2006, 0x2E07, 0x8208, 0x0609,     /* TV.05-09 */
+    0x560A, 0x050B, 0x500C, 0x3B0D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xF812, 0x2713,     /* TV.0F-13 */
+    0x9E14, 0x5515, 0x4216, 0x8517, 0x2C18,     /* TV.14-18 */
+    0x2419,                                     /* TV.19 */
+    0x101B, 0x021C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x111F, 0x1720, 0x0C21, 0xD522,     /* TV.1E-22 */
+    0x7323, 0x0424,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x3A4F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0x4750, 0x8151, 0x2352, 0x3E53, 0x0254,     /* TV.50-54 */
+    0x2455, 0x6756, 0x7757, 0x6358, 0x8859,     /* TV.55-59 */
+    0xCB5A, 0xDA5B, 0x005C, 0x065D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x625E, 0x2C5F, 0x0460, 0x0061, 0x0062,     /* TV.5E-62 */
+    0x9763, 0x0364,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    840, 640, 640, 200, 736, 56,  575, 480, 480, 95,  499, 7
+};
+
+static u16 VT1622A_N800x600_VF[] =3D {
+                                               =20
+    0x0400, 0x0001, 0x0002, 0x0603, 0x0304,     /* TV.00-04 */
+    0x0005, 0x2006, 0x8707, 0x9608, 0xFA09,     /* TV.05-09 */
+    0x560A, 0x000B, 0x500C, 0x3B0D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xED12, 0x1913,     /* TV.0F-13 */
+    0xA014, 0x1C15, 0xBE16, 0xFF17, 0x7F18,     /* TV.14-18 */
+    0x2019,                                     /* TV.19 */
+    0x101B, 0x011C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x221F, 0x1120, 0x0A21, 0xDE22,     /* TV.1E-22 */
+    0x7323, 0x0424,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x3A4F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xAF50, 0x1F51, 0x3452, 0xD753, 0x0254,     /* TV.50-54 */
+    0x7F55, 0xA956, 0x8457, 0x2358, 0x9859,     /* TV.55-59 */
+    0xE35A, 0xE45B, 0xAE5C, 0x065D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x8C5E, 0xB65F, 0x0560, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x7F63, 0x0664,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1200,800, 800, 400, 848, 216, 728, 600, 600, 128, 656, 9
+};
+
+static u16 VT1622A_N1024x768_VF[] =3D {
+                                               =20
+    0x8400, 0x0001, 0x0002, 0x0403, 0x0304,     /* TV.00-04 */
+    0x0005, 0x2006, 0x4E07, 0xDB08, 0x0C09,     /* TV.05-09 */
+    0x520A, 0x000B, 0x4F0C, 0x3A0D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0x6812, 0x0D13,     /* TV.0F-13 */
+    0x4A14, 0x1415, 0x3216, 0x8A17, 0x7C18,     /* TV.14-18 */
+    0x1619,                                     /* TV.19 */
+    0x101B, 0x031C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x661F, 0x0D20, 0x0521, 0x2422,     /* TV.1E-22 */
+    0x7323, 0x0424,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x394F,                                     /* TV.4F */=20
+=20
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0x9750, 0xFF51, 0x3452, 0x9C53, 0x0354,     /* TV.50-54 */
+    0x0E55, 0xDE56, 0xBF57, 0x3558, 0xDD59,     /* TV.55-59 */
+    0x495A, 0x7B5B, 0xB35C, 0x595D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x0C5E, 0x235F, 0x0760, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x1763, 0x0864,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1176,1024,1024,152, 1040,64,  925, 768, 768, 157, 779, 12
+};
+
+static u16 VT1622A_N848x480_VF[] =3D {
+                                               =20
+    0x0400, 0x0001, 0x0002, 0x0603, 0x0304,     /* TV.00-04 */
+    0x0005, 0x2006, 0x4707, 0xB508, 0x0B09,     /* TV.05-09 */
+    0x530A, 0x000B, 0x500C, 0x3A0D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xED12, 0x2313,     /* TV.0F-13 */
+    0x0E14, 0x3515, 0x8416, 0x8417, 0xF618,     /* TV.14-18 */
+    0x1A19,                                     /* TV.19 */
+    0x101B, 0x031C, 0x801D,                     /* TV.1B-1D */=20
+    0x001E, 0x441F, 0x1120, 0x0A21, 0x7822,     /* TV.1E-22 */
+    0x7323, 0x0424,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x394F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xE750, 0x4F51, 0x3352, 0x3653, 0x0254,     /* TV.50-54 */
+    0x3755, 0x3956, 0x9F57, 0x7458, 0xB759,     /* TV.55-59 */
+    0x125A, 0x3A5B, 0x125C, 0x585D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x525E, 0x1A5F, 0x0460, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x3763, 0x0464,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1000,848, 848, 152, 872, 56,  567, 480, 480, 87,  485, 7
+};
+
+static u16 VT1622A_N720x480_VF[] =3D {
+                                               =20
+    0x0400, 0x0001, 0x0002, 0x0603, 0x0304,     /* TV.00-04 */
+    0x0005, 0x2006, 0x3F07, 0x9808, 0x0A09,     /* TV.05-09 */
+    0x530A, 0x000B, 0x500C, 0x3B0D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xF512, 0x2713,     /* TV.0F-13 */
+    0x9E14, 0x5515, 0x9A16, 0xF417, 0xA618,     /* TV.14-18 */
+    0x1F19,                                     /* TV.19 */
+    0x101B, 0x031C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x221F, 0x1620, 0x0821, 0xF622,     /* TV.1E-22 */
+    0x7323, 0x0424,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x084E,     /* TV.4A-4E */
+    0x3A4F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0x4750, 0xCF51, 0x2352, 0x3E53, 0x0254,     /* TV.50-54 */
+    0x9755, 0xBE56, 0x8857, 0x6358, 0x9C59,     /* TV.55-59 */
+    0xE95A, 0xE15B, 0xDC5C, 0x065D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x625E, 0x175F, 0x0460, 0x0061, 0x0062,     /* TV.5E-62 */
+    0x9763, 0x0364,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    840, 720, 720, 120, 728, 48,  575, 480, 480, 95,  484, 15
+};
+
+static u16 VT1622A_P640x480_VF[] =3D {
+                                               =20
+    0x0400, 0x0001, 0x0002, 0x0603, 0x0004,     /* TV.00-04 */
+    0x0005, 0x2006, 0x4E07, 0x8A08, 0x3009,     /* Tv.05-09 */
+    0x5D0A, 0x000B, 0x4D0C, 0x410D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xF812, 0x1813,     /* TV.0F-13 */
+    0xFD14, 0x5415, 0xBC16, 0x4617, 0x1E18,     /* TV.14-18 */
+    0x2D19,                                     /* TV.19 */
+    0x101B, 0x021C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x991F, 0x1B20, 0x0C21, 0x8722,     /* TV.1E-22 */
+    0x7923, 0x0424,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x434F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xE750, 0x7F51, 0x2352, 0x3E53, 0x0254,     /* TV.50-54 */
+    0x2455, 0x5D56, 0x7657, 0x6358, 0x8959,     /* TV.55-59 */
+    0xC25A, 0x145B, 0x1C5C, 0x165D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0xAE5E, 0x3A5F, 0x0360, 0x0061, 0x0062,     /* TV.5E-62 */
+    0xBF63, 0x0364,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1000,640, 640, 360, 840, 80,  575, 480, 480, 95,  501, 3
+};
+
+static u16 VT1622A_P800x600_VF[] =3D {
+                                               =20
+    0x0400, 0x0001, 0x0002, 0x0603, 0x0004,     /* TV.00-04 */
+    0x0005, 0x2006, 0x4607, 0xB308, 0x0F09,     /* TV.05-09 */
+    0x5C0A, 0x000B, 0x4D0C, 0x410D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xF012, 0x2413,     /* TV.0F-13 */
+    0x3F14, 0x3915, 0x6016, 0x9017, 0xC818,     /* TV.14-18 */
+    0x2319,                                     /* TV.19 */
+    0x101B, 0x011C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0xBB1F, 0x1420, 0x0C21, 0xD922,     /* TV.1E-22 */
+    0x7923, 0x0024,                             /* TV.23-24 */
+=20
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x414F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xE750, 0x2151, 0x3352, 0xD453, 0x0254,     /* TV.50-54 */
+    0xF655, 0xFD56, 0x9557, 0x6358, 0xAE59,     /* TV.55-59 */
+    0xF55A, 0x1C5B, 0x965C, 0x175D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0xA45E, 0x315F, 0x0460, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x8763, 0x0464,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1000,800, 800, 200, 848, 80,  725, 600, 600, 125, 602, 1
+};
+
+static u16 VT1622A_P1024x768_VF[] =3D {
+                                               =20
+    0x8400, 0x0001, 0x0002, 0x0403, 0x0004,     /* TV.00-04 */
+    0x0005, 0x2006, 0x5707, 0xF208, 0x4009,     /* TV.05-09 */
+    0x5B0A, 0x000B, 0x4E0C, 0x400D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xF012, 0x2313,     /* TV.0F-13 */
+    0x9714, 0x3115, 0xB416, 0x7517, 0x4418,     /* TV.14-18 */
+    0x1B19,                                     /* TV.19 */
+    0x101B, 0x031C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0xEE1F, 0x0D20, 0x0C21, 0x8722,     /* TV.1E-22 */
+    0x7923, 0x0024,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x404F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xAF50, 0xFF51, 0x3452, 0x9C53, 0x0354,     /* TV.50-54 */
+    0x3355, 0xE656, 0xC357, 0x3558, 0xE959,     /* TV.55-59 */
+    0x515A, 0x7F5B, 0x015C, 0x5A5D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0xEB5E, 0x195F, 0x0560, 0x0061, 0x0162,     /* TV.5E-62 */
+    0xEF63, 0x0664,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1200,1024,1024,176, 1040,72,  925, 768, 768, 157, 782, 13
+};
+
+static u16 VT1622A_P848x480_VF[] =3D {
+                                               =20
+    0x0400, 0x0001, 0x0002, 0x0603, 0x0004,     /* TV.00-04 */
+    0x0005, 0x2006, 0x4A07, 0xC808, 0x3909,     /* TV.05-09 */
+    0x5B0A, 0x000B, 0x4D0C, 0x3F0D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xEA12, 0x2A13,     /* TV.0F-13 */
+    0xFD14, 0x3015, 0x9316, 0x1317, 0xE618,     /* TV.14-18 */
+    0x2019,                                     /* TV.19 */
+    0x101B, 0x031C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0xCC1F, 0x1220, 0x0C21, 0x2922,     /* TV.1E-22 */
+    0x7923, 0x0824,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x404F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xE750, 0x4F51, 0x3352, 0x3E53, 0x0254,     /* TV.50-54 */
+    0x4F55, 0x3856, 0xA257, 0x7458, 0xBE59,     /* TV.55-59 */
+    0x0B5A, 0x3C5B, 0x475C, 0x585D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0xAE5E, 0x1C5F, 0x0360, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x9763, 0x0364,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1000,848, 848, 152, 856, 72,  575, 480, 480, 95,  486, 3
+};
+
+static u16 VT1622A_P720x576_VF[] =3D {
+                                               =20
+    0x0400, 0x0001, 0x0002, 0x0603, 0x0004,     /* TV.00-04 */
+    0x0005, 0x2006, 0x2707, 0xAF08, 0x3309,     /* TV.05-09 */
+    0x620A, 0x000B, 0x4D0C, 0x440D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0x0912, 0x0713,     /* TV.0F-13 */
+    0x2114, 0x2815, 0x5016, 0x6317, 0xD518,     /* TV.14-18 */
+    0x2519,                                     /* TV.19 */
+    0x101B, 0x031C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0xAA1F, 0x1720, 0x0C21, 0xF322,     /* TV.1E-22 */
+    0x7923, 0x4824,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x424F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0x1F50, 0xCF51, 0x2352, 0xA253, 0x0254,     /* TV.50-54 */
+    0xBF55, 0xC956, 0x8D57, 0x2358, 0xA559,     /* TV.55-59 */
+    0xE85A, 0x1B5B, 0x2C5C, 0x175D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x525E, 0x085F, 0x0460, 0x0061, 0x0062,     /* TV.5E-62 */
+    0x5F63, 0x0364,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    800, 720, 720, 80,  728, 32,  675, 576, 576, 99,  602, 9
+};
+
+/* TV Overscan Table */
+
+static u16 VT1622A_N640x480_VO[] =3D {
+                                                 =20
+    0x0400, 0x0001, 0x0002, 0x0603, 0x0304,     /* TV.00-04 */
+    0x0005, 0x2006, 0x2F07, 0x6408, 0xFA09,     /* TV.05-09 */
+    0x5E0A, 0x170B, 0x500C, 0x3F0D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0x7012, 0x0D13,     /* TV.0F-13 */
+    0x5014, 0x3815, 0x4516, 0x9917, 0x9918,     /* TV.14-18 */
+    0x2919,                                     /* TV.19 */
+    0x101B, 0x001C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x001F, 0x1720, 0x0C21, 0x4822,     /* TV.1E-22 */
+    0x7423, 0x0824,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x3B4F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0x1F50, 0x7F51, 0x2352, 0x0C53, 0x0254,     /* TV.50-54 */
+    0xBB55, 0x3356, 0x6757, 0x6258, 0x7659,     /* TV.55-59 */
+    0xB05A, 0xA15B, 0x2F5C, 0x055D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x005E, 0x945F, 0x8460, 0x0061, 0x0062,     /* TV.5E-62 */
+    0x1F63, 0x0364,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    800, 640, 640, 160, 656, 96,  525, 480, 480, 45,  495, 11
+};
+
+static u16 VT1622A_N800x600_VO[] =3D {
+                                                 =20
+    0x8400, 0x0001, 0x0002, 0x0403, 0x0304,     /* TV.00-04 */
+    0x0005, 0x2006, 0x4607, 0x8108, 0xFE09,     /* TV.05-09 */
+    0x570A, 0x000B, 0x500C, 0x3D0D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0x4A12, 0x0D13,     /* TV.0F-13 */
+    0x3E14, 0x1C15, 0xD116, 0x6217, 0x8C18,     /* TV.14-18 */
+    0x2119,                                     /* TV.19 */
+    0x101B, 0x011C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x221F, 0x1120, 0x0A21, 0xB422,     /* TV.1E-22 */
+    0x7323, 0x0824,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x394F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xEF50, 0x1F51, 0x3352, 0x8A53, 0x0254,     /* TV.50-54 */
+    0x6355, 0xDE56, 0x8057, 0x6358, 0x9359,     /* TV.55-59 */
+    0xDC5A, 0xE05B, 0x7F5C, 0x065D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0xF65E, 0x9B5F, 0x0460, 0x0061, 0x0162,     /* TV.5E-62 */
+    0xD763, 0x0464,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1000,800, 800, 200, 832, 96,  651, 600, 600, 51,  608, 12
+};
+
+static u16 VT1622A_N1024x768_VO[] =3D {
+                                                 =20
+    0x8400, 0x0001, 0x0002, 0x0403, 0x0304,     /* TV.00-04 */=20
+    0x0005, 0x2006, 0x2F07, 0xB608, 0x0409,     /* TV.05-09 */
+    0x540A, 0x000B, 0x500C, 0x3C0D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0x6A12, 0x0D13,     /* TV.0F-13 */
+    0x5814, 0x1C15, 0x8A16, 0xE817, 0xA218,     /* TV.14-18 */
+    0x1719,                                     /* TV.19 */
+    0x101B, 0x031C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x551F, 0x0F20, 0x0521, 0x7222,     /* TV.1E-22 */
+    0x7323, 0x0824,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x394F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0x5F50, 0xFF51, 0x3452, 0x3853, 0x0354,     /* TV.50-54 */
+    0xCF55, 0xE056, 0xB657, 0x3458, 0xD259,     /* TV.55-59 */
+    0x395A, 0x5C5B, 0x415C, 0x595D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x495E, 0x235F, 0x0660, 0x0061, 0x0162,     /* TV.5E-62 */
+    0xDF63, 0x0664,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1120,1024,1024,96,  1040,40,  825, 768, 768, 57,  770, 6
+};
+
+static u16 VT1622A_N848x480_VO[] =3D {
+                                                 =20
+    0x8400, 0x0001, 0x0002, 0x0403, 0x0304,     /* TV.00-04 */
+    0x0005, 0x2006, 0x4E07, 0x9E08, 0x0709,     /* TV.05-09 */
+    0x510A, 0x000B, 0x500C, 0x3A0D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xED12, 0x2313,     /* TV.0F-13 */
+    0x0814, 0x3515, 0xA116, 0x6417, 0x9318,     /* TV.14-18 */
+    0x1B19,                                     /* TV.19 */
+    0x101B, 0x031C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x441F, 0x1120, 0x0A21, 0xF022,     /* TV.1E-22 */
+    0x7323, 0x0424,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x394F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xEF50, 0x5151, 0x3352, 0x2553, 0x0254,     /* TV.50-54 */
+    0x1F55, 0x4756, 0x9C57, 0x7458, 0xB559,     /* TV.55-59 */
+    0x0C5A, 0x3D5B, 0xF15C, 0x575D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x305E, 0x0C5F, 0x0460, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x1F63, 0x0464,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1008,848, 848, 160, 856, 72,  550, 480, 480, 70,  491, 5
+};
+
+static u16 VT1622A_N720x480_VO[] =3D {
+                                               =20
+    0x0400, 0x0001, 0x0002, 0x0603, 0x0304,     /* TV.00-04 */
+    0x0005, 0x2006, 0x2807, 0x5208, 0x0809,     /* TV.05-09 */
+    0x5B0A, 0x000B, 0x500C, 0x400D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0x2D12, 0x0713,     /* TV.0F-13 */
+    0x2814, 0x3415, 0x1D16, 0x6617, 0x6618,     /* TV.14-18 */
+    0x2419,                                     /* TV.19 */
+    0x101B, 0x021C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x111F, 0x1620, 0x0821, 0xDF22,     /* TV.1E-22 */
+    0x7623, 0x0424,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x084E,     /* TV.4A-4E */
+    0x3A4F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0x1F50, 0xCF51, 0x2352, 0x0C53, 0x0254,     /* TV.50-54 */
+    0x1F55, 0xCE56, 0x7657, 0x2358, 0x8859,     /* TV.55-59 */
+    0xC95A, 0xEF5B, 0xFF5C, 0x055D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x005E, 0x005F, 0x0060, 0x0061, 0x0062,     /* TV.5E-62 */
+    0x1F63, 0x0364,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    800, 720, 720, 80,  728, 32,  525, 480, 480, 45,  482, 1
+};
+
+static u16 VT1622A_P640x480_VO[] =3D {
+                                                 =20
+    0x0400, 0x0001, 0x0002, 0x0603, 0x0004,     /* TV.00-04 */
+    0x0005, 0x2006, 0x4F07, 0x7008, 0x2E09,     /* Tv.05-09 */
+    0x670A, 0x000B, 0x4D0C, 0x460D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0x4A12, 0x0E13,     /* TV.0F-13 */
+    0x3714, 0x2415, 0xC016, 0xD917, 0x7118,     /* TV.14-18 */
+    0x3219,                                     /* TV.19 */
+    0x101B, 0x021C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x881F, 0x1B20, 0x0C21, 0xEF22,     /* TV.1E-22 */
+    0x7923, 0x0424,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x444F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xE750, 0x7F51, 0x2352, 0xF353, 0x0154,     /* TV.50-54 */
+    0xCF55, 0xB756, 0x6957, 0x3258, 0x7A59,     /* TV.55-59 */
+    0xAD5A, 0xBF5B, 0x5F5C, 0x055D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x335E, 0x865F, 0x0360, 0x0061, 0x0062,     /* TV.5E-62 */
+    0x1F63, 0x0364,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1000,640, 640, 360, 800, 120, 500, 480, 480, 20,  485, 6
+};
+
+static u16 VT1622A_P800x600_VO[] =3D {
+                                                 =20
+    0x8400, 0x0001, 0x0002, 0x0403, 0x0004,     /* TV.00-04 */
+    0x0005, 0x2006, 0x4707, 0x9108, 0x3109,     /* TV.05-09 */
+    0x610A, 0x000B, 0x4D0C, 0x430D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xED12, 0x1513,     /* TV.0F-13 */
+    0x8F14, 0x3015, 0x5016, 0x6317, 0xD518,     /* TV.14-18 */
+    0x2519,                                     /* TV.19 */
+    0x101B, 0x031C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0xAA1F, 0x1420, 0x0C21, 0x7922,     /* TV.1E-22 */
+    0x7923, 0x0824,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x414F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xE750, 0x2151, 0x3352, 0x8953, 0x0254,     /* TV.50-54 */
+    0xBF55, 0xFD56, 0x8D57, 0x2358, 0xA559,     /* TV.55-59 */
+    0xE85A, 0xE95B, 0x325C, 0x075D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x295E, 0x325F, 0x0460, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x0F63, 0x0464,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1000,800, 800, 200, 872, 56,  650, 600, 600, 50,  608, 12
+};
+
+static u16 VT1622A_P1024x768_VO[] =3D {
+                                                 =20
+    0x8400, 0x0001, 0x0002, 0x0403, 0x0004,     /* TV.00-04 */
+    0x0005, 0x2006, 0x3707, 0xBD08, 0x3709,     /* TV.05-09 */
+    0x5E0A, 0x000B, 0x4D0C, 0x420D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xC912, 0x1413,     /* TV.0F-13 */
+    0x7914, 0x1C15, 0x3816, 0x0E17, 0x7B18,     /* TV.14-18 */
+    0x1D19,                                     /* TV.19 */
+    0x101B, 0x031C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0xDD1F, 0x0F20, 0x0C21, 0xC022,     /* TV.1E-22 */
+    0x7923, 0x0824,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x404F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xAF50, 0xFF51, 0x3452, 0x3853, 0x0354,     /* TV.50-54 */
+    0xCF55, 0xE356, 0xB457, 0x3458, 0xD459,     /* TV.55-59 */
+    0x2B5A, 0x405B, 0x525C, 0x595D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x485E, 0x215F, 0x0560, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x2F63, 0x0664,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1200,1024,1024,176, 1088,56,  825, 768, 768, 57,  771, 5
+};
+
+static u16 VT1622A_P848x480_VO[] =3D {
+                                               =20
+    0x8400, 0x0001, 0x0002, 0x0403, 0x0004,     /* TV.00-04 */
+    0x0005, 0x2006, 0xA507, 0xA108, 0x3809,     /* TV.05-09 */
+    0x5E0A, 0x000B, 0x4D0C, 0x410D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xC712, 0x1E13,     /* TV.0F-13 */
+    0x7914, 0x1C15, 0xEC16, 0xE517, 0x6418,     /* TV.14-18 */
+    0x2219,                                     /* TV.19 */
+    0x101B, 0x031C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0xBB1F, 0x1220, 0x0C21, 0x5A22,     /* TV.1E-22 */
+    0x7923, 0x0C24,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x3A4F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xAF50, 0x4F51, 0x3452, 0x2553, 0x0254,     /* TV.50-54 */
+    0x1F55, 0x4F56, 0x9B57, 0x7458, 0xB759,     /* TV.55-59 */
+    0x0A5A, 0x3F5B, 0xF05C, 0x585D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x855E, 0x005F, 0x0360, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x1F63, 0x0464,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1200,848, 848, 352, 864, 176, 550, 480, 480, 70,  491, 5
+};
+
+static u16 VT1622A_P720x576_VO[] =3D {
+                                               =20
+    0x0400, 0x0001, 0x0002, 0x0603, 0x0004,     /* TV.00-04 */
+    0x0005, 0x2006, 0x3F07, 0x8908, 0x3909,     /* TV.05-09 */
+    0x630A, 0x000B, 0x500C, 0x450D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xE812, 0x2313,     /* TV.0F-13 */
+    0x8414, 0x2015, 0xCB16, 0x8A17, 0x0918,     /* TV.14-18 */
+    0x2A19,                                     /* TV.19 */
+    0x101B, 0x021C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x991F, 0x1720, 0x0C21, 0x6F22,     /* TV.1E-22 */
+    0x7923, 0x4824,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x3A4F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0x5F50, 0xCF51, 0x2352, 0x7053, 0x0254,     /* TV.50-54 */
+    0x5F55, 0xBF56, 0x7E57, 0x2358, 0x9459,     /* TV.55-59 */
+    0xD05A, 0x275B, 0x8F5C, 0x165D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x005E, 0x005F, 0x0460, 0x0061, 0x0062,     /* TV.5E-62 */
+    0x5F63, 0x0364,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    864, 720, 720, 144, 760, 40,  625, 576, 576, 49,  577, 3
+};
+
+/***********************************/
+/* VT1622A output RGB Table        */
+/***********************************/
+
+/* NTSC */
+
+static u16 VT1622A_N640x480_RGB_VN[] =3D {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0x9127, 0x9C2B, 0x272C,    =20
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N800x600_RGB_VN[] =3D {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0x9127, 0x9C2B,            =20
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N1024x768_RGB_VN[] =3D {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0x9127, 0x9C2B,            =20
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N848x480_RGB_VN[] =3D {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0x9127, 0x9C2B,            =20
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N720x480_RGB_VN[] =3D {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0x9127, 0x9C2B,            =20
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N640x480_RGB_VF[] =3D {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0x9127, 0x9C2B, 0x272C,    =20
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N800x600_RGB_VF[] =3D {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0x9127, 0x9C2B,             =20
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N1024x768_RGB_VF[] =3D {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0x9127, 0x9C2B,             =20
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N848x480_RGB_VF[] =3D {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0x9127, 0x9C2B,            =20
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N720x480_RGB_VF[] =3D {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0x9127, 0x9C2B,            =20
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N640x480_RGB_VO[] =3D {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N800x600_RGB_VO[] =3D {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N1024x768_RGB_VO[] =3D {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N848x480_RGB_VO[] =3D {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N720x480_RGB_VO[] =3D {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+
+
+/* PAL */
+
+
+static u16 VT1622A_P640x480_RGB_VN[] =3D {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0x9127, 0x9C2B, 0x272C,    =20
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P800x600_RGB_VN[] =3D {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0x9127, 0x9C2B,               =20
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P1024x768_RGB_VN[] =3D {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0x9127, 0x9C2B,               =20
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P848x480_RGB_VN[] =3D {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0x9127, 0x9C2B,              =20
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P720x576_RGB_VN[] =3D {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0x9127, 0x9C2B,              =20
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P640x480_RGB_VF[] =3D {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0x9127, 0x9C2B, 0x272C,      =20
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P800x600_RGB_VF[] =3D {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0x9127, 0x9C2B,              =20
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P1024x768_RGB_VF[] =3D {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0x9127, 0x9C2B,              =20
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P848x480_RGB_VF[] =3D {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0x9127, 0x9C2B,              =20
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P720x576_RGB_VF[] =3D {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0x9127, 0x9C2B,              =20
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P640x480_RGB_VO[] =3D {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P800x600_RGB_VO[] =3D {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P1024x768_RGB_VO[] =3D {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P848x480_RGB_VO[] =3D {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P720x576_RGB_VO[] =3D {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+/***********************************/
+/* VT1622A output YPBPR Table      */
+/***********************************/
+
+/* NTSC */
+
+static u16 VT1622A_N640x480_YPBPR_VN[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N800x600_YPBPR_VN[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N1024x768_YPBPR_VN[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N848x480_YPBPR_VN[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+
+};
+
+static u16 VT1622A_N720x480_YPBPR_VN[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N640x480_YPBPR_VF[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N800x600_YPBPR_VF[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N1024x768_YPBPR_VF[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N848x480_YPBPR_VF[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N720x480_YPBPR_VF[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N640x480_YPBPR_VO[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N800x600_YPBPR_VO[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N1024x768_YPBPR_VO[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N848x480_YPBPR_VO[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N720x480_YPBPR_VO[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+
+/* PAL */
+
+static u16 VT1622A_P640x480_YPBPR_VN[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P800x600_YPBPR_VN[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P1024x768_YPBPR_VN[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P848x480_YPBPR_VN[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P720x576_YPBPR_VN[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P640x480_YPBPR_VF[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P800x600_YPBPR_VF[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P1024x768_YPBPR_VF[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P848x480_YPBPR_VF[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P720x576_YPBPR_VF[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P640x480_YPBPR_VO[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P800x600_YPBPR_VO[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P1024x768_YPBPR_VO[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P848x480_YPBPR_VO[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P720x576_YPBPR_VO[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+/***********************************/
+/* VT1622A output SDTV_RGB Table   */
+/***********************************/
+
+/* NTSC */
+
+static u16 VT1622A_N640x480_SDTV_RGB_VN[] =3D {
+    0x2A02, 0x0B04,             /* output SDTV_RGB type */
+    0x8A08, 0x1809, 0x001C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N800x600_SDTV_RGB_VN[] =3D {
+    0x2A02, 0x0B04,             /* output SDTV_RGB type */
+    0xC408, 0x1209, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N1024x768_SDTV_RGB_VN[] =3D {
+    0x2A02, 0x0B04,             /* output SDTV_RGB type */
+    0x0C08, 0x0E09, 0x051C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N848x480_SDTV_RGB_VN[] =3D {
+    0x2A02, 0x0B04,             /* output SDTV_RGB type */
+    0xB508, 0x0009, 0x001C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N720x480_SDTV_RGB_VN[] =3D {
+    0x2A02, 0x0B04,             /* output SDTV_RGB type */
+    0xA908, 0x0109, 0x001C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N640x480_SDTV_RGB_VF[] =3D {
+    0x2A02, 0X0B04,             /* output SDTV_RGB type */
+    0x7E08, 0x0109, 0x001C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N800x600_SDTV_RGB_VF[] =3D {
+    0x2A02, 0x0B04,             /* output SDTV_RGB type */
+    0x8B08, 0xF509, 0x031C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N1024x768_SDTV_RGB_VF[]=3D{
+    0x2A02, 0x0B04,             /* output SDTV_RGB type */
+    0xD408, 0x0909, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N848x480_SDTV_RGB_VF[] =3D {
+    0x2A02, 0x0B04,             /* output SDTV_RGB type */
+    0xA808, 0x0609, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N720x480_SDTV_RGB_VF[] =3D {
+    0x2A02, 0x0B04,             /* output SDTV_RGB type */
+    0x8C08, 0x0509, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N640x480_SDTV_RGB_VO[] =3D {
+    0x2A02, 0x0B04,             /* output SDTV_RGB type */
+    0x5708, 0xF109, 0x021C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N800x600_SDTV_RGB_VO[] =3D {
+    0x2A02, 0x0B04,             /* output SDTV_RGB type */
+    0x7208, 0xF809, 0x031C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N1024x768_SDTV_RGB_VO[] =3D {
+    0x2A02, 0x0B04,             /* output SDTV_RGB type */
+    0xAE08, 0x0209, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N848x480_SDTV_RGB_VO[] =3D {
+    0x2A02, 0x0B04,             /* output SDTV_RGB type */
+    0x9708, 0x0009, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N720x480_SDTV_RGB_VO[] =3D {
+    0x2A02, 0x0B04,             /* output SDTV_RGB type */
+    0x3E08, 0xFF09, 0x021C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+
+/* PAL */
+
+static u16 VT1622A_P640x480_SDTV_RGB_VN[] =3D {
+    0x2A02, 0x0804,             /* output SDTV_RGB type */
+    0x9508, 0x0009, 0x001C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+
+};
+
+static u16 VT1622A_P800x600_SDTV_RGB_VN[] =3D {
+    0x2A02, 0x0804,             /* output SDTV_RGB type */
+    0xAE08, 0x1B09, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+
+};
+
+static u16 VT1622A_P1024x768_SDTV_RGB_VN[] =3D {
+    0x2A02, 0x0804,             /* output SDTV_RGB type */
+    0x1C08, 0x0D09, 0x051C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P848x480_SDTV_RGB_VN[] =3D {
+    0x2A02, 0x0804,             /* output SDTV_RGB type */
+    0xDE08, 0x0F09, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P720x576_SDTV_RGB_VN[] =3D {=20
+    0x2A02, 0x0804,             /* output SDTV_RGB type */
+    0x9708, 0x0009, 0x001C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P640x480_SDTV_RGB_VF[] =3D {
+    0x2A02, 0x0804,             /* output SDTV_RGB type */
+    0x8B08, 0x0109, 0x001C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P800x600_SDTV_RGB_VF[] =3D {
+    0x2A02, 0x0804,             /* output SDTV_RGB type */
+    0xA908, 0x1D09, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P1024x768_SDTV_RGB_VF[] =3D {
+    0x2A02, 0x0804,             /* output SDTV_RGB type */
+    0xE908, 0x1009, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+
+};
+
+static u16 VT1622A_P848x480_SDTV_RGB_VF[] =3D {
+    0x2A02, 0x0804,             /* output SDTV_RGB type */
+    0xBC08, 0x1209, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P720x576_SDTV_RGB_VF[] =3D {
+    0x2A02, 0x0804,             /* output SDTV_RGB type */
+    0xA208, 0x0009, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P640x480_SDTV_RGB_VO[] =3D {
+    0x2A02, 0x0804,             /* output SDTV_RGB type */
+    0x6808, 0x0009, 0x001C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P800x600_SDTV_RGB_VO[] =3D {
+    0x2A02, 0x0804,             /* output SDTV_RGB type */
+    0x9108, 0x0009, 0x001C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P1024x768_SDTV_RGB_VO[] =3D {
+    0x2A02, 0x0804,             /* output SDTV_RGB type */
+    0xBC08, 0x0009, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P848x480_SDTV_RGB_VO[] =3D {
+    0x2A02, 0x0804,             /* output SDTV_RGB type */
+    0x9208, 0x0309, 0x001C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P720x576_SDTV_RGB_VO[] =3D {
+    0x2A02, 0x0804,             /* output SDTV_RGB type */
+    0x8108, 0x0009, 0x001C,     /* adjust TV's Position */=20
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+/***********************************/
+/* VT1622A output SDTV_YPBPR Table */
+/***********************************/
+
+/* NTSC */
+
+static u16 VT1622A_N640x480_SDTV_YPBPR_VN[] =3D {
+    0x0B02, 0x0B04,             /* output SDTV_YPBPR type */
+    0x8C08, 0x1409, 0x001C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor =
*/
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N800x600_SDTV_YPBPR_VN[] =3D {
+    0x0B02, 0x0B04,             /* output SDTV_YPBPR type */
+    0xC408, 0x1209, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor =
*/
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N1024x768_SDTV_YPBPR_VN[] =3D {
+    0x0B02, 0x0B04,             /* output SDTV_YPBPR type */
+    0x0C08, 0x0E09, 0x051C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor =
*/
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N848x480_SDTV_YPBPR_VN[] =3D {
+    0x0B02, 0x0B04,             /* output SDTV_YPBPR type */
+    0xB508, 0x0009, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor =
*/
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N720x480_SDTV_YPBPR_VN[] =3D {
+    0x0B02, 0x0B04,             /* output SDTV_YPBPR type */
+    0xA908, 0x0109, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor =
*/
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N640x480_SDTV_YPBPR_VF[] =3D {
+    0x0B02, 0x0B04,             /* output SDTV_YPBPR type */
+    0x7B08, 0x0109, 0x001C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor =
*/
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N800x600_SDTV_YPBPR_VF[] =3D {
+    0x0B02, 0x0B04,             /* output SDTV_YPBPR type */
+    0x8B08, 0xFA09, 0x031C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor =
*/
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N1024x768_SDTV_YPBPR_VF[] =3D {
+    0x0B02, 0x0B04,             /* output SDTV_YPBPR type */
+    0xD408, 0x0D09, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor =
*/
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N848x480_SDTV_YPBPR_VF[] =3D {
+    0x0B02, 0x0B04,             /* output SDTV_YPBPR type */
+    0xA808, 0x0609, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor =
*/
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N720x480_SDTV_YPBPR_VF[] =3D {
+    0x0B02, 0x0B04,             /* output SDTV_YPBPR type */
+    0x8C08, 0x0809, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor =
*/
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N640x480_SDTV_YPBPR_VO[] =3D {
+    0x0B02, 0x0B04,             /* output SDTV_YPBPR type */=20
+    0x5708, 0xF109, 0x021C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor =
*/
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N800x600_SDTV_YPBPR_VO[] =3D {
+    0x0B02, 0x0B04,             /* output SDTV_YPBPR type */
+    0x7208, 0xF809, 0x031C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor =
*/
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N1024x768_SDTV_YPBPR_VO[] =3D {
+    0x0B02, 0x0B04,             /* output SDTV_YPBPR type */
+    0xAE08, 0x0209, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor =
*/
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N848x480_SDTV_YPBPR_VO[] =3D {
+    0x0B02, 0x0B04,             /* output SDTV_YPBPR type */
+    0x9708, 0x1209, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor =
*/
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N720x480_SDTV_YPBPR_VO[] =3D {
+    0x0B02, 0x0B04,             /* output SDTV_YPBPR type */
+    0x3E08, 0xFF09, 0x021C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor =
*/
+    0xFFFF                      /* End symbol */
+};
+
+
+
+/* PAL */
+
+
+static u16 VT1622A_P640x480_SDTV_YPBPR_VN[] =3D {
+    0x0B02, 0x0804,             /* output SDTV_YPBPR type */
+    0x9508, 0x0009, 0x001C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor =
*/
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P800x600_SDTV_YPBPR_VN[] =3D {
+    0x0B02, 0x0804,             /* output SDTV_YPBPR type */
+    0xAE08, 0x1B09, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor =
*/
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P1024x768_SDTV_YPBPR_VN[] =3D {
+    0x0B02, 0x0804,             /* output SDTV_YPBPR type */
+    0x1E08, 0x0C09, 0x051C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor =
*/
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P848x480_SDTV_YPBPR_VN[] =3D {=20
+    0x0B02, 0x0804,             /* output SDTV_YPBPR type */
+    0xDE08, 0x0F09, 0x001C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor =
*/
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P720x576_SDTV_YPBPR_VN[] =3D {
+    0x0B02, 0x0804,             /* output SDTV_YPBPR type */
+    0x9708, 0x0009, 0x001C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor =
*/
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P640x480_SDTV_YPBPR_VF[] =3D {
+    0x0B02, 0x0804,             /* output SDTV_YPBPR type */
+    0x8B08, 0x0109, 0x001C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor =
*/
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P800x600_SDTV_YPBPR_VF[] =3D {
+    0x0B02, 0x0804,             /* output SDTV_YPBPR type */
+    0xA908, 0x2309, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor =
*/
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P1024x768_SDTV_YPBPR_VF[] =3D {
+    0x0B02, 0x0804,             /* output SDTV_YPBPR type */
+    0xE908, 0x1209, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor =
*/
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P848x480_SDTV_YPBPR_VF[] =3D {
+    0x0B02, 0x0804,             /* output SDTV_YPBPR type */
+    0xBC08, 0x1209, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor =
*/
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P720x576_SDTV_YPBPR_VF[] =3D {
+    0x0B02, 0x0804,             /* output SDTV_YPBPR type */
+    0xA208, 0x0009, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor =
*/
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P640x480_SDTV_YPBPR_VO[] =3D {
+    0x0B02, 0x0804,             /* output SDTV_YPBPR type */
+    0x6808, 0x0009, 0x001C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor =
*/
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P800x600_SDTV_YPBPR_VO[] =3D {
+    0x0B02, 0x0804,             /* output SDTV_YPBPR type */
+    0x9508, 0x0009, 0x001C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor =
*/
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P1024x768_SDTV_YPBPR_VO[] =3D {
+    0x0B02, 0x0804,             /* output SDTV_YPBPR type */
+    0xBC08, 0x0009, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor =
*/
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P848x480_SDTV_YPBPR_VO[] =3D {
+    0x0B02, 0x0804,             /* output SDTV_YPBPR type */
+    0x9208, 0x0309, 0x001C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor =
*/
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P720x576_SDTV_YPBPR_VO[] =3D {
+    0x0B02, 0x0804,             /* output SDTV_YPBPR type */
+    0x9508, 0x0009, 0x001C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY =3D 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor =
*/
+    0xFFFF                      /* End symbol */
+};
+
+/***********************************/
+/* VT1622A DeDotCrawl Table        */
+/***********************************/
+
+/* NTSC */
+
+static u16 VT1622A_N640x480_DeDotCrawl_VN[] =3D {
+    0xBE16, 0x8717,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N800x600_DeDotCrawl_VN[] =3D {
+    0x1216, 0x4917,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N1024x768_DeDotCrawl_VN[] =3D {
+    0x1816, 0x6117,             /* adjust TV FSCI */=20
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N848x480_DeDotCrawl_VN[] =3D {
+    0x5B16, 0xA017,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N720x480_DeDotCrawl_VN[] =3D {
+    0xC316, 0x4C17,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N640x480_DeDotCrawl_VF[] =3D {
+    0x5016, 0x7B17,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N800x600_DeDotCrawl_VF[] =3D {
+    0xD116, 0xF617,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N1024x768_DeDotCrawl_VF[] =3D {
+    0x0616, 0x8417,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N848x480_DeDotCrawl_VF[] =3D {
+    0x1C16, 0x7D17,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N720x480_DeDotCrawl_VF[] =3D {
+    0xE816, 0xEB17,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N640x480_DeDotCrawl_VO[] =3D {
+    0xE516, 0xA017,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N800x600_DeDotCrawl_VO[] =3D {
+    0xA116, 0x5917,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N1024x768_DeDotCrawl_VO[] =3D {
+    0x1116, 0xE217,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N848x480_DeDotCrawl_VO[] =3D {
+    0x6716, 0x3017,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N720x480_DeDotCrawl_VO[] =3D {
+    0x1E16, 0x5C17,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+
+static vt1622a_func_table vt1622a_ntsc_640x480_tbl[] =3D {
+    {TV_BASE_FUNC,         VT1622A_N640x480_VN,            =
VT1622A_N640x480_VF,            VT1622A_N640x480_VO},
+    {TV_RGB_FUNC,          VT1622A_N640x480_RGB_VN,        =
VT1622A_N640x480_RGB_VF,        VT1622A_N640x480_RGB_VO},
+    {TV_YPBPR_FUNC,        VT1622A_N640x480_YPBPR_VN,      =
VT1622A_N640x480_YPBPR_VF,      VT1622A_N640x480_YPBPR_VO},
+    {TV_SDTV_RGB_FUNC,     VT1622A_N640x480_SDTV_RGB_VN,   =
VT1622A_N640x480_SDTV_RGB_VF,   VT1622A_N640x480_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1622A_N640x480_SDTV_YPBPR_VN, =
VT1622A_N640x480_SDTV_YPBPR_VF, VT1622A_N640x480_SDTV_YPBPR_VO},
+    {TV_DeDotCrawl_FUNC,   VT1622A_N640x480_DeDotCrawl_VN, =
VT1622A_N640x480_DeDotCrawl_VF, VT1622A_N640x480_DeDotCrawl_VO}
+};
+
+static vt1622a_func_table vt1622a_ntsc_800x600_tbl[] =3D {
+    {TV_BASE_FUNC,         VT1622A_N800x600_VN,            =
VT1622A_N800x600_VF,            VT1622A_N800x600_VO},
+    {TV_RGB_FUNC,          VT1622A_N800x600_RGB_VN,        =
VT1622A_N800x600_RGB_VF,        VT1622A_N800x600_RGB_VO},
+    {TV_YPBPR_FUNC,        VT1622A_N800x600_YPBPR_VN,      =
VT1622A_N800x600_YPBPR_VF,      VT1622A_N800x600_YPBPR_VO},
+    {TV_SDTV_RGB_FUNC,     VT1622A_N800x600_SDTV_RGB_VN,   =
VT1622A_N800x600_SDTV_RGB_VF,   VT1622A_N800x600_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1622A_N800x600_SDTV_YPBPR_VN, =
VT1622A_N800x600_SDTV_YPBPR_VF, VT1622A_N800x600_SDTV_YPBPR_VO},
+    {TV_DeDotCrawl_FUNC,   VT1622A_N800x600_DeDotCrawl_VN, =
VT1622A_N800x600_DeDotCrawl_VF, VT1622A_N800x600_DeDotCrawl_VO}
+};
+
+static vt1622a_func_table vt1622a_ntsc_1024x768_tbl[]=3D {
+    {TV_BASE_FUNC,         VT1622A_N1024x768_VN,            =
VT1622A_N1024x768_VF,            VT1622A_N1024x768_VO},
+    {TV_RGB_FUNC,          VT1622A_N1024x768_RGB_VN,        =
VT1622A_N1024x768_RGB_VF,        VT1622A_N1024x768_RGB_VO},
+    {TV_YPBPR_FUNC,        VT1622A_N1024x768_YPBPR_VN,      =
VT1622A_N1024x768_YPBPR_VF,      VT1622A_N1024x768_YPBPR_VO},
+    {TV_SDTV_RGB_FUNC,     VT1622A_N1024x768_SDTV_RGB_VN,   =
VT1622A_N1024x768_SDTV_RGB_VF,   VT1622A_N1024x768_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1622A_N1024x768_SDTV_YPBPR_VN, =
VT1622A_N1024x768_SDTV_YPBPR_VF, VT1622A_N1024x768_SDTV_YPBPR_VO},
+    {TV_DeDotCrawl_FUNC,   VT1622A_N1024x768_DeDotCrawl_VN, =
VT1622A_N1024x768_DeDotCrawl_VF, VT1622A_N1024x768_DeDotCrawl_VO}
+};
+
+static vt1622a_func_table vt1622a_ntsc_848x480_tbl[] =3D {
+    {TV_BASE_FUNC,         VT1622A_N848x480_VN,             =
VT1622A_N848x480_VF,             VT1622A_N848x480_VO},
+    {TV_RGB_FUNC,          VT1622A_N848x480_RGB_VN,         =
VT1622A_N848x480_RGB_VF,         VT1622A_N848x480_RGB_VO},
+    {TV_YPBPR_FUNC,        VT1622A_N848x480_YPBPR_VN,       =
VT1622A_N848x480_YPBPR_VF,       VT1622A_N848x480_YPBPR_VO},
+    {TV_SDTV_RGB_FUNC,     VT1622A_N848x480_SDTV_RGB_VN,    =
VT1622A_N848x480_SDTV_RGB_VF,    VT1622A_N848x480_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1622A_N848x480_SDTV_YPBPR_VN,  =
VT1622A_N848x480_SDTV_YPBPR_VF,  VT1622A_N848x480_SDTV_YPBPR_VO},
+    {TV_DeDotCrawl_FUNC,   VT1622A_N848x480_DeDotCrawl_VN,  =
VT1622A_N848x480_DeDotCrawl_VF,  VT1622A_N848x480_DeDotCrawl_VO}
+};
+
+static vt1622a_func_table vt1622a_ntsc_720x480_tbl[] =3D {
+    {TV_BASE_FUNC,         VT1622A_N720x480_VN,             =
VT1622A_N720x480_VF,             VT1622A_N720x480_VO},
+    {TV_RGB_FUNC,          VT1622A_N720x480_RGB_VN,         =
VT1622A_N720x480_RGB_VF,         VT1622A_N720x480_RGB_VO},
+    {TV_YPBPR_FUNC,        VT1622A_N720x480_YPBPR_VN,       =
VT1622A_N720x480_YPBPR_VF,       VT1622A_N720x480_YPBPR_VO},
+    {TV_SDTV_RGB_FUNC,     VT1622A_N720x480_SDTV_RGB_VN,    =
VT1622A_N720x480_SDTV_RGB_VF,    VT1622A_N720x480_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1622A_N720x480_SDTV_YPBPR_VN,  =
VT1622A_N720x480_SDTV_YPBPR_VF,  VT1622A_N720x480_SDTV_YPBPR_VO},
+    {TV_DeDotCrawl_FUNC,   VT1622A_N720x480_DeDotCrawl_VN,  =
VT1622A_N720x480_DeDotCrawl_VF,  VT1622A_N720x480_DeDotCrawl_VO}
+};
+
+static vt1622a_func_table vt1622a_pal_640x480_tbl[] =3D {
+    {TV_BASE_FUNC,         VT1622A_P640x480_VN,             =
VT1622A_P640x480_VF,             VT1622A_P640x480_VO},
+    {TV_RGB_FUNC,          VT1622A_P640x480_RGB_VN,         =
VT1622A_P640x480_RGB_VF,         VT1622A_P640x480_RGB_VO},
+    {TV_YPBPR_FUNC,        VT1622A_P640x480_YPBPR_VN,       =
VT1622A_P640x480_YPBPR_VF,       VT1622A_P640x480_YPBPR_VO},
+    {TV_SDTV_RGB_FUNC,     VT1622A_P640x480_SDTV_RGB_VN,    =
VT1622A_P640x480_SDTV_RGB_VF,    VT1622A_P640x480_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1622A_P640x480_SDTV_YPBPR_VN,  =
VT1622A_P640x480_SDTV_YPBPR_VF,  VT1622A_P640x480_SDTV_YPBPR_VO}
+};
+
+static vt1622a_func_table vt1622a_pal_800x600_tbl[] =3D {
+    {TV_BASE_FUNC,         VT1622A_P800x600_VN,             =
VT1622A_P800x600_VF,             VT1622A_P800x600_VO},
+    {TV_RGB_FUNC,          VT1622A_P800x600_RGB_VN,         =
VT1622A_P800x600_RGB_VF,         VT1622A_P800x600_RGB_VO},
+    {TV_YPBPR_FUNC,        VT1622A_P800x600_YPBPR_VN,       =
VT1622A_P800x600_YPBPR_VF,       VT1622A_P800x600_YPBPR_VO},
+    {TV_SDTV_RGB_FUNC,     VT1622A_P800x600_SDTV_RGB_VN,    =
VT1622A_P800x600_SDTV_RGB_VF,    VT1622A_P800x600_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1622A_P800x600_SDTV_YPBPR_VN,  =
VT1622A_P800x600_SDTV_YPBPR_VF,  VT1622A_P800x600_SDTV_YPBPR_VO}
+};
+
+static vt1622a_func_table vt1622a_pal_1024x768_tbl[] =3D {
+    {TV_BASE_FUNC,         VT1622A_P1024x768_VN,             =
VT1622A_P1024x768_VF,             VT1622A_P1024x768_VO},
+    {TV_RGB_FUNC,          VT1622A_P1024x768_RGB_VN,         =
VT1622A_P1024x768_RGB_VF,         VT1622A_P1024x768_RGB_VO},
+    {TV_YPBPR_FUNC,        VT1622A_P1024x768_YPBPR_VN,       =
VT1622A_P1024x768_YPBPR_VF,       VT1622A_P1024x768_YPBPR_VO},
+    {TV_SDTV_RGB_FUNC,     VT1622A_P1024x768_SDTV_RGB_VN,    =
VT1622A_P1024x768_SDTV_RGB_VF,    VT1622A_P1024x768_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1622A_P1024x768_SDTV_YPBPR_VN,  =
VT1622A_P1024x768_SDTV_YPBPR_VF,  VT1622A_P1024x768_SDTV_YPBPR_VO}
+};
+
+static vt1622a_func_table vt1622a_pal_848x480_tbl[] =3D {
+    {TV_BASE_FUNC,         VT1622A_P848x480_VN,             =
VT1622A_P848x480_VF,             VT1622A_P848x480_VO},
+    {TV_RGB_FUNC,          VT1622A_P848x480_RGB_VN,         =
VT1622A_P848x480_RGB_VF,         VT1622A_P848x480_RGB_VO},
+    {TV_YPBPR_FUNC,        VT1622A_P848x480_YPBPR_VN,       =
VT1622A_P848x480_YPBPR_VF,       VT1622A_P848x480_YPBPR_VO},
+    {TV_SDTV_RGB_FUNC,     VT1622A_P848x480_SDTV_RGB_VN,    =
VT1622A_P848x480_SDTV_RGB_VF,    VT1622A_P848x480_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1622A_P848x480_SDTV_YPBPR_VN,  =
VT1622A_P848x480_SDTV_YPBPR_VF,  VT1622A_P848x480_SDTV_YPBPR_VO}
+};
+
+static vt1622a_func_table vt1622a_pal_720x576_tbl[] =3D {
+    {TV_BASE_FUNC,         VT1622A_P720x576_VN,             =
VT1622A_P720x576_VF,             VT1622A_P720x576_VO},
+    {TV_RGB_FUNC,          VT1622A_P720x576_RGB_VN,         =
VT1622A_P720x576_RGB_VF,         VT1622A_P720x576_RGB_VO},
+    {TV_YPBPR_FUNC,        VT1622A_P720x576_YPBPR_VN,       =
VT1622A_P720x576_YPBPR_VF,       VT1622A_P720x576_YPBPR_VO},
+    {TV_SDTV_RGB_FUNC,     VT1622A_P720x576_SDTV_RGB_VN,    =
VT1622A_P720x576_SDTV_RGB_VF,    VT1622A_P720x576_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1622A_P720x576_SDTV_YPBPR_VN,  =
VT1622A_P720x576_SDTV_YPBPR_VF,  VT1622A_P720x576_SDTV_YPBPR_VO}
+};
+
+
+static struct vt1622a_table vt1622a_tbl[] =3D {
+    {VIA_RES_640X480,             vt1622a_ntsc_640x480_tbl,    =
vt1622a_pal_640x480_tbl},
+    {VIA_RES_800X600,             vt1622a_ntsc_800x600_tbl,    =
vt1622a_pal_800x600_tbl},
+    {VIA_RES_1024X768,            vt1622a_ntsc_1024x768_tbl,   =
vt1622a_pal_1024x768_tbl},
+    {VIA_RES_848X480,             vt1622a_ntsc_848x480_tbl,    =
vt1622a_pal_848x480_tbl},
+    {VIA_RES_720X480,             vt1622a_ntsc_720x480_tbl,    =
vt1622a_ntsc_720x480_tbl},
+    {VIA_RES_720X576,             vt1622a_pal_720x576_tbl,     =
vt1622a_pal_720x576_tbl}
+};
+
+#define NUM_TOTAL_VT1622A_TABLE ARRAY_SIZE(vt1622a_tbl)
+
+#endif /* __TBL1622A_H__ */
diff -Nur linux-2.6.21-rc7/drivers/video/via/tbl1622.h =
linux-2.6.21-rc7.viafb/drivers/video/via/tbl1622.h
--- linux-2.6.21-rc7/drivers/video/via/tbl1622.h 1969-12-31 =
19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/tbl1622.h 2007-04-26 =
19:52:32.000000000 -0400
@@ -0,0 +1,1670 @@
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
+
+=20
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
+static u16 VT1622_N640x480_VN[] =3D {
+                                               =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0x0F50, 0x8151, 0x2352, 0x5753, 0x0254,     /* TV.50-54 */
+    0x0F55, 0x2956, 0x7357, 0x2358, 0x8659,     /* TV.55-59 */
+    0xC45A, 0xEA5B, 0xDF5C, 0x055D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x925E, 0xA15F, 0x0460, 0x0061, 0x0062,     /* TV.5E-62 */
+    0x7F63, 0x0364,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    784, 640, 640, 144, 656, 56,  600, 480, 480, 120, 488, 7
+};
+
+#define NUM_TOTAL_VT1622_REG ARRAY_SIZE(VT1622_N640x480_VN) =
-NUM_CRTC_TIMING
+
+static u16 VT1622_N800x600_VN[] =3D {
+                                                 =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0x2750, 0x2151, 0x3452, 0xED53, 0x0254,     /* TV.50-54 */
+    0x2755, 0xF556, 0x9D57, 0x2458, 0xB759,     /* TV.55-59 */
+    0x0D5A, 0x405B, 0x005C, 0x585D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0xB65E, 0x3B5F, 0x0560, 0x0061, 0x0162,     /* TV.5E-62 */
+    0xEF63, 0x0564,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1064,800, 800, 264, 840, 136, 750, 600, 600, 150, 606, 16
+};
+
+static u16 VT1622_N1024x768_VN[] =3D {
+                                                 =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0x8750, 0xFF51, 0x3452, 0xB053, 0x0354,     /* TV.50-54 */
+    0x6F55, 0xDB56, 0xCD57, 0x3558, 0xF159,     /* TV.55-59 */
+    0x5E5A, 0xA55B, 0x7E5C, 0x5A5D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x335E, 0x265F, 0x0760, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x2763, 0x0864,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1160,1024,1024,136, 1040,56,  945, 768, 768, 177, 789, 6
+};
+
+static u16 VT1622_N848x480_VN[] =3D {
+                                                 =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xAF50, 0x5151, 0x3452, 0x4453, 0x0254,     /* TV.50-54 */
+    0xE355, 0xC156, 0x9357, 0x2358, 0xAD59,     /* TV.55-59 */
+    0xFD5A, 0x2B5B, 0x7C5C, 0x175D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x6D5E, 0xCA5F, 0x0460, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x2F63, 0x0564,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1200,848, 848, 352, 872, 64,  581, 480, 480, 101, 496, 13
+};
+
+static u16 VT1622_N720x480_VN[] =3D {
+                                                 =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0x4750, 0xD151, 0x2352, 0x5753, 0x0254,     /* TV.50-54 */
+    0xBF55, 0xAF56, 0x8D57, 0x2358, 0xA459,     /* TV.55-59 */
+    0xF35A, 0x205B, 0x365C, 0x175D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x925E, 0x335F, 0x0460, 0x0061, 0x0062,     /* TV.5E-62 */
+    0xBF63, 0x0364,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    840, 720, 720, 120, 728, 48,  600, 480, 480, 120, 512, 7
+};
+
+static u16 VT1622_P640x480_VN[] =3D {
+                                               =20
+    0x0400, 0x0001, 0x0002, 0x8203, 0x0004,     /* TV.00-04 */
+    0x0005, 0x1006, 0x3E07, 0xA408, 0x3709,     /* TV.05-09 */
+    0x670A, 0x000B, 0x490C, 0x490D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xEC12, 0x2A13,     /* TV.0F-13 */
+    0xB814, 0x2915, 0x2D16, 0x7717, 0x6618,     /* TV.14-18 */=20
+    0x2D19,                                     /* TV.19 */
+    0x031B, 0x0A1C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x041F, 0x1220, 0x0C21, 0x0422,     /* TV.1E-22 */
+    0x7B23, 0x0024,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0xF94A, 0x504B, 0x044C, 0x004D, 0x004E,     /* TV.4A-4E */
+    0x454F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xE750, 0x8151, 0x2352, 0x5753, 0x0254,     /* TV.50-54 */
+    0x1F55, 0x3156, 0x7557, 0x2358, 0x8A59,     /* TV.55-59 */
+    0xC85A, 0xF05B, 0xFF5C, 0x055D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0xD75E, 0x8E5F, 0x0360, 0x7F61, 0xCF62,     /* TV.5E-62 */
+    0xBF63, 0x0364,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1000,640, 640, 360, 680, 72,  600, 480, 480, 120, 521, 5
+};
+
+static u16 VT1622_P800x600_VN[] =3D {
+                                               =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0x9750, 0x2151, 0x3352, 0xED53, 0x0254,     /* TV.50-54 */
+    0x9755, 0x8756, 0x8757, 0x2358, 0x9F59,     /* TV.55-59 */
+    0xE75A, 0x165B, 0xE75C, 0x165D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0xCC5E, 0xF35F, 0x0460, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x4F63, 0x0464,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    920, 800, 800, 120, 816, 64,  750, 600, 600, 150, 606, 16
+};
+
+static u16 VT1622_P1024x768_VN[] =3D {
+                                               =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xAF50, 0xFF51, 0x3452, 0xB553, 0x0354,     /* TV.50-54 */
+    0x5755, 0xA856, 0xC857, 0x3558, 0xEC59,     /* TV.55-59 */
+    0x4C5A, 0xCC5B, 0x675C, 0x5A5D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x145E, 0x5C5F, 0x0660, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x1F63, 0x0764,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1200,1024,1024,176, 1040,80,  950, 768, 768, 182, 802, 3
+};
+
+static u16 VT1622_P848x480_VN[] =3D {
+                                               =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xAF50, 0x5151, 0x3452, 0x5753, 0x0254,     /* TV.50-54 */
+    0x7F55, 0x4F56, 0xA957, 0x3458, 0xD159,     /* TV.55-59 */
+    0x2B5A, 0x5D5B, 0xAA5C, 0x585D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0xD75E, 0x015F, 0x0360, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x7F63, 0x0464,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1200,848, 848, 352, 976, 56,  600, 480, 480, 120, 499, 11
+};
+
+static u16 VT1622_P720x576_VN[] =3D {
+                                               =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xF750, 0xD151, 0x2252, 0xED53, 0x0254,     /* TV.50-54 */
+    0x1D55, 0x2956, 0x7557, 0x2358, 0x8859,     /* TV.55-59 */
+    0xC65A, 0xF05B, 0xFA5C, 0x0F5D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
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
+static u16 VT1622_N640x480_VF[] =3D {
+                                               =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0x4750, 0x8151, 0x2352, 0x3E53, 0x0254,     /* TV.50-54 */
+    0x2455, 0x6556, 0x7757, 0x2358, 0x8859,     /* TV.55-59 */
+    0xCB5A, 0x025B, 0x155C, 0x165D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x625E, 0x2E5F, 0x0460, 0x0061, 0x0062,     /* TV.5E-62 */
+    0x9763, 0x0364,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    840, 640, 640, 200, 672, 56,  575, 480, 480, 95,  499, 7
+};
+
+static u16 VT1622_N800x600_VF[] =3D {
+                                               =20
+    0x8400, 0x0001, 0x0002, 0x2403, 0x0304,     /*/ TV.00-04 */
+    0x0005, 0x1006, 0x5007, 0xA108, 0xFE09,     /*/ TV.05-09 */
+    0x630A, 0x170B, 0x460C, 0x470D, 0x0F0E,     /*/ TV.0A-0E */=20
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
+                                                /*/ Set Video Timing =
(TV Timing Regsiter ) */
+    0xAF50, 0x1F51, 0x3452, 0xD753, 0x0254,     /*/ TV.50-54 */
+    0x7F55, 0xA956, 0x8457, 0x2358, 0x9859,     /*/ TV.55-59 */
+    0xE35A, 0x1A5B, 0xB25C, 0x165D,             /*/ TV.5A-5D */
+                                                /*/ Set Video Timing =
(TV CRTC Regsiter ) */
+    0x8C5E, 0xB25F, 0x0560, 0x0061, 0x0162,     /*/ TV.5E-62 */
+    0x7F63, 0x0664,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1200,800, 800, 400, 864, 200, 728, 600, 600, 128, 656, 9
+};
+
+static u16 VT1622_N1024x768_VF[] =3D {
+                                               =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0x9750, 0xFF51, 0x3452, 0x9C53, 0x0354,     /* TV.50-54 */
+    0x0E55, 0xDE56, 0xBF57, 0x3558, 0xDD59,     /* TV.55-59 */
+    0x495A, 0x995B, 0xCE5C, 0x595D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x0C5E, 0x235F, 0x0760, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x1763, 0x0864,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1176,1024,1024,152, 1040,64,  925, 768, 768, 157, 779, 12
+};
+
+static u16 VT1622_N848x480_VF[] =3D {
+                                               =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xEF50, 0x5151, 0x3352, 0x3653, 0x0254,     /* TV.50-54 */
+    0x3755, 0x3956, 0x9F57, 0x3458, 0xB759,     /* TV.55-59 */
+    0x125A, 0x575B, 0x2C5C, 0x585D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x525E, 0x1A5F, 0x0460, 0x0061, 0x0062,     /* TV.5E-62 */
+    0x3763, 0x0464,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1000,848, 848, 152, 856, 56,  567, 480, 480, 87,  485, 7
+};
+
+static u16 VT1622_N720x480_VF[] =3D {
+                                               =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0x4750, 0xD151, 0x2352, 0x3E53, 0x0254,     /* TV.50-54 */
+    0x9755, 0xBF56, 0x8857, 0x2358, 0x9C59,     /* TV.55-59 */
+    0xE95A, 0x265B, 0xF55C, 0x165D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x625E, 0x175F, 0x0460, 0x0061, 0x0062,     /* TV.5E-62 */
+    0x9763, 0x0364,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    840, 720, 720, 120, 728, 48,  575, 480, 480, 95,  484, 15
+};
+
+static u16 VT1622_P640x480_VF[] =3D {
+                                               =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xE750, 0x8151, 0x2352, 0x3E53, 0x0254,     /* TV.50-54 */
+    0x2455, 0x5E56, 0x7657, 0x2358, 0x8959,     /* TV.55-59 */
+    0xC25A, 0x145B, 0x1C5C, 0x165D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0xAE5E, 0x3A5F, 0x0360, 0x0061, 0x0062,     /* TV.5E-62 */
+    0x9763, 0x0364,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1000,640, 640, 360, 680, 80,  575, 480, 480, 95,  501, 3
+};
+
+static u16 VT1622_P800x600_VF[] =3D {
+                                               =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xE750, 0x2151, 0x3352, 0xD453, 0x0254,     /* TV.50-54 */
+    0xF655, 0xFC56, 0x9557, 0x2358, 0xAE59,     /* TV.55-59 */
+    0xF55A, 0x595B, 0xB65C, 0x175D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0xA45E, 0x315F, 0x0460, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x8763, 0x0464,                             /* TV.63-64 */
+=20
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1000,800, 800, 200, 832, 80,  725, 600, 600, 125, 602, 1
+};
+
+static u16 VT1622_P1024x768_VF[] =3D {
+                                               =20
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
+    0xDD4A, 0x604B, 0x044C, 0x004D, 0x004E,     /* TV.4A-4E */=20
+    0x434F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xAF50, 0xFF51, 0x3452, 0x9C53, 0x0354,     /* TV.50-54 */
+    0x3355, 0xEA56, 0xC357, 0x3558, 0xE959,     /* TV.55-59 */
+    0x515A, 0x935B, 0x095C, 0x5A5D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0xEB5E, 0x165F, 0x0560, 0x0061, 0x0162,     /* TV.5E-62 */
+    0xEF63, 0x0664,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1200,1024,1024,176, 1040,72,  925, 768, 768, 157, 782, 13
+};
+
+static u16 VT1622_P848x480_VF[] =3D {
+                                               =20
+    0x8400, 0x0001, 0x0002, 0xC003, 0x0004,     /* TV.00-04 */
+    0x0005, 0x1006, 0x5707, 0xD108, 0x3E09,     /* TV.05-09 */
+    0x710A, 0x000B, 0x4E0C, 0x500D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xE512, 0x2A13,     /* TV.0F-13 */
+    0xFD14, 0x1415, 0x9316, 0x1317, 0xE618,     /* TV.14-18 */
+    0x2019,                                     /* TV.19 */
+    0x031B, 0x0B1C, 0x801D,                     /* TV.1B-1D */=20
+    0x001E, 0x841F, 0x0F20, 0x0C21, 0x0422,     /* TV.1E-22 */
+    0x7B23, 0x0024,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0xE74A, 0x454B, 0x044C, 0x004D, 0x004E,     /* TV.4A-4E */
+    0x464F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xAF50, 0x5151, 0x3452, 0x3E53, 0x0254,     /* TV.50-54 */
+    0x4F55, 0x3A56, 0xA257, 0x3458, 0xBE59,     /* TV.55-59 */
+    0x0B5A, 0x765B, 0x645C, 0x585D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0xAE5E, 0x1A5F, 0x0360, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x4F63, 0x0464,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1200,848, 848, 352, 856, 56,  575, 480, 480, 95,  495, 25
+};
+
+static u16 VT1622_P720x576_VF[] =3D {
+                                               =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xE750, 0xD151, 0x2352, 0xA253, 0x0254,     /* TV.50-54 */
+    0x5F55, 0x8556, 0x7E57, 0x2358, 0x9459,     /* TV.55-59 */
+    0xD05A, 0x275B, 0x8F5C, 0x165D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x525E, 0x7A5F, 0x0460, 0x0061, 0x0062,     /* TV.5E-62 */
+    0x3763, 0x0464,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1000,720, 720, 280, 776, 64,  675, 576, 576, 99,  602, 13
+};
+
+/* TV Overscan Table */
+
+static u16 VT1622_N640x480_VO[] =3D {
+                                               =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0x1F50, 0x7F51, 0x2352, 0x0C53, 0x0254,     /* TV.50-54 */
+    0xBB55, 0x3256, 0x6757, 0x2258, 0x7659,     /* TV.55-59 */
+    0xB05A, 0xD25B, 0x2E5C, 0x055D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x005E, 0x8E5F, 0x0060, 0x0061, 0x0062,     /* TV.5E-62 */
+    0x1F63, 0x0364,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    800, 640, 640, 160, 656, 96,  525, 480, 480, 45,  495, 11
+};
+
+static u16 VT1622_N800x600_VO[] =3D {
+                                               =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xE750, 0x1F51, 0x3352, 0x8A53, 0x0254,     /* TV.50-54 */
+    0x6355, 0xB956, 0x8057, 0x2358, 0x9359,     /* TV.55-59 */
+    0xDC5A, 0x0B5B, 0x7D5C, 0x165D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0xF65E, 0x975F, 0x0460, 0x0061, 0x0162,     /* TV.5E-62 */
+    0xD763, 0x0464,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1000,800, 800, 200, 832, 96,  651, 600, 600, 51,  608, 12
+};
+
+static u16 VT1622_N1024x768_VO[] =3D {
+                                               =20
+    0x8400, 0x0001, 0x0002, 0x4403, 0x0304,     /* TV.00-04 */=20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0x5F50, 0xFF51, 0x3452, 0x3853, 0x0354,     /* TV.50-54 */
+    0xCF55, 0xDF56, 0xB657, 0x3458, 0xD259,     /* TV.55-59 */
+    0x395A, 0x815B, 0x405C, 0x595D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x495E, 0x225F, 0x0660, 0x0061, 0x0162,     /* TV.5E-62 */
+    0xDF63, 0x0664,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1120,1024,1024,96,  1040,40,  825, 768, 768, 57,  770, 6
+};
+
+static u16 VT1622_N848x480_VO[] =3D {
+                                               =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xEF50, 0x5151, 0x3352, 0x2553, 0x0254,     /* TV.50-54 */
+    0x1F55, 0x4D56, 0x9C57, 0x3458, 0xB559,     /* TV.55-59 */
+    0x0C5A, 0x3D5B, 0xF15C, 0x575D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x305E, 0x015F, 0x0460, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x1F63, 0x0464,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */=20
+    1008,848, 848, 160, 856, 72,  550, 480, 480, 70,  491, 5
+};
+
+static u16 VT1622_N720x480_VO[] =3D {
+                                               =20
+    0x0400, 0x0001, 0x0002, 0x0203, 0x0304,     /* TV.00-04 */
+    0x0005, 0x1006, 0x1807, 0x2808, 0x0909,     /* TV.05-09 */
+    0x5B0A, 0x170B, 0x460C, 0x410D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xEE12, 0x0D13,     /* TV.0F-13 */=20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0x1F50, 0xCF51, 0x2352, 0x0C53, 0x0254,     /* TV.50-54 */
+    0x1F55, 0xCE56, 0x7657, 0x2358, 0x8859,     /* TV.55-59 */
+    0xC95A, 0xEF5B, 0xFF5C, 0x055D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x005E, 0x005F, 0x0060, 0x0061, 0x0062,     /* TV.5E-62 */
+    0x1F63, 0x0364,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    800, 720, 720, 80,  728, 32,  525, 480, 480, 45,  482, 1
+};
+
+static u16 VT1622_P640x480_VO[] =3D {
+                                               =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xE750, 0x7F51, 0x2352, 0xF353, 0x0154,     /* TV.50-54 */
+    0xCF55, 0x3F56, 0x6957, 0x2258, 0x7A59,     /* TV.55-59 */
+    0xAD5A, 0xF85B, 0x765C, 0x055D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x335E, 0x705F, 0x0360, 0x0061, 0x0062,     /* TV.5E-62 */
+    0x1F63, 0x0364,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1000,640, 640, 360, 800, 120, 500, 480, 480, 20,  485, 6
+};
+
+static u16 VT1622_P800x600_VO[] =3D {
+                                               =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xE750, 0x1F51, 0x3352, 0x8953, 0x0254,     /* TV.50-54 */
+    0xBF55, 0x0056, 0x8D57, 0x3358, 0xA559,     /* TV.55-59 */
+    0xE85A, 0x475B, 0x4B5C, 0x175D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x295E, 0x285F, 0x0460, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x0F63, 0x0464,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1000,800, 800, 200, 872, 56,  650, 600, 600, 50,  608, 12
+};
+
+static u16 VT1622_P1024x768_VO[] =3D {
+                                               =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xAF50, 0xFF51, 0x3452, 0x3853, 0x0354,     /* TV.50-54 */
+    0xCF55, 0xE356, 0xB457, 0x3458, 0xD459,     /* TV.55-59 */
+    0x2B5A, 0xA05B, 0x5E5C, 0x595D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x485E, 0x205F, 0x0560, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x2F63, 0x0664,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1200,1024,1024,176, 1088,56,  825, 768, 768, 57,  771, 5
+};
+
+static u16 VT1622_P848x480_VO[] =3D {
+                                               =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xAF50, 0x4F51, 0x3452, 0x2553, 0x0254,     /* TV.50-54 */
+    0x1F55, 0x4F56, 0x9B57, 0x3458, 0xB759,     /* TV.55-59 */
+    0x0A5A, 0x3F5B, 0xF05C, 0x575D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x855E, 0x005F, 0x0360, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x1F63, 0x0464,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1200,848, 848, 352, 872, 176, 550, 480, 480, 70,  491, 5
+};
+
+static u16 VT1622_P720x576_VO[] =3D {
+                                               =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xE750, 0xCF51, 0x2352, 0x5753, 0x0254,     /* TV.50-54 */
+    0x1F55, 0x8056, 0x7557, 0x2358, 0x8959,     /* TV.55-59 */
+    0xC75A, 0xF15B, 0xFF5C, 0x055D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */=20
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
+static u16 VT1622_N640x480_RGB_VN[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N800x600_RGB_VN[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N1024x768_RGB_VN[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N848x480_RGB_VN[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N720x480_RGB_VN[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N640x480_RGB_VF[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N800x600_RGB_VF[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N1024x768_RGB_VF[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N848x480_RGB_VF[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N720x480_RGB_VF[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N640x480_RGB_VO[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N800x600_RGB_VO[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N1024x768_RGB_VO[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N848x480_RGB_VO[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N720x480_RGB_VO[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+/* PAL */
+
+static u16 VT1622_P640x480_RGB_VN[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P800x600_RGB_VN[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P1024x768_RGB_VN[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P848x480_RGB_VN[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P720x576_RGB_VN[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P640x480_RGB_VF[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P800x600_RGB_VF[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P1024x768_RGB_VF[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P848x480_RGB_VF[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P720x576_RGB_VF[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P640x480_RGB_VO[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P800x600_RGB_VO[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P1024x768_RGB_VO[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P848x480_RGB_VO[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P720x576_RGB_VO[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+/***********************************/
+/* VT1622 output YPBPR Table       */
+/***********************************/
+
+/* NTSC */
+
+static u16 VT1622_N640x480_YPBPR_VN[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N800x600_YPBPR_VN[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x4365, 0x4A66, 0x4967,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N1024x768_YPBPR_VN[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x5865, 0x4B66, 0x4A67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N848x480_YPBPR_VN[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x4465, 0x4566, 0x4567,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+
+};
+
+static u16 VT1622_N720x480_YPBPR_VN[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x4265, 0x4966, 0x4867,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N640x480_YPBPR_VF[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x4F65, 0x4966, 0x4967,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N800x600_YPBPR_VF[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x4265, 0x4566, 0x4567,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N1024x768_YPBPR_VF[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x5765, 0x4566, 0x4567,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N848x480_YPBPR_VF[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x5865, 0x4566, 0x4567,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N720x480_YPBPR_VF[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x4D65, 0x4966, 0x4967,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N640x480_YPBPR_VO[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x4B65, 0x4866, 0x4867,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N800x600_YPBPR_VO[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x4265, 0x4566, 0x4567,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N1024x768_YPBPR_VO[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x5765, 0x4566, 0x4567,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N848x480_YPBPR_VO[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x5865, 0x4566, 0x4567,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N720x480_YPBPR_VO[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x4D65, 0x4966, 0x4967,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+/* PAL */
+
+static u16 VT1622_P640x480_YPBPR_VN[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x4265, 0x4966, 0x4967,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P800x600_YPBPR_VN[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x5865, 0x5E66, 0x5E67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P1024x768_YPBPR_VN[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x5165, 0x4966, 0x4967,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P848x480_YPBPR_VN[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4966, 0x4967,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P720x576_YPBPR_VN[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x5965, 0x4D66, 0x4A67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P640x480_YPBPR_VF[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x4265, 0x4966, 0x4967,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P800x600_YPBPR_VF[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x5865, 0x4866, 0x4867,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P1024x768_YPBPR_VF[] =3D {=20
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x6966, 0x6967,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P848x480_YPBPR_VF[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x4E65, 0x4966, 0x4967,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P720x576_YPBPR_VF[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x5865, 0x4866, 0x4967,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P640x480_YPBPR_VO[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x4265, 0x4966, 0x4967,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P800x600_YPBPR_VO[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x5865, 0x4866, 0x4867,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P1024x768_YPBPR_VO[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x5165, 0x4966, 0x4967,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P848x480_YPBPR_VO[] =3D {
+    0x0302,                     /* output YPBPR type */
+    0x4E65, 0x4966, 0x4967,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P720x576_YPBPR_VO[] =3D {
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
+static u16 VT1622_N640x480_SDTV_RGB_VN[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N800x600_SDTV_RGB_VN[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N1024x768_SDTV_RGB_VN[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N848x480_SDTV_RGB_VN[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N720x480_SDTV_RGB_VN[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N640x480_SDTV_RGB_VF[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N800x600_SDTV_RGB_VF[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N1024x768_SDTV_RGB_VF[]=3D{
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N848x480_SDTV_RGB_VF[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N720x480_SDTV_RGB_VF[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N640x480_SDTV_RGB_VO[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N800x600_SDTV_RGB_VO[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N1024x768_SDTV_RGB_VO[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N848x480_SDTV_RGB_VO[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N720x480_SDTV_RGB_VO[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+/* PAL */
+
+static u16 VT1622_P640x480_SDTV_RGB_VN[] =3D {
+    0xFFFF                      /* End symbol */
+
+};
+
+static u16 VT1622_P800x600_SDTV_RGB_VN[] =3D {
+    0xFFFF                      /* End symbol */
+
+};
+
+static u16 VT1622_P1024x768_SDTV_RGB_VN[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P848x480_SDTV_RGB_VN[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P720x576_SDTV_RGB_VN[] =3D {
+    0xFFFF                      /* End symbol */
+
+};
+
+static u16 VT1622_P640x480_SDTV_RGB_VF[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P800x600_SDTV_RGB_VF[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P1024x768_SDTV_RGB_VF[] =3D {
+    0xFFFF                      /* End symbol */
+
+};
+
+static u16 VT1622_P848x480_SDTV_RGB_VF[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P720x576_SDTV_RGB_VF[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P640x480_SDTV_RGB_VO[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P800x600_SDTV_RGB_VO[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P1024x768_SDTV_RGB_VO[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P848x480_SDTV_RGB_VO[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P720x576_SDTV_RGB_VO[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+/***********************************/
+/* VT1622 output SDTV_YPBPR Table  */
+/***********************************/
+
+/* NTSC */
+
+static u16 VT1622_N640x480_SDTV_YPBPR_VN[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N800x600_SDTV_YPBPR_VN[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N1024x768_SDTV_YPBPR_VN[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N848x480_SDTV_YPBPR_VN[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N720x480_SDTV_YPBPR_VN[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N640x480_SDTV_YPBPR_VF[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N800x600_SDTV_YPBPR_VF[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N1024x768_SDTV_YPBPR_VF[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N848x480_SDTV_YPBPR_VF[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N720x480_SDTV_YPBPR_VF[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N640x480_SDTV_YPBPR_VO[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N800x600_SDTV_YPBPR_VO[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N1024x768_SDTV_YPBPR_VO[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N848x480_SDTV_YPBPR_VO[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N720x480_SDTV_YPBPR_VO[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+/* PAL */
+
+static u16 VT1622_P640x480_SDTV_YPBPR_VN[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P800x600_SDTV_YPBPR_VN[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P1024x768_SDTV_YPBPR_VN[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P848x480_SDTV_YPBPR_VN[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P720x576_SDTV_YPBPR_VN[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P640x480_SDTV_YPBPR_VF[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P800x600_SDTV_YPBPR_VF[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P1024x768_SDTV_YPBPR_VF[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P848x480_SDTV_YPBPR_VF[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P720x576_SDTV_YPBPR_VF[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P640x480_SDTV_YPBPR_VO[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P800x600_SDTV_YPBPR_VO[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P1024x768_SDTV_YPBPR_VO[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P848x480_SDTV_YPBPR_VO[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_P720x576_SDTV_YPBPR_VO[] =3D {
+    0xFFFF                      /* End symbol */
+};
+
+/***********************************/
+/* VT1622 DeDotCrawl Table         */
+/***********************************/
+
+/* NTSC */
+
+static u16 VT1622_N640x480_DeDotCrawl_VN[] =3D {
+    0x0811,                     /* Enable DeDotCrawl (only update bit3 =
of TV.11h register) */
+    0xD516, 0x8D17,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N800x600_DeDotCrawl_VN[] =3D {
+    0x0811,                     /* Enable DeDotCrawl (only update bit3 =
of TV.11h register) */
+    0xA116, 0x5917,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N1024x768_DeDotCrawl_VN[] =3D {
+    0x0811,                     /* Enable DeDotCrawl (only update bit3 =
of TV.11h register) */
+    0x1116, 0xE217,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N848x480_DeDotCrawl_VN[] =3D {
+    0x0811,                     /* Enable DeDotCrawl (only update bit3 =
of TV.11h register) */
+    0x5B16, 0xA017,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N720x480_DeDotCrawl_VN[] =3D {
+    0x0811,                     /* Enable DeDotCrawl (only update bit3 =
of TV.11h register) */
+    0xC316, 0x4C17,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N640x480_DeDotCrawl_VF[] =3D {
+    0x0811,                     /* Enable DeDotCrawl (only update bit3 =
of TV.11h register) */
+    0x5016, 0x7B17,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N800x600_DeDotCrawl_VF[] =3D {
+    0x0811,                     /* Enable DeDotCrawl (only update bit3 =
of TV.11h register) */
+    0xD116, 0xF617,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N1024x768_DeDotCrawl_VF[] =3D {
+    0x0811,                     /* Enable DeDotCrawl (only update bit3 =
of TV.11h register) */
+    0x0616, 0x8417,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N848x480_DeDotCrawl_VF[] =3D {
+    0x0811,                     /* Enable DeDotCrawl (only update bit3 =
of TV.11h register) */
+    0x1C16, 0x7D17,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N720x480_DeDotCrawl_VF[] =3D {
+    0x0811,                     /* Enable DeDotCrawl (only update bit3 =
of TV.11h register) */
+    0xE816, 0xEB17,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N640x480_DeDotCrawl_VO[] =3D {
+    0x0811,                     /* Enable DeDotCrawl (only update bit3 =
of TV.11h register) */
+    0xD516, 0x8D17,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N800x600_DeDotCrawl_VO[] =3D {
+    0x0811,                     /* Enable DeDotCrawl (only update bit3 =
of TV.11h register) */
+    0x1416, 0xC717,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N1024x768_DeDotCrawl_VO[] =3D {
+    0x0811,                     /* Enable DeDotCrawl (only update bit3 =
of TV.11h register) */
+    0x6316, 0x3D17,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N848x480_DeDotCrawl_VO[] =3D {
+    0x0811,                     /* Enable DeDotCrawl (only update bit3 =
of TV.11h register) */
+    0x6716, 0x3017,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622_N720x480_DeDotCrawl_VO[] =3D {
+    0x0811,                     /* Enable DeDotCrawl (only update bit3 =
of TV.11h register) */
+    0x1E16, 0x5C17,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+
+static vt1622_func_table vt1622_ntsc_640x480_tbl[] =3D {
+    {TV_BASE_FUNC,         VT1622_N640x480_VN,            =
VT1622_N640x480_VF,            VT1622_N640x480_VO},
+    {TV_RGB_FUNC,          VT1622_N640x480_RGB_VN,        =
VT1622_N640x480_RGB_VF,        VT1622_N640x480_RGB_VO},
+    {TV_YPBPR_FUNC,        VT1622_N640x480_YPBPR_VN,      =
VT1622_N640x480_YPBPR_VF,      VT1622_N640x480_YPBPR_VO},
+    {TV_SDTV_RGB_FUNC,     VT1622_N640x480_SDTV_RGB_VN,   =
VT1622_N640x480_SDTV_RGB_VF,   VT1622_N640x480_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1622_N640x480_SDTV_YPBPR_VN, =
VT1622_N640x480_SDTV_YPBPR_VF, VT1622_N640x480_SDTV_YPBPR_VO},
+    {TV_DeDotCrawl_FUNC,   VT1622_N640x480_DeDotCrawl_VN, =
VT1622_N640x480_DeDotCrawl_VF, VT1622_N640x480_DeDotCrawl_VO}
+
+};
+
+static vt1622_func_table vt1622_ntsc_800x600_tbl[] =3D {
+    {TV_BASE_FUNC,         VT1622_N800x600_VN,            =
VT1622_N800x600_VF,            VT1622_N800x600_VO},
+    {TV_RGB_FUNC,          VT1622_N800x600_RGB_VN,        =
VT1622_N800x600_RGB_VF,        VT1622_N800x600_RGB_VO},
+    {TV_YPBPR_FUNC,        VT1622_N800x600_YPBPR_VN,      =
VT1622_N800x600_YPBPR_VF,      VT1622_N800x600_YPBPR_VO},
+    {TV_SDTV_RGB_FUNC,     VT1622_N800x600_SDTV_RGB_VN,   =
VT1622_N800x600_SDTV_RGB_VF,   VT1622_N800x600_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1622_N800x600_SDTV_YPBPR_VN, =
VT1622_N800x600_SDTV_YPBPR_VF, VT1622_N800x600_SDTV_YPBPR_VO},
+    {TV_DeDotCrawl_FUNC,   VT1622_N800x600_DeDotCrawl_VN, =
VT1622_N800x600_DeDotCrawl_VF, VT1622_N800x600_DeDotCrawl_VO}
+};
+
+static vt1622_func_table vt1622_ntsc_1024x768_tbl[]=3D {
+    {TV_BASE_FUNC,         VT1622_N1024x768_VN,            =
VT1622_N1024x768_VF,            VT1622_N1024x768_VO},
+    {TV_RGB_FUNC,          VT1622_N1024x768_RGB_VN,        =
VT1622_N1024x768_RGB_VF,        VT1622_N1024x768_RGB_VO},
+    {TV_YPBPR_FUNC,        VT1622_N1024x768_YPBPR_VN,      =
VT1622_N1024x768_YPBPR_VF,      VT1622_N1024x768_YPBPR_VO},
+    {TV_SDTV_RGB_FUNC,     VT1622_N1024x768_SDTV_RGB_VN,   =
VT1622_N1024x768_SDTV_RGB_VF,   VT1622_N1024x768_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1622_N1024x768_SDTV_YPBPR_VN, =
VT1622_N1024x768_SDTV_YPBPR_VF, VT1622_N1024x768_SDTV_YPBPR_VO},
+    {TV_DeDotCrawl_FUNC,   VT1622_N1024x768_DeDotCrawl_VN, =
VT1622_N1024x768_DeDotCrawl_VF, VT1622_N1024x768_DeDotCrawl_VO}
+};
+
+static vt1622_func_table vt1622_ntsc_848x480_tbl[] =3D {
+    {TV_BASE_FUNC,         VT1622_N848x480_VN,             =
VT1622_N848x480_VF,             VT1622_N848x480_VO},
+    {TV_RGB_FUNC,          VT1622_N848x480_RGB_VN,         =
VT1622_N848x480_RGB_VF,         VT1622_N848x480_RGB_VO},
+    {TV_YPBPR_FUNC,        VT1622_N848x480_YPBPR_VN,       =
VT1622_N848x480_YPBPR_VF,       VT1622_N848x480_YPBPR_VO},
+    {TV_SDTV_RGB_FUNC,     VT1622_N848x480_SDTV_RGB_VN,    =
VT1622_N848x480_SDTV_RGB_VF,    VT1622_N848x480_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1622_N848x480_SDTV_YPBPR_VN,  =
VT1622_N848x480_SDTV_YPBPR_VF,  VT1622_N848x480_SDTV_YPBPR_VO},
+    {TV_DeDotCrawl_FUNC,   VT1622_N848x480_DeDotCrawl_VN,  =
VT1622_N848x480_DeDotCrawl_VF,  VT1622_N848x480_DeDotCrawl_VO}
+};
+
+static vt1622_func_table vt1622_ntsc_720x480_tbl[] =3D {
+    {TV_BASE_FUNC,         VT1622_N720x480_VN,             =
VT1622_N720x480_VF,             VT1622_N720x480_VO},
+    {TV_RGB_FUNC,          VT1622_N720x480_RGB_VN,         =
VT1622_N720x480_RGB_VF,         VT1622_N720x480_RGB_VO},
+    {TV_YPBPR_FUNC,        VT1622_N720x480_YPBPR_VN,       =
VT1622_N720x480_YPBPR_VF,       VT1622_N720x480_YPBPR_VO},
+    {TV_SDTV_RGB_FUNC,     VT1622_N720x480_SDTV_RGB_VN,    =
VT1622_N720x480_SDTV_RGB_VF,    VT1622_N720x480_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1622_N720x480_SDTV_YPBPR_VN,  =
VT1622_N720x480_SDTV_YPBPR_VF,  VT1622_N720x480_SDTV_YPBPR_VO},
+    {TV_DeDotCrawl_FUNC,   VT1622_N720x480_DeDotCrawl_VN,  =
VT1622_N720x480_DeDotCrawl_VF,  VT1622_N720x480_DeDotCrawl_VO}
+};
+
+static vt1622_func_table vt1622_pal_640x480_tbl[] =3D {
+    {TV_BASE_FUNC,         VT1622_P640x480_VN,             =
VT1622_P640x480_VF,             VT1622_P640x480_VO},
+    {TV_RGB_FUNC,          VT1622_P640x480_RGB_VN,         =
VT1622_P640x480_RGB_VF,         VT1622_P640x480_RGB_VO},
+    {TV_YPBPR_FUNC,        VT1622_P640x480_YPBPR_VN,       =
VT1622_P640x480_YPBPR_VF,       VT1622_P640x480_YPBPR_VO},
+    {TV_SDTV_RGB_FUNC,     VT1622_P640x480_SDTV_RGB_VN,    =
VT1622_P640x480_SDTV_RGB_VF,    VT1622_P640x480_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1622_P640x480_SDTV_YPBPR_VN,  =
VT1622_P640x480_SDTV_YPBPR_VF,  VT1622_P640x480_SDTV_YPBPR_VO}
+};
+
+static vt1622_func_table vt1622_pal_800x600_tbl[] =3D {
+    {TV_BASE_FUNC,         VT1622_P800x600_VN,             =
VT1622_P800x600_VF,             VT1622_P800x600_VO},
+    {TV_RGB_FUNC,          VT1622_P800x600_RGB_VN,         =
VT1622_P800x600_RGB_VF,         VT1622_P800x600_RGB_VO},
+    {TV_YPBPR_FUNC,        VT1622_P800x600_YPBPR_VN,       =
VT1622_P800x600_YPBPR_VF,       VT1622_P800x600_YPBPR_VO},
+    {TV_SDTV_RGB_FUNC,     VT1622_P800x600_SDTV_RGB_VN,    =
VT1622_P800x600_SDTV_RGB_VF,    VT1622_P800x600_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1622_P800x600_SDTV_YPBPR_VN,  =
VT1622_P800x600_SDTV_YPBPR_VF,  VT1622_P800x600_SDTV_YPBPR_VO}
+};
+
+static vt1622_func_table vt1622_pal_1024x768_tbl[] =3D {
+    {TV_BASE_FUNC,         VT1622_P1024x768_VN,             =
VT1622_P1024x768_VF,             VT1622_P1024x768_VO},
+    {TV_RGB_FUNC,          VT1622_P1024x768_RGB_VN,         =
VT1622_P1024x768_RGB_VF,         VT1622_P1024x768_RGB_VO},
+    {TV_YPBPR_FUNC,        VT1622_P1024x768_YPBPR_VN,       =
VT1622_P1024x768_YPBPR_VF,       VT1622_P1024x768_YPBPR_VO},
+    {TV_SDTV_RGB_FUNC,     VT1622_P1024x768_SDTV_RGB_VN,    =
VT1622_P1024x768_SDTV_RGB_VF,    VT1622_P1024x768_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1622_P1024x768_SDTV_YPBPR_VN,  =
VT1622_P1024x768_SDTV_YPBPR_VF,  VT1622_P1024x768_SDTV_YPBPR_VO}
+};
+
+static vt1622_func_table vt1622_pal_848x480_tbl[] =3D {
+    {TV_BASE_FUNC,         VT1622_P848x480_VN,             =
VT1622_P848x480_VF,             VT1622_P848x480_VO},
+    {TV_RGB_FUNC,          VT1622_P848x480_RGB_VN,         =
VT1622_P848x480_RGB_VF,         VT1622_P848x480_RGB_VO},
+    {TV_YPBPR_FUNC,        VT1622_P848x480_YPBPR_VN,       =
VT1622_P848x480_YPBPR_VF,       VT1622_P848x480_YPBPR_VO},
+    {TV_SDTV_RGB_FUNC,     VT1622_P848x480_SDTV_RGB_VN,    =
VT1622_P848x480_SDTV_RGB_VF,    VT1622_P848x480_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1622_P848x480_SDTV_YPBPR_VN,  =
VT1622_P848x480_SDTV_YPBPR_VF,  VT1622_P848x480_SDTV_YPBPR_VO}
+};
+
+static vt1622_func_table vt1622_pal_720x576_tbl[] =3D {
+    {TV_BASE_FUNC,         VT1622_P720x576_VN,             =
VT1622_P720x576_VF,             VT1622_P720x576_VO},
+    {TV_RGB_FUNC,          VT1622_P720x576_RGB_VN,         =
VT1622_P720x576_RGB_VF,         VT1622_P720x576_RGB_VO},
+    {TV_YPBPR_FUNC,        VT1622_P720x576_YPBPR_VN,       =
VT1622_P720x576_YPBPR_VF,       VT1622_P720x576_YPBPR_VO},
+    {TV_SDTV_RGB_FUNC,     VT1622_P720x576_SDTV_RGB_VN,    =
VT1622_P720x576_SDTV_RGB_VF,    VT1622_P720x576_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1622_P720x576_SDTV_YPBPR_VN,  =
VT1622_P720x576_SDTV_YPBPR_VF,  VT1622_P720x576_SDTV_YPBPR_VO}
+};
+
+
+static struct vt1622_table vt1622_tbl[] =3D {
+    {VIA_RES_640X480,             vt1622_ntsc_640x480_tbl,    =
vt1622_pal_640x480_tbl},
+    {VIA_RES_800X600,             vt1622_ntsc_800x600_tbl,    =
vt1622_pal_800x600_tbl},
+    {VIA_RES_1024X768,            vt1622_ntsc_1024x768_tbl,   =
vt1622_pal_1024x768_tbl},
+    {VIA_RES_848X480,             vt1622_ntsc_848x480_tbl,    =
vt1622_pal_848x480_tbl},
+    {VIA_RES_720X480,             vt1622_ntsc_720x480_tbl,    =
vt1622_ntsc_720x480_tbl},
+    {VIA_RES_720X576,             vt1622_pal_720x576_tbl,     =
vt1622_pal_720x576_tbl}
+};
+
+#define NUM_TOTAL_VT1622_TABLE ARRAY_SIZE(vt1622_tbl)
+
+#endif /* __TBL1622_H__ */
+
diff -Nur linux-2.6.21-rc7/drivers/video/via/tbl1625.h =
linux-2.6.21-rc7.viafb/drivers/video/via/tbl1625.h
--- linux-2.6.21-rc7/drivers/video/via/tbl1625.h 1969-12-31 =
19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/tbl1625.h 2007-04-26 =
19:52:32.000000000 -0400
@@ -0,0 +1,2006 @@
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
+static u16 VT1625_N640x480_VN[] =3D {
+                                               =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0x0F50, 0x8151, 0x2352, 0x5753, 0x2254,     /* TV.50-54 */
+    0x5955, 0x8156, 0x7F57, 0x2358, 0x9159,     /* TV.55-59 */
+    0xD25A, 0x135B, 0x7C5C, 0x165D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x495E, 0x005F, 0x9260, 0x2061, 0xFF62,     /* TV.5E-62 */
+    0x7F63, 0x0364, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA, HBS, HBE, HSS, HSE,  VT,  VA, VBS, VBE, VSS, VSE */
+    784, 640, 640, 144, 688, 56,  600, 480, 480, 120, 488, 7
+};
+
+#define NUM_TOTAL_VT1625_REG ARRAY_SIZE(VT1625_N640x480_VN) =
-NUM_CRTC_TIMING
+
+static u16 VT1625_N800x600_VN[] =3D {
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0x2750, 0x2251, 0x3452, 0xED53, 0x2254,     /* TV.50-54 */
+    0x5955, 0x7B56, 0x7F57, 0x2358, 0x8C59,     /* TV.55-59 */
+    0xD25A, 0x135B, 0x7A5C, 0x165D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0xDB5E, 0x1A5F, 0xB660, 0xAA61, 0xFF62,     /* TV.5E-62 */
+    0xEF63, 0x0564, 0x5165,                     /* TV.63-65 */
+
+    /* HT,   HA, HBS, HBE, HSS, HSE,  VT,  VA, VBS, VBE, VSS, VSE */
+    1064, 800, 800, 264, 840, 136, 750, 600, 600, 150, 606, 15
+};
+
+static u16 VT1625_N1024x768_VN[] =3D {
+                                               =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0x5F50, 0x0251, 0x4452, 0xDD53, 0x0354,     /* TV.50-54 */
+    0x2755, 0xA456, 0xC357, 0x3558, 0xE259,     /* TV.55-59 */
+    0x475A, 0xA05B, 0xFF5C, 0x595D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x5F5E, 0xCC5F, 0xF160, 0x2861, 0xFF62,     /* TV.5E-62 */
+    0x3F63, 0x0864, 0x5165,                     /* TV.63-65 */
+
+  /*  HT,   HA,  HBS, HBE, HSS, HSE, VT,  VA, VBS, VBE, VSS, VSE */
+    1120, 1024, 1024, 96, 1080, 24, 990, 768, 768, 222, 800, 6
+};
+
+static u16 VT1625_N720x480_VN[] =3D {
+                                              =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0x0F50, 0xCF51, 0x2352, 0x5753, 0x2254,     /* TV.50-54 */
+    0x5955, 0x8356, 0x7F57, 0x2358, 0x9159,     /* TV.55-59 */
+    0xD25A, 0x135B, 0x7A5C, 0x165D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x495E, 0xF15F, 0x9260, 0xA861, 0xFF62,     /* TV.5E-62 */
+    0x7F63, 0x0364, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA, HBS, HBE, HSS, HSE,  VT,  VA, VBS, VBE, VSS, VSE */
+    784, 720, 720, 64,  728,  16, 600, 480, 480, 120, 490, 6
+};
+
+static u16 VT1625_P640x480_VN[] =3D {
+                                               =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xE750, 0x8151, 0x2352, 0x5753, 0x2254,     /* TV.50-54 */
+    0x5F55, 0x6F56, 0x7F57, 0x2358, 0x9459,     /* TV.55-59 */
+    0xD05A, 0x1C5B, 0x8F5C, 0x165D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0xE15E, 0x385F, 0x7A60, 0x2861, 0xFF62,     /* TV.5E-62 */
+    0xBF63, 0x0364, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA, HBS, HBE, HSS, HSE,  VT,  VA, VBS, VBE, VSS, VSE */
+    1000, 640, 640, 360, 704, 56,  600, 480, 480, 120, 500, 6
+};
+
+static u16 VT1625_P800x600_VN[] =3D {
+                                                  =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0x9750, 0x2251, 0x3352, 0xED53, 0x2254,     /* TV.50-54 */
+    0x5F55, 0x7356, 0x7F57, 0x2358, 0x9459,     /* TV.55-59 */
+    0xD05A, 0x275B, 0x8F5C, 0x165D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x995E, 0x385F, 0x9960, 0xAA61, 0xFF62,     /* TV.5E-62 */
+    0x4F63, 0x0464, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA, HBS, HBE, HSS, HSE,  VT,  VA, VBS, VBE, VSS, VSE */
+    920, 800, 800, 120, 816, 64,  750, 600, 600, 150, 606, 16
+};
+
+static u16 VT1625_P1024x768_VN[] =3D {
+                                               =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xAF50, 0x0251, 0x4452, 0xCE53, 0x0354,     /* TV.50-54 */
+    0x0F55, 0xA456, 0xBE57, 0x3558, 0xDC59,     /* TV.55-59 */
+    0x3E5A, 0xB55B, 0xDB5C, 0x595D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0xAE5E, 0xCD5F, 0xC760, 0x2861, 0xFF62,     /* TV.5E-62 */
+    0x4F63, 0x0764, 0x5165,                     /* TV.63-65 */
+
+    /*  HT,   HA,  HBS, HBE,  HSS, HSE, VT,  VA, VBS, VBE, VSS, VSE */
+    1200, 1024, 1024, 176, 1048, 16, 975, 768, 768, 107, 800, 6
+};
+
+static u16 VT1625_P720x576_VN[] =3D {
+                                              =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xE750, 0xD251, 0x2352, 0xB153, 0x2254,     /* TV.50-54 */
+    0x5F55, 0x6156, 0x7F57, 0x2358, 0x9059,     /* TV.55-59 */
+    0xCD5A, 0x355B, 0x835C, 0x165D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x4F5E, 0x765F, 0x8D60, 0xA961, 0xFF62,     /* TV.5E-62 */
+    0x4F63, 0x0464, 0x5165,                     /* TV.63-65 */
+
+    /* HT,   HA, HBS, HBE, HSS, HSE, VT,  VA, VBS, VBE, VSS, VSE */
+    1000, 720, 720, 280, 760, 40, 690, 576, 576, 114, 577, 3
+};
+
+
+/* Fit Industry TV Screen Mode */
+static u16 VT1625_N640x480_VF[] =3D {
+                                               =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xED50, 0x8151, 0x2252, 0x3D53, 0x2254,     /* TV.50-54 */
+    0x5955, 0x9156, 0x7F57, 0x2358, 0x9059,     /* TV.55-59 */
+    0xD35A, 0x135B, 0x7A5C, 0x165D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0xF25E, 0xCE5F, 0x8B60, 0x2761, 0xFF62,     /* TV.5E-62 */
+    0x3363, 0x0364, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    750, 640, 640, 110, 648, 16,  574, 480, 480, 94,  490, 6
+};
+
+static u16 VT1625_N800x600_VF[] =3D {
+                                                 =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xAF50, 0x2351, 0x3452, 0xD753, 0x2254,     /* TV.50-54 */
+    0x5955, 0x9156, 0x7F57, 0x2358, 0x9059,     /* TV.55-59 */
+    0xD25A, 0x135B, 0x7A5C, 0x165D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x7E5E, 0xC55F, 0xB160, 0xA961, 0xFF62,     /* TV.5E-62 */
+    0x7F63, 0x0664, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1200,800, 800, 400, 848, 216, 728, 600, 600, 128, 656, 9
+};
+
+static u16 VT1625_N1024x768_VF[] =3D {
+                                                 =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xAF50, 0x0351, 0x4452, 0xA953, 0x0354,     /* TV.50-54 */
+    0x2F55, 0x3B56, 0x9F57, 0x3458, 0xB659,     /* TV.55-59 */
+    0x095A, 0x545B, 0x1D5C, 0x585D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0xB15E, 0xEC5F, 0xE460, 0xA961, 0xFF62,     /* TV.5E-62 */
+    0x5F63, 0x0864, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1200,1024,1024,176, 1032,16,  938, 768, 768, 170, 777, 9
+};
+
+static u16 VT1625_N720x480_VF[] =3D {
+                                                 =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0x4750, 0xCF51, 0x2352, 0x3E53, 0x2254,     /* TV.50-54 */
+    0x5955, 0x8B56, 0x7F57, 0x2358, 0x9159,     /* TV.55-59 */
+    0xD25A, 0x135B, 0x7A5C, 0x165D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x305E, 0xD45F, 0x8C60, 0x2861, 0xFF62,     /* TV.5E-62 */
+    0x9763, 0x0364, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    840, 720, 720, 120, 728, 48,  575, 480, 480, 95,  484, 15
+};
+
+static u16 VT1625_P640x480_VF[] =3D {
+                                                 =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xE750, 0x8151, 0x2352, 0x3E53, 0x2254,     /* TV.50-54 */
+    0x5F55, 0x8056, 0x7F57, 0x2358, 0x9459,     /* TV.55-59 */
+    0xD15A, 0x275B, 0x8F5C, 0x165D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0xC25E, 0x005F, 0x7560, 0x2061, 0xFF62,     /* TV.5E-62 */
+    0x9763, 0x0364, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1000,640, 640, 360, 840, 80,  575, 480, 480, 95,  501, 3
+};
+
+static u16 VT1625_P800x600_VF[] =3D {
+                                                 =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xE750, 0x2151, 0x3352, 0xD453, 0x2254,     /* TV.50-54 */
+    0x5F55, 0x8756, 0x7F57, 0x2358, 0x9459,     /* TV.55-59 */
+    0xD15A, 0x275B, 0x8F5C, 0x165D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x7A5E, 0xE85F, 0x9460, 0xA961, 0xFF62,     /* TV.5E-62 */
+    0x8763, 0x0464, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1000,800, 800, 200, 848, 80,  725, 600, 600, 125, 602, 1
+};
+
+static u16 VT1625_P1024x768_VF[] =3D {
+                                               =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xAF50, 0x0251, 0x4452, 0x9C53, 0x0354,     /* TV.50-54 */
+    0x0B55, 0x0756, 0x9857, 0x3458, 0xB259,     /* TV.55-59 */
+    0xFB5A, 0x4E5B, 0xF55C, 0x175D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x705E, 0x945F, 0xBD60, 0xAA61, 0xFF62,     /* TV.5E-62 */
+    0xEF63, 0x0664, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1200,1024,1024,176, 1032,16,  925, 768, 768, 157, 778, 6
+};
+
+static u16 VT1625_P720x576_VF[] =3D {
+                                                 =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xE750, 0xCF51, 0x2352, 0x9D53, 0x2254,     /* TV.50-54 */
+    0x5F55, 0x8356, 0x7E57, 0x2358, 0x9459,     /* TV.55-59 */
+    0xD05A, 0x275B, 0x8F5C, 0x165D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x375E, 0xF35F, 0x8960, 0x2861, 0xFF62,     /* TV.5E-62 */
+    0x2F63, 0x0464, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1000, 720, 720, 280, 736, 16,  670, 576, 576, 94,  586, 6
+};
+
+/* TV Overscan Table */
+
+static u16 VT1625_N640x480_VO[] =3D {
+                                              =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0x2750, 0x8251, 0x2352, 0x0C53, 0x0254,     /* TV.50-54 */
+    0x2755, 0x8056, 0x7757, 0x2358, 0x8359,     /* TV.55-59 */
+    0xC35A, 0xFB5B, 0x115C, 0x065D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x005E, 0x005F, 0x8060, 0x2061, 0xFF62,     /* TV.5E-62 */
+    0x2763, 0x0364, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA, HBS, HBE, HSS, HSE, VT,  VA, VBS, VBE,VSS, VSE */
+    808, 640, 640, 168, 688, 24, 525, 480, 480, 45, 490, 6
+};
+
+static u16 VT1625_N800x600_VO[] =3D {
+                                               =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xAF50, 0x2251, 0x3452, 0x9153, 0x2254,     /* TV.50-54 */
+    0x5955, 0xC656, 0x7F57, 0x2358, 0x9059,     /* TV.55-59 */
+    0xD25A, 0xEE5B, 0x7A5C, 0x065D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x6D5E, 0x065F, 0xA060, 0x2961, 0xFF62,     /* TV.5E-62 */
+    0xDF63, 0x0564, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA, HBS, HBE, HSS, HSE, VT,  VA, VBS, VBE, VSS, VSE */
+    1200, 800, 800, 400, 880, 66, 658, 600, 600,  58, 610, 6
+};
+
+static u16 VT1625_N1024x768_VO[] =3D {
+                                              =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0x5F50, 0x0351, 0x4452, 0x3853, 0x0354,     /* TV.50-54 */
+    0x1F55, 0x6056, 0x9C57, 0x3458, 0xB359,     /* TV.55-59 */
+    0x045A, 0x2D5B, 0x005C, 0x585D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x245E, 0x7F5F, 0xC960, 0x2961, 0xFF62,     /* TV.5E-62 */
+    0xDF63, 0x0664, 0x5165,                     /* TV.63-65 */
+
+    /* HT,   HA,  HBS, HBE, HSS, HSE, VT,  VA, VBS, VBE, VSS, VSE */
+    1120, 1024, 1024, 96, 1032, 16, 825, 768, 768, 57,  777, 9
+};
+
+static u16 VT1625_N720x480_VO[] =3D {
+                                               =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0x1F50, 0xD251, 0x2352, 0x0C53, 0x2254,     /* TV.50-54 */
+    0x5955, 0xC056, 0x7E57, 0x2358, 0x8C59,     /* TV.55-59 */
+    0xD05A, 0xF65B, 0x7C5C, 0x065D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x005E, 0x345F, 0x8060, 0x2861, 0xFF62,     /* TV.5E-62 */
+    0x1F63, 0x0364, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA, HBS, HBE, HSS, HSE, VT,  VA, VBS, VBE, VSS, VSE */
+    800, 720, 720, 80,  760, 40, 525, 480, 480, 45,  482, 3
+};
+
+static u16 VT1625_P640x480_VO[] =3D {
+                                               =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xE750, 0x8751, 0x2352, 0x0753, 0x2254,     /* TV.50-54 */
+    0x5F55, 0xDF56, 0x7F57, 0x2358, 0x9459,     /* TV.55-59 */
+    0xD15A, 0x135B, 0x9E5C, 0x165D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x7F5E, 0x3A5F, 0x6A60, 0x2761, 0xFF62,     /* TV.5E-62 */
+    0x3F63, 0x0364, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE,  VT,  VA, VBS, VBE, VSS, VSE */
+    1000, 640, 640, 360, 816, 112, 520, 480, 480, 40,  490, 6
+};
+
+static u16 VT1625_P800x600_VO[] =3D {
+                                               =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xE750, 0x8751, 0x3352, 0x8953, 0x2254,     /* TV.50-54 */
+    0x5F55, 0xE056, 0x7F57, 0x2358, 0x9459,     /* TV.55-59 */
+    0xD15A, 0x055B, 0x855C, 0x165D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x1E5E, 0x1F5F, 0x8560, 0xA961, 0xFF62,     /* TV.5E-62 */
+    0x0F63, 0x0464, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA, VBS, VBE, VSS, VSE */
+    1000, 800, 800, 200, 872, 56, 650, 600, 600, 50,  608, 12
+};
+
+static u16 VT1625_P1024x768_VO[] =3D {
+                                               =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xCF50, 0x0351, 0x4752, 0x4253, 0x2354,     /* TV.50-54 */
+    0x5F55, 0xBF56, 0x7F57, 0x2358, 0x9359,     /* TV.55-59 */
+    0xD05A, 0x085B, 0xF05C, 0x165D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x025E, 0xAB5F, 0xAB60, 0xAB61, 0xFF62,     /* TV.5E-62 */
+    0x6F63, 0x0A64, 0x5165,                     /* TV.63-65 */
+
+    /* HT,   HA,  HBS,  HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    2000, 1024, 1024, 976, 1504, 32, 835, 768, 768, 67,  778, 6
+};
+
+static u16 VT1625_P720x576_VO[] =3D {
+                                               =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0x5F50, 0xCF51, 0x2352, 0x7053, 0x2254,     /* TV.50-54 */
+    0x5F55, 0xD056, 0x7F57, 0x2358, 0x9259,     /* TV.55-59 */
+    0xCE5A, 0x0C5B, 0x8E5C, 0x165D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
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
+static u16 TV_OUT_RGB[] =3D {
+    0x1202,                     /* SYNC on G */
+    0x7E23,                     /* Blank Level */
+    0x854A, 0x0A4B,             /* DAC Selection */
+    0x004E,                     /* YUV Delay Control */
+    0x5565, 0x3766, 0x5C67,     /* adjust SDTV_RGB Amplitude factor */
+    0xffff
+};
+
+static u16 HDTV_OUT_RGB[] =3D {
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
+static u16 TV_OUT_YPBPR[] =3D {
+    0x7E23, 0x004E,
+    0x5565, 0x5466, 0x5667,
+    0xFFFF                      /* End symbol */
+};
+
+unsigned short HDTV_OUT_YPBPR[] =3D {
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
+static u16 VT1625_N640x480_SDTV_RGB_VN[] =3D {
+    0x4003,                          /* Filter Selection                =
 */
+    0x1004,                          /* Output Mode                     =
 */
+    0x2807,                          /* Start Active Video              =
 */
+    0x4708, 0x1509,                  /* adjust TV's Position            =
 */
+    0x000B,                          /* Blanking Level set to zero      =
 */
+    0x001C,
+    0x8351, 0x8356,                  /* TV Timing                       =
 */
+    0x0062,                          /* Adaptive Deflicker Disable      =
 */
+    0xFFFF                           /* End symbol                      =
 */
+};
+
+static u16 VT1625_N800x600_SDTV_RGB_VN[] =3D {
+    0xC003,                          /* Filter Selection                =
 */
+    0x1004,                          /* Output Mode                     =
 */
+    0x5607,                          /* Start Active Video              =
 */
+    0x4B08, 0x1409,                  /* adjust TV's Position            =
 */
+    0x000B,                          /* Blanking Level set to zero      =
 */
+    0x001C,
+    0x011F,                          /* Filter Switch                   =
 */
+    0x2F20,                          /* TV Sync step                    =
 */
+    0x2551, 0x7D56,                  /* TV Timing                       =
 */
+    0x0062,                          /* Adaptive Deflicker Disable      =
 */
+    0xFFFF                           /* End symbol                      =
 */
+};
+
+static u16 VT1625_N1024x768_SDTV_RGB_VN[] =3D {
+    0xC003,                          /* Filter Selection                =
 */
+    0x1004,                          /* Output Mode                     =
 */
+    0x0F07,                          /* Start Active Video              =
 */
+    0x8008, 0x1409,                  /* adjust TV's Position            =
 */
+    0x000B,                          /* Blanking Level set to zero      =
 */
+    0x001C,
+    0x011F,                          /* Filter Switch                   =
 */
+    0x2520,                          /* TV Sync step                    =
 */
+    0x0451, 0xA756,                  /* TV Timing                       =
 */
+    0x0062,                          /* Adaptive Deflicker Disable      =
 */
+    0xFFFF                           /* End symbol                      =
 */
+};
+
+static u16 VT1625_N720x480_SDTV_RGB_VN[] =3D {
+    0x4003,                          /* Filter Selection                =
 */
+    0x1004,                          /* Output Mode                     =
 */
+    0x1409,                          /* adjust TV's Position            =
 */
+    0x000B,                          /* Blanking Level set to zero      =
 */
+    0x001C,
+    0x011F,                          /* Filter Switch                   =
 */
+    0x2F20,                          /* TV Sync step                    =
 */
+    0x0062,                          /* Adaptive Deflicker Disable      =
 */
+    0xFFFF                           /* End symbol                      =
 */
+};
+
+static u16 VT1625_N640x480_SDTV_RGB_VF[] =3D {
+    0x4003,                          /* Filter Selection                =
 */
+    0x1004,                          /* Output Mode                     =
 */
+    0x5607,                          /* Start Active Video              =
 */
+    0x3808,                          /* adjust TV's Position            =
 */
+    0x000B,                          /* Blanking Level set to zero      =
 */
+    0x011F,                          /* Filter Switch                   =
 */
+    0x8451,                          /* TV Timing                       =
 */
+    0x0254, 0x3355, 0x7956, 0x7957,  /* TV Timing                       =
 */
+    0x8559, 0xCA5A, 0x075B,          /* TV Timing                       =
 */
+    0x325C, 0x165D, 0xF25E, 0x225F,  /* TV Timing                       =
 */
+    0x8B60, 0x2861,                  /* Scaling                         =
 */
+    0x0062,                          /* Adaptive Deflicker Disable      =
 */
+    0xFFFF                           /* End symbol                      =
 */
+};
+
+static u16 VT1625_N800x600_SDTV_RGB_VF[] =3D {
+    0xC003,                          /* Filter Selection                =
 */
+    0x1004,                          /* Output Mode                     =
 */
+    0x8607,                          /* Start Active Video              =
 */
+    0x3F08, 0xFC09,                  /* adjust TV's Position            =
 */
+    0x000B,                          /* Blanking Level set to zero      =
 */
+    0x021C,
+    0x2F20,                          /* TV Sync step                    =
 */
+    0x0062,                          /* Adaptive Deflicker Disable      =
 */
+    0xFFFF                           /* End symbol                      =
 */
+};
+
+static u16 VT1625_N1024x768_SDTV_RGB_VF[]=3D{
+    0xC003,                          /* Filter Selection                =
 */
+    0x1004,                          /* Output Mode                     =
 */
+    0x9607,                          /* Start Active Video              =
 */
+    0x4608, 0x0D09,                  /* adjust TV's Position            =
 */
+    0x000B,                          /* Blanking Level set to zero      =
 */
+    0x001C,
+    0x011F,                          /* Filter Switch                   =
 */
+    0x2520,                          /* TV Sync step                    =
 */
+    0x0551, 0x3D56,                  /* TV Timing                       =
 */
+    0x0062,                          /* Adaptive Deflicker Disable      =
 */
+    0xFFFF                           /* End symbol                      =
 */
+};
+
+static u16 VT1625_N720x480_SDTV_RGB_VF[] =3D {
+    0x4003,                          /* Filter Selection                =
 */
+    0x1004,                          /* Output Mode                     =
 */
+    0x4308, 0x0709,                  /* adjust TV's Position            =
 */
+    0x000B,                          /* Blanking Level set to zero      =
 */
+    0x001C,
+    0x011F,                          /* Filter Switch                   =
 */
+    0x2F20,                          /* TV Sync step                    =
 */
+    0x0062,                          /* Adaptive Deflicker Disable      =
 */
+    0xFFFF                           /* End symbol                      =
 */
+};
+
+static u16 VT1625_N640x480_SDTV_RGB_VO[] =3D {
+    0x4003,                          /* Filter Selection                =
 */
+    0x1004,                          /* Output Mode                     =
 */
+    0x8407,                          /* Start Active Video              =
 */
+    0x1D08,                          /* adjust TV's Position            =
 */
+    0x000B,                          /* Blanking Level set to zero      =
 */
+    0x041C,=20
+    0x011F,                          /* Filter Switch                   =
 */
+    0x8351,                          /* TV Timing                       =
 */
+    0x0254, 0x1B55, 0x8356, 0x7557,  /* TV Timing                       =
 */
+    0x8159, 0xC45A, 0x005B,          /* TV Timing                       =
 */
+    0x045C, 0x005F,                  /* TV Timing                       =
 */
+    0x2061,                          /* Scaling                         =
 */
+    0x0062,                          /* Adaptive Deflicker Disable      =
 */
+    0xFFFF                           /* End symbol                      =
 */
+};
+
+static u16 VT1625_N800x600_SDTV_RGB_VO[] =3D {
+    0xC003,                          /* Filter Selection                =
 */
+    0x1004,                          /* Output Mode                     =
 */
+    0x0006, 0xFB07,                  /* Start Active Video              =
 */
+    0x2208, 0x0409,                  /* adjust TV's Position            =
 */
+    0x000B,                          /* Blanking Level set to zero      =
 */
+    0x041C,
+    0x011F,                          /* Filter Switch                   =
 */
+    0x2920,                          /* TV Sync step                    =
 */
+    0x2751, 0xCB56, 0xEB5B,          /* TV Timing                       =
 */
+    0x0062,                          /* Adaptive Deflicker Disable      =
 */
+    0xFFFF                           /* End symbol                      =
 */
+};
+
+static u16 VT1625_N1024x768_SDTV_RGB_VO[] =3D {
+    0xC003,                          /* Filter Selection                =
 */
+    0x1004,                          /* Output Mode                     =
 */
+    0x4707,                          /* Start Active Video              =
 */
+    0x2908, 0x0009,                  /* adjust TV's Position            =
 */
+    0x000B,                          /* Blanking Level set to zero      =
 */
+    0x041C,=20
+    0x011F,                          /* Filter Switch                   =
 */
+    0x2820,                          /* TV Sync step                    =
 */
+    0x0551, 0x6156,                  /* TV Timing                       =
 */
+    0x0062,                          /* Adaptive Deflicker Disable      =
 */
+    0xFFFF                           /* End symbol                      =
 */
+};
+
+static u16 VT1625_N720x480_SDTV_RGB_VO[] =3D {
+    0x4003,                          /* Filter Selection                =
 */
+    0x1004,                          /* Output Mode                     =
 */
+    0x2008, 0x0009,                  /* adjust TV's Position            =
 */
+    0x000B,                          /* Blanking Level set to zero      =
 */
+    0x001C,
+    0x011F,                          /* Filter Switch                   =
 */
+    0x2F20,                          /* TV Sync step                    =
 */
+    0x0062,                          /* Adaptive Deflicker Disable      =
 */
+    0xFFFF                           /* End symbol                      =
 */
+};
+
+
+/* PAL */
+
+static u16 VT1625_P640x480_SDTV_RGB_VN[] =3D {
+    0x4003,                          /* Filter Selection                =
 */
+    0x1304,                          /* Output Mode                     =
 */
+    0xF007,                          /* Start Active Video              =
 */
+    0x4E08, 0x1409,                  /* adjust TV's Position            =
 */
+    0x001C,=20
+    0x011F,                          /* Filter Switch                   =
 */
+    0x1C20,                          /* TV Sync step                    =
 */
+    0x8351, 0x7156,                  /* TV Timing                       =
 */
+    0x0062,                          /* Adaptive Deflicker Disable      =
 */
+    0xFFFF                           /* End symbol                      =
 */
+};
+
+static u16 VT1625_P800x600_SDTV_RGB_VN[] =3D {
+    0x4003,                          /* Filter Selection                =
 */
+    0x1304,                          /* Output Mode                     =
 */
+    0x2607,                          /* Start Active Video              =
 */
+    0x4A08, 0x1909,                  /* adjust TV's Position            =
 */
+    0x001C,
+    0x011F,                          /* Filter Switch                   =
 */
+    0x1C20,                          /* TV Sync step                    =
 */
+    0x2551, 0x7556,                  /* TV Timing                       =
 */
+    0x0062,                          /* Adaptive Deflicker Disable      =
 */
+    0xFFFF                           /* End symbol                      =
 */
+};
+
+static u16 VT1625_P1024x768_SDTV_RGB_VN[] =3D {
+    0xC003,                          /* Filter Selection                =
 */
+    0x1304,                          /* Output Mode                     =
 */
+    0x8707,                          /* Start Active Video              =
 */
+    0x6C08, 0x1909,                  /* adjust TV's Position            =
 */
+    0x001C,=20
+    0x011F,                          /* Filter Switch                   =
 */
+    0x1C20,                          /* TV Sync step                    =
 */
+    0x0451, 0xA556,                  /* TV Timing                       =
 */
+    0x0062,                          /* Adaptive Deflicker Disable      =
 */
+    0xFFFF                           /* End symbol                      =
 */
+};
+
+static u16 VT1625_P720x576_SDTV_RGB_VN[] =3D {
+    0x4003,                          /* Filter Selection                =
 */
+    0x1304,                          /* Output Mode                     =
 */
+    0x4D08, 0x1B09,                  /* adjust TV's Position            =
 */
+    0x001C,
+    0x011F,                          /* Filter Switch                   =
 */
+    0x1C20,                          /* TV Sync step                    =
 */
+    0x0062,                          /* Adaptive Deflicker Disable      =
 */
+    0xFFFF                           /* End symbol                      =
 */
+};
+
+static u16 VT1625_P640x480_SDTV_RGB_VF[] =3D {
+    0x4003,                          /* Filter Selection                =
 */
+    0x1304,                          /* Output Mode                     =
 */
+    0x5007, 0x4308, 0x0A09,          /* adjust TV's Position            =
 */
+    0x001C,
+    0x011F,                          /* Filter Switch                   =
 */
+    0x1C20,                          /* TV Sync step                    =
 */
+    0x8351, 0x8356,                  /* TV Timing                       =
 */
+    0x0062,                          /* Adaptive Deflicker Disable      =
 */
+    0xFFFF                           /* End symbol                      =
 */
+};
+
+static u16 VT1625_P800x600_SDTV_RGB_VF[] =3D {
+    0xC003,                          /* Filter Selection                =
 */
+    0x1304,                          /* Output Mode                     =
 */
+    0x4607,                          /* Start Active Video              =
 */
+    0x4108, 0x2409,                  /* adjust TV's Position            =
 */
+    0x0810,                          /* Hue Adjustment                  =
 */
+    0x001C,
+    0x011F,                          /* Filter Switch                   =
 */
+    0x1C20,                          /* TV Sync step                    =
 */
+    0x2451, 0x8956,                  /* TV Timing                       =
 */
+    0x0062,                          /* Adaptive Deflicker Disable      =
 */
+    0xFFFF                           /* End symbol                      =
 */
+};
+
+static u16 VT1625_P1024x768_SDTV_RGB_VF[] =3D {
+    0xC003,                          /* Filter Selection                =
 */
+    0x1304,                          /* Output Mode                     =
 */
+    0x9507,                          /* Start Active Video              =
 */
+    0x4B08, 0x1A09,                  /* adjust TV's Position            =
 */
+    0x001C,
+    0x001F,                          /* Filter Switch                   =
 */
+    0x0451, 0x0956,                  /* TV Timing                       =
 */
+    0x0062,                          /* Adaptive Deflicker Disable      =
 */
+    0xFFFF                           /* End symbol                      =
 */
+
+};
+
+static u16 VT1625_P720x576_SDTV_RGB_VF[] =3D {
+    0x4003,                          /* Filter Selection                =
 */
+    0x1304,                          /* Output Mode                     =
 */
+    0x4308, 0x0D09,                  /* adjust TV's Position            =
 */
+    0x001C,
+    0x011F,                          /* Filter Switch                   =
 */
+    0x1C20,                          /* TV Sync step                    =
 */
+    0x0062,                          /* Adaptive Deflicker Disable      =
 */
+    0xFFFF                           /* End symbol                      =
 */
+};
+
+static u16 VT1625_P640x480_SDTV_RGB_VO[] =3D {
+    0x4003,                          /* Filter Selection                =
 */
+    0x1304,                          /* Output Mode                     =
 */
+    0x4807,                          /* Start Active Video              =
 */
+    0x6409,                          /* adjust TV's Position            =
 */
+    0x041C,  =20
+    0x011F,                          /* Filter Switch                   =
 */
+    0x0254, 0xFF55, 0x9C56, 0x7057,  /* TV Timing                       =
 */
+    0x2258, 0x8359, 0xB95A, 0xD35B,  /* TV Timing                       =
 */
+    0xD45C, 0x055D, 0x7E5E, 0x005F,  /* TV Timing                       =
 */
+    0x2061,                          /* Scaling                         =
 */
+    0x0062,                          /* Adaptive Deflicker Disable      =
 */
+    0xFFFF                           /* End symbol                      =
 */
+};
+
+static u16 VT1625_P800x600_SDTV_RGB_VO[] =3D {
+    0xC003,                          /* Filter Selection                =
 */
+    0x1304,                          /* Output Mode                     =
 */
+    0x6509,                          /* adjust TV's Position            =
 */
+    0x041C,=20
+    0x011F,                          /* Filter Switch                   =
 */
+    0x1C20,                          /* TV Sync step                    =
 */
+    0x0062,                          /* Adaptive Deflicker Disable      =
 */
+    0xFFFF                           /* End symbol                      =
 */
+};
+
+static u16 VT1625_P1024x768_SDTV_RGB_VO[] =3D {
+    0xC003,                          /* Filter Selection                =
 */
+    0x1304,                          /* Output Mode                     =
 */
+    0xCC07,                          /* Start Active Video              =
 */
+    0x2408, 0x6E09,                  /* adjust TV's Position            =
 */
+    0x041C,
+    0x011F,                          /* Filter Switch                   =
 */
+    0x0651, 0xC156,                  /* TV Timing                       =
 */
+    0x0062,                          /* Adaptive Deflicker Disable      =
 */
+    0xFFFF                           /* End symbol                      =
 */
+};
+
+static u16 VT1625_P720x576_SDTV_RGB_VO[] =3D {
+    0x4003,                          /* Filter Selection                =
 */
+    0x1304,                          /* Output Mode                     =
 */
+    0x0309,                          /* adjust TV's Position            =
 */
+    0x001C,
+    0x011F,                          /* Filter Switch                   =
 */
+    0x1C20,                          /* TV Sync step                    =
 */
+    0x0062,                          /* Adaptive Deflicker Disable      =
 */
+    0xFFFF                           /* End symbol                      =
 */
+};
+
+/***********************************/
+/* VT1625 DeDotCrawl Table         */
+/***********************************/
+
+/* NTSC */
+
+static u16 VT1625_N640x480_DeDotCrawl_VN[] =3D {
+    0xBE16, 0x8717,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1625_N800x600_DeDotCrawl_VN[] =3D {
+    0x1216, 0x4917,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1625_N1024x768_DeDotCrawl_VN[] =3D {
+    0x1816, 0x6117,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1625_N720x480_DeDotCrawl_VN[] =3D {
+    0xC316, 0x4C17,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1625_N640x480_DeDotCrawl_VF[] =3D {
+    0x5016, 0x7B17,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1625_N800x600_DeDotCrawl_VF[] =3D {
+    0xD116, 0xF617,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1625_N1024x768_DeDotCrawl_VF[] =3D {
+    0x0616, 0x8417,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1625_N720x480_DeDotCrawl_VF[] =3D {
+    0xE816, 0xEB17,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1625_N640x480_DeDotCrawl_VO[] =3D {
+    0xE516, 0xA017,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1625_N800x600_DeDotCrawl_VO[] =3D {
+    0xA116, 0x5917,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1625_N1024x768_DeDotCrawl_VO[] =3D {
+    0x1116, 0xE217,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1625_N720x480_DeDotCrawl_VO[] =3D {
+    0x1E16, 0x5C17,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1625_NULL_FUNC[] =3D {
+    0xFFFF
+};
+
+static vt1625_func_table vt1625_ntsc_640x480_tbl[] =3D {
+    {TV_BASE_FUNC,         VT1625_N640x480_VN,             =
VT1625_N640x480_VF,             VT1625_N640x480_VO},
+    {TV_RGB_FUNC,          TV_OUT_RGB,                     TV_OUT_RGB,  =
                   TV_OUT_RGB},
+    {TV_YPBPR_FUNC,        TV_OUT_YPBPR,                   =
TV_OUT_YPBPR,                   TV_OUT_YPBPR},
+    {TV_SDTV_RGB_FUNC,     VT1625_N640x480_SDTV_RGB_VN,    =
VT1625_N640x480_SDTV_RGB_VF,    VT1625_N640x480_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1625_N640x480_SDTV_RGB_VN,    =
VT1625_N640x480_SDTV_RGB_VF,    VT1625_N640x480_SDTV_RGB_VO},
+    {TV_DeDotCrawl_FUNC,   VT1625_N640x480_DeDotCrawl_VN,  =
VT1625_N640x480_DeDotCrawl_VF,  VT1625_N640x480_DeDotCrawl_VO}
+};
+
+static vt1625_func_table vt1625_ntsc_800x600_tbl[] =3D {
+    {TV_BASE_FUNC,         VT1625_N800x600_VN,             =
VT1625_N800x600_VF,             VT1625_N800x600_VO},
+    {TV_RGB_FUNC,          TV_OUT_RGB,                     TV_OUT_RGB,  =
                   TV_OUT_RGB},
+    {TV_YPBPR_FUNC,        TV_OUT_YPBPR,                   =
TV_OUT_YPBPR,                   TV_OUT_YPBPR},
+    {TV_SDTV_RGB_FUNC,     VT1625_N800x600_SDTV_RGB_VN,    =
VT1625_N800x600_SDTV_RGB_VF,    VT1625_N800x600_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1625_N800x600_SDTV_RGB_VN,    =
VT1625_N800x600_SDTV_RGB_VF,    VT1625_N800x600_SDTV_RGB_VO},
+    {TV_DeDotCrawl_FUNC,   VT1625_N800x600_DeDotCrawl_VN,  =
VT1625_N800x600_DeDotCrawl_VF,  VT1625_N800x600_DeDotCrawl_VO}
+};
+
+static vt1625_func_table vt1625_ntsc_1024x768_tbl[]=3D {
+    {TV_BASE_FUNC,         VT1625_N1024x768_VN,            =
VT1625_N1024x768_VF,            VT1625_N1024x768_VO},
+    {TV_RGB_FUNC,          TV_OUT_RGB,                     TV_OUT_RGB,  =
                   TV_OUT_RGB},
+    {TV_YPBPR_FUNC,        TV_OUT_YPBPR,                   =
TV_OUT_YPBPR,                   TV_OUT_YPBPR},
+    {TV_SDTV_RGB_FUNC,     VT1625_N1024x768_SDTV_RGB_VN,   =
VT1625_N1024x768_SDTV_RGB_VF,   VT1625_N1024x768_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1625_N1024x768_SDTV_RGB_VN,   =
VT1625_N1024x768_SDTV_RGB_VF,   VT1625_N1024x768_SDTV_RGB_VO},
+    {TV_DeDotCrawl_FUNC,   VT1625_N1024x768_DeDotCrawl_VN, =
VT1625_N1024x768_DeDotCrawl_VF, VT1625_N1024x768_DeDotCrawl_VO}
+};
+
+static vt1625_func_table vt1625_ntsc_720x480_tbl[] =3D {
+    {TV_BASE_FUNC,         VT1625_N720x480_VN,             =
VT1625_N720x480_VF,             VT1625_N720x480_VO},
+    {TV_RGB_FUNC,          TV_OUT_RGB,                     TV_OUT_RGB,  =
                   TV_OUT_RGB},
+    {TV_YPBPR_FUNC,        TV_OUT_YPBPR,                   =
TV_OUT_YPBPR,                   TV_OUT_YPBPR},
+    {TV_SDTV_RGB_FUNC,     VT1625_N720x480_SDTV_RGB_VN,    =
VT1625_N720x480_SDTV_RGB_VF,    VT1625_N720x480_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1625_N720x480_SDTV_RGB_VN,    =
VT1625_N720x480_SDTV_RGB_VF,    VT1625_N720x480_SDTV_RGB_VO},
+    {TV_DeDotCrawl_FUNC,   VT1625_N720x480_DeDotCrawl_VN,  =
VT1625_N720x480_DeDotCrawl_VF,  VT1625_N720x480_DeDotCrawl_VO}
+};
+
+static vt1625_func_table vt1625_pal_640x480_tbl[] =3D {
+    {TV_BASE_FUNC,         VT1625_P640x480_VN,             =
VT1625_P640x480_VF,             VT1625_P640x480_VO},
+    {TV_RGB_FUNC,          TV_OUT_RGB,                     TV_OUT_RGB,  =
                   TV_OUT_RGB},
+    {TV_YPBPR_FUNC,        TV_OUT_YPBPR,                   =
TV_OUT_YPBPR,                   TV_OUT_YPBPR},
+    {TV_SDTV_RGB_FUNC,     VT1625_P640x480_SDTV_RGB_VN,    =
VT1625_P640x480_SDTV_RGB_VF,    VT1625_P640x480_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1625_P640x480_SDTV_RGB_VN,    =
VT1625_P640x480_SDTV_RGB_VF,    VT1625_P640x480_SDTV_RGB_VO}
+};
+
+static vt1625_func_table vt1625_pal_800x600_tbl[] =3D {
+    {TV_BASE_FUNC,         VT1625_P800x600_VN,             =
VT1625_P800x600_VF,             VT1625_P800x600_VO},
+    {TV_RGB_FUNC,          TV_OUT_RGB,                     TV_OUT_RGB,  =
                   TV_OUT_RGB},
+    {TV_YPBPR_FUNC,        TV_OUT_YPBPR,                   =
TV_OUT_YPBPR,                   TV_OUT_YPBPR},
+    {TV_SDTV_RGB_FUNC,     VT1625_P800x600_SDTV_RGB_VN,    =
VT1625_P800x600_SDTV_RGB_VF,    VT1625_P800x600_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1625_P800x600_SDTV_RGB_VN,    =
VT1625_P800x600_SDTV_RGB_VF,    VT1625_P800x600_SDTV_RGB_VO}
+};
+
+static vt1625_func_table vt1625_pal_1024x768_tbl[] =3D {
+    {TV_BASE_FUNC,         VT1625_P1024x768_VN,            =
VT1625_P1024x768_VF,            VT1625_P1024x768_VO},
+    {TV_RGB_FUNC,          TV_OUT_RGB,                     TV_OUT_RGB,  =
                   TV_OUT_RGB},
+    {TV_YPBPR_FUNC,        TV_OUT_YPBPR,                   =
TV_OUT_YPBPR,                   TV_OUT_YPBPR},
+    {TV_SDTV_RGB_FUNC,     VT1625_P1024x768_SDTV_RGB_VN,   =
VT1625_P1024x768_SDTV_RGB_VF,   VT1625_P1024x768_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1625_P1024x768_SDTV_RGB_VN,   =
VT1625_P1024x768_SDTV_RGB_VF,   VT1625_P1024x768_SDTV_RGB_VO}
+};
+
+static vt1625_func_table vt1625_pal_720x576_tbl[] =3D {
+    {TV_BASE_FUNC,         VT1625_P720x576_VN,             =
VT1625_P720x576_VF,             VT1625_P720x576_VO},
+    {TV_RGB_FUNC,          TV_OUT_RGB,                     TV_OUT_RGB,  =
                   TV_OUT_RGB},
+    {TV_YPBPR_FUNC,        TV_OUT_YPBPR,                   =
TV_OUT_YPBPR,                   TV_OUT_YPBPR},
+    {TV_SDTV_RGB_FUNC,     VT1625_P720x576_SDTV_RGB_VN,    =
VT1625_P720x576_SDTV_RGB_VF,    VT1625_P720x576_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1625_P720x576_SDTV_RGB_VN,    =
VT1625_P720x576_SDTV_RGB_VF,    VT1625_P720x576_SDTV_RGB_VO}
+};
+
+
+/* 720P Under Scan */
+static u16 VT1625_HDTV_720P_640x480_VN[] =3D {
+                                                =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xAF50, 0x8251, 0x2452, 0x2053, 0x1254,     /* TV.50-54 */
+    0x6755, 0x6B56, 0x2A57, 0x2358, 0x9E59,     /* TV.55-59 */
+    0x455A, 0xA05B, 0x455C, 0x435D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x035E, 0x4B5F, 0x5D60, 0x2861, 0x0062,     /* TV.5E-62 */
+    0x6763, 0x1364, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA, HBS, HBE, HSS, HSE,  VT,  VA, VBS, VBE, VSS, VSE */
+    1200, 640, 640, 560, 1040, 80,  545, 480, 480, 65, 481, 2
+};
+
+static u16 VT1625_HDTV_720P_800x600_VN[] =3D {
+                                                 =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xAF50, 0x2351, 0x3452, 0xA753, 0x1254,     /* TV.50-54 */
+    0x3F55, 0x0756, 0x3457, 0x3458, 0xC559,     /* TV.55-59 */
+    0x115A, 0xC85B, 0x145C, 0x045D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x0D5E, 0x4C5F, 0x7460, 0x2861, 0x0062,     /* TV.5E-62 */
+    0x3F63, 0x2464, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA, HBS, HBE, HSS, HSE,  VT,  VA, VBS, VBE, VSS, VSE */
+    1200, 800, 800, 400, 1120, 40, 680, 600, 600, 80, 610, 6
+};
+
+static u16 VT1625_HDTV_720P_1024x768_VN[] =3D {
+                                                =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0x0750, 0x0251, 0x4752, 0x6F53, 0x1354,     /* TV.50-54 */
+    0x7F55, 0xE356, 0x4457, 0x3558, 0x0059,     /* TV.55-59 */
+    0x435A, 0x035B, 0x475C, 0xD55D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x2F5E, 0x395F, 0x9660, 0x2861, 0x0062,     /* TV.5E-62 */
+    0x3F63, 0x2864, 0x5165,                     /* TV.63-65 */
+
+    /* HT,   HA,  HBS, HBE,  HSS, HSE,  VT,  VA, VBS, VBE, VSS, VSE */
+    1800, 1024, 1024, 776, 1360,  40, 880, 768, 768, 112, 770, 8
+};
+
+static u16 VT1625_HDTV_720P_720x480_VN[] =3D {
+                                               =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0x3750, 0xD251, 0x2452, 0x2553, 0x1254,     /* TV.50-54 */
+    0xEF55, 0xC756, 0x3057, 0x2358, 0xB759,     /* TV.55-59 */
+    0xC75A, 0xB95B, 0xC75C, 0x435D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0xDD5E, 0x205F, 0x5D60, 0x2861, 0x0062,     /* TV.5E-62 */
+    0x1763, 0x1364, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA, HBS, HBE, HSS, HSE,  VT,  VA, VBS, VBE, VSS, VSE */
+    1080, 720, 720, 360, 1040, 32,  550, 480, 480, 70, 482, 2
+};
+
+static u16 VT1625_HDTV_720P_720x576_VN[] =3D {
+                                               =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xC950, 0xD151, 0x2352, 0x5753, 0x1254,     /* TV.50-54 */
+    0xC955, 0xD156, 0x3057, 0x2358, 0xB259,     /* TV.55-59 */
+    0xA35A, 0xB75B, 0x895C, 0x435D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x665E, 0x005F, 0x6660, 0x2061, 0x0062,     /* TV.5E-62 */
+    0x0763, 0x1364, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA, HBS, HBE, HSS, HSE,  VT,  VA, VBS, VBE, VSS, VSE */
+    970, 720, 720, 250, 928,  28, 600, 576, 576,  24, 577, 3
+};
+
+static u16 VT1625_HDTV_720P_1280x720_VN[] =3D {
+                                               =20
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0x6F50, 0xFF51, 0x4652, 0xED53, 0x1254,     /* TV.50-54 */
+    0x6F55, 0xFF56, 0x5057, 0x4658, 0x2E59,     /* TV.55-59 */
+    0x275A, 0x275B, 0x275C, 0x965D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x005E, 0x005F, 0x8060, 0x2861, 0x0062,     /* TV.5E-62 */
+    0x6F63, 0x3664, 0x5165,                     /* TV.63-65 */
+
+    /* HT,   HA,  HBS, HBE,  HSS, HSE, VT,  VA, VBS, VBE,VSS, VSE */
+    1648, 1280, 1280, 368, 1296, 48, 750, 720, 720, 30, 720, 5
+};
+
+/* 1080I Under Scan */
+static u16 VT1625_HDTV_1080I_640x480_VN[] =3D {
+                                                /* Non-Macrovision =
Registers */
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0x9F50, 0x8251, 0x2552, 0x2553, 0x1254,     /* TV.50-54 */
+    0x1755, 0x7356, 0x4057, 0x2358, 0x7E59,     /* TV.55-59 */
+    0xF85A, 0xA95B, 0x105C, 0x065D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x935E, 0x2A5F, 0x3E60, 0x2861, 0xFF62,     /* TV.5E-62 */
+    0xBF63, 0x1264, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA, HBS, HBE,  HSS, HSE,  VT,  VA, VBS, VBE, VSS, VSE */
+    1440, 640, 640, 800, 1360, 40,  550, 480, 480, 70,  485, 6
+};
+
+static u16 VT1625_HDTV_1080I_800x600_VN[] =3D {
+                                                /* Non-Macrovision =
Registers */
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0x0750, 0x2251, 0x3752, 0xB153, 0x1254,     /* TV.50-54 */
+    0x2F55, 0xAD56, 0x4A57, 0x5758, 0x9259,     /* TV.55-59 */
+    0x735A, 0xC55B, 0x0B5C, 0x475D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x815E, 0xD15F, 0x4E60, 0x2861, 0xFF62,     /* TV.5E-62 */
+    0x4F63, 0x1464, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA, HBS, HBE,  HSS, HSE, VT,  VA, VBS, VBE, VSS, VSE */
+    1800, 800, 800, 1000, 1600, 80, 690, 600, 600, 90, 605, 6
+};
+
+static u16 VT1625_HDTV_1080I_1024x768_VN[] =3D {
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0x0750, 0x0251, 0x4752, 0x7453, 0x1354,     /* TV.50-54 */
+    0x3755, 0x4956, 0x5E57, 0x7958, 0xBC59,     /* TV.55-59 */
+    0x6C5A, 0xFD5B, 0x085C, 0x095D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0xB15E, 0xC95F, 0x6460, 0x2861, 0xFF62,     /* TV.5E-62 */
+    0x8763, 0x2564, 0x5165,                     /* TV.63-65 */
+
+  /*  HT,   HA,  HBS,  HBE,  HSS, HSE,  VT,  VA, VBS, VBE, VSS, VSE */
+    1800, 1024, 1024, 776, 1720, 80,  885, 768, 768, 117, 800, 5
+};
+
+static u16 VT1625_HDTV_1080I_720x480_VN[] =3D {
+                                                /* Non-Macrovision =
Registers */
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0x0750, 0xD251, 0x2752, 0x2553, 0x1254,     /* TV.50-54 */
+    0x6F55, 0xBB56, 0x4657, 0x2358, 0x8D59,     /* TV.55-59 */
+    0x4C5A, 0xBC5B, 0xBC5C, 0x465D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x935E, 0x3D5F, 0x3E60, 0x2861, 0xFF62,     /* TV.5E-62 */
+    0x6F63, 0x1364, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA, HBS,  HBE,  HSS, HSE,  VT,  VA, VBS, VBE, VSS, VSE */
+    1800, 720, 720, 1016, 1680,  56, 550, 480, 480,  70, 485, 6
+};
+
+static u16 VT1625_HDTV_1080I_720x576_VN[] =3D {
+                                                /* Non-Macrovision =
Registers */
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0x1750, 0xCF51, 0x2652, 0x5753, 0x1254,     /* TV.50-54 */
+    0x7F55, 0xCF56, 0x4857, 0x2358, 0x8F59,     /* TV.55-59 */
+    0x5C5A, 0xF05B, 0x935C, 0x465D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x445E, 0x005F, 0x4460, 0x2061, 0xFF62,     /* TV.5E-62 */
+    0x3F63, 0x1364,                             /* TV.63-65 */
+
+    /* HT,  HA, HBS, HBE,  HSS, HSE, VT,  VA, VBS, VBE, VSS, VSE */
+    1560, 720, 720, 840, 1520, 16, 600, 576, 576,  24, 577, 2
+};
+
+static u16 VT1625_HDTV_1080I_1920x1080_VN[] =3D {
+                                                /* Non-Macrovision =
Registeris */
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0x9750, 0x7F51, 0x7852, 0x6453, 0x1454,     /* TV.50-54 */
+    0x9755, 0x7F56, 0x5957, 0x7858, 0xB059,     /* TV.55-59 */
+    0x1A5A, 0xEC5B, 0xFA5C, 0x085D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x005E, 0x005F, 0x8060, 0x2061, 0xFF62,     /* TV.5E-62 */
+    0x9763, 0x2864, 0x5165,                     /* TV.63-65 */
+
+    /* HT,   HA,  HBS, HBE,  HSS, HSE,   VT,   VA,  VBS, VBE,  VSS, VSE =
*/
+    2200, 1920, 1920, 280, 1960, 104, 1125, 1080, 1080,  45, 1083, 4
+};
+
+
+/* 720P Over Scan */
+static u16 VT1625_HDTV_720P_640x480_VO[] =3D {
+                                                /* Non-Macrovision =
Registers */
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xD750, 0x8351, 0x2352, 0xF353, 0x1154,     /* TV.50-54 */
+    0x3355, 0x7B56, 0x2857, 0x2358, 0x9559,     /* TV.55-59 */
+    0x135A, 0x895B, 0x135C, 0x435D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x555E, 0x165F, 0x5560, 0x2861, 0x0062,     /* TV.5E-62 */
+    0x8F63, 0x1264, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    984, 640, 640, 344, 920, 64,  500, 480, 480, 20, 481, 2
+};
+
+static u16 VT1625_HDTV_720P_800x600_VO[] =3D {
+                                                /* Non-Macrovision =
Registers */
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xEF50, 0x1F51, 0x3352, 0x7053, 0x1254,     /* TV.50-54 */
+    0xEF55, 0x1F56, 0x3057, 0x3358, 0xB759,     /* TV.55-59 */
+    0xC75A, 0x9B5B, 0xC75C, 0x435D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0xAA5E, 0x005F, 0x6A60, 0x2061, 0x0062,     /* TV.5E-62 */
+    0x4763, 0x1364, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1008, 800, 800, 208, 936, 56, 625, 600, 600, 25, 603, 2
+};
+
+static u16 VT1625_HDTV_720P_1024x768_VO[] =3D {
+                                                /* Non-Macrovision =
Registers */
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0x3750, 0x0851, 0x4452, 0x1F53, 0x0354,     /* TV.50-54 */
+    0xEF55, 0x1756, 0x3557, 0x3358, 0xB959,     /* TV.55-59 */
+    0xC75A, 0xAA5B, 0xB95C, 0x435D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x885E, 0x7B5F, 0x8860, 0xAA61, 0x0062,     /* TV.5E-62 */
+    0x7F63, 0x1464, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1080, 1024, 1024, 56, 1040, 32,  800, 768, 768, 32, 770, 13
+};
+
+static u16 VT1625_HDTV_720P_720x480_VO[] =3D {
+                                                /* Non-Macrovision =
Registers */
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0x4F50, 0xD351, 0x2452, 0xF353, 0x1154,     /* TV.50-54 */
+    0x9755, 0xD156, 0x2C57, 0x2358, 0xA759,     /* TV.55-59 */
+    0x725A, 0x995B, 0x735C, 0x435D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x555E, 0x005F, 0x5560, 0x0061, 0x0062,     /* TV.5E-62 */
+    0xDF63, 0x1264, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1104, 720, 720, 384, 1040, 64,  500, 480, 480, 20, 482, 2
+};
+
+static u16 VT1625_HDTV_720P_1280x720_VO[] =3D {
+                                                /* Non-Macrovision =
Registers */
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0x7150, 0xFF51, 0x4652, 0xED53, 0x1254,     /* TV.50-54 */
+    0x7155, 0xFF56, 0x5057, 0x4658, 0x3059,     /* TV.55-59 */
+    0x305A, 0x1C5B, 0x475C, 0x965D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x005E, 0x005F, 0x8060, 0x2861, 0x0062,     /* TV.5E-62 */
+    0x7163, 0x3664, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1650, 1280, 1280, 370, 1328, 72,  750, 720, 720, 30, 723, 4
+};
+
+
+/* 1080I Over Scan */
+static u16 VT1625_HDTV_1080I_640x480_VO[] =3D {
+                                                /* Non-Macrovision =
Registers */
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
+=20
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xE750, 0x8351, 0x2552, 0xF353, 0x1154,     /* TV.50-54 */
+    0xD755, 0x7B56, 0x3A57, 0x2258, 0x7459,     /* TV.55-59 */
+    0xBA5A, 0x8E5B, 0x925C, 0x055D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0xE35E, 0x105F, 0x3860, 0x2861, 0xFF62,     /* TV.5E-62 */
+    0x9F63, 0x1264, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1512, 640, 640, 872, 1440, 64,  500, 480, 480, 20, 481, 2
+};
+
+static u16 VT1625_HDTV_1080I_800x600_VO[] =3D {
+                                                /* Non-Macrovision =
Registers */
+    0x0300, 0x0001, 0x1002, 0x4F03, 0x8604,     /* TV.00-04 */
+    0x0005, 0x0006, 0x1207, 0x1508, 0x0309,     /* TV.05-09 */
+    0x000A, 0x000B, 0x000C, 0x000D, 0x000E,     /* TV.0A-0E */
+    0xB00F, 0x0010, 0x8011, 0x0812, 0x0513,     /* TV.0F-13 */
+    0x1514, 0x2015, 0x0016, 0x0017, 0x0018,     /* TV.14-18 */
+    0x0019,                                     /* TV.19 */
+    0x501B, 0x001C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x031F, 0x2520, 0x0021, 0x0022,     /* TV.1E-22 */
+    0x7E23, 0x0024,                             /* TV.23-24 */
+=20
+                                                /* Filter registers */
+    0xC54A, 0x0F4B, 0x004C, 0x014D, 0x004E,     /* TV.4A-4E */
+    0x004F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xE750, 0x2151, 0x3552, 0x7053, 0x1254,     /* TV.50-54 */
+    0x4755, 0xDD56, 0x4357, 0x2358, 0x8559,     /* TV.55-59 */
+    0x245A, 0xA35B, 0x6E5C, 0x465D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x1C5E, 0xBD5F, 0x4760, 0x2861, 0xFF62,     /* TV.5E-62 */
+    0x4763, 0x1364, 0x5165,                     /* TV.63-65 */
+
+  /*HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1512, 800, 800, 712, 1440, 56,  625, 600, 600, 25, 600, 2
+};
+
+static u16 VT1625_HDTV_1080I_1024x768_VO[] =3D {
+                                                /* Non-Macrovision =
Registers */
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
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0xAD50, 0x0151, 0x4652, 0x1F53, 0x1354,     /* TV.50-54 */
+    0x2755, 0x9F56, 0x5557, 0x3458, 0xAA59,     /* TV.55-59 */
+    0xFD5A, 0xD95B, 0x195C, 0x485D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x055E, 0xD75F, 0x5B60, 0x2861, 0xFF62,     /* TV.5E-62 */
+    0xBF63, 0x1464, 0x5165,                     /* TV.63-65 */
+
+  /*HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1710, 1024, 1024, 56, 1584, 96,  800, 768, 768, 32, 770, 13
+};
+
+static u16 VT1625_HDTV_1080I_720x480_VO[] =3D {
+                                                /* Non-Macrovision =
Registers */
+    0x0300, 0x0001, 0x1002, 0x4F03, 0x8604,     /* TV.00-04 */
+    0x0005, 0x0006, 0x0007, 0x1A08, 0x2B09,     /* TV.05-09 */
+    0x000A, 0x000B, 0x000C, 0x000D, 0x000E,     /* TV.0A-0E */
+    0xB00F, 0x0010, 0x8011, 0xE812, 0x3213,     /* TV.0F-13 */
+    0xCF14, 0x2415, 0x0016, 0x0017, 0x0018,     /* TV.14-18 */
+    0x0019,                                     /* TV.19 */
+    0x501B, 0x041C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x031F, 0x2520, 0x0021, 0x0022,     /* TV.1E-22 */
+    0x7E23, 0x0024,                             /* TV.23-24 */
+=20
+                                                /* Filter registers */
+    0xC54A, 0x0F4B, 0x004C, 0x014D, 0x004E,     /* TV.4A-4E */
+    0x004F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0x7750, 0xD351, 0x2652, 0xF353, 0x1154,     /* TV.50-54 */
+    0x3B55, 0xD156, 0x4257, 0x2358, 0x8459,     /* TV.55-59 */
+    0x1A5A, 0xA25B, 0x565C, 0x465D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0xE35E, 0x005F, 0x3860, 0x2861, 0xFF62,     /* TV.5E-62 */
+    0xDF63, 0x1264, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1656, 720, 720, 936, 1584, 72,  500, 480, 480, 20, 485, 6
+};
+
+static u16 VT1625_HDTV_1080I_1920x1080_VO[] =3D {
+                                                /* Non-Macrovision =
Registers */
+    0x8300, 0x0001, 0x1002, 0x4A03, 0x8604,     /* TV.00-04 */
+    0x3905, 0x0006, 0x8B07, 0x3D08, 0x3209,     /* TV.05-09 */
+    0x000A, 0x000B, 0x000C, 0x000D, 0x000E,     /* TV.0A-0E */
+    0x9E0F, 0x0010, 0x8011, 0x4A12, 0x0813,     /* TV.0F-13 */
+    0x3714, 0x1415, 0x0016, 0x0017, 0x0018,     /* TV.14-18 */
+    0x0019,                                     /* TV.19 */
+    0x501B, 0x041C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x031F, 0x2520, 0x0021, 0x0022,     /* TV.1E-22 */
+    0x7E23, 0x0024,                             /* TV.23-24 */
+=20
+                                                /* Filter registers */
+    0xC54A, 0x0F4B, 0x004C, 0x014D, 0x004E,     /* TV.4A-4E */
+    0x004F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV =
Timing Regsiter ) */
+    0x9750, 0x7F51, 0x7852, 0x6453, 0x1454,     /* TV.50-54 */
+    0x9755, 0x7F56, 0x5957, 0x7858, 0xB059,     /* TV.55-59 */
+    0x1A5A, 0xEC5B, 0xFA5C, 0x085D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV =
CRTC Regsiter ) */
+    0x005E, 0x005F, 0x8060, 0x2061, 0xFF62,     /* TV.5E-62 */
+    0x9763, 0x2864, 0x5165,                     /* TV.63-65 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    2200, 1920, 1920, 280, 1960, 104,  1125, 1080, 1080, 45, 1083, 4
+};
+
+
+vt1625_func_table VT1625_HDTV_720P_640x480_tbl[] =3D {
+    {TV_BASE_FUNC,         VT1625_HDTV_720P_640x480_VN,     =
VT1625_NULL_FUNC,   VT1625_HDTV_720P_640x480_VO},
+    {TV_RGB_FUNC,          HDTV_OUT_RGB,                    =
VT1625_NULL_FUNC,   HDTV_OUT_RGB},
+    {TV_YPBPR_FUNC,        HDTV_OUT_YPBPR,                  =
VT1625_NULL_FUNC,   HDTV_OUT_YPBPR},
+    {TV_SDTV_RGB_FUNC,     VT1625_NULL_FUNC,                =
VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_SDTV_YPBPR_FUNC,   VT1625_NULL_FUNC,                =
VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_DeDotCrawl_FUNC,   VT1625_NULL_FUNC,                =
VT1625_NULL_FUNC,   VT1625_NULL_FUNC}
+};
+
+vt1625_func_table VT1625_HDTV_720P_800x600_tbl[] =3D {
+    {TV_BASE_FUNC,         VT1625_HDTV_720P_800x600_VN,     =
VT1625_NULL_FUNC,   VT1625_HDTV_720P_800x600_VO},
+    {TV_RGB_FUNC,          HDTV_OUT_RGB,                    =
VT1625_NULL_FUNC,   HDTV_OUT_RGB},
+    {TV_YPBPR_FUNC,        HDTV_OUT_YPBPR,                  =
VT1625_NULL_FUNC,   HDTV_OUT_YPBPR},
+    {TV_SDTV_RGB_FUNC,     VT1625_NULL_FUNC,                =
VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_SDTV_YPBPR_FUNC,   VT1625_NULL_FUNC,                =
VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_DeDotCrawl_FUNC,   VT1625_NULL_FUNC,                =
VT1625_NULL_FUNC,   VT1625_NULL_FUNC}
+};
+
+vt1625_func_table VT1625_HDTV_720P_1024x768_tbl[] =3D {
+    {TV_BASE_FUNC,         VT1625_HDTV_720P_1024x768_VN,    =
VT1625_NULL_FUNC,   VT1625_HDTV_720P_1024x768_VO},
+    {TV_RGB_FUNC,          HDTV_OUT_RGB,                    =
VT1625_NULL_FUNC,   HDTV_OUT_RGB},
+    {TV_YPBPR_FUNC,        HDTV_OUT_YPBPR,                  =
VT1625_NULL_FUNC,   HDTV_OUT_YPBPR},
+    {TV_SDTV_RGB_FUNC,     VT1625_NULL_FUNC,                =
VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_SDTV_YPBPR_FUNC,   VT1625_NULL_FUNC,                =
VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_DeDotCrawl_FUNC,   VT1625_NULL_FUNC,                =
VT1625_NULL_FUNC,   VT1625_NULL_FUNC}
+};
+
+vt1625_func_table VT1625_HDTV_720P_720x480_tbl[] =3D {
+    {TV_BASE_FUNC,         VT1625_HDTV_720P_720x480_VN,     =
VT1625_NULL_FUNC,   VT1625_HDTV_720P_720x480_VO},
+    {TV_RGB_FUNC,          HDTV_OUT_RGB,                    =
VT1625_NULL_FUNC,   HDTV_OUT_RGB},
+    {TV_YPBPR_FUNC,        HDTV_OUT_YPBPR,                  =
VT1625_NULL_FUNC,   HDTV_OUT_YPBPR},
+    {TV_SDTV_RGB_FUNC,     VT1625_NULL_FUNC,                =
VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_SDTV_YPBPR_FUNC,   VT1625_NULL_FUNC,                =
VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_DeDotCrawl_FUNC,   VT1625_NULL_FUNC,                =
VT1625_NULL_FUNC,   VT1625_NULL_FUNC}
+};
+
+vt1625_func_table VT1625_HDTV_720P_720x576_tbl[] =3D {
+    {TV_BASE_FUNC,         VT1625_HDTV_720P_720x576_VN,     =
VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_RGB_FUNC,          HDTV_OUT_RGB,                    =
VT1625_NULL_FUNC,   HDTV_OUT_RGB},
+    {TV_YPBPR_FUNC,        HDTV_OUT_YPBPR,                  =
VT1625_NULL_FUNC,   HDTV_OUT_YPBPR},
+    {TV_SDTV_RGB_FUNC,     VT1625_NULL_FUNC,                =
VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_SDTV_YPBPR_FUNC,   VT1625_NULL_FUNC,                =
VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_DeDotCrawl_FUNC,   VT1625_NULL_FUNC,                =
VT1625_NULL_FUNC,   VT1625_NULL_FUNC}
+};
+
+vt1625_func_table VT1625_HDTV_720P_1280x720_tbl[] =3D {
+    {TV_BASE_FUNC,         VT1625_HDTV_720P_1280x720_VN,    =
VT1625_NULL_FUNC,   VT1625_HDTV_720P_1280x720_VO},
+    {TV_RGB_FUNC,          HDTV_OUT_RGB,                    =
VT1625_NULL_FUNC,   HDTV_OUT_RGB},
+    {TV_YPBPR_FUNC,        HDTV_OUT_YPBPR,                  =
VT1625_NULL_FUNC,   HDTV_OUT_YPBPR},
+    {TV_SDTV_RGB_FUNC,     VT1625_NULL_FUNC,                =
VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_SDTV_YPBPR_FUNC,   VT1625_NULL_FUNC,                =
VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_DeDotCrawl_FUNC,   VT1625_NULL_FUNC,                =
VT1625_NULL_FUNC,   VT1625_NULL_FUNC}
+};
+
+vt1625_func_table VT1625_HDTV_1080I_640x480_tbl[] =3D {
+    {TV_BASE_FUNC,         VT1625_HDTV_1080I_640x480_VN,    =
VT1625_NULL_FUNC,   VT1625_HDTV_1080I_640x480_VO},
+    {TV_RGB_FUNC,          HDTV_OUT_RGB,                    =
VT1625_NULL_FUNC,   HDTV_OUT_RGB},
+    {TV_YPBPR_FUNC,        HDTV_OUT_YPBPR,                  =
VT1625_NULL_FUNC,   HDTV_OUT_YPBPR},
+    {TV_SDTV_RGB_FUNC,     VT1625_NULL_FUNC,                =
VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_SDTV_YPBPR_FUNC,   VT1625_NULL_FUNC,                =
VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_DeDotCrawl_FUNC,   VT1625_NULL_FUNC,                =
VT1625_NULL_FUNC,   VT1625_NULL_FUNC}
+};
+
+vt1625_func_table VT1625_HDTV_1080I_800x600_tbl[] =3D {
+    {TV_BASE_FUNC,         VT1625_HDTV_1080I_800x600_VN,    =
VT1625_NULL_FUNC,   VT1625_HDTV_1080I_800x600_VO},
+    {TV_RGB_FUNC,          HDTV_OUT_RGB,                    =
VT1625_NULL_FUNC,   HDTV_OUT_RGB},
+    {TV_YPBPR_FUNC,        HDTV_OUT_YPBPR,                  =
VT1625_NULL_FUNC,   HDTV_OUT_YPBPR},
+    {TV_SDTV_RGB_FUNC,     VT1625_NULL_FUNC,                =
VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_SDTV_YPBPR_FUNC,   VT1625_NULL_FUNC,                =
VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_DeDotCrawl_FUNC,   VT1625_NULL_FUNC,                =
VT1625_NULL_FUNC,   VT1625_NULL_FUNC}
+};
+
+vt1625_func_table VT1625_HDTV_1080I_1024x768_tbl[] =3D {
+    {TV_BASE_FUNC,         VT1625_HDTV_1080I_1024x768_VN,   =
VT1625_NULL_FUNC,   VT1625_HDTV_1080I_1024x768_VO},
+    {TV_RGB_FUNC,          HDTV_OUT_RGB,                    =
VT1625_NULL_FUNC,   HDTV_OUT_RGB},
+    {TV_YPBPR_FUNC,        HDTV_OUT_YPBPR,                  =
VT1625_NULL_FUNC,   HDTV_OUT_YPBPR},
+    {TV_SDTV_RGB_FUNC,     VT1625_NULL_FUNC,                =
VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_SDTV_YPBPR_FUNC,   VT1625_NULL_FUNC,                =
VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_DeDotCrawl_FUNC,   VT1625_NULL_FUNC,                =
VT1625_NULL_FUNC,   VT1625_NULL_FUNC}
+};
+
+vt1625_func_table VT1625_HDTV_1080I_720x480_tbl[] =3D {
+    {TV_BASE_FUNC,         VT1625_HDTV_1080I_720x480_VN,    =
VT1625_NULL_FUNC,   VT1625_HDTV_1080I_720x480_VO},
+    {TV_RGB_FUNC,          HDTV_OUT_RGB,                    =
VT1625_NULL_FUNC,   HDTV_OUT_RGB},
+    {TV_YPBPR_FUNC,        HDTV_OUT_YPBPR,                  =
VT1625_NULL_FUNC,   HDTV_OUT_YPBPR},
+    {TV_SDTV_RGB_FUNC,     VT1625_NULL_FUNC,                =
VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_SDTV_YPBPR_FUNC,   VT1625_NULL_FUNC,                =
VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_DeDotCrawl_FUNC,   VT1625_NULL_FUNC,                =
VT1625_NULL_FUNC,   VT1625_NULL_FUNC}
+};
+
+vt1625_func_table VT1625_HDTV_1080I_720x576_tbl[] =3D {
+    {TV_BASE_FUNC,         VT1625_HDTV_1080I_720x576_VN,    =
VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_RGB_FUNC,          HDTV_OUT_RGB,                    =
VT1625_NULL_FUNC,   HDTV_OUT_RGB},
+    {TV_YPBPR_FUNC,        HDTV_OUT_YPBPR,                  =
VT1625_NULL_FUNC,   HDTV_OUT_YPBPR},
+    {TV_SDTV_RGB_FUNC,     VT1625_NULL_FUNC,                =
VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_SDTV_YPBPR_FUNC,   VT1625_NULL_FUNC,                =
VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_DeDotCrawl_FUNC,   VT1625_NULL_FUNC,                =
VT1625_NULL_FUNC,   VT1625_NULL_FUNC}
+};
+
+vt1625_func_table VT1625_HDTV_1080I_1920x1080_tbl[] =3D {
+    {TV_BASE_FUNC,         VT1625_HDTV_1080I_1920x1080_VN,  =
VT1625_NULL_FUNC,   VT1625_HDTV_1080I_1920x1080_VO},
+    {TV_RGB_FUNC,          HDTV_OUT_RGB,                    =
VT1625_NULL_FUNC,   HDTV_OUT_RGB},
+    {TV_YPBPR_FUNC,        HDTV_OUT_YPBPR,                  =
VT1625_NULL_FUNC,   HDTV_OUT_YPBPR},
+    {TV_SDTV_RGB_FUNC,     VT1625_NULL_FUNC,                =
VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_SDTV_YPBPR_FUNC,   VT1625_NULL_FUNC,                =
VT1625_NULL_FUNC,   VT1625_NULL_FUNC},
+    {TV_DeDotCrawl_FUNC,   VT1625_NULL_FUNC,                =
VT1625_NULL_FUNC,   VT1625_NULL_FUNC}
+};
+
+vt1625_func_table VT1625_NULL_TBL[] =3D {
+    {0xFFFF,   VT1625_NULL_FUNC,   VT1625_NULL_FUNC,   =
VT1625_NULL_FUNC}
+};
+
+static struct vt1625_table vt1625_tbl[] =3D {
+    {VIA_RES_640X480,   vt1625_ntsc_640x480_tbl,  =
vt1625_pal_640x480_tbl,  VT1625_HDTV_720P_640x480_tbl,  =
VT1625_HDTV_1080I_640x480_tbl  },
+    {VIA_RES_800X600,   vt1625_ntsc_800x600_tbl,  =
vt1625_pal_800x600_tbl,  VT1625_HDTV_720P_800x600_tbl,  =
VT1625_HDTV_1080I_800x600_tbl  },
+    {VIA_RES_1024X768,  vt1625_ntsc_1024x768_tbl, =
vt1625_pal_1024x768_tbl, VT1625_HDTV_720P_1024x768_tbl, =
VT1625_HDTV_1080I_1024x768_tbl },
+    {VIA_RES_720X480,   vt1625_ntsc_720x480_tbl,  =
vt1625_ntsc_720x480_tbl, VT1625_HDTV_720P_720x480_tbl,  =
VT1625_HDTV_1080I_720x480_tbl  },
+    {VIA_RES_720X576,   vt1625_pal_720x576_tbl,   =
vt1625_pal_720x576_tbl,  VT1625_HDTV_720P_720x576_tbl,  =
VT1625_HDTV_1080I_720x576_tbl  },
+    {VIA_RES_1280X720,  VT1625_NULL_TBL,          VT1625_NULL_TBL,      =
   VT1625_HDTV_720P_1280x720_tbl, VT1625_NULL_TBL                },
+    {VIA_RES_1920X1080, VT1625_NULL_TBL,          VT1625_NULL_TBL,      =
   VT1625_NULL_TBL,               VT1625_HDTV_1080I_1920x1080_tbl}
+};
+
+#define NUM_TOTAL_VT1625_TABLE ARRAY_SIZE(vt1625_tbl)
+
+#define IS_VT1625_NULL_TBL(tbl) tbl[0].tv_func_index =3D=3D 0xFFFF ? =
TRUE : FALSE
+#define IS_VT1625_NULL_FUNC(func) func[0] =3D=3D 0xFFFF ? TRUE : FALSE
+
+static u16 VT1625_CGMS_TBL[] =3D {
+    0x006b, 0x006c, 0x006d, 0x006e, 0x006f, /* TV 0x6b-0x6f */
+    0x0070, 0x0071, 0x0072, 0x0073              /* TV0x70-0x73 */
+};
+#define NUM_TOTAL_VT1625_CGMS_TBL ARRAY_SIZE(VT1625_CGMS_TBL)
+
+#endif /* __TBL1625_H__ */

=20

------_=_NextPart_001_01C7893F.0D39D82C
Content-Type: text/html;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

<HTML dir=3Dltr><HEAD>=0A=
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dunicode">=0A=
<META content=3D"MSHTML 6.00.2900.3059" name=3DGENERATOR></HEAD>=0A=
<BODY><FONT face=3D=B7s=B2=D3=A9=FA=C5=E9 size=3D2>diff -Nur =
linux-2.6.21-rc7/drivers/video/via/tbl1622a.h =
linux-2.6.21-rc7.viafb/drivers/video/via/tbl1622a.h<BR>--- =
linux-2.6.21-rc7/drivers/video/via/tbl1622a.h&nbsp;1969-12-31 =
19:00:00.000000000 -0500<BR>+++ =
linux-2.6.21-rc7.viafb/drivers/video/via/tbl1622a.h&nbsp;2007-04-26 =
19:52:32.000000000 -0400<BR>@@ -0,0 +1,2039 @@<BR>+ /*<BR>+ * Copyright =
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
__TBL1622A_H__<BR>+#define __TBL1622A_H__<BR>+<BR>+#include =
"share.h"<BR>+<BR>+/***************************/<BR>+/* VT1622A TV =
Encoder Table*/<BR>+/***************************/<BR>+typedef struct =
_vt1622a_func_table {<BR>+&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp; =
tv_func_index;<BR>+&nbsp;&nbsp;&nbsp; u16&nbsp;&nbsp;&nbsp;&nbsp; =
*tv_underscan;<BR>+&nbsp;&nbsp;&nbsp; u16&nbsp;&nbsp;&nbsp;&nbsp; =
*tv_fitscan;<BR>+&nbsp;&nbsp;&nbsp; u16&nbsp;&nbsp;&nbsp;&nbsp; =
*tv_overscan;<BR>+} vt1622a_func_table;<BR>+<BR>+struct vt1622a_table =
{<BR>+&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp; =
tv_index;<BR>+&nbsp;&nbsp;&nbsp; vt1622a_func_table&nbsp;&nbsp; =
*tv_mode_ntsc;<BR>+&nbsp;&nbsp;&nbsp; vt1622a_func_table&nbsp;&nbsp; =
*tv_mode_pal;<BR>+};<BR>+<BR>+<BR>+/* Underscan table */<BR>+static u16 =
VT1622A_N640x480_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x0400, 0x0001, 0x0002, 0x0603, =
0x0304,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x2006, 0x2707, 0x9A08, 0x0C09,&nbsp;&nbsp;&nbsp;&nbsp; /* =
Tv.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x550A, 0x000B, 0x520C, 0x3B0D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0xF812, 0x3E13,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x8114, 0x5615, 0xF116, 0x9117, =
0x2418,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2519,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x101B, 0x001C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x111F, 0x1520, 0x0C21, =
0x5F22,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7523, =
0x0824,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0x004A, 0x004B, 0x004C, =
0x044D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x3B4F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x0F50, 0x7F51, 0x2352, 0x5753, 0x0254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x0F55, 0x2756, 0x7357, 0x6358, =
0x8659,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xC45A, 0xDD5B, 0xD35C, =
0x055D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x925E, 0xA45F, 0x0460, 0x0061, 0x0062,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x7F63, =
0x0364,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 784, 640, 640, 144, 688, 56,&nbsp; =
600, 480, 480, 120, 488, 7<BR>+};<BR>+<BR>+#define NUM_TOTAL_VT1622A_REG =
ARRAY_SIZE(VT1622A_N640x480_VN) -NUM_CRTC_TIMING<BR>+<BR>+static u16 =
VT1622A_N800x600_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x8400, 0x0001, 0x0002, 0x0403, =
0x0304,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x2006, 0x5707, 0xD408, 0x0909,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x520A, 0x000B, 0x510C, 0x3B0D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0x6A12, 0x0D13,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x4C14, 0x1C15, 0x9616, 0x5017, =
0x5E18,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x1B19,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x101B, 0x011C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x441F, 0x1020, 0x0A21, =
0x9C22,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7523, =
0x0424,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0x004A, 0x004B, 0x004C, =
0x044D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x3A4F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x2750, 0x1F51, 0x3452, 0xED53, 0x0254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x2755, 0xF556, 0x9D57, 0x6458, =
0xB759,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0D5A, 0x215B, 0xF15C, =
0x575D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xB65E, 0x3B5F, 0x0560, 0x0061, 0x0162,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0xEF63, =
0x0564,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 1064,800, 800, 264, 840, 136, 750, =
600, 600, 150, 606, 16<BR>+};<BR>+<BR>+static u16 VT1622A_N1024x768_VN[] =
=3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x8400, 0x0001, 0x0002, 0x0403, =
0x0304,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x2006, 0x4707, 0x1208, 0x0809,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x500A, 0x000B, 0x500C, 0x3A0D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0xEF12, 0x3713,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x7714, 0x2A15, 0xD616, 0x6617, =
0xEB18,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x1419,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x101B, 0x051C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x771F, 0x0D20, 0x0521, =
0xEF22,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7323, =
0x0C24,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0x004A, 0x004B, 0x004C, =
0x044D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x394F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x8750, 0xFF51, 0x3452, 0xB053, 0x0354,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x6F55, 0xDC56, 0xCD57, 0x3558, =
0xF159,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0x5E5A, 0x9A5B, 0x705C, =
0x5A5D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x335E, 0x265F, 0x0760, 0x0061, 0x0162,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x2763, =
0x0864,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 1160,1024,1024,136, 1040,56,&nbsp; =
945, 768, 768, 177, 789, 6<BR>+};<BR>+<BR>+static u16 =
VT1622A_N848x480_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x8400, 0x0001, 0x0002, 0x0403, =
0x0304,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x2006, 0xa707, 0xc108, 0x0709,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x500A, 0x000B, 0x500C, 0x390D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0xF012, 0x2913,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x6714, 0x3115, 0x6316, 0xA817, =
0x3C18,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x1D19,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x101B, 0x031C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x331F, 0x1120, 0x0821, =
0x4722,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7323, =
0x0C24,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 */<BR>+ =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0x004A, 0x004B, 0x004C, =
0x044D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x394F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xAF50, 0x4F51, 0x3452, 0x4453, 0x0254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0xE355, 0xBF56, 0x9357, 0x6358, =
0xAD59,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xFD5A, 0x1B5B, 0x6F5C, =
0x175D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x6D5E, 0xD45F, 0x0460, 0x0061, 0x0162,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x2F63, =
0x0564,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 1200,848, 848, 352, 968, 64,&nbsp; =
581, 480, 480, 101, 496, 13<BR>+};<BR>+<BR>+static u16 =
VT1622A_N720x480_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x0400, 0x0001, 0x0002, 0x0603, =
0x0304,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x2006, 0x3F07, 0xB608, 0x0709,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x520A, 0x000B, 0x510C, 0x3A0D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0xED12, 0x3113,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x5014, 0x3515, 0x1816, 0x5517, =
0x5518,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x1E19,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x101B, 0x031C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x331F, 0x1220, 0x0821, =
0x5722,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7523, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0x004A, 0x004B, 0x004C, =
0x044D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x3A4F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x4750, 0xCF51, 0x2352, 0x5753, 0x0254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0xBF55, 0xAD56, 0x8D57, 0x6358, =
0xA459,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xF35A, 0x1E5B, 0x285C, =
0x175D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x925E, 0x335F, 0x0460, 0x0061, 0x0062,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0xBF63, =
0x0364,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 840, 720, 720, 120, 728, 48,&nbsp; =
600, 480, 480, 120, 512, 7<BR>+};<BR>+<BR>+static u16 =
VT1622A_P640x480_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x0400, 0x0001, 0x0002, 0x0603, =
0x0004,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x2006, 0xBF07, 0x9F08, 0x3709,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x5D0A, 0x000B, 0x4F0C, 0x420D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0xAC12, 0x1513,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x6E14, 0x2815, 0x2D16, 0x7717, =
0x6618,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2D19,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x101B, 0x021C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x991F, 0x1720, 0x0C21, =
0x3122,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7A23, =
0x0424,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0x004A, 0x004B, 0x004C, =
0x044D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x434F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xE750, 0x7F51, 0x2352, 0x5753, 0x0254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x1F55, 0x2F56, 0x7557, 0x6358, =
0x8A59,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xC85A, 0xDB5B, 0xF55C, =
0x055D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xD75E, 0x8E5F, 0x0360, 0x7F61, 0xCF62,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0xBF63, =
0x0364,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 1000,640, 640, 360, 736, 72,&nbsp; =
600, 480, 480, 120, 521, 5<BR>+};<BR>+<BR>+static u16 =
VT1622A_P800x600_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x8400, 0x0001, 0x0002, 0x0403, =
0x0004,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */ <BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x2006, 0x2707, 0xB808, 0x0D09,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x5C0A, 0x000B, 0x4E0C, 0x400D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0xEC12, 0x2A13,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0xFD14, 0x2815, 0xE416, 0x7D17, =
0x7A18,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2719,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x101B, 0x011C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0xAA1F, 0x1320, 0x0C21, =
0x9F22,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7923, =
0x0C24,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0x004A, 0x004B, 0x004C, =
0x044D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x414F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F */<BR>+ =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; 0x9750, =
0x1F51, 0x3352, 0xED53, 0x0254,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.50-54 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x9755, 0x8756, 0x8757, 0x6358, =
0x9F59,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xE75A, 0xF35B, 0xE15C, =
0x065D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xCC5E, 0xF35F, 0x0460, 0x0061, 0x0162,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x4F63, =
0x0464,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 920, 800, 800, 120, 816, 64,&nbsp; =
750, 600, 600, 150, 606, 16<BR>+};<BR>+<BR>+static u16 =
VT1622A_P1024x768_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x8400, 0x0001, 0x0002, 0x0403, =
0x0004,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x2006, 0x5707, 0x2508, 0x4009,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x5A0A, 0x000B, 0x4D0C, 0x400D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0xE812, 0x2313,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0xD114, 0x1815, 0x7216, 0xC317, =
0x8C18,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x1A19,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x101B, 0x071C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0xFF1F, 0x0F20, 0x0C21, =
0x8722,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7923, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0x004A, 0x004B, 0x004C, =
0x044D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x404F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xAF50, 0xFF51, 0x3452, 0xB553, 0x0354,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x5755, 0xA856, 0xC857, 0x3558, =
0xEC59,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0x4C5A, 0x9A5B, 0x415C, =
0x5A5D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x145E, 0x5C5F, 0x0660, 0x0061, 0x0162,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x1F63, =
0x0764,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 1200,1024,1024,176, 1040,80,&nbsp; =
950, 768, 768, 182, 802, 3<BR>+};<BR>+<BR>+static u16 =
VT1622A_P848x480_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x0400, 0x0001, 0x0002, 0x0603, =
0x0004,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x2006, 0xa707, 0xE608, 0x0609,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */ <BR>+&nbsp;&nbsp;&nbsp; 0x5C0A, 0x000B, 0x4E0C, 0x410D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0xE612, 0x2313,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x8414, 0x1815, 0x1816, 0x2817, =
0x8718,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x1F19,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x101B, 0x011C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0xCC1F, 0x0F20, 0x0C21, =
0x6022,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7923, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0x004A, 0x004B, 0x004C, =
0x044D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x404F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xAF50, 0x4F51, 0x3452, 0x5753, 0x0254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x7F55, 0x3156, 0xA957, 0x7458, =
0xD159,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2B5A, 0x415B, 0xA55C, =
0x585D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xD75E, 0x265F, 0x0360, 0x0061, 0x0162,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x7F63, =
0x0464,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 1200,848, 848, 352, 976, 56,&nbsp; =
600, 480, 480, 120, 499, 11<BR>+};<BR>+<BR>+static u16 =
VT1622A_P720x576_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x0400, 0x0001, 0x0002, 0x0603, =
0x0004,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x2006, 0x4907, 0xCC08, 0x0609,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x5C0A, 0x000B, 0x4D0C, 0x410D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0xF012, 0x2413,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x3F14, 0x3915, 0x6016, 0x9017, =
0xC818,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2319,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x101B, 0x011C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0xBB1F, 0x1420, 0x0C21, =
0xD922,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7923, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0x004A, 0x004B, 0x004C, =
0x044D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x414F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xE750, 0xCF51, 0x2352, 0xD453, 0x0254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0xF655, 0xCF56, 0x9557, 0x6358, =
0xAE59,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xF55A, 0x1C5B, 0x965C, =
0x175D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xA45E, 0x005F, 0x0460, 0x0061, 0x0162,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x8763, =
0x0464,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 1000,720, 720, 280, 840, 96,&nbsp; =
725, 576, 576, 149, 602, 9<BR>+};<BR>+<BR>+<BR>+/* Fit Industry TV =
Screen Mode */<BR>+<BR>+static u16 VT1622A_N640x480_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x0400, 0x0001, 0x0002, 0x0603, =
0x0304,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x2006, 0x2E07, 0x8208, 0x0609,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x560A, 0x050B, 0x500C, 0x3B0D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0xF812, 0x2713,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x9E14, 0x5515, 0x4216, 0x8517, =
0x2C18,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2419,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x101B, 0x021C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x111F, 0x1720, 0x0C21, =
0xD522,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7323, =
0x0424,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0x004A, 0x004B, 0x004C, =
0x044D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x3A4F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x4750, 0x8151, 0x2352, 0x3E53, 0x0254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x2455, 0x6756, 0x7757, 0x6358, =
0x8859,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xCB5A, 0xDA5B, 0x005C, =
0x065D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x625E, 0x2C5F, 0x0460, 0x0061, 0x0062,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x9763, =
0x0364,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 840, 640, 640, 200, 736, 56,&nbsp; =
575, 480, 480, 95,&nbsp; 499, 7<BR>+};<BR>+<BR>+static u16 =
VT1622A_N800x600_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x0400, 0x0001, 0x0002, 0x0603, =
0x0304,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x2006, 0x8707, 0x9608, 0xFA09,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x560A, 0x000B, 0x500C, 0x3B0D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0xED12, 0x1913,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0xA014, 0x1C15, 0xBE16, 0xFF17, =
0x7F18,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2019,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x101B, 0x011C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x221F, 0x1120, 0x0A21, =
0xDE22,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7323, =
0x0424,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0x004A, 0x004B, 0x004C, =
0x044D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x3A4F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xAF50, 0x1F51, 0x3452, 0xD753, 0x0254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x7F55, 0xA956, 0x8457, 0x2358, =
0x9859,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xE35A, 0xE45B, 0xAE5C, =
0x065D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x8C5E, 0xB65F, 0x0560, 0x0061, 0x0162,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x7F63, =
0x0664,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 1200,800, 800, 400, 848, 216, 728, =
600, 600, 128, 656, 9<BR>+};<BR>+<BR>+static u16 VT1622A_N1024x768_VF[] =
=3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x8400, 0x0001, 0x0002, 0x0403, =
0x0304,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x2006, 0x4E07, 0xDB08, 0x0C09,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x520A, 0x000B, 0x4F0C, 0x3A0D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0x6812, 0x0D13,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x4A14, 0x1415, 0x3216, 0x8A17, =
0x7C18,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x1619,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x101B, 0x031C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x661F, 0x0D20, 0x0521, =
0x2422,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7323, =
0x0424,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0x004A, 0x004B, 0x004C, =
0x044D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x394F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F */ <BR>+ =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; 0x9750, =
0xFF51, 0x3452, 0x9C53, 0x0354,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.50-54 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0E55, 0xDE56, 0xBF57, 0x3558, =
0xDD59,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0x495A, 0x7B5B, 0xB35C, =
0x595D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x0C5E, 0x235F, 0x0760, 0x0061, 0x0162,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x1763, =
0x0864,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 1176,1024,1024,152, 1040,64,&nbsp; =
925, 768, 768, 157, 779, 12<BR>+};<BR>+<BR>+static u16 =
VT1622A_N848x480_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x0400, 0x0001, 0x0002, 0x0603, =
0x0304,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x2006, 0x4707, 0xB508, 0x0B09,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x530A, 0x000B, 0x500C, 0x3A0D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0xED12, 0x2313,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x0E14, 0x3515, 0x8416, 0x8417, =
0xF618,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x1A19,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x101B, 0x031C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D */ =
<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x441F, 0x1120, 0x0A21, =
0x7822,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7323, =
0x0424,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0x004A, 0x004B, 0x004C, =
0x044D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x394F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xE750, 0x4F51, 0x3352, 0x3653, 0x0254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x3755, 0x3956, 0x9F57, 0x7458, =
0xB759,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0x125A, 0x3A5B, 0x125C, =
0x585D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x525E, 0x1A5F, 0x0460, 0x0061, 0x0162,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x3763, =
0x0464,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 1000,848, 848, 152, 872, 56,&nbsp; =
567, 480, 480, 87,&nbsp; 485, 7<BR>+};<BR>+<BR>+static u16 =
VT1622A_N720x480_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x0400, 0x0001, 0x0002, 0x0603, =
0x0304,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x2006, 0x3F07, 0x9808, 0x0A09,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x530A, 0x000B, 0x500C, 0x3B0D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0xF512, 0x2713,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x9E14, 0x5515, 0x9A16, 0xF417, =
0xA618,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x1F19,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x101B, 0x031C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x221F, 0x1620, 0x0821, =
0xF622,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7323, =
0x0424,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0x004A, 0x004B, 0x004C, =
0x044D, 0x084E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x3A4F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x4750, 0xCF51, 0x2352, 0x3E53, 0x0254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x9755, 0xBE56, 0x8857, 0x6358, =
0x9C59,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xE95A, 0xE15B, 0xDC5C, =
0x065D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x625E, 0x175F, 0x0460, 0x0061, 0x0062,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x9763, =
0x0364,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 840, 720, 720, 120, 728, 48,&nbsp; =
575, 480, 480, 95,&nbsp; 484, 15<BR>+};<BR>+<BR>+static u16 =
VT1622A_P640x480_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x0400, 0x0001, 0x0002, 0x0603, =
0x0004,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x2006, 0x4E07, 0x8A08, 0x3009,&nbsp;&nbsp;&nbsp;&nbsp; /* =
Tv.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x5D0A, 0x000B, 0x4D0C, 0x410D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0xF812, 0x1813,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0xFD14, 0x5415, 0xBC16, 0x4617, =
0x1E18,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2D19,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x101B, 0x021C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x991F, 0x1B20, 0x0C21, =
0x8722,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7923, =
0x0424,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0x004A, 0x004B, 0x004C, =
0x044D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x434F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xE750, 0x7F51, 0x2352, 0x3E53, 0x0254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x2455, 0x5D56, 0x7657, 0x6358, =
0x8959,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xC25A, 0x145B, 0x1C5C, =
0x165D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xAE5E, 0x3A5F, 0x0360, 0x0061, 0x0062,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0xBF63, =
0x0364,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 1000,640, 640, 360, 840, 80,&nbsp; =
575, 480, 480, 95,&nbsp; 501, 3<BR>+};<BR>+<BR>+static u16 =
VT1622A_P800x600_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x0400, 0x0001, 0x0002, 0x0603, =
0x0004,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x2006, 0x4607, 0xB308, 0x0F09,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x5C0A, 0x000B, 0x4D0C, 0x410D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0xF012, 0x2413,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x3F14, 0x3915, 0x6016, 0x9017, =
0xC818,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2319,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x101B, 0x011C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0xBB1F, 0x1420, 0x0C21, =
0xD922,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7923, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 */<BR>+ =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0x004A, 0x004B, 0x004C, =
0x044D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x414F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xE750, 0x2151, 0x3352, 0xD453, 0x0254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0xF655, 0xFD56, 0x9557, 0x6358, =
0xAE59,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xF55A, 0x1C5B, 0x965C, =
0x175D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xA45E, 0x315F, 0x0460, 0x0061, 0x0162,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x8763, =
0x0464,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 1000,800, 800, 200, 848, 80,&nbsp; =
725, 600, 600, 125, 602, 1<BR>+};<BR>+<BR>+static u16 =
VT1622A_P1024x768_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x8400, 0x0001, 0x0002, 0x0403, =
0x0004,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x2006, 0x5707, 0xF208, 0x4009,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x5B0A, 0x000B, 0x4E0C, 0x400D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0xF012, 0x2313,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x9714, 0x3115, 0xB416, 0x7517, =
0x4418,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x1B19,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x101B, 0x031C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0xEE1F, 0x0D20, 0x0C21, =
0x8722,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7923, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0x004A, 0x004B, 0x004C, =
0x044D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x404F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xAF50, 0xFF51, 0x3452, 0x9C53, 0x0354,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x3355, 0xE656, 0xC357, 0x3558, =
0xE959,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0x515A, 0x7F5B, 0x015C, =
0x5A5D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xEB5E, 0x195F, 0x0560, 0x0061, 0x0162,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0xEF63, =
0x0664,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 1200,1024,1024,176, 1040,72,&nbsp; =
925, 768, 768, 157, 782, 13<BR>+};<BR>+<BR>+static u16 =
VT1622A_P848x480_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x0400, 0x0001, 0x0002, 0x0603, =
0x0004,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x2006, 0x4A07, 0xC808, 0x3909,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x5B0A, 0x000B, 0x4D0C, 0x3F0D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0xEA12, 0x2A13,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0xFD14, 0x3015, 0x9316, 0x1317, =
0xE618,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2019,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x101B, 0x031C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0xCC1F, 0x1220, 0x0C21, =
0x2922,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7923, =
0x0824,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0x004A, 0x004B, 0x004C, =
0x044D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x404F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xE750, 0x4F51, 0x3352, 0x3E53, 0x0254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x4F55, 0x3856, 0xA257, 0x7458, =
0xBE59,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0B5A, 0x3C5B, 0x475C, =
0x585D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xAE5E, 0x1C5F, 0x0360, 0x0061, 0x0162,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x9763, =
0x0364,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 1000,848, 848, 152, 856, 72,&nbsp; =
575, 480, 480, 95,&nbsp; 486, 3<BR>+};<BR>+<BR>+static u16 =
VT1622A_P720x576_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x0400, 0x0001, 0x0002, 0x0603, =
0x0004,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x2006, 0x2707, 0xAF08, 0x3309,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x620A, 0x000B, 0x4D0C, 0x440D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0x0912, 0x0713,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x2114, 0x2815, 0x5016, 0x6317, =
0xD518,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2519,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x101B, 0x031C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0xAA1F, 0x1720, 0x0C21, =
0xF322,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7923, =
0x4824,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0x004A, 0x004B, 0x004C, =
0x044D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x424F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x1F50, 0xCF51, 0x2352, 0xA253, 0x0254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0xBF55, 0xC956, 0x8D57, 0x2358, =
0xA559,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xE85A, 0x1B5B, 0x2C5C, =
0x175D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x525E, 0x085F, 0x0460, 0x0061, 0x0062,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x5F63, =
0x0364,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 800, 720, 720, 80,&nbsp; 728, =
32,&nbsp; 675, 576, 576, 99,&nbsp; 602, 9<BR>+};<BR>+<BR>+/* TV Overscan =
Table */<BR>+<BR>+static u16 VT1622A_N640x480_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; 0x0400, 0x0001, 0x0002, 0x0603, =
0x0304,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x2006, 0x2F07, 0x6408, 0xFA09,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x5E0A, 0x170B, 0x500C, 0x3F0D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0x7012, 0x0D13,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x5014, 0x3815, 0x4516, 0x9917, =
0x9918,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2919,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x101B, 0x001C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x001F, 0x1720, 0x0C21, =
0x4822,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7423, =
0x0824,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0x004A, 0x004B, 0x004C, =
0x044D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x3B4F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x1F50, 0x7F51, 0x2352, 0x0C53, 0x0254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0xBB55, 0x3356, 0x6757, 0x6258, =
0x7659,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xB05A, 0xA15B, 0x2F5C, =
0x055D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x005E, 0x945F, 0x8460, 0x0061, 0x0062,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x1F63, =
0x0364,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 800, 640, 640, 160, 656, 96,&nbsp; =
525, 480, 480, 45,&nbsp; 495, 11<BR>+};<BR>+<BR>+static u16 =
VT1622A_N800x600_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; 0x8400, 0x0001, 0x0002, 0x0403, =
0x0304,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x2006, 0x4607, 0x8108, 0xFE09,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x570A, 0x000B, 0x500C, 0x3D0D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0x4A12, 0x0D13,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x3E14, 0x1C15, 0xD116, 0x6217, =
0x8C18,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2119,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x101B, 0x011C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x221F, 0x1120, 0x0A21, =
0xB422,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7323, =
0x0824,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0x004A, 0x004B, 0x004C, =
0x044D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x394F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xEF50, 0x1F51, 0x3352, 0x8A53, 0x0254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x6355, 0xDE56, 0x8057, 0x6358, =
0x9359,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xDC5A, 0xE05B, 0x7F5C, =
0x065D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xF65E, 0x9B5F, 0x0460, 0x0061, 0x0162,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0xD763, =
0x0464,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 1000,800, 800, 200, 832, 96,&nbsp; =
651, 600, 600, 51,&nbsp; 608, 12<BR>+};<BR>+<BR>+static u16 =
VT1622A_N1024x768_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; 0x8400, 0x0001, 0x0002, 0x0403, =
0x0304,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */ <BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x2006, 0x2F07, 0xB608, 0x0409,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x540A, 0x000B, 0x500C, 0x3C0D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0x6A12, 0x0D13,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x5814, 0x1C15, 0x8A16, 0xE817, =
0xA218,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x1719,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x101B, 0x031C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x551F, 0x0F20, 0x0521, =
0x7222,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7323, =
0x0824,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0x004A, 0x004B, 0x004C, =
0x044D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x394F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x5F50, 0xFF51, 0x3452, 0x3853, 0x0354,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0xCF55, 0xE056, 0xB657, 0x3458, =
0xD259,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0x395A, 0x5C5B, 0x415C, =
0x595D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x495E, 0x235F, 0x0660, 0x0061, 0x0162,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0xDF63, =
0x0664,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 1120,1024,1024,96,&nbsp; =
1040,40,&nbsp; 825, 768, 768, 57,&nbsp; 770, 6<BR>+};<BR>+<BR>+static =
u16 VT1622A_N848x480_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; 0x8400, 0x0001, 0x0002, 0x0403, =
0x0304,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x2006, 0x4E07, 0x9E08, 0x0709,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x510A, 0x000B, 0x500C, 0x3A0D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0xED12, 0x2313,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x0814, 0x3515, 0xA116, 0x6417, =
0x9318,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x1B19,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x101B, 0x031C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x441F, 0x1120, 0x0A21, =
0xF022,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7323, =
0x0424,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0x004A, 0x004B, 0x004C, =
0x044D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x394F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xEF50, 0x5151, 0x3352, 0x2553, 0x0254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x1F55, 0x4756, 0x9C57, 0x7458, =
0xB559,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0C5A, 0x3D5B, 0xF15C, =
0x575D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x305E, 0x0C5F, 0x0460, 0x0061, 0x0162,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x1F63, =
0x0464,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 1008,848, 848, 160, 856, 72,&nbsp; =
550, 480, 480, 70,&nbsp; 491, 5<BR>+};<BR>+<BR>+static u16 =
VT1622A_N720x480_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x0400, 0x0001, 0x0002, 0x0603, =
0x0304,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x2006, 0x2807, 0x5208, 0x0809,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x5B0A, 0x000B, 0x500C, 0x400D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0x2D12, 0x0713,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x2814, 0x3415, 0x1D16, 0x6617, =
0x6618,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2419,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x101B, 0x021C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x111F, 0x1620, 0x0821, =
0xDF22,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7623, =
0x0424,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0x004A, 0x004B, 0x004C, =
0x044D, 0x084E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x3A4F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x1F50, 0xCF51, 0x2352, 0x0C53, 0x0254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x1F55, 0xCE56, 0x7657, 0x2358, =
0x8859,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xC95A, 0xEF5B, 0xFF5C, =
0x055D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x005E, 0x005F, 0x0060, 0x0061, 0x0062,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x1F63, =
0x0364,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 800, 720, 720, 80,&nbsp; 728, =
32,&nbsp; 525, 480, 480, 45,&nbsp; 482, 1<BR>+};<BR>+<BR>+static u16 =
VT1622A_P640x480_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; 0x0400, 0x0001, 0x0002, 0x0603, =
0x0004,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x2006, 0x4F07, 0x7008, 0x2E09,&nbsp;&nbsp;&nbsp;&nbsp; /* =
Tv.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x670A, 0x000B, 0x4D0C, 0x460D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0x4A12, 0x0E13,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x3714, 0x2415, 0xC016, 0xD917, =
0x7118,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x3219,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x101B, 0x021C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x881F, 0x1B20, 0x0C21, =
0xEF22,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7923, =
0x0424,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0x004A, 0x004B, 0x004C, =
0x044D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x444F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xE750, 0x7F51, 0x2352, 0xF353, 0x0154,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0xCF55, 0xB756, 0x6957, 0x3258, =
0x7A59,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xAD5A, 0xBF5B, 0x5F5C, =
0x055D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x335E, 0x865F, 0x0360, 0x0061, 0x0062,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x1F63, =
0x0364,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 1000,640, 640, 360, 800, 120, 500, =
480, 480, 20,&nbsp; 485, 6<BR>+};<BR>+<BR>+static u16 =
VT1622A_P800x600_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; 0x8400, 0x0001, 0x0002, 0x0403, =
0x0004,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x2006, 0x4707, 0x9108, 0x3109,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x610A, 0x000B, 0x4D0C, 0x430D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0xED12, 0x1513,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x8F14, 0x3015, 0x5016, 0x6317, =
0xD518,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2519,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x101B, 0x031C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0xAA1F, 0x1420, 0x0C21, =
0x7922,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7923, =
0x0824,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0x004A, 0x004B, 0x004C, =
0x044D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x414F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xE750, 0x2151, 0x3352, 0x8953, 0x0254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0xBF55, 0xFD56, 0x8D57, 0x2358, =
0xA559,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xE85A, 0xE95B, 0x325C, =
0x075D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x295E, 0x325F, 0x0460, 0x0061, 0x0162,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x0F63, =
0x0464,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 1000,800, 800, 200, 872, 56,&nbsp; =
650, 600, 600, 50,&nbsp; 608, 12<BR>+};<BR>+<BR>+static u16 =
VT1622A_P1024x768_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; 0x8400, 0x0001, 0x0002, 0x0403, =
0x0004,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x2006, 0x3707, 0xBD08, 0x3709,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x5E0A, 0x000B, 0x4D0C, 0x420D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0xC912, 0x1413,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x7914, 0x1C15, 0x3816, 0x0E17, =
0x7B18,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x1D19,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x101B, 0x031C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0xDD1F, 0x0F20, 0x0C21, =
0xC022,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7923, =
0x0824,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0x004A, 0x004B, 0x004C, =
0x044D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x404F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xAF50, 0xFF51, 0x3452, 0x3853, 0x0354,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0xCF55, 0xE356, 0xB457, 0x3458, =
0xD459,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2B5A, 0x405B, 0x525C, =
0x595D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x485E, 0x215F, 0x0560, 0x0061, 0x0162,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x2F63, =
0x0664,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 1200,1024,1024,176, 1088,56,&nbsp; =
825, 768, 768, 57,&nbsp; 771, 5<BR>+};<BR>+<BR>+static u16 =
VT1622A_P848x480_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x8400, 0x0001, 0x0002, 0x0403, =
0x0004,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x2006, 0xA507, 0xA108, 0x3809,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x5E0A, 0x000B, 0x4D0C, 0x410D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0xC712, 0x1E13,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x7914, 0x1C15, 0xEC16, 0xE517, =
0x6418,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2219,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x101B, 0x031C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0xBB1F, 0x1220, 0x0C21, =
0x5A22,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7923, =
0x0C24,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0x004A, 0x004B, 0x004C, =
0x044D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x3A4F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xAF50, 0x4F51, 0x3452, 0x2553, 0x0254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x1F55, 0x4F56, 0x9B57, 0x7458, =
0xB759,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0A5A, 0x3F5B, 0xF05C, =
0x585D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x855E, 0x005F, 0x0360, 0x0061, 0x0162,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x1F63, =
0x0464,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 1200,848, 848, 352, 864, 176, 550, =
480, 480, 70,&nbsp; 491, 5<BR>+};<BR>+<BR>+static u16 =
VT1622A_P720x576_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x0400, 0x0001, 0x0002, 0x0603, =
0x0004,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x2006, 0x3F07, 0x8908, 0x3909,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x630A, 0x000B, 0x500C, 0x450D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0xE812, 0x2313,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x8414, 0x2015, 0xCB16, 0x8A17, =
0x0918,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2A19,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x101B, 0x021C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x991F, 0x1720, 0x0C21, =
0x6F22,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7923, =
0x4824,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0x004A, 0x004B, 0x004C, =
0x044D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x3A4F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x5F50, 0xCF51, 0x2352, 0x7053, 0x0254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x5F55, 0xBF56, 0x7E57, 0x2358, =
0x9459,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xD05A, 0x275B, 0x8F5C, =
0x165D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x005E, 0x005F, 0x0460, 0x0061, 0x0062,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x5F63, =
0x0364,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 864, 720, 720, 144, 760, 40,&nbsp; =
625, 576, 576, 49,&nbsp; 577, =
3<BR>+};<BR>+<BR>+/***********************************/<BR>+/* VT1622A =
output RGB Table&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+/***********************************/<BR>+<BR>+/* NTSC =
*/<BR>+<BR>+static u16 VT1622A_N640x480_RGB_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x2A02,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output RGB =
type (SCART Connector) */<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x9127, 0x9C2B, =
0x272C,&nbsp;&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N800x600_RGB_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x2A02,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output RGB =
type (SCART Connector) */<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x9127, =
0x9C2B,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; <BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N1024x768_RGB_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x2A02,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output RGB =
type (SCART Connector) */<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x9127, =
0x9C2B,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; <BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N848x480_RGB_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x2A02,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output RGB =
type (SCART Connector) */<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x9127, =
0x9C2B,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; <BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N720x480_RGB_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x2A02,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output RGB =
type (SCART Connector) */<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x9127, =
0x9C2B,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; <BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N640x480_RGB_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x2A02,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output RGB =
type (SCART Connector) */<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x9127, 0x9C2B, =
0x272C,&nbsp;&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N800x600_RGB_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x2A02,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output RGB =
type (SCART Connector) */<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x9127, =
0x9C2B,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N1024x768_RGB_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x2A02,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output RGB =
type (SCART Connector) */<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x9127, =
0x9C2B,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N848x480_RGB_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x2A02,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output RGB =
type (SCART Connector) */<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x9127, =
0x9C2B,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; <BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N720x480_RGB_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x2A02,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output RGB =
type (SCART Connector) */<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x9127, =
0x9C2B,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; <BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N640x480_RGB_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x2A02,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output RGB =
type (SCART Connector) */<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N800x600_RGB_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x2A02,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output RGB =
type (SCART Connector) */<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N1024x768_RGB_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x2A02,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output RGB =
type (SCART Connector) */<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N848x480_RGB_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x2A02,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output RGB =
type (SCART Connector) */<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N720x480_RGB_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x2A02,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output RGB =
type (SCART Connector) */<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+<BR>+<BR>+/* PAL */<BR>+<BR>+<BR>+static u16 =
VT1622A_P640x480_RGB_VN[] =3D {<BR>+&nbsp;&nbsp;&nbsp; =
0x2A02,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output RGB =
type (SCART Connector) */<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x9127, 0x9C2B, =
0x272C,&nbsp;&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P800x600_RGB_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x2A02,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output RGB =
type (SCART Connector) */<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x9127, =
0x9C2B,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P1024x768_RGB_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x2A02,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output RGB =
type (SCART Connector) */<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x9127, =
0x9C2B,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P848x480_RGB_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x2A02,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output RGB =
type (SCART Connector) */<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x9127, =
0x9C2B,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P720x576_RGB_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x2A02,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output RGB =
type (SCART Connector) */<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x9127, =
0x9C2B,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P640x480_RGB_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x2A02,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output RGB =
type (SCART Connector) */<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x9127, 0x9C2B, =
0x272C,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P800x600_RGB_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x2A02,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output RGB =
type (SCART Connector) */<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x9127, =
0x9C2B,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P1024x768_RGB_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x2A02,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output RGB =
type (SCART Connector) */<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x9127, =
0x9C2B,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P848x480_RGB_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x2A02,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output RGB =
type (SCART Connector) */<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x9127, =
0x9C2B,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P720x576_RGB_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x2A02,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output RGB =
type (SCART Connector) */<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x9127, =
0x9C2B,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P640x480_RGB_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x2A02,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output RGB =
type (SCART Connector) */<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P800x600_RGB_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x2A02,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output RGB =
type (SCART Connector) */<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P1024x768_RGB_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x2A02,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output RGB =
type (SCART Connector) */<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P848x480_RGB_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x2A02,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output RGB =
type (SCART Connector) */<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P720x576_RGB_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x2A02,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output RGB =
type (SCART Connector) */<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+/***********************************/<BR>+/* =
VT1622A output YPBPR Table&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+/***********************************/<BR>+<BR>+/* NTSC =
*/<BR>+<BR>+static u16 VT1622A_N640x480_YPBPR_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4B66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N800x600_YPBPR_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4B66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N1024x768_YPBPR_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4B66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N848x480_YPBPR_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4B66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+<BR>+};<BR>+<BR>+static u16 VT1622A_N720x480_YPBPR_VN[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4B66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N640x480_YPBPR_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4B66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N800x600_YPBPR_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4B66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N1024x768_YPBPR_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4B66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N848x480_YPBPR_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4B66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N720x480_YPBPR_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4B66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N640x480_YPBPR_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4B66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N800x600_YPBPR_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4B66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N1024x768_YPBPR_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4B66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N848x480_YPBPR_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4B66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N720x480_YPBPR_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4B66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+<BR>+/* PAL */<BR>+<BR>+static u16 =
VT1622A_P640x480_YPBPR_VN[] =3D {<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4B66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P800x600_YPBPR_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4B66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P1024x768_YPBPR_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4B66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P848x480_YPBPR_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4B66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P720x576_YPBPR_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4B66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P640x480_YPBPR_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4B66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P800x600_YPBPR_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4B66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P1024x768_YPBPR_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4B66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P848x480_YPBPR_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4B66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P720x576_YPBPR_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4B66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P640x480_YPBPR_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4B66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P800x600_YPBPR_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4B66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P1024x768_YPBPR_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4B66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P848x480_YPBPR_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4B66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P720x576_YPBPR_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4B66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+/***********************************/<BR>+/* =
VT1622A output SDTV_RGB Table&nbsp;&nbsp; =
*/<BR>+/***********************************/<BR>+<BR>+/* NTSC =
*/<BR>+<BR>+static u16 VT1622A_N640x480_SDTV_RGB_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 0x2A02, =
0x0B04,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_RGB type */<BR>+&nbsp;&nbsp;&nbsp; 0x8A08, 0x1809, =
0x001C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N800x600_SDTV_RGB_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 0x2A02, =
0x0B04,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_RGB type */<BR>+&nbsp;&nbsp;&nbsp; 0xC408, 0x1209, =
0x011C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N1024x768_SDTV_RGB_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 0x2A02, =
0x0B04,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_RGB type */<BR>+&nbsp;&nbsp;&nbsp; 0x0C08, 0x0E09, =
0x051C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N848x480_SDTV_RGB_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 0x2A02, =
0x0B04,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_RGB type */<BR>+&nbsp;&nbsp;&nbsp; 0xB508, 0x0009, =
0x001C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N720x480_SDTV_RGB_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 0x2A02, =
0x0B04,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_RGB type */<BR>+&nbsp;&nbsp;&nbsp; 0xA908, 0x0109, =
0x001C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N640x480_SDTV_RGB_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 0x2A02, =
0X0B04,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_RGB type */<BR>+&nbsp;&nbsp;&nbsp; 0x7E08, 0x0109, =
0x001C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N800x600_SDTV_RGB_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 0x2A02, =
0x0B04,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_RGB type */<BR>+&nbsp;&nbsp;&nbsp; 0x8B08, 0xF509, =
0x031C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 =
VT1622A_N1024x768_SDTV_RGB_VF[]=3D{<BR>+&nbsp;&nbsp;&nbsp; 0x2A02, =
0x0B04,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_RGB type */<BR>+&nbsp;&nbsp;&nbsp; 0xD408, 0x0909, =
0x011C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N848x480_SDTV_RGB_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 0x2A02, =
0x0B04,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_RGB type */<BR>+&nbsp;&nbsp;&nbsp; 0xA808, 0x0609, =
0x011C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N720x480_SDTV_RGB_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 0x2A02, =
0x0B04,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_RGB type */<BR>+&nbsp;&nbsp;&nbsp; 0x8C08, 0x0509, =
0x011C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N640x480_SDTV_RGB_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 0x2A02, =
0x0B04,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_RGB type */<BR>+&nbsp;&nbsp;&nbsp; 0x5708, 0xF109, =
0x021C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N800x600_SDTV_RGB_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 0x2A02, =
0x0B04,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_RGB type */<BR>+&nbsp;&nbsp;&nbsp; 0x7208, 0xF809, =
0x031C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N1024x768_SDTV_RGB_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 0x2A02, =
0x0B04,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_RGB type */<BR>+&nbsp;&nbsp;&nbsp; 0xAE08, 0x0209, =
0x011C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N848x480_SDTV_RGB_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 0x2A02, =
0x0B04,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_RGB type */<BR>+&nbsp;&nbsp;&nbsp; 0x9708, 0x0009, =
0x011C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N720x480_SDTV_RGB_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 0x2A02, =
0x0B04,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_RGB type */<BR>+&nbsp;&nbsp;&nbsp; 0x3E08, 0xFF09, =
0x021C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+<BR>+/* PAL */<BR>+<BR>+static u16 =
VT1622A_P640x480_SDTV_RGB_VN[] =3D {<BR>+&nbsp;&nbsp;&nbsp; 0x2A02, =
0x0804,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_RGB type */<BR>+&nbsp;&nbsp;&nbsp; 0x9508, 0x0009, =
0x001C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+<BR>+};<BR>+<BR>+static u16 VT1622A_P800x600_SDTV_RGB_VN[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; 0x2A02, =
0x0804,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_RGB type */<BR>+&nbsp;&nbsp;&nbsp; 0xAE08, 0x1B09, =
0x011C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+<BR>+};<BR>+<BR>+static u16 =
VT1622A_P1024x768_SDTV_RGB_VN[] =3D {<BR>+&nbsp;&nbsp;&nbsp; 0x2A02, =
0x0804,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_RGB type */<BR>+&nbsp;&nbsp;&nbsp; 0x1C08, 0x0D09, =
0x051C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P848x480_SDTV_RGB_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 0x2A02, =
0x0804,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_RGB type */<BR>+&nbsp;&nbsp;&nbsp; 0xDE08, 0x0F09, =
0x011C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P720x576_SDTV_RGB_VN[] =3D =
{ <BR>+&nbsp;&nbsp;&nbsp; 0x2A02, =
0x0804,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_RGB type */<BR>+&nbsp;&nbsp;&nbsp; 0x9708, 0x0009, =
0x001C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P640x480_SDTV_RGB_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 0x2A02, =
0x0804,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_RGB type */<BR>+&nbsp;&nbsp;&nbsp; 0x8B08, 0x0109, =
0x001C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P800x600_SDTV_RGB_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 0x2A02, =
0x0804,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_RGB type */<BR>+&nbsp;&nbsp;&nbsp; 0xA908, 0x1D09, =
0x011C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P1024x768_SDTV_RGB_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 0x2A02, =
0x0804,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_RGB type */<BR>+&nbsp;&nbsp;&nbsp; 0xE908, 0x1009, =
0x011C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+<BR>+};<BR>+<BR>+static u16 VT1622A_P848x480_SDTV_RGB_VF[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; 0x2A02, =
0x0804,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_RGB type */<BR>+&nbsp;&nbsp;&nbsp; 0xBC08, 0x1209, =
0x011C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P720x576_SDTV_RGB_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 0x2A02, =
0x0804,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_RGB type */<BR>+&nbsp;&nbsp;&nbsp; 0xA208, 0x0009, =
0x011C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P640x480_SDTV_RGB_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 0x2A02, =
0x0804,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_RGB type */<BR>+&nbsp;&nbsp;&nbsp; 0x6808, 0x0009, =
0x001C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P800x600_SDTV_RGB_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 0x2A02, =
0x0804,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_RGB type */<BR>+&nbsp;&nbsp;&nbsp; 0x9108, 0x0009, =
0x001C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P1024x768_SDTV_RGB_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 0x2A02, =
0x0804,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_RGB type */<BR>+&nbsp;&nbsp;&nbsp; 0xBC08, 0x0009, =
0x011C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P848x480_SDTV_RGB_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 0x2A02, =
0x0804,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_RGB type */<BR>+&nbsp;&nbsp;&nbsp; 0x9208, 0x0309, =
0x001C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P720x576_SDTV_RGB_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 0x2A02, =
0x0804,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_RGB type */<BR>+&nbsp;&nbsp;&nbsp; 0x8108, 0x0009, =
0x001C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position */ =
<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x8265, 0x8066, =
0x8167,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+/***********************************/<BR>+/* =
VT1622A output SDTV_YPBPR Table =
*/<BR>+/***********************************/<BR>+<BR>+/* NTSC =
*/<BR>+<BR>+static u16 VT1622A_N640x480_SDTV_YPBPR_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 0x0B02, =
0x0B04,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_YPBPR type */<BR>+&nbsp;&nbsp;&nbsp; 0x8C08, =
0x1409, 0x001C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4D66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N800x600_SDTV_YPBPR_VN[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; 0x0B02, =
0x0B04,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_YPBPR type */<BR>+&nbsp;&nbsp;&nbsp; 0xC408, =
0x1209, 0x011C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4D66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N1024x768_SDTV_YPBPR_VN[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; 0x0B02, =
0x0B04,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_YPBPR type */<BR>+&nbsp;&nbsp;&nbsp; 0x0C08, =
0x0E09, 0x051C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4D66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N848x480_SDTV_YPBPR_VN[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; 0x0B02, =
0x0B04,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_YPBPR type */<BR>+&nbsp;&nbsp;&nbsp; 0xB508, =
0x0009, 0x011C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4D66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N720x480_SDTV_YPBPR_VN[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; 0x0B02, =
0x0B04,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_YPBPR type */<BR>+&nbsp;&nbsp;&nbsp; 0xA908, =
0x0109, 0x011C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4D66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N640x480_SDTV_YPBPR_VF[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; 0x0B02, =
0x0B04,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_YPBPR type */<BR>+&nbsp;&nbsp;&nbsp; 0x7B08, =
0x0109, 0x001C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4D66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N800x600_SDTV_YPBPR_VF[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; 0x0B02, =
0x0B04,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_YPBPR type */<BR>+&nbsp;&nbsp;&nbsp; 0x8B08, =
0xFA09, 0x031C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4D66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N1024x768_SDTV_YPBPR_VF[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; 0x0B02, =
0x0B04,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_YPBPR type */<BR>+&nbsp;&nbsp;&nbsp; 0xD408, =
0x0D09, 0x011C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4D66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N848x480_SDTV_YPBPR_VF[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; 0x0B02, =
0x0B04,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_YPBPR type */<BR>+&nbsp;&nbsp;&nbsp; 0xA808, =
0x0609, 0x011C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4D66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N720x480_SDTV_YPBPR_VF[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; 0x0B02, =
0x0B04,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_YPBPR type */<BR>+&nbsp;&nbsp;&nbsp; 0x8C08, =
0x0809, 0x011C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4D66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N640x480_SDTV_YPBPR_VO[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; 0x0B02, =
0x0B04,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_YPBPR type */ <BR>+&nbsp;&nbsp;&nbsp; 0x5708, =
0xF109, 0x021C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4D66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N800x600_SDTV_YPBPR_VO[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; 0x0B02, =
0x0B04,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_YPBPR type */<BR>+&nbsp;&nbsp;&nbsp; 0x7208, =
0xF809, 0x031C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4D66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N1024x768_SDTV_YPBPR_VO[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; 0x0B02, =
0x0B04,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_YPBPR type */<BR>+&nbsp;&nbsp;&nbsp; 0xAE08, =
0x0209, 0x011C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4D66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N848x480_SDTV_YPBPR_VO[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; 0x0B02, =
0x0B04,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_YPBPR type */<BR>+&nbsp;&nbsp;&nbsp; 0x9708, =
0x1209, 0x011C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4D66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N720x480_SDTV_YPBPR_VO[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; 0x0B02, =
0x0B04,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_YPBPR type */<BR>+&nbsp;&nbsp;&nbsp; 0x3E08, =
0xFF09, 0x021C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4D66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+<BR>+<BR>+/* PAL */<BR>+<BR>+<BR>+static u16 =
VT1622A_P640x480_SDTV_YPBPR_VN[] =3D {<BR>+&nbsp;&nbsp;&nbsp; 0x0B02, =
0x0804,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_YPBPR type */<BR>+&nbsp;&nbsp;&nbsp; 0x9508, =
0x0009, 0x001C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4D66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P800x600_SDTV_YPBPR_VN[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; 0x0B02, =
0x0804,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_YPBPR type */<BR>+&nbsp;&nbsp;&nbsp; 0xAE08, =
0x1B09, 0x011C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4D66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P1024x768_SDTV_YPBPR_VN[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; 0x0B02, =
0x0804,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_YPBPR type */<BR>+&nbsp;&nbsp;&nbsp; 0x1E08, =
0x0C09, 0x051C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4D66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P848x480_SDTV_YPBPR_VN[] =
=3D { <BR>+&nbsp;&nbsp;&nbsp; 0x0B02, =
0x0804,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_YPBPR type */<BR>+&nbsp;&nbsp;&nbsp; 0xDE08, =
0x0F09, 0x001C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4D66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P720x576_SDTV_YPBPR_VN[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; 0x0B02, =
0x0804,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_YPBPR type */<BR>+&nbsp;&nbsp;&nbsp; 0x9708, =
0x0009, 0x001C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4D66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P640x480_SDTV_YPBPR_VF[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; 0x0B02, =
0x0804,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_YPBPR type */<BR>+&nbsp;&nbsp;&nbsp; 0x8B08, =
0x0109, 0x001C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4D66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P800x600_SDTV_YPBPR_VF[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; 0x0B02, =
0x0804,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_YPBPR type */<BR>+&nbsp;&nbsp;&nbsp; 0xA908, =
0x2309, 0x011C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4D66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P1024x768_SDTV_YPBPR_VF[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; 0x0B02, =
0x0804,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_YPBPR type */<BR>+&nbsp;&nbsp;&nbsp; 0xE908, =
0x1209, 0x011C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4D66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P848x480_SDTV_YPBPR_VF[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; 0x0B02, =
0x0804,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_YPBPR type */<BR>+&nbsp;&nbsp;&nbsp; 0xBC08, =
0x1209, 0x011C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4D66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P720x576_SDTV_YPBPR_VF[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; 0x0B02, =
0x0804,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_YPBPR type */<BR>+&nbsp;&nbsp;&nbsp; 0xA208, =
0x0009, 0x011C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4D66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P640x480_SDTV_YPBPR_VO[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; 0x0B02, =
0x0804,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_YPBPR type */<BR>+&nbsp;&nbsp;&nbsp; 0x6808, =
0x0009, 0x001C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4D66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P800x600_SDTV_YPBPR_VO[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; 0x0B02, =
0x0804,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_YPBPR type */<BR>+&nbsp;&nbsp;&nbsp; 0x9508, =
0x0009, 0x001C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4D66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P1024x768_SDTV_YPBPR_VO[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; 0x0B02, =
0x0804,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_YPBPR type */<BR>+&nbsp;&nbsp;&nbsp; 0xBC08, =
0x0009, 0x011C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4D66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P848x480_SDTV_YPBPR_VO[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; 0x0B02, =
0x0804,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_YPBPR type */<BR>+&nbsp;&nbsp;&nbsp; 0x9208, =
0x0309, 0x001C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4D66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_P720x576_SDTV_YPBPR_VO[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; 0x0B02, =
0x0804,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* output SDTV_YPBPR type */<BR>+&nbsp;&nbsp;&nbsp; 0x9508, =
0x0009, 0x001C,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's Position =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0400, =
0x0003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* disable de-flicker function */<BR>+&nbsp;&nbsp;&nbsp; =
0x004D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Y_DELAY =3D 0 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4D66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+/***********************************/<BR>+/* =
VT1622A DeDotCrawl Table&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+/***********************************/<BR>+<BR>+/* NTSC =
*/<BR>+<BR>+static u16 VT1622A_N640x480_DeDotCrawl_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 0xBE16, =
0x8717,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* adjust TV FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N800x600_DeDotCrawl_VN[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; 0x1216, =
0x4917,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* adjust TV FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N1024x768_DeDotCrawl_VN[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; 0x1816, =
0x6117,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* adjust TV FSCI */ <BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N848x480_DeDotCrawl_VN[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; 0x5B16, =
0xA017,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* adjust TV FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N720x480_DeDotCrawl_VN[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; 0xC316, =
0x4C17,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* adjust TV FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N640x480_DeDotCrawl_VF[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; 0x5016, =
0x7B17,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* adjust TV FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N800x600_DeDotCrawl_VF[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; 0xD116, =
0xF617,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* adjust TV FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N1024x768_DeDotCrawl_VF[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; 0x0616, =
0x8417,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* adjust TV FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N848x480_DeDotCrawl_VF[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; 0x1C16, =
0x7D17,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* adjust TV FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N720x480_DeDotCrawl_VF[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; 0xE816, =
0xEB17,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* adjust TV FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N640x480_DeDotCrawl_VO[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; 0xE516, =
0xA017,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* adjust TV FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N800x600_DeDotCrawl_VO[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; 0xA116, =
0x5917,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* adjust TV FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N1024x768_DeDotCrawl_VO[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; 0x1116, =
0xE217,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* adjust TV FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N848x480_DeDotCrawl_VO[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; 0x6716, =
0x3017,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* adjust TV FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622A_N720x480_DeDotCrawl_VO[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; 0x1E16, =
0x5C17,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* adjust TV FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+<BR>+static vt1622a_func_table =
vt1622a_ntsc_640x480_tbl[] =3D {<BR>+&nbsp;&nbsp;&nbsp; =
{TV_BASE_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_N640x480_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; =
VT1622A_N640x480_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; VT1622A_N640x480_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_N640x480_RGB_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_N640x480_RGB_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_N640x480_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_YPBPR_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_N640x480_YPBPR_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_N640x480_YPBPR_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_N640x480_YPBPR_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_N640x480_SDTV_RGB_VN,&nbsp;&nbsp; =
VT1622A_N640x480_SDTV_RGB_VF,&nbsp;&nbsp; =
VT1622A_N640x480_SDTV_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_YPBPR_FUNC,&nbsp;&nbsp; VT1622A_N640x480_SDTV_YPBPR_VN, =
VT1622A_N640x480_SDTV_YPBPR_VF, =
VT1622A_N640x480_SDTV_YPBPR_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_DeDotCrawl_FUNC,&nbsp;&nbsp; VT1622A_N640x480_DeDotCrawl_VN, =
VT1622A_N640x480_DeDotCrawl_VF, =
VT1622A_N640x480_DeDotCrawl_VO}<BR>+};<BR>+<BR>+static =
vt1622a_func_table vt1622a_ntsc_800x600_tbl[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
{TV_BASE_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_N800x600_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; =
VT1622A_N800x600_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; VT1622A_N800x600_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_N800x600_RGB_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_N800x600_RGB_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_N800x600_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_YPBPR_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_N800x600_YPBPR_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_N800x600_YPBPR_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_N800x600_YPBPR_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_N800x600_SDTV_RGB_VN,&nbsp;&nbsp; =
VT1622A_N800x600_SDTV_RGB_VF,&nbsp;&nbsp; =
VT1622A_N800x600_SDTV_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_YPBPR_FUNC,&nbsp;&nbsp; VT1622A_N800x600_SDTV_YPBPR_VN, =
VT1622A_N800x600_SDTV_YPBPR_VF, =
VT1622A_N800x600_SDTV_YPBPR_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_DeDotCrawl_FUNC,&nbsp;&nbsp; VT1622A_N800x600_DeDotCrawl_VN, =
VT1622A_N800x600_DeDotCrawl_VF, =
VT1622A_N800x600_DeDotCrawl_VO}<BR>+};<BR>+<BR>+static =
vt1622a_func_table vt1622a_ntsc_1024x768_tbl[]=3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
{TV_BASE_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_N1024x768_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; =
VT1622A_N1024x768_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; VT1622A_N1024x768_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_N1024x768_RGB_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_N1024x768_RGB_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_N1024x768_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_YPBPR_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_N1024x768_YPBPR_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_N1024x768_YPBPR_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_N1024x768_YPBPR_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_N1024x768_SDTV_RGB_VN,&nbsp;&nbsp; =
VT1622A_N1024x768_SDTV_RGB_VF,&nbsp;&nbsp; =
VT1622A_N1024x768_SDTV_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_YPBPR_FUNC,&nbsp;&nbsp; VT1622A_N1024x768_SDTV_YPBPR_VN, =
VT1622A_N1024x768_SDTV_YPBPR_VF, =
VT1622A_N1024x768_SDTV_YPBPR_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_DeDotCrawl_FUNC,&nbsp;&nbsp; VT1622A_N1024x768_DeDotCrawl_VN, =
VT1622A_N1024x768_DeDotCrawl_VF, =
VT1622A_N1024x768_DeDotCrawl_VO}<BR>+};<BR>+<BR>+static =
vt1622a_func_table vt1622a_ntsc_848x480_tbl[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
{TV_BASE_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_N848x480_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; =
VT1622A_N848x480_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; VT1622A_N848x480_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_N848x480_RGB_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_N848x480_RGB_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_N848x480_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_YPBPR_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_N848x480_YPBPR_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_N848x480_YPBPR_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_N848x480_YPBPR_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_N848x480_SDTV_RGB_VN,&nbsp;&nbsp;&nbsp; =
VT1622A_N848x480_SDTV_RGB_VF,&nbsp;&nbsp;&nbsp; =
VT1622A_N848x480_SDTV_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_YPBPR_FUNC,&nbsp;&nbsp; VT1622A_N848x480_SDTV_YPBPR_VN,&nbsp; =
VT1622A_N848x480_SDTV_YPBPR_VF,&nbsp; =
VT1622A_N848x480_SDTV_YPBPR_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_DeDotCrawl_FUNC,&nbsp;&nbsp; VT1622A_N848x480_DeDotCrawl_VN,&nbsp; =
VT1622A_N848x480_DeDotCrawl_VF,&nbsp; =
VT1622A_N848x480_DeDotCrawl_VO}<BR>+};<BR>+<BR>+static =
vt1622a_func_table vt1622a_ntsc_720x480_tbl[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
{TV_BASE_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_N720x480_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; =
VT1622A_N720x480_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; VT1622A_N720x480_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_N720x480_RGB_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_N720x480_RGB_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_N720x480_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_YPBPR_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_N720x480_YPBPR_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_N720x480_YPBPR_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_N720x480_YPBPR_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_N720x480_SDTV_RGB_VN,&nbsp;&nbsp;&nbsp; =
VT1622A_N720x480_SDTV_RGB_VF,&nbsp;&nbsp;&nbsp; =
VT1622A_N720x480_SDTV_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_YPBPR_FUNC,&nbsp;&nbsp; VT1622A_N720x480_SDTV_YPBPR_VN,&nbsp; =
VT1622A_N720x480_SDTV_YPBPR_VF,&nbsp; =
VT1622A_N720x480_SDTV_YPBPR_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_DeDotCrawl_FUNC,&nbsp;&nbsp; VT1622A_N720x480_DeDotCrawl_VN,&nbsp; =
VT1622A_N720x480_DeDotCrawl_VF,&nbsp; =
VT1622A_N720x480_DeDotCrawl_VO}<BR>+};<BR>+<BR>+static =
vt1622a_func_table vt1622a_pal_640x480_tbl[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
{TV_BASE_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_P640x480_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; =
VT1622A_P640x480_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; VT1622A_P640x480_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_P640x480_RGB_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_P640x480_RGB_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_P640x480_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_YPBPR_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_P640x480_YPBPR_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_P640x480_YPBPR_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_P640x480_YPBPR_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_P640x480_SDTV_RGB_VN,&nbsp;&nbsp;&nbsp; =
VT1622A_P640x480_SDTV_RGB_VF,&nbsp;&nbsp;&nbsp; =
VT1622A_P640x480_SDTV_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_YPBPR_FUNC,&nbsp;&nbsp; VT1622A_P640x480_SDTV_YPBPR_VN,&nbsp; =
VT1622A_P640x480_SDTV_YPBPR_VF,&nbsp; =
VT1622A_P640x480_SDTV_YPBPR_VO}<BR>+};<BR>+<BR>+static =
vt1622a_func_table vt1622a_pal_800x600_tbl[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
{TV_BASE_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_P800x600_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; =
VT1622A_P800x600_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; VT1622A_P800x600_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_P800x600_RGB_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_P800x600_RGB_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_P800x600_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_YPBPR_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_P800x600_YPBPR_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_P800x600_YPBPR_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_P800x600_YPBPR_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_P800x600_SDTV_RGB_VN,&nbsp;&nbsp;&nbsp; =
VT1622A_P800x600_SDTV_RGB_VF,&nbsp;&nbsp;&nbsp; =
VT1622A_P800x600_SDTV_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_YPBPR_FUNC,&nbsp;&nbsp; VT1622A_P800x600_SDTV_YPBPR_VN,&nbsp; =
VT1622A_P800x600_SDTV_YPBPR_VF,&nbsp; =
VT1622A_P800x600_SDTV_YPBPR_VO}<BR>+};<BR>+<BR>+static =
vt1622a_func_table vt1622a_pal_1024x768_tbl[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
{TV_BASE_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_P1024x768_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; =
VT1622A_P1024x768_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; VT1622A_P1024x768_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_P1024x768_RGB_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =
VT1622A_P1024x768_RGB_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 VT1622A_P1024x768_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_YPBPR_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_P1024x768_YPBPR_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_P1024x768_YPBPR_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_P1024x768_YPBPR_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_P1024x768_SDTV_RGB_VN,&nbsp;&nbsp;&nbsp; =
VT1622A_P1024x768_SDTV_RGB_VF,&nbsp;&nbsp;&nbsp; =
VT1622A_P1024x768_SDTV_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_YPBPR_FUNC,&nbsp;&nbsp; VT1622A_P1024x768_SDTV_YPBPR_VN,&nbsp; =
VT1622A_P1024x768_SDTV_YPBPR_VF,&nbsp; =
VT1622A_P1024x768_SDTV_YPBPR_VO}<BR>+};<BR>+<BR>+static =
vt1622a_func_table vt1622a_pal_848x480_tbl[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
{TV_BASE_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_P848x480_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; =
VT1622A_P848x480_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; VT1622A_P848x480_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_P848x480_RGB_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_P848x480_RGB_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_P848x480_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_YPBPR_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_P848x480_YPBPR_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_P848x480_YPBPR_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_P848x480_YPBPR_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_P848x480_SDTV_RGB_VN,&nbsp;&nbsp;&nbsp; =
VT1622A_P848x480_SDTV_RGB_VF,&nbsp;&nbsp;&nbsp; =
VT1622A_P848x480_SDTV_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_YPBPR_FUNC,&nbsp;&nbsp; VT1622A_P848x480_SDTV_YPBPR_VN,&nbsp; =
VT1622A_P848x480_SDTV_YPBPR_VF,&nbsp; =
VT1622A_P848x480_SDTV_YPBPR_VO}<BR>+};<BR>+<BR>+static =
vt1622a_func_table vt1622a_pal_720x576_tbl[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
{TV_BASE_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_P720x576_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; =
VT1622A_P720x576_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; VT1622A_P720x576_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_P720x576_RGB_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_P720x576_RGB_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_P720x576_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_YPBPR_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_P720x576_YPBPR_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_P720x576_YPBPR_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_P720x576_YPBPR_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622A_P720x576_SDTV_RGB_VN,&nbsp;&nbsp;&nbsp; =
VT1622A_P720x576_SDTV_RGB_VF,&nbsp;&nbsp;&nbsp; =
VT1622A_P720x576_SDTV_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_YPBPR_FUNC,&nbsp;&nbsp; VT1622A_P720x576_SDTV_YPBPR_VN,&nbsp; =
VT1622A_P720x576_SDTV_YPBPR_VF,&nbsp; =
VT1622A_P720x576_SDTV_YPBPR_VO}<BR>+};<BR>+<BR>+<BR>+static struct =
vt1622a_table vt1622a_tbl[] =3D {<BR>+&nbsp;&nbsp;&nbsp; =
{VIA_RES_640X480,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; vt1622a_ntsc_640x480_tbl,&nbsp;&nbsp;&nbsp; =
vt1622a_pal_640x480_tbl},<BR>+&nbsp;&nbsp;&nbsp; =
{VIA_RES_800X600,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; vt1622a_ntsc_800x600_tbl,&nbsp;&nbsp;&nbsp; =
vt1622a_pal_800x600_tbl},<BR>+&nbsp;&nbsp;&nbsp; =
{VIA_RES_1024X768,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; vt1622a_ntsc_1024x768_tbl,&nbsp;&nbsp; =
vt1622a_pal_1024x768_tbl},<BR>+&nbsp;&nbsp;&nbsp; =
{VIA_RES_848X480,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; vt1622a_ntsc_848x480_tbl,&nbsp;&nbsp;&nbsp; =
vt1622a_pal_848x480_tbl},<BR>+&nbsp;&nbsp;&nbsp; =
{VIA_RES_720X480,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; vt1622a_ntsc_720x480_tbl,&nbsp;&nbsp;&nbsp; =
vt1622a_ntsc_720x480_tbl},<BR>+&nbsp;&nbsp;&nbsp; =
{VIA_RES_720X576,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; vt1622a_pal_720x576_tbl,&nbsp;&nbsp;&nbsp;&nbsp; =
vt1622a_pal_720x576_tbl}<BR>+};<BR>+<BR>+#define NUM_TOTAL_VT1622A_TABLE =
ARRAY_SIZE(vt1622a_tbl)<BR>+<BR>+#endif /* __TBL1622A_H__ */<BR>diff =
-Nur linux-2.6.21-rc7/drivers/video/via/tbl1622.h =
linux-2.6.21-rc7.viafb/drivers/video/via/tbl1622.h<BR>--- =
linux-2.6.21-rc7/drivers/video/via/tbl1622.h&nbsp;1969-12-31 =
19:00:00.000000000 -0500<BR>+++ =
linux-2.6.21-rc7.viafb/drivers/video/via/tbl1622.h&nbsp;2007-04-26 =
19:52:32.000000000 -0400<BR>@@ -0,0 +1,1670 @@<BR>+ /*<BR>+ * Copyright =
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
* DEALINGS IN THE SOFTWARE.<BR>+ */<BR>+<BR>+ <BR>+#ifndef =
__TBL1622_H__<BR>+#define __TBL1622_H__<BR>+<BR>+#include =
"share.h"<BR>+<BR>+/***************************/<BR>+/* VT1622 TV =
Encoder Table */<BR>+/***************************/<BR>+<BR>+typedef =
struct _vt1622_func_table {<BR>+&nbsp;&nbsp;&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp; tv_func_index;<BR>+&nbsp;&nbsp;&nbsp; =
u16&nbsp;&nbsp;&nbsp;&nbsp; *tv_underscan;<BR>+&nbsp;&nbsp;&nbsp; =
u16&nbsp;&nbsp;&nbsp;&nbsp; *tv_fitscan;<BR>+&nbsp;&nbsp;&nbsp; =
u16&nbsp;&nbsp;&nbsp;&nbsp; *tv_overscan;<BR>+} =
vt1622_func_table;<BR>+<BR>+struct vt1622_table {<BR>+&nbsp;&nbsp;&nbsp; =
int&nbsp;&nbsp;&nbsp;&nbsp; tv_index;<BR>+&nbsp;&nbsp;&nbsp; =
vt1622_func_table&nbsp;&nbsp; *tv_mode_ntsc;<BR>+&nbsp;&nbsp;&nbsp; =
vt1622_func_table&nbsp;&nbsp; *tv_mode_pal;<BR>+};<BR>+<BR>+<BR>+/* =
Underscan table */<BR>+static u16 VT1622_N640x480_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x0400, 0x0001, 0x0002, 0x0203, =
0x0304,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x1006, 0x7E07, 0x9D08, 0x0D09,&nbsp;&nbsp;&nbsp;&nbsp; /* =
Tv.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x600A, 0x170B, 0x520C, 0x450D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0xD012, 0x3313,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0xBF14, 0x3A15, 0xF116, 0x9117, =
0x2418,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2519,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x031B, 0x001C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x051F, 0x1220, 0x0C21, =
0x0422,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7423, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xDC4A, 0x504B, 0x044C, =
0x004D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x404F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x0F50, 0x8151, 0x2352, 0x5753, 0x0254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x0F55, 0x2956, 0x7357, 0x2358, =
0x8659,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xC45A, 0xEA5B, 0xDF5C, =
0x055D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x925E, 0xA15F, 0x0460, 0x0061, 0x0062,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x7F63, =
0x0364,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 784, 640, 640, 144, 656, 56,&nbsp; =
600, 480, 480, 120, 488, 7<BR>+};<BR>+<BR>+#define NUM_TOTAL_VT1622_REG =
ARRAY_SIZE(VT1622_N640x480_VN) -NUM_CRTC_TIMING<BR>+<BR>+static u16 =
VT1622_N800x600_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; 0x8400, 0x0001, 0x0002, 0x2403, =
0x0304,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x1006, 0xDE07, 0xD408, 0x0E09,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x590A, 0x170B, 0x460C, 0x400D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0xEA12, 0x0D13,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x9814, 0x1C15, 0x9616, 0x5017, =
0x5E18,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x1B19,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x031B, 0x011C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x851F, 0x0D20, 0x0A21, =
0x0422,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7423, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xE44A, 0x694B, 0x044C, =
0x004D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x3F4F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x2750, 0x2151, 0x3452, 0xED53, 0x0254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x2755, 0xF556, 0x9D57, 0x2458, =
0xB759,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0D5A, 0x405B, 0x005C, =
0x585D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xB65E, 0x3B5F, 0x0560, 0x0061, 0x0162,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0xEF63, =
0x0564,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 1064,800, 800, 264, 840, 136, 750, =
600, 600, 150, 606, 16<BR>+};<BR>+<BR>+static u16 VT1622_N1024x768_VN[] =
=3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; 0x8400, 0x0001, 0x0002, 0x4403, =
0x0304,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x1006, 0x8007, 0x1508, 0x0A09,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x580A, 0x170B, 0x5B0C, 0x400D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0xE912, 0x1E13,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x9D14, 0x1915, 0xD616, 0x6617, =
0xEB18,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x1419,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x031B, 0x051C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x851F, 0x0A20, 0x0521, =
0x0422,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7423, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xDA4A, 0x504B, 0x044C, =
0x004D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x3F4F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x8750, 0xFF51, 0x3452, 0xB053, 0x0354,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x6F55, 0xDB56, 0xCD57, 0x3558, =
0xF159,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0x5E5A, 0xA55B, 0x7E5C, =
0x5A5D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x335E, 0x265F, 0x0760, 0x0061, 0x0162,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x2763, =
0x0864,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 1160,1024,1024,136, 1040,56,&nbsp; =
945, 768, 768, 177, 789, 6<BR>+};<BR>+<BR>+static u16 =
VT1622_N848x480_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; 0x8400, 0x0001, 0x0002, 0x2403, =
0x0304,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x1006, 0x4607, 0xCC08, 0x0E09,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x560A, 0x170B, 0x430C, 0x3E0D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0xE812, 0x2913,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x6714, 0x1915, 0x6316, 0xA817, =
0x3C18,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x1D19,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x031B, 0x0B1C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x851F, 0x0E20, 0x0821, =
0x0422,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7423, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xDC4A, 0x504B, 0x004C, =
0x004D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x404F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xAF50, 0x5151, 0x3452, 0x4453, 0x0254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0xE355, 0xC156, 0x9357, 0x2358, =
0xAD59,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xFD5A, 0x2B5B, 0x7C5C, =
0x175D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x6D5E, 0xCA5F, 0x0460, 0x0061, 0x0162,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x2F63, =
0x0564,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 1200,848, 848, 352, 872, 64,&nbsp; =
581, 480, 480, 101, 496, 13<BR>+};<BR>+<BR>+static u16 =
VT1622_N720x480_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; 0x0400, 0x0001, 0x0002, 0x2603, =
0x0304,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x1006, 0x6D07, 0xC308, 0x0809,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x560A, 0x170B, 0x430C, 0x3E0D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0x0D12, 0x0713,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x6014, 0x3415, 0x1816, 0x5517, =
0x5518,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x1E19,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x031B, 0x031C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x851F, 0x0F20, 0x0821, =
0x0422,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7423, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xE44A, 0x694B, 0x044C, =
0x004D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x404F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x4750, 0xD151, 0x2352, 0x5753, 0x0254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0xBF55, 0xAF56, 0x8D57, 0x2358, =
0xA459,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xF35A, 0x205B, 0x365C, =
0x175D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x925E, 0x335F, 0x0460, 0x0061, 0x0062,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0xBF63, =
0x0364,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 840, 720, 720, 120, 728, 48,&nbsp; =
600, 480, 480, 120, 512, 7<BR>+};<BR>+<BR>+static u16 =
VT1622_P640x480_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x0400, 0x0001, 0x0002, 0x8203, =
0x0004,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x1006, 0x3E07, 0xA408, 0x3709,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x670A, 0x000B, 0x490C, 0x490D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0xEC12, 0x2A13,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0xB814, 0x2915, 0x2D16, 0x7717, =
0x6618,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */ <BR>+&nbsp;&nbsp;&nbsp; =
0x2D19,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x031B, 0x0A1C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x041F, 0x1220, 0x0C21, =
0x0422,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7B23, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xF94A, 0x504B, 0x044C, =
0x004D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x454F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xE750, 0x8151, 0x2352, 0x5753, 0x0254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x1F55, 0x3156, 0x7557, 0x2358, =
0x8A59,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xC85A, 0xF05B, 0xFF5C, =
0x055D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xD75E, 0x8E5F, 0x0360, 0x7F61, 0xCF62,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0xBF63, =
0x0364,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 1000,640, 640, 360, 680, 72,&nbsp; =
600, 480, 480, 120, 521, 5<BR>+};<BR>+<BR>+static u16 =
VT1622_P800x600_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x8400, 0x0001, 0x0002, 0xA403, =
0x0004,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x1906, 0x6607, 0xBF08, 0x1209,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x600A, 0x000B, 0x560C, 0x450D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0xEC12, 0x1513,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0xFD14, 0x2815, 0xE416, 0x7D17, =
0x7A18,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2719,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x031B, 0x011C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x851F, 0x1020, 0x0C21, =
0x0422,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7B23, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xE74A, 0x454B, 0x044C, =
0x004D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x444F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x9750, 0x2151, 0x3352, 0xED53, 0x0254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x9755, 0x8756, 0x8757, 0x2358, =
0x9F59,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xE75A, 0x165B, 0xE75C, =
0x165D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xCC5E, 0xF35F, 0x0460, 0x0061, 0x0162,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x4F63, =
0x0464,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 920, 800, 800, 120, 816, 64,&nbsp; =
750, 600, 600, 150, 606, 16<BR>+};<BR>+<BR>+static u16 =
VT1622_P1024x768_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x8400, 0x0001, 0x0002, 0x0C03, =
0x0004,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x1006, 0xA007, 0x2A08, 0x3809,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x700A, 0x000B, 0x4E0C, 0x500D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0xE412, 0x2313,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0xD114, 0x0C15, 0x7216, 0xC317, =
0x8C18,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x1A19,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x031B, 0x071C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x851F, 0x0C20, 0x0C21, =
0x0422,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7B23, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xDD4A, 0x604B, 0x044C, =
0x004D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x454F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xAF50, 0xFF51, 0x3452, 0xB553, 0x0354,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x5755, 0xA856, 0xC857, 0x3558, =
0xEC59,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0x4C5A, 0xCC5B, 0x675C, =
0x5A5D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x145E, 0x5C5F, 0x0660, 0x0061, 0x0162,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x1F63, =
0x0764,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 1200,1024,1024,176, 1040,80,&nbsp; =
950, 768, 768, 182, 802, 3<BR>+};<BR>+<BR>+static u16 =
VT1622_P848x480_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x0400, 0x0001, 0x0002, 0xC203, =
0x0004,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x1006, 0x4707, 0xE408, 0x0909,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x640A, 0x000B, 0x4F0C, 0x480D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0xE712, 0x0513,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x2C14, 0x1C15, 0x1816, 0x2817, =
0x8718,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x1F19,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x031B, 0x091C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x841F, 0x0A20, 0x0C21, =
0x0422,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7B23, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xE74A, 0x454B, 0x044C, =
0x004D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x434F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xAF50, 0x5151, 0x3452, 0x5753, 0x0254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x7F55, 0x4F56, 0xA957, 0x3458, =
0xD159,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2B5A, 0x5D5B, 0xAA5C, =
0x585D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xD75E, 0x015F, 0x0360, 0x0061, 0x0162,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x7F63, =
0x0464,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 1200,848, 848, 352, 976, 56,&nbsp; =
600, 480, 480, 120, 499, 11<BR>+};<BR>+<BR>+static u16 =
VT1622_P720x576_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x0400, 0x0001, 0x0002, 0xA203, =
0x0004,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x1006, 0x1E07, 0xAC08, 0x3809,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x670A, 0x000B, 0x570C, 0x490D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0xF012, 0x0F13,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0xD114, 0x3815, 0x3216, 0x9817, =
0x8318,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2D19,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x031B, 0x021C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x841F, 0x1320, 0x0C21, =
0x0422,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7B23, =
0x4824,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xE74A, 0x454B, 0x044C, =
0x004D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x454F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xF750, 0xD151, 0x2252, 0xED53, 0x0254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x1D55, 0x2956, 0x7557, 0x2358, =
0x8859,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xC65A, 0xF05B, 0xFA5C, =
0x0F5D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xCC5E, 0x305F, 0x1460, 0x0061, 0x0062,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x8F63, =
0x0364,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 760, 720, 720, 40,&nbsp; 728, =
16,&nbsp;&nbsp; 750, 576, 576, 174, 643, 29<BR>+};<BR>+<BR>+<BR>+/* Fit =
Industry TV Screen Mode */<BR>+<BR>+static u16 VT1622_N640x480_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x0400, 0x0001, 0x0002, 0x0203, =
0x0304,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x1006, 0xA607, 0x8C08, 0x0709,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x600A, 0x170B, 0x520C, 0x450D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0x8812, 0x0D13,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x5C14, 0x1C15, 0x4216, 0x8517, =
0x2C18,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2419,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x031B, 0x021C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x051F, 0x1220, 0x0C21, =
0x0422,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7523, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xC44A, 0x504B, 0x044C, =
0x004D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x414F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x4750, 0x8151, 0x2352, 0x3E53, 0x0254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x2455, 0x6556, 0x7757, 0x2358, =
0x8859,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xCB5A, 0x025B, 0x155C, =
0x165D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x625E, 0x2E5F, 0x0460, 0x0061, 0x0062,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x9763, =
0x0364,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 840, 640, 640, 200, 672, 56,&nbsp; =
575, 480, 480, 95,&nbsp; 499, 7<BR>+};<BR>+<BR>+static u16 =
VT1622_N800x600_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x8400, 0x0001, 0x0002, 0x2403, =
0x0304,&nbsp;&nbsp;&nbsp;&nbsp; /*/ TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x1006, 0x5007, 0xA108, 0xFE09,&nbsp;&nbsp;&nbsp;&nbsp; /*/ =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x630A, 0x170B, 0x460C, 0x470D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /*/ TV.0A-0E */ <BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0xED12, 0x1913,&nbsp;&nbsp;&nbsp;&nbsp; /*/ =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x4014, 0x1D15, 0xBE16, 0xFF17, =
0x7F18,&nbsp;&nbsp;&nbsp;&nbsp; /*/ TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2019,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /*/ TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x031B, 0x091C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*/ TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x851F, 0x0D20, 0x0A21, =
0x0422,&nbsp;&nbsp;&nbsp;&nbsp; /*/ TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7523, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*/ TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /*/ Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xE44A, 0x694B, =
0x044C, 0x004D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /*/ TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x404F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /*/ TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /*/ Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xAF50, 0x1F51, 0x3452, 0xD753, 0x0254,&nbsp;&nbsp;&nbsp;&nbsp; /*/ =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x7F55, 0xA956, 0x8457, 0x2358, =
0x9859,&nbsp;&nbsp;&nbsp;&nbsp; /*/ TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xE35A, 0x1A5B, 0xB25C, =
0x165D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /*/ TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/*/ Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x8C5E, 0xB25F, 0x0560, 0x0061, 0x0162,&nbsp;&nbsp;&nbsp;&nbsp; /*/ =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x7F63, =
0x0664,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 1200,800, 800, 400, 864, 200, 728, =
600, 600, 128, 656, 9<BR>+};<BR>+<BR>+static u16 VT1622_N1024x768_VF[] =
=3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x8400, 0x0001, 0x0002, 0x0403, =
0x0304,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x1006, 0x8E07, 0xE208, 0x0809,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x600A, 0x170B, 0x5C0C, 0x450D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0xE812, 0x0D13,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x9414, 0x1415, 0x3216, 0x8A17, =
0x7C18,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x1619,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x031B, 0x011C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x851F, 0x0A20, 0x0521, =
0x0422,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7423, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xE44A, 0x504B, 0x044C, =
0x004D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x404F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x9750, 0xFF51, 0x3452, 0x9C53, 0x0354,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x0E55, 0xDE56, 0xBF57, 0x3558, =
0xDD59,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0x495A, 0x995B, 0xCE5C, =
0x595D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x0C5E, 0x235F, 0x0760, 0x0061, 0x0162,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x1763, =
0x0864,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 1176,1024,1024,152, 1040,64,&nbsp; =
925, 768, 768, 157, 779, 12<BR>+};<BR>+<BR>+static u16 =
VT1622_N848x480_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x8400, 0x0001, 0x0002, 0x4403, =
0x0304,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x1006, 0x8F07, 0xBE08, 0x0509,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x600A, 0x170B, 0x5C0C, 0x460D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0xA712, 0x0D13,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x6C14, 0x1C15, 0x8416, 0x8417, =
0xF618,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x1A19,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x031B, 0x011C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x851F, 0x0D20, 0x0821, =
0x0422,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7523, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xDC4A, 0x504B, 0x004C, =
0x004D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x404F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xEF50, 0x5151, 0x3352, 0x3653, 0x0254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x3755, 0x3956, 0x9F57, 0x3458, =
0xB759,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0x125A, 0x575B, 0x2C5C, =
0x585D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x525E, 0x1A5F, 0x0460, 0x0061, 0x0062,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x3763, =
0x0464,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 1000,848, 848, 152, 856, 56,&nbsp; =
567, 480, 480, 87,&nbsp; 485, 7<BR>+};<BR>+<BR>+static u16 =
VT1622_N720x480_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x0400, 0x0001, 0x0002, 0x0203, =
0x0304,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x1006, 0x6E07, 0xA008, 0x0F09,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x630A, 0x170B, 0x520C, 0x4A0D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0x8712, 0x0D13,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x5C14, 0x1C15, 0x9A16, 0xF417, =
0xA618,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x1F19,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x031B, 0x031C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x851F, 0x1120, 0x0821, =
0x0422,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7523, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xE44A, 0x694B, 0x044C, =
0x004D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x404F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x4750, 0xD151, 0x2352, 0x3E53, 0x0254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x9755, 0xBF56, 0x8857, 0x2358, =
0x9C59,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xE95A, 0x265B, 0xF55C, =
0x165D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x625E, 0x175F, 0x0460, 0x0061, 0x0062,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x9763, =
0x0364,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 840, 720, 720, 120, 728, 48,&nbsp; =
575, 480, 480, 95,&nbsp; 484, 15<BR>+};<BR>+<BR>+static u16 =
VT1622_P640x480_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x0400, 0x0001, 0x0002, 0x8203, =
0x0004,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x1006, 0x3E07, 0x9308, 0x3609,&nbsp;&nbsp;&nbsp;&nbsp; /* =
Tv.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x740A, 0x000B, 0x480C, 0x540D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0xE812, 0x2413,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0xFD14, 0x1C15, 0xBC16, 0x4617, =
0x1E18,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2D19,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x031B, 0x0A1C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x051F, 0x1520, 0x0C21, =
0x0422,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7B23, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xF94A, 0x504B, 0x044C, =
0x004D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x484F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xE750, 0x8151, 0x2352, 0x3E53, 0x0254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x2455, 0x5E56, 0x7657, 0x2358, =
0x8959,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xC25A, 0x145B, 0x1C5C, =
0x165D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xAE5E, 0x3A5F, 0x0360, 0x0061, 0x0062,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x9763, =
0x0364,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 1000,640, 640, 360, 680, 80,&nbsp; =
575, 480, 480, 95,&nbsp; 501, 3<BR>+};<BR>+<BR>+static u16 =
VT1622_P800x600_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x8400, 0x0001, 0x0002, 0xA003, =
0x0004,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x1906, 0xA607, 0xBA08, 0x4709,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x720A, 0x000B, 0x570C, 0x510D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0xE812, 0x2413,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x3F14, 0x1D15, 0x6016, 0x9017, =
0xC818,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2319,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x031B, 0x031C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x851F, 0x1020, 0x0C21, =
0x0422,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7B23, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xE94A, 0x504B, 0x044C, =
0x004D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x474F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xE750, 0x2151, 0x3352, 0xD453, 0x0254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0xF655, 0xFC56, 0x9557, 0x2358, =
0xAE59,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xF55A, 0x595B, 0xB65C, =
0x175D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xA45E, 0x315F, 0x0460, 0x0061, 0x0162,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x8763, =
0x0464,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+ =
<BR>+&nbsp;&nbsp;&nbsp; /* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, =
VT,&nbsp; VA,&nbsp; VBS, VBE, VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; =
1000,800, 800, 200, 832, 80,&nbsp; 725, 600, 600, 125, 602, =
1<BR>+};<BR>+<BR>+static u16 VT1622_P1024x768_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x8400, 0x0001, 0x0002, 0xC403, =
0x0004,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x1006, 0x9E07, 0xF808, 0x4309,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x5F0A, 0x000B, 0x4D0C, 0x430D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0xE812, 0x2313,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x9714, 0x1915, 0xB416, 0x7517, =
0x4418,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x1B19,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x031B, 0x031C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x851F, 0x0920, 0x0C21, =
0x0422,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7B23, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xDD4A, 0x604B, 0x044C, =
0x004D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E */ =
<BR>+&nbsp;&nbsp;&nbsp; =
0x434F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xAF50, 0xFF51, 0x3452, 0x9C53, 0x0354,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x3355, 0xEA56, 0xC357, 0x3558, =
0xE959,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0x515A, 0x935B, 0x095C, =
0x5A5D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xEB5E, 0x165F, 0x0560, 0x0061, 0x0162,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0xEF63, =
0x0664,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 1200,1024,1024,176, 1040,72,&nbsp; =
925, 768, 768, 157, 782, 13<BR>+};<BR>+<BR>+static u16 =
VT1622_P848x480_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x8400, 0x0001, 0x0002, 0xC003, =
0x0004,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x1006, 0x5707, 0xD108, 0x3E09,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x710A, 0x000B, 0x4E0C, 0x500D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0xE512, 0x2A13,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0xFD14, 0x1415, 0x9316, 0x1317, =
0xE618,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2019,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x031B, 0x0B1C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D */ =
<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x841F, 0x0F20, 0x0C21, =
0x0422,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7B23, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xE74A, 0x454B, 0x044C, =
0x004D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x464F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xAF50, 0x5151, 0x3452, 0x3E53, 0x0254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x4F55, 0x3A56, 0xA257, 0x3458, =
0xBE59,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0B5A, 0x765B, 0x645C, =
0x585D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xAE5E, 0x1A5F, 0x0360, 0x0061, 0x0162,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x4F63, =
0x0464,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 1200,848, 848, 352, 856, 56,&nbsp; =
575, 480, 480, 95,&nbsp; 495, 25<BR>+};<BR>+<BR>+static u16 =
VT1622_P720x576_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x0400, 0x0001, 0x0002, 0xA603, =
0x0004,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x1006, 0xDE07, 0xA308, 0x3609,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x6D0A, 0x000B, 0x570C, 0x4F0D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0x0512, 0x0713,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x2114, 0x1015, 0xCB16, 0x8A17, =
0x0918,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2A19,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x031B, 0x021C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x841F, 0x1320, 0x0C21, =
0x0422,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7B23, =
0x4824,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xE74A, 0x454B, 0x044C, =
0x004D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x474F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xE750, 0xD151, 0x2352, 0xA253, 0x0254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x5F55, 0x8556, 0x7E57, 0x2358, =
0x9459,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xD05A, 0x275B, 0x8F5C, =
0x165D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x525E, 0x7A5F, 0x0460, 0x0061, 0x0062,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x3763, =
0x0464,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 1000,720, 720, 280, 776, 64,&nbsp; =
675, 576, 576, 99,&nbsp; 602, 13<BR>+};<BR>+<BR>+/* TV Overscan Table =
*/<BR>+<BR>+static u16 VT1622_N640x480_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x0400, 0x0001, 0x0002, 0x0203, =
0x0304,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x1006, 0x8F07, 0x6A08, 0x0009,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x6A0A, 0x170B, 0x520C, 0x500D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0x6812, 0x0D13,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x5014, 0x1C15, 0x4516, 0x9917, =
0x9918,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2919,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x031B, 0x021C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x051F, 0x1220, 0x0C21, =
0x0422,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7523, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xC44A, 0x504B, 0x044C, =
0x004D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x414F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x1F50, 0x7F51, 0x2352, 0x0C53, 0x0254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0xBB55, 0x3256, 0x6757, 0x2258, =
0x7659,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xB05A, 0xD25B, 0x2E5C, =
0x055D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x005E, 0x8E5F, 0x0060, 0x0061, 0x0062,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x1F63, =
0x0364,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 800, 640, 640, 160, 656, 96,&nbsp; =
525, 480, 480, 45,&nbsp; 495, 11<BR>+};<BR>+<BR>+static u16 =
VT1622_N800x600_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x8400, 0x0001, 0x0002, 0x2403, =
0x0304,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x1006, 0xA907, 0x8808, 0x0409,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x650A, 0x170B, 0x460C, 0x4C0D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0xCA12, 0x0D13,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x7C14, 0x1C15, 0xD116, 0x6217, =
0x8C18,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2119,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x031B, 0x031C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x841F, 0x0D20, 0x0A21, =
0x0422,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7523, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xE44A, 0x694B, 0x044C, =
0x004D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x444F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xE750, 0x1F51, 0x3352, 0x8A53, 0x0254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x6355, 0xB956, 0x8057, 0x2358, =
0x9359,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xDC5A, 0x0B5B, 0x7D5C, =
0x165D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xF65E, 0x975F, 0x0460, 0x0061, 0x0162,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0xD763, =
0x0464,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 1000,800, 800, 200, 832, 96,&nbsp; =
651, 600, 600, 51,&nbsp; 608, 12<BR>+};<BR>+<BR>+static u16 =
VT1622_N1024x768_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x8400, 0x0001, 0x0002, 0x4403, =
0x0304,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */ <BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x1006, 0x5807, 0xC308, 0x0509,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x640A, 0x170B, 0x5C0C, 0x4D0D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0xEA12, 0x0D13,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0xB014, 0x1C15, 0x8A16, 0xE817, =
0xA218,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x1719,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x031B, 0x031C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x851F, 0x0A20, 0x0521, =
0x0422,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7423, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xE44A, 0x504B, 0x044C, =
0x004D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x434F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x5F50, 0xFF51, 0x3452, 0x3853, 0x0354,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0xCF55, 0xDF56, 0xB657, 0x3458, =
0xD259,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0x395A, 0x815B, 0x405C, =
0x595D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x495E, 0x225F, 0x0660, 0x0061, 0x0162,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0xDF63, =
0x0664,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 1120,1024,1024,96,&nbsp; =
1040,40,&nbsp; 825, 768, 768, 57,&nbsp; 770, 6<BR>+};<BR>+<BR>+static =
u16 VT1622_N848x480_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x8400, 0x0001, 0x0002, 0x4403, =
0x0304,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x1006, 0x9607, 0xA708, 0x0809,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x5B0A, 0x170B, 0x460C, 0x400D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0xE812, 0x3C13,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x2D14, 0x2215, 0xA116, 0x6417, =
0x9318,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x1B19,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x031B, 0x011C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x851F, 0x0D20, 0x0821, =
0x0422,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7523, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xDC4A, 0x504B, 0x004C, =
0x004D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x404F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xEF50, 0x5151, 0x3352, 0x2553, 0x0254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x1F55, 0x4D56, 0x9C57, 0x3458, =
0xB559,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0C5A, 0x3D5B, 0xF15C, =
0x575D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x305E, 0x015F, 0x0460, 0x0061, 0x0162,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x1F63, =
0x0464,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */ <BR>+&nbsp;&nbsp;&nbsp; 1008,848, 848, 160, 856, 72,&nbsp; =
550, 480, 480, 70,&nbsp; 491, 5<BR>+};<BR>+<BR>+static u16 =
VT1622_N720x480_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x0400, 0x0001, 0x0002, 0x0203, =
0x0304,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x1006, 0x1807, 0x2808, 0x0909,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x5B0A, 0x170B, 0x460C, 0x410D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0xEE12, 0x0D13,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */ <BR>+&nbsp;&nbsp;&nbsp; 0xA014, 0x3815, 0x1D16, 0x6617, =
0x6618,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2419,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x031B, 0x021C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x851F, 0x1120, 0x0821, =
0x0422,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7523, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xE44A, 0x694B, 0x044C, =
0x004D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x404F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x1F50, 0xCF51, 0x2352, 0x0C53, 0x0254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x1F55, 0xCE56, 0x7657, 0x2358, =
0x8859,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xC95A, 0xEF5B, 0xFF5C, =
0x055D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x005E, 0x005F, 0x0060, 0x0061, 0x0062,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x1F63, =
0x0364,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 800, 720, 720, 80,&nbsp; 728, =
32,&nbsp; 525, 480, 480, 45,&nbsp; 482, 1<BR>+};<BR>+<BR>+static u16 =
VT1622_P640x480_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x0400, 0x0001, 0x0002, 0x8203, =
0x0004,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x1006, 0xCA07, 0x7D08, 0x3109,&nbsp;&nbsp;&nbsp;&nbsp; /* =
Tv.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x7A0A, 0x000B, 0x480C, 0x580D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0x4A12, 0x0713,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x3714, 0x2415, 0xC016, 0xD917, =
0x7118,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x3219,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x031B, 0x021C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x051F, 0x1520, 0x0C21, =
0x0422,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7B23, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xF94A, 0x7F4B, 0x234C, =
0xF34D, 0x014E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xCF4F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xE750, 0x7F51, 0x2352, 0xF353, 0x0154,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0xCF55, 0x3F56, 0x6957, 0x2258, =
0x7A59,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xAD5A, 0xF85B, 0x765C, =
0x055D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x335E, 0x705F, 0x0360, 0x0061, 0x0062,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x1F63, =
0x0364,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 1000,640, 640, 360, 800, 120, 500, =
480, 480, 20,&nbsp; 485, 6<BR>+};<BR>+<BR>+static u16 =
VT1622_P800x600_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x8400, 0x0001, 0x0002, 0xA003, =
0x0004,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x1906, 0x8007, 0xA608, 0x3609,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x770A, 0x000B, 0x570C, 0x540D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0xED12, 0x1513,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x1E14, 0x3115, 0x5016, 0x6317, =
0xD518,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2519,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x031B, 0x031C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x851F, 0x1020, 0x0C21, =
0x0422,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7B23, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xE94A, 0x504B, 0x044C, =
0x004D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x474F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xE750, 0x1F51, 0x3352, 0x8953, 0x0254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0xBF55, 0x0056, 0x8D57, 0x3358, =
0xA559,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xE85A, 0x475B, 0x4B5C, =
0x175D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x295E, 0x285F, 0x0460, 0x0061, 0x0162,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x0F63, =
0x0464,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 1000,800, 800, 200, 872, 56,&nbsp; =
650, 600, 600, 50,&nbsp; 608, 12<BR>+};<BR>+<BR>+static u16 =
VT1622_P1024x768_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x8400, 0x0001, 0x0002, 0xC003, =
0x0004,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x1006, 0x7107, 0xD108, 0x3809,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x770A, 0x000B, 0x4E0C, 0x520D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0xC912, 0x0A13,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x7914, 0x1C15, 0x3816, 0x0E17, =
0x7B18,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x1D19,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x031B, 0x031C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x851F, 0x0C20, 0x0C21, =
0x0422,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7B23, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xDD4A, 0x604B, 0x044C, =
0x004D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x474F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xAF50, 0xFF51, 0x3452, 0x3853, 0x0354,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0xCF55, 0xE356, 0xB457, 0x3458, =
0xD459,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2B5A, 0xA05B, 0x5E5C, =
0x595D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x485E, 0x205F, 0x0560, 0x0061, 0x0162,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x2F63, =
0x0664,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 1200,1024,1024,176, 1088,56,&nbsp; =
825, 768, 768, 57,&nbsp; 771, 5<BR>+};<BR>+<BR>+static u16 =
VT1622_P848x480_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x8400, 0x0001, 0x0002, 0xC003, =
0x0004,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x1006, 0x4707, 0xA808, 0x3909,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x640A, 0x000B, 0x4E0C, 0x460D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0xEA12, 0x1513,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0xF214, 0x2815, 0xEC16, 0xE517, =
0x6418,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2219,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x031B, 0x0B1C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x841F, 0x0F20, 0x0C21, =
0x0422,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7B23, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xE74A, 0x454B, 0x044C, =
0x004D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x434F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xAF50, 0x4F51, 0x3452, 0x2553, 0x0254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x1F55, 0x4F56, 0x9B57, 0x3458, =
0xB759,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0A5A, 0x3F5B, 0xF05C, =
0x575D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x855E, 0x005F, 0x0360, 0x0061, 0x0162,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x1F63, =
0x0464,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 1200,848, 848, 352, 872, 176, 550, =
480, 480, 70,&nbsp; 491, 5<BR>+};<BR>+<BR>+static u16 =
VT1622_P720x576_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x0400, 0x0001, 0x0002, 0xA603, =
0x0004,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x1006, 0x1007, 0x7D08, 0x3209,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x600A, 0x000B, 0x570C, 0x460D, =
0x0F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x000F, 0x0010, 0x0011, 0xEC12, 0x1513,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0xDC14, 0x2815, 0x2D16, 0x7717, =
0x6618,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2D19,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x031B, 0x0A1C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x841F, 0x1320, 0x0C21, =
0x0422,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7B23, =
0x4824,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xE74A, 0x454B, 0x044C, =
0x004D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x454F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xE750, 0xCF51, 0x2352, 0x5753, 0x0254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x1F55, 0x8056, 0x7557, 0x2358, =
0x8959,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xC75A, 0xF15B, 0xFF5C, =
0x055D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */ <BR>+&nbsp;&nbsp;&nbsp; =
0xD75E, 0x805F, 0x0360, 0x0061, 0x0062,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0xBF63, =
0x0364,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-64 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, =
VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 1000,720, 720, 280, 728, 48,&nbsp; =
600, 576, 576, 24,&nbsp; 577, =
3<BR>+};<BR>+<BR>+/***********************************/<BR>+/* VT1622 =
output RGB Table&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+/***********************************/<BR>+<BR>+/* NTSC =
*/<BR>+<BR>+static u16 VT1622_N640x480_RGB_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N800x600_RGB_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N1024x768_RGB_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N848x480_RGB_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N720x480_RGB_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N640x480_RGB_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N800x600_RGB_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N1024x768_RGB_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N848x480_RGB_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N720x480_RGB_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N640x480_RGB_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N800x600_RGB_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N1024x768_RGB_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N848x480_RGB_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N720x480_RGB_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+/* PAL */<BR>+<BR>+static u16 =
VT1622_P640x480_RGB_VN[] =3D {<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P800x600_RGB_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P1024x768_RGB_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P848x480_RGB_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P720x576_RGB_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P640x480_RGB_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P800x600_RGB_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P1024x768_RGB_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P848x480_RGB_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P720x576_RGB_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P640x480_RGB_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P800x600_RGB_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P1024x768_RGB_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P848x480_RGB_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P720x576_RGB_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+/***********************************/<BR>+/* =
VT1622 output YPBPR Table&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+/***********************************/<BR>+<BR>+/* NTSC =
*/<BR>+<BR>+static u16 VT1622_N640x480_YPBPR_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4B66, =
0x4D67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N800x600_YPBPR_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x4365, 0x4A66, =
0x4967,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N1024x768_YPBPR_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x5865, 0x4B66, =
0x4A67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N848x480_YPBPR_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x4465, 0x4566, =
0x4567,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+<BR>+};<BR>+<BR>+static u16 VT1622_N720x480_YPBPR_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x4265, 0x4966, =
0x4867,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N640x480_YPBPR_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x4F65, 0x4966, =
0x4967,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N800x600_YPBPR_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x4265, 0x4566, =
0x4567,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N1024x768_YPBPR_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x5765, 0x4566, =
0x4567,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N848x480_YPBPR_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x5865, 0x4566, =
0x4567,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N720x480_YPBPR_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x4D65, 0x4966, =
0x4967,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N640x480_YPBPR_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x4B65, 0x4866, =
0x4867,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N800x600_YPBPR_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x4265, 0x4566, =
0x4567,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N1024x768_YPBPR_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x5765, 0x4566, =
0x4567,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N848x480_YPBPR_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x5865, 0x4566, =
0x4567,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N720x480_YPBPR_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x4D65, 0x4966, =
0x4967,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+/* PAL */<BR>+<BR>+static u16 =
VT1622_P640x480_YPBPR_VN[] =3D {<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x4265, 0x4966, =
0x4967,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P800x600_YPBPR_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x5865, 0x5E66, =
0x5E67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P1024x768_YPBPR_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x5165, 0x4966, =
0x4967,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P848x480_YPBPR_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x4966, =
0x4967,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P720x576_YPBPR_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x5965, 0x4D66, =
0x4A67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P640x480_YPBPR_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x4265, 0x4966, =
0x4967,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P800x600_YPBPR_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x5865, 0x4866, =
0x4867,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P1024x768_YPBPR_VF[] =3D { =
<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x5065, 0x6966, =
0x6967,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P848x480_YPBPR_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x4E65, 0x4966, =
0x4967,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P720x576_YPBPR_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x5865, 0x4866, =
0x4967,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P640x480_YPBPR_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x4265, 0x4966, =
0x4967,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P800x600_YPBPR_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x5865, 0x4866, =
0x4867,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P1024x768_YPBPR_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x5165, 0x4966, =
0x4967,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P848x480_YPBPR_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x4E65, 0x4966, =
0x4967,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P720x576_YPBPR_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0302,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output YPBPR =
type */<BR>+&nbsp;&nbsp;&nbsp; 0x5865, 0x4866, =
0x4967,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust YPBPR Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+/***********************************/<BR>+/* =
VT1622 output SDTV_RGB Table&nbsp;&nbsp;&nbsp; =
*/<BR>+/***********************************/<BR>+<BR>+/* NTSC =
*/<BR>+<BR>+static u16 VT1622_N640x480_SDTV_RGB_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N800x600_SDTV_RGB_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N1024x768_SDTV_RGB_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N848x480_SDTV_RGB_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N720x480_SDTV_RGB_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N640x480_SDTV_RGB_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N800x600_SDTV_RGB_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 =
VT1622_N1024x768_SDTV_RGB_VF[]=3D{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N848x480_SDTV_RGB_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N720x480_SDTV_RGB_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N640x480_SDTV_RGB_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N800x600_SDTV_RGB_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N1024x768_SDTV_RGB_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N848x480_SDTV_RGB_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N720x480_SDTV_RGB_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+/* PAL */<BR>+<BR>+static u16 =
VT1622_P640x480_SDTV_RGB_VN[] =3D {<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+<BR>+};<BR>+<BR>+static u16 VT1622_P800x600_SDTV_RGB_VN[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+<BR>+};<BR>+<BR>+static u16 VT1622_P1024x768_SDTV_RGB_VN[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P848x480_SDTV_RGB_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P720x576_SDTV_RGB_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+<BR>+};<BR>+<BR>+static u16 VT1622_P640x480_SDTV_RGB_VF[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P800x600_SDTV_RGB_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P1024x768_SDTV_RGB_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+<BR>+};<BR>+<BR>+static u16 VT1622_P848x480_SDTV_RGB_VF[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P720x576_SDTV_RGB_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P640x480_SDTV_RGB_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P800x600_SDTV_RGB_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P1024x768_SDTV_RGB_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P848x480_SDTV_RGB_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P720x576_SDTV_RGB_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+/***********************************/<BR>+/* =
VT1622 output SDTV_YPBPR Table&nbsp; =
*/<BR>+/***********************************/<BR>+<BR>+/* NTSC =
*/<BR>+<BR>+static u16 VT1622_N640x480_SDTV_YPBPR_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N800x600_SDTV_YPBPR_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N1024x768_SDTV_YPBPR_VN[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N848x480_SDTV_YPBPR_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N720x480_SDTV_YPBPR_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N640x480_SDTV_YPBPR_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N800x600_SDTV_YPBPR_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N1024x768_SDTV_YPBPR_VF[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N848x480_SDTV_YPBPR_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N720x480_SDTV_YPBPR_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N640x480_SDTV_YPBPR_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N800x600_SDTV_YPBPR_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N1024x768_SDTV_YPBPR_VO[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N848x480_SDTV_YPBPR_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N720x480_SDTV_YPBPR_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+/* PAL */<BR>+<BR>+static u16 =
VT1622_P640x480_SDTV_YPBPR_VN[] =3D {<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P800x600_SDTV_YPBPR_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P1024x768_SDTV_YPBPR_VN[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P848x480_SDTV_YPBPR_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P720x576_SDTV_YPBPR_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P640x480_SDTV_YPBPR_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P800x600_SDTV_YPBPR_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P1024x768_SDTV_YPBPR_VF[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P848x480_SDTV_YPBPR_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P720x576_SDTV_YPBPR_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P640x480_SDTV_YPBPR_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P800x600_SDTV_YPBPR_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P1024x768_SDTV_YPBPR_VO[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P848x480_SDTV_YPBPR_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_P720x576_SDTV_YPBPR_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+/***********************************/<BR>+/* =
VT1622 DeDotCrawl Table&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+/***********************************/<BR>+<BR>+/* NTSC =
*/<BR>+<BR>+static u16 VT1622_N640x480_DeDotCrawl_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0811,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Enable =
DeDotCrawl (only update bit3 of TV.11h register) =
*/<BR>+&nbsp;&nbsp;&nbsp; 0xD516, =
0x8D17,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* adjust TV FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N800x600_DeDotCrawl_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0811,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Enable =
DeDotCrawl (only update bit3 of TV.11h register) =
*/<BR>+&nbsp;&nbsp;&nbsp; 0xA116, =
0x5917,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* adjust TV FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N1024x768_DeDotCrawl_VN[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; =
0x0811,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Enable =
DeDotCrawl (only update bit3 of TV.11h register) =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x1116, =
0xE217,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* adjust TV FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N848x480_DeDotCrawl_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0811,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Enable =
DeDotCrawl (only update bit3 of TV.11h register) =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x5B16, =
0xA017,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* adjust TV FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N720x480_DeDotCrawl_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0811,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Enable =
DeDotCrawl (only update bit3 of TV.11h register) =
*/<BR>+&nbsp;&nbsp;&nbsp; 0xC316, =
0x4C17,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* adjust TV FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N640x480_DeDotCrawl_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0811,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Enable =
DeDotCrawl (only update bit3 of TV.11h register) =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x5016, =
0x7B17,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* adjust TV FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N800x600_DeDotCrawl_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0811,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Enable =
DeDotCrawl (only update bit3 of TV.11h register) =
*/<BR>+&nbsp;&nbsp;&nbsp; 0xD116, =
0xF617,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* adjust TV FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N1024x768_DeDotCrawl_VF[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; =
0x0811,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Enable =
DeDotCrawl (only update bit3 of TV.11h register) =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0616, =
0x8417,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* adjust TV FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N848x480_DeDotCrawl_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0811,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Enable =
DeDotCrawl (only update bit3 of TV.11h register) =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x1C16, =
0x7D17,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* adjust TV FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N720x480_DeDotCrawl_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0811,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Enable =
DeDotCrawl (only update bit3 of TV.11h register) =
*/<BR>+&nbsp;&nbsp;&nbsp; 0xE816, =
0xEB17,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* adjust TV FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N640x480_DeDotCrawl_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0811,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Enable =
DeDotCrawl (only update bit3 of TV.11h register) =
*/<BR>+&nbsp;&nbsp;&nbsp; 0xD516, =
0x8D17,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* adjust TV FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N800x600_DeDotCrawl_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0811,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Enable =
DeDotCrawl (only update bit3 of TV.11h register) =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x1416, =
0xC717,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* adjust TV FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N1024x768_DeDotCrawl_VO[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; =
0x0811,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Enable =
DeDotCrawl (only update bit3 of TV.11h register) =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x6316, =
0x3D17,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* adjust TV FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N848x480_DeDotCrawl_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0811,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Enable =
DeDotCrawl (only update bit3 of TV.11h register) =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x6716, =
0x3017,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* adjust TV FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1622_N720x480_DeDotCrawl_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x0811,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Enable =
DeDotCrawl (only update bit3 of TV.11h register) =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x1E16, =
0x5C17,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* adjust TV FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+<BR>+static vt1622_func_table =
vt1622_ntsc_640x480_tbl[] =3D {<BR>+&nbsp;&nbsp;&nbsp; =
{TV_BASE_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_N640x480_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; =
VT1622_N640x480_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; VT1622_N640x480_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_N640x480_RGB_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_N640x480_RGB_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_N640x480_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_YPBPR_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_N640x480_YPBPR_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_N640x480_YPBPR_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_N640x480_YPBPR_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_N640x480_SDTV_RGB_VN,&nbsp;&nbsp; =
VT1622_N640x480_SDTV_RGB_VF,&nbsp;&nbsp; =
VT1622_N640x480_SDTV_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_YPBPR_FUNC,&nbsp;&nbsp; VT1622_N640x480_SDTV_YPBPR_VN, =
VT1622_N640x480_SDTV_YPBPR_VF, =
VT1622_N640x480_SDTV_YPBPR_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_DeDotCrawl_FUNC,&nbsp;&nbsp; VT1622_N640x480_DeDotCrawl_VN, =
VT1622_N640x480_DeDotCrawl_VF, =
VT1622_N640x480_DeDotCrawl_VO}<BR>+<BR>+};<BR>+<BR>+static =
vt1622_func_table vt1622_ntsc_800x600_tbl[] =3D {<BR>+&nbsp;&nbsp;&nbsp; =
{TV_BASE_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_N800x600_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; =
VT1622_N800x600_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; VT1622_N800x600_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_N800x600_RGB_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_N800x600_RGB_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_N800x600_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_YPBPR_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_N800x600_YPBPR_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_N800x600_YPBPR_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_N800x600_YPBPR_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_N800x600_SDTV_RGB_VN,&nbsp;&nbsp; =
VT1622_N800x600_SDTV_RGB_VF,&nbsp;&nbsp; =
VT1622_N800x600_SDTV_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_YPBPR_FUNC,&nbsp;&nbsp; VT1622_N800x600_SDTV_YPBPR_VN, =
VT1622_N800x600_SDTV_YPBPR_VF, =
VT1622_N800x600_SDTV_YPBPR_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_DeDotCrawl_FUNC,&nbsp;&nbsp; VT1622_N800x600_DeDotCrawl_VN, =
VT1622_N800x600_DeDotCrawl_VF, =
VT1622_N800x600_DeDotCrawl_VO}<BR>+};<BR>+<BR>+static vt1622_func_table =
vt1622_ntsc_1024x768_tbl[]=3D {<BR>+&nbsp;&nbsp;&nbsp; =
{TV_BASE_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_N1024x768_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; =
VT1622_N1024x768_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; VT1622_N1024x768_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_N1024x768_RGB_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_N1024x768_RGB_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_N1024x768_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_YPBPR_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_N1024x768_YPBPR_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_N1024x768_YPBPR_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_N1024x768_YPBPR_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_N1024x768_SDTV_RGB_VN,&nbsp;&nbsp; =
VT1622_N1024x768_SDTV_RGB_VF,&nbsp;&nbsp; =
VT1622_N1024x768_SDTV_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_YPBPR_FUNC,&nbsp;&nbsp; VT1622_N1024x768_SDTV_YPBPR_VN, =
VT1622_N1024x768_SDTV_YPBPR_VF, =
VT1622_N1024x768_SDTV_YPBPR_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_DeDotCrawl_FUNC,&nbsp;&nbsp; VT1622_N1024x768_DeDotCrawl_VN, =
VT1622_N1024x768_DeDotCrawl_VF, =
VT1622_N1024x768_DeDotCrawl_VO}<BR>+};<BR>+<BR>+static vt1622_func_table =
vt1622_ntsc_848x480_tbl[] =3D {<BR>+&nbsp;&nbsp;&nbsp; =
{TV_BASE_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_N848x480_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; =
VT1622_N848x480_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; VT1622_N848x480_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_N848x480_RGB_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_N848x480_RGB_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_N848x480_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_YPBPR_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_N848x480_YPBPR_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_N848x480_YPBPR_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_N848x480_YPBPR_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_N848x480_SDTV_RGB_VN,&nbsp;&nbsp;&nbsp; =
VT1622_N848x480_SDTV_RGB_VF,&nbsp;&nbsp;&nbsp; =
VT1622_N848x480_SDTV_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_YPBPR_FUNC,&nbsp;&nbsp; VT1622_N848x480_SDTV_YPBPR_VN,&nbsp; =
VT1622_N848x480_SDTV_YPBPR_VF,&nbsp; =
VT1622_N848x480_SDTV_YPBPR_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_DeDotCrawl_FUNC,&nbsp;&nbsp; VT1622_N848x480_DeDotCrawl_VN,&nbsp; =
VT1622_N848x480_DeDotCrawl_VF,&nbsp; =
VT1622_N848x480_DeDotCrawl_VO}<BR>+};<BR>+<BR>+static vt1622_func_table =
vt1622_ntsc_720x480_tbl[] =3D {<BR>+&nbsp;&nbsp;&nbsp; =
{TV_BASE_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_N720x480_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; =
VT1622_N720x480_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; VT1622_N720x480_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_N720x480_RGB_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_N720x480_RGB_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_N720x480_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_YPBPR_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_N720x480_YPBPR_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_N720x480_YPBPR_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_N720x480_YPBPR_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_N720x480_SDTV_RGB_VN,&nbsp;&nbsp;&nbsp; =
VT1622_N720x480_SDTV_RGB_VF,&nbsp;&nbsp;&nbsp; =
VT1622_N720x480_SDTV_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_YPBPR_FUNC,&nbsp;&nbsp; VT1622_N720x480_SDTV_YPBPR_VN,&nbsp; =
VT1622_N720x480_SDTV_YPBPR_VF,&nbsp; =
VT1622_N720x480_SDTV_YPBPR_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_DeDotCrawl_FUNC,&nbsp;&nbsp; VT1622_N720x480_DeDotCrawl_VN,&nbsp; =
VT1622_N720x480_DeDotCrawl_VF,&nbsp; =
VT1622_N720x480_DeDotCrawl_VO}<BR>+};<BR>+<BR>+static vt1622_func_table =
vt1622_pal_640x480_tbl[] =3D {<BR>+&nbsp;&nbsp;&nbsp; =
{TV_BASE_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_P640x480_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; =
VT1622_P640x480_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; VT1622_P640x480_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_P640x480_RGB_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_P640x480_RGB_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_P640x480_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_YPBPR_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_P640x480_YPBPR_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_P640x480_YPBPR_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_P640x480_YPBPR_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_P640x480_SDTV_RGB_VN,&nbsp;&nbsp;&nbsp; =
VT1622_P640x480_SDTV_RGB_VF,&nbsp;&nbsp;&nbsp; =
VT1622_P640x480_SDTV_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_YPBPR_FUNC,&nbsp;&nbsp; VT1622_P640x480_SDTV_YPBPR_VN,&nbsp; =
VT1622_P640x480_SDTV_YPBPR_VF,&nbsp; =
VT1622_P640x480_SDTV_YPBPR_VO}<BR>+};<BR>+<BR>+static vt1622_func_table =
vt1622_pal_800x600_tbl[] =3D {<BR>+&nbsp;&nbsp;&nbsp; =
{TV_BASE_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_P800x600_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; =
VT1622_P800x600_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; VT1622_P800x600_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_P800x600_RGB_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_P800x600_RGB_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_P800x600_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_YPBPR_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_P800x600_YPBPR_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_P800x600_YPBPR_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_P800x600_YPBPR_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_P800x600_SDTV_RGB_VN,&nbsp;&nbsp;&nbsp; =
VT1622_P800x600_SDTV_RGB_VF,&nbsp;&nbsp;&nbsp; =
VT1622_P800x600_SDTV_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_YPBPR_FUNC,&nbsp;&nbsp; VT1622_P800x600_SDTV_YPBPR_VN,&nbsp; =
VT1622_P800x600_SDTV_YPBPR_VF,&nbsp; =
VT1622_P800x600_SDTV_YPBPR_VO}<BR>+};<BR>+<BR>+static vt1622_func_table =
vt1622_pal_1024x768_tbl[] =3D {<BR>+&nbsp;&nbsp;&nbsp; =
{TV_BASE_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_P1024x768_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; =
VT1622_P1024x768_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; VT1622_P1024x768_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_P1024x768_RGB_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_P1024x768_RGB_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_P1024x768_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_YPBPR_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_P1024x768_YPBPR_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_P1024x768_YPBPR_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_P1024x768_YPBPR_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_P1024x768_SDTV_RGB_VN,&nbsp;&nbsp;&nbsp; =
VT1622_P1024x768_SDTV_RGB_VF,&nbsp;&nbsp;&nbsp; =
VT1622_P1024x768_SDTV_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_YPBPR_FUNC,&nbsp;&nbsp; VT1622_P1024x768_SDTV_YPBPR_VN,&nbsp; =
VT1622_P1024x768_SDTV_YPBPR_VF,&nbsp; =
VT1622_P1024x768_SDTV_YPBPR_VO}<BR>+};<BR>+<BR>+static vt1622_func_table =
vt1622_pal_848x480_tbl[] =3D {<BR>+&nbsp;&nbsp;&nbsp; =
{TV_BASE_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_P848x480_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; =
VT1622_P848x480_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; VT1622_P848x480_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_P848x480_RGB_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_P848x480_RGB_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_P848x480_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_YPBPR_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_P848x480_YPBPR_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_P848x480_YPBPR_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_P848x480_YPBPR_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_P848x480_SDTV_RGB_VN,&nbsp;&nbsp;&nbsp; =
VT1622_P848x480_SDTV_RGB_VF,&nbsp;&nbsp;&nbsp; =
VT1622_P848x480_SDTV_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_YPBPR_FUNC,&nbsp;&nbsp; VT1622_P848x480_SDTV_YPBPR_VN,&nbsp; =
VT1622_P848x480_SDTV_YPBPR_VF,&nbsp; =
VT1622_P848x480_SDTV_YPBPR_VO}<BR>+};<BR>+<BR>+static vt1622_func_table =
vt1622_pal_720x576_tbl[] =3D {<BR>+&nbsp;&nbsp;&nbsp; =
{TV_BASE_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_P720x576_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; =
VT1622_P720x576_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; VT1622_P720x576_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_P720x576_RGB_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_P720x576_RGB_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_P720x576_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_YPBPR_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_P720x576_YPBPR_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_P720x576_YPBPR_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_P720x576_YPBPR_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp; =
VT1622_P720x576_SDTV_RGB_VN,&nbsp;&nbsp;&nbsp; =
VT1622_P720x576_SDTV_RGB_VF,&nbsp;&nbsp;&nbsp; =
VT1622_P720x576_SDTV_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_YPBPR_FUNC,&nbsp;&nbsp; VT1622_P720x576_SDTV_YPBPR_VN,&nbsp; =
VT1622_P720x576_SDTV_YPBPR_VF,&nbsp; =
VT1622_P720x576_SDTV_YPBPR_VO}<BR>+};<BR>+<BR>+<BR>+static struct =
vt1622_table vt1622_tbl[] =3D {<BR>+&nbsp;&nbsp;&nbsp; =
{VIA_RES_640X480,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; vt1622_ntsc_640x480_tbl,&nbsp;&nbsp;&nbsp; =
vt1622_pal_640x480_tbl},<BR>+&nbsp;&nbsp;&nbsp; =
{VIA_RES_800X600,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; vt1622_ntsc_800x600_tbl,&nbsp;&nbsp;&nbsp; =
vt1622_pal_800x600_tbl},<BR>+&nbsp;&nbsp;&nbsp; =
{VIA_RES_1024X768,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; vt1622_ntsc_1024x768_tbl,&nbsp;&nbsp; =
vt1622_pal_1024x768_tbl},<BR>+&nbsp;&nbsp;&nbsp; =
{VIA_RES_848X480,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; vt1622_ntsc_848x480_tbl,&nbsp;&nbsp;&nbsp; =
vt1622_pal_848x480_tbl},<BR>+&nbsp;&nbsp;&nbsp; =
{VIA_RES_720X480,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; vt1622_ntsc_720x480_tbl,&nbsp;&nbsp;&nbsp; =
vt1622_ntsc_720x480_tbl},<BR>+&nbsp;&nbsp;&nbsp; =
{VIA_RES_720X576,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; vt1622_pal_720x576_tbl,&nbsp;&nbsp;&nbsp;&nbsp; =
vt1622_pal_720x576_tbl}<BR>+};<BR>+<BR>+#define NUM_TOTAL_VT1622_TABLE =
ARRAY_SIZE(vt1622_tbl)<BR>+<BR>+#endif /* __TBL1622_H__ */<BR>+<BR>diff =
-Nur linux-2.6.21-rc7/drivers/video/via/tbl1625.h =
linux-2.6.21-rc7.viafb/drivers/video/via/tbl1625.h<BR>--- =
linux-2.6.21-rc7/drivers/video/via/tbl1625.h&nbsp;1969-12-31 =
19:00:00.000000000 -0500<BR>+++ =
linux-2.6.21-rc7.viafb/drivers/video/via/tbl1625.h&nbsp;2007-04-26 =
19:52:32.000000000 -0400<BR>@@ -0,0 +1,2006 @@<BR>+/*<BR>+ * Copyright =
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
__TBL1625_H__<BR>+#define __TBL1625_H__<BR>+<BR>+#include =
"share.h"<BR>+<BR>+/***************************/<BR>+/* VT1625 TV =
Encoder Table */<BR>+/***************************/<BR>+typedef struct =
_vt1625_func_table {<BR>+&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp; =
tv_func_index;<BR>+&nbsp;&nbsp;&nbsp; u16&nbsp;&nbsp;&nbsp;&nbsp; =
*tv_underscan;<BR>+&nbsp;&nbsp;&nbsp; u16&nbsp;&nbsp;&nbsp;&nbsp; =
*tv_fitscan;<BR>+&nbsp;&nbsp;&nbsp; u16&nbsp;&nbsp;&nbsp;&nbsp; =
*tv_overscan;<BR>+} vt1625_func_table;<BR>+<BR>+struct vt1625_table =
{<BR>+&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp; =
tv_index;<BR>+&nbsp;&nbsp;&nbsp; vt1625_func_table&nbsp;&nbsp; =
*tv_mode_ntsc;<BR>+&nbsp;&nbsp;&nbsp; vt1625_func_table&nbsp;&nbsp; =
*tv_mode_pal;<BR>+&nbsp;&nbsp;&nbsp; vt1625_func_table&nbsp;&nbsp; =
*tv_mode_720p;<BR>+&nbsp;&nbsp;&nbsp; vt1625_func_table&nbsp;&nbsp; =
*tv_mode_1080i;<BR>+};<BR>+<BR>+<BR>+/* Underscan table */<BR>+static =
u16 VT1625_N640x480_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x0300, 0x0001, 0x1002, 0x1F03, =
0x0004,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x0006, 0x2907, 0x4008, 0x0B09,&nbsp;&nbsp;&nbsp;&nbsp; /* =
Tv.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x7B0A, 0x150B, 0x500C, 0x570D, =
0x000E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x9E0F, 0x0010, 0x8011, 0xFA12, 0x2113,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0xE014, 0x6815, 0xD616, 0x7B17, =
0xF018,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2119,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x501B, 0x011C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x101F, 0x1C20, 0x2A21, =
0xCB22,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7723, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xC54A, 0x00F4B, =
0x004C, 0x014D, 0x104E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x4A4F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x0F50, 0x8151, 0x2352, 0x5753, 0x2254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x5955, 0x8156, 0x7F57, 0x2358, =
0x9159,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xD25A, 0x135B, 0x7C5C, =
0x165D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x495E, 0x005F, 0x9260, 0x2061, 0xFF62,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x7F63, 0x0364, =
0x5165,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-65 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* HT,&nbsp; HA, HBS, HBE, HSS, =
HSE,&nbsp; VT,&nbsp; VA, VBS, VBE, VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; =
784, 640, 640, 144, 688, 56,&nbsp; 600, 480, 480, 120, 488, =
7<BR>+};<BR>+<BR>+#define NUM_TOTAL_VT1625_REG =
ARRAY_SIZE(VT1625_N640x480_VN) -NUM_CRTC_TIMING<BR>+<BR>+static u16 =
VT1625_N800x600_VN[] =3D {<BR>+<BR>+&nbsp;&nbsp;&nbsp; 0x0300, 0x0001, =
0x1002, 0x9003, 0x0004,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0005, 0x0006, 0x5807, 0x4508, =
0x0909,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7B0A, 0x150B, 0x500C, 0x570D, 0x000E,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; 0x9E0F, 0x0010, 0x8011, 0xED12, =
0x2113,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; =
0xBE14, 0x3415, 0xD616, 0x7B17, 0xF018,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2119,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x501B, 0x011C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x101F, 0x1C20, 0x0A21, =
0xC922,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7723, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xC54A, 0x0F4B, =
0x004C, 0x014D, 0x104E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x4A4F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x2750, 0x2251, 0x3452, 0xED53, 0x2254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x5955, 0x7B56, 0x7F57, 0x2358, =
0x8C59,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xD25A, 0x135B, 0x7A5C, =
0x165D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xDB5E, 0x1A5F, 0xB660, 0xAA61, 0xFF62,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0xEF63, 0x0564, =
0x5165,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-65 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* HT,&nbsp;&nbsp; HA, HBS, HBE, HSS, =
HSE,&nbsp; VT,&nbsp; VA, VBS, VBE, VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; =
1064, 800, 800, 264, 840, 136, 750, 600, 600, 150, 606, =
15<BR>+};<BR>+<BR>+static u16 VT1625_N1024x768_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x0300, 0x0001, 0x1002, 0x9A03, =
0x0004,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x0006, 0x1107, 0x7A08, 0x0C09,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x7B0A, 0x150B, 0x500C, 0x570D, =
0x000E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x9E0F, 0x0010, 0x8011, 0x2812, 0x0D13,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x2814, 0x1415, 0xB416, 0x8317, =
0x0F18,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x1619,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x501B, 0x011C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x001F, 0x1220, 0xFF21, =
0xA522,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7723, =
0x0C24,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xC54A, 0x0F4B, =
0x004C, 0x014D, 0x104E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x4A4F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x5F50, 0x0251, 0x4452, 0xDD53, 0x0354,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x2755, 0xA456, 0xC357, 0x3558, =
0xE259,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0x475A, 0xA05B, 0xFF5C, =
0x595D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x5F5E, 0xCC5F, 0xF160, 0x2861, 0xFF62,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x3F63, 0x0864, =
0x5165,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-65 =
*/<BR>+<BR>+&nbsp; /*&nbsp; HT,&nbsp;&nbsp; HA,&nbsp; HBS, HBE, HSS, =
HSE, VT,&nbsp; VA, VBS, VBE, VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 1120, =
1024, 1024, 96, 1080, 24, 990, 768, 768, 222, 800, =
6<BR>+};<BR>+<BR>+static u16 VT1625_N720x480_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x0300, 0x0001, 0x1002, 0x1F03, =
0x0004,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x0006, 0x2A07, 0x4108, 0x0A09,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x7B0A, 0x150B, 0x500C, 0x570D, =
0x000E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0xB70F, 0x0010, 0x8011, 0xAB12, 0x2713,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x7014, 0x2C15, 0xD616, 0x7B17, =
0xF018,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2119,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x501B, 0x011C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x101F, 0x1C20, 0x0821, =
0xCB22,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7723, =
0x0224,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xC54A, 0x0F4B, =
0x004C, 0x014D, 0x104E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x4A4F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x0F50, 0xCF51, 0x2352, 0x5753, 0x2254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x5955, 0x8356, 0x7F57, 0x2358, =
0x9159,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xD25A, 0x135B, 0x7A5C, =
0x165D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x495E, 0xF15F, 0x9260, 0xA861, 0xFF62,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x7F63, 0x0364, =
0x5165,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-65 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* HT,&nbsp; HA, HBS, HBE, HSS, =
HSE,&nbsp; VT,&nbsp; VA, VBS, VBE, VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; =
784, 720, 720, 64,&nbsp; 728,&nbsp; 16, 600, 480, 480, 120, 490, =
6<BR>+};<BR>+<BR>+static u16 VT1625_P640x480_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x0300, 0x0001, 0x1002, 0x1F03, =
0x0304,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x0006, 0xF207, 0x4208, 0x0A09,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x880A, 0x000B, 0x550C, 0x5E0D, =
0x000E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0xB00F, 0x0010, 0x8011, 0x0A12, 0x0913,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x1914, 0x2815, 0xCB16, 0x8A17, =
0x0918,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2A19,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x501B, 0x011C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x101F, 0x1720, 0x1C21, =
0x3522,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7D23, =
0x0224,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xC54A, 0x0F4B, =
0x004C, 0x014D, 0x104E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x514F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xE750, 0x8151, 0x2352, 0x5753, 0x2254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x5F55, 0x6F56, 0x7F57, 0x2358, =
0x9459,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xD05A, 0x1C5B, 0x8F5C, =
0x165D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xE15E, 0x385F, 0x7A60, 0x2861, 0xFF62,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0xBF63, 0x0364, =
0x5165,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-65 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* HT,&nbsp; HA, HBS, HBE, HSS, =
HSE,&nbsp; VT,&nbsp; VA, VBS, VBE, VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; =
1000, 640, 640, 360, 704, 56,&nbsp; 600, 480, 480, 120, 500, =
6<BR>+};<BR>+<BR>+static u16 VT1625_P800x600_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; 0x0300, 0x0001, 0x1002, 0x9003, =
0x0304,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x0006, 0x2807, 0x4108, 0x0F09,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x880A, 0x000B, 0x550C, 0x5E0D, =
0x000E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x9E0F, 0x0010, 0x8011, 0x1212, 0x0413,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x1714, 0x4815, 0xCB16, 0x8A17, =
0x0918,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2A19,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x501B, 0x011C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x101F, 0x1720, 0x1C21, =
0x3122,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7D23, =
0x0224,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xC54A, 0x0F4B, =
0x004C, 0x014D, 0x104E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x514F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x9750, 0x2251, 0x3352, 0xED53, 0x2254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x5F55, 0x7356, 0x7F57, 0x2358, =
0x9459,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xD05A, 0x275B, 0x8F5C, =
0x165D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x995E, 0x385F, 0x9960, 0xAA61, 0xFF62,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x4F63, 0x0464, =
0x5165,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-65 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* HT,&nbsp; HA, HBS, HBE, HSS, =
HSE,&nbsp; VT,&nbsp; VA, VBS, VBE, VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; =
920, 800, 800, 120, 816, 64,&nbsp; 750, 600, 600, 150, 606, =
16<BR>+};<BR>+<BR>+static u16 VT1625_P1024x768_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x0300, 0x0001, 0x1002, 0x9A03, =
0x0304,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x0006, 0x8907, 0x6408, 0x0D09,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x880A, 0x000B, 0x550C, 0x5E0D, =
0x000E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x9E0F, 0x0010, 0x8011, 0x2D12, 0x0813,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x2714, 0x2415, 0x8716, 0x5C17, =
0x0618,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x1C19,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x501B, 0x011C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x001F, 0x1D20, 0x1C21, =
0x8922,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7D23, =
0x0224,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xC54A, 0x0F4B, =
0x004C, 0x014D, 0x104E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x514F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xAF50, 0x0251, 0x4452, 0xCE53, 0x0354,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x0F55, 0xA456, 0xBE57, 0x3558, =
0xDC59,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0x3E5A, 0xB55B, 0xDB5C, =
0x595D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xAE5E, 0xCD5F, 0xC760, 0x2861, 0xFF62,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x4F63, 0x0764, =
0x5165,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-65 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /*&nbsp; HT,&nbsp;&nbsp; HA,&nbsp; HBS, =
HBE,&nbsp; HSS, HSE, VT,&nbsp; VA, VBS, VBE, VSS, VSE =
*/<BR>+&nbsp;&nbsp;&nbsp; 1200, 1024, 1024, 176, 1048, 16, 975, 768, =
768, 107, 800, 6<BR>+};<BR>+<BR>+static u16 VT1625_P720x576_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x0300, 0x0001, 0x1002, 0x1F03, =
0x0304,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x0006, 0xC907, 0x4C08, 0x1009,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x7C0A, 0x000B, 0x560C, 0x570D, =
0x030E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0xBF0F, 0x0010, 0x8011, 0x0912, 0x0813,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x1714, 0x2415, 0xCB16, 0x8A17, =
0x0918,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2A19,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x501B, 0x011C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x101F, 0x1420, 0x0C21, =
0x3222,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7E23, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xC54A, 0x0F4B, =
0x004C, 0x014D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x4B4F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xE750, 0xD251, 0x2352, 0xB153, 0x2254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x5F55, 0x6156, 0x7F57, 0x2358, =
0x9059,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xCD5A, 0x355B, 0x835C, =
0x165D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x4F5E, 0x765F, 0x8D60, 0xA961, 0xFF62,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x4F63, 0x0464, =
0x5165,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-65 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* HT,&nbsp;&nbsp; HA, HBS, HBE, HSS, =
HSE, VT,&nbsp; VA, VBS, VBE, VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 1000, =
720, 720, 280, 760, 40, 690, 576, 576, 114, 577, =
3<BR>+};<BR>+<BR>+<BR>+/* Fit Industry TV Screen Mode */<BR>+static u16 =
VT1625_N640x480_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x0300, 0x0001, 0x1002, 0x1F03, =
0x0004,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x0006, 0x5807, 0x3708, 0x0B09,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x7B0A, 0x150B, 0x500C, 0x570D, =
0x070E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0xB00F, 0x0010, 0x8011, 0xF612, 0x2713,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0xCD14, 0x5815, 0xD616, 0x7B17, =
0xF018,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2119,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x501B, 0x011C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x101F, 0x1C20, 0x2A21, =
0xCB22,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7723, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xC54A, 0x0F4B, 0x004C, =
0x014D, 0x104E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x4A4F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xED50, 0x8151, 0x2252, 0x3D53, 0x2254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x5955, 0x9156, 0x7F57, 0x2358, =
0x9059,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xD35A, 0x135B, 0x7A5C, =
0x165D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xF25E, 0xCE5F, 0x8B60, 0x2761, 0xFF62,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x3363, 0x0364, =
0x5165,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-65 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, =
HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; =
750, 640, 640, 110, 648, 16,&nbsp; 574, 480, 480, 94,&nbsp; 490, =
6<BR>+};<BR>+<BR>+static u16 VT1625_N800x600_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; 0x0300, 0x0001, 0x1002, 0x9003, =
0x0004,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x0006, 0x8707, 0x3708, 0xFE09,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x7B0A, 0x150B, 0x500C, 0x570D, =
0x000E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0xB70F, 0x0010, 0x8011, 0x2912, 0x0B13,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x3014, 0x2415, 0xD616, 0x7B17, =
0xF018,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2119,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x501B, 0x011C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x101F, 0x1C20, 0x2A21, =
0xC822,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7723, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xC54A, 0x0F4B, 0x004C, =
0x014D, 0x104E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x4A4F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xAF50, 0x2351, 0x3452, 0xD753, 0x2254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x5955, 0x9156, 0x7F57, 0x2358, =
0x9059,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xD25A, 0x135B, 0x7A5C, =
0x165D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x7E5E, 0xC55F, 0xB160, 0xA961, 0xFF62,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x7F63, 0x0664, =
0x5165,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-65 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, =
HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; =
1200,800, 800, 400, 848, 216, 728, 600, 600, 128, 656, =
9<BR>+};<BR>+<BR>+static u16 VT1625_N1024x768_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; 0x0300, 0x0001, 0x1002, 0x9A03, =
0x0004,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x0006, 0x9707, 0x4008, 0x1009,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x7B0A, 0x150B, 0x500C, 0x570D, =
0x000E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0xB00F, 0x0010, 0x8011, 0xF612, 0x2713,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x0C14, 0x2D15, 0x6D16, 0x0717, =
0x2A18,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x1B19,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x501B, 0x031C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x0C1F, 0x1620, 0xFF21, =
0x1B22,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7723, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xC54A, 0x0F4B, 0x004C, =
0x014D, 0x104E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x4A4F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xAF50, 0x0351, 0x4452, 0xA953, 0x0354,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x2F55, 0x3B56, 0x9F57, 0x3458, =
0xB659,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0x095A, 0x545B, 0x1D5C, =
0x585D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xB15E, 0xEC5F, 0xE460, 0xA961, 0xFF62,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x5F63, 0x0864, =
0x5165,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-65 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, =
HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; =
1200,1024,1024,176, 1032,16,&nbsp; 938, 768, 768, 170, 777, =
9<BR>+};<BR>+<BR>+static u16 VT1625_N720x480_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; 0x0300, 0x0001, 0x1002, 0x1F03, =
0x0004,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x0006, 0x4107, 0x3B08, 0x0B09,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x7B0A, 0x150B, 0x500C, 0x570D, =
0x000E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0xB70F, 0x0010, 0x8011, 0xCD12, 0x2113,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x7314, 0x3415, 0xD616, 0x7B17, =
0xF018,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2119,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x501B, 0x031C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x101F, 0x1C20, 0x0821, =
0xCA22,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7723, =
0x0224,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xC54A, 0x0F4B, 0x004C, =
0x014D, 0x104E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x4A4F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x4750, 0xCF51, 0x2352, 0x3E53, 0x2254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x5955, 0x8B56, 0x7F57, 0x2358, =
0x9159,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xD25A, 0x135B, 0x7A5C, =
0x165D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x305E, 0xD45F, 0x8C60, 0x2861, 0xFF62,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x9763, 0x0364, =
0x5165,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-65 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, =
HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; =
840, 720, 720, 120, 728, 48,&nbsp; 575, 480, 480, 95,&nbsp; 484, =
15<BR>+};<BR>+<BR>+static u16 VT1625_P640x480_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; 0x0300, 0x0001, 0x1002, 0x1F03, =
0x0304,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x0006, 0x5207, 0x3A08, 0x0509,&nbsp;&nbsp;&nbsp;&nbsp; /* =
Tv.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x880A, 0x000B, 0x550C, 0x5E0D, =
0x000E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0xB70F, 0x0010, 0x8011, 0xCC12, 0x2413,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x7314, 0x3015, 0xCB16, 0x8A17, =
0x0918,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2A19,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x501B, 0x011C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x101F, 0x1720, 0x1C21, =
0x3522,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7D23, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xC54A, 0x0F4B, 0x004C, =
0x014D, 0x104E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x514F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xE750, 0x8151, 0x2352, 0x3E53, 0x2254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x5F55, 0x8056, 0x7F57, 0x2358, =
0x9459,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xD15A, 0x275B, 0x8F5C, =
0x165D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xC25E, 0x005F, 0x7560, 0x2061, 0xFF62,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x9763, 0x0364, =
0x5165,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-65 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, =
HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; =
1000,640, 640, 360, 840, 80,&nbsp; 575, 480, 480, 95,&nbsp; 501, =
3<BR>+};<BR>+<BR>+static u16 VT1625_P800x600_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; 0x0300, 0x0001, 0x1002, 0x9003, =
0x0304,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x0006, 0x4807, 0x3708, 0x1309,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x880A, 0x000B, 0x550C, 0x5E0D, =
0x000E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0xB00F, 0x0010, 0x8011, 0xE912, 0x3013,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x9114, 0x2415, 0xCB16, 0x8A17, =
0x0918,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2A19,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x501B, 0x011C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x101F, 0x1720, 0x1C21, =
0x3222,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7D23, =
0x0224,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xC54A, 0x0F4B, 0x004C, =
0x014D, 0x104E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x514F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xE750, 0x2151, 0x3352, 0xD453, 0x2254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x5F55, 0x8756, 0x7F57, 0x2358, =
0x9459,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xD15A, 0x275B, 0x8F5C, =
0x165D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x7A5E, 0xE85F, 0x9460, 0xA961, 0xFF62,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x8763, 0x0464, =
0x5165,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-65 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, =
HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; =
1000,800, 800, 200, 848, 80,&nbsp; 725, 600, 600, 125, 602, =
1<BR>+};<BR>+<BR>+static u16 VT1625_P1024x768_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x0300, 0x0001, 0x1002, 0x9A03, =
0x0304,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x0006, 0x9807, 0x4008, 0x0F09,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x880A, 0x000B, 0x550C, 0x5E0D, =
0x000E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0xB50F, 0x0010, 0x8011, 0xF812, 0x2413,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x0314, 0x3915, 0x7A16, 0xE017, =
0x0E18,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2319,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x501B, 0x011C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x101F, 0x1D20, 0x1C21, =
0xBA22,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7D23, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xC54A, 0x0F4B, 0x004C, =
0x014D, 0x104E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x514F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xAF50, 0x0251, 0x4452, 0x9C53, 0x0354,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x0B55, 0x0756, 0x9857, 0x3458, =
0xB259,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xFB5A, 0x4E5B, 0xF55C, =
0x175D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x705E, 0x945F, 0xBD60, 0xAA61, 0xFF62,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0xEF63, 0x0664, =
0x5165,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-65 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, =
HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; =
1200,1024,1024,176, 1032,16,&nbsp; 925, 768, 768, 157, 778, =
6<BR>+};<BR>+<BR>+static u16 VT1625_P720x576_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; 0x0300, 0x0001, 0x1002, 0x1F03, =
0x0304,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x1006, 0x0307, 0x3908, 0x0609,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x880A, 0x000B, 0x550C, 0x5E0D, =
0x000E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0xB00F, 0x0010, 0x8011, 0x6912, 0x1813,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x4314, 0x2415, 0xCB16, 0x8A17, =
0x0918,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2A19,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x501B, 0x011C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x101F, 0x1720, 0x0C21, =
0x3222,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7D23, =
0x0224,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xC54A, 0x0F4B, 0x004C, =
0x014D, 0x104E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x514F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xE750, 0xCF51, 0x2352, 0x9D53, 0x2254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x5F55, 0x8356, 0x7E57, 0x2358, =
0x9459,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xD05A, 0x275B, 0x8F5C, =
0x165D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x375E, 0xF35F, 0x8960, 0x2861, 0xFF62,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x2F63, 0x0464, =
0x5165,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-65 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, =
HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; =
1000, 720, 720, 280, 736, 16,&nbsp; 670, 576, 576, 94,&nbsp; 586, =
6<BR>+};<BR>+<BR>+/* TV Overscan Table */<BR>+<BR>+static u16 =
VT1625_N640x480_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x0300, 0x0001, 0x1002, 0x1F03, =
0x0004,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x0006, 0x9207, 0x2A08, 0x0109,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x7B0A, 0x150B, 0x500C, 0x570D, =
0x3F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0xB00F, 0x0010, 0x8011, 0xAD12, 0x2113,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x6514, 0x3415, 0x3916, 0x2317, =
0x0A18,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2419,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x501B, 0x031C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x141F, 0x1C20, 0x2A21, =
0xDB22,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7723, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xC54A, 0x0F4B, =
0x004C, 0x014D, 0x104E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x4A4F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x2750, 0x8251, 0x2352, 0x0C53, 0x0254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x2755, 0x8056, 0x7757, 0x2358, =
0x8359,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xC35A, 0xFB5B, 0x115C, =
0x065D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x005E, 0x005F, 0x8060, 0x2061, 0xFF62,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x2763, 0x0364, =
0x5165,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-65 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* HT,&nbsp; HA, HBS, HBE, HSS, HSE, =
VT,&nbsp; VA, VBS, VBE,VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 808, 640, 640, =
168, 688, 24, 525, 480, 480, 45, 490, 6<BR>+};<BR>+<BR>+static u16 =
VT1625_N800x600_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x0300, 0x0001, 0x1002, 0x9003, =
0x0004,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x1006, 0x0107, 0x1E08, 0x0309,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x7B0A, 0x150B, 0x500C, 0x570D, =
0x000E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0xB00F, 0x0010, 0x8011, 0xED12, 0x2113,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0xBC14, 0x3415, 0xD616, 0x7B17, =
0xF018,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2119,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x501B, 0x031C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x101F, 0x1C20, 0x2A21, =
0xCA22,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7723, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xC54A, 0x0F4B, =
0x004C, 0x014D, 0x104E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x4A4F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xAF50, 0x2251, 0x3452, 0x9153, 0x2254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x5955, 0xC656, 0x7F57, 0x2358, =
0x9059,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xD25A, 0xEE5B, 0x7A5C, =
0x065D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x6D5E, 0x065F, 0xA060, 0x2961, 0xFF62,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0xDF63, 0x0564, =
0x5165,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-65 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* HT,&nbsp; HA, HBS, HBE, HSS, HSE, =
VT,&nbsp; VA, VBS, VBE, VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 1200, 800, =
800, 400, 880, 66, 658, 600, 600,&nbsp; 58, 610, =
6<BR>+};<BR>+<BR>+static u16 VT1625_N1024x768_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x0300, 0x0001, 0x1002, 0x9A03, =
0x0004,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x0006, 0x4807, 0x2308, 0x0509,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x7B0A, 0x150B, 0x500C, 0x570D, =
0x000E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0xB00F, 0x0010, 0x8011, 0x2A12, 0x0D13,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x2814, 0x1815, 0xA116, 0x6417, =
0x9318,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x1B19,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x501B, 0x051C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x0C1F, 0x1720, 0xFF21, =
0x3722,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7723, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xC54A, 0x0F4B, =
0x004C, 0x014D, 0x104E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x4A4F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x5F50, 0x0351, 0x4452, 0x3853, 0x0354,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x1F55, 0x6056, 0x9C57, 0x3458, =
0xB359,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0x045A, 0x2D5B, 0x005C, =
0x585D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x245E, 0x7F5F, 0xC960, 0x2961, 0xFF62,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0xDF63, 0x0664, =
0x5165,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-65 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* HT,&nbsp;&nbsp; HA,&nbsp; HBS, HBE, =
HSS, HSE, VT,&nbsp; VA, VBS, VBE, VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; =
1120, 1024, 1024, 96, 1032, 16, 825, 768, 768, 57,&nbsp; 777, =
9<BR>+};<BR>+<BR>+static u16 VT1625_N720x480_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x0300, 0x0001, 0x1002, 0x1F03, =
0x0004,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x0006, 0x0207, 0x1008, 0x0009,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x7B0A, 0x150B, 0x500C, 0x570D, =
0x3F0E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0xB70F, 0x0010, 0x8011, 0xAD12, 0x2113,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x6414, 0x3415, 0xD616, 0x7B17, =
0xF018,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2119,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x501B, 0x011C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x101F, 0x1C20, 0x0821, =
0x0E22,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7723, =
0x0224,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xC54A, 0x0F4B, =
0x004C, 0x014D, 0x104E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x4A4F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x1F50, 0xD251, 0x2352, 0x0C53, 0x2254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x5955, 0xC056, 0x7E57, 0x2358, =
0x8C59,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xD05A, 0xF65B, 0x7C5C, =
0x065D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x005E, 0x345F, 0x8060, 0x2861, 0xFF62,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x1F63, 0x0364, =
0x5165,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-65 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* HT,&nbsp; HA, HBS, HBE, HSS, HSE, =
VT,&nbsp; VA, VBS, VBE, VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 800, 720, =
720, 80,&nbsp; 760, 40, 525, 480, 480, 45,&nbsp; 482, =
3<BR>+};<BR>+<BR>+static u16 VT1625_P640x480_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x0300, 0x0001, 0x1002, 0x1F03, =
0x0304,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x0306, 0x4307, 0x5F08, 0x3109,&nbsp;&nbsp;&nbsp;&nbsp; /* =
Tv.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x880A, 0x000B, 0x550C, 0x5E0D, =
0x000E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0xB70F, 0x0010, 0x8011, 0x0D12, 0x0913,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x1A14, 0x3015, 0xCB16, 0x8A17, =
0x0918,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2A19,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x501B, 0x031C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x101F, 0x1720, 0x1C21, =
0x2D22,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7D23, =
0x0224,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xC54A, 0x0F4B, =
0x004C, 0x014D, 0x104E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x514F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xE750, 0x8751, 0x2352, 0x0753, 0x2254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x5F55, 0xDF56, 0x7F57, 0x2358, =
0x9459,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xD15A, 0x135B, 0x9E5C, =
0x165D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x7F5E, 0x3A5F, 0x6A60, 0x2761, 0xFF62,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x3F63, 0x0364, =
0x5165,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-65 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, =
HSE,&nbsp; VT,&nbsp; VA, VBS, VBE, VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; =
1000, 640, 640, 360, 816, 112, 520, 480, 480, 40,&nbsp; 490, =
6<BR>+};<BR>+<BR>+static u16 VT1625_P800x600_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x0300, 0x0001, 0x1002, 0x9003, =
0x0304,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x0006, 0x4607, 0x0008, 0x3209,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x880A, 0x000B, 0x550C, 0x5E0D, =
0x000E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0xB70F, 0x0010, 0x8011, 0x6C12, 0x1213,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x4114, 0x3015, 0xCB16, 0x8A17, =
0x0918,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2A19,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x501B, 0x031C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x101F, 0x1720, 0x1C21, =
0x3422,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7D23, =
0x0224,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xC54A, 0x0F4B, =
0x004C, 0x014D, 0x104E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x514F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xE750, 0x8751, 0x3352, 0x8953, 0x2254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x5F55, 0xE056, 0x7F57, 0x2358, =
0x9459,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xD15A, 0x055B, 0x855C, =
0x165D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x1E5E, 0x1F5F, 0x8560, 0xA961, 0xFF62,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x0F63, 0x0464, =
0x5165,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-65 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, =
HSE, VT,&nbsp; VA, VBS, VBE, VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 1000, =
800, 800, 200, 872, 56, 650, 600, 600, 50,&nbsp; 608, =
12<BR>+};<BR>+<BR>+static u16 VT1625_P1024x768_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x0300, 0x0001, 0x1002, 0x9A03, =
0x0304,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x1006, 0xCF07, 0x1E08, 0x3709,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x880A, 0x000B, 0x550C, 0x5E0D, =
0x000E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0xB00F, 0x0010, 0x8011, 0xE412, 0x3613,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0xA714, 0x1015, 0xCB16, 0x8A17, =
0x0918,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2A19,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x501B, 0x031C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x101F, 0x1D20, 0x1C21, =
0xEE22,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7D23, =
0x0224,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xC54A, 0x0F4B, =
0x004C, 0x014D, 0x104E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x514F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xCF50, 0x0351, 0x4752, 0x4253, 0x2354,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x5F55, 0xBF56, 0x7F57, 0x2358, =
0x9359,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xD05A, 0x085B, 0xF05C, =
0x165D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x025E, 0xAB5F, 0xAB60, 0xAB61, 0xFF62,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x6F63, 0x0A64, =
0x5165,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-65 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* HT,&nbsp;&nbsp; HA,&nbsp; HBS,&nbsp; =
HBE, HSS, HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, VSS, VSE =
*/<BR>+&nbsp;&nbsp;&nbsp; 2000, 1024, 1024, 976, 1504, 32, 835, 768, =
768, 67,&nbsp; 778, 6<BR>+};<BR>+<BR>+static u16 VT1625_P720x576_VO[] =
=3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x0300, 0x0001, 0x1002, 0x1F03, =
0x0304,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x0006, 0x3907, 0x1908, 0x0109,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x880A, 0x000B, 0x550C, 0x5E0D, =
0x000E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x9E0F, 0x0010, 0x8011, 0x0412, 0x0813,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x0814, 0x1015, 0xCB16, 0x8A17, =
0x0918,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2A19,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x501B, 0x011C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x101F, 0x1720, 0x0C21, =
0x3222,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7D23, =
0x0224,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xC54A, 0x0F4B, =
0x004C, 0x014D, 0x104E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x514F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x5F50, 0xCF51, 0x2352, 0x7053, 0x2254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x5F55, 0xD056, 0x7F57, 0x2358, =
0x9259,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xCE5A, 0x0C5B, 0x8E5C, =
0x165D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x005E, 0x005F, 0x8060, 0x2061, 0xFF62,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x5F63, 0x0364, =
0x5165,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-65 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, =
HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; =
864, 720, 720, 144, 760, 40,&nbsp; 625, 576, 576, 49,&nbsp; 578, =
3<BR>+};<BR>+<BR>+/***********************************/<BR>+/* VT1625 =
output RGB Table&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+/***********************************/<BR>+<BR>+static u16 =
TV_OUT_RGB[] =3D {<BR>+&nbsp;&nbsp;&nbsp; =
0x1202,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* SYNC on G =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x7E23,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Blank Level =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x854A, =
0x0A4B,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* DAC Selection */<BR>+&nbsp;&nbsp;&nbsp; =
0x004E,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* YUV Delay =
Control */<BR>+&nbsp;&nbsp;&nbsp; 0x5565, 0x3766, =
0x5C67,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; 0xffff<BR>+};<BR>+<BR>+static u16 =
HDTV_OUT_RGB[] =3D {<BR>+&nbsp;&nbsp;&nbsp; =
0x1202,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* output =
SDTV_RGB type */<BR>+&nbsp;&nbsp;&nbsp; 0x854A, =
0x0A4B,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* DAC Selection */<BR>+&nbsp;&nbsp;&nbsp; 0x5565, 0x3966, =
0x6667,&nbsp;&nbsp;&nbsp;&nbsp; /* adjust SDTV_RGB Amplitude factor =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF<BR>+};<BR>+<BR>+/***********************************/<BR>+/* =
VT1625 output YPBPR Table&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+/***********************************/<BR>+<BR>+static u16 =
TV_OUT_YPBPR[] =3D {<BR>+&nbsp;&nbsp;&nbsp; 0x7E23, =
0x004E,<BR>+&nbsp;&nbsp;&nbsp; 0x5565, 0x5466, =
0x5667,<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+unsigned short HDTV_OUT_YPBPR[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 0x5565, 0x5666, 0x5567,&nbsp;&nbsp;&nbsp;&nbsp; =
/* adjust YPbPr Amplitude factor */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF<BR>+};<BR>+<BR>+/***********************************/<BR>+/* =
VT1625 output SDTV_RGB Table&nbsp;&nbsp;&nbsp; =
*/<BR>+/***********************************/<BR>+<BR>+/* NTSC =
*/<BR>+<BR>+static u16 VT1625_N640x480_SDTV_RGB_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x4003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Filter =
Selection&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x1004,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Output =
Mode&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x2807,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Start Active =
Video&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x4708, =
0x1509,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's =
Position&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x000B,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Blanking Level set to =
zero&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x001C,<BR>+&nbsp;&nbsp;&nbsp; 0x8351, =
0x8356,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV =
Timing&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x0062,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Adaptive Deflicker =
Disable&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; /* End =
symbol&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+};<BR>+<BR>+static u16 VT1625_N800x600_SDTV_RGB_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xC003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Filter =
Selection&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x1004,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Output =
Mode&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x5607,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Start Active =
Video&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x4B08, =
0x1409,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's =
Position&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x000B,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Blanking Level set to =
zero&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x001C,<BR>+&nbsp;&nbsp;&nbsp; =
0x011F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Filter =
Switch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x2F20,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* TV Sync =
step&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x2551, =
0x7D56,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV =
Timing&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x0062,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Adaptive Deflicker =
Disable&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; /* End =
symbol&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+};<BR>+<BR>+static u16 VT1625_N1024x768_SDTV_RGB_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xC003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Filter =
Selection&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x1004,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Output =
Mode&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x0F07,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Start Active =
Video&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x8008, =
0x1409,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's =
Position&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x000B,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Blanking Level set to =
zero&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x001C,<BR>+&nbsp;&nbsp;&nbsp; =
0x011F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Filter =
Switch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x2520,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* TV Sync =
step&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0451, =
0xA756,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV =
Timing&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x0062,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Adaptive Deflicker =
Disable&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; /* End =
symbol&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+};<BR>+<BR>+static u16 VT1625_N720x480_SDTV_RGB_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x4003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Filter =
Selection&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x1004,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Output =
Mode&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x1409,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* adjust TV's =
Position&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x000B,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Blanking Level set to =
zero&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x001C,<BR>+&nbsp;&nbsp;&nbsp; =
0x011F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Filter =
Switch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x2F20,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* TV Sync =
step&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x0062,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Adaptive Deflicker =
Disable&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; /* End =
symbol&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+};<BR>+<BR>+static u16 VT1625_N640x480_SDTV_RGB_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x4003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Filter =
Selection&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x1004,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Output =
Mode&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x5607,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Start Active =
Video&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x3808,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* adjust TV's =
Position&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x000B,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Blanking Level set to =
zero&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x011F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Filter =
Switch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x8451,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* TV =
Timing&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0254, 0x3355, 0x7956, 0x7957,&nbsp; /* TV =
Timing&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x8559, 0xCA5A, =
0x075B,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV =
Timing&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x325C, 0x165D, 0xF25E, 0x225F,&nbsp; /* TV =
Timing&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x8B60, =
0x2861,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
Scaling&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x0062,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Adaptive Deflicker =
Disable&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; /* End =
symbol&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+};<BR>+<BR>+static u16 VT1625_N800x600_SDTV_RGB_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xC003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Filter =
Selection&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x1004,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Output =
Mode&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x8607,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Start Active =
Video&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x3F08, =
0xFC09,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's =
Position&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x000B,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Blanking Level set to =
zero&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x021C,<BR>+&nbsp;&nbsp;&nbsp; =
0x2F20,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* TV Sync =
step&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x0062,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Adaptive Deflicker =
Disable&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; /* End =
symbol&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+};<BR>+<BR>+static u16 =
VT1625_N1024x768_SDTV_RGB_VF[]=3D{<BR>+&nbsp;&nbsp;&nbsp; =
0xC003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Filter =
Selection&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x1004,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Output =
Mode&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x9607,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Start Active =
Video&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x4608, =
0x0D09,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's =
Position&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x000B,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Blanking Level set to =
zero&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x001C,<BR>+&nbsp;&nbsp;&nbsp; =
0x011F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Filter =
Switch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x2520,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* TV Sync =
step&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0551, =
0x3D56,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV =
Timing&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x0062,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Adaptive Deflicker =
Disable&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; /* End =
symbol&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+};<BR>+<BR>+static u16 VT1625_N720x480_SDTV_RGB_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x4003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Filter =
Selection&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x1004,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Output =
Mode&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x4308, =
0x0709,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's =
Position&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x000B,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Blanking Level set to =
zero&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x001C,<BR>+&nbsp;&nbsp;&nbsp; =
0x011F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Filter =
Switch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x2F20,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* TV Sync =
step&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x0062,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Adaptive Deflicker =
Disable&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; /* End =
symbol&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+};<BR>+<BR>+static u16 VT1625_N640x480_SDTV_RGB_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x4003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Filter =
Selection&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x1004,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Output =
Mode&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x8407,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Start Active =
Video&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x1D08,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* adjust TV's =
Position&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x000B,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Blanking Level set to =
zero&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x041C, <BR>+&nbsp;&nbsp;&nbsp; =
0x011F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Filter =
Switch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x8351,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* TV =
Timing&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0254, 0x1B55, 0x8356, 0x7557,&nbsp; /* TV =
Timing&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x8159, 0xC45A, =
0x005B,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV =
Timing&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x045C, =
0x005F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV =
Timing&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x2061,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* =
Scaling&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x0062,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Adaptive Deflicker =
Disable&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; /* End =
symbol&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+};<BR>+<BR>+static u16 VT1625_N800x600_SDTV_RGB_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xC003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Filter =
Selection&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x1004,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Output =
Mode&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0006, =
0xFB07,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Start Active =
Video&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x2208, =
0x0409,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's =
Position&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x000B,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Blanking Level set to =
zero&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x041C,<BR>+&nbsp;&nbsp;&nbsp; =
0x011F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Filter =
Switch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x2920,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* TV Sync =
step&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x2751, 0xCB56, =
0xEB5B,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV =
Timing&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x0062,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Adaptive Deflicker =
Disable&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; /* End =
symbol&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+};<BR>+<BR>+static u16 VT1625_N1024x768_SDTV_RGB_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xC003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Filter =
Selection&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x1004,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Output =
Mode&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x4707,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Start Active =
Video&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x2908, =
0x0009,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's =
Position&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x000B,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Blanking Level set to =
zero&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x041C, <BR>+&nbsp;&nbsp;&nbsp; =
0x011F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Filter =
Switch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x2820,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* TV Sync =
step&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0551, =
0x6156,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV =
Timing&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x0062,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Adaptive Deflicker =
Disable&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; /* End =
symbol&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+};<BR>+<BR>+static u16 VT1625_N720x480_SDTV_RGB_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x4003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Filter =
Selection&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x1004,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Output =
Mode&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x2008, =
0x0009,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's =
Position&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x000B,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Blanking Level set to =
zero&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x001C,<BR>+&nbsp;&nbsp;&nbsp; =
0x011F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Filter =
Switch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x2F20,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* TV Sync =
step&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x0062,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Adaptive Deflicker =
Disable&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; /* End =
symbol&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+};<BR>+<BR>+<BR>+/* PAL */<BR>+<BR>+static u16 =
VT1625_P640x480_SDTV_RGB_VN[] =3D {<BR>+&nbsp;&nbsp;&nbsp; =
0x4003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Filter =
Selection&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x1304,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Output =
Mode&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xF007,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Start Active =
Video&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x4E08, =
0x1409,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's =
Position&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x001C, <BR>+&nbsp;&nbsp;&nbsp; =
0x011F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Filter =
Switch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x1C20,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* TV Sync =
step&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x8351, =
0x7156,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV =
Timing&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x0062,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Adaptive Deflicker =
Disable&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; /* End =
symbol&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+};<BR>+<BR>+static u16 VT1625_P800x600_SDTV_RGB_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x4003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Filter =
Selection&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x1304,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Output =
Mode&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x2607,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Start Active =
Video&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x4A08, =
0x1909,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's =
Position&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x001C,<BR>+&nbsp;&nbsp;&nbsp; =
0x011F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Filter =
Switch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x1C20,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* TV Sync =
step&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x2551, =
0x7556,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV =
Timing&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x0062,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Adaptive Deflicker =
Disable&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; /* End =
symbol&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+};<BR>+<BR>+static u16 VT1625_P1024x768_SDTV_RGB_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xC003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Filter =
Selection&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x1304,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Output =
Mode&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x8707,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Start Active =
Video&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x6C08, =
0x1909,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's =
Position&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x001C, <BR>+&nbsp;&nbsp;&nbsp; =
0x011F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Filter =
Switch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x1C20,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* TV Sync =
step&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0451, =
0xA556,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV =
Timing&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x0062,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Adaptive Deflicker =
Disable&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; /* End =
symbol&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+};<BR>+<BR>+static u16 VT1625_P720x576_SDTV_RGB_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x4003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Filter =
Selection&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x1304,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Output =
Mode&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x4D08, =
0x1B09,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's =
Position&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x001C,<BR>+&nbsp;&nbsp;&nbsp; =
0x011F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Filter =
Switch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x1C20,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* TV Sync =
step&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x0062,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Adaptive Deflicker =
Disable&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; /* End =
symbol&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+};<BR>+<BR>+static u16 VT1625_P640x480_SDTV_RGB_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x4003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Filter =
Selection&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x1304,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Output =
Mode&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x5007, 0x4308, =
0x0A09,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* adjust =
TV's =
Position&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x001C,<BR>+&nbsp;&nbsp;&nbsp; =
0x011F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Filter =
Switch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x1C20,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* TV Sync =
step&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x8351, =
0x8356,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV =
Timing&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x0062,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Adaptive Deflicker =
Disable&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; /* End =
symbol&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+};<BR>+<BR>+static u16 VT1625_P800x600_SDTV_RGB_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xC003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Filter =
Selection&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x1304,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Output =
Mode&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x4607,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Start Active =
Video&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x4108, =
0x2409,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's =
Position&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x0810,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Hue =
Adjustment&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x001C,<BR>+&nbsp;&nbsp;&nbsp; =
0x011F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Filter =
Switch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x1C20,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* TV Sync =
step&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x2451, =
0x8956,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV =
Timing&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x0062,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Adaptive Deflicker =
Disable&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; /* End =
symbol&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+};<BR>+<BR>+static u16 VT1625_P1024x768_SDTV_RGB_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xC003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Filter =
Selection&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x1304,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Output =
Mode&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x9507,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Start Active =
Video&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x4B08, =
0x1A09,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's =
Position&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x001C,<BR>+&nbsp;&nbsp;&nbsp; =
0x001F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Filter =
Switch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0451, =
0x0956,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV =
Timing&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x0062,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Adaptive Deflicker =
Disable&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; /* End =
symbol&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+<BR>+};<BR>+<BR>+static u16 VT1625_P720x576_SDTV_RGB_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x4003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Filter =
Selection&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x1304,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Output =
Mode&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x4308, =
0x0D09,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's =
Position&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x001C,<BR>+&nbsp;&nbsp;&nbsp; =
0x011F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Filter =
Switch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x1C20,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* TV Sync =
step&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x0062,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Adaptive Deflicker =
Disable&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; /* End =
symbol&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+};<BR>+<BR>+static u16 VT1625_P640x480_SDTV_RGB_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x4003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Filter =
Selection&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x1304,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Output =
Mode&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x4807,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Start Active =
Video&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x6409,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* adjust TV's =
Position&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x041C,&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; =
0x011F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Filter =
Switch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0254, 0xFF55, 0x9C56, 0x7057,&nbsp; /* TV =
Timing&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x2258, 0x8359, 0xB95A, 0xD35B,&nbsp; /* TV =
Timing&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0xD45C, 0x055D, 0x7E5E, 0x005F,&nbsp; /* TV =
Timing&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x2061,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* =
Scaling&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x0062,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Adaptive Deflicker =
Disable&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; /* End =
symbol&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+};<BR>+<BR>+static u16 VT1625_P800x600_SDTV_RGB_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xC003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Filter =
Selection&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x1304,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Output =
Mode&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x6509,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* adjust TV's =
Position&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x041C, <BR>+&nbsp;&nbsp;&nbsp; =
0x011F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Filter =
Switch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x1C20,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* TV Sync =
step&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x0062,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Adaptive Deflicker =
Disable&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; /* End =
symbol&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+};<BR>+<BR>+static u16 VT1625_P1024x768_SDTV_RGB_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0xC003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Filter =
Selection&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x1304,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Output =
Mode&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0xCC07,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Start Active =
Video&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x2408, =
0x6E09,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* adjust TV's =
Position&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x041C,<BR>+&nbsp;&nbsp;&nbsp; =
0x011F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Filter =
Switch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0651, =
0xC156,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV =
Timing&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x0062,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Adaptive Deflicker =
Disable&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; /* End =
symbol&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+};<BR>+<BR>+static u16 VT1625_P720x576_SDTV_RGB_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; =
0x4003,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Filter =
Selection&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0x1304,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Output =
Mode&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x0309,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* adjust TV's =
Position&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; 0x001C,<BR>+&nbsp;&nbsp;&nbsp; =
0x011F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Filter =
Switch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x1C20,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* TV Sync =
step&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x0062,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Adaptive Deflicker =
Disable&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; /* End =
symbol&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+};<BR>+<BR>+/***********************************/<BR>+/* VT1625 =
DeDotCrawl Table&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<BR>+/***********************************/<BR>+<BR>+/* NTSC =
*/<BR>+<BR>+static u16 VT1625_N640x480_DeDotCrawl_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 0xBE16, =
0x8717,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* adjust TV FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1625_N800x600_DeDotCrawl_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 0x1216, =
0x4917,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* adjust TV FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1625_N1024x768_DeDotCrawl_VN[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; 0x1816, =
0x6117,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* adjust TV FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1625_N720x480_DeDotCrawl_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 0xC316, =
0x4C17,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* adjust TV FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1625_N640x480_DeDotCrawl_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 0x5016, =
0x7B17,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* adjust TV FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1625_N800x600_DeDotCrawl_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 0xD116, =
0xF617,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* adjust TV FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1625_N1024x768_DeDotCrawl_VF[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; 0x0616, =
0x8417,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* adjust TV FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1625_N720x480_DeDotCrawl_VF[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 0xE816, =
0xEB17,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* adjust TV FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1625_N640x480_DeDotCrawl_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 0xE516, =
0xA017,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* adjust TV FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1625_N800x600_DeDotCrawl_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 0xA116, =
0x5917,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* adjust TV FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1625_N1024x768_DeDotCrawl_VO[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; 0x1116, =
0xE217,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* adjust TV FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1625_N720x480_DeDotCrawl_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 0x1E16, =
0x5C17,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* adjust TV FSCI */<BR>+&nbsp;&nbsp;&nbsp; =
0xFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* End =
symbol */<BR>+};<BR>+<BR>+static u16 VT1625_NULL_FUNC[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 0xFFFF<BR>+};<BR>+<BR>+static vt1625_func_table =
vt1625_ntsc_640x480_tbl[] =3D {<BR>+&nbsp;&nbsp;&nbsp; =
{TV_BASE_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_N640x480_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; =
VT1625_N640x480_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; VT1625_N640x480_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUT_RGB,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUT_RGB,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUT_RGB},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_YPBPR_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUT_YPBPR,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUT_YPBPR,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUT_YPBPR},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_N640x480_SDTV_RGB_VN,&nbsp;&nbsp;&nbsp; =
VT1625_N640x480_SDTV_RGB_VF,&nbsp;&nbsp;&nbsp; =
VT1625_N640x480_SDTV_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_YPBPR_FUNC,&nbsp;&nbsp; =
VT1625_N640x480_SDTV_RGB_VN,&nbsp;&nbsp;&nbsp; =
VT1625_N640x480_SDTV_RGB_VF,&nbsp;&nbsp;&nbsp; =
VT1625_N640x480_SDTV_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_DeDotCrawl_FUNC,&nbsp;&nbsp; VT1625_N640x480_DeDotCrawl_VN,&nbsp; =
VT1625_N640x480_DeDotCrawl_VF,&nbsp; =
VT1625_N640x480_DeDotCrawl_VO}<BR>+};<BR>+<BR>+static vt1625_func_table =
vt1625_ntsc_800x600_tbl[] =3D {<BR>+&nbsp;&nbsp;&nbsp; =
{TV_BASE_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_N800x600_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; =
VT1625_N800x600_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; VT1625_N800x600_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUT_RGB,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUT_RGB,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUT_RGB},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_YPBPR_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUT_YPBPR,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUT_YPBPR,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUT_YPBPR},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_N800x600_SDTV_RGB_VN,&nbsp;&nbsp;&nbsp; =
VT1625_N800x600_SDTV_RGB_VF,&nbsp;&nbsp;&nbsp; =
VT1625_N800x600_SDTV_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_YPBPR_FUNC,&nbsp;&nbsp; =
VT1625_N800x600_SDTV_RGB_VN,&nbsp;&nbsp;&nbsp; =
VT1625_N800x600_SDTV_RGB_VF,&nbsp;&nbsp;&nbsp; =
VT1625_N800x600_SDTV_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_DeDotCrawl_FUNC,&nbsp;&nbsp; VT1625_N800x600_DeDotCrawl_VN,&nbsp; =
VT1625_N800x600_DeDotCrawl_VF,&nbsp; =
VT1625_N800x600_DeDotCrawl_VO}<BR>+};<BR>+<BR>+static vt1625_func_table =
vt1625_ntsc_1024x768_tbl[]=3D {<BR>+&nbsp;&nbsp;&nbsp; =
{TV_BASE_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_N1024x768_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; =
VT1625_N1024x768_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; VT1625_N1024x768_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUT_RGB,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUT_RGB,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUT_RGB},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_YPBPR_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUT_YPBPR,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUT_YPBPR,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUT_YPBPR},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_N1024x768_SDTV_RGB_VN,&nbsp;&nbsp; =
VT1625_N1024x768_SDTV_RGB_VF,&nbsp;&nbsp; =
VT1625_N1024x768_SDTV_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_YPBPR_FUNC,&nbsp;&nbsp; =
VT1625_N1024x768_SDTV_RGB_VN,&nbsp;&nbsp; =
VT1625_N1024x768_SDTV_RGB_VF,&nbsp;&nbsp; =
VT1625_N1024x768_SDTV_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_DeDotCrawl_FUNC,&nbsp;&nbsp; VT1625_N1024x768_DeDotCrawl_VN, =
VT1625_N1024x768_DeDotCrawl_VF, =
VT1625_N1024x768_DeDotCrawl_VO}<BR>+};<BR>+<BR>+static vt1625_func_table =
vt1625_ntsc_720x480_tbl[] =3D {<BR>+&nbsp;&nbsp;&nbsp; =
{TV_BASE_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_N720x480_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; =
VT1625_N720x480_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; VT1625_N720x480_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUT_RGB,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUT_RGB,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUT_RGB},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_YPBPR_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUT_YPBPR,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUT_YPBPR,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUT_YPBPR},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_N720x480_SDTV_RGB_VN,&nbsp;&nbsp;&nbsp; =
VT1625_N720x480_SDTV_RGB_VF,&nbsp;&nbsp;&nbsp; =
VT1625_N720x480_SDTV_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_YPBPR_FUNC,&nbsp;&nbsp; =
VT1625_N720x480_SDTV_RGB_VN,&nbsp;&nbsp;&nbsp; =
VT1625_N720x480_SDTV_RGB_VF,&nbsp;&nbsp;&nbsp; =
VT1625_N720x480_SDTV_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_DeDotCrawl_FUNC,&nbsp;&nbsp; VT1625_N720x480_DeDotCrawl_VN,&nbsp; =
VT1625_N720x480_DeDotCrawl_VF,&nbsp; =
VT1625_N720x480_DeDotCrawl_VO}<BR>+};<BR>+<BR>+static vt1625_func_table =
vt1625_pal_640x480_tbl[] =3D {<BR>+&nbsp;&nbsp;&nbsp; =
{TV_BASE_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_P640x480_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; =
VT1625_P640x480_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; VT1625_P640x480_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUT_RGB,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUT_RGB,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUT_RGB},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_YPBPR_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUT_YPBPR,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUT_YPBPR,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUT_YPBPR},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_P640x480_SDTV_RGB_VN,&nbsp;&nbsp;&nbsp; =
VT1625_P640x480_SDTV_RGB_VF,&nbsp;&nbsp;&nbsp; =
VT1625_P640x480_SDTV_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_YPBPR_FUNC,&nbsp;&nbsp; =
VT1625_P640x480_SDTV_RGB_VN,&nbsp;&nbsp;&nbsp; =
VT1625_P640x480_SDTV_RGB_VF,&nbsp;&nbsp;&nbsp; =
VT1625_P640x480_SDTV_RGB_VO}<BR>+};<BR>+<BR>+static vt1625_func_table =
vt1625_pal_800x600_tbl[] =3D {<BR>+&nbsp;&nbsp;&nbsp; =
{TV_BASE_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_P800x600_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; =
VT1625_P800x600_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; VT1625_P800x600_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUT_RGB,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUT_RGB,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUT_RGB},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_YPBPR_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUT_YPBPR,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUT_YPBPR,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUT_YPBPR},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_P800x600_SDTV_RGB_VN,&nbsp;&nbsp;&nbsp; =
VT1625_P800x600_SDTV_RGB_VF,&nbsp;&nbsp;&nbsp; =
VT1625_P800x600_SDTV_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_YPBPR_FUNC,&nbsp;&nbsp; =
VT1625_P800x600_SDTV_RGB_VN,&nbsp;&nbsp;&nbsp; =
VT1625_P800x600_SDTV_RGB_VF,&nbsp;&nbsp;&nbsp; =
VT1625_P800x600_SDTV_RGB_VO}<BR>+};<BR>+<BR>+static vt1625_func_table =
vt1625_pal_1024x768_tbl[] =3D {<BR>+&nbsp;&nbsp;&nbsp; =
{TV_BASE_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_P1024x768_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; =
VT1625_P1024x768_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; VT1625_P1024x768_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUT_RGB,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUT_RGB,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUT_RGB},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_YPBPR_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUT_YPBPR,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUT_YPBPR,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUT_YPBPR},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_P1024x768_SDTV_RGB_VN,&nbsp;&nbsp; =
VT1625_P1024x768_SDTV_RGB_VF,&nbsp;&nbsp; =
VT1625_P1024x768_SDTV_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_YPBPR_FUNC,&nbsp;&nbsp; =
VT1625_P1024x768_SDTV_RGB_VN,&nbsp;&nbsp; =
VT1625_P1024x768_SDTV_RGB_VF,&nbsp;&nbsp; =
VT1625_P1024x768_SDTV_RGB_VO}<BR>+};<BR>+<BR>+static vt1625_func_table =
vt1625_pal_720x576_tbl[] =3D {<BR>+&nbsp;&nbsp;&nbsp; =
{TV_BASE_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_P720x576_VN,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; =
VT1625_P720x576_VF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; VT1625_P720x576_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUT_RGB,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUT_RGB,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUT_RGB},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_YPBPR_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUT_YPBPR,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUT_YPBPR,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TV_OUT_YPBPR},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_P720x576_SDTV_RGB_VN,&nbsp;&nbsp;&nbsp; =
VT1625_P720x576_SDTV_RGB_VF,&nbsp;&nbsp;&nbsp; =
VT1625_P720x576_SDTV_RGB_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_YPBPR_FUNC,&nbsp;&nbsp; =
VT1625_P720x576_SDTV_RGB_VN,&nbsp;&nbsp;&nbsp; =
VT1625_P720x576_SDTV_RGB_VF,&nbsp;&nbsp;&nbsp; =
VT1625_P720x576_SDTV_RGB_VO}<BR>+};<BR>+<BR>+<BR>+/* 720P Under Scan =
*/<BR>+static u16 VT1625_HDTV_720P_640x480_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; <BR>+&nbsp;&nbsp;&nbsp; 0x0300, 0x0001, 0x1002, 0x4003, =
0x9404,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x0006, 0x5007, 0x5608, 0x2209,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x000A, 0x000B, 0x000C, 0x000D, =
0x000E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0xB00F, 0x0010, 0x8011, 0xAC12, 0x1913,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x6D14, 0x3015, 0x0016, 0x0017, =
0x0018,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0019,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x501B, 0x001C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x031F, 0x4220, 0x0021, =
0x0022,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7823, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xC54A, 0x0F4B, =
0x004C, 0x014D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x004F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xAF50, 0x8251, 0x2452, 0x2053, 0x1254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x6755, 0x6B56, 0x2A57, 0x2358, =
0x9E59,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0x455A, 0xA05B, 0x455C, =
0x435D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x035E, 0x4B5F, 0x5D60, 0x2861, 0x0062,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x6763, 0x1364, =
0x5165,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-65 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* HT,&nbsp; HA, HBS, HBE, HSS, =
HSE,&nbsp; VT,&nbsp; VA, VBS, VBE, VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; =
1200, 640, 640, 560, 1040, 80,&nbsp; 545, 480, 480, 65, 481, =
2<BR>+};<BR>+<BR>+static u16 VT1625_HDTV_720P_800x600_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; <BR>+&nbsp;&nbsp;&nbsp; 0x0300, 0x0001, 0x1002, 0x4003, =
0x9404,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x0006, 0x2807, 0x6508, 0x1109,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x000A, 0x000B, 0x000C, 0x000D, =
0x000E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0xB00F, 0x0010, 0x8011, 0xA912, 0x1913,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x6614, 0x2415, 0x0016, 0x0017, =
0x0018,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0019,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x501B, 0x011C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x031F, 0x4220, 0x0021, =
0x0022,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7823, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xC54A, 0x0F4B, =
0x004C, 0x014D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x004F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xAF50, 0x2351, 0x3452, 0xA753, 0x1254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x3F55, 0x0756, 0x3457, 0x3458, =
0xC559,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0x115A, 0xC85B, 0x145C, =
0x045D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x0D5E, 0x4C5F, 0x7460, 0x2861, 0x0062,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x3F63, 0x2464, =
0x5165,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-65 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* HT,&nbsp; HA, HBS, HBE, HSS, =
HSE,&nbsp; VT,&nbsp; VA, VBS, VBE, VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; =
1200, 800, 800, 400, 1120, 40, 680, 600, 600, 80, 610, =
6<BR>+};<BR>+<BR>+static u16 VT1625_HDTV_720P_1024x768_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; <BR>+&nbsp;&nbsp;&nbsp; 0x8300, 0x0001, 0x1002, 0x4003, =
0x9404,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x1F05, 0x1006, 0x9307, 0x8008, 0x1E09,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x000A, 0x000B, 0x000C, 0x000D, =
0x000E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x9E0F, 0x0010, 0x8011, 0x6612, 0x1913,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x5814, 0x1015, 0x0016, 0x0017, =
0x0018,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0019,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x501B, 0x001C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x031F, 0x2520, 0x0021, =
0x0022,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7E23, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xC54A, 0x0F4B, =
0x004C, 0x014D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x004F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x0750, 0x0251, 0x4752, 0x6F53, 0x1354,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x7F55, 0xE356, 0x4457, 0x3558, =
0x0059,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0x435A, 0x035B, 0x475C, =
0xD55D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x2F5E, 0x395F, 0x9660, 0x2861, 0x0062,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x3F63, 0x2864, =
0x5165,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-65 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* HT,&nbsp;&nbsp; HA,&nbsp; HBS, =
HBE,&nbsp; HSS, HSE,&nbsp; VT,&nbsp; VA, VBS, VBE, VSS, VSE =
*/<BR>+&nbsp;&nbsp;&nbsp; 1800, 1024, 1024, 776, 1360,&nbsp; 40, 880, =
768, 768, 112, 770, 8<BR>+};<BR>+<BR>+static u16 =
VT1625_HDTV_720P_720x480_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x0300, 0x0001, 0x1002, 0x4003, =
0x9404,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x0006, 0x0807, 0x6408, 0x2409,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x000A, 0x000B, 0x000C, 0x000D, =
0x000E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0xB00F, 0x0010, 0x8011, 0xEB12, 0x3213,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0xE714, 0x3815, 0x0016, 0x0017, =
0x0018,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0019,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x501B, 0x011C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x031F, 0x4220, 0x0021, =
0x0022,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7823, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xC54A, 0x0F4B, =
0x004C, 0x014D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x004F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x3750, 0xD251, 0x2452, 0x2553, 0x1254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0xEF55, 0xC756, 0x3057, 0x2358, =
0xB759,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xC75A, 0xB95B, 0xC75C, =
0x435D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xDD5E, 0x205F, 0x5D60, 0x2861, 0x0062,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x1763, 0x1364, =
0x5165,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-65 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* HT,&nbsp; HA, HBS, HBE, HSS, =
HSE,&nbsp; VT,&nbsp; VA, VBS, VBE, VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; =
1080, 720, 720, 360, 1040, 32,&nbsp; 550, 480, 480, 70, 482, =
2<BR>+};<BR>+<BR>+static u16 VT1625_HDTV_720P_720x576_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x0300, 0x0001, 0x1002, 0x4003, =
0x9404,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x0006, 0x0E07, 0x4408, 0x0409,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x000A, 0x000B, 0x000C, 0x000D, =
0x000E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x9E0F, 0x0010, 0x8011, 0x8812, 0x1E13,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x6114, 0x2815, 0x0016, 0x0017, =
0x0018,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0019,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x501B, 0x001C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x031F, 0x2520, 0x0021, =
0x0022,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7E23, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xC54A, 0x0F4B, =
0x004C, 0x014D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x004F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xC950, 0xD151, 0x2352, 0x5753, 0x1254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0xC955, 0xD156, 0x3057, 0x2358, =
0xB259,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xA35A, 0xB75B, 0x895C, =
0x435D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x665E, 0x005F, 0x6660, 0x2061, 0x0062,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x0763, 0x1364, =
0x5165,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-65 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* HT,&nbsp; HA, HBS, HBE, HSS, =
HSE,&nbsp; VT,&nbsp; VA, VBS, VBE, VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; =
970, 720, 720, 250, 928,&nbsp; 28, 600, 576, 576,&nbsp; 24, 577, =
3<BR>+};<BR>+<BR>+static u16 VT1625_HDTV_720P_1280x720_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<BR>+&nbsp;&nbsp;&nbsp; 0x8300, 0x0001, 0x1002, 0x4003, =
0x9404,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0005, 0x1006, 0x3307, 0x4A08, 0x0109,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x000A, 0x000B, 0x000C, 0x000D, =
0x000E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0xB00F, 0x0010, 0x8011, 0xA512, 0x1E13,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0x6714, 0x1415, 0x0016, 0x0017, =
0x0018,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0019,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x501B, 0x001C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x031F, 0x4220, 0x0021, =
0x0022,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7823, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xC54A, 0x0F4B, =
0x004C, 0x014D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x004F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x6F50, 0xFF51, 0x4652, 0xED53, 0x1254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x6F55, 0xFF56, 0x5057, 0x4658, =
0x2E59,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0x275A, 0x275B, 0x275C, =
0x965D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x005E, 0x005F, 0x8060, 0x2861, 0x0062,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x6F63, 0x3664, =
0x5165,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-65 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* HT,&nbsp;&nbsp; HA,&nbsp; HBS, =
HBE,&nbsp; HSS, HSE, VT,&nbsp; VA, VBS, VBE,VSS, VSE =
*/<BR>+&nbsp;&nbsp;&nbsp; 1648, 1280, 1280, 368, 1296, 48, 750, 720, =
720, 30, 720, 5<BR>+};<BR>+<BR>+/* 1080I Under Scan */<BR>+static u16 =
VT1625_HDTV_1080I_640x480_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
Non-Macrovision Registers */<BR>+&nbsp;&nbsp;&nbsp; 0x0300, 0x0001, =
0x1002, 0x4F03, 0x8604,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0005, 0x0006, 0x2A07, 0x3908, =
0x1209,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; =
0x000A, 0x000B, 0x000C, 0x000D, 0x000E,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; 0x9E0F, 0x0010, 0x8011, 0x8812, =
0x1913,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; =
0x6314, 0x2415, 0x0016, 0x0017, 0x0018,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0019,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x501B, 0x001C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x031F, 0x2520, 0x0021, =
0x0022,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7E23, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xC54A, 0x0F4B, =
0x004C, 0x014D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x004F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x9F50, 0x8251, 0x2552, 0x2553, 0x1254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x1755, 0x7356, 0x4057, 0x2358, =
0x7E59,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xF85A, 0xA95B, 0x105C, =
0x065D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x935E, 0x2A5F, 0x3E60, 0x2861, 0xFF62,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0xBF63, 0x1264, =
0x5165,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-65 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* HT,&nbsp; HA, HBS, HBE,&nbsp; HSS, =
HSE,&nbsp; VT,&nbsp; VA, VBS, VBE, VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; =
1440, 640, 640, 800, 1360, 40,&nbsp; 550, 480, 480, 70,&nbsp; 485, =
6<BR>+};<BR>+<BR>+static u16 VT1625_HDTV_1080I_800x600_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
Non-Macrovision Registers */<BR>+&nbsp;&nbsp;&nbsp; 0x0300, 0x0001, =
0x1002, 0x4F03, 0x8604,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x2005, 0x0006, 0x7A07, 0x8608, =
0x1B09,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; =
0x000A, 0x000B, 0x000C, 0x000D, 0x000E,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; 0x9E0F, 0x0010, 0x8011, 0x6612, =
0x1413,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; =
0x4514, 0x1415, 0x0016, 0x0017, 0x0018,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0019,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x501B, 0x001C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x031F, 0x2520, 0x0021, =
0x0022,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7E23, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xC54A, 0x0F4B, =
0x004C, 0x014D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x004F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x0750, 0x2251, 0x3752, 0xB153, 0x1254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x2F55, 0xAD56, 0x4A57, 0x5758, =
0x9259,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0x735A, 0xC55B, 0x0B5C, =
0x475D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x815E, 0xD15F, 0x4E60, 0x2861, 0xFF62,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x4F63, 0x1464, =
0x5165,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-65 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* HT,&nbsp; HA, HBS, HBE,&nbsp; HSS, =
HSE, VT,&nbsp; VA, VBS, VBE, VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 1800, =
800, 800, 1000, 1600, 80, 690, 600, 600, 90, 605, =
6<BR>+};<BR>+<BR>+static u16 VT1625_HDTV_1080I_1024x768_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 0x0300, 0x0001, 0x1002, 0x4F03, =
0x8604,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 */<BR>+&nbsp;&nbsp;&nbsp; =
0x3A05, 0x0006, 0x0207, 0xA008, 0x0609,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; 0x000A, 0x000B, 0x000C, 0x000D, =
0x000E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; =
0x9E0F, 0x0010, 0x8011, 0xE612, 0x2813,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; 0xB114, 0x1415, 0x0016, 0x0017, =
0x0018,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0019,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x501B, 0x001C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x031F, 0x2520, 0x0021, =
0x0022,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7E23, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xC54A, 0x0F4B, =
0x004C, 0x014D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x004F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x0750, 0x0251, 0x4752, 0x7453, 0x1354,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x3755, 0x4956, 0x5E57, 0x7958, =
0xBC59,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0x6C5A, 0xFD5B, 0x085C, =
0x095D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xB15E, 0xC95F, 0x6460, 0x2861, 0xFF62,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x8763, 0x2564, =
0x5165,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-65 =
*/<BR>+<BR>+&nbsp; /*&nbsp; HT,&nbsp;&nbsp; HA,&nbsp; HBS,&nbsp; =
HBE,&nbsp; HSS, HSE,&nbsp; VT,&nbsp; VA, VBS, VBE, VSS, VSE =
*/<BR>+&nbsp;&nbsp;&nbsp; 1800, 1024, 1024, 776, 1720, 80,&nbsp; 885, =
768, 768, 117, 800, 5<BR>+};<BR>+<BR>+static u16 =
VT1625_HDTV_1080I_720x480_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
Non-Macrovision Registers */<BR>+&nbsp;&nbsp;&nbsp; 0x0300, 0x0001, =
0x1002, 0x4F03, 0x8604,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0005, 0x0006, 0x4207, 0x3F08, =
0x4809,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; =
0x000A, 0x000B, 0x000C, 0x000D, 0x000E,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; 0x9E0F, 0x0010, 0x8011, 0x0612, =
0x0A13,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2114, 0x1815, 0x0016, 0x0017, 0x0018,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0019,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x501B, 0x041C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x031F, 0x2520, 0x0021, =
0x0022,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7E23, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xC54A, 0x0F4B, =
0x004C, 0x014D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x004F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x0750, 0xD251, 0x2752, 0x2553, 0x1254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x6F55, 0xBB56, 0x4657, 0x2358, =
0x8D59,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0x4C5A, 0xBC5B, 0xBC5C, =
0x465D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x935E, 0x3D5F, 0x3E60, 0x2861, 0xFF62,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x6F63, 0x1364, =
0x5165,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-65 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* HT,&nbsp; HA, HBS,&nbsp; HBE,&nbsp; =
HSS, HSE,&nbsp; VT,&nbsp; VA, VBS, VBE, VSS, VSE =
*/<BR>+&nbsp;&nbsp;&nbsp; 1800, 720, 720, 1016, 1680,&nbsp; 56, 550, =
480, 480,&nbsp; 70, 485, 6<BR>+};<BR>+<BR>+static u16 =
VT1625_HDTV_1080I_720x576_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
Non-Macrovision Registers */<BR>+&nbsp;&nbsp;&nbsp; 0x0300, 0x0001, =
0x1002, 0x4A03, 0x8604,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0005, 0x0006, 0x1A07, 0x3908, =
0x0209,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; =
0x000A, 0x000B, 0x000C, 0x000D, 0x000E,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; 0x9E0F, 0x0010, 0x8011, 0xED12, =
0x1913,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; =
0xB614, 0x3815, 0x0016, 0x0017, 0x0018,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0019,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x501B, 0x001C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x031F, 0x2520, 0x0021, =
0x0022,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7E23, 0x0024, =
0x5165,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xC54A, 0x0F4B, =
0x004C, 0x014D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x004F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x1750, 0xCF51, 0x2652, 0x5753, 0x1254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x7F55, 0xCF56, 0x4857, 0x2358, =
0x8F59,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0x5C5A, 0xF05B, 0x935C, =
0x465D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x445E, 0x005F, 0x4460, 0x2061, 0xFF62,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x3F63, =
0x1364,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-65 */<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
/* HT,&nbsp; HA, HBS, HBE,&nbsp; HSS, HSE, VT,&nbsp; VA, VBS, VBE, VSS, =
VSE */<BR>+&nbsp;&nbsp;&nbsp; 1560, 720, 720, 840, 1520, 16, 600, 576, =
576,&nbsp; 24, 577, 2<BR>+};<BR>+<BR>+static u16 =
VT1625_HDTV_1080I_1920x1080_VN[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
Non-Macrovision Registeris */<BR>+&nbsp;&nbsp;&nbsp; 0x8300, 0x0001, =
0x1002, 0x4A03, 0x8604,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x3905, 0x0006, 0x8B07, 0x3D08, =
0x3209,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; =
0x000A, 0x000B, 0x000C, 0x000D, 0x000E,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; 0x9E0F, 0x0010, 0x8011, 0x4A12, =
0x0813,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; =
0x3714, 0x1415, 0x0016, 0x0017, 0x0018,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0019,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x501B, 0x041C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x031F, 0x2520, 0x0021, =
0x0022,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7E23, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xC54A, 0x0F4B, =
0x004C, 0x014D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x004F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x9750, 0x7F51, 0x7852, 0x6453, 0x1454,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x9755, 0x7F56, 0x5957, 0x7858, =
0xB059,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0x1A5A, 0xEC5B, 0xFA5C, =
0x085D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x005E, 0x005F, 0x8060, 0x2061, 0xFF62,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x9763, 0x2864, =
0x5165,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-65 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* HT,&nbsp;&nbsp; HA,&nbsp; HBS, =
HBE,&nbsp; HSS, HSE,&nbsp;&nbsp; VT,&nbsp;&nbsp; VA,&nbsp; VBS, =
VBE,&nbsp; VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 2200, 1920, 1920, 280, =
1960, 104, 1125, 1080, 1080,&nbsp; 45, 1083, 4<BR>+};<BR>+<BR>+<BR>+/* =
720P Over Scan */<BR>+static u16 VT1625_HDTV_720P_640x480_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
Non-Macrovision Registers */<BR>+&nbsp;&nbsp;&nbsp; 0x0300, 0x0001, =
0x1002, 0x4003, 0x9404,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0005, 0x0006, 0x0007, 0x3808, =
0x0409,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; =
0x000A, 0x000B, 0x000C, 0x000D, 0x000E,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; 0xB00F, 0x0010, 0x8011, 0x2C12, =
0x0A13,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2914, 0x3C15, 0x0016, 0x0017, 0x0018,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0019,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x501B, 0x001C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x031F, 0x2520, 0x0021, =
0x0022,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7E23, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xC54A, 0x0F4B, 0x004C, =
0x014D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x004F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xD750, 0x8351, 0x2352, 0xF353, 0x1154,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x3355, 0x7B56, 0x2857, 0x2358, =
0x9559,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0x135A, 0x895B, 0x135C, =
0x435D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x555E, 0x165F, 0x5560, 0x2861, 0x0062,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x8F63, 0x1264, =
0x5165,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-65 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, =
HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; =
984, 640, 640, 344, 920, 64,&nbsp; 500, 480, 480, 20, 481, =
2<BR>+};<BR>+<BR>+static u16 VT1625_HDTV_720P_800x600_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
Non-Macrovision Registers */<BR>+&nbsp;&nbsp;&nbsp; 0x0300, 0x0001, =
0x1002, 0x4003, 0x9404,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0005, 0x0006, 0x1007, 0x3908, =
0x0209,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; =
0x000A, 0x000B, 0x000C, 0x000D, 0x000E,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; 0xB00F, 0x0010, 0x8011, 0x4F12, =
0x0A13,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; =
0x3F14, 0x4815, 0x0016, 0x0017, 0x0018,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0019,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x501B, 0x001C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x001F, 0x2520, 0x0021, =
0x0022,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7E23, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xC54A, 0x0F4B, 0x004C, =
0x014D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x004F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xEF50, 0x1F51, 0x3352, 0x7053, 0x1254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0xEF55, 0x1F56, 0x3057, 0x3358, =
0xB759,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xC75A, 0x9B5B, 0xC75C, =
0x435D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xAA5E, 0x005F, 0x6A60, 0x2061, 0x0062,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x4763, 0x1364, =
0x5165,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-65 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, =
HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; =
1008, 800, 800, 208, 936, 56, 625, 600, 600, 25, 603, =
2<BR>+};<BR>+<BR>+static u16 VT1625_HDTV_720P_1024x768_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
Non-Macrovision Registers */<BR>+&nbsp;&nbsp;&nbsp; 0x0300, 0x0001, =
0x1002, 0x4003, 0x9404,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0005, 0x0006, 0x0307, 0x3508, =
0xEE09,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; =
0x000A, 0x000B, 0x000C, 0x000D, 0x000E,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; 0xB80F, 0x0010, 0x8011, 0x6812, =
0x1913,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; =
0x5414, 0x1C15, 0x0016, 0x0017, 0x0018,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0019,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x501B, 0x041C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x031F, 0x1C20, 0x0021, =
0x0022,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7E23, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xC54A, 0x0F4B, 0x004C, =
0x014D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x004F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x3750, 0x0851, 0x4452, 0x1F53, 0x0354,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0xEF55, 0x1756, 0x3557, 0x3358, =
0xB959,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xC75A, 0xAA5B, 0xB95C, =
0x435D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x885E, 0x7B5F, 0x8860, 0xAA61, 0x0062,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x7F63, 0x1464, =
0x5165,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-65 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, =
HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; =
1080, 1024, 1024, 56, 1040, 32,&nbsp; 800, 768, 768, 32, 770, =
13<BR>+};<BR>+<BR>+static u16 VT1625_HDTV_720P_720x480_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
Non-Macrovision Registers */<BR>+&nbsp;&nbsp;&nbsp; 0x0300, 0x0001, =
0x1002, 0x4003, 0x9404,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0005, 0x0006, 0x0007, 0x3108, =
0x0309,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; =
0x000A, 0x000B, 0x000C, 0x000D, 0x000E,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; 0xB00F, 0x0010, 0x8011, 0x2812, =
0x0F13,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; =
0x2E14, 0x2815, 0x0016, 0x0017, 0x0018,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0019,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x501B, 0x001C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x031F, 0x2520, 0x0021, =
0x0022,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7E23, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xC54A, 0x0F4B, 0x004C, =
0x014D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x004F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x4F50, 0xD351, 0x2452, 0xF353, 0x1154,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x9755, 0xD156, 0x2C57, 0x2358, =
0xA759,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0x725A, 0x995B, 0x735C, =
0x435D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x555E, 0x005F, 0x5560, 0x0061, 0x0062,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0xDF63, 0x1264, =
0x5165,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-65 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, =
HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; =
1104, 720, 720, 384, 1040, 64,&nbsp; 500, 480, 480, 20, 482, =
2<BR>+};<BR>+<BR>+static u16 VT1625_HDTV_720P_1280x720_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
Non-Macrovision Registers */<BR>+&nbsp;&nbsp;&nbsp; 0x8300, 0x0001, =
0x1002, 0x4003, 0x9404,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0005, 0x0006, 0xFF07, 0x5308, =
0x0009,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; =
0x000A, 0x000B, 0x000C, 0x000D, 0x000E,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; 0x9E0F, 0x0010, 0x8011, 0x8912, =
0x1013,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; =
0x6314, 0x2415, 0x0016, 0x0017, 0x0018,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0019,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x501B, 0x001C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x031F, 0x2520, 0x0021, =
0x0022,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7E23, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xC54A, 0x0F4B, 0x004C, =
0x014D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x004F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x7150, 0xFF51, 0x4652, 0xED53, 0x1254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x7155, 0xFF56, 0x5057, 0x4658, =
0x3059,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0x305A, 0x1C5B, 0x475C, =
0x965D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x005E, 0x005F, 0x8060, 0x2861, 0x0062,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x7163, 0x3664, =
0x5165,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-65 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, =
HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; =
1650, 1280, 1280, 370, 1328, 72,&nbsp; 750, 720, 720, 30, 723, =
4<BR>+};<BR>+<BR>+<BR>+/* 1080I Over Scan */<BR>+static u16 =
VT1625_HDTV_1080I_640x480_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
Non-Macrovision Registers */<BR>+&nbsp;&nbsp;&nbsp; 0x0300, 0x0001, =
0x1002, 0x4F03, 0x8604,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0005, 0x0006, 0x0A07, 0x1708, =
0x0209,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; =
0x000A, 0x000B, 0x000C, 0x000D, 0x000E,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; 0xB00F, 0x0010, 0x8011, 0xEC12, =
0x3213,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; =
0x1114, 0x3515, 0x0016, 0x0017, 0x0018,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0019,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x501B, 0x001C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x031F, 0x2520, 0x0021, =
0x0022,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7E23, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xC54A, 0x0F4B, 0x004C, =
0x014D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x004F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F */<BR>+ =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; 0xE750, =
0x8351, 0x2552, 0xF353, 0x1154,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.50-54 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0xD755, 0x7B56, 0x3A57, 0x2258, =
0x7459,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xBA5A, 0x8E5B, 0x925C, =
0x055D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xE35E, 0x105F, 0x3860, 0x2861, 0xFF62,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x9F63, 0x1264, =
0x5165,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-65 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, =
HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; =
1512, 640, 640, 872, 1440, 64,&nbsp; 500, 480, 480, 20, 481, =
2<BR>+};<BR>+<BR>+static u16 VT1625_HDTV_1080I_800x600_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
Non-Macrovision Registers */<BR>+&nbsp;&nbsp;&nbsp; 0x0300, 0x0001, =
0x1002, 0x4F03, 0x8604,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0005, 0x0006, 0x1207, 0x1508, =
0x0309,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; =
0x000A, 0x000B, 0x000C, 0x000D, 0x000E,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; 0xB00F, 0x0010, 0x8011, 0x0812, =
0x0513,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; =
0x1514, 0x2015, 0x0016, 0x0017, 0x0018,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0019,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x501B, 0x001C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x031F, 0x2520, 0x0021, =
0x0022,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7E23, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 */<BR>+ =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xC54A, 0x0F4B, 0x004C, =
0x014D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x004F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xE750, 0x2151, 0x3552, 0x7053, 0x1254,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x4755, 0xDD56, 0x4357, 0x2358, =
0x8559,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0x245A, 0xA35B, 0x6E5C, =
0x465D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x1C5E, 0xBD5F, 0x4760, 0x2861, 0xFF62,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x4763, 0x1364, =
0x5165,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-65 =
*/<BR>+<BR>+&nbsp; /*HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; =
VA,&nbsp; VBS, VBE, VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 1512, 800, 800, =
712, 1440, 56,&nbsp; 625, 600, 600, 25, 600, 2<BR>+};<BR>+<BR>+static =
u16 VT1625_HDTV_1080I_1024x768_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
Non-Macrovision Registers */<BR>+&nbsp;&nbsp;&nbsp; 0x0300, 0x0001, =
0x1002, 0x4503, 0x8604,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0005, 0x0006, 0x2007, 0x1D08, =
0x3109,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; =
0x000A, 0x000B, 0x000C, 0x000D, 0x000E,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; 0xB80F, 0x0010, 0x8011, 0xE812, =
0x1913,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; =
0x8514, 0x1C15, 0x0016, 0x0017, 0x0018,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0019,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x501B, 0x041C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x031F, 0x1C20, 0x0021, =
0x0022,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7E23, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xC54A, 0x0F4B, 0x004C, =
0x014D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x004F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xAD50, 0x0151, 0x4652, 0x1F53, 0x1354,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x2755, 0x9F56, 0x5557, 0x3458, =
0xAA59,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0xFD5A, 0xD95B, 0x195C, =
0x485D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x055E, 0xD75F, 0x5B60, 0x2861, 0xFF62,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0xBF63, 0x1464, =
0x5165,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-65 =
*/<BR>+<BR>+&nbsp; /*HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, HSE, VT,&nbsp; =
VA,&nbsp; VBS, VBE, VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; 1710, 1024, 1024, =
56, 1584, 96,&nbsp; 800, 768, 768, 32, 770, 13<BR>+};<BR>+<BR>+static =
u16 VT1625_HDTV_1080I_720x480_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
Non-Macrovision Registers */<BR>+&nbsp;&nbsp;&nbsp; 0x0300, 0x0001, =
0x1002, 0x4F03, 0x8604,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x0005, 0x0006, 0x0007, 0x1A08, =
0x2B09,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; =
0x000A, 0x000B, 0x000C, 0x000D, 0x000E,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; 0xB00F, 0x0010, 0x8011, 0xE812, =
0x3213,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; =
0xCF14, 0x2415, 0x0016, 0x0017, 0x0018,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0019,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x501B, 0x041C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x031F, 0x2520, 0x0021, =
0x0022,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7E23, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 */<BR>+ =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xC54A, 0x0F4B, 0x004C, =
0x014D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x004F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x7750, 0xD351, 0x2652, 0xF353, 0x1154,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x3B55, 0xD156, 0x4257, 0x2358, =
0x8459,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0x1A5A, 0xA25B, 0x565C, =
0x465D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0xE35E, 0x005F, 0x3860, 0x2861, 0xFF62,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0xDF63, 0x1264, =
0x5165,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-65 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, =
HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; =
1656, 720, 720, 936, 1584, 72,&nbsp; 500, 480, 480, 20, 485, =
6<BR>+};<BR>+<BR>+static u16 VT1625_HDTV_1080I_1920x1080_VO[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
Non-Macrovision Registers */<BR>+&nbsp;&nbsp;&nbsp; 0x8300, 0x0001, =
0x1002, 0x4A03, 0x8604,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.00-04 =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x3905, 0x0006, 0x8B07, 0x3D08, =
0x3209,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.05-09 */<BR>+&nbsp;&nbsp;&nbsp; =
0x000A, 0x000B, 0x000C, 0x000D, 0x000E,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.0A-0E */<BR>+&nbsp;&nbsp;&nbsp; 0x9E0F, 0x0010, 0x8011, 0x4A12, =
0x0813,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.0F-13 */<BR>+&nbsp;&nbsp;&nbsp; =
0x3714, 0x1415, 0x0016, 0x0017, 0x0018,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.14-18 */<BR>+&nbsp;&nbsp;&nbsp; =
0x0019,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.19 */<BR>+&nbsp;&nbsp;&nbsp; 0x501B, 0x041C, =
0x801D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1B-1D =
*/<BR>+&nbsp;&nbsp;&nbsp; 0x001E, 0x031F, 0x2520, 0x0021, =
0x0022,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.1E-22 */<BR>+&nbsp;&nbsp;&nbsp; =
0x7E23, =
0x0024,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.23-24 */<BR>+ =
<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
Filter registers */<BR>+&nbsp;&nbsp;&nbsp; 0xC54A, 0x0F4B, 0x004C, =
0x014D, 0x004E,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.4A-4E =
*/<BR>+&nbsp;&nbsp;&nbsp; =
0x004F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* TV.4F =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Set Video Timing (TV Timing Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x9750, 0x7F51, 0x7852, 0x6453, 0x1454,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.50-54 */<BR>+&nbsp;&nbsp;&nbsp; 0x9755, 0x7F56, 0x5957, 0x7858, =
0xB059,&nbsp;&nbsp;&nbsp;&nbsp; /* TV.55-59 */<BR>+&nbsp;&nbsp;&nbsp; =
0x1A5A, 0xEC5B, 0xFA5C, =
0x085D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* TV.5A-5D =
*/<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* Set Video Timing (TV CRTC Regsiter ) */<BR>+&nbsp;&nbsp;&nbsp; =
0x005E, 0x005F, 0x8060, 0x2061, 0xFF62,&nbsp;&nbsp;&nbsp;&nbsp; /* =
TV.5E-62 */<BR>+&nbsp;&nbsp;&nbsp; 0x9763, 0x2864, =
0x5165,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TV.63-65 =
*/<BR>+<BR>+&nbsp;&nbsp;&nbsp; /* HT,&nbsp; HA,&nbsp; HBS, HBE, HSS, =
HSE, VT,&nbsp; VA,&nbsp; VBS, VBE, VSS, VSE */<BR>+&nbsp;&nbsp;&nbsp; =
2200, 1920, 1920, 280, 1960, 104,&nbsp; 1125, 1080, 1080, 45, 1083, =
4<BR>+};<BR>+<BR>+<BR>+vt1625_func_table VT1625_HDTV_720P_640x480_tbl[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; =
{TV_BASE_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_HDTV_720P_640x480_VN,&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp; =
VT1625_HDTV_720P_640x480_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
HDTV_OUT_RGB,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp; HDTV_OUT_RGB},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_YPBPR_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
HDTV_OUT_YPBPR,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp; HDTV_OUT_YPBPR},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VT1625_NULL_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_YPBPR_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VT1625_NULL_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_DeDotCrawl_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VT1625_NULL_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC}<BR>+};<BR>+<BR>+vt1625_func_table =
VT1625_HDTV_720P_800x600_tbl[] =3D {<BR>+&nbsp;&nbsp;&nbsp; =
{TV_BASE_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_HDTV_720P_800x600_VN,&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp; =
VT1625_HDTV_720P_800x600_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
HDTV_OUT_RGB,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp; HDTV_OUT_RGB},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_YPBPR_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
HDTV_OUT_YPBPR,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp; HDTV_OUT_YPBPR},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VT1625_NULL_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_YPBPR_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VT1625_NULL_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_DeDotCrawl_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VT1625_NULL_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC}<BR>+};<BR>+<BR>+vt1625_func_table =
VT1625_HDTV_720P_1024x768_tbl[] =3D {<BR>+&nbsp;&nbsp;&nbsp; =
{TV_BASE_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_HDTV_720P_1024x768_VN,&nbsp;&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp; =
VT1625_HDTV_720P_1024x768_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
HDTV_OUT_RGB,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp; HDTV_OUT_RGB},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_YPBPR_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
HDTV_OUT_YPBPR,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp; HDTV_OUT_YPBPR},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VT1625_NULL_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_YPBPR_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VT1625_NULL_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_DeDotCrawl_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VT1625_NULL_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC}<BR>+};<BR>+<BR>+vt1625_func_table =
VT1625_HDTV_720P_720x480_tbl[] =3D {<BR>+&nbsp;&nbsp;&nbsp; =
{TV_BASE_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_HDTV_720P_720x480_VN,&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp; =
VT1625_HDTV_720P_720x480_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
HDTV_OUT_RGB,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp; HDTV_OUT_RGB},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_YPBPR_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
HDTV_OUT_YPBPR,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp; HDTV_OUT_YPBPR},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VT1625_NULL_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_YPBPR_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VT1625_NULL_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_DeDotCrawl_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VT1625_NULL_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC}<BR>+};<BR>+<BR>+vt1625_func_table =
VT1625_HDTV_720P_720x576_tbl[] =3D {<BR>+&nbsp;&nbsp;&nbsp; =
{TV_BASE_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_HDTV_720P_720x576_VN,&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp; VT1625_NULL_FUNC},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
HDTV_OUT_RGB,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp; HDTV_OUT_RGB},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_YPBPR_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
HDTV_OUT_YPBPR,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp; HDTV_OUT_YPBPR},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VT1625_NULL_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_YPBPR_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VT1625_NULL_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_DeDotCrawl_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VT1625_NULL_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC}<BR>+};<BR>+<BR>+vt1625_func_table =
VT1625_HDTV_720P_1280x720_tbl[] =3D {<BR>+&nbsp;&nbsp;&nbsp; =
{TV_BASE_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_HDTV_720P_1280x720_VN,&nbsp;&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp; =
VT1625_HDTV_720P_1280x720_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
HDTV_OUT_RGB,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp; HDTV_OUT_RGB},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_YPBPR_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
HDTV_OUT_YPBPR,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp; HDTV_OUT_YPBPR},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VT1625_NULL_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_YPBPR_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VT1625_NULL_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_DeDotCrawl_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VT1625_NULL_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC}<BR>+};<BR>+<BR>+vt1625_func_table =
VT1625_HDTV_1080I_640x480_tbl[] =3D {<BR>+&nbsp;&nbsp;&nbsp; =
{TV_BASE_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_HDTV_1080I_640x480_VN,&nbsp;&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp; =
VT1625_HDTV_1080I_640x480_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
HDTV_OUT_RGB,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp; HDTV_OUT_RGB},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_YPBPR_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
HDTV_OUT_YPBPR,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp; HDTV_OUT_YPBPR},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VT1625_NULL_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_YPBPR_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VT1625_NULL_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_DeDotCrawl_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VT1625_NULL_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC}<BR>+};<BR>+<BR>+vt1625_func_table =
VT1625_HDTV_1080I_800x600_tbl[] =3D {<BR>+&nbsp;&nbsp;&nbsp; =
{TV_BASE_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_HDTV_1080I_800x600_VN,&nbsp;&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp; =
VT1625_HDTV_1080I_800x600_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
HDTV_OUT_RGB,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp; HDTV_OUT_RGB},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_YPBPR_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
HDTV_OUT_YPBPR,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp; HDTV_OUT_YPBPR},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VT1625_NULL_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_YPBPR_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VT1625_NULL_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_DeDotCrawl_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VT1625_NULL_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC}<BR>+};<BR>+<BR>+vt1625_func_table =
VT1625_HDTV_1080I_1024x768_tbl[] =3D {<BR>+&nbsp;&nbsp;&nbsp; =
{TV_BASE_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_HDTV_1080I_1024x768_VN,&nbsp;&nbsp; VT1625_NULL_FUNC,&nbsp;&nbsp; =
VT1625_HDTV_1080I_1024x768_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
HDTV_OUT_RGB,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp; HDTV_OUT_RGB},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_YPBPR_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
HDTV_OUT_YPBPR,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp; HDTV_OUT_YPBPR},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VT1625_NULL_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_YPBPR_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VT1625_NULL_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_DeDotCrawl_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VT1625_NULL_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC}<BR>+};<BR>+<BR>+vt1625_func_table =
VT1625_HDTV_1080I_720x480_tbl[] =3D {<BR>+&nbsp;&nbsp;&nbsp; =
{TV_BASE_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_HDTV_1080I_720x480_VN,&nbsp;&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp; =
VT1625_HDTV_1080I_720x480_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
HDTV_OUT_RGB,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp; HDTV_OUT_RGB},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_YPBPR_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
HDTV_OUT_YPBPR,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp; HDTV_OUT_YPBPR},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VT1625_NULL_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_YPBPR_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VT1625_NULL_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_DeDotCrawl_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VT1625_NULL_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC}<BR>+};<BR>+<BR>+vt1625_func_table =
VT1625_HDTV_1080I_720x576_tbl[] =3D {<BR>+&nbsp;&nbsp;&nbsp; =
{TV_BASE_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_HDTV_1080I_720x576_VN,&nbsp;&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp; VT1625_NULL_FUNC},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
HDTV_OUT_RGB,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp; HDTV_OUT_RGB},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_YPBPR_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
HDTV_OUT_YPBPR,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp; HDTV_OUT_YPBPR},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VT1625_NULL_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_YPBPR_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VT1625_NULL_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_DeDotCrawl_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VT1625_NULL_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC}<BR>+};<BR>+<BR>+vt1625_func_table =
VT1625_HDTV_1080I_1920x1080_tbl[] =3D {<BR>+&nbsp;&nbsp;&nbsp; =
{TV_BASE_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_HDTV_1080I_1920x1080_VN,&nbsp; VT1625_NULL_FUNC,&nbsp;&nbsp; =
VT1625_HDTV_1080I_1920x1080_VO},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
HDTV_OUT_RGB,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp; HDTV_OUT_RGB},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_YPBPR_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
HDTV_OUT_YPBPR,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp; HDTV_OUT_YPBPR},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_RGB_FUNC,&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VT1625_NULL_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_SDTV_YPBPR_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VT1625_NULL_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC},<BR>+&nbsp;&nbsp;&nbsp; =
{TV_DeDotCrawl_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VT1625_NULL_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC}<BR>+};<BR>+<BR>+vt1625_func_table VT1625_NULL_TBL[] =
=3D {<BR>+&nbsp;&nbsp;&nbsp; {0xFFFF,&nbsp;&nbsp; =
VT1625_NULL_FUNC,&nbsp;&nbsp; VT1625_NULL_FUNC,&nbsp;&nbsp; =
VT1625_NULL_FUNC}<BR>+};<BR>+<BR>+static struct vt1625_table =
vt1625_tbl[] =3D {<BR>+&nbsp;&nbsp;&nbsp; {VIA_RES_640X480,&nbsp;&nbsp; =
vt1625_ntsc_640x480_tbl,&nbsp; vt1625_pal_640x480_tbl,&nbsp; =
VT1625_HDTV_720P_640x480_tbl,&nbsp; VT1625_HDTV_1080I_640x480_tbl&nbsp; =
},<BR>+&nbsp;&nbsp;&nbsp; {VIA_RES_800X600,&nbsp;&nbsp; =
vt1625_ntsc_800x600_tbl,&nbsp; vt1625_pal_800x600_tbl,&nbsp; =
VT1625_HDTV_720P_800x600_tbl,&nbsp; VT1625_HDTV_1080I_800x600_tbl&nbsp; =
},<BR>+&nbsp;&nbsp;&nbsp; {VIA_RES_1024X768,&nbsp; =
vt1625_ntsc_1024x768_tbl, vt1625_pal_1024x768_tbl, =
VT1625_HDTV_720P_1024x768_tbl, VT1625_HDTV_1080I_1024x768_tbl =
},<BR>+&nbsp;&nbsp;&nbsp; {VIA_RES_720X480,&nbsp;&nbsp; =
vt1625_ntsc_720x480_tbl,&nbsp; vt1625_ntsc_720x480_tbl, =
VT1625_HDTV_720P_720x480_tbl,&nbsp; VT1625_HDTV_1080I_720x480_tbl&nbsp; =
},<BR>+&nbsp;&nbsp;&nbsp; {VIA_RES_720X576,&nbsp;&nbsp; =
vt1625_pal_720x576_tbl,&nbsp;&nbsp; vt1625_pal_720x576_tbl,&nbsp; =
VT1625_HDTV_720P_720x576_tbl,&nbsp; VT1625_HDTV_1080I_720x576_tbl&nbsp; =
},<BR>+&nbsp;&nbsp;&nbsp; {VIA_RES_1280X720,&nbsp; =
VT1625_NULL_TBL,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_NULL_TBL,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_HDTV_720P_1280x720_tbl, =
VT1625_NULL_TBL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<BR>+&nbsp;&nbsp;&nbsp; =
{VIA_RES_1920X1080, =
VT1625_NULL_TBL,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_NULL_TBL,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_NULL_TBL,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; =
VT1625_HDTV_1080I_1920x1080_tbl}<BR>+};<BR>+<BR>+#define =
NUM_TOTAL_VT1625_TABLE ARRAY_SIZE(vt1625_tbl)<BR>+<BR>+#define =
IS_VT1625_NULL_TBL(tbl) tbl[0].tv_func_index =3D=3D 0xFFFF ? TRUE : =
FALSE<BR>+#define IS_VT1625_NULL_FUNC(func) func[0] =3D=3D 0xFFFF ? TRUE =
: FALSE<BR>+<BR>+static u16 VT1625_CGMS_TBL[] =3D =
{<BR>+&nbsp;&nbsp;&nbsp; 0x006b, 0x006c, 0x006d, 0x006e, 0x006f, /* TV =
0x6b-0x6f */<BR>+&nbsp;&nbsp;&nbsp; 0x0070, 0x0071, 0x0072, =
0x0073&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* TV0x70-0x73 */<BR>+};<BR>+#define =
NUM_TOTAL_VT1625_CGMS_TBL ARRAY_SIZE(VT1625_CGMS_TBL)<BR>+<BR>+#endif /* =
__TBL1625_H__ */<BR></FONT>=0A=
<DIV><FONT face=3D=B7s=B2=D3=A9=FA=C5=E9 color=3D#000000 =
size=3D2></FONT>&nbsp;</DIV></BODY></HTML>
------_=_NextPart_001_01C7893F.0D39D82C--


--===============0653840958==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0653840958==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0653840958==--
