From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Patch to support i854 with intelfb
Date: Fri, 10 Oct 2008 14:12:30 -0700
Message-ID: <20081010141230.7ac56d7b.akpm@linux-foundation.org>
References: <f43011d0810081200v7ed6b3fbl7c60ce4197e95f3@mail.gmail.com>
	<f43011d0810081213h520c40dcw2369a1f387962c96@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <akpm@linux-foundation.org>) id 1KoPI0-0004zr-JS
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 10 Oct 2008 21:12:48 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1KoPHv-0008RS-4c
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 10 Oct 2008 21:12:48 +0000
In-Reply-To: <f43011d0810081213h520c40dcw2369a1f387962c96@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Stefan Husemann <shusemann@googlemail.com>
Cc: Dave Airlie <airlied@linux.ie>, Keith Packard <keithp@keithp.com>, linux-fbdev-devel@lists.sourceforge.net

On Wed, 8 Oct 2008 21:13:28 +0200
"Stefan Husemann" <shusemann@googlemail.com> wrote:

> Sorry! Again in plaintext:
> 
> Hello,
> 
> I attached a small and simple patch for intelfb to support Intel 854 Chipset.
> 
> We test and use the patch on a Thomson IP1101 IPTV-Box. On the
> VGA-Port we get a normal signal.
> 
> Here is the link to the Mambux-Project: http://www.mambux.de
> 
> We hope that we find our patch later inside the Linux-Kernel ;-)
> 
> Have an nice day
> 

Please always include a Signed-off-by:, as per
Documentation/SubmittingPatches.

I forward-ported your patch from 2.6.25 into the current development
kernels.  It turns out that include/drm/drm_pciids.h already has an
0x8086, 0x358e entry, so we'll need to work out what to do there?


From: "Stefan Husemann" <shusemann@googlemail.com>

Support the Intel 854 Chipset in fbdev.

We test and use the patch on a Thomson IP1101 IPTV-Box.  On the VGA-Port
we get a normal signal.

Here is the link to the Mambux-Project: http://www.mambux.de

Cc: Keith Packard <keithp@keithp.com>
Cc: Dave Airlie <airlied@linux.ie>
Cc: Krzysztof Helt <krzysztof.h1@poczta.fm>
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
@@ -2114,6 +2114,8 @@ static const struct intel_driver_descrip
 	{ PCI_DEVICE_ID_INTEL_82845G_HB, PCI_DEVICE_ID_INTEL_82845G_IG, 0, "830M",
 		&intel_845_driver, &intel_830_driver },
 	{ PCI_DEVICE_ID_INTEL_82850_HB, 0, 0, "i850", &intel_850_driver, NULL },
+	{ PCI_DEVICE_ID_INTEL_82854_HB, PCI_DEVICE_ID_INTEL_82854_IG, 0, "854",
+		&intel_845_driver, &intel_830_driver },
 	{ PCI_DEVICE_ID_INTEL_82855PM_HB, 0, 0, "855PM", &intel_845_driver, NULL },
 	{ PCI_DEVICE_ID_INTEL_82855GM_HB, PCI_DEVICE_ID_INTEL_82855GM_IG, 0, "855GM",
 		&intel_845_driver, &intel_830_driver },
@@ -2332,6 +2334,7 @@ static struct pci_device_id agp_intel_pc
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
@@ -157,6 +157,7 @@ void intelfb_create_i2c_busses(struct in
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
@@ -353,6 +353,7 @@
 	{0x8086, 0x2562, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
 	{0x8086, 0x3582, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
 	{0x8086, 0x2572, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
+	{0x8086, 0x358e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
 	{0, 0, 0}
 
 #define gamma_PCI_IDS \
@@ -408,6 +409,7 @@
 	{0x8086, 0x29d2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
 	{0x8086, 0x2a02, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
 	{0x8086, 0x2a12, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
+	{0x8086, 0x358e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
 	{0x8086, 0x2a42, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
 	{0x8086, 0x2e02, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
 	{0x8086, 0x2e12, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
diff -puN include/linux/pci_ids.h~intelfb-support-i854 include/linux/pci_ids.h
--- a/include/linux/pci_ids.h~intelfb-support-i854
+++ a/include/linux/pci_ids.h
@@ -2440,6 +2440,8 @@
 #define PCI_DEVICE_ID_INTEL_IOAT_TBG3	0x3433
 #define PCI_DEVICE_ID_INTEL_82830_HB	0x3575
 #define PCI_DEVICE_ID_INTEL_82830_CGC	0x3577
+#define PCI_DEVICE_ID_INTEL_82854_HB	0x358c
+#define PCI_DEVICE_ID_INTEL_82854_IG	0x358e
 #define PCI_DEVICE_ID_INTEL_82855GM_HB	0x3580
 #define PCI_DEVICE_ID_INTEL_82855GM_IG	0x3582
 #define PCI_DEVICE_ID_INTEL_E7520_MCH	0x3590
_


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
