From: Gary Hade <garyhade@us.ibm.com>
Date: Tue, 01 Mar 2011 17:50:26 +0000
Subject: matroxfb: remove incorrect Matrox G200eV support
Message-Id: <20110301175026.GA18770@us.ibm.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@us.ibm.com>, Krzysztof Helt <krzysztof.h1@wp.pl>, Petr Vandrovec <vandrove@vc.cvut.cz>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Gary Hade <garyhade@us.ibm.com>


From: Gary Hade <garyhade@us.ibm.com>

Remove incorrect Matrox G200eV support that was previously added
by commit e3a1938805d2e81b27d3d348788644f3bad004f2

One serious issue with the G200eV support that I have reproduced
on a Matrox G200eV equipped IBM x3650 M2 is the lack of text (login
banner, login prompt, etc) on the console when X not running and
lack of text on all of the virtual consoles after X is started.

Signed-off-by: Gary Hade <garyhade@us.ibm.com>
Cc: Darrick J. Wong <djwong@us.ibm.com>
Cc: Krzysztof Helt <krzysztof.h1@wp.pl>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>

---
 drivers/video/matrox/matroxfb_base.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/drivers/video/matrox/matroxfb_base.c b/drivers/video/matrox/matroxfb_base.c
index a082deb..a74439a 100644
--- a/drivers/video/matrox/matroxfb_base.c
+++ b/drivers/video/matrox/matroxfb_base.c
@@ -1461,13 +1461,6 @@ static struct board {
 		MGA_G100,
 		&vbG100,
 		"MGA-G100 (AGP)"},
-	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_G200EV_PCI,	0xFF,
-		0,			0,
-		DEVF_G200,
-		230000,
-		MGA_G200,
-		&vbG200,
-		"MGA-G200eV (PCI)"},
 	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_G200_PCI,	0xFF,
 		0,			0,
 		DEVF_G200,
@@ -2119,8 +2112,6 @@ static struct pci_device_id matroxfb_devices[] = {
 		PCI_ANY_ID,	PCI_ANY_ID,	0, 0, 0},
 	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_G100_AGP,
 		PCI_ANY_ID,	PCI_ANY_ID,	0, 0, 0},
-	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_G200EV_PCI,
-		PCI_ANY_ID,	PCI_ANY_ID,	0, 0, 0},
 	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_G200_PCI,
 		PCI_ANY_ID,	PCI_ANY_ID,	0, 0, 0},
 	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_G200_AGP,
