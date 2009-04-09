From: Andrew Morton <akpm@linux-foundation.org>
Subject: intelfb-support-i854.patch
Date: Thu, 9 Apr 2009 13:35:16 -0700
Message-ID: <20090409133516.f2c44402.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <akpm@linux-foundation.org>) id 1Ls11T-0005bw-7R
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 09 Apr 2009 20:38:55 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Ls11H-0002tT-Ep
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 09 Apr 2009 20:38:45 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Keith Packard <keithp@keithp.com>, Dave Airlie <airlied@linux.ie>
Cc: Stefan Husemann <shusemann@googlemail.com>, linux-fbdev-devel@lists.sourceforge.net


Guys, I've been sitting on this patch for ages because there was some
issue wrt interactions with drm (iirc).

Could you please refresh our memories on what the problem was and help
find the resolution here?

Thanks.


From: "Stefan Husemann" <shusemann@googlemail.com>

Support the Intel 854 Chipset in fbdev.

We test and use the patch on a Thomson IP1101 IPTV-Box.  On the VGA-Port
we get a normal signal.

Here is the link to the Mambux-Project: http://www.mambux.de

Cc: Keith Packard <keithp@keithp.com>
Cc: Dave Airlie <airlied@linux.ie>
Cc: Krzysztof Helt <krzysztof.h1@poczta.fm>
Signed-off-by: Stefan Husemann <shusemann@googlemail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/char/agp/intel-agp.c        |    3 +++
 drivers/video/intelfb/intelfb.h     |    2 ++
 drivers/video/intelfb/intelfb_i2c.c |    1 +
 drivers/video/intelfb/intelfbdrv.c  |    1 +
 drivers/video/intelfb/intelfbhw.c   |    5 +++++
 include/drm/drm_pciids.h            |    2 ++
 include/linux/pci_ids.h             |    2 ++
 7 files changed, 16 insertions(+)

diff -puN drivers/char/agp/intel-agp.c~intelfb-support-i854 drivers/char/agp/intel-agp.c
--- a/drivers/char/agp/intel-agp.c~intelfb-support-i854
+++ a/drivers/char/agp/intel-agp.c
@@ -2131,6 +2131,8 @@ static const struct intel_driver_descrip
 	{ PCI_DEVICE_ID_INTEL_82845G_HB, PCI_DEVICE_ID_INTEL_82845G_IG, 0, "830M",
 		&intel_845_driver, &intel_830_driver },
 	{ PCI_DEVICE_ID_INTEL_82850_HB, 0, 0, "i850", &intel_850_driver, NULL },
+	{ PCI_DEVICE_ID_INTEL_82854_HB, PCI_DEVICE_ID_INTEL_82854_IG, 0, "854",
+		&intel_845_driver, &intel_830_driver },
 	{ PCI_DEVICE_ID_INTEL_82855PM_HB, 0, 0, "855PM", &intel_845_driver, NULL },
 	{ PCI_DEVICE_ID_INTEL_82855GM_HB, PCI_DEVICE_ID_INTEL_82855GM_IG, 0, "855GM",
 		&intel_845_driver, &intel_830_driver },
@@ -2355,6 +2357,7 @@ static struct pci_device_id agp_intel_pc
 	ID(PCI_DEVICE_ID_INTEL_82845_HB),
 	ID(PCI_DEVICE_ID_INTEL_82845G_HB),
 	ID(PCI_DEVICE_ID_INTEL_82850_HB),
+	ID(PCI_DEVICE_ID_INTEL_82854_HB),
 	ID(PCI_DEVICE_ID_INTEL_82855PM_HB),
 	ID(PCI_DEVICE_ID_INTEL_82855GM_HB),
 	ID(PCI_DEVICE_ID_INTEL_82860_HB),
diff -puN drivers/video/intelfb/intelfb.h~intelfb-support-i854 drivers/video/intelfb/intelfb.h
--- a/drivers/video/intelfb/intelfb.h~intelfb-support-i854
+++ a/drivers/video/intelfb/intelfb.h
@@ -53,6 +53,7 @@
 #define PCI_DEVICE_ID_INTEL_830M	0x3577
 #define PCI_DEVICE_ID_INTEL_845G	0x2562
 #define PCI_DEVICE_ID_INTEL_85XGM	0x3582
+#define PCI_DEVICE_ID_INTEL_854		0x358E
 #define PCI_DEVICE_ID_INTEL_865G	0x2572
 #define PCI_DEVICE_ID_INTEL_915G	0x2582
 #define PCI_DEVICE_ID_INTEL_915GM	0x2592
@@ -154,6 +155,7 @@ enum intel_chips {
 	INTEL_85XGM,
 	INTEL_852GM,
 	INTEL_852GME,
+	INTEL_854,
 	INTEL_855GM,
 	INTEL_855GME,
 	INTEL_865G,
diff -puN drivers/video/intelfb/intelfb_i2c.c~intelfb-support-i854 drivers/video/intelfb/intelfb_i2c.c
--- a/drivers/video/intelfb/intelfb_i2c.c~intelfb-support-i854
+++ a/drivers/video/intelfb/intelfb_i2c.c
@@ -156,6 +156,7 @@ void intelfb_create_i2c_busses(struct in
 	switch(dinfo->chipset) {
 	case INTEL_830M:
 	case INTEL_845G:
+	case INTEL_854:
 	case INTEL_855GM:
 	case INTEL_865G:
 		dinfo->output[i].type = INTELFB_OUTPUT_DVO;
diff -puN drivers/video/intelfb/intelfbdrv.c~intelfb-support-i854 drivers/video/intelfb/intelfbdrv.c
--- a/drivers/video/intelfb/intelfbdrv.c~intelfb-support-i854
+++ a/drivers/video/intelfb/intelfbdrv.c
@@ -182,6 +182,7 @@ static struct pci_device_id intelfb_pci_
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_845G, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_845G },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_85XGM, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_85XGM },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_865G, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_865G },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_854, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_854 },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_915G, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_915G },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_915GM, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_915GM },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_945G, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_945G },
diff -puN drivers/video/intelfb/intelfbhw.c~intelfb-support-i854 drivers/video/intelfb/intelfbhw.c
--- a/drivers/video/intelfb/intelfbhw.c~intelfb-support-i854
+++ a/drivers/video/intelfb/intelfbhw.c
@@ -84,6 +84,11 @@ int intelfbhw_get_chipset(struct pci_dev
 		dinfo->mobile = 0;
 		dinfo->pll_index = PLLS_I8xx;
 		return 0;
+	case PCI_DEVICE_ID_INTEL_854:
+		dinfo->mobile = 1;
+		dinfo->name = "Intel(R) 854";
+		dinfo->chipset = INTEL_854;
+		return 0;
 	case PCI_DEVICE_ID_INTEL_85XGM:
 		tmp = 0;
 		dinfo->mobile = 1;
diff -puN include/drm/drm_pciids.h~intelfb-support-i854 include/drm/drm_pciids.h
--- a/include/drm/drm_pciids.h~intelfb-support-i854
+++ a/include/drm/drm_pciids.h
@@ -472,6 +472,7 @@
 	{0x8086, 0x2562, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
 	{0x8086, 0x3582, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
 	{0x8086, 0x2572, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
+	{0x8086, 0x358e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
 	{0, 0, 0}
 
 #define gamma_PCI_IDS \
@@ -533,4 +534,5 @@
 	{0x8086, 0x2e22, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA << 8, 0xffff00, 0}, \
 	{0x8086, 0xa001, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA << 8, 0xffff00, 0}, \
 	{0x8086, 0xa011, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA << 8, 0xffff00, 0}, \
+	{0x8086, 0x35e8, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA << 8, 0xffff00, 0}, \
 	{0, 0, 0}
diff -puN include/linux/pci_ids.h~intelfb-support-i854 include/linux/pci_ids.h
--- a/include/linux/pci_ids.h~intelfb-support-i854
+++ a/include/linux/pci_ids.h
@@ -2513,6 +2513,8 @@
 #define PCI_DEVICE_ID_INTEL_IOAT_TBG3	0x3433
 #define PCI_DEVICE_ID_INTEL_82830_HB	0x3575
 #define PCI_DEVICE_ID_INTEL_82830_CGC	0x3577
+#define PCI_DEVICE_ID_INTEL_82854_HB	0x358c
+#define PCI_DEVICE_ID_INTEL_82854_IG	0x358e
 #define PCI_DEVICE_ID_INTEL_82855GM_HB	0x3580
 #define PCI_DEVICE_ID_INTEL_82855GM_IG	0x3582
 #define PCI_DEVICE_ID_INTEL_E7520_MCH	0x3590
_


------------------------------------------------------------------------------
This SF.net email is sponsored by:
High Quality Requirements in a Collaborative Environment.
Download a free trial of Rational Requirements Composer Now!
http://p.sf.net/sfu/www-ibm-com
