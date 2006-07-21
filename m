From: apgo@patchbomb.org (Arthur Othieno)
Subject: [PATCH] nvidiafb: remove redundant CONFIG_PCI
	check
Date: Fri, 21 Jul 2006 04:08:47 -0400
Message-ID: <20060721080847.GF8584@krypton>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G3q83-0004zp-3K for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 21 Jul 2006 01:12:59 -0700
Received: from mailrelay3.sunrise.ch ([194.158.229.31] helo=obelix.sunrise.ch)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1G3q81-0001Dd-FU
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 21 Jul 2006 01:12:59 -0700
Content-Disposition: inline
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
To: akpm@osdl.org
Cc: Antonino Daplas <adaplas@pol.net>, linux-fbdev-devel@lists.sourceforge.net

CONFIG_FB_NVIDIA already depends on CONFIG_PCI in drivers/video/Kconfig.
Driver does an extra ``sanity check'' which is then redundant.

Signed-off-by: Arthur Othieno <apgo@patchbomb.org>
Cc: Antonino Daplas <adaplas@pol.net>
Cc: linux-fbdev-devel@lists.sourceforge.net
---
 drivers/video/nvidia/nvidia.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
index 9f2066f..d0ca0d8 100644
--- a/drivers/video/nvidia/nvidia.c
+++ b/drivers/video/nvidia/nvidia.c
@@ -34,10 +34,6 @@ #include "nv_type.h"
 #include "nv_proto.h"
 #include "nv_dma.h"
 
-#ifndef CONFIG_PCI		/* sanity check */
-#error This driver requires PCI support.
-#endif
-
 #undef CONFIG_FB_NVIDIA_DEBUG
 #ifdef CONFIG_FB_NVIDIA_DEBUG
 #define NVTRACE          printk
-- 
1.4.0


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
