From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 1/7] nvidiafb: Process boot options earlier
Date: Sun, 20 Mar 2005 21:08:29 +0800
Message-ID: <200503202108.31573.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DD0CV-0001Fe-Jj
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 20 Mar 2005 05:10:39 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DD0CS-0007lZ-Ru
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 20 Mar 2005 05:10:39 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 38FBF14CE796
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 20 Mar 2005 13:10:25 +0000 (UTC)
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

  A few options, such as noscale, are processed after hardware
  has been configured which render them useless. This manifest
  as failure of DVI displays to scale.

  Process them earlier.

From: Antonino Daplas <adaplas@pol.net>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 nvidia.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -Nru a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
--- a/drivers/video/nvidia/nvidia.c	2005-03-20 20:09:13 +08:00
+++ b/drivers/video/nvidia/nvidia.c	2005-03-15 18:42:12 +08:00
@@ -1353,8 +1353,6 @@
 	if (!hwcur)
 		info->fbops->fb_cursor = soft_cursor;
 	info->var.accel_flags = (!noaccel);
-	par->FpScale = (!noscale);
-	par->paneltweak = paneltweak;
 
 	switch (par->Architecture) {
 	case NV_ARCH_04:
@@ -1486,6 +1484,8 @@
 		printk(KERN_INFO PFX "flatpanel support enabled\n");
 
 	par->CRTCnumber = forceCRTC;
+	par->FpScale = (!noscale);
+	par->paneltweak = paneltweak;
 
 	/* enable IO and mem if not already done */
 	pci_read_config_word(pd, PCI_COMMAND, &cmd);





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
