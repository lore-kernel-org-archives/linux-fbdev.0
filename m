From: Alex Song <asong@ds-usa.com>
Subject: radeonfb IGP patch
Date: Mon, 5 Apr 2004 12:11:50 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <21E683CF0A08D311943E006097D50C72B7269A@AS2>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C41B41.D90A94B0"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BAZWd-0000l4-0A
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Apr 2004 12:12:51 -0700
Received: from [65.219.8.130] (helo=as2.alaris.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BAZWc-0002B5-O6
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Apr 2004 12:12:50 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: 'Benjamin Herrenschmidt' <benh@kernel.crashing.org>
Cc: "'linux-fbdev-devel@lists.sf.net'" <linux-fbdev-devel@lists.sf.net>

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C41B41.D90A94B0
Content-Type: text/plain;
	charset="iso-8859-1"

hi ben,

this patch for the new radeonfb in linux-2.6.4 fixes memory detection and fb
offsets for IGP based radeons.

cheers,

alex

============================================
Alex Song
Software Engineer
Digital Stream USA, Inc.
44061 Nobel Drive
Fremont, CA 94538, USA
Work: (510) 770-5700 x266
Fax: (510) 770-5769
Email: asong@ds-usa.com
============================================


------_=_NextPart_000_01C41B41.D90A94B0
Content-Type: application/octet-stream;
	name="radeonfb-IGP-linux-2.6.4.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="radeonfb-IGP-linux-2.6.4.patch"

diff -uprN -X dontdiff =
linux-2.6.4-clean/drivers/video/aty/radeon_base.c =
linux-2.6.4/drivers/video/aty/radeon_base.c=0A=
--- linux-2.6.4-clean/drivers/video/aty/radeon_base.c	2004-03-10 =
18:55:25.000000000 -0800=0A=
+++ linux-2.6.4/drivers/video/aty/radeon_base.c	2004-04-01 =
16:10:32.050172056 -0800=0A=
@@ -1144,6 +1144,7 @@ static void radeon_write_pll_regs(struct=0A=
 =0A=
 	/* Set PPLL ref. div */=0A=
 	if (rinfo->family =3D=3D CHIP_FAMILY_R300 ||=0A=
+	    rinfo->family =3D=3D CHIP_FAMILY_RS300 ||=0A=
 	    rinfo->family =3D=3D CHIP_FAMILY_R350 ||=0A=
 	    rinfo->family =3D=3D CHIP_FAMILY_RV350) {=0A=
 		if (mode->ppll_ref_div & R300_PPLL_REF_DIV_ACC_MASK) {=0A=
@@ -2129,7 +2130,31 @@ static int radeonfb_pci_register (struct=0A=
 #endif /* CONFIG_PPC_OF */=0A=
 =0A=
 	/* framebuffer size */=0A=
-	tmp =3D INREG(CONFIG_MEMSIZE);=0A=
+	if ((rinfo->family =3D=3D CHIP_FAMILY_RS100) ||=0A=
+	    (rinfo->family =3D=3D CHIP_FAMILY_RS200) ||=0A=
+	    (rinfo->family =3D=3D CHIP_FAMILY_RS300)) {=0A=
+	  u32 tom =3D INREG(NB_TOM);=0A=
+	  tmp =3D ((((tom >> 16) - (tom & 0xffff) + 1) << 6) * 1024);=0A=
+=0A=
+	  OUTREG(MC_FB_LOCATION, tom);=0A=
+	  OUTREG(DISPLAY_BASE_ADDR, (tom & 0xffff) << 16);=0A=
+	  OUTREG(CRTC2_DISPLAY_BASE_ADDR, (tom & 0xffff) << 16);=0A=
+	  OUTREG(OV0_BASE_ADDR, (tom & 0xffff) << 16);=0A=
+=0A=
+	  /* This is supposed to fix the crtc2 noise problem. */=0A=
+	  OUTREG(GRPH2_BUFFER_CNTL, INREG(GRPH2_BUFFER_CNTL) & ~0x7f0000);=0A=
+ =0A=
+	  if ((rinfo->family =3D=3D CHIP_FAMILY_RS100) ||=0A=
+	      (rinfo->family =3D=3D CHIP_FAMILY_RS200)) {=0A=
+            /* This is to workaround the asic bug for RMX, some =
versions=0A=
+               of BIOS dosen't have this register initialized =
correctly.=0A=
+            */=0A=
+            OUTREGP(CRTC_MORE_CNTL, CRTC_H_CUTOFF_ACTIVE_EN,=0A=
+                    ~CRTC_H_CUTOFF_ACTIVE_EN);=0A=
+	  }=0A=
+	} else {=0A=
+	  tmp =3D INREG(CONFIG_MEMSIZE);=0A=
+	}=0A=
 =0A=
 	/* mem size is bits [28:0], mask off the rest */=0A=
 	rinfo->video_ram =3D tmp & CONFIG_MEMSIZE_MASK;=0A=
diff -uprN -X dontdiff linux-2.6.4-clean/include/video/radeon.h =
linux-2.6.4/include/video/radeon.h=0A=
--- linux-2.6.4-clean/include/video/radeon.h	2004-03-10 =
18:55:54.000000000 -0800=0A=
+++ linux-2.6.4/include/video/radeon.h	2004-03-29 18:34:57.000000000 =
-0800=0A=
@@ -73,6 +73,7 @@=0A=
 #define MEM_IO_CNTL_A0                         0x0178  =0A=
 #define MEM_INIT_LATENCY_TIMER                 0x0154  =0A=
 #define MEM_SDRAM_MODE_REG                     0x0158  =0A=
+#define NB_TOM                                 0x015C  =0A=
 #define AGP_BASE                               0x0170  =0A=
 #define MEM_IO_CNTL_A1                         0x017C  =0A=
 #define MEM_IO_CNTL_B0                         0x0180=0A=
@@ -173,6 +174,8 @@=0A=
 #define CUR_CLR1                               0x0270  =0A=
 #define FP_HORZ_VERT_ACTIVE                    0x0278  =0A=
 #define CRTC_MORE_CNTL                         0x027C  =0A=
+#       define CRTC_H_CUTOFF_ACTIVE_EN         (1<<4)=0A=
+#       define CRTC_V_CUTOFF_ACTIVE_EN         (1<<5)=0A=
 #define DAC_EXT_CNTL                           0x0280  =0A=
 #define FP_GEN_CNTL                            0x0284  =0A=
 #define FP_HORZ_STRETCH                        0x028C  =0A=
@@ -185,6 +188,7 @@=0A=
 //#define DDA_ON_OFF			       0x02e4=0A=
 #define DVI_I2C_CNTL_1			       0x02e4=0A=
 #define GRPH_BUFFER_CNTL                       0x02F0=0A=
+#define GRPH2_BUFFER_CNTL                      0x03F0=0A=
 #define VGA_BUFFER_CNTL                        0x02F4=0A=
 #define OV0_Y_X_START                          0x0400=0A=
 #define OV0_Y_X_END                            0x0404  =0A=

------_=_NextPart_000_01C41B41.D90A94B0--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
