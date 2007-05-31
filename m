From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 2/8] radeonfb: Add support for Radeon
	Xpress 200M (RS485)
Date: Thu, 31 May 2007 20:59:24 +0800
Message-ID: <465EC6AC.6030105@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HtkQ0-0001Gj-SI for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 May 2007 06:10:21 -0700
Received: from wx-out-0506.google.com ([66.249.82.238])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HtkQ0-0001YJ-Gb
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 May 2007 06:10:20 -0700
Received: by wx-out-0506.google.com with SMTP id t15so151309wxc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 31 May 2007 06:10:20 -0700 (PDT)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Stephan Wolf <WolfSt.External@qimonda.com>

From: Stephan Wolf <WolfSt.External@qimonda.com>

Add PCI ids for the Radeon Xpress 200M (RS485).

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/aty/ati_ids.h     |    1 +
 drivers/video/aty/radeon_base.c |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/video/aty/ati_ids.h b/drivers/video/aty/ati_ids.h
index 90e7df2..685a754 100644
--- a/drivers/video/aty/ati_ids.h
+++ b/drivers/video/aty/ati_ids.h
@@ -204,6 +204,7 @@ #define PCI_CHIP_RV280_5960		0x5960
 #define PCI_CHIP_RV280_5961		0x5961
 #define PCI_CHIP_RV280_5962		0x5962
 #define PCI_CHIP_RV280_5964		0x5964
+#define PCI_CHIP_RS485_5975		0x5975
 #define PCI_CHIP_RV280_5C61		0x5C61
 #define PCI_CHIP_RV280_5C63		0x5C63
 #define PCI_CHIP_R423_5D57              0x5D57
diff --git a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
index 3b3c657..9448db8 100644
--- a/drivers/video/aty/radeon_base.c
+++ b/drivers/video/aty/radeon_base.c
@@ -153,6 +153,8 @@ static struct pci_device_id radeonfb_pci
 	/* Mobility 9200 (M9+) */
 	CHIP_DEF(PCI_CHIP_RV280_5C61,	RV280,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
 	CHIP_DEF(PCI_CHIP_RV280_5C63,	RV280,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	/*Mobility Xpress 200 */
+	CHIP_DEF(PCI_CHIP_RS485_5975,	R300,	CHIP_HAS_CRTC2 | CHIP_IS_IGP | CHIP_IS_MOBILITY),
 	/* 9200 */
 	CHIP_DEF(PCI_CHIP_RV280_5960,	RV280,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_RV280_5961,	RV280,	CHIP_HAS_CRTC2),



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
