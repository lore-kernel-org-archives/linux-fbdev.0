From: syrjala@sci.fi
Subject: [PATCH 2/5] matroxfb: Add support for Mystique AGP
Date: Tue,  1 Nov 2005 00:12:20 +0200 (EET)
Message-ID: <20051031221220.69515313@kuori.saunalahti.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EWhtE-0004RZ-LP
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 31 Oct 2005 14:12:28 -0800
Received: from gw01.mail.saunalahti.fi ([195.197.172.115])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EWhtC-0000O5-48
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 31 Oct 2005 14:12:28 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
MIME-Version: 1.0
Content-Type: text; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: vandrove@vc.cvut.cz
Cc: linux-fbdev-devel@lists.sourceforge.net

Add new entries for Mystique AGP with the PCI ID 0x051e.

I don't actually have such boards but according to google they do exist.=20
Curiosly X.Org doesn't recognize that PCI ID. And what's even more=20
interesting is that Matrox's own Windows drivers don't recognize it=20
either. After going through about a dozen different versions I did find=20
one older driver that does list this particular ID. It is also listed in=20
the pci.ids file.

I'm not sure if non-220 AGP chips exist. I left the chip revision check=20
intact for AGP chips nonetheless.

Signed-off-by: Ville Syrj=E4l=E4 <syrjala@sci.fi>
---

 drivers/video/matrox/matroxfb_base.c |   14 ++++++++++++++
 include/linux/pci_ids.h              |    1 +
 2 files changed, 15 insertions(+)

diff -uprN linux-2.6.14-1/drivers/video/matrox/matroxfb_base.c linux-2.6.14=
-2/drivers/video/matrox/matroxfb_base.c
--- linux-2.6.14-1/drivers/video/matrox/matroxfb_base.c	2005-10-31 17:44:11=
.000000000 +0200
+++ linux-2.6.14-2/drivers/video/matrox/matroxfb_base.c	2005-10-31 17:45:41=
.000000000 +0200
@@ -1428,6 +1428,20 @@ static struct board {
 		MGA_1164,
 		&vbMystique,
 		"Mystique 220 (PCI)"},
+	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_MYS_AGP,	0x02,
+		0,			0,
+		DEVF_VIDEO64BIT | DEVF_CROSS4MB,
+		180000,
+		MGA_1064,
+		&vbMystique,
+		"Mystique (AGP)"},
+	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_MYS_AGP,	0xFF,
+		0,			0,
+		DEVF_VIDEO64BIT | DEVF_SWAPS | DEVF_CROSS4MB,
+		220000,
+		MGA_1164,
+		&vbMystique,
+		"Mystique 220 (AGP)"},
 #endif
 #ifdef CONFIG_FB_MATROX_G
 	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_G100_MM,	0xFF,
diff -uprN linux-2.6.14-1/include/linux/pci_ids.h linux-2.6.14-2/include/li=
nux/pci_ids.h
--- linux-2.6.14-1/include/linux/pci_ids.h	2005-10-31 17:43:06.000000000 +0=
200
+++ linux-2.6.14-2/include/linux/pci_ids.h	2005-10-31 17:46:34.000000000 +0=
200
@@ -568,6 +568,7 @@
 #define PCI_DEVICE_ID_MATROX_MIL	0x0519
 #define PCI_DEVICE_ID_MATROX_MYS	0x051A
 #define PCI_DEVICE_ID_MATROX_MIL_2	0x051b
+#define PCI_DEVICE_ID_MATROX_MYS_AGP	0x051e
 #define PCI_DEVICE_ID_MATROX_MIL_2_AGP	0x051f
 #define PCI_DEVICE_ID_MATROX_MGA_IMP	0x0d10
 #define PCI_DEVICE_ID_MATROX_G100_MM	0x1000



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
