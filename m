From: akpm@osdl.org
Subject: coverity-fbsysfs-fix-null-pointer-check.patch added to -mm tree
Date: Thu, 30 Jun 2005 22:53:09 -0700
Message-ID: <200507010553.j615rbmw022839@shell0.pdx.osdl.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.91] (helo=sc8-sf-mx1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DoETA-0005A3-M8
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 30 Jun 2005 22:53:44 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by sc8-sf-mx1-new.sourceforge.net with esmtp (Exim 4.44)
	id 1DoET9-00009D-Hk
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 30 Jun 2005 22:53:44 -0700
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kambarov@berkeley.edu, linux-fbdev-devel@lists.sourceforge.net, zkambarov@coverity.com, mm-commits@vger.kernel.org


The patch titled

     coverity: fix fbsysfs null pointer check

has been added to the -mm tree.  Its filename is

     coverity-fbsysfs-fix-null-pointer-check.patch

Patches currently in -mm which might be from kambarov@berkeley.edu are

coverity-fbsysfs-fix-null-pointer-check.patch



From: "KAMBAROV, ZAUR" <kambarov@berkeley.edu>

Correctly test for a null pointer before going and dereferencing it.

This defect was found automatically by Coverity Prevent, a static analysis
tool.

Signed-off-by: Zaur Kambarov <zkambarov@coverity.com>
Cc: <linux-fbdev-devel@lists.sourceforge.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/video/fbsysfs.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/video/fbsysfs.c~coverity-fbsysfs-fix-null-pointer-check drivers/video/fbsysfs.c
--- devel/drivers/video/fbsysfs.c~coverity-fbsysfs-fix-null-pointer-check	2005-06-30 22:52:31.000000000 -0700
+++ devel-akpm/drivers/video/fbsysfs.c	2005-06-30 22:52:31.000000000 -0700
@@ -256,7 +256,7 @@ static ssize_t show_cmap(struct class_de
 	unsigned int offset = 0, i;
 
 	if (!fb_info->cmap.red || !fb_info->cmap.blue ||
-	    fb_info->cmap.green || fb_info->cmap.transp)
+	    !fb_info->cmap.green || !fb_info->cmap.transp)
 		return -EINVAL;
 
 	for (i = 0; i < fb_info->cmap.len; i++) {
_


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
