From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 3/5] sisfb: Trivial cleanups
Date: Tue, 15 Mar 2005 07:06:03 +0800
Message-ID: <200503150706.03026.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAyfO-0007uF-Qw
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Mar 2005 15:08:06 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DAyfO-0003mo-AE
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Mar 2005 15:08:06 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id EBCCBF9630A
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 14 Mar 2005 23:07:51 +0000 (UTC)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, c.lucas@ifrance.com, domen@coderock.org, Thomas Winischhofer <thomas@winischhofer.net>

  sis_main.c vfree() checking cleanups.
  convert from pci_module_init to pci_register_driver

  (from:http://kerneljanitors.org/TODO).

Signed-off by: James Lamanna <jlamanna@gmail.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 sis_main.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -Nru a/drivers/video/sis/sis_main.c b/drivers/video/sis/sis_main.c
--- a/drivers/video/sis/sis_main.c	2005-03-12 23:25:37 +08:00
+++ b/drivers/video/sis/sis_main.c	2005-03-05 23:13:01 +08:00
@@ -5640,7 +5640,7 @@
 	/* Unmap */
 	iounmap(ivideo->video_vbase);
 	iounmap(ivideo->mmio_vbase);
-	if(ivideo->bios_abase) vfree(ivideo->bios_abase);
+	vfree(ivideo->bios_abase);
 
 	/* Release mem regions */
 	release_mem_region(ivideo->video_base, ivideo->video_size);
@@ -5695,7 +5695,7 @@
 	sisfb_setup(options);
 #endif
 #endif
-	return(pci_module_init(&sisfb_driver));
+	return(pci_register_driver(&sisfb_driver));
 }
 
 #if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,8)





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
