From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 1/7] intelfb: vesa_modes require CONFIG_FB_MODEHELPERS
Date: Thu, 17 Feb 2005 20:46:44 +0800
Message-ID: <200502172045.12607.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D1l62-0000kx-DB
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Feb 2005 04:49:30 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D1l61-0008NB-T6
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Feb 2005 04:49:30 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 92EA9E50339
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 17 Feb 2005 12:49:23 +0000 (UTC)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

The recent intelfb update made intelfb pass vesa_modes as the database to
fb_find_mode(). The array vesa_modes depends on CONFIG_FB_MODEHELPERS. Fix

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 Kconfig |    1 +
 1 files changed, 1 insertion(+)

diff -Nru a/drivers/video/Kconfig b/drivers/video/Kconfig
--- a/drivers/video/Kconfig	2005-02-05 09:02:45 +08:00
+++ b/drivers/video/Kconfig	2005-02-15 21:03:40 +08:00
@@ -522,6 +522,7 @@
 	depends on FB && EXPERIMENTAL && PCI && X86 && !X86_64
 	select AGP
 	select AGP_INTEL
+	select FB_MODE_HELPERS
 	help
 	  This driver supports the on-board graphics built in to the Intel
           830M/845G/852GM/855GM/865G chipsets.





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
