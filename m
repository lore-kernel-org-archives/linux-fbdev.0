From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 6/7] neofb: mmio fixes
Date: Sun, 20 Mar 2005 21:09:43 +0800
Message-ID: <200503202109.43080.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DD0Cn-0001GE-T7
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 20 Mar 2005 05:10:57 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DD0Cl-0007nl-AJ
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 20 Mar 2005 05:10:57 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id C34FE14CE83C
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 20 Mar 2005 13:10:48 +0000 (UTC)
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Marek Marczykowski <marmarek@staszic.waw.pl>

  Changes in neo_map_mmio to make neofb working on NM2070,
  NM2090, NM2093.

From: Marek Marczykowski <marmarek@staszic.waw.pl>
Signed-off-by: Marek Marczykowski <marmarek@staszic.waw.pl>
---

 neofb.c |   22 +++++++++++++++++++++-
 1 files changed, 21 insertions(+), 1 deletion(-)

diff -Nru a/drivers/video/neofb.c b/drivers/video/neofb.c
--- a/drivers/video/neofb.c	2005-03-12 23:23:15 +08:00
+++ b/drivers/video/neofb.c	2005-03-19 05:33:32 +08:00
@@ -1691,7 +1691,27 @@
 
 	DBG("neo_map_mmio");
 
-	info->fix.mmio_start = pci_resource_start(dev, 1);
+	switch (info->fix.accel) {
+		case FB_ACCEL_NEOMAGIC_NM2070:
+			info->fix.mmio_start = pci_resource_start(dev, 0)+
+				0x100000;
+			break;
+		case FB_ACCEL_NEOMAGIC_NM2090:
+		case FB_ACCEL_NEOMAGIC_NM2093:
+			info->fix.mmio_start = pci_resource_start(dev, 0)+
+				0x200000;
+			break;
+		case FB_ACCEL_NEOMAGIC_NM2160:
+		case FB_ACCEL_NEOMAGIC_NM2097:
+		case FB_ACCEL_NEOMAGIC_NM2200:
+		case FB_ACCEL_NEOMAGIC_NM2230:
+		case FB_ACCEL_NEOMAGIC_NM2360:
+		case FB_ACCEL_NEOMAGIC_NM2380:
+			info->fix.mmio_start = pci_resource_start(dev, 1);
+			break;
+		default:
+			info->fix.mmio_start = pci_resource_start(dev, 0);
+	}
 	info->fix.mmio_len = MMIO_SIZE;
 
 	if (!request_mem_region




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
