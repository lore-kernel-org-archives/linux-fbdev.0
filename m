From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 5/6] nvidiafb: Kconfig help text update for config FB_NVIDIA
Date: Sun, 13 Mar 2005 08:34:45 +0800
Message-ID: <200503130834.45375.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAH5s-0003qI-EU
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 16:36:32 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DAH5p-0008R8-0w
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 16:36:32 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 2FA6A14ACBAD
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 13 Mar 2005 00:36:23 +0000 (UTC)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Jesper Juhl <juhl-lkml@dif.dk>

  Tiny trivial patch to fix up the help text for config FB_NVIDIA.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 Kconfig |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -Nru a/drivers/video/Kconfig b/drivers/video/Kconfig
--- a/drivers/video/Kconfig	2005-03-12 23:22:35 +08:00
+++ b/drivers/video/Kconfig	2005-03-05 07:56:36 +08:00
@@ -619,12 +619,11 @@
 	help
 	  This driver supports graphics boards with the nVidia chips, TNT
 	  and newer. For very old chipsets, such as the RIVA128, then use
-	  the the rivafb.
+	  the rivafb.
 	  Say Y if you have such a graphics board.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called nvidiafb.
-          none yet
 
 config FB_NVIDIA_I2C
        bool "Enable DDC Support"




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
