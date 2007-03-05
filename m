From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 2/4] nvidiafb backlight: Fix implicit
	declaration in nv_backlight
Date: Mon, 05 Mar 2007 17:50:58 +0800
Message-ID: <45EBE802.5080704@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HO9rl-0000aV-Ob for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 01:52:26 -0800
Received: from nz-out-0506.google.com ([64.233.162.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HO9rl-0003eB-Fr
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 01:52:25 -0800
Received: by nz-out-0506.google.com with SMTP id i11so2494886nzi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 05 Mar 2007 01:52:25 -0800 (PST)
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
Cc: Dave Jones <davej@redhat.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Dave Jones <davej@redhat.com>

drivers/video/nvidia/nv_backlight.c: In function 'nvidia_bl_init':
drivers/video/nvidia/nv_backlight.c:103: error: implicit declaration of function 'pmac_has_backlight_type'

Signed-off-by: Dave Jones <davej@redhat.com>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/nvidia/nv_backlight.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/video/nvidia/nv_backlight.c b/drivers/video/nvidia/nv_backlight.c
index a50b303..43f62d8 100644
--- a/drivers/video/nvidia/nv_backlight.c
+++ b/drivers/video/nvidia/nv_backlight.c
@@ -12,6 +12,11 @@
 #include <linux/backlight.h>
 #include <linux/fb.h>
 #include <linux/pci.h>
+
+#ifdef CONFIG_PMAC_BACKLIGHT
+#include <asm/backlight.h>
+#endif
+
 #include "nv_local.h"
 #include "nv_type.h"
 #include "nv_proto.h"



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
