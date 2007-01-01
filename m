From: Luca Tettamanti <kronos.it@gmail.com>
Subject: [PATCH] radeonfb: add support for newer cards
Date: Mon, 1 Jan 2007 22:25:51 +0100
Message-ID: <20070101212551.GA19598@dreamland.darkstar.lan>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1460537926=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H1UfY-0006Uf-BX for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Jan 2007 13:26:08 -0800
Received: from ug-out-1314.google.com ([66.249.92.171])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1H1UfW-0006yF-W2
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Jan 2007 13:26:08 -0800
Received: by ug-out-1314.google.com with SMTP id z38so4736927ugc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 01 Jan 2007 13:26:05 -0800 (PST)
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net, Solomon Peachy <pizza@shaftnet.org>, linux-kernel@vger.kernel.org

--===============1460537926==
Content-Type: text/plain; charset=UTF8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ben, Andrew,
I've rebased 'ATOM BIOS patch' from Solomon Peachy to apply to 2.6.20.
The patch adds support for newer Radeon cards and is mainly based on
X.Org code.

I've fixed a few things:
- Port sharing in radeon_get_conn_info_atom; old code didn't actually
  deal with it leading to wrong monitor detection
- Don't try to use I2C bus if BIOS says that there's no DDC channel,
  otherwise bad things happen:
  http://marc.theaimsgroup.com/?l=3Dlinux-fbdev-devel&m=3D116455601620186=
&w=3D2
- Make it compile on PPC (hopefully...)
- Cleanup whitespaces and coding style (only in the code alreay affected
  by the patch, I didn't touched all the driver...)

Signed-Off-By: Luca Tettamanti <kronos.it@gmail.com>
Signed-Off-By: Solomon Peachy <pizza@shaftnet.org> (I guess...)

---
Diffstat is pretty big, but a lot of changes are due to refactoring to
make legacy and ATOM BIOS stuff coexist.

 drivers/video/aty/ati_ids.h          |   32=20
 drivers/video/aty/radeon_accel.c     |   19=20
 drivers/video/aty/radeon_backlight.c |    4=20
 drivers/video/aty/radeon_base.c      |  497 ++++++++----
 drivers/video/aty/radeon_i2c.c       |   66 +
 drivers/video/aty/radeon_monitor.c   | 1339 +++++++++++++++++++++++-----=
-----
 drivers/video/aty/radeonfb.h         |  163 +++-
 7 files changed, 1518 insertions(+), 602 deletions(-)

diff --git a/drivers/video/aty/ati_ids.h b/drivers/video/aty/ati_ids.h
index 39ab483..b81c977 100644
--- a/drivers/video/aty/ati_ids.h
+++ b/drivers/video/aty/ati_ids.h
@@ -31,6 +31,7 @@
 #define PCI_CHIP_RV360_AR               0x4152
 #define PCI_CHIP_RV350_AS               0x4153
 #define PCI_CHIP_RV350_AT               0x4154
+#define PCI_CHIP_RV350_AU 		0x4155
 #define PCI_CHIP_RV350_AV               0x4156
 #define PCI_CHIP_MACH32			0x4158
 #define PCI_CHIP_RS250_4237		0x4237
@@ -71,7 +72,13 @@
 #define PCI_CHIP_R420_JL                0x4A4C
 #define PCI_CHIP_R420_JM                0x4A4D
 #define PCI_CHIP_R420_JN                0x4A4E
+#define PCI_CHIP_R420_JO 		0x4A4F
 #define PCI_CHIP_R420_JP                0x4A50
+#define PCI_CHIP_R420_JT 		0x4A54
+#define PCI_CHIP_R480_KI 		0x4B49
+#define PCI_CHIP_R480_KJ 		0x4B4A
+#define PCI_CHIP_R480_KK                0x4B4B
+#define PCI_CHIP_R480_KL 		0x4B4C
 #define PCI_CHIP_MACH64LB		0x4C42
 #define PCI_CHIP_MACH64LD		0x4C44
 #define PCI_CHIP_RAGE128LE		0x4C45
@@ -182,9 +189,19 @@
 #define PCI_CHIP_R423_UI                0x5549
 #define PCI_CHIP_R423_UJ                0x554A
 #define PCI_CHIP_R423_UK                0x554B
+#define PCI_CHIP_R423_UL 		0x554C
+#define PCI_CHIP_R423_UM 		0x554D
+#define PCI_CHIP_R423_UN 		0x554E
+#define PCI_CHIP_R423_UO 		0x554F
+#define PCI_CHIP_R423_UP 	       	0x5550
 #define PCI_CHIP_R423_UQ                0x5551
 #define PCI_CHIP_R423_UR                0x5552
 #define PCI_CHIP_R423_UT                0x5554
+#define PCI_CHIP_RV410_VJ 		0x564A
+#define PCI_CHIP_RV410_VK 		0x564B
+#define PCI_CHIP_RV410_VO 		0x564F
+#define PCI_CHIP_RV410_VR 		0x5652
+#define PCI_CHIP_RV410_VS 		0x5653
 #define PCI_CHIP_MACH64VT		0x5654
 #define PCI_CHIP_MACH64VU		0x5655
 #define PCI_CHIP_MACH64VV		0x5656
@@ -206,7 +223,22 @@
 #define PCI_CHIP_RV280_5964		0x5964
 #define PCI_CHIP_RV280_5C61		0x5C61
 #define PCI_CHIP_RV280_5C63		0x5C63
+#define PCI_CHIP_R423_5D48		0x5D48
+#define PCI_CHIP_R423_5D49		0x5D49
+#define PCI_CHIP_R423_5D4A		0x5D4A
+#define PCI_CHIP_R480_5D4C		0x5D4C
+#define PCI_CHIP_R480_5D4D		0x5D4D
+#define PCI_CHIP_R480_5D4E		0x5D4E
+#define PCI_CHIP_R480_5D4F		0x5D4F
+#define PCI_CHIP_R480_5D50		0x5D50
+#define PCI_CHIP_R480_5D52		0x5D52
 #define PCI_CHIP_R423_5D57              0x5D57
+#define PCI_CHIP_RV410_5E48		0x5E48
+#define PCI_CHIP_RV410_5E4A		0x5E4A
+#define PCI_CHIP_RV410_5E4B		0x5E4B
+#define PCI_CHIP_RV410_5E4C		0x5E4C
+#define PCI_CHIP_RV410_5E4D		0x5E4D
+#define PCI_CHIP_RV410_5E4F		0x5E4F
 #define PCI_CHIP_RS350_7834             0x7834
 #define PCI_CHIP_RS350_7835             0x7835
=20
diff --git a/drivers/video/aty/radeon_accel.c b/drivers/video/aty/radeon_=
accel.c
index 3ca27cb..529f158 100644
--- a/drivers/video/aty/radeon_accel.c
+++ b/drivers/video/aty/radeon_accel.c
@@ -203,9 +203,7 @@ void radeonfb_engine_reset(struct radeonfb_info *rinf=
o)
 	host_path_cntl =3D INREG(HOST_PATH_CNTL);
 	rbbm_soft_reset =3D INREG(RBBM_SOFT_RESET);
=20
-	if (rinfo->family =3D=3D CHIP_FAMILY_R300 ||
-	    rinfo->family =3D=3D CHIP_FAMILY_R350 ||
-	    rinfo->family =3D=3D CHIP_FAMILY_RV350) {
+	if (IS_R300_VARIANT(rinfo)) {
 		u32 tmp;
=20
 		OUTREG(RBBM_SOFT_RESET, (rbbm_soft_reset |
@@ -241,9 +239,7 @@ void radeonfb_engine_reset(struct radeonfb_info *rinf=
o)
 	INREG(HOST_PATH_CNTL);
 	OUTREG(HOST_PATH_CNTL, host_path_cntl);
=20
-	if (rinfo->family !=3D CHIP_FAMILY_R300 ||
-	    rinfo->family !=3D CHIP_FAMILY_R350 ||
-	    rinfo->family !=3D CHIP_FAMILY_RV350)
+	if (IS_R300_VARIANT(rinfo))
 		OUTREG(RBBM_SOFT_RESET, rbbm_soft_reset);
=20
 	OUTREG(CLOCK_CNTL_INDEX, clock_cntl_index);
@@ -254,16 +250,15 @@ void radeonfb_engine_init (struct radeonfb_info *ri=
nfo)
 {
 	unsigned long temp;
=20
-	/* disable 3D engine */
-	OUTREG(RB3D_CNTL, 0);
-
 	radeonfb_engine_reset(rinfo);
=20
 	radeon_fifo_wait (1);
-	if ((rinfo->family !=3D CHIP_FAMILY_R300) &&
-	    (rinfo->family !=3D CHIP_FAMILY_R350) &&
-	    (rinfo->family !=3D CHIP_FAMILY_RV350))
+	if (IS_R300_VARIANT(rinfo)) {
+		temp =3D INREG(RB2D_DSTCACHE_MODE);
+		OUTREG(RB2D_DSTCACHE_MODE, temp | (1<<17)); /* FIXME */
+	} else {
 		OUTREG(RB2D_DSTCACHE_MODE, 0);
+	}
=20
 	radeon_fifo_wait (3);
 	/* We re-read MC_FB_LOCATION from card as it can have been
diff --git a/drivers/video/aty/radeon_backlight.c b/drivers/video/aty/rad=
eon_backlight.c
index 3abfd4a..04e3963 100644
--- a/drivers/video/aty/radeon_backlight.c
+++ b/drivers/video/aty/radeon_backlight.c
@@ -58,7 +58,7 @@ static int radeon_bl_update_status(struct backlight_dev=
ice *bd)
 	u32 lvds_gen_cntl, tmpPixclksCntl;
 	int level;
=20
-	if (rinfo->mon1_type !=3D MT_LCD)
+	if (PRIMARY_MONITOR(rinfo) !=3D MT_LCD)
 		return 0;
=20
 	/* We turn off the LCD completely instead of just dimming the
@@ -146,7 +146,7 @@ void radeonfb_bl_init(struct radeonfb_info *rinfo)
 	struct radeon_bl_privdata *pdata;
 	char name[12];
=20
-	if (rinfo->mon1_type !=3D MT_LCD)
+	if (PRIMARY_MONITOR(rinfo) =3D=3D MT_LCD) {
 		return;
=20
 #ifdef CONFIG_PMAC_BACKLIGHT
diff --git a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_b=
ase.c
index 0ed577e..798fc37 100644
--- a/drivers/video/aty/radeon_base.c
+++ b/drivers/video/aty/radeon_base.c
@@ -3,6 +3,7 @@
  *
  *	framebuffer driver for ATI Radeon chipset video boards
  *
+ *	Copyright 2006	Solomon Peachy <pizza@shaftnet.org>
  *	Copyright 2003	Ben. Herrenschmidt <benh@kernel.crashing.org>
  *	Copyright 2000	Ani Joshi <ajoshi@kernel.crashing.org>
  *
@@ -50,7 +51,7 @@
  */
=20
=20
-#define RADEON_VERSION	"0.2.0"
+#define RADEON_VERSION	"0.3.0"
=20
 #include <linux/module.h>
 #include <linux/moduleparam.h>
@@ -110,7 +111,7 @@ static struct pci_device_id radeonfb_pci_table[] =3D =
{
 	/* Radeon IGP320M (U1) */
 	CHIP_DEF(PCI_CHIP_RS100_4336,	RS100,	CHIP_HAS_CRTC2 | CHIP_IS_IGP | CHI=
P_IS_MOBILITY),
 	/* Radeon IGP320 (A3) */
-	CHIP_DEF(PCI_CHIP_RS100_4136,	RS100,	CHIP_HAS_CRTC2 | CHIP_IS_IGP),=20
+	CHIP_DEF(PCI_CHIP_RS100_4136,	RS100,	CHIP_HAS_CRTC2 | CHIP_IS_IGP),
 	/* IGP330M/340M/350M (U2) */
 	CHIP_DEF(PCI_CHIP_RS200_4337,	RS200,	CHIP_HAS_CRTC2 | CHIP_IS_IGP | CHI=
P_IS_MOBILITY),
 	/* IGP330/340/350 (A4) */
@@ -180,6 +181,7 @@ static struct pci_device_id radeonfb_pci_table[] =3D =
{
 	CHIP_DEF(PCI_CHIP_RV360_AR,	RV350,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_RV350_AS,	RV350,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_RV350_AT,	RV350,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_RV350_AU, 	RV350,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_RV350_AV,	RV350,	CHIP_HAS_CRTC2),
 	/* 9800/Pro/FileGL X2 */
 	CHIP_DEF(PCI_CHIP_R350_AH,	R350,	CHIP_HAS_CRTC2),
@@ -190,7 +192,7 @@ static struct pci_device_id radeonfb_pci_table[] =3D =
{
 	CHIP_DEF(PCI_CHIP_R350_NI,	R350,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_R360_NJ,	R350,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_R350_NK,	R350,	CHIP_HAS_CRTC2),
-	/* Newer stuff */
+	/* X300/X600 */
 	CHIP_DEF(PCI_CHIP_RV380_3E50,	RV380,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_RV380_3E54,	RV380,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_RV380_3150,	RV380,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY)=
,
@@ -201,6 +203,19 @@ static struct pci_device_id radeonfb_pci_table[] =3D=
 {
 	CHIP_DEF(PCI_CHIP_RV370_5B65,	RV380,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_RV370_5460,	RV380,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY)=
,
 	CHIP_DEF(PCI_CHIP_RV370_5464,	RV380,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY)=
,
+	/* X700 */
+	CHIP_DEF(PCI_CHIP_RV410_VJ, 	RV410,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_RV410_VK, 	RV410,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_RV410_VO, 	RV410,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_RV410_VR, 	RV410,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_RV410_VS, 	RV410,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_RV410_5E48,	RV410,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_RV410_5E4A,	RV410,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_RV410_5E4B,	RV410,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_RV410_5E4C,	RV410,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_RV410_5E4D,	RV410,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_RV410_5E4F,	RV410,	CHIP_HAS_CRTC2),
+	/* X800/X850 */
 	CHIP_DEF(PCI_CHIP_R420_JH,	R420,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_R420_JI,	R420,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_R420_JJ,	R420,	CHIP_HAS_CRTC2),
@@ -208,7 +223,9 @@ static struct pci_device_id radeonfb_pci_table[] =3D =
{
 	CHIP_DEF(PCI_CHIP_R420_JL,	R420,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_R420_JM,	R420,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_R420_JN,	R420,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_R420_JO, 	R420,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_R420_JP,	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R420_JT, 	R420,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_R423_UH,	R420,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_R423_UI,	R420,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_R423_UJ,	R420,	CHIP_HAS_CRTC2),
@@ -217,6 +234,24 @@ static struct pci_device_id radeonfb_pci_table[] =3D=
 {
 	CHIP_DEF(PCI_CHIP_R423_UR,	R420,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_R423_UT,	R420,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_R423_5D57,	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R423_UP, 	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R423_5D49, 	R420,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_R423_5D4A, 	R420,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_R423_5D48, 	R420,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_R423_UO, 	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R423_UM, 	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R423_UN, 	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R423_UL, 	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R480_5D4C, 	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R480_5D50, 	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R480_5D4E, 	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R480_5D4F, 	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R480_5D52, 	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R480_5D4D, 	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R480_KJ, 	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R480_KK,    R420,     CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R480_KI, 	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R480_KL, 	R420,	CHIP_HAS_CRTC2),
 	/* Original Radeon/7200 */
 	CHIP_DEF(PCI_CHIP_RADEON_QD,	RADEON,	0),
 	CHIP_DEF(PCI_CHIP_RADEON_QE,	RADEON,	0),
@@ -237,7 +272,7 @@ typedef struct {
  * interfere with anything
  */
 static reg_val common_regs[] =3D {
-	{ OVR_CLR, 0 },=09
+	{ OVR_CLR, 0 },
 	{ OVR_WID_LEFT_RIGHT, 0 },
 	{ OVR_WID_TOP_BOTTOM, 0 },
 	{ OV0_SCALE_CNTL, 0 },
@@ -252,13 +287,13 @@ static reg_val common_regs[] =3D {
 /*
  * globals
  */
-       =20
 static char *mode_option;
 static char *monitor_layout;
 static int noaccel =3D 0;
 static int default_dynclk =3D -2;
 static int nomodeset =3D 0;
 static int ignore_edid =3D 0;
+static int ignore_conntable =3D 0;
 static int mirror =3D 0;
 static int panel_yres =3D 0;
 static int force_dfp =3D 0;
@@ -269,6 +304,12 @@ static int nomtrr =3D 0;
 static int force_sleep;
 static int ignore_devlist;
=20
+#ifdef CONFIG_FB_RADEON_DEBUG
+int radeonfb_debug =3D 1;
+#else
+int radeonfb_debug =3D 0;
+#endif
+
 /*
  * prototypes
  */
@@ -324,7 +365,7 @@ static int __devinit radeon_map_ROM(struct radeonfb_i=
nfo *rinfo, struct pci_dev
 	 * to phase out Open Firmware images.
 	 *
 	 * Currently, we only look at the first PCI data, we could iteratre and=
 deal with
-	 * them all, and we should use fb_bios_start relative to start of image=
 and not
+	 * them all, and we should use fp_bios_start relative to start of image=
 and not
 	 * relative start of ROM, but so far, I never found a dual-image ATI ca=
rd
 	 *
 	 * typedef struct {
@@ -410,7 +451,7 @@ static int  __devinit radeon_find_mem_vbios(struct ra=
deonfb_info *rinfo)
  * Read XTAL (ref clock), SCLK and MCLK from Open Firmware device
  * tree. Hopefully, ATI OF driver is kind enough to fill these
  */
-static int __devinit radeon_read_xtal_OF (struct radeonfb_info *rinfo)
+static int __devinit radeon_get_pll_info_openfirmware (struct radeonfb_i=
nfo *rinfo)
 {
 	struct device_node *dp =3D rinfo->of_node;
 	const u32 *val;
@@ -433,7 +474,8 @@ static int __devinit radeon_read_xtal_OF (struct rade=
onfb_info *rinfo)
 	if (val && *val)
 		rinfo->pll.mclk =3D (*val) / 10;
=20
-       	return 0;
+	RTRACE("Retrieved PLL infos from Open Firmware\n");
+	return 0;
 }
 #endif /* CONFIG_PPC_OF */
=20
@@ -575,10 +617,87 @@ static int __devinit radeon_probe_pll_params(struct=
 radeonfb_info *rinfo)
 	return 0;
 }
=20
+static int __devinit radeon_get_pll_info_legacy(struct radeonfb_info *ri=
nfo)
+{
+	u16 pll_info_block;
+
+	if (!rinfo->bios_seg)
+		return -EINVAL;
+
+	pll_info_block =3D BIOS_IN16(rinfo->fp_bios_start + 0x30);
+
+	rinfo->pll.sclk		=3D BIOS_IN16(pll_info_block + 0x08);
+	rinfo->pll.mclk		=3D BIOS_IN16(pll_info_block + 0x0a);
+	rinfo->pll.ref_clk	=3D BIOS_IN16(pll_info_block + 0x0e);
+	rinfo->pll.ref_div	=3D BIOS_IN16(pll_info_block + 0x10);
+	rinfo->pll.ppll_min	=3D BIOS_IN32(pll_info_block + 0x12);
+	rinfo->pll.ppll_max	=3D BIOS_IN32(pll_info_block + 0x16);
+
+	RTRACE("Retrieved PLL infos from Legacy BIOS\n");
+	return 0;
+}
+
+
+static int __devinit radeon_get_pll_info_atom(struct radeonfb_info *rinf=
o)
+{
+	u16 pll_info_block;
+
+	if (!rinfo->bios_seg)
+		return -EINVAL;
+
+	pll_info_block =3D BIOS_IN16(rinfo->atom_data_start + 12);
+
+	rinfo->pll.sclk =3D BIOS_IN32(pll_info_block + 8);
+	rinfo->pll.mclk =3D BIOS_IN32(pll_info_block + 12);
+	rinfo->pll.ref_clk =3D BIOS_IN16(pll_info_block + 82);
+	rinfo->pll.ref_div =3D 0; /* Have to get it elsewhere */
+	rinfo->pll.ppll_min =3D BIOS_IN16(pll_info_block + 78);
+	rinfo->pll.ppll_max =3D BIOS_IN32(pll_info_block + 32);
+
+	RTRACE("Retrieved PLL infos from ATOM BIOS\n");
+	return 0;
+}
+
+static void radeon_detect_bios_type(struct radeonfb_info *rinfo)
+{
+#ifdef CONFIG_PPC_OF
+	rinfo->is_atom_bios =3D 0;
+	rinfo->radeon_get_pll_info =3D radeon_get_pll_info_openfirmware;
+	rinfo->radeon_get_lvds_info =3D radeon_get_lvds_info_openfirmware;
+	rinfo->radeon_get_tmds_info =3D NULL;
+	rinfo->radeon_get_conn_info =3D radeon_get_conn_info_openfirmware;
+#else
+	int tmp =3D rinfo->fp_bios_start + 4;
+	unsigned char sign[4];
+
+	sign[0] =3D BIOS_IN8(tmp);
+	sign[1] =3D BIOS_IN8(tmp + 1);
+	sign[2] =3D BIOS_IN8(tmp + 2);
+	sign[3] =3D BIOS_IN8(tmp + 3);
+
+	if (!memcmp(sign, "ATOM", 4) || !memcmp(sign, "MOTA", 4)) {
+		rinfo->is_atom_bios =3D 1;
+
+		rinfo->atom_data_start =3D BIOS_IN16(rinfo->fp_bios_start + 32);
+		rinfo->radeon_get_pll_info =3D radeon_get_pll_info_atom;
+		rinfo->radeon_get_lvds_info =3D radeon_get_lvds_info_atom;
+		rinfo->radeon_get_conn_info =3D radeon_get_conn_info_atom;
+		rinfo->radeon_get_tmds_info =3D radeon_get_tmds_info_atom;
+	} else {
+		rinfo->is_atom_bios =3D 0;
+		rinfo->radeon_get_pll_info =3D radeon_get_pll_info_legacy;
+		rinfo->radeon_get_lvds_info =3D radeon_get_lvds_info_legacy;
+		rinfo->radeon_get_conn_info =3D radeon_get_conn_info_legacy;
+		rinfo->radeon_get_tmds_info =3D radeon_get_tmds_info_legacy;
+	}
+#endif  /* CONFIG_PPC_OF */
+
+}
+
 /*
  * Retrieve PLL infos by different means (BIOS, Open Firmware, register =
probing...)
  */
-static void __devinit radeon_get_pllinfo(struct radeonfb_info *rinfo)
+static void __devinit radeon_get_pll_info(struct radeonfb_info *rinfo)
 {
 	/*
 	 * In the case nothing works, these are defaults; they are mostly
@@ -630,46 +749,30 @@ static void __devinit radeon_get_pllinfo(struct rad=
eonfb_info *rinfo)
 	case PCI_DEVICE_ID_ATI_RADEON_QF:
 	case PCI_DEVICE_ID_ATI_RADEON_QG:
 	default:
-		rinfo->pll.ppll_max =3D 35000;
-		rinfo->pll.ppll_min =3D 12000;
+		if (rinfo->family =3D=3D CHIP_FAMILY_R420) {
+			rinfo->pll.ppll_max =3D 50000;
+			rinfo->pll.ppll_min =3D 20000;
+		} else {
+			rinfo->pll.ppll_max =3D 35000;
+			rinfo->pll.ppll_min =3D 12000;
+		}
 		rinfo->pll.mclk =3D 16600;
 		rinfo->pll.sclk =3D 16600;
 		rinfo->pll.ref_clk =3D 2700;
 		break;
 	}
-	rinfo->pll.ref_div =3D INPLL(PPLL_REF_DIV) & PPLL_REF_DIV_MASK;
=20
-
-#ifdef CONFIG_PPC_OF
 	/*
-	 * Retrieve PLL infos from Open Firmware first
+	 * If we have a way to retrieve the PLL information, do so.
 	 */
-       	if (!force_measure_pll && radeon_read_xtal_OF(rinfo) =3D=3D 0) {
-       		printk(KERN_INFO "radeonfb: Retrieved PLL infos from Open Firmw=
are\n");
-		goto found;
-	}
-#endif /* CONFIG_PPC_OF */
-
-	/*
-	 * Check out if we have an X86 which gave us some PLL informations
-	 * and if yes, retrieve them
-	 */
-	if (!force_measure_pll && rinfo->bios_seg) {
-		u16 pll_info_block =3D BIOS_IN16(rinfo->fp_bios_start + 0x30);
-
-		rinfo->pll.sclk		=3D BIOS_IN16(pll_info_block + 0x08);
-		rinfo->pll.mclk		=3D BIOS_IN16(pll_info_block + 0x0a);
-		rinfo->pll.ref_clk	=3D BIOS_IN16(pll_info_block + 0x0e);
-		rinfo->pll.ref_div	=3D BIOS_IN16(pll_info_block + 0x10);
-		rinfo->pll.ppll_min	=3D BIOS_IN32(pll_info_block + 0x12);
-		rinfo->pll.ppll_max	=3D BIOS_IN32(pll_info_block + 0x16);
-
-		printk(KERN_INFO "radeonfb: Retrieved PLL infos from BIOS\n");
-		goto found;
+	if (!force_measure_pll && rinfo->radeon_get_pll_info) {
+		if (!rinfo->radeon_get_pll_info(rinfo)) {
+			goto found;
+		}
 	}
=20
 	/*
-	 * We didn't get PLL parameters from either OF or BIOS, we try to
+	 * If we don't get the PLL parameters handed to us, we try to
 	 * probe them
 	 */
 	if (radeon_probe_pll_params(rinfo) =3D=3D 0) {
@@ -680,9 +783,25 @@ static void __devinit radeon_get_pllinfo(struct rade=
onfb_info *rinfo)
 	/*
 	 * Fall back to already-set defaults...
 	 */
-       	printk(KERN_INFO "radeonfb: Used default PLL infos\n");
+	printk(KERN_INFO "radeonfb: Used default PLL infos\n");
=20
 found:
+
+	/* Check and fix-up the PLL divisor if necessary */
+	if (rinfo->pll.ref_div < 2) {
+		int tmp =3D INPLL(PPLL_REF_DIV);
+		if (rinfo->family =3D=3D CHIP_FAMILY_RS300) {
+			rinfo->pll.ref_div =3D (tmp & R300_PPLL_REF_DIV_ACC_MASK) >> R300_PPL=
L_REF_DIV_ACC_SHIFT;
+		} else {
+			rinfo->pll.ref_div =3D tmp & PPLL_REF_DIV_MASK;
+		}
+
+		/* Sane default */
+		if (rinfo->pll.ref_div < 2) {
+			rinfo->pll.ref_div =3D 12;
+		}
+	}
+
 	/*
 	 * Some methods fail to retrieve SCLK and MCLK values, we apply default
 	 * settings in this case (200Mhz). If that really happne often, we coul=
d
@@ -698,7 +817,7 @@ found:
 	       rinfo->pll.ref_div,
 	       rinfo->pll.mclk / 100, rinfo->pll.mclk % 100,
 	       rinfo->pll.sclk / 100, rinfo->pll.sclk % 100);
-	printk("radeonfb: PLL min %d max %d\n", rinfo->pll.ppll_min, rinfo->pll=
.ppll_max);
+	RTRACE("PLL min %d max %d\n", rinfo->pll.ppll_min, rinfo->pll.ppll_max)=
;
 }
=20
 static int radeonfb_check_var (struct fb_var_screeninfo *var, struct fb_=
info *info)
@@ -839,7 +958,7 @@ static int radeonfb_pan_display (struct fb_var_screen=
info *var,
         if (rinfo->asleep)
         	return 0;
=20
-	radeon_fifo_wait(2);
+	radeon_engine_idle();
         OUTREG(CRTC_OFFSET, ((var->yoffset * var->xres_virtual + var->xo=
ffset)
 			     * var->bits_per_pixel / 8) & ~7);
         return 0;
@@ -920,9 +1039,10 @@ static int radeonfb_ioctl (struct fb_info *info, un=
signed int cmd,
=20
 int radeon_screen_blank(struct radeonfb_info *rinfo, int blank, int mode=
_switch)
 {
-        u32 val;
+	u32 val;
 	u32 tmp_pix_clks;
 	int unblank =3D 0;
+	int i;
=20
 	if (rinfo->lock_blank)
 		return 0;
@@ -930,9 +1050,9 @@ int radeon_screen_blank(struct radeonfb_info *rinfo,=
 int blank, int mode_switch)
 	radeon_engine_idle();
=20
 	val =3D INREG(CRTC_EXT_CNTL);
-        val &=3D ~(CRTC_DISPLAY_DIS | CRTC_HSYNC_DIS |
+	val &=3D ~(CRTC_DISPLAY_DIS | CRTC_HSYNC_DIS |
                  CRTC_VSYNC_DIS);
-        switch (blank) {
+	switch (blank) {
 	case FB_BLANK_VSYNC_SUSPEND:
 		val |=3D (CRTC_DISPLAY_DIS | CRTC_VSYNC_DIS);
 		break;
@@ -949,81 +1069,84 @@ int radeon_screen_blank(struct radeonfb_info *rinf=
o, int blank, int mode_switch)
 	case FB_BLANK_UNBLANK:
 	default:
 		unblank =3D 1;
-        }
+	}
 	OUTREG(CRTC_EXT_CNTL, val);
=20
+	for (i =3D 0 ; i < RADEON_MAX_CONNECTORS ; i++) {
+		if (rinfo->heads[i] =3D=3D -1)
+			continue;
=20
-	switch (rinfo->mon1_type) {
-	case MT_DFP:
-		if (unblank)
-			OUTREGP(FP_GEN_CNTL, (FP_FPON | FP_TMDS_EN),
-				~(FP_FPON | FP_TMDS_EN));
-		else {
-			if (mode_switch || blank =3D=3D FB_BLANK_NORMAL)
-				break;
-			OUTREGP(FP_GEN_CNTL, 0, ~(FP_FPON | FP_TMDS_EN));
-		}
+		switch (rinfo->connectors[rinfo->heads[i]].mon_type) {
+		case MT_DFP:
+			if (unblank)
+				OUTREGP(FP_GEN_CNTL, (FP_FPON | FP_TMDS_EN),
+					~(FP_FPON | FP_TMDS_EN));
+			else {
+				if (mode_switch || blank =3D=3D FB_BLANK_NORMAL)
+					break;
+				OUTREGP(FP_GEN_CNTL, 0, ~(FP_FPON | FP_TMDS_EN));
+			}
 		break;
-	case MT_LCD:
-		del_timer_sync(&rinfo->lvds_timer);
-		val =3D INREG(LVDS_GEN_CNTL);
-		if (unblank) {
-			u32 target_val =3D (val & ~LVDS_DISPLAY_DIS) | LVDS_BLON | LVDS_ON
-				| LVDS_EN | (rinfo->init_state.lvds_gen_cntl
-					     & (LVDS_DIGON | LVDS_BL_MOD_EN));
-			if ((val ^ target_val) =3D=3D LVDS_DISPLAY_DIS)
-				OUTREG(LVDS_GEN_CNTL, target_val);
-			else if ((val ^ target_val) !=3D 0) {
-				OUTREG(LVDS_GEN_CNTL, target_val
-				       & ~(LVDS_ON | LVDS_BL_MOD_EN));
-				rinfo->init_state.lvds_gen_cntl &=3D ~LVDS_STATE_MASK;
-				rinfo->init_state.lvds_gen_cntl |=3D
-					target_val & LVDS_STATE_MASK;
-				if (mode_switch) {
-					radeon_msleep(rinfo->panel_info.pwr_delay);
+		case MT_LCD:
+			del_timer_sync(&rinfo->lvds_timer);
+			val =3D INREG(LVDS_GEN_CNTL);
+			if (unblank) {
+				u32 target_val =3D (val & ~LVDS_DISPLAY_DIS) | LVDS_BLON | LVDS_ON
+					| LVDS_EN | (rinfo->init_state.lvds_gen_cntl
+						     & (LVDS_DIGON | LVDS_BL_MOD_EN));
+				if ((val ^ target_val) =3D=3D LVDS_DISPLAY_DIS)
 					OUTREG(LVDS_GEN_CNTL, target_val);
+				else if ((val ^ target_val) !=3D 0) {
+					OUTREG(LVDS_GEN_CNTL, target_val
+					       & ~(LVDS_ON | LVDS_BL_MOD_EN));
+					rinfo->init_state.lvds_gen_cntl &=3D ~LVDS_STATE_MASK;
+					rinfo->init_state.lvds_gen_cntl |=3D
+						target_val & LVDS_STATE_MASK;
+					if (mode_switch) {
+						radeon_msleep(rinfo->panel_info.pwr_delay);
+						OUTREG(LVDS_GEN_CNTL, target_val);
+					} else {
+						rinfo->pending_lvds_gen_cntl =3D target_val;
+						mod_timer(&rinfo->lvds_timer,
+							  jiffies +
+							  msecs_to_jiffies(rinfo->panel_info.pwr_delay));
+					}
 				}
-				else {
-					rinfo->pending_lvds_gen_cntl =3D target_val;
-					mod_timer(&rinfo->lvds_timer,
-					   jiffies +
-					   msecs_to_jiffies(rinfo->panel_info.pwr_delay));
-				}
+			} else {
+				val |=3D LVDS_DISPLAY_DIS;
+				OUTREG(LVDS_GEN_CNTL, val);
+
+				/* We don't do a full switch-off on a simple mode switch */
+				if (mode_switch || blank =3D=3D FB_BLANK_NORMAL)
+					break;
+
+				/* Asic bug, when turning off LVDS_ON, we have to make sure
+				 * RADEON_PIXCLK_LVDS_ALWAYS_ON bit is off
+				 */
+				tmp_pix_clks =3D INPLL(PIXCLKS_CNTL);
+				if (rinfo->is_mobility || rinfo->is_IGP)
+					OUTPLLP(PIXCLKS_CNTL, 0, ~PIXCLK_LVDS_ALWAYS_ONb);
+				val &=3D ~(LVDS_BL_MOD_EN);
+				OUTREG(LVDS_GEN_CNTL, val);
+				udelay(100);
+				val &=3D ~(LVDS_ON | LVDS_EN);
+				OUTREG(LVDS_GEN_CNTL, val);
+				val &=3D ~LVDS_DIGON;
+				rinfo->pending_lvds_gen_cntl =3D val;
+				mod_timer(&rinfo->lvds_timer,
+					  jiffies +
+					  msecs_to_jiffies(rinfo->panel_info.pwr_delay));
+				rinfo->init_state.lvds_gen_cntl &=3D ~LVDS_STATE_MASK;
+				rinfo->init_state.lvds_gen_cntl |=3D val & LVDS_STATE_MASK;
+				if (rinfo->is_mobility || rinfo->is_IGP)
+					OUTPLL(PIXCLKS_CNTL, tmp_pix_clks);
 			}
-		} else {
-			val |=3D LVDS_DISPLAY_DIS;
-			OUTREG(LVDS_GEN_CNTL, val);
-
-			/* We don't do a full switch-off on a simple mode switch */
-			if (mode_switch || blank =3D=3D FB_BLANK_NORMAL)
-				break;
-
-			/* Asic bug, when turning off LVDS_ON, we have to make sure
-			 * RADEON_PIXCLK_LVDS_ALWAYS_ON bit is off
-			 */
-			tmp_pix_clks =3D INPLL(PIXCLKS_CNTL);
-			if (rinfo->is_mobility || rinfo->is_IGP)
-				OUTPLLP(PIXCLKS_CNTL, 0, ~PIXCLK_LVDS_ALWAYS_ONb);
-			val &=3D ~(LVDS_BL_MOD_EN);
-			OUTREG(LVDS_GEN_CNTL, val);
-			udelay(100);
-			val &=3D ~(LVDS_ON | LVDS_EN);
-			OUTREG(LVDS_GEN_CNTL, val);
-			val &=3D ~LVDS_DIGON;
-			rinfo->pending_lvds_gen_cntl =3D val;
-			mod_timer(&rinfo->lvds_timer,
-				  jiffies +
-				  msecs_to_jiffies(rinfo->panel_info.pwr_delay));
-			rinfo->init_state.lvds_gen_cntl &=3D ~LVDS_STATE_MASK;
-			rinfo->init_state.lvds_gen_cntl |=3D val & LVDS_STATE_MASK;
-			if (rinfo->is_mobility || rinfo->is_IGP)
-				OUTPLL(PIXCLKS_CNTL, tmp_pix_clks);
+			break;
+		case MT_CRT:
+			// todo: powerdown DAC
+		default:
+			break;
 		}
-		break;
-	case MT_CRT:
-		// todo: powerdown DAC
-	default:
-		break;
 	}
=20
 	/* let fbcon do a soft blank for us */
@@ -1254,7 +1377,7 @@ static void radeon_write_pll_regs(struct radeonfb_i=
nfo *rinfo, struct radeon_reg
 				~PPLL_DIV_SEL_MASK);
 			radeon_pll_errata_after_index(rinfo);
 			radeon_pll_errata_after_data(rinfo);
-            		return;
+			return;
 		}
 	}
=20
@@ -1274,10 +1397,7 @@ static void radeon_write_pll_regs(struct radeonfb_=
info *rinfo, struct radeon_reg
 	radeon_pll_errata_after_data(rinfo);
=20
 	/* Set PPLL ref. div */
-	if (rinfo->family =3D=3D CHIP_FAMILY_R300 ||
-	    rinfo->family =3D=3D CHIP_FAMILY_RS300 ||
-	    rinfo->family =3D=3D CHIP_FAMILY_R350 ||
-	    rinfo->family =3D=3D CHIP_FAMILY_RV350) {
+	if (IS_R300_VARIANT(rinfo) || (rinfo->family =3D=3D CHIP_FAMILY_RS300))=
 {
 		if (mode->ppll_ref_div & R300_PPLL_REF_DIV_ACC_MASK) {
 			/* When restoring console mode, use saved PPLL_REF_DIV
 			 * setting.
@@ -1286,7 +1406,7 @@ static void radeon_write_pll_regs(struct radeonfb_i=
nfo *rinfo, struct radeon_reg
 		} else {
 			/* R300 uses ref_div_acc field as real ref divider */
 			OUTPLLP(PPLL_REF_DIV,
-				(mode->ppll_ref_div << R300_PPLL_REF_DIV_ACC_SHIFT),=20
+				(mode->ppll_ref_div << R300_PPLL_REF_DIV_ACC_SHIFT),
 				~R300_PPLL_REF_DIV_ACC_MASK);
 		}
 	} else
@@ -1374,6 +1494,7 @@ void radeon_write_mode (struct radeonfb_info *rinfo=
, struct radeon_regs *mode,
 	OUTREG(CRTC_OFFSET_CNTL, 0);
 	OUTREG(CRTC_PITCH, mode->crtc_pitch);
 	OUTREG(SURFACE_CNTL, mode->surface_cntl);
+	OUTREG(DISP_MERGE_CNTL, 0xffff0000);
=20
 	radeon_write_pll_regs(rinfo, mode);
=20
@@ -1884,7 +2005,7 @@ static int __devinit radeon_set_fbinfo (struct rade=
onfb_info *rinfo)
         info->fix.ywrapstep =3D 0;
         info->fix.type_aux =3D 0;
         info->fix.mmio_start =3D rinfo->mmio_base_phys;
-        info->fix.mmio_len =3D RADEON_REGSIZE;
+        info->fix.mmio_len =3D pci_resource_len(rinfo->pdev, 2);
 	info->fix.accel =3D FB_ACCEL_ATI_RADEON;
=20
 	fb_alloc_cmap(&info->cmap, 256, 0);
@@ -1988,9 +2109,7 @@ static void radeon_identify_vram(struct radeonfb_in=
fo *rinfo)
 	u32 tmp;
=20
 	/* framebuffer size */
-        if ((rinfo->family =3D=3D CHIP_FAMILY_RS100) ||
-            (rinfo->family =3D=3D CHIP_FAMILY_RS200) ||
-            (rinfo->family =3D=3D CHIP_FAMILY_RS300)) {
+        if (rinfo->is_IGP) {
           u32 tom =3D INREG(NB_TOM);
           tmp =3D ((((tom >> 16) - (tom & 0xffff) + 1) << 6) * 1024);
=20
@@ -2018,6 +2137,10 @@ static void radeon_identify_vram(struct radeonfb_i=
nfo *rinfo)
 	/* mem size is bits [28:0], mask off the rest */
 	rinfo->video_ram =3D tmp & CONFIG_MEMSIZE_MASK;
=20
+	/* Limit memory to 128 megs for now */
+	if (rinfo->video_ram > MAX_VRAM)
+		rinfo->video_ram =3D MAX_VRAM;
+
 	/*
 	 * Hack to get around some busted production M6's
 	 * reporting no ram
@@ -2099,10 +2222,10 @@ static ssize_t radeon_show_edid1(struct kobject *=
kobj, char *buf, loff_t off, si
 {
 	struct device *dev =3D container_of(kobj, struct device, kobj);
 	struct pci_dev *pdev =3D to_pci_dev(dev);
-        struct fb_info *info =3D pci_get_drvdata(pdev);
-        struct radeonfb_info *rinfo =3D info->par;
+	struct fb_info *info =3D pci_get_drvdata(pdev);
+	struct radeonfb_info *rinfo =3D info->par;
=20
-	return radeon_show_one_edid(buf, off, count, rinfo->mon1_EDID);
+	return radeon_show_one_edid(buf, off, count, rinfo->connectors[rinfo->h=
eads[0]].edid);
 }
=20
=20
@@ -2110,10 +2233,30 @@ static ssize_t radeon_show_edid2(struct kobject *=
kobj, char *buf, loff_t off, si
 {
 	struct device *dev =3D container_of(kobj, struct device, kobj);
 	struct pci_dev *pdev =3D to_pci_dev(dev);
-        struct fb_info *info =3D pci_get_drvdata(pdev);
-        struct radeonfb_info *rinfo =3D info->par;
+	struct fb_info *info =3D pci_get_drvdata(pdev);
+	struct radeonfb_info *rinfo =3D info->par;
+
+	return radeon_show_one_edid(buf, off, count, rinfo->connectors[rinfo->h=
eads[1]].edid);
+}
+
+static ssize_t radeon_show_edid3(struct kobject *kobj, char *buf, loff_t=
 off, size_t count)
+{
+	struct device *dev =3D container_of(kobj, struct device, kobj);
+	struct pci_dev *pdev =3D to_pci_dev(dev);
+	struct fb_info *info =3D pci_get_drvdata(pdev);
+	struct radeonfb_info *rinfo =3D info->par;
+
+	return radeon_show_one_edid(buf, off, count, rinfo->connectors[rinfo->h=
eads[2]].edid);
+}
+
+static ssize_t radeon_show_edid4(struct kobject *kobj, char *buf, loff_t=
 off, size_t count)
+{
+	struct device *dev =3D container_of(kobj, struct device, kobj);
+	struct pci_dev *pdev =3D to_pci_dev(dev);
+	struct fb_info *info =3D pci_get_drvdata(pdev);
+	struct radeonfb_info *rinfo =3D info->par;
=20
-	return radeon_show_one_edid(buf, off, count, rinfo->mon2_EDID);
+	return radeon_show_one_edid(buf, off, count, rinfo->connectors[rinfo->h=
eads[3]].edid);
 }
=20
 static struct bin_attribute edid1_attr =3D {
@@ -2136,6 +2279,25 @@ static struct bin_attribute edid2_attr =3D {
 	.read	=3D radeon_show_edid2,
 };
=20
+static struct bin_attribute edid3_attr =3D {
+	.attr   =3D {
+		.name	=3D "edid3",
+		.owner	=3D THIS_MODULE,
+		.mode	=3D 0444,
+	},
+	.size	=3D EDID_LENGTH,
+	.read	=3D radeon_show_edid3,
+};
+
+static struct bin_attribute edid4_attr =3D {
+	.attr   =3D {
+		.name	=3D "edid4",
+		.owner	=3D THIS_MODULE,
+		.mode	=3D 0444,
+	},
+	.size	=3D EDID_LENGTH,
+	.read	=3D radeon_show_edid4,
+};
=20
 static int __devinit radeonfb_pci_register (struct pci_dev *pdev,
 				  const struct pci_device_id *ent)
@@ -2143,9 +2305,10 @@ static int __devinit radeonfb_pci_register (struct=
 pci_dev *pdev,
 	struct fb_info *info;
 	struct radeonfb_info *rinfo;
 	int ret;
+	int i;
=20
 	RTRACE("radeonfb_pci_register BEGIN\n");
-=09
+
 	/* Enable device in PCI config */
 	ret =3D pci_enable_device(pdev);
 	if (ret < 0) {
@@ -2162,9 +2325,9 @@ static int __devinit radeonfb_pci_register (struct =
pci_dev *pdev,
 		goto err_disable;
 	}
 	rinfo =3D info->par;
-	rinfo->info =3D info;=09
+	rinfo->info =3D info;
 	rinfo->pdev =3D pdev;
-=09
+
 	spin_lock_init(&rinfo->reg_lock);
 	init_timer(&rinfo->lvds_timer);
 	rinfo->lvds_timer.function =3D radeon_lvds_timer_func;
@@ -2199,7 +2362,8 @@ static int __devinit radeonfb_pci_register (struct =
pci_dev *pdev,
 	}
=20
 	/* map the regions */
-	rinfo->mmio_base =3D ioremap(rinfo->mmio_base_phys, RADEON_REGSIZE);
+	rinfo->mmio_base =3D ioremap(rinfo->mmio_base_phys,
+				   pci_resource_len(rinfo->pdev, 2));
 	if (!rinfo->mmio_base) {
 		printk(KERN_ERR "radeonfb (%s): cannot map MMIO\n",
 		       pci_name(rinfo->pdev));
@@ -2249,7 +2413,7 @@ static int __devinit radeonfb_pci_register (struct =
pci_dev *pdev,
 	rinfo->mapped_vram =3D min_t(unsigned long, MAX_MAPPED_VRAM, rinfo->vid=
eo_ram);
=20
 	do {
-		rinfo->fb_base =3D ioremap (rinfo->fb_base_phys,
+		rinfo->fb_base =3D ioremap(rinfo->fb_base_phys,
 					  rinfo->mapped_vram);
 	} while (   rinfo->fb_base =3D=3D 0 &&
 		  ((rinfo->mapped_vram /=3D2) >=3D MIN_MAPPED_VRAM) );
@@ -2284,6 +2448,7 @@ static int __devinit radeonfb_pci_register (struct =
pci_dev *pdev,
 	 * We probably need to make sure this is the primary display,
 	 * but that is difficult without some arch support.
 	 */
+
 #ifdef CONFIG_X86
 	if (rinfo->bios_seg =3D=3D NULL)
 		radeon_find_mem_vbios(rinfo);
@@ -2295,14 +2460,23 @@ static int __devinit radeonfb_pci_register (struc=
t pci_dev *pdev,
 	if (rinfo->bios_seg =3D=3D NULL && rinfo->is_mobility)
 		radeon_map_ROM(rinfo, pdev);
=20
+	/* Check BIOS Type */
+	radeon_detect_bios_type(rinfo);
+
 	/* Get informations about the board's PLL */
-	radeon_get_pllinfo(rinfo);
+	radeon_get_pll_info(rinfo);
+
+	/* Get informations about internal TMDS controller if any */
+	radeon_get_tmds_info(rinfo);
=20
 #ifdef CONFIG_FB_RADEON_I2C
 	/* Register I2C bus */
 	radeon_create_i2c_busses(rinfo);
 #endif
=20
+	/* Get infos about connectors -- need I2C here! */
+	radeon_get_conn_info(rinfo, ignore_conntable);
+
 	/* set all the vital stuff */
 	radeon_set_fbinfo (rinfo);
=20
@@ -2313,10 +2487,15 @@ static int __devinit radeonfb_pci_register (struc=
t pci_dev *pdev,
 	radeon_check_modes(rinfo, mode_option);
=20
 	/* Register some sysfs stuff (should be done better) */
-	if (rinfo->mon1_EDID)
+
+	if ((rinfo->heads[0] !=3D -1) && rinfo->connectors[rinfo->heads[0]].edi=
d)
 		sysfs_create_bin_file(&rinfo->pdev->dev.kobj, &edid1_attr);
-	if (rinfo->mon2_EDID)
+	if ((rinfo->heads[1] !=3D -1) && rinfo->connectors[rinfo->heads[1]].edi=
d)
 		sysfs_create_bin_file(&rinfo->pdev->dev.kobj, &edid2_attr);
+	if ((rinfo->heads[2] !=3D -1) && rinfo->connectors[rinfo->heads[2]].edi=
d)
+		sysfs_create_bin_file(&rinfo->pdev->dev.kobj, &edid3_attr);
+	if ((rinfo->heads[3] !=3D -1) && rinfo->connectors[rinfo->heads[3]].edi=
d)
+		sysfs_create_bin_file(&rinfo->pdev->dev.kobj, &edid4_attr);
=20
 	/* save current mode regs before we switch into the new one
 	 * so we can restore this upon __exit
@@ -2361,10 +2540,12 @@ static int __devinit radeonfb_pci_register (struc=
t pci_dev *pdev,
 err_unmap_fb:
 	iounmap(rinfo->fb_base);
 err_unmap_rom:
-	kfree(rinfo->mon1_EDID);
-	kfree(rinfo->mon2_EDID);
-	if (rinfo->mon1_modedb)
-		fb_destroy_modedb(rinfo->mon1_modedb);
+	for (i =3D 0 ; i < RADEON_MAX_CONNECTORS ; i++) {
+		kfree(rinfo->connectors[i].edid);
+		if (rinfo->connectors[i].modedb)
+			fb_destroy_modedb(rinfo->connectors[i].modedb);
+	}
+
 	fb_dealloc_cmap(&info->cmap);
 #ifdef CONFIG_FB_RADEON_I2C
 	radeon_delete_i2c_busses(rinfo);
@@ -2377,7 +2558,7 @@ err_release_pci2:
 err_release_pci0:
 	pci_release_region(pdev, 0);
 err_release_fb:
-        framebuffer_release(info);
+	framebuffer_release(info);
 err_disable:
 err_out:
 	return ret;
@@ -2389,18 +2570,23 @@ static void __devexit radeonfb_pci_unregister (st=
ruct pci_dev *pdev)
 {
         struct fb_info *info =3D pci_get_drvdata(pdev);
         struct radeonfb_info *rinfo =3D info->par;
-=20
+	int i;
+
         if (!rinfo)
                 return;
=20
 	radeonfb_bl_exit(rinfo);
 	radeonfb_pm_exit(rinfo);
=20
-	if (rinfo->mon1_EDID)
+	if ((rinfo->heads[0] !=3D -1) && rinfo->connectors[rinfo->heads[0]].edi=
d)
 		sysfs_remove_bin_file(&rinfo->pdev->dev.kobj, &edid1_attr);
-	if (rinfo->mon2_EDID)
+	if ((rinfo->heads[1] !=3D -1) && rinfo->connectors[rinfo->heads[1]].edi=
d)
 		sysfs_remove_bin_file(&rinfo->pdev->dev.kobj, &edid2_attr);
-
+	if ((rinfo->heads[2] !=3D -1) && rinfo->connectors[rinfo->heads[2]].edi=
d)
+		sysfs_remove_bin_file(&rinfo->pdev->dev.kobj, &edid3_attr);
+	if ((rinfo->heads[3] !=3D -1) && rinfo->connectors[rinfo->heads[3]].edi=
d)
+		sysfs_remove_bin_file(&rinfo->pdev->dev.kobj, &edid4_attr);
+=20
 #if 0
 	/* restore original state
 	 *=20
@@ -2426,13 +2612,14 @@ static void __devexit radeonfb_pci_unregister (st=
ruct pci_dev *pdev)
 	pci_release_region(pdev, 2);
 	pci_release_region(pdev, 0);
=20
-	kfree(rinfo->mon1_EDID);
-	kfree(rinfo->mon2_EDID);
-	if (rinfo->mon1_modedb)
-		fb_destroy_modedb(rinfo->mon1_modedb);
+	for (i =3D 0; i < RADEON_MAX_CONNECTORS; i++) {
+		kfree(rinfo->connectors[i].edid);
+		if (rinfo->connectors[i].modedb)
+			fb_destroy_modedb(rinfo->connectors[i].modedb);
+	}
 #ifdef CONFIG_FB_RADEON_I2C
 	radeon_delete_i2c_busses(rinfo);
-#endif       =20
+#endif
 	fb_dealloc_cmap(&info->cmap);
         framebuffer_release(info);
 }
@@ -2479,12 +2666,18 @@ static int __init radeonfb_setup (char *options)
 			force_measure_pll =3D 1;
 		} else if (!strncmp(this_opt, "ignore_edid", 11)) {
 			ignore_edid =3D 1;
+		} else if (!strncmp(this_opt, "ignore_conntable", 16)) {
+			ignore_conntable =3D 1;
+		} else if (!strncmp( this_opt, "default_dynclk:", 15)) {
+			default_dynclk =3D simple_strtoul((this_opt+15), NULL, 10);
 #if defined(CONFIG_PM) && defined(CONFIG_X86)
-	 	} else if (!strncmp(this_opt, "force_sleep", 11)) {
+		} else if (!strncmp(this_opt, "force_sleep", 11)) {
 			force_sleep =3D 1;
 		} else if (!strncmp(this_opt, "ignore_devlist", 14)) {
 			ignore_devlist =3D 1;
 #endif
+		} else if (!strncmp(this_opt, "debug", 5)) {
+			radeonfb_debug =3D 1;
 		} else
 			mode_option =3D this_opt;
 	}
@@ -2528,6 +2721,8 @@ module_param(force_dfp, bool, 0);
 MODULE_PARM_DESC(force_dfp, "bool: force display to dfp");
 module_param(ignore_edid, bool, 0);
 MODULE_PARM_DESC(ignore_edid, "bool: Ignore EDID data when doing DDC pro=
be");
+module_param(ignore_conntable, bool, 0);
+MODULE_PARM_DESC(ignore_conntable, "bool: Ignore BIOS Connector table");
 module_param(monitor_layout, charp, 0);
 MODULE_PARM_DESC(monitor_layout, "Specify monitor mapping (like XFree86)=
");
 module_param(force_measure_pll, bool, 0);
@@ -2546,3 +2741,5 @@ MODULE_PARM_DESC(force_sleep, "bool: force D2 sleep=
 mode on all hardware");
 module_param(ignore_devlist, bool, 0);
 MODULE_PARM_DESC(ignore_devlist, "bool: ignore workarounds for bugs in s=
pecific laptops");
 #endif
+module_param(radeonfb_debug, int, 0);
+MODULE_PARM_DESC(radeonfb_debug, "Enable full debugging text");
diff --git a/drivers/video/aty/radeon_i2c.c b/drivers/video/aty/radeon_i2=
c.c
index e7c5b21..92b492d 100644
--- a/drivers/video/aty/radeon_i2c.c
+++ b/drivers/video/aty/radeon_i2c.c
@@ -136,35 +136,57 @@ void radeon_delete_i2c_busses(struct radeonfb_info =
*rinfo)
 	rinfo->i2c[3].rinfo =3D NULL;
 }
=20
-int radeon_probe_i2c_connector(struct radeonfb_info *rinfo, int conn,
-			       u8 **out_edid)
+
+int radeon_probe_i2c_connector(struct radeonfb_info *rinfo, struct radeo=
n_connector *conn)
 {
-	u32 reg =3D rinfo->i2c[conn-1].ddc_reg;
+	int mon_type =3D MT_NONE;
 	u8 *edid;
=20
-	OUTREG(reg, INREG(reg) &
-			~(VGA_DDC_DATA_OUTPUT | VGA_DDC_CLK_OUTPUT));
+	if (!conn)
+		return 1;
+
+	if (rinfo->is_mobility && (conn->ddc_type =3D=3D ddc_none) &&
+	    (INREG(LVDS_GEN_CNTL) & (LVDS_ON|LVDS_EN))) {
+			RTRACE("radeonfb: I2C (port %d) ... found LVDS panel\n", conn->ddc_ty=
pe);
+			mon_type =3D MT_LCD;
+			edid =3D NULL;
+			goto done;
+	}
=20
-	edid =3D fb_ddc_read(&rinfo->i2c[conn-1].adapter);
+	if (conn->ddc_type =3D=3D ddc_none)
+		return 1;
+	edid =3D fb_ddc_read(&rinfo->i2c[conn->ddc_type].adapter);
=20
-	if (out_edid)
-		*out_edid =3D edid;
 	if (!edid) {
-		RTRACE("radeonfb: I2C (port %d) ... not found\n", conn);
-		return MT_NONE;
+		/* what about the special case where we are a DFP/LVDS, but have a DDC=
 connection
+		 * but no EDID? We should fall back to MT_LCD...?  XXXX
+		 */
+		RTRACE("radeonfb: I2C (port %d) ... not found\n", conn->ddc_type);
+		mon_type =3D MT_NONE;
+		goto done;
+	}
+	if ((edid[EDID_STRUCT_DISPLAY] & 0x80) && (conn->ddc_type =3D=3D ddc_dv=
i)) {
+		RTRACE("radeonfb: I2C (port %d) ... found TMDS panel\n", conn->ddc_typ=
e);
+		mon_type =3D MT_DFP;
+		goto done;
 	}
-	if (edid[0x14] & 0x80) {
-		/* Fix detection using BIOS tables */
-		if (rinfo->is_mobility /*&& conn =3D=3D ddc_dvi*/ &&
-		    (INREG(LVDS_GEN_CNTL) & LVDS_ON)) {
-			RTRACE("radeonfb: I2C (port %d) ... found LVDS panel\n", conn);
-			return MT_LCD;
-		} else {
-			RTRACE("radeonfb: I2C (port %d) ... found TMDS panel\n", conn);
-			return MT_DFP;
-		}
+
+	if (rinfo->is_mobility &&
+	    (conn->conn_type =3D=3D conn_lvds) &&
+	    (edid[EDID_STRUCT_DISPLAY] & 0x80) &&  // ie EDID valid and marks u=
s as a DFP...
+	    (INREG(LVDS_GEN_CNTL) & (LVDS_ON|LVDS_EN))) {
+		RTRACE("radeonfb: I2C (port %d) ... found LVDS panel\n", conn->ddc_typ=
e);
+		mon_type =3D MT_LCD;
+		goto done;
 	}
-       	RTRACE("radeonfb: I2C (port %d) ... found CRT display\n", conn);
-	return MT_CRT;
+
+	RTRACE("radeonfb: I2C (port %d) ... found CRT display\n", conn->ddc_typ=
e);
+	mon_type =3D MT_CRT;
+
+done:
+	conn->edid =3D edid;
+	conn->mon_type =3D mon_type;
+
+	return (mon_type =3D=3D MT_NONE);
 }
=20
diff --git a/drivers/video/aty/radeon_monitor.c b/drivers/video/aty/radeo=
n_monitor.c
index 38c7dbf..2b1d71c 100644
--- a/drivers/video/aty/radeon_monitor.c
+++ b/drivers/video/aty/radeon_monitor.c
@@ -1,6 +1,29 @@
 #include "radeonfb.h"
 #include "../edid.h"
=20
+/*
+ * TMDS PLL configuration table, taken from X.org
+ */
+static const struct radeon_tmds_pll_info default_tmds_pll[CHIP_FAMILY_LA=
ST][4] =3D
+{
+	{{0, 0}, {0, 0}, {0, 0}, {0, 0}},				/*CHIP_FAMILY_UNKNOW*/
+	{{0, 0}, {0, 0}, {0, 0}, {0, 0}},				/*CHIP_FAMILY_LEGACY*/
+	{{12000, 0xa1b}, {0xffffffff, 0xa3f}, {0, 0}, {0, 0}},		/*CHIP_FAMILY_R=
ADEON*/
+	{{12000, 0xa1b}, {0xffffffff, 0xa3f}, {0, 0}, {0, 0}},		/*CHIP_FAMILY_R=
V100*/
+	{{0, 0}, {0, 0}, {0, 0}, {0, 0}},				/*CHIP_FAMILY_RS100*/
+	{{15000, 0xa1b}, {0xffffffff, 0xa3f}, {0, 0}, {0, 0}},		/*CHIP_FAMILY_R=
V200*/
+	{{12000, 0xa1b}, {0xffffffff, 0xa3f}, {0, 0}, {0, 0}},		/*CHIP_FAMILY_R=
S200*/
+	{{15000, 0xa1b}, {0xffffffff, 0xa3f}, {0, 0}, {0, 0}},		/*CHIP_FAMILY_R=
200*/
+	{{15500, 0x81b}, {0xffffffff, 0x83f}, {0, 0}, {0, 0}},		/*CHIP_FAMILY_R=
V250*/
+	{{0, 0}, {0, 0}, {0, 0}, {0, 0}},				/*CHIP_FAMILY_RS300*/
+	{{13000, 0x400f4}, {15000, 0x400f7}, {0xffffffff, 0x400f7}, {0, 0}},	/*=
CHIP_FAMILY_RV280*/
+	{{0xffffffff, 0xb01cb}, {0, 0}, {0, 0}, {0, 0}},		/*CHIP_FAMILY_R300*/
+	{{0xffffffff, 0xb01cb}, {0, 0}, {0, 0}, {0, 0}},		/*CHIP_FAMILY_R350*/
+	{{15000, 0xb0155}, {0xffffffff, 0xb01cb}, {0, 0}, {0, 0}},	/*CHIP_FAMIL=
Y_RV350*/
+	{{15000, 0xb0155}, {0xffffffff, 0xb01cb}, {0, 0}, {0, 0}},	/*CHIP_FAMIL=
Y_RV380*/
+	{{0xffffffff, 0xb01cb}, {0, 0}, {0, 0}, {0, 0}},		/*CHIP_FAMILY_R420*/
+};
+
 static struct fb_var_screeninfo radeonfb_default_var =3D {
 	.xres		=3D 640,
 	.yres		=3D 480,
@@ -23,35 +46,311 @@ static struct fb_var_screeninfo radeonfb_default_var=
 =3D {
 	.vmode		=3D FB_VMODE_NONINTERLACED
 };
=20
-static char *radeon_get_mon_name(int type)
+
+int __devinit radeon_get_lvds_info_atom(struct radeonfb_info *rinfo)
 {
-	char *pret =3D NULL;
+	unsigned long tmp;
=20
-	switch (type) {
-		case MT_NONE:
-			pret =3D "no";
-			break;
-		case MT_CRT:
-			pret =3D "CRT";
-			break;
-		case MT_DFP:
-			pret =3D "DFP";
-			break;
-		case MT_LCD:
-			pret =3D "LCD";
-			break;
-		case MT_CTV:
-			pret =3D "CTV";
-			break;
-		case MT_STV:
-			pret =3D "STV";
+	if (!rinfo->bios_seg)
+		return -ENODEV;
+
+	tmp =3D BIOS_IN16(rinfo->atom_data_start + 16);
+	if (!tmp) {
+		RTRACE("No LVDS panel info in ATOM BIOS\n");
+		rinfo->panel_info.pwr_delay =3D 200;
+		return -ENODEV;
+	}
+
+	rinfo->panel_info.xres =3D BIOS_IN16(tmp+6);
+	rinfo->panel_info.yres =3D BIOS_IN16(tmp+10);
+	printk("radeonfb: detected LVDS panel size from BIOS: %dx%d\n",
+	       rinfo->panel_info.xres, rinfo->panel_info.yres);
+	rinfo->panel_info.pwr_delay =3D BIOS_IN16(tmp+40);
+	RTRACE("BIOS provided panel power delay: %d\n", rinfo->panel_info.pwr_d=
elay);
+	if (rinfo->panel_info.pwr_delay > 2000 || rinfo->panel_info.pwr_delay <=
=3D 0)
+		rinfo->panel_info.pwr_delay =3D 2000;
+
+	/* No special divider combinations? */
+
+	rinfo->panel_info.hblank =3D BIOS_IN16(tmp+8);
+	rinfo->panel_info.hOver_plus =3D BIOS_IN16(tmp+14);
+	rinfo->panel_info.hSync_width =3D BIOS_IN16(tmp+16);
+	rinfo->panel_info.vblank =3D BIOS_IN16(tmp+12);
+	rinfo->panel_info.vOver_plus =3D BIOS_IN16(tmp+18);
+	rinfo->panel_info.vSync_width =3D BIOS_IN16(tmp+20);
+	rinfo->panel_info.clock =3D BIOS_IN16(tmp+4);
+
+	/* Assume high active syncs for now until ATI tells me more... maybe we
+	 * can probe register values here ?
+	 */
+	rinfo->panel_info.hAct_high =3D 1;
+	rinfo->panel_info.vAct_high =3D 1;
+	/* Mark panel infos valid */
+	rinfo->panel_info.valid =3D 1;
+
+	return 0;
+}
+
+int __devinit radeon_get_lvds_info_legacy(struct radeonfb_info *rinfo)
+{
+	unsigned long tmp, tmp0;
+	char stmp[30];
+	int i;
+
+	if (!rinfo->bios_seg)
+		return -ENODEV;
+
+	if (!(tmp =3D BIOS_IN16(rinfo->fp_bios_start + 0x40))) {
+		RTRACE("No LVDS panel info in Legacy BIOS\n");
+		rinfo->panel_info.pwr_delay =3D 200;
+		return -ENODEV;
+	}
+
+	for(i =3D 0; i < 24; i++)
+		stmp[i] =3D BIOS_IN8(tmp + i + 1);
+	stmp[24] =3D 0;
+	printk("radeonfb: panel ID string: %s\n", stmp);
+	rinfo->panel_info.xres =3D BIOS_IN16(tmp + 25);
+	rinfo->panel_info.yres =3D BIOS_IN16(tmp + 27);
+	printk("radeonfb: detected LVDS panel size from BIOS: %dx%d\n",
+	       rinfo->panel_info.xres, rinfo->panel_info.yres);
+
+	rinfo->panel_info.pwr_delay =3D BIOS_IN16(tmp + 44);
+	RTRACE("BIOS provided panel power delay: %d\n", rinfo->panel_info.pwr_d=
elay);
+	if (rinfo->panel_info.pwr_delay > 2000 || rinfo->panel_info.pwr_delay <=
=3D 0)
+		rinfo->panel_info.pwr_delay =3D 2000;
+
+	/*
+	 * Some panels only work properly with some divider combinations
+	 */
+	rinfo->panel_info.ref_divider =3D BIOS_IN16(tmp + 46);
+	rinfo->panel_info.post_divider =3D BIOS_IN8(tmp + 48);
+	rinfo->panel_info.fbk_divider =3D BIOS_IN16(tmp + 49);
+	if (rinfo->panel_info.ref_divider !=3D 0 &&
+	    rinfo->panel_info.fbk_divider > 3) {
+		rinfo->panel_info.use_bios_dividers =3D 1;
+		printk(KERN_INFO "radeondb: BIOS provided dividers will be used\n");
+		RTRACE("ref_divider =3D %x\n", rinfo->panel_info.ref_divider);
+		RTRACE("post_divider =3D %x\n", rinfo->panel_info.post_divider);
+		RTRACE("fbk_divider =3D %x\n", rinfo->panel_info.fbk_divider);
+	}
+
+	RTRACE("Scanning BIOS table ...\n");
+	for(i =3D 0; i < 32; i++) {
+		tmp0 =3D BIOS_IN16(tmp + 64 + i*2);
+		if (tmp0 =3D=3D 0)
 			break;
+		RTRACE(" %d x %d\n", BIOS_IN16(tmp0), BIOS_IN16(tmp0 + 2));
+		if ((BIOS_IN16(tmp0) =3D=3D rinfo->panel_info.xres) &&
+		    (BIOS_IN16(tmp0 + 2) =3D=3D rinfo->panel_info.yres)) {
+			rinfo->panel_info.hblank =3D (BIOS_IN16(tmp0 + 17) - BIOS_IN16(tmp0 +=
 19)) * 8;
+			rinfo->panel_info.hOver_plus =3D ((BIOS_IN16(tmp0 + 21) -
+							 BIOS_IN16(tmp0 + 19) -1) * 8) & 0x7fff;
+			rinfo->panel_info.hSync_width =3D BIOS_IN8(tmp0 + 23) * 8;
+			rinfo->panel_info.vblank =3D BIOS_IN16(tmp0 + 24) - BIOS_IN16(tmp0 + =
26);
+			rinfo->panel_info.vOver_plus =3D (BIOS_IN16(tmp0 + 28) & 0x7ff) - BIO=
S_IN16(tmp0 + 26);
+			rinfo->panel_info.vSync_width =3D (BIOS_IN16(tmp0 + 28) & 0xf800) >> =
11;
+			rinfo->panel_info.clock =3D BIOS_IN16(tmp0 + 9);
+			/* Assume high active syncs for now until ATI tells me more... maybe =
we
+			 * can probe register values here ?
+			 */
+			rinfo->panel_info.hAct_high =3D 1;
+			rinfo->panel_info.vAct_high =3D 1;
+			/* Mark panel infos valid */
+			rinfo->panel_info.valid =3D 1;
+
+			RTRACE("Found panel in BIOS table:\n");
+			RTRACE("  hblank: %d\n", rinfo->panel_info.hblank);
+			RTRACE("  hOver_plus: %d\n", rinfo->panel_info.hOver_plus);
+			RTRACE("  hSync_width: %d\n", rinfo->panel_info.hSync_width);
+			RTRACE("  vblank: %d\n", rinfo->panel_info.vblank);
+			RTRACE("  vOver_plus: %d\n", rinfo->panel_info.vOver_plus);
+			RTRACE("  vSync_width: %d\n", rinfo->panel_info.vSync_width);
+			RTRACE("  clock: %d\n", rinfo->panel_info.clock);
+
+			return 0;
+		}
 	}
=20
-	return pret;
+	RTRACE("Didn't find panel in BIOS table !\n");
+
+	return -ENODEV;
+}
+
+/*
+ * Get informations about TMDS controllers and their setup at
+ * different operating frequencies
+ */
+void __devinit radeon_get_tmds_info(struct radeonfb_info *rinfo)
+{
+	int i;
+	int family =3D rinfo->family;
+
+	/* Get default TMDS infos for this chip */
+	for (i =3D 0; i < 4; i++) {
+		rinfo->tmds_pll[i].value =3D default_tmds_pll[family][i].value;
+		rinfo->tmds_pll[i].freq =3D default_tmds_pll[family][i].freq;
+	}
+
+	/* Get whatever the firmware provides */
+	if (rinfo->radeon_get_tmds_info) {
+		rinfo->radeon_get_tmds_info(rinfo);
+		// XXX Do we care about the return value?
+	}
+}
+
+int __devinit radeon_get_tmds_info_legacy(struct radeonfb_info *rinfo)
+{
+	int offset, i, n, rev;
+
+	offset =3D BIOS_IN16(rinfo->fp_bios_start + 0x34);
+	if (offset =3D=3D 0)
+		return -ENODEV;
+
+	rev =3D BIOS_IN8(offset);
+	RTRACE("DFP table revision: %d\n", rev);
+
+	switch(rev) {
+	case 3:
+		n =3D BIOS_IN8(offset + 5) + 1;
+		if (n > 4)
+			n =3D 4;
+		for (i =3D 0; i < n; i++) {
+			/* Looks bogus ... but that's what is in X.org */
+			rinfo->tmds_pll[i].value =3D
+				BIOS_IN32(offset + i*10 + 0x08);
+			rinfo->tmds_pll[i].freq =3D
+				BIOS_IN16(offset + i*10 + 0x10);
+		}
+		return 0;
+
+	/* revision 4 has some problem as it appears in RV280,
+	 * comment it off for now, use default instead
+	 */
+#if 0
+	case 4:
+		stride =3D 0;
+		n =3D BIOS_IN8(offset  5) + 1;
+		if (n > 4)
+			n =3D 4;
+		for (i =3D 0; i < n; i++) {
+			rinfo->tmds_pll[i].value =3D
+				BIOS_IN32(tmp + stride + 0x08);
+			rinfo->tmds_pll[i].freq =3D
+				BIOS_IN16(tmp + stride + 0x10);
+			if (i =3D=3D 0)
+				stride +=3D 10;
+			else
+				stride +=3D 6;
+		}
+		return 0;
+#endif
+	}
+	return -ENODEV;
+}
+
+int __devinit radeon_get_tmds_info_atom(struct radeonfb_info *rinfo)
+{
+	int offset, i, maxfreq;
+
+	offset =3D BIOS_IN16(rinfo->atom_data_start + 18);
+	if (offset =3D=3D 0)
+		return -ENODEV;
+
+	maxfreq =3D BIOS_IN16(offset + 4);
+
+	for (i =3D 0; i < 4; i++) {
+		rinfo->tmds_pll[i].freq =3D BIOS_IN16(offset + i*6 + 6);
+		/* This assumes each field in TMDS_PLL has 6 bit as
+		 * in R300/R420
+		 */
+		rinfo->tmds_pll[i].value =3D
+			((BIOS_IN8(offset + i*6 + 8) & 0x3f) |
+			 ((BIOS_IN8(offset + i*6 + 10) & 0x3f)<<6) |
+			 ((BIOS_IN8(offset + i*6 + 9) & 0xf)<<12) |
+			 ((BIOS_IN8(offset + i*6 + 11) & 0xf)<<16));
+		RTRACE("TMDS PLL from BIOS: %ld %x\n",
+		       rinfo->tmds_pll[i].freq, rinfo->tmds_pll[i].value);
+
+		if (maxfreq =3D=3D rinfo->tmds_pll[i].freq) {
+			rinfo->tmds_pll[i].freq =3D 0xffffffff;
+			break;
+		}
+	}
+	return 0;
 }
=20
=20
+static const char *conn_type_name[] =3D {
+	"NONE", "VGA", "DVI-I", "DVI-D", "DVI-A", "S-Video",
+	"Composite Video", "Internal Panel", "Digital",
+	"Unsupported", "Proprietary"
+};
+
+static const char *mon_type_name[] =3D {
+	"None", "CRT", "LVDS Flat panel",
+	"DVI Flat panel", "Composite TV", "S-Video TV"
+};
+
+static void __devinit radeon_fill_conn(struct radeon_connector *conn, in=
t mon_type, int ddc_type, int *found_tmds, int *found_crt)
+{
+	conn->mon_type =3D mon_type;
+	conn->ddc_type =3D ddc_type;
+
+	// XXX what about reversed DAC/TMDS??
+
+	switch(mon_type) {
+	case MT_CRT:
+		conn->conn_type =3D conn_vga;
+		conn->tmds_type =3D tmds_unknown;
+		conn->dac_type =3D (*found_crt) ? dac_tvdac: dac_primary;
+		if (ddc_type =3D=3D ddc_none)
+			conn->ddc_type =3D (*found_crt) ? ddc_crt2 : ddc_vga;
+		*found_crt =3D 1;
+		break;
+	case MT_DFP:
+		conn->conn_type =3D conn_dvi_i;
+		conn->tmds_type =3D (*found_tmds) ? tmds_external: tmds_internal;
+		conn->dac_type =3D dac_unknown;
+		if (ddc_type =3D=3D ddc_none)
+			conn->ddc_type =3D ddc_dvi;
+		*found_tmds =3D 1;
+		break;
+	case MT_LCD:
+		conn->conn_type =3D conn_lvds;
+		conn->tmds_type =3D tmds_unknown;
+		conn->dac_type =3D dac_unknown;
+		if (ddc_type =3D=3D ddc_none)
+			conn->ddc_type =3D ddc_none; //heh
+		break;
+	case MT_CTV:
+		conn->conn_type =3D conn_ctv;
+		conn->tmds_type =3D tmds_unknown;
+		conn->dac_type =3D dac_tvdac;
+		if (ddc_type =3D=3D ddc_none)
+			conn->ddc_type =3D ddc_vga; // XXX ddc_crt2?
+		break;
+	case MT_STV:
+		conn->conn_type =3D conn_stv;
+		conn->tmds_type =3D tmds_unknown;
+		conn->dac_type =3D dac_tvdac;
+		if (ddc_type =3D=3D ddc_none)
+			conn->ddc_type =3D ddc_vga; // XXX ddc_crt2?
+		break;
+	case MT_UNKNOWN:
+	case MT_NONE:
+		conn->conn_type =3D conn_none;
+		conn->tmds_type =3D tmds_unknown;
+		conn->mon_type =3D MT_NONE;
+		conn->ddc_type =3D ddc_none;
+		conn->dac_type =3D dac_unknown;
+		break;
+	default:
+		break;
+	}
+	// leaves conn_digital, conn_unsupported, conn_propritetary
+}
+
 #ifdef CONFIG_PPC_OF
 /*
  * Try to find monitor informations & EDID data out of the Open Firmware
@@ -59,33 +358,40 @@ static char *radeon_get_mon_name(int type)
  * models with broken OF probing by hard-coding known EDIDs for some Mac
  * laptops internal LVDS panel. (XXX: not done yet)
  */
-static int __devinit radeon_parse_montype_prop(struct device_node *dp, u=
8 **out_EDID,
+static int __devinit radeon_parse_montype_prop(struct radeonfb_info *rin=
fo,
+					       struct device_node *dp,
+					       struct radeon_connector *conn,
 					       int hdno)
 {
-        static char *propnames[] =3D { "DFP,EDID", "LCD,EDID", "EDID",
+	static char *propnames[] =3D { "DFP,EDID", "LCD,EDID", "EDID",
 				     "EDID1", "EDID2",  NULL };
 	const u8 *pedid =3D NULL;
 	const u8 *pmt =3D NULL;
 	u8 *tmp;
-        int i, mt =3D MT_NONE; =20
-=09
+	int i;
+
 	RTRACE("analyzing OF properties...\n");
 	pmt =3D get_property(dp, "display-type", NULL);
 	if (!pmt)
-		return MT_NONE;
+		return -1;
 	RTRACE("display-type: %s\n", pmt);
-	/* OF says "LCD" for DFP as well, we discriminate from the caller of th=
is
-	 * function
-	 */
-	if (!strcmp(pmt, "LCD") || !strcmp(pmt, "DFP"))
-		mt =3D MT_DFP;
-	else if (!strcmp(pmt, "CRT"))
-		mt =3D MT_CRT;
-	else {
+	if (!strcmp(pmt, "LCD") || !strcmp(pmt, "DFP")) {
+		/* OF says "LCD" for DFP as well.*/
+		if (rinfo->is_mobility) {
+			conn->mon_type =3D MT_LCD;
+			/* Maybe check for LVDS_GEN_CNTL here ? I need to check out
+			 * what OF does when booting with lid closed
+			 */
+		} else{
+			conn->mon_type =3D MT_DFP;
+		}
+	} else if (!strcmp(pmt, "CRT")) {
+		conn->mon_type =3D MT_CRT;
+	} else {
 		if (strcmp(pmt, "NONE") !=3D 0)
 			printk(KERN_WARNING "radeonfb: Unknown OF display-type: %s\n",
 			       pmt);
-		return MT_NONE;
+		return -1;
 	}
=20
 	for (i =3D 0; propnames[i] !=3D NULL; ++i) {
@@ -102,25 +408,36 @@ static int __devinit radeon_parse_montype_prop(stru=
ct device_node *dp, u8 **out_
 	if (pedid =3D=3D NULL && dp->parent && (hdno =3D=3D 0))
 		pedid =3D get_property(dp->parent, "EDID", NULL);
 	if (pedid =3D=3D NULL)
-		return mt;
+		return -1;
=20
 	tmp =3D kmemdup(pedid, EDID_LENGTH, GFP_KERNEL);
-	if (!tmp)
-		return mt;
-	*out_EDID =3D tmp;
-	return mt;
+	conn->edid =3D tmp;
+
+	{
+		int found_tmds =3D 0;
+		int found_crt =3D 0;
+		int ddc_type =3D ddc_none;
+		// XXX what about reversed DAC/TMDS??
+		radeon_fill_conn(conn, conn->mon_type, ddc_type, &found_crt, &found_tm=
ds);
+	}
+
+	return 0;
 }
=20
-static int __devinit radeon_probe_OF_head(struct radeonfb_info *rinfo, i=
nt head_no,
-					  u8 **out_EDID)
+/* return a -1 on error */
+static int __devinit radeon_probe_OF_head(struct radeonfb_info *rinfo, i=
nt head_no)
+
 {
-        struct device_node *dp;
+	struct radeon_connector *conn;
+	struct device_node *dp;
=20
 	RTRACE("radeon_probe_OF_head\n");
=20
-        dp =3D rinfo->of_node;
-        while (dp =3D=3D NULL)
-		return MT_NONE;
+	conn =3D &rinfo->connectors[head_no];
+
+	dp =3D rinfo->of_node;
+	if (dp =3D=3D NULL)
+		return -1;
=20
 	if (rinfo->has_CRTC2) {
 		const char *pname;
@@ -129,116 +446,284 @@ static int __devinit radeon_probe_OF_head(struct =
radeonfb_info *rinfo, int head_
 		dp =3D dp->child;
 		do {
 			if (!dp)
-				return MT_NONE;
+				return -1;
+
 			pname =3D get_property(dp, "name", NULL);
-			if (!pname)
-				return MT_NONE;
+			if (!pname)=20
+				return -1;
+
 			len =3D strlen(pname);
 			RTRACE("head: %s (letter: %c, head_no: %d)\n",
 			       pname, pname[len-1], head_no);
 			if (pname[len-1] =3D=3D 'A' && head_no =3D=3D 0) {
-				int mt =3D radeon_parse_montype_prop(dp, out_EDID, 0);
-				/* Maybe check for LVDS_GEN_CNTL here ? I need to check out
-				 * what OF does when booting with lid closed
-				 */
-				if (mt =3D=3D MT_DFP && rinfo->is_mobility)
-					mt =3D MT_LCD;
-				return mt;
-			} else if (pname[len-1] =3D=3D 'B' && head_no =3D=3D 1)
-				return radeon_parse_montype_prop(dp, out_EDID, 1);
+				return radeon_parse_montype_prop(rinfo, dp, conn, 0);
+			} else if (pname[len-1] =3D=3D 'B' && head_no =3D=3D 1) {
+				return radeon_parse_montype_prop(rinfo, dp, conn, 1);
+			}
 			second =3D 1;
 			dp =3D dp->sibling;
 		} while(!second);
 	} else {
 		if (head_no > 0)
-			return MT_NONE;
-		return radeon_parse_montype_prop(dp, out_EDID, -1);
+			return -1;
+		return radeon_parse_montype_prop(rinfo, dp, conn, -1);
 	}
-        return MT_NONE;
+	return -1;
 }
 #endif /* CONFIG_PPC_OF */
=20
-
-static int __devinit radeon_get_panel_info_BIOS(struct radeonfb_info *ri=
nfo)
+/*
+ * Get informations about the various connectors on this card. This is
+ * the most prone to fail function as various firmwares tend to say
+ * crap or not give any info at all. The Open Firmware version is just
+ * a table of known cards for now for example. We'll probably need some
+ * additional module params to force different settings in case of
+ * misdetection here.
+ *
+ * This doesn _not_ try actual probing of whatever is plugged on those
+ * various connectors. This will be done later. We do store whatever
+ * probing info the firmware gives us though
+ */
+void __devinit radeon_get_conn_info(struct radeonfb_info *rinfo, int ign=
ore_conntable)
 {
-	unsigned long tmp, tmp0;
-	char stmp[30];
 	int i;
=20
-	if (!rinfo->bios_seg)
-		return 0;
-
-	if (!(tmp =3D BIOS_IN16(rinfo->fp_bios_start + 0x40))) {
-		printk(KERN_ERR "radeonfb: Failed to detect DFP panel info using BIOS\=
n");
-		rinfo->panel_info.pwr_delay =3D 200;
-		return 0;
+	/* Clear table */
+	for (i =3D 0; i < RADEON_MAX_CONNECTORS; i++) {
+		rinfo->connectors[i].conn_type	=3D conn_none;
+		rinfo->connectors[i].ddc_type	=3D ddc_none;
+		rinfo->connectors[i].dac_type	=3D dac_unknown;
+		rinfo->connectors[i].tmds_type	=3D tmds_unknown;
+		rinfo->connectors[i].mon_type	=3D MT_UNKNOWN;
+		rinfo->connectors[i].head       =3D -1;
+		rinfo->heads[i] =3D -1;
 	}
+	rinfo->num_heads =3D 0;
+
+	if (ignore_conntable) {
+#if defined(CONFIG_FB_RADEON_I2C)
+		struct radeon_connector conn;
+		int idx =3D 0;
+		int found_tmds =3D 0;
+		int found_crt =3D 0;
+
+		// XXX what about reversed DAC/TMDS??
+
+		for (i =3D 0; i < 4; i++) {
+			conn.ddc_type =3D i;
+			if (!radeon_probe_i2c_connector(rinfo, &conn)) {
+				radeon_fill_conn(&rinfo->connectors[idx++], conn.mon_type, conn.ddc_=
type,
+						 &found_tmds, &found_crt);
+			}
+		}
=20
-	for(i=3D0; i<24; i++)
-		stmp[i] =3D BIOS_IN8(tmp+i+1);
-	stmp[24] =3D 0;
-	printk("radeonfb: panel ID string: %s\n", stmp);
-	rinfo->panel_info.xres =3D BIOS_IN16(tmp + 25);
-	rinfo->panel_info.yres =3D BIOS_IN16(tmp + 27);
-	printk("radeonfb: detected LVDS panel size from BIOS: %dx%d\n",
-		rinfo->panel_info.xres, rinfo->panel_info.yres);
+		/* If we failed to probe something.. */
+		if (idx)
+			goto found;
+#endif /* CONFIG_FB_RADEON_I2C */
+	} else {
+		/* Try to obtain infos from firmware */
+		if (rinfo->radeon_get_conn_info) {
+			if (!rinfo->radeon_get_conn_info(rinfo)) {
+				goto found;
+			}
+		}
+	}
=20
-	rinfo->panel_info.pwr_delay =3D BIOS_IN16(tmp + 44);
-	RTRACE("BIOS provided panel power delay: %d\n", rinfo->panel_info.pwr_d=
elay);
-	if (rinfo->panel_info.pwr_delay > 2000 || rinfo->panel_info.pwr_delay <=
=3D 0)
-		rinfo->panel_info.pwr_delay =3D 2000;
+	printk(KERN_INFO "radeonfb: No connector infos, using defaults...\n");
=20
-	/*
-	 * Some panels only work properly with some divider combinations
+	/* Here, we use defaults that are common enough ... we hope
+	 * For a mobility chip, we assume LVDS is on primary
 	 */
-	rinfo->panel_info.ref_divider =3D BIOS_IN16(tmp + 46);
-	rinfo->panel_info.post_divider =3D BIOS_IN8(tmp + 48);
-	rinfo->panel_info.fbk_divider =3D BIOS_IN16(tmp + 49);
-	if (rinfo->panel_info.ref_divider !=3D 0 &&
-	    rinfo->panel_info.fbk_divider > 3) {
-		rinfo->panel_info.use_bios_dividers =3D 1;
-		printk(KERN_INFO "radeondb: BIOS provided dividers will be used\n");
-		RTRACE("ref_divider =3D %x\n", rinfo->panel_info.ref_divider);
-		RTRACE("post_divider =3D %x\n", rinfo->panel_info.post_divider);
-		RTRACE("fbk_divider =3D %x\n", rinfo->panel_info.fbk_divider);
+	if (rinfo->is_mobility) {
+		rinfo->connectors[0].conn_type	=3D conn_lvds;
+		rinfo->connectors[0].ddc_type	=3D ddc_dvi;
+		rinfo->connectors[0].dac_type	=3D dac_primary;
+		rinfo->connectors[0].tmds_type	=3D tmds_unknown;
+		rinfo->connectors[0].mon_type	=3D MT_UNKNOWN;
+
+		rinfo->connectors[1].conn_type	=3D conn_dvi_d;
+		rinfo->connectors[1].ddc_type	=3D ddc_vga;
+		rinfo->connectors[1].dac_type	=3D dac_primary;
+		rinfo->connectors[1].tmds_type	=3D tmds_internal;
+		rinfo->connectors[1].mon_type	=3D MT_UNKNOWN;
+
+		rinfo->connectors[2].conn_type	=3D conn_stv;
+		rinfo->connectors[2].ddc_type	=3D ddc_none;
+		rinfo->connectors[2].dac_type	=3D dac_tvdac;
+		rinfo->connectors[2].tmds_type	=3D tmds_unknown;
+		rinfo->connectors[2].mon_type	=3D MT_UNKNOWN;
+	} else {
+		rinfo->connectors[0].conn_type	=3D conn_dvi_d;
+		rinfo->connectors[0].ddc_type	=3D ddc_dvi;
+		rinfo->connectors[0].dac_type	=3D dac_tvdac;
+		rinfo->connectors[0].tmds_type	=3D tmds_internal;
+		rinfo->connectors[0].mon_type	=3D MT_UNKNOWN;
+
+		rinfo->connectors[1].conn_type	=3D conn_vga;
+		rinfo->connectors[1].ddc_type	=3D ddc_vga;
+		rinfo->connectors[1].dac_type	=3D dac_primary;
+		rinfo->connectors[1].tmds_type	=3D tmds_unknown;
+		rinfo->connectors[1].mon_type	=3D MT_UNKNOWN;
+
+		if (rinfo->has_CRTC2) {
+			rinfo->connectors[1].conn_type	=3D conn_vga;
+			rinfo->connectors[1].ddc_type	=3D ddc_crt2;
+			rinfo->connectors[1].dac_type	=3D dac_tvdac;
+			rinfo->connectors[1].tmds_type	=3D tmds_unknown;
+			rinfo->connectors[1].mon_type	=3D MT_UNKNOWN;
+		}
 	}
-	RTRACE("Scanning BIOS table ...\n");
-	for(i=3D0; i<32; i++) {
-		tmp0 =3D BIOS_IN16(tmp+64+i*2);
-		if (tmp0 =3D=3D 0)
-			break;
-		RTRACE(" %d x %d\n", BIOS_IN16(tmp0), BIOS_IN16(tmp0+2));
-		if ((BIOS_IN16(tmp0) =3D=3D rinfo->panel_info.xres) &&
-		    (BIOS_IN16(tmp0+2) =3D=3D rinfo->panel_info.yres)) {
-			rinfo->panel_info.hblank =3D (BIOS_IN16(tmp0+17) - BIOS_IN16(tmp0+19)=
) * 8;
-			rinfo->panel_info.hOver_plus =3D ((BIOS_IN16(tmp0+21) -
-							 BIOS_IN16(tmp0+19) -1) * 8) & 0x7fff;
-			rinfo->panel_info.hSync_width =3D BIOS_IN8(tmp0+23) * 8;
-			rinfo->panel_info.vblank =3D BIOS_IN16(tmp0+24) - BIOS_IN16(tmp0+26);
-			rinfo->panel_info.vOver_plus =3D (BIOS_IN16(tmp0+28) & 0x7ff) - BIOS_=
IN16(tmp0+26);
-			rinfo->panel_info.vSync_width =3D (BIOS_IN16(tmp0+28) & 0xf800) >> 11=
;
-			rinfo->panel_info.clock =3D BIOS_IN16(tmp0+9);
-			/* Assume high active syncs for now until ATI tells me more... maybe =
we
-			 * can probe register values here ?
-			 */
-			rinfo->panel_info.hAct_high =3D 1;
-			rinfo->panel_info.vAct_high =3D 1;
-			/* Mark panel infos valid */
-			rinfo->panel_info.valid =3D 1;
=20
-			RTRACE("Found panel in BIOS table:\n");
-			RTRACE("  hblank: %d\n", rinfo->panel_info.hblank);
-			RTRACE("  hOver_plus: %d\n", rinfo->panel_info.hOver_plus);
-			RTRACE("  hSync_width: %d\n", rinfo->panel_info.hSync_width);
-			RTRACE("  vblank: %d\n", rinfo->panel_info.vblank);
-			RTRACE("  vOver_plus: %d\n", rinfo->panel_info.vOver_plus);
-			RTRACE("  vSync_width: %d\n", rinfo->panel_info.vSync_width);
-			RTRACE("  clock: %d\n", rinfo->panel_info.clock);
-			=09
-			return 1;
+found:
+	/* Now, we do additional fixups */
+
+	/* RS300 has only one DAC, force TV-DAC on VGA port */
+	if (rinfo->family =3D=3D CHIP_FAMILY_RS300) {
+		for (i =3D 0; i < RADEON_MAX_CONNECTORS; i++) {
+			if (rinfo->connectors[i].conn_type =3D=3D conn_vga)
+				rinfo->connectors[i].dac_type =3D dac_tvdac;
+			else if (rinfo->connectors[i].dac_type !=3D dac_unknown)
+				rinfo->connectors[i].dac_type =3D dac_primary;
 		}
 	}
-	RTRACE("Didn't find panel in BIOS table !\n");
+
+	/* Single head chips all use primary DAC */
+	if (!rinfo->has_CRTC2)
+		rinfo->connectors[0].dac_type =3D dac_primary;
+
+	return;
+}
+
+#ifdef CONFIG_PPC_OF
+int __devinit radeon_get_conn_info_openfirmware(struct radeonfb_info *ri=
nfo)
+{
+	int i;
+	int found =3D 0;
+
+	/* Only two heads for OF! */
+	for(i =3D 0 ; i < 2 ; i++) {
+		if (!radeon_probe_OF_head(rinfo, i))
+			found =3D 0;
+	}
+	return found;
+}
+#endif /* CONFIG_PPC_OF */
+
+int __devinit radeon_get_conn_info_atom(struct radeonfb_info *rinfo)
+{
+	int i, j, offset, valids;
+	int ids[RADEON_MAX_CONNECTORS];
+	u16 portinfo, tmp0;
+	int conn_index =3D 0;
+	int conn_add =3D 2;
+	int idx =3D 0;
+	int ddc_type, dac_type, conn_type, tmds_type, port_id;
+	int connector_found =3D 0;
+	int shared;
+
+	offset =3D BIOS_IN16(rinfo->atom_data_start + 22);
+	if (offset =3D=3D 0)
+		return -ENODEV;
+
+	/* Again, I slightly modified X.org algorithm. I assign "primary" outpu=
ts
+	 * to entries 0 and 1, and anything else goes after 2.
+	 *
+	 * Also, I keep an array of all port IDs matching connectors[] array,
+	 * unlike X which limits itself to "crtc"'s
+	 */
+	for (i =3D 0; i < RADEON_MAX_CONNECTORS; i++)
+		ids[i] =3D -1;
+
+	valids =3D BIOS_IN16(offset + 4);
+	for (i =3D 0; i < 8; i++) {
+		shared =3D 0;
+		if (!(valids & (1 << i)))
+			continue;
+		portinfo =3D BIOS_IN16(offset + 6 + i*2);
+
+		conn_type =3D (portinfo >> 4) & 0xf;
+		dac_type =3D (portinfo & 0xf) - 1;
+		port_id =3D (portinfo >> 8) & 0xf;
+		ddc_type =3D ddc_none;
+
+		if ((tmp0 =3D BIOS_IN16(rinfo->atom_data_start + 24))) {
+			switch(BIOS_IN16(tmp0 + 4 + (27 * port_id)) * 4) {
+			case GPIO_MONID:
+				ddc_type =3D ddc_monid;
+				break;
+			case GPIO_DVI_DDC:
+				ddc_type =3D ddc_dvi;
+				break;
+			case GPIO_VGA_DDC:
+				ddc_type =3D ddc_vga;
+				break;
+			case GPIO_CRT2_DDC:
+				ddc_type =3D ddc_crt2;
+				break;
+			default:
+				ddc_type =3D ddc_none;
+				break;
+			}
+		}
+
+		if (i =3D=3D 3)
+			tmds_type =3D tmds_internal;
+		else if (i =3D=3D 7)
+			tmds_type =3D tmds_external;
+		else
+			tmds_type =3D tmds_unknown;
+
+		RTRACE("index %d port %d conn %d dac %d ddc %d tmds %d\n", i, port_id,=
 conn_type, dac_type, ddc_type, tmds_type);
+
+		/* Ok, now we have the port ID, look for an existing port
+		 * already using this ID
+		 */
+		for (j =3D 0; j < RADEON_MAX_CONNECTORS; j++) {
+			if (port_id !=3D ids[j])
+				continue;
+
+			/* This port is shared. Update the values (if needed)
+			 * and probe next connector without creating a new
+			 * connector entry.
+			 */
+			if (tmds_type !=3D tmds_unknown)
+				rinfo->connectors[j].tmds_type =3D tmds_type;
+			if (rinfo->connectors[j].dac_type =3D=3D dac_unknown)
+				rinfo->connectors[j].dac_type =3D dac_type;
+			if (rinfo->connectors[j].ddc_type =3D=3D ddc_none)
+				rinfo->connectors[j].ddc_type =3D ddc_type;
+
+			shared =3D 1;
+		}
+		if (shared)
+			continue;
+
+		conn_index =3D (ddc_type =3D=3D ddc_dvi || conn_index =3D=3D 1) ? 0 : =
1;
+
+		/* if the port is a TV port, or both connectors are already
+		 * assigned, assign it after further in the table
+		 */
+		if (conn_type =3D=3D conn_ctv || conn_type =3D=3D conn_stv ||
+		    (rinfo->connectors[0].conn_type !=3D conn_none &&
+		     rinfo->connectors[1].conn_type !=3D conn_none))
+			idx =3D conn_add++;
+		else
+			idx =3D conn_index;
+
+		rinfo->connectors[idx].tmds_type =3D tmds_type;
+		rinfo->connectors[idx].dac_type =3D dac_type;
+		rinfo->connectors[idx].ddc_type =3D ddc_type;
+		rinfo->connectors[idx].conn_type =3D conn_type;
+		ids[idx] =3D port_id;
+
+		/* increment connector_found for primary connectors only */
+		if (idx < 2)
+			connector_found +=3D (idx + 1);
+	}
+
+	if (connector_found =3D=3D 0)
+		return -ENODEV;
=20
 	return 0;
 }
@@ -247,44 +732,167 @@ static int __devinit radeon_get_panel_info_BIOS(st=
ruct radeonfb_info *rinfo)
  * doesn't quite work yet, but it's output is still useful for
  * debugging
  */
-static void __devinit radeon_parse_connector_info(struct radeonfb_info *=
rinfo)
+int __devinit radeon_get_conn_info_legacy(struct radeonfb_info *rinfo)
 {
-	int offset, chips, connectors, tmp, i, conn, type;
-
-	static char* __conn_type_table[16] =3D {
-		"NONE", "Proprietary", "CRT", "DVI-I", "DVI-D", "Unknown", "Unknown",
-		"Unknown", "Unknown", "Unknown", "Unknown", "Unknown", "Unknown",
-		"Unknown", "Unknown", "Unknown"
+	int offset, i, entry, tmp;
+	int ddc_type, dac_type, conn_type, tmds_type;
+	int conn_index =3D 0;
+	int conn_add =3D 2;
+	int idx =3D 0;
+
+	/* Convert legacy to real connector types */
+	const enum radeon_conn_type legacy_conn_to_type[] =3D {
+		conn_none,
+		conn_proprietary,
+		conn_vga,
+		conn_dvi_i,
+		conn_dvi_d,
+		conn_ctv,
+		conn_stv,
+		conn_unsupported,
 	};
=20
-	if (!rinfo->bios_seg)
-		return;
+	/* Some laptops only have one connector (VGA) listed in the connector
+	 * table, we need to add LVDS in as a non-DDC display.
+	 * Note, we can't assume the listed VGA will be filled in PortInfo[0],
+	 * when walking through connector table. connector_found has following
+	 * meaning:
+	 * 0 -- nothing found,
+	 * 1 -- only connectors[0] filled,
+	 * 2 -- only connectors[1] filled,
+	 * 3 -- both are filled.
+	 *
+	 * Note: I modified X.org algorithm to add additional entries if any
+	 * after the second table slot. Those entries do not affect the value
+	 * of connector_found. --BenH.
+	 */
+	int connector_found =3D 0;
=20
 	offset =3D BIOS_IN16(rinfo->fp_bios_start + 0x50);
-	if (offset =3D=3D 0) {
-		printk(KERN_WARNING "radeonfb: No connector info table detected\n");
-		return;
+	if (offset =3D=3D 0)
+		return -ENODEV;
+
+	for (i =3D 1; i < 4; i++) {
+		entry =3D offset + i*2;
+
+		/* End of table */
+		if (!BIOS_IN8(entry) && i > 1)
+			break;
+
+		/* Read table entry, check connector type */
+		tmp =3D BIOS_IN16(entry);
+		conn_type =3D (tmp >> 12) & 0xf;
+		if (conn_type =3D=3D legacy_conn_none)
+			continue;
+		ddc_type =3D (tmp >> 8) & 0xf;
+		dac_type =3D (tmp & 0x01) ? dac_tvdac : dac_primary;
+		tmds_type =3D (tmp & 0x10) ? tmds_external : tmds_internal;
+
+		/* same connector */
+		if (connector_found > 0) {
+			if (rinfo->connectors[conn_index].ddc_type =3D=3D ddc_type)
+				continue;
+		}
+
+		/* sanity checks */
+		if (ddc_type > ddc_crt2)
+			ddc_type =3D ddc_none;
+		if (conn_type > legacy_conn_unsupported)
+			conn_type =3D legacy_conn_unsupported;
+		if (conn_type !=3D legacy_conn_dvi_d &&
+		    conn_type !=3D legacy_conn_dvi_i &&
+		    tmds_type =3D=3D tmds_internal)
+			tmds_type=3D tmds_unknown;
+
+		/* convert connector type */
+		conn_type =3D legacy_conn_to_type[conn_type];
+
+		/* internal DDC_DVI port will get assigned to connector[0], or
+		 * if there is no DDC_DVI (like in some IGPs).
+		 */
+		conn_index =3D (ddc_type =3D=3D ddc_dvi || conn_index =3D=3D 1) ? 0 : =
1;
+
+		/* if the port is a TV port, or both connectors are already
+		 * assigned, assign it after further in the table
+		 */
+		if (conn_type =3D=3D conn_ctv || conn_type =3D=3D conn_stv ||
+		    (rinfo->connectors[0].conn_type !=3D conn_none &&
+		     rinfo->connectors[1].conn_type))
+			idx =3D conn_add++;
+		else
+			idx =3D conn_index;
+
+		/* if table full, exit */
+		if (idx >=3D RADEON_MAX_CONNECTORS) {
+			printk(KERN_WARNING "radeonfb: Connector table full !\n");
+			break;
+		}
+		rinfo->connectors[idx].conn_type	=3D conn_type;
+		rinfo->connectors[idx].ddc_type		=3D ddc_type;
+		rinfo->connectors[idx].dac_type		=3D dac_type;
+		rinfo->connectors[idx].tmds_type	=3D tmds_type;
+
+		/* increment connector_found for primary connectors only */
+		if (idx < 2)
+			connector_found +=3D (idx + 1);
 	}
=20
-	/* Don't do much more at this point but displaying the data if
-	 * DEBUG is enabled
-	 */
-	chips =3D BIOS_IN8(offset++) >> 4;
-	RTRACE("%d chips in connector info\n", chips);
-	for (i =3D 0; i < chips; i++) {
-		tmp =3D BIOS_IN8(offset++);
-		connectors =3D tmp & 0x0f;
-		RTRACE(" - chip %d has %d connectors\n", tmp >> 4, connectors);
-		for (conn =3D 0; ; conn++) {
-			tmp =3D BIOS_IN16(offset);
-			if (tmp =3D=3D 0)
-				break;
-			offset +=3D 2;
-			type =3D (tmp >> 12) & 0x0f;
-			RTRACE("  * connector %d of type %d (%s) : %04x\n",
-			       conn, type, __conn_type_table[type], tmp);
+	if (rinfo->is_mobility) {
+		/* For the cases where only one VGA connector is found,
+		 * we assume LVDS is not listed in the connector table,
+		 * add it in here as the first port.
+		 *
+		 * TODO: Check what's up with laptops that have a DVI output
+		 * and no LVDS entry in the table. I suspect some thinkpads
+		 * may play trick with us here... We may want to check the
+		 * presence of a panel via LVDS_GEN_CNTL to be sure...
+		 */
+		if ((connector_found < 3) &&
+		    (rinfo->connectors[idx].conn_type =3D=3D conn_vga)) {
+			if (connector_found =3D=3D 1) {
+				memcpy(&rinfo->connectors[1], &rinfo->connectors[0],
+						sizeof(struct radeon_connector));
+			}
+
+			/* Fixme: TV DAC is probably elsewhere ... */
+			rinfo->connectors[0].dac_type =3D dac_tvdac;
+			rinfo->connectors[0].tmds_type =3D tmds_unknown;
+			rinfo->connectors[0].ddc_type =3D ddc_none;
+			rinfo->connectors[0].conn_type =3D conn_proprietary;
+
+			printk(KERN_WARNING "radeonfb: LVDS port is not in connector table, a=
dded in.\n");
+			if (connector_found =3D=3D 0)
+				connector_found =3D 1;
+			else
+				connector_found =3D 3;
 		}
+
+		/* Check for LCD DDC info table */
+		if ((offset =3D BIOS_IN16(rinfo->fp_bios_start + 0x42))) {
+			if ((tmp =3D BIOS_IN16(offset + 0x15))) {
+				if ((ddc_type =3D BIOS_IN8(tmp+2) & 0x07)) {
+					rinfo->connectors[0].ddc_type =3D ddc_type;
+					printk(KERN_WARNING "radeonfb: LCD DDC Info Table found, "
+						"forcing primary port to %d\n",
+						ddc_type);
+				}
+			}
+		}
+	} else if (connector_found =3D=3D 2) {
+		memcpy(&rinfo->connectors[0], &rinfo->connectors[1],
+			sizeof (struct radeon_connector));
+		rinfo->connectors[1].dac_type =3D dac_unknown;
+		rinfo->connectors[1].tmds_type =3D tmds_unknown;
+		rinfo->connectors[1].ddc_type =3D ddc_none;
+		rinfo->connectors[1].conn_type =3D conn_none;
+		connector_found =3D 1;
 	}
+
+	if (connector_found =3D=3D 0)
+		return -ENODEV;
+
+	/* External TMDS Table, not used now */
+	return 0;
 }
=20
=20
@@ -361,6 +969,51 @@ static int __devinit radeon_crt_is_connected(struct =
radeonfb_info *rinfo, int is
     return connected ? MT_CRT : MT_NONE;
 }
=20
+/* Find if the desired connector and monitor are compatible */
+static int __devinit radeon_conn_monitor_compatible(int mon_type, int co=
nn_type)
+{
+	switch(mon_type) {
+	case MT_CRT:
+		return ((conn_type =3D=3D conn_vga) || (conn_type =3D=3D conn_dvi_a));
+	case MT_DFP:
+		return ((conn_type =3D=3D conn_dvi_i) || (conn_type =3D=3D conn_dvi_d)=
);
+	case MT_LCD:
+		return (conn_type =3D=3D conn_lvds);
+	case MT_CTV:
+		return (conn_type =3D=3D conn_ctv);
+	case MT_STV:
+		return (conn_type =3D=3D conn_stv);
+	case MT_UNKNOWN:
+	case MT_NONE:
+	default:
+		return 0;
+	}
+	// leaves conn_digital, conn_unsupported, conn_propritetary
+}
+
+/* Find a suitable connector for this display type */
+static int __devinit radeon_find_connector_for_mon(struct radeonfb_info =
*rinfo, int mon_type)
+{
+	int i;
+
+	if (mon_type <=3D MT_NONE)
+		return 0;
+
+	for (i =3D 0; i < RADEON_MAX_CONNECTORS ; i++) {
+		if (radeon_conn_monitor_compatible(mon_type, rinfo->connectors[i].conn=
_type) &&
+		    (rinfo->connectors[i].mon_type <=3D MT_NONE)) {
+			rinfo->connectors[i].mon_type =3D mon_type;
+			rinfo->connectors[i].head =3D rinfo->num_heads;
+			rinfo->heads[rinfo->num_heads] =3D i;
+			rinfo->num_heads++;
+			return 0;
+		}
+	}
+
+	printk(KERN_INFO "radeonfb: couldn't find a connector for monitor %d\n"=
, mon_type);
+	return -1;
+}
+
 /*
  * Parse the "monitor_layout" string if any. This code is mostly
  * copied from XFree's radeon driver
@@ -406,19 +1059,20 @@ static int __devinit radeon_parse_monitor_layout(s=
truct radeonfb_info *rinfo,
 		s1[i] =3D 0;
 		s2[0] =3D 0;
 	}
+
 	if (strcmp(s1, "CRT") =3D=3D 0)
-		rinfo->mon1_type =3D MT_CRT;
+		radeon_find_connector_for_mon(rinfo, MT_CRT);
 	else if (strcmp(s1, "TMDS") =3D=3D 0)
-		rinfo->mon1_type =3D MT_DFP;
+		radeon_find_connector_for_mon(rinfo, MT_DFP);
 	else if (strcmp(s1, "LVDS") =3D=3D 0)
-		rinfo->mon1_type =3D MT_LCD;
+		radeon_find_connector_for_mon(rinfo, MT_LCD);
=20
 	if (strcmp(s2, "CRT") =3D=3D 0)
-		rinfo->mon2_type =3D MT_CRT;
+		radeon_find_connector_for_mon(rinfo, MT_CRT);
 	else if (strcmp(s2, "TMDS") =3D=3D 0)
-		rinfo->mon2_type =3D MT_DFP;
+		radeon_find_connector_for_mon(rinfo, MT_DFP);
 	else if (strcmp(s2, "LVDS") =3D=3D 0)
-		rinfo->mon2_type =3D MT_LCD;
+		radeon_find_connector_for_mon(rinfo, MT_LCD);
=20
 	return 1;
 }
@@ -432,12 +1086,7 @@ static int __devinit radeon_parse_monitor_layout(st=
ruct radeonfb_info *rinfo,
 void __devinit radeon_probe_screens(struct radeonfb_info *rinfo,
 				    const char *monitor_layout, int ignore_edid)
 {
-#ifdef CONFIG_FB_RADEON_I2C
-	int ddc_crt2_used =3D 0;=09
-#endif
-	int tmp, i;
-
-	radeon_parse_connector_info(rinfo);
+	int i;
=20
 	if (radeon_parse_monitor_layout(rinfo, monitor_layout)) {
=20
@@ -448,214 +1097,142 @@ void __devinit radeon_probe_screens(struct radeo=
nfb_info *rinfo,
 		 * a layout for each card ?
 		 */
=20
-		RTRACE("Using specified monitor layout: %s", monitor_layout);
+		RTRACE("Using specified monitor layout: %s\n", monitor_layout);
 #ifdef CONFIG_FB_RADEON_I2C
 		if (!ignore_edid) {
-			if (rinfo->mon1_type !=3D MT_NONE)
-				if (!radeon_probe_i2c_connector(rinfo, ddc_dvi, &rinfo->mon1_EDID)) =
{
-					radeon_probe_i2c_connector(rinfo, ddc_crt2, &rinfo->mon1_EDID);
-					ddc_crt2_used =3D 1;
+			int mon_type;
+
+			/* If the DDC detection fails,=20
+			   we still want to use the user's specified layout! */
+			mon_type =3D PRIMARY_MONITOR(rinfo);
+
+			if (PRIMARY_MONITOR(rinfo) > MT_NONE)
+				if (radeon_probe_i2c_connector(rinfo, &PRIMARY_HEAD(rinfo)))
+					PRIMARY_MONITOR(rinfo) =3D mon_type;
+			if (SECONDARY_HEAD_PRESENT(rinfo)) {
+				mon_type =3D SECONDARY_MONITOR(rinfo);
+				if (SECONDARY_MONITOR(rinfo) > MT_NONE) {
+					if (radeon_probe_i2c_connector(rinfo, &SECONDARY_HEAD(rinfo)))
+						rinfo->connectors[rinfo->heads[1]].mon_type =3D mon_type;
 				}
-			if (rinfo->mon2_type !=3D MT_NONE)
-				if (!radeon_probe_i2c_connector(rinfo, ddc_vga, &rinfo->mon2_EDID) &=
&
-				    !ddc_crt2_used)
-					radeon_probe_i2c_connector(rinfo, ddc_crt2, &rinfo->mon2_EDID);
+			}
 		}
 #endif /* CONFIG_FB_RADEON_I2C */
-		if (rinfo->mon1_type =3D=3D MT_NONE) {
-			if (rinfo->mon2_type !=3D MT_NONE) {
-				rinfo->mon1_type =3D rinfo->mon2_type;
-				rinfo->mon1_EDID =3D rinfo->mon2_EDID;
-			} else {
-				rinfo->mon1_type =3D MT_CRT;
-				printk(KERN_INFO "radeonfb: No valid monitor, assuming CRT on first =
port\n");
-			}
-			rinfo->mon2_type =3D MT_NONE;
-			rinfo->mon2_EDID =3D NULL;
+
+		/* If the user specified a bogus monitor layout... */
+		if (PRIMARY_MONITOR(rinfo) <=3D MT_NONE) {
+			radeon_find_connector_for_mon(rinfo, MT_CRT);
+			printk(KERN_INFO "radeonfb: No valid monitor, assuming CRT on first p=
ort\n");
 		}
 	} else {
 		/*
 		 * Auto-detecting display type (well... trying to ...)
 		 */
-	=09
-		RTRACE("Starting monitor auto detection...\n");
=20
-#if DEBUG && defined(CONFIG_FB_RADEON_I2C)
-		{
-			u8 *EDIDs[4] =3D { NULL, NULL, NULL, NULL };
-			int mon_types[4] =3D {MT_NONE, MT_NONE, MT_NONE, MT_NONE};
-			int i;
+		RTRACE("Starting monitor auto detection...\n");
=20
-			for (i =3D 0; i < 4; i++)
-				mon_types[i] =3D radeon_probe_i2c_connector(rinfo,
-									  i+1, &EDIDs[i]);
-		}
-#endif /* DEBUG */
 		/*
 		 * Old single head cards
 		 */
 		if (!rinfo->has_CRTC2) {
-#ifdef CONFIG_PPC_OF
-			if (rinfo->mon1_type =3D=3D MT_NONE)
-				rinfo->mon1_type =3D radeon_probe_OF_head(rinfo, 0,
-									&rinfo->mon1_EDID);
-#endif /* CONFIG_PPC_OF */
 #ifdef CONFIG_FB_RADEON_I2C
-			if (rinfo->mon1_type =3D=3D MT_NONE)
-				rinfo->mon1_type =3D
-					radeon_probe_i2c_connector(rinfo, ddc_dvi,
-								   &rinfo->mon1_EDID);
-			if (rinfo->mon1_type =3D=3D MT_NONE)
-				rinfo->mon1_type =3D
-					radeon_probe_i2c_connector(rinfo, ddc_vga,
-								   &rinfo->mon1_EDID);
-			if (rinfo->mon1_type =3D=3D MT_NONE)
-				rinfo->mon1_type =3D
-					radeon_probe_i2c_connector(rinfo, ddc_crt2,
-								   &rinfo->mon1_EDID);=09
-#endif /* CONFIG_FB_RADEON_I2C */
-			if (rinfo->mon1_type =3D=3D MT_NONE)
-				rinfo->mon1_type =3D MT_CRT;
-			goto bail;
-		}
-
-		/*
-		 * Check for cards with reversed DACs or TMDS controllers using BIOS
-		 */
-		if (rinfo->bios_seg &&
-		    (tmp =3D BIOS_IN16(rinfo->fp_bios_start + 0x50))) {
-			for (i =3D 1; i < 4; i++) {
-				unsigned int tmp0;
-
-				if (!BIOS_IN8(tmp + i*2) && i > 1)
+			/* Probe each connector */
+			for(i =3D 0 ; i < RADEON_MAX_CONNECTORS ; i++) {
+				if (PRIMARY_MONITOR(rinfo) > MT_NONE)
+					/* only one head */
 					break;
-				tmp0 =3D BIOS_IN16(tmp + i*2);
-				if ((!(tmp0 & 0x01)) && (((tmp0 >> 8) & 0x0f) =3D=3D ddc_dvi)) {
-					rinfo->reversed_DAC =3D 1;
-					printk(KERN_INFO "radeonfb: Reversed DACs detected\n");
-				}
-				if ((((tmp0 >> 8) & 0x0f) =3D=3D ddc_dvi) && ((tmp0 >> 4) & 0x01)) {
-					rinfo->reversed_TMDS =3D 1;
-					printk(KERN_INFO "radeonfb: Reversed TMDS detected\n");
+				if (!radeon_probe_i2c_connector(rinfo, &rinfo->connectors[i])) {
+					rinfo->heads[rinfo->num_heads] =3D i;
+					rinfo->connectors[i].head =3D rinfo->num_heads++;
 				}
 			}
+#endif /* CONFIG_FB_RADEON_I2C */
+			if (PRIMARY_MONITOR(rinfo) <=3D MT_NONE) {
+				radeon_find_connector_for_mon(rinfo, MT_CRT);
+			}
+			goto bail;
 		}
=20
-		/*
-		 * Probe primary head (DVI or laptop internal panel)
-		 */
-#ifdef CONFIG_PPC_OF
-		if (rinfo->mon1_type =3D=3D MT_NONE)
-			rinfo->mon1_type =3D radeon_probe_OF_head(rinfo, 0,
-								&rinfo->mon1_EDID);
-#endif /* CONFIG_PPC_OF */
+		/* Probe heads */
 #ifdef CONFIG_FB_RADEON_I2C
-		if (rinfo->mon1_type =3D=3D MT_NONE)
-			rinfo->mon1_type =3D radeon_probe_i2c_connector(rinfo, ddc_dvi,
-								      &rinfo->mon1_EDID);
-		if (rinfo->mon1_type =3D=3D MT_NONE) {
-			rinfo->mon1_type =3D radeon_probe_i2c_connector(rinfo, ddc_crt2,
-								      &rinfo->mon1_EDID);
-			if (rinfo->mon1_type !=3D MT_NONE)
-				ddc_crt2_used =3D 1;
-		}
-#endif /* CONFIG_FB_RADEON_I2C */
-		if (rinfo->mon1_type =3D=3D MT_NONE && rinfo->is_mobility &&
-		    ((rinfo->bios_seg && (INREG(BIOS_4_SCRATCH) & 4))
-		     || (INREG(LVDS_GEN_CNTL) & LVDS_ON))) {
-			rinfo->mon1_type =3D MT_LCD;
-			printk("Non-DDC laptop panel detected\n");
+		/* Probe each connector in turn. */
+		for(i =3D 0; i < RADEON_MAX_CONNECTORS; i++) {
+			if (rinfo->connectors[i].mon_type > MT_NONE)
+				/* Don't probe "detected" stuff again */
+				continue;
+			if (!radeon_probe_i2c_connector(rinfo, &rinfo->connectors[i])) {
+				rinfo->heads[rinfo->num_heads] =3D i;
+				rinfo->connectors[i].head =3D rinfo->num_heads++;
+			}
 		}
-		if (rinfo->mon1_type =3D=3D MT_NONE)
-			rinfo->mon1_type =3D radeon_crt_is_connected(rinfo, rinfo->reversed_D=
AC);
=20
-		/*
-		 * Probe secondary head (mostly VGA, can be DVI)
-		 */
-#ifdef CONFIG_PPC_OF
-		if (rinfo->mon2_type =3D=3D MT_NONE)
-			rinfo->mon2_type =3D radeon_probe_OF_head(rinfo, 1,
-								&rinfo->mon2_EDID);
-#endif /* CONFIG_PPC_OF */
-#ifdef CONFIG_FB_RADEON_I2C
-		if (rinfo->mon2_type =3D=3D MT_NONE)
-			rinfo->mon2_type =3D radeon_probe_i2c_connector(rinfo, ddc_vga,
-								      &rinfo->mon2_EDID);
-		if (rinfo->mon2_type =3D=3D MT_NONE && !ddc_crt2_used)
-			rinfo->mon2_type =3D radeon_probe_i2c_connector(rinfo, ddc_crt2,
-								      &rinfo->mon2_EDID);
 #endif /* CONFIG_FB_RADEON_I2C */
-		if (rinfo->mon2_type =3D=3D MT_NONE)
-			rinfo->mon2_type =3D radeon_crt_is_connected(rinfo, !rinfo->reversed_=
DAC);
=20
-		/*
-		 * If we only detected port 2, we swap them, if none detected,
-		 * assume CRT (maybe fallback to old BIOS_SCRATCH stuff ? or look
-		 * at FP registers ?)
-		 */
-		if (rinfo->mon1_type =3D=3D MT_NONE) {
-			if (rinfo->mon2_type !=3D MT_NONE) {
-				rinfo->mon1_type =3D rinfo->mon2_type;
-				rinfo->mon1_EDID =3D rinfo->mon2_EDID;
-			} else
-				rinfo->mon1_type =3D MT_CRT;
-			rinfo->mon2_type =3D MT_NONE;
-			rinfo->mon2_EDID =3D NULL;
+		/* Mobility chips usually have LCDs... */
+		if ((PRIMARY_MONITOR(rinfo) <=3D MT_NONE) &&
+		    rinfo->is_mobility &&
+		    ((rinfo->bios_seg && (INREG(BIOS_4_SCRATCH) & 4)) ||
+		     (INREG(LVDS_GEN_CNTL) & (LVDS_EN|LVDS_ON)))) {
+			printk(KERN_INFO "radeonfb: Non-DDC laptop panel detected\n");
+			radeon_find_connector_for_mon(rinfo, MT_LCD);
+			if (rinfo->radeon_get_lvds_info) {
+				rinfo->radeon_get_lvds_info(rinfo);
+			}
 		}
=20
-		/*
-		 * Deal with reversed TMDS
-		 */
-		if (rinfo->reversed_TMDS) {
-			/* Always keep internal TMDS as primary head */
-			if (rinfo->mon1_type =3D=3D MT_DFP || rinfo->mon2_type =3D=3D MT_DFP)=
 {
-				int tmp_type =3D rinfo->mon1_type;
-				u8 *tmp_EDID =3D rinfo->mon1_EDID;
-				rinfo->mon1_type =3D rinfo->mon2_type;
-				rinfo->mon1_EDID =3D rinfo->mon2_EDID;
-				rinfo->mon2_type =3D tmp_type;
-				rinfo->mon2_EDID =3D tmp_EDID;
-				if (rinfo->mon1_type =3D=3D MT_CRT || rinfo->mon2_type =3D=3D MT_CRT=
)
-					rinfo->reversed_DAC ^=3D 1;
-			}
+		/* Probe for monitors on the primary and secondary crtc heads */
+		if (PRIMARY_MONITOR(rinfo) <=3D MT_NONE)
+			radeon_find_connector_for_mon(rinfo, radeon_crt_is_connected(rinfo, 1=
));
+
+		/* If we still haven't found anything, just force it to be on the CRT.=
. */
+		if (PRIMARY_MONITOR(rinfo) <=3D MT_NONE)
+			radeon_find_connector_for_mon(rinfo, MT_CRT);
+
+		/* Always keep internal TMDS as primary head */
+		if (SECONDARY_HEAD_PRESENT(rinfo) &&
+		    (SECONDARY_HEAD(rinfo).tmds_type =3D=3D tmds_internal) &&
+		    (SECONDARY_MONITOR(rinfo) =3D=3D MT_DFP)) {
+			int head =3D rinfo->heads[0];
+			rinfo->heads[0] =3D rinfo->heads[1];
+			rinfo->heads[1] =3D head;
 		}
 	}
-	if (ignore_edid) {
-		kfree(rinfo->mon1_EDID);
-		rinfo->mon1_EDID =3D NULL;
-		kfree(rinfo->mon2_EDID);
-		rinfo->mon2_EDID =3D NULL;
+bail:
+
+	/* Dump out the heads we've found so far */
+	for (i =3D 0; i < RADEON_MAX_CONNECTORS; i++) {
+		if (rinfo->connectors[i].conn_type =3D=3D conn_none)
+			continue;
+		printk(KERN_INFO " * Connector %d is %s. Head %d, Monitor: %s ", i + 1=
,
+			conn_type_name[rinfo->connectors[i].conn_type],
+			rinfo->connectors[i].head,
+			rinfo->connectors[i].mon_type =3D=3D MT_UNKNOWN  ?
+				"Not Probed Yet" :
+				mon_type_name[rinfo->connectors[i].mon_type]);
+
+		if (rinfo->connectors[i].edid)
+			printk("(EDID probed)\n");
+		else
+			printk("\n");
+
+		printk(KERN_INFO "   ddc port: %d, dac: %d, tmds: %d\n",
+			rinfo->connectors[i].ddc_type,
+			rinfo->connectors[i].dac_type,
+			rinfo->connectors[i].tmds_type);
 	}
-
- bail:
-	printk(KERN_INFO "radeonfb: Monitor 1 type %s found\n",
-	       radeon_get_mon_name(rinfo->mon1_type));
-	if (rinfo->mon1_EDID)
-		printk(KERN_INFO "radeonfb: EDID probed\n");
-	if (!rinfo->has_CRTC2)
-		return;
-	printk(KERN_INFO "radeonfb: Monitor 2 type %s found\n",
-	       radeon_get_mon_name(rinfo->mon2_type));
-	if (rinfo->mon2_EDID)
-		printk(KERN_INFO "radeonfb: EDID probed\n");
 }
=20
=20
-/*
- * This functions applyes any arch/model/machine specific fixups
- * to the panel info. It may eventually alter EDID block as
- * well or whatever is specific to a given model and not probed
- * properly by the default code
- */
-static void radeon_fixup_panel_info(struct radeonfb_info *rinfo)
-{
 #ifdef CONFIG_PPC_OF
+int __devinit radeon_get_lvds_info_openfirmware(struct radeonfb_info *ri=
nfo)
+{
+
 	/*
 	 * LCD Flat panels should use fixed dividers, we enfore that on
 	 * PPC only for now...
 	 */
-	if (!rinfo->panel_info.use_bios_dividers && rinfo->mon1_type =3D=3D MT_=
LCD
-	    && rinfo->is_mobility) {
+	if (!rinfo->panel_info.use_bios_dividers && (PRIMARY_MONITOR(rinfo) =3D=
=3D MT_LCD) &&
+	    rinfo->is_mobility) {
 		int ppll_div_sel;
 		u32 ppll_divn;
 		ppll_div_sel =3D INREG8(CLOCK_CNTL_INDEX + 1) & 0x3;
@@ -666,15 +1243,16 @@ static void radeon_fixup_panel_info(struct radeonf=
b_info *rinfo)
 		rinfo->panel_info.post_divider =3D (ppll_divn >> 16) & 0x7;
 		rinfo->panel_info.use_bios_dividers =3D 1;
=20
-		printk(KERN_DEBUG "radeonfb: Using Firmware dividers 0x%08x "
+		printk(KERN_INFO "Using Firmware dividers 0x%08x "
 		       "from PPLL %d\n",
 		       rinfo->panel_info.fbk_divider |
 		       (rinfo->panel_info.post_divider << 16),
 		       ppll_div_sel);
+		return 0;
 	}
-#endif /* CONFIG_PPC_OF */
+	return -ENODEV;
 }
-
+#endif /* CONFIG_PPC_OF */
=20
 /*
  * Fill up panel infos from a mode definition, either returned by the ED=
ID
@@ -687,18 +1265,18 @@ static void radeon_var_to_panel_info(struct radeon=
fb_info *rinfo, struct fb_var_
 	rinfo->panel_info.clock =3D 100000000 / var->pixclock;
 	rinfo->panel_info.hOver_plus =3D var->right_margin;
 	rinfo->panel_info.hSync_width =3D var->hsync_len;
-       	rinfo->panel_info.hblank =3D var->left_margin +
+	rinfo->panel_info.hblank =3D var->left_margin +
 		(var->right_margin + var->hsync_len);
 	rinfo->panel_info.vOver_plus =3D var->lower_margin;
 	rinfo->panel_info.vSync_width =3D var->vsync_len;
-       	rinfo->panel_info.vblank =3D var->upper_margin +
+	rinfo->panel_info.vblank =3D var->upper_margin +
 		(var->lower_margin + var->vsync_len);
 	rinfo->panel_info.hAct_high =3D
 		(var->sync & FB_SYNC_HOR_HIGH_ACT) !=3D 0;
 	rinfo->panel_info.vAct_high =3D
 		(var->sync & FB_SYNC_VERT_HIGH_ACT) !=3D 0;
 	rinfo->panel_info.valid =3D 1;
-	/* We use a default of 200ms for the panel power delay,=20
+	/* We use a default of 200ms for the panel power delay,
 	 * I need to have a real schedule() instead of mdelay's in the panel co=
de.
 	 * we might be possible to figure out a better power delay either from
 	 * MacOS OF tree or from the EDID block (proprietary extensions ?)
@@ -741,22 +1319,34 @@ void __devinit radeon_check_modes(struct radeonfb_=
info *rinfo, const char *mode_
 	info->var =3D radeonfb_default_var;
 	INIT_LIST_HEAD(&info->modelist);
=20
-	/*
-	 * First check out what BIOS has to say
-	 */
-	if (rinfo->mon1_type =3D=3D MT_LCD)
-		radeon_get_panel_info_BIOS(rinfo);
+	/* If we're an LCD and don't have a valid setup... */
+	if ((PRIMARY_MONITOR(rinfo) =3D=3D MT_LCD) &&
+	    !rinfo->panel_info.valid &&
+	    rinfo->radeon_get_lvds_info) {
+		rinfo->radeon_get_lvds_info(rinfo);
+	}
+
+#if 0
+	/* If we're a mobility and still haven't detected a screen..? */
+	if ((PRIMARY_MONITOR(rinfo) <=3D MT_NONE) &&
+	    rinfo->is_mobility &&
+	    rinfo->radeon_get_lvds_info) {
+		if (!rinfo->radeon_get_lvds_info(rinfo))
+			radeon_find_connector_for_mon(rinfo, MT_LCD);
+	}
+#endif
=20
 	/*
 	 * Parse EDID detailed timings and deduce panel infos if any. Right now
 	 * we only deal with first entry returned by parse_EDID, we may do bett=
er
 	 * some day...
 	 */
-	if (!rinfo->panel_info.use_bios_dividers && rinfo->mon1_type !=3D MT_CR=
T
-	    && rinfo->mon1_EDID) {
+	if (!rinfo->panel_info.use_bios_dividers &&
+	    (PRIMARY_MONITOR(rinfo) !=3D MT_CRT) &&
+	    PRIMARY_HEAD(rinfo).edid) {
 		struct fb_var_screeninfo var;
 		RTRACE("Parsing EDID data for panel info\n");
-		if (fb_parse_edid(rinfo->mon1_EDID, &var) =3D=3D 0) {
+		if (fb_parse_edid(PRIMARY_HEAD(rinfo).edid, &var) =3D=3D 0) {
 			if (var.xres >=3D rinfo->panel_info.xres &&
 			    var.yres >=3D rinfo->panel_info.yres)
 				radeon_var_to_panel_info(rinfo, &var);
@@ -764,15 +1354,10 @@ void __devinit radeon_check_modes(struct radeonfb_=
info *rinfo, const char *mode_
 	}
=20
 	/*
-	 * Do any additional platform/arch fixups to the panel infos
-	 */
-	radeon_fixup_panel_info(rinfo);
-
-	/*
 	 * If we have some valid panel infos, we setup the default mode based o=
n
 	 * those
 	 */
-	if (rinfo->mon1_type !=3D MT_CRT && rinfo->panel_info.valid) {
+	if ((PRIMARY_MONITOR(rinfo) !=3D MT_CRT) && rinfo->panel_info.valid) {
 		struct fb_var_screeninfo *var =3D &info->var;
=20
 		RTRACE("Setting up default mode based on panel info\n");
@@ -803,22 +1388,21 @@ void __devinit radeon_check_modes(struct radeonfb_=
info *rinfo, const char *mode_
 	/*
 	 * Now build modedb from EDID
 	 */
-	if (rinfo->mon1_EDID) {
-		fb_edid_to_monspecs(rinfo->mon1_EDID, &info->monspecs);
+	if (PRIMARY_HEAD(rinfo).edid) {
+		fb_edid_to_monspecs(PRIMARY_HEAD(rinfo).edid, &info->monspecs);
 		fb_videomode_to_modelist(info->monspecs.modedb,
 					 info->monspecs.modedb_len,
 					 &info->modelist);
-		rinfo->mon1_modedb =3D info->monspecs.modedb;
-		rinfo->mon1_dbsize =3D info->monspecs.modedb_len;
+		PRIMARY_HEAD(rinfo).modedb =3D info->monspecs.modedb;
+		PRIMARY_HEAD(rinfo).modedb_size =3D info->monspecs.modedb_len;
 	}
=20
-=09
 	/*
 	 * Finally, if we don't have panel infos we need to figure some (or
 	 * we try to read it from card), we try to pick a default mode
 	 * and create some panel infos. Whatever...
 	 */
-	if (rinfo->mon1_type !=3D MT_CRT && !rinfo->panel_info.valid) {
+	if ((PRIMARY_MONITOR(rinfo) !=3D MT_CRT) && !rinfo->panel_info.valid) {
 		struct fb_videomode	*modedb;
 		int			dbsize;
 		char			modename[32];
@@ -832,25 +1416,26 @@ void __devinit radeon_check_modes(struct radeonfb_=
info *rinfo, const char *mode_
 		}
 		if (rinfo->panel_info.xres =3D=3D 0 || rinfo->panel_info.yres =3D=3D 0=
) {
 			printk(KERN_WARNING "radeonfb: Can't find panel size, going back to C=
RT\n");
-			rinfo->mon1_type =3D MT_CRT;
+			radeon_find_connector_for_mon(rinfo, MT_CRT);
 			goto pickup_default;
 		}
 		printk(KERN_WARNING "radeonfb: Assuming panel size %dx%d\n",
 		       rinfo->panel_info.xres, rinfo->panel_info.yres);
-		modedb =3D rinfo->mon1_modedb;
-		dbsize =3D rinfo->mon1_dbsize;
+		modedb =3D PRIMARY_HEAD(rinfo).modedb;
+		dbsize =3D PRIMARY_HEAD(rinfo).modedb_size;
 		snprintf(modename, 31, "%dx%d", rinfo->panel_info.xres, rinfo->panel_i=
nfo.yres);
 		if (fb_find_mode(&info->var, info, modename,
 				 modedb, dbsize, NULL, 8) =3D=3D 0) {
 			printk(KERN_WARNING "radeonfb: Can't find mode for panel size, going =
back to CRT\n");
-			rinfo->mon1_type =3D MT_CRT;
+			radeon_find_connector_for_mon(rinfo, MT_CRT);
 			goto pickup_default;
 		}
 		has_default_mode =3D 1;
+		radeon_find_connector_for_mon(rinfo, MT_LCD);
 		radeon_var_to_panel_info(rinfo, &info->var);
 	}
=20
- pickup_default:
+pickup_default:
 	/*
 	 * Apply passed-in mode option if any
 	 */
@@ -859,7 +1444,7 @@ void __devinit radeon_check_modes(struct radeonfb_in=
fo *rinfo, const char *mode_
 				 info->monspecs.modedb,
 				 info->monspecs.modedb_len, NULL, 8) !=3D 0)
 			has_default_mode =3D 1;
- 	}
+	}
=20
 	/*
 	 * Still no mode, let's pick up a default from the db
@@ -946,14 +1531,14 @@ int  radeon_match_mode(struct radeonfb_info *rinfo=
,
 	memcpy(dest, src, sizeof(struct fb_var_screeninfo));
=20
 	/* Check if we have a modedb built from EDID */
-	if (rinfo->mon1_modedb) {
-		db =3D rinfo->mon1_modedb;
-		dbsize =3D rinfo->mon1_dbsize;
+	if (PRIMARY_HEAD(rinfo).modedb) {
+		db =3D PRIMARY_HEAD(rinfo).modedb;
+		dbsize =3D PRIMARY_HEAD(rinfo).modedb_size;
 		native_db =3D 1;
 	}
=20
 	/* Check if we have a scaler allowing any fancy mode */
-	has_rmx =3D rinfo->mon1_type =3D=3D MT_LCD || rinfo->mon1_type =3D=3D M=
T_DFP;
+	has_rmx =3D (PRIMARY_MONITOR(rinfo) =3D=3D MT_LCD) || (PRIMARY_MONITOR(=
rinfo) =3D=3D MT_DFP);
=20
 	/* If we have a scaler and are passed FB_ACTIVATE_TEST or
 	 * FB_ACTIVATE_NOW, just do basic checking and return if the
@@ -966,7 +1551,7 @@ int  radeon_match_mode(struct radeonfb_info *rinfo,
 		 * 640x480-60, but I assume userland knows what it's doing here
 		 * (though I may be proven wrong...)
 		 */
-		if (has_rmx =3D=3D 0 && rinfo->mon1_modedb)
+		if (has_rmx =3D=3D 0 && PRIMARY_HEAD(rinfo).modedb)
 			if (fb_validate_mode((struct fb_var_screeninfo *)src, rinfo->info))
 				return -EINVAL;
 		return 0;
@@ -978,7 +1563,7 @@ int  radeon_match_mode(struct radeonfb_info *rinfo,
 			int d;
=20
 			if (db[i].yres < src->yres)
-				continue;=09
+				continue;
 			if (db[i].xres < src->xres)
 				continue;
 			d =3D radeon_compare_modes(src, &db[i]);
diff --git a/drivers/video/aty/radeonfb.h b/drivers/video/aty/radeonfb.h
index d5ff224..9819dc5 100644
--- a/drivers/video/aty/radeonfb.h
+++ b/drivers/video/aty/radeonfb.h
@@ -26,6 +26,8 @@
  * Most of the definitions here are adapted right from XFree86 *
  ***************************************************************/
=20
+/* Sorry, we have to limit video ram to 128M */
+#define MAX_VRAM		(128*1024*1024)
=20
 /*
  * Chip families. Must fit in the low 16 bits of a long word
@@ -47,7 +49,8 @@ enum radeon_family {
 	CHIP_FAMILY_R350,
 	CHIP_FAMILY_RV350,
 	CHIP_FAMILY_RV380,    /* RV370/RV380/M22/M24 */
-	CHIP_FAMILY_R420,     /* R420/R423/M18 */
+	CHIP_FAMILY_RV410,    /* RV410/M26 */
+	CHIP_FAMILY_R420,     /* R420/R423/R480/M18 */
 	CHIP_FAMILY_LAST,
 };
=20
@@ -64,6 +67,7 @@ enum radeon_family {
 				((rinfo)->family =3D=3D CHIP_FAMILY_RV350) || \
 				((rinfo)->family =3D=3D CHIP_FAMILY_R350)  || \
 				((rinfo)->family =3D=3D CHIP_FAMILY_RV380) || \
+				((rinfo)->family =3D=3D CHIP_FAMILY_RV410) || \
 				((rinfo)->family =3D=3D CHIP_FAMILY_R420))
=20
 /*
@@ -86,11 +90,50 @@ enum radeon_errata {
 	CHIP_ERRATA_PLL_DELAY		=3D 0x00000004,
 };
=20
+/*
+ * DDC i2c ports
+ */
+enum radeon_ddc_type {
+	ddc_none =3D -1,
+	ddc_monid =3D 0,
+	ddc_dvi,
+	ddc_vga,
+	ddc_crt2,
+};
+
+/*
+ * Connector types
+ */
+enum radeon_legacy_conn_type {
+	legacy_conn_none =3D 0,
+	legacy_conn_proprietary,
+	legacy_conn_crt,
+	legacy_conn_dvi_i,
+	legacy_conn_dvi_d,
+	legacy_conn_ctv,
+	legacy_conn_stv,
+	legacy_conn_unsupported,
+};
+
+enum radeon_conn_type {
+	conn_none =3D 0,
+	conn_vga,
+	conn_dvi_i,
+	conn_dvi_d,
+	conn_dvi_a,
+	conn_stv,
+	conn_ctv,
+	conn_lvds,
+	conn_digital,
+	conn_unsupported,
+	conn_proprietary,
+};
=20
 /*
  * Monitor types
  */
-enum radeon_montype {
+enum radeon_mon_type {
+	MT_UNKNOWN =3D -1,
 	MT_NONE =3D 0,
 	MT_CRT,		/* CRT */
 	MT_LCD,		/* LCD */
@@ -100,27 +143,45 @@ enum radeon_montype {
 };
=20
 /*
- * DDC i2c ports
+ * DAC types
  */
-enum ddc_type {
-	ddc_none,
-	ddc_monid,
-	ddc_dvi,
-	ddc_vga,
-	ddc_crt2,
+enum radeon_dac_type {
+	dac_unknown =3D -1,
+	dac_primary =3D 0,
+	dac_tvdac =3D 1,
 };
=20
 /*
- * Connector types
+ * TMDS types
  */
-enum conn_type {
-	conn_none,
-	conn_proprietary,
-	conn_crt,
-	conn_DVI_I,
-	conn_DVI_D,
+enum radeon_tmds_type {
+	tmds_unknown =3D -1,
+	tmds_internal =3D 0,
+	tmds_external =3D 1,
 };
=20
+/*
+ * Each connector gets this structure associated with it,
+ * containing infos about the connector wiring and about
+ * whatever has been detected on it
+ */
+struct radeon_connector {
+	enum radeon_conn_type	conn_type;
+	enum radeon_ddc_type	ddc_type;
+	enum radeon_dac_type	dac_type;
+	enum radeon_tmds_type	tmds_type;
+	enum radeon_mon_type	mon_type;
+	u8			*edid;
+	struct fb_videomode	*modedb;
+	unsigned int		modedb_size;
+
+	int head;
+};
+
+/*
+ * Currently, the driver deals with at most 4 connectors
+ */
+#define RADEON_MAX_CONNECTORS	4
=20
 /*
  * PLL infos
@@ -128,11 +189,19 @@ enum conn_type {
 struct pll_info {
 	int ppll_max;
 	int ppll_min;
-	int sclk, mclk;
+	int sclk;
+	int mclk;
 	int ref_div;
 	int ref_clk;
 };
=20
+/*
+ * TMDS PLL infos
+ */
+struct radeon_tmds_pll_info {
+	long	freq;
+	u32	value;
+};
=20
 /*
  * This structure contains the various registers manipulated by this
@@ -299,6 +368,20 @@ struct radeonfb_info {
 	void __iomem		*bios_seg;
 	int			fp_bios_start;
=20
+	int                     is_atom_bios;
+	int                     atom_data_start;
+
+	/* BIOS Functions */
+	int                     (*radeon_get_pll_info)(struct radeonfb_info *ri=
nfo);
+	int                     (*radeon_get_lvds_info)(struct radeonfb_info *r=
info);
+	int                     (*radeon_get_conn_info)(struct radeonfb_info *r=
info);
+	int                     (*radeon_get_tmds_info)(struct radeonfb_info *r=
info);
+
+	/* Connector infos */
+	struct radeon_connector		connectors[RADEON_MAX_CONNECTORS];
+	int                     heads[RADEON_MAX_CONNECTORS];  // index into co=
nnectors.
+	int                     num_heads;  // number of heads.
+
 	u32			pseudo_palette[17];
 	struct { u8 red, green, blue, pad; }
 				palette[256];
@@ -317,15 +400,8 @@ struct radeonfb_info {
 	int			has_CRTC2;
 	int			is_mobility;
 	int			is_IGP;
-	int			reversed_DAC;
-	int			reversed_TMDS;
 	struct panel_info	panel_info;
-	int			mon1_type;
-	u8			*mon1_EDID;
-	struct fb_videomode	*mon1_modedb;
-	int			mon1_dbsize;
-	int			mon2_type;
-	u8		        *mon2_EDID;
+	struct radeon_tmds_pll_info	tmds_pll[4];
=20
 	u32			dp_gui_master_cntl;
=20
@@ -357,24 +433,19 @@ struct radeonfb_info {
 };
=20
=20
-#define PRIMARY_MONITOR(rinfo)	(rinfo->mon1_type)
+#define PRIMARY_HEAD(rinfo)      (rinfo->connectors[rinfo->heads[0]])
+#define SECONDARY_HEAD(rinfo)    (rinfo->connectors[rinfo->heads[1]])
=20
+#define SECONDARY_HEAD_PRESENT(rinfo) (rinfo->heads[1] !=3D -1)
+
+#define PRIMARY_MONITOR(rinfo)	 (rinfo->connectors[rinfo->heads[0]].mon_=
type)
+#define SECONDARY_MONITOR(rinfo) ((SECONDARY_HEAD_PRESENT(rinfo) ? (rinf=
o->connectors[rinfo->heads[1]].mon_type) : MT_NONE))
=20
 /*
  * Debugging stuffs
  */
-#ifdef CONFIG_FB_RADEON_DEBUG
-#define DEBUG		1
-#else
-#define DEBUG		0
-#endif
-
-#if DEBUG
-#define RTRACE		printk
-#else
-#define RTRACE		if(0) printk
-#endif
-
+extern int radeonfb_debug;
+#define RTRACE		if(radeonfb_debug) printk
=20
 /*
  * IO macros
@@ -597,7 +668,7 @@ static inline void _radeon_engine_idle(struct radeonf=
b_info *rinfo)
 /* I2C Functions */
 extern void radeon_create_i2c_busses(struct radeonfb_info *rinfo);
 extern void radeon_delete_i2c_busses(struct radeonfb_info *rinfo);
-extern int radeon_probe_i2c_connector(struct radeonfb_info *rinfo, int c=
onn, u8 **out_edid);
+extern int radeon_probe_i2c_connector(struct radeonfb_info *rinfo, struc=
t radeon_connector *conn);
=20
 /* PM Functions */
 extern int radeonfb_pci_suspend(struct pci_dev *pdev, pm_message_t state=
);
@@ -635,4 +706,18 @@ static inline void radeonfb_bl_init(struct radeonfb_=
info *rinfo) {}
 static inline void radeonfb_bl_exit(struct radeonfb_info *rinfo) {}
 #endif
=20
+/* Bios functions.  Fix this. */
+extern void __devinit radeon_get_conn_info(struct radeonfb_info *rinfo, =
int ignore_conntable);
+extern void __devinit radeon_get_tmds_info(struct radeonfb_info *rinfo);
+
+extern int __devinit radeon_get_lvds_info_atom(struct radeonfb_info *rin=
fo);
+extern int __devinit radeon_get_lvds_info_legacy(struct radeonfb_info *r=
info);
+extern int __devinit radeon_get_conn_info_atom(struct radeonfb_info *rin=
fo);
+extern int __devinit radeon_get_conn_info_legacy(struct radeonfb_info *r=
info);
+extern int __devinit radeon_get_tmds_info_legacy(struct radeonfb_info *r=
info);
+extern int __devinit radeon_get_tmds_info_atom(struct radeonfb_info *rin=
fo);
+#ifdef CONFIG_PPC_OF
+extern int __devinit radeon_get_lvds_info_openfirmware(struct radeonfb_i=
nfo *rinfo);
+extern int __devinit radeon_get_conn_info_openfirmware(struct radeonfb_i=
nfo *rinfo);
+#endif
 #endif /* __RADEONFB_H__ */


Happy new year!
Luca
--=20
"La donna =E8 coinvolta sessualmente in tutti gli affari della vita. A
 volte perfino nell'amore." -- K. Kraus


--===============1460537926==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1460537926==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1460537926==--
